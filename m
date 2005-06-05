Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVFEIvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVFEIvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVFEIvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:51:42 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:12307 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261369AbVFEIup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:50:45 -0400
Date: Sun, 5 Jun 2005 10:51:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
 drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Message-Id: <20050605105146.6f68fc94.khali@linux-fr.org>
In-Reply-To: <2538186705051703479bd0c29@mail.gmail.com>
References: <2538186705051703479bd0c29@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yani, all,

> Finally (phew!) this patch demonstrates how to adapt the adm1026 to
> take advantage of the new callbacks, and the i2c-sysfs.h defined
> structure/macros. Most of the other sensor/hwmon drivers could be
> updated in the same way. The odd few exceptions (bmcsensors for
> example) however might be better off with their own custom attribute
> structure.

I just noticed that this patch has a repeated coding style error:

+	struct sensor_device_attribute *sensor_attr= to_sensor_dev_attr(attr);

should be:

+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);

Can we apply this modified version instead? Or is an incremental patch
preferred?

----------------------------------------------------------

Finally (phew!) this patch demonstrates how to adapt the adm1026 to
take advantage of the new callbacks, and the i2c-sysfs.h defined
structure/macros. Most of the other sensor/hwmon drivers could be
updated in the same way. The odd few exceptions (bmcsensors for
example) however might be better off with their own custom attribute
structure.

Again I'd prefer someone test this particular patch before it be
applied, because I haven't got an adm1026 to test it with :-).

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/adm1026.c |  524 ++++++++++++++++++++------------------------
 1 files changed, 241 insertions(+), 283 deletions(-)

--- linux-2.6.12-rc5.orig/drivers/i2c/chips/adm1026.c	2005-05-25 20:55:47.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/adm1026.c	2005-06-05 10:35:11.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/i2c-sysfs.h>
 #include <linux/i2c-vid.h>
 
 /* Addresses to scan */
@@ -710,19 +711,27 @@
 	return data;
 }
 
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
 }
-static ssize_t show_in_min(struct device *dev, char *buf, int nr) 
+static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev); 
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_min[nr]));
 }
-static ssize_t set_in_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -733,14 +742,19 @@
 	up(&data->update_lock);
 	return count; 
 }
-static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_max[nr]));
 }
-static ssize_t set_in_max(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -752,34 +766,13 @@
 	return count;
 }
 
-#define in_reg(offset)                                                    \
-static ssize_t show_in##offset (struct device *dev, struct device_attribute *attr, char *buf)            \
-{                                                                         \
-	return show_in(dev, buf, offset);                                 \
-}                                                                         \
-static ssize_t show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)      \
-{                                                                         \
-	return show_in_min(dev, buf, offset);                             \
-}                                                                         \
-static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr,                  \
-	const char *buf, size_t count)                                    \
-{                                                                         \
-	return set_in_min(dev, buf, count, offset);                       \
-}                                                                         \
-static ssize_t show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)      \
-{                                                                         \
-	return show_in_max(dev, buf, offset);                             \
-}                                                                         \
-static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr,                  \
-	const char *buf, size_t count)                                    \
-{                                                                         \
-	return set_in_max(dev, buf, count, offset);                       \
-}                                                                         \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);   \
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,                   \
-		show_in##offset##_min, set_in##offset##_min);             \
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,                   \
-		show_in##offset##_max, set_in##offset##_max);
+#define in_reg(offset)						\
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in,	\
+		NULL, offset);					\
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, offset);
 
 
 in_reg(0);
@@ -842,30 +835,38 @@
 	return count;
 }
 
