Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUCCDDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUCCDDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:03:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65451 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261671AbUCCDCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:02:52 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Distributed mmap API
Date: Tue, 2 Mar 2004 22:00:38 -0500
User-Agent: KMail/1.5.4
Cc: paulmck@us.ibm.com, sct@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040216190927.GA2969@us.ibm.com> <200402251604.19040.phillips@arcor.de> <20040225140727.0cde826e.akpm@osdl.org>
In-Reply-To: <20040225140727.0cde826e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403022200.39633.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 February 2004 17:07, Andrew Morton wrote:
> I think you need to check pfn_valid() before running is_anon(pfn_to_page())

Hi Andrew,

Here is a rearranged zap_pte_range that avoids any operations for out-of-range
pfns.  The only annoyance with this factoring is that tlb_remove_tlb_entry is
expanded in two places.  For most architectures the macro is null anyway, and
for the rest it's hardly any code at all, except for ppc64, which has
__tlb_remove_tlb_entry as an inline that looks like it expands into a fair
amount of code.  But probably not enough to worry about.

I took the opportunity to remove some indents by liberal use of continues. 
This version reads pretty easily.

	if (pte_present(pte)) {
		unsigned long pfn = pte_pfn(pte);
		struct page *page;

		if (unlikely(!pfn_valid(pfn))) {
			pte_clear(ptep);
			tlb_remove_tlb_entry(tlb, ptep, address+offset);
			continue;
		}
		page = pfn_to_page(pfn);
		if (unlikely(!all) && is_anon(page))
			continue;
		pte = ptep_get_and_clear(ptep); /* get dirty bit atomically */
		tlb_remove_tlb_entry(tlb, ptep, address+offset);
		if (PageReserved(page))
			continue;
		if (pte_dirty(pte))
			set_page_dirty(page);
		if (page->mapping && pte_young(pte) && !PageSwapCache(page))
			mark_page_accessed(page);
		tlb->freed++;
		page_remove_rmap(page, ptep);
		tlb_remove_page(tlb, page);
		continue;
	}

I also tried your "if (page)" suggestion, which looks like this:

	if (pte_present(pte)) {
		unsigned long pfn = pte_pfn(pte);
		struct page *page = NULL;

		if (likely(pfn_valid(pfn))) {
			page = pfn_to_page(pfn);
			if (unlikely(!all) && is_anon(page))
				continue;
		}
		pte = ptep_get_and_clear(ptep); /* get dirty bit atomically */
		tlb_remove_tlb_entry(tlb, ptep, address+offset);
		if (unlikely(!page) || PageReserved(page))
			continue;
		if (pte_dirty(pte))
			set_page_dirty(page);
		if (page->mapping && pte_young(pte) && !PageSwapCache(page))
			mark_page_accessed(page);
		tlb->freed++;
		page_remove_rmap(page, ptep);
		tlb_remove_page(tlb, page);
		continue;
	}

It came out ok too - only one "if (page)", a little shorter and no extra macro
expansions, though it's a little harder to follow and might be microscopically
slower.  The complete patch below uses the first form, and does away with the
is_anon inline.

Regards,

Daniel

--- 2.6.3.clean/include/linux/mm.h	2004-02-17 22:57:13.000000000 -0500
+++ 2.6.3/include/linux/mm.h	2004-02-21 12:59:16.000000000 -0500
@@ -430,23 +430,23 @@
 void shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
 
-void zap_page_range(struct vm_area_struct *vma, unsigned long address,
-			unsigned long size);
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted);
-void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			unsigned long address, unsigned long size);
+		unsigned long end_addr, unsigned long *nr_accounted, int zap);
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
 int zeromap_page_range(struct vm_area_struct *vma, unsigned long from,
 			unsigned long size, pgprot_t prot);
-
-extern void invalidate_mmap_range(struct address_space *mapping,
-				  loff_t const holebegin,
-				  loff_t const holelen);
+extern void invalidate_filemap_range(struct address_space *mapping, loff_t const start, loff_t const length);
 extern int vmtruncate(struct inode * inode, loff_t offset);
