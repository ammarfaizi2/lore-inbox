Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUE1V2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUE1V2w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUE1V1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:27:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:18349 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261867AbUE1V0m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:42 -0400
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core fixes for 2.6.7-rc1
In-Reply-To: <20040528212511.GA12470@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 28 May 2004 14:25:54 -0700
Message-Id: <10857795543986@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.7.1, 2004/05/17 10:32:30-07:00, maneesh@in.ibm.com

[PATCH] fix-sysfs-symlinks.patch

- Rediffed the patch for 2.6.6-mm3 to fix rejects in the latest changes
  in sysfs code.

o The symlinks code in sysfs doesnot point to the correct target kobject
  whenever target kobject is renamed and suffers from dangling symlinks
  if target kobject is removed.

o The following patch implements ->readlink and ->follow_link operations
  for sysfs instead of using the page_symlink_inode_operations.
  The pointer to target kobject is saved in the link dentry's d_fsdata field.
  The target path is generated everytime we do ->readlink and ->follow_link.
  This results in generating the correct target path during readlink and
  follow_link operations inspite of renamed target kobject.

o This also pins the target kobject during link creation and the ref. is
  released when the link is removed.

o Apart from being correct this patch also saves some memory by not pinning
  a whole page for saving the target information.

o Used a rw_semaphor sysfs_rename_sem to avoid clashing with renaming of
  ancestors while the target path is generated.

o Used dcache_lock in fs/sysfs/sysfs.h:sysfs_get_kobject() because of using
  d_drop() while removing dentries.


 fs/sysfs/dir.c     |   12 ++++
 fs/sysfs/inode.c   |    7 ++
 fs/sysfs/symlink.c |  135 ++++++++++++++++++++++++++++++++++++-----------------
 fs/sysfs/sysfs.h   |    7 +-
 4 files changed, 116 insertions(+), 45 deletions(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	Fri May 28 14:18:34 2004
+++ b/fs/sysfs/dir.c	Fri May 28 14:18:34 2004
@@ -10,6 +10,8 @@
 #include <linux/kobject.h>
 #include "sysfs.h"
 
+DECLARE_RWSEM(sysfs_rename_sem);
+
 static int init_dir(struct inode * inode)
 {
 	inode->i_op = &simple_dir_inode_operations;
@@ -134,8 +136,14 @@
 			/**
 			 * Unlink and unhash.
 			 */
+			__d_drop(d);
 			spin_unlock(&dcache_lock);
-			d_delete(d);
+			/* release the target kobject in case of 
+			 * a symlink
+			 */
+			if (S_ISLNK(d->d_inode->i_mode))
+				kobject_put(d->d_fsdata);
+			
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			pr_debug(" done\n");
@@ -165,6 +173,7 @@
 	if (!kobj->parent)
 		return -EINVAL;
 
+	down_write(&sysfs_rename_sem);
 	parent = kobj->parent->dentry;
 
 	down(&parent->d_inode->i_sem);
@@ -179,6 +188,7 @@
 		dput(new_dentry);
 	}
 	up(&parent->d_inode->i_sem);	
+	up_write(&sysfs_rename_sem);
 
 	return error;
 }
diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	Fri May 28 14:18:34 2004
+++ b/fs/sysfs/inode.c	Fri May 28 14:18:34 2004
@@ -96,7 +96,12 @@
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
 
