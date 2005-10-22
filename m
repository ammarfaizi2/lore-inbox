Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVJVQUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVJVQUc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVJVQUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:20:32 -0400
Received: from silver.veritas.com ([143.127.12.111]:26517 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932244AbVJVQUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:20:31 -0400
Date: Sat, 22 Oct 2005 17:19:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] mm: i386 sh sh64 ready for split ptlock
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510221718100.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:20:31.0091 (UTC) FILETIME=[85A51430:01C5D724]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use pte_offset_map_lock, instead of pte_offset_map (or inappropriate
pte_offset_kernel) and mm-wide page_table_lock, in sundry arch places.

The i386 vm86 mark_screen_rdonly: yes, there was and is an assumption
that the screen fits inside the one page table, as indeed it does.

The sh __do_page_fault: which handles both kernel faults (without lock)
and user mm faults (locked - though it set_pte without locking before).

The sh64 flush_cache_range and helpers: which wrongly thought callers
held page_table_lock before (only its tlb_start_vma did, and no longer
does so); moved the flush loop down, and adjusted the large versus small
range decision to consider a range which spans page tables as large.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/i386/kernel/vm86.c |   17 +++++-------
 arch/sh/mm/fault.c      |   40 ++++++++++++++++-------------
 arch/sh64/mm/cache.c    |   66 +++++++++++++++++++++---------------------------
 3 files changed, 59 insertions(+), 64 deletions(-)

--- mm0/arch/i386/kernel/vm86.c	2005-10-17 12:05:09.000000000 +0100
+++ mm1/arch/i386/kernel/vm86.c	2005-10-22 14:06:01.000000000 +0100
@@ -134,17 +134,16 @@ struct pt_regs * fastcall save_v86_state
 	return ret;
 }
 
