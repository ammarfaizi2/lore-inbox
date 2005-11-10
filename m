Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVKJBww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVKJBww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVKJBww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:52:52 -0500
Received: from silver.veritas.com ([143.127.12.111]:43816 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751420AbVKJBwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:52:51 -0500
Date: Thu, 10 Nov 2005 01:51:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] mm: powerpc ptlock comments
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100150150.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:52:51.0385 (UTC) FILETIME=[757D9A90:01C5E599]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update comments (only) on page_table_lock and mmap_sem in arch/powerpc.
Removed the comment on page_table_lock from hash_huge_page: since it's
no longer taking page_table_lock itself, it's irrelevant whether others
are; but how it is safe (even against huge file truncation?) I can't say.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/powerpc/mm/hugetlbpage.c |    4 +---
 arch/powerpc/mm/mem.c         |    2 +-
 arch/powerpc/mm/tlb_32.c      |    6 ++++++
 arch/powerpc/mm/tlb_64.c      |    4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

--- mm06/arch/powerpc/mm/hugetlbpage.c	2005-11-07 07:39:05.000000000 +0000
+++ mm07/arch/powerpc/mm/hugetlbpage.c	2005-11-09 14:39:16.000000000 +0000
@@ -754,9 +754,7 @@ repeat:
 	}
 
 	/*
-	 * No need to use ldarx/stdcx here because all who
-	 * might be updating the pte will hold the
-	 * page_table_lock
+	 * No need to use ldarx/stdcx here
 	 */
 	*ptep = __pte(new_pte & ~_PAGE_BUSY);
 
--- mm06/arch/powerpc/mm/mem.c	2005-11-07 07:39:05.000000000 +0000
+++ mm07/arch/powerpc/mm/mem.c	2005-11-09 14:39:16.000000000 +0000
@@ -491,7 +491,7 @@ EXPORT_SYMBOL(flush_icache_user_range);
  * We use it to preload an HPTE into the hash table corresponding to
  * the updated linux PTE.
  * 
- * This must always be called with the mm->page_table_lock held
+ * This must always be called with the pte lock held.
  */
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t pte)
--- mm06/arch/powerpc/mm/tlb_32.c	2005-11-07 07:39:05.000000000 +0000
+++ mm07/arch/powerpc/mm/tlb_32.c	2005-11-09 14:39:16.000000000 +0000
@@ -149,6 +149,12 @@ void flush_tlb_mm(struct mm_struct *mm)
 		return;
 	}
 
+	/*
+	 * It is safe to go down the mm's list of vmas when called
+	 * from dup_mmap, holding mmap_sem.  It would also be safe from
+	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
+	 * but it seems dup_mmap is the only SMP case which gets here.
+	 */
 	for (mp = mm->mmap; mp != NULL; mp = mp->vm_next)
 		flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 	FINISH_FLUSH;
--- mm06/arch/powerpc/mm/tlb_64.c	2005-11-07 07:39:05.000000000 +0000
+++ mm07/arch/powerpc/mm/tlb_64.c	2005-11-09 14:39:16.000000000 +0000
@@ -95,7 +95,7 @@ static void pte_free_submit(struct pte_f
 
 void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
 {
-	/* This is safe as we are holding page_table_lock */
+	/* This is safe since tlb_gather_mmu has disabled preemption */
         cpumask_t local_cpumask = cpumask_of_cpu(smp_processor_id());
 	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
 
@@ -206,7 +206,7 @@ void __flush_tlb_pending(struct ppc64_tl
 
 void pte_free_finish(void)
 {
-	/* This is safe as we are holding page_table_lock */
+	/* This is safe since tlb_gather_mmu has disabled preemption */
 	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
 
 	if (*batchp == NULL)
