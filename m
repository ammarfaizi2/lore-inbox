Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288963AbSAYXy1>; Fri, 25 Jan 2002 18:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSAYXyS>; Fri, 25 Jan 2002 18:54:18 -0500
Received: from zero.tech9.net ([209.61.188.187]:31499 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288959AbSAYXxz>;
	Fri, 25 Jan 2002 18:53:55 -0500
Subject: Re: [PATCH] add BUG_ON to 2.4 #2
From: Robert Love <rml@tech9.net>
To: Robert Love <rml@tech9.net>
Cc: David Garfield <garfield@irving.iisd.sra.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <1012003077.3505.136.camel@phantasy>
In-Reply-To: <1012000599.3799.85.camel@phantasy> 
	<15441.59731.568087.579456@irving.iisd.sra.com> 
	<1012003077.3505.136.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 18:58:58 -0500
Message-Id: <1012003139.3505.140.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 18:57, Robert Love wrote:

> Probably doesn't hurt but obviously not what I intended.  Attached patch
> is fixed.  Sorry.

Ugh my formatting was bad there.  Attached patch is correct.  Sorry,
Marcelo.

	Robert Love

diff -urN linux-2.4.18-pre7/arch/i386/kernel/smp.c linux/arch/i386/kernel/smp.c
--- linux-2.4.18-pre7/arch/i386/kernel/smp.c	Thu Jan 24 13:48:49 2002
+++ linux/arch/i386/kernel/smp.c	Fri Jan 25 17:59:41 2002
@@ -301,8 +301,7 @@
  */
 static void inline leave_mm (unsigned long cpu)
 {
-	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
-		BUG();
+	BUG_ON(cpu_tlbstate[cpu].state == TLBSTATE_OK);
 	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
 }
 
diff -urN linux-2.4.18-pre7/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.4.18-pre7/arch/i386/kernel/smpboot.c	Thu Jan 24 13:48:49 2002
+++ linux/arch/i386/kernel/smpboot.c	Fri Jan 25 18:00:50 2002
@@ -130,8 +130,7 @@
 	 * Has to be in very low memory so we can execute
 	 * real-mode AP code.
 	 */
-	if (__pa(trampoline_base) >= 0x9F000)
-		BUG();
+	BUG_ON(__pa(trampoline_base) >= 0x9F000);
 }
 
 /*
@@ -1088,8 +1087,7 @@
 	connect_bsp_APIC();
 	setup_local_APIC();
 
-	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
-		BUG();
+	BUG_ON(GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid);
 
 	/*
 	 * Scan the CPU present map and fire up the other CPUs via do_boot_cpu
diff -urN linux-2.4.18-pre7/kernel/exit.c linux/kernel/exit.c
--- linux-2.4.18-pre7/kernel/exit.c	Thu Jan 24 13:48:17 2002
+++ linux/kernel/exit.c	Fri Jan 25 17:58:03 2002
@@ -316,7 +316,7 @@
 	mm_release();
 	if (mm) {
 		atomic_inc(&mm->mm_count);
-		if (mm != tsk->active_mm) BUG();
+		BUG_ON(mm != tsk->active_mm);
 		/* more a memory barrier than a real lock */
 		task_lock(tsk);
 		tsk->mm = NULL;
diff -urN linux-2.4.18-pre7/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.18-pre7/kernel/fork.c	Thu Jan 24 13:48:17 2002
+++ linux/kernel/fork.c	Fri Jan 25 17:58:14 2002
@@ -249,7 +249,7 @@
  */
 inline void __mmdrop(struct mm_struct *mm)
 {
-	if (mm == &init_mm) BUG();
+	BUG_ON(mm == &init_mm);
 	pgd_free(mm->pgd);
 	destroy_context(mm);
 	free_mm(mm);
diff -urN linux-2.4.18-pre7/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.18-pre7/kernel/sched.c	Thu Jan 24 13:48:17 2002
+++ linux/kernel/sched.c	Fri Jan 25 17:59:13 2002
@@ -556,7 +556,7 @@
 
 	spin_lock_prefetch(&runqueue_lock);
 
-	if (!current->active_mm) BUG();
+	BUG_ON(!current->active_mm);
 need_resched_back:
 	prev = current;
 	this_cpu = prev->processor;
diff -urN linux-2.4.18-pre7/mm/filemap.c linux/mm/filemap.c
--- linux-2.4.18-pre7/mm/filemap.c	Thu Jan 24 13:48:18 2002
+++ linux/mm/filemap.c	Fri Jan 25 18:03:40 2002
@@ -120,7 +120,7 @@
  */
 void __remove_inode_page(struct page *page)
 {
-	if (PageDirty(page)) BUG();
+	BUG_ON(PageDirty(page));
 	remove_page_from_inode_queue(page);
 	remove_page_from_hash_queue(page);
 }
@@ -628,8 +628,7 @@
  */
 void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index)
 {
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 
 	page->index = index;
 	page_cache_get(page);
@@ -2078,8 +2077,7 @@
 
 	dir = pgd_offset(vma->vm_mm, address);
 	flush_cache_range(vma->vm_mm, end - size, end);
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		error |= filemap_sync_pmd_range(dir, address, end - address, vma, flags);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
diff -urN linux-2.4.18-pre7/mm/slab.c linux/mm/slab.c
--- linux-2.4.18-pre7/mm/slab.c	Thu Jan 24 13:48:18 2002
+++ linux/mm/slab.c	Fri Jan 25 18:06:51 2002
@@ -666,8 +666,7 @@
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
@@ -811,8 +810,7 @@
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
 
 			/* The name field is constant - no lock needed. */
-			if (!strcmp(pc->name, name))
-				BUG();
+			BUG_ON(!strcmp(pc->name, name));
 		}
 	}
 
@@ -1095,8 +1093,8 @@
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
 	 */
-	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
-		BUG();
+	BUG_ON(flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW));
+
 	if (flags & SLAB_NO_GROW)
 		return 0;
 
diff -urN linux-2.4.18-pre7/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.4.18-pre7/mm/vmscan.c	Thu Jan 24 13:48:18 2002
+++ linux/mm/vmscan.c	Fri Jan 25 18:05:14 2002
@@ -234,8 +234,8 @@
 	pgdir = pgd_offset(mm, address);
 
 	end = vma->vm_end;
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
+
 	do {
 		count = swap_out_pgd(mm, vma, pgdir, address, end, count, classzone);
 		if (!count)
@@ -354,10 +354,8 @@
 
 		page = list_entry(entry, struct page, lru);
 
-		if (unlikely(!PageLRU(page)))
-			BUG();
-		if (unlikely(PageActive(page)))
-			BUG();
+		BUG_ON(!PageLRU(page));
+		BUG_ON(PageActive(page))
 
 		list_del(entry);
 		list_add(entry, &inactive_list);


