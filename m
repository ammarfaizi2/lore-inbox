Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161547AbWJ3Xhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161547AbWJ3Xhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161548AbWJ3Xhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:37:37 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:15075 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161547AbWJ3Xhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:37:35 -0500
Date: Mon, 30 Oct 2006 17:37:30 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, mhalcrow@us.ibm.com
Subject: [PATCH 4/6] eCryptfs: Consolidate lower dentry_open's
Message-ID: <20061030233730.GC21515@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061030233209.GC3458@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233209.GC3458@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Opens on lower dentry objects happen in several places in eCryptfs,
and they all involve the same steps (dget, mntget, dentry_open). This
patch consolidates the lower open events into a single function call.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   24 +++++++++++-----------
 fs/ecryptfs/ecryptfs_kernel.h |    4 ++++
 fs/ecryptfs/file.c            |   44 ++++++++++++++++++++++++++++++++++-------
 fs/ecryptfs/inode.c           |   33 ++++++++++---------------------
 4 files changed, 63 insertions(+), 42 deletions(-)

ae8de046956510acf0bd358ac93adccc78f76e84
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 7f32fcb..3f83613 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1191,28 +1191,28 @@ int ecryptfs_cipher_code_to_string(char 
 int ecryptfs_read_header_region(char *data, struct dentry *dentry,
 				struct vfsmount *mnt)
 {
-	struct file *file;
+	struct file *lower_file;
 	mm_segment_t oldfs;
 	int rc;
 
-	mnt = mntget(mnt);
-	file = dentry_open(dentry, mnt, O_RDONLY);
-	if (IS_ERR(file)) {
-		ecryptfs_printk(KERN_DEBUG, "Error opening file to "
-				"read header region\n");
-		mntput(mnt);
-		rc = PTR_ERR(file);
+	if ((rc = ecryptfs_open_lower_file(&lower_file, dentry, mnt,
+					   O_RDONLY))) {
+		printk(KERN_ERR
+		       "Error opening lower_file to read header region\n");
 		goto out;
 	}
-	file->f_pos = 0;
+	lower_file->f_pos = 0;
 	oldfs = get_fs();
 	set_fs(get_ds());
 	/* For releases 0.1 and 0.2, all of the header information
 	 * fits in the first data extent-sized region. */
-	rc = file->f_op->read(file, (char __user *)data,
-			      ECRYPTFS_DEFAULT_EXTENT_SIZE, &file->f_pos);
+	rc = lower_file->f_op->read(lower_file, (char __user *)data,
+			      ECRYPTFS_DEFAULT_EXTENT_SIZE, &lower_file->f_pos);
 	set_fs(oldfs);
-	fput(file);
+	if ((rc = ecryptfs_close_lower_file(lower_file))) {
+		printk(KERN_ERR "Error closing lower_file\n");
+		goto out;
+	}
 	rc = 0;
 out:
 	return rc;
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 199fcda..f992533 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -482,5 +482,9 @@ ecryptfs_process_cipher(struct crypto_bl
 int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode);
 int ecryptfs_inode_set(struct inode *inode, void *lower_inode);
 void ecryptfs_init_inode(struct inode *inode, struct inode *lower_inode);
+int ecryptfs_open_lower_file(struct file **lower_file,
+			     struct dentry *lower_dentry,
+			     struct vfsmount *lower_mnt, int flags);
+int ecryptfs_close_lower_file(struct file *lower_file);
 
 #endif /* #ifndef ECRYPTFS_KERNEL_H */
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c8550c9..a92ef05 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -198,6 +198,33 @@ retry:
 
 struct kmem_cache *ecryptfs_file_info_cache;
 
+int ecryptfs_open_lower_file(struct file **lower_file,
+			     struct dentry *lower_dentry,
+			     struct vfsmount *lower_mnt, int flags)
+{
+	int rc = 0;
+
+	dget(lower_dentry);
+	mntget(lower_mnt);
+	*lower_file = dentry_open(lower_dentry, lower_mnt, flags);
+	if (IS_ERR(*lower_file)) {
+		printk(KERN_ERR "Error opening lower file for lower_dentry "
+		       "[0x%p], lower_mnt [0x%p], and flags [0x%x]\n",
+		       lower_dentry, lower_mnt, flags);
+		rc = PTR_ERR(*lower_file);
+		*lower_file = NULL;
+		goto out;
+	}
+out:
+	return rc;
+}
+
+int ecryptfs_close_lower_file(struct file *lower_file)
+{
+	fput(lower_file);
+	return 0;
+}
+
 /**
  * ecryptfs_open
  * @inode: inode speciying file to open
@@ -244,19 +271,15 @@ static int ecryptfs_open(struct inode *i
 		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
 	}
 	mutex_unlock(&crypt_stat->cs_mutex);
-	/* This mntget & dget is undone via fput when the file is released */
-	dget(lower_dentry);
 	lower_flags = file->f_flags;
 	if ((lower_flags & O_ACCMODE) == O_WRONLY)
 		lower_flags = (lower_flags & O_ACCMODE) | O_RDWR;
 	if (file->f_flags & O_APPEND)
 		lower_flags &= ~O_APPEND;
 	lower_mnt = ecryptfs_dentry_to_lower_mnt(ecryptfs_dentry);
-	mntget(lower_mnt);
 	/* Corresponding fput() in ecryptfs_release() */
-	lower_file = dentry_open(lower_dentry, lower_mnt, lower_flags);
-	if (IS_ERR(lower_file)) {
-		rc = PTR_ERR(lower_file);
+	if ((rc = ecryptfs_open_lower_file(&lower_file, lower_dentry, lower_mnt,
+					   lower_flags))) {
 		ecryptfs_printk(KERN_ERR, "Error opening lower file\n");
 		goto out_puts;
 	}
@@ -341,11 +364,16 @@ static int ecryptfs_release(struct inode
 	struct file *lower_file = ecryptfs_file_to_lower(file);
 	struct ecryptfs_file_info *file_info = ecryptfs_file_to_private(file);
 	struct inode *lower_inode = ecryptfs_inode_to_lower(inode);
+	int rc;
 
-	fput(lower_file);
+	if ((rc = ecryptfs_close_lower_file(lower_file))) {
+		printk(KERN_ERR "Error closing lower_file\n");
+		goto out;
+	}
 	inode->i_blocks = lower_inode->i_blocks;
 	kmem_cache_free(ecryptfs_file_info_cache, file_info);
-	return 0;
+out:
+	return rc;
 }
 
 static int
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index efdd2b7..2f2c6cf 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -231,7 +231,6 @@ static int ecryptfs_initialize_file(stru
 	int lower_flags;
 	struct ecryptfs_crypt_stat *crypt_stat;
 	struct dentry *lower_dentry;
-	struct dentry *tlower_dentry = NULL;
 	struct file *lower_file;
 	struct inode *inode, *lower_inode;
 	struct vfsmount *lower_mnt;
@@ -241,30 +240,19 @@ static int ecryptfs_initialize_file(stru
 			lower_dentry->d_name.name);
 	inode = ecryptfs_dentry->d_inode;
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
-	tlower_dentry = dget(lower_dentry);
-	if (!tlower_dentry) {
-		rc = -ENOMEM;
-		ecryptfs_printk(KERN_ERR, "Error dget'ing lower_dentry\n");
-		goto out;
-	}
 	lower_flags = ((O_CREAT | O_WRONLY | O_TRUNC) & O_ACCMODE) | O_RDWR;
 #if BITS_PER_LONG != 32
 	lower_flags |= O_LARGEFILE;
 #endif
 	lower_mnt = ecryptfs_dentry_to_lower_mnt(ecryptfs_dentry);
-	mntget(lower_mnt);
 	/* Corresponding fput() at end of this function */
-	lower_file = dentry_open(tlower_dentry, lower_mnt, lower_flags);
-	if (IS_ERR(lower_file)) {
-		rc = PTR_ERR(lower_file);
+	if ((rc = ecryptfs_open_lower_file(&lower_file, lower_dentry, lower_mnt,
+					   lower_flags))) {
 		ecryptfs_printk(KERN_ERR,
 				"Error opening dentry; rc = [%i]\n", rc);
 		goto out;
 	}
-	/* fput(lower_file) should handle the puts if we do this */
-	lower_file->f_dentry = tlower_dentry;
-	lower_file->f_vfsmnt = lower_mnt;
-	lower_inode = tlower_dentry->d_inode;
+	lower_inode = lower_dentry->d_inode;
 	if (S_ISDIR(ecryptfs_dentry->d_inode->i_mode)) {
 		ecryptfs_printk(KERN_DEBUG, "This is a directory\n");
 		ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
@@ -285,7 +273,8 @@ #endif
 	}
 	rc = grow_file(ecryptfs_dentry, lower_file, inode, lower_inode);
 out_fput:
-	fput(lower_file);
+	if ((rc = ecryptfs_close_lower_file(lower_file)))
+		printk(KERN_ERR "Error closing lower_file\n");
 out:
 	return rc;
 }
@@ -832,12 +821,11 @@ int ecryptfs_truncate(struct dentry *den
 	}
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	/* This dget & mntget is released through fput at out_fput: */
-	dget(lower_dentry);
 	lower_mnt = ecryptfs_dentry_to_lower_mnt(dentry);
-	mntget(lower_mnt);
-	lower_file = dentry_open(lower_dentry, lower_mnt, O_RDWR);
-	if (unlikely(IS_ERR(lower_file))) {
-		rc = PTR_ERR(lower_file);
+	if ((rc = ecryptfs_open_lower_file(&lower_file, lower_dentry, lower_mnt,
+					   O_RDWR))) {
+		ecryptfs_printk(KERN_ERR,
+				"Error opening dentry; rc = [%i]\n", rc);
 		goto out_free;
 	}
 	ecryptfs_set_file_lower(&fake_ecryptfs_file, lower_file);
@@ -879,7 +867,8 @@ int ecryptfs_truncate(struct dentry *den
 		= CURRENT_TIME;
 	mark_inode_dirty_sync(inode);
 out_fput:
-	fput(lower_file);
+	if ((rc = ecryptfs_close_lower_file(lower_file)))
+		printk(KERN_ERR "Error closing lower_file\n");
 out_free:
 	if (ecryptfs_file_to_private(&fake_ecryptfs_file))
 		kmem_cache_free(ecryptfs_file_info_cache,
-- 
1.3.3

