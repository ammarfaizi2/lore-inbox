Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTLLO6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbTLLO56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:57:58 -0500
Received: from mail.dietlibc.org ([212.84.236.4]:40849 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265223AbTLLO4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:56:54 -0500
Date: Fri, 12 Dec 2003 15:56:52 +0100
From: Johannes Stezenbach <js@convergence.de>
To: sensors@stimpy.netroedge.com
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: 2.6.0-test11: i2c-dev.h for userspace
Message-ID: <20031212145652.GA30747@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	sensors@stimpy.netroedge.com, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had some trouble compiling a userspace application
which uses the I2C device interface (the DirectFB
Matrox driver). Apparently some stuff has been removed
from i2c-dev.h, and Documentation/i2c/dev-interface is
out of date. I'm using Debian unstable (where glibc is
built with kernel 2.6 headers).

The patch below puts back some "#if __KERNEL__" conditionals
so i2c.h can be included without errors in userspace progams.

Regards,
Johannes



--- linux-2.6.0-test11-bk8/include/linux/i2c.h.orig	2003-12-12 15:19:12.000000000 +0100
+++ linux-2.6.0-test11-bk8/include/linux/i2c.h	2003-12-12 15:19:37.000000000 +0100
@@ -28,21 +28,26 @@
 #ifndef _LINUX_I2C_H
 #define _LINUX_I2C_H
 
+#ifdef __KERNEL__
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
 #include <asm/semaphore.h>
+#endif
+#include <linux/types.h>
+#include <linux/i2c-id.h>
 
 /* --- General options ------------------------------------------------	*/
 
 struct i2c_msg;
+union i2c_smbus_data;
+
+#ifdef __KERNEL__
+
 struct i2c_algorithm;
 struct i2c_adapter;
 struct i2c_client;
 struct i2c_driver;
 struct i2c_client_address_data;
-union i2c_smbus_data;
 
 /*
  * The master routines are the ones normally used to transmit data to devices
@@ -384,6 +389,7 @@
 
 /* Return 1 if adapter supports everything we need, 0 if not. */
 extern int i2c_check_functionality (struct i2c_adapter *adap, u32 func);
+#endif /* #if __KERNEL__ */
 
 /*
  * I2C Message - used for pure i2c transaction, also from /dev interface
@@ -530,6 +536,8 @@
 				/* written byte (except address)	*/
 #define I2C_MDELAY	0x0706	/* millisec delay between written bytes */
 
+
+#ifdef __KERNEL__
 /* ----- I2C-DEV: char device interface stuff ------------------------- */
 
 #define I2C_MAJOR	89		/* Device major number		*/
@@ -605,5 +613,6 @@
 	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(timeout);
 }
+#endif /* #if __KERNEL__ */
 
 #endif /* _LINUX_I2C_H */
--- linux-2.6.0-test11-bk8/include/linux/i2c-dev.h.orig	2003-12-12 15:19:17.000000000 +0100
+++ linux-2.6.0-test11-bk8/include/linux/i2c-dev.h	2003-12-12 15:19:37.000000000 +0100
@@ -25,6 +25,7 @@
 #define _LINUX_I2C_DEV_H
 
 #include <linux/types.h>
+#include <linux/compiler.h>
 
 /* Some IOCTL commands are defined in <linux/i2c.h> */
 /* Note: 10-bit addresses are NOT supported! */
