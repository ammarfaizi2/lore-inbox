Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUDOXgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 19:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUDOXgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 19:36:24 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:32306 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261210AbUDOXer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 19:34:47 -0400
Date: Fri, 16 Apr 2004 00:34:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 11 mremap moves
In-Reply-To: <Pine.LNX.4.44.0404160030330.10431-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404160033380.10431-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmap 11 handle mremap movements

A weakness of the anonmm scheme is its difficulty in tracking pages
shared between two or more mms (one being an ancestor of the other),
when mremap has been used to move a range of pages in one of those mms.
mremap move is not very common anyway, and it's more often used on a
page range exclusive to the mm; but uncommon though it may be,
we must not allow unlocked pages to become unswappable.

This patch follows Linus' suggestion, simply to take a private copy of
the page in such a case: early C-O-W.  My previous implementation was
daft with respect to pages currently on swap: it insisted on swapping
them in to copy them.  No need for that: just take the copy when a page
is brought in from swap, and its intended address is found to clash
with what rmap has already noted.

If do_swap_page has to make this copy in the mremap moved case (simply
a call to do_wp_page), might as well do so also in the case when it's a
write access but the page not exclusive, it's always seemed a little odd
that swapin needed a second fault for that.  A bug even: get_user_pages
force imagines that a single call to handle_mm_fault must break C-O-W.
Another bugfix: swapoff's unuse_process didn't check is_vm_hugetlb_page.

Andrea's anon_vma has no such problem with mremap moved pages, handling
them with elegant use of vm_pgoff - though at some cost to vma merging.
How important is it to handle them efficiently?  For now there's a msg
printk(KERN_WARNING "%s: mremap moved %d cows\n", current->comm, cows);

 include/linux/rmap.h |   46 +++++++++++++++++++++++++++++++++++++++
 mm/memory.c          |   11 ++++++++-
 mm/mremap.c          |   59 ++++++++++++++++++++++++++++++++++-----------------
 mm/rmap.c            |   32 +++++++++++++++++++++++++++
 mm/swapfile.c        |   42 +++++++++++++++++++++++++-----------
 5 files changed, 157 insertions(+), 33 deletions(-)

--- rmap10/include/linux/rmap.h	2004-04-15 20:24:06.976219816 +0100
+++ rmap11/include/linux/rmap.h	2004-04-15 20:24:18.452475160 +0100
@@ -34,6 +34,52 @@ static inline void page_dup_rmap(struct 
 	rmap_unlock(page);
 }
 
+int fastcall mremap_move_anon_rmap(struct page *page, unsigned long addr);
+
+/**
+ * mremap_moved_anon_rmap - does new address clash with that noted?
+ * @page:	the page just brought back in from swap
+ * @addr:	the user virtual address at which it is mapped
+ *
+ * Returns boolean, true if addr clashes with address already in page.
+ *
+ * For do_swap_page and unuse_pte: anonmm rmap cannot find the page if
+ * it's at different addresses in different mms, so caller must take a
+ * copy of the page to avoid that: not very clever, but too rare a case
+ * to merit cleverness.
+ */
+static inline int mremap_moved_anon_rmap(struct page *page, unsigned long addr)
+{
+	return page->index != (addr & PAGE_MASK);
+}
+
+/**
+ * make_page_exclusive - try to make page exclusive to one mm
+ * @vma		the vm_area_struct covering this address
+ * @addr	the user virtual address of the page in question
+ *
+ * Assumes that the page at this address is anonymous (COWable),
+ * and that the caller holds mmap_sem for reading or for writing.
+ *
+ * For mremap's move_page_tables and for swapoff's unuse_process:
+ * not a general purpose routine, and in general may not succeed.
+ * But move_page_tables loops until it succeeds, and unuse_process
+ * holds the original page locked, which protects against races.
+ */
+static inline int make_page_exclusive(struct vm_area_struct *vma,
+					unsigned long addr)
+{
+	switch (handle_mm_fault(vma->vm_mm, vma, addr, 1)) {
+	case VM_FAULT_MINOR:
+	case VM_FAULT_MAJOR:
+		return 0;
+	case VM_FAULT_OOM:
+		return -ENOMEM;
+	default:
+		return -EFAULT;
+	}
+}
+
 /*
  * Called from kernel/fork.c to manage anonymous memory
  */
--- rmap10/mm/memory.c	2004-04-15 20:23:55.475968120 +0100
+++ rmap11/mm/memory.c	2004-04-15 20:24:18.454474856 +0100
@@ -1376,14 +1376,23 @@ static int do_swap_page(struct mm_struct
 
 	mm->rss++;
 	pte = mk_pte(page, vma->vm_page_prot);
-	if (write_access && can_share_swap_page(page))
+	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
+		write_access = 0;
+	}
 	unlock_page(page);
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
 	page_add_anon_rmap(page, mm, address);
 
