import 'package:flutter/material.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const rountName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) async {
    _isLoading = true;
    Provider.of<Orders>(context, listen: false).fetschAndSetOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Orders',
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orderData.odrers.length,
              itemBuilder: (ctx, i) => OrderItem(
                orderData.odrers[i],
              ),
            ),
    );
  }
}
