Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVFVHWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVFVHWt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVFVHUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:20:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:60827 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262772AbVFVFVw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:52 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: lm63 uses new sysfs callbacks
In-Reply-To: <11194174672283@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:47 -0700
Message-Id: <11194174671555@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: lm63 uses new sysfs callbacks

I updated the lm63 hardware monitoring driver to take benefit of Yani
Ioannou's new sysfs callback capabilities.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bc51ae1159c0c9a34d2400a8449e1fca3ee965b4
tree a7bef5ee693b9b35a34ccf8361caab7578254c30
parent 1a86c05121a3f56b4b928ed43f9f8ffc1376d802
author Jean Delvare <khali@linux-fr.org> Sun, 05 Jun 2005 20:32:27 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:04 -0700

 drivers/i2c/chips/lm63.c |  267 ++++++++++++++++++++++++----------------------
 1 files changed, 142 insertions(+), 125 deletions(-)

diff --git a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c
+++ b/drivers/i2c/chips/lm63.c
@@ -1,7 +1,7 @@
 /*
  * lm63.c - driver for the National Semiconductor LM63 temperature sensor
  *          with integrated fan control
- * Copyright (C) 2004  Jean Delvare <khali@linux-fr.org>
+ * Copyright (C) 2004-2005  Jean Delvare <khali@linux-fr.org>
  * Based on the lm90 driver.
  *
  * The LM63 is a sensor chip made by National Semiconductor. It measures
@@ -43,6 +43,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/i2c-sysfs.h>
 
 /*
  * Addresses to scan
@@ -157,16 +158,16 @@ struct lm63_data {
 
 	/* registers values */
 	u8 config, config_fan;
-	u16 fan1_input;
-	u16 fan1_low;
+	u16 fan[2];	/* 0: input
+			   1: low limit */
 	u8 pwm1_freq;
 	u8 pwm1_value;
-	s8 temp1_input;
-	s8 temp1_high;
-	s16 temp2_input;
-	s16 temp2_high;
-	s16 temp2_low;
-	s8 temp2_crit;
+	s8 temp8[3];	/* 0: local input
+			   1: local high limit
+			   2: remote critical limit */
+	s16 temp11[3];	/* 0: remote input
+			   1: remote low limit
+			   2: remote high limit */
 	u8 temp2_crit_hyst;
 	u8 alarms;
 };
@@ -175,33 +176,33 @@ struct lm63_data {
  * Sysfs callback functions and files
  */
 
-#define show_fan(value) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct lm63_data *data = lm63_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value)); \
+static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm63_data *data = lm63_update_device(dev);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index]));
 }
-show_fan(fan1_input);
-show_fan(fan1_low);
 
-static ssize_t set_fan1_low(struct device *dev, struct device_attribute *attr, const char *buf,
-	size_t count)
+static ssize_t set_fan(struct device *dev, struct device_attribute *dummy,
+		       const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->fan1_low = FAN_TO_REG(val);
+	data->fan[1] = FAN_TO_REG(val);
 	i2c_smbus_write_byte_data(client, LM63_REG_TACH_LIMIT_LSB,
-				  data->fan1_low & 0xFF);
+				  data->fan[1] & 0xFF);
 	i2c_smbus_write_byte_data(client, LM63_REG_TACH_LIMIT_MSB,
-				  data->fan1_low >> 8);
+				  data->fan[1] >> 8);
 	up(&data->update_lock);
 	return count;
 }
 
-static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_pwm1(struct device *dev, struct device_attribute *dummy,
+			 char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1_value >= 2 * data->pwm1_freq ?
@@ -209,7 +210,8 @@ static ssize_t show_pwm1(struct device *
 		       (2 * data->pwm1_freq));
 }
 
-static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,
+			const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
@@ -228,77 +230,83 @@ static ssize_t set_pwm1(struct device *d
 	return count;
 }
 
