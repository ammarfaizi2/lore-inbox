Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWIRUWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWIRUWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWIRUWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:22:36 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50949 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751918AbWIRUWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:22:36 -0400
Date: Mon, 18 Sep 2006 16:22:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] Fix potential deadlock in driver core
Message-ID: <Pine.LNX.4.44L0.0609181620590.7192-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential deadlock in the driver core.  It boils down to
the fact that bus_remove_device() calls klist_remove() instead of
klist_del(), thereby waiting until the reference count of the
klist_node in the bus's klist of devices drops to 0.  The refcount
can't reach 0 so long as a modprobe process is trying to bind a new
driver to the device being removed, by calling __driver_attach().  The
problem is that __driver_attach() tries to acquire the device's
parent's semaphore, but the caller of bus_remove_device() is quite
likely to own that semaphore already.

It isn't sufficient just to replace klist_remove() with klist_del().
Doing so runs the risk that the device would remain on the bus's klist
of devices for some time, and so could be bound to another driver even
after it was unregistered.  What's needed is a new way to distinguish
whether or not a device is registered, based on a criterion other than
whether its klist_node is linked into the bus's klist of devices.  That
way driver binding can fail when the device is unregistered, even if
it is still linked into the klist.

This patch (as782) implements the solution, by adding a new bitflag to
indiate when a struct device is registered, by testing the flag before
allowing a driver to bind a device, and by changing the definition of
the device_is_registered() inline.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: mm2/drivers/base/dd.c
===================================================================
--- mm2.orig/drivers/base/dd.c
+++ mm2/drivers/base/dd.c
@@ -162,6 +162,8 @@ int driver_probe_device(struct device_dr
 	struct task_struct *probe_task;
 	int ret = 0;
 
+	if (!device_is_registered(dev))
+		return -ENODEV;
 	if (drv->bus->match && !drv->bus->match(dev, drv))
 		goto done;
 
Index: mm2/drivers/base/bus.c
===================================================================
--- mm2.orig/drivers/base/bus.c
+++ mm2/drivers/base/bus.c
@@ -402,6 +402,7 @@ out:
  *	bus_attach_device - add device to bus
  *	@dev:	device tried to attach to a driver
  *
+ *	- Add device to bus's list of devices.
  *	- Try to attach to driver.
  */
 int bus_attach_device(struct device * dev)
@@ -410,11 +411,13 @@ int bus_attach_device(struct device * de
 	int ret = 0;
 
 	if (bus) {
+		dev->is_registered = 1;
 		ret = device_attach(dev);
 		if (ret >= 0) {
 			klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 			ret = 0;
-		}
+		} else
+			dev->is_registered = 0;
 	}
 	return ret;
 }
@@ -454,7 +457,8 @@ void bus_remove_device(struct device * d
 		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
-		klist_remove(&dev->knode_bus);
+		dev->is_registered = 0;
+		klist_del(&dev->knode_bus);
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		put_bus(dev->bus);
Index: mm2/include/linux/device.h
===================================================================
--- mm2.orig/include/linux/device.h
+++ mm2/include/linux/device.h
@@ -322,6 +322,7 @@ struct device {
 
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
+	unsigned		is_registered:1;
 	struct device_attribute uevent_attr;
 	struct device_attribute *devt_attr;
 
@@ -374,7 +375,7 @@ dev_set_drvdata (struct device *dev, voi
 
 static inline int device_is_registered(struct device *dev)
 {
-	return klist_node_attached(&dev->knode_bus);
+	return dev->is_registered;
 }
 
 /*

