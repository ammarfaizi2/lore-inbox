Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUCZOad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbUCZOad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:30:33 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19989 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263089AbUCZO3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:29:35 -0500
Date: Fri, 26 Mar 2004 14:29:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: Andrea Arcangeli <andrea@suse.de>
Subject: [PATCH] anobjrmap 8/6 unmap nonlinear
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403261427350.17331-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 8/6 unmap nonlinear

The six anobjrmap patches I posted last week, based 2.6.5-rc1,
left two issues outstanding.  Patch 7/6 dealt with mremap move
earlier this week, now this 8/6 handles try_to_unmap on nonlinear
vmas (those to which sys_remap_file_pages has been applied).

Less draconian than Andrea's solution, which punished users of
unlocked nonlinear vmas by unmapping every pte of every nonlinear
vma of the file whenever any page of the file reached try_to_unmap
(later version reprieves ptes with referenced flag set, but they'll
tend to get unmapped as soon as the next page comes down).  If you
find this method works well, Andrea, and you're in a mood to forgive
the users of unlocked nonlinear vmas, please grab it for your tree:
nothing specific to anonmm about it.

Ignoring the page requested, try to unmap cluster of 32 neighbouring
ptes (in worst case all empty slots) in a nonlinear vma, then move
on to the next vma; stopping when we've unmapped at least as many
maps as the requested page had (vague guide of how hard to try),
or have reached the end.  Use vm_private_data a little like the old
mm->swap_address, as a cursor recording how far we got, so we don't
attack the same ptes next time around (earlier tried inserting an
empty marker vma in the list, but that got messy).

Existing users of vm_private_data have either VM_RESERVED or
VM_DONTEXPAND set, both of which are in the VM_SPECIAL category
where we never try to merge vmas: so removed vm_private_data
test from is_mergeable_vma, so we can still merge VM_NONLINEARs.
Of course, we could instead add another field to vm_area_struct.

In addition, page_referenced report page as unreferenced if it
cannot get the semaphore or spinlock, so try_to_unmap will try
for it (but check referenced flag): following Andrea, to avoid
shm livelock he encountered.

 fremap.c |    5 +
 mmap.c   |    2 
 rmap.c   |  250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 219 insertions(+), 38 deletions(-)

--- anobjrmap7/mm/fremap.c	2004-03-17 22:00:34.000000000 +0000
+++ anobjrmap8/mm/fremap.c	2004-03-26 13:33:21.504036832 +0000
@@ -186,9 +186,12 @@ asmlinkage long sys_remap_file_pages(uns
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
--- anobjrmap7/mm/mmap.c	2004-03-25 21:42:20.698394304 +0000
+++ anobjrmap8/mm/mmap.c	2004-03-26 13:33:21.505036680 +0000
@@ -331,8 +331,6 @@ static inline int is_mergeable_vma(struc
 		return 0;
 	if (vma->vm_flags != vm_flags)
 		return 0;
-	if (vma->vm_private_data)
-		return 0;
 	return 1;
 }
 
--- anobjrmap7/mm/rmap.c	2004-03-25 21:42:20.703393544 +0000
+++ anobjrmap8/mm/rmap.c	2004-03-26 13:33:21.509036072 +0000
@@ -182,10 +182,8 @@ static int page_referenced_one(struct pa
 	pte_t *pte;
 	int referenced = 0;
 
-	if (!spin_trylock(&mm->page_table_lock)) {
-		referenced++;
-		goto out;
-	}
+	if (!spin_trylock(&mm->page_table_lock))
+		return 0;
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -212,8 +210,6 @@ out_unmap:
 
 out_unlock:
 	spin_unlock(&mm->page_table_lock);
-
-out:
 	return referenced;
 }
 
@@ -267,7 +263,7 @@ out:
  * This function is only called from page_referenced for object-based pages.
  *
  * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
- * assume a reference count of 1.
+ * assume a reference count of 0, so try_to_unmap will then have a go.
  */
 static inline int page_referenced_obj(struct page *page, int *mapcount)
 {
@@ -277,30 +273,39 @@ static inline int page_referenced_obj(st
 	int referenced = 0;
 
 	if (down_trylock(&mapping->i_shared_sem))
-		return 1;
+		return 0;
 
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
 		if (!vma->vm_mm->rss)
 			continue;
 		address = vma_address(page, vma);
-		if (address != NOADDR) {
-			referenced += page_referenced_one(
-				page, vma->vm_mm, address, mapcount);
-			if (!*mapcount)
-				goto out;
+		if (address == NOADDR)
+			continue;
+		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE)) ==
+					(VM_LOCKED|VM_MAYSHARE)) {
+			referenced++;
+			goto out;
 		}
+		referenced += page_referenced_one(
+			page, vma->vm_mm, address, mapcount);
+		if (!*mapcount)
+			goto out;
 	}
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		if (!vma->vm_mm->rss)
+		if (!vma->vm_mm->rss || (vma->vm_flags & VM_NONLINEAR))
 			continue;
 		address = vma_address(page, vma);
