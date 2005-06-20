Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVFUCQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVFUCQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVFUCQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:16:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:35044 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261748AbVFTW7u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:50 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Fix up bus code and remove use of rwsem.
In-Reply-To: <1119308365431@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:25 -0700
Message-Id: <11193083652661@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix up bus code and remove use of rwsem.

- Don't add devices to bus's embedded kset, since it's not used by anyone anymore.
- Don't need to take the bus rwsem when calling {device,driver}_attach(), since
  those functions use the klists and the klists' spinlocks.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6eded061b1263847aedac7469339e99579aec5e5
tree 849eadc1c02df67e2d327880ce2ecc20975a856f
parent d4a7537122fa47a6ce41c5fdab53d844c78d7023
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 13:02:28 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:18 -0700

 drivers/base/bus.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -17,8 +17,6 @@
 #include "base.h"
 #include "power/power.h"
 
-#define to_dev(node) container_of(node, struct device, bus_list)
-
 #define to_bus_attr(_attr) container_of(_attr, struct bus_attribute, attr)
 #define to_bus(obj) container_of(obj, struct bus_type, subsys.kset.kobj)
 
@@ -271,11 +269,8 @@ int bus_add_device(struct device * dev)
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
@@ -300,11 +295,8 @@ void bus_remove_device(struct device * d
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
@@ -364,9 +356,7 @@ int bus_add_driver(struct device_driver 
 			return error;
 		}
 
-		down_write(&bus->subsys.rwsem);
 		driver_attach(drv);
-		up_write(&bus->subsys.rwsem);
 		klist_add_tail(&bus->klist_drivers, &drv->knode_bus);
 		module_add_driver(drv->owner, drv);
 
@@ -390,10 +380,8 @@ void bus_remove_driver(struct device_dri
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

