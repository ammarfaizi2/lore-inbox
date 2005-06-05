Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVFET0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVFET0q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 15:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVFET0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 15:26:46 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:47879 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261608AbVFET00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 15:26:26 -0400
Date: Sun, 5 Jun 2005 21:27:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Yani Ioannou <yani.ioannou@gmail.com>
Subject: [PATCH 2.6] I2C: (3/3) lm90 uses new sysfs callbacks
Message-Id: <20050605212728.5c59ac57.khali@linux-fr.org>
In-Reply-To: <20050605200901.41592fe9.khali@linux-fr.org>
References: <20050605200901.41592fe9.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

I updated the lm90 hardware monitoring driver to take benefit of Yani
Ioannou's new sysfs callback capabilities.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/lm90.c |  270 ++++++++++++++++++++++++++---------------------
 1 files changed, 150 insertions(+), 120 deletions(-)

Index: linux-2.6.12-rc5/drivers/i2c/chips/lm90.c
===================================================================
--- linux-2.6.12-rc5.orig/drivers/i2c/chips/lm90.c	2005-06-05 14:14:27.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/lm90.c	2005-06-05 19:29:15.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * lm90.c - Part of lm_sensors, Linux kernel modules for hardware
  *          monitoring
- * Copyright (C) 2003-2004  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2003-2005  Jean Delvare <khali@linux-fr.org>
  *
  * Based on the lm83 driver. The LM90 is a sensor chip made by National
  * Semiconductor. It reports up to two temperatures (its own plus up to
@@ -76,6 +76,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/i2c-sysfs.h>
 
 /*
  * Addresses to scan
@@ -205,9 +206,14 @@
 	int kind;
 
 	/* registers values */
-	s8 temp_input1, temp_low1, temp_high1; /* local */
-	s16 temp_input2, temp_low2, temp_high2; /* remote, combined */
-	s8 temp_crit1, temp_crit2;
+	s8 temp8[5];	/* 0: local input
+			   1: local low limit
+			   2: local high limit
+			   3: local critical limit
+			   4: remote critical limit */
+	s16 temp11[3];	/* 0: remote input
+			   1: remote low limit
+			   2: remote high limit */
 	u8 temp_hyst;
 	u8 alarms; /* bitvector */
 };
@@ -216,75 +222,88 @@
  * Sysfs stuff
  */
 
-#define show_temp(value, converter) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct lm90_data *data = lm90_update_device(dev); \
-	return sprintf(buf, "%d\n", converter(data->value)); \
-}
-show_temp(temp_input1, TEMP1_FROM_REG);
-show_temp(temp_input2, TEMP2_FROM_REG);
-show_temp(temp_low1, TEMP1_FROM_REG);
-show_temp(temp_low2, TEMP2_FROM_REG);
-show_temp(temp_high1, TEMP1_FROM_REG);
-show_temp(temp_high2, TEMP2_FROM_REG);
-show_temp(temp_crit1, TEMP1_FROM_REG);
-show_temp(temp_crit2, TEMP1_FROM_REG);
-
-#define set_temp1(value, reg) \
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm90_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	if (data->kind == adt7461) \
-		data->value = TEMP1_TO_REG_ADT7461(val); \
-	else \
-		data->value = TEMP1_TO_REG(val); \
-	i2c_smbus_write_byte_data(client, reg, data->value); \
-	up(&data->update_lock); \
-	return count; \
-}
-#define set_temp2(value, regh, regl) \
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm90_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	if (data->kind == adt7461) \
-		data->value = TEMP2_TO_REG_ADT7461(val); \
-	else \
-		data->value = TEMP2_TO_REG(val); \
-	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
-	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
-	up(&data->update_lock); \
-	return count; \
-}
-set_temp1(temp_low1, LM90_REG_W_LOCAL_LOW);
-set_temp2(temp_low2, LM90_REG_W_REMOTE_LOWH, LM90_REG_W_REMOTE_LOWL);
-set_temp1(temp_high1, LM90_REG_W_LOCAL_HIGH);
-set_temp2(temp_high2, LM90_REG_W_REMOTE_HIGHH, LM90_REG_W_REMOTE_HIGHL);
-set_temp1(temp_crit1, LM90_REG_W_LOCAL_CRIT);
-set_temp1(temp_crit2, LM90_REG_W_REMOTE_CRIT);
-
-#define show_temp_hyst(value, basereg) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct lm90_data *data = lm90_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->basereg) \
-		       - TEMP1_FROM_REG(data->temp_hyst)); \
+static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
+			  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm90_data *data = lm90_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp8[attr->index]));
 }
