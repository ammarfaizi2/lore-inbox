Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWKGP4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWKGP4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWKGPz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:55:56 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:41453 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932635AbWKGPzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:55:19 -0500
Date: Tue, 7 Nov 2006 16:55:48 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC/Patch 2/5] driver core: Introduce device_move(): move a device
 to a new parent.
Message-ID: <20061107165548.33095b20@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061107163730.0c8f3dad@gondolin.boeblingen.de.ibm.com>
References: <20061107163730.0c8f3dad@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Provide a function device_move() to move a device to a new parent device. Add
auxilliary functions kobject_move() and sysfs_move_dir().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c     |   92 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/dir.c          |   45 +++++++++++++++++++++++
 include/linux/device.h  |    1 
 include/linux/kobject.h |    1 
 include/linux/sysfs.h   |    3 +
 lib/kobject.c           |   30 +++++++++++++++
 6 files changed, 172 insertions(+)

--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -953,3 +953,95 @@ int device_rename(struct device *dev, ch
 
 	return error;
 }
+
+
+static int device_move_class_links(struct device *dev,
+				   struct device *old_parent,
+				   struct device *new_parent)
+{
+#ifdef CONFIG_SYSFS_DEPRECATED
+	int error;
+	char *class_name;
+
+	class_name = make_class_name(dev->class->name, &dev->kobj);
+	if (!class_name) {
+		error = PTR_ERR(class_name);
+		class_name = NULL;
+		goto out;
+	}
+	if (old_parent) {
+		sysfs_remove_link(&dev->kobj, "device");
+		sysfs_remove_link(&old_parent->kobj, class_name);
+	}
+	error = sysfs_create_link(&dev->kobj, &new_parent->kobj, "device");
+	if (error)
+		goto out;
+	error = sysfs_create_link(&new_parent->kobj, &dev->kobj, class_name);
+	if (error)
+		sysfs_remove_link(&dev->kobj, "device");
+out:
+	kfree(class_name);
+	return error;
+#else
+	return 0;
+#endif
+}
+
+/**
+ * device_move - moves a device to a new parent
+ * @dev: the pointer to the struct device to be moved
+ * @new_parent: the new parent of the device
+ */
+int device_move(struct device *dev, struct device *new_parent)
+{
+	int error;
+	struct device *old_parent;
+
+	dev = get_device(dev);
+	if (!dev)
+		return -EINVAL;
+
+	if (!device_is_registered(dev)) {
+		error = -EINVAL;
+		goto out;
+	}
+	new_parent = get_device(new_parent);
+	if (!new_parent) {
+		error = -EINVAL;
+		goto out;
+	}
+	pr_debug("DEVICE: moving '%s' to '%s'\n", dev->bus_id,
+		new_parent->bus_id);
+	error = kobject_move(&dev->kobj, &new_parent->kobj);
+	if (error) {
+		put_device(new_parent);
+		goto out;
+	}
+	old_parent = dev->parent;
+	dev->parent = new_parent;
+	if (old_parent)
+		klist_del(&dev->knode_parent);
+	klist_add_tail(&dev->knode_parent, &new_parent->klist_children);
+	if (!dev->class)
+		goto out_put;
+	error = device_move_class_links(dev, old_parent, new_parent);
+	if (error) {
+		/* We ignore errors on cleanup since we're hosed anyway... */
+		device_move_class_links(dev, new_parent, old_parent);
+		if (!kobject_move(&dev->kobj, &old_parent->kobj)) {
+			klist_del(&dev->knode_parent);
+			if (old_parent)
+				klist_add_tail(&dev->knode_parent,
+					       &old_parent->klist_children);
+		}
+		put_device(new_parent);
+		goto out;
+	}
+out_put:
+	put_device(old_parent);
+out:
+	put_device(dev);
+	return error;
+}
+
+EXPORT_SYMBOL_GPL(device_move);
--- linux-2.6-CH.orig/fs/sysfs/dir.c
+++ linux-2.6-CH/fs/sysfs/dir.c
@@ -372,6 +372,51 @@ int sysfs_rename_dir(struct kobject * ko
 	return error;
 }
 
