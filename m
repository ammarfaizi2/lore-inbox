Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbUKCJZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUKCJZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbUKCJZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:25:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:6045 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261545AbUKCJWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:22:34 -0500
Date: Wed, 3 Nov 2004 15:02:12 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: Re: [PATCH 6/6] AIO wait page and AIO lock page
Message-ID: <20041103093212.GA6093@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041103091036.GA4041@in.ibm.com> <20041103092300.GF5737@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103092300.GF5737@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [6] aio-wait-page.patch

Sorry, forgot to regenerate this one against 2.6.10-rc1.

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

--------------------------------------------


Define low-level page wait and lock page routines which take a
wait queue entry pointer as an additional parameter and
return status (which may be non-zero when the wait queue
parameter signifies an asynchronous wait, typically during
AIO).

Synchronous IO waits become a special case where the wait
queue parameter is the running task's default io wait context.
Asynchronous IO waits happen when the wait queue parameter
is the io wait context of a kiocb. Code paths which choose to
execute synchronous or asynchronous behaviour depending on the
called context specify the current io wait context (which points
to sync or async context as the case may be) as the wait
parameter. 

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>


 linux-2.6.10-rc1-suparna/include/linux/pagemap.h |   29 ++++++++++++++++-------
 linux-2.6.10-rc1-suparna/kernel/sched.c          |   14 +++++++++++
 linux-2.6.10-rc1-suparna/mm/filemap.c            |   28 ++++++++++++----------
 3 files changed, 51 insertions(+), 20 deletions(-)

