Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVCYGRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVCYGRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCYGKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:10:37 -0500
Received: from digitalimplant.org ([64.62.235.95]:5075 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261418AbVCYFyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:46 -0500
Date: Thu, 24 Mar 2005 21:54:38 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [5/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242151270.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2243, 2005-03-24 13:02:28-08:00, mochel@digitalimplant.org
  [driver core] Fix up bus code and remove use of rwsem.

  - Don't add devices to bus's embedded kset, since it's not used by anyone anymore.
  - Don't need to take the bus rwsem when calling {device,driver}_attach(), since
    those functions use the klists and the klists' spinlocks.


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-03-24 20:33:31 -08:00
+++ b/drivers/base/bus.c	2005-03-24 20:33:31 -08:00
@@ -17,8 +17,6 @@
 #include "base.h"
 #include "power/power.h"

-#define to_dev(node) container_of(node, struct device, bus_list)
-
 #define to_bus_attr(_attr) container_of(_attr, struct bus_attribute, attr)
 #define to_bus(obj) container_of(obj, struct bus_type, subsys.kset.kobj)

@@ -272,11 +270,8 @@
 	int error = 0;

 	if (bus) {
-		down_write(&dev->bus->subsys.rwsem);
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
 		device_attach(dev);
-		up_write(&dev->bus->subsys.rwsem);
 		klist_add_tail(&bus->klist_devices, &dev->knode_bus);
 		device_add_attrs(bus, dev);
 		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
@@ -301,11 +296,8 @@
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
 		klist_remove(&dev->knode_bus);
-		down_write(&dev->bus->subsys.rwsem);
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
-		list_del_init(&dev->bus_list);
-		up_write(&dev->bus->subsys.rwsem);
 		put_bus(dev->bus);
 	}
 }
@@ -365,9 +357,7 @@
 			return error;
 		}

-		down_write(&bus->subsys.rwsem);
 		driver_attach(drv);
-		up_write(&bus->subsys.rwsem);
 		klist_add_tail(&bus->klist_drivers, &drv->knode_bus);
 		module_add_driver(drv->owner, drv);

@@ -391,10 +381,8 @@
 	if (drv->bus) {
 		driver_remove_attrs(drv->bus, drv);
 		klist_remove(&drv->knode_bus);
-		down_write(&drv->bus->subsys.rwsem);
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
-		up_write(&drv->bus->subsys.rwsem);
 		module_remove_driver(drv);
 		kobject_unregister(&drv->kobj);
 		put_bus(drv->bus);
