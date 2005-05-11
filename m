Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVEKIBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVEKIBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVEKIBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:01:06 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:10 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261915AbVEKH6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:58:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=uKI2sAf+0TqMFMY2Rm8i08kQ8siNrmCoL3ZXY/tdQrrWOQBT6ghZbTIMF0NTmTJ4DGyH9yRFByNRL9qS5sZH4AN3bhZZ8YJKxEdXVf+ZdNXK/kLdWlqY8MRqZG/EcEF9GhgU1xXDCfQYRwIUObANUPunc2q+OEof4btIxZtESHU=
Message-ID: <2538186705051100583c6b1ffb@mail.gmail.com>
Date: Wed, 11 May 2005 03:58:35 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Cc: Justin Thiessen <jthiessen@penguincomputing.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_192_11616748.1115798315665"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_192_11616748.1115798315665
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This patch presents as an example one possible way to use the dynamic
callbacks to clean up one of the i2c chip drivers, adm1026 (for more
information please see
http://archives.andrew.net.au/lm-sensors/msg31310.html).

The first patch defines a new macros like DEVICE_ATTR that also sets
the attribute private data (Greg whats your opinion on defining a
separate set of macros for this v.s. rolling it into one macro?).

The second patch changes adm1026 to pass the sensor index/number via
the private data pointer. I can't test this patch (so you won't want
to apply this) but I'm CCing it to the adm1026 maintainer.

The size difference:

-----------------2.6.11.7--------------------
Module                  Size  Used by
adm1026                44692  0
------2.6.12-rc4-sysdyncallback-----
Module                  Size  Used by
adm1026                32656  0

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

---

------=_Part_192_11616748.1115798315665
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/include/linux/device.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro/include/linux/device.h
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/include/linux/device.h	2005-05-10 23:38:13.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro/include/linux/device.h	2005-05-11 03:15:40.000000000 -0400
@@ -343,6 +343,13 @@ struct device_attribute {
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
 struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
+#define DEVICE_ATTR_PRIVATE(_name,_mode,_show,_store,_private)                      \
+struct device_attribute dev_attr_##_name =  {                                       \
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE,   \
+		.private   = _private, },                                           \
+	.show   = _show,                                                            \
+	.store  = _store,                                                           \
+}
 
 extern int device_create_file(struct device *device, struct device_attribute * entry);
 extern void device_remove_file(struct device * dev, struct device_attribute * attr);











------=_Part_192_11616748.1115798315665
Content-Type: text/x-patch; name=adm1026-sysdyncallback.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="adm1026-sysdyncallback.diff"

--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/adm1026.c	2005-05-11 00:32:26.000000000 -0400
+++ /usr/src/linux/drivers/i2c/chips/adm1026.c	2005-05-11 03:40:25.000000000 -0400
@@ -711,19 +711,22 @@ static struct adm1026_data *adm1026_upda
 	return data;
 }
 
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private);
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
 }
-static ssize_t show_in_min(struct device *dev, char *buf, int nr) 
+static ssize_t show_in_min(struct device *dev, char *buf, void *private) 
 {
+	int nr = *((int*)private);
 	struct adm1026_data *data = adm1026_update_device(dev); 
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_min[nr]));
 }
 static ssize_t set_in_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -734,14 +737,16 @@ static ssize_t set_in_min(struct device 
 	up(&data->update_lock);
 	return count; 
 }
