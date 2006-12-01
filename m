Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162236AbWLAXWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162236AbWLAXWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162239AbWLAXWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:22:23 -0500
Received: from mx1.suse.de ([195.135.220.2]:9613 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162236AbWLAXWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:22 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/36] Driver core: add notification of bus events
Date: Fri,  1 Dec 2006 15:21:31 -0800
Message-Id: <11650153262399-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <20061201231620.GA7560@kroah.com>
References: <20061201231620.GA7560@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I finally did as you suggested and added the notifier to the struct
bus_type itself. There are still problems to be expected is something
attaches to a bus type where the code can hook in different struct
device sub-classes (which is imho a big bogosity but I won't even try to
argue that case now) but it will solve nicely a number of issues I've
had so far.

That also means that clients interested in registering for such
notifications have to do it before devices are added and after bus types
are registered. Fortunately, most bus types that matter for the various
usage scenarios I have in mind are registerd at postcore_initcall time,
which means I have a really nice spot at arch_initcall time to add my
notifiers.

There are 4 notifications provided. Device being added (before hooked to
the bus) and removed (failure of previous case or after being unhooked
from the bus), along with driver being bound to a device and about to be
unbound.

The usage I have for these are:

 - The 2 first ones are used to maintain a struct device_ext that is
hooked to struct device.firmware_data. This structure contains for now a
pointer to the Open Firmware node related to the device (if any), the
NUMA node ID (for quick access to it) and the DMA operations pointers &
iommu table instance for DMA to/from this device. For bus types I own
(like IBM VIO or EBUS), I just maintain that structure directly from the
bus code when creating the devices. But for bus types managed by generic
code like PCI or platform (actually, of_platform which is a variation of
platform linked to Open Firmware device-tree), I need this notifier.

 - The other two ones have a completely different usage scenario. I have
cases where multiple devices and their drivers depend on each other. For
example, the IBM EMAC network driver needs to attach to a MAL DMA engine
which is a separate device, and a PHY interface which is also a separate
device. They are all of_platform_device's (well, about to be with my
upcoming patches) but there is no say in what precise order the core
will "probe" them and instanciate the various modules. The solution I
found for that is to have the drivers for emac to use multithread_probe,
and wait for a driver to be bound to the target MAL and PHY control
devices (the device-tree contains reference to the MAL and PHY interface
nodes, which I can then match to of_platform_devices). Right now, I've
been polling, but with that notifier, I can more cleanly wait (with a
timeout of course).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c     |   14 ++++++++++++++
 drivers/base/core.c    |   12 ++++++++++++
 drivers/base/dd.c      |   10 ++++++++++
 include/linux/device.h |   25 +++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 7d8a7ce..ed3e8a2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -724,6 +724,8 @@ int bus_register(struct bus_type * bus)
 {
 	int retval;
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&bus->bus_notifier);
+
 	retval = kobject_set_name(&bus->subsys.kset.kobj, "%s", bus->name);
 	if (retval)
 		goto out;
@@ -782,6 +784,18 @@ void bus_unregister(struct bus_type * bu
 	subsystem_unregister(&bus->subsys);
 }
 
+int bus_register_notifier(struct bus_type *bus, struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&bus->bus_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(bus_register_notifier);
+
+int bus_unregister_notifier(struct bus_type *bus, struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&bus->bus_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(bus_unregister_notifier);
+
 int __init buses_init(void)
 {
 	return subsystem_register(&bus_subsys);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 002fde4..d4f35d8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/notifier.h>
 
 #include <asm/semaphore.h>
 
@@ -428,6 +429,11 @@ int device_add(struct device *dev)
 	if (platform_notify)
 		platform_notify(dev);
 
+	/* notify clients of device entry (new way) */
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->bus_notifier,
+					     BUS_NOTIFY_ADD_DEVICE, dev);
+
 	dev->uevent_attr.attr.name = "uevent";
 	dev->uevent_attr.attr.mode = S_IWUSR;
 	if (dev->driver)
@@ -504,6 +510,9 @@ int device_add(struct device *dev)
  BusError:
 	device_pm_remove(dev);
  PMError:
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->bus_notifier,
+					     BUS_NOTIFY_DEL_DEVICE, dev);
 	device_remove_groups(dev);
  GroupError:
  	device_remove_attrs(dev);
@@ -622,6 +631,9 @@ void device_del(struct device * dev)
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->bus_notifier,
+					     BUS_NOTIFY_DEL_DEVICE, dev);
 	bus_remove_device(dev);
 	device_pm_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c5d6bb4..9c88b1e 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -52,6 +52,11 @@ int device_bind_driver(struct device *de
 
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
+
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->bus_notifier,
+					     BUS_NOTIFY_BOUND_DRIVER, dev);
+
 	klist_add_tail(&dev->knode_driver, &dev->driver->klist_devices);
 	ret = sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
@@ -288,6 +293,11 @@ static void __device_release_driver(stru
 		sysfs_remove_link(&dev->kobj, "driver");
 		klist_remove(&dev->knode_driver);
 
+		if (dev->bus)
+			blocking_notifier_call_chain(&dev->bus->bus_notifier,
+						     BUS_NOTIFY_UNBIND_DRIVER,
+						     dev);
+
 		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
diff --git a/include/linux/device.h b/include/linux/device.h
index 9d4f6a9..b00e027 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -42,6 +42,8 @@ struct bus_type {
 	struct klist		klist_devices;
 	struct klist		klist_drivers;
 
+	struct blocking_notifier_head bus_notifier;
+
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
 	struct driver_attribute	* drv_attrs;
@@ -75,6 +77,29 @@ int __must_check bus_for_each_drv(struct
 		struct device_driver *start, void *data,
 		int (*fn)(struct device_driver *, void *));
 
+/*
+ * Bus notifiers: Get notified of addition/removal of devices
+ * and binding/unbinding of drivers to devices.
+ * In the long run, it should be a replacement for the platform
+ * notify hooks.
+ */
+struct notifier_block;
+
+extern int bus_register_notifier(struct bus_type *bus,
+				 struct notifier_block *nb);
+extern int bus_unregister_notifier(struct bus_type *bus,
+				   struct notifier_block *nb);
+
+/* All 4 notifers below get called with the target struct device *
+ * as an argument. Note that those functions are likely to be called
+ * with the device semaphore held in the core, so be careful.
+ */
+#define BUS_NOTIFY_ADD_DEVICE		0x00000001 /* device added */
+#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device removed */
+#define BUS_NOTIFY_BOUND_DRIVER		0x00000003 /* driver bound to device */
+#define BUS_NOTIFY_UNBIND_DRIVER	0x00000004 /* driver about to be
+						      unbound */
+
 /* driverfs interface for exporting bus attributes */
 
 struct bus_attribute {
-- 
1.4.4.1

