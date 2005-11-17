Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbVKQAsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbVKQAsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbVKQAsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:48:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:40661 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161059AbVKQAsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:48:03 -0500
Date: Wed, 16 Nov 2005 16:31:39 -0800
From: Greg KH <gregkh@suse.de>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 01/02] USB: reorg some functions out of the main usb.c file
Message-ID: <20051117003139.GB14896@kroah.com>
References: <20051117003053.GA14896@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117003053.GA14896@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will make the dynamic-id stuff easier to do, as it will be
self-contained.

No logic was changed at all.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 Documentation/DocBook/usb.tmpl |    1 
 drivers/usb/core/Makefile      |    2 
 drivers/usb/core/driver.c      |  338 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c         |  310 -------------------------------------
 drivers/usb/core/usb.h         |    3 
 5 files changed, 343 insertions(+), 311 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/usb.c
+++ gregkh-2.6/drivers/usb/core/usb.c
@@ -52,161 +52,6 @@ static int nousb;	/* Disable USB when bu
 static DECLARE_RWSEM(usb_all_devices_rwsem);
 
 
-static int generic_probe (struct device *dev)
-{
-	return 0;
-}
-static int generic_remove (struct device *dev)
-{
-	struct usb_device *udev = to_usb_device(dev);
-
-	/* if this is only an unbind, not a physical disconnect, then
-	 * unconfigure the device */
-	if (udev->state == USB_STATE_CONFIGURED)
-		usb_set_configuration(udev, 0);
-
-	/* in case the call failed or the device was suspended */
-	if (udev->state >= USB_STATE_CONFIGURED)
-		usb_disable_device(udev, 0);
-	return 0;
-}
-
-static struct device_driver usb_generic_driver = {
-	.owner = THIS_MODULE,
-	.name =	"usb",
-	.bus = &usb_bus_type,
-	.probe = generic_probe,
-	.remove = generic_remove,
-};
-
-static int usb_generic_driver_data;
-
-/* called from driver core with usb_bus_type.subsys writelock */
-static int usb_probe_interface(struct device *dev)
-{
-	struct usb_interface * intf = to_usb_interface(dev);
-	struct usb_driver * driver = to_usb_driver(dev->driver);
-	const struct usb_device_id *id;
-	int error = -ENODEV;
-
-	dev_dbg(dev, "%s\n", __FUNCTION__);
-
-	if (!driver->probe)
-		return error;
-	/* FIXME we'd much prefer to just resume it ... */
-	if (interface_to_usbdev(intf)->state == USB_STATE_SUSPENDED)
-		return -EHOSTUNREACH;
-
-	id = usb_match_id (intf, driver->id_table);
-	if (id) {
-		dev_dbg (dev, "%s - got id\n", __FUNCTION__);
-
-		/* Interface "power state" doesn't correspond to any hardware
-		 * state whatsoever.  We use it to record when it's bound to
-		 * a driver that may start I/0:  it's not frozen/quiesced.
-		 */
-		mark_active(intf);
-		intf->condition = USB_INTERFACE_BINDING;
-		error = driver->probe (intf, id);
-		if (error) {
-			mark_quiesced(intf);
-			intf->condition = USB_INTERFACE_UNBOUND;
-		} else
-			intf->condition = USB_INTERFACE_BOUND;
-	}
-
-	return error;
-}
-
-/* called from driver core with usb_bus_type.subsys writelock */
-static int usb_unbind_interface(struct device *dev)
-{
-	struct usb_interface *intf = to_usb_interface(dev);
-	struct usb_driver *driver = to_usb_driver(intf->dev.driver);
-
-	intf->condition = USB_INTERFACE_UNBINDING;
-
-	/* release all urbs for this interface */
-	usb_disable_interface(interface_to_usbdev(intf), intf);
-
-	if (driver && driver->disconnect)
-		driver->disconnect(intf);
-
-	/* reset other interface state */
-	usb_set_interface(interface_to_usbdev(intf),
-			intf->altsetting[0].desc.bInterfaceNumber,
-			0);
-	usb_set_intfdata(intf, NULL);
-	intf->condition = USB_INTERFACE_UNBOUND;
-	mark_quiesced(intf);
-
-	return 0;
-}
-
-/**
- * usb_register - register a USB driver
- * @new_driver: USB operations for the driver
- *
- * Registers a USB driver with the USB core.  The list of unattached
- * interfaces will be rescanned whenever a new driver is added, allowing
- * the new driver to attach to any recognized devices.
- * Returns a negative error code on failure and 0 on success.
- * 
- * NOTE: if you want your driver to use the USB major number, you must call
- * usb_register_dev() to enable that functionality.  This function no longer
- * takes care of that.
- */
-int usb_register(struct usb_driver *new_driver)
-{
-	int retval = 0;
-
-	if (nousb)
-		return -ENODEV;
-
-	new_driver->driver.name = (char *)new_driver->name;
-	new_driver->driver.bus = &usb_bus_type;
-	new_driver->driver.probe = usb_probe_interface;
-	new_driver->driver.remove = usb_unbind_interface;
-	new_driver->driver.owner = new_driver->owner;
-
-	usb_lock_all_devices();
-	retval = driver_register(&new_driver->driver);
-	usb_unlock_all_devices();
-
-	if (!retval) {
-		pr_info("%s: registered new driver %s\n",
-			usbcore_name, new_driver->name);
-		usbfs_update_special();
-	} else {
-		printk(KERN_ERR "%s: error %d registering driver %s\n",
-			usbcore_name, retval, new_driver->name);
-	}
-
-	return retval;
-}
-
-/**
- * usb_deregister - unregister a USB driver
- * @driver: USB operations of the driver to unregister
- * Context: must be able to sleep
- *
- * Unlinks the specified driver from the internal USB driver list.
- * 
- * NOTE: If you called usb_register_dev(), you still need to call
- * usb_deregister_dev() to clean up your driver's allocated minor numbers,
- * this * call will no longer do it for you.
- */
-void usb_deregister(struct usb_driver *driver)
-{
-	pr_info("%s: deregistering driver %s\n", usbcore_name, driver->name);
-
-	usb_lock_all_devices();
-	driver_unregister (&driver->driver);
-	usb_unlock_all_devices();
-
-	usbfs_update_special();
-}
-
 /**
  * usb_ifnum_to_if - get the interface object with a given interface number
  * @dev: the device whose current configuration is considered
@@ -352,137 +197,6 @@ void usb_driver_release_interface(struct
 	mark_quiesced(iface);
 }
 
-/**
- * usb_match_id - find first usb_device_id matching device or interface
- * @interface: the interface of interest
- * @id: array of usb_device_id structures, terminated by zero entry
- *
- * usb_match_id searches an array of usb_device_id's and returns
- * the first one matching the device or interface, or null.
- * This is used when binding (or rebinding) a driver to an interface.
- * Most USB device drivers will use this indirectly, through the usb core,
- * but some layered driver frameworks use it directly.
- * These device tables are exported with MODULE_DEVICE_TABLE, through
- * modutils, to support the driver loading functionality of USB hotplugging.
- *
- * What Matches:
- *
- * The "match_flags" element in a usb_device_id controls which
- * members are used.  If the corresponding bit is set, the
- * value in the device_id must match its corresponding member
- * in the device or interface descriptor, or else the device_id
- * does not match.
- *
- * "driver_info" is normally used only by device drivers,
- * but you can create a wildcard "matches anything" usb_device_id
- * as a driver's "modules.usbmap" entry if you provide an id with
- * only a nonzero "driver_info" field.  If you do this, the USB device
- * driver's probe() routine should use additional intelligence to
- * decide whether to bind to the specified interface.
- * 
- * What Makes Good usb_device_id Tables:
- *
- * The match algorithm is very simple, so that intelligence in
- * driver selection must come from smart driver id records.
- * Unless you have good reasons to use another selection policy,
- * provide match elements only in related groups, and order match
- * specifiers from specific to general.  Use the macros provided
- * for that purpose if you can.
- *
- * The most specific match specifiers use device descriptor
- * data.  These are commonly used with product-specific matches;
- * the USB_DEVICE macro lets you provide vendor and product IDs,
- * and you can also match against ranges of product revisions.
- * These are widely used for devices with application or vendor
- * specific bDeviceClass values.
- *
- * Matches based on device class/subclass/protocol specifications
- * are slightly more general; use the USB_DEVICE_INFO macro, or
- * its siblings.  These are used with single-function devices
- * where bDeviceClass doesn't specify that each interface has
- * its own class. 
- *
- * Matches based on interface class/subclass/protocol are the
- * most general; they let drivers bind to any interface on a
- * multiple-function device.  Use the USB_INTERFACE_INFO
- * macro, or its siblings, to match class-per-interface style 
- * devices (as recorded in bDeviceClass).
- *  
- * Within those groups, remember that not all combinations are
- * meaningful.  For example, don't give a product version range
- * without vendor and product IDs; or specify a protocol without
- * its associated class and subclass.
- */   
-const struct usb_device_id *
-usb_match_id(struct usb_interface *interface, const struct usb_device_id *id)
-{
-	struct usb_host_interface *intf;
-	struct usb_device *dev;
-
-	/* proc_connectinfo in devio.c may call us with id == NULL. */
-	if (id == NULL)
-		return NULL;
-
-	intf = interface->cur_altsetting;
-	dev = interface_to_usbdev(interface);
-
-	/* It is important to check that id->driver_info is nonzero,
-	   since an entry that is all zeroes except for a nonzero
-	   id->driver_info is the way to create an entry that
-	   indicates that the driver want to examine every
-	   device and interface. */
-	for (; id->idVendor || id->bDeviceClass || id->bInterfaceClass ||
-	       id->driver_info; id++) {
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_VENDOR) &&
-		    id->idVendor != le16_to_cpu(dev->descriptor.idVendor))
-			continue;
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_PRODUCT) &&
-		    id->idProduct != le16_to_cpu(dev->descriptor.idProduct))
-			continue;
-
-		/* No need to test id->bcdDevice_lo != 0, since 0 is never
-		   greater than any unsigned number. */
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_LO) &&
-		    (id->bcdDevice_lo > le16_to_cpu(dev->descriptor.bcdDevice)))
-			continue;
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_HI) &&
-		    (id->bcdDevice_hi < le16_to_cpu(dev->descriptor.bcdDevice)))
-			continue;
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_CLASS) &&
-		    (id->bDeviceClass != dev->descriptor.bDeviceClass))
-			continue;
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_SUBCLASS) &&
-		    (id->bDeviceSubClass!= dev->descriptor.bDeviceSubClass))
-			continue;
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_PROTOCOL) &&
-		    (id->bDeviceProtocol != dev->descriptor.bDeviceProtocol))
-			continue;
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_CLASS) &&
-		    (id->bInterfaceClass != intf->desc.bInterfaceClass))
-			continue;
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_SUBCLASS) &&
-		    (id->bInterfaceSubClass != intf->desc.bInterfaceSubClass))
-			continue;
-
-		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_PROTOCOL) &&
-		    (id->bInterfaceProtocol != intf->desc.bInterfaceProtocol))
-			continue;
-
-		return id;
-	}
-
-	return NULL;
-}
-
-
 static int __find_interface(struct device * dev, void * data)
 {
 	struct usb_interface ** ret = (struct usb_interface **)data;
@@ -520,27 +234,6 @@ struct usb_interface *usb_find_interface
 	return ret ? intf : NULL;
 }
 
