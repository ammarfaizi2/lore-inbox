Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWIVJhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWIVJhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWIVJhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:37:39 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:41950 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751112AbWIVJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:36:59 -0400
Date: Fri, 22 Sep 2006 11:37:17 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [7/9] driver core fixes: sysfs_create_link() retval check in core.c
Message-ID: <20060922113717.6b84c4cc@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return value of sysfs_create_link() in device_add() and
device_rename(). Add helper functions device_add_class_symlinks() and
device_remove_class_symlinks() to make the code easier to read.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c |  129 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 32 deletions(-)

--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -387,6 +387,75 @@ void device_initialize(struct device *de
 	device_init_wakeup(dev, 0);
 }
 
+static int device_add_class_symlinks(struct device *dev)
+{
+	int error;
+#ifdef CONFIG_SYSFS_DEPRECATED
+	char *class_name;
+#endif
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
+#ifdef CONFIG_SYSFS_DEPRECATED
+	if (dev->parent) {
+		error = sysfs_create_link(&dev->kobj, &dev->parent->kobj,
+					  "device");
+		if (error)
+			goto out_busid;
+		class_name = make_class_name(dev->class->name, &dev->kobj);
+		if (!class_name) {
+			error = -ENOMEM;
+			goto out_busid;
+		}
+		error = sysfs_create_link(&dev->parent->kobj, &dev->kobj,
+					  class_name);
+		kfree(class_name);
+		if (error)
+			goto out_device;
+	}
+#endif
+	return 0;
+#ifdef CONFIG_SYSFS_DEPRECATED
+out_device:
+	if (dev->parent)
+		sysfs_remove_link(&dev->kobj, "device");
+out_busid:
+	sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+#endif
+out_subsys:
+	sysfs_remove_link(&dev->kobj, "subsystem");
+out:
+	return error;
+}
+
+static void device_remove_class_symlinks(struct device *dev)
+{
+#ifdef CONFIG_SYSFS_DEPRECATED
+	char *class_name;
+#endif
+	if (!dev->class)
+		return;
+#ifdef CONFIG_SYSFS_DEPRECATED
+	if (dev->parent) {
+		class_name = make_class_name(dev->class->name, &dev->kobj);
+		if (class_name) {
+			sysfs_remove_link(&dev->parent->kobj, class_name);
+			kfree(class_name);
+		}
+		sysfs_remove_link(&dev->kobj, "device");
+	}
+#endif
+	sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+	sysfs_remove_link(&dev->kobj, "subsystem");
+}
+
 /**
  *	device_add - add device to device hierarchy.
  *	@dev:	device.
@@ -401,7 +470,6 @@ void device_initialize(struct device *de
 int device_add(struct device *dev)
 {
 	struct device *parent = NULL;
-	char *class_name = NULL;
 	struct class_interface *class_intf;
 	int error = -EINVAL;
 
@@ -462,22 +530,8 @@ int device_add(struct device *dev)
 		dev->devt_attr = attr;
 	}
 
-	if (dev->class) {
-		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
-				  "subsystem");
-		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
-				  dev->bus_id);
-#ifdef CONFIG_SYSFS_DEPRECATED
-		if (parent) {
-			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
-			class_name = make_class_name(dev->class->name, &dev->kobj);
-			if (class_name)
-				sysfs_create_link(&dev->parent->kobj,
-						  &dev->kobj, class_name);
-		}
-#endif
-	}
-
+	if ((error = device_add_class_symlinks(dev)))
+		goto SymlinkError;
 	if ((error = device_add_attrs(dev)))
 		goto AttrsError;
 	if ((error = device_add_groups(dev)))
@@ -505,7 +559,6 @@ int device_add(struct device *dev)
 		up(&dev->class->sem);
 	}
  Done:
- 	kfree(class_name);
 	put_device(dev);
 	return error;
  attachError:
@@ -517,6 +570,8 @@ int device_add(struct device *dev)
  GroupError:
  	device_remove_attrs(dev);
  AttrsError:
+	device_remove_class_symlinks(dev);
+ SymlinkError:
 	if (dev->devt_attr) {
 		device_remove_file(dev, dev->devt_attr);
 		kfree(dev->devt_attr);
@@ -816,7 +871,7 @@ int device_rename(struct device *dev, ch
 	char *old_class_name = NULL;
 	char *new_class_name = NULL;
 #endif
-	char *old_symlink_name = NULL;
+	char *old_device_name = NULL;
 	int error;
 
 	dev = get_device(dev);
@@ -830,23 +885,27 @@ int device_rename(struct device *dev, ch
 		old_class_name = make_class_name(dev->class->name, &dev->kobj);
 #endif
 
-	if (dev->class) {
-		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
-		if (!old_symlink_name)
-			return -ENOMEM;
-		strlcpy(old_symlink_name, dev->bus_id, BUS_ID_SIZE);
+	old_device_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
+	if (!old_device_name) {
+		error =  -ENOMEM;
+		goto out;
 	}
-
+	strlcpy(old_device_name, dev->bus_id, BUS_ID_SIZE);
 	strlcpy(dev->bus_id, new_name, BUS_ID_SIZE);
 
 	error = kobject_rename(&dev->kobj, new_name);
-
+	if (error) {
+		strlcpy(dev->bus_id, old_device_name, BUS_ID_SIZE);
+		goto out;
+	}
 #ifdef CONFIG_SYSFS_DEPRECATED
 	if (old_class_name) {
 		new_class_name = make_class_name(dev->class->name, &dev->kobj);
 		if (new_class_name) {
-			sysfs_create_link(&dev->parent->kobj, &dev->kobj,
-					  new_class_name);
+			error = sysfs_create_link(&dev->parent->kobj, &dev->kobj,
+					  	  new_class_name);
+			if (error)
+				goto out;
 			sysfs_remove_link(&dev->parent->kobj, old_class_name);
 		}
 	}
@@ -854,17 +913,23 @@ int device_rename(struct device *dev, ch
 
 	if (dev->class) {
 		sysfs_remove_link(&dev->class->subsys.kset.kobj,
-				  old_symlink_name);
-		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
-				  dev->bus_id);
+				  old_device_name);
+		error = sysfs_create_link(&dev->class->subsys.kset.kobj,
+					  &dev->kobj, dev->bus_id);
+		if (error) {
+			/* Uh... how to unravel this if restoring can fail? */
+			dev_err(dev, "%s: sysfs_create_symlink failed (%d)\n",
+				__FUNCTION__, error);
+		}
 	}
+out:
 	put_device(dev);
 
 #ifdef CONFIG_SYSFS_DEPRECATED
 	kfree(old_class_name);
 	kfree(new_class_name);
 #endif
-	kfree(old_symlink_name);
+	kfree(old_device_name);
 
 	return error;
 }
