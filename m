Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbVKQAsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbVKQAsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbVKQAsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:48:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:40405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161061AbVKQAsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:48:03 -0500
Date: Wed, 16 Nov 2005 16:32:42 -0800
From: Greg KH <gregkh@suse.de>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 02/02] USB: add dynamic id functionality to USB core
Message-ID: <20051117003241.GC14896@kroah.com>
References: <20051117003053.GA14896@kroah.com> <20051117003139.GB14896@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117003139.GB14896@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Echo the usb vendor and product id to the "new_id" file in the driver's
sysfs directory, and then that driver will be able to bind to a device
with those ids if it is present.


Example:
	echo 0557 2008 > /sys/bus/usb/drivers/foo_driver/new_id
adds the hex values 0557 and 2008 to the device id table for the foo_driver.


Note, usb-serial drivers do not currently work with this capability yet.
usb-storage also might have some oddities.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/core/driver.c |  218 +++++++++++++++++++++++++++++++++++-----------
 include/linux/usb.h       |    8 +
 2 files changed, 176 insertions(+), 50 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/driver.c
+++ gregkh-2.6/drivers/usb/core/driver.c
@@ -27,6 +27,15 @@
 #include "hcd.h"
 #include "usb.h"
 
+static int usb_match_one_id(struct usb_interface *interface,
+			    const struct usb_device_id *id);
+
+struct usb_dynid {
+	struct list_head node;
+	struct usb_device_id id;
+};
+
+
 static int generic_probe(struct device *dev)
 {
 	return 0;
@@ -58,6 +67,96 @@ struct device_driver usb_generic_driver 
  * usb device or a usb interface. */
 int usb_generic_driver_data;
 
+#ifdef CONFIG_HOTPLUG
+
+/*
+ * Adds a new dynamic USBdevice ID to this driver,
+ * and cause the driver to probe for all devices again.
+ */
+static ssize_t store_new_id(struct device_driver *driver,
+			    const char *buf, size_t count)
+{
+	struct usb_driver *usb_drv = to_usb_driver(driver);
+	struct usb_dynid *dynid;
+	u32 idVendor = 0;
+	u32 idProduct = 0;
+	int fields = 0;
+
+	fields = sscanf(buf, "%x %x", &idVendor, &idProduct);
+	if (fields < 0)
+		return -EINVAL;
+
+	dynid = kzalloc(sizeof(*dynid), GFP_KERNEL);
+	if (!dynid)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&dynid->node);
+	dynid->id.idVendor = idVendor;
+	dynid->id.idProduct = idProduct;
+	dynid->id.match_flags = USB_DEVICE_ID_MATCH_DEVICE;
+
+	spin_lock(&usb_drv->dynids.lock);
+	list_add_tail(&usb_drv->dynids.list, &dynid->node);
+	spin_unlock(&usb_drv->dynids.lock);
+
+	if (get_driver(&usb_drv->driver)) {
+		driver_attach(&usb_drv->driver);
+		put_driver(&usb_drv->driver);
+	}
+
+	return count;
+}
+static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
+
+static int usb_create_newid_file(struct usb_driver *usb_drv)
+{
+	int error = 0;
+
+	if (usb_drv->probe != NULL)
+		error = sysfs_create_file(&usb_drv->driver.kobj,
+					  &driver_attr_new_id.attr);
+	return error;
+}
+
+static void usb_free_dynids(struct usb_driver *usb_drv)
+{
+	struct usb_dynid *dynid, *n;
+
+	spin_lock(&usb_drv->dynids.lock);
+	list_for_each_entry_safe(dynid, n, &usb_drv->dynids.list, node) {
+		list_del(&dynid->node);
+		kfree(dynid);
+	}
+	spin_unlock(&usb_drv->dynids.lock);
+}
+#else
+static inline int usb_create_newid_file(struct usb_driver *usb_drv)
+{
+	return 0;
+}
+
+static inline void usb_free_dynids(struct usb_driver *usb_drv)
+{
+}
+#endif
+
+static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
+							struct usb_driver *drv)
+{
+	struct usb_dynid *dynid;
+
+	spin_lock(&drv->dynids.lock);
+	list_for_each_entry(dynid, &drv->dynids.list, node) {
+		if (usb_match_one_id(intf, &dynid->id)) {
+			spin_unlock(&drv->dynids.lock);
+			return &dynid->id;
+		}
+	}
+	spin_unlock(&drv->dynids.lock);
+	return NULL;
+}
+
+
 /* called from driver core with usb_bus_type.subsys writelock */
 static int usb_probe_interface(struct device *dev)
 {
@@ -75,6 +174,8 @@ static int usb_probe_interface(struct de
 		return -EHOSTUNREACH;
 
 	id = usb_match_id(intf, driver->id_table);
+	if (!id)
+		id = usb_match_dynamic_id(intf, driver);
 	if (id) {
 		dev_dbg(dev, "%s - got id\n", __FUNCTION__);
 
@@ -120,6 +221,64 @@ static int usb_unbind_interface(struct d
 	return 0;
 }
 
+/* returns 0 if no match, 1 if match */
+static int usb_match_one_id(struct usb_interface *interface,
+			    const struct usb_device_id *id)
+{
+	struct usb_host_interface *intf;
+	struct usb_device *dev;
+
+	/* proc_connectinfo in devio.c may call us with id == NULL. */
+	if (id == NULL)
+		return 0;
+
+	intf = interface->cur_altsetting;
+	dev = interface_to_usbdev(interface);
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_VENDOR) &&
+	    id->idVendor != le16_to_cpu(dev->descriptor.idVendor))
+		return 0;
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_PRODUCT) &&
+	    id->idProduct != le16_to_cpu(dev->descriptor.idProduct))
+		return 0;
+
+	/* No need to test id->bcdDevice_lo != 0, since 0 is never
+	   greater than any unsigned number. */
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_LO) &&
+	    (id->bcdDevice_lo > le16_to_cpu(dev->descriptor.bcdDevice)))
+		return 0;
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_HI) &&
+	    (id->bcdDevice_hi < le16_to_cpu(dev->descriptor.bcdDevice)))
+		return 0;
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_CLASS) &&
+	    (id->bDeviceClass != dev->descriptor.bDeviceClass))
+		return 0;
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_SUBCLASS) &&
+	    (id->bDeviceSubClass!= dev->descriptor.bDeviceSubClass))
+		return 0;
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_PROTOCOL) &&
+	    (id->bDeviceProtocol != dev->descriptor.bDeviceProtocol))
+		return 0;
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_CLASS) &&
+	    (id->bInterfaceClass != intf->desc.bInterfaceClass))
+		return 0;
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_SUBCLASS) &&
+	    (id->bInterfaceSubClass != intf->desc.bInterfaceSubClass))
+		return 0;
+
+	if ((id->match_flags & USB_DEVICE_ID_MATCH_INT_PROTOCOL) &&
+	    (id->bInterfaceProtocol != intf->desc.bInterfaceProtocol))
+		return 0;
+
+	return 1;
+}
 /**
  * usb_match_id - find first usb_device_id matching device or interface
  * @interface: the interface of interest
@@ -184,16 +343,10 @@ static int usb_unbind_interface(struct d
 const struct usb_device_id *usb_match_id(struct usb_interface *interface,
 					 const struct usb_device_id *id)
 {
-	struct usb_host_interface *intf;
-	struct usb_device *dev;
-
 	/* proc_connectinfo in devio.c may call us with id == NULL. */
 	if (id == NULL)
 		return NULL;
 