-static int usb_device_match (struct device *dev, struct device_driver *drv)
-{
-	struct usb_interface *intf;
-	struct usb_driver *usb_drv;
-	const struct usb_device_id *id;
-
-	/* check for generic driver, which we don't match any device with */
-	if (drv == &usb_generic_driver)
-		return 0;
-
-	intf = to_usb_interface(dev);
-	usb_drv = to_usb_driver(drv);
-	
-	id = usb_match_id (intf, usb_drv->id_table);
-	if (id)
-		return 1;
-
-	return 0;
-}
-
-
 #ifdef	CONFIG_HOTPLUG
 
 /*
@@ -1591,8 +1284,6 @@ module_exit(usb_exit);
  * driver modules to use.
  */
 
-EXPORT_SYMBOL(usb_register);
-EXPORT_SYMBOL(usb_deregister);
 EXPORT_SYMBOL(usb_disabled);
 
 EXPORT_SYMBOL_GPL(usb_get_intf);
@@ -1610,7 +1301,6 @@ EXPORT_SYMBOL(usb_unlock_device);
 
 EXPORT_SYMBOL(usb_driver_claim_interface);
 EXPORT_SYMBOL(usb_driver_release_interface);
-EXPORT_SYMBOL(usb_match_id);
 EXPORT_SYMBOL(usb_find_interface);
 EXPORT_SYMBOL(usb_ifnum_to_if);
 EXPORT_SYMBOL(usb_altnum_to_altsetting);
