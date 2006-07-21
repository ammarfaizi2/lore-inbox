Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWGUBEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWGUBEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 21:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWGUBEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 21:04:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:58826 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030419AbWGUBEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 21:04:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZgjA6Pi5j88rb7GXtU3BH3eMlVQnX/pa7ntNrDhq/4KAY2pTzyJy796aPBCoN5pNYsCrh4LknwcMt/6PFf2cDzP0+ZWJF3HfOQBZtChGsf6Aa8UfrjjxLFW0FVRXyiSrpjdXxOc49xtOzrJnYvm2KZJO8QybNrwWFrxtc00zh28=
Message-ID: <bda6d13a0607201804je89fc3exd0b8f821509a3894@mail.gmail.com>
Date: Thu, 20 Jul 2006 18:04:49 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: what is necessary for directory hard links
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the sum total of all that I had to change in the kernel
VFS layer to support hard links to directories and a few worse things
(hard links to things that are sometimes directories). Never mind
about do_path_lookup. I call that from an ioctl (flink).

Note the missing signed-off line. Not ready for mainline. Not adequitely tested.
Also understand that a filesystem cannot just set the flags and expect
hard links to work for it. There will be races: the target directory
for any operation is locked, but the item is not.
Oh, and any user will have to implement d_revalidate.

If you say this shouldn't be done maybe you're right but I'm doing it
for myself anyway.
If you have constructive feedback I will listen. If you want this in
kernel, you better have
a worthy user for it and be ready to hammer it. Tested with light load
on one filesystem on one architecture with one set of configuration
options doesn't quailfy. I haven't even passed it through the lock
validator yet because the backing filesystem isn't ready.

---
diff -rup -X linux-2.6.18-rc2/Documentation/dontdiff
linux-2.6.18-rc2/fs/namei.c linux-2.6.18-rc2-kb0/fs/namei.c
--- linux-2.6.18-rc2/fs/namei.c	2006-07-17 18:53:13.000000000 -0700
+++ linux-2.6.18-rc2-kb0/fs/namei.c	2006-07-17 17:35:43.000000000 -0700
@@ -1069,7 +1069,7 @@ set_it:
 }

 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
