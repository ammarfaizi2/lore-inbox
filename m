Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUBYVKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUBYVKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:10:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41882 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261499AbUBYVHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:07:16 -0500
From: Daniel Phillips <phillips@arcor.de>
To: paulmck@us.ibm.com
Subject: [RFC] Distributed mmap API
Date: Wed, 25 Feb 2004 16:04:19 -0500
User-Agent: KMail/1.5.4
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <20040216190927.GA2969@us.ibm.com> <200402211400.16779.phillips@arcor.de> <20040222233911.GB1311@us.ibm.com>
In-Reply-To: <20040222233911.GB1311@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402251604.19040.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the function formerly known as invalidate_mmap_range, with the
addition of a new code path in the zap_ call chain to handle MAP_PRIVATE
properly.  This function by itself is enough to support a crude but useful
form of distributed mmap where a shared file is cached only on one cluster
node at a time.

To use this, the distributed filesystem has to hook do_no_page to intercept
page faults and carry out the needed global locking.  The locking itself does
not require any new kernel hooks.  In brief, the patch here and another patch
to be presented for the do_no_page hook, together provide the core kernel API
for a simplified, distributed mmap.  (Note that there may be a workaround for
the lack of a do_no_page hook, but certainly not as simple and robust.)

To put this in perspective, I'll mention the two big limitations of the
simplified API:

  1) Invalidation is always a whole file at a time
  2) Multiple readers may not cache the same data simultaneously

To handle sub-file cache granularity, we also need to be able to flush dirty
data and evict cache pages with sub-file granularity, giving a trio of cache
management functions:

    unmap_mapping_range(mapping, start, length) /* this patch */
    write_mapping_range(mapping, start, length) /* start IO for dirty cache */
    evict_mapping_range(mapping, start, length) /* wait on IO and evict cache */

To handle (2) above, the distributed filesystem will need to hook and modify
the behaviour of do_wp_page so that it can intercept memory writes to shared
cache pages.

To summarize the current proposal, and where we need to go in the future:

  Simple core kernel API for simplistic distributed memory map
  ------------------------------------------------------------

     - unmap_mapping_range export (this patch)
     - do_no_page hook

  Improved core kernel API for optimal distributed memory map
  -----------------------------------------------------------

     - unmap_mapping_range export (this patch)
     - write_mapping_range export
     - evict_mapping_range export
     - do_no_page hook
     - do_wp_page hook

There's no big rush to move on to the optimal version just now, since the simplistic
version is already a big step forward.

I'd like to take this opportunity to apologize to Paul for derailing his more
modest proposal, but unfortunately, the semantics that could be obtained that
way are fatally flawed: private mmaps just won't work.  What I've written here
is about the minimum that supports acceptable mmap semantics.

And finally, the EXPORT_SYMBOL_GPL issue: after much fretting I've changed it
to just EXPORT_SYMBOL in this patch, because I feel that we have better ways
to further our goals of free and open software than to try to use this
particular API as a battering ram.  Of course it's not my decision, I just
want to register my vote here.

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
+++ 2.6.3/mm/memory.c	2004-02-25 13:34:57.000000000 -0500
@@ -384,9 +384,13 @@
 	return -ENOMEM;
 }
 
-static void
-zap_pte_range(struct mmu_gather *tlb, pmd_t * pmd,
-		unsigned long address, unsigned long size)
+static inline int is_anon(struct page *page)
+{
+	return !page->mapping || PageSwapCache(page);
+}
+
+static void zap_pte_range(struct mmu_gather *tlb, pmd_t * pmd,
+		unsigned long address, unsigned long size, int all)
 {
 	unsigned long offset;
 	pte_t *ptep;
@@ -409,8 +413,9 @@
 			continue;
 		if (pte_present(pte)) {
 			unsigned long pfn = pte_pfn(pte);
-
-			pte = ptep_get_and_clear(ptep);
+			if (unlikely(!all) && is_anon(pfn_to_page(pfn)))
+				continue;
+			pte = ptep_get_and_clear(ptep); /* get dirty bit atomically */
 			tlb_remove_tlb_entry(tlb, ptep, address+offset);
 			if (pfn_valid(pfn)) {
 				struct page *page = pfn_to_page(pfn);
@@ -426,17 +431,19 @@
 				}
 			}
 		} else {
-			if (!pte_file(pte))
+			if (!pte_file(pte)) {
+				if (!all)
+					continue;
 				free_swap_and_cache(pte_to_swp_entry(pte));
+			}
 			pte_clear(ptep);
 		}
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
@@ -453,14 +460,14 @@
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
 
@@ -474,7 +481,7 @@
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
-		zap_pmd_range(tlb, dir, address, end - address);
+		zap_pmd_range(tlb, dir, address, end - address, all);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -524,7 +531,7 @@
  */
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted)
+		unsigned long end_addr, unsigned long *nr_accounted, int all)
 {
 	unsigned long zap_bytes = ZAP_BLOCK_SIZE;
 	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
@@ -568,7 +575,7 @@
 				tlb_start_valid = 1;
 			}
 
-			unmap_page_range(*tlbp, vma, start, start + block);
+			unmap_page_range(*tlbp, vma, start, start + block, all);
 			start += block;
 			zap_bytes -= block;
 			if ((long)zap_bytes > 0)
@@ -594,8 +601,8 @@
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
@@ -612,7 +619,7 @@
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
-	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted);
+	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, all);
 	tlb_finish_mmu(tlb, address, end);
 	spin_unlock(&mm->page_table_lock);
 }
@@ -1071,10 +1078,8 @@
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
@@ -1095,9 +1100,9 @@
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
 
@@ -1115,8 +1120,8 @@
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
@@ -1133,12 +1138,19 @@
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
@@ -1156,7 +1168,7 @@
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

