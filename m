Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWEZOWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWEZOWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWEZOWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:7838 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750788AbWEZOV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:21:58 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 8/10] Remove unnecessary NULL checks
Message-Id: <E1FjdCG-00033j-Nx@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary checks for NULL for values that should never be
NULL. A couple of minor comment/spacing fixes.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/dentry.c |    4 ----
 fs/ecryptfs/file.c   |   24 ++++--------------------
 fs/ecryptfs/inode.c  |   18 ------------------
 fs/ecryptfs/mmap.c   |    7 -------
 fs/ecryptfs/super.c  |    3 ---
 5 files changed, 4 insertions(+), 52 deletions(-)

080439fe5ee41e1cff6f947722c7be027c295583
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 12362c0..7b1018a 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -47,10 +47,6 @@ static int ecryptfs_d_revalidate(struct 
 	struct vfsmount *saved_vfsmount;
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	if (!lower_dentry) {
-		err = 0;
-		goto out;
-	}
 	if (!lower_dentry->d_op || !lower_dentry->d_op->d_revalidate)
 		goto out;
 	saved_dentry = nd->dentry;
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index b8fcd0a..3a9cd15 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -337,12 +337,6 @@ ecryptfs_fsync(struct file *file, struct
 			mutex_unlock(&lower_dentry->d_inode->i_mutex);
 		}
 	} else {
-		if (!ecryptfs_file_to_private(file)) {
-			rc = -EINVAL;
-			ecryptfs_printk(KERN_ERR, "ecryptfs_file_to_private"
-					"(file=[%p]) is NULL\n", file);
-			goto out;
-		}
 		lower_file = ecryptfs_file_to_lower(file);
 		lower_dentry = ecryptfs_dentry_to_lower(dentry);
 		if (lower_file->f_op && lower_file->f_op->fsync) {
@@ -352,7 +346,6 @@ ecryptfs_fsync(struct file *file, struct
 			mutex_unlock(&lower_dentry->d_inode->i_mutex);
 		}
 	}
-out:
 	return rc;
 }
 
@@ -466,15 +459,9 @@ static int ecryptfs_fasync(int fd, struc
 	int rc = 0;
 	struct file *lower_file = NULL;
 
-	if (NULL != ecryptfs_file_to_private(file))
-		lower_file = ecryptfs_file_to_lower(file);
-	else {
-		rc = -EINVAL;
-		goto out;
-	}
+	lower_file = ecryptfs_file_to_lower(file);
 	if (lower_file->f_op && lower_file->f_op->fasync)
 		rc = lower_file->f_op->fasync(fd, lower_file, flag);
-out:
 	return rc;
 }
 
@@ -483,9 +470,7 @@ static int ecryptfs_lock(struct file *fi
 	int rc = 0;
 	struct file *lower_file = NULL;
 
-	if (ecryptfs_file_to_private(file))
-		lower_file = ecryptfs_file_to_lower(file);
-	BUG_ON(!lower_file);
+	lower_file = ecryptfs_file_to_lower(file);
 	rc = -EINVAL;
 	if (!fl)
 		goto out;
@@ -513,9 +498,7 @@ static ssize_t ecryptfs_sendfile(struct 
 	struct file *lower_file = NULL;
 	int rc = -EINVAL;
 
-	if (ecryptfs_file_to_private(file))
-		lower_file = ecryptfs_file_to_lower(file);
-	BUG_ON(!lower_file);
+	lower_file = ecryptfs_file_to_lower(file);
 	if (lower_file->f_op && lower_file->f_op->sendfile)
 		rc = lower_file->f_op->sendfile(lower_file, ppos, count,
 						actor, target);
@@ -561,6 +544,7 @@ ecryptfs_ioctl(struct inode *inode, stru
 {
 	int rc = 0;
 	struct file *lower_file = NULL;
+
 	if (ecryptfs_file_to_private(file))
 		lower_file = ecryptfs_file_to_lower(file);
 	if (lower_file && lower_file->f_op && lower_file->f_op->ioctl)
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c24b043..47e4202 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -159,12 +159,6 @@ ecryptfs_do_create(struct inode *directo
 	struct dentry *lower_dir_dentry;
 
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
-	if (IS_ERR(lower_dentry)) {
-		ecryptfs_printk(KERN_ERR, "ecryptfs dentry doesn't know"
-				"about its lower counterpart\n");
-		rc = PTR_ERR(lower_dentry);
-		goto out;
-	}
 	lower_dir_dentry = lock_parent(lower_dentry);
 	if (unlikely(IS_ERR(lower_dir_dentry))) {
 		ecryptfs_printk(KERN_ERR, "Error locking directory of "
@@ -252,12 +246,6 @@ static int ecryptfs_initialize_file(stru
 	struct vfsmount *lower_mnt;
 
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
-	if (IS_ERR(lower_dentry)) {
-		ecryptfs_printk(KERN_ERR, "ecryptfs dentry doesn't know"
-				"about its lower counterpart\n");
-		rc = PTR_ERR(lower_dentry);
-		goto out;
-	}
 	ecryptfs_printk(KERN_DEBUG, "lower_dentry->d_name.name = [%s]\n",
 			lower_dentry->d_name.name);
 	inode = ecryptfs_dentry->d_inode;
@@ -831,12 +819,6 @@ int ecryptfs_truncate(struct dentry *den
 	if (unlikely((new_length == i_size)))
 		goto out;
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
-	if (unlikely(!crypt_stat)) {
-		ecryptfs_printk(KERN_ERR, "NULL crypt_stat on dentry with "
-				"d_name.name = [%s]\n", dentry->d_name.name);
-		rc = -EINVAL;
-		goto out;
-	}
 	/* Set up a fake ecryptfs file, this is used to interface with
 	 * the file in the underlying filesystem so that the
 	 * truncation has an effect there as well. */
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 0c0411a..e9cff02 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -219,11 +219,6 @@ int ecryptfs_do_readpage(struct file *fi
 	const struct address_space_operations *lower_a_ops;
 
 	dentry = file->f_dentry;
-	if (!ecryptfs_file_to_private(file)) {
-		rc = -ENOENT;
-		ecryptfs_printk(KERN_ERR, "No lower file info\n");
-		goto out;
-	}
 	lower_file = ecryptfs_file_to_lower(file);
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	inode = dentry->d_inode;
@@ -646,8 +641,6 @@ static int ecryptfs_commit_write(struct 
 	mutex_lock(&lower_inode->i_mutex);
 	crypt_stat =
 		&ecryptfs_inode_to_private(file->f_dentry->d_inode)->crypt_stat;
-	BUG_ON(!crypt_stat);
-	BUG_ON(!lower_file);
 	if (ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE)) {
 		ecryptfs_printk(KERN_DEBUG, "ECRYPTFS_NEW_FILE flag set in "
 			"crypt_stat at memory location [%p]\n", crypt_stat);
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 1d344e0..94c50f1 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -37,9 +37,6 @@ struct kmem_cache *ecryptfs_inode_info_c
  *
  * Called to bring an inode into existence.
  *
- * Note that setting the self referencing pointer doesn't work here:
- * 	i.e. ECRYPTFS_INODE_TO_PRIVATE_SM(inode) = ei;
- *
  * Only handle allocation, setting up structures should be done in
  * ecryptfs_read_inode. This is because the kernel, between now and
  * then, will 0 out the private data pointer.
-- 
1.3.3

