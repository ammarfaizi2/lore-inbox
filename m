Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWAZURI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWAZURI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWAZURI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:17:08 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:62950 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751414AbWAZURH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:17:07 -0500
Date: Thu, 26 Jan 2006 15:17:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver core: better reference counting for klists
Message-ID: <Pine.LNX.4.44L0.0601261415140.4713-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

This is a revised version (as641b) of the earlier patch that James 
Bottomley didn't like.  It goes in the direction of eliminating 
klist_remove entirely.  (One more patch is still needed...)

	Add an is_registered flag to struct device, so that drivers
	won't get bound to a device after it is gone.

	When unregistering a driver, use the drv->unloaded completion
	to wait for the device_driver structure to be removed from
	the bus's klist instead of using klist_remove.  This also
	eliminates the need for the klist_drivers_get method.  (It's
	not a violation of the refcounting credo, because we have to
	wait in any case for the driver to be completely idle before 
	driver_unregister can return.)

	Likewise, the klist_devices_get and klist_devices_put methods
	in drivers.c aren't needed, because we always have to wait for
	a device to be completely removed from its driver's klist.  In
	fact, this is the last remaining usage of klist_remove.

	Move the call to a klist's put method outside the scope of the
	spinlock (i.e., move it from klist_release to klist_del and
	klist_next).