-static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+static ssize_t show_in_max(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private);
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_max[nr]));
 }
 static ssize_t set_in_max(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -753,35 +758,13 @@ static ssize_t set_in_max(struct device 
 	return count;
 }
 
-#define in_reg(offset)                                                    \
-static ssize_t show_in##offset (struct device *dev, char *buf, void *private)            \
-{                                                                         \
-	return show_in(dev, buf, offset);                                 \
-}                                                                         \
-static ssize_t show_in##offset##_min (struct device *dev, char *buf, void *private)      \
-{                                                                         \
-	return show_in_min(dev, buf, offset);                             \
-}                                                                         \
-static ssize_t set_in##offset##_min (struct device *dev,                  \
-	const char *buf, size_t count, void *private)                                    \
-{                                                                         \
-	return set_in_min(dev, buf, count, offset);                       \
-}                                                                         \
-static ssize_t show_in##offset##_max (struct device *dev, char *buf, void *private)      \
-{                                                                         \
-	return show_in_max(dev, buf, offset);                             \
-}                                                                         \
-static ssize_t set_in##offset##_max (struct device *dev,                  \
-	const char *buf, size_t count, void *private)                                    \
-{                                                                         \
-	return set_in_max(dev, buf, count, offset);                       \
-}                                                                         \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);   \
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,                   \
-		show_in##offset##_min, set_in##offset##_min);             \
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,                   \
-		show_in##offset##_max, set_in##offset##_max);
-
+#define in_reg(offset)                                                \
+static DEVICE_ATTR_PRIVATE(in##offset##_input, S_IRUGO, show_in, NULL,\
+		(void *)offset);                                      \
+static DEVICE_ATTR_PRIVATE(in##offset##_min, S_IRUGO | S_IWUSR,       \
+		show_in_min, set_in_min, (void *) offset);            \
+static DEVICE_ATTR_PRIVATE(in##offset##_max, S_IRUGO | S_IWUSR,       \
+		show_in_max, set_in_max, (void *) offset);
 
 in_reg(0);
 in_reg(1);
@@ -852,21 +835,24 @@ static DEVICE_ATTR(in16_max, S_IRUGO | S
 
 /* Now add fan read/write functions */
 
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr],
 		data->fan_div[nr]));
 }
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
 		data->fan_div[nr]));
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -879,23 +865,11 @@ static ssize_t set_fan_min(struct device
 	return count;
 }
 
-#define fan_offset(offset)                                                  \
-static ssize_t show_fan_##offset (struct device *dev, char *buf, void *private)            \
-{                                                                           \
-	return show_fan(dev, buf, offset - 1);                              \
-}                                                                           \
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf, void *private)      \
-{                                                                           \
-	return show_fan_min(dev, buf, offset - 1);                          \
-}                                                                           \
-static ssize_t set_fan_##offset##_min (struct device *dev,                  \
-	const char *buf, size_t count, void *private)                                      \
-{                                                                           \
-	return set_fan_min(dev, buf, count, offset - 1);                    \
-}                                                                           \
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);  \
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,                    \
-		show_fan_##offset##_min, set_fan_##offset##_min);
+#define fan_offset(offset)                                               \
+static DEVICE_ATTR_PRIVATE(fan##offset##_input, S_IRUGO, show_fan, NULL, \
+		(void *)offset);                                        \
+static DEVICE_ATTR_PRIVATE(fan##offset##_min, S_IRUGO | S_IWUSR,         \
+		show_fan_min, set_fan_min, (void *)offset);
 
 fan_offset(1);
 fan_offset(2);
@@ -926,14 +900,16 @@ static void fixup_fan_min(struct device 
 }
 
 /* Now add fan_div read/write functions */
-static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_div(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", data->fan_div[nr]);
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int    val,orig_div,new_div,shift;
@@ -967,17 +943,8 @@ static ssize_t set_fan_div(struct device
 }
 
 #define fan_offset_div(offset)                                          \
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf, void *private)  \
-{                                                                       \
-	return show_fan_div(dev, buf, offset - 1);                      \
-}                                                                       \
-static ssize_t set_fan_##offset##_div (struct device *dev,              \
-	const char *buf, size_t count, void *private)                                  \
-{                                                                       \
-	return set_fan_div(dev, buf, count, offset - 1);                \
-}                                                                       \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,                \
-		show_fan_##offset##_div, set_fan_##offset##_div);
+static DEVICE_ATTR_PRIVATE(fan##offset##_div, S_IRUGO | S_IWUSR,           \
+		show_fan_div, set_fan_div, (void *)offset);
 
 fan_offset_div(1);
 fan_offset_div(2);