+void invalidate_page_range(struct vm_area_struct *vma, unsigned long address, unsigned long size, int all);
+
+static inline void zap_page_range(struct vm_area_struct *vma, ulong address, ulong size)
+{
+	invalidate_page_range(vma, address, size, 1);
+}
+
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
--- 2.6.3.clean/mm/memory.c	2004-02-17 22:57:47.000000000 -0500
+++ 2.6.3/mm/memory.c	2004-03-02 20:59:58.000000000 -0500
@@ -384,9 +384,8 @@
 	return -ENOMEM;
 }
 
-static void
-zap_pte_range(struct mmu_gather *tlb, pmd_t * pmd,
-		unsigned long address, unsigned long size)
+static void zap_pte_range(struct mmu_gather *tlb, pmd_t * pmd,
+		unsigned long address, unsigned long size, int all)
 {
 	unsigned long offset;
 	pte_t *ptep;
@@ -409,34 +408,41 @@
 			continue;
 		if (pte_present(pte)) {
 			unsigned long pfn = pte_pfn(pte);
+			struct page *page;
 
-			pte = ptep_get_and_clear(ptep);
-			tlb_remove_tlb_entry(tlb, ptep, address+offset);
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-				if (!PageReserved(page)) {
-					if (pte_dirty(pte))
-						set_page_dirty(page);
-					if (page->mapping && pte_young(pte) &&
-							!PageSwapCache(page))
-						mark_page_accessed(page);
-					tlb->freed++;
-					page_remove_rmap(page, ptep);
-					tlb_remove_page(tlb, page);
-				}
+			if (unlikely(!pfn_valid(pfn))) {
+				pte_clear(ptep);
+				tlb_remove_tlb_entry(tlb, ptep, address+offset);
+				continue;
 			}
-		} else {
-			if (!pte_file(pte))
-				free_swap_and_cache(pte_to_swp_entry(pte));
-			pte_clear(ptep);
+			page = pfn_to_page(pfn);
+			if (unlikely(!all) && (!page->mapping || PageSwapCache(page)))
+				continue;
+			pte = ptep_get_and_clear(ptep); /* get dirty bit atomically */
+			tlb_remove_tlb_entry(tlb, ptep, address+offset);
+			if (PageReserved(page))
+				continue;
+			if (pte_dirty(pte))
+				set_page_dirty(page);
+			if (page->mapping && pte_young(pte) && !PageSwapCache(page))
+				mark_page_accessed(page);
+			tlb->freed++;
+			page_remove_rmap(page, ptep);
+			tlb_remove_page(tlb, page);
+			continue;
 		}
+		if (!pte_file(pte)) {
+			if (!all)
+				continue;
+			free_swap_and_cache(pte_to_swp_entry(pte));
+		}
+		pte_clear(ptep);
 	}
 	pte_unmap(ptep-1);
 }
 
-static void
-zap_pmd_range(struct mmu_gather *tlb, pgd_t * dir,
-		unsigned long address, unsigned long size)
+static void zap_pmd_range(struct mmu_gather *tlb, pgd_t * dir,
+		unsigned long address, unsigned long size, int all)
 {
 	pmd_t * pmd;
 	unsigned long end;
@@ -453,14 +459,14 @@
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address);
-		address = (address + PMD_SIZE) & PMD_MASK; 
+		zap_pte_range(tlb, pmd, address, end - address, all);
+		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
 }
 
-void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			unsigned long address, unsigned long end)
+static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long address, unsigned long end, int all)
 {
 	pgd_t * dir;
 
@@ -474,7 +480,7 @@
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
-		zap_pmd_range(tlb, dir, address, end - address);
+		zap_pmd_range(tlb, dir, address, end - address, all);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -524,7 +530,7 @@
  */
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted)
+		unsigned long end_addr, unsigned long *nr_accounted, int all)
 {
 	unsigned long zap_bytes = ZAP_BLOCK_SIZE;
 	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
@@ -568,7 +574,7 @@
 				tlb_start_valid = 1;
 			}
 
-			unmap_page_range(*tlbp, vma, start, start + block);
+			unmap_page_range(*tlbp, vma, start, start + block, all);
 			start += block;
 			zap_bytes -= block;
 			if ((long)zap_bytes > 0)
@@ -594,8 +600,8 @@
  * @address: starting address of pages to zap
  * @size: number of bytes to zap
  */
