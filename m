Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTEIXoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTEIXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:44:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:46023 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263594AbTEIXmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:42:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10525245943581@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.69
In-Reply-To: <10525245943373@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 9 May 2003 16:56:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083.2.5, 2003/05/09 14:54:25-07:00, warp@mercury.d2dc.net

[PATCH] I2C: And another it87 patch.

Don't provide min/max for in8, which allowed one to scribble on
registers one should not be messing with. (My fault, oops.)

The setting of the temp high/low registers was off by one, not mine this
time.  While I was at it, I reordered a few other register accesses to
be base 0 instead of base 1.

The temp interface was slightly incorrect, degrees * 100 instead of
degrees * 1000, also fixed.

And lastly, when changing the fan count divisor, fix up the min setting
to still be roughly the same. (Previously the meaning of the value in
the register changed, but not the value itself, resulting in, undesired
surprises.)


 drivers/i2c/chips/it87.c |   77 ++++++++++++++++++++++++++++-------------------
 1 files changed, 47 insertions(+), 30 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Fri May  9 16:47:47 2003
+++ b/drivers/i2c/chips/it87.c	Fri May  9 16:47:47 2003
@@ -80,17 +80,17 @@
 
 /* Monitors: 9 voltage (0 to 7, battery), 3 temp (1 to 3), 3 fan (1 to 3) */
 
-#define IT87_REG_FAN(nr)       (0x0c + (nr))
-#define IT87_REG_FAN_MIN(nr)   (0x0f + (nr))
+#define IT87_REG_FAN(nr)       (0x0d + (nr))
+#define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
 #define IT87_REG_FAN_CTRL      0x13
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
-#define IT87_REG_TEMP(nr)      (0x28 + (nr))
+#define IT87_REG_TEMP(nr)      (0x29 + (nr))
 
 #define IT87_REG_VIN_MAX(nr)   (0x30 + (nr) * 2)
 #define IT87_REG_VIN_MIN(nr)   (0x31 + (nr) * 2)
-#define IT87_REG_TEMP_HIGH(nr) (0x3e + (nr) * 2)
-#define IT87_REG_TEMP_LOW(nr)  (0x3f + (nr) * 2)
+#define IT87_REG_TEMP_HIGH(nr) (0x40 + ((nr) * 2))
+#define IT87_REG_TEMP_LOW(nr)  (0x41 + ((nr) * 2))
 
 #define IT87_REG_I2C_ADDR      0x48
 
@@ -289,6 +289,9 @@
 {								\
 	return show_in(dev, buf, 0x##offset);			\
 }								\
+static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL)
+
+#define limit_in_offset(offset)					\
 static ssize_t							\
 	show_in##offset##_min (struct device *dev, char *buf)	\
 {								\
@@ -309,20 +312,27 @@
 {								\
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
-static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL) 	\
 static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 		\
 		show_in##offset##_min, set_in##offset##_min)	\
 static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 		\
 		show_in##offset##_max, set_in##offset##_max)
 
 show_in_offset(0);
+limit_in_offset(0);
 show_in_offset(1);
+limit_in_offset(1);
 show_in_offset(2);
+limit_in_offset(2);
 show_in_offset(3);
+limit_in_offset(3);
 show_in_offset(4);
+limit_in_offset(4);
 show_in_offset(5);
+limit_in_offset(5);
 show_in_offset(6);
+limit_in_offset(6);
 show_in_offset(7);
+limit_in_offset(7);
 show_in_offset(8);
 
 /* 3 temperatures */
@@ -331,7 +341,7 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*10 );
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*100 );
 }
 /* more like overshoot temperature */
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
@@ -339,7 +349,7 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*10);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*100);
 }
 /* more like hysteresis temperature */
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
@@ -347,14 +357,14 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*10);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*100);
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf, 
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/10;
+	int val = simple_strtol(buf, NULL, 10)/100;
 	data->temp_high[nr] = TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
 	return count;
@@ -364,7 +374,7 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10)/10;
+	int val = simple_strtol(buf, NULL, 10)/100;
 	data->temp_low[nr] = TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
 	return count;
