Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270223AbTGNOaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270584AbTGNO2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:28:14 -0400
Received: from verein.lst.de ([212.34.189.10]:5819 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S270223AbTGNOWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:22:12 -0400
Date: Mon, 14 Jul 2003 16:36:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com, Christoph Hellwig <hch@infradead.org>,
       Jan Kara <jack@suse.cz>
Subject: Re: -- END OF BLOCK -- (fwd)
Message-ID: <20030714143613.GA9349@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>, marcelo@conectiva.com,
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
References: <Pine.LNX.4.55L.0307141007560.18257@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307141007560.18257@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5.5 () EMAIL_ATTRIBUTION,IN_REP_TO,PATCH_UNIFIED_DIFF,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 10:08:02AM -0300, Marcelo Tosatti wrote:
> The quota code you have in -ac is new Jan Kara's stuff (which supports
> both formats, etc) plus the ext3 deadlock avoidance and the compat stuff ?
> 
> Christoph, for what reason have you removed the ext3 deadlock avoidance
> patches? And also, what else have you changed wrt originals Jan code ?

Umm, I didn't not remove anything.  I backported Jan's code from 2.5
long ago and resynched with 2.5 from time to time.  I sent this code
to Alan and Andrea for -aa and -ac and now sent it to you with the
changes you requested (make the old quota format and userland ABI
compiled in unconditionally.)

Now it seems Alan merged other stuff without telling the person
who send him the original patch, thus -ac seems to have code the
XFS tree and -aa don't have.

I've now extracted the ext3 quota changes from -ac for you.  Note
that their only relation of them to the new quota code is that
the patch is ontop of it and thus takes it into account, the problem
is an old one.

Here's the patch, probably the last 2.4 patch from me if we really
want to play the hot potatoe game.

> Lets have -pre6 soon to fix up this mess (which is causing DEADLOCKS), ok?

s/cause/not fix existing/


p.s. yes, the patch is more ugly than anything I'd usually submit.
but it's not mine and I don't have any interest in it.  merge it asis
or clean it up yourself - I don't care anymore.

--- 1.19/fs/dquot.c	Mon Jul  7 12:44:36 2003
+++ edited/fs/dquot.c	Mon Jul 14 05:52:09 2003
@@ -395,7 +395,7 @@
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
 		if (dquot_dirty(dquot))
-			commit_dqblk(dquot);
+			sb->dq_op->sync_dquot(dquot);
 		dqput(dquot);
 		goto restart;
 	}
@@ -1219,9 +1219,16 @@
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
@@ -1517,3 +1524,4 @@
 EXPORT_SYMBOL(register_quota_format);
 EXPORT_SYMBOL(unregister_quota_format);
 EXPORT_SYMBOL(dqstats);
+EXPORT_SYMBOL(init_dquot_operations);
--- 1.9/fs/ext3/super.c	Tue Apr 22 03:16:23 2003
+++ edited/fs/ext3/super.c	Mon Jul 14 06:01:49 2003
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
@@ -1758,10 +1762,65 @@
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
+/* Blocks: (2 data blocks) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
+#define EXT3_OLD_QFMT_BLOCKS 11
+/* Blocks: quota info + (4 pointer blocks + 1 entry block) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
+#define EXT3_V0_QFMT_BLOCKS 27
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
 
===== include/linux/quota.h 1.4 vs edited =====
--- 1.4/include/linux/quota.h	Tue Jun 24 23:11:29 2003
+++ edited/include/linux/quota.h	Mon Jul 14 06:03:04 2003
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
 
