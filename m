Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVADRXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVADRXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVADRXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:23:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56333 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261822AbVADRVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:21:25 -0500
Date: Tue, 4 Jan 2005 17:21:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.10-bkcurr: major slab corruption preventing booting on ARM
Message-ID: <20050104172118.B26816@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20050104144350.A22890@flint.arm.linux.org.uk> <20050104161049.D22890@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050104161049.D22890@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 04, 2005 at 04:10:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 04:10:49PM +0000, Russell King wrote:
> On Tue, Jan 04, 2005 at 02:43:50PM +0000, Russell King wrote:
> > I've had a report from a fellow ARM hacker of their platform not
> > booting.  After they turned on slab debugging, they saw (pieced
> > together from a report on IRC):
> > 
> > Freeing init memory: 104K
> > run_init_process(/bin/bash)
> > Slab corruption: start=c0010934, len=160
> > Last user: [<c00adc54>](d_alloc+0x28/0x2d8)
> > 
> > I've just run up 2.6.10-bkcurr on a different ARM platform, and
> > encountered the following output.  It looks like there's serious
> > slab corruption issues in these kernels.
> > 
> > I'll dig a little further into the report below to see if there's
> > anything obvious.
> 
> Ok, reverting the pud_t patch fixes both these problems (the exact
> patch can be found at: http://www.home.arm.linux.org.uk/~rmk/misc/bk4-bk5
> Note that this is not a plain bk4-bk5 patch, but just the pud_t
> changes brought forward to bk6 or there abouts.)
> 
> So, something in the 4 level page table patches is causing random
> scribbling in kernel memory.

Ok, I've narrowed the problem down to something in the following patch.
Andi Kleen suggests that maybe the ARM FIRST_USER_PGD_NR got broken in
by something here.  Nick, any ideas?

diff -urN linux-2.6.10-bk4/include/linux/mm.h linux-2.6.10-bk5/include/linux/mm.h
--- linux-2.6.10-bk4/include/linux/mm.h	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.10-bk5/include/linux/mm.h	2005-01-02 04:55:30.285949371 -0800
@@ -566,7 +566,7 @@
 		struct vm_area_struct *start_vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *);
-void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr);
+void clear_page_range(struct mmu_gather *tlb, unsigned long addr, unsigned long end);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
 int zeromap_page_range(struct vm_area_struct *vma, unsigned long from,
diff -urN linux-2.6.10-bk4/mm/memory.c linux-2.6.10-bk5/mm/memory.c
--- linux-2.6.10-bk4/mm/memory.c	2004-12-24 13:34:44.000000000 -0800
+++ linux-2.6.10-bk5/mm/memory.c	2005-01-02 04:55:31.265995181 -0800
@@ -34,6 +34,8 @@
  *
  * 16.07.99  -  Support of BIGMEM added by Gerhard Wichert, Siemens AG
  *		(Gerhard.Wichert@pdb.siemens.de)
+ *
+ * Aug/Sep 2004 Changed to four level page tables (Andi Kleen)
  */
 
 #include <linux/kernel_stat.h>
@@ -98,58 +100,107 @@
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static inline void free_one_pmd(struct mmu_gather *tlb, pmd_t * dir)
+static inline void clear_pmd_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long start, unsigned long end)
 {
 	struct page *page;
 
-	if (pmd_none(*dir))
+	if (pmd_none(*pmd))
 		return;
-	if (unlikely(pmd_bad(*dir))) {
-		pmd_ERROR(*dir);
-		pmd_clear(dir);
+	if (unlikely(pmd_bad(*pmd))) {
+		pmd_ERROR(*pmd);
+		pmd_clear(pmd);
 		return;
 	}
-	page = pmd_page(*dir);
-	pmd_clear(dir);
-	dec_page_state(nr_page_table_pages);
-	tlb->mm->nr_ptes--;
-	pte_free_tlb(tlb, page);
+	if (!(start & ~PMD_MASK) && !(end & ~PMD_MASK)) {
+		page = pmd_page(*pmd);
+		pmd_clear(pmd);
+		dec_page_state(nr_page_table_pages);
+		tlb->mm->nr_ptes--;
+		pte_free_tlb(tlb, page);
+	}
 }
 
-static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
+static inline void clear_pud_range(struct mmu_gather *tlb, pud_t *pud, unsigned long start, unsigned long end)
 {
-	int j;
-	pmd_t * pmd;
+	unsigned long addr = start, next;
+	pmd_t *pmd, *__pmd;
 
-	if (pgd_none(*dir))
+	if (pud_none(*pud))
 		return;
-	if (unlikely(pgd_bad(*dir))) {
-		pgd_ERROR(*dir);
-		pgd_clear(dir);
+	if (unlikely(pud_bad(*pud))) {
+		pud_ERROR(*pud);
+		pud_clear(pud);
 		return;
 	}
-	pmd = pmd_offset(dir, 0);
-	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++)
-		free_one_pmd(tlb, pmd+j);
-	pmd_free_tlb(tlb, pmd);
+
+	pmd = __pmd = pmd_offset(pud, start);
+	do {
+		next = (addr + PMD_SIZE) & PMD_MASK;
+		if (next > end || next <= addr)
+			next = end;
+		
+		clear_pmd_range(tlb, pmd, addr, next);
+		pmd++;
+		addr = next;
+	} while (addr && (addr < end));
+
+	if (!(start & ~PUD_MASK) && !(end & ~PUD_MASK)) {
+		pud_clear(pud);
+		pmd_free_tlb(tlb, __pmd);
+	}
+}
+
+
+static inline void clear_pgd_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long start, unsigned long end)
+{
+	unsigned long addr = start, next;
+	pud_t *pud, *__pud;
+
+	if (pgd_none(*pgd))
+		return;
+	if (unlikely(pgd_bad(*pgd))) {
+		pgd_ERROR(*pgd);
+		pgd_clear(pgd);
+		return;
+	}
+
+	pud = __pud = pud_offset(pgd, start);
+	do {
+		next = (addr + PUD_SIZE) & PUD_MASK;
+		if (next > end || next <= addr)
+			next = end;
+		
+		clear_pud_range(tlb, pud, addr, next);
+		pud++;
+		addr = next;
+	} while (addr && (addr < end));
+
+	if (!(start & ~PGDIR_MASK) && !(end & ~PGDIR_MASK)) {
+		pgd_clear(pgd);
+		pud_free_tlb(tlb, __pud);
+	}
 }
 
 /*
- * This function clears all user-level page tables of a process - this
- * is needed by execve(), so that old pages aren't in the way.
+ * This function clears user-level page tables of a process.
  *
  * Must be called with pagetable lock held.
  */
