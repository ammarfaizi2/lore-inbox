Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWIZFmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWIZFmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWIZFky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:40:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:3030 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751477AbWIZFkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:32 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 46/47] Driver core: Remove unneeded routines from driver core
Date: Mon, 25 Sep 2006 22:38:06 -0700
Message-Id: <1159249232139-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <115924922922-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com> <11592492193773-gi
 t-send-email-greg@kroah.com> <11592492221573-git-send-email-greg@kroah.com> <1159249226922-git-send-email-greg@kroah.com> <115924922922-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c    |   18 +-----------------
 drivers/base/driver.c |   16 +---------------
 2 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 636af53..12173d1 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -696,22 +696,6 @@ static void klist_devices_put(struct kli
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
@@ -747,7 +731,7 @@ int bus_register(struct bus_type * bus)
 		goto bus_drivers_fail;
 
 	klist_init(&bus->klist_devices, klist_devices_get, klist_devices_put);
-	klist_init(&bus->klist_drivers, klist_drivers_get, klist_drivers_put);
+	klist_init(&bus->klist_drivers, NULL, NULL);
 	bus_add_attrs(bus);
 
 	pr_debug("bus type '%s' registered\n", bus->name);
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 562600d..1214cbd 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
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
-- 
1.4.2.1

