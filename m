Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWGXRA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWGXRA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWGXRA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:00:57 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:1919 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932220AbWGXRA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:00:56 -0400
Date: Mon, 24 Jul 2006 19:00:52 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: [Patch] [mm] Yet further driver core fixes for -mm
Message-ID: <20060724190052.6599d0fb@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060721152000.5a59813a@gondolin.boeblingen.de.ibm.com>
References: <20060720165911.42603374@gondolin.boeblingen.de.ibm.com>
	<20060721152000.5a59813a@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch goes on top of the previous one and attempts to fix some
more problems in the driver core. These should contain most of the
low-hanging fruit for now...

These patches probably could use some testing by someone else but me :)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Some more fixes in the driver core:

- make_class_name() returns an ERR_PTR on error, not NULL.
- fixup some more unwinding on errors.

CC: Greg K-H <greg@kroah.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 bus.c      |   24 +++++++++++++++++++-----
 class.c    |    5 ++++-
 core.c     |   46 ++++++++++++++++++++++++++++------------------
 platform.c |   29 ++++++++++++++++++-----------
 4 files changed, 69 insertions(+), 35 deletions(-)

diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/bus.c linux-2.6.18-rc1-mm2+CH/drivers/base/bus.c
--- linux-2.6.18-rc1-mm2/drivers/base/bus.c	2006-07-24 12:59:29.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/bus.c	2006-07-24 18:31:36.000000000 +0200
@@ -372,18 +372,28 @@ int bus_add_device(struct device * dev)
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
 		error = device_add_attrs(bus, dev);
 		if (error)
-			goto out;
+			goto out_put;
 		error = sysfs_create_link(&bus->devices.kobj,
 						&dev->kobj, dev->bus_id);
 		if (error)
-			goto out;
+			goto out_id;
 		error = sysfs_create_link(&dev->kobj,
 				&dev->bus->subsys.kset.kobj, "subsystem");
 		if (error)
-			goto out;
+			goto out_subsys;
 		error = sysfs_create_link(&dev->kobj,
 				&dev->bus->subsys.kset.kobj, "bus");
-	}
+		if (!error)
+			goto out;
+	} else
+		goto out;
+	sysfs_remove_link(&dev->kobj, "subsystem");
+out_subsys:
+	sysfs_remove_link(&bus->devices.kobj, dev->bus_id);
+out_id:
+	device_remove_attrs(bus, dev);
+out_put:
+	put_bus(dev->bus);
 out:
 	return error;
 }
@@ -760,11 +770,15 @@ int bus_register(struct bus_type * bus)
 
 	klist_init(&bus->klist_devices, klist_devices_get, klist_devices_put);
 	klist_init(&bus->klist_drivers, klist_drivers_get, klist_drivers_put);
-	bus_add_attrs(bus);
+	retval = bus_add_attrs(bus);
+	if (retval)
+		goto bus_attrs_fail;
 
 	pr_debug("bus type '%s' registered\n", bus->name);
 	return 0;
 
+bus_attrs_fail:
+	kset_unregister(&bus->drivers);
 bus_drivers_fail:
 	kset_unregister(&bus->devices);
 bus_devices_fail:
diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/class.c linux-2.6.18-rc1-mm2+CH/drivers/base/class.c
--- linux-2.6.18-rc1-mm2/drivers/base/class.c	2006-07-24 12:59:29.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/class.c	2006-07-24 15:58:39.000000000 +0200
@@ -153,7 +153,10 @@ int class_register(struct class * cls)
 	error = subsystem_register(&cls->subsys);
 	if (!error) {
 		error = add_class_attrs(class_get(cls));
-		class_put(cls);
+		if (error)
+			subsystem_unregister(&cls->subsys);
+		else
+			class_put(cls);
 	}
 	return error;
 }
diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/core.c linux-2.6.18-rc1-mm2+CH/drivers/base/core.c
--- linux-2.6.18-rc1-mm2/drivers/base/core.c	2006-07-24 12:59:29.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/core.c	2006-07-24 18:24:42.000000000 +0200
@@ -804,7 +804,7 @@ int device_rename(struct device *dev, ch
 {
 	char *old_class_name = NULL;
 	char *new_class_name = NULL;
-	char *old_symlink_name = NULL;
+	char *old_device_name = NULL;
 	int error;
 
 	dev = get_device(dev);
@@ -813,33 +813,43 @@ int device_rename(struct device *dev, ch
 
 	pr_debug("DEVICE: renaming '%s' to '%s'\n", dev->bus_id, new_name);
 
-	if ((dev->class) && (dev->parent))
+	if ((dev->class) && (dev->parent)) {
 		old_class_name = make_class_name(dev->class->name, &dev->kobj);
-
-	if (dev->class) {
-		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
-		if (!old_symlink_name)
-			return -ENOMEM;
-		strlcpy(old_symlink_name, dev->bus_id, BUS_ID_SIZE);
+		if (IS_ERR(old_class_name)) {
+			error = PTR_ERR(old_class_name);
+			old_class_name = NULL;
+			goto out;
+		}
 	}
-
+	old_device_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
+	if (!old_device_name) {
+		error = -ENOMEM;
+		goto out;
+	}
+	strlcpy(old_device_name, dev->bus_id, BUS_ID_SIZE);
 	strlcpy(dev->bus_id, new_name, BUS_ID_SIZE);
 
 	error = kobject_rename(&dev->kobj, new_name);
-
+	if (error) {
+		strlcpy(dev->bus_id, old_device_name, BUS_ID_SIZE);
+		goto out;
+	}
 	if (old_class_name) {
 		new_class_name = make_class_name(dev->class->name, &dev->kobj);
-		if (new_class_name) {
-			error = sysfs_create_link(&dev->parent->kobj,
-						  &dev->kobj, new_class_name);
-			if (error)
-				goto out;
-			sysfs_remove_link(&dev->parent->kobj, old_class_name);
+		if (IS_ERR(new_class_name)) {
+			error = PTR_ERR(new_class_name);
+			new_class_name = NULL;
+			goto out;
 		}
+		error = sysfs_create_link(&dev->parent->kobj,
+					  &dev->kobj, new_class_name);
+		if (error)
+			goto out;
+		sysfs_remove_link(&dev->parent->kobj, old_class_name);
 	}
 	if (dev->class) {
 		sysfs_remove_link(&dev->class->subsys.kset.kobj,
-				  old_symlink_name);
+				  old_device_name);
 		error = sysfs_create_link(&dev->class->subsys.kset.kobj,
 					  &dev->kobj, dev->bus_id);
 		if (error) {
@@ -853,7 +863,7 @@ out:
 
 	kfree(old_class_name);
 	kfree(new_class_name);
-	kfree(old_symlink_name);
+	kfree(old_device_name);
 
 	return error;
 }
diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/platform.c linux-2.6.18-rc1-mm2+CH/drivers/base/platform.c
--- linux-2.6.18-rc1-mm2/drivers/base/platform.c	2006-07-24 12:59:29.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/platform.c	2006-07-24 15:39:07.000000000 +0200
@@ -202,6 +202,17 @@ int platform_device_add_resources(struct
 }
 EXPORT_SYMBOL_GPL(platform_device_add_resources);
 
+static void platform_device_del_resources(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource *r = &pdev->resource[i];
+		if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
+			release_resource(r);
+	}
+}
+
 /**
  *	platform_device_add_data
  *	@pdev:	platform device allocated by platform_device_alloc to add resources to
@@ -296,15 +307,8 @@ EXPORT_SYMBOL_GPL(platform_device_add);
  */
 void platform_device_del(struct platform_device *pdev)
 {
-	int i;
-
 	if (pdev) {
-		for (i = 0; i < pdev->num_resources; i++) {
-			struct resource *r = &pdev->resource[i];
-			if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
-				release_resource(r);
-		}
-
+		platform_device_del_resources(pdev);
 		device_del(&pdev->dev);
 	}
 }
@@ -365,17 +369,20 @@ struct platform_device *platform_device_
 	if (num) {
 		retval = platform_device_add_resources(pdev, res, num);
 		if (retval)
-			goto error;
+			goto error_put;
 	}
 
 	retval = platform_device_add(pdev);
 	if (retval)
-		goto error;
+		goto error_resources;
 
 	return pdev;
 
-error:
+error_resources:
+	platform_device_del_resources(pdev);
+error_put:
 	platform_device_put(pdev);
+error:
 	return ERR_PTR(retval);
 }
 EXPORT_SYMBOL_GPL(platform_device_register_simple);
