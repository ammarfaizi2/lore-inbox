Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUKCJSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUKCJSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUKCJSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:18:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61588 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261533AbUKCJO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:14:27 -0500
Date: Wed, 3 Nov 2004 14:53:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: Re: [PATCH 6/6] AIO wait page and AIO lock page
Message-ID: <20041103092300.GF5737@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041103091036.GA4041@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103091036.GA4041@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:40:36PM +0530, Suparna Bhattacharya wrote:
> 
> The series of patches that follow integrate AIO with 
> William Lee Irwin's wait bit changes, to support asynchronous
> page waits.
> 
> [1] modify-wait-bit-action-args.patch
> 	Add a wait queue arg to the wait_bit action() routine
> 
> [2] lock_page_slow.patch
> 	Rename __lock_page to lock_page_slow
> 
> [3] init-wait-bit-key.patch
> 	Interfaces to init and to test wait bit key
> 
> [4] tsk-default-io-wait.patch
> 	Add default io wait bit field in task struct
> 
> [5] aio-wait-bit.patch
> 	AIO wake bit and AIO wait bit
> 
> [6] aio-wait-page.patch
> 	AIO wait page and lock page
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

---------------------------------------------------


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

 linux-2.6.9-rc1-mm4-suparna/include/linux/pagemap.h |   38 ++++++++++++++------
 linux-2.6.9-rc1-mm4-suparna/mm/filemap.c            |   27 ++++++++------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff -urp linux-2.6.9-rc3/kernel/sched.c linux-2.6.9-rc3-mm2/kernel/sched.c
--- linux-2.6.9-rc3/kernel/sched.c	2004-10-07 13:19:10.000000000 +0530
+++ linux-2.6.9-rc3-mm2/kernel/sched.c	2004-10-08 11:53:18.000000000 +0530
@@ -4428,6 +4428,20 @@ long __sched io_schedule_timeout(long ti
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
--- linux-2.6.9-rc1-mm4/mm/filemap.c~aio-wait-page	2004-09-17 09:25:48.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/mm/filemap.c	2004-09-20 22:57:37.000000000 +0530
@@ -146,8 +146,7 @@ static int sync_page(void *word, wait_qu
 	mapping = page_mapping(page);
 	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
 		mapping->a_ops->sync_page(page);
-	io_schedule();
-	return 0;
+	return io_wait_schedule(wait);
 }
 
 /**
@@ -378,13 +377,17 @@ static inline void wake_up_page(struct p
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
 
@@ -414,7 +417,6 @@ void fastcall unlock_page(struct page *p
 }
 
 EXPORT_SYMBOL(unlock_page);
-EXPORT_SYMBOL(lock_page);
 
 /*
  * End writeback against a page.
@@ -431,18 +434,20 @@ void end_page_writeback(struct page *pag
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
diff -puN include/linux/pagemap.h~aio-wait-page include/linux/pagemap.h
--- linux-2.6.9-rc1-mm4/include/linux/pagemap.h~aio-wait-page	2004-09-17 09:25:48.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/include/linux/pagemap.h	2004-09-20 22:56:21.000000000 +0530
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
@@ -174,20 +178,29 @@ extern void FASTCALL(wait_on_page_bit(st
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
 * Fault a userspace page into pagetables.  Return non-zero on a fault.
