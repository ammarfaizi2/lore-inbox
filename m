Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVCIWj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVCIWj4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVCIWjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:39:23 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48443 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261952AbVCIWMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:12:48 -0500
Date: Wed, 9 Mar 2005 22:12:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/15] ptwalk: unmap_page_range
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092211280.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert unmap_page_range pagetable walkers to loops using p?d_addr_end.
Move blanking of irrelevant details up to unmap_page_range as Nick did.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |  119 ++++++++++++++++++++++++++----------------------------------
 1 files changed, 53 insertions(+), 66 deletions(-)

--- ptwalk8/mm/memory.c	2005-03-09 01:37:15.000000000 +0000
+++ ptwalk9/mm/memory.c	2005-03-09 01:38:00.000000000 +0000
@@ -454,29 +454,22 @@ next_pgd:
 	return err;
 }
 
-static void zap_pte_range(struct mmu_gather *tlb,
-		pmd_t *pmd, unsigned long address,
-		unsigned long size, struct zap_details *details)
+static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
 {
-	unsigned long offset;
-	pte_t *ptep;
+	pte_t *pte;
 
 	if (pmd_none_or_clear_bad(pmd))
 		return;
-	ptep = pte_offset_map(pmd, address);
-	offset = address & ~PMD_MASK;
-	if (offset + size > PMD_SIZE)
-		size = PMD_SIZE - offset;
-	size &= PAGE_MASK;
-	if (details && !details->check_mapping && !details->nonlinear_vma)
-		details = NULL;
-	for (offset=0; offset < size; ptep++, offset += PAGE_SIZE) {
-		pte_t pte = *ptep;
-		if (pte_none(pte))
+	pte = pte_offset_map(pmd, addr);
+	do {
+		pte_t ptent = *pte;
+		if (pte_none(ptent))
 			continue;
-		if (pte_present(pte)) {
+		if (pte_present(ptent)) {
 			struct page *page = NULL;
-			unsigned long pfn = pte_pfn(pte);
+			unsigned long pfn = pte_pfn(ptent);
 			if (pfn_valid(pfn)) {
 				page = pfn_to_page(pfn);
 				if (PageReserved(page))
@@ -500,20 +493,20 @@ static void zap_pte_range(struct mmu_gat
 				     page->index > details->last_index))
 					continue;
 			}
-			pte = ptep_get_and_clear(tlb->mm, address+offset, ptep);
-			tlb_remove_tlb_entry(tlb, ptep, address+offset);
+			ptent = ptep_get_and_clear(tlb->mm, addr, pte);
+			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
-					address+offset) != page->index)
-				set_pte_at(tlb->mm, address+offset,
-					   ptep, pgoff_to_pte(page->index));
-			if (pte_dirty(pte))
+						addr) != page->index)
+				set_pte_at(tlb->mm, addr, pte,
+					   pgoff_to_pte(page->index));
+			if (pte_dirty(ptent))
 				set_page_dirty(page);
 			if (PageAnon(page))
 				tlb->mm->anon_rss--;
-			else if (pte_young(pte))
+			else if (pte_young(ptent))
 				mark_page_accessed(page);
 			tlb->freed++;
 			page_remove_rmap(page);
@@ -526,68 +519,62 @@ static void zap_pte_range(struct mmu_gat
 		 */
 		if (unlikely(details))
 			continue;
-		if (!pte_file(pte))
-			free_swap_and_cache(pte_to_swp_entry(pte));
-		pte_clear(tlb->mm, address+offset, ptep);
-	}
-	pte_unmap(ptep-1);
+		if (!pte_file(ptent))
+			free_swap_and_cache(pte_to_swp_entry(ptent));
+		pte_clear(tlb->mm, addr, pte);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(pte - 1);
 }
 
-static void zap_pmd_range(struct mmu_gather *tlb,
-		pud_t *pud, unsigned long address,
-		unsigned long size, struct zap_details *details)
+static void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
 {
-	pmd_t * pmd;
-	unsigned long end;
+	pmd_t *pmd;
+	unsigned long next;
 
 	if (pud_none_or_clear_bad(pud))
 		return;
-	pmd = pmd_offset(pud, address);
-	end = address + size;
-	if (end > ((address + PUD_SIZE) & PUD_MASK))
-		end = ((address + PUD_SIZE) & PUD_MASK);
+	pmd = pmd_offset(pud, addr);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address, details);
-		address = (address + PMD_SIZE) & PMD_MASK; 
-		pmd++;
-	} while (address && (address < end));
+		next = pmd_addr_end(addr, end);
+		zap_pte_range(tlb, pmd, addr, next, details);
+	} while (pmd++, addr = next, addr != end);
 }
 
-static void zap_pud_range(struct mmu_gather *tlb,
-		pgd_t * pgd, unsigned long address,
-		unsigned long end, struct zap_details *details)
+static void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
 {
-	pud_t * pud;
+	pud_t *pud;
+	unsigned long next;
 
 	if (pgd_none_or_clear_bad(pgd))
 		return;
-	pud = pud_offset(pgd, address);
+	pud = pud_offset(pgd, addr);
 	do {
-		zap_pmd_range(tlb, pud, address, end - address, details);
-		address = (address + PUD_SIZE) & PUD_MASK; 
-		pud++;
-	} while (address && (address < end));
+		next = pud_addr_end(addr, end);
+		zap_pmd_range(tlb, pud, addr, next, details);
+	} while (pud++, addr = next, addr != end);
 }
 
-static void unmap_page_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long address,
-		unsigned long end, struct zap_details *details)
+static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
 {
-	unsigned long next;
 	pgd_t *pgd;
-	int i;
+	unsigned long next;
 
-	BUG_ON(address >= end);
-	pgd = pgd_offset(vma->vm_mm, address);
+	if (details && !details->check_mapping && !details->nonlinear_vma)
+		details = NULL;
+
+	BUG_ON(addr >= end);
 	tlb_start_vma(tlb, vma);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= address || next > end)
-			next = end;
-		zap_pud_range(tlb, pgd, address, next, details);
-		address = next;
-		pgd++;
-	}
+	pgd = pgd_offset(vma->vm_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		zap_pud_range(tlb, pgd, addr, next, details);
+	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
 }
 
