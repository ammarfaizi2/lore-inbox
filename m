Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUDMQLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbUDMQLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:11:07 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36286 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263618AbUDMQKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:10:07 -0400
Date: Tue, 13 Apr 2004 17:09:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 8 unmap nonlinear
In-Reply-To: <Pine.LNX.4.44.0404131705200.5516-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404131708230.5516-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmap 8 unmap nonlinear

The previous patch let the ptes of file pages be located via page
->mapping->i_mmap and i_mmap_shared lists of vmas; which works well
unless the vma is VM_NONLINEAR - one in which sys_remap_file_pages has
been used to place pages in unexpected places, to avoid an explosion of
distinct unmergable vmas.  Such pages were effectively locked in memory.

page_referenced_file is already skipping nonlinear vmas, they'd just
waste its time, and age unfairly any pages in their proper positions.
Now extend try_to_unmap_file, to persuade it to swap from nonlinears.

Ignoring the page requested, try to unmap cluster of 32 neighbouring
ptes (in worst case all empty slots) in a nonlinear vma, then move
on to the next vma; stopping when we've unmapped at least as many
maps as the requested page had (vague guide of how hard to try),
or have reached the end.  With large sparse nonlinear vmas, this
could take a long time: inserted a cond_resched while no locks are
held, unusual at this level but I think okay, shrink_list does so.

Use vm_private_data a little like the old mm->swap_address, as a
cursor recording how far we got, so we don't attack the same ptes
next time around (earlier tried inserting an empty marker vma in
the list, but that got messy).  How well this will work on real-
life nonlinear vmas remains to be seen, but should work better than
locking them all in memory, or swapping everything out all the time.

Existing users of vm_private_data have either VM_RESERVED or
VM_DONTEXPAND set, both of which are in the VM_SPECIAL category
where we never try to merge vmas: so removed the vm_private_data
test from is_mergeable_vma, so we can still merge VM_NONLINEARs.
Of course, we could instead add another field to vm_area_struct.

 mm/fremap.c |    7 +-
 mm/mmap.c   |    2 
 mm/rmap.c   |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 167 insertions(+), 5 deletions(-)

--- rmap7/mm/fremap.c	2004-04-13 12:23:32.193251488 +0100
+++ rmap8/mm/fremap.c	2004-04-13 12:23:57.589390688 +0100
@@ -186,15 +186,18 @@ asmlinkage long sys_remap_file_pages(uns
 	/*
 	 * Make sure the vma is shared, that it supports prefaulting,
 	 * and that the remapped range is valid and fully within
-	 * the single existing vma:
+	 * the single existing vma.  vm_private_data is used as a
+	 * swapout cursor in a VM_NONLINEAR vma (unless VM_RESERVED
+	 * or VM_LOCKED, but VM_LOCKED could be revoked later on).
 	 */
 	if (vma && (vma->vm_flags & VM_SHARED) &&
+		(!vma->vm_private_data || (vma->vm_flags & VM_RESERVED)) &&
 		vma->vm_ops && vma->vm_ops->populate &&
 			end > start && start >= vma->vm_start &&
 				end <= vma->vm_end) {
 
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff)
+		if (pgoff != linear_page_index(vma, start))
 			vma->vm_flags |= VM_NONLINEAR;
 
 		/* ->populate can take a long time, so downgrade the lock. */
--- rmap7/mm/mmap.c	2004-04-13 11:02:29.430503792 +0100
+++ rmap8/mm/mmap.c	2004-04-13 12:23:57.591390384 +0100
@@ -333,8 +333,6 @@ static inline int is_mergeable_vma(struc
 		return 0;
 	if (vma->vm_flags != vm_flags)
 		return 0;
-	if (vma->vm_private_data)
-		return 0;
 	return 1;
 }
 
--- rmap7/mm/rmap.c	2004-04-13 12:23:32.202250120 +0100
+++ rmap8/mm/rmap.c	2004-04-13 12:23:57.594389928 +0100
@@ -593,6 +593,94 @@ out:
 	return ret;
 }
 
