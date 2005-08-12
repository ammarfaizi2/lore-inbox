Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVHLSyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVHLSyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVHLSyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:54:52 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:39339 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1750932AbVHLSsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:48:51 -0400
Subject: [patch 36/39] remap_file_pages protection support: avoid lookup of pages for PROT_NONE remapping
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:30 +0200
Message-Id: <20050812183631.31D2524E7EC@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This optimization avoid looking up pages for PROT_NONE mappings. The idea was
taken from the "wrong "historical" code for review - 1" one (the next one)
from mingo, but I fixed it, by adding another "detail" parameter. I've also
fixed the other callers to clear this parameter, and fixed madvise_dontneed()
to use memset(0) on its parameter - currently it's probably a bug.

Not even-compile tested, just written off the top of my head.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/mm.h |    1 +
 linux-2.6.git-paolo/mm/filemap.c       |   18 ++++++++++++++++++
 linux-2.6.git-paolo/mm/madvise.c       |   10 ++++++----
 linux-2.6.git-paolo/mm/memory.c        |   11 ++++++++---
 linux-2.6.git-paolo/mm/shmem.c         |   11 +++++++++++
 5 files changed, 44 insertions(+), 7 deletions(-)

diff -puN mm/filemap.c~rfp-avoid-lookup-pages-miss-mapping mm/filemap.c
--- linux-2.6.git/mm/filemap.c~rfp-avoid-lookup-pages-miss-mapping	2005-08-12 18:42:23.000000000 +0200
+++ linux-2.6.git-paolo/mm/filemap.c	2005-08-12 19:14:39.000000000 +0200
@@ -1495,6 +1495,24 @@ int filemap_populate(struct vm_area_stru
 	struct page *page;
 	int err;
 
+	/*
+	 * mapping-removal fastpath:
+	 */
+	if ((vma->vm_flags & VM_SHARED) &&
+			(pgprot_val(prot) == pgprot_val(PAGE_NONE))) {
+		struct zap_details details;
+
+		/* Still do error-checking! */
+		size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+		if (pgoff + (len >> PAGE_CACHE_SHIFT) > size)
+			return -EINVAL;
+
+		memset(&details, 0, sizeof(details));
+		details.prot_none_ptes = 1;
+		zap_page_range(vma, addr, len, &details);
+		return 0;
+	}
+
 	if (!nonblock)
 		force_page_cache_readahead(mapping, vma->vm_file,
 					pgoff, len >> PAGE_CACHE_SHIFT);
diff -puN mm/shmem.c~rfp-avoid-lookup-pages-miss-mapping mm/shmem.c
--- linux-2.6.git/mm/shmem.c~rfp-avoid-lookup-pages-miss-mapping	2005-08-12 18:42:23.000000000 +0200
+++ linux-2.6.git-paolo/mm/shmem.c	2005-08-12 19:11:52.000000000 +0200
@@ -1186,6 +1186,17 @@ static int shmem_populate(struct vm_area
 	if (pgoff >= size || pgoff + (len >> PAGE_SHIFT) > size)
 		return -EINVAL;
 
+	/*
+	 * mapping-removal fastpath:
+	 */
+	if ((vma->vm_flags & VM_SHARED) &&
+			(pgprot_val(prot) == pgprot_val(PAGE_NONE))) {
+		memset(&details, 0, sizeof(details));
+		details.prot_none_ptes = 1;
+		zap_page_range(vma, addr, len, &details);
+		return 0;
+	}
+
 	while ((long) len > 0) {
 		struct page *page = NULL;
 		int err;
diff -puN mm/memory.c~rfp-avoid-lookup-pages-miss-mapping mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-avoid-lookup-pages-miss-mapping	2005-08-12 18:44:29.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-12 19:09:50.000000000 +0200
@@ -575,11 +575,14 @@ static void zap_pte_range(struct mmu_gat
 		 * If details->check_mapping, we leave swap entries;
 		 * if details->nonlinear_vma, we leave file entries.
 		 */
-		if (unlikely(details))
+		if (unlikely(details) && !details->prot_none_ptes)
 			continue;
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
-		pte_clear(tlb->mm, addr, pte);
+		if (unlikely(details->prot_none_ptes))
+			set_pte_at(mm, addr, pte, pfn_pte(0, __S000));
+		else
+			pte_clear(tlb->mm, addr, pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
 }
@@ -623,7 +626,8 @@ static void unmap_page_range(struct mmu_
 	pgd_t *pgd;
 	unsigned long next;
 
-	if (details && !details->check_mapping && !details->nonlinear_vma)
+	if (details && !details->check_mapping && !details->nonlinear_vma &&
+			!details->prot_none_ptes)
 		details = NULL;
 
 	BUG_ON(addr >= end);
@@ -1499,6 +1503,7 @@ void unmap_mapping_range(struct address_
 	if (details.last_index < details.first_index)
 		details.last_index = ULONG_MAX;
 	details.i_mmap_lock = &mapping->i_mmap_lock;
+	details.prot_none_ptes = 0;
 
 	spin_lock(&mapping->i_mmap_lock);
 
diff -puN include/linux/mm.h~rfp-avoid-lookup-pages-miss-mapping include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-avoid-lookup-pages-miss-mapping	2005-08-12 18:44:36.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-12 19:01:52.000000000 +0200
@@ -680,6 +680,7 @@ struct zap_details {
 	pgoff_t last_index;			/* Highest page->index to unmap */
 	spinlock_t *i_mmap_lock;		/* For unmap_mapping_range: */
 	unsigned long truncate_count;		/* Compare vm_truncate_count */
+	unsigned prot_none_ptes : 1;		/* If 1, set all PTE's to PROT_NONE ones.*/
 };
 
 unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
diff -puN mm/madvise.c~rfp-avoid-lookup-pages-miss-mapping mm/madvise.c
--- linux-2.6.git/mm/madvise.c~rfp-avoid-lookup-pages-miss-mapping	2005-08-12 18:45:58.000000000 +0200
+++ linux-2.6.git-paolo/mm/madvise.c	2005-08-12 19:20:45.000000000 +0200
@@ -127,10 +127,12 @@ static long madvise_dontneed(struct vm_a
 		return -EINVAL;
 
 	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
-		struct zap_details details = {
-			.nonlinear_vma = vma,
-			.last_index = ULONG_MAX,
-		};
+		struct zap_details details;
+		memset(&details, 0, sizeof(details));
+
+		details.nonlinear_vma = vma;
+		details.last_index = ULONG_MAX;
+
 		zap_page_range(vma, start, end - start, &details);
 	} else
 		zap_page_range(vma, start, end - start, NULL);
_