-static ssize_t show_pwm1_enable(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_pwm1_enable(struct device *dev, struct device_attribute *dummy,
+				char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", data->config_fan & 0x20 ? 1 : 2);
 }
 
-#define show_temp8(value) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct lm63_data *data = lm63_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->value)); \
-}
-#define show_temp11(value) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct lm63_data *data = lm63_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->value)); \
-}
-show_temp8(temp1_input);
-show_temp8(temp1_high);
-show_temp11(temp2_input);
-show_temp11(temp2_high);
-show_temp11(temp2_low);
-show_temp8(temp2_crit);
-
-#define set_temp8(value, reg) \
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm63_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->value = TEMP8_TO_REG(val); \
-	i2c_smbus_write_byte_data(client, reg, data->value); \
-	up(&data->update_lock); \
-	return count; \
-}
-#define set_temp11(value, reg_msb, reg_lsb) \
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm63_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->value = TEMP11_TO_REG(val); \
-	i2c_smbus_write_byte_data(client, reg_msb, data->value >> 8); \
-	i2c_smbus_write_byte_data(client, reg_lsb, data->value & 0xff); \
-	up(&data->update_lock); \
-	return count; \
-}
-set_temp8(temp1_high, LM63_REG_LOCAL_HIGH);
-set_temp11(temp2_high, LM63_REG_REMOTE_HIGH_MSB, LM63_REG_REMOTE_HIGH_LSB);
-set_temp11(temp2_low, LM63_REG_REMOTE_LOW_MSB, LM63_REG_REMOTE_LOW_LSB);
+static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
+			  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm63_data *data = lm63_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp8[attr->index]));
+}
+
+static ssize_t set_temp8(struct device *dev, struct device_attribute *dummy,
+			 const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp8[1] = TEMP8_TO_REG(val);
+	i2c_smbus_write_byte_data(client, LM63_REG_LOCAL_HIGH, data->temp8[1]);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm63_data *data = lm63_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->temp11[attr->index]));
+}
+
+static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
+			  const char *buf, size_t count)
+{
+	static const u8 reg[4] = {
+		LM63_REG_REMOTE_LOW_MSB,
+		LM63_REG_REMOTE_LOW_LSB,
+		LM63_REG_REMOTE_HIGH_MSB,
+		LM63_REG_REMOTE_HIGH_LSB,
+	};
+
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm63_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	int nr = attr->index;
+
+	down(&data->update_lock);
+	data->temp11[nr] = TEMP11_TO_REG(val);
+	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
+				  data->temp11[nr] >> 8);
+	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
+				  data->temp11[nr] & 0xff);
+	up(&data->update_lock);
+	return count;
+}
 
 /* Hysteresis register holds a relative value, while we want to present
    an absolute to user-space */
-static ssize_t show_temp2_crit_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp2_crit_hyst(struct device *dev, struct device_attribute *dummy,
+				    char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp2_crit)
+	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp8[2])
 		       - TEMP8_FROM_REG(data->temp2_crit_hyst));
 }
 
 /* And now the other way around, user-space provides an absolute
    hysteresis value and we have to store a relative one */
-static ssize_t set_temp2_crit_hyst(struct device *dev, struct device_attribute *attr, const char *buf,
-	size_t count)
+static ssize_t set_temp2_crit_hyst(struct device *dev, struct device_attribute *dummy,
+				   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
@@ -306,36 +314,37 @@ static ssize_t set_temp2_crit_hyst(struc
 	long hyst;
 
 	down(&data->update_lock);
-	hyst = TEMP8_FROM_REG(data->temp2_crit) - val;
+	hyst = TEMP8_FROM_REG(data->temp8[2]) - val;
 	i2c_smbus_write_byte_data(client, LM63_REG_REMOTE_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
 	up(&data->update_lock);
 	return count;
 }
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
+			   char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }
 
-static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan1_input, NULL);
-static DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan1_low,
-	set_fan1_low);
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan,
+	set_fan, 1);
 
 static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1);
 static DEVICE_ATTR(pwm1_enable, S_IRUGO, show_pwm1_enable, NULL);
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1_input, NULL);
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp1_high,
-	set_temp1_high);
-
-static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp2_input, NULL);
-static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp2_low,
-	set_temp2_low);
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp2_high,
-	set_temp2_high);
-static DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp2_crit, NULL);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp8, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 1);
+
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 1);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 2);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp8, NULL, 2);
 static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp2_crit_hyst,
 	set_temp2_crit_hyst);
 