+	if (write_access || mremap_moved_anon_rmap(page, address)) {
+		if (do_wp_page(mm, vma, address,
+				page_table, pmd, pte) == VM_FAULT_OOM)
+			ret = VM_FAULT_OOM;
+		goto out;
+	}
+
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
 	pte_unmap(page_table);
--- rmap10/mm/mremap.c	2004-04-15 20:23:55.476967968 +0100
+++ rmap11/mm/mremap.c	2004-04-15 20:24:18.456474552 +0100
@@ -79,23 +79,19 @@ static inline pte_t *alloc_one_pte_map(s
 	return pte;
 }
 
-static void
-copy_one_pte(struct vm_area_struct *vma, unsigned long old_addr,
-	     unsigned long new_addr, pte_t *src, pte_t *dst)
+static inline int
+can_move_one_pte(pte_t *src, unsigned long new_addr)
 {
-	pte_t pte = ptep_clear_flush(vma, old_addr, src);
-	set_pte(dst, pte);
-
-	if (pte_present(pte)) {
-		unsigned long pfn = pte_pfn(pte);
+	int move = 1;
+	if (pte_present(*src)) {
+		unsigned long pfn = pte_pfn(*src);
 		if (pfn_valid(pfn)) {
 			struct page *page = pfn_to_page(pfn);
-			if (PageAnon(page)) {
-				page_remove_rmap(page);
-				page_add_anon_rmap(page, vma->vm_mm, new_addr);
-			}
+			if (PageAnon(page))
+				move = mremap_move_anon_rmap(page, new_addr);
 		}
 	}
+	return move;
 }
 
 static int
@@ -126,10 +122,15 @@ move_one_page(struct vm_area_struct *vma
 		 * page_table_lock, we should re-check the src entry...
 		 */
 		if (src) {
-			if (dst)
-				copy_one_pte(vma, old_addr, new_addr, src, dst);
-			else
+			if (!dst)
 				error = -ENOMEM;
+			else if (!can_move_one_pte(src, new_addr))
+				error = -EAGAIN;
+			else {
+				pte_t pte;
+				pte = ptep_clear_flush(vma, old_addr, src);
+				set_pte(dst, pte);
+			}
 			pte_unmap_nested(src);
 		}
 		pte_unmap(dst);
@@ -139,7 +140,8 @@ move_one_page(struct vm_area_struct *vma
 }
 
 static int move_page_tables(struct vm_area_struct *vma,
-	unsigned long new_addr, unsigned long old_addr, unsigned long len)
+		unsigned long new_addr, unsigned long old_addr,
+		unsigned long len, int *cows)
 {
 	unsigned long offset;
 
@@ -151,8 +153,23 @@ static int move_page_tables(struct vm_ar
 	 * only a few pages.. This also makes error recovery easier.
 	 */
 	for (offset = 0; offset < len; offset += PAGE_SIZE) {
-		if (move_one_page(vma, old_addr+offset, new_addr+offset) < 0)
+		int ret = move_one_page(vma, old_addr+offset, new_addr+offset);
+		/*
+		 * The anonmm objrmap can only track anon page movements
+		 * if the page is exclusive to one mm.  In the rare case
+		 * when mremap move is applied to a shared page, break
+		 * COW (take a copy of the page) to make it exclusive.
+		 * If shared while on swap, page will be copied when
+		 * brought back in (if it's still shared by then).
+		 */
+		if (ret == -EAGAIN) {
+			ret = make_page_exclusive(vma, old_addr+offset);
+			offset -= PAGE_SIZE;
+			(*cows)++;
+		}
+		if (ret)
 			break;
+		cond_resched();
 	}
 	return offset;
 }
@@ -168,6 +185,7 @@ static unsigned long move_vma(struct vm_
 	unsigned long moved_len;
 	unsigned long excess = 0;
 	int split = 0;
+	int cows = 0;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -181,7 +199,7 @@ static unsigned long move_vma(struct vm_
 	if (!new_vma)
 		return -ENOMEM;
 
-	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
+	moved_len = move_page_tables(vma, new_addr, old_addr, old_len, &cows);
 	if (moved_len < old_len) {
 		/*
 		 * On error, move entries back from new area to old,
@@ -195,12 +213,15 @@ static unsigned long move_vma(struct vm_
 		 * truncated back from new_vma into just cleaned old.
 		 */
 		vma_relink_file(vma, new_vma);
-		move_page_tables(new_vma, old_addr, new_addr, moved_len);
+		move_page_tables(new_vma, old_addr, new_addr, moved_len, &cows);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
 		new_addr = -ENOMEM;
 	}
+	if (cows)	/* Downgrade or remove this message later */
+		printk(KERN_WARNING "%s: mremap moved %d cows\n",
+							current->comm, cows);
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT) {
--- rmap10/mm/rmap.c	2004-04-15 20:24:06.983218752 +0100
+++ rmap11/mm/rmap.c	2004-04-15 20:24:18.458474248 +0100
@@ -261,6 +261,12 @@ static inline int page_referenced_anon(s
 		}
 	}
 
+	/*
+	 * The warning below may appear if page_referenced catches the
+	 * page in between page_add_rmap and its replacement demanded
+	 * by mremap_moved_anon_page: so remove the warning once we're
+	 * convinced that anonmm rmap really is finding its pages.
+	 */
 	WARN_ON(!failed);
 out:
 	spin_unlock(&anonhd->lock);
@@ -449,6 +455,32 @@ void fastcall page_remove_rmap(struct pa
 }
 
 /**
+ * mremap_move_anon_rmap - try to note new address of anonymous page
+ * @page:	page about to be moved
+ * @address:	user virtual address at which it is going to be mapped
+ *
+ * Returns boolean, true if page is not shared, so address updated.
+ *
+ * For mremap's can_move_one_page: to update address when vma is moved,
+ * provided that anon page is not shared with a parent or child mm.
+ * If it is shared, then caller must take a copy of the page instead:
+ * not very clever, but too rare a case to merit cleverness.
+ */
+int fastcall mremap_move_anon_rmap(struct page *page, unsigned long address)
+{
+	int move = 0;
+	if (page->mapcount == 1) {
+		rmap_lock(page);
+		if (page->mapcount == 1) {
+			page->index = address & PAGE_MASK;
+			move = 1;
+		}
+		rmap_unlock(page);
+	}
+	return move;
+}
+
+/**
  ** Subfunctions of try_to_unmap: try_to_unmap_one called
  ** repeatedly from either try_to_unmap_anon or try_to_unmap_file.
  **/
--- rmap10/mm/swapfile.c	2004-04-15 20:23:55.485966600 +0100
+++ rmap11/mm/swapfile.c	2004-04-15 20:24:18.461473792 +0100
@@ -7,6 +7,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
@@ -465,7 +466,7 @@ unuse_pte(struct vm_area_struct *vma, un
 }
 
 /* vma->vm_mm->page_table_lock is held */
-static int unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
+static unsigned long unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
 	unsigned long address, unsigned long size, unsigned long offset,
 	swp_entry_t entry, struct page *page)
 {
@@ -494,7 +495,8 @@ static int unuse_pmd(struct vm_area_stru
 		if (unlikely(pte_same(*pte, swp_pte))) {
 			unuse_pte(vma, offset + address, pte, entry, page);
 			pte_unmap(pte);
-			return 1;
+			/* add 1 since address may be 0 */
+			return 1 + offset + address;
 		}
 		address += PAGE_SIZE;
 		pte++;
@@ -504,12 +506,13 @@ static int unuse_pmd(struct vm_area_stru
 }
 
 /* vma->vm_mm->page_table_lock is held */
-static int unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
+static unsigned long unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
 	unsigned long address, unsigned long size,
 	swp_entry_t entry, struct page *page)
 {
 	pmd_t * pmd;
 	unsigned long offset, end;
+	unsigned long foundaddr;
 
 	if (pgd_none(*dir))
 		return 0;
@@ -527,9 +530,10 @@ static int unuse_pgd(struct vm_area_stru
 	if (address >= end)
 		BUG();
 	do {
-		if (unuse_pmd(vma, pmd, address, end - address,
-				offset, entry, page))
-			return 1;
+		foundaddr = unuse_pmd(vma, pmd, address, end - address,
+						offset, entry, page);
+		if (foundaddr)
+			return foundaddr;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -537,16 +541,19 @@ static int unuse_pgd(struct vm_area_stru
 }
 
 /* vma->vm_mm->page_table_lock is held */
-static int unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
+static unsigned long unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
 	swp_entry_t entry, struct page *page)
 {
 	unsigned long start = vma->vm_start, end = vma->vm_end;
+	unsigned long foundaddr;
 
 	if (start >= end)
 		BUG();
 	do {
-		if (unuse_pgd(vma, pgdir, start, end - start, entry, page))
-			return 1;
+		foundaddr = unuse_pgd(vma, pgdir, start, end - start,
+						entry, page);
+		if (foundaddr)
+			return foundaddr;
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		pgdir++;
 	} while (start && (start < end));
@@ -557,18 +564,27 @@ static int unuse_process(struct mm_struc
 			swp_entry_t entry, struct page* page)
 {
 	struct vm_area_struct* vma;
+	unsigned long foundaddr = 0;
+	int ret = 0;
 
 	/*
 	 * Go through process' page directory.
 	 */
+	down_read(&mm->mmap_sem);
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
-		if (unuse_vma(vma, pgd, entry, page))
-			break;
+		if (!is_vm_hugetlb_page(vma)) {
+			pgd_t * pgd = pgd_offset(mm, vma->vm_start);
+			foundaddr = unuse_vma(vma, pgd, entry, page);
+			if (foundaddr)
+				break;
+		}
 	}
 	spin_unlock(&mm->page_table_lock);
-	return 0;
+	if (foundaddr && mremap_moved_anon_rmap(page, foundaddr))
+		ret = make_page_exclusive(vma, foundaddr);
+	up_read(&mm->mmap_sem);
+	return ret;
 }
 
 /*

