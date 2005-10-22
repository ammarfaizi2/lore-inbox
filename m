Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVJVQc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVJVQc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVJVQc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:32:27 -0400
Received: from gold.veritas.com ([143.127.12.110]:9222 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932268AbVJVQc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:32:26 -0400
Date: Sat, 22 Oct 2005 17:31:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] mm: update comments to pte lock
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510221730420.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:32:26.0077 (UTC) FILETIME=[2FCF48D0:01C5D726]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated several references to page_table_lock in common code comments.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-generic/pgtable.h |    2 +-
 include/linux/mempolicy.h     |    3 +--
 mm/filemap.c                  |    6 +++---
 mm/rmap.c                     |   10 +++++-----
 mm/swap_state.c               |    3 +--
 5 files changed, 11 insertions(+), 13 deletions(-)

--- mm8/include/asm-generic/pgtable.h	2005-10-11 12:07:47.000000000 +0100
+++ mm9/include/asm-generic/pgtable.h	2005-10-22 14:07:54.000000000 +0100
@@ -8,7 +8,7 @@
  *  - update the page tables
  *  - inform the TLB about the new one
  *
- * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock.
+ * We hold the mm semaphore for reading, and the pte lock.
  *
  * Note: the old pte is known to not be writable, so we don't need to
  * worry about dirty bits etc getting lost.
--- mm8/include/linux/mempolicy.h	2005-10-17 12:05:38.000000000 +0100
+++ mm9/include/linux/mempolicy.h	2005-10-22 14:07:54.000000000 +0100
@@ -47,8 +47,7 @@ struct vm_area_struct;
  * Locking policy for interlave:
  * In process context there is no locking because only the process accesses
  * its own state. All vma manipulation is somewhat protected by a down_read on
- * mmap_sem. For allocating in the interleave policy the page_table_lock
- * must be also aquired to protect il_next.
+ * mmap_sem.
  *
  * Freeing policy:
  * When policy is MPOL_BIND v.zonelist is kmalloc'ed and must be kfree'd.
--- mm8/mm/filemap.c	2005-10-17 12:05:40.000000000 +0100
+++ mm9/mm/filemap.c	2005-10-22 14:07:54.000000000 +0100
@@ -66,7 +66,7 @@ generic_file_direct_IO(int rw, struct ki
  *
  *  ->mmap_sem
  *    ->i_mmap_lock
- *      ->page_table_lock	(various places, mainly in mmap.c)
+ *      ->page_table_lock or pte_lock	(various, mainly in memory.c)
  *        ->mapping->tree_lock	(arch-dependent flush_dcache_mmap_lock)
  *
  *  ->mmap_sem
@@ -86,9 +86,9 @@ generic_file_direct_IO(int rw, struct ki
  *    ->anon_vma.lock		(vma_adjust)
  *
  *  ->anon_vma.lock
- *    ->page_table_lock		(anon_vma_prepare and various)
+ *    ->page_table_lock or pte_lock	(anon_vma_prepare and various)
  *
- *  ->page_table_lock
+ *  ->page_table_lock or pte_lock
  *    ->swap_lock		(try_to_unmap_one)
  *    ->private_lock		(try_to_unmap_one)
  *    ->tree_lock		(try_to_unmap_one)
--- mm8/mm/rmap.c	2005-10-22 14:07:40.000000000 +0100
+++ mm9/mm/rmap.c	2005-10-22 14:07:54.000000000 +0100
@@ -32,7 +32,7 @@
  *   page->flags PG_locked (lock_page)
  *     mapping->i_mmap_lock
  *       anon_vma->lock
- *         mm->page_table_lock
+ *         mm->page_table_lock or pte_lock
  *           zone->lru_lock (in mark_page_accessed)
  *           swap_lock (in swap_duplicate, swap_info_get)
  *             mmlist_lock (in mmput, drain_mmlist and others)
@@ -244,7 +244,7 @@ unsigned long page_address_in_vma(struct
 /*
  * Check that @page is mapped at @address into @mm.
  *
- * On success returns with mapped pte and locked mm->page_table_lock.
+ * On success returns with pte mapped and locked.
  */
 pte_t *page_check_address(struct page *page, struct mm_struct *mm,
 			  unsigned long address, spinlock_t **ptlp)
@@ -445,7 +445,7 @@ int page_referenced(struct page *page, i
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
  *
- * The caller needs to hold the mm->page_table_lock.
+ * The caller needs to hold the pte lock.
  */
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
@@ -468,7 +468,7 @@ void page_add_anon_rmap(struct page *pag
  * page_add_file_rmap - add pte mapping to a file page
  * @page: the page to add the mapping to
  *
- * The caller needs to hold the mm->page_table_lock.
+ * The caller needs to hold the pte lock.
  */
 void page_add_file_rmap(struct page *page)
 {
@@ -483,7 +483,7 @@ void page_add_file_rmap(struct page *pag
  * page_remove_rmap - take down pte mapping from a page
  * @page: page to remove mapping from
  *
- * Caller needs to hold the mm->page_table_lock.
+ * The caller needs to hold the pte lock.
  */
 void page_remove_rmap(struct page *page)
 {
--- mm8/mm/swap_state.c	2005-10-17 12:05:40.000000000 +0100
+++ mm9/mm/swap_state.c	2005-10-22 14:07:54.000000000 +0100
@@ -263,8 +263,7 @@ static inline void free_swap_cache(struc
 
 /* 
  * Perform a free_page(), also freeing any swap cache associated with
- * this page if it is the last user of the page. Can not do a lock_page,
- * as we are holding the page_table_lock spinlock.
+ * this page if it is the last user of the page.
  */
 void free_page_and_swap_cache(struct page *page)
 {
