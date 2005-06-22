Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVFVG07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVFVG07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVFVGZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:25:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:33436 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262804AbVFVFWH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:07 -0400
Cc: gregkh@suse.de
Subject: [PATCH] I2C: fix up some sysfs device attribute file parameters
In-Reply-To: <11194174652790@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:45 -0700
Message-Id: <11194174652306@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: fix up some sysfs device attribute file parameters

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6f637a6494a1872c613fe68f64ea4831c3e5b037
tree a18368e908290ca7bdf3430b0b5b9cbc0131da5b
parent 563db2fe9e0843da9d1d85d824f022be0ada4a3c
author Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:01:59 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:59 -0700

 drivers/i2c/chips/adm9240.c   |   54 ++++++++++++++++++++++++++++-------------
 drivers/i2c/chips/atxp1.c     |   12 +++++----
 drivers/i2c/chips/w83627ehf.c |   29 ++++++++++++++--------
 3 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/chips/adm9240.c b/drivers/i2c/chips/adm9240.c
--- a/drivers/i2c/chips/adm9240.c
+++ b/drivers/i2c/chips/adm9240.c
@@ -185,7 +185,9 @@ static int adm9240_write_value(struct i2
 
 /* temperature */
 #define show_temp(value, scale)					\
-static ssize_t show_##value(struct device *dev, char *buf)	\
+static ssize_t show_##value(struct device *dev,			\
+			    struct device_attribute *attr,	\
+			    char *buf)				\
 {								\
 	struct adm9240_data *data = adm9240_update_device(dev);	\
 	return sprintf(buf, "%d\n", data->value * scale);	\
@@ -195,8 +197,9 @@ show_temp(temp_hyst, 1000);
 show_temp(temp, 500); /* 0.5'C per bit */
 
 #define set_temp(value, reg)					\
-static ssize_t set_##value(struct device *dev, const char *buf,	\
-		size_t count)					\
+static ssize_t set_##value(struct device *dev, 			\
+			   struct device_attribute *attr,	\
+			   const char *buf, size_t count)	\
 {								\
 	struct i2c_client *client = to_i2c_client(dev);		\
 	struct adm9240_data *data = adm9240_update_device(dev);	\
@@ -266,26 +269,36 @@ static ssize_t set_in_max(struct device 
 }
 
 #define show_in_offset(offset)						\
-static ssize_t show_in##offset(struct device *dev, char *buf)		\
+static ssize_t show_in##offset(struct device *dev,			\
+			       struct device_attribute *attr,		\
+			       char *buf)				\
 {									\
 	return show_in(dev, buf, offset);				\
 }									\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);	\
-static ssize_t show_in##offset##_min(struct device *dev, char *buf)	\
+static ssize_t show_in##offset##_min(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
 {									\
 	return show_in_min(dev, buf, offset);				\
 }									\
-static ssize_t show_in##offset##_max(struct device *dev, char *buf)	\
+static ssize_t show_in##offset##_max(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
 {									\
 	return show_in_max(dev, buf, offset);				\
 }									\
 static ssize_t								\
-set_in##offset##_min(struct device *dev, const char *buf, size_t count)	\
+set_in##offset##_min(struct device *dev,				\
+		     struct device_attribute *attr, const char *buf,	\
+		     size_t count)					\
 {									\
 	return set_in_min(dev, buf, count, offset);			\
 }									\
 static ssize_t								\
-set_in##offset##_max(struct device *dev, const char *buf, size_t count)	\
+set_in##offset##_max(struct device *dev,				\
+		     struct device_attribute *attr, const char *buf,	\
+		     size_t count)					\
 {									\
 	return set_in_max(dev, buf, count, offset);			\
 }									\
