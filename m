Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbSBGWwB>; Thu, 7 Feb 2002 17:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSBGWvv>; Thu, 7 Feb 2002 17:51:51 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:27403 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285516AbSBGWvh>;
	Thu, 7 Feb 2002 17:51:37 -0500
Date: Thu, 7 Feb 2002 14:48:47 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mochel@osdl.org
Subject: [PATCH] driverfs support for USB
Message-ID: <20020207224846.GB20492@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 10 Jan 2002 20:32:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, finally got something to work properly...

Here's a patch against 2.5.4-pre2 that adds driverfs support to the USB
subsystem.  It differs from my previous patches, in that this one works
well :)

First off, here's what a USB tree on my machine looks like right now:
    |   |-- 00:1f.2
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   |-- resources
    |   |   |-- status
    |   |   `-- usb_bus
    |   |       |-- 000
    |   |       |   |-- name
    |   |       |   |-- power
    |   |       |   `-- status
    |   |       |-- 01
    |   |       |   |-- 000
    |   |       |   |   |-- name
    |   |       |   |   |-- power
    |   |       |   |   `-- status
    |   |       |   |-- 01
    |   |       |   |   |-- 000
    |   |       |   |   |   |-- name
    |   |       |   |   |   |-- power
    |   |       |   |   |   `-- status
    |   |       |   |   |-- name
    |   |       |   |   |-- power
    |   |       |   |   `-- status
    |   |       |   |-- name
    |   |       |   |-- power
    |   |       |   `-- status
    |   |       |-- name
    |   |       |-- power
    |   |       `-- status

(portions were snipped for clarity.)

What this tree shows is a USB UHCI pci driver attached to the pci
device.  This driver has a root hub, with a single interface (the first
000 directory at the top.)  Then plugged into the second port on the
root hub, is another hub (with it's own interface).  Then plugged into
the second port on that hub, is a USB trackball (again, with only one
interface.)

This now provides a stable device tree that is mapped to the physical
topology of the tree (port numbers), and also shows the fact that USB
drivers bind to the individual USB interfaces, not the devices
themselves (yes, USB topology is odd the first 100 times you look at it,
but after that, you learn to relax and accept it...)

Feel free to play around with this patch, I've sent it on to Linus.

Next up, we start defining the different properties that we want to
export for every USB device, and the different USB drivers :)

thanks,

greg k-h


diff -Nru a/drivers/usb/hcd/ehci-hcd.c b/drivers/usb/hcd/ehci-hcd.c
--- a/drivers/usb/hcd/ehci-hcd.c	Thu Feb  7 13:55:10 2002
+++ b/drivers/usb/hcd/ehci-hcd.c	Thu Feb  7 13:55:10 2002
@@ -277,7 +277,7 @@
 	 */
 	usb_connect (udev);
 	udev->speed = USB_SPEED_HIGH;
-	if (usb_new_device (udev) != 0) {
+	if (usb_register_root_hub (udev, &ehci->hcd.pdev->dev) != 0) {
 		if (hcd->state == USB_STATE_RUNNING)
 			ehci_ready (ehci);
 		while (readl (&ehci->regs->status) & (STS_ASS | STS_PSS))
diff -Nru a/drivers/usb/hcd/ohci-hcd.c b/drivers/usb/hcd/ohci-hcd.c
--- a/drivers/usb/hcd/ohci-hcd.c	Thu Feb  7 13:55:11 2002
+++ b/drivers/usb/hcd/ohci-hcd.c	Thu Feb  7 13:55:11 2002
@@ -469,7 +469,7 @@
 
 	usb_connect (udev);
 	udev->speed = USB_SPEED_FULL;
-	if (usb_new_device (udev) != 0) {
+	if (usb_register_root_hub (udev, &ohci->hcd.pdev->dev) != 0) {
 		usb_free_dev (udev); 
 		ohci->disabled = 1;
 // FIXME cleanup
diff -Nru a/drivers/usb/hub.c b/drivers/usb/hub.c
--- a/drivers/usb/hub.c	Thu Feb  7 13:55:11 2002
+++ b/drivers/usb/hub.c	Thu Feb  7 13:55:11 2002
@@ -721,6 +721,20 @@
 		info("new USB device on bus %d path %s, assigned address %d",
 			dev->bus->busnum, dev->devpath, dev->devnum);
 
+		/* put the device in the global device tree */
+		dev->dev.parent = &dev->parent->dev;
+		sprintf (&dev->dev.name[0], "USB device %04x:%04x",
+			 dev->descriptor.idVendor,
+			 dev->descriptor.idProduct);
+		/* find the number of the port this device is connected to */
+		sprintf (&dev->dev.bus_id[0], "unknown_port_%03d", dev->devnum);
+		for (i = 0; i < USB_MAXCHILDREN; ++i) {
+			if (dev->parent->children[i] == dev) {
+				sprintf (&dev->dev.bus_id[0], "%02d", i);
+				break;
+			}
+		}
+
 		/* Run it through the hoops (find a driver, etc) */
 		if (!usb_new_device(dev))
 			goto done;
diff -Nru a/drivers/usb/uhci.c b/drivers/usb/uhci.c
--- a/drivers/usb/uhci.c	Thu Feb  7 13:55:11 2002
+++ b/drivers/usb/uhci.c	Thu Feb  7 13:55:11 2002
@@ -2842,7 +2842,7 @@
 
 	usb_connect(uhci->rh.dev);
 
-	if (usb_new_device(uhci->rh.dev) != 0) {
+	if (usb_register_root_hub(uhci->rh.dev, &dev->dev) != 0) {
 		err("unable to start root hub");
 		retval = -ENOMEM;
 		goto err_start_root_hub;
diff -Nru a/drivers/usb/usb-ohci.c b/drivers/usb/usb-ohci.c
--- a/drivers/usb/usb-ohci.c	Thu Feb  7 13:55:10 2002
+++ b/drivers/usb/usb-ohci.c	Thu Feb  7 13:55:10 2002
@@ -2231,7 +2231,7 @@
 	dev = usb_to_ohci (usb_dev);
 	ohci->bus->root_hub = usb_dev;
 	usb_connect (usb_dev);
-	if (usb_new_device (usb_dev) != 0) {
+	if (usb_register_root_hub (usb_dev, &ohci->ohci_dev->dev) != 0) {
 		usb_free_dev (usb_dev); 
 		ohci->disabled = 1;
 		return -ENODEV;
diff -Nru a/drivers/usb/usb-uhci.c b/drivers/usb/usb-uhci.c
--- a/drivers/usb/usb-uhci.c	Thu Feb  7 13:55:10 2002
+++ b/drivers/usb/usb-uhci.c	Thu Feb  7 13:55:10 2002
@@ -2907,7 +2907,7 @@
 	s->bus->root_hub = usb_dev;
 	usb_connect (usb_dev);
 
-	if (usb_new_device (usb_dev) != 0) {
+	if (usb_register_root_hub (usb_dev, &s->uhci_pci->dev) != 0) {
 		usb_free_dev (usb_dev);
 		return -1;
 	}
diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
--- a/drivers/usb/usb.c	Thu Feb  7 13:55:11 2002
+++ b/drivers/usb/usb.c	Thu Feb  7 13:55:11 2002
@@ -980,8 +980,16 @@
 	unsigned claimed = 0;
 
 	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++) {
+		struct usb_interface *interface = &dev->actconfig->interface[ifnum];
+		
+		/* register this interface with driverfs */
+		interface->dev.parent = &dev->dev;
+		sprintf (&interface->dev.bus_id[0], "%03d", ifnum);
+		sprintf (&interface->dev.name[0], "figure out some name...");
+		device_register (&interface->dev);
+
 		/* if this interface hasn't already been claimed */
-		if (!usb_interface_claimed(dev->actconfig->interface + ifnum)) {
+		if (!usb_interface_claimed(interface)) {
 			if (usb_find_interface_driver(dev, ifnum))
 				rejected++;
 			else
@@ -1969,8 +1977,10 @@
 				if (driver->owner)
 					__MOD_DEC_USE_COUNT(driver->owner);
 				/* if driver->disconnect didn't release the interface */
-				if (interface->driver)
+				if (interface->driver) {
+					put_device (&interface->dev);
 					usb_driver_release_interface(driver, interface);
+				}
 			}
 		}
 	}
@@ -1989,6 +1999,7 @@
 	if (dev->devnum > 0) {
 		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
 		usbfs_remove_device(dev);
+		put_device(&dev->dev);
 	}
 
 	/* Free up the device itself */
@@ -2715,6 +2726,11 @@
 		usb_show_string(dev, "SerialNumber", dev->descriptor.iSerialNumber);
 #endif
 
+	/* register this device in the driverfs tree */
+	err = device_register (&dev->dev);
+	if (err)
+		return err;
+
 	/* now that the basic setup is over, add a /proc/bus/usb entry */
 	usbfs_add_device(dev);
 
@@ -2727,6 +2743,29 @@
 	return 0;
 }
 
+/**
+ * usb_register_root_hub - called by a usb host controller to register the root hub device in the system
+ * @usb_dev: the usb root hub device to be registered.
+ * @parent_dev: the parent device of this root hub.
+ *
+ * The USB host controller calls this function to register the root hub
+ * properly with the USB subsystem.  It sets up the device properly in
+ * the driverfs tree, and then calls usb_new_device() to register the
+ * usb device.
+ */
+int usb_register_root_hub (struct usb_device *usb_dev, struct device *parent_dev)
+{
+	int retval;
+
+	usb_dev->dev.parent = parent_dev;
+	strcpy (&usb_dev->dev.name[0], "usb_name");
+	strcpy (&usb_dev->dev.bus_id[0], "usb_bus");
+	retval = usb_new_device (usb_dev);
+	if (retval)
+		put_device (&usb_dev->dev);
+	return retval;
+}
+
 static int usb_open(struct inode * inode, struct file * file)
 {
 	int minor = minor(inode->i_rdev);
@@ -2832,6 +2871,7 @@
 EXPORT_SYMBOL(usb_free_bus);
 EXPORT_SYMBOL(usb_register_bus);
 EXPORT_SYMBOL(usb_deregister_bus);
+EXPORT_SYMBOL(usb_register_root_hub);
 EXPORT_SYMBOL(usb_alloc_dev);
 EXPORT_SYMBOL(usb_free_dev);
 EXPORT_SYMBOL(usb_inc_dev_use);
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Thu Feb  7 13:55:11 2002
+++ b/include/linux/usb.h	Thu Feb  7 13:55:11 2002
@@ -1,6 +1,8 @@
 #ifndef __LINUX_USB_H
 #define __LINUX_USB_H
 
+#include <linux/device.h>
+
 /* USB constants */
 
 /*
@@ -260,6 +262,7 @@
 	int max_altsetting;             /* total memory allocated */
  
 	struct usb_driver *driver;	/* driver */
+	struct device dev;		/* interface specific device info */
 	void *private_data;
 };
 
@@ -945,6 +948,7 @@
 extern void usb_free_bus(struct usb_bus *);
 extern void usb_register_bus(struct usb_bus *);
 extern void usb_deregister_bus(struct usb_bus *);
+extern int usb_register_root_hub(struct usb_device *usb_dev, struct device *parent_dev);
 
 extern int usb_check_bandwidth (struct usb_device *dev, struct urb *urb);
 extern void usb_claim_bandwidth (struct usb_device *dev, struct urb *urb,
@@ -1040,6 +1044,8 @@
 
 	struct usb_device *parent;
 	struct usb_bus *bus;		/* Bus we're part of */
+
+	struct device dev;		/* Generic device interface */
 
 	struct usb_device_descriptor descriptor;/* Descriptor */
 	struct usb_config_descriptor *config;	/* All of the configs */