-static DEVICE_ATTR(in16_input, S_IRUGO, show_in16, NULL);
-static DEVICE_ATTR(in16_min, S_IRUGO | S_IWUSR, show_in16_min, set_in16_min);
-static DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max, set_in16_max);
+static SENSOR_DEVICE_ATTR(in16_input, S_IRUGO, show_in16, NULL, 16);
+static SENSOR_DEVICE_ATTR(in16_min, S_IRUGO | S_IWUSR, show_in16_min, set_in16_min, 16);
+static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max, set_in16_max, 16);
 
 
 
 
 /* Now add fan read/write functions */
 
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr],
 		data->fan_div[nr]));
 }
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
 		data->fan_div[nr]));
 }
-static ssize_t set_fan_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -878,23 +879,11 @@
 	return count;
 }
 
-#define fan_offset(offset)                                                  \
-static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)            \
-{                                                                           \
-	return show_fan(dev, buf, offset - 1);                              \
-}                                                                           \
-static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)      \
-{                                                                           \
-	return show_fan_min(dev, buf, offset - 1);                          \
-}                                                                           \
-static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr,                  \
-	const char *buf, size_t count)                                      \
-{                                                                           \
-	return set_fan_min(dev, buf, count, offset - 1);                    \
-}                                                                           \
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);  \
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,                    \
-		show_fan_##offset##_min, set_fan_##offset##_min);
+#define fan_offset(offset)                                         		\
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan, NULL, 	\
+		offset - 1);							\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,           	\
+		show_fan_min, set_fan_min, offset - 1);
 
 fan_offset(1);
 fan_offset(2);
@@ -925,14 +914,19 @@
 }
 
 /* Now add fan_div read/write functions */
-static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", data->fan_div[nr]);
 }
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int    val,orig_div,new_div,shift;
@@ -966,17 +960,8 @@
 }
 
 #define fan_offset_div(offset)                                          \
-static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)  \
-{                                                                       \
-	return show_fan_div(dev, buf, offset - 1);                      \
-}                                                                       \
-static ssize_t set_fan_##offset##_div (struct device *dev, struct device_attribute *attr,              \
-	const char *buf, size_t count)                                  \
-{                                                                       \
-	return set_fan_div(dev, buf, count, offset - 1);                \
-}                                                                       \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,                \
-		show_fan_##offset##_div, set_fan_##offset##_div);
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,         \
+		show_fan_div, set_fan_div, offset - 1);
 
 fan_offset_div(1);
 fan_offset_div(2);
@@ -988,19 +973,27 @@
 fan_offset_div(8);
 
 /* Temps */
-static ssize_t show_temp(struct device *dev, char *buf, int nr)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp[nr]));
 }
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_min[nr]));
 }
-static ssize_t set_temp_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1012,14 +1005,19 @@
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[nr]));
 }
-static ssize_t set_temp_max(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1031,48 +1029,34 @@
 	up(&data->update_lock);
 	return count;
 }
-#define temp_reg(offset)                                                      \
-static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)             \
-{                                                                             \
-	return show_temp(dev, buf, offset - 1);                               \
-}                                                                             \
-static ssize_t show_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)       \
-{                                                                             \
-	return show_temp_min(dev, buf, offset - 1);                           \
-}                                                                             \
-static ssize_t show_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)       \
-{                                                                             \
-	return show_temp_max(dev, buf, offset - 1);                           \
-}                                                                             \
-static ssize_t set_temp_##offset##_min (struct device *dev, struct device_attribute *attr,                   \
-	const char *buf, size_t count)                                        \
-{                                                                             \
-	return set_temp_min(dev, buf, count, offset - 1);                     \
-}                                                                             \
-static ssize_t set_temp_##offset##_max (struct device *dev, struct device_attribute *attr,                   \
-	const char *buf, size_t count)                                        \
-{                                                                             \
-	return set_temp_max(dev, buf, count, offset - 1);                     \
-}                                                                             \
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);  \
-static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,                     \
-		show_temp_##offset##_min, set_temp_##offset##_min);           \
-static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,                     \
-		show_temp_##offset##_max, set_temp_##offset##_max);
+
+#define temp_reg(offset)						\
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp, 	\
+		NULL, offset - 1);					\
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_temp_min, set_temp_min, offset - 1);		\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_temp_max, set_temp_max, offset - 1);
 
 
 temp_reg(1);
 temp_reg(2);
 temp_reg(3);
 
