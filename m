Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbTL3W6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbTL3WKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:10:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:58561 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265841AbTL3WGl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:41 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219731748@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:14 -0800
Message-Id: <10728219741342@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.9.4, 2003/12/04 13:43:05-08:00, khali@linux-fr.org

[PATCH] I2C: make I2C chipset drivers use temp_hyst[1-3]

Summary of the changes:
adm1021.c: No changes, that chipset uses a real min/max model.
eeeprom.c: No changes (obviously).
it87.c:    Remove buggy comments (obviously taken from via686a) about
           max and min temperature limits being over and hyst. This
           isn't the case for this driver (min/max model).
lm75.c:    Simple sysfs file name change (temp_min to temp_hyst).
lm78.c:    Simple sysfs file name change (temp_min to temp_hyst).
lm85.c:    No changes needed (min/max model).
via686a.c: Rename functions and macros from min/max to hyst/over, what
           it really is. Remove unnecessary comments. Rename sysfs
           files from temp_min[1-3] to temp_hyst[1-3].
w83781d.c: Rename variables from temp_min* to temp_hyst* (needed so
           that the macros keep working). Update macro calls
           accordingly. Fix writing temp to max and hyst being
           swapped.

Additional remarks:

The lm75 and lm78 having a single temperature channel, there is no
number appended to the file names. Shouldn't a "1" be appended in this
case? I think it would make it easier for the future library to catch
all the files.

I made sure the drivers would still compile after the changes, but did
not test them otherwise (no working 2.6.0 kernel here, and not all the
hardware anyway).


 drivers/i2c/chips/it87.c    |    2 --
 drivers/i2c/chips/lm75.c    |    4 ++--
 drivers/i2c/chips/lm78.c    |    4 ++--
 drivers/i2c/chips/via686a.c |   38 ++++++++++++++++++--------------------
 drivers/i2c/chips/w83781d.c |   24 ++++++++++++------------
 5 files changed, 34 insertions(+), 38 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue Dec 30 12:32:05 2003
+++ b/drivers/i2c/chips/it87.c	Tue Dec 30 12:32:05 2003
@@ -343,7 +343,6 @@
 	it87_update_client(client);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*100 );
 }
-/* more like overshoot temperature */
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -351,7 +350,6 @@
 	it87_update_client(client);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*100);
 }
-/* more like hysteresis temperature */
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Tue Dec 30 12:32:05 2003
+++ b/drivers/i2c/chips/lm75.c	Tue Dec 30 12:32:05 2003
@@ -116,7 +116,7 @@
 set(temp_hyst, LM75_REG_TEMP_HYST);
 
 static DEVICE_ATTR(temp_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp_min, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
 static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
@@ -209,7 +209,7 @@
 	
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
 	device_create_file(&new_client->dev, &dev_attr_temp_input);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Tue Dec 30 12:32:05 2003
+++ b/drivers/i2c/chips/lm78.c	Tue Dec 30 12:32:05 2003
@@ -367,7 +367,7 @@
 static DEVICE_ATTR(temp_input, S_IRUGO, show_temp, NULL)
 static DEVICE_ATTR(temp_max, S_IRUGO | S_IWUSR,
 		show_temp_over, set_temp_over)
-static DEVICE_ATTR(temp_min, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp_hyst, S_IRUGO | S_IWUSR,
 		show_temp_hyst, set_temp_hyst)
 
 /* 3 Fans */
@@ -674,8 +674,8 @@
 	device_create_file(&new_client->dev, &dev_attr_in_min6);
 	device_create_file(&new_client->dev, &dev_attr_in_max6);
 	device_create_file(&new_client->dev, &dev_attr_temp_input);
-	device_create_file(&new_client->dev, &dev_attr_temp_min);
 	device_create_file(&new_client->dev, &dev_attr_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_min1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Tue Dec 30 12:32:05 2003
+++ b/drivers/i2c/chips/via686a.c	Tue Dec 30 12:32:05 2003
@@ -496,21 +496,19 @@
 	via686a_update_client(client);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*100 );
 }
-/* more like overshoot temperature */
-static ssize_t show_temp_max(struct device *dev, char *buf, int nr) {
+static ssize_t show_temp_over(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*100);
 }
-/* more like hysteresis temperature */
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr) {
+static ssize_t show_temp_hyst(struct device *dev, char *buf, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*100);
 }
