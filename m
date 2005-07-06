Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVGFC0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVGFC0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVGFCZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:25:20 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:57496 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262038AbVGFCTR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:17 -0400
Subject: [PATCH] [5/48] Suspend2 2.1.9.8 for 2.6.12: 350-workthreads.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:39 +1000
Message-Id: <112061643920@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 351-syncthreads.patch-old/fs/buffer.c 351-syncthreads.patch-new/fs/buffer.c
--- 351-syncthreads.patch-old/fs/buffer.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/fs/buffer.c	2005-07-04 23:14:18.000000000 +1000
@@ -173,6 +173,15 @@ EXPORT_SYMBOL(sync_blockdev);
  */
 int fsync_super(struct super_block *sb)
 {
+	int ret;
+
+	/* A safety net. During suspend, we might overwrite
+	 * memory containing filesystem info. We don't then
+	 * want to sync it to disk. */
+	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
+	
+	current->flags |= PF_SYNCTHREAD;
+
 	sync_inodes_sb(sb, 0);
 	DQUOT_SYNC(sb);
 	lock_super(sb);
@@ -184,7 +193,10 @@ int fsync_super(struct super_block *sb)
 	sync_blockdev(sb->s_bdev);
 	sync_inodes_sb(sb, 1);
 
-	return sync_blockdev(sb->s_bdev);
+	ret = sync_blockdev(sb->s_bdev);
+
+	current->flags &= ~PF_SYNCTHREAD;
+	return ret;
 }
 
 /*
@@ -195,12 +207,21 @@ int fsync_super(struct super_block *sb)
 int fsync_bdev(struct block_device *bdev)
 {
 	struct super_block *sb = get_super(bdev);
+	int ret;
+
+	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
+
+	current->flags |= PF_SYNCTHREAD;
+
 	if (sb) {
 		int res = fsync_super(sb);
 		drop_super(sb);
+		current->flags &= ~PF_SYNCTHREAD;
 		return res;
 	}
-	return sync_blockdev(bdev);
+	ret = sync_blockdev(bdev);
+	current->flags &= ~PF_SYNCTHREAD;
+	return ret;
 }
 
 /**
@@ -280,6 +301,13 @@ EXPORT_SYMBOL(thaw_bdev);
  */
 static void do_sync(unsigned long wait)
 {
+	/* A safety net. During suspend, we might overwrite
+	 * memory containing filesystem info. We don't then
+	 * want to sync it to disk. */
+	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
+
+	current->flags |= PF_SYNCTHREAD;
+
 	wakeup_bdflush(0);
 	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
 	DQUOT_SYNC(NULL);
@@ -291,6 +319,8 @@ static void do_sync(unsigned long wait)
 		printk("Emergency Sync complete\n");
 	if (unlikely(laptop_mode))
 		laptop_sync_completion();
+
+	current->flags &= ~PF_SYNCTHREAD;
 }
 
 asmlinkage long sys_sync(void)
