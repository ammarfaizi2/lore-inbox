Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUEQCNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUEQCNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 22:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbUEQCNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 22:13:23 -0400
Received: from thunk.org ([140.239.227.29]:17615 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263134AbUEQCMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 22:12:55 -0400
Date: Sun, 16 May 2004 22:12:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: [PATCH] Ext3: Retry allocation after transaction commit (v2)
Message-ID: <20040517021218.GA3437@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is a reworked version of my patch to ext3 to retry certain
filesystem operations after an ENOSPC error.  The
ext3_should_retry_alloc() function will not wait on the currently
running transaction if there is a currently active handle; hence this
should avoid deadlocks in the Lustre use case.  The patch is versus
BK-recent.

I've also included a simple, reliable test case which demonstrates the
problem this patch is intended to fix.  (Note that BK-recent is not
sufficient to address this test case, and waiting on the commiting
transaction in ext3_new_block is also not sufficient.  Been there,
tried that, didn't work.  We need to do the full-bore retry from the
top level.  The ext3_should_retry_alloc() will only wait on the
committing transaction if there is an active handle; hence Lustre will
probably also need to use ext3_should_retry_alloc() if it wants to
reliably avoid this particular problem.)

						- Ted

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="retry.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/16 17:29:49-04:00 tytso@think.thunk.org 
#   Adds retry logic to the ext3 filesystem in the case where forcing 
#   the current transaction out to disk may cause the filesystem operation
#   to succeed.
# 
# include/linux/ext3_fs.h
#   2004/05/16 12:39:52-04:00 tytso@think.thunk.org +1 -0
#   Add function prototype for ext3_should_retry_alloc()
# 
# fs/ext3/xattr.c
#   2004/05/16 12:39:52-04:00 tytso@think.thunk.org +5 -1
#   Add retry logic in the case of ENOSPC.
# 
# fs/ext3/namei.c
#   2004/05/16 12:39:52-04:00 tytso@think.thunk.org +20 -5
#   Add retry logic in the case of ENOSPC.
# 
# fs/ext3/inode.c
#   2004/05/16 12:39:52-04:00 tytso@think.thunk.org +5 -14
#   Add retry logic in the case of ENOSPC.
# 
# fs/ext3/balloc.c
#   2004/05/16 12:39:52-04:00 tytso@think.thunk.org +56 -6
#   Factor out the check for free blocks into ext3_has_free_blocks().
#   
#   New function, ext3_should_retry_alloc() which centralizes logic for
#   determining whether or not the top-level filesystem code should 
#   retry the operation.  This function also will wait until the 
#   current or commiting transaction is completed in the case where
#   retrying is indicated.
# 
# fs/ext3/acl.c
#   2004/05/16 12:39:52-04:00 tytso@think.thunk.org +9 -1
#   Add retry logic in the case of ENOSPC.
# 
diff -Nru a/fs/ext3/acl.c b/fs/ext3/acl.c
--- a/fs/ext3/acl.c	Sun May 16 17:36:00 2004
+++ b/fs/ext3/acl.c	Sun May 16 17:36:00 2004
@@ -428,7 +428,9 @@
 	error = posix_acl_chmod_masq(clone, inode->i_mode);
 	if (!error) {
 		handle_t *handle;
+		int retries = 0;
 
+	retry:
 		handle = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS);
 		if (IS_ERR(handle)) {
 			error = PTR_ERR(handle);
@@ -437,6 +439,9 @@
 		}
 		error = ext3_set_acl(handle, inode, ACL_TYPE_ACCESS, clone);
 		ext3_journal_stop(handle);
+		if (error == -ENOSPC && 
+		    ext3_should_retry_alloc(inode->i_sb, &retries))
+			goto retry;
 	}
 out:
 	posix_acl_release(clone);
@@ -516,7 +521,7 @@
 {
 	handle_t *handle;
 	struct posix_acl *acl;
-	int error;
+	int error, retries = 0;
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return -EOPNOTSUPP;
@@ -535,11 +540,14 @@
 	} else
 		acl = NULL;
 
+retry:
 	handle = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	error = ext3_set_acl(handle, inode, type, acl);
 	ext3_journal_stop(handle);
+	if (error == -ENOSPC && ext3_should_retry_alloc(inode->i_sb, &retries))
+		goto retry;
 
 release_and_out:
 	posix_acl_release(acl);
