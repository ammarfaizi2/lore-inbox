Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUDNWoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUDNWnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:43:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:52383 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261918AbUDNWZP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:15 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <1081981449409@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:10 -0700
Message-Id: <10819814504116@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.6, 2004/03/26 13:53:01-08:00, khali@linux-fr.org

[PATCH] I2C: Setting w83627hf fan_div preserves fan_min

Here is a patch that updates the w83627hf driver in the exact same way I
did recently for the w83781d driver. There were two problems:
1* Fan divisor storing code was ugly, badly ripped from the 2.4 w83627hf
   driver and/or the 2.6 w83781d driver.
2* Setting fan divisors wouldn't preserve fan mins.

Exactly the same as w83781d:
http://archives.andrew.net.au/lm-sensors/msg06952.html
http://archives.andrew.net.au/lm-sensors/msg07008.html

No surprise since the w83627hf driver is a fork of the w83781d driver.

Since the two drivers are strongly similar, I took the code directly
from the updated w83781d driver. I cannot test the w83627hf driver
(testers welcome BTW) but this makes me feel confident that the code is
correct.

To make it clear, this single patch is the w83627f equivalent of the
three patches I submitted for the w83781d:
* Cleanup
* Refactoring
* Setting fan_div preserves fan_min
All in one (much better looking BTW).


 drivers/i2c/chips/w83627hf.c |   54 ++++++++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 23 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Wed Apr 14 15:14:33 2004
+++ b/drivers/i2c/chips/w83627hf.c	Wed Apr 14 15:14:33 2004
@@ -659,34 +659,37 @@
 		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
 }
 
+/* Note: we save and restore the fan minimum here, because its value is
+   determined in part by the fan divisor.  This follows the principle of
+   least suprise; the user doesn't expect the fan minimum to change just
+   because the divisor changed. */
 static ssize_t
 store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83627hf_data *data = i2c_get_clientdata(client);
-	u32 val, old, old2, old3 = 0;
+	unsigned long min;
+	u8 reg;
 
-	val = simple_strtoul(buf, NULL, 10);
-	old = w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
-	old3 = w83627hf_read_value(client, W83781D_REG_VBAT);
-	data->fan_div[nr - 1] = DIV_TO_REG(val);
-
-	if (nr >= 3 && data->type != w83697hf) {
-		old2 = w83627hf_read_value(client, W83781D_REG_PIN);
-		old2 = (old2 & 0x3f) | ((data->fan_div[2] & 0x03) << 6);
-		w83627hf_write_value(client, W83781D_REG_PIN, old2);
-		old3 = (old3 & 0x7f) | ((data->fan_div[2] & 0x04) << 5);
-	}
-	if (nr >= 2) {
-		old = (old & 0x3f) | ((data->fan_div[1] & 0x03) << 6);
-		old3 = (old3 & 0xbf) | ((data->fan_div[1] & 0x04) << 4);
-	}
-	if (nr >= 1) {
-		old = (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);
-		w83627hf_write_value(client, W83781D_REG_VID_FANDIV, old);
-		old3 = (old3 & 0xdf) | ((data->fan_div[0] & 0x04) << 3);
-		w83627hf_write_value(client, W83781D_REG_VBAT, old3);
-	}
+	/* Save fan_min */
+	min = FAN_FROM_REG(data->fan_min[nr],
+			   DIV_FROM_REG(data->fan_div[nr]));
+
+	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+
+	reg = (w83627hf_read_value(client, nr==2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
+	       & (nr==0 ? 0xcf : 0x3f))
+	    | ((data->fan_div[nr] & 0x03) << (nr==0 ? 4 : 6));
+	w83627hf_write_value(client, nr==2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
+
+	reg = (w83627hf_read_value(client, W83781D_REG_VBAT)
+	       & ~(1 << (5 + nr)))
+	    | ((data->fan_div[nr] & 0x04) << (3 + nr));
+	w83627hf_write_value(client, W83781D_REG_VBAT, reg);
+
+	/* Restore fan_min */
+	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
 	return count;
 }
@@ -700,7 +703,7 @@
 store_regs_fan_div_##offset (struct device *dev, \
 			    const char *buf, size_t count) \
 { \
-	return store_fan_div_reg(dev, buf, count, offset); \
+	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
 		  show_regs_fan_div_##offset, store_regs_fan_div_##offset)
@@ -981,6 +984,11 @@
 
 	/* Initialize the chip */
 	w83627hf_init_client(new_client);
+
+	/* A few vars need to be filled upon startup */
+	data->fan_min[0] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(1));
+	data->fan_min[1] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(2));
+	data->fan_min[2] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(3));
 
 	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);

