Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbSI0Tgt>; Fri, 27 Sep 2002 15:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbSI0Tgs>; Fri, 27 Sep 2002 15:36:48 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:1550 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262584AbSI0Tgq>;
	Fri, 27 Sep 2002 15:36:46 -0400
Date: Fri, 27 Sep 2002 12:40:25 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194025.GC12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927193855.GB12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.1 -> 1.611.1.2
#	drivers/usb/usb-skeleton.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	greg@kroah.com	1.611.1.2
# USB: convert the usb-skeleton.c driver to work with the latest USB core changes.
# --------------------------------------------
#
diff -Nru a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
--- a/drivers/usb/usb-skeleton.c	Fri Sep 27 12:30:25 2002
+++ b/drivers/usb/usb-skeleton.c	Fri Sep 27 12:30:25 2002
@@ -1,12 +1,11 @@
 /*
- * USB Skeleton driver - 0.7
+ * USB Skeleton driver - 0.8
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001-2002 Greg Kroah-Hartman (greg@kroah.com)
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License as
- *	published by the Free Software Foundation; either version 2 of
- *	the License, or (at your option) any later version.
+ *	published by the Free Software Foundation, version 2.
  *
  *
  * This driver is to be used as a skeleton driver to be able to create a
@@ -22,6 +21,8 @@
  *
  * History:
  *
+ * 2002_09_26 - 0.8 - changes due to USB core conversion to struct device
+ *			driver.
  * 2002_02_12 - 0.7 - zero out dev in probe function for devices that do
  *			not have both a bulk in and bulk out endpoint.
  *			Thanks to Holger Waechtler for the fix.
@@ -133,8 +134,8 @@
 static int skel_open		(struct inode *inode, struct file *file);
 static int skel_release		(struct inode *inode, struct file *file);
 	
-static void * skel_probe	(struct usb_device *dev, unsigned int ifnum, const struct usb_device_id *id);
-static void skel_disconnect	(struct usb_device *dev, void *ptr);
+static int skel_probe		(struct usb_interface *intf, const struct usb_device_id *id);
+static void skel_disconnect	(struct usb_interface *intf);
 
 static void skel_write_bulk_callback	(struct urb *urb);
 
@@ -509,10 +510,10 @@
  *	Called by the usb core when a new device is connected that it thinks
  *	this driver might be interested in.
  */
-static void * skel_probe(struct usb_device *udev, unsigned int ifnum, const struct usb_device_id *id)
+static int skel_probe(struct usb_interface *interface, const struct usb_device_id *id)
 {
+	struct usb_device *udev = interface_to_usbdev(interface);
 	struct usb_skel *dev = NULL;
-	struct usb_interface *interface;
 	struct usb_interface_descriptor *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
 	int minor;
@@ -525,7 +526,7 @@
 	/* See if the device offered us matches what we can accept */
 	if ((udev->descriptor.idVendor != USB_SKEL_VENDOR_ID) ||
 	    (udev->descriptor.idProduct != USB_SKEL_PRODUCT_ID)) {
-		return NULL;
+		return -ENODEV;
 	}
 
 	down (&minor_table_mutex);
@@ -545,8 +546,6 @@
 	memset (dev, 0x00, sizeof (*dev));
 	minor_table[minor] = dev;
 
-	interface = &udev->actconfig->interface[ifnum];
-
 	init_MUTEX (&dev->sem);
 	dev->udev = udev;
 	dev->interface = interface;
@@ -619,7 +618,11 @@
 
 exit:
 	up (&minor_table_mutex);
-	return dev;
+	if (dev) {
+		dev_set_drvdata (&interface->dev, dev);
+		return 0;
+	}
+	return -ENODEV;
 }
 
 
@@ -628,13 +631,17 @@
  *
  *	Called by the usb core when the device is removed from the system.
  */
-static void skel_disconnect(struct usb_device *udev, void *ptr)
+static void skel_disconnect(struct usb_interface *interface)
 {
 	struct usb_skel *dev;
 	int minor;
 
-	dev = (struct usb_skel *)ptr;
-	
+	dev = dev_get_drvdata (&interface->dev);
+	dev_set_drvdata (&interface->dev, NULL);
+
+	if (!dev)
+		return;
+
 	down (&minor_table_mutex);
 	down (&dev->sem);
 		