-show_temp_hyst(temp_hyst1, temp_crit1);
-show_temp_hyst(temp_hyst2, temp_crit2);
 
-static ssize_t set_temp_hyst1(struct device *dev, struct device_attribute *attr, const char *buf,
-	size_t count)
+static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	static const u8 reg[4] = {
+		LM90_REG_W_LOCAL_LOW,
+		LM90_REG_W_LOCAL_HIGH,
+		LM90_REG_W_LOCAL_CRIT,
+		LM90_REG_W_REMOTE_CRIT,
+	};
+
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm90_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	int nr = attr->index;
+
+	down(&data->update_lock);
+	if (data->kind == adt7461)
+		data->temp8[nr] = TEMP1_TO_REG_ADT7461(val);
+	else
+		data->temp8[nr] = TEMP1_TO_REG(val);
+	i2c_smbus_write_byte_data(client, reg[nr - 1], data->temp8[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm90_data *data = lm90_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP2_FROM_REG(data->temp11[attr->index]));
+}
+
+static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
+			  const char *buf, size_t count)
+{
+	static const u8 reg[4] = {
+		LM90_REG_W_REMOTE_LOWH,
+		LM90_REG_W_REMOTE_LOWL,
+		LM90_REG_W_REMOTE_HIGHH,
+		LM90_REG_W_REMOTE_HIGHL,
+	};
+
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm90_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	int nr = attr->index;
+
+	down(&data->update_lock);
+	if (data->kind == adt7461)
+		data->temp11[nr] = TEMP2_TO_REG_ADT7461(val);
+	else
+		data->temp11[nr] = TEMP2_TO_REG(val);
+	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
+				  data->temp11[nr] >> 8);
+	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
+				  data->temp11[nr] & 0xff);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_temphyst(struct device *dev, struct device_attribute *devattr,
+			     char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm90_data *data = lm90_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp8[attr->index])
+		       - TEMP1_FROM_REG(data->temp_hyst));
+}
+
+static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm90_data *data = i2c_get_clientdata(client);
@@ -292,36 +311,37 @@
 	long hyst;
 
 	down(&data->update_lock);
