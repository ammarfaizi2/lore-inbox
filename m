Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVAHJFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVAHJFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVAHIsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:48:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:56453 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261886AbVAHFs2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:28 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627732076@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:33 -0800
Message-Id: <11051627731563@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.46, 2005/01/06 13:54:52-08:00, khali@linux-fr.org

[PATCH] I2C: Improve VID code for the W83627THF

This patch cleans up and improves the VID pins value retrieval for the
W83627THF chip in the w83627hf driver. Tested successfully by Mark
Hoffman. The previous code was using an unrelated lock and reading
register values it didn't need. The new code supports 6-bit VID values
(as defined by Intel VRM 10), and also ensures that the GPIO pins are
possibly used as VID inputs.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83627hf.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2005-01-07 14:54:41 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2005-01-07 14:54:41 -08:00
@@ -90,9 +90,9 @@
 
 #define	DEVID	0x20	/* Register: Device ID */
 
+#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
 #define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
 #define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
-#define W83627THF_GPIO5_INVR	0xf5 /* w83627thf only */
 
 static inline void
 superio_outb(int reg, int val)
@@ -1190,16 +1190,31 @@
 
 static int w83627thf_read_gpio5(struct i2c_client *client)
 {
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-	int res, inv;
+	int res = 0xff, sel;
 
-	down(&data->lock);
 	superio_enter();
 	superio_select(W83627HF_LD_GPIO5);
-	res = superio_inb(W83627THF_GPIO5_DR);
-	inv = superio_inb(W83627THF_GPIO5_INVR);
+
+	/* Make sure these GPIO pins are enabled */
+	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
+		dev_dbg(&client->dev, "GPIO5 disabled, no VID function\n");
+		goto exit;
+	}
+
+	/* Make sure the pins are configured for input
+	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
+	sel = superio_inb(W83627THF_GPIO5_IOSR);
+	if ((sel & 0x1f) != 0x1f) {
+		dev_dbg(&client->dev, "GPIO5 not configured for VID "
+			"function\n");
+		goto exit;
+	}
+
+	dev_info(&client->dev, "Reading VID from GPIO5\n");
+	res = superio_inb(W83627THF_GPIO5_DR) & sel;
+
+exit:
 	superio_exit();
-	up(&data->lock);
 	return res;
 }
 
@@ -1272,7 +1287,7 @@
 		int hi = w83627hf_read_value(client, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
 	} else if (w83627thf == data->type) {
-		data->vid = w83627thf_read_gpio5(client) & 0x1f;
+		data->vid = w83627thf_read_gpio5(client) & 0x3f;
 	}
 
 	/* Read VRM & OVT Config only once */

