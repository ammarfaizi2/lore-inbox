Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUCWVoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbUCWVoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:44:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45449
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262859AbUCWVoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:44:09 -0500
Date: Tue, 23 Mar 2004 22:44:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: nonlinear swapping w/o pte_chains [Re: VMA_MERGING_FIXUP and patch]
Message-ID: <20040323214459.GG3682@dualathlon.random>
References: <20040322175216.GJ3649@dualathlon.random> <Pine.LNX.4.44.0403221842060.12658-100000@localhost.localdomain> <20040322195826.GA22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322195826.GA22639@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is incremental with 2.6.5-rc2-aa1 and it should allow swapping of
nonlinear mappings too. Has anybody a testcase that I can use to test
the nonlinear mapping swapping or should I write it from scratch?
This code compiles fine but it's untested at this time (I tested the
regular swapping but not the nonlinear one).

I don't think I can use the tlb gather because I've to set the pte back
immediatly, or can I? The IPI flood and huge pagetable walk with total
destruction of the address space with huge mappings will be very bad in
terms of usability during swapping of huge nonlinear vmas, but hey, if
you want to swap smoothly, you should use the vmas.

If you giveup using remap_file_pages you will get a good swapping and,
as far as there are a dozen of pages per-vma, the cost of
remap_file_pages w/ pte_chains will be the same of the cost of the vmas
w/o pte_chains, plus the vmas can be heavily merged. So remap_file_pages
really makes sense only if you would generate less than a dozen pages
per vma and you can save significant ram with the vmas and you take the
risk of the worse-swapping, or alternatively if you giveup swapping (so
if you use mlock + remap_file_pages that saves the memory for the vmas).

But in general (especially w/o pte_chains) the usage of remap_file_pages
should be strongly discouraged, unless it's a special app using mlock or
an emulator with small amounts of nonlinear address space. If you use it
don't hope to ever swap efficiently. On 64bit archs nothing but the
emulators should use it.

--- x/include/linux/objrmap.h.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/include/linux/objrmap.h	2004-03-23 22:29:53.699758112 +0100
@@ -1,5 +1,5 @@
-#ifndef _LINUX_RMAP_H
-#define _LINUX_RMAP_H
+#ifndef _LINUX_OBJRMAP_H
+#define _LINUX_OBJRMAP_H
 /*
  * Declarations for Object Reverse Mapping functions in mm/objrmap.c
  */
@@ -75,4 +75,4 @@ int FASTCALL(page_referenced(struct page
 
 #endif /* CONFIG_MMU */
 
-#endif /* _LINUX_RMAP_H */
+#endif /* _LINUX_OBJRMAP_H */
--- x/include/linux/page-flags.h.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/include/linux/page-flags.h	2004-03-23 22:30:16.940225024 +0100
@@ -71,11 +71,11 @@
 #define PG_nosave		14	/* Used for system suspend/resume */
 #define PG_maplock		15	/* lock bit for ->as.anon_vma and ->mapcount */
 
+#define PG_swapcache		16	/* SwapCache page */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
 #define PG_anon			20	/* Anonymous page */
-#define PG_swapcache		21	/* SwapCache page */
 
 
 /*
--- x/mm/vmscan.c.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/mm/vmscan.c	2004-03-22 18:39:05.000000000 +0100
@@ -313,16 +313,14 @@ shrink_list(struct list_head *page_list,
 		if (page_mapped(page) && mapping) {
 			switch (try_to_unmap(page)) {
 			case SWAP_FAIL:
-				page_map_unlock(page);
 				goto activate_locked;
 			case SWAP_AGAIN:
-				page_map_unlock(page);
 				goto keep_locked;
 			case SWAP_SUCCESS:
 				; /* try to free the page below */
 			}
-		}
-		page_map_unlock(page);
+		} else
+			page_map_unlock(page);
 
 		/*
 		 * If the page is dirty, only perform writeback if that write
--- x/mm/memory.c.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/mm/memory.c	2004-03-23 22:25:28.758035376 +0100
@@ -97,7 +97,7 @@ static inline void free_one_pmd(struct m
 
 	if (pmd_none(*dir))
 		return;
-	if (pmd_bad(*dir)) {
+	if (unlikely(pmd_bad(*dir))) {
 		pmd_ERROR(*dir);
 		pmd_clear(dir);
 		return;
@@ -115,7 +115,7 @@ static inline void free_one_pgd(struct m
 
 	if (pgd_none(*dir))
 		return;
-	if (pgd_bad(*dir)) {
+	if (unlikely(pgd_bad(*dir))) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
 		return;
@@ -232,7 +232,7 @@ int copy_page_range(struct mm_struct *ds
 		
 		if (pgd_none(*src_pgd))
 			goto skip_copy_pmd_range;
-		if (pgd_bad(*src_pgd)) {
+		if (unlikely(pgd_bad(*src_pgd))) {
 			pgd_ERROR(*src_pgd);
 			pgd_clear(src_pgd);
 skip_copy_pmd_range:	address = (address + PGDIR_SIZE) & PGDIR_MASK;
@@ -253,7 +253,7 @@ skip_copy_pmd_range:	address = (address 
 		
 			if (pmd_none(*src_pmd))
 				goto skip_copy_pte_range;
-			if (pmd_bad(*src_pmd)) {
+			if (unlikely(pmd_bad(*src_pmd))) {
 				pmd_ERROR(*src_pmd);
 				pmd_clear(src_pmd);
 skip_copy_pte_range:
@@ -324,9 +324,11 @@ skip_copy_pte_range:
 					 * Device driver pages must not be
 					 * tracked by the VM for unmapping.
 					 */
