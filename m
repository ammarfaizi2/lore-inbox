Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVCaXu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVCaXu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVCaXuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:50:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:43744 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262522AbVCaXYN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:13 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: i2c-s3c2410 functionality and fixes
In-Reply-To: <11123113953775@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:15 -0800
Message-Id: <11123113952683@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2346, 2005/03/31 14:31:40-08:00, khali@linux-fr.org

[PATCH] I2C: i2c-s3c2410 functionality and fixes

This patch does the following updates to the i2c-s3c2410 bus driver:

* Properly report the i2c functionality by adding to the
  `.functionality` field of the adapter

* Change the dev_err() call on no-ack to an dev_dbg() to make
  it less noisy when the bus is being probed by i2cdetect, etc.

* Add I2C_M_REV_DIR_ADDR to fully implement the
  I2C_FUNC_PROTOCOLO_MANGLING.

* Ensure that the adapter owner field is set to THIS_MODULE

Please apply, thanks.

(Once this is applied, all i2c bus drivers will be properly reporting
their functionality so I'll be able to go on with the i2c functionality
core cleanups.)

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-s3c2410.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c	2005-03-31 15:16:24 -08:00
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2005-03-31 15:16:24 -08:00
@@ -1,6 +1,6 @@
 /* linux/drivers/i2c/busses/i2c-s3c2410.c
  *
- * Copyright (C) 2004 Simtec Electronics
+ * Copyright (C) 2004,2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C2410 I2C Controller
@@ -188,6 +188,9 @@
 	} else
 		stat |= S3C2410_IICSTAT_MASTER_TX;
 
+	if (msg->flags & I2C_M_REV_DIR_ADDR)
+		addr ^= 1;
+
 	// todo - check for wether ack wanted or not
 	s3c24xx_i2c_enable_ack(i2c);
 
@@ -287,7 +290,7 @@
 		    !(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
 			/* ack was not received... */
 
-			dev_err(i2c->dev, "ack was not received\n" );
+			dev_dbg(i2c->dev, "ack was not received\n");
 			s3c24xx_i2c_stop(i2c, -EREMOTEIO);
 			goto out_ack;
 		}
@@ -555,11 +558,18 @@
 	return -EREMOTEIO;
 }
 
+/* declare our i2c functionality */
+static u32 s3c24xx_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
+}
+
 /* i2c bus registration info */
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.name			= "S3C2410-I2C-Algorithm",
 	.master_xfer		= s3c24xx_i2c_xfer,
+	.functionality		= s3c24xx_i2c_func,
 };
 
 static struct s3c24xx_i2c s3c24xx_i2c = {
@@ -567,6 +577,7 @@
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
 	.adap	= {
 		.name			= "s3c2410-i2c",
+		.owner			= THIS_MODULE,
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
 		.class			= I2C_CLASS_HWMON,

