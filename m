Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUDSOES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbUDSODh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:03:37 -0400
Received: from mail.shareable.org ([81.29.64.88]:15780 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264434AbUDSNct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:32:49 -0400
Date: Mon, 19 Apr 2004 14:32:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Non-linear mappings and truncate/madvise(MADV_DONTNEED)
Message-ID: <20040419133240.GA14482@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of thoughts on non-linear mappings.  Vanilla 2.6.5.

I'm reading madvise_dontneed() and thinking about that zap_page_range()
call.  It'll wipe non-linear file offset ptes, won't it?

MADV_DONTNEED is actually a reasonable thing to do with a non-linear
mapping, when you no longer need some of the pages.  You could argue
that losing the offsets is acceptable in this case, but I think it's a
poor argument.  The offsets should be preserved while zapping the ptes.

Then there's vmtruncate() and invalidate_mmap_range() which calls
zap_page_range().  When you call truncate(), the non-linear offsets
appear to be lost (I'm reading the code, not testing it) for the part
of each VMA corresponding to where the linear mapping would have been.

That means (a) a peculiar part of the mapping is lost, and (b) some of
the truncated pages will stay mapped, if they're in a part of a VMA
which didn't get wiped by the linear calculation.

Do any of the latest objrmap patches fix these problems?  Have I
misdiagnosed these problems?

Both would be fixed by changing zap_page_range() to preserve the
non-linear offsets.  Here's a patch which does exactly that.  I'm sure
there's a fatal flaw: for example aren't page table pages supposed to
be empty after an mm is released?  This patch is to show an idea only...
Compiled but not tested.

Your comments would be appreciated.

Thanks,
-- Jamie

--- orig-2.6.5/mm/memory.c	2004-04-14 08:30:04.000000000 +0100
+++ dual-2.6.5/mm/memory.c	2004-04-19 13:57:30.000000000 +0100
@@ -385,10 +385,10 @@
 }
 
 static void
-zap_pte_range(struct mmu_gather *tlb, pmd_t * pmd,
+zap_pte_range(struct mmu_gather *tlb, struct vm_area_struct *vma, pmd_t * pmd,
 		unsigned long address, unsigned long size)
 {
-	unsigned long offset;
+	unsigned long offset, pgidx;
 	pte_t *ptep;
 
 	if (pmd_none(*pmd))
@@ -399,11 +399,12 @@
 		return;
 	}
 	ptep = pte_offset_map(pmd, address);
+	pgidx = ((address - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 	offset = address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
 		size = PMD_SIZE - offset;
 	size &= PAGE_MASK;
-	for (offset=0; offset < size; ptep++, offset += PAGE_SIZE) {
+	for (offset=0; offset < size; ptep++, pgidx++, offset += PAGE_SIZE) {
 		pte_t pte = *ptep;
 		if (pte_none(pte))
 			continue;
@@ -420,14 +421,18 @@
 					if (page->mapping && pte_young(pte) &&
 							!PageSwapCache(page))
 						mark_page_accessed(page);
+					/* Preserve non-linear offsets. */
+					if ((pgidx >> (PAGE_CACHE_SHIFT - PAGE_SHIFT)) != page->index) {
+						set_pte(ptep, pgoff_to_pte(page->index));
+						BUG_ON(!pte_file(*ptep));
+					}
 					tlb->freed++;
 					page_remove_rmap(page, ptep);
 					tlb_remove_page(tlb, page);
 				}
 			}
-		} else {
-			if (!pte_file(pte))
-				free_swap_and_cache(pte_to_swp_entry(pte));
+		} else if (!pte_file(pte)) { /* Preserve non-linear offsets. */
+			free_swap_and_cache(pte_to_swp_entry(pte));
 			pte_clear(ptep);
 		}
 	}
@@ -435,7 +440,7 @@
 }
 
 static void
-zap_pmd_range(struct mmu_gather *tlb, pgd_t * dir,
+zap_pmd_range(struct mmu_gather *tlb, struct vm_area_struct *vma, pgd_t * dir,
 		unsigned long address, unsigned long size)
 {
 	pmd_t * pmd;
@@ -453,7 +458,7 @@
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address);
+		zap_pte_range(tlb, vma, pmd, address, end - address);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address < end);
@@ -474,7 +479,7 @@
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
-		zap_pmd_range(tlb, dir, address, end - address);
+		zap_pmd_range(tlb, vma, dir, address, end - address);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
