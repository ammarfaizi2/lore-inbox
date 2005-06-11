Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVFKHw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVFKHw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVFKHvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:51:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:64195 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261642AbVFKHsj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:39 -0400
Subject: [PATCH] Remove the mode field from usb_class_driver as it's no longer needed
In-Reply-To: <11184761123002@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:32 -0700
Message-Id: <11184761122236@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes all drivers that set this field, and removes some other devfs
specfic USB logic.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/class/usblp.c           |    3 +--
 drivers/usb/core/file.c             |   12 ++++--------
 drivers/usb/image/mdc800.c          |    3 +--
 drivers/usb/input/aiptek.c          |    2 +-
 drivers/usb/input/hiddev.c          |    3 +--
 drivers/usb/media/dabusb.c          |    3 +--
 drivers/usb/misc/auerswald.c        |    3 +--
 drivers/usb/misc/idmouse.c          |    5 ++---
 drivers/usb/misc/legousbtower.c     |    5 ++---
 drivers/usb/misc/rio500.c           |    3 +--
 drivers/usb/misc/sisusbvga/sisusb.c |    3 +--
 drivers/usb/misc/usblcd.c           |    9 ++++-----
 drivers/usb/usb-skeleton.c          |    3 +--
 include/linux/usb.h                 |    7 ++-----
 14 files changed, 23 insertions(+), 41 deletions(-)

--- gregkh-2.6.orig/include/linux/usb.h	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/include/linux/usb.h	2005-06-10 23:37:26.000000000 -0700
@@ -570,10 +570,8 @@
 
 /**
  * struct usb_class_driver - identifies a USB driver that wants to use the USB major number
- * @name: devfs name for this driver.  Will also be used by the driver
- *	class code to create a usb class device.
+ * @name: the usb class device name for this driver.  Will show up in sysfs.
  * @fops: pointer to the struct file_operations of this driver.
- * @mode: the mode for the devfs file to be created for this driver.
  * @minor_base: the start of the minor range for this driver.
  *
  * This structure is used for the usb_register_dev() and
@@ -583,8 +581,7 @@
 struct usb_class_driver {
 	char *name;
 	struct file_operations *fops;
-	mode_t mode;
-	int minor_base;	
+	int minor_base;
 };
 
 /*
--- gregkh-2.6.orig/drivers/usb/class/usblp.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/class/usblp.c	2005-06-10 23:37:26.000000000 -0700
@@ -841,9 +841,8 @@
 };
 
 static struct usb_class_driver usblp_class = {
-	.name =		"usb/lp%d",
+	.name =		"lp%d",
 	.fops =		&usblp_fops,
-	.mode =		S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 	.minor_base =	USBLP_MINOR_BASE,
 };
 
--- gregkh-2.6.orig/drivers/usb/core/file.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/usb/core/file.c	2005-06-10 23:37:26.000000000 -0700
@@ -108,8 +108,7 @@
  * enabled, the minor number will be based on the next available free minor,
  * starting at the class_driver->minor_base.
  *
- * This function also creates the devfs file for the usb device, if devfs
- * is enabled, and creates a usb class device in the sysfs tree.
+ * This function also creates a usb class device in the sysfs tree.
  *
  * usb_deregister_dev() must be called when the driver is done with
  * the minor numbers given out by this function.
@@ -158,10 +157,8 @@
 
 	intf->minor = minor;
 
-	/* handle the devfs registration */
-	snprintf(name, BUS_ID_SIZE, class_driver->name, minor - minor_base);
-
 	/* create a usb class device for this usb interface */
+	snprintf(name, BUS_ID_SIZE, class_driver->name, minor - minor_base);
 	temp = strrchr(name, '/');
 	if (temp && (temp[1] != 0x00))
 		++temp;
@@ -189,9 +186,8 @@
  * call to usb_register_dev() (usually when the device is disconnected
  * from the system.)
  *
- * This function also cleans up the devfs file for the usb device, if devfs
- * is enabled, and removes the usb class device from the sysfs tree.
- * 
+ * This function also removes the usb class device from the sysfs tree.
+ *
  * This should be called by all drivers that use the USB major number.
  */
 void usb_deregister_dev(struct usb_interface *intf,
--- gregkh-2.6.orig/drivers/usb/image/mdc800.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/image/mdc800.c	2005-06-10 23:37:26.000000000 -0700
@@ -425,9 +425,8 @@
 static struct usb_driver mdc800_usb_driver;
 static struct file_operations mdc800_device_ops;
 static struct usb_class_driver mdc800_class = {
-	.name =		"usb/mdc800%d",
+	.name =		"mdc800%d",
 	.fops =		&mdc800_device_ops,
-	.mode =		S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 	.minor_base =	MDC800_DEVICE_MINOR_BASE,
 };
 
--- gregkh-2.6.orig/drivers/usb/input/hiddev.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/usb/input/hiddev.c	2005-06-10 23:37:26.000000000 -0700
@@ -730,9 +730,8 @@
 };
 
 static struct usb_class_driver hiddev_class = {
-	.name =		"usb/hid/hiddev%d",
+	.name =		"hiddev%d",
 	.fops =		&hiddev_fops,
-	.mode =		S_IFCHR | S_IRUGO | S_IWUSR,
        	.minor_base =	HIDDEV_MINOR_BASE,
 };
 
