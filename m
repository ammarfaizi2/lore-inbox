Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTKXJns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTKXJns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:43:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:206 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263698AbTKXJnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:43:45 -0500
Date: Mon, 24 Nov 2003 10:43:44 +0100
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Ext3+quota deadlock fix for 2.6.0-test9
Message-ID: <20031124094344.GB13790@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Andrew,

  here's patch which should fix deadlock with quotas+ext3 reported in
2.4 (the same problem existed in 2.6 but nobody found it). Please apply.
The patch is against 2.6.0-test9 but should apply to -test10 too.

								Honza

-----------------------<cut>---------------------------------------

diff -ruX ../kerndiffexclude linux-2.6.0-test9-syncfix/fs/dquot.c linux-2.6.0-test9-ext3deadlock/fs/dquot.c
--- linux-2.6.0-test9-syncfix/fs/dquot.c	Mon Nov 24 10:31:41 2003
+++ linux-2.6.0-test9-ext3deadlock/fs/dquot.c	Mon Nov 24 10:08:11 2003
@@ -344,7 +344,7 @@
 		atomic_inc(&dquot->dq_count);
 		dqstats.lookups++;
 		spin_unlock(&dq_list_lock);
-		sb->dq_op->sync_dquot(dquot);
+		sb->dq_op->write_dquot(dquot);
 		dqput(dquot);
 		goto restart;
 	}
@@ -432,7 +432,7 @@
 	}
 	if (dquot_dirty(dquot)) {
 		spin_unlock(&dq_list_lock);
-		commit_dqblk(dquot);
+		dquot->dq_sb->dq_op->write_dquot(dquot);
 		goto we_slept;
 	}
 	atomic_dec(&dquot->dq_count);
@@ -1088,7 +1088,7 @@
 	.free_space	= dquot_free_space,
 	.free_inode	= dquot_free_inode,
 	.transfer	= dquot_transfer,
-	.sync_dquot	= commit_dqblk
+	.write_dquot	= commit_dqblk
 };
 
 /* Function used by filesystems for initializing the dquot_operations structure */
@@ -1212,9 +1212,9 @@
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
 		goto out_file_init;
-	/* We don't want quota on quota files */
+	/* We don't want quota and atime on quota files (deadlocks possible) */
 	dquot_drop_nolock(inode);
-	inode->i_flags |= S_NOQUOTA;
+	inode->i_flags |= S_NOQUOTA | S_NOATIME;
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
diff -ruX ../kerndiffexclude linux-2.6.0-test9-syncfix/fs/ext3/super.c linux-2.6.0-test9-ext3deadlock/fs/ext3/super.c
--- linux-2.6.0-test9-syncfix/fs/ext3/super.c	Sat Oct 25 20:44:40 2003
+++ linux-2.6.0-test9-ext3deadlock/fs/ext3/super.c	Mon Nov 24 09:59:27 2003
@@ -1944,9 +1944,9 @@
 /* Blocks: quota info + (4 pointer blocks + 1 entry block) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
 #define EXT3_V0_QFMT_BLOCKS 27
 
-static int (*old_sync_dquot)(struct dquot *dquot);
+static int (*old_write_dquot)(struct dquot *dquot);
 
-static int ext3_sync_dquot(struct dquot *dquot)
+static int ext3_write_dquot(struct dquot *dquot)
 {
 	int nblocks;
 	int ret;
@@ -1971,7 +1971,7 @@
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	ret = old_sync_dquot(dquot);
+	ret = old_write_dquot(dquot);
 	err = ext3_journal_stop(handle);
 	if (ret == 0)
 		ret = err;
@@ -2004,8 +2004,8 @@
 		goto out1;
 #ifdef CONFIG_QUOTA
 	init_dquot_operations(&ext3_qops);
-	old_sync_dquot = ext3_qops.sync_dquot;
-	ext3_qops.sync_dquot = ext3_sync_dquot;
+	old_write_dquot = ext3_qops.write_dquot;
+	ext3_qops.write_dquot = ext3_write_dquot;
 #endif
         err = register_filesystem(&ext3_fs_type);
 	if (err)
diff -ruX ../kerndiffexclude linux-2.6.0-test9-syncfix/include/linux/quota.h linux-2.6.0-test9-ext3deadlock/include/linux/quota.h
--- linux-2.6.0-test9-syncfix/include/linux/quota.h	Sat Oct 25 20:44:10 2003
+++ linux-2.6.0-test9-ext3deadlock/include/linux/quota.h	Mon Nov 24 10:00:19 2003
@@ -250,7 +250,7 @@
 	void (*free_space) (struct inode *, qsize_t);
 	void (*free_inode) (const struct inode *, unsigned long);
 	int (*transfer) (struct inode *, struct iattr *);
-	int (*sync_dquot) (struct dquot *);
+	int (*write_dquot) (struct dquot *);
 };
 
 /* Operations handling requests from userspace */
