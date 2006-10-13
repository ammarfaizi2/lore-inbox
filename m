Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWJMNXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWJMNXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWJMNXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:23:33 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10418 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750720AbWJMNXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:23:31 -0400
Date: Fri, 13 Oct 2006 16:23:29 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org, jsipek@cs.sunysb.edu, ezk@cs.sunysb.edu,
       mhalcrow@us.ibm.com, phillip@hellewell.homeip.net
Subject: [RFC/PATCH 2/2] ecryptfs: use stackfs functions
Message-ID: <Pine.LNX.4.64.0610131622110.563@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Convert ecryptfs to use the generic stackfs stackfs_hidden_<...> functions.

Cc: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Cc: Erez Zadok <ezk@cs.sunysb.edu>
Cc: Mike Halcrow <mhalcrow@us.ibm.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/ecryptfs/crypto.c          |    4 +-
 fs/ecryptfs/dentry.c          |    6 +--
 fs/ecryptfs/ecryptfs_kernel.h |   55 +++++++++--------------------------
 fs/ecryptfs/file.c            |   30 +++++++++----------
 fs/ecryptfs/inode.c           |   66 +++++++++++++++++++++---------------------
 fs/ecryptfs/main.c            |    7 +++-
 fs/ecryptfs/mmap.c            |   18 +++++------
 fs/ecryptfs/super.c           |   10 +++---
 8 files changed, 87 insertions(+), 109 deletions(-)

Index: 2.6/fs/ecryptfs/ecryptfs_kernel.h
===================================================================
--- 2.6.orig/fs/ecryptfs/ecryptfs_kernel.h
+++ 2.6/fs/ecryptfs/ecryptfs_kernel.h
@@ -29,6 +29,7 @@
 #include <keys/user-type.h>
 #include <linux/fs.h>
 #include <linux/scatterlist.h>
+#include <linux/stack_fs.h>
 
 /* Version verification for shared data structures w/ userspace */
 #define ECRYPTFS_VERSION_MAJOR 0x00
