Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946437AbWJ0LhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946437AbWJ0LhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946435AbWJ0Lgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:36:42 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:63227 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946424AbWJ0LgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:36:15 -0400
Date: Fri, 27 Oct 2006 13:36:50 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [Patch 2/7] driver core fixes: sysfs_create_link() retval checks in
 core.c
Message-ID: <20061027133650.4539f0c7@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return value of sysfs_create_link() in device_add()
and device_rename().  Add helper functions device_add_class_symlinks() and
device_remove_class_symlinks() to make the code easier to read.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---

 drivers/base/core.c |  133 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 97 insertions(+), 36 deletions(-)

--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -365,6 +365,75 @@ static void klist_children_put(struct kl
 }
 
 
+static int device_add_class_symlinks(struct device *dev)
+{
+	int error;
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
+#ifdef CONFIG_SYSFS_DEPRECATED
+	if (dev->parent) {
+		char *class_name;
+
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
+
+#ifdef CONFIG_SYSFS_DEPRECATED
+out_device:
+	if (dev->parent)
+		sysfs_remove_link(&dev->kobj, "device");
+out_busid:
+#endif
+	sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+out_subsys:
+	sysfs_remove_link(&dev->kobj, "subsystem");
+out:
+	return error;
+}
+
+static void device_remove_class_symlinks(struct device *dev)
+{
+	if (!dev->class)
+		return;
+#ifdef CONFIG_SYSFS_DEPRECATED
+	if (dev->parent) {
+		char *class_name;
+
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
  *	device_initialize - init device structure.
  *	@dev:	device.
@@ -442,7 +511,6 @@ int setup_parent(struct device *dev, str
 int device_add(struct device *dev)
 {
 	struct device *parent = NULL;
-	char *class_name = NULL;
 	struct class_interface *class_intf;
 	int error = -EINVAL;
 
@@ -506,24 +574,8 @@ int device_add(struct device *dev)
 		dev->devt_attr = attr;
 	}
 
-	if (dev->class) {
-		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
-				  "subsystem");
-		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
-				  dev->bus_id);
-#ifdef CONFIG_SYSFS_DEPRECATED
-		if (parent) {
-			sysfs_create_link(&dev->kobj, &dev->parent->kobj,
-							"device");
-			class_name = make_class_name(dev->class->name,
-							&dev->kobj);
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
@@ -550,7 +602,6 @@ int device_add(struct device *dev)
 		up(&dev->class->sem);
 	}
  Done:
- 	kfree(class_name);
 	put_device(dev);
 	return error;
  AttachError:
@@ -565,6 +616,8 @@ int device_add(struct device *dev)
  GroupError:
  	device_remove_attrs(dev);
  AttrsError:
+	device_remove_class_symlinks(dev);
+ SymlinkError:
 	if (dev->devt_attr) {
 		device_remove_file(dev, dev->devt_attr);
 		kfree(dev->devt_attr);
@@ -864,7 +917,7 @@ int device_rename(struct device *dev, ch
 {
 	char *old_class_name = NULL;
 	char *new_class_name = NULL;
-	char *old_symlink_name = NULL;
+	char *old_device_name = NULL;
 	int error;
 
 	dev = get_device(dev);
@@ -878,25 +931,28 @@ int device_rename(struct device *dev, ch
 		old_class_name = make_class_name(dev->class->name, &dev->kobj);
 #endif
 
-	if (dev->class) {
-		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
-		if (!old_symlink_name) {
-			error = -ENOMEM;
-			goto out_free_old_class;
-		}
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
+			error = sysfs_create_link(&dev->parent->kobj,
+						  &dev->kobj, new_class_name);
+			if (error)
+				goto out;
 			sysfs_remove_link(&dev->parent->kobj, old_class_name);
 		}
 	}
@@ -904,16 +960,21 @@ int device_rename(struct device *dev, ch
 
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
+			dev_err(dev, "%s: sysfs_create_link failed (%d)\n",
+				__FUNCTION__, error);
+		}
 	}
+ out:
 	put_device(dev);
 
 	kfree(new_class_name);
-	kfree(old_symlink_name);
- out_free_old_class:
 	kfree(old_class_name);
+	kfree(old_device_name);
 
 	return error;
 }