-	hyst = TEMP1_FROM_REG(data->temp_crit1) - val;
+	hyst = TEMP1_FROM_REG(data->temp8[3]) - val;
 	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
 	up(&data->update_lock);
 	return count;
 }
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
+			   char *buf)
 {
 	struct lm90_data *data = lm90_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
-static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
-static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_low1,
-	set_temp_low1);
-static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_low2,
-	set_temp_low2);
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_high1,
-	set_temp_high1);
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_high2,
-	set_temp_high2);
-static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_crit1,
-	set_temp_crit1);
-static DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit2,
-	set_temp_crit2);
-static DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst1,
-	set_temp_hyst1);
-static DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_hyst2, NULL);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp8, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 1);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 1);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 2);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 2);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 3);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 4);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temphyst,
+	set_temphyst, 3);
+static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temphyst, NULL, 4);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /*
@@ -480,16 +500,26 @@
 	lm90_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_input);
-	device_create_file(&new_client->dev, &dev_attr_temp1_min);
-	device_create_file(&new_client->dev, &dev_attr_temp2_min);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp1_crit_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp2_crit_hyst);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_min.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_min.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_crit.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_crit.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_crit_hyst.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_crit_hyst.dev_attr);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
@@ -540,16 +570,16 @@
 		u8 oldh, newh;
 
 		dev_dbg(&client->dev, "Updating lm90 data.\n");
-		data->temp_input1 = i2c_smbus_read_byte_data(client,
-				    LM90_REG_R_LOCAL_TEMP);
-		data->temp_high1 = i2c_smbus_read_byte_data(client,
-				   LM90_REG_R_LOCAL_HIGH);
-		data->temp_low1 = i2c_smbus_read_byte_data(client,
-				  LM90_REG_R_LOCAL_LOW);
-		data->temp_crit1 = i2c_smbus_read_byte_data(client,
-				   LM90_REG_R_LOCAL_CRIT);
-		data->temp_crit2 = i2c_smbus_read_byte_data(client,
-				   LM90_REG_R_REMOTE_CRIT);
+		data->temp8[0] = i2c_smbus_read_byte_data(client,
+				 LM90_REG_R_LOCAL_TEMP);
+		data->temp8[1] = i2c_smbus_read_byte_data(client,
+				 LM90_REG_R_LOCAL_LOW);
+		data->temp8[2] = i2c_smbus_read_byte_data(client,
+				 LM90_REG_R_LOCAL_HIGH);
+		data->temp8[3] = i2c_smbus_read_byte_data(client,
+				 LM90_REG_R_LOCAL_CRIT);
+		data->temp8[4] = i2c_smbus_read_byte_data(client,
+				 LM90_REG_R_REMOTE_CRIT);
 		data->temp_hyst = i2c_smbus_read_byte_data(client,
 				  LM90_REG_R_TCRIT_HYST);
 
@@ -569,13 +599,13 @@
 		 */
 		oldh = i2c_smbus_read_byte_data(client,
 		       LM90_REG_R_REMOTE_TEMPH);
-		data->temp_input2 = i2c_smbus_read_byte_data(client,
-				    LM90_REG_R_REMOTE_TEMPL);
+		data->temp11[0] = i2c_smbus_read_byte_data(client,
+				  LM90_REG_R_REMOTE_TEMPL);
 		newh = i2c_smbus_read_byte_data(client,
 		       LM90_REG_R_REMOTE_TEMPH);
 		if (newh != oldh) {
-			data->temp_input2 = i2c_smbus_read_byte_data(client,
-					    LM90_REG_R_REMOTE_TEMPL);
+			data->temp11[0] = i2c_smbus_read_byte_data(client,
+					  LM90_REG_R_REMOTE_TEMPL);
 #ifdef DEBUG
 			oldh = i2c_smbus_read_byte_data(client,
 			       LM90_REG_R_REMOTE_TEMPH);
@@ -585,16 +615,16 @@
 					 "wrong.\n");
 #endif
 		}
-		data->temp_input2 |= (newh << 8);
+		data->temp11[0] |= (newh << 8);
 
-		data->temp_high2 = (i2c_smbus_read_byte_data(client,
+		data->temp11[1] = (i2c_smbus_read_byte_data(client,
+				   LM90_REG_R_REMOTE_LOWH) << 8) +
+				   i2c_smbus_read_byte_data(client,
+				   LM90_REG_R_REMOTE_LOWL);
+		data->temp11[2] = (i2c_smbus_read_byte_data(client,
 				   LM90_REG_R_REMOTE_HIGHH) << 8) +
 				   i2c_smbus_read_byte_data(client,
 				   LM90_REG_R_REMOTE_HIGHL);
-		data->temp_low2 = (i2c_smbus_read_byte_data(client,
-				  LM90_REG_R_REMOTE_LOWH) << 8) +
-				  i2c_smbus_read_byte_data(client,
-				  LM90_REG_R_REMOTE_LOWL);
 		data->alarms = i2c_smbus_read_byte_data(client,
 			       LM90_REG_R_STATUS);
 


-- 
Jean Delvare
