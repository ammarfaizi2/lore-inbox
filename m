Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965904AbWKTQHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965904AbWKTQHT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965978AbWKTQHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:07:19 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:50833 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965904AbWKTQHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:07:16 -0500
Date: Mon, 20 Nov 2006 17:07:51 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [Patch -mm 1/1] driver core: Introduce device_move(): move a device
 to a new parent.
Message-ID: <20061120170751.6026e8f4@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061120163946.38c878d7@gondolin.boeblingen.de.ibm.com>
References: <20061116154210.217f2e04@gondolin.boeblingen.de.ibm.com>
	<1163695657.7900.9.camel@min.off.vrfy.org>
	<20061117042338.GA11131@kroah.com>
	<20061120090537.6d59dbc5@gondolin.boeblingen.de.ibm.com>
	<20061120135515.38298bf5@gondolin.boeblingen.de.ibm.com>
	<1164032103.5541.12.camel@min.off.vrfy.org>
	<20061120163946.38c878d7@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Provide a function device_move() to move a device to a new parent device. Add
auxilliary functions kobject_move() and sysfs_move_dir().
kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
previous path (DEVPATH_OLD) in addition to the usual values. For this, a new
interface kobject_uevent_env() is created that allows to add further
environmental data to the uevent at the kobject layer.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c     |   92 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/dir.c          |   45 +++++++++++++++++++++++
 include/linux/device.h  |    1 
 include/linux/kobject.h |    8 ++++
 include/linux/sysfs.h   |    8 ++++
 lib/kobject.c           |   50 ++++++++++++++++++++++++++
 lib/kobject_uevent.c    |   28 ++++++++++++--
 7 files changed, 228 insertions(+), 4 deletions(-)

--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -955,3 +955,95 @@ int device_rename(struct device *dev, ch
 
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
@@ -47,6 +47,7 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
+	KOBJ_MOVE	= (__force kobject_action_t) 0x08,	/* device move */
 };
 
 struct kobject {
@@ -76,6 +77,7 @@ extern int __must_check kobject_add(stru
 extern void kobject_del(struct kobject *);
 
 extern int __must_check kobject_rename(struct kobject *, const char *new_name);
+extern int __must_check kobject_move(struct kobject *, struct kobject *);
 
 extern int __must_check kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
@@ -264,6 +266,8 @@ extern int __must_check subsys_create_fi
 
 #if defined(CONFIG_HOTPLUG)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
+void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
+			char *envp[]);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,
 			char *buffer, int buffer_size, int *cur_len,
@@ -271,6 +275,10 @@ int add_uevent_var(char **envp, int num_
 	__attribute__((format (printf, 7, 8)));
 #else
 static inline void kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
+static inline void kobject_uevent_env(struct kobject *kobj,
+				      enum kobject_action action,
+				      char *envp[])
+{ }
 
 static inline int add_uevent_var(char **envp, int num_envp, int *cur_index,
 				      char *buffer, int buffer_size, int *cur_len, 
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
@@ -143,6 +146,11 @@ static inline int sysfs_rename_dir(struc
 	return 0;
 }
 
+static inline int sysfs_move_dir(struct kobject * k, struct kobject * new_parent)
+{
+	return 0;
+}
+
 static inline int sysfs_create_file(struct kobject * k, const struct attribute * a)
 {
 	return 0;
--- linux-2.6-CH.orig/lib/kobject.c
+++ linux-2.6-CH/lib/kobject.c
@@ -355,6 +355,56 @@ int kobject_rename(struct kobject * kobj
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
+	const char *devpath = NULL;
+	char *devpath_string = NULL;
+	char *envp[2];
+
+	kobj = kobject_get(kobj);
+	if (!kobj)
+		return -EINVAL;
+	new_parent = kobject_get(new_parent);
+	if (!new_parent) {
+		error = -EINVAL;
+		goto out;
+	}
+	/* old object path */
+	devpath = kobject_get_path(kobj, GFP_KERNEL);
+	if (!devpath) {
+		error = -ENOMEM;
+		goto out;
+	}
+	devpath_string = kmalloc(strlen(devpath) + 15, GFP_KERNEL);
+	if (!devpath_string) {
+		error = -ENOMEM;
+		goto out;
+	}
+	sprintf(devpath_string, "DEVPATH_OLD=%s", devpath);
+	envp[0] = devpath_string;
+	envp[1] = NULL;
+	error = sysfs_move_dir(kobj, new_parent);
+	if (error)
+		goto out;
+	old_parent = kobj->parent;
+	kobj->parent = new_parent;
+	kobject_put(old_parent);
+	kobject_uevent_env(kobj, KOBJ_MOVE, envp);
+out:
+	kobject_put(kobj);
+	kfree(devpath_string);
+	kfree(devpath);
+	return error;
+}
+
+/**
  *	kobject_del - unlink kobject from hierarchy.
  * 	@kobj:	object.
  */
--- linux-2.6-CH.orig/lib/kobject_uevent.c
+++ linux-2.6-CH/lib/kobject_uevent.c
@@ -50,18 +50,22 @@ static char *action_to_string(enum kobje
 		return "offline";
 	case KOBJ_ONLINE:
 		return "online";
+	case KOBJ_MOVE:
+		return "move";
 	default:
 		return NULL;
 	}
 }
 
 /**
- * kobject_uevent - notify userspace by ending an uevent
+ * kobject_uevent_env - send an uevent with environmental data
  *
- * @action: action that is happening (usually KOBJ_ADD and KOBJ_REMOVE)
+ * @action: action that is happening (usually KOBJ_MOVE)
  * @kobj: struct kobject that the action is happening to
+ * @envp_ext: pointer to environmental data
  */
-void kobject_uevent(struct kobject *kobj, enum kobject_action action)
+void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
+			char *envp_ext[])
 {
 	char **envp;
 	char *buffer;
@@ -76,6 +80,7 @@ void kobject_uevent(struct kobject *kobj
 	char *seq_buff;
 	int i = 0;
 	int retval;
+	int j;
 
 	pr_debug("%s\n", __FUNCTION__);
 
@@ -134,7 +139,8 @@ void kobject_uevent(struct kobject *kobj
 	scratch += sprintf (scratch, "DEVPATH=%s", devpath) + 1;
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", subsystem) + 1;
-
+	for (j = 0; envp_ext && envp_ext[j]; j++)
+		envp[i++] = envp_ext[j];
 	/* just reserve the space, overwrite it after kset call has returned */
 	envp[i++] = seq_buff = scratch;
 	scratch += strlen("SEQNUM=18446744073709551616") + 1;
@@ -200,6 +206,20 @@ exit:
 	kfree(envp);
 	return;
 }
+
+EXPORT_SYMBOL_GPL(kobject_uevent_env);
+
+/**
+ * kobject_uevent - notify userspace by ending an uevent
+ *
+ * @action: action that is happening (usually KOBJ_ADD and KOBJ_REMOVE)
+ * @kobj: struct kobject that the action is happening to
+ */
+void kobject_uevent(struct kobject *kobj, enum kobject_action action)
+{
+	kobject_uevent_env(kobj, action, NULL);
+}
+
 EXPORT_SYMBOL_GPL(kobject_uevent);
 
 /**