diff -puN include/linux/pagemap.h~aio-wait-page include/linux/pagemap.h
--- linux-2.6.10-rc1/include/linux/pagemap.h~aio-wait-page	2004-11-03 14:58:42.000000000 +0530
+++ linux-2.6.10-rc1-suparna/include/linux/pagemap.h	2004-11-03 14:58:42.000000000 +0530
@@ -151,21 +151,25 @@ static inline pgoff_t linear_page_index(
 	return pgoff >> (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 }
 
-extern void FASTCALL(lock_page_slow(struct page *page));
+extern int FASTCALL(lock_page_slow(struct page *page, wait_queue_t *wait));
 extern void FASTCALL(unlock_page(struct page *page));
 
-static inline void lock_page(struct page *page)
+static inline int __lock_page(struct page *page, wait_queue_t *wait)
 {
 	might_sleep();
 	if (TestSetPageLocked(page))
-		lock_page_slow(page);
+		return lock_page_slow(page, wait);
+	return 0;
 }
+
+#define lock_page(page)	__lock_page(page, &current->__wait.wait)
 	
 /*
  * This is exported only for wait_on_page_locked/wait_on_page_writeback.
  * Never use this directly!
  */
-extern void FASTCALL(wait_on_page_bit(struct page *page, int bit_nr));
+extern int FASTCALL(wait_on_page_bit(struct page *page, int bit_nr,
+			wait_queue_t *wait));
 
 /* 
  * Wait for a page to be unlocked.
@@ -174,21 +178,30 @@ extern void FASTCALL(wait_on_page_bit(st
  * ie with increased "page->count" so that the page won't
  * go away during the wait..
  */
-static inline void wait_on_page_locked(struct page *page)
+static inline int __wait_on_page_locked(struct page *page, wait_queue_t *wait)
 {
 	if (PageLocked(page))
-		wait_on_page_bit(page, PG_locked);
+		return wait_on_page_bit(page, PG_locked, wait);
+	return 0;
 }
 
+#define wait_on_page_locked(page) \
+	__wait_on_page_locked(page, &current->__wait.wait)
+
 /* 
  * Wait for a page to complete writeback
  */
-static inline void wait_on_page_writeback(struct page *page)
+static inline int __wait_on_page_writeback(struct page *page,
+					wait_queue_t *wait)
 {
 	if (PageWriteback(page))
-		wait_on_page_bit(page, PG_writeback);
+		return wait_on_page_bit(page, PG_writeback, wait);
+	return 0;
 }
 
+#define wait_on_page_writeback(page) \
+	__wait_on_page_writeback(page, &current->__wait.wait)
+
 extern void end_page_writeback(struct page *page);
 
 /*
diff -puN kernel/sched.c~aio-wait-page kernel/sched.c
--- linux-2.6.10-rc1/kernel/sched.c~aio-wait-page	2004-11-03 14:58:42.000000000 +0530
+++ linux-2.6.10-rc1-suparna/kernel/sched.c	2004-11-03 14:58:42.000000000 +0530
@@ -3444,6 +3444,20 @@ long __sched io_schedule_timeout(long ti
 	return ret;
 }
 
+/*
+ * Sleep only if the wait context passed is not async,
+ * otherwise return so that a retry can be issued later.
+ */
+int __sched io_wait_schedule(wait_queue_t *wait)
+{
+	if (!is_sync_wait(wait))
+		return -EIOCBRETRY;
+	io_schedule();
+	return 0;
+}
+
+EXPORT_SYMBOL(io_wait_schedule);
+
 /**
  * sys_sched_get_priority_max - return maximum RT priority.
  * @policy: scheduling class.
diff -puN mm/filemap.c~aio-wait-page mm/filemap.c
--- linux-2.6.10-rc1/mm/filemap.c~aio-wait-page	2004-11-03 14:58:42.000000000 +0530
+++ linux-2.6.10-rc1-suparna/mm/filemap.c	2004-11-03 14:58:42.000000000 +0530
@@ -145,8 +145,7 @@ static int sync_page(void *word, wait_qu
 	mapping = page_mapping(page);
 	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
 		mapping->a_ops->sync_page(page);
-	io_schedule();
-	return 0;
+	return io_wait_schedule(wait);
 }
 
 /**
@@ -376,13 +375,17 @@ static inline void wake_up_page(struct p
 	__wake_up_bit(page_waitqueue(page), &page->flags, bit);
 }
 
-void fastcall wait_on_page_bit(struct page *page, int bit_nr)
+int fastcall wait_on_page_bit(struct page *page, int bit_nr,
+					wait_queue_t *wait)
 {
-	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
-
-	if (test_bit(bit_nr, &page->flags))
-		__wait_on_bit(page_waitqueue(page), &wait, sync_page,
+	if (test_bit(bit_nr, &page->flags)) {
+		struct wait_bit_queue *wait_bit
+			= container_of(wait, struct wait_bit_queue, wait);
+		init_wait_bit_key(wait_bit, &page->flags, bit_nr);
+		return __wait_on_bit(page_waitqueue(page), wait_bit, sync_page,
 							TASK_UNINTERRUPTIBLE);
+	}
+	return 0;
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
@@ -411,7 +414,6 @@ void fastcall unlock_page(struct page *p
 }
 
 EXPORT_SYMBOL(unlock_page);
-EXPORT_SYMBOL(lock_page);
 
 /*
  * End writeback against a page.
@@ -429,18 +431,20 @@ void end_page_writeback(struct page *pag
 EXPORT_SYMBOL(end_page_writeback);
 
 /*
- * Get a lock on the page, assuming we need to sleep to get it.
+ * Get a lock on the page, assuming we need to wait to get it.
  *
  * Ugly: running sync_page() in state TASK_UNINTERRUPTIBLE is scary.  If some
  * random driver's requestfn sets TASK_RUNNING, we could busywait.  However
  * chances are that on the second loop, the block layer's plug list is empty,
  * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
-void fastcall lock_page_slow(struct page *page)
+int fastcall lock_page_slow(struct page *page, wait_queue_t *wait)
 {
-	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
+	struct wait_bit_queue *wait_bit
+		= container_of(wait, struct wait_bit_queue, wait);
 
-	__wait_on_bit_lock(page_waitqueue(page), &wait, sync_page,
+	init_wait_bit_key(wait_bit, &page->flags, PG_locked);
+	return __wait_on_bit_lock(page_waitqueue(page), wait_bit, sync_page,
 							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(lock_page_slow);

_
