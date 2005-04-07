Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVDGBLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVDGBLB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVDGBLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:11:01 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13566 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262366AbVDGBKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:10:22 -0400
Date: Thu, 7 Apr 2005 02:10:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] freepgt2: free_pgtables from FIRST_USER_ADDRESS
Message-ID: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patches to free_pgtables by vma left problems on any architectures
which leave some user address page table entries unencapsulated by vma.
Andi has fixed the 32-bit vDSO on x86_64 to use a vma.  Now fix arm (and
arm26), whose first PAGE_SIZE is reserved (perhaps) for machine vectors.

Our calls to free_pgtables must not touch that area, and exit_mmap's
BUG_ON(nr_ptes) must allow that arm's get_pgd_slow may (or may not) have
allocated an extra page table, which its free_pgd_slow would free later.

FIRST_USER_PGD_NR has misled me and others: until all the arches define
FIRST_USER_ADDRESS instead, a hack in mmap.c to derive one from t'other.
This patch fixes the bugs, the remaining patches just clean it up.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mmap.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

--- 2.6.12-rc2-mm1/mm/mmap.c	2005-04-05 15:23:00.000000000 +0100
+++ linux/mm/mmap.c	2005-04-05 18:59:01.000000000 +0100
@@ -1608,6 +1608,11 @@ static void unmap_vma_list(struct mm_str
 	validate_mm(mm);
 }
 
+#ifndef FIRST_USER_ADDRESS	/* temporary hack */
+#define THIS_IS_ARM		FIRST_USER_PGD_NR
+#define FIRST_USER_ADDRESS	(THIS_IS_ARM * PAGE_SIZE)
+#endif
+
 /*
  * Get rid of page table information in the indicated region.
  *
@@ -1626,7 +1631,7 @@ static void unmap_region(struct mm_struc
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
-	free_pgtables(&tlb, vma, prev? prev->vm_end: 0,
+	free_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
 				 next? next->vm_start: 0);
 	tlb_finish_mmu(tlb, start, end);
 	spin_unlock(&mm->page_table_lock);
@@ -1906,7 +1911,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
-	free_pgtables(&tlb, vma, 0, 0);
+	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
 	tlb_finish_mmu(tlb, 0, end);
 
 	mm->mmap = mm->mmap_cache = NULL;
@@ -1927,7 +1932,7 @@ void exit_mmap(struct mm_struct *mm)
 		vma = next;
 	}
 
-	BUG_ON(mm->nr_ptes);	/* This is just debugging */
+	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
 }
 
 /* Insert vm structure into process list sorted by address