-			d_delete(victim);
+			d_drop(victim);
+			/* release the target kobject in case of 
+			 * a symlink
+			 */
+			if (S_ISLNK(victim->d_inode->i_mode))
+				kobject_put(victim->d_fsdata);
 			simple_unlink(dir->d_inode,victim);
 		}
 		/*
diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c	Fri May 28 14:18:34 2004
+++ b/fs/sysfs/symlink.c	Fri May 28 14:18:34 2004
@@ -8,27 +8,17 @@
 
 #include "sysfs.h"
 
+static struct inode_operations sysfs_symlink_inode_operations = {
+	.readlink = sysfs_readlink,
+	.follow_link = sysfs_follow_link,
+};
 
 static int init_symlink(struct inode * inode)
 {
-	inode->i_op = &page_symlink_inode_operations;
+	inode->i_op = &sysfs_symlink_inode_operations;
 	return 0;
 }
 
-static int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
-{
-	int error;
-
-	error = sysfs_create(dentry, S_IFLNK|S_IRWXUGO, init_symlink);
-	if (!error) {
-		int l = strlen(symname)+1;
-		error = page_symlink(dentry->d_inode, symname, l);
-		if (error)
-			iput(dentry->d_inode);
-	}
-	return error;
-}
-
 static int object_depth(struct kobject * kobj)
 {
 	struct kobject * p = kobj;
@@ -74,37 +64,20 @@
 	struct dentry * dentry = kobj->dentry;
 	struct dentry * d;
 	int error = 0;
-	int size;
-	int depth;
-	char * path;
-	char * s;
-
-	depth = object_depth(kobj);
-	size = object_path_length(target) + depth * 3 - 1;
-	if (size > PATH_MAX)
-		return -ENAMETOOLONG;
-	pr_debug("%s: depth = %d, size = %d\n",__FUNCTION__,depth,size);
-
-	path = kmalloc(size,GFP_KERNEL);
-	if (!path)
-		return -ENOMEM;
-	memset(path,0,size);
-
-	for (s = path; depth--; s += 3)
-		strcpy(s,"../");
-
-	fill_object_path(target,path,size);
-	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
 
 	down(&dentry->d_inode->i_sem);
 	d = sysfs_get_dentry(dentry,name);
-	if (!IS_ERR(d))
-		error = sysfs_symlink(dentry->d_inode,d,path);
-	else
+	if (!IS_ERR(d)) {
+		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
+		if (!error)
+			/* 
+			 * associate the link dentry with the target kobject 
+			 */
+			d->d_fsdata = kobject_get(target);
+		dput(d);
+	} else 
 		error = PTR_ERR(d);
-	dput(d);
 	up(&dentry->d_inode->i_sem);
-	kfree(path);
 	return error;
 }
 
@@ -120,6 +93,86 @@
 	sysfs_hash_and_remove(kobj->dentry,name);
 }
 
+static int sysfs_get_target_path(struct kobject * kobj, struct kobject * target,
+				   char *path)
+{
+	char * s;
+	int depth, size;
+
+	depth = object_depth(kobj);
+	size = object_path_length(target) + depth * 3 - 1;
+	if (size > PATH_MAX)
+		return -ENAMETOOLONG;
+
+	pr_debug("%s: depth = %d, size = %d\n", __FUNCTION__, depth, size);
+
+	for (s = path; depth--; s += 3)
+		strcpy(s,"../");
+
+	fill_object_path(target, path, size);
+	pr_debug("%s: path = '%s'\n", __FUNCTION__, path);
+
+	return 0;
+}
+
+static int sysfs_getlink(struct dentry *dentry, char * path)
+{
+	struct kobject *kobj, *target_kobj;
+	int error = 0;
+
+	kobj = sysfs_get_kobject(dentry->d_parent);
+	if (!kobj)
+		return -EINVAL;
+
+	target_kobj = sysfs_get_kobject(dentry);
+	if (!target_kobj) {
+		kobject_put(kobj);
+		return -EINVAL;
+	}
+
+	down_read(&sysfs_rename_sem);
+	error = sysfs_get_target_path(kobj, target_kobj, path);
+	up_read(&sysfs_rename_sem);
+	
+	kobject_put(kobj);
+	kobject_put(target_kobj);
+	return error;
+
+}
+
+int sysfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
+{
+	int error = 0;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	error = sysfs_getlink(dentry, (char *) page);
+	if (!error)
+	        error = vfs_readlink(dentry, buffer, buflen, (char *) page);
+
+	free_page(page);
+
+	return error;
+}
+
+int sysfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	int error = 0;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	error = sysfs_getlink(dentry, (char *) page); 
+	if (!error)
+	        error = vfs_follow_link(nd, (char *) page);
+
+	free_page(page);
+
+	return error;
+}
 
 EXPORT_SYMBOL(sysfs_create_link);
 EXPORT_SYMBOL(sysfs_remove_link);
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	Fri May 28 14:18:34 2004
+++ b/fs/sysfs/sysfs.h	Fri May 28 14:18:34 2004
@@ -12,15 +12,18 @@
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
 
+extern int sysfs_readlink(struct dentry *, char __user *, int );
+extern int sysfs_follow_link(struct dentry *, struct nameidata *);
+extern struct rw_semaphore sysfs_rename_sem;
 
 static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
 {
 	struct kobject * kobj = NULL;
 
-	spin_lock(&dentry->d_lock);
+	spin_lock(&dcache_lock);
 	if (!d_unhashed(dentry))
 		kobj = kobject_get(dentry->d_fsdata);
-	spin_unlock(&dentry->d_lock);
+	spin_unlock(&dcache_lock);
 
 	return kobj;
 }

