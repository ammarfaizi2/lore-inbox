Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423057AbWJQExJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423057AbWJQExJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423050AbWJQEwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:52:49 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:23774 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1423055AbWJQEwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:52:44 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 2] eCryptfs: Use fsstack's generic copy inode attr
	functions
Message-Id: <f5f659cc65dcaaae61dd.1161060148@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161060146@thor.fsl.cs.sunysb.edu>
Date: Tue, 17 Oct 2006 00:42:28 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: null@josefsipek.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Replace eCryptfs specific code & calls with the more generic fsstack
equivalents and remove the eCryptfs specific functions.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

3 files changed, 24 insertions(+), 59 deletions(-)
fs/ecryptfs/file.c  |    3 +-
fs/ecryptfs/inode.c |   75 ++++++++++++---------------------------------------
fs/ecryptfs/main.c  |    5 ++-

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
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
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -30,6 +30,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/crypto.h>
+#include <linux/fs_stack.h>
 #include "ecryptfs_kernel.h"
 
 static struct dentry *lock_parent(struct dentry *dentry)
@@ -51,48 +52,6 @@ static void unlock_dir(struct dentry *di
 {
 	mutex_unlock(&dir->d_inode->i_mutex);
 	dput(dir);
-}
-
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
 }
 
 /**
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
@@ -372,7 +331,7 @@ static struct dentry *ecryptfs_lookup(st
        		"d_name.name = [%s]\n", lower_dentry,
 		lower_dentry->d_name.name);
 	lower_inode = lower_dentry->d_inode;
-	ecryptfs_copy_attr_atime(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_atime(dir, lower_dir_dentry->d_inode);
 	BUG_ON(!atomic_read(&lower_dentry->d_count));
 	ecryptfs_set_dentry_private(dentry,
 				    kmem_cache_alloc(ecryptfs_dentry_info_cache,
@@ -478,7 +437,8 @@ static int ecryptfs_link(struct dentry *
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb, 0);
 	if (rc)
 		goto out_lock;
-	ecryptfs_copy_attr_timesizes(dir, lower_new_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_new_dentry->d_inode);
+	fsstack_copy_inode_size(dir, lower_new_dentry->d_inode);
 	old_dentry->d_inode->i_nlink =
 		ecryptfs_inode_to_lower(old_dentry->d_inode)->i_nlink;
 	i_size_write(new_dentry->d_inode, file_size_save);
@@ -503,7 +463,7 @@ static int ecryptfs_unlink(struct inode 
 		ecryptfs_printk(KERN_ERR, "Error in vfs_unlink\n");
 		goto out_unlock;
 	}
-	ecryptfs_copy_attr_times(dir, lower_dir_inode);
+	fsstack_copy_attr_times(dir, lower_dir_inode);
 	dentry->d_inode->i_nlink =
 		ecryptfs_inode_to_lower(dentry->d_inode)->i_nlink;
 	dentry->d_inode->i_ctime = dir->i_ctime;
@@ -542,7 +502,8 @@ static int ecryptfs_symlink(struct inode
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
 	if (rc)
 		goto out_lock;
-	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_inode_size(dir, lower_dir_dentry->d_inode);
 out_lock:
 	unlock_dir(lower_dir_dentry);
 	dput(lower_dentry);
@@ -565,7 +526,8 @@ static int ecryptfs_mkdir(struct inode *
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
 	if (rc)
 		goto out;
-	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_inode_size(dir, lower_dir_dentry->d_inode);
 	dir->i_nlink = lower_dir_dentry->d_inode->i_nlink;
 out:
 	unlock_dir(lower_dir_dentry);
@@ -601,7 +563,7 @@ static int ecryptfs_rmdir(struct inode *
 		d_delete(tlower_dentry);
 		tlower_dentry = NULL;
 	}
-	ecryptfs_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_dir_dentry->d_inode);
 	dir->i_nlink = lower_dir_dentry->d_inode->i_nlink;
 	unlock_dir(lower_dir_dentry);
 	if (!rc)
@@ -629,7 +591,8 @@ ecryptfs_mknod(struct inode *dir, struct
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
 	if (rc)
 		goto out;
-	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	fsstack_copy_inode_size(dir, lower_dir_dentry->d_inode);
 out:
 	unlock_dir(lower_dir_dentry);
 	if (!dentry->d_inode)
@@ -658,9 +621,9 @@ ecryptfs_rename(struct inode *old_dir, s
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
 	dput(lower_new_dentry);
@@ -714,8 +677,8 @@ ecryptfs_readlink(struct dentry *dentry,
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
@@ -945,7 +908,7 @@ static int ecryptfs_setattr(struct dentr
 	}
 	rc = notify_change(lower_dentry, ia);
 out:
-	ecryptfs_copy_attr_all(inode, lower_inode);
+	fsstack_copy_attr_all(inode, lower_inode);
 	return rc;
 }
 
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -35,6 +35,7 @@
 #include <linux/pagemap.h>
 #include <linux/key.h>
 #include <linux/parser.h>
+#include <linux/fs_stack.h>
 #include "ecryptfs_kernel.h"
 
 /**
@@ -115,10 +116,10 @@ int ecryptfs_interpose(struct dentry *lo
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


