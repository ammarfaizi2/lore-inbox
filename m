Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVFVHhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVFVHhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVFVHeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:34:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:56731 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262768AbVFVFVu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:50 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: drivers/i2c/chips/it87.c: use dynamic sysfs callbacks
In-Reply-To: <11194174673955@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:47 -0700
Message-Id: <11194174672283@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: drivers/i2c/chips/it87.c: use dynamic sysfs callbacks

This patch modifies the it87 hardware monitoring driver to take benefit
of the new sysfs callback features introduced by Yani Ioannou, making
the code much clearer and the resulting driver significantly smaller.

From: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 20ad93d4e5cf5f0616198b5919ee9f304119dd4b
tree a2260af225b373435ceb4e9475dfbbe67f019832
parent bc51ae1159c0c9a34d2400a8449e1fca3ee965b4
author Jean Delvare <khali@linux-fr.org> Sun, 05 Jun 2005 11:53:25 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:04 -0700

 drivers/i2c/chips/it87.c |  387 ++++++++++++++++++++++------------------------
 1 files changed, 183 insertions(+), 204 deletions(-)

diff --git a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c
+++ b/drivers/i2c/chips/it87.c
@@ -37,6 +37,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/i2c-sysfs.h>
 #include <linux/i2c-vid.h>
 #include <asm/io.h>
 
@@ -238,27 +239,42 @@ static struct i2c_driver it87_driver = {
 	.detach_client	= it87_detach_client,
 };
 
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
 }
 
-static ssize_t show_in_min(struct device *dev, char *buf, int nr)
+static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
 }
 
-static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
 }
 
-static ssize_t set_in_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
@@ -270,9 +286,12 @@ static ssize_t set_in_min(struct device 
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_in_max(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
@@ -286,38 +305,14 @@ static ssize_t set_in_max(struct device 
 }
 
 #define show_in_offset(offset)					\
-static ssize_t							\
-	show_in##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{								\
-	return show_in(dev, buf, offset);			\
-}								\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
+		show_in, NULL, offset);
 
 #define limit_in_offset(offset)					\
-static ssize_t							\
-	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{								\
-	return show_in_min(dev, buf, offset);			\
-}								\
-static ssize_t							\
-	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
-{								\
-	return show_in_max(dev, buf, offset);			\
-}								\
-static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr, 	\
-		const char *buf, size_t count) 			\
-{								\
-	return set_in_min(dev, buf, count, offset);		\
-}								\
-static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr,	\
-			const char *buf, size_t count)		\
-{								\
-	return set_in_max(dev, buf, count, offset);		\
-}								\
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_min, set_in##offset##_min);	\
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_max, set_in##offset##_max);
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, offset);
 
 show_in_offset(0);
 limit_in_offset(0);
@@ -338,24 +333,39 @@ limit_in_offset(7);
 show_in_offset(8);
 
 /* 3 temperatures */
-static ssize_t show_temp(struct device *dev, char *buf, int nr)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
 }
-static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr]));
 }
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr]));
 }
-static ssize_t set_temp_max(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -366,9 +376,12 @@ static ssize_t set_temp_max(struct devic
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_temp_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -380,42 +393,23 @@ static ssize_t set_temp_min(struct devic
 	return count;
 }
 #define show_temp_offset(offset)					\
-static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_temp(dev, buf, offset - 1);				\
-}									\
-static ssize_t								\
-show_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return show_temp_max(dev, buf, offset - 1);			\
-}									\
-static ssize_t								\
-show_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return show_temp_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_temp_##offset##_max (struct device *dev, struct device_attribute *attr, 		\
-		const char *buf, size_t count) 				\
-{									\
-	return set_temp_max(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t set_temp_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
-		const char *buf, size_t count) 				\
-{									\
-	return set_temp_min(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL); \
-static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_max, set_temp_##offset##_max); 	\
-static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_min, set_temp_##offset##_min);	
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
+		show_temp, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_temp_max, set_temp_max, offset - 1);		\
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_temp_min, set_temp_min, offset - 1);
 
 show_temp_offset(1);
 show_temp_offset(2);
 show_temp_offset(3);
 
-static ssize_t show_sensor(struct device *dev, char *buf, int nr)
+static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	u8 reg = data->sensor; /* In case the value is updated while we use it */
 	
@@ -425,9 +419,12 @@ static ssize_t show_sensor(struct device
 		return sprintf(buf, "2\n");  /* thermistor */
 	return sprintf(buf, "0\n");      /* disabled */
 }
-static ssize_t set_sensor(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -450,53 +447,67 @@ static ssize_t set_sensor(struct device 
 	return count;
 }
 #define show_sensor_offset(offset)					\
-static ssize_t show_sensor_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_sensor(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_sensor_##offset (struct device *dev, struct device_attribute *attr, 		\
-		const char *buf, size_t count) 				\
-{									\
-	return set_sensor(dev, buf, count, offset - 1);			\
-}									\
-static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, 		\
-		show_sensor_##offset, set_sensor_##offset);
+static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR,	\
+		show_sensor, set_sensor, offset - 1);
 
 show_sensor_offset(1);
 show_sensor_offset(2);
 show_sensor_offset(3);
 
 /* 3 Fans */
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
 				DIV_FROM_REG(data->fan_div[nr])));
 }
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n",
 		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])));
 }
-static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
-static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
+static ssize_t show_pwm_enable(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
 }
-static ssize_t show_pwm(struct device *dev, char *buf, int nr)
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", data->manual_pwm_ctl[nr]);
 }
