Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUD3KOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUD3KOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 06:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265142AbUD3KOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 06:14:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:14726 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262009AbUD3KOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 06:14:43 -0400
Date: Fri, 30 Apr 2004 15:47:18 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC 2/2] kobject_set_name - error handling
Message-ID: <20040430101718.GD25296@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040420161602.GB9603@kroah.com> <20040421101104.GA7921@in.ibm.com> <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk> <20040423085218.GB27638@in.ibm.com> <20040423092641.GM17014@parcelfarce.linux.theplanet.co.uk> <20040429130353.GC11624@in.ibm.com> <20040429154104.GI17014@parcelfarce.linux.theplanet.co.uk> <20040430100543.GA25296@in.ibm.com> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430101401.GC25296@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o The following patch cleans up sysfs_rename_dir(). It now checks the 
  return code of kobject_set_name() and propagates the error code to its
  callers. Because of this there are changes in the following two APIs. Both
  return int instead of void.

int sysfs_rename_dir(struct kobject * kobj, const char *new_name)
int kobject_rename(struct kobject * kobj, char *new_name)

o It needs the sysfs-symlinks-fix.patch to get apppied.
	http://marc.theaimsgroup.com/?l=linux-kernel&m=108331963219401&w=2

 drivers/base/class.c    |    6 ++++--
 fs/sysfs/dir.c          |   14 +++++++++-----
 include/linux/kobject.h |    2 +-
 include/linux/sysfs.h   |    2 +-
 lib/kobject.c           |   10 +++++++---
 net/core/dev.c          |   12 +++++++-----
 6 files changed, 29 insertions(+), 17 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs_rename_dir-cleanup fs/sysfs/dir.c
--- linux-2.6.6-rc2-mm2/fs/sysfs/dir.c~sysfs_rename_dir-cleanup	2004-04-30 15:00:41.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/fs/sysfs/dir.c	2004-04-30 15:12:13.000000000 +0530
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
--- linux-2.6.6-rc2-mm2/include/linux/sysfs.h~sysfs_rename_dir-cleanup	2004-04-30 15:00:48.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/include/linux/sysfs.h	2004-04-30 15:07:23.000000000 +0530
@@ -44,7 +44,7 @@ sysfs_create_dir(struct kobject *);
 extern void
 sysfs_remove_dir(struct kobject *);
 
-extern void
+extern int
 sysfs_rename_dir(struct kobject *, const char *new_name);
 
 extern int
diff -puN lib/kobject.c~sysfs_rename_dir-cleanup lib/kobject.c
--- linux-2.6.6-rc2-mm2/lib/kobject.c~sysfs_rename_dir-cleanup	2004-04-30 15:00:54.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/lib/kobject.c	2004-04-30 15:08:21.000000000 +0530
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
--- linux-2.6.6-rc2-mm2/include/linux/kobject.h~sysfs_rename_dir-cleanup	2004-04-30 15:03:32.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/include/linux/kobject.h	2004-04-30 15:07:08.000000000 +0530
@@ -48,7 +48,7 @@ extern void kobject_cleanup(struct kobje
 extern int kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
-extern void kobject_rename(struct kobject *, char *new_name);
+extern int kobject_rename(struct kobject *, char *new_name);
 
 extern int kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
diff -puN drivers/base/class.c~sysfs_rename_dir-cleanup drivers/base/class.c
--- linux-2.6.6-rc2-mm2/drivers/base/class.c~sysfs_rename_dir-cleanup	2004-04-30 15:04:06.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/drivers/base/class.c	2004-04-30 15:06:51.000000000 +0530
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
--- linux-2.6.6-rc2-mm2/net/core/dev.c~sysfs_rename_dir-cleanup	2004-04-30 15:08:36.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/net/core/dev.c	2004-04-30 15:09:34.000000000 +0530
@@ -811,12 +811,14 @@ int dev_change_name(struct net_device *d
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
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
