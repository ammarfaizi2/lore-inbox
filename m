Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbUCPARk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUCPAQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:16:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:19375 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262893AbUCPACT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:19 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913943831@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:34 -0800
Message-Id: <1079391394320@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.8, 2004/03/10 14:34:17-08:00, khali@linux-fr.org

[PATCH] I2C: Cleanup fan_div in w83781d

Here is a proposed patch that cleanups the fan_div code from w83781d.
The original code was obviously taken from the 2.4 driver, but the way
things were done in 2.4 do not make any sense anymore (because we now
have a single value per interface file).

Since fan divisor bits are spread over three different regs with various
bitmask manipulations, I don't think it makes much sense to have a
single function as we do in most other cases. Having three different
functions makes more sense, although they are of course similar. The
size increment is only 581 bytes, I don't think its a problem since it
also makes the code much more efficient and readable too IMHO.

I agree that the original code was working - it was simply doing far too
much work each time one would want to change a fan divisor.

Originally, I took a look at the code because I wanted to fix the fact
that changing fan divisors breaks fan mins. But it looked like a good
cleanup before doing that was required. Once this patch will have been
accepted, I'll work on the other one.

I've tested my patch successfully on a W83781D and an AS99127F rev.1.
Note that this means that one part of the code wasn't tested, because
these are the two chips of the family that do not support divisors
greater than 8. If anyone can test it, please do.


 drivers/i2c/chips/w83781d.c |   91 +++++++++++++++++++++++++++-----------------
 1 files changed, 56 insertions(+), 35 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:34:38 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:34:38 2004
@@ -639,7 +639,6 @@
 device_create_file(&client->dev, &dev_attr_beep_mask); \
 } while (0)
 
-/* w83697hf only has two fans */
 static ssize_t
 show_fan_div_reg(struct device *dev, char *buf, int nr)
 {
@@ -652,47 +651,73 @@
 		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
 }
 
-/* w83697hf only has two fans */
 static ssize_t
-store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
+store_regs_fan_div_1(struct device *dev, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 val, old, old2, old3 = 0;
+	u32 reg;
 
-	val = simple_strtoul(buf, NULL, 10);
-	old = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
+	data->fan_div[0] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
+				      data->type);
 
-	data->fan_div[nr - 1] = DIV_TO_REG(val, data->type);
+	reg = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0xcf;
+	reg |= (data->fan_div[0] & 0x03) << 4;
+	w83781d_write_value(client, W83781D_REG_VID_FANDIV, reg);
 
 	/* w83781d and as99127f don't have extended divisor bits */
-	if ((data->type != w83781d) && data->type != as99127f) {
-		old3 = w83781d_read_value(client, W83781D_REG_VBAT);
+	if (data->type != w83781d && data->type != as99127f) {
+		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0xdf;
+		reg |= (data->fan_div[0] & 0x04) << 3;
+		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
-	if (nr >= 3 && data->type != w83697hf) {
-		old2 = w83781d_read_value(client, W83781D_REG_PIN);
-		old2 = (old2 & 0x3f) | ((data->fan_div[2] & 0x03) << 6);
-		w83781d_write_value(client, W83781D_REG_PIN, old2);
-
-		if ((data->type != w83781d) && (data->type != as99127f)) {
-			old3 = (old3 & 0x7f) | ((data->fan_div[2] & 0x04) << 5);
-		}
-	}
-	if (nr >= 2) {
-		old = (old & 0x3f) | ((data->fan_div[1] & 0x03) << 6);
 
-		if ((data->type != w83781d) && (data->type != as99127f)) {
-			old3 = (old3 & 0xbf) | ((data->fan_div[1] & 0x04) << 4);
-		}
+	return count;
+}
+
+static ssize_t
+store_regs_fan_div_2(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 reg;
+
+	data->fan_div[1] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
+				      data->type);
+
+	reg = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x3f;
+	reg |= (data->fan_div[1] & 0x03) << 6;
+	w83781d_write_value(client, W83781D_REG_VID_FANDIV, reg);
+
+	/* w83781d and as99127f don't have extended divisor bits */
+	if (data->type != w83781d && data->type != as99127f) {
+		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0xbf;
+		reg |= (data->fan_div[1] & 0x04) << 4;
+		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
-	if (nr >= 1) {
-		old = (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);
-		w83781d_write_value(client, W83781D_REG_VID_FANDIV, old);
-
-		if ((data->type != w83781d) && (data->type != as99127f)) {
-			old3 = (old3 & 0xdf) | ((data->fan_div[0] & 0x04) << 3);
-			w83781d_write_value(client, W83781D_REG_VBAT, old3);
-		}
+
+	return count;
+}
+
+static ssize_t
+store_regs_fan_div_3(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 reg;
+
+	data->fan_div[2] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
+				      data->type);
+
+	reg = w83781d_read_value(client, W83781D_REG_PIN) & 0x3f;
+	reg |= (data->fan_div[2] & 0x03) << 6;
+	w83781d_write_value(client, W83781D_REG_PIN, reg);
+
+	/* w83781d and as99127f don't have extended divisor bits */
+	if (data->type != w83781d && data->type != as99127f) {
+		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0x7f;
+		reg |= (data->fan_div[2] & 0x04) << 5;
+		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
 
 	return count;
@@ -702,10 +727,6 @@
 static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
 { \
 	return show_fan_div_reg(dev, buf, offset); \
-} \
-static ssize_t store_regs_fan_div_##offset (struct device *dev, const char *buf, size_t count) \
-{ \
-	return store_fan_div_reg(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset)
 

