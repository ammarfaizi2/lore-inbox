Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWKBPVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWKBPVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWKBPVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:21:04 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:13991 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751360AbWKBPU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:20:56 -0500
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 3/3] fsstack: Make ecryptfs a user of new fsstack_* functions
Date: Wed, 01 Nov 2006 22:59:30 -0500
To: linux-kernel@vger.kernel.org
Message-Id: <20061102035928.679.4632.stgit@thor.fsl.cs.sunysb.edu>
In-Reply-To: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch makes eCryptfs a user of the generic fsstack lower object fsstack
structures and functions.

Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Erez Zadok <ezk@cs.sunysb.edu>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
---

 fs/ecryptfs/crypto.c          |    4 +-
 fs/ecryptfs/dentry.c          |    6 +--
 fs/ecryptfs/ecryptfs_kernel.h |   84 ++++++------------------------------------
 fs/ecryptfs/file.c            |   34 ++++++++---------
 fs/ecryptfs/inode.c           |   72 ++++++++++++++++++------------------
 fs/ecryptfs/main.c            |    8 ++--
 fs/ecryptfs/mmap.c            |   18 ++++-----
 fs/ecryptfs/super.c           |   10 ++---
 8 files changed, 89 insertions(+), 147 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f49f105..736adcb 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -482,7 +482,7 @@ #define ECRYPTFS_PAGE_STATE_MODIFIED  2
 #define ECRYPTFS_PAGE_STATE_WRITTEN   3
 	int page_state;
 
