Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUH1UQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUH1UQp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUH1UMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:12:30 -0400
Received: from holomorphy.com ([207.189.100.168]:1449 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267801AbUH1UJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:09:53 -0400
Date: Sat, 28 Aug 2004 13:09:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [3/5] consolidate bit waiting code patterns
Message-ID: <20040828200951.GU5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040828200549.GR5492@holomorphy.com> <20040828200659.GS5492@holomorphy.com> <20040828200841.GT5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828200841.GT5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 01:08:41PM -0700, William Lee Irwin III wrote:
> Eliminate specialized page and bh waitqueue hashing structures in favor
> of a standardized structure, using wake_up_bit() to wake waiters using
> the standardized wait_bit_key structure.

Consolidate bit waiting code patterns for page waitqueues using
__wait_on_bit() and __wait_on_bit_lock().

Index: wait-2.6.9-rc1-mm1/kernel/wait.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/wait.c	2004-08-28 09:48:39.109023976 -0700
+++ wait-2.6.9-rc1-mm1/kernel/wait.c	2004-08-28 09:49:23.070340840 -0700
@@ -143,6 +143,43 @@
 }
 EXPORT_SYMBOL(wake_bit_function);
 
+/*
+ * To allow interruptible waiting and asynchronous (i.e. nonblocking)
+ * waiting, the actions of __wait_on_bit() and __wait_on_bit_lock() are
+ * permitted return codes. Nonzero return codes halt waiting and return.
+ */
+int __sched __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
+			void *word,
+			int bit, int (*action)(void *), unsigned mode)
+{
+	int ret = 0;
+
+	prepare_to_wait(wq, &q->wait, mode);
+	if (test_bit(bit, word))
+		ret = (*action)(word);
+	finish_wait(wq, &q->wait);
+	return ret;
+}
+EXPORT_SYMBOL(__wait_on_bit);
+
+int __sched __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
+			void *word, int bit,
+			int (*action)(void *), unsigned mode)
+{
+	int ret = 0;
+
+	while (test_and_set_bit(bit, word)) {
+		prepare_to_wait_exclusive(wq, &q->wait, mode);
+		if (test_bit(bit, word)) {
+			if ((ret = (*action)(word)))
+				break;
+		}
+	}
+	finish_wait(wq, &q->wait);
+	return ret;
+}
+EXPORT_SYMBOL(__wait_on_bit_lock);
+
 void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
 {
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
Index: wait-2.6.9-rc1-mm1/mm/filemap.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/mm/filemap.c	2004-08-28 09:48:39.118022608 -0700
+++ wait-2.6.9-rc1-mm1/mm/filemap.c	2004-08-28 09:49:23.068341144 -0700
@@ -132,9 +132,11 @@
 }
 EXPORT_SYMBOL(remove_from_page_cache);
 
-static inline int sync_page(struct page *page)
+static int sync_page(void *word)
 {
 	struct address_space *mapping;
+	struct page *page
+		= container_of((page_flags_t *)word, struct page, flags);
 
 	/*
 	 * FIXME, fercrissake.  What is this barrier here for?
@@ -142,7 +144,8 @@
 	smp_mb();
 	mapping = page_mapping(page);
 	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
-		return mapping->a_ops->sync_page(page);
+		mapping->a_ops->sync_page(page);
+	io_schedule();
 	return 0;
 }
 
@@ -362,19 +365,19 @@
 	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
 
+static inline void wake_up_page(struct page *page, int bit)
+{
+	__wake_up_bit(page_waitqueue(page), &page->flags, bit);
+}
+
 void fastcall wait_on_page_bit(struct page *page, int bit_nr)
 {
-	wait_queue_head_t *waitqueue = page_waitqueue(page);
 	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
 
-	prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
-	if (test_bit(bit_nr, &page->flags)) {
-		sync_page(page);
-		io_schedule();
-	}
-	finish_wait(waitqueue, &wait.wait);
+	if (test_bit(bit_nr, &page->flags))
+		__wait_on_bit(page_waitqueue(page), &wait, wait.key.flags,
+				bit_nr, sync_page, TASK_UNINTERRUPTIBLE);
 }
-
 EXPORT_SYMBOL(wait_on_page_bit);
 
 /**
@@ -398,7 +401,7 @@
 	if (!TestClearPageLocked(page))
 		BUG();
 	smp_mb__after_clear_bit(); 
-	__wake_up_bit(page_waitqueue(page), &page->flags, PG_locked);
+	wake_up_page(page, PG_locked);
 }
 
 EXPORT_SYMBOL(unlock_page);
@@ -414,7 +417,7 @@
 			BUG();
 		smp_mb__after_clear_bit();
 	}
-	__wake_up_bit(page_waitqueue(page), &page->flags, PG_writeback);
+	wake_up_page(page, PG_writeback);
 }
 
 EXPORT_SYMBOL(end_page_writeback);
@@ -429,19 +432,11 @@
  */
 void fastcall __lock_page(struct page *page)
 {
-	wait_queue_head_t *wqh = page_waitqueue(page);
 	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
 
-	while (TestSetPageLocked(page)) {
-		prepare_to_wait_exclusive(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
-		if (PageLocked(page)) {
-			sync_page(page);
-			io_schedule();
-		}
-	}
-	finish_wait(wqh, &wait.wait);
+	__wait_on_bit_lock(page_waitqueue(page), &wait, wait.key.flags,
+				PG_locked, sync_page, TASK_UNINTERRUPTIBLE);
 }
-
 EXPORT_SYMBOL(__lock_page);
 
 /*
Index: wait-2.6.9-rc1-mm1/include/linux/wait.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/linux/wait.h	2004-08-28 09:48:39.121022152 -0700
+++ wait-2.6.9-rc1-mm1/include/linux/wait.h	2004-08-28 09:49:23.059342512 -0700
@@ -139,6 +139,8 @@
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
 void FASTCALL(__wake_up_bit(wait_queue_head_t *, void *, int));
+int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
+int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
 
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
