Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVCWRY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVCWRY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVCWRWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:22:46 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:29047 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262749AbVCWRRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:17:33 -0500
Date: Wed, 23 Mar 2005 17:16:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] freepgt: hugetlb area is clean
In-Reply-To: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503231715340.15274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once we're strict about clearing away page tables, hugetlb_prefault can
assume there are no page tables left within its range.  Since the other
arches continue if !pte_none here, let i386 do the same.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/i386/mm/hugetlbpage.c  |   11 ++---------
 arch/ppc64/mm/hugetlbpage.c |   37 -------------------------------------
 2 files changed, 2 insertions(+), 46 deletions(-)

--- freepgt5/arch/i386/mm/hugetlbpage.c	2005-03-18 10:22:18.000000000 +0000
+++ freepgt6/arch/i386/mm/hugetlbpage.c	2005-03-23 15:41:23.000000000 +0000
@@ -246,15 +246,8 @@ int hugetlb_prefault(struct address_spac
 			goto out;
 		}
 
-		if (!pte_none(*pte)) {
-			pmd_t *pmd = (pmd_t *) pte;
-
-			page = pmd_page(*pmd);
-			pmd_clear(pmd);
-			mm->nr_ptes--;
-			dec_page_state(nr_page_table_pages);
-			page_cache_release(page);
-		}
+		if (!pte_none(*pte))
+			continue;
 
 		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
--- freepgt5/arch/ppc64/mm/hugetlbpage.c	2005-03-21 19:07:01.000000000 +0000
+++ freepgt6/arch/ppc64/mm/hugetlbpage.c	2005-03-23 15:41:23.000000000 +0000
@@ -203,8 +203,6 @@ static int prepare_low_seg_for_htlb(stru
 	unsigned long start = seg << SID_SHIFT;
 	unsigned long end = (seg+1) << SID_SHIFT;
 	struct vm_area_struct *vma;
-	unsigned long addr;
-	struct mmu_gather *tlb;
 
 	BUG_ON(seg >= 16);
 
@@ -213,41 +211,6 @@ static int prepare_low_seg_for_htlb(stru
 	if (vma && (vma->vm_start < end))
 		return -EBUSY;
 
-	/* Clean up any leftover PTE pages in the region */
-	spin_lock(&mm->page_table_lock);
-	tlb = tlb_gather_mmu(mm, 0);
-	for (addr = start; addr < end; addr += PMD_SIZE) {
-		pgd_t *pgd = pgd_offset(mm, addr);
-		pmd_t *pmd;
-		struct page *page;
-		pte_t *pte;
-		int i;
-
-		if (pgd_none(*pgd))
-			continue;
-		pmd = pmd_offset(pgd, addr);
-		if (!pmd || pmd_none(*pmd))
-			continue;
-		if (pmd_bad(*pmd)) {
-			pmd_ERROR(*pmd);
-			pmd_clear(pmd);
-			continue;
-		}
-		pte = (pte_t *)pmd_page_kernel(*pmd);
-		/* No VMAs, so there should be no PTEs, check just in case. */
-		for (i = 0; i < PTRS_PER_PTE; i++) {
-			BUG_ON(!pte_none(*pte));
-			pte++;
-		}
-		page = pmd_page(*pmd);
-		pmd_clear(pmd);
-		mm->nr_ptes--;
-		dec_page_state(nr_page_table_pages);
-		pte_free_tlb(tlb, page);
-	}
-	tlb_finish_mmu(tlb, start, end);
-	spin_unlock(&mm->page_table_lock);
-
 	return 0;
 }
 