@@ -989,19 +956,22 @@ fan_offset_div(7);
 fan_offset_div(8);
 
 /* Temps */
-static ssize_t show_temp(struct device *dev, char *buf, int nr)
+static ssize_t show_temp(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp[nr]));
 }
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_min(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_min[nr]));
 }
 static ssize_t set_temp_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1013,14 +983,16 @@ static ssize_t set_temp_min(struct devic
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_max(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[nr]));
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1032,48 +1004,30 @@ static ssize_t set_temp_max(struct devic
 	up(&data->update_lock);
 	return count;
 }
+
 #define temp_reg(offset)                                                      \
-static ssize_t show_temp_##offset (struct device *dev, char *buf, void *private)             \
-{                                                                             \
-	return show_temp(dev, buf, offset - 1);                               \
-}                                                                             \
-static ssize_t show_temp_##offset##_min (struct device *dev, char *buf, void *private)       \
-{                                                                             \
-	return show_temp_min(dev, buf, offset - 1);                           \
-}                                                                             \
-static ssize_t show_temp_##offset##_max (struct device *dev, char *buf, void *private)       \
-{                                                                             \
-	return show_temp_max(dev, buf, offset - 1);                           \
-}                                                                             \
-static ssize_t set_temp_##offset##_min (struct device *dev,                   \
-	const char *buf, size_t count, void *private)                                        \
-{                                                                             \
-	return set_temp_min(dev, buf, count, offset - 1);                     \
-}                                                                             \
-static ssize_t set_temp_##offset##_max (struct device *dev,                   \
-	const char *buf, size_t count, void *private)                                        \
-{                                                                             \
-	return set_temp_max(dev, buf, count, offset - 1);                     \
-}                                                                             \
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);  \
-static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,                     \
-		show_temp_##offset##_min, set_temp_##offset##_min);           \
-static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,                     \
-		show_temp_##offset##_max, set_temp_##offset##_max);
+static DEVICE_ATTR_PRIVATE(temp##offset##_input, S_IRUGO, show_temp, NULL,       \
+		(void *)offset);                                          \
+static DEVICE_ATTR_PRIVATE(temp##offset##_min, S_IRUGO | S_IWUSR,                \
+		show_temp_min, set_temp_min, (void *)offset);             \
+static DEVICE_ATTR_PRIVATE(temp##offset##_max, S_IRUGO | S_IWUSR,                \
+		show_temp_max, set_temp_max, (void *)offset);
 
 
 temp_reg(1);
 temp_reg(2);
 temp_reg(3);
 
-static ssize_t show_temp_offset(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_offset(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_offset[nr]));
 }
 static ssize_t set_temp_offset(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1087,45 +1041,40 @@ static ssize_t set_temp_offset(struct de
 }
 
 #define temp_offset_reg(offset)                                             \
-static ssize_t show_temp_##offset##_offset (struct device *dev, char *buf, void *private)  \
-{                                                                           \
-	return show_temp_offset(dev, buf, offset - 1);                      \
-}                                                                           \
-static ssize_t set_temp_##offset##_offset (struct device *dev,              \
-	const char *buf, size_t count, void *private)                                      \
-{                                                                           \
-	return set_temp_offset(dev, buf, count, offset - 1);                \
-}                                                                           \
-static DEVICE_ATTR(temp##offset##_offset, S_IRUGO | S_IWUSR,                \
-		show_temp_##offset##_offset, set_temp_##offset##_offset);
+static DEVICE_ATTR_PRIVATE(temp##offset##_offset, S_IRUGO | S_IWUSR,           \
+		show_temp_offset, set_temp_offset, (void *)offset);
 
 temp_offset_reg(1);
 temp_offset_reg(2);
 temp_offset_reg(3);
 
 static ssize_t show_temp_auto_point1_temp_hyst(struct device *dev, char *buf,
-		int nr)
+		void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(
 		ADM1026_FAN_ACTIVATION_TEMP_HYST + data->temp_tmin[nr]));
 }
 static ssize_t show_temp_auto_point2_temp(struct device *dev, char *buf,
-		int nr)
+		void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_tmin[nr] +
 		ADM1026_FAN_CONTROL_TEMP_RANGE));
 }
 static ssize_t show_temp_auto_point1_temp(struct device *dev, char *buf,
-		int nr)
+		void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_tmin[nr]));
 }
 static ssize_t set_temp_auto_point1_temp(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1138,34 +1087,13 @@ static ssize_t set_temp_auto_point1_temp
 	return count;
 }
 
