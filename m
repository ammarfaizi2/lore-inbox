Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUH1UUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUH1UUI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUH1USs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:18:48 -0400
Received: from holomorphy.com ([207.189.100.168]:3753 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267851AbUH1UMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:12:42 -0400
Date: Sat, 28 Aug 2004 13:12:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [5/5] eliminate inode waitqueue hashtable
Message-ID: <20040828201239.GW5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040828200549.GR5492@holomorphy.com> <20040828200659.GS5492@holomorphy.com> <20040828200841.GT5492@holomorphy.com> <20040828200951.GU5492@holomorphy.com> <20040828201107.GV5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828201107.GV5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 01:11:07PM -0700, William Lee Irwin III wrote:
> Eliminate the bh waitqueue hashtable using bit_waitqueue() via
> wait_on_bit() and wake_up_bit() to locate the waitqueue head associated
> with a bit.

Eliminate the inode waitqueue hashtable using bit_waitqueue() via
wait_on_bit() and wake_up_bit() to locate the waitqueue head associated
with a bit.

Index: wait-2.6.9-rc1-mm1/include/linux/fs.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/linux/fs.h	2004-08-28 09:43:24.899791040 -0700
+++ wait-2.6.9-rc1-mm1/include/linux/fs.h	2004-08-28 09:50:30.834039192 -0700
@@ -1057,6 +1057,7 @@
 #define I_NEW			64
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
+#define __I_LOCK		3 /* I_LOCK == 1 << __I_LOCK */
 
 extern void __mark_inode_dirty(struct inode *, int);
 static inline void mark_inode_dirty(struct inode *inode)
Index: wait-2.6.9-rc1-mm1/fs/inode.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/fs/inode.c	2004-08-28 09:43:23.419016152 -0700
+++ wait-2.6.9-rc1-mm1/fs/inode.c	2004-08-28 09:50:30.827040256 -0700
@@ -1257,37 +1257,10 @@
 
 #endif
 
-/*
- * Hashed waitqueues for wait_on_inode().  The table is pretty small - the
- * kernel doesn't lock many inodes at the same time.
- */
-#define I_WAIT_TABLE_ORDER	3
-static struct i_wait_queue_head {
-	wait_queue_head_t wqh;
-} ____cacheline_aligned_in_smp i_wait_queue_heads[1<<I_WAIT_TABLE_ORDER];
-
-/*
- * Return the address of the waitqueue_head to be used for this inode
- */
-static wait_queue_head_t *i_waitq_head(struct inode *inode)
+int inode_wait(void *word)
 {
-	return &i_wait_queue_heads[hash_ptr(inode, I_WAIT_TABLE_ORDER)].wqh;
-}
-
-void __wait_on_inode(struct inode *inode)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	wait_queue_head_t *wq = i_waitq_head(inode);
-
-	add_wait_queue(wq, &wait);
-repeat:
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (inode->i_state & I_LOCK) {
-		schedule();
-		goto repeat;
-	}
-	remove_wait_queue(wq, &wait);
-	__set_current_state(TASK_RUNNING);
+	schedule();
+	return 0;
 }
 
 /*
@@ -1296,36 +1269,39 @@
  * that it isn't found.  This is because iget will immediately call
  * ->read_inode, and we want to be sure that evidence of the deletion is found
  * by ->read_inode.
- *
- * This call might return early if an inode which shares the waitq is woken up.
- * This is most easily handled by the caller which will loop around again
- * looking for the inode.
- *
  * This is called with inode_lock held.
  */
 static void __wait_on_freeing_inode(struct inode *inode)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	wait_queue_head_t *wq = i_waitq_head(inode);
+	wait_queue_head_t *wq;
+	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_LOCK);
 