diff -Nru a/fs/ext3/balloc.c b/fs/ext3/balloc.c
--- a/fs/ext3/balloc.c	Sun May 16 17:36:00 2004
+++ b/fs/ext3/balloc.c	Sun May 16 17:36:00 2004
@@ -465,6 +465,60 @@
 	return -1;
 }
 
+static int ext3_has_free_blocks(struct ext3_sb_info *sbi)
+{
+	int free_blocks, root_blocks;
+
+	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
+	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
+		sbi->s_resuid != current->fsuid &&
+		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * Ext3_should_retry_alloc is called when ENOSPC is returned, and if
+ * it is profitable to retry the operation, this function will wait
+ * for the current or commiting transaction to complete, and then
+ * return TRUE.
+ */
+int ext3_should_retry_alloc(struct super_block *sb, int *retries)
+{
+	transaction_t *transaction = NULL;
+	journal_t *journal = EXT3_SB(sb)->s_journal;
+	tid_t tid;
+
+	if (!ext3_has_free_blocks(EXT3_SB(sb)) || (*retries)++ > 3)
+		return 0;
+
+	jbd_debug(1, "%s: retrying operation after ENOSPC\n", sb->s_id);
+
+	/* 
+	 * We can only force the running transaction if we don't have
+	 * an active handle; otherwise, we will deadlock.
+	 */
+	spin_lock(&journal->j_state_lock);
+	if (journal->j_running_transaction && !current->journal_info) {
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
@@ -485,7 +539,7 @@
 	int target_block;			/* tmp */
 	int fatal = 0, err;
 	int performed_allocation = 0;
-	int free_blocks, root_blocks;
+	int free_blocks;
 	struct super_block *sb;
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
@@ -512,11 +566,7 @@
 	es = EXT3_SB(sb)->s_es;
 	ext3_debug("goal=%lu.\n", goal);
 
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
-	root_blocks = le32_to_cpu(es->s_r_blocks_count);
-	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
-		sbi->s_resuid != current->fsuid &&
-		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
+	if (!ext3_has_free_blocks(sbi)) {
 		*errp = -ENOSPC;
 		goto out;
 	}
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Sun May 16 17:36:00 2004
+++ b/fs/ext3/inode.c	Sun May 16 17:36:00 2004
@@ -1081,7 +1081,7 @@
 	struct inode *inode = page->mapping->host;
 	int ret, needed_blocks = ext3_writepage_trans_blocks(inode);
 	handle_t *handle;
-	int tried_commit = 0;
+	int retries = 0;
 
 retry:
 	handle = ext3_journal_start(inode, needed_blocks);
@@ -1090,19 +1090,8 @@
 		goto out;
 	}
 	ret = block_prepare_write(page, from, to, ext3_get_block);
-	if (ret) {
-		if (ret != -ENOSPC || tried_commit)
-			goto prepare_write_failed;
-		/*
-		 * It could be that there _is_ free space, but it's all tied up
-		 * in uncommitted bitmaps.  So force a commit here, which makes
-		 * those blocks allocatable and try again.
-		 */
-		tried_commit = 1;
-		handle->h_sync = 1;
-		ext3_journal_stop(handle);
-		goto retry;
-	}
+	if (ret)
+		goto prepare_write_failed;
 
 	if (ext3_should_journal_data(inode)) {
 		ret = walk_page_buffers(handle, page_buffers(page),
@@ -1111,6 +1100,8 @@
 prepare_write_failed:
 	if (ret)
 		ext3_journal_stop(handle);
+	if (ret == -ENOSPC && ext3_should_retry_alloc(inode->i_sb, &retries))
+		goto retry;
 out:
 	return ret;
 }
diff -Nru a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Sun May 16 17:36:00 2004
+++ b/fs/ext3/namei.c	Sun May 16 17:36:00 2004
@@ -1630,8 +1630,9 @@
 {
 	handle_t *handle; 
 	struct inode * inode;
-	int err;
+	int err, retries = 0;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3 +
 					2*EXT3_QUOTA_INIT_BLOCKS);
@@ -1650,6 +1651,8 @@
 		err = ext3_add_nondir(handle, dentry, inode);
 	}
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb, &retries))
+		goto retry;
 	return err;
 }
 
@@ -1658,11 +1661,12 @@
 {
 	handle_t *handle;
 	struct inode *inode;
-	int err;
+	int err, retries = 0;
 
 	if (!new_valid_dev(rdev))
 		return -EINVAL;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3 +
 					2*EXT3_QUOTA_INIT_BLOCKS);
@@ -1682,6 +1686,8 @@
 		err = ext3_add_nondir(handle, dentry, inode);
 	}
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb, &retries))
+		goto retry;
 	return err;
 }
 