-	lower_inode = ecryptfs_inode_to_lower(ctx->page->mapping->host);
+	lower_inode = fsstack_lower_inode(ctx->page->mapping->host);
 	inode_info = ecryptfs_inode_to_private(ctx->page->mapping->host);
 	crypt_stat = &inode_info->crypt_stat;
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)) {
@@ -616,7 +616,7 @@ int ecryptfs_decrypt_page(struct file *f
 
 	crypt_stat = &(ecryptfs_inode_to_private(
 			       page->mapping->host)->crypt_stat);
-	lower_inode = ecryptfs_inode_to_lower(page->mapping->host);
+	lower_inode = fsstack_lower_inode(page->mapping->host);
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)) {
 		rc = ecryptfs_do_readpage(file, page, page->index);
 		if (rc)
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 0b9992a..6559d82 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -42,8 +42,8 @@ #include "ecryptfs_kernel.h"
  */
 static int ecryptfs_d_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct vfsmount *lower_mnt = ecryptfs_dentry_to_lower_mnt(dentry);
+	struct dentry *lower_dentry = fsstack_lower_dentry(dentry);
+	struct vfsmount *lower_mnt = fsstack_lower_mnt(dentry);
 	struct dentry *dentry_save;
 	struct vfsmount *vfsmount_save;
 	int rc = 1;
@@ -73,7 +73,7 @@ static void ecryptfs_d_release(struct de
 {
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	if (ecryptfs_dentry_to_private(dentry))
 		kmem_cache_free(ecryptfs_dentry_info_cache,
 				ecryptfs_dentry_to_private(dentry));
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 870a65b..2f46258 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -30,6 +30,7 @@ #include <keys/user-type.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
+#include <linux/fs_stack.h>
 
 /* Version verification for shared data structures w/ userspace */
 #define ECRYPTFS_VERSION_MAJOR 0x00
@@ -218,17 +219,20 @@ #define ECRYPTFS_KEY_VALID          0x00
 	struct mutex cs_mutex;
 };
 
-/* inode private data. */
+/* inode private data.
+ *
+ * fsstack requires inode to be first, and info to be second
+ */
 struct ecryptfs_inode_info {
 	struct inode vfs_inode;
-	struct inode *wii_inode;
+	struct fsstack_inode_info info;
 	struct ecryptfs_crypt_stat crypt_stat;
 };
 
 /* dentry private data. Each dentry must keep track of a lower
- * vfsmount too. */
+ * vfsmount too - fsstack requires info to be first */
 struct ecryptfs_dentry_info {
-	struct path lower_path;
+	struct fsstack_dentry_info info;
 	struct ecryptfs_crypt_stat *crypt_stat;
 };
 
@@ -252,15 +256,15 @@ #define ECRYPTFS_PLAINTEXT_PASSTHROUGH_E
 	unsigned char global_auth_tok_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
 };
 
-/* superblock private data. */
+/* superblock private data - fsstack requires info to be first */
 struct ecryptfs_sb_info {
-	struct super_block *wsi_sb;
+	struct fsstack_sb_info info;
 	struct ecryptfs_mount_crypt_stat mount_crypt_stat;
 };
 
-/* file private data. */
+/* file private data - fsstack requires info to be first */
 struct ecryptfs_file_info {
-	struct file *wfi_file;
+	struct fsstack_file_info info;
 	struct ecryptfs_crypt_stat *crypt_stat;
 };
 
@@ -284,35 +288,12 @@ ecryptfs_set_file_private(struct file *f
 	file->private_data = file_info;
 }
 
-static inline struct file *ecryptfs_file_to_lower(struct file *file)
-{
-	return ((struct ecryptfs_file_info *)file->private_data)->wfi_file;
-}
-
-static inline void
-ecryptfs_set_file_lower(struct file *file, struct file *lower_file)
-{
-	((struct ecryptfs_file_info *)file->private_data)->wfi_file =
-		lower_file;
-}
-
 static inline struct ecryptfs_inode_info *
 ecryptfs_inode_to_private(struct inode *inode)
 {
 	return container_of(inode, struct ecryptfs_inode_info, vfs_inode);
 }
 
-static inline struct inode *ecryptfs_inode_to_lower(struct inode *inode)
-{
-	return ecryptfs_inode_to_private(inode)->wii_inode;
-}
-
-static inline void
-ecryptfs_set_inode_lower(struct inode *inode, struct inode *lower_inode)
-{
-	ecryptfs_inode_to_private(inode)->wii_inode = lower_inode;
-}
-
 static inline struct ecryptfs_sb_info *
 ecryptfs_superblock_to_private(struct super_block *sb)
 {
@@ -326,23 +307,10 @@ ecryptfs_set_superblock_private(struct s
 	sb->s_fs_info = sb_info;
 }
 
-static inline struct super_block *
-ecryptfs_superblock_to_lower(struct super_block *sb)
-{
-	return ((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb;
-}
-
-static inline void
-ecryptfs_set_superblock_lower(struct super_block *sb,
-			      struct super_block *lower_sb)
-{
-	((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb = lower_sb;
-}
-
 static inline struct ecryptfs_dentry_info *
 ecryptfs_dentry_to_private(struct dentry *dentry)
 {
-	return (struct ecryptfs_dentry_info *)dentry->d_fsdata;
+	return dentry->d_fsdata;
 }
 
 static inline void
@@ -352,32 +320,6 @@ ecryptfs_set_dentry_private(struct dentr
 	dentry->d_fsdata = dentry_info;
 }
 
-static inline struct dentry *
-ecryptfs_dentry_to_lower(struct dentry *dentry)
-{
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry;
-}
-
-static inline void
-ecryptfs_set_dentry_lower(struct dentry *dentry, struct dentry *lower_dentry)
-{
-	((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry =
-		lower_dentry;
-}
-
-static inline struct vfsmount *
-ecryptfs_dentry_to_lower_mnt(struct dentry *dentry)
-{
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.mnt;
-}
-
-static inline void
-ecryptfs_set_dentry_lower_mnt(struct dentry *dentry, struct vfsmount *lower_mnt)
-{
-	((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.mnt =
-		lower_mnt;
-}
-
 #define ecryptfs_printk(type, fmt, arg...) \
         __ecryptfs_printk(type "%s: " fmt, __FUNCTION__, ## arg);
 void __ecryptfs_printk(const char *fmt, ...);
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 8064e90..06e322d 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -117,8 +117,8 @@ static ssize_t ecryptfs_read_update_atim
 	if (-EIOCBQUEUED == rc)
 		rc = wait_on_sync_kiocb(iocb);
 	if (rc >= 0) {
-		lower_dentry = ecryptfs_dentry_to_lower(file->f_path.dentry);
-		lower_vfsmount = ecryptfs_dentry_to_lower_mnt(file->f_path.dentry);
+ 		lower_dentry = fsstack_lower_dentry(file->f_path.dentry);
+ 		lower_vfsmount = fsstack_lower_mnt(file->f_path.dentry);
 		touch_atime(lower_vfsmount, lower_dentry);
 	}
 	return rc;
@@ -175,7 +175,7 @@ static int ecryptfs_readdir(struct file 
 	struct inode *inode;
 	struct ecryptfs_getdents_callback buf;
 
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_file = fsstack_lower_file(file);
 	lower_file->f_pos = file->f_pos;
 	inode = file->f_path.dentry->d_inode;
 	memset(&buf, 0, sizeof(buf));
@@ -243,7 +243,7 @@ static int ecryptfs_open(struct inode *i
 	struct dentry *ecryptfs_dentry = file->f_path.dentry;
 	/* Private value of ecryptfs_dentry allocated in
 	 * ecryptfs_lookup() */
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	struct dentry *lower_dentry = fsstack_lower_dentry(ecryptfs_dentry);
 	struct inode *lower_inode = NULL;
 	struct file *lower_file = NULL;
 	struct vfsmount *lower_mnt;
@@ -260,7 +260,7 @@ static int ecryptfs_open(struct inode *i
 		goto out;
 	}
 	memset(file_info, 0, sizeof(*file_info));
-	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	lower_dentry = fsstack_lower_dentry(ecryptfs_dentry);
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 		ecryptfs_dentry->d_sb)->mount_crypt_stat;
@@ -277,14 +277,14 @@ static int ecryptfs_open(struct inode *i
 		lower_flags = (lower_flags & O_ACCMODE) | O_RDWR;
 	if (file->f_flags & O_APPEND)
 		lower_flags &= ~O_APPEND;
-	lower_mnt = ecryptfs_dentry_to_lower_mnt(ecryptfs_dentry);
+	lower_mnt = fsstack_lower_mnt(ecryptfs_dentry);
 	/* Corresponding fput() in ecryptfs_release() */
 	if ((rc = ecryptfs_open_lower_file(&lower_file, lower_dentry, lower_mnt,
 					   lower_flags))) {
 		ecryptfs_printk(KERN_ERR, "Error opening lower file\n");
 		goto out_puts;
 	}
-	ecryptfs_set_file_lower(file, lower_file);
+	fsstack_set_lower_file(file, lower_file);
 	/* Isn't this check the same as the one in lookup? */
 	lower_inode = lower_dentry->d_inode;
 	if (S_ISDIR(ecryptfs_dentry->d_inode->i_mode)) {
@@ -338,7 +338,7 @@ static int ecryptfs_open(struct inode *i
 	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = [0x%.16x] "
 			"size: [0x%.16x]\n", inode, inode->i_ino,
 			i_size_read(inode));
-	ecryptfs_set_file_lower(file, lower_file);
+	fsstack_set_lower_file(file, lower_file);
 	goto out;
 out_puts:
 	mntput(lower_mnt);
@@ -354,7 +354,7 @@ static int ecryptfs_flush(struct file *f
 	int rc = 0;
 	struct file *lower_file = NULL;
 
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_file = fsstack_lower_file(file);
 	if (lower_file->f_op && lower_file->f_op->flush)
 		rc = lower_file->f_op->flush(lower_file, td);
 	return rc;
@@ -362,9 +362,9 @@ static int ecryptfs_flush(struct file *f
 
 static int ecryptfs_release(struct inode *inode, struct file *file)
 {
-	struct file *lower_file = ecryptfs_file_to_lower(file);
+	struct file *lower_file = fsstack_lower_file(file);
 	struct ecryptfs_file_info *file_info = ecryptfs_file_to_private(file);
-	struct inode *lower_inode = ecryptfs_inode_to_lower(inode);
+	struct inode *lower_inode = fsstack_lower_inode(inode);
 	int rc;
 
 	if ((rc = ecryptfs_close_lower_file(lower_file))) {
@@ -380,8 +380,8 @@ out:
 static int
 ecryptfs_fsync(struct file *file, struct dentry *dentry, int datasync)
 {
-	struct file *lower_file = ecryptfs_file_to_lower(file);
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	struct file *lower_file = fsstack_lower_file(file);
+	struct dentry *lower_dentry = fsstack_lower_dentry(dentry);
 	struct inode *lower_inode = lower_dentry->d_inode;
 	int rc = -EINVAL;
 
@@ -399,7 +399,7 @@ static int ecryptfs_fasync(int fd, struc
 	int rc = 0;
 	struct file *lower_file = NULL;
 
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_file = fsstack_lower_file(file);
 	if (lower_file->f_op && lower_file->f_op->fasync)
 		rc = lower_file->f_op->fasync(fd, lower_file, flag);
 	return rc;
@@ -411,7 +411,7 @@ static ssize_t ecryptfs_sendfile(struct 
 	struct file *lower_file = NULL;
 	int rc = -EINVAL;
 
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_file = fsstack_lower_file(file);
 	if (lower_file->f_op && lower_file->f_op->sendfile)
 		rc = lower_file->f_op->sendfile(lower_file, ppos, count,
 						actor, target);
@@ -459,9 +459,9 @@ ecryptfs_ioctl(struct inode *inode, stru
 	struct file *lower_file = NULL;
 
 	if (ecryptfs_file_to_private(file))
-		lower_file = ecryptfs_file_to_lower(file);
+		lower_file = fsstack_lower_file(file);
 	if (lower_file && lower_file->f_op && lower_file->f_op->ioctl)
-		rc = lower_file->f_op->ioctl(ecryptfs_inode_to_lower(inode),
+		rc = lower_file->f_op->ioctl(fsstack_lower_inode(inode),
 					     lower_file, cmd, arg);
 	else
 		rc = -ENOTTY;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index cfcfcbf..c5c21e8 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -71,8 +71,8 @@ ecryptfs_create_underlying_file(struct i
 				struct dentry *dentry, int mode,
 				struct nameidata *nd)
 {
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct vfsmount *lower_mnt = ecryptfs_dentry_to_lower_mnt(dentry);
+	struct dentry *lower_dentry = fsstack_lower_dentry(dentry);
+	struct vfsmount *lower_mnt = fsstack_lower_mnt(dentry);
 	struct dentry *dentry_save;
 	struct vfsmount *vfsmount_save;
 	int rc;
@@ -109,7 +109,7 @@ ecryptfs_do_create(struct inode *directo
 	struct dentry *lower_dentry;
 	struct dentry *lower_dir_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	lower_dentry = fsstack_lower_dentry(ecryptfs_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	if (unlikely(IS_ERR(lower_dir_dentry))) {
 		ecryptfs_printk(KERN_ERR, "Error locking directory of "
@@ -158,7 +158,7 @@ static int grow_file(struct dentry *ecry
 	fake_file.f_path.dentry = ecryptfs_dentry;
 	memset(&tmp_file_info, 0, sizeof(tmp_file_info));
 	ecryptfs_set_file_private(&fake_file, &tmp_file_info);
-	ecryptfs_set_file_lower(&fake_file, lower_file);
+	fsstack_set_lower_file(&fake_file, lower_file);
 	rc = ecryptfs_fill_zeros(&fake_file, 1);
 	if (rc) {
 		ECRYPTFS_SET_FLAG(
@@ -194,7 +194,7 @@ static int ecryptfs_initialize_file(stru
 	struct inode *inode, *lower_inode;
 	struct vfsmount *lower_mnt;
 
-	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	lower_dentry = fsstack_lower_dentry(ecryptfs_dentry);
 	ecryptfs_printk(KERN_DEBUG, "lower_dentry->d_name.name = [%s]\n",
 			lower_dentry->d_name.name);
 	inode = ecryptfs_dentry->d_inode;
@@ -203,7 +203,7 @@ static int ecryptfs_initialize_file(stru
 #if BITS_PER_LONG != 32
 	lower_flags |= O_LARGEFILE;
 #endif
-	lower_mnt = ecryptfs_dentry_to_lower_mnt(ecryptfs_dentry);
+	lower_mnt = fsstack_lower_mnt(ecryptfs_dentry);
 	/* Corresponding fput() at end of this function */
 	if ((rc = ecryptfs_open_lower_file(&lower_file, lower_dentry, lower_mnt,
 					   lower_flags))) {
@@ -291,7 +291,7 @@ static struct dentry *ecryptfs_lookup(st
 	struct inode *lower_inode;
 	u64 file_size;
 
-	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
+	lower_dir_dentry = fsstack_lower_dentry(dentry->d_parent);
 	dentry->d_op = &ecryptfs_dops;
 	if ((dentry->d_name.len == 1 && !strcmp(dentry->d_name.name, "."))
 	    || (dentry->d_name.len == 2
@@ -335,8 +335,8 @@ static struct dentry *ecryptfs_lookup(st
 				"to allocate ecryptfs_dentry_info struct\n");
 		goto out_dput;
 	}
-	ecryptfs_set_dentry_lower(dentry, lower_dentry);
-	ecryptfs_set_dentry_lower_mnt(dentry, lower_mnt);
+	fsstack_set_lower_dentry(dentry, lower_dentry);
+	fsstack_set_lower_mnt(dentry, lower_mnt);
 	if (!lower_dentry->d_inode) {
 		/* We want to add because we couldn't find in lower */
 		d_add(dentry, NULL);
@@ -409,8 +409,8 @@ static int ecryptfs_link(struct dentry *
 	int rc;
 
 	file_size_save = i_size_read(old_dentry->d_inode);
-	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
+	lower_old_dentry = fsstack_lower_dentry(old_dentry);
+	lower_new_dentry = fsstack_lower_dentry(new_dentry);
 	dget(lower_old_dentry);
 	dget(lower_new_dentry);
 	lower_dir_dentry = lock_parent(lower_new_dentry);
@@ -424,7 +424,7 @@ static int ecryptfs_link(struct dentry *
 	fsstack_copy_attr_times(dir, lower_new_dentry->d_inode);
 	fsstack_copy_inode_size(dir, lower_new_dentry->d_inode);
 	old_dentry->d_inode->i_nlink =
-		ecryptfs_inode_to_lower(old_dentry->d_inode)->i_nlink;
+		fsstack_lower_inode(old_dentry->d_inode)->i_nlink;
 	i_size_write(new_dentry->d_inode, file_size_save);
 out_lock:
 	unlock_dir(lower_dir_dentry);
@@ -438,8 +438,8 @@ out_lock:
 static int ecryptfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int rc = 0;
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct inode *lower_dir_inode = ecryptfs_inode_to_lower(dir);
+	struct dentry *lower_dentry = fsstack_lower_dentry(dentry);
+	struct inode *lower_dir_inode = fsstack_lower_inode(dir);
 
 	lock_parent(lower_dentry);
 	rc = vfs_unlink(lower_dir_inode, lower_dentry);
@@ -449,7 +449,7 @@ static int ecryptfs_unlink(struct inode 
 	}
 	fsstack_copy_attr_times(dir, lower_dir_inode);
 	dentry->d_inode->i_nlink =
-		ecryptfs_inode_to_lower(dentry->d_inode)->i_nlink;
+		fsstack_lower_inode(dentry->d_inode)->i_nlink;
 	dentry->d_inode->i_ctime = dir->i_ctime;
 out_unlock:
 	unlock_parent(lower_dentry);
@@ -467,7 +467,7 @@ static int ecryptfs_symlink(struct inode
 	unsigned int encoded_symlen;
 	struct ecryptfs_crypt_stat *crypt_stat = NULL;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	dget(lower_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	mode = S_IALLUGO;
@@ -502,7 +502,7 @@ static int ecryptfs_mkdir(struct inode *
 	struct dentry *lower_dentry;
 	struct dentry *lower_dir_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	rc = vfs_mkdir(lower_dir_dentry->d_inode, lower_dentry, mode);
 	if (rc || !lower_dentry->d_inode)
@@ -526,7 +526,7 @@ static int ecryptfs_rmdir(struct inode *
 	struct dentry *lower_dir_dentry;
 	int rc;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	dget(dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	dget(lower_dentry);
@@ -550,7 +550,7 @@ ecryptfs_mknod(struct inode *dir, struct
 	struct dentry *lower_dentry;
 	struct dentry *lower_dir_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	rc = vfs_mknod(lower_dir_dentry->d_inode, lower_dentry, mode, dev);
 	if (rc || !lower_dentry->d_inode)
@@ -577,8 +577,8 @@ ecryptfs_rename(struct inode *old_dir, s
 	struct dentry *lower_old_dir_dentry;
 	struct dentry *lower_new_dir_dentry;
 
-	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
+	lower_old_dentry = fsstack_lower_dentry(old_dentry);
+	lower_new_dentry = fsstack_lower_dentry(new_dentry);
 	dget(lower_old_dentry);
 	dget(lower_new_dentry);
 	lower_old_dir_dentry = dget_parent(lower_old_dentry);
@@ -608,7 +608,7 @@ ecryptfs_readlink(struct dentry *dentry,
 	mm_segment_t old_fs;
 	struct ecryptfs_crypt_stat *crypt_stat;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op ||
 	    !lower_dentry->d_inode->i_op->readlink) {
 		rc = -EINVAL;
@@ -760,16 +760,16 @@ int ecryptfs_truncate(struct dentry *den
 		rc = -ENOMEM;
 		goto out;
 	}
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	/* This dget & mntget is released through fput at out_fput: */
-	lower_mnt = ecryptfs_dentry_to_lower_mnt(dentry);
+	lower_mnt = fsstack_lower_mnt(dentry);
 	if ((rc = ecryptfs_open_lower_file(&lower_file, lower_dentry, lower_mnt,
 					   O_RDWR))) {
 		ecryptfs_printk(KERN_ERR,
 				"Error opening dentry; rc = [%i]\n", rc);
 		goto out_free;
 	}
-	ecryptfs_set_file_lower(&fake_ecryptfs_file, lower_file);
+	fsstack_set_lower_file(&fake_ecryptfs_file, lower_file);
 	/* Switch on growing or shrinking file */
 	if (new_length > i_size) {
 		rc = ecryptfs_fill_zeros(&fake_ecryptfs_file, new_length);
@@ -827,13 +827,13 @@ ecryptfs_permission(struct inode *inode,
 		struct vfsmount *vfsmnt_save = nd->mnt;
 		struct dentry *dentry_save = nd->dentry;
 
-		nd->mnt = ecryptfs_dentry_to_lower_mnt(nd->dentry);
-		nd->dentry = ecryptfs_dentry_to_lower(nd->dentry);
-		rc = permission(ecryptfs_inode_to_lower(inode), mask, nd);
+		nd->mnt = fsstack_lower_mnt(nd->dentry);
+		nd->dentry = fsstack_lower_dentry(nd->dentry);
+		rc = permission(fsstack_lower_inode(inode), mask, nd);
 		nd->mnt = vfsmnt_save;
 		nd->dentry = dentry_save;
         } else
-		rc = permission(ecryptfs_inode_to_lower(inode), mask, NULL);
+		rc = permission(fsstack_lower_inode(inode), mask, NULL);
         return rc;
 }
 
@@ -858,9 +858,9 @@ static int ecryptfs_setattr(struct dentr
 	struct ecryptfs_crypt_stat *crypt_stat;
 
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	inode = dentry->d_inode;
-	lower_inode = ecryptfs_inode_to_lower(inode);
+	lower_inode = fsstack_lower_inode(inode);
 	if (ia->ia_valid & ATTR_SIZE) {
 		ecryptfs_printk(KERN_DEBUG,
 				"ia->ia_valid = [0x%x] ATTR_SIZE" " = [0x%x]\n",
@@ -886,7 +886,7 @@ ecryptfs_setxattr(struct dentry *dentry,
 	int rc = 0;
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op->setxattr) {
 		rc = -ENOSYS;
 		goto out;
@@ -906,7 +906,7 @@ ecryptfs_getxattr(struct dentry *dentry,
 	int rc = 0;
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op->getxattr) {
 		rc = -ENOSYS;
 		goto out;
@@ -925,7 +925,7 @@ ecryptfs_listxattr(struct dentry *dentry
 	int rc = 0;
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op->listxattr) {
 		rc = -ENOSYS;
 		goto out;
@@ -942,7 +942,7 @@ static int ecryptfs_removexattr(struct d
 	int rc = 0;
 	struct dentry *lower_dentry;
 
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_dentry = fsstack_lower_dentry(dentry);
 	if (!lower_dentry->d_inode->i_op->removexattr) {
 		rc = -ENOSYS;
 		goto out;
@@ -956,7 +956,7 @@ out:
 
 int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode)
 {
-	if ((ecryptfs_inode_to_lower(inode)
+	if ((fsstack_lower_inode(inode)
 	     == (struct inode *)candidate_lower_inode))
 		return 1;
 	else
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index a4aee57..06f5479 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -79,7 +79,7 @@ int ecryptfs_interpose(struct dentry *lo
 	int rc = 0;
 
 	lower_inode = lower_dentry->d_inode;
-	if (lower_inode->i_sb != ecryptfs_superblock_to_lower(sb)) {
+	if (lower_inode->i_sb != fsstack_lower_sb(sb)) {
 		rc = -EXDEV;
 		goto out;
 	}
@@ -449,10 +449,10 @@ static int ecryptfs_read_super(struct su
 		goto out_free;
 	}
 	lower_mnt = nd.mnt;
-	ecryptfs_set_superblock_lower(sb, lower_root->d_sb);
+	fsstack_set_lower_sb(sb, lower_root->d_sb);
 	sb->s_maxbytes = lower_root->d_sb->s_maxbytes;
-	ecryptfs_set_dentry_lower(sb->s_root, lower_root);
-	ecryptfs_set_dentry_lower_mnt(sb->s_root, lower_mnt);
+	fsstack_set_lower_dentry(sb->s_root, lower_root);
+	fsstack_set_lower_mnt(sb->s_root, lower_mnt);
 	if ((rc = ecryptfs_interpose(lower_root, sb->s_root, sb, 0)))
 		goto out_free;
 	rc = 0;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 3001189..419b907 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -219,10 +219,10 @@ int ecryptfs_do_readpage(struct file *fi
 	const struct address_space_operations *lower_a_ops;
 
 	dentry = file->f_path.dentry;
-	lower_file = ecryptfs_file_to_lower(file);
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+ 	lower_file = fsstack_lower_file(file);
+ 	lower_dentry = fsstack_lower_dentry(dentry);
 	inode = dentry->d_inode;
-	lower_inode = ecryptfs_inode_to_lower(inode);
+ 	lower_inode = fsstack_lower_inode(inode);
 	lower_a_ops = lower_inode->i_mapping->a_ops;
 	lower_page = read_cache_page(lower_inode->i_mapping, lower_page_index,
 				     (filler_t *)lower_a_ops->readpage,
@@ -542,8 +542,8 @@ process_new_file(struct ecryptfs_crypt_s
 	int header_pages;
 	int more_header_data_to_be_written = 1;
 
-	lower_inode = ecryptfs_inode_to_lower(inode);
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_inode = fsstack_lower_inode(inode);
+	lower_file = fsstack_lower_file(file);
 	lower_a_ops = lower_inode->i_mapping->a_ops;
 	header_pages = ((crypt_stat->header_extent_size
 			 * crypt_stat->num_header_extents_at_front)
@@ -635,8 +635,8 @@ static int ecryptfs_commit_write(struct 
 	int rc;
 
 	inode = page->mapping->host;
-	lower_inode = ecryptfs_inode_to_lower(inode);
-	lower_file = ecryptfs_file_to_lower(file);
+	lower_inode = fsstack_lower_inode(inode);
+	lower_file = fsstack_lower_file(file);
 	mutex_lock(&lower_inode->i_mutex);
 	crypt_stat = &ecryptfs_inode_to_private(file->f_path.dentry->d_inode)
 				->crypt_stat;
@@ -749,7 +749,7 @@ static sector_t ecryptfs_bmap(struct add
 	struct inode *lower_inode;
 
 	inode = (struct inode *)mapping->host;
-	lower_inode = ecryptfs_inode_to_lower(inode);
+	lower_inode = fsstack_lower_inode(inode);
 	if (lower_inode->i_mapping->a_ops->bmap)
 		rc = lower_inode->i_mapping->a_ops->bmap(lower_inode->i_mapping,
 							 block);
@@ -763,7 +763,7 @@ static void ecryptfs_sync_page(struct pa
 	struct page *lower_page;
 
 	inode = page->mapping->host;
-	lower_inode = ecryptfs_inode_to_lower(inode);
+	lower_inode = fsstack_lower_inode(inode);
 	/* NOTE: Recently swapped with grab_cache_page(), since
 	 * sync_page() just makes sure that pending I/O gets done. */
 	lower_page = find_lock_page(lower_inode->i_mapping, page->index);
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 825757a..904283a 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -85,7 +85,7 @@ static void ecryptfs_destroy_inode(struc
  */
 void ecryptfs_init_inode(struct inode *inode, struct inode *lower_inode)
 {
-	ecryptfs_set_inode_lower(inode, lower_inode);
+	fsstack_set_lower_inode(inode, lower_inode);
 	inode->i_ino = lower_inode->i_ino;
 	inode->i_version++;
 	inode->i_op = &ecryptfs_main_iops;
@@ -119,7 +119,7 @@ static void ecryptfs_put_super(struct su
  */
 static int ecryptfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	return vfs_statfs(ecryptfs_dentry_to_lower(dentry), buf);
+	return vfs_statfs(fsstack_lower_dentry(dentry), buf);
 }
 
 /**
@@ -134,7 +134,7 @@ static int ecryptfs_statfs(struct dentry
  */
 static void ecryptfs_clear_inode(struct inode *inode)
 {
-	iput(ecryptfs_inode_to_lower(inode));
+	iput(fsstack_lower_inode(inode));
 }
 
 /**
@@ -146,8 +146,8 @@ static void ecryptfs_clear_inode(struct 
 static int ecryptfs_show_options(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
-	struct dentry *lower_root_dentry = ecryptfs_dentry_to_lower(sb->s_root);
-	struct vfsmount *lower_mnt = ecryptfs_dentry_to_lower_mnt(sb->s_root);
+	struct dentry *lower_root_dentry = fsstack_lower_dentry(sb->s_root);
+	struct vfsmount *lower_mnt = fsstack_lower_mnt(sb->s_root);
 	char *tmp_page;
 	char *path;
 	int rc = 0;

