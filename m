Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318049AbSGYA0f>; Wed, 24 Jul 2002 20:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSGYA0f>; Wed, 24 Jul 2002 20:26:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21497 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318049AbSGYA0d>; Wed, 24 Jul 2002 20:26:33 -0400
Subject: [PATCH] updated low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: akpm@zip.com.au, torvalds@transmeta.com
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jul 2002 17:29:35 -0700
Message-Id: <1027556975.927.1641.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew and Linus,

The lock hold time in zap_page_range is horrid.  This patch breaks the
work up into chunks and relinquishes the lock after each iteration. 
This drastically lowers latency by creating a preemption point, as well
as lowering lock contention.

This patch is updated over the previous: per Linus's suggestion, we now
call a new "cond_resched_lock()" function.  Per Andrew's suggestion, it
checks the preempt_count as to not allow an improper preemption. 
However, we can now longer allow the conditional reschedule without
CONFIG_PREEMPT here (since there is no way to know if it is safe) so it
becomes a nop.

This lowers the maximum latency in zap_page_range from 10~20ms (on a
dual Athlon - one of the worst latencies recorded) to unmeasurable.

I made a couple other cleanups and optimizations:

        - remove unneeded dir variable and call to pgd_offset - nothing
          uses this anymore as the code was pushed to unmap_page_range

        - removed duplicated start variable - it is the same as address

        - BUG -> BUG_ON in unmap_page_range

        - remove redundant BUG from zap_page_range - the same check is
          done in unmap_page_range

        - better comments

Patch is against 2.5.28, please apply.

        Robert Love

diff -urN linux-2.5.28/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.28/include/linux/sched.h	Wed Jul 24 14:03:20 2002
+++ linux/include/linux/sched.h	Wed Jul 24 17:21:29 2002
@@ -888,6 +888,24 @@
 		__cond_resched();
 }
 
+/*
+ * cond_resched_lock() - if a reschedule is pending, drop the given lock,
+ * call schedule, and on return reacquire the lock.
+ *
+ * Note: this assumes the given lock is the _only_ held lock and otherwise
+ * you are not atomic.  The kernel preemption counter gives us "free"
+ * checking that this is really the only lock held -- let's use it.
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
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
    Athread cathreaders should have t->sigmask_lock.  */
diff -urN linux-2.5.28/mm/memory.c linux/mm/memory.c
--- linux-2.5.28/mm/memory.c	Wed Jul 24 14:03:27 2002
+++ linux/mm/memory.c	Wed Jul 24 17:20:58 2002
@@ -390,8 +390,8 @@
 {
 	pgd_t * dir;
 
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
+
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
@@ -402,33 +402,43 @@
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
-	pgd_t * dir;
-	unsigned long start = address, end = address + size;
+	unsigned long end, block;
 
-	dir = pgd_offset(mm, address);
+	spin_lock(&mm->page_table_lock);
 
 	/*
-	 * This is a long-lived spinlock. That's fine.
-	 * There's no contention, because the page table
-	 * lock only protects against kswapd anyway, and
-	 * even if kswapd happened to be looking at this
-	 * process we _want_ it to get stuck.
+	 * This was once a long-held spinlock.  Now we break the
+	 * work up into ZAP_BLOCK_SIZE units and relinquish the
+	 * lock after each interation.  This drastically lowers
+	 * lock contention and allows for a preemption point.
 	 */
-	if (address >= end)
-		BUG();
-	spin_lock(&mm->page_table_lock);
-	flush_cache_range(vma, address, end);
+	while (size) {
+		block = (size > ZAP_BLOCK_SIZE) ? ZAP_BLOCK_SIZE : size;
+		end = address + block;
+
+		flush_cache_range(vma, address, end);
+		tlb = tlb_gather_mmu(mm, 0);
+		unmap_page_range(tlb, vma, address, end);
+		tlb_finish_mmu(tlb, address, end);
+
+		cond_resched_lock(&mm->page_table_lock);
+
+		address += block;
+		size -= block;
+	}
 
-	tlb = tlb_gather_mmu(mm, 0);
-	unmap_page_range(tlb, vma, address, end);
-	tlb_finish_mmu(tlb, start, end);
 	spin_unlock(&mm->page_table_lock);
 }
 

