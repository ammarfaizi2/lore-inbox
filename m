Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270211AbUJTBz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270211AbUJTBz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270216AbUJTAtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:49:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:5300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266896AbUJTAT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:29 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315043782@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:24 -0700
Message-Id: <10982315044129@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.73.6, 2004/09/08 12:36:05-07:00, khali@linux-fr.org

[PATCH] I2C: Fix macro calls in chip drivers

I noticed that some I2C chip drivers (all written or reviewed by me, I
feel ashamed to say) misuse macros. Passing function calls
(simple_strtol in this case) to macros evaluating their argument up to 4
times is certainly not wise and obviously performs poorly. It is not
critical in that it happens only when writing to the chips (setting
limits), which doesn't happen that often. However I'd say it's worth
fixing.

Thus, the patch below fixes that, by moving the function calls outside
of the macro calls.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1025.c |   14 ++++++++------
 drivers/i2c/chips/gl518sm.c |    6 ++++--
 drivers/i2c/chips/lm80.c    |    5 +++--
 drivers/i2c/chips/lm83.c    |    3 ++-
 drivers/i2c/chips/lm90.c    |    6 ++++--
 drivers/i2c/chips/max1619.c |    3 ++-
 6 files changed, 23 insertions(+), 14 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c	2004-10-19 16:55:37 -07:00
+++ b/drivers/i2c/chips/adm1025.c	2004-10-19 16:55:37 -07:00
@@ -212,8 +212,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
-	data->in_min[offset] = IN_TO_REG(simple_strtol(buf, NULL, 10), \
-			       in_scale[offset]); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->in_min[offset] = IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MIN(offset), \
 				  data->in_min[offset]); \
 	return count; \
@@ -223,8 +223,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
-	data->in_max[offset] = IN_TO_REG(simple_strtol(buf, NULL, 10), \
-			       in_scale[offset]); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->in_max[offset] = IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MAX(offset), \
 				  data->in_max[offset]); \
 	return count; \
@@ -246,7 +246,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
-	data->temp_min[offset-1] = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->temp_min[offset-1] = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_LOW(offset-1), \
 				  data->temp_min[offset-1]); \
 	return count; \
@@ -256,7 +257,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
-	data->temp_max[offset-1] = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->temp_max[offset-1] = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_HIGH(offset-1), \
 				  data->temp_max[offset-1]); \
 	return count; \
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	2004-10-19 16:55:37 -07:00
+++ b/drivers/i2c/chips/gl518sm.c	2004-10-19 16:55:37 -07:00
@@ -217,7 +217,8 @@
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
-	data->value = type##_TO_REG(simple_strtol(buf, NULL, 10));	\
+	long val = simple_strtol(buf, NULL, 10);			\
+	data->value = type##_TO_REG(val);				\
 	gl518_write_value(client, reg, data->value);			\
 	return count;							\
 }
@@ -229,7 +230,8 @@
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
 	int regvalue = gl518_read_value(client, reg);			\
-	data->value = type##_TO_REG(simple_strtoul(buf, NULL, 10));	\
+	unsigned long val = simple_strtoul(buf, NULL, 10);		\
+	data->value = type##_TO_REG(val);				\
 	regvalue = (regvalue & ~mask) | (data->value << shift);		\
 	gl518_write_value(client, reg, regvalue);			\
 	return count;							\
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	2004-10-19 16:55:37 -07:00
+++ b/drivers/i2c/chips/lm80.c	2004-10-19 16:55:37 -07:00
@@ -262,14 +262,15 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
-	unsigned long min;
+	unsigned long min, val;
 	u8 reg;
 
 	/* Save fan_min */
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
-	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+	val = simple_strtoul(buf, NULL, 10);
+	data->fan_div[nr] = DIV_TO_REG(val);
 
 	reg = (lm80_read_value(client, LM80_REG_FANDIV) & ~(3 << (2 * (nr + 1))))
 	    | (data->fan_div[nr] << (2 * (nr + 1)));
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2004-10-19 16:55:37 -07:00
+++ b/drivers/i2c/chips/lm83.c	2004-10-19 16:55:37 -07:00
@@ -180,7 +180,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm83_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2004-10-19 16:55:37 -07:00
+++ b/drivers/i2c/chips/lm90.c	2004-10-19 16:55:37 -07:00
@@ -214,7 +214,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP1_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->value = TEMP1_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }
@@ -224,7 +225,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP2_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->value = TEMP2_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
 	return count; \
diff -Nru a/drivers/i2c/chips/max1619.c b/drivers/i2c/chips/max1619.c
--- a/drivers/i2c/chips/max1619.c	2004-10-19 16:55:37 -07:00
+++ b/drivers/i2c/chips/max1619.c	2004-10-19 16:55:37 -07:00
@@ -145,7 +145,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct max1619_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }

