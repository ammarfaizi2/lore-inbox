Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUENAmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUENAmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 20:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbUENAmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 20:42:55 -0400
Received: from thunk.org ([140.239.227.29]:37307 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264231AbUENAmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 20:42:42 -0400
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC/RFT] [PATCH] EXT3: Retry allocation after journal commit
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1BOQmf-0005cP-4Q@thunk.org>
Date: Thu, 13 May 2004 20:42:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is possible for block allocation to fail, even if there is space in
the filesystem, because all of the free blocks were recently deleted and
so could not be allocated until after the currently running transaction
is committed.   This can result in a very strange and surprising result
where a system call such as a mkdir() will fail even though there is
plenty of disk space apparently available.

This patch detects the case where a system call is apparently going to
fail due to ENOSPC, even though there is space available, and forces the
currently running transaction to complete before retrying the operation.

Unfortunately, it is necessary to hit so many high-level routines,
instead of making a smaller change in a single low-level route, such as
ext3_new_block(), because if we try to wait for the currently running
transaction to complete while we are holding an active handle associated
with that transaction, it will result in a deadlock.  Hence the retry
has to happen outside of the journal_start().... journal_stop() code
path.

						- Ted


===== fs/ext3/balloc.c 1.20 vs edited =====
--- 1.20/fs/ext3/balloc.c	Mon Feb 23 00:24:13 2004
+++ edited/fs/ext3/balloc.c	Thu May 13 14:57:38 2004
@@ -465,6 +465,64 @@
 	return -1;
 }
 
+static int ext3_has_free_blocks(struct super_block *sb)
+{
+	struct ext3_super_block *es;
+	struct ext3_sb_info *sbi;
+	int free_blocks, root_blocks;
+
+	sbi = EXT3_SB(sb);
+	es = EXT3_SB(sb)->s_es;
+
+	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	root_blocks = le32_to_cpu(es->s_r_blocks_count);
+	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
+		sbi->s_resuid != current->fsuid &&
+		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * This function is called when an allocation is failed, and will
+ * return true if it is profitable to retry an allocation.  There must
+ * *NOT* be a currently active handle, so the retry has to happen at
+ * the top-level ext3 function.  This is because this function will
+ * attempt to force the currently running transaction to the log, and
+ * block until it is completed.  If the current process is holding an
+ * active handle, this will cause a deadlock.
+ */
+int ext3_should_retry_alloc(struct super_block *sb)
+{
+	transaction_t *transaction = NULL;
+	journal_t *journal = EXT3_SB(sb)->s_journal;
+	tid_t tid;
+
+	if (!ext3_has_free_blocks(sb))
+		return 0;
+
+	spin_lock(&journal->j_state_lock);
+
+	/* Force everything buffered to the log... */
+	if (journal->j_running_transaction) {
+		transaction = journal->j_running_transaction;
+		__log_start_commit(journal, transaction->t_tid);
+	} else if (journal->j_committing_transaction)
+		transaction = journal->j_committing_transaction;
+
+	if (!transaction) {
+		spin_unlock(&journal->j_state_lock);
+		return 0;	/* Nothing to retry */
+	}
+		
+	tid = transaction->t_tid;
+	spin_unlock(&journal->j_state_lock);
+	log_wait_commit(journal, tid);
+
+	return 1;
+}
+
 /*
  * ext3_new_block uses a goal block to assist allocation.  If the goal is
  * free, or there is a free block within 32 blocks of the goal, that block
@@ -485,7 +543,8 @@
 	int target_block;			/* tmp */
 	int fatal = 0, err;
 	int performed_allocation = 0;
-	int free_blocks, root_blocks;
+	int free_blocks;
+	int num_free_bgroups = 0;
 	struct super_block *sb;
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
@@ -512,11 +571,7 @@
 	es = EXT3_SB(sb)->s_es;
 	ext3_debug("goal=%lu.\n", goal);
 
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
-	root_blocks = le32_to_cpu(es->s_r_blocks_count);
-	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
-		sbi->s_resuid != current->fsuid &&
-		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
+	if (!ext3_has_free_blocks(sb)) {
 		*errp = -ENOSPC;
 		goto out;
 	}
@@ -565,6 +620,7 @@
 		if (free_blocks <= 0)
 			continue;
 
+		num_free_bgroups++;
 		brelse(bitmap_bh);
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
@@ -575,6 +631,10 @@
 			goto out;
 		if (ret_block >= 0) 
 			goto allocated;
+	}
+
+	if (num_free_bgroups) {
+		jbd_debug(1, "%s: %d free blockgroups, but couldn't find free blocks\n", sb->s_id, num_free_bgroups);
 	}
 
 	/* No space left on the device */
===== fs/ext3/acl.c 1.16 vs edited =====
--- 1.16/fs/ext3/acl.c	Fri Mar 12 04:33:00 2004
+++ edited/fs/ext3/acl.c	Thu May 13 15:18:23 2004
@@ -428,7 +428,9 @@
 	error = posix_acl_chmod_masq(clone, inode->i_mode);
 	if (!error) {
 		handle_t *handle;
+		int retry = 0;
 
+	retry:
 		handle = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS);
 		if (IS_ERR(handle)) {
 			error = PTR_ERR(handle);
@@ -437,6 +439,9 @@
 		}
 		error = ext3_set_acl(handle, inode, ACL_TYPE_ACCESS, clone);
 		ext3_journal_stop(handle);
+		if (error == -ENOSPC && 
+		    ext3_should_retry_alloc(inode->i_sb) && retry++ <= 3)
+			goto retry;
 	}
 out:
 	posix_acl_release(clone);
@@ -516,7 +521,7 @@
 {
 	handle_t *handle;
 	struct posix_acl *acl;
-	int error;
+	int error, retry = 0;
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return -EOPNOTSUPP;
@@ -535,11 +540,15 @@
 	} else
 		acl = NULL;
 
+retry:
 	handle = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	error = ext3_set_acl(handle, inode, type, acl);
 	ext3_journal_stop(handle);
+	if (error == -ENOSPC && ext3_should_retry_alloc(inode->i_sb) && 
+	    retry++ <= 3)
+		goto retry;
 
 release_and_out:
 	posix_acl_release(acl);
===== fs/ext3/inode.c 1.94 vs edited =====
--- 1.94/fs/ext3/inode.c	Thu Apr 22 19:20:51 2004
+++ edited/fs/ext3/inode.c	Thu May 13 15:12:45 2004
@@ -1080,8 +1080,10 @@
 {
 	struct inode *inode = page->mapping->host;
 	int ret, needed_blocks = ext3_writepage_trans_blocks(inode);
+	int retry = 0;
 	handle_t *handle;
 
+retry:
 	handle = ext3_journal_start(inode, needed_blocks);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
@@ -1098,6 +1100,9 @@
 prepare_write_failed:
 	if (ret)
 		ext3_journal_stop(handle);
+	if (ret == -ENOSPC && ext3_should_retry_alloc(inode->i_sb) && 
+	    retry++ <= 3)
+		goto retry;
 out:
 	return ret;
 }
===== fs/ext3/namei.c 1.51 vs edited =====
--- 1.51/fs/ext3/namei.c	Wed Apr 14 21:37:52 2004
+++ edited/fs/ext3/namei.c	Thu May 13 14:59:37 2004
@@ -1628,8 +1628,9 @@
 {
 	handle_t *handle; 
 	struct inode * inode;
-	int err;
+	int err, retry = 0;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3 +
 					2*EXT3_QUOTA_INIT_BLOCKS);
@@ -1648,6 +1649,9 @@
 		err = ext3_add_nondir(handle, dentry, inode);
 	}
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb) && 
+	    retry++ <= 3)
+		goto retry;
 	return err;
 }
 
@@ -1656,11 +1660,12 @@
 {
 	handle_t *handle;
 	struct inode *inode;
-	int err;
+	int err, retry = 0;
 
 	if (!new_valid_dev(rdev))
 		return -EINVAL;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3 +
 					2*EXT3_QUOTA_INIT_BLOCKS);
@@ -1680,6 +1685,9 @@
 		err = ext3_add_nondir(handle, dentry, inode);
 	}
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb) && 
+	    retry++ <= 3)
+		goto retry;
 	return err;
 }
 
@@ -1689,11 +1697,13 @@
 	struct inode * inode;
 	struct buffer_head * dir_block;
 	struct ext3_dir_entry_2 * de;
+	int retry = 0;
 	int err;
 
 	if (dir->i_nlink >= EXT3_LINK_MAX)
 		return -EMLINK;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3 +
 					2*EXT3_QUOTA_INIT_BLOCKS);
@@ -1751,6 +1761,9 @@
 	d_instantiate(dentry, inode);
 out_stop:
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb) && 
+	    retry++ <= 3)
+		goto retry;
 	return err;
 }
 
@@ -2085,12 +2098,13 @@
 {
 	handle_t *handle;
 	struct inode * inode;
-	int l, err;
+	int l, err, retry = 0;
 
 	l = strlen(symname)+1;
 	if (l > dir->i_sb->s_blocksize)
 		return -ENAMETOOLONG;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 5 +
 					2*EXT3_QUOTA_INIT_BLOCKS);
@@ -2129,6 +2143,9 @@
 	err = ext3_add_nondir(handle, dentry, inode);
 out_stop:
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb) && 
+	    retry++ <= 3)
+		goto retry;
 	return err;
 }
 
@@ -2137,11 +2154,12 @@
 {
 	handle_t *handle;
 	struct inode *inode = old_dentry->d_inode;
-	int err;
+	int err, retry = 0;
 
 	if (inode->i_nlink >= EXT3_LINK_MAX)
 		return -EMLINK;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 					EXT3_INDEX_EXTRA_TRANS_BLOCKS);
 	if (IS_ERR(handle))
@@ -2156,6 +2174,9 @@
 
 	err = ext3_add_nondir(handle, dentry, inode);
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb) && 
+	    retry++ <= 3)
+		goto retry;
 	return err;
 }
 
===== fs/ext3/xattr.c 1.27 vs edited =====
--- 1.27/fs/ext3/xattr.c	Fri Feb  6 03:30:14 2004
+++ edited/fs/ext3/xattr.c	Thu May 13 15:18:39 2004
@@ -875,8 +875,9 @@
 	       const void *value, size_t value_len, int flags)
 {
 	handle_t *handle;
-	int error;
+	int error, retry = 0;
 
+retry:
 	handle = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS);
 	if (IS_ERR(handle)) {
 		error = PTR_ERR(handle);
@@ -885,7 +886,13 @@
 
 		error = ext3_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
+
 		error2 = ext3_journal_stop(handle);
+
+		if (error == -ENOSPC && 
+		    ext3_should_retry_alloc(inode->i_sb) && retry++ <= 3)
+			goto retry;
+
 		if (error == 0)
 			error = error2;
 	}
===== include/linux/ext3_fs.h 1.30 vs edited =====
--- 1.30/include/linux/ext3_fs.h	Fri Aug  1 05:31:19 2003
+++ edited/include/linux/ext3_fs.h	Thu May 13 14:58:51 2004
@@ -689,6 +689,7 @@
 extern struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
 						    unsigned int block_group,
 						    struct buffer_head ** bh);
+extern int ext3_should_retry_alloc(struct super_block *sb);
 
 /* dir.c */
 extern int ext3_check_dir_entry(const char *, struct inode *,
