Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVCIW5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVCIW5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVCIW40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:56:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50015 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262080AbVCIWOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:14:54 -0500
Date: Wed, 9 Mar 2005 22:14:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] ptwalk: clear_page_range
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092213310.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert clear_page_range pagetable walkers to loops using p?d_addr_end.
These are exceptional in that some out-of-tree memory layouts might pass
end 0, so the macros need to handle that (though previous code did not).

The naming here was out of step: now we usually pass pmd_t *pmd down to
action_on_pte_range, not action_on_pmd_range, etc: made like the others.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   98 ++++++++++++++++++++++++++++--------------------------------
 1 files changed, 46 insertions(+), 52 deletions(-)

--- ptwalk11/mm/memory.c	2005-03-09 01:38:54.000000000 +0000
+++ ptwalk12/mm/memory.c	2005-03-09 01:39:06.000000000 +0000
@@ -110,15 +110,14 @@ void pmd_clear_bad(pmd_t *pmd)
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static inline void clear_pmd_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long start, unsigned long end)
+static inline void clear_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+				unsigned long addr, unsigned long end)
 {
-	struct page *page;
-
 	if (pmd_none_or_clear_bad(pmd))
 		return;
-	if (!((start | end) & ~PMD_MASK)) {
-		/* Only clear full, aligned ranges */
-		page = pmd_page(*pmd);
+	if (!((addr | end) & ~PMD_MASK)) {
+		/* Only free fully aligned ranges */
+		struct page *page = pmd_page(*pmd);
 		pmd_clear(pmd);
 		dec_page_state(nr_page_table_pages);
 		tlb->mm->nr_ptes--;
@@ -126,77 +125,72 @@ static inline void clear_pmd_range(struc
 	}
 }
 
-static inline void clear_pud_range(struct mmu_gather *tlb, pud_t *pud, unsigned long start, unsigned long end)
+static inline void clear_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+				unsigned long addr, unsigned long end)
 {
-	unsigned long addr = start, next;
-	pmd_t *pmd, *__pmd;
+	pmd_t *pmd;
+	unsigned long next;
+	pmd_t *empty_pmd = NULL;
 
 	if (pud_none_or_clear_bad(pud))
 		return;
-	pmd = __pmd = pmd_offset(pud, start);
+	pmd = pmd_offset(pud, addr);
+
+	/* Only free fully aligned ranges */
+	if (!((addr | end) & ~PUD_MASK))
+		empty_pmd = pmd;
 	do {
-		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		
-		clear_pmd_range(tlb, pmd, addr, next);
-		pmd++;
-		addr = next;
-	} while (addr && (addr < end));
+		next = pmd_addr_end(addr, end);
+		clear_pte_range(tlb, pmd, addr, next);
+	} while (pmd++, addr = next, addr != end);
 
-	if (!((start | end) & ~PUD_MASK)) {
-		/* Only clear full, aligned ranges */
+	if (empty_pmd) {
 		pud_clear(pud);
-		pmd_free_tlb(tlb, __pmd);
+		pmd_free_tlb(tlb, empty_pmd);
 	}
 }
 
-
-static inline void clear_pgd_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long start, unsigned long end)
+static inline void clear_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+				unsigned long addr, unsigned long end)
 {
-	unsigned long addr = start, next;
-	pud_t *pud, *__pud;
+	pud_t *pud;
+	unsigned long next;
+	pud_t *empty_pud = NULL;
 
 	if (pgd_none_or_clear_bad(pgd))
 		return;
-	pud = __pud = pud_offset(pgd, start);
+	pud = pud_offset(pgd, addr);
+
+	/* Only free fully aligned ranges */
+	if (!((addr | end) & ~PGDIR_MASK))
+		empty_pud = pud;
 	do {
-		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		
-		clear_pud_range(tlb, pud, addr, next);
-		pud++;
-		addr = next;
-	} while (addr && (addr < end));
+		next = pud_addr_end(addr, end);
+		clear_pmd_range(tlb, pud, addr, next);
+	} while (pud++, addr = next, addr != end);
 
-	if (!((start | end) & ~PGDIR_MASK)) {
-		/* Only clear full, aligned ranges */
+	if (empty_pud) {
 		pgd_clear(pgd);
-		pud_free_tlb(tlb, __pud);
+		pud_free_tlb(tlb, empty_pud);
 	}
 }
 
 /*
  * This function clears user-level page tables of a process.
- *
+ * Unlike other pagetable walks, some memory layouts might give end 0.
  * Must be called with pagetable lock held.
  */
-void clear_page_range(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+void clear_page_range(struct mmu_gather *tlb,
+				unsigned long addr, unsigned long end)
 {
-	unsigned long addr = start, next;
-	pgd_t * pgd = pgd_offset(tlb->mm, start);
-	unsigned long i;
-
-	for (i = pgd_index(start); i <= pgd_index(end-1); i++) {
-		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		
-		clear_pgd_range(tlb, pgd, addr, next);
-		pgd++;
-		addr = next;
-	}
+	pgd_t *pgd;
+	unsigned long next;
+
+	pgd = pgd_offset(tlb->mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		clear_pud_range(tlb, pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
 }
 
 pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
