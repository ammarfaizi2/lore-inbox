Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbTDPT1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbTDPT1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:27:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19471 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264557AbTDPT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:27:06 -0400
Date: Wed, 16 Apr 2003 21:38:59 +0200
From: Jan Kara <jack@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@digeo.com, sct@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ext3+quota deadlock
Message-ID: <20030416193859.GA1379@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi Alan,

  I'm sending you a patch which fixes a deadlock when quota is used on
ext3. There is lock inversion on dqio_sem and journal_start/stop. The
patch introduces needed framework for ext3 to start transaction before
dqio_sem is acquired. Please apply.

							Bye
								Honza

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.4.21-pre5-ac3-2-ext3deadlock.diff"

diff -ruNX /home/jack/.kerndiffexclude linux-2.4.21-pre5-ac3-1-syncall/fs/dquot.c linux-2.4.21-pre5-ac3-2-ext3deadlock/fs/dquot.c
--- linux-2.4.21-pre5-ac3-1-syncall/fs/dquot.c	Tue Apr  1 21:08:39 2003
+++ linux-2.4.21-pre5-ac3-2-ext3deadlock/fs/dquot.c	Mon Apr 14 23:55:34 2003
@@ -397,7 +397,7 @@
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
 		if (dquot_dirty(dquot))
-			commit_dqblk(dquot);
+			sb->dq_op->sync_dquot(dquot);
 		dqput(dquot);
 		goto restart;
 	}
@@ -1221,9 +1221,16 @@
 	alloc_inode:	dquot_alloc_inode,
 	free_space:	dquot_free_space,
 	free_inode:	dquot_free_inode,
-	transfer:	dquot_transfer
+	transfer:	dquot_transfer,
+	sync_dquot:	commit_dqblk
 };
 
+/* Function used by filesystems for initializing the dquot_operations structure */
+void init_dquot_operations(struct dquot_operations *fsdqops)
+{
+	memcpy(fsdqops, &dquot_operations, sizeof(dquot_operations));
+}
+
 static inline void set_enable_flags(struct quota_info *dqopt, int type)
 {
 	switch (type) {
@@ -1519,3 +1526,4 @@
 EXPORT_SYMBOL(register_quota_format);
 EXPORT_SYMBOL(unregister_quota_format);
 EXPORT_SYMBOL(dqstats);
+EXPORT_SYMBOL(init_dquot_operations);
diff -ruNX /home/jack/.kerndiffexclude linux-2.4.21-pre5-ac3-1-syncall/fs/ext3/super.c linux-2.4.21-pre5-ac3-2-ext3deadlock/fs/ext3/super.c
--- linux-2.4.21-pre5-ac3-1-syncall/fs/ext3/super.c	Tue Apr  1 21:06:22 2003
+++ linux-2.4.21-pre5-ac3-2-ext3deadlock/fs/ext3/super.c	Mon Apr 14 23:58:24 2003
@@ -448,6 +448,9 @@
 	return;
 }
 
+static struct dquot_operations ext3_qops;
+static int (*old_sync_dquot)(struct dquot *dquot);
+
 static struct super_operations ext3_sops = {
 	read_inode:	ext3_read_inode,	/* BKL held */
 	write_inode:	ext3_write_inode,	/* BKL not held.  Don't need */
@@ -1128,6 +1131,7 @@
 	 * set up enough so that it can read an inode
 	 */
 	sb->s_op = &ext3_sops;
+	sb->dq_op = &ext3_qops;
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 
 	sb->s_root = 0;
@@ -1758,10 +1762,63 @@
 	return 0;
 }
 
+/* Helper function for writing quotas on sync - we need to start transaction before quota file
+ * is locked for write. Otherwise the are possible deadlocks:
+ * Process 1                         Process 2
+ * ext3_create()                     quota_sync()
+ *   journal_start()                   write_dquot()
+ *   DQUOT_INIT()                        down(dqio_sem)
+ *     down(dqio_sem)                    journal_start()
+ *
+ */
+
+#ifdef CONFIG_QUOTA
+
+#define EXT3_OLD_QFMT_BLOCKS 2
+#define EXT3_V0_QFMT_BLOCKS 6
+
+static int ext3_sync_dquot(struct dquot *dquot)
+{
+	int nblocks, ret;
+	handle_t *handle;
+	struct quota_info *dqops = sb_dqopt(dquot->dq_sb);
+	struct inode *qinode;
+
+	switch (dqops->info[dquot->dq_type].dqi_format->qf_fmt_id) {
+		case QFMT_VFS_OLD:
+			nblocks = EXT3_OLD_QFMT_BLOCKS;
+			break;
+		case QFMT_VFS_V0:
+			nblocks = EXT3_V0_QFMT_BLOCKS;
+			break;
+		default:
+			nblocks = EXT3_MAX_TRANS_DATA;
+	}
+	lock_kernel();
+	qinode = dqops->files[dquot->dq_type]->f_dentry->d_inode;
+	handle = ext3_journal_start(qinode, nblocks);
+	if (IS_ERR(handle)) {
+		unlock_kernel();
+		return PTR_ERR(handle);
+	}
+	unlock_kernel();
+	ret = old_sync_dquot(dquot);
+	lock_kernel();
+	ret = ext3_journal_stop(handle, qinode);
+	unlock_kernel();
+	return ret;
+}
+#endif
+
 static DECLARE_FSTYPE_DEV(ext3_fs_type, "ext3", ext3_read_super);
 
 static int __init init_ext3_fs(void)
 {
+#ifdef CONFIG_QUOTA
+	init_dquot_operations(&ext3_qops);
+	old_sync_dquot = ext3_qops.sync_dquot;
+	ext3_qops.sync_dquot = ext3_sync_dquot;
+#endif
         return register_filesystem(&ext3_fs_type);
 }
 
diff -ruNX /home/jack/.kerndiffexclude linux-2.4.21-pre5-ac3-1-syncall/include/linux/quota.h linux-2.4.21-pre5-ac3-2-ext3deadlock/include/linux/quota.h
--- linux-2.4.21-pre5-ac3-1-syncall/include/linux/quota.h	Tue Apr  1 21:19:44 2003
+++ linux-2.4.21-pre5-ac3-2-ext3deadlock/include/linux/quota.h	Tue Apr 15 21:07:51 2003
@@ -251,6 +251,7 @@
 	void (*free_space) (struct inode *, qsize_t);
 	void (*free_inode) (const struct inode *, unsigned long);
 	int (*transfer) (struct inode *, struct iattr *);
+	int (*sync_dquot) (struct dquot *);
 };
 
 /* Operations handling requests from userspace */
@@ -312,6 +313,7 @@
 
 int register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
+void init_dquot_operations(struct dquot_operations *fsdqops);
 
 #else
 

--cWoXeonUoKmBZSoM--
