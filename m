Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTEFWam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTEFWal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:30:41 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:20239 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S262018AbTEFWah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:30:37 -0400
Date: Tue, 6 May 2003 18:43:07 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: 2.5.69 it87 patch.
Message-ID: <20030506224307.GA10063@babylon.d2dc.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, greg@kroah.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

More or less straight forward patch.

Fix a typo in the comments at the top.
Show all 9 voltage inputs.
Show all 3 fan inputs.
Allow you to select the temp sensor type from the sysfs interface,
instead of just with the temp_type module option.
(1 =3D diode, 2 =3D thermistor, 0 =3D disabled).

I'm still trying to figure out the registers for PWM fan controller
support.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"This system operates under martial law. The constitution is suspended. You
 have no rights except as declared by the area commander. Violators will be
  shot. Repeat violators will be repeatedly shot...."       -from "A_W_O_L"


--- old/drivers/i2c/chips/it87.c	2003-05-06 18:34:11.000000000 -0400
+++ new/drivers/i2c/chips/it87.c	2003-05-06 18:16:39.000000000 -0400
@@ -3,7 +3,7 @@
              monitoring.
=20
     Supports: IT8705F  Super I/O chip w/LPC interface
-              IT8712F  Super I/O chup w/LPC interface & SMbus
+              IT8712F  Super I/O chip w/LPC interface & SMbus
               Sis950   A clone of the IT8705F
=20
     Copyright (c) 2001 Chris Gauthron <chrisg@0-in.com>=20
@@ -238,6 +238,7 @@
 	u8 temp[3];		/* Register value */
 	u8 temp_high[3];	/* Register value */
 	u8 temp_low[3];		/* Register value */
+	u8 sensor;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
@@ -252,7 +253,7 @@
 static int it87_write_value(struct i2c_client *client, u8 register,
 			u8 value);
 static void it87_update_client(struct i2c_client *client);
-static void it87_init_client(struct i2c_client *client);
+static void it87_init_client(struct i2c_client *client, struct it87_data *=
data);
=20
=20
 static struct i2c_driver it87_driver =3D {
@@ -350,6 +351,10 @@
 show_in_offset(2);
 show_in_offset(3);
 show_in_offset(4);
+show_in_offset(5);
+show_in_offset(6);
+show_in_offset(7);
+show_in_offset(8);
=20
 /* 3 temperatures */
 static ssize_t show_temp(struct device *dev, char *buf, int nr)
@@ -430,7 +435,52 @@
 show_temp_offset(2);
 show_temp_offset(3);
=20
-/* 2 Fans */
+/* more like overshoot temperature */
+static ssize_t show_sensor(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	if (data->sensor & (1 << nr))
+	    return sprintf(buf, "1\n");
+	if (data->sensor & (8 << nr))
+	    return sprintf(buf, "2\n");
+	return sprintf(buf, "0\n");
+}
+static ssize_t set_sensor(struct device *dev, const char *buf,=20
+		size_t count, int nr)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct it87_data *data =3D i2c_get_clientdata(client);
+	int val =3D simple_strtol(buf, NULL, 10);
+
+	data->sensor &=3D ~(1 << nr);
+	data->sensor &=3D ~(8 << nr);
+	if (val =3D=3D 1)
+	    data->sensor |=3D 1 << nr;
+	else if (val =3D=3D 2)
+	    data->sensor |=3D 8 << nr;
+	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
+	return count;
+}
+#define show_sensor_offset(offset)					\
+static ssize_t show_sensor_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_sensor(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_sensor_##offset (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_sensor(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(sensor##offset, S_IRUGO | S_IWUSR,	 		\
+		show_sensor_##offset, set_sensor_##offset)
+
+show_sensor_offset(1);
+show_sensor_offset(2);
+show_sensor_offset(3);
+
+/* 3 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
@@ -508,6 +558,7 @@
=20
 show_fan_offset(1);
 show_fan_offset(2);
+show_fan_offset(3);
=20
 /* Alarm */
 static ssize_t show_alarm(struct device *dev, char *buf)
@@ -585,6 +636,7 @@
 		err =3D -ENOMEM;
 		goto ERROR1;
 	}
+	memset (new_client, 0x00, sizeof(struct i2c_client) + sizeof(struct it87_=
data));
=20
 	data =3D (struct it87_data *) (new_client + 1);
 	if (is_isa)
