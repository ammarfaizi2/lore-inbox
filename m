Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTKJLNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTKJLNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:13:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24795 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263142AbTKJLN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:13:27 -0500
Date: Mon, 10 Nov 2003 12:13:25 +0100
From: Jan Kara <jack@suse.cz>
To: Alex Lyashkov <shadow@itt.net.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [BUG] journal handler reference count breaked and fs deadlocked
Message-ID: <20031110111325.GC11335@atrey.karlin.mff.cuni.cz>
References: <200311092334.01957.shadow@itt.net.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <200311092334.01957.shadow@itt.net.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

  thanks for tracking. Are you able to reproduce the problem also on
recent vanilla kernels (ie. 2.4.22)? Can you try the vanilla kernel with
the attached patch (it should fix one of possible deadlocks).

						Thanks for testing 
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.4.22-deadlockfix.diff"

diff -ruX ../kerndiffexclude linux-2.4.22-fixstat/fs/dquot.c linux-2.4.22-deadlock/fs/dquot.c
--- linux-2.4.22-fixstat/fs/dquot.c	Wed Nov  5 21:21:58 2003
+++ linux-2.4.22-deadlock/fs/dquot.c	Mon Nov 10 11:48:47 2003
@@ -396,7 +396,7 @@
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
 		if (dquot_dirty(dquot))
-			sb->dq_op->sync_dquot(dquot);
+			sb->dq_op->write_dquot(dquot);
 		dqput(dquot);
 		goto restart;
 	}
@@ -543,7 +543,7 @@
 		return;
 	}
 	if (dquot_dirty(dquot)) {
-		commit_dqblk(dquot);
+		dquot->dq_sb->dq_op->write_dquot(dquot);
 		goto we_slept;
 	}
 
@@ -1219,7 +1219,7 @@
 	free_space:	dquot_free_space,
 	free_inode:	dquot_free_inode,
 	transfer:	dquot_transfer,
-	sync_dquot:	commit_dqblk
+	write_dquot:	commit_dqblk
 };
 
 /* Function used by filesystems for initializing the dquot_operations structure */
@@ -1331,9 +1331,9 @@
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
 		goto out_f;
-	/* We don't want quota on quota files */
+	/* We don't want quota and atime on quota files */
 	dquot_drop(inode);
-	inode->i_flags |= S_NOQUOTA;
+	inode->i_flags |= S_NOQUOTA | S_NOATIME;
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
diff -ruX ../kerndiffexclude linux-2.4.22-fixstat/fs/ext3/super.c linux-2.4.22-deadlock/fs/ext3/super.c
--- linux-2.4.22-fixstat/fs/ext3/super.c	Mon Aug 25 13:44:43 2003
+++ linux-2.4.22-deadlock/fs/ext3/super.c	Mon Nov 10 11:43:32 2003
@@ -449,7 +449,7 @@
 }
 
 static struct dquot_operations ext3_qops;
-static int (*old_sync_dquot)(struct dquot *dquot);
+static int (*old_write_dquot)(struct dquot *dquot);
 
 static struct super_operations ext3_sops = {
 	read_inode:	ext3_read_inode,	/* BKL held */
@@ -1779,7 +1779,7 @@
 /* Blocks: quota info + (4 pointer blocks + 1 entry block) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
 #define EXT3_V0_QFMT_BLOCKS 27
 
-static int ext3_sync_dquot(struct dquot *dquot)
+static int ext3_write_dquot(struct dquot *dquot)
 {
 	int nblocks, ret;
 	handle_t *handle;
@@ -1804,7 +1804,7 @@
 		return PTR_ERR(handle);
 	}
 	unlock_kernel();
-	ret = old_sync_dquot(dquot);
+	ret = old_write_dquot(dquot);
 	lock_kernel();
 	ret = ext3_journal_stop(handle, qinode);
 	unlock_kernel();
@@ -1818,8 +1818,8 @@
 {
 #ifdef CONFIG_QUOTA
 	init_dquot_operations(&ext3_qops);
-	old_sync_dquot = ext3_qops.sync_dquot;
-	ext3_qops.sync_dquot = ext3_sync_dquot;
+	old_write_dquot = ext3_qops.write_dquot;
+	ext3_qops.write_dquot = ext3_write_dquot;
 #endif
         return register_filesystem(&ext3_fs_type);
 }
diff -ruX ../kerndiffexclude linux-2.4.22-fixstat/include/linux/quota.h linux-2.4.22-deadlock/include/linux/quota.h
--- linux-2.4.22-fixstat/include/linux/quota.h	Wed Nov  5 21:27:44 2003
+++ linux-2.4.22-deadlock/include/linux/quota.h	Mon Nov 10 11:40:06 2003
@@ -249,7 +249,7 @@
 	void (*free_space) (struct inode *, qsize_t);
 	void (*free_inode) (const struct inode *, unsigned long);
 	int (*transfer) (struct inode *, struct iattr *);
-	int (*sync_dquot) (struct dquot *);
+	int (*write_dquot) (struct dquot *);
 };
 
 /* Operations handling requests from userspace */
Binary files linux-2.4.22-fixstat/linux and linux-2.4.22-deadlock/linux differ

--gatW/ieO32f1wygP--
