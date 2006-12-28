Return-Path: <linux-kernel-owner+w=401wt.eu-S964982AbWL1IhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWL1IhZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWL1IhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:37:25 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:59527 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964982AbWL1IhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:37:24 -0500
Date: Thu, 28 Dec 2006 14:11:49 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [FSAIO][PATCH 6/8] Enable asynchronous wait page and lock page
Message-ID: <20061228084149.GF6971@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 linux-2.6.20-rc1-root/include/linux/pagemap.h |   30 ++++++++++++++++++-------
 linux-2.6.20-rc1-root/include/linux/sched.h   |    1 
 linux-2.6.20-rc1-root/kernel/sched.c          |   14 +++++++++++
 linux-2.6.20-rc1-root/mm/filemap.c            |   31 +++++++++++++++-----------
 4 files changed, 55 insertions(+), 21 deletions(-)

diff -puN include/linux/pagemap.h~aio-wait-page include/linux/pagemap.h
--- linux-2.6.20-rc1/include/linux/pagemap.h~aio-wait-page	2006-12-21 08:46:02.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/pagemap.h	2006-12-21 08:46:02.000000000 +0530
@@ -133,20 +133,24 @@ static inline pgoff_t linear_page_index(
 	return pgoff >> (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 }
 
-extern void FASTCALL(lock_page_slow(struct page *page));
+extern int FASTCALL(__lock_page_slow(struct page *page, wait_queue_t *wait));
 extern void FASTCALL(__lock_page_nosync(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
 /*
  * lock_page may only be called if we have the page's inode pinned.
  */
-static inline void lock_page(struct page *page)
+static inline int __lock_page(struct page *page, wait_queue_t *wait)
 {
 	might_sleep();
 	if (TestSetPageLocked(page))
-		lock_page_slow(page);
+		return __lock_page_slow(page, wait);
+	return 0;
 }
 
+#define lock_page(page)		__lock_page(page, &current->__wait.wait)
+#define lock_page_slow(page)	__lock_page_slow(page, &current->__wait.wait)
+
 /*
  * lock_page_nosync should only be used if we can't pin the page's inode.
  * Doesn't play quite so well with block device plugging.
@@ -162,7 +166,8 @@ static inline void lock_page_nosync(stru
  * This is exported only for wait_on_page_locked/wait_on_page_writeback.
  * Never use this directly!
  */
-extern void FASTCALL(wait_on_page_bit(struct page *page, int bit_nr));
+extern int FASTCALL(wait_on_page_bit(struct page *page, int bit_nr,
+			wait_queue_t *wait));
 
 /* 
  * Wait for a page to be unlocked.
@@ -171,21 +176,30 @@ extern void FASTCALL(wait_on_page_bit(st
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
diff -puN include/linux/sched.h~aio-wait-page include/linux/sched.h
--- linux-2.6.20-rc1/include/linux/sched.h~aio-wait-page	2006-12-21 08:46:02.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/sched.h	2006-12-28 09:26:27.000000000 +0530
@@ -216,6 +216,7 @@ extern void show_stack(struct task_struc
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
+int io_wait_schedule(wait_queue_t *wait);
 
 extern void cpu_init (void);
 extern void trap_init(void);
diff -puN kernel/sched.c~aio-wait-page kernel/sched.c
--- linux-2.6.20-rc1/kernel/sched.c~aio-wait-page	2006-12-21 08:46:02.000000000 +0530
+++ linux-2.6.20-rc1-root/kernel/sched.c	2006-12-21 08:46:02.000000000 +0530
@@ -4743,6 +4743,20 @@ long __sched io_schedule_timeout(long ti
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
--- linux-2.6.20-rc1/mm/filemap.c~aio-wait-page	2006-12-21 08:46:02.000000000 +0530
+++ linux-2.6.20-rc1-root/mm/filemap.c	2006-12-28 09:32:27.000000000 +0530
@@ -165,8 +165,7 @@ static int sync_page(void *word, wait_qu
 	mapping = page_mapping(page);
 	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
 		mapping->a_ops->sync_page(page);
-	io_schedule();
-	return 0;
+	return io_wait_schedule(wait);
 }
 
 /**
@@ -478,7 +477,7 @@ struct page *__page_cache_alloc(gfp_t gf
 EXPORT_SYMBOL(__page_cache_alloc);
 #endif
 
-static int __sleep_on_page_lock(void *word)
+static int __sleep_on_page_lock(void *word, wait_queue_t *wait)
 {
 	io_schedule();
 	return 0;
@@ -506,13 +505,17 @@ static inline void wake_up_page(struct p
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
 
@@ -556,7 +559,7 @@ void end_page_writeback(struct page *pag
 EXPORT_SYMBOL(end_page_writeback);
 
 /**
- * lock_page_slow - get a lock on the page, assuming we need to sleep to get it
+ * __lock_page_slow: get a lock on the page, assuming we need to wait to get it
  * @page: the page to lock
  *
  * Ugly. Running sync_page() in state TASK_UNINTERRUPTIBLE is scary.  If some
@@ -564,14 +567,16 @@ EXPORT_SYMBOL(end_page_writeback);
  * chances are that on the second loop, the block layer's plug list is empty,
  * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
-void fastcall lock_page_slow(struct page *page)
+int fastcall __lock_page_slow(struct page *page, wait_queue_t *wait)
 {
-	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
+	struct wait_bit_queue *wait_bit
+		= container_of(wait, struct wait_bit_queue, wait);
 
-	__wait_on_bit_lock(page_waitqueue(page), &wait, sync_page,
+	init_wait_bit_key(wait_bit, &page->flags, PG_locked);
+	return __wait_on_bit_lock(page_waitqueue(page), wait_bit, sync_page,
 							TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(lock_page_slow);
+EXPORT_SYMBOL(__lock_page_slow);
 
 /*
  * Variant of lock_page that does not require the caller to hold a reference
_
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