-static int fastcall do_path_lookup(int dfd, const char *name,
+int fastcall do_path_lookup(int dfd, const char *name,
 				unsigned int flags, struct nameidata *nd)
 {
 	int retval = 0;
@@ -1416,13 +1416,22 @@ static inline int lookup_flags(unsigned
 }

 /*
+ * Return true if assumptions in Documentation/filesystems/directory-locking
+ * are false [fs must set]. FS must have replacement locking in itself.
+ */
+static inline int fs_is_insane(struct inode *inode)
+{
+	return inode->i_sb->s_type->fs_flags & FS_OWN_LOCKS;
+}
+
+/*
  * p1 and p2 should be directories on the same fs.
  */
 struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;

-	if (p1 == p2) {
+	if (p1->d_inode == p2->d_inode) {
 		mutex_lock_nested(&p1->d_inode->i_mutex, I_MUTEX_PARENT);
 		return NULL;
 	}
@@ -1453,7 +1462,7 @@ struct dentry *lock_rename(struct dentry
 void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	mutex_unlock(&p1->d_inode->i_mutex);
-	if (p1 != p2) {
+	if (p1->d_inode != p2->d_inode) {
 		mutex_unlock(&p2->d_inode->i_mutex);
 		mutex_unlock(&p1->d_inode->i_sb->s_vfs_rename_mutex);
 	}
@@ -1967,7 +1976,8 @@ int vfs_rmdir(struct inode *dir, struct

 	DQUOT_INIT(dir);

-	mutex_lock(&dentry->d_inode->i_mutex);
+	if (!(unlikely(fs_is_insane(dentry->d_inode))))
+		mutex_lock(&dentry->d_inode->i_mutex);
 	dentry_unhash(dentry);
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
@@ -1975,11 +1985,12 @@ int vfs_rmdir(struct inode *dir, struct
 		error = security_inode_rmdir(dir, dentry);
 		if (!error) {
 			error = dir->i_op->rmdir(dir, dentry);
-			if (!error)
+			if (!error && likely(dentry->d_inode->i_nlink == 0))
 				dentry->d_inode->i_flags |= S_DEAD;
 		}
 	}
-	mutex_unlock(&dentry->d_inode->i_mutex);
+	if (!(unlikely(fs_is_insane(dentry->d_inode))))
+		mutex_unlock(&dentry->d_inode->i_mutex);
 	if (!error) {
 		d_delete(dentry);
 	}
@@ -2046,7 +2057,8 @@ int vfs_unlink(struct inode *dir, struct

 	DQUOT_INIT(dir);

-	mutex_lock(&dentry->d_inode->i_mutex);
+	if (!(unlikely(fs_is_insane(dentry->d_inode))))
+		mutex_lock(&dentry->d_inode->i_mutex);
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
@@ -2054,7 +2066,8 @@ int vfs_unlink(struct inode *dir, struct
 		if (!error)
 			error = dir->i_op->unlink(dir, dentry);
 	}
-	mutex_unlock(&dentry->d_inode->i_mutex);
+	if (!(unlikely(fs_is_insane(dentry->d_inode))))
+		mutex_unlock(&dentry->d_inode->i_mutex);

 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
 	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
@@ -2216,16 +2229,20 @@ int vfs_link(struct dentry *old_dentry,
 	if (!dir->i_op || !dir->i_op->link)
 		return -EPERM;
 	if (S_ISDIR(old_dentry->d_inode->i_mode))
-		return -EPERM;
+		if (!old_dentry->d_inode->i_sb->s_type->fs_flags
+					& FS_ALLOW_HLINK_DIR)
+			return -EPERM;

 	error = security_inode_link(old_dentry, dir, new_dentry);
 	if (error)
 		return error;

-	mutex_lock(&old_dentry->d_inode->i_mutex);
+	if (!(unlikely(fs_is_insane(old_dentry->d_inode))))
+		mutex_lock(&old_dentry->d_inode->i_mutex);
 	DQUOT_INIT(dir);
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
-	mutex_unlock(&old_dentry->d_inode->i_mutex);
+	if (!(unlikely(fs_is_insane(old_dentry->d_inode))))
+		mutex_unlock(&old_dentry->d_inode->i_mutex);
 	if (!error)
 		fsnotify_create(dir, new_dentry);
 	return error;
@@ -2343,7 +2360,8 @@ static int vfs_rename_dir(struct inode *

 	target = new_dentry->d_inode;
 	if (target) {
-		mutex_lock(&target->i_mutex);
+		if (!(unlikely(fs_is_insane(target))))
+			mutex_lock(&target->i_mutex);
 		dentry_unhash(new_dentry);
 	}
 	if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
@@ -2353,7 +2371,8 @@ static int vfs_rename_dir(struct inode *
 	if (target) {
 		if (!error)
 			target->i_flags |= S_DEAD;
-		mutex_unlock(&target->i_mutex);
+		if (!(unlikely(fs_is_insane(target))))
+			mutex_unlock(&target->i_mutex);
 		if (d_unhashed(new_dentry))
 			d_rehash(new_dentry);
 		dput(new_dentry);
@@ -2375,7 +2394,7 @@ static int vfs_rename_other(struct inode

 	dget(new_dentry);
 	target = new_dentry->d_inode;
-	if (target)
+	if (target && !(unlikely(fs_is_insane(target))))
 		mutex_lock(&target->i_mutex);
 	if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
@@ -2386,7 +2405,7 @@ static int vfs_rename_other(struct inode
 		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
 			d_move(old_dentry, new_dentry);
 	}
-	if (target)
+	if (target && !(unlikely(fs_is_insane(target))))
 		mutex_unlock(&target->i_mutex);
 	dput(new_dentry);
 	return error;
@@ -2713,6 +2732,7 @@ EXPORT_SYMBOL(__page_symlink);
 EXPORT_SYMBOL(page_symlink);
 EXPORT_SYMBOL(page_symlink_inode_operations);
 EXPORT_SYMBOL(path_lookup);
+EXPORT_SYMBOL(do_path_lookup);
 EXPORT_SYMBOL(path_release);
 EXPORT_SYMBOL(path_walk);
 EXPORT_SYMBOL(permission);
diff -rup -X linux-2.6.18-rc2/Documentation/dontdiff
linux-2.6.18-rc2/include/linux/fs.h
linux-2.6.18-rc2-kb0/include/linux/fs.h
--- linux-2.6.18-rc2/include/linux/fs.h	2006-07-17 18:53:25.000000000 -0700
+++ linux-2.6.18-rc2-kb0/include/linux/fs.h	2006-07-17 17:30:58.000000000 -0700
@@ -91,6 +91,8 @@ extern int dir_notify_enable;
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1
 #define FS_BINARY_MOUNTDATA 2
+#define FS_ALLOW_HLINK_DIR 4
+#define FS_OWN_LOCKS 8
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
Only in linux-2.6.18-rc2-kb0/include/linux: utsrelease.h
