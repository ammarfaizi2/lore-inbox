Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWFUTt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWFUTt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWFUTtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:49:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:65456 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030235AbWFUTtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:20 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/22] [PATCH] Driver core: bus device event delay
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:47 -0700
Message-Id: <1150919175882-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509191721672-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@suse.de>

split bus_add_device() and send device uevents after sysfs population

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/base.h |    1 +
 drivers/base/bus.c  |   22 ++++++++++++++++++----
 drivers/base/core.c |    3 ++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 5735b38..bbbc2ac 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -11,6 +11,7 @@ extern int cpu_dev_init(void);
 extern int attribute_container_init(void);
 
 extern int bus_add_device(struct device * dev);
+extern void bus_attach_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 
 extern int bus_add_driver(struct device_driver *);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 76656ac..b27a606 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -362,8 +362,7 @@ static void device_remove_attrs(struct b
  *	@dev:	device being added
  *
  *	- Add the device to its bus's list of devices.
- *	- Try to attach to driver.
- *	- Create link to device's physical location.
+ *	- Create link to device's bus.
  */
 int bus_add_device(struct device * dev)
 {
@@ -372,8 +371,6 @@ int bus_add_device(struct device * dev)
 
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		device_attach(dev);
-		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 		error = device_add_attrs(bus, dev);
 		if (!error) {
 			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
@@ -384,6 +381,22 @@ int bus_add_device(struct device * dev)
 }
 
 /**
+ *	bus_attach_device - add device to bus
+ *	@dev:	device tried to attach to a driver
+ *
+ *	- Try to attach to driver.
+ */
+void bus_attach_device(struct device * dev)
+{
+	struct bus_type * bus = dev->bus;
+
+	if (bus) {
+		device_attach(dev);
+		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
+	}
+}
+
+/**
  *	bus_remove_device - remove device from bus
  *	@dev:	device to be removed
  *
@@ -733,6 +746,7 @@ EXPORT_SYMBOL_GPL(bus_find_device);
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
 
 EXPORT_SYMBOL_GPL(bus_add_device);
+EXPORT_SYMBOL_GPL(bus_attach_device);
 EXPORT_SYMBOL_GPL(bus_remove_device);
 EXPORT_SYMBOL_GPL(bus_register);
 EXPORT_SYMBOL_GPL(bus_unregister);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6b355bd..d5e15a0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -274,11 +274,12 @@ int device_add(struct device *dev)
 	dev->uevent_attr.store = store_uevent;
 	device_create_file(dev, &dev->uevent_attr);
 
-	kobject_uevent(&dev->kobj, KOBJ_ADD);
 	if ((error = device_pm_add(dev)))
 		goto PMError;
 	if ((error = bus_add_device(dev)))
 		goto BusError;
+	kobject_uevent(&dev->kobj, KOBJ_ADD);
+	bus_attach_device(dev);
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
-- 
1.4.0