+int sysfs_move_dir(struct kobject *kobj, struct kobject *new_parent)
+{
+	struct dentry *old_parent_dentry, *new_parent_dentry, *new_dentry;
+	struct sysfs_dirent *new_parent_sd, *sd;
+	int error;
+
+	if (!new_parent)
+		return -EINVAL;
+
+	old_parent_dentry = kobj->parent ?
+		kobj->parent->dentry : sysfs_mount->mnt_sb->s_root;
+	new_parent_dentry = new_parent->dentry;
+
+again:
+	mutex_lock(&old_parent_dentry->d_inode->i_mutex);
+	if (!mutex_trylock(&new_parent_dentry->d_inode->i_mutex)) {
+		mutex_unlock(&old_parent_dentry->d_inode->i_mutex);
+		goto again;
+	}
+
+	new_parent_sd = new_parent_dentry->d_fsdata;
+	sd = kobj->dentry->d_fsdata;
+
+	new_dentry = lookup_one_len(kobj->name, new_parent_dentry,
+				    strlen(kobj->name));
+	if (IS_ERR(new_dentry)) {
+		error = PTR_ERR(new_dentry);
+		goto out;
+	} else
+		error = 0;
+	d_add(new_dentry, NULL);
+	d_move(kobj->dentry, new_dentry);
+	dput(new_dentry);
+
+	/* Remove from old parent's list and insert into new parent's list. */
+	list_del_init(&sd->s_sibling);
+	list_add(&sd->s_sibling, &new_parent_sd->s_children);
+
+out:
+	mutex_unlock(&new_parent_dentry->d_inode->i_mutex);
+	mutex_unlock(&old_parent_dentry->d_inode->i_mutex);
+
+	return error;
+}
+
 static int sysfs_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry * dentry = file->f_path.dentry;
--- linux-2.6-CH.orig/include/linux/device.h
+++ linux-2.6-CH/include/linux/device.h
@@ -423,6 +423,7 @@ extern int device_for_each_child(struct 
 extern struct device *device_find_child(struct device *, void *data,
 					int (*match)(struct device *, void *));
 extern int device_rename(struct device *dev, char *new_name);
+extern int device_move(struct device *dev, struct device *new_parent);
 
 /*
  * Manual binding of a device to driver. See drivers/base/bus.c
--- linux-2.6-CH.orig/include/linux/kobject.h
+++ linux-2.6-CH/include/linux/kobject.h
@@ -76,6 +76,7 @@ extern int __must_check kobject_add(stru
 extern void kobject_del(struct kobject *);
 
 extern int __must_check kobject_rename(struct kobject *, const char *new_name);
+extern int __must_check kobject_move(struct kobject *, struct kobject *);
 
 extern int __must_check kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
--- linux-2.6-CH.orig/include/linux/sysfs.h
+++ linux-2.6-CH/include/linux/sysfs.h
@@ -97,6 +97,9 @@ extern int __must_check
 sysfs_rename_dir(struct kobject *, const char *new_name);
 
 extern int __must_check
+sysfs_move_dir(struct kobject *, struct kobject *);
+
+extern int __must_check
 sysfs_create_file(struct kobject *, const struct attribute *);
 
 extern int __must_check
--- linux-2.6-CH.orig/lib/kobject.c
+++ linux-2.6-CH/lib/kobject.c
@@ -355,6 +355,36 @@ int kobject_rename(struct kobject * kobj
 }
 
 /**
+ *	kobject_move - move object to another parent
+ *	@kobj:	object in question.
+ *	@new_parent: object's new parent
+ */
+
+int kobject_move(struct kobject *kobj, struct kobject *new_parent)
+{
+	int error;
+	struct kobject *old_parent;
+
+	kobj = kobject_get(kobj);
+	if (!kobj)
+		return -EINVAL;
+	new_parent = kobject_get(new_parent);
+	if (!new_parent) {
+		error = -EINVAL;
+		goto out;
+	}
+	error = sysfs_move_dir(kobj, new_parent);
+	if (error)
+		goto out;
+	old_parent = kobj->parent;
+	kobj->parent = new_parent;
+	kobject_put(old_parent);
+out:
+	kobject_put(kobj);
+	return error;
+}
+
+/**
  *	kobject_del - unlink kobject from hierarchy.
  * 	@kobj:	object.
  */
