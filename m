Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbUKVUa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUKVUa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbUKVTYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:24:07 -0500
Received: from [61.51.204.161] ([61.51.204.161]:31718 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S262367AbUKVTVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:21:31 -0500
Date: Tue, 23 Nov 2004 03:17:33 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411221917.iAMJHXg02123@freya.yggdrasil.com>
To: greg@kroah.com
Subject: [Patch] Delete sysfs_dirent.s_count, saving ~100kB on my system
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The following patch against linux-2.6.10-rc2-bk6 removes
the s_count field from sysfs_dirent.  This reduces sizeof(sysfs_dirent)
from 36 to 32 bytes on 32-bit machines, resulting in big space
savings because it reduces the size that kmalloc actually uses for
the allocation from 64 to 32 bytes, and there is one of these for
every node in sysfs, of which there are 3405 on the modest desktop
machine that I'm using to compose this email.  That's a savings of
108,960 bytes of unswappable kernel memory in this case.

	Reference counting appears to me to be unnecessary on this
data structure.  sysfs_dirent exists when a node name is registered in
sysfs, and it does not exist when the node name is not registered.
It does not matter if a program is still holding a reference to the
struct inode when sysfs_dirent is deleted, since sysfs_dirent is only
relevant to directory lookup operations.  It also should not matter if the
system is freeing the struct inode and the struct dentry to save
space.  As long as the file is registered in sysfs, the sysfs_dirent
is not freed.

	Removing sysfs_dirent.s_count results in the removal of other
supporting code, including sysfs_dentry_ops, for a net deletion of
39 lines of code.

	I have only tested this patch by mounting /sys, and running
some "find" commands on it, plugging and unplugging a USB device,
and verifying that the number of entries in sysfs increased and
decreased accordingly.  I am running it on the system on which I
am composing this email.

	By the way, I think there is hope in future for reducing
sizeof(sysfs_dirent) to 32 bytes or less on platforms with 64-bit
pointers too, by some combination of changing s_sibling and s_children
to singly linked lists, eliminating s_dentry, only allocating s_children
for directories, and/or stufffing s_type and s_mode into unused poniter
bits (although I doubt it would come to this last resort, and that might
not be worth the maintainability cost if it did).

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--- linux-2.6.10-rc2-bk6/include/linux/sysfs.h	2004-11-17 18:59:17.000000000 +0800
+++ linux/include/linux/sysfs.h	2004-11-23 01:40:35.000000000 +0800
@@ -60,7 +60,6 @@
 };
 
 struct sysfs_dirent {
-	atomic_t		s_count;
 	struct list_head	s_sibling;
 	struct list_head	s_children;
 	void 			* s_element;
diff -u linux-2.6.10-rc2-bk6/fs/sysfs/dir.c linux/fs/sysfs/dir.c
--- linux-2.6.10-rc2-bk6/fs/sysfs/dir.c	2004-11-22 21:15:11.000000000 +0800
+++ linux/fs/sysfs/dir.c	2004-11-23 01:56:18.000000000 +0800
@@ -12,22 +12,6 @@
 
 DECLARE_RWSEM(sysfs_rename_sem);
 
-static void sysfs_d_iput(struct dentry * dentry, struct inode * inode)
-{
-	struct sysfs_dirent * sd = dentry->d_fsdata;
-
-	if (sd) {
-		BUG_ON(sd->s_dentry != dentry);
-		sd->s_dentry = NULL;
-		sysfs_put(sd);
-	}
-	iput(inode);
-}
-
-static struct dentry_operations sysfs_dentry_ops = {
-	.d_iput		= sysfs_d_iput,
-};
-
 /*
  * Allocates a new sysfs_dirent and links it to the parent sysfs_dirent
  */
@@ -41,7 +25,6 @@
 		return NULL;
 
 	memset(sd, 0, sizeof(*sd));
-	atomic_set(&sd->s_count, 1);
 	INIT_LIST_HEAD(&sd->s_children);
 	list_add(&sd->s_sibling, &parent_sd->s_children);
 	sd->s_element = element;
@@ -61,10 +44,8 @@
 	sd->s_mode = mode;
 	sd->s_type = type;
 	sd->s_dentry = dentry;
-	if (dentry) {
-		dentry->d_fsdata = sysfs_get(sd);
-		dentry->d_op = &sysfs_dentry_ops;
-	}
+	if (dentry)
+		dentry->d_fsdata = sd;
 
 	return 0;
 }
