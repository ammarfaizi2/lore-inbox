Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936291AbWLDMqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936291AbWLDMqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936305AbWLDMqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:46:35 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46302 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936291AbWLDMeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:34:37 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 03/35] eCryptfs: Use fsstack's generic copy inode attr functions
Date: Mon,  4 Dec 2006 07:30:36 -0500
Message-Id: <11652354681162-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Replace eCryptfs specific code & calls with the more generic fsstack
equivalents and remove the eCryptfs specific functions.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
 fs/ecryptfs/file.c  |    3 +-
 fs/ecryptfs/inode.c |   75 +++++++++++++--------------------------------------
 fs/ecryptfs/main.c  |    5 ++-
 3 files changed, 24 insertions(+), 59 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index a92ef05..a961a0c 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -30,6 +30,7 @@
 #include <linux/security.h>
 #include <linux/smp_lock.h>
 #include <linux/compat.h>
+#include <linux/fs_stack.h>
 #include "ecryptfs_kernel.h"
 
 /**
@@ -192,7 +193,7 @@ retry:
 		goto retry;
 	file->f_pos = lower_file->f_pos;
 	if (rc >= 0)
-		ecryptfs_copy_attr_atime(inode, lower_file->f_dentry->d_inode);
+		fsstack_copy_attr_atime(inode, lower_file->f_dentry->d_inode);
 	return rc;
 }
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index dfcc684..3e2a786 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -30,6 +30,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/crypto.h>
+#include <linux/fs_stack.h>
 #include "ecryptfs_kernel.h"
 
 static struct dentry *lock_parent(struct dentry *dentry)
@@ -53,48 +54,6 @@ static void unlock_dir(struct dentry *di
 	dput(dir);
 }
 
-void ecryptfs_copy_inode_size(struct inode *dst, const struct inode *src)
-{
-	i_size_write(dst, i_size_read((struct inode *)src));
-	dst->i_blocks = src->i_blocks;
-}
-
-void ecryptfs_copy_attr_atime(struct inode *dest, const struct inode *src)
-{
-	dest->i_atime = src->i_atime;
-}
-
-static void ecryptfs_copy_attr_times(struct inode *dest,
-				     const struct inode *src)
-{
-	dest->i_atime = src->i_atime;
-	dest->i_mtime = src->i_mtime;
-	dest->i_ctime = src->i_ctime;
-}
-
-static void ecryptfs_copy_attr_timesizes(struct inode *dest,
-					 const struct inode *src)
-{
-	dest->i_atime = src->i_atime;
-	dest->i_mtime = src->i_mtime;
-	dest->i_ctime = src->i_ctime;
-	ecryptfs_copy_inode_size(dest, src);
-}
-
-void ecryptfs_copy_attr_all(struct inode *dest, const struct inode *src)
-{
-	dest->i_mode = src->i_mode;
-	dest->i_nlink = src->i_nlink;
-	dest->i_uid = src->i_uid;
-	dest->i_gid = src->i_gid;
-	dest->i_rdev = src->i_rdev;
-	dest->i_atime = src->i_atime;
-	dest->i_mtime = src->i_mtime;
-	dest->i_ctime = src->i_ctime;
-	dest->i_blkbits = src->i_blkbits;
-	dest->i_flags = src->i_flags;
-}
-
 /**
  * ecryptfs_create_underlying_file
  * @lower_dir_inode: inode of the parent in the lower fs of the new file
@@ -171,8 +130,8 @@ ecryptfs_do_create(struct inode *directo
 		ecryptfs_printk(KERN_ERR, "Failure in ecryptfs_interpose\n");
 		goto out_lock;
 	}
-	ecryptfs_copy_attr_timesizes(directory_inode,
-				     lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(directory_inode, lower_dir_dentry->d_inode);
+	fsstack_copy_inode_size(directory_inode, lower_dir_dentry->d_inode);
 out_lock:
 	unlock_dir(lower_dir_dentry);
 out:
@@ -365,7 +324,7 @@ static struct dentry *ecryptfs_lookup(st
        		"d_name.name = [%s]\n", lower_dentry,
 		lower_dentry->d_name.name);
 	lower_inode = lower_dentry->d_inode;
-	ecryptfs_copy_attr_atime(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_atime(dir, lower_dir_dentry->d_inode);
 	BUG_ON(!atomic_read(&lower_dentry->d_count));
 	ecryptfs_set_dentry_private(dentry,
 				    kmem_cache_alloc(ecryptfs_dentry_info_cache,
@@ -462,7 +421,8 @@ static int ecryptfs_link(struct dentry *
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb, 0);
 	if (rc)
 		goto out_lock;
-	ecryptfs_copy_attr_timesizes(dir, lower_new_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_new_dentry->d_inode);
+	fsstack_copy_inode_size(dir, lower_new_dentry->d_inode);
 	old_dentry->d_inode->i_nlink =
 		ecryptfs_inode_to_lower(old_dentry->d_inode)->i_nlink;
 	i_size_write(new_dentry->d_inode, file_size_save);
@@ -488,7 +448,7 @@ static int ecryptfs_unlink(struct inode
 		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
 	}
-	ecryptfs_copy_attr_times(dir, lower_dir_inode);
+	fsstack_copy_attr_times(dir, lower_dir_inode);
 	dentry->d_inode->i_nlink =
 		ecryptfs_inode_to_lower(dentry->d_inode)->i_nlink;
 	dentry->d_inode->i_ctime = dir->i_ctime;
@@ -527,7 +487,8 @@ static int ecryptfs_symlink(struct inode
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
 	if (rc)
 		goto out_lock;
-	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_inode_size(dir, lower_dir_dentry->d_inode);
 out_lock:
 	unlock_dir(lower_dir_dentry);
 	dput(lower_dentry);
@@ -550,7 +511,8 @@ static int ecryptfs_mkdir(struct inode *
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
 	if (rc)
 		goto out;
-	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_inode_size(dir, lower_dir_dentry->d_inode);
 	dir->i_nlink = lower_dir_dentry->d_inode->i_nlink;
 out:
 	unlock_dir(lower_dir_dentry);
@@ -573,7 +535,7 @@ static int ecryptfs_rmdir(struct inode *
 	dput(lower_dentry);
 	if (!rc)
 		d_delete(lower_dentry);
-	ecryptfs_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_dir_dentry->d_inode);
 	dir->i_nlink = lower_dir_dentry->d_inode->i_nlink;
 	unlock_dir(lower_dir_dentry);
 	if (!rc)
@@ -597,7 +559,8 @@ ecryptfs_mknod(struct inode *dir, struct
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
 	if (rc)
 		goto out;
-	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_inode_size(dir, lower_dir_dentry->d_inode);
 out:
 	unlock_dir(lower_dir_dentry);
 	if (!dentry->d_inode)
@@ -626,9 +589,9 @@ ecryptfs_rename(struct inode *old_dir, s
 			lower_new_dir_dentry->d_inode, lower_new_dentry);
 	if (rc)
 		goto out_lock;
-	ecryptfs_copy_attr_all(new_dir, lower_new_dir_dentry->d_inode);
+	fsstack_copy_attr_all(new_dir, lower_new_dir_dentry->d_inode);
 	if (new_dir != old_dir)
-		ecryptfs_copy_attr_all(old_dir, lower_old_dir_dentry->d_inode);
+		fsstack_copy_attr_all(old_dir, lower_old_dir_dentry->d_inode);
 out_lock:
 	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
 	dput(lower_new_dentry->d_parent);
@@ -684,8 +647,8 @@ ecryptfs_readlink(struct dentry *dentry,
 				rc = -EFAULT;
 		}
 		kfree(decoded_name);
-		ecryptfs_copy_attr_atime(dentry->d_inode,
-					 lower_dentry->d_inode);
+		fsstack_copy_attr_atime(dentry->d_inode,
+					lower_dentry->d_inode);
 	}
 out_free_lower_buf:
 	kfree(lower_buf);
@@ -915,7 +878,7 @@ static int ecryptfs_setattr(struct dentr
 	}
 	rc = notify_change(lower_dentry, ia);
 out:
-	ecryptfs_copy_attr_all(inode, lower_inode);
+	fsstack_copy_attr_all(inode, lower_inode);
 	return rc;
 }
 
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index a78d87d..5982931 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -35,6 +35,7 @@
 #include <linux/pagemap.h>
 #include <linux/key.h>
 #include <linux/parser.h>
+#include <linux/fs_stack.h>
 #include "ecryptfs_kernel.h"
 
 /**
@@ -112,10 +113,10 @@ int ecryptfs_interpose(struct dentry *lo
 		d_add(dentry, inode);
 	else
 		d_instantiate(dentry, inode);
-	ecryptfs_copy_attr_all(inode, lower_inode);
+	fsstack_copy_attr_all(inode, lower_inode);
 	/* This size will be overwritten for real files w/ headers and
 	 * other metadata */
-	ecryptfs_copy_inode_size(inode, lower_inode);
+	fsstack_copy_inode_size(inode, lower_inode);
 out:
 	return rc;
 }
-- 
1.4.3.3