@@ -652,16 +704,28 @@
 	device_create_file(&new_client->dev, &dev_attr_in_input2);
 	device_create_file(&new_client->dev, &dev_attr_in_input3);
 	device_create_file(&new_client->dev, &dev_attr_in_input4);
+	device_create_file(&new_client->dev, &dev_attr_in_input5);
+	device_create_file(&new_client->dev, &dev_attr_in_input6);
+	device_create_file(&new_client->dev, &dev_attr_in_input7);
+	device_create_file(&new_client->dev, &dev_attr_in_input8);
 	device_create_file(&new_client->dev, &dev_attr_in_min0);
 	device_create_file(&new_client->dev, &dev_attr_in_min1);
 	device_create_file(&new_client->dev, &dev_attr_in_min2);
 	device_create_file(&new_client->dev, &dev_attr_in_min3);
 	device_create_file(&new_client->dev, &dev_attr_in_min4);
+	device_create_file(&new_client->dev, &dev_attr_in_min5);
+	device_create_file(&new_client->dev, &dev_attr_in_min6);
+	device_create_file(&new_client->dev, &dev_attr_in_min7);
+	device_create_file(&new_client->dev, &dev_attr_in_min8);
 	device_create_file(&new_client->dev, &dev_attr_in_max0);
 	device_create_file(&new_client->dev, &dev_attr_in_max1);
 	device_create_file(&new_client->dev, &dev_attr_in_max2);
 	device_create_file(&new_client->dev, &dev_attr_in_max3);
 	device_create_file(&new_client->dev, &dev_attr_in_max4);
+	device_create_file(&new_client->dev, &dev_attr_in_max5);
+	device_create_file(&new_client->dev, &dev_attr_in_max6);
+	device_create_file(&new_client->dev, &dev_attr_in_max7);
+	device_create_file(&new_client->dev, &dev_attr_in_max8);
 	device_create_file(&new_client->dev, &dev_attr_temp_input1);
 	device_create_file(&new_client->dev, &dev_attr_temp_input2);
 	device_create_file(&new_client->dev, &dev_attr_temp_input3);
@@ -671,16 +735,22 @@
 	device_create_file(&new_client->dev, &dev_attr_temp_min1);
 	device_create_file(&new_client->dev, &dev_attr_temp_min2);
 	device_create_file(&new_client->dev, &dev_attr_temp_min3);
+	device_create_file(&new_client->dev, &dev_attr_sensor1);
+	device_create_file(&new_client->dev, &dev_attr_sensor2);
+	device_create_file(&new_client->dev, &dev_attr_sensor3);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input2);
+	device_create_file(&new_client->dev, &dev_attr_fan_input3);
 	device_create_file(&new_client->dev, &dev_attr_fan_min1);
 	device_create_file(&new_client->dev, &dev_attr_fan_min2);
+	device_create_file(&new_client->dev, &dev_attr_fan_min3);
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div2);
+	device_create_file(&new_client->dev, &dev_attr_fan_div3);
 	device_create_file(&new_client->dev, &dev_attr_alarm);
=20
 	/* Initialize the IT87 chip */
-	it87_init_client(new_client);
+	it87_init_client(new_client, data);
 	return 0;
=20
 ERROR1:
@@ -753,7 +823,7 @@
 }
=20
 /* Called when we have found a new IT87. It should set limits, etc. */
-static void it87_init_client(struct i2c_client *client)
+static void it87_init_client(struct i2c_client *client, struct it87_data *=
data)
 {
 	/* Reset all except Watchdog values and last conversion values
 	   This sets fan-divs to 2, among others */
@@ -814,9 +884,9 @@
 	it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
=20
 	/* Enable Temp1-Temp3 */
-	it87_write_value(client, IT87_REG_TEMP_ENABLE,
-			(it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0)
-			| (temp_type & 0x3f));
+	data->sensor =3D (it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0);
+	data->sensor |=3D temp_type & 0x3f;
+	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
=20
 	/* Enable fans */
 	it87_write_value(client, IT87_REG_FAN_CTRL,

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+uDp7RFMAi+ZaeAERAl23AJ9zCCuRkFldp2yyvoYWFObkUhMnrQCeJVBi
R/mWr3ufxrQPCqoi4FIFiSA=
=0hzQ
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
