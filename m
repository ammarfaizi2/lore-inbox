Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264790AbUD1Nq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264790AbUD1Nq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbUD1Nq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:46:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57996 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264790AbUD1Nqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:46:47 -0400
Date: Wed, 28 Apr 2004 15:46:46 +0200
From: Jan Kara <jack@ucw.cz>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix deadlock in journalled quota
Message-ID: <20040428134646.GA10953@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello!

 Attached patch should fix reported deadlock in journalled quota code.
quotactl() call was violating the locking rules and didn't start
transaction when should. Attached patch fixes that. Please apply.

								Honza

diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-5-dirtylist/fs/dquot.c linux-2.6.5-6-quotactlfix/fs/dquot.c
--- linux-2.6.5-5-dirtylist/fs/dquot.c	2004-04-21 17:03:12.000000000 +0200
+++ linux-2.6.5-6-quotactlfix/fs/dquot.c	2004-04-28 10:02:36.000000000 +0200
@@ -529,7 +529,7 @@
 	clear_dquot_dirty(dquot);
 	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
 		spin_unlock(&dq_list_lock);
-		dquot_release(dquot);
+		dquot->dq_sb->dq_op->release_dquot(dquot);
 		goto we_slept;
 	}
 	atomic_dec(&dquot->dq_count);
@@ -605,7 +605,7 @@
 	 * finished or it will be canceled due to dq_count > 1 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot and instantiate it (everything done only if needed) */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && dquot_acquire(dquot) < 0) {
+	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && sb->dq_op->acquire_dquot(dquot) < 0) {
 		dqput(dquot);
 		return NODQUOT;
 	}
@@ -1259,6 +1259,8 @@
 	.free_inode	= dquot_free_inode,
 	.transfer	= dquot_transfer,
 	.write_dquot	= dquot_commit,
+	.acquire_dquot	= dquot_acquire,
+	.release_dquot	= dquot_release,
 	.mark_dirty	= dquot_mark_dquot_dirty,
 	.write_info	= dquot_commit_info
 };
diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-5-dirtylist/fs/ext3/super.c linux-2.6.5-6-quotactlfix/fs/ext3/super.c
--- linux-2.6.5-5-dirtylist/fs/ext3/super.c	2004-04-21 17:25:03.000000000 +0200
+++ linux-2.6.5-6-quotactlfix/fs/ext3/super.c	2004-04-28 10:07:41.000000000 +0200
@@ -521,6 +521,8 @@
 static int ext3_dquot_initialize(struct inode *inode, int type);
 static int ext3_dquot_drop(struct inode *inode);
 static int ext3_write_dquot(struct dquot *dquot);
+static int ext3_acquire_dquot(struct dquot *dquot);
+static int ext3_release_dquot(struct dquot *dquot);
 static int ext3_mark_dquot_dirty(struct dquot *dquot);
 static int ext3_write_info(struct super_block *sb, int type);
 static int ext3_quota_on(struct super_block *sb, int type, int format_id, char *path);
@@ -536,6 +538,8 @@
 	.free_inode	= dquot_free_inode,
 	.transfer	= dquot_transfer,
 	.write_dquot	= ext3_write_dquot,
+	.acquire_dquot	= ext3_acquire_dquot,
+	.release_dquot	= ext3_release_dquot,
 	.mark_dirty	= ext3_mark_dquot_dirty,
 	.write_info	= ext3_write_info
 };
@@ -2174,6 +2178,38 @@
 	return ret;
 }
 
+static int ext3_acquire_dquot(struct dquot *dquot)
+{
+	int ret, err;
+	handle_t *handle;
+
+	handle = ext3_journal_start(dquot_to_inode(dquot),
+					EXT3_QUOTA_INIT_BLOCKS);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	ret = dquot_acquire(dquot);
+	err = ext3_journal_stop(handle);
+	if (!ret)
+		ret = err;
+	return ret;
+}
+
+static int ext3_release_dquot(struct dquot *dquot)
+{
+	int ret, err;
+	handle_t *handle;
+
+	handle = ext3_journal_start(dquot_to_inode(dquot),
+					EXT3_QUOTA_INIT_BLOCKS);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	ret = dquot_release(dquot);
+	err = ext3_journal_stop(handle);
+	if (!ret)
+		ret = err;
+	return ret;
+}
+
 static int ext3_mark_dquot_dirty(struct dquot * dquot)
 {
 	/* Are we journalling quotas? */
diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-5-dirtylist/include/linux/quota.h linux-2.6.5-6-quotactlfix/include/linux/quota.h
--- linux-2.6.5-5-dirtylist/include/linux/quota.h	2004-04-21 10:59:40.000000000 +0200
+++ linux-2.6.5-6-quotactlfix/include/linux/quota.h	2004-04-28 09:58:26.000000000 +0200
@@ -250,6 +250,8 @@
 	int (*free_inode) (const struct inode *, unsigned long);
 	int (*transfer) (struct inode *, struct iattr *);
 	int (*write_dquot) (struct dquot *);		/* Ordinary dquot write */
+	int (*acquire_dquot) (struct dquot *);		/* Quota is going to be created on disk */
+	int (*release_dquot) (struct dquot *);		/* Quota is going to be deleted from disk */
 	int (*mark_dirty) (struct dquot *);		/* Dquot is marked dirty */
 	int (*write_info) (struct super_block *, int);	/* Write of quota "superblock" */
 };
