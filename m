Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319232AbSH2P1T>; Thu, 29 Aug 2002 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319235AbSH2P1T>; Thu, 29 Aug 2002 11:27:19 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:49415
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319232AbSH2P1R>; Thu, 29 Aug 2002 11:27:17 -0400
Subject: [PATCH] low-latency zap_page_range()
From: Robert Love <rml@tech9.net>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 11:31:39 -0400
Message-Id: <1030635100.939.2551.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Attached patch implements a low latency version of "zap_page_range()".

Calls with even moderately large page ranges result in very long lock
held times and consequently very long periods of non-preemptibility. 
This function is in my list of the top 3 worst offenders.  It is gross.

This new version reimplements zap_page_range() as a loop over
ZAP_BLOCK_SIZE chunks.  After each iteration, if a reschedule is
pending, we drop page_table_lock and automagically preempt.  Note we can
not blindly drop the locks and reschedule (e.g. for the non-preempt
case) since there is a possibility to enter this codepath holding other
locks.

... I am sure you are familar with all this, its the same deal as your
low-latency work.  This patch implements the "cond_resched_lock()" as we
discussed sometime back.  I think this solution should be acceptable to
you and Linus.

There are other misc. cleanups, too.

This new zap_page_range() yields latency too-low-to-benchmark: <<1ms.

Please, Andrew, add this to your ever-growing list.

	Robert Love

diff -urN linux-2.5.32/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.32/include/linux/sched.h	Tue Aug 27 15:26:34 2002
+++ linux/include/linux/sched.h	Wed Aug 28 18:04:41 2002
@@ -898,6 +898,34 @@
 		__cond_resched();
 }
 
+#ifdef CONFIG_PREEMPT
+
+/*
+ * cond_resched_lock() - if a reschedule is pending, drop the given lock,
+ * call schedule, and on return reacquire the lock.
+ *
+ * Note: this does not assume the given lock is the _only_ lock held.
+ * The kernel preemption counter gives us "free" checking that we are
+ * atomic -- let's use it.
+ */
+static inline void cond_resched_lock(spinlock_t * lock)
+{
+	if (need_resched() && preempt_count() == 1) {
+		_raw_spin_unlock(lock);
+		preempt_enable_no_resched();
+		__cond_resched();
+		spin_lock(lock);
+	}
+}
+
+#else
+
+static inline void cond_resched_lock(spinlock_t * lock)
+{
+}
+
+#endif
+
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
    Athread cathreaders should have t->sigmask_lock.  */
diff -urN linux-2.5.32/mm/memory.c linux/mm/memory.c
--- linux-2.5.32/mm/memory.c	Tue Aug 27 15:26:42 2002
+++ linux/mm/memory.c	Wed Aug 28 18:03:11 2002
@@ -389,8 +389,8 @@
 {
 	pgd_t * dir;
 
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
+
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
@@ -401,30 +401,43 @@
 	tlb_end_vma(tlb, vma);
 }
 
-/*
- * remove user pages in a given range.
+#define ZAP_BLOCK_SIZE	(256 * PAGE_SIZE) /* how big a chunk we loop over */
+ 
+/**
+ * zap_page_range - remove user pages in a given range
+ * @vma: vm_area_struct holding the applicable pages
+ * @address: starting address of pages to zap
+ * @size: number of bytes to zap
  */
 void zap_page_range(struct vm_area_struct *vma, unsigned long address, unsigned long size)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	mmu_gather_t *tlb;
-	unsigned long start = address, end = address + size;
+	unsigned long end, block;
 
-	/*
-	 * This is a long-lived spinlock. That's fine.
-	 * There's no contention, because the page table
-	 * lock only protects against kswapd anyway, and
-	 * even if kswapd happened to be looking at this
-	 * process we _want_ it to get stuck.
-	 */
-	if (address >= end)
-		BUG();
 	spin_lock(&mm->page_table_lock);
-	flush_cache_range(vma, address, end);
 
-	tlb = tlb_gather_mmu(mm, 0);
-	unmap_page_range(tlb, vma, address, end);
-	tlb_finish_mmu(tlb, start, end);
+  	/*
+ 	 * This was once a long-held spinlock.  Now we break the
+ 	 * work up into ZAP_BLOCK_SIZE units and relinquish the
+ 	 * lock after each interation.  This drastically lowers
+ 	 * lock contention and allows for a preemption point.
+  	 */
+	while (size) {
+		block = (size > ZAP_BLOCK_SIZE) ? ZAP_BLOCK_SIZE : size;
+ 		end = address + block;
+ 
+ 		flush_cache_range(vma, address, end);
+ 		tlb = tlb_gather_mmu(mm, 0);
+ 		unmap_page_range(tlb, vma, address, end);
+ 		tlb_finish_mmu(tlb, address, end);
+ 
+ 		cond_resched_lock(&mm->page_table_lock);
+ 
+ 		address += block;
+ 		size -= block;
+ 	}
+
 	spin_unlock(&mm->page_table_lock);
 }
 



