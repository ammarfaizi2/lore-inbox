Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUBTFKi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 00:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267479AbUBTFKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 00:10:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17109 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267540AbUBTFKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 00:10:13 -0500
From: Daniel Phillips <phillips@arcor.de>
To: paulmck@us.ibm.com
Subject: Re: Non-GPL export of invalidate_mmap_range
Date: Fri, 20 Feb 2004 00:07:25 -0500
User-Agent: KMail/1.5.4
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <20040216190927.GA2969@us.ibm.com> <200402192106.02086.phillips@arcor.de> <20040219194751.GN1269@us.ibm.com>
In-Reply-To: <20040219194751.GN1269@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402200007.25832.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 February 2004 14:47, Paul E. McKenney wrote:
> OK, I surrender.  I got some private email agreeing with this
> viewpoint.  Any dissenters, speak soon, or...

An implementation is going to look something like the patch below. 
Unfortunately I don't think there is a way around passing an extra parameter
all the way down the unmap call chain.  Doubly unfortunately, this doesn't
give any benefit at all to anybody who doesn't use a clustered filesystem
(which is nearly everybody) while there is a marginal cost.  Do you know a
better way?  Anyway, this is the price of correct MAP_PRIVATE semantics for
clustered filesystems.  At least I have quantified it so we can decide if it's
worth it.  (My opinion: correctness is always worth it.)

Regards,

Daniel

--- 2.6.3.clean/include/linux/mm.h	2004-02-17 22:57:13.000000000 -0500
+++ 2.6.3/include/linux/mm.h	2004-02-19 23:18:08.000000000 -0500
@@ -434,9 +434,7 @@
 			unsigned long size);
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted);
-void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			unsigned long address, unsigned long size);
+		unsigned long end_addr, unsigned long *nr_accounted, int zap);
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
@@ -444,8 +442,7 @@
 			unsigned long size, pgprot_t prot);
 
 extern void invalidate_mmap_range(struct address_space *mapping,
-				  loff_t const holebegin,
-				  loff_t const holelen);
+			  loff_t const holebegin,  loff_t const holelen, int zap);
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
--- 2.6.3.clean/mm/memory.c	2004-02-17 22:57:47.000000000 -0500
+++ 2.6.3/mm/memory.c	2004-02-19 23:48:23.000000000 -0500
@@ -386,7 +386,7 @@
 
 static void
 zap_pte_range(struct mmu_gather *tlb, pmd_t * pmd,
-		unsigned long address, unsigned long size)
+		unsigned long address, unsigned long size, int zap)
 {
 	unsigned long offset;
 	pte_t *ptep;
@@ -414,7 +414,7 @@
 			tlb_remove_tlb_entry(tlb, ptep, address+offset);
 			if (pfn_valid(pfn)) {
 				struct page *page = pfn_to_page(pfn);
-				if (!PageReserved(page)) {
+				if (!PageReserved(page) && (zap || (page->mapping && !PageSwapCache(page)))) {
 					if (pte_dirty(pte))
 						set_page_dirty(page);
 					if (page->mapping && pte_young(pte) &&
@@ -436,7 +436,7 @@
 
 static void
 zap_pmd_range(struct mmu_gather *tlb, pgd_t * dir,
-		unsigned long address, unsigned long size)
+		unsigned long address, unsigned long size, int zap)
 {
 	pmd_t * pmd;
 	unsigned long end;
@@ -453,14 +453,14 @@
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address);
-		address = (address + PMD_SIZE) & PMD_MASK; 
+		zap_pte_range(tlb, pmd, address, end - address, zap);
+		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
 }
 
-void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			unsigned long address, unsigned long end)
+static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			unsigned long address, unsigned long end, int zap)
 {
 	pgd_t * dir;
 
@@ -474,7 +474,7 @@
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
-		zap_pmd_range(tlb, dir, address, end - address);
+		zap_pmd_range(tlb, dir, address, end - address, zap);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -524,7 +524,7 @@
  */
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted)
+		unsigned long end_addr, unsigned long *nr_accounted, int zap)
 {
 	unsigned long zap_bytes = ZAP_BLOCK_SIZE;
 	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
@@ -568,7 +568,7 @@
 				tlb_start_valid = 1;
 			}
 
-			unmap_page_range(*tlbp, vma, start, start + block);
+			unmap_page_range(*tlbp, vma, start, start + block, zap);
 			start += block;
 			zap_bytes -= block;
 			if ((long)zap_bytes > 0)
@@ -594,8 +594,8 @@
  * @address: starting address of pages to zap
  * @size: number of bytes to zap
  */
-void zap_page_range(struct vm_area_struct *vma,
-			unsigned long address, unsigned long size)
+void invalidate_page_range(struct vm_area_struct *vma,
+			unsigned long address, unsigned long size, int zap)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather *tlb;
@@ -612,11 +612,17 @@
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
-	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted);
+	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, zap);
 	tlb_finish_mmu(tlb, address, end);
 	spin_unlock(&mm->page_table_lock);
 }
 
+void zap_page_range(struct vm_area_struct *vma,
+			unsigned long address, unsigned long size)
+{
+	invalidate_page_range(vma, address, size, 1);
+}
+
 /*
  * Do a quick page-table lookup for a single page.
  * mm->page_table_lock must be held.
@@ -1095,9 +1101,9 @@
 		    	continue;	/* Mapping disjoint from hole. */
 		zba = (hba <= vba) ? vba : hba;
 		zea = (vea <= hea) ? vea : hea;
-		zap_page_range(vp,
+		invalidate_page_range(vp,
 			       ((zba - vba) << PAGE_SHIFT) + vp->vm_start,
-			       (zea - zba + 1) << PAGE_SHIFT);
+			       (zea - zba + 1) << PAGE_SHIFT, 1);
 	}
 }
 
@@ -1116,7 +1122,7 @@
  * end of the file.
  */
 void invalidate_mmap_range(struct address_space *mapping,
-		      loff_t const holebegin, loff_t const holelen)
+		      loff_t const holebegin, loff_t const holelen, int zap)
 {
 	unsigned long hba = holebegin >> PAGE_SHIFT;
 	unsigned long hlen = (holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -1156,7 +1162,7 @@
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

