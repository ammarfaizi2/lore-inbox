Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTFKWJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264606AbTFKWJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:09:13 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:26886
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S264593AbTFKWIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:08:12 -0400
Subject: sysfs: Initialization order and system devices
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-i0BlibAkoyU4+AoG4Oo8"
Organization: 
Message-Id: <1055369924.4071.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 15:18:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i0BlibAkoyU4+AoG4Oo8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

With the current system device changes (I picked them up in 2.5.70-mm8),
the system device class assumes that all system device drivers are
registered before any system devices are registered.

Unfortunately, this is often not the case.  CPU devices are registered
very early, but cpufreq registers drivers for them; since cpufreq
drivers can be loaded as modules, they clearly can't be registered
before the device is.

This patch keeps a list of all registered devices hanging off the system
device class.  When a new driver is registered, it calls the driver's
add() function with all existing devices.

Conversely, when a driver is unregistered, it calls the driver's
remove() function for all existing devices so the driver can clean up.

	J

--=-i0BlibAkoyU4+AoG4Oo8
Content-Disposition: attachment; filename=sysdev-init-order.patch
Content-Type: text/plain; name=sysdev-init-order.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Sysdev assumes that all device drivers will be added before any
devices are actually registered.  This doesn't take into account that
some devices are added very early (cpu), but drivers for them may be
added later in boot, or even as a loaded module (cpufreq).

This patch adds a list of all existing devices to each class.  When a
driver is added to a class, it is told about all existing devices.

It also calls the driver's remove function for each device when the
driver unregisters itself.


 drivers/base/sys.c     |   31 ++++++++++++++++++++++++++-----
 include/linux/sysdev.h |    2 ++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff -puN drivers/base/sys.c~sysdev-init-order drivers/base/sys.c
--- local-2.5/drivers/base/sys.c~sysdev-init-order	2003-06-11 13:27:41.000000000 -0700
+++ local-2.5-jeremy/drivers/base/sys.c	2003-06-11 14:12:33.000000000 -0700
@@ -71,6 +71,7 @@ int sysdev_class_register(struct sysdev_
 {
 	pr_debug("Registering sysdev class '%s'\n",cls->kset.kobj.name);
 	INIT_LIST_HEAD(&cls->drivers);
+	INIT_LIST_HEAD(&cls->devices);
 	cls->kset.subsys = &system_subsys;
 	kset_set_kset_s(cls,system_subsys);
 	return kset_register(&cls->kset);
@@ -108,6 +109,14 @@ int sysdev_driver_register(struct sysdev
 		list_add_tail(&drv->entry,&cls->drivers);
 	else
 		list_add_tail(&drv->entry,&global_drivers);
+
+	/* If devices of this class already exist, tell the driver */
+	if (drv->add) {
+		struct sys_device *dev;
+		list_for_each_entry(dev, &cls->devices, entry)
+			drv->add(dev);
+	}
+
 	up_write(&system_subsys.rwsem);
 	return 0;
 }
@@ -123,8 +132,14 @@ void sysdev_driver_unregister(struct sys
 {
 	down_write(&system_subsys.rwsem);
 	list_del_init(&drv->entry);
-	if (cls)
+	if (cls) {
+		if (drv->remove) {
+			struct sys_device *dev;
+			list_for_each_entry(dev, &cls->devices, entry)
+				drv->remove(dev);
+		}
 		kset_put(&cls->kset);
+	}
 	up_write(&system_subsys.rwsem);
 }
 
@@ -157,11 +172,14 @@ int sys_device_register(struct sys_devic
 	if (!error) {
 		struct sysdev_driver * drv;
 
-		down_read(&system_subsys.rwsem);
+		down_write(&system_subsys.rwsem);
 		/* Generic notification is implicit, because it's that 
 		 * code that should have called us. 
 		 */
 
+		/* add device to class's device list */
+		list_add_tail(&sysdev->entry, &cls->devices);
+
 		/* Notify global drivers */
 		list_for_each_entry(drv,&global_drivers,entry) {
 			if (drv->add)
@@ -173,7 +191,7 @@ int sys_device_register(struct sys_devic
 			if (drv->add)
 				drv->add(sysdev);
 		}
-		up_read(&system_subsys.rwsem);
+		up_write(&system_subsys.rwsem);
 	}
 	return error;
 }
@@ -182,7 +200,7 @@ void sys_device_unregister(struct sys_de
 {
 	struct sysdev_driver * drv;
 
-	down_read(&system_subsys.rwsem);
+	down_write(&system_subsys.rwsem);
 	list_for_each_entry(drv,&global_drivers,entry) {
 		if (drv->remove)
 			drv->remove(sysdev);
@@ -192,7 +210,10 @@ void sys_device_unregister(struct sys_de
 		if (drv->remove)
 			drv->remove(sysdev);
 	}
-	up_read(&system_subsys.rwsem);
+
+	list_del_init(&sysdev->entry);
+
+	up_write(&system_subsys.rwsem);
 
 	kobject_unregister(&sysdev->kobj);
 }
diff -puN include/linux/sysdev.h~sysdev-init-order include/linux/sysdev.h
--- local-2.5/include/linux/sysdev.h~sysdev-init-order	2003-06-11 13:27:41.000000000 -0700
+++ local-2.5-jeremy/include/linux/sysdev.h	2003-06-11 13:27:41.000000000 -0700
@@ -28,6 +28,7 @@ struct sys_device;
 
 struct sysdev_class {
 	struct list_head	drivers;
+	struct list_head	devices;
 
 	/* Default operations for these types of devices */
 	int	(*shutdown)(struct sys_device *);
@@ -72,6 +73,7 @@ struct sys_device {
 	u32		id;
 	struct sysdev_class	* cls;
 	struct kobject		kobj;
+	struct list_head	entry;
 };
 
 extern int sys_device_register(struct sys_device *);

_

--=-i0BlibAkoyU4+AoG4Oo8--

