Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUCVUiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUCVUiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:38:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38923 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262388AbUCVUho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:37:44 -0500
Date: Mon, 22 Mar 2004 20:37:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: [PATCH] anobjrmap 7/6 mremap moves
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403222032470.19332-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 7/6 handle mremap movements

The six anobjrmap patches I posted last week, based on 2.6.5-rc1,
left two issues outstanding: locating anon pages after mremap move
of inherited vma, and locating obj pages in a non-linear vma.  I still
haven't done the non-linear, but this handles the mremap move issue,
following Linus' suggestion to just copy pages in the rare case.

It looks a lot more complicated than Linus was imagining, for several
unrelated reasons.  The prime reason is that pages might already have
been swapped out, we'd need to copy those too if shared with another.
So... we swap them back in to make it easy to find them later if we
need to swap them out... hmmm, have we got our priorities right?
Maybe: it is in practice a very rare case, we're just making sure
nobody can clog up the system with mysteriously unswappable pages.

The awkward part is identifying when it is that rare case.  I doubt
anyone else is going to love my rmap_needs_broken_cow function; but
even if this version of rmap goes nowhere, or it does something else
than copying the pages, I think the alternative will always involve
some penalty in the rare shared anon case, so we'll still want to
identify that case, so the rmap_needs_broken_cow code still be
needed (under another name).  Please examine it with scepticism,
especially that smp_rmb() - a giveaway that I'm out of my depth.

There's also more change than expected because, if we're using up
memory to move the vma, and that's a large vma, then we may well
need to free memory from that vma: but in the past the new copy
of the vma has been hidden from the page stealer until afterwards.
Any good reason?  I don't see why, and have changed that.

On previous visits to move_vma I've just changed what I had to and
run away again.  This time I've made it much more how I think it
should be: check map_count at the start, let vma_merge decide on
vma merging, apply do_munmap to old if successful or new if failed,
get accounting right on failure.  Even if anobjrmap codes ends up
in the bin, there's changes here I'd want to put back in mainline.
But I admit that so far this has had less testing than it needs.

Unrelated, but fixes to a couple of points from Rajesh: we need to
be careful about the ordering of the i_mmap lists in case there's a
racing vmtruncate.  There was a good comment in fork.c, but someone
chose exactly the wrong way round when converting to list_add_tail.

One non-issue: I thought there would be a strict commit accounting
difficulty with copying the moved pages in a readonly mapping.  But
in fact not: if they're now anon pages (not file or zero), ancestor
must have been writable in the past, VM_ACCOUNT set then and now
inherited, dup_mmap has already made the pessimistic deduction.

