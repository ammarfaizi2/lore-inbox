Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTKJLLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTKJLLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:11:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63194 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263158AbTKJLLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:11:05 -0500
Date: Mon, 10 Nov 2003 12:11:03 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, ext3-users@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: EXT3 deadlock in 2.4.22 and 2.4.23-pre7 - quota related?
Message-ID: <20031110111103.GB11335@atrey.karlin.mff.cuni.cz>
References: <16284.46552.776018.358472@notabene.cse.unsw.edu.au> <20031027020151.333fcb9e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20031027020151.333fcb9e.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

  attached patch for 2.4.22 (should apply to -pre kernels also) should
fix the problem... The fix contains two parts - first it disables ATIME
on quota files so we know that reading file doesn't cause a write to
filesystem (can I rely on this?) and second it ensures that whenever we
write some quota structure the transaction is already started and hence
we should not deadlock. I was thinking about the problem and I didn't
find better solution. Please test the patch (I gave it reasonable
testing under UML but anyway).

								Honza

> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > 
> > Hi all, and particularly Andrew and Stephen,
> > 
> >  I recently "upgraded' one of my NFS fileservers from (patched)2.4.18
> >  to 2.4.23-pre7 (in order to resolve a HIMEM related memory pressure
> >  problem).
> > 
> >  Unfortunately I have experienced what appears to be a deadlock.
> >
> 
> I don't recall a time when quotas on ext3 were not deadlocky :(
> 
> > ...
> > 
> >       rquotad Call Trace:    [sleep_on+75/124]
> >             [start_this_handle+205/368] [journal_start+149/196]
> >             [ext3_dirty_inode+116/268] [__mark_inode_dirty+50/168]
> >             [update_atime+75/80] [do_generic_file_read+1158/1172]
> >             [generic_file_read+147/400] [file_read_actor+0/224]
> >             [do_get_write_access+1382/1420] [v1_read_dqblk+121/196]
> >             [read_dqblk+76/128] [dqget+344/484] [vfs_get_dqblk+21/64]
> >             [v1_get_dqblk+39/172] [link_path_walk+2680/2956]
> >             [do_compat_quotactl+417/688] [resolve_dev+89/108]
> >             [sys_quotactl+166/275] [system_call+51/56] 
> 
> read_dqblk() took dqio_sem, then ext3_dirty_inode() did journal_start().
> 
> > At the same time, "sync" is running:
> > 
> >          sync Call Trace:    [__down+109/208] [__down_failed+8/12]
> >              [.text.lock.dquot+73/286] [ext3_sync_dquot+337/462]
> >              [vfs_quota_sync+102/372] [sync_dquots_dev+194/260]
> >              [fsync_dev+66/128] [sys_sync+7/16] [system_call+51/56] 
> 
> ext3_sync_dquot() did journal_start(), then someone (commit_dqblk?) tried
> to take dqio_sem.
> 
> Probably it is not too hard to flip the ordering in the latter case, but all
> other code paths need to be checked, and perhaps even documented.
> 
> Jan, didn't we fix this very problem in 2.6 recently?
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--LZvS9be/3tNcYl/X
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

--LZvS9be/3tNcYl/X--
