Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbULIFiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbULIFiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 00:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbULIFiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 00:38:17 -0500
Received: from [61.48.53.158] ([61.48.53.158]:504 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261457AbULIFhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 00:37:35 -0500
Date: Wed, 8 Dec 2004 21:26:32 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412090526.iB95QWs27140@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: [fake patch] un-inline sysfs_get_kobject and release_sysfs_dirent
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maneesh,

	The following fake patch against a heavily hacked
linux-2.6.10-rc2-bk16, which moves sysfs_get_kobject and release_sysfs_dirent
from fs/sysfs/sysfs.h as inline functions to .c files as non-inline
functions.  These routines are big enough, that they should not be
inline functions.  Although my previous patches have contributed
to this, I believe that the routines were still big enough that making
them non-inline would be justified even without any of my previous
patches.

	There were no changes to the contents of the functions other
than making them non-inline, although a previous patch that I posted
added SYSFS_ATTR_GROUP, which resulted in a change to sysfs_get_kobject
which affects this patch, as does my change to avoid allocating
the "s_children" field for non-directories.

	I am posting this patch now to simplify my patch for
unpinning sysfs directories, which I expect to post in about
an hour.  I am posting it against 2.6.10-rc2-bk16 for consistency
with my stream of patches from a few days ago, which this patch
is based on.  After posting the patch for unpinning sysfs directories,
I expect to update to the latest snapshot, and I will then
be able to regenerate patches against that if that would be
helpful.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


Signed-off-by: Adam J. Richter <adam@yggdrasil.com>

diff -u linux/fs/sysfs.old/dir.c linux/fs/sysfs/dir.c
--- linux/fs/sysfs.old/dir.c	2004-12-03 12:04:45.000000000 +0800
+++ linux/fs/sysfs/dir.c	2004-12-09 13:14:03.000000000 +0800
@@ -57,6 +57,20 @@
 	return sd;
 }
 
+void release_sysfs_dirent(struct sysfs_dirent * sd)
+{
+	if (sd->s_type & SYSFS_KOBJ_LINK) {
+		struct sysfs_symlink * sl = sd->s_element;
+		kfree(sl->link_name);
+		kobject_put(sl->target_kobj);
+		kfree(sl);
+	}
+	if (sysfs_type_dir(sd->s_type))
+		kmem_cache_free(sysfs_dir_cachep, to_sysfs_dir(sd));
+	else
+		kmem_cache_free(sysfs_dirent_cachep, sd);
+}
+
 int sysfs_make_dirent(struct sysfs_dir * parent_sd, struct dentry * dentry,
 			void * element, umode_t mode, int type)
 {
diff -u linux/fs/sysfs.old/inode.c linux/fs/sysfs/inode.c
--- linux/fs/sysfs.old/inode.c	2004-12-03 12:04:45.000000000 +0800
+++ linux/fs/sysfs/inode.c	2004-12-09 13:14:21.000000000 +0800
@@ -164,4 +164,24 @@
 	up(&dir->d_inode->i_sem);
 }
 
+struct kobject *sysfs_get_kobject(struct dentry *dentry)
+{
+	struct kobject * kobj = NULL;
 
+	spin_lock(&dcache_lock);
+	if (!d_unhashed(dentry)) {
+		struct sysfs_dirent * sd = dentry->d_fsdata;
+		if (sd->s_type == SYSFS_ATTR_GROUP) {
+			sd = dentry->d_parent->d_fsdata;
+			BUG_ON(sd->s_type != SYSFS_DIR);
+		}
+		if (sd->s_type & SYSFS_KOBJ_LINK) {
+			struct sysfs_symlink * sl = sd->s_element;
+			kobj = kobject_get(sl->target_kobj);
+		} else
+			kobj = kobject_get(sd->s_element);
+	}
+	spin_unlock(&dcache_lock);
+
+	return kobj;
+}
diff -u linux/fs/sysfs.old/sysfs.h linux/fs/sysfs/sysfs.h
--- linux/fs/sysfs.old/sysfs.h	2004-12-03 12:04:45.000000000 +0800
+++ linux/fs/sysfs/sysfs.h	2004-12-09 13:09:40.000000000 +0800
@@ -98,41 +98,8 @@
 	return ((struct bin_attribute *) sd->s_element);
 }
 
-static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
-{
-	struct kobject * kobj = NULL;
-
-	spin_lock(&dcache_lock);
-	if (!d_unhashed(dentry)) {
-		struct sysfs_dirent * sd = dentry->d_fsdata;
-		if (sd->s_type == SYSFS_ATTR_GROUP) {
-			sd = dentry->d_parent->d_fsdata;
-			BUG_ON(sd->s_type != SYSFS_DIR);
-		}
-		if (sd->s_type & SYSFS_KOBJ_LINK) {
-			struct sysfs_symlink * sl = sd->s_element;
-			kobj = kobject_get(sl->target_kobj);
-		} else
-			kobj = kobject_get(sd->s_element);
-	}
-	spin_unlock(&dcache_lock);
-
-	return kobj;
-}
-
-static inline void release_sysfs_dirent(struct sysfs_dirent * sd)
-{
-	if (sd->s_type & SYSFS_KOBJ_LINK) {
-		struct sysfs_symlink * sl = sd->s_element;
-		kfree(sl->link_name);
-		kobject_put(sl->target_kobj);
-		kfree(sl);
-	}
-	if (sysfs_type_dir(sd->s_type))
-		kmem_cache_free(sysfs_dir_cachep, to_sysfs_dir(sd));
-	else
-		kmem_cache_free(sysfs_dirent_cachep, sd);
-}
+extern struct kobject *sysfs_get_kobject(struct dentry *dentry);
+extern void release_sysfs_dirent(struct sysfs_dirent * sd);
 
 static inline void sysfs_put(struct sysfs_dirent * sd)
 {
