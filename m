Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbTEGAUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTEGATe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:19:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:141 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262143AbTEGATL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:19:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052267615252@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.69
In-Reply-To: <10522676153273@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 17:33:35 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1086, 2003/05/06 17:20:04-07:00, warp@mercury.d2dc.net

[PATCH] i2c: it87 patch.

More or less straight forward patch.

Fix a typo in the comments at the top.
Show all 9 voltage inputs.
Show all 3 fan inputs.
Allow you to select the temp sensor type from the sysfs interface,
instead of just with the temp_type module option.
(1 = diode, 2 = thermistor, 0 = disabled).

I'm still trying to figure out the registers for PWM fan controller
support.


 drivers/i2c/chips/it87.c |   86 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 78 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue May  6 17:24:24 2003
+++ b/drivers/i2c/chips/it87.c	Tue May  6 17:24:24 2003
@@ -3,7 +3,7 @@
              monitoring.
 
     Supports: IT8705F  Super I/O chip w/LPC interface
-              IT8712F  Super I/O chup w/LPC interface & SMbus
+              IT8712F  Super I/O chip w/LPC interface & SMbus
               Sis950   A clone of the IT8705F
 
     Copyright (c) 2001 Chris Gauthron <chrisg@0-in.com> 
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
+static void it87_init_client(struct i2c_client *client, struct it87_data *data);
 
 
 static struct i2c_driver it87_driver = {
@@ -350,6 +351,10 @@
 show_in_offset(2);
 show_in_offset(3);
 show_in_offset(4);
+show_in_offset(5);
+show_in_offset(6);
+show_in_offset(7);
+show_in_offset(8);
 
 /* 3 temperatures */
 static ssize_t show_temp(struct device *dev, char *buf, int nr)
@@ -430,7 +435,52 @@
 show_temp_offset(2);
 show_temp_offset(3);
 
-/* 2 Fans */
+/* more like overshoot temperature */
+static ssize_t show_sensor(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	if (data->sensor & (1 << nr))
+	    return sprintf(buf, "1\n");
+	if (data->sensor & (8 << nr))
+	    return sprintf(buf, "2\n");
+	return sprintf(buf, "0\n");
+}
+static ssize_t set_sensor(struct device *dev, const char *buf, 
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+
+	data->sensor &= ~(1 << nr);
+	data->sensor &= ~(8 << nr);
+	if (val == 1)
+	    data->sensor |= 1 << nr;
+	else if (val == 2)
+	    data->sensor |= 8 << nr;
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
 	struct i2c_client *client = to_i2c_client(dev);
@@ -508,6 +558,7 @@
 
 show_fan_offset(1);
 show_fan_offset(2);
+show_fan_offset(3);
 
 /* Alarm */
 static ssize_t show_alarm(struct device *dev, char *buf)
@@ -576,6 +627,7 @@
 			}
 		}
 	}
+	memset (new_client, 0x00, sizeof(struct i2c_client) + sizeof(struct it87_data));
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
@@ -656,16 +708,28 @@
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
@@ -675,16 +739,22 @@
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
 
 	/* Initialize the IT87 chip */
-	it87_init_client(new_client);
+	it87_init_client(new_client, data);
 	return 0;
 
 ERROR1:
@@ -757,7 +827,7 @@
 }
 
 /* Called when we have found a new IT87. It should set limits, etc. */
-static void it87_init_client(struct i2c_client *client)
+static void it87_init_client(struct i2c_client *client, struct it87_data *data)
 {
 	/* Reset all except Watchdog values and last conversion values
 	   This sets fan-divs to 2, among others */
@@ -818,9 +888,9 @@
 	it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
 
 	/* Enable Temp1-Temp3 */
-	it87_write_value(client, IT87_REG_TEMP_ENABLE,
-			(it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0)
-			| (temp_type & 0x3f));
+	data->sensor = (it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0);
+	data->sensor |= temp_type & 0x3f;
+	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 
 	/* Enable fans */
 	it87_write_value(client, IT87_REG_FAN_CTRL,

