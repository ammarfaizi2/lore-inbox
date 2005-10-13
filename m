Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVJMBSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVJMBSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVJMBSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:18:20 -0400
Received: from silver.veritas.com ([143.127.12.111]:44183 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964852AbVJMBST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:18:19 -0400
Date: Thu, 13 Oct 2005 02:17:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 16/21] mm: unlink vma before pagetables
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130216450.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:18:19.0039 (UTC) FILETIME=[FEB5B2F0:01C5CF93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In most places the descent from pgd to pud to pmd to pte holds mmap_sem
(exclusively or not), which ensures that free_pgtables cannot be freeing
page tables from any level at the same time.  But truncation and reverse
mapping descend without mmap_sem.

No problem: just make sure that a vma is unlinked from its prio_tree (or
nonlinear list) and from its anon_vma list, after zapping the vma, but
before freeing its page tables.  Then neither vmtruncate nor rmap can
reach that vma whose page tables are now volatile (nor do they need to
reach it, since all its page entries have been zapped by this stage).

The i_mmap_lock and anon_vma->lock already serialize this correctly;
but the locking hierarchy is such that we cannot take them while holding
page_table_lock.  Well, we're trying to push that down anyway.  So in
this patch, move anon_vma_unlink and unlink_file_vma into free_pgtables,
at the same time as moving page_table_lock around calls to unmap_vmas.

tlb_gather_mmu and tlb_finish_mmu then fall outside the page_table_lock,
but we made them preempt_disable and preempt_enable earlier; and a long
source audit of all the architectures has shown no problem with removing
page_table_lock from them.  free_pgtables doesn't need page_table_lock
for itself, nor for what it calls; tlb->mm->nr_ptes is usually protected
by page_table_lock, but partly by non-exclusive mmap_sem - here it's
decremented with exclusive mmap_sem, or mm_users 0.  update_hiwater_rss
and vm_unacct_memory don't need page_table_lock either.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   12 ++++++++++--
 mm/mmap.c   |   23 ++++++-----------------
 2 files changed, 16 insertions(+), 19 deletions(-)

--- mm15/mm/memory.c	2005-10-11 23:56:56.000000000 +0100
+++ mm16/mm/memory.c	2005-10-11 23:57:45.000000000 +0100
@@ -260,6 +260,12 @@ void free_pgtables(struct mmu_gather **t
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long addr = vma->vm_start;
 
+		/*
+		 * Hide vma from rmap and vmtruncate before freeing pgtables
+		 */
+		anon_vma_unlink(vma);
+		unlink_file_vma(vma);
+
 		if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next? next->vm_start: ceiling);
@@ -272,6 +278,8 @@ void free_pgtables(struct mmu_gather **t
 							HPAGE_SIZE)) {
 				vma = next;
 				next = vma->vm_next;
+				anon_vma_unlink(vma);
+				unlink_file_vma(vma);
 			}
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next? next->vm_start: ceiling);
@@ -798,12 +806,12 @@ unsigned long zap_page_range(struct vm_a
 	}
 
 	lru_add_drain();
-	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
 	update_hiwater_rss(mm);
+	spin_lock(&mm->page_table_lock);
 	end = unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
-	tlb_finish_mmu(tlb, address, end);
 	spin_unlock(&mm->page_table_lock);
+	tlb_finish_mmu(tlb, address, end);
 	return end;
 }
 
--- mm15/mm/mmap.c	2005-10-11 23:55:38.000000000 +0100
+++ mm16/mm/mmap.c	2005-10-11 23:57:46.000000000 +0100
@@ -199,14 +199,6 @@ static struct vm_area_struct *remove_vma
 {
 	struct vm_area_struct *next = vma->vm_next;
 
-	/*
-	 * Hide vma from rmap and vmtruncate before freeing page tables:
-	 * to be moved into free_pgtables once page_table_lock is lifted
-	 * from it, but until then lock ordering forbids that move.
-	 */
-	anon_vma_unlink(vma);
-	unlink_file_vma(vma);
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
@@ -1675,15 +1667,15 @@ static void unmap_region(struct mm_struc
 	unsigned long nr_accounted = 0;
 
 	lru_add_drain();
-	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
 	update_hiwater_rss(mm);
+	spin_lock(&mm->page_table_lock);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
+	spin_unlock(&mm->page_table_lock);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
 				 next? next->vm_start: 0);
 	tlb_finish_mmu(tlb, start, end);
-	spin_unlock(&mm->page_table_lock);
 }
 
 /*
@@ -1958,23 +1950,20 @@ void exit_mmap(struct mm_struct *mm)
 	unsigned long end;
 
 	lru_add_drain();
-
-	spin_lock(&mm->page_table_lock);
-
 	flush_cache_mm(mm);
 	tlb = tlb_gather_mmu(mm, 1);
 	/* Don't update_hiwater_rss(mm) here, do_exit already did */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
+	spin_lock(&mm->page_table_lock);
 	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
+	spin_unlock(&mm->page_table_lock);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
 	tlb_finish_mmu(tlb, 0, end);
 
-	spin_unlock(&mm->page_table_lock);
-
 	/*
-	 * Walk the list again, actually closing and freeing it
-	 * without holding any MM locks.
+	 * Walk the list again, actually closing and freeing it,
+	 * with preemption enabled, without holding any MM locks.
 	 */
 	while (vma)
 		vma = remove_vma(vma);
