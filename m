Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVFTQaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVFTQaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVFTQ2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:28:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62900 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261362AbVFTQ1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:27:08 -0400
Date: Mon, 20 Jun 2005 22:06:10 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 6/6] AIO wait page and AIO lock page
Message-ID: <20050620163610.GF5380@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620160126.GA5271@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 09:31:26PM +0530, Suparna Bhattacharya wrote:
> > (1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
> > 	Status: Updated to 2.6.12-rc6, needs review
> 


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

 include/linux/pagemap.h |   38 ++++++++++++++------
 mm/filemap.c            |   27 ++++++++------
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
--- linux-2.6.10-rc1/include/linux/sched.h	2004-11-03 12:04:20.000000000 +0530
+++ linux-2.6.10-rc1-aio/include/linux/sched.h	2004-11-10 13:06:03.376403392 +0530
@@ -165,6 +165,7 @@ extern void show_stack(struct task_struc
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
+int io_wait_schedule(wait_queue_t *wait);
 
 extern void cpu_init (void);
 extern void trap_init(void);

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

