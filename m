Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUH1JYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUH1JYv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUH1JYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:24:51 -0400
Received: from holomorphy.com ([207.189.100.168]:26789 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266810AbUH1JWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:22:20 -0400
Date: Sat, 28 Aug 2004 02:22:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: [2/4] consolidate bit waiting code patterns
Message-ID: <20040828092210.GJ5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, oleg@tv-sign.ru,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com> <20040827231713.212245c5.akpm@osdl.org> <20040828063419.GA5492@holomorphy.com> <20040827234033.2b6e1525.akpm@osdl.org> <20040828064829.GB5492@holomorphy.com> <20040828092040.GH5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828092040.GH5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:20:40AM -0700, William Lee Irwin III wrote:
> I didn't see very many apologies in x86-64 so I wasn't entirely sure
> what those would consist of; void * and some minor commentary added.
> Let me know if there's something more specific I should add comments
> about.


Consolidate bit waiting code patterns for page waitqueues using
__wait_on_bit() and __wait_on_bit_lock().


Index: mm1-2.6.9-rc1/kernel/fork.c
===================================================================
--- mm1-2.6.9-rc1.orig/kernel/fork.c	2004-08-28 01:20:04.105925320 -0700
+++ mm1-2.6.9-rc1/kernel/fork.c	2004-08-28 01:23:00.542102944 -0700
@@ -250,6 +250,40 @@
 }
 EXPORT_SYMBOL(__wake_up_bit);
 
+int __sched __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
+			void *word,
+			int bit, int (*wait)(void *), unsigned mode)
+{
+	int ret;
+
+	prepare_to_wait(wq, &q->wait, mode);
+	if (test_bit(bit, word)) {
+		if ((ret = (*wait)(word)))
+			return ret;
+	}
+	finish_wait(wq, &q->wait);
+	return 0;
+}
+EXPORT_SYMBOL(__wait_on_bit);
+
+int __sched __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
+			void *word, int bit,
+			int (*wait)(void *), unsigned mode)
+{
+	int ret;
+
+	while (test_and_set_bit(bit, word)) {
+		prepare_to_wait_exclusive(wq, &q->wait, mode);
+		if (test_bit(bit, word)) {
+			if ((ret = (*wait)(word)))
+				return ret;
+		}
+	}
+	finish_wait(wq, &q->wait);
+	return 0;
+}
+EXPORT_SYMBOL(__wait_on_bit_lock);
+
 void __init fork_init(unsigned long mempages)
 {
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
Index: mm1-2.6.9-rc1/mm/filemap.c
===================================================================
--- mm1-2.6.9-rc1.orig/mm/filemap.c	2004-08-28 01:19:28.658314176 -0700
+++ mm1-2.6.9-rc1/mm/filemap.c	2004-08-28 01:23:00.551101576 -0700
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
 
@@ -362,19 +365,18 @@
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
+	__wait_on_bit(page_waitqueue(page), &wait, wait.key.flags,
+				bit_nr, sync_page, TASK_UNINTERRUPTIBLE);
 }
-
 EXPORT_SYMBOL(wait_on_page_bit);
 
 /**
@@ -398,7 +400,7 @@
 	if (!TestClearPageLocked(page))
 		BUG();
 	smp_mb__after_clear_bit(); 
-	__wake_up_bit(page_waitqueue(page), &page->flags, PG_locked);
+	wake_up_page(page, PG_locked);
 }
 
 EXPORT_SYMBOL(unlock_page);
@@ -414,7 +416,7 @@
 			BUG();
 		smp_mb__after_clear_bit();
 	}
-	__wake_up_bit(page_waitqueue(page), &page->flags, PG_writeback);
+	wake_up_page(page, PG_writeback);
 }
 
 EXPORT_SYMBOL(end_page_writeback);
@@ -429,19 +431,11 @@
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
Index: mm1-2.6.9-rc1/include/linux/wait.h
===================================================================
--- mm1-2.6.9-rc1.orig/include/linux/wait.h	2004-08-27 23:51:01.407138992 -0700
+++ mm1-2.6.9-rc1/include/linux/wait.h	2004-08-28 01:23:00.554101120 -0700
@@ -139,6 +139,8 @@
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
 void FASTCALL(__wake_up_bit(wait_queue_head_t *, void *, int));
+int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
+int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
 
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