--- anobjrmap6/include/linux/mm.h	2004-03-17 22:00:34.000000000 +0000
+++ anobjrmap7/include/linux/mm.h	2004-03-21 21:45:36.741181120 +0000
@@ -511,6 +511,9 @@ extern void si_meminfo_node(struct sysin
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 	struct rb_node **, struct rb_node *);
+extern struct vm_area_struct *copy_vma(struct vm_area_struct *,
+	unsigned long addr, unsigned long len, unsigned long pgoff);
+extern void vma_relink_file(struct vm_area_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
--- anobjrmap6/include/linux/swap.h	2004-03-17 22:00:34.000000000 +0000
+++ anobjrmap7/include/linux/swap.h	2004-03-21 20:18:35.688901712 +0000
@@ -214,6 +214,8 @@ extern void swap_free(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
 extern sector_t map_swap_page(struct swap_info_struct *, pgoff_t);
 extern struct swap_info_struct *get_swap_info_struct(unsigned);
+extern struct swap_info_struct *swap_info_get(swp_entry_t);
+extern void swap_info_put(struct swap_info_struct *);
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
 
--- anobjrmap6/kernel/fork.c	2004-03-17 22:00:34.000000000 +0000
+++ anobjrmap7/kernel/fork.c	2004-03-21 15:39:59.147202328 +0000
@@ -323,7 +323,7 @@ static inline int dup_mmap(struct mm_str
       
 			/* insert tmp into the share list, just after mpnt */
 			down(&file->f_mapping->i_shared_sem);
-			list_add_tail(&tmp->shared, &mpnt->shared);
+			list_add(&tmp->shared, &mpnt->shared);
 			up(&file->f_mapping->i_shared_sem);
 		}
 
--- anobjrmap6/mm/memory.c	2004-03-17 22:32:46.000000000 +0000
+++ anobjrmap7/mm/memory.c	2004-03-21 16:56:15.291522648 +0000
@@ -1256,11 +1256,13 @@ static int do_swap_page(struct mm_struct
 
 	/* The page isn't present yet, go ahead with the fault. */
 		
+	mm->rss++;
+	page_add_anon_rmap(page, mm, address);
+
 	swap_free(entry);
 	if (vm_swap_full())
 		remove_exclusive_swap_page(page);
 
-	mm->rss++;
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page))
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1268,7 +1270,6 @@ static int do_swap_page(struct mm_struct
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
-	page_add_anon_rmap(page, mm, address);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
--- anobjrmap6/mm/mmap.c	2004-03-16 07:00:20.000000000 +0000
+++ anobjrmap7/mm/mmap.c	2004-03-22 18:06:48.622957992 +0000
@@ -383,7 +383,8 @@ can_vma_merge_after(struct vm_area_struc
  * whether that can be merged with its predecessor or its successor.  Or
  * both (it neatly fills a hole).
  */
-static int vma_merge(struct mm_struct *mm, struct vm_area_struct *prev,
+static struct vm_area_struct *vma_merge(struct mm_struct *mm,
+			struct vm_area_struct *prev,
 			struct rb_node *rb_parent, unsigned long addr, 
 			unsigned long end, unsigned long vm_flags,
 			struct file *file, unsigned long pgoff)
@@ -397,7 +398,7 @@ static int vma_merge(struct mm_struct *m
 	 * vma->vm_flags & VM_SPECIAL, too.
 	 */
 	if (vm_flags & VM_SPECIAL)
-		return 0;
+		return NULL;
 
 	i_shared_sem = file ? &file->f_mapping->i_shared_sem : NULL;
 
@@ -410,7 +411,6 @@ static int vma_merge(struct mm_struct *m
 	 * Can it merge with the predecessor?
 	 */
 	if (prev->vm_end == addr &&
-			is_mergeable_vma(prev, file, vm_flags) &&
 			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
 		struct vm_area_struct *next;
 		int need_up = 0;
@@ -441,12 +441,12 @@ static int vma_merge(struct mm_struct *m
 
 			mm->map_count--;
 			kmem_cache_free(vm_area_cachep, next);
-			return 1;
+			return prev;
 		}
 		spin_unlock(lock);
 		if (need_up)
 			up(i_shared_sem);
-		return 1;
+		return prev;
 	}
 
 	/*
@@ -457,7 +457,7 @@ static int vma_merge(struct mm_struct *m
  merge_next:
 		if (!can_vma_merge_before(prev, vm_flags, file,
 				pgoff, (end - addr) >> PAGE_SHIFT))
-			return 0;
+			return NULL;
 		if (end == prev->vm_start) {
 			if (file)
 				down(i_shared_sem);
@@ -467,11 +467,11 @@ static int vma_merge(struct mm_struct *m
 			spin_unlock(lock);
 			if (file)
 				up(i_shared_sem);
-			return 1;
+			return prev;
 		}
 	}
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -1484,5 +1484,57 @@ void insert_vm_struct(struct mm_struct *
 	if (__vma && __vma->vm_start < vma->vm_end)
 		BUG();
 	vma_link(mm, vma, prev, rb_link, rb_parent);
-	validate_mm(mm);
+}
+
+/*
+ * Copy the vma structure to a new location in the same mm,
+ * prior to moving page table entries, to effect an mremap move.
+ */
+struct vm_area_struct *copy_vma(struct vm_area_struct *vma,
+	unsigned long addr, unsigned long len, unsigned long pgoff)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct vm_area_struct *new_vma, *prev;
+	struct rb_node **rb_link, *rb_parent;
+
+	find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
+	new_vma = vma_merge(mm, prev, rb_parent, addr, addr + len,
+			vma->vm_flags, vma->vm_file, pgoff);
+	if (!new_vma) {
+		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+		if (new_vma) {
+			*new_vma = *vma;
+			INIT_LIST_HEAD(&new_vma->shared);
+			new_vma->vm_start = addr;
+			new_vma->vm_end = addr + len;
+			new_vma->vm_pgoff = pgoff;
+			if (new_vma->vm_file)
+				get_file(new_vma->vm_file);
+			if (new_vma->vm_ops && new_vma->vm_ops->open)
+				new_vma->vm_ops->open(new_vma);
+			vma_link(mm, new_vma, prev, rb_link, rb_parent);
+		}
+	}
+	return new_vma;
+}
+
+/*
+ * Position vma after prev in shared file list:
+ * for mremap move error recovery racing against vmtruncate.
+ */
+void vma_relink_file(struct vm_area_struct *vma, struct vm_area_struct *prev)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct address_space *mapping;
+
+	if (vma->vm_file) {
+		mapping = vma->vm_file->f_mapping;
+		if (mapping) {
+			down(&mapping->i_shared_sem);
+			spin_lock(&mm->page_table_lock);
+			list_move(&vma->shared, &prev->shared);
+			spin_unlock(&mm->page_table_lock);
+			up(&mapping->i_shared_sem);
+		}
+	}
 }
--- anobjrmap6/mm/mremap.c	2004-03-17 22:00:34.000000000 +0000
+++ anobjrmap7/mm/mremap.c	2004-03-22 19:44:32.880455344 +0000
@@ -16,6 +16,8 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/rmap.h>
+#include <linux/pagemap.h>
+#include <linux/swapops.h>
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
@@ -79,30 +81,102 @@ static inline pte_t *alloc_one_pte_map(s
 	return pte;
 }
 
-static void
-copy_one_pte(struct vm_area_struct *vma, unsigned long old_addr,
-	     unsigned long new_addr, pte_t *src, pte_t *dst)
+#ifdef CONFIG_SWAP
+/*
+ * rmap_needs_broken_cow is for mremap MAYMOVE's move_one_page.
+ * The anonmm objrmap can only track anon page movements if the
+ * page (or swap entry) is exclusive to the mm, but we don't
+ * want the waste of early COW break unless it's necessary.
+ * This tells us, with side-effect to update anon rmap if okay.
+ * page_table_lock (and mmap_sem) are held throughout.
+ */
+static int rmap_needs_broken_cow(pte_t *ptep, unsigned long new_addr)
 {
-	pte_t pte;
-
-	pte = ptep_clear_flush(vma, old_addr, src);
-	set_pte(dst, pte);
+	pte_t pte = *ptep;
+	unsigned long pfn;
+	struct page *page;
+	swp_entry_t entry;
+	struct swap_info_struct *si;
+	unsigned int mapcount = 0;
 
-	/*
-	 * This block handles a common case, but is grossly inadequate
-	 * for the general case: what if the anon page is shared with
-	 * parent or child? what if it's currently swapped out?
-	 * Return to handle mremap moving rmap in a later patch.
-	 */
 	if (pte_present(pte)) {
-		unsigned long pfn = pte_pfn(pte);
-		if (pfn_valid(pfn)) {
-			struct page *page = pfn_to_page(pfn);
-			if (PageAnon(page))
-				page_update_anon_rmap(page, vma->vm_mm, new_addr);
+		pfn = pte_pfn(pte);
+		if (!pfn_valid(pfn))
+			return 0;
+		page = pfn_to_page(pfn);
+		if (!PageAnon(page))
+			return 0;
+		if (pte_write(pte))
+			goto update;
+again:
+		/*
+		 * page->private on a PageAnon page is always the
+		 * swap entry (if PageSwapCache) or 0 (if not):
+		 * so we can peep at page->private without taking
+		 * a lock, no need to check PageSwapCache too.
+		 */
+		entry.val = page->private;
+		smp_rmb();
+		mapcount = page->mapcount;
+		if (mapcount > 1)
+			return 1;
+		if (!entry.val)
+			goto update;
+		/*
+		 * This is tricky: entry can get freed right here,
+		 * since we don't hold the page lock (and cannot wait
+		 * for it).  Use swap_duplicate which, already allows
+		 * for that, before the less forgiving swap_info_get.
+		 */
+		if (!swap_duplicate(entry))
+			goto again;
+		si = swap_info_get(entry);
+		if (si) {
+			mapcount = si->swap_map[swp_offset(entry)] +
+					page->mapcount - 2;
+			swap_info_put(si);
+		} else
+			mapcount = 0;
+		swap_free(entry);
+		if (entry.val != page->private)
+			goto again;
+		if (mapcount > 1)
+			return 1;
+update:
+		/* Before we forget the struct page, update its rmap */
+		page_update_anon_rmap(page, current->mm, new_addr);
+		return 0;
+	}
+
+	if (!pte_file(pte) && !pte_none(pte)) {
+		entry = pte_to_swp_entry(pte);
+		si = swap_info_get(entry);
+		if (si) {
+			page = NULL;
+			mapcount = si->swap_map[swp_offset(entry)];
+			if (mapcount == 2) {
+				page = lookup_swap_cache(entry);
+				if (page)
+					mapcount = page->mapcount + 1;
+			}
+			swap_info_put(si);
+			if (page)
+				page_cache_release(page);
 		}
 	}
+
+	return mapcount > 1;
 }
+#else /* !CONFIG_SWAP */
+
+/*
+ * The swap interfaces used above are not available.  Actually,
+ * all of the anonymous rmap is just a waste of space-time in this case.
+ * But no enthusiam for peppering the code with #ifdefs right now.
+ */
+#define rmap_needs_broken_cow(ptep, new_addr)	0
+
+#endif /* CONFIG_SWAP */
 
 static int
 move_one_page(struct vm_area_struct *vma, unsigned long old_addr,
@@ -132,10 +206,15 @@ move_one_page(struct vm_area_struct *vma
 		 * page_table_lock, we should re-check the src entry...
 		 */
 		if (src) {
-			if (dst)
-				copy_one_pte(vma, old_addr, new_addr, src, dst);
-			else
+			if (!dst)
 				error = -ENOMEM;
+			else if (rmap_needs_broken_cow(src, new_addr))
+				error = -EAGAIN;
+			else {
+				pte_t pte;
+				pte = ptep_clear_flush(vma, old_addr, src);
+				set_pte(dst, pte);
+			}
 			pte_unmap_nested(src);
 		}
 		pte_unmap(dst);
@@ -147,7 +226,8 @@ move_one_page(struct vm_area_struct *vma
 static int move_page_tables(struct vm_area_struct *vma,
 	unsigned long new_addr, unsigned long old_addr, unsigned long len)
 {
-	unsigned long offset = len;
+	unsigned long offset = 0;
+	int ret;
 
 	flush_cache_range(vma, old_addr, old_addr + len);
 
@@ -156,137 +236,107 @@ static int move_page_tables(struct vm_ar
 	 * easy way out on the assumption that most remappings will be
 	 * only a few pages.. This also makes error recovery easier.
 	 */
-	while (offset) {
-		offset -= PAGE_SIZE;
-		if (move_one_page(vma, old_addr + offset, new_addr + offset))
-			goto oops_we_failed;
+	while (offset < len) {
+		ret = move_one_page(vma, old_addr+offset, new_addr+offset);
+		if (!ret) {
+			offset += PAGE_SIZE;
+			continue;
+		}
+		if (ret != -EAGAIN)
+			break;
+		/*
+		 * The anonmm objrmap can only track anon page movements
+		 * if the page (or swap entry) is exclusive to this mm. 
+		 * In the very unusual case when it's shared, break COW
+		 * (take a copy of the page) to make it exclusive.  If
+		 * the page is shared and on swap, move_one_page will
+		 * normally succeed on the third attempt (do_swap_page
+		 * does not break COW); but under very great pressure it
+		 * could get swapped out again and need more attempts.
+		 */
+		ret = handle_mm_fault(vma->vm_mm, vma, old_addr+offset, 1);
+		if (ret != VM_FAULT_MINOR && ret != VM_FAULT_MAJOR)
+			break;
 	}
-	return 0;
-
-	/*
-	 * Ok, the move failed because we didn't have enough pages for
-	 * the new page table tree. This is unlikely, but we have to
-	 * take the possibility into account. In that case we just move
-	 * all the pages back (this will work, because we still have
-	 * the old page tables)
-	 */
-oops_we_failed:
-	flush_cache_range(vma, new_addr, new_addr + len);
-	while ((offset += PAGE_SIZE) < len)
-		move_one_page(vma, new_addr + offset, old_addr + offset);
-	zap_page_range(vma, new_addr, len);
-	return -1;
+	return offset;
 }
 
 static unsigned long move_vma(struct vm_area_struct *vma,
-	unsigned long addr, unsigned long old_len, unsigned long new_len,
-	unsigned long new_addr)
+		unsigned long old_addr, unsigned long old_len,
+		unsigned long new_len, unsigned long new_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *new_vma, *next, *prev;
-	int allocated_vma;
+	struct vm_area_struct *new_vma;
+	unsigned long vm_flags = vma->vm_flags;
+	unsigned long new_pgoff;
+	unsigned long moved_len;
+	unsigned long excess = 0;
 	int split = 0;
 
-	new_vma = NULL;
-	next = find_vma_prev(mm, new_addr, &prev);
-	if (next) {
-		if (prev && prev->vm_end == new_addr &&
-		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file &&
-					!(vma->vm_flags & VM_SHARED)) {
-			spin_lock(&mm->page_table_lock);
-			prev->vm_end = new_addr + new_len;
-			spin_unlock(&mm->page_table_lock);
-			new_vma = prev;
-			if (next != prev->vm_next)
-				BUG();
-			if (prev->vm_end == next->vm_start &&
-					can_vma_merge(next, prev->vm_flags)) {
-				spin_lock(&mm->page_table_lock);
-				prev->vm_end = next->vm_end;
-				__vma_unlink(mm, next, prev);
-				spin_unlock(&mm->page_table_lock);
-				if (vma == next)
-					vma = prev;
-				mm->map_count--;
-				kmem_cache_free(vm_area_cachep, next);
-			}
-		} else if (next->vm_start == new_addr + new_len &&
-			  	can_vma_merge(next, vma->vm_flags) &&
-				!vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
-			spin_lock(&mm->page_table_lock);
-			next->vm_start = new_addr;
-			spin_unlock(&mm->page_table_lock);
-			new_vma = next;
-		}
-	} else {
-		prev = find_vma(mm, new_addr-1);
-		if (prev && prev->vm_end == new_addr &&
-		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file &&
-				!(vma->vm_flags & VM_SHARED)) {
-			spin_lock(&mm->page_table_lock);
-			prev->vm_end = new_addr + new_len;
-			spin_unlock(&mm->page_table_lock);
-			new_vma = prev;
-		}
-	}
+	/*
+	 * We'd prefer to avoid failure later on in do_munmap:
+	 * which may split one vma into three before unmapping.
+	 */
+	if (mm->map_count >= MAX_MAP_COUNT - 3)
+		return -ENOMEM;
 
-	allocated_vma = 0;
-	if (!new_vma) {
-		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-		if (!new_vma)
-			goto out;
-		allocated_vma = 1;
-	}
-
-	if (!move_page_tables(vma, new_addr, addr, old_len)) {
-		unsigned long vm_locked = vma->vm_flags & VM_LOCKED;
-
-		if (allocated_vma) {
-			*new_vma = *vma;
-			INIT_LIST_HEAD(&new_vma->shared);
-			new_vma->vm_start = new_addr;
-			new_vma->vm_end = new_addr+new_len;
-			new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;
-			if (new_vma->vm_file)
-				get_file(new_vma->vm_file);
-			if (new_vma->vm_ops && new_vma->vm_ops->open)
-				new_vma->vm_ops->open(new_vma);
-			insert_vm_struct(current->mm, new_vma);
-		}
+	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
+	new_vma = copy_vma(vma, new_addr, new_len, new_pgoff);
+	if (!new_vma)
+		return -ENOMEM;
 
-		/* Conceal VM_ACCOUNT so old reservation is not undone */
-		if (vma->vm_flags & VM_ACCOUNT) {
-			vma->vm_flags &= ~VM_ACCOUNT;
-			if (addr > vma->vm_start) {
-				if (addr + old_len < vma->vm_end)
-					split = 1;
-			} else if (addr + old_len == vma->vm_end)
-				vma = NULL;	/* it will be removed */
-		} else
-			vma = NULL;		/* nothing more to do */
+	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
+	if (moved_len < old_len) {
+		/*
+		 * On error, move entries back from new area to old,
+		 * which will succeed since page tables still there,
+		 * and then proceed to unmap new area instead of old.
+		 *
+		 * Subtle point from Rajesh Venkatasubramanian: before
+		 * moving file-based ptes, move new_vma before old vma
+		 * in the i_mmap or i_mmap_shared list, so when racing
+		 * against vmtruncate we cannot propagate pages to be
+		 * truncated back from new_vma into just cleaned old.
+		 */
+		vma_relink_file(vma, new_vma);
+		move_page_tables(new_vma, old_addr, new_addr, moved_len);
+		vma = new_vma;
+		old_len = new_len;
+		old_addr = new_addr;
+		new_addr = -ENOMEM;
+	}
 
-		do_munmap(current->mm, addr, old_len);
+	/* Conceal VM_ACCOUNT so old reservation is not undone */
+	if (vm_flags & VM_ACCOUNT) {
+		vma->vm_flags &= ~VM_ACCOUNT;
+		excess = vma->vm_end - vma->vm_start - old_len;
+		if (old_addr > vma->vm_start &&
+		    old_addr + old_len < vma->vm_end)
+			split = 1;
+	}
 
-		/* Restore VM_ACCOUNT if one or two pieces of vma left */
-		if (vma) {
-			vma->vm_flags |= VM_ACCOUNT;
-			if (split)
-				vma->vm_next->vm_flags |= VM_ACCOUNT;
-		}
+	if (do_munmap(mm, old_addr, old_len) < 0) {
+		/* OOM: unable to split vma, just get accounts right */
+		vm_unacct_memory(excess >> PAGE_SHIFT);
+		excess = 0;
+	}
 
-		current->mm->total_vm += new_len >> PAGE_SHIFT;
-		if (vm_locked) {
-			current->mm->locked_vm += new_len >> PAGE_SHIFT;
-			if (new_len > old_len)
-				make_pages_present(new_addr + old_len,
-						   new_addr + new_len);
-		}
-		return new_addr;
+	/* Restore VM_ACCOUNT if one or two pieces of vma left */
+	if (excess) {
+		vma->vm_flags |= VM_ACCOUNT;
+		if (split)
+			vma->vm_next->vm_flags |= VM_ACCOUNT;
 	}
-	if (allocated_vma)
-		kmem_cache_free(vm_area_cachep, new_vma);
- out:
-	return -ENOMEM;
+
+	mm->total_vm += new_len >> PAGE_SHIFT;
+	if (vm_flags & VM_LOCKED) {
+		mm->locked_vm += new_len >> PAGE_SHIFT;
+		if (new_len > old_len)
+			make_pages_present(new_addr + old_len,
+					   new_addr + new_len);
+	}
+
+	return new_addr;
 }
 
 /*
@@ -430,6 +480,7 @@ unsigned long do_mremap(unsigned long ad
 	if (flags & MREMAP_MAYMOVE) {
 		if (!(flags & MREMAP_FIXED)) {
 			unsigned long map_flags = 0;
+
 			if (vma->vm_flags & VM_MAYSHARE)
 				map_flags |= MAP_SHARED;
 
--- anobjrmap6/mm/rmap.c	2004-03-17 22:00:34.000000000 +0000
+++ anobjrmap7/mm/rmap.c	2004-03-22 18:08:27.851872904 +0000
@@ -25,6 +25,8 @@
 #include <linux/init.h>
 #include <linux/rmap.h>
 
+#include <asm/tlbflush.h>
+
 /*
  * struct anonmm: to track a bundle of anonymous memory mappings.
  *
@@ -483,7 +485,6 @@ static int try_to_unmap_one(struct page 
 
 	/*
 	 * If the page is mlock()d, we cannot swap it out.
-	 * During mremap, it's possible pages are not in a VMA.
 	 */
 	if (!vma)
 		vma = find_vma(mm, address);
--- anobjrmap6/mm/swap_state.c	2004-03-17 22:00:34.000000000 +0000
+++ anobjrmap7/mm/swap_state.c	2004-03-21 19:14:35.492700272 +0000
@@ -120,6 +120,7 @@ void __delete_from_swap_cache(struct pag
 	BUG_ON(PageWriteback(page));
 
 	radix_tree_delete(&swapper_space.page_tree, page->private);
+	page->private = 0;
 	ClearPageSwapCache(page);
 	total_swapcache_pages--;
 	pagecache_acct(-1);
--- anobjrmap6/mm/swapfile.c	2004-03-17 22:00:34.000000000 +0000
+++ anobjrmap7/mm/swapfile.c	2004-03-21 20:19:30.156621360 +0000
@@ -158,7 +158,7 @@ out:
 	return entry;
 }
 
-static struct swap_info_struct * swap_info_get(swp_entry_t entry)
+struct swap_info_struct * swap_info_get(swp_entry_t entry)
 {
 	struct swap_info_struct * p;
 	unsigned long offset, type;
@@ -197,7 +197,7 @@ out:
 	return NULL;
 }	
 
-static void swap_info_put(struct swap_info_struct * p)
+void swap_info_put(struct swap_info_struct * p)
 {
 	swap_device_unlock(p);
 	swap_list_unlock();
@@ -254,7 +254,7 @@ static int exclusive_swap_page(struct pa
 		if (p->swap_map[swp_offset(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
 			spin_lock(&swapper_space.page_lock);
-			if (page_count(page) - !!PagePrivate(page) == 2)
+			if (page_count(page) == 2)
 				retval = 1;
 			spin_unlock(&swapper_space.page_lock);
 		}

