Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWGUNUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWGUNUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 09:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGUNUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 09:20:05 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:14870 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750718AbWGUNUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 09:20:03 -0400
Date: Fri, 21 Jul 2006 15:20:00 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: [Patch] [mm] More driver core fixes for -mm
Message-ID: <20060721152000.5a59813a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060720165911.42603374@gondolin.boeblingen.de.ibm.com>
References: <20060720165911.42603374@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've looked some more into the __must_check stuff in the driver core,
and tried to fix some functions (especially device_add() is a bit of a
beast; I split off helper functions).

Question: What is considered "good style" concerning symlinks? I would
think I should remove symlinks I created, but most places don't seem to
do this...

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Fix missing checks of return codes for driver model functions called in
the driver core.

Also fix bus_attach_device(), which didn't take into account that
device_attach() may return 0 or 1 on success.

CC: Greg K-H <greg@kroah.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 base.h     |    1 
 bus.c      |   24 +++++++++++-
 class.c    |   12 ++++--
 core.c     |  115 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 platform.c |   11 ++++-
5 files changed, 133 insertions(+), 30 deletions(-)

diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/base.h linux-2.6.18-rc1-mm2+CH/drivers/base/base.h
--- linux-2.6.18-rc1-mm2/drivers/base/base.h	2006-07-17 17:58:13.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/base.h	2006-07-21 13:36:09.000000000 +0200
@@ -17,6 +17,7 @@ extern int attribute_container_init(void
 
 extern int bus_add_device(struct device * dev);
 extern int __must_check bus_attach_device(struct device * dev);
+extern void bus_delete_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 extern struct bus_type *get_bus(struct bus_type * bus);
 extern void put_bus(struct bus_type * bus);
diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/bus.c linux-2.6.18-rc1-mm2+CH/drivers/base/bus.c
--- linux-2.6.18-rc1-mm2/drivers/base/bus.c	2006-07-21 13:49:57.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/bus.c	2006-07-21 14:51:20.000000000 +0200
@@ -360,7 +360,7 @@ static void device_remove_attrs(struct b
  *	bus_add_device - add device to bus
  *	@dev:	device being added
  *
- *	- Add the device to its bus's list of devices.
+ *	- Add attributes.
  *	- Create link to device's bus.
  */
 int bus_add_device(struct device * dev)
@@ -401,13 +401,33 @@ int bus_attach_device(struct device * de
 
 	if (bus) {
 		ret = device_attach(dev);
-		if (ret == 0)
+		if (ret >= 0)
 			klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 	}
 	return ret;
 }
 
 /**
+ *	bus_delete_device - undo bus_add_device
+ *	@dev:	device being deleted
+ *
+ *	- Remove symlink from bus's directory.
+ *	- Remove attributes.
+ *	- Drop reference taken in bus_add_device().
+ */
+void bus_delete_device(struct device * dev)
+{
+	if (dev->bus) {
+		sysfs_remove_link(&dev->kobj, "subsystem");
+		sysfs_remove_link(&dev->kobj, "bus");
+		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
+		device_remove_attrs(dev->bus, dev);
+		put_bus(dev->bus);
+	}
+}
+
+
+/**
  *	bus_remove_device - remove device from bus
  *	@dev:	device to be removed
  *
diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/class.c linux-2.6.18-rc1-mm2+CH/drivers/base/class.c
--- linux-2.6.18-rc1-mm2/drivers/base/class.c	2006-07-06 06:09:49.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/class.c	2006-07-21 13:43:03.000000000 +0200
@@ -560,7 +560,10 @@ int class_device_add(struct class_device
 		goto out2;
 
 	/* add the needed attributes to this device */
-	sysfs_create_link(&class_dev->kobj, &parent_class->subsys.kset.kobj, "subsystem");
+	error = sysfs_create_link(&class_dev->kobj,
+				  &parent_class->subsys.kset.kobj, "subsystem");
+	if (error)
+		goto out3;
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
 	class_dev->uevent_attr.attr.owner = parent_class->owner;
@@ -809,10 +812,13 @@ int class_device_rename(struct class_dev
 	if (class_dev->dev) {
 		new_class_name = make_class_name(class_dev->class->name,
 						 &class_dev->kobj);
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  new_class_name);
+		error = sysfs_create_link(&class_dev->dev->kobj,
+					  &class_dev->kobj, new_class_name);
+		if (error)
+			goto out;
 		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
 	}
+out:
 	class_device_put(class_dev);
 
 	kfree(old_class_name);
diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/core.c linux-2.6.18-rc1-mm2+CH/drivers/base/core.c
--- linux-2.6.18-rc1-mm2/drivers/base/core.c	2006-07-17 17:58:13.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/core.c	2006-07-21 14:51:00.000000000 +0200
@@ -353,6 +353,67 @@ void device_initialize(struct device *de
 	device_init_wakeup(dev, 0);
 }
 
+static int device_add_class_symlinks(struct device *dev)
+{
+	int error;
+	char *class_name;
+
+	if (!dev->class)
+		return 0;
+	error = sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
+				  "subsystem");
+	if (error)
+		goto out;
+	error = sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
+				  dev->bus_id);
+	if (error)
+		goto out_subsys;
+	if (dev->parent) {
+		error = sysfs_create_link(&dev->kobj, &dev->parent->kobj,
+					  "device");
+		if (error)
+			goto out_busid;
+		class_name = make_class_name(dev->class->name, &dev->kobj);
+		if (IS_ERR(class_name)) {
+			error = PTR_ERR(class_name);
+			goto out_busid;
+		}
+		error = sysfs_create_link(&dev->parent->kobj, &dev->kobj,
+					  class_name);
+		kfree(class_name);
+		if (error)
+			goto out_device;
+	}
+	return error;
+out_device:
+	if (dev->parent)
+		sysfs_remove_link(&dev->kobj, "device");
+out_busid:
+	sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+out_subsys:
+	sysfs_remove_link(&dev->kobj, "subsystem");
+out:
+	return error;
+}
+
+static void device_remove_class_symlinks(struct device *dev)
+{
+	char *class_name = NULL;
+
+	if (!dev->class)
+		return;
+	if (dev->parent) {
+		class_name = make_class_name(dev->class->name, &dev->kobj);
+		if (!IS_ERR(class_name)) {
+			sysfs_remove_link(&dev->parent->kobj, class_name);
+			kfree(class_name);
+		}
+		sysfs_remove_link(&dev->kobj, "device");
+	}
+	sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+	sysfs_remove_link(&dev->kobj, "subsystem");
+}
+
 /**
  *	device_add - add device to device hierarchy.
  *	@dev:	device.
@@ -367,7 +428,6 @@ void device_initialize(struct device *de
 int device_add(struct device *dev)
 {
 	struct device *parent = NULL;
-	char *class_name = NULL;
 	int error = -EINVAL;
 
 	dev = get_device(dev);
@@ -395,14 +455,16 @@ int device_add(struct device *dev)
 	if (dev->driver)
 		dev->uevent_attr.attr.owner = dev->driver->owner;
 	dev->uevent_attr.store = store_uevent;
-	device_create_file(dev, &dev->uevent_attr);
+	error = device_create_file(dev, &dev->uevent_attr);
+	if (error)
+		goto attrError;
 
 	if (MAJOR(dev->devt)) {
 		struct device_attribute *attr;
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
-			goto PMError;
+			goto ueventattrError;
 		}
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
@@ -412,24 +474,13 @@ int device_add(struct device *dev)
 		error = device_create_file(dev, attr);
 		if (error) {
 			kfree(attr);
-			goto attrError;
+			goto ueventattrError;
 		}
-
 		dev->devt_attr = attr;
 	}
 
-	if (dev->class) {
-		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
-				  "subsystem");
-		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
-				  dev->bus_id);
-		if (parent) {
-			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
-			class_name = make_class_name(dev->class->name, &dev->kobj);
-			sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
-		}
-	}
-
+	if ((error = device_add_class_symlinks(dev)))
+		goto SymlinkError;
 	if ((error = device_add_attrs(dev)))
 		goto AttrsError;
 	if ((error = device_add_groups(dev)))
@@ -439,7 +490,12 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	bus_attach_device(dev);
+	if ((error = bus_attach_device(dev))) {
+		if (error < 0)
+			goto attachError;
+		else
+			error = 0;
+	}
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -450,9 +506,10 @@ int device_add(struct device *dev)
 		up(&dev->class->sem);
 	}
  Done:
- 	kfree(class_name);
 	put_device(dev);
 	return error;
+ attachError:
+	bus_delete_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:
@@ -460,10 +517,14 @@ int device_add(struct device *dev)
  GroupError:
  	device_remove_attrs(dev);
  AttrsError:
+	device_remove_class_symlinks(dev);
+ SymlinkError:
 	if (dev->devt_attr) {
 		device_remove_file(dev, dev->devt_attr);
 		kfree(dev->devt_attr);
 	}
+ ueventattrError:
+	device_remove_file(dev, &dev->uevent_attr);
  attrError:
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
@@ -769,17 +830,25 @@ int device_rename(struct device *dev, ch
 	if (old_class_name) {
 		new_class_name = make_class_name(dev->class->name, &dev->kobj);
 		if (new_class_name) {
-			sysfs_create_link(&dev->parent->kobj, &dev->kobj,
-					  new_class_name);
+			error = sysfs_create_link(&dev->parent->kobj,
+						  &dev->kobj, new_class_name);
+			if (error)
+				goto out;
 			sysfs_remove_link(&dev->parent->kobj, old_class_name);
 		}
 	}
 	if (dev->class) {
 		sysfs_remove_link(&dev->class->subsys.kset.kobj,
 				  old_symlink_name);
-		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
-				  dev->bus_id);
+		error = sysfs_create_link(&dev->class->subsys.kset.kobj,
+					  &dev->kobj, dev->bus_id);
+		if (error) {
+			/* Uh... how to unravel this if restoring can fail? */
+			printk(KERN_ERR"%s: sysfs_create_symlink(%s) failed\n",
+			       __FUNCTION__, dev->bus_id);
+		}
 	}
+out:
 	put_device(dev);
 
 	kfree(old_class_name);
diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/platform.c linux-2.6.18-rc1-mm2+CH/drivers/base/platform.c
--- linux-2.6.18-rc1-mm2/drivers/base/platform.c	2006-07-06 06:09:49.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/platform.c	2006-07-21 14:04:45.000000000 +0200
@@ -537,8 +537,15 @@ EXPORT_SYMBOL_GPL(platform_bus_type);
 
 int __init platform_bus_init(void)
 {
-	device_register(&platform_bus);
-	return bus_register(&platform_bus_type);
+	int error;
+
+	error = device_register(&platform_bus);
+	if (error)
+		return error;
+	error = bus_register(&platform_bus_type);
+	if (error)
+		device_unregister(&platform_bus);
+	return error;
 }
 
 #ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
