Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUEHKCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUEHKCC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbUEHKCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:02:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:64994 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264215AbUEHKBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:01:53 -0400
Date: Fri, 9 May 2003 15:39:57 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>
Subject: [RFC 2/2] sysfs_rename_dir-cleanup
Message-ID: <20030509153957.A20432@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com> <200404300748.14151.dtor_core@ameritech.net> <20040504053908.GA2900@in.ibm.com> <20040507222549.GB14660@kroah.com> <20030509153523.A20357@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030509153523.A20357@in.ibm.com>; from maneesh@in.ibm.com on Fri, May 09, 2003 at 03:35:23PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o The following patch cleans up sysfs_rename_dir(). It now checks the 
  return code of kobject_set_name() and propagates the error code to its
  callers. Because of this there are changes in the following two APIs. Both
  return int instead of void.

int sysfs_rename_dir(struct kobject * kobj, const char *new_name)
int kobject_rename(struct kobject * kobj, char *new_name)


 drivers/base/class.c    |    6 ++++--
 fs/sysfs/dir.c          |   14 +++++++++-----
 include/linux/kobject.h |    2 +-
 include/linux/sysfs.h   |    2 +-
 lib/kobject.c           |   10 +++++++---
 net/core/dev.c          |   16 ++++++++++------
 6 files changed, 32 insertions(+), 18 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs_rename_dir-cleanup fs/sysfs/dir.c
--- linux-2.6.6-rc3-mm2/fs/sysfs/dir.c~sysfs_rename_dir-cleanup	2004-05-05 18:22:39.000000000 +0530
+++ linux-2.6.6-rc3-mm2-maneesh/fs/sysfs/dir.c	2004-05-05 18:33:54.000000000 +0530
@@ -162,15 +162,16 @@ restart:
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
 
 	down_write(&sysfs_rename_sem);
 	parent = kobj->parent->dentry;
@@ -179,13 +180,16 @@ void sysfs_rename_dir(struct kobject * k
 	new_dentry = sysfs_get_dentry(parent, new_name);
 	if (!IS_ERR(new_dentry)) {
 		if (!new_dentry->d_inode) {
-			d_move(kobj->dentry, new_dentry);
-			kobject_set_name(kobj,new_name);
+			error = kobject_set_name(kobj,new_name);
+			if (!error)
+				d_move(kobj->dentry, new_dentry);
 		}
 		dput(new_dentry);
 	}
 	up(&parent->d_inode->i_sem);	
 	up_write(&sysfs_rename_sem);
+
+	return error;
 }
 
 EXPORT_SYMBOL(sysfs_create_dir);
diff -puN include/linux/sysfs.h~sysfs_rename_dir-cleanup include/linux/sysfs.h
--- linux-2.6.6-rc3-mm2/include/linux/sysfs.h~sysfs_rename_dir-cleanup	2004-05-05 18:22:39.000000000 +0530
+++ linux-2.6.6-rc3-mm2-maneesh/include/linux/sysfs.h	2004-05-05 18:33:58.000000000 +0530
@@ -44,7 +44,7 @@ sysfs_create_dir(struct kobject *);
 extern void
 sysfs_remove_dir(struct kobject *);
 
-extern void
+extern int
 sysfs_rename_dir(struct kobject *, const char *new_name);
 
 extern int
diff -puN lib/kobject.c~sysfs_rename_dir-cleanup lib/kobject.c
--- linux-2.6.6-rc3-mm2/lib/kobject.c~sysfs_rename_dir-cleanup	2004-05-05 18:22:39.000000000 +0530
+++ linux-2.6.6-rc3-mm2-maneesh/lib/kobject.c	2004-05-05 18:22:39.000000000 +0530
@@ -385,13 +385,17 @@ EXPORT_SYMBOL(kobject_set_name);
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
diff -puN include/linux/kobject.h~sysfs_rename_dir-cleanup include/linux/kobject.h
--- linux-2.6.6-rc3-mm2/include/linux/kobject.h~sysfs_rename_dir-cleanup	2004-05-05 18:22:39.000000000 +0530
+++ linux-2.6.6-rc3-mm2-maneesh/include/linux/kobject.h	2004-05-05 18:22:39.000000000 +0530
@@ -48,7 +48,7 @@ extern void kobject_cleanup(struct kobje
 extern int kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
-extern void kobject_rename(struct kobject *, char *new_name);
+extern int kobject_rename(struct kobject *, char *new_name);
 
 extern int kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
diff -puN drivers/base/class.c~sysfs_rename_dir-cleanup drivers/base/class.c
--- linux-2.6.6-rc3-mm2/drivers/base/class.c~sysfs_rename_dir-cleanup	2004-05-05 18:22:39.000000000 +0530
+++ linux-2.6.6-rc3-mm2-maneesh/drivers/base/class.c	2004-05-05 18:22:39.000000000 +0530
@@ -361,6 +361,8 @@ void class_device_unregister(struct clas
 
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
+	int error = 0;
+
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
 		return -EINVAL;
@@ -370,11 +372,11 @@ int class_device_rename(struct class_dev
 
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
-	kobject_rename(&class_dev->kobj, new_name);
+	error = kobject_rename(&class_dev->kobj, new_name);
 
 	class_device_put(class_dev);
 
-	return 0;
+	return error;
 }
 
 struct class_device * class_device_get(struct class_device *class_dev)
diff -puN net/core/dev.c~sysfs_rename_dir-cleanup net/core/dev.c
--- linux-2.6.6-rc3-mm2/net/core/dev.c~sysfs_rename_dir-cleanup	2004-05-05 18:22:39.000000000 +0530
+++ linux-2.6.6-rc3-mm2-maneesh/net/core/dev.c	2004-05-05 18:22:39.000000000 +0530
@@ -792,6 +792,8 @@ int dev_alloc_name(struct net_device *de
  */
 int dev_change_name(struct net_device *dev, char *newname)
 {
+	int err = 0;
+
 	ASSERT_RTNL();
 
 	if (dev->flags & IFF_UP)
@@ -801,7 +803,7 @@ int dev_change_name(struct net_device *d
 		return -EINVAL;
 
 	if (strchr(newname, '%')) {
-		int err = dev_alloc_name(dev, newname);
+		err = dev_alloc_name(dev, newname);
 		if (err < 0)
 			return err;
 		strcpy(newname, dev->name);
@@ -811,12 +813,14 @@ int dev_change_name(struct net_device *d
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

_
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
