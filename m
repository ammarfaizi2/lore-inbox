Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUD1AAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUD1AAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUD1AAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:00:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:8047 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264515AbUD0X7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:59:48 -0400
Date: Wed, 28 Apr 2004 00:59:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 14 i_shared_lock fixes
Message-ID: <Pine.LNX.4.44.0404280055270.2444-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of batch of six patches against 2.6.6-rc2-mm2, which introduce
Rajesh Venkatasubramanian's implementation of a radix priority search
tree of vmas, to handle object-based reverse mapping corner cases well.

rmap 14 i_shared_lock fixes

Start the sequence with a couple of outstanding i_shared_lock fixes.

Since i_shared_sem became i_shared_lock, we've had to shift and then
temporarily remove mremap move's protection of concurrent truncation
- if mremap moves ptes while unmap_mapping_range_list is making its
way through the vmas, there's a danger we'd move a pte from an area
yet to be cleaned back into an area already cleared.

Now site the i_shared_lock with the page_table_lock in move_one_page.
Replace page_table_present by get_one_pte_map, so we know when it's
necessary to allocate a new page table: in which case have to drop
i_shared_lock, trylock and perhaps reorder locks on the way back.
Yet another fix: must check for NULL dst before pte_unmap(dst).

And over in rmap.c, try_to_unmap_file's cond_resched amidst its
lengthy nonlinear swapping was now causing might_sleep warnings:
moved to a rather unsatisfactory and less frequent cond_resched_lock
on i_shared_lock when we reach the end of the list; and one before
starting on the nonlinears too: the "cursor" may become out-of-date
if we do schedule, but I doubt it's worth bothering about.

 mm/mremap.c |   42 +++++++++++++++++++++++++++++++++---------
 mm/rmap.c   |    3 ++-
 2 files changed, 35 insertions(+), 10 deletions(-)

--- 2.6.6-rc2-mm2/mm/mremap.c	2004-04-26 12:39:46.961068192 +0100
+++ rmap14/mm/mremap.c	2004-04-27 19:18:19.421286456 +0100
@@ -55,16 +55,18 @@ end:
 	return pte;
 }
 
-static inline int page_table_present(struct mm_struct *mm, unsigned long addr)
+static pte_t *get_one_pte_map(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
 
 	pgd = pgd_offset(mm, addr);
 	if (pgd_none(*pgd))
-		return 0;
+		return NULL;
 	pmd = pmd_offset(pgd, addr);
-	return pmd_present(*pmd);
+	if (!pmd_present(*pmd))
+		return NULL;
+	return pte_offset_map(pmd, addr);
 }
 
 static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long addr)
@@ -97,11 +99,23 @@ static int
 move_one_page(struct vm_area_struct *vma, unsigned long old_addr,
 		unsigned long new_addr)
 {
+	struct address_space *mapping = NULL;
 	struct mm_struct *mm = vma->vm_mm;
 	int error = 0;
 	pte_t *src, *dst;
 
+	if (vma->vm_file) {
+		/*
+		 * Subtle point from Rajesh Venkatasubramanian: before
+		 * moving file-based ptes, we must lock vmtruncate out,
+		 * since it might clean the dst vma before the src vma,
+		 * and we propagate stale pages into the dst afterward.
+		 */
+		mapping = vma->vm_file->f_mapping;
+		spin_lock(&mapping->i_shared_lock);
+	}
 	spin_lock(&mm->page_table_lock);
+
 	src = get_one_pte_map_nested(mm, old_addr);
 	if (src) {
 		/*
@@ -109,13 +123,19 @@ move_one_page(struct vm_area_struct *vma
 		 * memory allocation.  If it does then we need to drop the
 		 * atomic kmap
 		 */
-		if (!page_table_present(mm, new_addr)) {
+		dst = get_one_pte_map(mm, new_addr);
+		if (unlikely(!dst)) {
 			pte_unmap_nested(src);
-			src = NULL;
-		}
-		dst = alloc_one_pte_map(mm, new_addr);
-		if (src == NULL)
+			if (mapping)
+				spin_unlock(&mapping->i_shared_lock);
+			dst = alloc_one_pte_map(mm, new_addr);
+			if (mapping && !spin_trylock(&mapping->i_shared_lock)) {
+				spin_unlock(&mm->page_table_lock);
+				spin_lock(&mapping->i_shared_lock);
+				spin_lock(&mm->page_table_lock);
+			}
 			src = get_one_pte_map_nested(mm, old_addr);
+		}
 		/*
 		 * Since alloc_one_pte_map can drop and re-acquire
 		 * page_table_lock, we should re-check the src entry...
@@ -132,9 +152,13 @@ move_one_page(struct vm_area_struct *vma
 			}
 			pte_unmap_nested(src);
 		}
-		pte_unmap(dst);
+		if (dst)
+			pte_unmap(dst);
 	}
+
 	spin_unlock(&mm->page_table_lock);
+	if (mapping)
+		spin_unlock(&mapping->i_shared_lock);
 	return error;
 }
 
--- 2.6.6-rc2-mm2/mm/rmap.c	2004-04-26 12:39:46.000000000 +0100
+++ rmap14/mm/rmap.c	2004-04-27 19:18:19.423286152 +0100
@@ -777,6 +777,7 @@ static inline int try_to_unmap_file(stru
 	 * but even so use it as a guide to how hard we should try?
 	 */
 	rmap_unlock(page);
+	cond_resched_lock(&mapping->i_shared_lock);
 
 	max_nl_size = (max_nl_size + CLUSTER_SIZE - 1) & CLUSTER_MASK;
 	if (max_nl_cursor == 0)
@@ -799,13 +800,13 @@ static inline int try_to_unmap_file(stru
 				vma->vm_private_data = (void *) cursor;
 				if ((int)mapcount <= 0)
 					goto relock;
-				cond_resched();
 			}
 			if (ret != SWAP_FAIL)
 				vma->vm_private_data =
 					(void *) max_nl_cursor;
 			ret = SWAP_AGAIN;
 		}
+		cond_resched_lock(&mapping->i_shared_lock);
 		max_nl_cursor += CLUSTER_SIZE;
 	} while (max_nl_cursor <= max_nl_size);
 