-static ssize_t set_fan_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -507,9 +518,12 @@ static ssize_t set_fan_min(struct device
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_fan_div(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -547,9 +561,12 @@ static ssize_t set_fan_div(struct device
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_pwm_enable(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_pwm_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -578,9 +595,12 @@ static ssize_t set_pwm_enable(struct dev
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t set_pwm(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -596,64 +616,23 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }
 
-#define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan(dev, buf, offset - 1);				\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan_div(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
-	const char *buf, size_t count) 					\
-{									\
-	return set_fan_min(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t set_fan_##offset##_div (struct device *dev, struct device_attribute *attr, 		\
-		const char *buf, size_t count) 				\
-{									\
-	return set_fan_div(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL); \
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_min, set_fan_##offset##_min); 	\
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_div, set_fan_##offset##_div);
+#define show_fan_offset(offset)					\
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,		\
+		show_fan, NULL, offset - 1);			\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
+		show_fan_min, set_fan_min, offset - 1);		\
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
+		show_fan_div, set_fan_div, offset - 1);
 
 show_fan_offset(1);
 show_fan_offset(2);
 show_fan_offset(3);
 
 #define show_pwm_offset(offset)						\
-static ssize_t show_pwm##offset##_enable (struct device *dev, struct device_attribute *attr,		\
-	char *buf)							\
-{									\
-	return show_pwm_enable(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_pwm##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	return show_pwm(dev, buf, offset - 1);				\
-}									\
-static ssize_t set_pwm##offset##_enable (struct device *dev, struct device_attribute *attr,		\
-		const char *buf, size_t count)				\
-{									\
-	return set_pwm_enable(dev, buf, count, offset - 1);		\
-}									\
-static ssize_t set_pwm##offset (struct device *dev, struct device_attribute *attr,			\
-		const char *buf, size_t count)				\
-{									\
-	return set_pwm(dev, buf, count, offset - 1);			\
-}									\
-static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,		\
-		show_pwm##offset##_enable,				\
-		set_pwm##offset##_enable);				\
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
-		show_pwm##offset , set_pwm##offset );
+static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
+		show_pwm_enable, set_pwm_enable, offset - 1);		\
+static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
+		show_pwm, set_pwm, offset - 1);
 
 show_pwm_offset(1);
 show_pwm_offset(2);
@@ -861,60 +840,60 @@ int it87_detect(struct i2c_adapter *adap
 	it87_init_client(new_client, data);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_in0_input);
-	device_create_file(&new_client->dev, &dev_attr_in1_input);
-	device_create_file(&new_client->dev, &dev_attr_in2_input);
-	device_create_file(&new_client->dev, &dev_attr_in3_input);
-	device_create_file(&new_client->dev, &dev_attr_in4_input);
-	device_create_file(&new_client->dev, &dev_attr_in5_input);
-	device_create_file(&new_client->dev, &dev_attr_in6_input);
-	device_create_file(&new_client->dev, &dev_attr_in7_input);
-	device_create_file(&new_client->dev, &dev_attr_in8_input);
-	device_create_file(&new_client->dev, &dev_attr_in0_min);
-	device_create_file(&new_client->dev, &dev_attr_in1_min);
-	device_create_file(&new_client->dev, &dev_attr_in2_min);
-	device_create_file(&new_client->dev, &dev_attr_in3_min);
-	device_create_file(&new_client->dev, &dev_attr_in4_min);
-	device_create_file(&new_client->dev, &dev_attr_in5_min);
-	device_create_file(&new_client->dev, &dev_attr_in6_min);
-	device_create_file(&new_client->dev, &dev_attr_in7_min);
-	device_create_file(&new_client->dev, &dev_attr_in0_max);
-	device_create_file(&new_client->dev, &dev_attr_in1_max);
-	device_create_file(&new_client->dev, &dev_attr_in2_max);
-	device_create_file(&new_client->dev, &dev_attr_in3_max);
-	device_create_file(&new_client->dev, &dev_attr_in4_max);
-	device_create_file(&new_client->dev, &dev_attr_in5_max);
-	device_create_file(&new_client->dev, &dev_attr_in6_max);
-	device_create_file(&new_client->dev, &dev_attr_in7_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_input);
-	device_create_file(&new_client->dev, &dev_attr_temp3_input);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max);
-	device_create_file(&new_client->dev, &dev_attr_temp3_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_min);
-	device_create_file(&new_client->dev, &dev_attr_temp2_min);
-	device_create_file(&new_client->dev, &dev_attr_temp3_min);
-	device_create_file(&new_client->dev, &dev_attr_temp1_type);
-	device_create_file(&new_client->dev, &dev_attr_temp2_type);
-	device_create_file(&new_client->dev, &dev_attr_temp3_type);
-	device_create_file(&new_client->dev, &dev_attr_fan1_input);
-	device_create_file(&new_client->dev, &dev_attr_fan2_input);
-	device_create_file(&new_client->dev, &dev_attr_fan3_input);
-	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan2_min);
-	device_create_file(&new_client->dev, &dev_attr_fan3_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_div);
-	device_create_file(&new_client->dev, &dev_attr_fan2_div);
-	device_create_file(&new_client->dev, &dev_attr_fan3_div);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_type.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_div.dev_attr);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	if (enable_pwm_interface) {
-		device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
-		device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
-		device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
-		device_create_file(&new_client->dev, &dev_attr_pwm1);
-		device_create_file(&new_client->dev, &dev_attr_pwm2);
-		device_create_file(&new_client->dev, &dev_attr_pwm3);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_enable.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_enable.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_enable.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
 	}
 
 	if (data->type == it8712) {

