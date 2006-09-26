Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWIZFl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWIZFl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWIZFlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:41:10 -0400
Received: from mail.suse.de ([195.135.220.2]:482 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751462AbWIZFkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:15 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 41/47] drivers/base: check errors
Date: Mon, 25 Sep 2006 22:38:01 -0700
Message-Id: <11592492153066-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592492123695-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Add lots of return-value checking.

<pcornelia.huck@de.ibm.com>: fix bus_rescan_devices()]
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/base.h    |    2 -
 drivers/base/bus.c     |  107 ++++++++++++++++++++++++++++++++----------------
 drivers/base/dd.c      |   37 ++++++++++++-----
 include/linux/device.h |    8 ++--
 4 files changed, 104 insertions(+), 50 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index c3b8dc9..d26644a 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -16,7 +16,7 @@ extern int cpu_dev_init(void);
 extern int attribute_container_init(void);
 
 extern int bus_add_device(struct device * dev);
-extern void bus_attach_device(struct device * dev);
+extern int bus_attach_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 extern struct bus_type *get_bus(struct bus_type * bus);
 extern void put_bus(struct bus_type * bus);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 4d22a1d..aa685a2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -371,12 +371,20 @@ int bus_add_device(struct device * dev)
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
 		error = device_add_attrs(bus, dev);
-		if (!error) {
-			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
-			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "subsystem");
-			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
-		}
+		if (error)
+			goto out;
+		error = sysfs_create_link(&bus->devices.kobj,
+						&dev->kobj, dev->bus_id);
+		if (error)
+			goto out;
+		error = sysfs_create_link(&dev->kobj,
+				&dev->bus->subsys.kset.kobj, "subsystem");
+		if (error)
+			goto out;
+		error = sysfs_create_link(&dev->kobj,
+				&dev->bus->subsys.kset.kobj, "bus");
 	}
+out:
 	return error;
 }
 
@@ -386,14 +394,19 @@ int bus_add_device(struct device * dev)
  *
  *	- Try to attach to driver.
  */
-void bus_attach_device(struct device * dev)
+int bus_attach_device(struct device * dev)
 {
-	struct bus_type * bus = dev->bus;
+	struct bus_type *bus = dev->bus;
+	int ret = 0;
 
 	if (bus) {
-		device_attach(dev);
-		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
+		ret = device_attach(dev);
+		if (ret >= 0) {
+			klist_add_tail(&dev->knode_bus, &bus->klist_devices);
+			ret = 0;
+		}
 	}
+	return ret;
 }
 
 /**
@@ -455,10 +468,17 @@ #ifdef CONFIG_HOTPLUG
  * Thanks to drivers making their tables __devinit, we can't allow manual
  * bind and unbind from userspace unless CONFIG_HOTPLUG is enabled.
  */
-static void add_bind_files(struct device_driver *drv)
+static int __must_check add_bind_files(struct device_driver *drv)
 {
-	driver_create_file(drv, &driver_attr_unbind);
-	driver_create_file(drv, &driver_attr_bind);
+	int ret;
+
+	ret = driver_create_file(drv, &driver_attr_unbind);
+	if (ret == 0) {
+		ret = driver_create_file(drv, &driver_attr_bind);
+		if (ret)
+			driver_remove_file(drv, &driver_attr_unbind);
+	}
+	return ret;
 }
 
 static void remove_bind_files(struct device_driver *drv)
@@ -476,7 +496,7 @@ #endif
  *	@drv:	driver.
  *
  */