The one unpalatable aspect of this patch is that it adds a new single-bit 
flag to struct device, thereby increasing the structure's size by at least 
4 bytes.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/dd.c
===================================================================
--- usb-2.6.orig/drivers/base/dd.c
+++ usb-2.6/drivers/base/dd.c
@@ -72,6 +72,8 @@ int driver_probe_device(struct device_dr
 {
 	int ret = 0;
 
+	if (!device_is_registered(dev))
+		return -ENODEV;
 	if (drv->bus->match && !drv->bus->match(dev, drv))
 		goto Done;
 
Index: usb-2.6/drivers/base/bus.c
===================================================================
--- usb-2.6.orig/drivers/base/bus.c
+++ usb-2.6/drivers/base/bus.c
@@ -367,6 +367,7 @@ int bus_add_device(struct device * dev)
 
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
+		dev->is_registered = 1;
 		device_attach(dev);
 		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 		error = device_add_attrs(bus, dev);
@@ -393,7 +394,8 @@ void bus_remove_device(struct device * d
 		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
-		klist_remove(&dev->knode_bus);
+		klist_del(&dev->knode_bus);
+		dev->is_registered = 0;
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		put_bus(dev->bus);
@@ -500,7 +502,8 @@ void bus_remove_driver(struct device_dri
 	if (drv->bus) {
 		remove_bind_files(drv);
 		driver_remove_attrs(drv->bus, drv);
-		klist_remove(&drv->knode_bus);
+		klist_del(&drv->knode_bus);
+		wait_for_completion(&drv->unloaded);
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
 		module_remove_driver(drv);
@@ -613,20 +616,12 @@ static void klist_devices_put(struct kli
 	put_device(dev);
 }
 
-static void klist_drivers_get(struct klist_node *n)
-{
-	struct device_driver *drv = container_of(n, struct device_driver,
-						 knode_bus);
-
-	get_driver(drv);
-}
-
 static void klist_drivers_put(struct klist_node *n)
 {
 	struct device_driver *drv = container_of(n, struct device_driver,
 						 knode_bus);
 
-	put_driver(drv);
+	complete(&drv->unloaded);
 }
 
 /**
@@ -664,7 +659,7 @@ int bus_register(struct bus_type * bus)
 		goto bus_drivers_fail;
 
 	klist_init(&bus->klist_devices, klist_devices_get, klist_devices_put);
-	klist_init(&bus->klist_drivers, klist_drivers_get, klist_drivers_put);
+	klist_init(&bus->klist_drivers, NULL, klist_drivers_put);
 	bus_add_attrs(bus);
 
 	pr_debug("bus type '%s' registered\n", bus->name);
Index: usb-2.6/drivers/base/driver.c
===================================================================
--- usb-2.6.orig/drivers/base/driver.c
+++ usb-2.6/drivers/base/driver.c
@@ -143,20 +143,6 @@ void put_driver(struct device_driver * d
 	kobject_put(&drv->kobj);
 }
 
-static void klist_devices_get(struct klist_node *n)
-{
-	struct device *dev = container_of(n, struct device, knode_driver);
-
-	get_device(dev);
-}
-
-static void klist_devices_put(struct klist_node *n)
-{
-	struct device *dev = container_of(n, struct device, knode_driver);
-
-	put_device(dev);
-}
-
 /**
  *	driver_register - register driver with bus
  *	@drv:	driver to register
@@ -176,7 +162,7 @@ int driver_register(struct device_driver
 	    (drv->bus->shutdown && drv->shutdown)) {
 		printk(KERN_WARNING "Driver '%s' needs updating - please use bus_type methods\n", drv->name);
 	}
-	klist_init(&drv->klist_devices, klist_devices_get, klist_devices_put);
+	klist_init(&drv->klist_devices, NULL, NULL);
 	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }
Index: usb-2.6/lib/klist.c
===================================================================
--- usb-2.6.orig/lib/klist.c
+++ usb-2.6/lib/klist.c
@@ -123,12 +123,10 @@ EXPORT_SYMBOL_GPL(klist_add_tail);
 static void klist_release(struct kref * kref)
 {
 	struct klist_node * n = container_of(kref, struct klist_node, n_ref);
-	void (*put)(struct klist_node *) = n->n_klist->put;
+
 	list_del(&n->n_node);
 	complete(&n->n_removed);
 	n->n_klist = NULL;
-	if (put)
-		put(n);
 }
 
 static int klist_dec_and_del(struct klist_node * n)
@@ -145,10 +143,14 @@ static int klist_dec_and_del(struct klis
 void klist_del(struct klist_node * n)
 {
 	struct klist * k = n->n_klist;
+	void (*put)(struct klist_node *) = k->put;
 
 	spin_lock(&k->k_lock);
-	klist_dec_and_del(n);
+	if (!klist_dec_and_del(n))
+		put = NULL;
 	spin_unlock(&k->k_lock);
+	if (put)
+		put(n);
 }
 
 EXPORT_SYMBOL_GPL(klist_del);
@@ -161,10 +163,7 @@ EXPORT_SYMBOL_GPL(klist_del);
 
 void klist_remove(struct klist_node * n)
 {
-	struct klist * k = n->n_klist;
-	spin_lock(&k->k_lock);
-	klist_dec_and_del(n);
-	spin_unlock(&k->k_lock);
+	klist_del(n);
 	wait_for_completion(&n->n_removed);
 }
 
@@ -260,12 +259,15 @@ static struct klist_node * to_klist_node
 struct klist_node * klist_next(struct klist_iter * i)
 {
 	struct list_head * next;
+	struct klist_node * lnode = i->i_cur;
 	struct klist_node * knode = NULL;
+	void (*put)(struct klist_node *) = i->i_klist->put;
 
 	spin_lock(&i->i_klist->k_lock);
-	if (i->i_cur) {
-		next = i->i_cur->n_node.next;
-		klist_dec_and_del(i->i_cur);
+	if (lnode) {
+		next = lnode->n_node.next;
+		if (!klist_dec_and_del(lnode))
+			put = NULL;
 	} else
 		next = i->i_head->next;
 
@@ -275,6 +277,8 @@ struct klist_node * klist_next(struct kl
 	}
 	i->i_cur = knode;
 	spin_unlock(&i->i_klist->k_lock);
+	if (put && lnode)
+		put(lnode);
 	return knode;
 }
 
Index: usb-2.6/include/linux/device.h
===================================================================
--- usb-2.6.orig/include/linux/device.h
+++ usb-2.6/include/linux/device.h
@@ -311,6 +311,7 @@ struct device {
 
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
+	u8	is_registered;
 	struct device_attribute uevent_attr;
 
 	struct semaphore	sem;	/* semaphore to synchronize calls to
@@ -356,7 +357,7 @@ dev_set_drvdata (struct device *dev, voi
 
 static inline int device_is_registered(struct device *dev)
 {
-	return klist_node_attached(&dev->knode_bus);
+	return dev->is_registered;
 }
 
 /*

