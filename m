Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUH1UQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUH1UQj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUH1UOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:14:06 -0400
Received: from holomorphy.com ([207.189.100.168]:2729 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267807AbUH1ULM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:11:12 -0400
Date: Sat, 28 Aug 2004 13:11:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [4/5] eliminate bh waitqueue hashtable
Message-ID: <20040828201107.GV5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040828200549.GR5492@holomorphy.com> <20040828200659.GS5492@holomorphy.com> <20040828200841.GT5492@holomorphy.com> <20040828200951.GU5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828200951.GU5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 01:09:51PM -0700, William Lee Irwin III wrote:
> Consolidate bit waiting code patterns for page waitqueues using
> __wait_on_bit() and __wait_on_bit_lock().

Eliminate the bh waitqueue hashtable using bit_waitqueue() via
wait_on_bit() and wake_up_bit() to locate the waitqueue head associated
with a bit.

Index: wait-2.6.9-rc1-mm1/fs/buffer.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/fs/buffer.c	2004-08-28 09:48:39.107024280 -0700
+++ wait-2.6.9-rc1-mm1/fs/buffer.c	2004-08-28 09:49:39.441851992 -0700
@@ -43,14 +43,6 @@
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
-/*
- * Hashed waitqueue_head's for wait_on_buffer()
- */
-#define BH_WAIT_TABLE_ORDER	7
-static struct bh_wait_queue_head {
-	wait_queue_head_t wqh;
-} ____cacheline_aligned_in_smp bh_wait_queue_heads[1<<BH_WAIT_TABLE_ORDER];
-
 inline void
 init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)
 {
@@ -58,49 +50,31 @@
 	bh->b_private = private;
 }
 
-/*
- * Return the address of the waitqueue_head to be used for this
- * buffer_head
- */
-wait_queue_head_t *bh_waitq_head(struct buffer_head *bh)
-{
-	return &bh_wait_queue_heads[hash_ptr(bh, BH_WAIT_TABLE_ORDER)].wqh;
-}
-EXPORT_SYMBOL(bh_waitq_head);
-
 void wake_up_buffer(struct buffer_head *bh)
 {
-	wait_queue_head_t *wq = bh_waitq_head(bh);
-
 	smp_mb();
-	__wake_up_bit(wq, &bh->b_state, BH_Lock);
+	wake_up_bit(&bh->b_state, BH_Lock);
 }
 EXPORT_SYMBOL(wake_up_buffer);
 
-static void sync_buffer(struct buffer_head *bh)
+static int sync_buffer(void *word)
 {
 	struct block_device *bd;
+	struct buffer_head *bh
+		= container_of(word, struct buffer_head, b_state);
 
 	smp_mb();
 	bd = bh->b_bdev;
 	if (bd)
 		blk_run_address_space(bd->bd_inode->i_mapping);
+	io_schedule();
+	return 0;
 }
 
 void fastcall __lock_buffer(struct buffer_head *bh)
 {
-	wait_queue_head_t *wqh = bh_waitq_head(bh);
-	DEFINE_WAIT_BIT(wait, &bh->b_state, BH_Lock);
-
-	do {
-		prepare_to_wait_exclusive(wqh, &wait.wait,
-					TASK_UNINTERRUPTIBLE);
-		if (buffer_locked(bh)) {
-			sync_buffer(bh);
-			io_schedule();
-		}
-	} while (test_set_buffer_locked(bh));
-	finish_wait(wqh, &wait.wait);
+	wait_on_bit_lock(&bh->b_state, BH_Lock, sync_buffer,
+							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(__lock_buffer);
 
@@ -118,15 +92,7 @@
  */
 void __wait_on_buffer(struct buffer_head * bh)
 {
-	wait_queue_head_t *wqh = bh_waitq_head(bh);
-	DEFINE_WAIT_BIT(wait, &bh->b_state, BH_Lock);
-
-	prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
-	if (buffer_locked(bh)) {
-		sync_buffer(bh);
-		io_schedule();
-	}
-	finish_wait(wqh, &wait.wait);
+	wait_on_bit(&bh->b_state, BH_Lock, sync_buffer, TASK_UNINTERRUPTIBLE);
 }
 
 static void
@@ -3096,14 +3062,11 @@
 
 void __init buffer_init(void)
 {
-	int i;
 	int nrpages;
 
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,
 			SLAB_PANIC, init_buffer_head, NULL);
-	for (i = 0; i < ARRAY_SIZE(bh_wait_queue_heads); i++)
-		init_waitqueue_head(&bh_wait_queue_heads[i].wqh);
 
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
Index: wait-2.6.9-rc1-mm1/kernel/wait.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/wait.c	2004-08-28 09:49:23.070340840 -0700
+++ wait-2.6.9-rc1-mm1/kernel/wait.c	2004-08-28 09:49:39.456849712 -0700
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/hash.h>
 
 void fastcall add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
@@ -187,3 +188,13 @@
 		__wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE, 1, &key);
 }
 EXPORT_SYMBOL(__wake_up_bit);
