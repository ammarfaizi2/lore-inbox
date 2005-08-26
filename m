Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbVHZRHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVHZRHv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbVHZRB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:01:57 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:28821 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965118AbVHZRBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:01:54 -0400
Subject: [patch 15/18] remap_file_pages protection support: fix pte clearing on accessible vmas
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:56 +0200
Message-Id: <20050826165356.3F8CC25484D@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Ingo Molnar <mingo@elte.hu>

This patch is only needed if nonuniform VMAs can have protections different
from PROT_NONE.

It corrects the previous optimization: instead of clearing the PTEs, it simply
marks them as pte_file unreadable ones.

This is done by fixing the code, by adding another field in "zap_details",
i.e. ->prot_none_ptes. I've also fixed the other callers to clear this
parameter.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/mm.h |    3 +++
 linux-2.6.git-paolo/mm/filemap.c       |    6 +++++-
 linux-2.6.git-paolo/mm/memory.c        |   26 +++++++++++++++++++-------
 linux-2.6.git-paolo/mm/shmem.c         |    6 +++++-
 4 files changed, 32 insertions(+), 9 deletions(-)

diff -puN include/linux/mm.h~rfp-avoid-lookup-pages-miss-mapping include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-avoid-lookup-pages-miss-mapping	2005-08-25 13:07:41.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-25 13:07:42.000000000 +0200
@@ -686,6 +686,9 @@ struct zap_details {
 	pgoff_t last_index;			/* Highest page->index to unmap */
 	spinlock_t *i_mmap_lock;		/* For unmap_mapping_range: */
 	unsigned long truncate_count;		/* Compare vm_truncate_count */
+	unsigned prot_none_ptes : 1;		/* If 1, set all PTE's to
+						   PROT_NONE ones, and all other
+						   fields must be clear */
 };
 
 unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
diff -puN mm/filemap.c~rfp-avoid-lookup-pages-miss-mapping mm/filemap.c
--- linux-2.6.git/mm/filemap.c~rfp-avoid-lookup-pages-miss-mapping	2005-08-25 13:07:41.000000000 +0200
+++ linux-2.6.git-paolo/mm/filemap.c	2005-08-25 13:07:42.000000000 +0200
@@ -1500,12 +1500,16 @@ int filemap_populate(struct vm_area_stru
 	 */
 	if ((vma->vm_flags & VM_SHARED) &&
 			(pgprot_val(prot) == pgprot_val(__S000))) {
+		struct zap_details details = {
+			.prot_none_ptes = 1,
+		};
+
 		/* Still do error-checking! */
 		size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 		if (pgoff + (len >> PAGE_CACHE_SHIFT) > size)
 			return -EINVAL;
 
-		zap_page_range(vma, addr, len, NULL);
+		zap_page_range(vma, addr, len, &details);
 		return 0;
 	}
 
diff -puN mm/memory.c~rfp-avoid-lookup-pages-miss-mapping mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-avoid-lookup-pages-miss-mapping	2005-08-25 13:07:41.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-25 13:07:42.000000000 +0200
@@ -523,8 +523,11 @@ static void zap_pte_range(struct mmu_gat
 	pte = pte_offset_map(pmd, addr);
 	do {
 		pte_t ptent = *pte;
-		if (pte_none(ptent))
+		if (pte_none(ptent)) {
+			if (unlikely(details && details->prot_none_ptes))
+				set_pte_at(mm, addr, pte, pfn_pte(0, __S000));
 			continue;
+		}
 		if (pte_present(ptent)) {
 			struct page *page = NULL;
 			unsigned long pfn = pte_pfn(ptent);
@@ -533,7 +536,8 @@ static void zap_pte_range(struct mmu_gat
 				if (PageReserved(page))
 					page = NULL;
 			}
-			if (unlikely(details) && page) {
+			if (unlikely(details && !details->prot_none_ptes) &&
+					page) {
 				/*
 				 * unmap_shared_mapping_pages() wants to
 				 * invalidate cache without truncating:
@@ -553,9 +557,12 @@ static void zap_pte_range(struct mmu_gat
 			}
 			ptent = ptep_get_and_clear(tlb->mm, addr, pte);
 			tlb_remove_tlb_entry(tlb, pte, addr);
+			if (unlikely(details && details->prot_none_ptes))
+				set_pte_at(mm, addr, pte, pfn_pte(0, __S000));
 			if (unlikely(!page))
 				continue;
-			if (unlikely(details) && details->nonlinear_vma) {
+			if (unlikely(details) && details->nonlinear_vma &&
+					!details->prot_none_ptes) {
 				save_nonlinear_pte(ptent, pte,
 						details->nonlinear_vma,
 						tlb->mm, page, addr);
@@ -575,11 +582,14 @@ static void zap_pte_range(struct mmu_gat
 		 * If details->check_mapping, we leave swap entries;
 		 * if details->nonlinear_vma, we leave file entries.
 		 */
-		if (unlikely(details))
+		if (unlikely(details) && !details->prot_none_ptes)
 			continue;
-		if (!pte_file(ptent))
+		if (likely(!pte_file(ptent)))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
-		pte_clear(tlb->mm, addr, pte);
+		if (unlikely(details && details->prot_none_ptes))
+			set_pte_at(mm, addr, pte, pfn_pte(0, __S000));
+		else
+			pte_clear(tlb->mm, addr, pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
 }
@@ -623,7 +633,8 @@ static void unmap_page_range(struct mmu_
 	pgd_t *pgd;
 	unsigned long next;
 
-	if (details && !details->check_mapping && !details->nonlinear_vma)
+	if (details && !details->check_mapping && !details->nonlinear_vma &&
+			!details->prot_none_ptes)
 		details = NULL;
 
 	BUG_ON(addr >= end);
@@ -1524,6 +1535,7 @@ void unmap_mapping_range(struct address_
 	if (details.last_index < details.first_index)
 		details.last_index = ULONG_MAX;
 	details.i_mmap_lock = &mapping->i_mmap_lock;
+	details.prot_none_ptes = 0;
 
 	spin_lock(&mapping->i_mmap_lock);
 
diff -puN mm/shmem.c~rfp-avoid-lookup-pages-miss-mapping mm/shmem.c
--- linux-2.6.git/mm/shmem.c~rfp-avoid-lookup-pages-miss-mapping	2005-08-25 13:07:41.000000000 +0200
+++ linux-2.6.git-paolo/mm/shmem.c	2005-08-25 13:07:42.000000000 +0200
@@ -1191,7 +1191,11 @@ static int shmem_populate(struct vm_area
 	 */
 	if ((vma->vm_flags & VM_SHARED) &&
 			(pgprot_val(prot) == pgprot_val(__S000))) {
-		zap_page_range(vma, addr, len, NULL);
+		struct zap_details details = {
+			.prot_none_ptes = 1,
+		};
+
+		zap_page_range(vma, addr, len, &details);
 		return 0;
 	}
 
_