@@ -401,20 +414,27 @@ static ssize_t set_fan_min(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev,			\
+				  struct device_attribute *attr,	\
+				  char *buf)				\
 {									\
 return show_fan(dev, buf, offset - 1);					\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_div (struct device *dev,		\
+					struct device_attribute *attr,	\
+					char *buf)			\
 {									\
 return show_fan_div(dev, buf, offset - 1);				\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_min (struct device *dev,		\
+					struct device_attribute *attr,	\
+					char *buf)			\
 {									\
 return show_fan_min(dev, buf, offset - 1);				\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
-const char *buf, size_t count)						\
+				       struct device_attribute *attr,	\
+				       const char *buf, size_t count)	\
 {									\
 return set_fan_min(dev, buf, count, offset - 1);			\
 }									\
@@ -429,7 +449,7 @@ show_fan_offset(1);
 show_fan_offset(2);
 
 /* alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -437,7 +457,7 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* vid */
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -445,13 +465,13 @@ static ssize_t show_vid(struct device *d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* analog output */
-static ssize_t show_aout(struct device *dev, char *buf)
+static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
 
-static ssize_t set_aout(struct device *dev, const char *buf, size_t count)
+static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
@@ -466,7 +486,7 @@ static ssize_t set_aout(struct device *d
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
 
 /* chassis_clear */
-static ssize_t chassis_clear(struct device *dev, const char *buf, size_t count)
+static ssize_t chassis_clear(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned long val = simple_strtol(buf, NULL, 10);
diff --git a/drivers/i2c/chips/atxp1.c b/drivers/i2c/chips/atxp1.c
--- a/drivers/i2c/chips/atxp1.c
+++ b/drivers/i2c/chips/atxp1.c
@@ -99,7 +99,7 @@ static struct atxp1_data * atxp1_update_
 }
 
 /* sys file functions for cpu0_vid */
-static ssize_t atxp1_showvcore(struct device *dev, char *buf)
+static ssize_t atxp1_showvcore(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -111,7 +111,7 @@ static ssize_t atxp1_showvcore(struct de
 	return size;
 }
 
-static ssize_t atxp1_storevcore(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storevcore(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
@@ -169,7 +169,7 @@ static ssize_t atxp1_storevcore(struct d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore, atxp1_storevcore);
 
 /* sys file functions for GPIO1 */
-static ssize_t atxp1_showgpio1(struct device *dev, char *buf)
+static ssize_t atxp1_showgpio1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -181,7 +181,7 @@ static ssize_t atxp1_showgpio1(struct de
 	return size;
 }
 
-static ssize_t atxp1_storegpio1(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storegpio1(struct device *dev, struct device_attribute *attr, const char*buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
@@ -211,7 +211,7 @@ static ssize_t atxp1_storegpio1(struct d
 static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);
 
 /* sys file functions for GPIO2 */
-static ssize_t atxp1_showgpio2(struct device *dev, char *buf)
+static ssize_t atxp1_showgpio2(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -223,7 +223,7 @@ static ssize_t atxp1_showgpio2(struct de
 	return size;
 }
 
-static ssize_t atxp1_storegpio2(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storegpio2(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
diff --git a/drivers/i2c/chips/w83627ehf.c b/drivers/i2c/chips/w83627ehf.c
--- a/drivers/i2c/chips/w83627ehf.c
+++ b/drivers/i2c/chips/w83627ehf.c
@@ -486,7 +486,8 @@ store_fan_min(struct device *dev, const 
 
 #define sysfs_fan_offset(offset) \
 static ssize_t \
-show_reg_fan_##offset(struct device *dev, char *buf) \
+show_reg_fan_##offset(struct device *dev, struct device_attribute *attr, \
+		      char *buf) \
 { \
 	return show_fan(dev, buf, offset-1); \
 } \
@@ -495,13 +496,14 @@ static DEVICE_ATTR(fan##offset##_input, 
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t \
-show_reg_fan##offset##_min(struct device *dev, char *buf) \
+show_reg_fan##offset##_min(struct device *dev, struct device_attribute *attr, \
+			   char *buf) \
 { \
 	return show_fan_min(dev, buf, offset-1); \
 } \
 static ssize_t \
-store_reg_fan##offset##_min(struct device *dev, const char *buf, \
-			    size_t count) \
+store_reg_fan##offset##_min(struct device *dev, struct device_attribute *attr, \
+			    const char *buf, size_t count) \
 { \
 	return store_fan_min(dev, buf, count, offset-1); \
 } \
@@ -511,7 +513,8 @@ static DEVICE_ATTR(fan##offset##_min, S_
 
 #define sysfs_fan_div_offset(offset) \
 static ssize_t \
-show_reg_fan##offset##_div(struct device *dev, char *buf) \
+show_reg_fan##offset##_div(struct device *dev, struct device_attribute *attr, \
+			   char *buf) \
 { \
 	return show_fan_div(dev, buf, offset - 1); \
 } \
@@ -536,7 +539,8 @@ sysfs_fan_div_offset(5);
 
 #define show_temp1_reg(reg) \
 static ssize_t \
-show_##reg(struct device *dev, char *buf) \
+show_##reg(struct device *dev, struct device_attribute *attr, \
+	   char *buf) \
 { \
 	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
 	return sprintf(buf, "%d\n", temp1_from_reg(data->reg)); \
@@ -547,7 +551,8 @@ show_temp1_reg(temp1_max_hyst);
 
 #define store_temp1_reg(REG, reg) \
 static ssize_t \
-store_temp1_##reg(struct device *dev, const char *buf, size_t count) \
+store_temp1_##reg(struct device *dev, struct device_attribute *attr, \
+		  const char *buf, size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct w83627ehf_data *data = i2c_get_clientdata(client); \
@@ -601,7 +606,8 @@ store_temp_reg(HYST, temp_max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
-show_reg_temp##offset (struct device *dev, char *buf) \
+show_reg_temp##offset (struct device *dev, struct device_attribute *attr, \
+		       char *buf) \
 { \
 	return show_temp(dev, buf, offset - 2); \
 } \
@@ -610,13 +616,14 @@ static DEVICE_ATTR(temp##offset##_input,
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t \
-show_reg_temp##offset##_##reg(struct device *dev, char *buf) \
+show_reg_temp##offset##_##reg(struct device *dev, struct device_attribute *attr, \
+			      char *buf) \
 { \
 	return show_temp_##reg(dev, buf, offset - 2); \
 } \
 static ssize_t \
-store_reg_temp##offset##_##reg(struct device *dev, const char *buf, \
-			       size_t count) \
+store_reg_temp##offset##_##reg(struct device *dev, struct device_attribute *attr, \
+			       const char *buf, size_t count) \
 { \
 	return store_temp_##reg(dev, buf, count, offset - 2); \
 } \