+
+wait_queue_head_t * fastcall bit_waitqueue(void *word, int bit)
+{
+	const int shift = BITS_PER_LONG == 32 ? 5 : 6;
+	const struct zone *zone = page_zone(virt_to_page(word));
+	unsigned long val = (unsigned long)word << shift | bit;
+
+	return &zone->wait_table[hash_long(val, zone->wait_table_bits)];
+}
+EXPORT_SYMBOL(bit_waitqueue);
Index: wait-2.6.9-rc1-mm1/fs/jbd/transaction.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/fs/jbd/transaction.c	2004-08-28 09:42:49.971101008 -0700
+++ wait-2.6.9-rc1-mm1/fs/jbd/transaction.c	2004-08-28 09:49:39.449850776 -0700
@@ -633,21 +633,21 @@
 		 * disk then we cannot do copy-out here. */
 
 		if (jh->b_jlist == BJ_Shadow) {
-			wait_queue_head_t *wqh;
-			DEFINE_WAIT(wait);
+			DEFINE_WAIT_BIT(wait, &bh->b_state, BH_Lock);
+			wait_queue_head_t *wqh
+					= bit_waitqueue(&bh->b_state, BH_Lock);
 
 			JBUFFER_TRACE(jh, "on shadow: sleep");
 			jbd_unlock_bh_state(bh);
 			/* commit wakes up all shadow buffers after IO */
-			wqh = bh_waitq_head(bh);
 			for ( ; ; ) {
-				prepare_to_wait(wqh, &wait,
+				prepare_to_wait(wqh, &wait.wait,
 						TASK_UNINTERRUPTIBLE);
 				if (jh->b_jlist != BJ_Shadow)
 					break;
 				schedule();
 			}
-			finish_wait(wqh, &wait);
+			finish_wait(wqh, &wait.wait);
 			goto repeat;
 		}
 
Index: wait-2.6.9-rc1-mm1/include/linux/wait.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/linux/wait.h	2004-08-28 09:49:23.059342512 -0700
+++ wait-2.6.9-rc1-mm1/include/linux/wait.h	2004-08-28 09:49:39.453850168 -0700
@@ -24,6 +24,7 @@
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <asm/system.h>
+#include <asm/current.h>
 
 typedef struct __wait_queue wait_queue_t;
 typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync, void *key);
@@ -141,6 +142,22 @@
 void FASTCALL(__wake_up_bit(wait_queue_head_t *, void *, int));
 int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
 int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
+wait_queue_head_t *FASTCALL(bit_waitqueue(void *, int));
+
+/**
+ * wake_up_bit - wake up a waiter on a bit
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ *
+ * There is a standard hashed waitqueue table for generic use. This
+ * is the part of the hashtable's accessor API that wakes up waiters
+ * on a bit. For instance, if one were to have waiters on a bitflag,
+ * one would call wake_up_bit() after clearing the bit.
+ */
+static inline void wake_up_bit(void *word, int bit)
+{
+	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
+}
 
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
@@ -321,6 +338,62 @@
 		wait->func = autoremove_wake_function;			\
 		INIT_LIST_HEAD(&wait->task_list);			\
 	} while (0)
+
+/**
+ * wait_on_bit - wait for a bit to be cleared
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ * @action: the function used to sleep, which may take special actions
+ * @mode: the task state to sleep in
+ *
+ * There is a standard hashed waitqueue table for generic use. This
+ * is the part of the hashtable's accessor API that waits on a bit.
+ * For instance, if one were to have waiters on a bitflag, one would
+ * call wait_on_bit() in threads waiting for the bit to clear.
+ * One uses wait_on_bit() where one is waiting for the bit to clear,
+ * but has no intention of setting it.
+ */
+static inline int wait_on_bit(void *word, int bit,
+				int (*action)(void *), unsigned mode)
+{
+	DEFINE_WAIT_BIT(q, word, bit);
+	wait_queue_head_t *wqh;
+
+	if (!test_bit(bit, word))
+		return 0;
+
+	wqh = bit_waitqueue(word, bit);
+	return __wait_on_bit(wqh, &q, word, bit, action, mode);
+}
+
+/**
+ * wait_on_bit_lock - wait for a bit to be cleared, when wanting to set it
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ * @action: the function used to sleep, which may take special actions
+ * @mode: the task state to sleep in
+ *
+ * There is a standard hashed waitqueue table for generic use. This
+ * is the part of the hashtable's accessor API that waits on a bit
+ * when one intends to set it, for instance, trying to lock bitflags.
+ * For instance, if one were to have waiters trying to set bitflag
+ * and waiting for it to clear before setting it, one would call
+ * wait_on_bit() in threads waiting to be able to set the bit.
+ * One uses wait_on_bit_lock() where one is waiting for the bit to
+ * clear with the intention of setting it, and when done, clearing it.
+ */
+static inline int wait_on_bit_lock(void *word, int bit,
+				int (*action)(void *), unsigned mode)
+{
+	DEFINE_WAIT_BIT(q, word, bit);
+	wait_queue_head_t *wqh;
+
+	if (!test_bit(bit, word))
+		return 0;
+
+	wqh = bit_waitqueue(word, bit);
+	return __wait_on_bit_lock(wqh, &q, word, bit, action, mode);
+}
 	
 #endif /* __KERNEL__ */
 
