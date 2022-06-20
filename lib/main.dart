// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unnecessary_this

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 60, 146, 216),
      ),
      home: const HomePage(title: 'Tính điểm'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double diemTB = 0;
  String thongBaoDiem = '';
  String xepLoai = '';
  String thongBao = 'Vui lòng nhập điểm';

  TextEditingController diemToanController = TextEditingController();
  TextEditingController diemVanController = TextEditingController();
  TextEditingController diemAnhController = TextEditingController();

  void tinhDiem() {
    setState(() {
      if (double.tryParse(diemToanController.text) == null ||
          double.tryParse(diemVanController.text) == null ||
          double.tryParse(diemAnhController.text) == null) {
        this.thongBao = 'Vui lòng nhập đủ điểm 3 môn và chỉ nhập số';
        this.diemTB = 0;
        this.thongBaoDiem = '';
        this.xepLoai = '';
      } else {
        this.thongBao = '';
        this.diemTB = (double.parse(diemToanController.text) +
                double.parse(diemVanController.text) +
                double.parse(diemAnhController.text)) /
            3;

        if (this.diemTB >= 8) {
          this.xepLoai = 'Học lực Giỏi';
        } else if (this.diemTB >= 6.5) {
          this.xepLoai = 'Học lực Khá';
        } else if (this.diemTB >= 5) {
          this.xepLoai = 'Học lực Trung bình';
        } else {
          this.xepLoai = 'Học lực Yếu';
        }

        this.thongBaoDiem = 'Điểm trung bình ${diemTB.toStringAsFixed(1)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              inputWidget(
                  labelText: 'Điểm Toán',
                  controller: diemToanController,
                  hintText: 'Nhập điểm Toán'),
              inputWidget(
                  labelText: 'Điểm Văn', controller: diemVanController, hintText: 'Nhập điểm Văn'),
              inputWidget(
                  labelText: 'Điểm Anh', controller: diemAnhController, hintText: 'Nhập điểm Anh'),
              ElevatedButton(
                onPressed: tinhDiem,
                child: Text('Tính điểm trung bình'),
              ),
              resultWidget(
                  diemTB: this.thongBaoDiem, xepLoai: this.xepLoai, thongBao: this.thongBao),
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputWidget({required String labelText, required controller, required hintText}) {
  return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
        controller: controller,
      ));
}

Widget resultWidget({required String diemTB, required String xepLoai, required String thongBao}) {
  return Card(
    margin: EdgeInsets.only(top: 16),
    child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(thongBao),
            Text(diemTB),
            Text(xepLoai),
          ],
        )),
  );
}
