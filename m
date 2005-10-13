Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVJMBAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVJMBAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVJMBAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:00:13 -0400
Received: from gold.veritas.com ([143.127.12.110]:12051 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964838AbVJMBAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:00:10 -0400
Date: Thu, 13 Oct 2005 01:59:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Rusell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       William Irwin <wli@holomorphy.com>,
       "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>,
       Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] mm: arches skip ptlock
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130156280.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:00:10.0292 (UTC) FILETIME=[75C41740:01C5CF91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert those few architectures which are calling pud_alloc, pmd_alloc,
pte_alloc_map on a user mm, not to take the page_table_lock first, nor
drop it after.  Each of these can continue to use pte_alloc_map, no need
to change over to pte_alloc_map_lock, they're neither racy nor swappable.

In the sparc64 io_remap_pfn_range, flush_tlb_range then falls outside of
the page_table_lock: that's okay, on sparc64 it's like flush_tlb_mm, and
that has always been called from outside of page_table_lock in dup_mmap.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/arm/mm/mm-armv.c     |   14 --------------
 arch/arm26/mm/memc.c      |   15 ---------------
 arch/sparc/mm/generic.c   |    4 +---
 arch/sparc64/mm/generic.c |    6 ++----
 arch/um/kernel/skas/mmu.c |    3 ---
 5 files changed, 3 insertions(+), 39 deletions(-)

--- mm11/arch/arm/mm/mm-armv.c	2005-09-21 12:16:12.000000000 +0100
+++ mm12/arch/arm/mm/mm-armv.c	2005-10-11 23:56:41.000000000 +0100
@@ -180,11 +180,6 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 
 	if (!vectors_high()) {
 		/*
-		 * This lock is here just to satisfy pmd_alloc and pte_lock
-		 */
-		spin_lock(&mm->page_table_lock);
-
-		/*
 		 * On ARM, first page must always be allocated since it
 		 * contains the machine vectors.
 		 */
@@ -201,23 +196,14 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 		set_pte(new_pte, *init_pte);
 		pte_unmap_nested(init_pte);
 		pte_unmap(new_pte);
-
-		spin_unlock(&mm->page_table_lock);
 	}
 
 	return new_pgd;
 
 no_pte:
-	spin_unlock(&mm->page_table_lock);
 	pmd_free(new_pmd);
-	free_pages((unsigned long)new_pgd, 2);
-	return NULL;
-
 no_pmd:
-	spin_unlock(&mm->page_table_lock);
 	free_pages((unsigned long)new_pgd, 2);
-	return NULL;
-
 no_pgd:
 	return NULL;
 }
--- mm11/arch/arm26/mm/memc.c	2005-10-11 23:55:53.000000000 +0100
+++ mm12/arch/arm26/mm/memc.c	2005-10-11 23:56:41.000000000 +0100
@@ -79,12 +79,6 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 		goto no_pgd;
 
 	/*
-	 * This lock is here just to satisfy pmd_alloc and pte_lock
-         * FIXME: I bet we could avoid taking it pretty much altogether
-	 */
-	spin_lock(&mm->page_table_lock);
-
-	/*
 	 * On ARM, first page must always be allocated since it contains
 	 * the machine vectors.
 	 */
@@ -113,23 +107,14 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 	memcpy(new_pgd + FIRST_KERNEL_PGD_NR, init_pgd + FIRST_KERNEL_PGD_NR,
 		(PTRS_PER_PGD - FIRST_KERNEL_PGD_NR) * sizeof(pgd_t));
 
-	spin_unlock(&mm->page_table_lock);
-
 	/* update MEMC tables */
 	cpu_memc_update_all(new_pgd);
 	return new_pgd;
 
 no_pte:
-	spin_unlock(&mm->page_table_lock);
 	pmd_free(new_pmd);
-	free_pgd_slow(new_pgd);
-	return NULL;
-
 no_pmd:
-	spin_unlock(&mm->page_table_lock);
 	free_pgd_slow(new_pgd);
-	return NULL;
-
 no_pgd:
 	return NULL;
 }
--- mm11/arch/sparc/mm/generic.c	2005-09-21 12:16:20.000000000 +0100
+++ mm12/arch/sparc/mm/generic.c	2005-10-11 23:56:41.000000000 +0100
@@ -78,9 +78,8 @@ int io_remap_pfn_range(struct vm_area_st
 	dir = pgd_offset(mm, from);
 	flush_cache_range(vma, beg, end);
 
-	spin_lock(&mm->page_table_lock);
 	while (from < end) {
-		pmd_t *pmd = pmd_alloc(current->mm, dir, from);
+		pmd_t *pmd = pmd_alloc(mm, dir, from);
 		error = -ENOMEM;
 		if (!pmd)
 			break;
@@ -90,7 +89,6 @@ int io_remap_pfn_range(struct vm_area_st
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	}
-	spin_unlock(&mm->page_table_lock);
 
 	flush_tlb_range(vma, beg, end);
 	return error;
--- mm11/arch/sparc64/mm/generic.c	2005-09-21 12:16:20.000000000 +0100
+++ mm12/arch/sparc64/mm/generic.c	2005-10-11 23:56:41.000000000 +0100
@@ -132,9 +132,8 @@ int io_remap_pfn_range(struct vm_area_st
 	dir = pgd_offset(mm, from);
 	flush_cache_range(vma, beg, end);
 
-	spin_lock(&mm->page_table_lock);
 	while (from < end) {
-		pud_t *pud = pud_alloc(current->mm, dir, from);
+		pud_t *pud = pud_alloc(mm, dir, from);
 		error = -ENOMEM;
 		if (!pud)
 			break;
@@ -144,8 +143,7 @@ int io_remap_pfn_range(struct vm_area_st
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	}
-	flush_tlb_range(vma, beg, end);
-	spin_unlock(&mm->page_table_lock);
 
+	flush_tlb_range(vma, beg, end);
 	return error;
 }
--- mm11/arch/um/kernel/skas/mmu.c	2005-09-21 12:16:21.000000000 +0100
+++ mm12/arch/um/kernel/skas/mmu.c	2005-10-11 23:56:41.000000000 +0100
@@ -28,7 +28,6 @@ static int init_stub_pte(struct mm_struc
 	pmd_t *pmd;
 	pte_t *pte;
 
-	spin_lock(&mm->page_table_lock);
 	pgd = pgd_offset(mm, proc);
 	pud = pud_alloc(mm, pgd, proc);
 	if (!pud)
@@ -63,7 +62,6 @@ static int init_stub_pte(struct mm_struc
 	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
 	*pte = pte_mkexec(*pte);
 	*pte = pte_wrprotect(*pte);
-	spin_unlock(&mm->page_table_lock);
 	return(0);
 
  out_pmd:
@@ -71,7 +69,6 @@ static int init_stub_pte(struct mm_struc
  out_pte:
 	pmd_free(pmd);
  out:
-	spin_unlock(&mm->page_table_lock);
 	return(-ENOMEM);
 }
 