-	intf = interface->cur_altsetting;
-	dev = interface_to_usbdev(interface);
-
 	/* It is important to check that id->driver_info is nonzero,
 	   since an entry that is all zeroes except for a nonzero
 	   id->driver_info is the way to create an entry that
@@ -201,50 +354,8 @@ const struct usb_device_id *usb_match_id
 	   device and interface. */
 	for (; id->idVendor || id->bDeviceClass || id->bInterfaceClass ||
 	       id->driver_info; id++) {
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
+		if (usb_match_one_id(interface, id))
+			return id;
 	}
 
 	return NULL;
@@ -268,6 +379,9 @@ int usb_device_match(struct device *dev,
 	if (id)
 		return 1;
 
+	id = usb_match_dynamic_id(intf, usb_drv);
+	if (id)
+		return 1;
 	return 0;
 }
 
@@ -296,6 +410,8 @@ int usb_register(struct usb_driver *new_
 	new_driver->driver.probe = usb_probe_interface;
 	new_driver->driver.remove = usb_unbind_interface;
 	new_driver->driver.owner = new_driver->owner;
+	spin_lock_init(&new_driver->dynids.lock);
+	INIT_LIST_HEAD(&new_driver->dynids.list);
 
 	usb_lock_all_devices();
 	retval = driver_register(&new_driver->driver);
@@ -305,6 +421,7 @@ int usb_register(struct usb_driver *new_
 		pr_info("%s: registered new driver %s\n",
 			usbcore_name, new_driver->name);
 		usbfs_update_special();
+		usb_create_newid_file(new_driver);
 	} else {
 		printk(KERN_ERR "%s: error %d registering driver %s\n",
 			usbcore_name, retval, new_driver->name);
@@ -330,6 +447,7 @@ void usb_deregister(struct usb_driver *d
 	pr_info("%s: deregistering driver %s\n", usbcore_name, driver->name);
 
 	usb_lock_all_devices();
+	usb_free_dynids(driver);
 	driver_unregister(&driver->driver);
 	usb_unlock_all_devices();
 
--- gregkh-2.6.orig/include/linux/usb.h
+++ gregkh-2.6/include/linux/usb.h
@@ -528,6 +528,11 @@ static inline int usb_make_path (struct 
 
 /* ----------------------------------------------------------------------- */
 
+struct usb_dynids {
+	spinlock_t lock;
+	struct list_head list;
+};
+
 /**
  * struct usb_driver - identifies USB driver to usbcore
  * @owner: Pointer to the module owner of this driver; initialize
@@ -552,6 +557,8 @@ static inline int usb_make_path (struct 
  * @id_table: USB drivers use ID table to support hotplugging.
  *	Export this with MODULE_DEVICE_TABLE(usb,...).  This must be set
  *	or your driver's probe function will never get called.
+ * @dynids: used internally to hold the list of dynamically added device
+ *	ids for this driver.
  * @driver: the driver model core driver structure.
  *
  * USB drivers must provide a name, probe() and disconnect() methods,
@@ -587,6 +594,7 @@ struct usb_driver {
 
 	const struct usb_device_id *id_table;
 
+	struct usb_dynids dynids;
 	struct device_driver driver;
 };
 #define	to_usb_driver(d) container_of(d, struct usb_driver, driver)