-int bus_add_driver(struct device_driver * drv)
+int bus_add_driver(struct device_driver *drv)
 {
 	struct bus_type * bus = get_bus(drv->bus);
 	int error = 0;
@@ -484,27 +504,39 @@ int bus_add_driver(struct device_driver 
 	if (bus) {
 		pr_debug("bus %s: add driver %s\n", bus->name, drv->name);
 		error = kobject_set_name(&drv->kobj, "%s", drv->name);
-		if (error) {
-			put_bus(bus);
-			return error;
-		}
+		if (error)
+			goto out_put_bus;
 		drv->kobj.kset = &bus->drivers;
-		if ((error = kobject_register(&drv->kobj))) {
-			put_bus(bus);
-			return error;
-		}
+		if ((error = kobject_register(&drv->kobj)))
+			goto out_put_bus;
 
-		driver_attach(drv);
+		error = driver_attach(drv);
+		if (error)
+			goto out_unregister;
 		klist_add_tail(&drv->knode_bus, &bus->klist_drivers);
 		module_add_driver(drv->owner, drv);
 
-		driver_add_attrs(bus, drv);
-		add_bind_files(drv);
+		error = driver_add_attrs(bus, drv);
+		if (error) {
+			/* How the hell do we get out of this pickle? Give up */
+			printk(KERN_ERR "%s: driver_add_attrs(%s) failed\n",
+				__FUNCTION__, drv->name);
+		}
+		error = add_bind_files(drv);
+		if (error) {
+			/* Ditto */
+			printk(KERN_ERR "%s: add_bind_files(%s) failed\n",
+				__FUNCTION__, drv->name);
+		}
 	}
 	return error;
+out_unregister:
+	kobject_unregister(&drv->kobj);
+out_put_bus:
+	put_bus(bus);
+	return error;
 }
 
-
 /**
  *	bus_remove_driver - delete driver from bus's knowledge.
  *	@drv:	driver.
@@ -530,16 +562,21 @@ void bus_remove_driver(struct device_dri
 
 
 /* Helper for bus_rescan_devices's iter */
-static int bus_rescan_devices_helper(struct device *dev, void *data)
+static int __must_check bus_rescan_devices_helper(struct device *dev,
+						void *data)
 {
+	int ret = 0;
+
 	if (!dev->driver) {
 		if (dev->parent)	/* Needed for USB */
 			down(&dev->parent->sem);
-		device_attach(dev);
+		ret = device_attach(dev);
 		if (dev->parent)
 			up(&dev->parent->sem);
+		if (ret > 0)
+			ret = 0;
 	}
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 /**
@@ -550,9 +587,9 @@ static int bus_rescan_devices_helper(str
  * attached and rescan it against existing drivers to see if it matches
  * any by calling device_attach() for the unbound devices.
  */
-void bus_rescan_devices(struct bus_type * bus)
+int bus_rescan_devices(struct bus_type * bus)
 {
-	bus_for_each_dev(bus, NULL, NULL, bus_rescan_devices_helper);
+	return bus_for_each_dev(bus, NULL, NULL, bus_rescan_devices_helper);
 }
 
 /**
@@ -564,7 +601,7 @@ void bus_rescan_devices(struct bus_type 
  * to use if probing criteria changed during a devices lifetime and
  * driver attachment should change accordingly.
  */
-void device_reprobe(struct device *dev)
+int device_reprobe(struct device *dev)
 {
 	if (dev->driver) {
 		if (dev->parent)        /* Needed for USB */
@@ -573,14 +610,14 @@ void device_reprobe(struct device *dev)
 		if (dev->parent)
 			up(&dev->parent->sem);
 	}
-
-	bus_rescan_devices_helper(dev, NULL);
+	return bus_rescan_devices_helper(dev, NULL);
 }
 EXPORT_SYMBOL_GPL(device_reprobe);
 
-struct bus_type * get_bus(struct bus_type * bus)
+struct bus_type *get_bus(struct bus_type *bus)
 {
-	return bus ? container_of(subsys_get(&bus->subsys), struct bus_type, subsys) : NULL;
+	return bus ? container_of(subsys_get(&bus->subsys),
+				struct bus_type, subsys) : NULL;
 }
 
 void put_bus(struct bus_type * bus)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 889c711..9f6f11c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -38,17 +38,29 @@ #define to_drv(node) container_of(node, 
  *
  *	This function must be called with @dev->sem held.
  */
-void device_bind_driver(struct device * dev)
+int device_bind_driver(struct device *dev)
 {
-	if (klist_node_attached(&dev->knode_driver))
-		return;
+	int ret;
+
+	if (klist_node_attached(&dev->knode_driver)) {
+		printk(KERN_WARNING "%s: device %s already bound\n",
+			__FUNCTION__, kobject_name(&dev->kobj));
+		return 0;
+	}
 
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
 	klist_add_tail(&dev->knode_driver, &dev->driver->klist_devices);
-	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
+	ret = sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
-	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+	if (ret == 0) {
+		ret = sysfs_create_link(&dev->kobj, &dev->driver->kobj,
+					"driver");
+		if (ret)
+			sysfs_remove_link(&dev->driver->kobj,
+					kobject_name(&dev->kobj));
+	}
+	return ret;
 }
 
 /**
@@ -91,7 +103,11 @@ int driver_probe_device(struct device_dr
 			goto ProbeFailed;
 		}
 	}
-	device_bind_driver(dev);
+	if (device_bind_driver(dev)) {
+		printk(KERN_ERR "%s: device_bind_driver(%s) failed\n",
+			__FUNCTION__, dev->bus_id);
+		/* How does undo a ->probe?  We're screwed. */
+	}
 	ret = 1;
 	pr_debug("%s: Bound Device %s to Driver %s\n",
 		 drv->bus->name, dev->bus_id, drv->name);
@@ -139,8 +155,9 @@ int device_attach(struct device * dev)
 
 	down(&dev->sem);
 	if (dev->driver) {
-		device_bind_driver(dev);
-		ret = 1;
+		ret = device_bind_driver(dev);
+		if (ret == 0)
+			ret = 1;
 	} else
 		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
 	up(&dev->sem);
@@ -182,9 +199,9 @@ static int __driver_attach(struct device
  *	returns 0 and the @dev->driver is set, we've found a
  *	compatible pair.
  */
-void driver_attach(struct device_driver * drv)
+int driver_attach(struct device_driver * drv)
 {
-	bus_for_each_dev(drv->bus, NULL, drv, __driver_attach);
+	return bus_for_each_dev(drv->bus, NULL, drv, __driver_attach);
 }
 
 /**
diff --git a/include/linux/device.h b/include/linux/device.h
index ad4db72..b3da9a8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -62,7 +62,7 @@ struct bus_type {
 extern int __must_check bus_register(struct bus_type * bus);
 extern void bus_unregister(struct bus_type * bus);
 
-extern void bus_rescan_devices(struct bus_type * bus);
+extern int __must_check bus_rescan_devices(struct bus_type * bus);
 
 /* iterator helpers for buses */
 
@@ -397,11 +397,11 @@ extern int device_rename(struct device *
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
-extern void device_bind_driver(struct device * dev);
+extern int __must_check device_bind_driver(struct device *dev);
 extern void device_release_driver(struct device * dev);
 extern int  __must_check device_attach(struct device * dev);
-extern void driver_attach(struct device_driver * drv);
-extern void device_reprobe(struct device *dev);
+extern int __must_check driver_attach(struct device_driver *drv);
+extern int __must_check device_reprobe(struct device *dev);
 
 /*
  * Easy functions for dynamically creating devices on the fly
-- 
1.4.2.1