@@ -1691,11 +1697,12 @@
 	struct inode * inode;
 	struct buffer_head * dir_block;
 	struct ext3_dir_entry_2 * de;
-	int err;
+	int err, retries = 0;
 
 	if (dir->i_nlink >= EXT3_LINK_MAX)
 		return -EMLINK;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3 +
 					2*EXT3_QUOTA_INIT_BLOCKS);
@@ -1753,6 +1760,8 @@
 	d_instantiate(dentry, inode);
 out_stop:
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb, &retries))
+		goto retry;
 	return err;
 }
 
@@ -2094,12 +2103,13 @@
 {
 	handle_t *handle;
 	struct inode * inode;
-	int l, err;
+	int l, err, retries = 0;
 
 	l = strlen(symname)+1;
 	if (l > dir->i_sb->s_blocksize)
 		return -ENAMETOOLONG;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 5 +
 					2*EXT3_QUOTA_INIT_BLOCKS);
@@ -2138,6 +2148,8 @@
 	err = ext3_add_nondir(handle, dentry, inode);
 out_stop:
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb, &retries))
+		goto retry;
 	return err;
 }
 
@@ -2146,11 +2158,12 @@
 {
 	handle_t *handle;
 	struct inode *inode = old_dentry->d_inode;
-	int err;
+	int err, retries = 0;
 
 	if (inode->i_nlink >= EXT3_LINK_MAX)
 		return -EMLINK;
 
+retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 					EXT3_INDEX_EXTRA_TRANS_BLOCKS);
 	if (IS_ERR(handle))
@@ -2165,6 +2178,8 @@
 
 	err = ext3_add_nondir(handle, dentry, inode);
 	ext3_journal_stop(handle);
+	if (err == -ENOSPC && ext3_should_retry_alloc(dir->i_sb, &retries))
+		goto retry;
 	return err;
 }
 
diff -Nru a/fs/ext3/xattr.c b/fs/ext3/xattr.c
--- a/fs/ext3/xattr.c	Sun May 16 17:36:00 2004
+++ b/fs/ext3/xattr.c	Sun May 16 17:36:00 2004
@@ -875,8 +875,9 @@
 	       const void *value, size_t value_len, int flags)
 {
 	handle_t *handle;
-	int error;
+	int error, retries = 0;
 
+retry:
 	handle = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS);
 	if (IS_ERR(handle)) {
 		error = PTR_ERR(handle);
@@ -886,6 +887,9 @@
 		error = ext3_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
 		error2 = ext3_journal_stop(handle);
+		if (error == -ENOSPC && 
+		    ext3_should_retry_alloc(inode->i_sb, &retries))
+			goto retry;
 		if (error == 0)
 			error = error2;
 	}
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Sun May 16 17:36:00 2004
+++ b/include/linux/ext3_fs.h	Sun May 16 17:36:00 2004
@@ -689,6 +689,7 @@
 extern struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
 						    unsigned int block_group,
 						    struct buffer_head ** bh);
+extern int ext3_should_retry_alloc(struct super_block *sb, int *retries);
 
 /* dir.c */
 extern int ext3_check_dir_entry(const char *, struct inode *,

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=test-retry

#!/bin/sh
#
#
TEST_DIR=/tmp
IMAGE=$TEST_DIR/retry.img
MNTPT=$TEST_DIR/retry.mnt
TEST_SRC=/usr/projects/e2fsprogs/e2fsprogs/build
MKE2FS_OPTS=""
IMAGE_SIZE=8192

umount $MNTPT
dd if=/dev/zero of=$IMAGE bs=4k count=$IMAGE_SIZE
mke2fs -j -F $MKE2FS_OPTS $IMAGE 

function test_log ()
{
	echo $*
	logger -p local4.notice $*
}

mkdir -p $MNTPT
mount -o loop -t ext3 $IMAGE $MNTPT
test_log Retry test: BEGIN
for i in `seq 1 3`
do
	test_log "Retry test: Loop $i"
	echo 2 > /proc/sys/fs/jbd-debug
	while ! mkdir -p $MNTPT/foo/bar
	do
		test_log "Retry test: mkdir failed"
		sleep 1
	done
	echo 0 > /proc/sys/fs/jbd-debug
	cp -r $TEST_SRC $MNTPT/foo/bar 2> /dev/null
	rm -rf $MNTPT/*
done
umount $MNTPT
test_log "Retry test: END"

--NzB8fVQJ5HfG6fxh--