-	add_wait_queue(wq, &wait);
-	set_current_state(TASK_UNINTERRUPTIBLE);
+	/*
+	 * I_FREEING and I_CLEAR are cleared in process context under
+	 * inode_lock, so we have to give the tasks who would clear them
+	 * a chance to run and acquire inode_lock.
+	 */
+	if (!(inode->i_state & I_LOCK)) {
+		spin_unlock(&inode_lock);
+		yield();
+		spin_lock(&inode_lock);
+		return;
+	}
+	wq = bit_waitqueue(&inode->i_state, __I_LOCK);
+	prepare_to_wait(wq, &wait.wait, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode_lock);
 	schedule();
-	remove_wait_queue(wq, &wait);
+	finish_wait(wq, &wait.wait);
 	spin_lock(&inode_lock);
 }
 
 void wake_up_inode(struct inode *inode)
 {
-	wait_queue_head_t *wq = i_waitq_head(inode);
-
 	/*
 	 * Prevent speculative execution through spin_unlock(&inode_lock);
 	 */
 	smp_mb();
-	if (waitqueue_active(wq))
-		wake_up_all(wq);
+	wake_up_bit(&inode->i_state, __I_LOCK);
 }
 EXPORT_SYMBOL(wake_up_inode);
 
@@ -1361,11 +1337,6 @@
 
 void __init inode_init(unsigned long mempages)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
-		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
-
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
 				0, SLAB_PANIC, init_once, NULL);
Index: wait-2.6.9-rc1-mm1/kernel/wait.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/wait.c	2004-08-28 09:49:39.456849712 -0700
+++ wait-2.6.9-rc1-mm1/kernel/wait.c	2004-08-28 09:50:30.842037976 -0700
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 #include <linux/wait.h>
 #include <linux/hash.h>
 
Index: wait-2.6.9-rc1-mm1/fs/fs-writeback.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/fs/fs-writeback.c	2004-08-28 09:43:21.401322888 -0700
+++ wait-2.6.9-rc1-mm1/fs/fs-writeback.c	2004-08-28 09:50:30.840038280 -0700
@@ -240,6 +240,8 @@
 __writeback_single_inode(struct inode *inode,
 			struct writeback_control *wbc)
 {
+	wait_queue_head_t *wqh;
+
 	if ((wbc->sync_mode != WB_SYNC_ALL) && (inode->i_state & I_LOCK)) {
 		list_move(&inode->i_list, &inode->i_sb->s_dirty);
 		return 0;
@@ -248,12 +250,18 @@
 	/*
 	 * It's a data-integrity sync.  We must wait.
 	 */
-	while (inode->i_state & I_LOCK) {
-		__iget(inode);
-		spin_unlock(&inode_lock);
-		__wait_on_inode(inode);
-		iput(inode);
-		spin_lock(&inode_lock);
+	if (inode->i_state & I_LOCK) {
+		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LOCK);
+
+		wqh = bit_waitqueue(&inode->i_state, __I_LOCK);
+		do {
+			__iget(inode);
+			spin_unlock(&inode_lock);
+			__wait_on_bit(wqh, &wq, &inode->i_state, __I_LOCK,
+					inode_wait, TASK_UNINTERRUPTIBLE);
+			iput(inode);
+			spin_lock(&inode_lock);
+		} while (inode->i_state & I_LOCK);
 	}
 	return __sync_single_inode(inode, wbc);
 }
Index: wait-2.6.9-rc1-mm1/include/linux/writeback.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/linux/writeback.h	2004-08-28 09:43:02.320223656 -0700
+++ wait-2.6.9-rc1-mm1/include/linux/writeback.h	2004-08-28 09:50:30.836038888 -0700
@@ -68,7 +68,7 @@
  */	
 void writeback_inodes(struct writeback_control *wbc);
 void wake_up_inode(struct inode *inode);
-void __wait_on_inode(struct inode * inode);
+int inode_wait(void *);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
 
@@ -76,8 +76,8 @@
 static inline void wait_on_inode(struct inode *inode)
 {
 	might_sleep();
-	if (inode->i_state & I_LOCK)
-		__wait_on_inode(inode);
+	wait_on_bit(&inode->i_state, __I_LOCK, inode_wait,
+							TASK_UNINTERRUPTIBLE);
 }
 
 /*