--- gregkh-2.6.orig/drivers/usb/media/dabusb.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/media/dabusb.c	2005-06-10 23:37:26.000000000 -0700
@@ -707,9 +707,8 @@
 };
 
 static struct usb_class_driver dabusb_class = {
-	.name =		"usb/dabusb%d",
+	.name =		"dabusb%d",
 	.fops =		&dabusb_fops,
-	.mode =		S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 	.minor_base =	DABUSB_MINOR,
 };
 
--- gregkh-2.6.orig/drivers/usb/misc/auerswald.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/misc/auerswald.c	2005-06-10 23:37:26.000000000 -0700
@@ -1874,9 +1874,8 @@
 };
 
 static struct usb_class_driver auerswald_class = {
-	.name =		"usb/auer%d",
+	.name =		"auer%d",
 	.fops =		&auerswald_fops,
-	.mode =		S_IFCHR | S_IRUGO | S_IWUGO,
 	.minor_base =	AUER_MINOR_BASE,
 };
 
--- gregkh-2.6.orig/drivers/usb/misc/idmouse.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/misc/idmouse.c	2005-06-10 23:37:26.000000000 -0700
@@ -105,11 +105,10 @@
 	.release = idmouse_release,
 };
 
-/* class driver information for devfs */
+/* class driver information */
 static struct usb_class_driver idmouse_class = {
-	.name = "usb/idmouse%d",
+	.name = "idmouse%d",
 	.fops = &idmouse_fops,
-	.mode = S_IFCHR | S_IRUSR | S_IRGRP | S_IROTH, /* filemode (char, 444) */
 	.minor_base = USB_IDMOUSE_MINOR_BASE,
 };
 
--- gregkh-2.6.orig/drivers/usb/misc/legousbtower.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/misc/legousbtower.c	2005-06-10 23:37:26.000000000 -0700
@@ -271,12 +271,11 @@
 
 /*
  * usb class driver info in order to get a minor number from the usb core,
- * and to have the device registered with devfs and the driver core
+ * and to have the device registered with the driver core
  */
 static struct usb_class_driver tower_class = {
-	.name =		"usb/legousbtower%d",
+	.name =		"legousbtower%d",
 	.fops =		&tower_fops,
-	.mode =		S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
 	.minor_base =	LEGO_USB_TOWER_MINOR_BASE,
 };
 
--- gregkh-2.6.orig/drivers/usb/misc/rio500.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/misc/rio500.c	2005-06-10 23:37:26.000000000 -0700
@@ -443,9 +443,8 @@
 };
 
 static struct usb_class_driver usb_rio_class = {
-	.name =		"usb/rio500%d",
+	.name =		"rio500%d",
 	.fops =		&usb_rio_fops,
-	.mode =		S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 	.minor_base =	RIO_MINOR,
 };
 
--- gregkh-2.6.orig/drivers/usb/misc/usblcd.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/misc/usblcd.c	2005-06-10 23:37:26.000000000 -0700
@@ -251,13 +251,12 @@
 };
 
 /*
- *  * usb class driver info in order to get a minor number from the usb core,
- *   * and to have the device registered with devfs and the driver core
- *    */
+ * usb class driver info in order to get a minor number from the usb core,
+ * and to have the device registered with the driver core
+ */
 static struct usb_class_driver lcd_class = {
-        .name =         "usb/lcd%d",
+        .name =         "lcd%d",
         .fops =         &lcd_fops,
-        .mode =         S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
         .minor_base =   USBLCD_MINOR,
 };
 
--- gregkh-2.6.orig/drivers/usb/usb-skeleton.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/usb-skeleton.c	2005-06-10 23:37:33.000000000 -0700
@@ -223,9 +223,8 @@
  * and to have the device registered with devfs and the driver core
  */
 static struct usb_class_driver skel_class = {
-	.name =		"usb/skel%d",
+	.name =		"skel%d",
 	.fops =		&skel_fops,
-	.mode =		S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
 	.minor_base =	USB_SKEL_MINOR_BASE,
 };
 
--- gregkh-2.6.orig/drivers/usb/misc/sisusbvga/sisusb.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/misc/sisusbvga/sisusb.c	2005-06-10 23:37:26.000000000 -0700
@@ -2895,9 +2895,8 @@
 };
 
 static struct usb_class_driver usb_sisusb_class = {
-	.name =		"usb/sisusbvga%d",
+	.name =		"sisusbvga%d",
 	.fops =		&usb_sisusb_fops,
-	.mode =		S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 	.minor_base =	SISUSB_MINOR
 };
 
--- gregkh-2.6.orig/drivers/usb/input/aiptek.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/usb/input/aiptek.c	2005-06-10 23:37:26.000000000 -0700
@@ -2170,7 +2170,7 @@
 	 * input_handles associated with this input device.
 	 * What identifies an evdev input_handler is that it begins
 	 * with 'event', continues with a digit, and that in turn
-	 * is mapped to /{devfs}/input/eventN.
+	 * is mapped to input/eventN.
 	 */
 	inputdev = &aiptek->inputdev;
 	list_for_each_safe(node, next, &inputdev->h_list) {

