Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbUEEEz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUEEEz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 00:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUEEEz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 00:55:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22469 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261221AbUEEEzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 00:55:08 -0400
Date: Tue, 4 May 2004 18:38:26 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2/2] kobject_set_name - error handling
Message-ID: <20040504130826.GD2900@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040421101104.GA7921@in.ibm.com> <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk> <20040423085218.GB27638@in.ibm.com> <20040423092641.GM17014@parcelfarce.linux.theplanet.co.uk> <20040429130353.GC11624@in.ibm.com> <20040429154104.GI17014@parcelfarce.linux.theplanet.co.uk> <20040430100543.GA25296@in.ibm.com> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com> <20040430101718.GD25296@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430101718.GD25296@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 03:47:18PM +0530, Maneesh Soni wrote:
> 
> 
The previous one had compilation problems. Corrected now. 

Thanks
Maneesh



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
--- linux-2.6.6-rc3-mm1/fs/sysfs/dir.c~sysfs_rename_dir-cleanup	2004-04-30 16:07:28.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/fs/sysfs/dir.c	2004-05-04 14:55:43.000000000 +0530
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
--- linux-2.6.6-rc3-mm1/include/linux/sysfs.h~sysfs_rename_dir-cleanup	2004-04-30 16:07:28.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/include/linux/sysfs.h	2004-05-04 14:55:44.000000000 +0530
@@ -44,7 +44,7 @@ sysfs_create_dir(struct kobject *);
 extern void
 sysfs_remove_dir(struct kobject *);
 
-extern void
+extern int
 sysfs_rename_dir(struct kobject *, const char *new_name);
 
 extern int
diff -puN lib/kobject.c~sysfs_rename_dir-cleanup lib/kobject.c
--- linux-2.6.6-rc3-mm1/lib/kobject.c~sysfs_rename_dir-cleanup	2004-04-30 16:07:28.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/lib/kobject.c	2004-04-30 16:07:28.000000000 +0530
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
--- linux-2.6.6-rc3-mm1/include/linux/kobject.h~sysfs_rename_dir-cleanup	2004-04-30 16:07:28.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/include/linux/kobject.h	2004-04-30 16:07:28.000000000 +0530
@@ -48,7 +48,7 @@ extern void kobject_cleanup(struct kobje
 extern int kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
-extern void kobject_rename(struct kobject *, char *new_name);
+extern int kobject_rename(struct kobject *, char *new_name);
 
 extern int kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
diff -puN drivers/base/class.c~sysfs_rename_dir-cleanup drivers/base/class.c
--- linux-2.6.6-rc3-mm1/drivers/base/class.c~sysfs_rename_dir-cleanup	2004-04-30 16:07:28.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/drivers/base/class.c	2004-04-30 16:07:28.000000000 +0530
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
--- linux-2.6.6-rc3-mm1/net/core/dev.c~sysfs_rename_dir-cleanup	2004-04-30 16:07:28.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/net/core/dev.c	2004-05-04 14:56:17.000000000 +0530
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
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
