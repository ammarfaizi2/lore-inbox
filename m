Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266253AbUGAUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUGAUHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUGAUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:07:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8361 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266253AbUGAUHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:07:41 -0400
Date: Thu, 1 Jul 2004 22:07:40 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix minor quota race
Message-ID: <20040701200740.GE3540@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello Andrew!

  I'm sending one more quota fix - it fixes a possible race between
quotaoff and prune_icache. The race could lead to some forgotten
pointers to quotas in inodes leading later to BUG when invalidating
quota structures. The patch is against 2.6.7. Please apply.

							Honza


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.7-2-quotaoff.diff"

diff -rpuX /home/jack/.kerndiffexclude linux-2.6.7-1-flagslock/fs/dquot.c linux-2.6.7-2-quotaoff/fs/dquot.c
--- linux-2.6.7-1-flagslock/fs/dquot.c	2004-07-01 20:49:27.000000000 +0200
+++ linux-2.6.7-2-quotaoff/fs/dquot.c	2004-07-01 20:54:04.000000000 +0200
@@ -114,9 +114,10 @@
  * operations on dquots don't hold dq_lock as they copy data under dq_data_lock
  * spinlock to internal buffers before writing.
  *
- * Lock ordering (including related VFS locks) is following:
- *  i_sem > dqonoff_sem > journal_lock > dqptr_sem > dquot->dq_lock > dqio_sem
- *  i_sem on quota files is special (it's below dqio_sem)
+ * Lock ordering (including some related VFS locks) is the following:
+ *   i_sem > dqonoff_sem > iprune_sem > journal_lock > dqptr_sem >
+ *   > dquot->dq_lock > dqio_sem
+ * i_sem on quota files is special (it's below dqio_sem)
  */
 
 spinlock_t dq_list_lock = SPIN_LOCK_UNLOCKED;
@@ -726,14 +727,20 @@ static void put_dquot_list(struct list_h
 /* Function in inode.c - remove pointers to dquots in icache */
 extern void remove_dquot_ref(struct super_block *, int, struct list_head *);
 
+extern struct semaphore iprune_sem;
+
 /* Gather all references from inodes and drop them */
 static void drop_dquot_ref(struct super_block *sb, int type)
 {
 	LIST_HEAD(tofree_head);
 
+	/* We need to be guarded against prune_icache to reach all the
+	 * inodes - otherwise some can be on the local list of prune_icache */
+	down(&iprune_sem);
 	down_write(&sb_dqopt(sb)->dqptr_sem);
 	remove_dquot_ref(sb, type, &tofree_head);
 	up_write(&sb_dqopt(sb)->dqptr_sem);
+	up(&iprune_sem);
 	put_dquot_list(&tofree_head);
 }
 
diff -rpuX /home/jack/.kerndiffexclude linux-2.6.7-1-flagslock/fs/inode.c linux-2.6.7-2-quotaoff/fs/inode.c
--- linux-2.6.7-1-flagslock/fs/inode.c	2004-06-30 23:17:12.000000000 +0200
+++ linux-2.6.7-2-quotaoff/fs/inode.c	2004-07-01 00:27:08.000000000 +0200
@@ -89,7 +89,7 @@ spinlock_t inode_lock = SPIN_LOCK_UNLOCK
  * from its final dispose_list, the struct super_block they refer to
  * (for inode->i_sb->s_op) may already have been freed and reused.
  */
-static DECLARE_MUTEX(iprune_sem);
+DECLARE_MUTEX(iprune_sem);
 
 /*
  * Statistics gathering..

--Yylu36WmvOXNoKYn--
