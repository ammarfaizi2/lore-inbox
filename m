Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUH1J1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUH1J1R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUH1J0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:26:25 -0400
Received: from holomorphy.com ([207.189.100.168]:28837 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266741AbUH1JY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:24:59 -0400
Date: Sat, 28 Aug 2004 02:24:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: [4/4] eliminate inode waitqueue hashtable
Message-ID: <20040828092451.GL5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, oleg@tv-sign.ru,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com> <20040827231713.212245c5.akpm@osdl.org> <20040828063419.GA5492@holomorphy.com> <20040827234033.2b6e1525.akpm@osdl.org> <20040828064829.GB5492@holomorphy.com> <20040828092040.GH5492@holomorphy.com> <20040828092210.GJ5492@holomorphy.com> <20040828092337.GK5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828092337.GK5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:23:37AM -0700, William Lee Irwin III wrote:
> Eliminate the bh waitqueue hashtable using bit_waitqueue() via
> wait_on_bit() and wake_up_bit() to locate the waitqueue head associated
> with a bit.

Eliminate the inode waitqueue hashtable using bit_waitqueue() via
wait_on_bit() and wake_up_bit() to locate the waitqueue head associated
with a bit.

Index: mm1-2.6.9-rc1/fs/inode.c
===================================================================
--- mm1-2.6.9-rc1.orig/fs/inode.c	2004-08-26 15:04:02.000000000 -0700
+++ mm1-2.6.9-rc1/fs/inode.c	2004-08-27 22:15:43.602377440 -0700
@@ -1257,37 +1257,17 @@
 
 #endif
 
-/*
- * Hashed waitqueues for wait_on_inode().  The table is pretty small - the
- * kernel doesn't lock many inodes at the same time.
- */
-#define I_WAIT_TABLE_ORDER	3
-static struct i_wait_queue_head {
-	wait_queue_head_t wqh;
-} ____cacheline_aligned_in_smp i_wait_queue_heads[1<<I_WAIT_TABLE_ORDER];
+#define __I_LOCK	3
 
-/*
- * Return the address of the waitqueue_head to be used for this inode
- */
-static wait_queue_head_t *i_waitq_head(struct inode *inode)
+static int inode_wait(void *word)
 {
-	return &i_wait_queue_heads[hash_ptr(inode, I_WAIT_TABLE_ORDER)].wqh;
+	schedule();
+	return 0;
 }
 
 void __wait_on_inode(struct inode *inode)
 {
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
+	wait_on_bit(&inode->i_state, __I_LOCK, inode_wait, TASK_UNINTERRUPTIBLE);
 }
 
 /*
@@ -1305,27 +1285,23 @@
  */
 static void __wait_on_freeing_inode(struct inode *inode)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	wait_queue_head_t *wq = i_waitq_head(inode);
+	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_LOCK);
+	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_LOCK);
 
-	add_wait_queue(wq, &wait);
-	set_current_state(TASK_UNINTERRUPTIBLE);
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
