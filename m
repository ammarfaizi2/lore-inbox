Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264289AbRFHR47>; Fri, 8 Jun 2001 13:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264299AbRFHR4u>; Fri, 8 Jun 2001 13:56:50 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:25354 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S264289AbRFHR4c>; Fri, 8 Jun 2001 13:56:32 -0400
Date: Fri, 8 Jun 2001 13:57:26 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@vesta.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB Scanner devfs support
Message-ID: <Pine.LNX.4.33.0106081347450.29693-100000@vesta.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've made a patch for devfs support in USB scanners (against 2.4.5-ac9).
It can be found here:

http://www.red-bean.com/~proski/linux/scanner-devfs.diff

The patch is quite straightforward. The necessary changes have been taken
from usb-skeleton.c and verified against printer.c.

The scanner names will be /dev/usb/scanner0 ... /dev/usb/scanner15 in full
accordance will Documentation/devices.txt.

For some reason private structures of the driver are kept in scanner.h,
but it's only included by scanner.c, so please don't worry about changes
in the headers. Ideally, most (all?) stuff from scanner.h should be moved
into scanner.c, but I don't want to mix two patches.

The patch has been tested with ScanPrisa 640U.

The patch is below my signature as well as at
http://www.red-bean.com/~proski/linux/scanner-devfs.diff

-- 
Regards,
Pavel Roskin


-------------------------------------------------------------
--- linux.orig/drivers/usb/scanner.c
+++ linux/drivers/usb/scanner.c
@@ -263,6 +263,13 @@
  */
 #include "scanner.h"

+/* the global usb devfs handle */
+extern devfs_handle_t usb_devfs_handle;
+
+/* Forward declarations */
+static struct
+file_operations usb_scanner_fops;
+

 static void
 irq_scanner(struct urb *urb)
@@ -363,6 +370,8 @@ close_scanner(struct inode * inode, stru

 	scn = p_scn_table[scn_minor];

+	devfs_unregister(scn->devfs);
+
 	scn->isopen = 0;

 	file->private_data = NULL;
@@ -594,6 +603,7 @@ probe_scanner(struct usb_device *dev, un

 	char valid_device = 0;
 	char have_bulk_in, have_bulk_out, have_intr;
+	char name[12];

 	if (vendor != -1 && product != -1) {
 		info("probe_scanner: User specified USB scanner -- Vendor:Product - %x:%x", vendor, product);
@@ -813,6 +823,17 @@ probe_scanner(struct usb_device *dev, un

 	init_MUTEX(&(scn->gen_lock));

+	sprintf(name, "scanner%d", scn_minor);
+
+	/* Create with perms=664 */
+	scn->devfs = devfs_register(usb_devfs_handle, name,
+				    DEVFS_FL_DEFAULT, USB_MAJOR,
+				    SCN_BASE_MNR + scn_minor,
+				    S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
+				    S_IWGRP, &usb_scanner_fops, NULL);
+	if (scn->devfs == NULL)
+		err("scanner%d: device node registration failed", scn_minor);
+
 	return p_scn_table[scn_minor] = scn;
 }

@@ -830,6 +851,8 @@ disconnect_scanner(struct usb_device *de

 	kfree(scn->ibuf);
 	kfree(scn->obuf);
+
+	devfs_unregister(scn->devfs);

 	dbg("disconnect_scanner: De-allocating minor:%d", scn->scn_minor);
 	p_scn_table[scn->scn_minor] = NULL;
--- linux.orig/drivers/usb/scanner.h
+++ linux/drivers/usb/scanner.h
@@ -31,6 +31,7 @@
 #include <linux/ioctl.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>

 // #define DEBUG

@@ -169,6 +170,7 @@

 struct scn_usb_data {
 	struct usb_device *scn_dev;
+	devfs_handle_t devfs;	/* devfs device */
 	struct urb scn_irq;
 	unsigned int ifnum;	/* Interface number of the USB device */
 	kdev_t scn_minor;	/* Scanner minor - used in disconnect() */
-------------------------------------------------------------