-static ssize_t show_temp_offset(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_offset(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_offset[nr]));
 }
-static ssize_t set_temp_offset(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_temp_offset(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1085,46 +1069,45 @@
 	return count;
 }
 
-#define temp_offset_reg(offset)                                             \
-static ssize_t show_temp_##offset##_offset (struct device *dev, struct device_attribute *attr, char *buf)  \
-{                                                                           \
-	return show_temp_offset(dev, buf, offset - 1);                      \
-}                                                                           \
-static ssize_t set_temp_##offset##_offset (struct device *dev, struct device_attribute *attr,              \
-	const char *buf, size_t count)                                      \
-{                                                                           \
-	return set_temp_offset(dev, buf, count, offset - 1);                \
-}                                                                           \
-static DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,                \
-		show_temp_##offset##_offset, set_temp_##offset##_offset);
+#define temp_offset_reg(offset)							\
+static SENSOR_DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,		\
+		show_temp_offset, set_temp_offset, offset - 1);
 
 temp_offset_reg(1);
 temp_offset_reg(2);
 temp_offset_reg(3);
 
-static ssize_t show_temp_auto_point1_temp_hyst(struct device *dev, char *buf,
-		int nr)
+static ssize_t show_temp_auto_point1_temp_hyst(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(
 		ADM1026_FAN_ACTIVATION_TEMP_HYST + data->temp_tmin[nr]));
 }
-static ssize_t show_temp_auto_point2_temp(struct device *dev, char *buf,
-		int nr)
+static ssize_t show_temp_auto_point2_temp(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_tmin[nr] +
 		ADM1026_FAN_CONTROL_TEMP_RANGE));
 }
-static ssize_t show_temp_auto_point1_temp(struct device *dev, char *buf,
-		int nr)
+static ssize_t show_temp_auto_point1_temp(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_tmin[nr]));
 }
