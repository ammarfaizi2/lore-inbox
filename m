Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319334AbSH2U1r>; Thu, 29 Aug 2002 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319336AbSH2U1q>; Thu, 29 Aug 2002 16:27:46 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:33545 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319334AbSH2U1o>; Thu, 29 Aug 2002 16:27:44 -0400
Message-ID: <3D6E844C.4E756D10@zip.com.au>
Date: Thu, 29 Aug 2002 13:30:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] low-latency zap_page_range()
References: <1030635100.939.2551.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Andrew,
> 
> Attached patch implements a low latency version of "zap_page_range()".
> 

This doesn't quite do the right thing on SMP.

Note that pages which are to be torn down are buffered in the
mmu_gather_t array.  The kernel throws away 507 pages at a
time - this is to reduce the frequency of global TLB invalidations.
(The 507 is, I assume, designed to make the mmu_gather_t be
2048 bytes in size.  I recently broke that math, and need to fix
it up).

However with your change, we'll only ever put 256 pages into the
mmu_gather_t.  Half of that thing's buffer is unused and the
invalidation rate will be doubled during teardown of large
address ranges.

I suggest that you make ZAP_BLOCK_SIZE be equal to FREE_PTE_NR on
SMP, and 256 on UP.

(We could get fancier and do something like:

	tlb = tlb_gather_mmu(mm, 0):
	while (size) {
		...
		unmap_page_range(ZAP_BLOCK_SIZE pages);
		tlb_flush_mmu(...);
		cond_resched_lock();
	}
	tlb_finish_mmu(..);
	spin_unlock(page_table_lock);

but I don't think that passes the benefit-versus-complexity test.)

Also, if the kernel is not compiled for preemption then we're
doing a little bit of extra work to no advantage, yes?  We can
avoid doing that by setting ZAP_BLOCK_SIZE to infinity.

How does this altered version look?  All I changed was the ZAP_BLOCK_SIZE
initialisation.


--- 2.5.32/include/linux/sched.h~llzpr	Thu Aug 29 13:01:01 2002
+++ 2.5.32-akpm/include/linux/sched.h	Thu Aug 29 13:01:01 2002
@@ -907,6 +907,34 @@ static inline void cond_resched(void)
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
--- 2.5.32/mm/memory.c~llzpr	Thu Aug 29 13:01:01 2002
+++ 2.5.32-akpm/mm/memory.c	Thu Aug 29 13:26:21 2002
@@ -389,8 +389,8 @@ void unmap_page_range(mmu_gather_t *tlb,
 {
 	pgd_t * dir;
 
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
+
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
@@ -401,30 +401,53 @@ void unmap_page_range(mmu_gather_t *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
-/*
- * remove user pages in a given range.
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+#define ZAP_BLOCK_SIZE	(FREE_PTE_NR * PAGE_SIZE)
+#endif
+
+#if !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+#define ZAP_BLOCK_SIZE	(256 * PAGE_SIZE)
+#endif
+
+#if !defined(CONFIG_PREEMPT)
+#define ZAP_BLOCK_SIZE	(~(0UL))
+#endif
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
 

.
