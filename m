Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUDNX3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUDNW0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:26:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:44447 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261979AbUDNWZE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:04 -0400
Subject: [PATCH] I2C update for 2.6.5
In-Reply-To: <20040414222215.GA26225@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:09 -0700
Message-Id: <10819814493235@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.1, 2004/03/19 13:24:14-08:00, khali@linux-fr.org

[PATCH] I2C: w83781d fan_div code refactoring

Quoting myself:

> This tends to increase the size of the three set_store_regs_fan_div
> functions, and I am considering refactoring them at some point. Later
> though.

Here is the promised refactoring. Tested on my AS99127F rev.1, seems to
work. As for the previous patch, there is a part that I cannot test with
the AS99127F, so additional testing is welcome.

I agree this makes the code slightly less readable, but this saves 60
lines of code (1754 bytes, around 3% of the driver total), and is
actually far less complex that I first feared.


 drivers/i2c/chips/w83781d.c |   94 +++++++-------------------------------------
 1 files changed, 17 insertions(+), 77 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Apr 14 15:15:00 2004
+++ b/drivers/i2c/chips/w83781d.c	Wed Apr 14 15:15:00 2004
@@ -620,7 +620,7 @@
    least suprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
-store_regs_fan_div_1(struct device *dev, const char *buf, size_t count)
+store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
@@ -628,92 +628,28 @@
 	u8 reg;
 
 	/* Save fan_min */
-	min = FAN_FROM_REG(data->fan_min[0],
-			   DIV_FROM_REG(data->fan_div[0]));
+	min = FAN_FROM_REG(data->fan_min[nr],
+			   DIV_FROM_REG(data->fan_div[nr]));
 
-	data->fan_div[0] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
+	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
 				      data->type);
 
-	reg = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0xcf;
-	reg |= (data->fan_div[0] & 0x03) << 4;
-	w83781d_write_value(client, W83781D_REG_VID_FANDIV, reg);
+	reg = (w83781d_read_value(client, nr==2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
+	       & (nr==0 ? 0xcf : 0x3f))
+	    | ((data->fan_div[nr] & 0x03) << (nr==0 ? 4 : 6));
+	w83781d_write_value(client, nr==2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
 
 	/* w83781d and as99127f don't have extended divisor bits */
 	if (data->type != w83781d && data->type != as99127f) {
-		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0xdf;
-		reg |= (data->fan_div[0] & 0x04) << 3;
+		reg = (w83781d_read_value(client, W83781D_REG_VBAT)
+		       & ~(1 << (5 + nr)))
+		    | ((data->fan_div[nr] & 0x04) << (3 + nr));
 		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
 
 	/* Restore fan_min */
-	data->fan_min[0] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[0]));
-	w83781d_write_value(client, W83781D_REG_FAN_MIN(1), data->fan_min[0]);
-
-	return count;
-}
-
-static ssize_t
-store_regs_fan_div_2(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-	unsigned long min;
-	u8 reg;
-
-	/* Save fan_min */
-	min = FAN_FROM_REG(data->fan_min[1],
-			   DIV_FROM_REG(data->fan_div[1]));
-
-	data->fan_div[1] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
-				      data->type);
-
-	reg = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x3f;
-	reg |= (data->fan_div[1] & 0x03) << 6;
-	w83781d_write_value(client, W83781D_REG_VID_FANDIV, reg);
-
-	/* w83781d and as99127f don't have extended divisor bits */
-	if (data->type != w83781d && data->type != as99127f) {
-		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0xbf;
-		reg |= (data->fan_div[1] & 0x04) << 4;
-		w83781d_write_value(client, W83781D_REG_VBAT, reg);
-	}
-
-	/* Restore fan_min */
-	data->fan_min[1] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[1]));
-	w83781d_write_value(client, W83781D_REG_FAN_MIN(2), data->fan_min[1]);
-
-	return count;
-}
-
-static ssize_t
-store_regs_fan_div_3(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-	unsigned long min;
-	u8 reg;
-
-	/* Save fan_min */
-	min = FAN_FROM_REG(data->fan_min[2],
-			   DIV_FROM_REG(data->fan_div[2]));
-
-	data->fan_div[2] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
-				      data->type);
-
-	reg = w83781d_read_value(client, W83781D_REG_PIN) & 0x3f;
-	reg |= (data->fan_div[2] & 0x03) << 6;
-	w83781d_write_value(client, W83781D_REG_PIN, reg);
-
-	/* w83781d and as99127f don't have extended divisor bits */
-	if (data->type != w83781d && data->type != as99127f) {
-		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0x7f;
-		reg |= (data->fan_div[2] & 0x04) << 5;
-		w83781d_write_value(client, W83781D_REG_VBAT, reg);
-	}
-
-	/* Restore fan_min */
-	data->fan_min[2] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[2]));
-	w83781d_write_value(client, W83781D_REG_FAN_MIN(3), data->fan_min[2]);
+	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
 	return count;
 }
@@ -722,6 +658,10 @@
 static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
 { \
 	return show_fan_div_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_fan_div_##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset)
 

