Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVGUF2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVGUF2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVGUF0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:26:06 -0400
Received: from [216.208.38.107] ([216.208.38.107]:10916 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261631AbVGUFYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:24:10 -0400
Subject: [PATCH] Syncthreads support.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121923564.2936.231.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 21 Jul 2005 15:26:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a new PF_SYNCTHREAD flag, which allows upcoming
the refrigerator implementation to know that a thread is syncing data to
disk. This allows the refrigerator to be more reliable, even under heavy
load, because it can separate userspace processes that are submitting
I/O from those trying to sync it and freezing the former first. We can
thus ensure that syncing processes complete their work more quickly and
the refrigerator is far less likely to incorrectly give up (thinking a
syncing process is completely failing to enter the refrigerator).

Signed-off by: Nigel Cunningham <nigel@suspend2.net>

 fs/buffer.c           |   45 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/sched.h |    2 ++
 2 files changed, 45 insertions(+), 2 deletions(-)
diff -ruNp 410-syncthreads.patch-old/fs/buffer.c 410-syncthreads.patch-new/fs/buffer.c
--- 410-syncthreads.patch-old/fs/buffer.c	2005-07-18 06:36:58.000000000 +1000
+++ 410-syncthreads.patch-new/fs/buffer.c	2005-07-21 15:18:42.000000000 +1000
@@ -171,6 +171,15 @@ EXPORT_SYMBOL(sync_blockdev);
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
@@ -182,7 +191,10 @@ int fsync_super(struct super_block *sb)
 	sync_blockdev(sb->s_bdev);
 	sync_inodes_sb(sb, 1);
 
-	return sync_blockdev(sb->s_bdev);
+	ret = sync_blockdev(sb->s_bdev);
+
+	current->flags &= ~PF_SYNCTHREAD;
+	return ret;
 }
 
 /*
@@ -193,12 +205,21 @@ int fsync_super(struct super_block *sb)
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
@@ -278,6 +299,13 @@ EXPORT_SYMBOL(thaw_bdev);
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
 	wakeup_pdflush(0);
 	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
 	DQUOT_SYNC(NULL);
@@ -289,6 +317,8 @@ static void do_sync(unsigned long wait)
 		printk("Emergency Sync complete\n");
 	if (unlikely(laptop_mode))
 		laptop_sync_completion();
+
+	current->flags &= ~PF_SYNCTHREAD;
 }
 
 asmlinkage long sys_sync(void)
@@ -314,6 +344,10 @@ int file_fsync(struct file *filp, struct
 	struct super_block * sb;
 	int ret, err;
 
+	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
+
+	current->flags |= PF_SYNCTHREAD;
+
 	/* sync the inode to buffers */
 	ret = write_inode_now(inode, 0);
 
@@ -328,6 +362,8 @@ int file_fsync(struct file *filp, struct
 	err = sync_blockdev(sb->s_bdev);
 	if (!ret)
 		ret = err;
+
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
@@ -337,6 +373,10 @@ static long do_fsync(unsigned int fd, in
 	struct address_space *mapping;
 	int ret, err;
 
+	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
+
+	current->flags |= PF_SYNCTHREAD;
+
 	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
@@ -370,6 +410,7 @@ static long do_fsync(unsigned int fd, in
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
diff -ruNp 410-syncthreads.patch-old/include/linux/sched.h 410-syncthreads.patch-new/include/linux/sched.h
--- 410-syncthreads.patch-old/include/linux/sched.h	2005-07-21 15:18:26.000000000 +1000
+++ 410-syncthreads.patch-new/include/linux/sched.h	2005-07-21 15:18:42.000000000 +1000
@@ -829,6 +829,8 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_SYNCTHREAD	0x01000000	/* this thread can start activity during the 
++ 					   early part of freezing processes */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

