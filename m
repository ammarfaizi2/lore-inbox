Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264537AbUENX4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUENX4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUENXyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:54:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:25317 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264537AbUENX37 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:59 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <1084577357292@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:17 -0700
Message-Id: <1084577357958@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.8, 2004/05/05 15:34:00-07:00, khali@linux-fr.org

[PATCH] I2C: Invert as99127f beep bits in kernel space

The following patch changes the way we invert beep bits for the AS99127F
sensor chip. This chip behaves differently from the other chips in that
a disabled bit is 1, not 0. So far we didn't handle that specificity in
the w83781d driver, so it was left to user-space applications to handle
it. For the sake of uniformity, it's obviously better if it's done in
the driver instead (although the meaning of each bit is still
chip-dependant).

I already did a similar change to the 2.4 driver and the sensors
program. I don't think that many user-space application will be
affected, since most of them don't handle the beep mask as far as I can
tell.

This also close Debian bug #209299:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=209299

Successfully tested on my AS99127F rev.1 chip. Aurelien Jarno also
checked that there were no regression on non-Asus chips.


 drivers/i2c/chips/w83781d.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Fri May 14 16:20:26 2004
+++ b/drivers/i2c/chips/w83781d.c	Fri May 14 16:20:26 2004
@@ -183,8 +183,10 @@
 #define ALARMS_FROM_REG(val)		(val)
 #define PWM_FROM_REG(val)		(val)
 #define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
-#define BEEP_MASK_FROM_REG(val)		(val)
-#define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
+#define BEEP_MASK_FROM_REG(val,type)	((type) == as99127f ? \
+					 (val) ^ 0x7fff : (val))
+#define BEEP_MASK_TO_REG(val,type)	((type) == as99127f ? \
+					 (~(val)) & 0x7fff : (val) & 0xffffff)
 
 #define BEEP_ENABLE_TO_REG(val)		((val) ? 1 : 0)
 #define BEEP_ENABLE_FROM_REG(val)	((val) ? 1 : 0)
@@ -539,14 +541,18 @@
 DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
 #define device_create_file_alarms(client) \
 device_create_file(&client->dev, &dev_attr_alarms);
-#define show_beep_reg(REG, reg) \
-static ssize_t show_beep_##reg (struct device *dev, char *buf) \
-{ \
-	struct w83781d_data *data = w83781d_update_device(dev); \
-	return sprintf(buf,"%ld\n", (long)BEEP_##REG##_FROM_REG(data->beep_##reg)); \
+static ssize_t show_beep_mask (struct device *dev, char *buf)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	return sprintf(buf, "%ld\n",
+		       (long)BEEP_MASK_FROM_REG(data->beep_mask, data->type));
+}
+static ssize_t show_beep_enable (struct device *dev, char *buf)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	return sprintf(buf, "%ld\n",
+		       (long)BEEP_ENABLE_FROM_REG(data->beep_enable));
 }
-show_beep_reg(ENABLE, enable);
-show_beep_reg(MASK, mask);
 
 #define BEEP_ENABLE			0	/* Store beep_enable */
 #define BEEP_MASK			1	/* Store beep_mask */
@@ -562,7 +568,7 @@
 	val = simple_strtoul(buf, NULL, 10);
 
 	if (update_mask == BEEP_MASK) {	/* We are storing beep_mask */
-		data->beep_mask = BEEP_MASK_TO_REG(val);
+		data->beep_mask = BEEP_MASK_TO_REG(val, data->type);
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
 				    data->beep_mask & 0xff);
 

