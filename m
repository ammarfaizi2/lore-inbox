Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313027AbSDCDDb>; Tue, 2 Apr 2002 22:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSDCDDX>; Tue, 2 Apr 2002 22:03:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:53515 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313027AbSDCDDL>;
	Tue, 2 Apr 2002 22:03:11 -0500
Subject: [PATCH] 2.4: BUG_ON (2/2)
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 Apr 2002 22:03:11 -0500
Message-Id: <1017802992.2940.602.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch, which requires the previous BUG_ON part 1 patch, changes a
few uses of BUG -> BUG_ON in fast paths in the kernel, partly to
demonstrate readability, partly for the optimization, mostly to give a
reason to take part 1. ;)

Patch is against 2.4.19-pre5, please apply.

	Robert Love

diff -urN linux-2.4.19-pre5/arch/i386/kernel/smp.c linux/arch/i386/kernel/smp.c
--- linux-2.4.19-pre5/arch/i386/kernel/smp.c	Sat Mar 30 18:27:32 2002
+++ linux/arch/i386/kernel/smp.c	Sat Mar 30 18:34:07 2002
@@ -301,8 +301,7 @@
  */
 static void inline leave_mm (unsigned long cpu)
 {
-	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
-		BUG();
+	BUG_ON(cpu_tlbstate[cpu].state == TLBSTATE_OK);
 	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
 }
 
diff -urN linux-2.4.19-pre5/kernel/exit.c linux/kernel/exit.c
--- linux-2.4.19-pre5/kernel/exit.c	Sat Mar 30 18:26:41 2002
+++ linux/kernel/exit.c	Sat Mar 30 18:34:07 2002
@@ -316,7 +316,7 @@
 	mm_release();
 	if (mm) {
 		atomic_inc(&mm->mm_count);
-		if (mm != tsk->active_mm) BUG();
+		BUG_ON(mm != tsk->active_mm);
 		/* more a memory barrier than a real lock */
 		task_lock(tsk);
 		tsk->mm = NULL;
diff -urN linux-2.4.19-pre5/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.19-pre5/kernel/fork.c	Sat Mar 30 18:26:41 2002
+++ linux/kernel/fork.c	Sat Mar 30 18:34:07 2002
@@ -251,7 +251,7 @@
  */
 inline void __mmdrop(struct mm_struct *mm)
 {
-	if (mm == &init_mm) BUG();
+	BUG_ON(mm == &init_mm);
 	pgd_free(mm->pgd);
 	destroy_context(mm);
 	free_mm(mm);
diff -urN linux-2.4.19-pre5/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre5/kernel/sched.c	Sat Mar 30 18:26:41 2002
+++ linux/kernel/sched.c	Sat Mar 30 18:34:07 2002
@@ -556,7 +556,7 @@
 
 	spin_lock_prefetch(&runqueue_lock);
 
-	if (!current->active_mm) BUG();
+	BUG_ON(!current->active_mm);
 need_resched_back:
 	prev = current;
 	this_cpu = prev->processor;
@@ -675,12 +675,12 @@
 		struct mm_struct *mm = next->mm;
 		struct mm_struct *oldmm = prev->active_mm;
 		if (!mm) {
-			if (next->active_mm) BUG();
+			BUG_ON(next->active_mm);
 			next->active_mm = oldmm;
 			atomic_inc(&oldmm->mm_count);
 			enter_lazy_tlb(oldmm, next, this_cpu);
 		} else {
-			if (next->active_mm != mm) BUG();
+			BUG_ON(next->active_mm != mm);
 			switch_mm(oldmm, mm, next, this_cpu);
 		}
 
diff -urN linux-2.4.19-pre5/mm/slab.c linux/mm/slab.c
--- linux-2.4.19-pre5/mm/slab.c	Sat Mar 30 18:26:41 2002
+++ linux/mm/slab.c	Sat Mar 30 18:34:07 2002
@@ -665,8 +665,7 @@
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
diff -urN linux-2.4.19-pre5/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.4.19-pre5/mm/vmscan.c	Sat Mar 30 18:26:41 2002
+++ linux/mm/vmscan.c	Sat Mar 30 18:34:07 2002
@@ -233,8 +233,7 @@
 	pgdir = pgd_offset(mm, address);
 
 	end = vma->vm_end;
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		count = swap_out_pgd(mm, vma, pgdir, address, end, count, classzone);
 		if (!count)
@@ -353,10 +352,8 @@
 
 		page = list_entry(entry, struct page, lru);
 
-		if (unlikely(!PageLRU(page)))
-			BUG();
-		if (unlikely(PageActive(page)))
-			BUG();
+		BUG_ON(!PageLRU(page));
+		BUG_ON(PageActive(page));
 
 		list_del(entry);
 		list_add(entry, &inactive_list);