-void zap_page_range(struct vm_area_struct *vma,
-			unsigned long address, unsigned long size)
+void invalidate_page_range(struct vm_area_struct *vma,
+		unsigned long address, unsigned long size, int all)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather *tlb;
@@ -612,7 +618,7 @@
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
-	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted);
+	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, all);
 	tlb_finish_mmu(tlb, address, end);
 	spin_unlock(&mm->page_table_lock);
 }
@@ -1071,10 +1077,8 @@
  * Both hba and hlen are page numbers in PAGE_SIZE units.
  * An hlen of zero blows away the entire portion file after hba.
  */
-static void
-invalidate_mmap_range_list(struct list_head *head,
-			   unsigned long const hba,
-			   unsigned long const hlen)
+static void invalidate_mmap_range_list(struct list_head *head,
+		 unsigned long const hba,  unsigned long const hlen, int all)
 {
 	struct list_head *curr;
 	unsigned long hea;	/* last page of hole. */
@@ -1095,9 +1099,9 @@
 		    	continue;	/* Mapping disjoint from hole. */
 		zba = (hba <= vba) ? vba : hba;
 		zea = (vea <= hea) ? vea : hea;
-		zap_page_range(vp,
+		invalidate_page_range(vp,
 			       ((zba - vba) << PAGE_SHIFT) + vp->vm_start,
-			       (zea - zba + 1) << PAGE_SHIFT);
+			       (zea - zba + 1) << PAGE_SHIFT, all);
 	}
 }
 
@@ -1115,8 +1119,8 @@
  * up to a PAGE_SIZE boundary.  A holelen of zero truncates to the
  * end of the file.
  */
-void invalidate_mmap_range(struct address_space *mapping,
-		      loff_t const holebegin, loff_t const holelen)
+static void invalidate_mmap_range(struct address_space *mapping,
+		loff_t const holebegin, loff_t const holelen, int all)
 {
 	unsigned long hba = holebegin >> PAGE_SHIFT;
 	unsigned long hlen = (holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -1133,12 +1137,19 @@
 	/* Protect against page fault */
 	atomic_inc(&mapping->truncate_count);
 	if (unlikely(!list_empty(&mapping->i_mmap)))
-		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen);
+		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen, all);
 	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
-		invalidate_mmap_range_list(&mapping->i_mmap_shared, hba, hlen);
+		invalidate_mmap_range_list(&mapping->i_mmap_shared, hba, hlen, all);
 	up(&mapping->i_shared_sem);
 }
-EXPORT_SYMBOL_GPL(invalidate_mmap_range);
+
+ void unmap_mapping_range(struct address_space *mapping,
+		loff_t const start, loff_t const length)
+{
+	invalidate_mmap_range(mapping, start, length, 0);
+}
+
+EXPORT_SYMBOL(unmap_mapping_range);
 
 /*
  * Handle all mappings that got truncated by a "truncate()"
@@ -1156,7 +1167,7 @@
 	if (inode->i_size < offset)
 		goto do_expand;
 	i_size_write(inode, offset);
-	invalidate_mmap_range(mapping, offset + PAGE_SIZE - 1, 0);
+	invalidate_mmap_range(mapping, offset + PAGE_SIZE - 1, 0, 1);
 	truncate_inode_pages(mapping, offset);
 	goto out_truncate;
 
--- 2.6.3.clean/mm/mmap.c	2004-02-17 22:58:32.000000000 -0500
+++ 2.6.3/mm/mmap.c	2004-02-19 22:46:01.000000000 -0500
@@ -1134,7 +1134,7 @@
 
 	lru_add_drain();
 	tlb = tlb_gather_mmu(mm, 0);
-	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted);
+	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, 1);
 	vm_unacct_memory(nr_accounted);
 
 	if (is_hugepage_only_range(start, end - start))
@@ -1436,7 +1436,7 @@
 	flush_cache_mm(mm);
 	/* Use ~0UL here to ensure all VMAs in the mm are unmapped */
 	mm->map_count -= unmap_vmas(&tlb, mm, mm->mmap, 0,
-					~0UL, &nr_accounted);
+					~0UL, &nr_accounted, 1);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
 	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);