-static void mark_screen_rdonly(struct task_struct * tsk)
+static void mark_screen_rdonly(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte, *mapped;
+	pte_t *pte;
+	spinlock_t *ptl;
 	int i;
 
-	preempt_disable();
-	spin_lock(&tsk->mm->page_table_lock);
-	pgd = pgd_offset(tsk->mm, 0xA0000);
+	pgd = pgd_offset(mm, 0xA0000);
 	if (pgd_none_or_clear_bad(pgd))
 		goto out;
 	pud = pud_offset(pgd, 0xA0000);
@@ -153,16 +152,14 @@ static void mark_screen_rdonly(struct ta
 	pmd = pmd_offset(pud, 0xA0000);
 	if (pmd_none_or_clear_bad(pmd))
 		goto out;
-	pte = mapped = pte_offset_map(pmd, 0xA0000);
+	pte = pte_offset_map_lock(mm, pmd, 0xA0000, &ptl);
 	for (i = 0; i < 32; i++) {
 		if (pte_present(*pte))
 			set_pte(pte, pte_wrprotect(*pte));
 		pte++;
 	}
-	pte_unmap(mapped);
+	pte_unmap_unlock(pte, ptl);
 out:
-	spin_unlock(&tsk->mm->page_table_lock);
-	preempt_enable();
 	flush_tlb();
 }
 
@@ -306,7 +303,7 @@ static void do_sys_vm86(struct kernel_vm
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
-		mark_screen_rdonly(tsk);
+		mark_screen_rdonly(tsk->mm);
 	__asm__ __volatile__(
 		"xorl %%eax,%%eax; movl %%eax,%%fs; movl %%eax,%%gs\n\t"
 		"movl %0,%%esp\n\t"
--- mm0/arch/sh/mm/fault.c	2004-10-18 22:56:27.000000000 +0100
+++ mm1/arch/sh/mm/fault.c	2005-10-22 14:06:01.000000000 +0100
@@ -194,10 +194,13 @@ asmlinkage int __do_page_fault(struct pt
 			       unsigned long address)
 {
 	unsigned long addrmax = P4SEG;
-	pgd_t *dir;
+	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
 	pte_t entry;
+	struct mm_struct *mm;
+	spinlock_t *ptl;
+	int ret = 1;
 
 #ifdef CONFIG_SH_KGDB
 	if (kgdb_nofault && kgdb_bus_err_hook)
@@ -208,28 +211,28 @@ asmlinkage int __do_page_fault(struct pt
 	addrmax = P4SEG_STORE_QUE + 0x04000000;
 #endif
 
-	if (address >= P3SEG && address < addrmax)
-		dir = pgd_offset_k(address);
-	else if (address >= TASK_SIZE)
+	if (address >= P3SEG && address < addrmax) {
+		pgd = pgd_offset_k(address);
+		mm = NULL;
+	} else if (address >= TASK_SIZE)
 		return 1;
-	else if (!current->mm)
+	else if (!(mm = current->mm))
 		return 1;
 	else
-		dir = pgd_offset(current->mm, address);
+		pgd = pgd_offset(mm, address);
 
-	pmd = pmd_offset(dir, address);
-	if (pmd_none(*pmd))
+	pmd = pmd_offset(pgd, address);
+	if (pmd_none_or_clear_bad(pmd))
 		return 1;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return 1;
-	}
-	pte = pte_offset_kernel(pmd, address);
+	if (mm)
+		pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+	else
+		pte = pte_offset_kernel(pmd, address);
+
 	entry = *pte;
 	if (pte_none(entry) || pte_not_present(entry)
 	    || (writeaccess && !pte_write(entry)))
-		return 1;
+		goto unlock;
 
 	if (writeaccess)
 		entry = pte_mkdirty(entry);
@@ -251,8 +254,11 @@ asmlinkage int __do_page_fault(struct pt
 
 	set_pte(pte, entry);
 	update_mmu_cache(NULL, address, entry);
-
-	return 0;
+	ret = 0;
+unlock:
+	if (mm)
+		pte_unmap_unlock(pte, ptl);
+	return ret;
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
--- mm0/arch/sh64/mm/cache.c	2005-06-17 20:48:29.000000000 +0100
+++ mm1/arch/sh64/mm/cache.c	2005-10-22 14:06:01.000000000 +0100
@@ -584,32 +584,36 @@ static void sh64_dcache_purge_phy_page(u
 	}
 }
 
-static void sh64_dcache_purge_user_page(struct mm_struct *mm, unsigned long eaddr)
+static void sh64_dcache_purge_user_pages(struct mm_struct *mm,
+				unsigned long addr, unsigned long end)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
 	pte_t entry;
+	spinlock_t *ptl;
 	unsigned long paddr;
 
-	/* NOTE : all the callers of this have mm->page_table_lock held, so the
-	   following page table traversal is safe even on SMP/pre-emptible. */
-
-	if (!mm) return; /* No way to find physical address of page */
-	pgd = pgd_offset(mm, eaddr);
-	if (pgd_bad(*pgd)) return;
-
-	pmd = pmd_offset(pgd, eaddr);
-	if (pmd_none(*pmd) || pmd_bad(*pmd)) return;
-
-	pte = pte_offset_kernel(pmd, eaddr);
-	entry = *pte;
-	if (pte_none(entry) || !pte_present(entry)) return;
-
-	paddr = pte_val(entry) & PAGE_MASK;
-
-	sh64_dcache_purge_coloured_phy_page(paddr, eaddr);
+	if (!mm)
+		return; /* No way to find physical address of page */
 
+	pgd = pgd_offset(mm, addr);
+	if (pgd_bad(*pgd))
+		return;
+
+	pmd = pmd_offset(pgd, addr);
+	if (pmd_none(*pmd) || pmd_bad(*pmd))
+		return;
+
+	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	do {
+		entry = *pte;
+		if (pte_none(entry) || !pte_present(entry))
+			continue;
+		paddr = pte_val(entry) & PAGE_MASK;
+		sh64_dcache_purge_coloured_phy_page(paddr, addr);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap_unlock(pte - 1, ptl);
 }
 /****************************************************************************/
 
@@ -668,7 +672,7 @@ static void sh64_dcache_purge_user_range
 	int n_pages;
 
 	n_pages = ((end - start) >> PAGE_SHIFT);
-	if (n_pages >= 64) {
+	if (n_pages >= 64 || ((start ^ (end - 1)) & PMD_MASK)) {
 #if 1
 		sh64_dcache_purge_all();
 #else
@@ -707,20 +711,10 @@ static void sh64_dcache_purge_user_range
 		}
 #endif
 	} else {
-		/* 'Small' range */
-		unsigned long aligned_start;
-		unsigned long eaddr;
-		unsigned long last_page_start;
-
-		aligned_start = start & PAGE_MASK;
-		/* 'end' is 1 byte beyond the end of the range */
-		last_page_start = (end - 1) & PAGE_MASK;
-
-		eaddr = aligned_start;
-		while (eaddr <= last_page_start) {
-			sh64_dcache_purge_user_page(mm, eaddr);
-			eaddr += PAGE_SIZE;
-		}
+		/* Small range, covered by a single page table page */
+		start &= PAGE_MASK;	/* should already be so */
+		end = PAGE_ALIGN(end);	/* should already be so */
+		sh64_dcache_purge_user_pages(mm, start, end);
 	}
 	return;
 }
@@ -880,9 +874,7 @@ void flush_cache_range(struct vm_area_st
 	   addresses from the user address space specified by mm, after writing
 	   back any dirty data.
 
-	   Note(1), 'end' is 1 byte beyond the end of the range to flush.
-
-	   Note(2), this is called with mm->page_table_lock held.*/
+	   Note, 'end' is 1 byte beyond the end of the range to flush. */
 
 	sh64_dcache_purge_user_range(mm, start, end);
 	sh64_icache_inv_user_page_range(mm, start, end);
@@ -898,7 +890,7 @@ void flush_cache_page(struct vm_area_str
 	   the I-cache must be searched too in case the page in question is
 	   both writable and being executed from (e.g. stack trampolines.)
 
-	   Note(1), this is called with mm->page_table_lock held.
+	   Note, this is called with pte lock held.
 	   */
 
 	sh64_dcache_purge_phy_page(pfn << PAGE_SHIFT);