@@ -480,7 +490,7 @@
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(client, IT87_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf, 
@@ -489,8 +499,12 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+	int i, min[3];
 	u8 old = it87_read_value(client, IT87_REG_FAN_DIV);
 
+	for (i = 0; i < 3; i++)
+		min[i] = FAN_FROM_REG(data->fan_min[i], DIV_FROM_REG(data->fan_div[i]));
+
 	switch (nr) {
 	case 0:
 	case 1:
@@ -508,6 +522,11 @@
 	if (data->fan_div[2] == 3)
 		val |= 0x1 << 6;
 	it87_write_value(client, IT87_REG_FAN_DIV, val);
+
+	for (i = 0; i < 3; i++) {
+		data->fan_min[i]=FAN_TO_REG(min[i], DIV_FROM_REG(data->fan_div[i]));
+		it87_write_value(client, IT87_REG_FAN_MIN(i), data->fan_min[i]);
+	}
 	return count;
 }
 
@@ -704,7 +723,6 @@
 	device_create_file(&new_client->dev, &dev_attr_in_min5);
 	device_create_file(&new_client->dev, &dev_attr_in_min6);
 	device_create_file(&new_client->dev, &dev_attr_in_min7);
-	device_create_file(&new_client->dev, &dev_attr_in_min8);
 	device_create_file(&new_client->dev, &dev_attr_in_max0);
 	device_create_file(&new_client->dev, &dev_attr_in_max1);
 	device_create_file(&new_client->dev, &dev_attr_in_max2);
@@ -713,7 +731,6 @@
 	device_create_file(&new_client->dev, &dev_attr_in_max5);
 	device_create_file(&new_client->dev, &dev_attr_in_max6);
 	device_create_file(&new_client->dev, &dev_attr_in_max7);
-	device_create_file(&new_client->dev, &dev_attr_in_max8);
 	device_create_file(&new_client->dev, &dev_attr_temp_input1);
 	device_create_file(&new_client->dev, &dev_attr_temp_input2);
 	device_create_file(&new_client->dev, &dev_attr_temp_input3);
@@ -849,23 +866,23 @@
 	it87_write_value(client, IT87_REG_VIN_MAX(7),
 			 IN_TO_REG(IT87_INIT_IN_MAX_7));
 	/* Note: Battery voltage does not have limit registers */
-	it87_write_value(client, IT87_REG_FAN_MIN(1),
+	it87_write_value(client, IT87_REG_FAN_MIN(0),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(2),
+	it87_write_value(client, IT87_REG_FAN_MIN(1),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_2, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(3),
+	it87_write_value(client, IT87_REG_FAN_MIN(2),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_3, 2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(1),
+	it87_write_value(client, IT87_REG_TEMP_HIGH(0),
 			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_1));
-	it87_write_value(client, IT87_REG_TEMP_LOW(1),
+	it87_write_value(client, IT87_REG_TEMP_LOW(0),
 			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_1));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(2),
+	it87_write_value(client, IT87_REG_TEMP_HIGH(1),
 			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_2));
-	it87_write_value(client, IT87_REG_TEMP_LOW(2),
+	it87_write_value(client, IT87_REG_TEMP_LOW(1),
 			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(3),
+	it87_write_value(client, IT87_REG_TEMP_HIGH(2),
 			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_3));
-	it87_write_value(client, IT87_REG_TEMP_LOW(3),
+	it87_write_value(client, IT87_REG_TEMP_LOW(2),
 			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_3));
 
 	/* Enable voltage monitors */
@@ -918,18 +935,18 @@
 		data->in_min[8] = 0;
 		data->in_max[8] = 255;
 
-		for (i = 1; i <= 3; i++) {
-			data->fan[i - 1] =
+		for (i = 0; i < 3; i++) {
+			data->fan[i] =
 			    it87_read_value(client, IT87_REG_FAN(i));
-			data->fan_min[i - 1] =
+			data->fan_min[i] =
 			    it87_read_value(client, IT87_REG_FAN_MIN(i));
 		}
-		for (i = 1; i <= 3; i++) {
-			data->temp[i - 1] =
+		for (i = 0; i < 3; i++) {
+			data->temp[i] =
 			    it87_read_value(client, IT87_REG_TEMP(i));
-			data->temp_high[i - 1] =
+			data->temp_high[i] =
 			    it87_read_value(client, IT87_REG_TEMP_HIGH(i));
-			data->temp_low[i - 1] =
+			data->temp_low[i] =
 			    it87_read_value(client, IT87_REG_TEMP_LOW(i));
 		}
 