-void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr)
+void clear_page_range(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
-	pgd_t * page_dir = tlb->mm->pgd;
-
-	page_dir += first;
-	do {
-		free_one_pgd(tlb, page_dir);
-		page_dir++;
-	} while (--nr);
+	unsigned long addr = start, next;
+	unsigned long i, nr = pgd_index(end + PGDIR_SIZE-1) - pgd_index(start);
+	pgd_t * pgd = pgd_offset(tlb->mm, start);
+
+	for (i = 0; i < nr; i++) {
+		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
+		if (next > end || next <= addr)
+			next = end;
+		
+		clear_pgd_range(tlb, pgd, addr, next);
+		pgd++;
+		addr = next;
+	}
 }
 
 pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
diff -urN linux-2.6.10-bk4/mm/mmap.c linux-2.6.10-bk5/mm/mmap.c
--- linux-2.6.10-bk4/mm/mmap.c	2004-12-24 13:35:00.000000000 -0800
+++ linux-2.6.10-bk5/mm/mmap.c	2005-01-02 04:55:31.385000743 -0800
@@ -1474,7 +1474,6 @@
 {
 	unsigned long first = start & PGDIR_MASK;
 	unsigned long last = end + PGDIR_SIZE - 1;
-	unsigned long start_index, end_index;
 	struct mm_struct *mm = tlb->mm;
 
 	if (!prev) {
@@ -1499,23 +1498,18 @@
 				last = next->vm_start;
 		}
 		if (prev->vm_end > first)
-			first = prev->vm_end + PGDIR_SIZE - 1;
+			first = prev->vm_end;
 		break;
 	}
 no_mmaps:
 	if (last < first)	/* for arches with discontiguous pgd indices */
 		return;
-	/*
-	 * If the PGD bits are not consecutive in the virtual address, the
-	 * old method of shifting the VA >> by PGDIR_SHIFT doesn't work.
-	 */
-	start_index = pgd_index(first);
-	if (start_index < FIRST_USER_PGD_NR)
-		start_index = FIRST_USER_PGD_NR;
-	end_index = pgd_index(last);
-	if (end_index > start_index) {
-		clear_page_tables(tlb, start_index, end_index - start_index);
-		flush_tlb_pgtables(mm, first & PGDIR_MASK, last & PGDIR_MASK);
+	if (first < FIRST_USER_PGD_NR * PGDIR_SIZE)
+		first = FIRST_USER_PGD_NR * PGDIR_SIZE;
+	/* No point trying to free anything if we're in the same pte page */
+	if ((first & PMD_MASK) < (last & PMD_MASK)) {
+		clear_page_range(tlb, first, last);
+		flush_tlb_pgtables(mm, first, last);
 	}
 }
 
@@ -1844,7 +1838,9 @@
 					~0UL, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
-	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
+	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE,
+			(TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK);
+	
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
 
 	vma = mm->mmap;


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