@@ -316,6 +346,10 @@ int file_fsync(struct file *filp, struct
 	struct super_block * sb;
 	int ret, err;
 
+	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
+
+	current->flags |= PF_SYNCTHREAD;
+
 	/* sync the inode to buffers */
 	ret = write_inode_now(inode, 0);
 
@@ -330,6 +364,8 @@ int file_fsync(struct file *filp, struct
 	err = sync_blockdev(sb->s_bdev);
 	if (!ret)
 		ret = err;
+
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
@@ -339,6 +375,10 @@ asmlinkage long sys_fsync(unsigned int f
 	struct address_space *mapping;
 	int ret, err;
 
+	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
+
+	current->flags |= PF_SYNCTHREAD;
+
 	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
@@ -372,6 +412,7 @@ asmlinkage long sys_fsync(unsigned int f
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
@@ -381,6 +422,10 @@ asmlinkage long sys_fdatasync(unsigned i
 	struct address_space *mapping;
 	int ret, err;
 
+	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
+
+	current->flags |= PF_SYNCTHREAD;
+
 	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
@@ -407,6 +452,7 @@ asmlinkage long sys_fdatasync(unsigned i
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
diff -ruNp 351-syncthreads.patch-old/fs/jbd/journal.c 351-syncthreads.patch-new/fs/jbd/journal.c
--- 351-syncthreads.patch-old/fs/jbd/journal.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/fs/jbd/journal.c	2005-07-04 23:14:19.000000000 +1000
@@ -130,6 +130,7 @@ int kjournald(void *arg)
 	current_journal = journal;
 
 	daemonize("kjournald");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* Set up an interval timer which can be used to trigger a
            commit wakeup after the commit interval expires */
diff -ruNp 351-syncthreads.patch-old/fs/jffs/intrep.c 351-syncthreads.patch-new/fs/jffs/intrep.c
--- 351-syncthreads.patch-old/fs/jffs/intrep.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/fs/jffs/intrep.c	2005-07-04 23:14:19.000000000 +1000
@@ -3364,6 +3364,7 @@ jffs_garbage_collect_thread(void *ptr)
 	D1(int i = 1);
 
 	daemonize("jffs_gcd");
+	current->flags |= PF_SYNCTHREAD;
 
 	c->gc_task = current;
 
diff -ruNp 351-syncthreads.patch-old/fs/jfs/jfs_logmgr.c 351-syncthreads.patch-new/fs/jfs/jfs_logmgr.c
--- 351-syncthreads.patch-old/fs/jfs/jfs_logmgr.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/fs/jfs/jfs_logmgr.c	2005-07-04 23:14:19.000000000 +1000
@@ -2351,6 +2351,7 @@ int jfsIOWait(void *arg)
 	struct lbuf *bp;
 
 	daemonize("jfsIO");
+	current->flags |= PF_SYNCTHREAD;
 
 	complete(&jfsIOwait);
 
diff -ruNp 351-syncthreads.patch-old/fs/jfs/jfs_txnmgr.c 351-syncthreads.patch-new/fs/jfs/jfs_txnmgr.c
--- 351-syncthreads.patch-old/fs/jfs/jfs_txnmgr.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/fs/jfs/jfs_txnmgr.c	2005-07-04 23:14:19.000000000 +1000
@@ -47,7 +47,6 @@
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
-#include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include "jfs_incore.h"
@@ -2777,6 +2776,7 @@ int jfs_lazycommit(void *arg)
 	struct jfs_sb_info *sbi;
 
 	daemonize("jfsCommit");
+	current->flags |= PF_SYNCTHREAD;
 
 	complete(&jfsIOwait);
 
diff -ruNp 351-syncthreads.patch-old/fs/lockd/clntlock.c 351-syncthreads.patch-new/fs/lockd/clntlock.c
--- 351-syncthreads.patch-old/fs/lockd/clntlock.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/fs/lockd/clntlock.c	2005-07-04 23:14:19.000000000 +1000
@@ -200,6 +200,7 @@ reclaimer(void *ptr)
 	struct inode *inode;
 
 	daemonize("%s-reclaim", host->h_name);
+	current->flags |= PF_SYNCTHREAD;
 	allow_signal(SIGKILL);
 
 	/* This one ensures that our parent doesn't terminate while the
diff -ruNp 351-syncthreads.patch-old/fs/lockd/svc.c 351-syncthreads.patch-new/fs/lockd/svc.c
--- 351-syncthreads.patch-old/fs/lockd/svc.c	2005-06-20 11:47:13.000000000 +1000
+++ 351-syncthreads.patch-new/fs/lockd/svc.c	2005-07-04 23:14:19.000000000 +1000
@@ -115,6 +115,7 @@ lockd(struct svc_rqst *rqstp)
 	up(&lockd_start);
 
 	daemonize("lockd");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* Process request with signals blocked, but allow SIGKILL.  */
 	allow_signal(SIGKILL);
@@ -138,6 +139,8 @@ lockd(struct svc_rqst *rqstp)
 	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 
+		try_to_freeze();
+
 		if (signalled()) {
 			flush_signals(current);
 			if (nlmsvc_ops) {
diff -ruNp 351-syncthreads.patch-old/fs/nfsd/nfssvc.c 351-syncthreads.patch-new/fs/nfsd/nfssvc.c
--- 351-syncthreads.patch-old/fs/nfsd/nfssvc.c	2005-06-20 11:47:13.000000000 +1000
+++ 351-syncthreads.patch-new/fs/nfsd/nfssvc.c	2005-07-04 23:14:19.000000000 +1000
@@ -182,6 +182,7 @@ nfsd(struct svc_rqst *rqstp)
 	/* Lock module and set up kernel thread */
 	lock_kernel();
 	daemonize("nfsd");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* After daemonize() this kernel thread shares current->fs
 	 * with the init process. We need to create files with a
diff -ruNp 351-syncthreads.patch-old/fs/xfs/linux-2.6/xfs_buf.c 351-syncthreads.patch-new/fs/xfs/linux-2.6/xfs_buf.c
--- 351-syncthreads.patch-old/fs/xfs/linux-2.6/xfs_buf.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/fs/xfs/linux-2.6/xfs_buf.c	2005-07-04 23:14:19.000000000 +1000
@@ -1772,7 +1772,7 @@ pagebuf_daemon(
 
 	/*  Set up the thread  */
 	daemonize("xfsbufd");
-	current->flags |= PF_MEMALLOC;
+	current->flags |= PF_MEMALLOC | PF_SYNCTHREAD;
 
 	pagebuf_daemon_task = current;
 	pagebuf_daemon_active = 1;
diff -ruNp 351-syncthreads.patch-old/fs/xfs/linux-2.6/xfs_super.c 351-syncthreads.patch-new/fs/xfs/linux-2.6/xfs_super.c
--- 351-syncthreads.patch-old/fs/xfs/linux-2.6/xfs_super.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/fs/xfs/linux-2.6/xfs_super.c	2005-07-04 23:14:19.000000000 +1000
@@ -470,6 +470,7 @@ xfssyncd(
 	struct vfs_sync_work	*work, *n;
 
 	daemonize("xfssyncd");
+	current->flags |= PF_SYNCTHREAD;
 
 	vfsp->vfs_sync_work.w_vfs = vfsp;
 	vfsp->vfs_sync_work.w_syncer = vfs_sync_worker;
diff -ruNp 351-syncthreads.patch-old/include/linux/sched.h 351-syncthreads.patch-new/include/linux/sched.h
--- 351-syncthreads.patch-old/include/linux/sched.h	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/include/linux/sched.h	2005-07-04 23:14:19.000000000 +1000
@@ -798,6 +798,8 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_SYNCTHREAD	0x01000000	/* this thread can start activity during the 
++ 					   early part of freezing processes */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
diff -ruNp 351-syncthreads.patch-old/mm/pdflush.c 351-syncthreads.patch-new/mm/pdflush.c
--- 351-syncthreads.patch-old/mm/pdflush.c	2005-07-06 11:15:04.000000000 +1000
+++ 351-syncthreads.patch-new/mm/pdflush.c	2005-07-04 23:14:19.000000000 +1000
@@ -89,7 +89,7 @@ struct pdflush_work {
 
 static int __pdflush(struct pdflush_work *my_work)
 {
-	current->flags |= PF_FLUSHER;
+	current->flags |= (PF_FLUSHER | PF_SYNCTHREAD);
 	my_work->fn = NULL;
 	my_work->who = current;
 	INIT_LIST_HEAD(&my_work->list);

