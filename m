Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVCIXFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVCIXFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVCIWm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:42:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:30317 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262204AbVCIWPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:15:41 -0500
Date: Wed, 9 Mar 2005 22:14:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] ptwalk: move p?d_none_or_clear_bad
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092214110.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To handle large sparse areas a little more efficiently, follow Nick and
move the p?d_none_or_clear_bad tests up from the start of each function
to its callsite.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c   |   24 ++++++++++++------------
 mm/mprotect.c |   12 ++++++------
 mm/msync.c    |   12 ++++++------
 mm/swapfile.c |   12 ++++++------
 mm/vmalloc.c  |   15 ++++++---------
 5 files changed, 36 insertions(+), 39 deletions(-)

--- ptwalk12/mm/memory.c	2005-03-09 01:39:06.000000000 +0000
+++ ptwalk13/mm/memory.c	2005-03-09 01:39:18.000000000 +0000
@@ -113,8 +113,6 @@ void pmd_clear_bad(pmd_t *pmd)
 static inline void clear_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
 				unsigned long addr, unsigned long end)
 {
-	if (pmd_none_or_clear_bad(pmd))
-		return;
 	if (!((addr | end) & ~PMD_MASK)) {
 		/* Only free fully aligned ranges */
 		struct page *page = pmd_page(*pmd);
@@ -132,8 +130,6 @@ static inline void clear_pmd_range(struc
 	unsigned long next;
 	pmd_t *empty_pmd = NULL;
 
-	if (pud_none_or_clear_bad(pud))
-		return;
 	pmd = pmd_offset(pud, addr);
 
 	/* Only free fully aligned ranges */
@@ -141,6 +137,8 @@ static inline void clear_pmd_range(struc
 		empty_pmd = pmd;
 	do {
 		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
 		clear_pte_range(tlb, pmd, addr, next);
 	} while (pmd++, addr = next, addr != end);
 
@@ -157,8 +155,6 @@ static inline void clear_pud_range(struc
 	unsigned long next;
 	pud_t *empty_pud = NULL;
 
-	if (pgd_none_or_clear_bad(pgd))
-		return;
 	pud = pud_offset(pgd, addr);
 
 	/* Only free fully aligned ranges */
@@ -166,6 +162,8 @@ static inline void clear_pud_range(struc
 		empty_pud = pud;
 	do {
 		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
 		clear_pmd_range(tlb, pud, addr, next);
 	} while (pud++, addr = next, addr != end);
 
@@ -189,6 +187,8 @@ void clear_page_range(struct mmu_gather 
 	pgd = pgd_offset(tlb->mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
 		clear_pud_range(tlb, pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 }
@@ -432,8 +432,6 @@ static void zap_pte_range(struct mmu_gat
 {
 	pte_t *pte;
 
-	if (pmd_none_or_clear_bad(pmd))
-		return;
 	pte = pte_offset_map(pmd, addr);
 	do {
 		pte_t ptent = *pte;
@@ -505,11 +503,11 @@ static void zap_pmd_range(struct mmu_gat
 	pmd_t *pmd;
 	unsigned long next;
 
-	if (pud_none_or_clear_bad(pud))
-		return;
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
 		zap_pte_range(tlb, pmd, addr, next, details);
 	} while (pmd++, addr = next, addr != end);
 }
@@ -521,11 +519,11 @@ static void zap_pud_range(struct mmu_gat
 	pud_t *pud;
 	unsigned long next;
 
-	if (pgd_none_or_clear_bad(pgd))
-		return;
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
 		zap_pmd_range(tlb, pud, addr, next, details);
 	} while (pud++, addr = next, addr != end);
 }
@@ -545,6 +543,8 @@ static void unmap_page_range(struct mmu_
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
 		zap_pud_range(tlb, pgd, addr, next, details);
 	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
--- ptwalk12/mm/mprotect.c	2005-03-09 01:36:01.000000000 +0000
+++ ptwalk13/mm/mprotect.c	2005-03-09 01:39:18.000000000 +0000
@@ -30,8 +30,6 @@ static inline void change_pte_range(stru
 {
 	pte_t *pte;
 
-	if (pmd_none_or_clear_bad(pmd))
-		return;
 	pte = pte_offset_map(pmd, addr);
 	do {
 		if (pte_present(*pte)) {
@@ -54,11 +52,11 @@ static inline void change_pmd_range(stru
 	pmd_t *pmd;
 	unsigned long next;
 
-	if (pud_none_or_clear_bad(pud))
-		return;
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
 		change_pte_range(mm, pmd, addr, next, newprot);
 	} while (pmd++, addr = next, addr != end);
 }
@@ -69,11 +67,11 @@ static inline void change_pud_range(stru
 	pud_t *pud;
 	unsigned long next;
 
-	if (pgd_none_or_clear_bad(pgd))
-		return;
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
 		change_pmd_range(mm, pud, addr, next, newprot);
 	} while (pud++, addr = next, addr != end);
 }
@@ -92,6 +90,8 @@ static void change_protection(struct vm_
 	spin_lock(&mm->page_table_lock);
 	do {
 		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
 		change_pud_range(mm, pgd, addr, next, newprot);
 	} while (pgd++, addr = next, addr != end);
 	flush_tlb_range(vma, start, end);
--- ptwalk12/mm/msync.c	2005-03-09 01:36:14.000000000 +0000
+++ ptwalk13/mm/msync.c	2005-03-09 01:39:18.000000000 +0000
@@ -27,8 +27,6 @@ static void sync_pte_range(struct vm_are
 {
 	pte_t *pte;
 
-	if (pmd_none_or_clear_bad(pmd))
-		return;
 	pte = pte_offset_map(pmd, addr);
 	do {
 		unsigned long pfn;
@@ -56,11 +54,11 @@ static inline void sync_pmd_range(struct
 	pmd_t *pmd;
 	unsigned long next;
 
-	if (pud_none_or_clear_bad(pud))
-		return;
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
 		sync_pte_range(vma, pmd, addr, next);
 	} while (pmd++, addr = next, addr != end);
 }
@@ -71,11 +69,11 @@ static inline void sync_pud_range(struct
 	pud_t *pud;
 	unsigned long next;
 
-	if (pgd_none_or_clear_bad(pgd))
-		return;
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
 		sync_pmd_range(vma, pud, addr, next);
 	} while (pud++, addr = next, addr != end);
 }
@@ -99,6 +97,8 @@ static void sync_page_range(struct vm_ar
 	spin_lock(&mm->page_table_lock);
 	do {
 		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
 		sync_pud_range(vma, pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 	spin_unlock(&mm->page_table_lock);
--- ptwalk12/mm/swapfile.c	2005-03-09 01:36:25.000000000 +0000
+++ ptwalk13/mm/swapfile.c	2005-03-09 01:39:18.000000000 +0000
@@ -442,8 +442,6 @@ static int unuse_pte_range(struct vm_are
 	pte_t *pte;
 	pte_t swp_pte = swp_entry_to_pte(entry);
 
-	if (pmd_none_or_clear_bad(pmd))
-		return 0;
 	pte = pte_offset_map(pmd, addr);
 	do {
 		/*
@@ -467,11 +465,11 @@ static int unuse_pmd_range(struct vm_are
 	pmd_t *pmd;
 	unsigned long next;
 
-	if (pud_none_or_clear_bad(pud))
-		return 0;
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
 		if (unuse_pte_range(vma, pmd, addr, next, entry, page))
 			return 1;
 	} while (pmd++, addr = next, addr != end);
@@ -485,11 +483,11 @@ static int unuse_pud_range(struct vm_are
 	pud_t *pud;
 	unsigned long next;
 
-	if (pgd_none_or_clear_bad(pgd))
-		return 0;
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
 		if (unuse_pmd_range(vma, pud, addr, next, entry, page))
 			return 1;
 	} while (pud++, addr = next, addr != end);
@@ -516,6 +514,8 @@ static int unuse_vma(struct vm_area_stru
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
 		if (unuse_pud_range(vma, pgd, addr, next, entry, page))
 			return 1;
 	} while (pgd++, addr = next, addr != end);
--- ptwalk12/mm/vmalloc.c	2005-03-09 01:36:38.000000000 +0000
+++ ptwalk13/mm/vmalloc.c	2005-03-09 01:39:18.000000000 +0000
@@ -27,9 +27,6 @@ static void vunmap_pte_range(pmd_t *pmd,
 {
 	pte_t *pte;
 
-	if (pmd_none_or_clear_bad(pmd))
-		return;
-
 	pte = pte_offset_kernel(pmd, addr);
 	do {
 		pte_t ptent = ptep_get_and_clear(&init_mm, addr, pte);
@@ -42,12 +39,11 @@ static void vunmap_pmd_range(pud_t *pud,
 	pmd_t *pmd;
 	unsigned long next;
 
-	if (pud_none_or_clear_bad(pud))
-		return;
-
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
 		vunmap_pte_range(pmd, addr, next);
 	} while (pmd++, addr = next, addr != end);
 }
@@ -57,12 +53,11 @@ static void vunmap_pud_range(pgd_t *pgd,
 	pud_t *pud;
 	unsigned long next;
 
-	if (pgd_none_or_clear_bad(pgd))
-		return;
-
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
 		vunmap_pmd_range(pud, addr, next);
 	} while (pud++, addr = next, addr != end);
 }
@@ -79,6 +74,8 @@ void unmap_vm_area(struct vm_struct *are
 	flush_cache_vunmap(addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
 		vunmap_pud_range(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 	flush_tlb_kernel_range((unsigned long) area->addr, end);
