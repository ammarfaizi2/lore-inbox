Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVFKHuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVFKHuA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVFKHuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:50:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:63427 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261638AbVFKHsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:38 -0400
Subject: [PATCH] Last little devfs cleanups throughout the kernel tree.
In-Reply-To: <1118476112352@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:33 -0700
Message-Id: <111847611361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just removes a few unused #defines and fixes some comments due to
devfs now being gone.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/block/viodasd.c                           |    1 -
 drivers/cdrom/viocd.c                             |    1 -
 drivers/md/dm.c                                   |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   11 -----------
 drivers/serial/dz.c                               |    4 ----
 drivers/serial/serial_core.c                      |    2 +-
 drivers/usb/usb-skeleton.c                        |    4 ++--
 7 files changed, 4 insertions(+), 21 deletions(-)

--- gregkh-2.6.orig/drivers/block/viodasd.c	2005-06-10 23:37:22.000000000 -0700
+++ gregkh-2.6/drivers/block/viodasd.c	2005-06-10 23:37:27.000000000 -0700
@@ -59,7 +59,6 @@
  * numbers 0-255 we get a maximum of 32 disks.
  */
 #define VIOD_GENHD_NAME		"iseries/vd"
-#define VIOD_GENHD_DEVFS_NAME	"iseries/disc"
 
 #define VIOD_VERS		"1.64"
 
--- gregkh-2.6.orig/drivers/cdrom/viocd.c	2005-06-10 23:37:22.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/viocd.c	2005-06-10 23:37:27.000000000 -0700
@@ -51,7 +51,6 @@
 #include <asm/iSeries/vio.h>
 
 #define VIOCD_DEVICE			"iseries/vcd"
-#define VIOCD_DEVICE_DEVFS		"iseries/vcd"
 
 #define VIOCD_VERS "1.06"
 
--- gregkh-2.6.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-06-10 23:28:55.000000000 -0700
+++ gregkh-2.6/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-06-10 23:37:27.000000000 -0700
@@ -123,10 +123,6 @@
 
 	int revision;
 
-#if 0
-	devfs_handle_t stc_devfs_handle;
-#endif
-
 	struct dvb_frontend* fe;
 };
 
@@ -1529,13 +1525,6 @@
 		return -ENODEV;
 	}
 
-#if 0
-	ttusb->stc_devfs_handle =
-	    devfs_register(ttusb->adapter->devfs_handle, TTUSB_BUDGET_NAME,
-			   DEVFS_FL_DEFAULT, 0, 192,
-			   S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP
-			   | S_IROTH | S_IWOTH, &stc_fops, ttusb);
-#endif
 	usb_set_intfdata(intf, (void *) ttusb);
 
 	frontend_init(ttusb);
--- gregkh-2.6.orig/drivers/serial/dz.c	2005-06-10 23:28:55.000000000 -0700
+++ gregkh-2.6/drivers/serial/dz.c	2005-06-10 23:37:27.000000000 -0700
@@ -771,11 +771,7 @@
 static struct uart_driver dz_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-#ifdef CONFIG_DEVFS
-	.dev_name		= "tts/%d",
-#else
 	.dev_name		= "ttyS%d",
-#endif
 	.major			= TTY_MAJOR,
 	.minor			= 64,
 	.nr			= DZ_NB_PORT,
--- gregkh-2.6.orig/drivers/md/dm.c	2005-06-10 23:28:55.000000000 -0700
+++ gregkh-2.6/drivers/md/dm.c	2005-06-10 23:37:27.000000000 -0700
@@ -150,7 +150,7 @@
 	bioset_free(dm_set);
 
 	if (unregister_blkdev(_major, _name) < 0)
-		DMERR("devfs_unregister_blkdev failed");
+		DMERR("unregister_blkdev failed");
 
 	_major = 0;
 
--- gregkh-2.6.orig/drivers/serial/serial_core.c	2005-06-10 23:37:26.000000000 -0700
+++ gregkh-2.6/drivers/serial/serial_core.c	2005-06-10 23:37:27.000000000 -0700
@@ -2218,7 +2218,7 @@
 	down(&port_sem);
 
 	/*
-	 * Remove the devices from devfs
+	 * Remove the devices from sysfs
 	 */
 	tty_unregister_device(drv->tty_driver, port->line);
 
--- gregkh-2.6.orig/drivers/usb/usb-skeleton.c	2005-06-10 23:37:26.000000000 -0700
+++ gregkh-2.6/drivers/usb/usb-skeleton.c	2005-06-10 23:37:27.000000000 -0700
@@ -218,9 +218,9 @@
 	.release =	skel_release,
 };
 
-/* 
+/*
  * usb class driver info in order to get a minor number from the usb core,
- * and to have the device registered with devfs and the driver core
+ * and to have the device registered with sysfs.
  */
 static struct usb_class_driver skel_class = {
 	.name =		"skel%d",

