Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVEKUMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVEKUMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVEKUMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:12:45 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:23931 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262037AbVEKUK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:10:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=JUA+w93r7TMqa38baPZq1zSKRfa1V64u/foHButjyvztQiGUBF6jdpGnPiy0wMeDop8LoRwHmNe4Al9jovxufKK4cLerKKJwYCZH/SjrBqvklNfShLRT6zNJFK1N9MBvlvVRXZtUoXtRbZADI2PVPkuPHhctxfwQXYRgua2N658=
Message-ID: <2538186705051113106f6f14fd@mail.gmail.com>
Date: Wed, 11 May 2005 16:10:26 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, Justin Thiessen <jthiessen@penguincomputing.com>
Subject: [PATCH 2.6.12-rc4] (dynamic sysfs callbacks) adm1026 (2nd try)
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050511170750.GE15398@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_337_25339421.1115842226205"
References: <2538186705051100583c6b1ffb@mail.gmail.com>
	 <20050511170750.GE15398@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_337_25339421.1115842226205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Attached is the corrected adm1026 patch (incorrect casting of void *
argument in callbacks). Justin if you have the ability to test this
patch that would be much appreciated.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

---
 adm1026.c |  235
++++++++++++++++++++------------------------------------------ 1 files
changed, 78 insertions(+), 157 deletions(-)
---

------=_Part_337_25339421.1115842226205
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-adm1026.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-adm1026.diff"

diff -uprN linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro/drivers/i2c/chips/adm1026.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-adm1026/drivers/i2c/chips/adm1026.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro/drivers/i2c/chips/adm1026.c	2005-05-11 02:09:21.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-adm1026/drivers/i2c/chips/adm1026.c	2005-05-11 16:01:01.000000000 -0400
@@ -711,19 +711,22 @@ static struct adm1026_data *adm1026_upda
 	return data;
 }
 
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, char *buf, void *private)
 {
+	int nr = (int)private;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
 }
-static ssize_t show_in_min(struct device *dev, char *buf, int nr) 
+static ssize_t show_in_min(struct device *dev, char *buf, void *private) 
 {
+	int nr = (int)private;
 	struct adm1026_data *data = adm1026_update_device(dev); 
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_min[nr]));
 }
 static ssize_t set_in_min(struct device *dev, const char *buf, 
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = (int)private;
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
+	int nr = (int)private;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_max[nr]));
 }
 static ssize_t set_in_max(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = (int)private;
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
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr],
 		data->fan_div[nr]));
 }
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev, char *buf, void *private)
 {
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
 		data->fan_div[nr]));
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = ((int)private)-1;
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
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", data->fan_div[nr]);
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = ((int)private)-1;
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
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp[nr]));
 }
-static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
+static ssize_t show_temp_min(struct device *dev, char *buf, void *private)
 {
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_min[nr]));
 }
 static ssize_t set_temp_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = ((int)private)-1;
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
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[nr]));
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = ((int)private)-1;
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
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_offset[nr]));
 }
 static ssize_t set_temp_offset(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = ((int)private)-1;
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
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(
 		ADM1026_FAN_ACTIVATION_TEMP_HYST + data->temp_tmin[nr]));
 }
 static ssize_t show_temp_auto_point2_temp(struct device *dev, char *buf,
-		int nr)
+		void *private)
 {
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_tmin[nr] +
 		ADM1026_FAN_CONTROL_TEMP_RANGE));
 }
 static ssize_t show_temp_auto_point1_temp(struct device *dev, char *buf,
-		int nr)
+		void *private)
 {
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_tmin[nr]));
 }
 static ssize_t set_temp_auto_point1_temp(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = ((int)private)-1;
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
+	int nr = ((int)private)-1;
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_crit[nr]));
 }
 static ssize_t set_temp_crit(struct device *dev, const char *buf,
-		size_t count, int nr)
+		size_t count, void *private)
 {
+	int nr = ((int)private)-1;
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

------=_Part_337_25339421.1115842226205--
