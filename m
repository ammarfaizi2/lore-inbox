Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUCPBiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbUCPB1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:27:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:34735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262910AbUCPACm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:42 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <1079391394926@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:35 -0800
Message-Id: <10793913953583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.16, 2004/03/15 13:09:19-08:00, khali@linux-fr.org

[PATCH] I2C: Setting w83781d fan_div preserves fan_min

This patch makes the w83781d driver preserve fan_min settings when the
user changes fan_divs. This isn't done "by default" because the actual
fan min value (in RPMs) depends on both the fan_min register and the
fan_div register. Only two drivers handle it properly at the moment as
far as I know (lm78 and asb100). Several other drivers would need to be
fixed the same way, but well, once at a time ;)

Tested on my AS99127F rev.1.

Credits go to Philip Pokorny, since I think I remember he is the one who
introduced the method in the lm78 driver in the first place.

This tends to increase the size of the three set_store_regs_fan_div
functions, and I am considering refactoring them at some point. Later
though.


 drivers/i2c/chips/w83781d.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:33:59 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:33:59 2004
@@ -615,12 +615,21 @@
 		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
 }
 
+/* Note: we save and restore the fan minimum here, because its value is
+   determined in part by the fan divisor.  This follows the principle of
+   least suprise; the user doesn't expect the fan minimum to change just
+   because the divisor changed. */
 static ssize_t
 store_regs_fan_div_1(struct device *dev, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 reg;
+	unsigned long min;
+	u8 reg;
+
+	/* Save fan_min */
+	min = FAN_FROM_REG(data->fan_min[0],
+			   DIV_FROM_REG(data->fan_div[0]));
 
 	data->fan_div[0] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
 				      data->type);
@@ -636,6 +645,10 @@
 		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
 
+	/* Restore fan_min */
+	data->fan_min[0] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[0]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(1), data->fan_min[0]);
+
 	return count;
 }
 
@@ -644,7 +657,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 reg;
+	unsigned long min;
+	u8 reg;
+
+	/* Save fan_min */
+	min = FAN_FROM_REG(data->fan_min[1],
+			   DIV_FROM_REG(data->fan_div[1]));
 
 	data->fan_div[1] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
 				      data->type);
@@ -660,6 +678,10 @@
 		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
 
+	/* Restore fan_min */
+	data->fan_min[1] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[1]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(2), data->fan_min[1]);
+
 	return count;
 }
 
@@ -668,7 +690,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 reg;
+	unsigned long min;
+	u8 reg;
+
+	/* Save fan_min */
+	min = FAN_FROM_REG(data->fan_min[2],
+			   DIV_FROM_REG(data->fan_div[2]));
 
 	data->fan_div[2] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
 				      data->type);
@@ -683,6 +710,10 @@
 		reg |= (data->fan_div[2] & 0x04) << 5;
 		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
+
+	/* Restore fan_min */
+	data->fan_min[2] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[2]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(3), data->fan_min[2]);
 
 	return count;
 }