--- gregkh-2.6.orig/drivers/usb/core/Makefile
+++ gregkh-2.6/drivers/usb/core/Makefile
@@ -2,7 +2,7 @@
 # Makefile for USB Core files and filesystem
 #
 
-usbcore-objs	:= usb.o hub.o hcd.o urb.o message.o \
+usbcore-objs	:= usb.o hub.o hcd.o urb.o message.o driver.o \
 			config.o file.o buffer.o sysfs.o devio.o notify.o
 
 ifeq ($(CONFIG_PCI),y)
--- /dev/null
+++ gregkh-2.6/drivers/usb/core/driver.c
@@ -0,0 +1,338 @@
+/*
+ * drivers/usb/driver.c - most of the driver model stuff for usb
+ *
+ * (C) Copyright 2005 Greg Kroah-Hartman <gregkh@suse.de>
+ *
+ * based on drivers/usb/usb.c which had the following copyrights:
+ *	(C) Copyright Linus Torvalds 1999
+ *	(C) Copyright Johannes Erdfelt 1999-2001
+ *	(C) Copyright Andreas Gal 1999
+ *	(C) Copyright Gregory P. Smith 1999
+ *	(C) Copyright Deti Fliegl 1999 (new USB architecture)
+ *	(C) Copyright Randy Dunlap 2000
+ *	(C) Copyright David Brownell 2000-2004
+ *	(C) Copyright Yggdrasil Computing, Inc. 2000
+ *		(usb_device_id matching changes by Adam J. Richter)
+ *	(C) Copyright Greg Kroah-Hartman 2002-2003
+ *
+ * NOTE! This is not actually a driver at all, rather this is
+ * just a collection of helper routines that implement the
+ * generic USB things that the real drivers can use..
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/device.h>
+#include <linux/usb.h>
+#include "hcd.h"
+#include "usb.h"
+
+static int generic_probe(struct device *dev)
+{
+	return 0;
+}
+static int generic_remove(struct device *dev)
+{
+	struct usb_device *udev = to_usb_device(dev);
+
+	/* if this is only an unbind, not a physical disconnect, then
+	 * unconfigure the device */
+	if (udev->state == USB_STATE_CONFIGURED)
+		usb_set_configuration(udev, 0);
+
+	/* in case the call failed or the device was suspended */
+	if (udev->state >= USB_STATE_CONFIGURED)
+		usb_disable_device(udev, 0);
+	return 0;
+}
+
+struct device_driver usb_generic_driver = {
+	.owner = THIS_MODULE,
+	.name =	"usb",
+	.bus = &usb_bus_type,
+	.probe = generic_probe,
+	.remove = generic_remove,
+};
+
+/* Fun hack to determine if the struct device is a
+ * usb device or a usb interface. */
+int usb_generic_driver_data;
+
+/* called from driver core with usb_bus_type.subsys writelock */
+static int usb_probe_interface(struct device *dev)
+{
+	struct usb_interface * intf = to_usb_interface(dev);
+	struct usb_driver * driver = to_usb_driver(dev->driver);
+	const struct usb_device_id *id;
+	int error = -ENODEV;
+
+	dev_dbg(dev, "%s\n", __FUNCTION__);
+
+	if (!driver->probe)
+		return error;
+	/* FIXME we'd much prefer to just resume it ... */
+	if (interface_to_usbdev(intf)->state == USB_STATE_SUSPENDED)
+		return -EHOSTUNREACH;
+
+	id = usb_match_id(intf, driver->id_table);
+	if (id) {
+		dev_dbg(dev, "%s - got id\n", __FUNCTION__);
+
+		/* Interface "power state" doesn't correspond to any hardware
+		 * state whatsoever.  We use it to record when it's bound to
+		 * a driver that may start I/0:  it's not frozen/quiesced.
+		 */
+		mark_active(intf);
+		intf->condition = USB_INTERFACE_BINDING;
+		error = driver->probe(intf, id);
+		if (error) {
+			mark_quiesced(intf);
+			intf->condition = USB_INTERFACE_UNBOUND;
+		} else
+			intf->condition = USB_INTERFACE_BOUND;
+	}
+
+	return error;
+}
+
+/* called from driver core with usb_bus_type.subsys writelock */
+static int usb_unbind_interface(struct device *dev)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct usb_driver *driver = to_usb_driver(intf->dev.driver);
+
+	intf->condition = USB_INTERFACE_UNBINDING;
+
+	/* release all urbs for this interface */
+	usb_disable_interface(interface_to_usbdev(intf), intf);
+
+	if (driver && driver->disconnect)
+		driver->disconnect(intf);
+
+	/* reset other interface state */
+	usb_set_interface(interface_to_usbdev(intf),
+			intf->altsetting[0].desc.bInterfaceNumber,
+			0);
+	usb_set_intfdata(intf, NULL);
+	intf->condition = USB_INTERFACE_UNBOUND;
+	mark_quiesced(intf);
+
+	return 0;
+}
+
+/**
+ * usb_match_id - find first usb_device_id matching device or interface
+ * @interface: the interface of interest
+ * @id: array of usb_device_id structures, terminated by zero entry
+ *
+ * usb_match_id searches an array of usb_device_id's and returns
+ * the first one matching the device or interface, or null.
+ * This is used when binding (or rebinding) a driver to an interface.
+ * Most USB device drivers will use this indirectly, through the usb core,
+ * but some layered driver frameworks use it directly.
+ * These device tables are exported with MODULE_DEVICE_TABLE, through
+ * modutils, to support the driver loading functionality of USB hotplugging.
+ *
+ * What Matches:
+ *
+ * The "match_flags" element in a usb_device_id controls which
+ * members are used.  If the corresponding bit is set, the
+ * value in the device_id must match its corresponding member
+ * in the device or interface descriptor, or else the device_id
+ * does not match.
+ *
+ * "driver_info" is normally used only by device drivers,
+ * but you can create a wildcard "matches anything" usb_device_id
+ * as a driver's "modules.usbmap" entry if you provide an id with
+ * only a nonzero "driver_info" field.  If you do this, the USB device
+ * driver's probe() routine should use additional intelligence to
+ * decide whether to bind to the specified interface.
+ *
+ * What Makes Good usb_device_id Tables:
+ *
+ * The match algorithm is very simple, so that intelligence in
+ * driver selection must come from smart driver id records.
+ * Unless you have good reasons to use another selection policy,
+ * provide match elements only in related groups, and order match
+ * specifiers from specific to general.  Use the macros provided
+ * for that purpose if you can.
+ *
+ * The most specific match specifiers use device descriptor
+ * data.  These are commonly used with product-specific matches;
+ * the USB_DEVICE macro lets you provide vendor and product IDs,
+ * and you can also match against ranges of product revisions.
+ * These are widely used for devices with application or vendor
+ * specific bDeviceClass values.
+ *
+ * Matches based on device class/subclass/protocol specifications
+ * are slightly more general; use the USB_DEVICE_INFO macro, or
+ * its siblings.  These are used with single-function devices
+ * where bDeviceClass doesn't specify that each interface has
+ * its own class.
+ *
+ * Matches based on interface class/subclass/protocol are the
+ * most general; they let drivers bind to any interface on a
+ * multiple-function device.  Use the USB_INTERFACE_INFO
+ * macro, or its siblings, to match class-per-interface style
+ * devices (as recorded in bDeviceClass).
+ *
+ * Within those groups, remember that not all combinations are
+ * meaningful.  For example, don't give a product version range
+ * without vendor and product IDs; or specify a protocol without
+ * its associated class and subclass.
+ */
+const struct usb_device_id *usb_match_id(struct usb_interface *interface,
+					 const struct usb_device_id *id)
+{
+	struct usb_host_interface *intf;
+	struct usb_device *dev;
+
+	/* proc_connectinfo in devio.c may call us with id == NULL. */
+	if (id == NULL)
+		return NULL;
+
+	intf = interface->cur_altsetting;
+	dev = interface_to_usbdev(interface);
+
+	/* It is important to check that id->driver_info is nonzero,
+	   since an entry that is all zeroes except for a nonzero
+	   id->driver_info is the way to create an entry that
+	   indicates that the driver want to examine every
+	   device and interface. */
+	for (; id->idVendor || id->bDeviceClass || id->bInterfaceClass ||
+	       id->driver_info; id++) {
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_VENDOR) &&
+		    id->idVendor != le16_to_cpu(dev->descriptor.idVendor))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_PRODUCT) &&
+		    id->idProduct != le16_to_cpu(dev->descriptor.idProduct))
+			continue;
+
+		/* No need to test id->bcdDevice_lo != 0, since 0 is never
+		   greater than any unsigned number. */
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_LO) &&
+		    (id->bcdDevice_lo > le16_to_cpu(dev->descriptor.bcdDevice)))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_HI) &&
+		    (id->bcdDevice_hi < le16_to_cpu(dev->descriptor.bcdDevice)))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_CLASS) &&
+		    (id->bDeviceClass != dev->descriptor.bDeviceClass))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_SUBCLASS) &&
+		    (id->bDeviceSubClass!= dev->descriptor.bDeviceSubClass))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_PROTOCOL) &&
+		    (id->bDeviceProtocol != dev->descriptor.bDeviceProtocol))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_CLASS) &&
+		    (id->bInterfaceClass != intf->desc.bInterfaceClass))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_SUBCLASS) &&
+		    (id->bInterfaceSubClass != intf->desc.bInterfaceSubClass))
+			continue;
+
+		if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_PROTOCOL) &&
+		    (id->bInterfaceProtocol != intf->desc.bInterfaceProtocol))
+			continue;
+
+		return id;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(usb_match_id);
+
+int usb_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct usb_interface *intf;
+	struct usb_driver *usb_drv;
+	const struct usb_device_id *id;
+
+	/* check for generic driver, which we don't match any device with */
+	if (drv == &usb_generic_driver)
+		return 0;
+
+	intf = to_usb_interface(dev);
+	usb_drv = to_usb_driver(drv);
+
+	id = usb_match_id(intf, usb_drv->id_table);
+	if (id)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * usb_register - register a USB driver
+ * @new_driver: USB operations for the driver
+ *
+ * Registers a USB driver with the USB core.  The list of unattached
+ * interfaces will be rescanned whenever a new driver is added, allowing
+ * the new driver to attach to any recognized devices.
+ * Returns a negative error code on failure and 0 on success.
+ *
+ * NOTE: if you want your driver to use the USB major number, you must call
+ * usb_register_dev() to enable that functionality.  This function no longer
+ * takes care of that.
+ */
+int usb_register(struct usb_driver *new_driver)
+{
+	int retval = 0;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	new_driver->driver.name = (char *)new_driver->name;
+	new_driver->driver.bus = &usb_bus_type;
+	new_driver->driver.probe = usb_probe_interface;
+	new_driver->driver.remove = usb_unbind_interface;
+	new_driver->driver.owner = new_driver->owner;
+
+	usb_lock_all_devices();
+	retval = driver_register(&new_driver->driver);
+	usb_unlock_all_devices();
+
+	if (!retval) {
+		pr_info("%s: registered new driver %s\n",
+			usbcore_name, new_driver->name);
+		usbfs_update_special();
+	} else {
+		printk(KERN_ERR "%s: error %d registering driver %s\n",
+			usbcore_name, retval, new_driver->name);
+	}
+
+	return retval;
+}
+EXPORT_SYMBOL(usb_register);
+
+/**
+ * usb_deregister - unregister a USB driver
+ * @driver: USB operations of the driver to unregister
+ * Context: must be able to sleep
+ *
+ * Unlinks the specified driver from the internal USB driver list.
+ *
+ * NOTE: If you called usb_register_dev(), you still need to call
+ * usb_deregister_dev() to clean up your driver's allocated minor numbers,
+ * this * call will no longer do it for you.
+ */
+void usb_deregister(struct usb_driver *driver)
+{
+	pr_info("%s: deregistering driver %s\n", usbcore_name, driver->name);
+
+	usb_lock_all_devices();
+	driver_unregister(&driver->driver);
+	usb_unlock_all_devices();
+
+	usbfs_update_special();
+}
+EXPORT_SYMBOL(usb_deregister);
--- gregkh-2.6.orig/drivers/usb/core/usb.h
+++ gregkh-2.6/drivers/usb/core/usb.h
@@ -33,6 +33,9 @@ extern void usb_host_cleanup(void);
 extern int usb_suspend_device(struct usb_device *dev);
 extern int usb_resume_device(struct usb_device *dev);
 
+extern struct device_driver usb_generic_driver;
+extern int usb_generic_driver_data;
+extern int usb_device_match(struct device *dev, struct device_driver *drv);
 
 /* Interfaces and their "power state" are owned by usbcore */
 
--- gregkh-2.6.orig/Documentation/DocBook/usb.tmpl
+++ gregkh-2.6/Documentation/DocBook/usb.tmpl
@@ -253,6 +253,7 @@
 !Edrivers/usb/core/urb.c
 !Edrivers/usb/core/message.c
 !Edrivers/usb/core/file.c
+!Edrivers/usb/core/driver.c
 !Edrivers/usb/core/usb.c
 !Edrivers/usb/core/hub.c
     </chapter>