-					BUG_ON(!page_mapped(page));
-					BUG_ON(!page->mapping);
-					page_add_rmap(page, vma, address, PageAnon(page));
+					if (likely(page_mapped(page) && page->mapping))
+						page_add_rmap(page, vma, address, PageAnon(page));
+					else
+						printk("Badness in %s at %s:%d\n",
+						       __FUNCTION__, __FILE__, __LINE__);
 				} else {
 					BUG_ON(page_mapped(page));
 					BUG_ON(page->mapping);
@@ -381,7 +383,7 @@ zap_pte_range(struct mmu_gather *tlb, pm
 
 	if (pmd_none(*pmd))
 		return;
-	if (pmd_bad(*pmd)) {
+	if (unlikely(pmd_bad(*pmd))) {
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
 		return;
@@ -424,27 +426,25 @@ zap_pte_range(struct mmu_gather *tlb, pm
 
 static void
 zap_pmd_range(struct mmu_gather *tlb, pgd_t * dir,
-		unsigned long address, unsigned long size)
+		unsigned long address, unsigned long end)
 {
 	pmd_t * pmd;
-	unsigned long end;
 
 	if (pgd_none(*dir))
 		return;
-	if (pgd_bad(*dir)) {
+	if (unlikely(pgd_bad(*dir))) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
 		return;
 	}
 	pmd = pmd_offset(dir, address);
-	end = address + size;
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
 		zap_pte_range(tlb, pmd, address, end - address);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
-	} while (address < end);
+	} while (address && (address < end));
 }
 
 void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
@@ -462,7 +462,7 @@ void unmap_page_range(struct mmu_gather 
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
-		zap_pmd_range(tlb, dir, address, end - address);
+		zap_pmd_range(tlb, dir, address, end);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -632,7 +632,7 @@ follow_page(struct mm_struct *mm, unsign
 		goto out;
 	if (pmd_huge(*pmd))
 		return follow_huge_pmd(mm, address, pmd, write);
-	if (pmd_bad(*pmd))
+	if (unlikely(pmd_bad(*pmd)))
 		goto out;
 
 	ptep = pte_offset_map(pmd, address);
@@ -1429,7 +1429,9 @@ retry:
 	 * real anonymous pages, they're "device" reserved pages instead.
 	 */
 	reserved = !!(vma->vm_flags & VM_RESERVED);
-	WARN_ON(reserved == pageable);
+	if (unlikely(reserved == pageable))
+		printk("Badness in %s at %s:%d\n",
+		       __FUNCTION__, __FILE__, __LINE__);
 
 	/*
 	 * Should we do an early C-O-W break?
--- x/mm/objrmap.c.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/mm/objrmap.c	2004-03-23 22:23:27.393485592 +0100
@@ -19,6 +19,11 @@
  * Released under the General Public License (GPL).
  */
 
+/*
+ * nonlinear pagetable walking elaborated from mm/memory.c under
+ * Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ */
+
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
@@ -62,7 +67,7 @@ static inline void validate_anon_vma_fin
  * 
  * It is the caller's responsibility to unmap the pte if it is returned.
  */
-static inline pte_t *
+static pte_t *
 find_pte(struct vm_area_struct *vma, struct page *page, unsigned long *addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -120,7 +125,14 @@ page_referenced_one(struct vm_area_struc
 	pte_t *pte;
 	int referenced = 0;
 
-	if (!spin_trylock(&mm->page_table_lock))
+	/*
+	 * Tracking the referenced info is too expensive
+	 * for nonlinear mappings.
+	 */
+	if (vma->vm_flags & VM_NONLINEAR)
+		goto out;
+
+	if (unlikely(!spin_trylock(&mm->page_table_lock)))
 		goto out;
 
 	pte = find_pte(vma, page, NULL);
@@ -158,7 +170,7 @@ page_referenced_inode(struct page *page)
 
 	BUG_ON(PageSwapCache(page));
 
-	if (down_trylock(&mapping->i_shared_sem))
+	if (unlikely(down_trylock(&mapping->i_shared_sem)))
 		goto out;
 
 	list_for_each_entry(vma, &mapping->i_mmap, shared)
@@ -212,7 +224,7 @@ int fastcall page_referenced(struct page
 	BUG_ON(!page->mapping);
 
 	if (page_test_and_clear_young(page))
-		mark_page_accessed(page);
+		referenced++;
 
 	if (TestClearPageReferenced(page))
 		referenced++;
@@ -344,38 +356,18 @@ void fastcall page_remove_rmap(struct pa
   
  out_unlock:
 	page_map_unlock(page);
+
+	if (!page_mapped(page) && page_test_and_clear_dirty(page))
+		set_page_dirty(page);
+
 	return;
 }
 
-/**
- * try_to_unmap_one - unmap a page using the object-based rmap method
- * @page: the page to unmap
- *
- * Determine whether a page is mapped in a given vma and unmap it if it's found.
- *
- * This function is strictly a helper function for try_to_unmap_inode.
- */
-static int
-try_to_unmap_one(struct vm_area_struct *vma, struct page *page)
+static void
+unmap_pte_page(struct page * page, struct vm_area_struct * vma,
+	       unsigned long address, pte_t * pte)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
-	pte_t *pte;
 	pte_t pteval;
-	int ret = SWAP_AGAIN;
-
-	if (!spin_trylock(&mm->page_table_lock))
-		return ret;
-
-	pte = find_pte(vma, page, &address);
-	if (!pte)
-		goto out;
-
-	BUG_ON(vma->vm_flags & VM_RESERVED);
-	if (vma->vm_flags & VM_LOCKED) {
-		ret =  SWAP_FAIL;
-		goto out_unmap;
-	}
 
 	flush_cache_page(vma, address);
 	pteval = ptep_clear_flush(vma, address, pte);
@@ -389,8 +381,11 @@ try_to_unmap_one(struct vm_area_struct *
 		swap_duplicate(entry);
 		set_pte(pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
+		BUG_ON(!PageAnon(page));
 	} else {
 		unsigned long pgidx;
+
+		BUG_ON(PageAnon(page));
 		/*
 		 * If a nonlinear mapping then store the file page offset
 		 * in the pte.
@@ -409,14 +404,129 @@ try_to_unmap_one(struct vm_area_struct *
 
 	BUG_ON(!page->mapcount);
 
-	mm->rss--;
+	vma->vm_mm->rss--;
 	if (!--page->mapcount && PageAnon(page))
 		anon_vma_page_unlink(page);
 	page_cache_release(page);
+}
 
-out_unmap:
-	pte_unmap(pte);
+static void
+try_to_unmap_nonlinear_pte(struct vm_area_struct * vma,
+			   pmd_t * pmd, unsigned long address, unsigned long size)
+{
+	unsigned long offset;
+	pte_t *ptep;
+
+	if (pmd_none(*pmd))
+		return;
+	if (unlikely(pmd_bad(*pmd))) {
+		pmd_ERROR(*pmd);
+		pmd_clear(pmd);
+		return;
+	}
+	ptep = pte_offset_map(pmd, address);
+	offset = address & ~PMD_MASK;
+	if (offset + size > PMD_SIZE)
+		size = PMD_SIZE - offset;
+	size &= PAGE_MASK;
+	for (offset=0; offset < size; ptep++, offset += PAGE_SIZE) {
+		pte_t pte = *ptep;
+		if (pte_none(pte))
+			continue;
+		if (pte_present(pte)) {
+			unsigned long pfn = pte_pfn(pte);
+			struct page * page;
+
+			BUG_ON(!pfn_valid(pfn));
+			page = pfn_to_page(pfn);
+#ifdef __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
+			get_page(page);
+#endif
+			unmap_pte_page(page, vma, address, ptep);
+			if (!page_mapped(page) && page_test_and_clear_dirty(page))
+				/* ugly locking */
+				set_page_dirty(page);
+#ifdef __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
+			put_page(page);
+#endif
+		}
+	}
+	pte_unmap(ptep-1);
+}
+
+static void
+try_to_unmap_nonlinear_pmd(struct vm_area_struct * vma,
+			   pgd_t * dir, unsigned long address, unsigned long end)
+{
+	pmd_t * pmd;
+
+	if (pgd_none(*dir))
+		return;
+	if (unlikely(pgd_bad(*dir))) {
+		pgd_ERROR(*dir);
+		pgd_clear(dir);
+		return;
+	}
+	pmd = pmd_offset(dir, address);
+	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
+		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
+	do {
+		try_to_unmap_nonlinear_pte(vma, pmd, address, end - address);
+		address = (address + PMD_SIZE) & PMD_MASK; 
+		pmd++;
+	} while (address && (address < end));
+}
+
+static void
+try_to_unmap_nonlinear(struct vm_area_struct *vma)
+{
+	pgd_t * dir;
+	unsigned long address = vma->vm_start, end = vma->vm_end;
+
+	dir = pgd_offset(vma->vm_mm, address);
+	do {
+		try_to_unmap_nonlinear_pmd(vma, dir, address, end);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		dir++;
+	} while (address && (address < end));
+}
+
+/**
+ * try_to_unmap_one - unmap a page using the object-based rmap method
+ * @page: the page to unmap
+ *
+ * Determine whether a page is mapped in a given vma and unmap it if it's found.
+ *
+ * This function is strictly a helper function for try_to_unmap_inode.
+ */
+static int
+try_to_unmap_one(struct vm_area_struct *vma, struct page *page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
+	pte_t *pte;
+	int ret;
+
+	BUG_ON(vma->vm_flags & VM_RESERVED);
+	if (unlikely(vma->vm_flags & VM_LOCKED))
+		return SWAP_FAIL;
+
+	ret = SWAP_AGAIN;
+	if (unlikely(!spin_trylock(&mm->page_table_lock)))
+		return ret;
+
+	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
+		try_to_unmap_nonlinear(vma);
+		goto out;
+	}
+
+	pte = find_pte(vma, page, &address);
+	if (!pte)
+		goto out;
 
+	unmap_pte_page(page, vma, address, pte);
+
+	pte_unmap(pte);
 out:
 	spin_unlock(&mm->page_table_lock);
 	return ret;
@@ -443,7 +553,7 @@ try_to_unmap_inode(struct page *page)
 
 	BUG_ON(PageSwapCache(page));
 
-	if (down_trylock(&mapping->i_shared_sem))
+	if (unlikely(down_trylock(&mapping->i_shared_sem)))
 		return ret;
 	
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
@@ -523,6 +633,11 @@ int fastcall try_to_unmap(struct page * 
 		dec_page_state(nr_mapped);
 		ret = SWAP_SUCCESS;
 	}
+	page_map_unlock(page);
+
+	if (ret == SWAP_SUCCESS && page_test_and_clear_dirty(page))
+		set_page_dirty(page);
+
 	return ret;
 }
 
