Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266806AbUH1FiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266806AbUH1FiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 01:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268182AbUH1FiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 01:38:09 -0400
Received: from holomorphy.com ([207.189.100.168]:15780 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266806AbUH1Fhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 01:37:33 -0400
Date: Fri, 27 Aug 2004 22:37:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org
Subject: [3/4] eliminate bh waitqueue hashtable
Message-ID: <20040828053726.GD2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com> <20040828053557.GC2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828053557.GC2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:35:57PM -0700, William Lee Irwin III wrote:
> Consolidate bit waiting code patterns for page waitqueues using
> __wait_on_bit() and __wait_on_bit_lock().

Eliminate the bh waitqueue hashtable using bit_waitqueue() via
wait_on_bit() and wake_up_bit() to locate the waitqueue head associated
with a bit.

Index: mm1-2.6.9-rc1/fs/buffer.c
===================================================================
--- mm1-2.6.9-rc1.orig/fs/buffer.c	2004-08-27 22:02:17.837872264 -0700
+++ mm1-2.6.9-rc1/fs/buffer.c	2004-08-27 22:15:39.524997296 -0700
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
+static int sync_buffer(unsigned long *word)
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
Index: mm1-2.6.9-rc1/fs/jbd/transaction.c
===================================================================
--- mm1-2.6.9-rc1.orig/fs/jbd/transaction.c	2004-08-26 15:03:31.000000000 -0700
+++ mm1-2.6.9-rc1/fs/jbd/transaction.c	2004-08-27 22:15:39.532996080 -0700
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
 
Index: mm1-2.6.9-rc1/kernel/fork.c
===================================================================
--- mm1-2.6.9-rc1.orig/kernel/fork.c	2004-08-27 22:15:35.543602560 -0700
+++ mm1-2.6.9-rc1/kernel/fork.c	2004-08-27 22:15:39.537995320 -0700
@@ -40,6 +40,7 @@
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
+#include <linux/hash.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -242,6 +243,16 @@
 }
 EXPORT_SYMBOL(wake_bit_function);
 
+wait_queue_head_t * fastcall bit_waitqueue(unsigned long *word, int bit)
+{
+	const int shift = BITS_PER_LONG == 32 ? 5 : 6;
+	const struct zone *zone = page_zone(virt_to_page(word));
+	unsigned long val = (unsigned long)word << shift | bit;
+
+	return &zone->wait_table[hash_long(val, zone->wait_table_bits)];
+}
+EXPORT_SYMBOL(bit_waitqueue);
+
 void fastcall __wake_up_bit(wait_queue_head_t *wq, unsigned long *word, int bit)
 {
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
Index: mm1-2.6.9-rc1/include/linux/wait.h
===================================================================
--- mm1-2.6.9-rc1.orig/include/linux/wait.h	2004-08-27 22:15:35.554600888 -0700
+++ mm1-2.6.9-rc1/include/linux/wait.h	2004-08-27 22:15:39.540994864 -0700
@@ -24,6 +24,7 @@
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <asm/system.h>
+#include <asm/current.h>
 
 typedef struct __wait_queue wait_queue_t;
 typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync, void *key);
@@ -141,6 +142,12 @@
 void FASTCALL(__wake_up_bit(wait_queue_head_t *, unsigned long *, int));
 int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, unsigned long *, int, int (*)(unsigned long *), unsigned));
 int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, unsigned long *, int, int (*)(unsigned long *), unsigned));
+wait_queue_head_t *FASTCALL(bit_waitqueue(unsigned long *, int));
+
+static inline void wake_up_bit(unsigned long *word, int bit)
+{
+	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
+}
 
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
@@ -321,6 +328,24 @@
 		wait->func = autoremove_wake_function;			\
 		INIT_LIST_HEAD(&wait->task_list);			\
 	} while (0)
+
+static inline int wait_on_bit(unsigned long *word, int bit,
+				int (*wait)(unsigned long *), unsigned mode)
+{
+	DEFINE_WAIT_BIT(q, word, bit);
+	wait_queue_head_t *wqh = bit_waitqueue(word, bit);
+
+	return __wait_on_bit(wqh, &q, word, bit, wait, mode);
+}
+
+static inline int wait_on_bit_lock(unsigned long *word, int bit,
+				int (*wait)(unsigned long *), unsigned mode)
+{
+	DEFINE_WAIT_BIT(q, word, bit);
+	wait_queue_head_t *wqh = bit_waitqueue(word, bit);
+
+	return __wait_on_bit_lock(wqh, &q, word, bit, wait, mode);
+}
 	
 #endif /* __KERNEL__ */
 
