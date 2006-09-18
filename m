Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWIRUYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWIRUYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWIRUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:24:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51717 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964863AbWIRUY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:24:29 -0400
Date: Mon, 18 Sep 2006 16:24:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] Remove unneeded routines from driver core
Message-ID: <Pine.LNX.4.44L0.0609181622350.7192-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as783) simplifies the driver core slightly by removing four
unnecessary _get and _put methods.

It is vital that when a driver is removed from its bus's klist of
registered drivers, or when a device is removed from a driver's klist
of bound devices, that the klist updates complete synchronously.
Otherwise the kernel might try binding an unregistered driver to a
newly-registered device, or adding a device to the klist for a new
driver before it has been removed from the old driver's klist.

Since the removals must be synchronous, they don't need to update any
reference counts.  Hence the _get and _put methods can be dispensed
with.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

This patch is based on 2.6.18-rc6-mm2.  It will need a small, obvious
adjustment before it can be applied to the gregkh-all tree.

Index: mm2/drivers/base/bus.c
===================================================================
--- mm2.orig/drivers/base/bus.c
+++ mm2/drivers/base/bus.c
@@ -725,22 +725,6 @@ static void klist_devices_put(struct kli
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
-static void klist_drivers_put(struct klist_node *n)
-{
-	struct device_driver *drv = container_of(n, struct device_driver,
-						 knode_bus);
-
-	put_driver(drv);
-}
-
 /**
  *	bus_register - register a bus with the system.
  *	@bus:	bus.
@@ -776,7 +760,7 @@ int bus_register(struct bus_type * bus)
 		goto bus_drivers_fail;
 
 	klist_init(&bus->klist_devices, klist_devices_get, klist_devices_put);
-	klist_init(&bus->klist_drivers, klist_drivers_get, klist_drivers_put);
+	klist_init(&bus->klist_drivers, NULL, NULL);
 	retval = bus_add_attrs(bus);
 	if (retval)
 		goto bus_attrs_fail;
Index: mm2/drivers/base/driver.c
===================================================================
--- mm2.orig/drivers/base/driver.c
+++ mm2/drivers/base/driver.c
@@ -142,20 +142,6 @@ void put_driver(struct device_driver * d
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
@@ -175,7 +161,7 @@ int driver_register(struct device_driver
 	    (drv->bus->shutdown && drv->shutdown)) {
 		printk(KERN_WARNING "Driver '%s' needs updating - please use bus_type methods\n", drv->name);
 	}
-	klist_init(&drv->klist_devices, klist_devices_get, klist_devices_put);
+	klist_init(&drv->klist_devices, NULL, NULL);
 	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }

