Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUGBNIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUGBNIj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUGBNIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:08:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12686 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264502AbUGBNH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:07:29 -0400
Date: Fri, 2 Jul 2004 18:46:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 5/22] AIO wait on page support
Message-ID: <20040702131655.GE4374@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).
> 
> Full retry infrastructure and fixes
> [1] aio-retry.patch
> [2] 4g4g-aio-hang-fix.patch
> [3] aio-retry-elevated-refcount.patch
> [4] aio-splice-runlist.patch
> 
> FS AIO read
> [5] aio-wait-page.patch

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
-----------------------------------

From: Suparna Bhattacharya <suparna@in.ibm.com>

Async wait on page support. Implements async versions of lock_page,
wait_on_page_locked, and wait_on_page_writeback which accept a 
wait queue entry as a parameter, and where blocking waits 
converted into retry exits if the wait queue entry specifies
an async callback for AIO.


 include/linux/pagemap.h |   38 ++++++++++++++----
 mm/filemap.c            |  100 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 105 insertions(+), 33 deletions(-)

--- aio/include/linux/pagemap.h	2004-06-17 14:12:37.170571824 -0700
+++ aio-wait-page/include/linux/pagemap.h	2004-06-17 14:10:41.974084352 -0700
@@ -150,17 +150,27 @@ static inline pgoff_t linear_page_index(
 extern void FASTCALL(__lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
-static inline void lock_page(struct page *page)
+
+extern int FASTCALL(__lock_page_wq(struct page *page, wait_queue_t *wait));
+static inline int lock_page_wq(struct page *page, wait_queue_t *wait)
 {
 	if (TestSetPageLocked(page))
-		__lock_page(page);
+		return __lock_page_wq(page, wait);
+	else
+		return 0;
+}
+
+static inline void lock_page(struct page *page)
+{
+	lock_page_wq(page, NULL);
 }
 	
 /*
  * This is exported only for wait_on_page_locked/wait_on_page_writeback.
  * Never use this directly!
  */
-extern void FASTCALL(wait_on_page_bit(struct page *page, int bit_nr));
+extern int FASTCALL(wait_on_page_bit_wq(struct page *page, int bit_nr,
+	wait_queue_t *wait));
 
 /* 
  * Wait for a page to be unlocked.
@@ -169,19 +179,33 @@ extern void FASTCALL(wait_on_page_bit(st
  * ie with increased "page->count" so that the page won't
  * go away during the wait..
  */
-static inline void wait_on_page_locked(struct page *page)
+static inline int wait_on_page_locked_wq(struct page *page, wait_queue_t *wait)
 {
 	if (PageLocked(page))
-		wait_on_page_bit(page, PG_locked);
+		return wait_on_page_bit_wq(page, PG_locked, wait);
+	return 0;
+}
+
+static inline int wait_on_page_writeback_wq(struct page *page,
+						wait_queue_t *wait)
+{
+	if (PageWriteback(page))
+		return wait_on_page_bit_wq(page, PG_writeback, wait);
+	return 0;
+}
+
+static inline void wait_on_page_locked(struct page *page)
+{
+	wait_on_page_locked_wq(page, NULL);
 }
 
 /* 
  * Wait for a page to complete writeback
  */
+
 static inline void wait_on_page_writeback(struct page *page)
 {
-	if (PageWriteback(page))
-		wait_on_page_bit(page, PG_writeback);
+	wait_on_page_writeback_wq(page, NULL);
 }
 
 extern void end_page_writeback(struct page *page);
--- aio/mm/filemap.c	2004-06-17 14:11:57.420614736 -0700
+++ aio-wait-page/mm/filemap.c	2004-06-17 14:02:17.137831128 -0700
@@ -340,22 +340,43 @@ static void wake_up_page(struct page *pa
 		__wake_up(waitqueue, mode, 1, page);
 }
 
-void fastcall wait_on_page_bit(struct page *page, int bit_nr)
+/*
+ * wait for the specified page bit to be cleared
+ * this could be a synchronous wait or could just queue an async
+ * notification callback depending on the wait queue entry parameter
+ *
+ * A NULL wait queue parameter defaults to sync behaviour
+ */
+int fastcall wait_on_page_bit_wq(struct page *page, int bit_nr, wait_queue_t *wait)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	DEFINE_PAGE_WAIT(wait, page, bit_nr);
+	DEFINE_PAGE_WAIT(local_wait, page, bit_nr);
 
-	do {
-		prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
-		if (test_bit(bit_nr, &page->flags)) {
-			sync_page(page);
-			io_schedule();
-		}
-	} while (test_bit(bit_nr, &page->flags));
-	finish_wait(waitqueue, &wait.wait);
+	if (!wait)
+		wait = &local_wait.wait; /* default to a sync wait entry */
+ 
+ 	do {
+		prepare_to_wait(waitqueue, wait, TASK_UNINTERRUPTIBLE);
+ 		if (test_bit(bit_nr, &page->flags)) {
+ 			sync_page(page);
+			if (!is_sync_wait(wait)) {
+				/*
+				 * if we've queued an async wait queue
+				 * callback do not block; just tell the
+				 * caller to return and retry later when
+				 * the callback is notified
+				 */
+				return -EIOCBRETRY;
+			}
+ 			io_schedule();
+ 		}
+ 	} while (test_bit(bit_nr, &page->flags));
+	finish_wait(waitqueue, wait);
+ 
+	return 0;
 }
-
-EXPORT_SYMBOL(wait_on_page_bit);
+EXPORT_SYMBOL(wait_on_page_bit_wq);
+ 
 
 /**
  * unlock_page() - unlock a locked page
@@ -365,8 +386,9 @@ EXPORT_SYMBOL(wait_on_page_bit);
  * Unlocks the page and wakes up sleepers in ___wait_on_page_locked().
  * Also wakes sleepers in wait_on_page_writeback() because the wakeup
  * mechananism between PageLocked pages and PageWriteback pages is shared.
- * But that's OK - sleepers in wait_on_page_writeback() just go back to sleep.
- *
+ * But that's OK - sleepers in wait_on_page_writeback() just go back to sleep,
+ * or in case the wakeup notifies async wait queue entries, as in the case
+ * of aio, retries would be triggered and may re-queue their callbacks.
  * The first mb is necessary to safely close the critical section opened by the
  * TestSetPageLocked(), the second mb is necessary to enforce ordering between
  * the clear_bit and the read of the waitqueue (to avoid SMP races with a
@@ -399,29 +421,55 @@ void end_page_writeback(struct page *pag
 
 EXPORT_SYMBOL(end_page_writeback);
 
+ 
 /*
- * Get a lock on the page, assuming we need to sleep to get it.
+ * Get a lock on the page, assuming we need to either sleep to get it
+ * or to queue an async notification callback to try again when its
+ * available.
+ *
+ * A NULL wait queue parameter defaults to sync behaviour. Otherwise
+ * it specifies the wait queue entry to be used for async notification
+ * or waiting.
  *
  * Ugly: running sync_page() in state TASK_UNINTERRUPTIBLE is scary.  If some
  * random driver's requestfn sets TASK_RUNNING, we could busywait.  However
  * chances are that on the second loop, the block layer's plug list is empty,
  * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
-void fastcall __lock_page(struct page *page)
+int fastcall __lock_page_wq(struct page *page, wait_queue_t *wait)
 {
-	wait_queue_head_t *wqh = page_waitqueue(page);
-	DEFINE_PAGE_WAIT_EXCLUSIVE(wait, page, PG_locked);
+ 	wait_queue_head_t *wqh = page_waitqueue(page);
+	DEFINE_PAGE_WAIT_EXCLUSIVE(local_wait, page, PG_locked);
 
-	while (TestSetPageLocked(page)) {
-		prepare_to_wait_exclusive(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
-		if (PageLocked(page)) {
-			sync_page(page);
-			io_schedule();
-		}
-	}
-	finish_wait(wqh, &wait.wait);
+	if (!wait)
+		wait = &local_wait.wait;
+ 
+ 	while (TestSetPageLocked(page)) {
+		prepare_to_wait_exclusive(wqh, wait, TASK_UNINTERRUPTIBLE);
+ 		if (PageLocked(page)) {
+ 			sync_page(page);
+			if (!is_sync_wait(wait)) {
+				/*
+				 * if we've queued an async wait queue
+				 * callback do not block; just tell the
+				 * caller to return and retry later when
+				 * the callback is notified
+				 */
+				return -EIOCBRETRY;
+			}
+ 			io_schedule();
+ 		}
+ 	}
+	finish_wait(wqh, wait);
+	return 0;
 }
+EXPORT_SYMBOL(__lock_page_wq);
 
+void fastcall __lock_page(struct page *page)
+{
+	__lock_page_wq(page, NULL);
+}
+ 
 EXPORT_SYMBOL(__lock_page);
 
 /*
