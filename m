Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSGYB0f>; Wed, 24 Jul 2002 21:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318287AbSGYB0f>; Wed, 24 Jul 2002 21:26:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24053 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318286AbSGYB0e>; Wed, 24 Jul 2002 21:26:34 -0400
Subject: Re: [PATCH] updated low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0207241820170.5944-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207241820170.5944-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jul 2002 18:29:41 -0700
Message-Id: <1027560581.17955.20.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 18:21, Linus Torvalds wrote:

> > Then we get "if (0 && ..)" which should hopefully be evaluated away.
> 
> I think preempt_count() is not unconditionally 0 for non-preemptible
> kernels, so I don't think this is a compile-time constant.
> 
> That may be a bug in preempt_count(), of course.

Oh, it was until Ingo's IRQ rewrite... we do not want it unconditional
anymore.  Here is a new version which defines an empty
"cond_resched_lock()" for !CONFIG_PREEMPT [1].

Good for you guys?

	Robert Love

[1] You may ask, why not just have it drop the lock and reschedule
unconditionally if !CONFIG_PREEMPT?  The answer is because in this
function, as in many others, we do not know the call chain and the locks
held.  Most callers of zap_page_range() hold no locks on call -- but one
does.  This is one reason I would prefer to just unconditionally drop
the locks and have each kernel do the right thing.

diff -urN linux-2.5.28/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.28/include/linux/sched.h	Wed Jul 24 14:03:20 2002
+++ linux/include/linux/sched.h	Wed Jul 24 18:26:06 2002
@@ -888,6 +888,34 @@
 		__cond_resched();
 }
 
+#ifdef CONFIG_PREEMPT
+
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
diff -urN linux-2.5.28/mm/memory.c linux/mm/memory.c
--- linux-2.5.28/mm/memory.c	Wed Jul 24 14:03:27 2002
+++ linux/mm/memory.c	Wed Jul 24 18:24:48 2002
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
 

