Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWIGXqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWIGXqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWIGXqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:46:18 -0400
Received: from god.demon.nl ([83.160.164.11]:24473 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S1751876AbWIGXqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:46:17 -0400
Date: Fri, 8 Sep 2006 01:46:14 +0200
From: Henk Vergonet <Henk.Vergonet@gmail.com>
To: gregkh@suse.de, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix unload oops and memory leak in yealink driver
Message-ID: <20060907234614.GA31195@god.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I hope we can schedule this for inclusion in 2.6.18 as many users have
reported problems with kernel oops-en while unloading the driver.

(tested on 2.6.18-rc6)

Description:

This patch fixes a memory leak and a kernel oops when trying to unload
the driver, due to an unbalanced cleanup.
Thanks Ivar Jensen for spotting my mistake.

Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="yealink.c.patch"

--- linux-2.6.18-rc6/drivers/usb/input/yealink.c.orig	2006-09-07 23:49:18.000000000 +0200
+++ linux-2.6.18-rc6/drivers/usb/input/yealink.c	2006-09-08 00:14:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * drivers/usb/input/yealink.c
  *
- * Copyright (c) 2005 Henk Vergonet <Henk.Vergonet@gmail.com>
+ * Copyright (c) 2005,2006 Henk Vergonet <Henk.Vergonet@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -44,11 +44,11 @@
  *   20050701 henk	sysfs write serialisation, fix potential unload races
  *   20050801 henk	Added ringtone, restructure USB
  *   20050816 henk	Merge 2.6.13-rc6
+ *   20060830 henk	Proper urb cleanup cycle, thanks Ivan Jensen for
+ *			pointing this out.
  */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
 #include <linux/usb/input.h>
@@ -56,7 +56,7 @@
 #include "map_to_7segment.h"
 #include "yealink.h"
 
-#define DRIVER_VERSION "yld-20051230"
+#define DRIVER_VERSION "L20060906"
 #define DRIVER_AUTHOR "Henk Vergonet"
 #define DRIVER_DESC "Yealink phone driver"
 
@@ -197,8 +197,8 @@ static int setChar(struct yealink_dev *y
  *       7      8      9
  *       *      0      #
  *
- * The "up" and "down" keys, are symbolised by arrows on the button.
- * The "pickup" and "hangup" keys are symbolised by a green and red phone
+ * The "up" and "down" keys, are symbolized by arrows on the button.
+ * The "pickup" and "hangup" keys are symbolized by a green and red phone
  * on the button.
  */
 static int map_p1k_to_key(int scancode)
@@ -410,7 +410,7 @@ send_update:
 
 /* Decide on how to handle responses
  *
- * The state transition diagram is somethhing like:
+ * The state transition diagram is something like:
  *
  *          syncState<--+
  *               |      |
@@ -810,12 +810,9 @@ static int usb_cleanup(struct yealink_de
 	if (yld == NULL)
 		return err;
 
-        if (yld->urb_irq) {
-		usb_kill_urb(yld->urb_irq);
-		usb_free_urb(yld->urb_irq);
-	}
-        if (yld->urb_ctl)
-		usb_free_urb(yld->urb_ctl);
+	usb_kill_urb(yld->urb_irq);	/* parameter validation in core/urb */
+	usb_kill_urb(yld->urb_ctl);	/* parameter validation in core/urb */
+
         if (yld->idev) {
 		if (err)
 			input_free_device(yld->idev);
@@ -831,6 +828,9 @@ static int usb_cleanup(struct yealink_de
 	if (yld->irq_data)
 		usb_buffer_free(yld->udev, USB_PKT_LEN,
 				yld->irq_data, yld->irq_dma);
+
+	usb_free_urb(yld->urb_irq);	/* parameter validation in core/urb */
+	usb_free_urb(yld->urb_ctl);	/* parameter validation in core/urb */
 	kfree(yld);
 	return err;
 }

--RnlQjJ0d97Da+TV1--
