Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVFVHSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVFVHSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVFVHRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:17:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:61851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262774AbVFVFVw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:52 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: lm83 uses new sysfs callbacks
In-Reply-To: <11194174673876@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:47 -0700
Message-Id: <11194174673955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: lm83 uses new sysfs callbacks

I updated the lm83 hardware monitoring driver to take benefit of Yani
Ioannou's new sysfs callback capabilities.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1a86c05121a3f56b4b928ed43f9f8ffc1376d802
tree 5ae73589d53ccadec32b90305988828f530efc04
parent 30d7394b1a3df0e7cc145a543846109babd4d53b
author Jean Delvare <khali@linux-fr.org> Sun, 05 Jun 2005 21:16:39 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:04 -0700

 drivers/i2c/chips/lm83.c |  157 +++++++++++++++++++++++-----------------------
 1 files changed, 77 insertions(+), 80 deletions(-)

diff --git a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c
+++ b/drivers/i2c/chips/lm83.c
@@ -1,7 +1,7 @@
 /*
  * lm83.c - Part of lm_sensors, Linux kernel modules for hardware
  *          monitoring
- * Copyright (C) 2003  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2005  Jean Delvare <khali@linux-fr.org>
  *
  * Heavily inspired from the lm78, lm75 and adm1021 drivers. The LM83 is
  * a sensor chip made by National Semiconductor. It reports up to four
@@ -33,6 +33,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/i2c-sysfs.h>
 
 /*
  * Addresses to scan
@@ -93,21 +94,20 @@ static const u8 LM83_REG_R_TEMP[] = {
 	LM83_REG_R_LOCAL_TEMP,
 	LM83_REG_R_REMOTE1_TEMP,
 	LM83_REG_R_REMOTE2_TEMP,
-	LM83_REG_R_REMOTE3_TEMP
-};
-
-static const u8 LM83_REG_R_HIGH[] = {
+	LM83_REG_R_REMOTE3_TEMP,
 	LM83_REG_R_LOCAL_HIGH,
 	LM83_REG_R_REMOTE1_HIGH,
 	LM83_REG_R_REMOTE2_HIGH,
-	LM83_REG_R_REMOTE3_HIGH
+	LM83_REG_R_REMOTE3_HIGH,
+	LM83_REG_R_TCRIT,
 };
 
 static const u8 LM83_REG_W_HIGH[] = {
 	LM83_REG_W_LOCAL_HIGH,
 	LM83_REG_W_REMOTE1_HIGH,
 	LM83_REG_W_REMOTE2_HIGH,
-	LM83_REG_W_REMOTE3_HIGH
+	LM83_REG_W_REMOTE3_HIGH,
+	LM83_REG_W_TCRIT,
 };
 
 /*
@@ -143,9 +143,9 @@ struct lm83_data {
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	s8 temp_input[4];
-	s8 temp_high[4];
-	s8 temp_crit;
+	s8 temp[9];	/* 0..3: input 1-4,
+			   4..7: high limit 1-4,
+			   8   : critical limit */
 	u16 alarms; /* bitvector, combined */
 };
 
@@ -153,65 +153,55 @@ struct lm83_data {
  * Sysfs stuff
  */
 
-#define show_temp(suffix, value) \
-static ssize_t show_temp_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct lm83_data *data = lm83_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
+static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm83_data *data = lm83_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }
-show_temp(input1, temp_input[0]);
-show_temp(input2, temp_input[1]);
-show_temp(input3, temp_input[2]);
-show_temp(input4, temp_input[3]);
-show_temp(high1, temp_high[0]);
-show_temp(high2, temp_high[1]);
-show_temp(high3, temp_high[2]);
-show_temp(high4, temp_high[3]);
-show_temp(crit, temp_crit);
-
-#define set_temp(suffix, value, reg) \
-static ssize_t set_temp_##suffix(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm83_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->value = TEMP_TO_REG(val); \
-	i2c_smbus_write_byte_data(client, reg, data->value); \
-	up(&data->update_lock); \
-	return count; \
+
+static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm83_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	int nr = attr->index;
+
+	down(&data->update_lock);
+	data->temp[nr] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, LM83_REG_W_HIGH[nr - 4],
+				  data->temp[nr]);
+	up(&data->update_lock);
+	return count;
 }
-set_temp(high1, temp_high[0], LM83_REG_W_LOCAL_HIGH);
-set_temp(high2, temp_high[1], LM83_REG_W_REMOTE1_HIGH);
-set_temp(high3, temp_high[2], LM83_REG_W_REMOTE2_HIGH);
-set_temp(high4, temp_high[3], LM83_REG_W_REMOTE3_HIGH);
-set_temp(crit, temp_crit, LM83_REG_W_TCRIT);
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
+			   char *buf)
 {
 	struct lm83_data *data = lm83_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
-static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
-static DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input3, NULL);
-static DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input4, NULL);
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_high1,
-    set_temp_high1);
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_high2,
-    set_temp_high2);
-static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_high3,
-    set_temp_high3);
-static DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_high4,
-    set_temp_high4);
-static DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL);
-static DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit, NULL);
-static DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_temp_crit,
-    set_temp_crit);
-static DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp_crit, NULL);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp,
+	set_temp, 4);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp,
+	set_temp, 5);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp,
+	set_temp, 6);
+static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp,
+	set_temp, 7);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL, 8);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp, NULL, 8);
+static SENSOR_DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_temp,
+	set_temp, 8);
+static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp, NULL, 8);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /*
@@ -322,18 +312,30 @@ static int lm83_detect(struct i2c_adapte
 	 */
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_input);
-	device_create_file(&new_client->dev, &dev_attr_temp3_input);
-	device_create_file(&new_client->dev, &dev_attr_temp4_input);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max);
-	device_create_file(&new_client->dev, &dev_attr_temp3_max);
-	device_create_file(&new_client->dev, &dev_attr_temp4_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp3_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp4_crit);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp3_input.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp4_input.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp3_max.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp4_max.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_crit.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_crit.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp3_crit.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp4_crit.dev_attr);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
@@ -369,16 +371,11 @@ static struct lm83_data *lm83_update_dev
 		int nr;
 
 		dev_dbg(&client->dev, "Updating lm83 data.\n");
-		for (nr = 0; nr < 4 ; nr++) {
-			data->temp_input[nr] =
+		for (nr = 0; nr < 9; nr++) {
+			data->temp[nr] =
 			    i2c_smbus_read_byte_data(client,
 			    LM83_REG_R_TEMP[nr]);
-			data->temp_high[nr] =
-			    i2c_smbus_read_byte_data(client,
-			    LM83_REG_R_HIGH[nr]);
 		}
-		data->temp_crit =
-		    i2c_smbus_read_byte_data(client, LM83_REG_R_TCRIT);
 		data->alarms =
 		    i2c_smbus_read_byte_data(client, LM83_REG_R_STATUS1)
 		    + (i2c_smbus_read_byte_data(client, LM83_REG_R_STATUS2)