@@ -218,15 +219,15 @@ struct ecryptfs_crypt_stat {
 
 /* inode private data. */
 struct ecryptfs_inode_info {
+	struct stackfs_inode_info info;		/* stackfs expects this to be first */
 	struct inode vfs_inode;
-	struct inode *wii_inode;
 	struct ecryptfs_crypt_stat crypt_stat;
 };
 
 /* dentry private data. Each dentry must keep track of a lower
  * vfsmount too. */
 struct ecryptfs_dentry_info {
-	struct dentry *wdi_dentry;
+	struct stackfs_dentry_info info;	/* stackfs expects this to be first */
 	struct vfsmount *lower_mnt;
 	struct ecryptfs_crypt_stat *crypt_stat;
 };
@@ -253,13 +254,13 @@ struct ecryptfs_mount_crypt_stat {
 
 /* superblock private data. */
 struct ecryptfs_sb_info {
-	struct super_block *wsi_sb;
+	struct stackfs_sb_info info;	/* stackfs expects this to be first */
 	struct ecryptfs_mount_crypt_stat mount_crypt_stat;
 };
 
 /* file private data. */
 struct ecryptfs_file_info {
-	struct file *wfi_file;
+	struct stackfs_file_info info;	/* stackfs expects this to be first */
 	struct ecryptfs_crypt_stat *crypt_stat;
 };
 
@@ -283,16 +284,11 @@ ecryptfs_set_file_private(struct file *f
 	file->private_data = file_info;
 }
 
-static inline struct file *ecryptfs_file_to_lower(struct file *file)
-{
-	return ((struct ecryptfs_file_info *)file->private_data)->wfi_file;
-}
-
 static inline void
 ecryptfs_set_file_lower(struct file *file, struct file *lower_file)
 {
-	((struct ecryptfs_file_info *)file->private_data)->wfi_file =
-		lower_file;
+	struct ecryptfs_file_info *info = file->private_data;
+	info->info.hidden_files[0] = lower_file;
 }
 
 static inline struct ecryptfs_inode_info *
@@ -301,15 +297,11 @@ ecryptfs_inode_to_private(struct inode *
 	return container_of(inode, struct ecryptfs_inode_info, vfs_inode);
 }
 
-static inline struct inode *ecryptfs_inode_to_lower(struct inode *inode)
-{
-	return ecryptfs_inode_to_private(inode)->wii_inode;
-}
-
 static inline void
 ecryptfs_set_inode_lower(struct inode *inode, struct inode *lower_inode)
 {
-	ecryptfs_inode_to_private(inode)->wii_inode = lower_inode;
+	struct ecryptfs_inode_info *info = ecryptfs_inode_to_private(inode);
+	info->info.hidden_inodes[0] = lower_inode;
 }
 
 static inline struct ecryptfs_sb_info *
@@ -325,17 +317,12 @@ ecryptfs_set_superblock_private(struct s
 	sb->s_fs_info = sb_info;
 }
 
-static inline struct super_block *
-ecryptfs_superblock_to_lower(struct super_block *sb)
-{
-	return ((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb;
-}
-
 static inline void
 ecryptfs_set_superblock_lower(struct super_block *sb,
 			      struct super_block *lower_sb)
 {
-	((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb = lower_sb;
+	struct ecryptfs_sb_info *info = sb->s_fs_info;
+	info->info.hidden_sbs[0] = lower_sb;
 }
 
 static inline struct ecryptfs_dentry_info *
@@ -351,30 +338,18 @@ ecryptfs_set_dentry_private(struct dentr
 	dentry->d_fsdata = dentry_info;
 }
 
-static inline struct dentry *
-ecryptfs_dentry_to_lower(struct dentry *dentry)
-{
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->wdi_dentry;
-}
-
 static inline void
 ecryptfs_set_dentry_lower(struct dentry *dentry, struct dentry *lower_dentry)
 {
-	((struct ecryptfs_dentry_info *)dentry->d_fsdata)->wdi_dentry =
-		lower_dentry;
-}
-
-static inline struct vfsmount *
-ecryptfs_dentry_to_lower_mnt(struct dentry *dentry)
-{
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_mnt;
+	struct ecryptfs_dentry_info *info = dentry->d_fsdata;
+	info->info.hidden_dentrys[0] = lower_dentry;
 }
 
 static inline void
 ecryptfs_set_dentry_lower_mnt(struct dentry *dentry, struct vfsmount *lower_mnt)
 {
-	((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_mnt =
-		lower_mnt;
+	struct ecryptfs_dentry_info *info = dentry->d_fsdata;
+	info->info.hidden_mnts[0] = lower_mnt;
 }
 
 #define ecryptfs_printk(type, fmt, arg...) \
Index: 2.6/fs/ecryptfs/file.c
===================================================================
--- 2.6.orig/fs/ecryptfs/file.c
+++ 2.6/fs/ecryptfs/file.c
@@ -116,8 +116,8 @@ static ssize_t ecryptfs_read_update_atim
 	if (-EIOCBQUEUED == rc)
 		rc = wait_on_sync_kiocb(iocb);
 	if (rc >= 0) {
-		lower_dentry = ecryptfs_dentry_to_lower(file->f_dentry);
-		lower_vfsmount = ecryptfs_dentry_to_lower_mnt(file->f_dentry);
+		lower_dentry = stackfs_hidden_dentry(file->f_dentry);
+		lower_vfsmount = stackfs_hidden_dentry_mnt(file->f_dentry);
 		touch_atime(lower_vfsmount, lower_dentry);
 	}
 	return rc;
@@ -174,7 +174,7 @@ static int ecryptfs_readdir(struct file 
 	struct inode *inode;
 	struct ecryptfs_getdents_callback buf;
 
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_file = stackfs_hidden_file(file);
 	lower_file->f_pos = file->f_pos;
 	inode = file->f_dentry->d_inode;
 	memset(&buf, 0, sizeof(buf));
@@ -215,7 +215,7 @@ static int ecryptfs_open(struct inode *i
 	struct dentry *ecryptfs_dentry = file->f_dentry;
 	/* Private value of ecryptfs_dentry allocated in
 	 * ecryptfs_lookup() */
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	struct dentry *lower_dentry = stackfs_hidden_dentry(ecryptfs_dentry);
 	struct inode *lower_inode = NULL;
 	struct file *lower_file = NULL;
 	struct vfsmount *lower_mnt;
@@ -232,7 +232,7 @@ static int ecryptfs_open(struct inode *i
 		goto out;
 	}
 	memset(file_info, 0, sizeof(*file_info));
-	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	lower_dentry = stackfs_hidden_dentry(ecryptfs_dentry);
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 		ecryptfs_dentry->d_sb)->mount_crypt_stat;
@@ -251,7 +251,7 @@ static int ecryptfs_open(struct inode *i
 		lower_flags = (lower_flags & O_ACCMODE) | O_RDWR;
 	if (file->f_flags & O_APPEND)
 		lower_flags &= ~O_APPEND;
-	lower_mnt = ecryptfs_dentry_to_lower_mnt(ecryptfs_dentry);
+	lower_mnt = stackfs_hidden_dentry_mnt(ecryptfs_dentry);
 	mntget(lower_mnt);
 	/* Corresponding fput() in ecryptfs_release() */
 	lower_file = dentry_open(lower_dentry, lower_mnt, lower_flags);
@@ -330,7 +330,7 @@ static int ecryptfs_flush(struct file *f
 	int rc = 0;
 	struct file *lower_file = NULL;
 
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_file = stackfs_hidden_file(file);
 	if (lower_file->f_op && lower_file->f_op->flush)
 		rc = lower_file->f_op->flush(lower_file, td);
 	return rc;
@@ -338,9 +338,9 @@ static int ecryptfs_flush(struct file *f
 
 static int ecryptfs_release(struct inode *inode, struct file *file)
 {
-	struct file *lower_file = ecryptfs_file_to_lower(file);
+	struct file *lower_file = stackfs_hidden_file(file);
 	struct ecryptfs_file_info *file_info = ecryptfs_file_to_private(file);
-	struct inode *lower_inode = ecryptfs_inode_to_lower(inode);
+	struct inode *lower_inode = stackfs_hidden_inode(inode);
 
 	fput(lower_file);
 	inode->i_blocks = lower_inode->i_blocks;
@@ -351,8 +351,8 @@ static int ecryptfs_release(struct inode
 static int
 ecryptfs_fsync(struct file *file, struct dentry *dentry, int datasync)
 {
-	struct file *lower_file = ecryptfs_file_to_lower(file);
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	struct file *lower_file = stackfs_hidden_file(file);
+	struct dentry *lower_dentry = stackfs_hidden_dentry(dentry);
 	struct inode *lower_inode = lower_dentry->d_inode;
 	int rc = -EINVAL;
 
@@ -370,7 +370,7 @@ static int ecryptfs_fasync(int fd, struc
 	int rc = 0;
 	struct file *lower_file = NULL;
 
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_file = stackfs_hidden_file(file);
 	if (lower_file->f_op && lower_file->f_op->fasync)
 		rc = lower_file->f_op->fasync(fd, lower_file, flag);
 	return rc;
@@ -382,7 +382,7 @@ static ssize_t ecryptfs_sendfile(struct 
 	struct file *lower_file = NULL;
 	int rc = -EINVAL;
 
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_file = stackfs_hidden_file(file);
 	if (lower_file->f_op && lower_file->f_op->sendfile)
 		rc = lower_file->f_op->sendfile(lower_file, ppos, count,
 						actor, target);
@@ -430,9 +430,9 @@ ecryptfs_ioctl(struct inode *inode, stru
 	struct file *lower_file = NULL;
 
 	if (ecryptfs_file_to_private(file))
-		lower_file = ecryptfs_file_to_lower(file);
+		lower_file = stackfs_hidden_file(file);
 	if (lower_file && lower_file->f_op && lower_file->f_op->ioctl)
-		rc = lower_file->f_op->ioctl(ecryptfs_inode_to_lower(inode),
+		rc = lower_file->f_op->ioctl(stackfs_hidden_inode(inode),
 					     lower_file, cmd, arg);
 	else
 		rc = -ENOTTY;
Index: 2.6/fs/ecryptfs/mmap.c
===================================================================
--- 2.6.orig/fs/ecryptfs/mmap.c
+++ 2.6/fs/ecryptfs/mmap.c
@@ -219,10 +219,10 @@ int ecryptfs_do_readpage(struct file *fi
 	const struct address_space_operations *lower_a_ops;
 
 	dentry = file->f_dentry;
-	lower_file = ecryptfs_file_to_lower(file);
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_file = stackfs_hidden_file(file);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	inode = dentry->d_inode;
-	lower_inode = ecryptfs_inode_to_lower(inode);
+	lower_inode = stackfs_hidden_inode(inode);
 	lower_a_ops = lower_inode->i_mapping->a_ops;
 	lower_page = read_cache_page(lower_inode->i_mapping, lower_page_index,
 				     (filler_t *)lower_a_ops->readpage,
@@ -542,8 +542,8 @@ process_new_file(struct ecryptfs_crypt_s
 	int header_pages;
 	int more_header_data_to_be_written = 1;
 
-	lower_inode = ecryptfs_inode_to_lower(inode);
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_inode = stackfs_hidden_inode(inode);
+	lower_file = stackfs_hidden_file(file);
 	lower_a_ops = lower_inode->i_mapping->a_ops;
 	header_pages = ((crypt_stat->header_extent_size
 			 * crypt_stat->num_header_extents_at_front)
@@ -635,8 +635,8 @@ static int ecryptfs_commit_write(struct 
 	int rc;
 
 	inode = page->mapping->host;
-	lower_inode = ecryptfs_inode_to_lower(inode);
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_inode = stackfs_hidden_inode(inode);
+	lower_file = stackfs_hidden_file(file);
 	mutex_lock(&lower_inode->i_mutex);
 	crypt_stat =
 		&ecryptfs_inode_to_private(file->f_dentry->d_inode)->crypt_stat;
@@ -749,7 +749,7 @@ static sector_t ecryptfs_bmap(struct add
 	struct inode *lower_inode;
 
 	inode = (struct inode *)mapping->host;
-	lower_inode = ecryptfs_inode_to_lower(inode);
+	lower_inode = stackfs_hidden_inode(inode);
 	if (lower_inode->i_mapping->a_ops->bmap)
 		rc = lower_inode->i_mapping->a_ops->bmap(lower_inode->i_mapping,
 							 block);
@@ -763,7 +763,7 @@ static void ecryptfs_sync_page(struct pa
 	struct page *lower_page;
 
 	inode = page->mapping->host;
-	lower_inode = ecryptfs_inode_to_lower(inode);
+	lower_inode = stackfs_hidden_inode(inode);
 	/* NOTE: Recently swapped with grab_cache_page(), since
 	 * sync_page() just makes sure that pending I/O gets done. */
 	lower_page = find_lock_page(lower_inode->i_mapping, page->index);
Index: 2.6/fs/ecryptfs/main.c
===================================================================
--- 2.6.orig/fs/ecryptfs/main.c
+++ 2.6/fs/ecryptfs/main.c
@@ -78,7 +78,7 @@ int ecryptfs_interpose(struct dentry *lo
 	int rc = 0;
 
 	lower_inode = lower_dentry->d_inode;
-	if (lower_inode->i_sb != ecryptfs_superblock_to_lower(sb)) {
+	if (lower_inode->i_sb != stackfs_hidden_sb(sb)) {
 		rc = -EXDEV;
 		goto out;
 	}
@@ -551,8 +551,11 @@ inode_info_init_once(void *vptr, struct 
 	struct ecryptfs_inode_info *ei = (struct ecryptfs_inode_info *)vptr;
 
 	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR)
+	    SLAB_CTOR_CONSTRUCTOR) {
 		inode_init_once(&ei->vfs_inode);
+		/* Needed by stackfs_hidden_inode(). */
+		ei->vfs_inode.i_private = ei;
+	}
 }
 
 static struct ecryptfs_cache_info {
Index: 2.6/fs/ecryptfs/dentry.c
===================================================================
--- 2.6.orig/fs/ecryptfs/dentry.c
+++ 2.6/fs/ecryptfs/dentry.c
@@ -41,8 +41,8 @@
  */
 static int ecryptfs_d_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct vfsmount *lower_mnt = ecryptfs_dentry_to_lower_mnt(dentry);
+	struct dentry *lower_dentry = stackfs_hidden_dentry(dentry);
+	struct vfsmount *lower_mnt = stackfs_hidden_dentry_mnt(dentry);
 	struct dentry *dentry_save;
 	struct vfsmount *vfsmount_save;
 	int rc = 1;
@@ -72,7 +72,7 @@ static void ecryptfs_d_release(struct de
 {
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	if (ecryptfs_dentry_to_private(dentry))
 		kmem_cache_free(ecryptfs_dentry_info_cache,
 				ecryptfs_dentry_to_private(dentry));
Index: 2.6/fs/ecryptfs/inode.c
===================================================================
--- 2.6.orig/fs/ecryptfs/inode.c
+++ 2.6/fs/ecryptfs/inode.c
@@ -112,8 +112,8 @@ ecryptfs_create_underlying_file(struct i
 				struct dentry *dentry, int mode,
 				struct nameidata *nd)
 {
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct vfsmount *lower_mnt = ecryptfs_dentry_to_lower_mnt(dentry);
+	struct dentry *lower_dentry = stackfs_hidden_dentry(dentry);
+	struct vfsmount *lower_mnt = stackfs_hidden_dentry_mnt(dentry);
 	struct dentry *dentry_save;
 	struct vfsmount *vfsmount_save;
 	int rc;
@@ -150,7 +150,7 @@ ecryptfs_do_create(struct inode *directo
 	struct dentry *lower_dentry;
 	struct dentry *lower_dir_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	lower_dentry = stackfs_hidden_dentry(ecryptfs_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	if (unlikely(IS_ERR(lower_dir_dentry))) {
 		ecryptfs_printk(KERN_ERR, "Error locking directory of "
@@ -236,7 +236,7 @@ static int ecryptfs_initialize_file(stru
 	struct inode *inode, *lower_inode;
 	struct vfsmount *lower_mnt;
 
-	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	lower_dentry = stackfs_hidden_dentry(ecryptfs_dentry);
 	ecryptfs_printk(KERN_DEBUG, "lower_dentry->d_name.name = [%s]\n",
 			lower_dentry->d_name.name);
 	inode = ecryptfs_dentry->d_inode;
@@ -251,7 +251,7 @@ static int ecryptfs_initialize_file(stru
 #if BITS_PER_LONG != 32
 	lower_flags |= O_LARGEFILE;
 #endif
-	lower_mnt = ecryptfs_dentry_to_lower_mnt(ecryptfs_dentry);
+	lower_mnt = stackfs_hidden_dentry_mnt(ecryptfs_dentry);
 	mntget(lower_mnt);
 	/* Corresponding fput() at end of this function */
 	lower_file = dentry_open(tlower_dentry, lower_mnt, lower_flags);
@@ -344,7 +344,7 @@ static struct dentry *ecryptfs_lookup(st
 	struct inode *lower_inode;
 	u64 file_size;
 
-	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
+	lower_dir_dentry = stackfs_hidden_dentry(dentry->d_parent);
 	dentry->d_op = &ecryptfs_dops;
 	if ((dentry->d_name.len == 1 && !strcmp(dentry->d_name.name, "."))
 	    || (dentry->d_name.len == 2 && !strcmp(dentry->d_name.name, "..")))
@@ -362,7 +362,7 @@ static struct dentry *ecryptfs_lookup(st
 	lower_dentry = lookup_one_len(encoded_name, lower_dir_dentry,
 				      encoded_namelen - 1);
 	kfree(encoded_name);
-	lower_mnt = mntget(ecryptfs_dentry_to_lower_mnt(dentry->d_parent));
+	lower_mnt = mntget(stackfs_hidden_dentry_mnt(dentry->d_parent));
 	if (IS_ERR(lower_dentry)) {
 		ecryptfs_printk(KERN_ERR, "ERR from lower_dentry\n");
 		rc = PTR_ERR(lower_dentry);
@@ -466,8 +466,8 @@ static int ecryptfs_link(struct dentry *
 	int rc;
 
 	file_size_save = i_size_read(old_dentry->d_inode);
-	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
+	lower_old_dentry = stackfs_hidden_dentry(old_dentry);
+	lower_new_dentry = stackfs_hidden_dentry(new_dentry);
 	dget(lower_old_dentry);
 	dget(lower_new_dentry);
 	lower_dir_dentry = lock_parent(lower_new_dentry);
@@ -480,7 +480,7 @@ static int ecryptfs_link(struct dentry *
 		goto out_lock;
 	ecryptfs_copy_attr_timesizes(dir, lower_new_dentry->d_inode);
 	old_dentry->d_inode->i_nlink =
-		ecryptfs_inode_to_lower(old_dentry->d_inode)->i_nlink;
+		stackfs_hidden_inode(old_dentry->d_inode)->i_nlink;
 	i_size_write(new_dentry->d_inode, file_size_save);
 out_lock:
 	unlock_dir(lower_dir_dentry);
@@ -494,8 +494,8 @@ out_lock:
 static int ecryptfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int rc = 0;
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct inode *lower_dir_inode = ecryptfs_inode_to_lower(dir);
+	struct dentry *lower_dentry = stackfs_hidden_dentry(dentry);
+	struct inode *lower_dir_inode = stackfs_hidden_inode(dir);
 
 	lock_parent(lower_dentry);
 	rc = vfs_unlink(lower_dir_inode, lower_dentry);
@@ -505,7 +505,7 @@ static int ecryptfs_unlink(struct inode 
 	}
 	ecryptfs_copy_attr_times(dir, lower_dir_inode);
 	dentry->d_inode->i_nlink =
-		ecryptfs_inode_to_lower(dentry->d_inode)->i_nlink;
+		stackfs_hidden_inode(dentry->d_inode)->i_nlink;
 	dentry->d_inode->i_ctime = dir->i_ctime;
 out_unlock:
 	unlock_parent(lower_dentry);
@@ -523,7 +523,7 @@ static int ecryptfs_symlink(struct inode
 	unsigned int encoded_symlen;
 	struct ecryptfs_crypt_stat *crypt_stat = NULL;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	dget(lower_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	mode = S_IALLUGO;
@@ -557,7 +557,7 @@ static int ecryptfs_mkdir(struct inode *
 	struct dentry *lower_dentry;
 	struct dentry *lower_dir_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	rc = vfs_mkdir(lower_dir_dentry->d_inode, lower_dentry, mode);
 	if (rc || !lower_dentry->d_inode)
@@ -582,7 +582,7 @@ static int ecryptfs_rmdir(struct inode *
 	struct dentry *tlower_dentry = NULL;
 	struct dentry *lower_dir_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	if (!(tdentry = dget(dentry))) {
 		rc = -EINVAL;
 		ecryptfs_printk(KERN_ERR, "Error dget'ing dentry [%p]\n",
@@ -621,7 +621,7 @@ ecryptfs_mknod(struct inode *dir, struct
 	struct dentry *lower_dentry;
 	struct dentry *lower_dir_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	rc = vfs_mknod(lower_dir_dentry->d_inode, lower_dentry, mode, dev);
 	if (rc || !lower_dentry->d_inode)
@@ -647,8 +647,8 @@ ecryptfs_rename(struct inode *old_dir, s
 	struct dentry *lower_old_dir_dentry;
 	struct dentry *lower_new_dir_dentry;
 
-	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
+	lower_old_dentry = stackfs_hidden_dentry(old_dentry);
+	lower_new_dentry = stackfs_hidden_dentry(new_dentry);
 	dget(lower_old_dentry);
 	dget(lower_new_dentry);
 	lower_old_dir_dentry = dget_parent(lower_old_dentry);
@@ -678,7 +678,7 @@ ecryptfs_readlink(struct dentry *dentry,
 	mm_segment_t old_fs;
 	struct ecryptfs_crypt_stat *crypt_stat;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op ||
 	    !lower_dentry->d_inode->i_op->readlink) {
 		rc = -EINVAL;
@@ -830,10 +830,10 @@ int ecryptfs_truncate(struct dentry *den
 		rc = -ENOMEM;
 		goto out;
 	}
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	/* This dget & mntget is released through fput at out_fput: */
 	dget(lower_dentry);
-	lower_mnt = ecryptfs_dentry_to_lower_mnt(dentry);
+	lower_mnt = stackfs_hidden_dentry_mnt(dentry);
 	mntget(lower_mnt);
 	lower_file = dentry_open(lower_dentry, lower_mnt, O_RDWR);
 	if (unlikely(IS_ERR(lower_file))) {
@@ -897,13 +897,13 @@ ecryptfs_permission(struct inode *inode,
 		struct vfsmount *vfsmnt_save = nd->mnt;
 		struct dentry *dentry_save = nd->dentry;
 
-		nd->mnt = ecryptfs_dentry_to_lower_mnt(nd->dentry);
-		nd->dentry = ecryptfs_dentry_to_lower(nd->dentry);
-		rc = permission(ecryptfs_inode_to_lower(inode), mask, nd);
+		nd->mnt = stackfs_hidden_dentry_mnt(nd->dentry);
+		nd->dentry = stackfs_hidden_dentry(nd->dentry);
+		rc = permission(stackfs_hidden_inode(inode), mask, nd);
 		nd->mnt = vfsmnt_save;
 		nd->dentry = dentry_save;
         } else
-		rc = permission(ecryptfs_inode_to_lower(inode), mask, NULL);
+		rc = permission(stackfs_hidden_inode(inode), mask, NULL);
         return rc;
 }
 
@@ -928,9 +928,9 @@ static int ecryptfs_setattr(struct dentr
 	struct ecryptfs_crypt_stat *crypt_stat;
 
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	inode = dentry->d_inode;
-	lower_inode = ecryptfs_inode_to_lower(inode);
+	lower_inode = stackfs_hidden_inode(inode);
 	if (ia->ia_valid & ATTR_SIZE) {
 		ecryptfs_printk(KERN_DEBUG,
 				"ia->ia_valid = [0x%x] ATTR_SIZE" " = [0x%x]\n",
@@ -956,7 +956,7 @@ ecryptfs_setxattr(struct dentry *dentry,
 	int rc = 0;
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op->setxattr) {
 		rc = -ENOSYS;
 		goto out;
@@ -976,7 +976,7 @@ ecryptfs_getxattr(struct dentry *dentry,
 	int rc = 0;
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op->getxattr) {
 		rc = -ENOSYS;
 		goto out;
@@ -995,7 +995,7 @@ ecryptfs_listxattr(struct dentry *dentry
 	int rc = 0;
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op->listxattr) {
 		rc = -ENOSYS;
 		goto out;
@@ -1012,7 +1012,7 @@ static int ecryptfs_removexattr(struct d
 	int rc = 0;
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = stackfs_hidden_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op->removexattr) {
 		rc = -ENOSYS;
 		goto out;
@@ -1026,7 +1026,7 @@ out:
 
 int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode)
 {
-	if ((ecryptfs_inode_to_lower(inode)
+	if ((stackfs_hidden_inode(inode)
 	     == (struct inode *)candidate_lower_inode))
 		return 1;
 	else
Index: 2.6/fs/ecryptfs/super.c
===================================================================
--- 2.6.orig/fs/ecryptfs/super.c
+++ 2.6/fs/ecryptfs/super.c
@@ -119,7 +119,7 @@ static void ecryptfs_put_super(struct su
  */
 static int ecryptfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	return vfs_statfs(ecryptfs_dentry_to_lower(dentry), buf);
+	return vfs_statfs(stackfs_hidden_dentry(dentry), buf);
 }
 
 /**
@@ -134,7 +134,7 @@ static int ecryptfs_statfs(struct dentry
  */
 static void ecryptfs_clear_inode(struct inode *inode)
 {
-	iput(ecryptfs_inode_to_lower(inode));
+	iput(stackfs_hidden_inode(inode));
 }
 
 /**
@@ -145,7 +145,7 @@ static void ecryptfs_clear_inode(struct 
 static void ecryptfs_umount_begin(struct vfsmount *vfsmnt, int flags)
 {
 	struct vfsmount *lower_mnt =
-		ecryptfs_dentry_to_lower_mnt(vfsmnt->mnt_sb->s_root);
+		stackfs_hidden_dentry_mnt(vfsmnt->mnt_sb->s_root);
 	struct super_block *lower_sb;
 
 	mntput(lower_mnt);
@@ -163,8 +163,8 @@ static void ecryptfs_umount_begin(struct
 static int ecryptfs_show_options(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
-	struct dentry *lower_root_dentry = ecryptfs_dentry_to_lower(sb->s_root);
-	struct vfsmount *lower_mnt = ecryptfs_dentry_to_lower_mnt(sb->s_root);
+	struct dentry *lower_root_dentry = stackfs_hidden_dentry(sb->s_root);
+	struct vfsmount *lower_mnt = stackfs_hidden_dentry_mnt(sb->s_root);
 	char *tmp_page;
 	char *path;
 	int rc = 0;
Index: 2.6/fs/ecryptfs/crypto.c
===================================================================
--- 2.6.orig/fs/ecryptfs/crypto.c
+++ 2.6/fs/ecryptfs/crypto.c
@@ -449,7 +449,7 @@ int ecryptfs_encrypt_page(struct ecryptf
 #define ECRYPTFS_PAGE_STATE_WRITTEN   3
 	int page_state;
 
-	lower_inode = ecryptfs_inode_to_lower(ctx->page->mapping->host);
+	lower_inode = stackfs_hidden_inode(ctx->page->mapping->host);
 	inode_info = ecryptfs_inode_to_private(ctx->page->mapping->host);
 	crypt_stat = &inode_info->crypt_stat;
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)) {
@@ -583,7 +583,7 @@ int ecryptfs_decrypt_page(struct file *f
 
 	crypt_stat = &(ecryptfs_inode_to_private(
 			       page->mapping->host)->crypt_stat);
-	lower_inode = ecryptfs_inode_to_lower(page->mapping->host);
+	lower_inode = stackfs_hidden_inode(page->mapping->host);
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)) {
 		rc = ecryptfs_do_readpage(file, page, page->index);
 		if (rc)
