Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUENXSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUENXSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUENXRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:17:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:61660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264346AbUENXIU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:20 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760433731@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:23 -0700
Message-Id: <10845760433442@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.29, 2004/05/14 12:13:00-07:00, maneesh@in.ibm.com

[PATCH] sysfs_rename_dir-cleanup

o The following patch cleans up sysfs_rename_dir(). It now checks the
  return code of kobject_set_name() and propagates the error code to its
  callers. Because of this there are changes in the following two APIs. Both
  return int instead of void.

int sysfs_rename_dir(struct kobject * kobj, const char *new_name)
int kobject_rename(struct kobject * kobj, char *new_name)


 drivers/base/class.c    |    6 ++++--
 fs/sysfs/dir.c          |   19 ++++++++++++++-----
 include/linux/kobject.h |    2 +-
 include/linux/sysfs.h   |    2 +-
 lib/kobject.c           |   10 +++++++---
 net/core/dev.c          |   16 ++++++++++------
 6 files changed, 37 insertions(+), 18 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Fri May 14 15:55:40 2004
+++ b/drivers/base/class.c	Fri May 14 15:55:40 2004
@@ -361,6 +361,8 @@
 
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
+	int error = 0;
+
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
 		return -EINVAL;
@@ -370,11 +372,11 @@
 
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
-	kobject_rename(&class_dev->kobj, new_name);
+	error = kobject_rename(&class_dev->kobj, new_name);
 
 	class_device_put(class_dev);
 
-	return 0;
+	return error;
 }
 
 struct class_device * class_device_get(struct class_device *class_dev)
diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	Fri May 14 15:55:40 2004
+++ b/fs/sysfs/dir.c	Fri May 14 15:55:40 2004
@@ -154,24 +154,33 @@
 	dput(dentry);
 }
 
-void sysfs_rename_dir(struct kobject * kobj, const char *new_name)
+int sysfs_rename_dir(struct kobject * kobj, const char *new_name)
 {
+	int error = 0;
 	struct dentry * new_dentry, * parent;
 
 	if (!strcmp(kobject_name(kobj), new_name))
-		return;
+		return -EINVAL;
 
 	if (!kobj->parent)
-		return;
+		return -EINVAL;
 
 	parent = kobj->parent->dentry;
 
 	down(&parent->d_inode->i_sem);
 
 	new_dentry = sysfs_get_dentry(parent, new_name);
-	d_move(kobj->dentry, new_dentry);
-	kobject_set_name(kobj,new_name);
+	if (!IS_ERR(new_dentry)) {
+  		if (!new_dentry->d_inode) {
+			error = kobject_set_name(kobj,new_name);
+			if (!error)
+				d_move(kobj->dentry, new_dentry);
+		}
+		dput(new_dentry);
+	}
 	up(&parent->d_inode->i_sem);	
+
+	return error;
 }
 
 EXPORT_SYMBOL(sysfs_create_dir);
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Fri May 14 15:55:40 2004
+++ b/include/linux/kobject.h	Fri May 14 15:55:40 2004
@@ -48,7 +48,7 @@
 extern int kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
-extern void kobject_rename(struct kobject *, char *new_name);
+extern int kobject_rename(struct kobject *, char *new_name);
 
 extern int kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	Fri May 14 15:55:40 2004
+++ b/include/linux/sysfs.h	Fri May 14 15:55:40 2004
@@ -44,7 +44,7 @@
 extern void
 sysfs_remove_dir(struct kobject *);
 
-extern void
+extern int
 sysfs_rename_dir(struct kobject *, const char *new_name);
 
 extern int
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Fri May 14 15:55:40 2004
+++ b/lib/kobject.c	Fri May 14 15:55:40 2004
@@ -385,13 +385,17 @@
  *	@new_name: object's new name
  */
 
-void kobject_rename(struct kobject * kobj, char *new_name)
+int kobject_rename(struct kobject * kobj, char *new_name)
 {
+	int error = 0;
+
 	kobj = kobject_get(kobj);
 	if (!kobj)
-		return;
-	sysfs_rename_dir(kobj, new_name);
+		return -EINVAL;
+	error = sysfs_rename_dir(kobj, new_name);
 	kobject_put(kobj);
+
+	return error;
 }
 
 /**
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Fri May 14 15:55:40 2004
+++ b/net/core/dev.c	Fri May 14 15:55:40 2004
@@ -792,6 +792,8 @@
  */
 int dev_change_name(struct net_device *dev, char *newname)
 {
+	int err = 0;
+
 	ASSERT_RTNL();
 
 	if (dev->flags & IFF_UP)
@@ -801,7 +803,7 @@
 		return -EINVAL;
 
 	if (strchr(newname, '%')) {
-		int err = dev_alloc_name(dev, newname);
+		err = dev_alloc_name(dev, newname);
 		if (err < 0)
 			return err;
 		strcpy(newname, dev->name);
@@ -811,12 +813,14 @@
 	else
 		strlcpy(dev->name, newname, IFNAMSIZ);
 
-	hlist_del(&dev->name_hlist);
-	hlist_add_head(&dev->name_hlist, dev_name_hash(dev->name));
+	err = class_device_rename(&dev->class_dev, dev->name);
+	if (!err) {
+		hlist_del(&dev->name_hlist);
+		hlist_add_head(&dev->name_hlist, dev_name_hash(dev->name));
+		notifier_call_chain(&netdev_chain, NETDEV_CHANGENAME, dev);
+	}
 
-	class_device_rename(&dev->class_dev, dev->name);
-	notifier_call_chain(&netdev_chain, NETDEV_CHANGENAME, dev);
-	return 0;
+	return err;
 }
 
 /**

