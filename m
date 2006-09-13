Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWIMQkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWIMQkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIMQjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:39:54 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:61258 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750742AbWIMQim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:42 -0400
Date: Wed, 13 Sep 2006 18:39:01 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [10/12] driver core fixes: sysfs_create_link() retval check in
 core.c
Message-ID: <20060913183901.3b12e42e@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
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

 core.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++------------------
1 file changed, 87 insertions(+), 31 deletions(-)

--- linux-2.6.18-rc6/drivers/base/core.c	2006-09-12 18:50:10.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/core.c	2006-09-13 10:29:33.000000000 +0200
@@ -357,6 +357,67 @@ void device_initialize(struct device *de
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
@@ -371,7 +432,6 @@ void device_initialize(struct device *de
 int device_add(struct device *dev)
 {
 	struct device *parent = NULL;
-	char *class_name = NULL;
 	int error = -EINVAL;
 
 	dev = get_device(dev);
@@ -431,22 +491,8 @@ int device_add(struct device *dev)
 		dev->devt_attr = attr;
 	}
 
-	if (dev->class) {
-		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
-				  "subsystem");
-		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
-				  dev->bus_id);
-		if ((parent) && (!device_is_virtual(dev))) {
-			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
-			class_name = make_class_name(dev->class->name, &dev->kobj);
-			if (!IS_ERR(class_name))
-				sysfs_create_link(&dev->parent->kobj,
-						  &dev->kobj, class_name);
-			else
-				class_name = NULL;
-		}
-	}
-
+	if ((error = device_add_class_symlinks(dev)))
+		goto SymlinkError;
 	if ((error = device_add_attrs(dev)))
 		goto AttrsError;
 	if ((error = device_add_groups(dev)))
@@ -469,7 +515,6 @@ int device_add(struct device *dev)
 		up(&dev->class->sem);
 	}
  Done:
- 	kfree(class_name);
 	put_device(dev);
 	return error;
  attachError:
@@ -481,6 +526,8 @@ int device_add(struct device *dev)
  GroupError:
  	device_remove_attrs(dev);
  AttrsError:
+	device_remove_class_symlinks(dev);
+ SymlinkError:
 	if (dev->devt_attr) {
 		device_remove_file(dev, dev->devt_attr);
 		kfree(dev->devt_attr);
@@ -770,7 +817,7 @@ int device_rename(struct device *dev, ch
 {
 	char *old_class_name = NULL;
 	char *new_class_name = NULL;
-	char *old_symlink_name = NULL;
+	char *old_device_name = NULL;
 	int error;
 
 	dev = get_device(dev);
@@ -787,38 +834,47 @@ int device_rename(struct device *dev, ch
 			goto out;
 		}
 	}
-	if (dev->class) {
-		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
-		if (!old_symlink_name)
-			return -ENOMEM;
-		strlcpy(old_symlink_name, dev->bus_id, BUS_ID_SIZE);
+	old_device_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
+	if (!old_device_name) {
+		error = -ENOMEM;
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
 	if (old_class_name) {
 		new_class_name = make_class_name(dev->class->name, &dev->kobj);
 		if (!IS_ERR(new_class_name)) {
-			sysfs_create_link(&dev->parent->kobj, &dev->kobj,
+			error = sysfs_create_link(&dev->parent->kobj, &dev->kobj,
 					  new_class_name);
+			if (error)
+				goto out;
 			sysfs_remove_link(&dev->parent->kobj, old_class_name);
 		} else
 			new_class_name = NULL;
 	}
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
 out:
 	put_device(dev);
 
 	kfree(old_class_name);
 	kfree(new_class_name);
-	kfree(old_symlink_name);
+	kfree(old_device_name);
 
 	return error;
 }