@@ -429,17 +438,25 @@ static int lm63_detect(struct i2c_adapte
 
 	/* Register sysfs hooks */
 	if (data->config & 0x04) { /* tachometer enabled */
-		device_create_file(&new_client->dev, &dev_attr_fan1_input);
-		device_create_file(&new_client->dev, &dev_attr_fan1_min);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_fan1_input.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_fan1_min.dev_attr);
 	}
 	device_create_file(&new_client->dev, &dev_attr_pwm1);
 	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_min);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_min.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&new_client->dev,
+			   &sensor_dev_attr_temp2_crit.dev_attr);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_hyst);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
@@ -510,14 +527,14 @@ static struct lm63_data *lm63_update_dev
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		if (data->config & 0x04) { /* tachometer enabled  */
 			/* order matters for fan1_input */
-			data->fan1_input = i2c_smbus_read_byte_data(client,
-					   LM63_REG_TACH_COUNT_LSB) & 0xFC;
-			data->fan1_input |= i2c_smbus_read_byte_data(client,
-					    LM63_REG_TACH_COUNT_MSB) << 8;
-			data->fan1_low = (i2c_smbus_read_byte_data(client,
-					  LM63_REG_TACH_LIMIT_LSB) & 0xFC)
-				       | (i2c_smbus_read_byte_data(client,
-					  LM63_REG_TACH_LIMIT_MSB) << 8);
+			data->fan[0] = i2c_smbus_read_byte_data(client,
+				       LM63_REG_TACH_COUNT_LSB) & 0xFC;
+			data->fan[0] |= i2c_smbus_read_byte_data(client,
+					LM63_REG_TACH_COUNT_MSB) << 8;
+			data->fan[1] = (i2c_smbus_read_byte_data(client,
+					LM63_REG_TACH_LIMIT_LSB) & 0xFC)
+				     | (i2c_smbus_read_byte_data(client,
+					LM63_REG_TACH_LIMIT_MSB) << 8);
 		}
 
 		data->pwm1_freq = i2c_smbus_read_byte_data(client,
@@ -527,26 +544,26 @@ static struct lm63_data *lm63_update_dev
 		data->pwm1_value = i2c_smbus_read_byte_data(client,
 				   LM63_REG_PWM_VALUE);
 
-		data->temp1_input = i2c_smbus_read_byte_data(client,
-				    LM63_REG_LOCAL_TEMP);
-		data->temp1_high = i2c_smbus_read_byte_data(client,
-				   LM63_REG_LOCAL_HIGH);
+		data->temp8[0] = i2c_smbus_read_byte_data(client,
+				 LM63_REG_LOCAL_TEMP);
+		data->temp8[1] = i2c_smbus_read_byte_data(client,
+				 LM63_REG_LOCAL_HIGH);
 
 		/* order matters for temp2_input */
-		data->temp2_input = i2c_smbus_read_byte_data(client,
-				    LM63_REG_REMOTE_TEMP_MSB) << 8;
-		data->temp2_input |= i2c_smbus_read_byte_data(client,
-				     LM63_REG_REMOTE_TEMP_LSB);
-		data->temp2_high = (i2c_smbus_read_byte_data(client,
-				   LM63_REG_REMOTE_HIGH_MSB) << 8)
-				 | i2c_smbus_read_byte_data(client,
-				   LM63_REG_REMOTE_HIGH_LSB);
-		data->temp2_low = (i2c_smbus_read_byte_data(client,
+		data->temp11[0] = i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_TEMP_MSB) << 8;
+		data->temp11[0] |= i2c_smbus_read_byte_data(client,
+				   LM63_REG_REMOTE_TEMP_LSB);
+		data->temp11[1] = (i2c_smbus_read_byte_data(client,
 				  LM63_REG_REMOTE_LOW_MSB) << 8)
 				| i2c_smbus_read_byte_data(client,
 				  LM63_REG_REMOTE_LOW_LSB);
-		data->temp2_crit = i2c_smbus_read_byte_data(client,
-				   LM63_REG_REMOTE_TCRIT);
+		data->temp11[2] = (i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_HIGH_MSB) << 8)
+				| i2c_smbus_read_byte_data(client,
+				  LM63_REG_REMOTE_HIGH_LSB);
+		data->temp8[2] = i2c_smbus_read_byte_data(client,
+				 LM63_REG_REMOTE_TCRIT);
 		data->temp2_crit_hyst = i2c_smbus_read_byte_data(client,
 					LM63_REG_REMOTE_TCRIT_HYST);
 