+/*
+ * try_to_unmap_cluster is only used on VM_NONLINEAR shared object vmas,
+ * in which objrmap is unable to predict where a page will be found.
+ */
+#define CLUSTER_SIZE	(32 * PAGE_SIZE)
+#if     CLUSTER_SIZE  >	PMD_SIZE
+#undef  CLUSTER_SIZE
+#define CLUSTER_SIZE	PMD_SIZE
+#endif
+#define CLUSTER_MASK	(~(CLUSTER_SIZE - 1))
+
+static int try_to_unmap_cluster(struct mm_struct *mm, unsigned long cursor,
+	unsigned int *mapcount, struct vm_area_struct *vma)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	pte_t pteval;
+	struct page *page;
+	unsigned long address;
+	unsigned long end;
+	unsigned long pfn;
+
+	/*
+	 * We need the page_table_lock to protect us from page faults,
+	 * munmap, fork, etc...
+	 */
+	if (!spin_trylock(&mm->page_table_lock))
+		return SWAP_FAIL;
+
+	address = (vma->vm_start + cursor) & CLUSTER_MASK;
+	end = address + CLUSTER_SIZE;
+	if (address < vma->vm_start)
+		address = vma->vm_start;
+	if (end > vma->vm_end)
+		end = vma->vm_end;
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		goto out_unlock;
+
+	pmd = pmd_offset(pgd, address);
+	if (!pmd_present(*pmd))
+		goto out_unlock;
+
+	for (pte = pte_offset_map(pmd, address);
+			address < end; pte++, address += PAGE_SIZE) {
+
+		if (!pte_present(*pte))
+			continue;
+
+		pfn = pte_pfn(*pte);
+		if (!pfn_valid(pfn))
+			continue;
+
+		page = pfn_to_page(pfn);
+		BUG_ON(PageAnon(page));
+		if (PageReserved(page))
+			continue;
+
+		if (ptep_test_and_clear_young(pte))
+			continue;
+
+		/* Nuke the page table entry. */
+		flush_cache_page(vma, address);
+		pteval = ptep_clear_flush(vma, address, pte);
+
+		/* If nonlinear, store the file page offset in the pte. */
+		if (page->index != linear_page_index(vma, address))
+			set_pte(pte, pgoff_to_pte(page->index));
+
+		/* Move the dirty bit to the physical page now the pte is gone. */
+		if (pte_dirty(pteval))
+			set_page_dirty(page);
+
+		page_remove_rmap(page, pte);
+		page_cache_release(page);
+		mm->rss--;
+		(*mapcount)--;
+	}
+
+	pte_unmap(pte);
+
+out_unlock:
+	spin_unlock(&mm->page_table_lock);
+	return SWAP_AGAIN;
+}
+
 /**
  * try_to_unmap_file - unmap file page using the object-based rmap method
  * @page: the page to unmap
@@ -613,6 +701,9 @@ static inline int try_to_unmap_file(stru
 	struct vm_area_struct *vma;
 	unsigned long address;
 	int ret = SWAP_AGAIN;
+	unsigned long cursor;
+	unsigned long max_nl_cursor = 0;
+	unsigned long max_nl_size = 0;
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return ret;
@@ -630,8 +721,22 @@ static inline int try_to_unmap_file(stru
 	}
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		if (unlikely(vma->vm_flags & VM_NONLINEAR))
+		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
+			/*
+			 * Defer unmapping nonlinear to the next loop,
+			 * but take notes while we're here e.g. don't
+			 * want to loop again when no nonlinear vmas.
+			 */
+			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
+				continue;
+			cursor = (unsigned long) vma->vm_private_data;
+			if (cursor > max_nl_cursor)
+				max_nl_cursor = cursor;
+			cursor = vma->vm_end - vma->vm_start;
+			if (cursor > max_nl_size)
+				max_nl_size = cursor;
 			continue;
+		}
 		if (vma->vm_mm->rss) {
 			address = vma_address(vma, pgoff);
 			if (address == -EFAULT)
@@ -642,6 +747,62 @@ static inline int try_to_unmap_file(stru
 				goto out;
 		}
 	}
+
+	if (max_nl_size == 0)	/* no nonlinear vmas of this file */
+		goto out;
+
+	/*
+	 * We don't try to search for this page in the nonlinear vmas,
+	 * and page_referenced wouldn't have found it anyway.  Instead
+	 * just walk the nonlinear vmas trying to age and unmap some.
+	 * The mapcount of the page we came in with is irrelevant,
+	 * but even so use it as a guide to how hard we should try?
+	 */
+	rmap_unlock(page);
+
+	max_nl_size = (max_nl_size + CLUSTER_SIZE - 1) & CLUSTER_MASK;
+	if (max_nl_cursor == 0)
+		max_nl_cursor = CLUSTER_SIZE;
+
+	do {
+		list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+			if (VM_NONLINEAR != (vma->vm_flags &
+			     (VM_NONLINEAR|VM_LOCKED|VM_RESERVED)))
+				continue;
+			cursor = (unsigned long) vma->vm_private_data;
+			while (vma->vm_mm->rss &&
+				cursor < max_nl_cursor &&
+				cursor < vma->vm_end - vma->vm_start) {
+				ret = try_to_unmap_cluster(vma->vm_mm,
+						cursor, &mapcount, vma);
+				if (ret == SWAP_FAIL)
+					break;
+				cursor += CLUSTER_SIZE;
+				vma->vm_private_data = (void *) cursor;
+				if ((int)mapcount <= 0)
+					goto relock;
+				cond_resched();
+			}
+			if (ret != SWAP_FAIL)
+				vma->vm_private_data =
+					(void *) max_nl_cursor;
+			ret = SWAP_AGAIN;
+		}
+		max_nl_cursor += CLUSTER_SIZE;
+	} while (max_nl_cursor <= max_nl_size);
+
+	/*
+	 * Don't loop forever (perhaps all the remaining pages are
+	 * in locked vmas).  Reset cursor on all unreserved nonlinear
+	 * vmas, now forgetting on which ones it had fallen behind.
+	 */
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		if ((vma->vm_flags & (VM_NONLINEAR|VM_RESERVED)) ==
+				VM_NONLINEAR)
+			vma->vm_private_data = 0;
+	}
+relock:
+	rmap_lock(page);
 out:
 	up(&mapping->i_shared_sem);
 	return ret;

