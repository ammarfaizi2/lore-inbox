Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262142AbSIZECy>; Thu, 26 Sep 2002 00:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262156AbSIZECy>; Thu, 26 Sep 2002 00:02:54 -0400
Received: from packet.digeo.com ([12.110.80.53]:37336 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262142AbSIZECs>;
	Thu, 26 Sep 2002 00:02:48 -0400
Message-ID: <3D92881E.E047A58F@digeo.com>
Date: Wed, 25 Sep 2002 21:07:58 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/4] use prepare_to_wait in VM/VFS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 04:07:58.0419 (UTC) FILETIME=[4C541230:01C26512]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The patch uses the new wakeup machinery in some hot parts of the VFS
and block layers.

wait_on_buffer(), wait_on_page(), lock_page(), blk_congestion_wait().
Also in get_request_wait(), although the benefit for exclusive wakeups
will be lower.



 drivers/block/ll_rw_blk.c |   17 +++++---------
 fs/buffer.c               |   16 +++++--------
 include/linux/pagemap.h   |    8 +++++-
 mm/filemap.c              |   55 ++++++++++++++++------------------------------
 4 files changed, 40 insertions(+), 56 deletions(-)

--- 2.5.38/drivers/block/ll_rw_blk.c~vm-wakeups	Sun Sep 22 21:01:45 2002
+++ 2.5.38-akpm/drivers/block/ll_rw_blk.c	Sun Sep 22 21:01:45 2002
@@ -1233,24 +1233,23 @@ static struct request *get_request(reque
  */
 static struct request *get_request_wait(request_queue_t *q, int rw)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	DEFINE_WAIT(wait);
 	struct request_list *rl = &q->rq[rw];
 	struct request *rq;
 
 	spin_lock_prefetch(q->queue_lock);
 
 	generic_unplug_device(q);
-	add_wait_queue_exclusive(&rl->wait, &wait);
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		prepare_to_wait_exclusive(&rl->wait, &wait,
+					TASK_UNINTERRUPTIBLE);
 		if (!rl->count)
 			schedule();
+		finish_wait(&rl->wait, &wait);
 		spin_lock_irq(q->queue_lock);
 		rq = get_request(q, rw);
 		spin_unlock_irq(q->queue_lock);
 	} while (rq == NULL);
-	remove_wait_queue(&rl->wait, &wait);
-	current->state = TASK_RUNNING;
 	return rq;
 }
 
@@ -1460,18 +1459,16 @@ void blk_put_request(struct request *req
  */
 void blk_congestion_wait(int rw, long timeout)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	DEFINE_WAIT(wait);
 	struct congestion_state *cs = &congestion_states[rw];
 
 	if (atomic_read(&cs->nr_congested_queues) == 0)
 		return;
 	blk_run_queues();
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	add_wait_queue(&cs->wqh, &wait);
+	prepare_to_wait(&cs->wqh, &wait, TASK_UNINTERRUPTIBLE);
 	if (atomic_read(&cs->nr_congested_queues) != 0)
 		schedule_timeout(timeout);
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&cs->wqh, &wait);
+	finish_wait(&cs->wqh, &wait);
 }
 
 /*
--- 2.5.38/fs/buffer.c~vm-wakeups	Sun Sep 22 21:01:45 2002
+++ 2.5.38-akpm/fs/buffer.c	Sun Sep 22 21:01:45 2002
@@ -128,22 +128,18 @@ void unlock_buffer(struct buffer_head *b
  */
 void __wait_on_buffer(struct buffer_head * bh)
 {
-	wait_queue_head_t *wq = bh_waitq_head(bh);
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	wait_queue_head_t *wqh = bh_waitq_head(bh);
+	DEFINE_WAIT(wait);
 
 	get_bh(bh);
-	add_wait_queue(wq, &wait);
 	do {
+		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 		blk_run_queues();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!buffer_locked(bh))
-			break;
-		schedule();
+		if (buffer_locked(bh))
+			schedule();
 	} while (buffer_locked(bh));
-	tsk->state = TASK_RUNNING;
-	remove_wait_queue(wq, &wait);
 	put_bh(bh);
+	finish_wait(wqh, &wait);
 }
 
 static inline void
--- 2.5.38/mm/filemap.c~vm-wakeups	Sun Sep 22 21:01:45 2002
+++ 2.5.38-akpm/mm/filemap.c	Sun Sep 22 21:01:45 2002
@@ -632,19 +632,15 @@ static inline wait_queue_head_t *page_wa
 void wait_on_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	DEFINE_WAIT(wait);
 
-	add_wait_queue(waitqueue, &wait);
 	do {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!test_bit(bit_nr, &page->flags))
-			break;
+		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
 		sync_page(page);
-		schedule();
+		if (test_bit(bit_nr, &page->flags))
+			schedule();
 	} while (test_bit(bit_nr, &page->flags));
-	__set_task_state(tsk, TASK_RUNNING);
-	remove_wait_queue(waitqueue, &wait);
+	finish_wait(waitqueue, &wait);
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
@@ -690,38 +686,27 @@ void end_page_writeback(struct page *pag
 EXPORT_SYMBOL(end_page_writeback);
 
 /*
- * Get a lock on the page, assuming we need to sleep
- * to get it..
+ * Get a lock on the page, assuming we need to sleep to get it.
+ *
+ * Ugly: running sync_page() in state TASK_UNINTERRUPTIBLE is scary.  If some
+ * random driver's requestfn sets TASK_RUNNING, we could busywait.  However
+ * chances are that on the second loop, the block layer's plug list is empty,
+ * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
-static void __lock_page(struct page *page)
+void __lock_page(struct page *page)
 {
-	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	wait_queue_head_t *wqh = page_waitqueue(page);
+	DEFINE_WAIT(wait);
 
-	add_wait_queue_exclusive(waitqueue, &wait);
-	for (;;) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (PageLocked(page)) {
-			sync_page(page);
+	while (TestSetPageLocked(page)) {
+		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		sync_page(page);
+		if (PageLocked(page))
 			schedule();
-		}
-		if (!TestSetPageLocked(page))
-			break;
 	}
-	__set_task_state(tsk, TASK_RUNNING);
-	remove_wait_queue(waitqueue, &wait);
-}
-
-/*
- * Get an exclusive lock on the page, optimistically
- * assuming it's not locked..
- */
-void lock_page(struct page *page)
-{
-	if (TestSetPageLocked(page))
-		__lock_page(page);
+	finish_wait(wqh, &wait);
 }
+EXPORT_SYMBOL(__lock_page);
 
 /*
  * a rather lightweight function, finding and getting a reference to a
--- 2.5.38/include/linux/pagemap.h~vm-wakeups	Sun Sep 22 21:01:45 2002
+++ 2.5.38-akpm/include/linux/pagemap.h	Sun Sep 22 21:01:45 2002
@@ -74,9 +74,15 @@ static inline void ___add_to_page_cache(
 	inc_page_state(nr_pagecache);
 }
 
-extern void FASTCALL(lock_page(struct page *page));
+extern void FASTCALL(__lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
+static inline void lock_page(struct page *page)
+{
+	if (TestSetPageLocked(page))
+		__lock_page(page);
+}
+	
 /*
  * This is exported only for wait_on_page_locked/wait_on_page_writeback.
  * Never use this directly!

.