-static ssize_t set_temp_max(struct device *dev, const char *buf, 
+static ssize_t set_temp_over(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -519,7 +517,7 @@
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
 	return count;
 }
-static ssize_t set_temp_min(struct device *dev, const char *buf, 
+static ssize_t set_temp_hyst(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
@@ -534,30 +532,30 @@
 	return show_temp(dev, buf, 0x##offset - 1);			\
 }									\
 static ssize_t								\
-show_temp_##offset##_max (struct device *dev, char *buf)		\
+show_temp_##offset##_over (struct device *dev, char *buf)		\
 {									\
-	return show_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_temp_over(dev, buf, 0x##offset - 1);			\
 }									\
 static ssize_t								\
-show_temp_##offset##_min (struct device *dev, char *buf)		\
+show_temp_##offset##_hyst (struct device *dev, char *buf)		\
 {									\
-	return show_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_temp_hyst(dev, buf, 0x##offset - 1);			\
 }									\
-static ssize_t set_temp_##offset##_max (struct device *dev, 		\
+static ssize_t set_temp_##offset##_over (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_over(dev, buf, count, 0x##offset - 1);		\
 }									\
-static ssize_t set_temp_##offset##_min (struct device *dev, 		\
+static ssize_t set_temp_##offset##_hyst (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_hyst(dev, buf, count, 0x##offset - 1);		\
 }									\
 static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL) \
 static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_max, set_temp_##offset##_max) 	\
-static DEVICE_ATTR(temp_min##offset, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_min, set_temp_##offset##_min)	
+		show_temp_##offset##_over, set_temp_##offset##_over) 	\
+static DEVICE_ATTR(temp_hyst##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_hyst, set_temp_##offset##_hyst)	
 
 show_temp_offset(1);
 show_temp_offset(2);
@@ -760,9 +758,9 @@
 	device_create_file(&new_client->dev, &dev_attr_temp_max1);
 	device_create_file(&new_client->dev, &dev_attr_temp_max2);
 	device_create_file(&new_client->dev, &dev_attr_temp_max3);
-	device_create_file(&new_client->dev, &dev_attr_temp_min1);
-	device_create_file(&new_client->dev, &dev_attr_temp_min2);
-	device_create_file(&new_client->dev, &dev_attr_temp_min3);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst2);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst3);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input2);
 	device_create_file(&new_client->dev, &dev_attr_fan_min1);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Tue Dec 30 12:32:05 2003
+++ b/drivers/i2c/chips/w83781d.c	Tue Dec 30 12:32:05 2003
@@ -309,11 +309,11 @@
 	u8 fan[3];		/* Register value */
 	u8 fan_min[3];		/* Register value */
 	u8 temp;
-	u8 temp_min;		/* Register value */
 	u8 temp_max;		/* Register value */
+	u8 temp_hyst;		/* Register value */
 	u16 temp_add[2];	/* Register value */
 	u16 temp_max_add[2];	/* Register value */
-	u16 temp_min_add[2];	/* Register value */
+	u16 temp_hyst_add[2];	/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
@@ -510,8 +510,8 @@
 	} \
 }
 show_temp_reg(temp);
-show_temp_reg(temp_min);
 show_temp_reg(temp_max);
+show_temp_reg(temp_hyst);
 
 #define store_temp_reg(REG, reg) \
 static ssize_t store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
@@ -538,8 +538,8 @@
 	 \
 	return count; \
 }
-store_temp_reg(OVER, min);
-store_temp_reg(HYST, max);
+store_temp_reg(OVER, max);
+store_temp_reg(HYST, hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
@@ -562,8 +562,8 @@
 
 #define sysfs_temp_offsets(offset) \
 sysfs_temp_offset(offset); \
-sysfs_temp_reg_offset(min, offset); \
-sysfs_temp_reg_offset(max, offset);
+sysfs_temp_reg_offset(max, offset); \
+sysfs_temp_reg_offset(hyst, offset);
 
 sysfs_temp_offsets(1);
 sysfs_temp_offsets(2);
@@ -573,7 +573,7 @@
 do { \
 device_create_file(&client->dev, &dev_attr_temp_input##offset); \
 device_create_file(&client->dev, &dev_attr_temp_max##offset); \
-device_create_file(&client->dev, &dev_attr_temp_min##offset); \
+device_create_file(&client->dev, &dev_attr_temp_hyst##offset); \
 } while (0)
 
 static ssize_t
@@ -1865,15 +1865,15 @@
 		}
 
 		data->temp = w83781d_read_value(client, W83781D_REG_TEMP(1));
-		data->temp_min =
-		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(1));
 		data->temp_max =
+		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(1));
+		data->temp_hyst =
 		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(1));
 		data->temp_add[0] =
 		    w83781d_read_value(client, W83781D_REG_TEMP(2));
 		data->temp_max_add[0] =
 		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
-		data->temp_min_add[0] =
+		data->temp_hyst_add[0] =
 		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
 		if (data->type != w83783s && data->type != w83697hf) {
 			data->temp_add[1] =
@@ -1881,7 +1881,7 @@
 			data->temp_max_add[1] =
 			    w83781d_read_value(client,
 					       W83781D_REG_TEMP_OVER(3));
-			data->temp_min_add[1] =
+			data->temp_hyst_add[1] =
 			    w83781d_read_value(client,
 					       W83781D_REG_TEMP_HYST(3));
 		}

