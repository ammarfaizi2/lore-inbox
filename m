Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312314AbSCUAS0>; Wed, 20 Mar 2002 19:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312309AbSCUASJ>; Wed, 20 Mar 2002 19:18:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:65034 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312310AbSCUAQ5>;
	Wed, 20 Mar 2002 19:16:57 -0500
Subject: [PATCH] 2.4-ac: BUG_ON (2/2)
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 20 Mar 2002 19:16:59 -0500
Message-Id: <1016669824.15474.270.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

This patch, which requires the previous BUG_ON part 1 patch, changes a
few uses of BUG -> BUG_ON in fast paths in the kernel.

This is a separate patch from the Marcelo variant as part 2 does not
apply cleanly to your tree due to various changes.

Patch is against 2.4.19-pre3-ac4.  Alan, please apply.

	Robert Love

diff -urN linux-2.4.19-pre3-ac4/arch/i386/kernel/smp.c linux/arch/i386/kernel/smp.c
--- linux-2.4.19-pre3-ac4/arch/i386/kernel/smp.c	Wed Mar 20 18:56:39 2002
+++ linux/arch/i386/kernel/smp.c	Wed Mar 20 18:49:51 2002
@@ -301,8 +301,7 @@
  */
 static void inline leave_mm (unsigned long cpu)
 {
-	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
-		BUG();
+	BUG_ON(cpu_tlbstate[cpu].state == TLBSTATE_OK);
 	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
 }
 
diff -urN linux-2.4.19-pre3-ac4/kernel/exit.c linux/kernel/exit.c
--- linux-2.4.19-pre3-ac4/kernel/exit.c	Wed Mar 20 18:56:51 2002
+++ linux/kernel/exit.c	Wed Mar 20 18:49:51 2002
@@ -362,7 +362,7 @@
 	mm_release();
 	if (mm) {
 		atomic_inc(&mm->mm_count);
-		if (mm != tsk->active_mm) BUG();
+		BUG_ON(mm != tsk->active_mm);
 		/* more a memory barrier than a real lock */
 		task_lock(tsk);
 		tsk->mm = NULL;
diff -urN linux-2.4.19-pre3-ac4/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.19-pre3-ac4/kernel/fork.c	Wed Mar 20 18:56:51 2002
+++ linux/kernel/fork.c	Wed Mar 20 18:49:51 2002
@@ -275,7 +275,7 @@
  */
 inline void __mmdrop(struct mm_struct *mm)
 {
-	if (mm == &init_mm) BUG();
+	BUG_ON(mm == &init_mm);
 	pgd_free(mm->pgd);
 	destroy_context(mm);
 	free_mm(mm);
diff -urN linux-2.4.19-pre3-ac4/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre3-ac4/kernel/sched.c	Wed Mar 20 18:56:51 2002
+++ linux/kernel/sched.c	Wed Mar 20 18:50:23 2002
@@ -749,8 +749,8 @@
 	list_t *queue;
 	int idx;
 
-	if (unlikely(in_interrupt()))
-		BUG();
+	BUG_ON(in_interrupt());
+
 	release_kernel_lock(prev, smp_processor_id());
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
diff -urN linux-2.4.19-pre3-ac4/mm/rmap.c linux/mm/rmap.c
--- linux-2.4.19-pre3-ac4/mm/rmap.c	Wed Mar 20 18:56:52 2002
+++ linux/mm/rmap.c	Wed Mar 20 18:52:16 2002
@@ -136,8 +136,7 @@
 {
 	struct pte_chain * pc, * prev_pc = NULL;
 
-	if (!page || !ptep)
-		BUG();
+	BUG_ON(!page || !ptep);
 	if (!VALID_PAGE(page) || PageReserved(page))
 		return;
 
@@ -186,8 +185,7 @@
 	pte_t pte;
 	int ret;
 
-	if (!mm)
-		BUG();
+	BUG_ON(!mm);
 
 	/*
 	 * We need the page_table_lock to protect us from page faults,
@@ -255,13 +253,10 @@
 	int ret = SWAP_SUCCESS;
 
 	/* This page should not be on the pageout lists. */
-	if (!VALID_PAGE(page) || PageReserved(page))
-		BUG();
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!VALID_PAGE(page) || PageReserved(page));
+	BUG_ON(!PageLocked(page));
 	/* We need backing store to swap out a page. */
-	if (!page->mapping)
-		BUG();
+	BUG_ON(!page->mapping);
 
 	for (pc = page->pte_chain; pc; pc = next_pc) {
 		next_pc = pc->next;
diff -urN linux-2.4.19-pre3-ac4/mm/slab.c linux/mm/slab.c
--- linux-2.4.19-pre3-ac4/mm/slab.c	Wed Mar 20 18:56:52 2002
+++ linux/mm/slab.c	Wed Mar 20 18:49:51 2002
@@ -666,8 +666,7 @@
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);


