Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264632AbUEJLYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbUEJLYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEJLYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:24:34 -0400
Received: from niit.caravan.ru ([217.23.131.158]:35856 "EHLO mail.tv-sign.ru")
	by vger.kernel.org with ESMTP id S264632AbUEJLXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:23:30 -0400
Message-ID: <409F668A.CEFD60F6@tv-sign.ru>
Date: Mon, 10 May 2004 15:24:58 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] WAIT_BIT_QUEUE
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

a better (imho) alternative to filtered wakeups.
see http://marc.theaimsgroup.com/?l=linux-kernel&m=108375670411475&w=2

process waiting in wait_on_page_bit() will be woken only after
the required bit is cleared.

so there is no need to recheck the bit in do/while loop, because
there is no false wakeups now.

yes, when process gets cpu, the page can be locked again, it's ok.

Oleg.

diff -urp 6.6-clean/fs/buffer.c 6.6-waitb/fs/buffer.c
--- 6.6-clean/fs/buffer.c	2004-05-10 12:50:53.000000000 +0400
+++ 6.6-waitb/fs/buffer.c	2004-05-10 14:13:40.000000000 +0400
@@ -93,20 +93,20 @@ void fastcall unlock_buffer(struct buffe
 void __wait_on_buffer(struct buffer_head * bh)
 {
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT_BIT(wait, &bh->b_state, BH_Lock);
 
-	do {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-		if (buffer_locked(bh)) {
-			struct block_device *bd;
-			smp_mb();
-			bd = bh->b_bdev;
-			if (bd)
-				blk_run_address_space(bd->bd_inode->i_mapping);
-			io_schedule();
-		}
-	} while (buffer_locked(bh));
-	finish_wait(wqh, &wait);
+	prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
+
+	if (buffer_locked(bh)) {
+		struct block_device *bd;
+		smp_mb();
+		bd = bh->b_bdev;
+		if (bd)
+			blk_run_address_space(bd->bd_inode->i_mapping);
+		io_schedule();
+	}
+
+	finish_wait(wqh, &wait.wait);
 }
 
 static void
diff -urp 6.6-clean/include/linux/wait.h 6.6-waitb/include/linux/wait.h
--- 6.6-clean/include/linux/wait.h	2004-03-11 05:55:28.000000000 +0300
+++ 6.6-waitb/include/linux/wait.h	2004-05-10 14:14:17.000000000 +0400
@@ -257,7 +257,27 @@ int autoremove_wake_function(wait_queue_
 		wait->func = autoremove_wake_function;			\
 		INIT_LIST_HEAD(&wait->task_list);			\
 	} while (0)
-	
+
+
+struct wait_bit_queue {
+	unsigned long *flags;
+	int bit_nr;
+	wait_queue_t wait;
+};
+
+#define DEFINE_WAIT_BIT(name, _flags, _bit_nr)					\
+	struct wait_bit_queue name = {						\
+		.flags	= _flags,						\
+		.bit_nr	= _bit_nr,						\
+		.wait	= {							\
+			.task = current,					\
+			.func = wake_bit_function,				\
+			.task_list = LIST_HEAD_INIT(name.wait.task_list),	\
+		},								\
+	}
+
+int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync);
+
 #endif /* __KERNEL__ */
 
 #endif
diff -urp 6.6-clean/kernel/fork.c 6.6-waitb/kernel/fork.c
--- 6.6-clean/kernel/fork.c	2004-05-10 12:50:59.000000000 +0400
+++ 6.6-waitb/kernel/fork.c	2004-05-10 14:14:08.000000000 +0400
@@ -207,6 +207,17 @@ int autoremove_wake_function(wait_queue_
 
 EXPORT_SYMBOL(autoremove_wake_function);
 
+int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync)
+{
+	struct wait_bit_queue *wait_bit =
+		container_of(wait, struct wait_bit_queue, wait);
+
+	if (test_bit(wait_bit->bit_nr, wait_bit->flags))
+		return 0;
+
+	return autoremove_wake_function(wait, mode, sync);
+}
+
 void __init fork_init(unsigned long mempages)
 {
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
diff -urp 6.6-clean/mm/filemap.c 6.6-waitb/mm/filemap.c
--- 6.6-clean/mm/filemap.c	2004-05-10 12:50:59.000000000 +0400
+++ 6.6-waitb/mm/filemap.c	2004-05-10 14:13:52.000000000 +0400
@@ -301,16 +301,16 @@ static wait_queue_head_t *page_waitqueue
 void fastcall wait_on_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
 
-	do {
-		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
-		if (test_bit(bit_nr, &page->flags)) {
-			sync_page(page);
-			io_schedule();
-		}
-	} while (test_bit(bit_nr, &page->flags));
-	finish_wait(waitqueue, &wait);
+	prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
+
+	if (test_bit(bit_nr, &page->flags)) {
+		sync_page(page);
+		io_schedule();
+	}
+
+	finish_wait(waitqueue, &wait.wait);
 }
 
 EXPORT_SYMBOL(wait_on_page_bit);
@@ -372,17 +372,8 @@ EXPORT_SYMBOL(end_page_writeback);
  */
 void fastcall __lock_page(struct page *page)
 {
-	wait_queue_head_t *wqh = page_waitqueue(page);
-	DEFINE_WAIT(wait);
-
-	while (TestSetPageLocked(page)) {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-		if (PageLocked(page)) {
-			sync_page(page);
-			io_schedule();
-		}
-	}
-	finish_wait(wqh, &wait);
+	while (TestSetPageLocked(page))
+		wait_on_page_bit(page, PG_locked);
 }
 
 EXPORT_SYMBOL(__lock_page);