-static ssize_t set_temp_auto_point1_temp(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_temp_auto_point1_temp(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1137,46 +1120,27 @@
 	return count;
 }
 
-#define temp_auto_point(offset)                                             \
-static ssize_t show_temp##offset##_auto_point1_temp (struct device *dev, struct device_attribute *attr,    \
-	char *buf)                                                          \
-{                                                                           \
-	return show_temp_auto_point1_temp(dev, buf, offset - 1);            \
-}                                                                           \
-static ssize_t set_temp##offset##_auto_point1_temp (struct device *dev, struct device_attribute *attr,     \
-	const char *buf, size_t count)                                      \
-{                                                                           \
-	return set_temp_auto_point1_temp(dev, buf, count, offset - 1);      \
-}                                                                           \
-static ssize_t show_temp##offset##_auto_point1_temp_hyst (struct device     \
-	*dev, struct device_attribute *attr, char *buf)                                                    \
-{                                                                           \
-	return show_temp_auto_point1_temp_hyst(dev, buf, offset - 1);       \
-}                                                                           \
-static ssize_t show_temp##offset##_auto_point2_temp (struct device *dev, struct device_attribute *attr,    \
-	 char *buf)                                                         \
-{                                                                           \
-	return show_temp_auto_point2_temp(dev, buf, offset - 1);            \
-}                                                                           \
-static DEVICE_ATTR(temp##offset##_auto_point1_temp, S_IRUGO | S_IWUSR,      \
-		show_temp##offset##_auto_point1_temp,                       \
-		set_temp##offset##_auto_point1_temp);                       \
-static DEVICE_ATTR(temp##offset##_auto_point1_temp_hyst, S_IRUGO,           \
-		show_temp##offset##_auto_point1_temp_hyst, NULL);           \
-static DEVICE_ATTR(temp##offset##_auto_point2_temp, S_IRUGO,                \
-		show_temp##offset##_auto_point2_temp, NULL);
+#define temp_auto_point(offset)							\
+static SENSOR_DEVICE_ATTR(temp##offset##_auto_point1_temp, S_IRUGO | S_IWUSR,	\
+		show_temp_auto_point1_temp, set_temp_auto_point1_temp, 		\
+		offset - 1);							\
+static SENSOR_DEVICE_ATTR(temp##offset##_auto_point1_temp_hyst, S_IRUGO,	\
+		show_temp_auto_point1_temp_hyst, NULL, offset - 1);		\
+static SENSOR_DEVICE_ATTR(temp##offset##_auto_point2_temp, S_IRUGO,		\
+		show_temp_auto_point2_temp, NULL, offset - 1);
 
 temp_auto_point(1);
 temp_auto_point(2);
 temp_auto_point(3);
 
-static ssize_t show_temp_crit_enable(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_crit_enable(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", (data->config1 & CFG1_THERM_HOT) >> 4);
 }
-static ssize_t set_temp_crit_enable(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
+static ssize_t set_temp_crit_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
@@ -1192,24 +1156,27 @@
 	return count;
 }
 
-static DEVICE_ATTR(temp1_crit_enable, S_IRUGO | S_IWUSR, 
-	show_temp_crit_enable, set_temp_crit_enable);
-
-static DEVICE_ATTR(temp2_crit_enable, S_IRUGO | S_IWUSR, 
-	show_temp_crit_enable, set_temp_crit_enable);
-
-static DEVICE_ATTR(temp3_crit_enable, S_IRUGO | S_IWUSR, 
+#define temp_crit_enable(offset)				\
+static DEVICE_ATTR(temp##offset##_crit_enable, S_IRUGO | S_IWUSR, \
 	show_temp_crit_enable, set_temp_crit_enable);
 
+temp_crit_enable(1);
+temp_crit_enable(2);
+temp_crit_enable(3);
 
-static ssize_t show_temp_crit(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_crit(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_crit[nr]));
 }
-static ssize_t set_temp_crit(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1222,18 +1189,9 @@
 	return count;
 }
 
-#define temp_crit_reg(offset)                                             \
-static ssize_t show_temp_##offset##_crit (struct device *dev, struct device_attribute *attr, char *buf)  \
-{                                                                         \
-	return show_temp_crit(dev, buf, offset - 1);                      \
-}                                                                         \
-static ssize_t set_temp_##offset##_crit (struct device *dev, struct device_attribute *attr,              \
-	const char *buf, size_t count)                                    \
-{                                                                         \
-	return set_temp_crit(dev, buf, count, offset - 1);                \
-}                                                                         \
-static DEVICE_ATTR(temp##offset##_crit, S_IRUGO | S_IWUSR,                \
-		show_temp_##offset##_crit, set_temp_##offset##_crit);
+#define temp_crit_reg(offset)						\
+static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IRUGO | S_IWUSR,	\
+		show_temp_crit, set_temp_crit, offset - 1);
 
 temp_crit_reg(1);
 temp_crit_reg(2);
@@ -1597,114 +1555,114 @@
 	adm1026_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_in0_input);
-	device_create_file(&new_client->dev, &dev_attr_in0_max);
-	device_create_file(&new_client->dev, &dev_attr_in0_min);
-	device_create_file(&new_client->dev, &dev_attr_in1_input);
-	device_create_file(&new_client->dev, &dev_attr_in1_max);
-	device_create_file(&new_client->dev, &dev_attr_in1_min);
-	device_create_file(&new_client->dev, &dev_attr_in2_input);
-	device_create_file(&new_client->dev, &dev_attr_in2_max);
-	device_create_file(&new_client->dev, &dev_attr_in2_min);
-	device_create_file(&new_client->dev, &dev_attr_in3_input);
-	device_create_file(&new_client->dev, &dev_attr_in3_max);
-	device_create_file(&new_client->dev, &dev_attr_in3_min);
-	device_create_file(&new_client->dev, &dev_attr_in4_input);
-	device_create_file(&new_client->dev, &dev_attr_in4_max);
-	device_create_file(&new_client->dev, &dev_attr_in4_min);
-	device_create_file(&new_client->dev, &dev_attr_in5_input);
-	device_create_file(&new_client->dev, &dev_attr_in5_max);
-	device_create_file(&new_client->dev, &dev_attr_in5_min);
-	device_create_file(&new_client->dev, &dev_attr_in6_input);
-	device_create_file(&new_client->dev, &dev_attr_in6_max);
-	device_create_file(&new_client->dev, &dev_attr_in6_min);
-	device_create_file(&new_client->dev, &dev_attr_in7_input);
-	device_create_file(&new_client->dev, &dev_attr_in7_max);
-	device_create_file(&new_client->dev, &dev_attr_in7_min);
-	device_create_file(&new_client->dev, &dev_attr_in8_input);
-	device_create_file(&new_client->dev, &dev_attr_in8_max);
-	device_create_file(&new_client->dev, &dev_attr_in8_min);
-	device_create_file(&new_client->dev, &dev_attr_in9_input);
-	device_create_file(&new_client->dev, &dev_attr_in9_max);
-	device_create_file(&new_client->dev, &dev_attr_in9_min);
-	device_create_file(&new_client->dev, &dev_attr_in10_input);
-	device_create_file(&new_client->dev, &dev_attr_in10_max);
-	device_create_file(&new_client->dev, &dev_attr_in10_min);
-	device_create_file(&new_client->dev, &dev_attr_in11_input);
-	device_create_file(&new_client->dev, &dev_attr_in11_max);
-	device_create_file(&new_client->dev, &dev_attr_in11_min);
-	device_create_file(&new_client->dev, &dev_attr_in12_input);
-	device_create_file(&new_client->dev, &dev_attr_in12_max);
-	device_create_file(&new_client->dev, &dev_attr_in12_min);
-	device_create_file(&new_client->dev, &dev_attr_in13_input);
-	device_create_file(&new_client->dev, &dev_attr_in13_max);
-	device_create_file(&new_client->dev, &dev_attr_in13_min);
-	device_create_file(&new_client->dev, &dev_attr_in14_input);
-	device_create_file(&new_client->dev, &dev_attr_in14_max);
-	device_create_file(&new_client->dev, &dev_attr_in14_min);
-	device_create_file(&new_client->dev, &dev_attr_in15_input);
-	device_create_file(&new_client->dev, &dev_attr_in15_max);
-	device_create_file(&new_client->dev, &dev_attr_in15_min);
-	device_create_file(&new_client->dev, &dev_attr_in16_input);
-	device_create_file(&new_client->dev, &dev_attr_in16_max);
-	device_create_file(&new_client->dev, &dev_attr_in16_min);
-	device_create_file(&new_client->dev, &dev_attr_fan1_input);
-	device_create_file(&new_client->dev, &dev_attr_fan1_div);
-	device_create_file(&new_client->dev, &dev_attr_fan1_min);
-	device_create_file(&new_client->dev, &dev_attr_fan2_input);
-	device_create_file(&new_client->dev, &dev_attr_fan2_div);
-	device_create_file(&new_client->dev, &dev_attr_fan2_min);
-	device_create_file(&new_client->dev, &dev_attr_fan3_input);
-	device_create_file(&new_client->dev, &dev_attr_fan3_div);
-	device_create_file(&new_client->dev, &dev_attr_fan3_min);
-	device_create_file(&new_client->dev, &dev_attr_fan4_input);
-	device_create_file(&new_client->dev, &dev_attr_fan4_div);
-	device_create_file(&new_client->dev, &dev_attr_fan4_min);
-	device_create_file(&new_client->dev, &dev_attr_fan5_input);
-	device_create_file(&new_client->dev, &dev_attr_fan5_div);
-	device_create_file(&new_client->dev, &dev_attr_fan5_min);
-	device_create_file(&new_client->dev, &dev_attr_fan6_input);
-	device_create_file(&new_client->dev, &dev_attr_fan6_div);
-	device_create_file(&new_client->dev, &dev_attr_fan6_min);
-	device_create_file(&new_client->dev, &dev_attr_fan7_input);
-	device_create_file(&new_client->dev, &dev_attr_fan7_div);
-	device_create_file(&new_client->dev, &dev_attr_fan7_min);
-	device_create_file(&new_client->dev, &dev_attr_fan8_input);
-	device_create_file(&new_client->dev, &dev_attr_fan8_div);
-	device_create_file(&new_client->dev, &dev_attr_fan8_min);
-	device_create_file(&new_client->dev, &dev_attr_temp1_input);
-	device_create_file(&new_client->dev, &dev_attr_temp1_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_min);
-	device_create_file(&new_client->dev, &dev_attr_temp2_input);
-	device_create_file(&new_client->dev, &dev_attr_temp2_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_min);
-	device_create_file(&new_client->dev, &dev_attr_temp3_input);
-	device_create_file(&new_client->dev, &dev_attr_temp3_max);
-	device_create_file(&new_client->dev, &dev_attr_temp3_min);
-	device_create_file(&new_client->dev, &dev_attr_temp1_offset);
-	device_create_file(&new_client->dev, &dev_attr_temp2_offset);
-	device_create_file(&new_client->dev, &dev_attr_temp3_offset);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in8_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in8_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in9_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in9_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in9_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in10_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in10_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in10_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in11_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in11_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in11_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in12_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in12_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in12_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in13_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in13_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in13_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in14_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in14_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in14_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in15_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in15_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in15_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in16_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in16_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_in16_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan4_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan4_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan4_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan5_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan5_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan5_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan6_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan6_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan6_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan7_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan7_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan7_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan8_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan8_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan8_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_offset.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_offset.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_offset.dev_attr);
 	device_create_file(&new_client->dev, 
-		&dev_attr_temp1_auto_point1_temp);
+		&sensor_dev_attr_temp1_auto_point1_temp.dev_attr);
 	device_create_file(&new_client->dev, 
-		&dev_attr_temp2_auto_point1_temp);
+		&sensor_dev_attr_temp2_auto_point1_temp.dev_attr);
 	device_create_file(&new_client->dev, 
-		&dev_attr_temp3_auto_point1_temp);
+		&sensor_dev_attr_temp3_auto_point1_temp.dev_attr);
 	device_create_file(&new_client->dev,
-		&dev_attr_temp1_auto_point1_temp_hyst);
+		&sensor_dev_attr_temp1_auto_point1_temp_hyst.dev_attr);
 	device_create_file(&new_client->dev,
-		&dev_attr_temp2_auto_point1_temp_hyst);
+		&sensor_dev_attr_temp2_auto_point1_temp_hyst.dev_attr);
 	device_create_file(&new_client->dev,
-		&dev_attr_temp3_auto_point1_temp_hyst);
+		&sensor_dev_attr_temp3_auto_point1_temp_hyst.dev_attr);
 	device_create_file(&new_client->dev, 
-		&dev_attr_temp1_auto_point2_temp);
+		&sensor_dev_attr_temp1_auto_point2_temp.dev_attr);
 	device_create_file(&new_client->dev, 
-		&dev_attr_temp2_auto_point2_temp);
+		&sensor_dev_attr_temp2_auto_point2_temp.dev_attr);
 	device_create_file(&new_client->dev, 
-		&dev_attr_temp3_auto_point2_temp);
-	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp3_crit);
+		&sensor_dev_attr_temp3_auto_point2_temp.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_crit.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_crit.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_crit.dev_attr);
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);


-- 
Jean Delvare