@@ -107,7 +88,6 @@
 						SYSFS_DIR);
 			if (!error) {
 				p->d_inode->i_nlink++;
-				(*d)->d_op = &sysfs_dentry_ops;
 				d_rehash(*d);
 			}
 		}
@@ -179,8 +159,7 @@
 		dentry->d_inode->i_size = bin_attr->size;
 		dentry->d_inode->i_fop = &bin_fops;
 	}
-	dentry->d_op = &sysfs_dentry_ops;
-	dentry->d_fsdata = sysfs_get(sd);
+	dentry->d_fsdata = sd;
 	sd->s_dentry = dentry;
 	d_rehash(dentry);
 
@@ -193,8 +172,7 @@
 
 	err = sysfs_create(dentry, S_IFLNK|S_IRWXUGO, init_symlink);
 	if (!err) {
-		dentry->d_op = &sysfs_dentry_ops;
-		dentry->d_fsdata = sysfs_get(sd);
+		dentry->d_fsdata = sd;
 		sd->s_dentry = dentry;
 		d_rehash(dentry);
 	}
@@ -239,7 +217,7 @@
 	d_delete(d);
 	sd = d->d_fsdata;
  	list_del_init(&sd->s_sibling);
-	sysfs_put(sd);
+	release_sysfs_dirent(sd);
 	if (d->d_inode)
 		simple_rmdir(parent->d_inode,d);
 
@@ -282,7 +260,7 @@
 			continue;
 		list_del_init(&sd->s_sibling);
 		sysfs_drop_dentry(sd, dentry);
-		sysfs_put(sd);
+		release_sysfs_dirent(sd);
 	}
 	up(&dentry->d_inode->i_sem);
 
diff -u linux-2.6.10-rc2-bk6/fs/sysfs/inode.c linux/fs/sysfs/inode.c
--- linux-2.6.10-rc2-bk6/fs/sysfs/inode.c	2004-11-17 18:59:13.000000000 +0800
+++ linux/fs/sysfs/inode.c	2004-11-23 01:51:26.000000000 +0800
@@ -151,7 +151,7 @@
 		if (!strcmp(sysfs_get_name(sd), name)) {
 			list_del_init(&sd->s_sibling);
 			sysfs_drop_dentry(sd, dir);
-			sysfs_put(sd);
+			release_sysfs_dirent(sd);
 			break;
 		}
 	}
diff -u linux-2.6.10-rc2-bk6/fs/sysfs/sysfs.h linux/fs/sysfs/sysfs.h
--- linux-2.6.10-rc2-bk6/fs/sysfs/sysfs.h	2004-11-17 18:59:13.000000000 +0800
+++ linux/fs/sysfs/sysfs.h	2004-11-23 01:54:30.000000000 +0800
@@ -76,19 +76,3 @@
 	}
 	kfree(sd);
 }
-
-static inline struct sysfs_dirent * sysfs_get(struct sysfs_dirent * sd)
-{
-	if (sd) {
-		WARN_ON(!atomic_read(&sd->s_count));
-		atomic_inc(&sd->s_count);
-	}
-	return sd;
-}
-
-static inline void sysfs_put(struct sysfs_dirent * sd)
-{
-	if (atomic_dec_and_test(&sd->s_count))
-		release_sysfs_dirent(sd);
-}
-