-#define temp_auto_point(offset)                                             \
-static ssize_t show_temp##offset##_auto_point1_temp (struct device *dev,    \
-	char *buf, void *private)                                                          \
-{                                                                           \
-	return show_temp_auto_point1_temp(dev, buf, offset - 1);            \
-}                                                                           \
-static ssize_t set_temp##offset##_auto_point1_temp (struct device *dev,     \
-	const char *buf, size_t count, void *private)                                      \
-{                                                                           \
-	return set_temp_auto_point1_temp(dev, buf, count, offset - 1);      \
-}                                                                           \
-static ssize_t show_temp##offset##_auto_point1_temp_hyst (struct device     \
-	*dev, char *buf, void *private)                                                    \
-{                                                                           \
-	return show_temp_auto_point1_temp_hyst(dev, buf, offset - 1);       \
-}                                                                           \
-static ssize_t show_temp##offset##_auto_point2_temp (struct device *dev,    \
-	 char *buf, void *private)                                                         \
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
+#define temp_auto_point(offset)                                                             \
+static DEVICE_ATTR_PRIVATE(temp##offset##_auto_point1_temp, S_IRUGO | S_IWUSR,                 \
+		show_temp_auto_point1_temp, set_temp_auto_point1_temp, (void *)offset); \
+static DEVICE_ATTR_PRIVATE(temp##offset##_auto_point1_temp_hyst, S_IRUGO,                      \
+		show_temp_auto_point1_temp_hyst, NULL, (void *)offset);                 \
+static DEVICE_ATTR_PRIVATE(temp##offset##_auto_point2_temp, S_IRUGO,                           \
+		show_temp_auto_point2_temp, NULL, (void *)offset);
 
 temp_auto_point(1);
 temp_auto_point(2);
@@ -1203,14 +1131,16 @@ static DEVICE_ATTR(temp3_crit_enable, S_
 	show_temp_crit_enable, set_temp_crit_enable);
 
 
-static ssize_t show_temp_crit(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_crit(struct device *dev, char *buf, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_crit[nr]));
 }
 static ssize_t set_temp_crit(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = *((int*)private)-1;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
@@ -1224,17 +1154,8 @@ static ssize_t set_temp_crit(struct devi
 }
 
 #define temp_crit_reg(offset)                                             \
-static ssize_t show_temp_##offset##_crit (struct device *dev, char *buf, void *private)  \
-{                                                                         \
-	return show_temp_crit(dev, buf, offset - 1);                      \
-}                                                                         \
-static ssize_t set_temp_##offset##_crit (struct device *dev,              \
-	const char *buf, size_t count, void *private)                                    \
-{                                                                         \
-	return set_temp_crit(dev, buf, count, offset - 1);                \
-}                                                                         \
-static DEVICE_ATTR(temp##offset##_crit, S_IRUGO | S_IWUSR,                \
-		show_temp_##offset##_crit, set_temp_##offset##_crit);
+static DEVICE_ATTR_PRIVATE(temp##offset##_crit, S_IRUGO | S_IWUSR,           \
+		show_temp_crit, set_temp_crit, (void *)offset);
 
 temp_crit_reg(1);
 temp_crit_reg(2);










------=_Part_192_11616748.1115798315665--