-		if (address != NOADDR) {
-			referenced += page_referenced_one(
-				page, vma->vm_mm, address, mapcount);
-			if (!*mapcount)
-				goto out;
+		if (address == NOADDR)
+			continue;
+		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
+			referenced++;
+			goto out;
 		}
+		referenced += page_referenced_one(
+			page, vma->vm_mm, address, mapcount);
+		if (!*mapcount)
+			goto out;
 	}
 out:
 	up(&mapping->i_shared_sem);
@@ -483,13 +488,21 @@ static int try_to_unmap_one(struct page 
 
 	(*mapcount)--;
 
+	if (!vma) {
+		vma = find_vma(mm, address);
+		/* unmap_vmas drops page_table_lock with vma unlinked */
+		if (!vma)
+			goto out_unmap;
+	}
+
 	/*
 	 * If the page is mlock()d, we cannot swap it out.
+	 * If it's recently referenced (perhaps page_referenced
+	 * skipped over this mm) then we should reactivate it.
 	 */
-	if (!vma)
-		vma = find_vma(mm, address);
-	if (!vma || (vma->vm_flags & (VM_LOCKED|VM_RESERVED))) {
-		ret =  SWAP_FAIL;
+	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
+			ptep_test_and_clear_young(pte)) {
+		ret = SWAP_FAIL;
 		goto out_unmap;
 	}
 
@@ -528,6 +541,100 @@ out:
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
+static int try_to_unmap_cluster(struct mm_struct *mm,
+	unsigned long cursor, int *mapcount, struct vm_area_struct *vma)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	pte_t pteval;
+	struct page *page;
+	unsigned long address;
+	unsigned long end;
+	unsigned long pfn;
+	unsigned long pgidx;
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
+		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
+		pgidx += vma->vm_pgoff;
+		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
+		if (page->index != pgidx) {
+			set_pte(pte, pgoff_to_pte(page->index));
+			BUG_ON(!pte_file(*pte));
+		}
+
+		/* Move the dirty bit to the physical page now the pte is gone. */
+		if (pte_dirty(pteval))
+			set_page_dirty(page);
+
+		page_remove_rmap(page);
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
 static inline int try_to_unmap_anon(struct page *page, int *mapcount)
 {
 	struct anonmm *anonmm = (struct anonmm *) page->mapping;
@@ -584,6 +691,9 @@ static inline int try_to_unmap_obj(struc
 	struct vm_area_struct *vma;
 	unsigned long address;
 	int ret = SWAP_AGAIN;
+	unsigned long cursor;
+	unsigned long max_nl_cursor = 0;
+	unsigned long max_nl_size = 0;
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return ret;
@@ -592,26 +702,96 @@ static inline int try_to_unmap_obj(struc
 		if (!vma->vm_mm->rss)
 			continue;
 		address = vma_address(page, vma);
-		if (address != NOADDR) {
-			ret = try_to_unmap_one(
-				page, vma->vm_mm, address, mapcount, vma);
-			if (ret == SWAP_FAIL || !*mapcount)
-				goto out;
-		}
+		if (address == NOADDR)
+			continue;
+		ret = try_to_unmap_one(
+			page, vma->vm_mm, address, mapcount, vma);
+		if (ret == SWAP_FAIL || !*mapcount)
+			goto out;
 	}
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
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
+			continue;
+		}
 		if (!vma->vm_mm->rss)
 			continue;
 		address = vma_address(page, vma);
-		if (address != NOADDR) {
-			ret = try_to_unmap_one(
-				page, vma->vm_mm, address, mapcount, vma);
-			if (ret == SWAP_FAIL || !*mapcount)
-				goto out;
-		}
+		if (address == NOADDR)
+			continue;
+		ret = try_to_unmap_one(
+			page, vma->vm_mm, address, mapcount, vma);
+		if (ret == SWAP_FAIL || !*mapcount)
+			goto out;
 	}
 
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
+						cursor, mapcount, vma);
+				if (ret == SWAP_FAIL)
+					break;
+				cursor += CLUSTER_SIZE;
+				vma->vm_private_data = (void *) cursor;
+				if (*mapcount <= 0)
+					goto relock;
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

