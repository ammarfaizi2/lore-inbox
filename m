Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263654AbUERWOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUERWOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUERWNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:13:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13047 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263665AbUERWK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:10:27 -0400
Date: Tue, 18 May 2004 23:07:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 36 mprotect use vma_merge
In-Reply-To: <Pine.LNX.4.44.0405182304150.3416-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405182307130.3416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier on, in 2.6.6, we took the vma merging code out of mremap.c
and let it rely on vma_merge instead (via copy_vma).  Now take the
vma merging code out of mprotect.c and let it rely on vma_merge too:
so vma_merge becomes the sole vma merging engine.  The fruit of this
consolidation is that mprotect now merges file-backed vmas naturally.
Make this change now because anon_vma will complicate the vma merging
rules, let's keep them all in one place.

vma_merge remains where the decisions are made, whether to merge with
prev and/or next; but now [addr,end) may be the latter part of prev, or
first part or whole of next, whereas before it was always a new area.

vma_adjust carries out vma_merge's decision, but when sliding the
boundary between vma and next, must temporarily remove next from the
prio_tree too.  And it turned out (by oops) to have a surer idea of
whether next needs to be removed than vma_merge, so the fput and
freeing moves into vma_adjust.

Too much decipherment of what's going on at the start of vma_adjust?
Yes, and there's a delicate assumption that you may use vma_adjust in
sliding a boundary, or splitting in two, or growing a vma (mremap uses
it in that way), but not for simply shrinking a vma.  Which is so, and
must be so (how could pages mapped in the part to go, be zapped without
first splitting?), but would feel better with some protection.

__vma_unlink can then be moved from mm.h to mmap.c, and
mm.h's more misleading than helpful can_vma_merge is deleted.

 include/linux/mm.h |   29 +-------
 mm/mmap.c          |  172 +++++++++++++++++++++++++++++++++++++++--------------
 mm/mprotect.c      |  110 ++++++++-------------------------
 3 files changed, 159 insertions(+), 152 deletions(-)

--- rmap35/include/linux/mm.h	2004-05-18 20:50:45.788661560 +0100
+++ rmap36/include/linux/mm.h	2004-05-18 20:50:58.875672032 +0100
@@ -607,7 +607,12 @@ struct vm_area_struct *vma_prio_tree_nex
 
 /* mmap.c */
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *next);
+	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert);
+extern struct vm_area_struct *vma_merge(struct mm_struct *,
+	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
+	unsigned long vm_flags, struct file *, pgoff_t, struct mempolicy *);
+extern int split_vma(struct mm_struct *,
+	struct vm_area_struct *, unsigned long addr, int new_below);
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 	struct rb_node **, struct rb_node *);
@@ -638,26 +643,6 @@ extern int do_munmap(struct mm_struct *,
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
-static inline void
-__vma_unlink(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev)
-{
-	prev->vm_next = vma->vm_next;
-	rb_erase(&vma->vm_rb, &mm->mm_rb);
-	if (mm->mmap_cache == vma)
-		mm->mmap_cache = prev;
-}
-
-static inline int
-can_vma_merge(struct vm_area_struct *vma, unsigned long vm_flags)
-{
-#ifdef CONFIG_MMU
-	if (!vma->vm_file && vma->vm_flags == vm_flags)
-		return 1;
-#endif
-	return 0;
-}
-
 /* filemap.c */
 extern unsigned long page_unuse(struct page *);
 extern void truncate_inode_pages(struct address_space *, loff_t);
@@ -691,8 +676,6 @@ extern int expand_stack(struct vm_area_s
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
 					     struct vm_area_struct **pprev);
-extern int split_vma(struct mm_struct * mm, struct vm_area_struct * vma,
-		     unsigned long addr, int new_below);
 
 /* Look up the first VMA which intersects the interval start_addr..end_addr-1,
    NULL if none.  Assume start_addr < end_addr. */
--- rmap35/mm/mmap.c	2004-05-18 20:50:45.816657304 +0100
+++ rmap36/mm/mmap.c	2004-05-18 20:50:58.878671576 +0100
@@ -338,20 +338,51 @@ __insert_vm_struct(struct mm_struct * mm
 	validate_mm(mm);
 }
 
+static inline void
+__vma_unlink(struct mm_struct *mm, struct vm_area_struct *vma,
+		struct vm_area_struct *prev)
+{
+	prev->vm_next = vma->vm_next;
+	rb_erase(&vma->vm_rb, &mm->mm_rb);
+	if (mm->mmap_cache == vma)
+		mm->mmap_cache = prev;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
  * The following helper function should be used when such adjustments
- * are necessary.  The "next" vma (if any) is to be removed or inserted
+ * are necessary.  The "insert" vma (if any) is to be inserted
  * before we drop the necessary locks.
  */
 void vma_adjust(struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *next)
+	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct vm_area_struct *next = vma->vm_next;
 	struct address_space *mapping = NULL;
 	struct prio_tree_root *root = NULL;
 	struct file *file = vma->vm_file;
+	long adjust_next = 0;
+	int remove_next = 0;
+
+	if (next && !insert) {
+		if (end >= next->vm_end) {
+again:			remove_next = 1 + (end > next->vm_end);
+			end = next->vm_end;
+		} else if (end < vma->vm_end || end > next->vm_start) {
+			/*
+			 * vma shrinks, and !insert tells it's not
+			 * split_vma inserting another: so it must
+			 * be mprotect shifting the boundary down.
+			 *   Or:
+			 * vma expands, overlapping part of the next:
+			 * must be mprotect shifting the boundary up.
+			 */
+			BUG_ON(vma->vm_end != next->vm_start);
+			adjust_next = end - next->vm_start;
+		}
+	}
 
 	if (file) {
 		mapping = file->f_mapping;
@@ -364,38 +395,67 @@ void vma_adjust(struct vm_area_struct *v
 	if (root) {
 		flush_dcache_mmap_lock(mapping);
 		vma_prio_tree_remove(vma, root);
+		if (adjust_next)
+			vma_prio_tree_remove(next, root);
 	}
+
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
+	if (adjust_next) {
+		next->vm_start += adjust_next;
+		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
+	}
+
 	if (root) {
+		if (adjust_next) {
+			vma_prio_tree_init(next);
+			vma_prio_tree_insert(next, root);
+		}
 		vma_prio_tree_init(vma);
 		vma_prio_tree_insert(vma, root);
 		flush_dcache_mmap_unlock(mapping);
 	}
 
-	if (next) {
-		if (next == vma->vm_next) {
-			/*
-			 * vma_merge has merged next into vma, and needs
-			 * us to remove next before dropping the locks.
-			 */
-			__vma_unlink(mm, next, vma);
-			if (file)
-				__remove_shared_vm_struct(next, file, mapping);
-		} else {
-			/*
-			 * split_vma has split next from vma, and needs
-			 * us to insert next before dropping the locks
-			 * (next may either follow vma or precede it).
-			 */
-			__insert_vm_struct(mm, next);
-		}
+	if (remove_next) {
+		/*
+		 * vma_merge has merged next into vma, and needs
+		 * us to remove next before dropping the locks.
+		 */
+		__vma_unlink(mm, next, vma);
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+	} else if (insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		__insert_vm_struct(mm, insert);
 	}
 
 	spin_unlock(&mm->page_table_lock);
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
+
+	if (remove_next) {
+		if (file)
+			fput(file);
+		mm->map_count--;
+		mpol_free(vma_policy(next));
+		kmem_cache_free(vm_area_cachep, next);
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we must remove another next too. It would clutter
+		 * up the code too much to do both in one go.
+		 */
+		if (remove_next == 2) {
+			next = vma->vm_next;
+			goto again;
+		}
+	}
+
+	validate_mm(mm);
 }
 
 /*
@@ -459,18 +519,42 @@ can_vma_merge_after(struct vm_area_struc
 }
 
 /*
- * Given a new mapping request (addr,end,vm_flags,file,pgoff), figure out
- * whether that can be merged with its predecessor or its successor.  Or
- * both (it neatly fills a hole).
+ * Given a mapping request (addr,end,vm_flags,file,pgoff), figure out
+ * whether that can be merged with its predecessor or its successor.
+ * Or both (it neatly fills a hole).
+ *
+ * In most cases - when called for mmap, brk or mremap - [addr,end) is
+ * certain not to be mapped by the time vma_merge is called; but when
+ * called for mprotect, it is certain to be already mapped (either at
+ * an offset within prev, or at the start of next), and the flags of
+ * this area are about to be changed to vm_flags - and the no-change
+ * case has already been eliminated.
+ *
+ * The following mprotect cases have to be considered, where AAAA is
+ * the area passed down from mprotect_fixup, never extending beyond one
+ * vma, PPPPPP is the prev vma specified, and NNNNNN the next vma after:
+ *
+ *     AAAA             AAAA                AAAA          AAAA
+ *    PPPPPPNNNNNN    PPPPPPNNNNNN    PPPPPPNNNNNN    PPPPNNNNXXXX
+ *    cannot merge    might become    might become    might become
+ *                    PPNNNNNNNNNN    PPPPPPPPPPNN    PPPPPPPPPPPP 6 or
+ *    mmap, brk or    case 4 below    case 5 below    PPPPPPPPXXXX 7 or
+ *    mremap move:                                    PPPPNNNNNNNN 8
+ *        AAAA
+ *    PPPP    NNNN    PPPPPPPPPPPP    PPPPPPPPNNNN    PPPPNNNNNNNN
+ *    might become    case 1 below    case 2 below    case 3 below
+ *
+ * Odd one out? Case 8, because it extends NNNN but needs flags of XXXX:
+ * mprotect_fixup updates vm_flags & vm_page_prot on successful return.
  */
-static struct vm_area_struct *vma_merge(struct mm_struct *mm,
+struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			struct vm_area_struct *prev, unsigned long addr,
 			unsigned long end, unsigned long vm_flags,
 		     	struct file *file, pgoff_t pgoff,
 		        struct mempolicy *policy)
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
-	struct vm_area_struct *next;
+	struct vm_area_struct *area, *next;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
@@ -479,16 +563,18 @@ static struct vm_area_struct *vma_merge(
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	if (!prev) {
+	if (prev)
+		next = prev->vm_next;
+	else
 		next = mm->mmap;
-		goto merge_next;
-	}
-	next = prev->vm_next;
+	area = next;
+	if (next && next->vm_end == end)		/* cases 6, 7, 8 */
+		next = next->vm_next;
 
 	/*
 	 * Can it merge with the predecessor?
 	 */
-	if (prev->vm_end == addr &&
+	if (prev && prev->vm_end == addr &&
   			mpol_equal(vma_policy(prev), policy) &&
 			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
 		/*
@@ -498,33 +584,29 @@ static struct vm_area_struct *vma_merge(
 				mpol_equal(policy, vma_policy(next)) &&
 				can_vma_merge_before(next, vm_flags, file,
 							pgoff+pglen)) {
+							/* cases 1, 6 */
 			vma_adjust(prev, prev->vm_start,
-				next->vm_end, prev->vm_pgoff, next);
-			if (file)
-				fput(file);
-			mm->map_count--;
-			mpol_free(vma_policy(next));
-			kmem_cache_free(vm_area_cachep, next);
-		} else
+				next->vm_end, prev->vm_pgoff, NULL);
+		} else					/* cases 2, 5, 7 */
 			vma_adjust(prev, prev->vm_start,
 				end, prev->vm_pgoff, NULL);
 		return prev;
 	}
 
-merge_next:
-
 	/*
 	 * Can this new request be merged in front of next?
 	 */
-	if (next) {
-		if (end == next->vm_start &&
- 				mpol_equal(policy, vma_policy(next)) &&
-				can_vma_merge_before(next, vm_flags, file,
+	if (next && end == next->vm_start &&
+ 			mpol_equal(policy, vma_policy(next)) &&
+			can_vma_merge_before(next, vm_flags, file,
 							pgoff+pglen)) {
-			vma_adjust(next, addr, next->vm_end,
+		if (prev && addr < prev->vm_end)	/* case 4 */
+			vma_adjust(prev, prev->vm_start,
+				addr, prev->vm_pgoff, NULL);
+		else					/* cases 3, 8 */
+			vma_adjust(area, addr, next->vm_end,
 				next->vm_pgoff - pglen, NULL);
-			return next;
-		}
+		return area;
 	}
 
 	return NULL;
--- rmap35/mm/mprotect.c	2004-05-18 20:50:32.614664312 +0100
+++ rmap36/mm/mprotect.c	2004-05-18 20:50:58.879671424 +0100
@@ -106,53 +106,6 @@ change_protection(struct vm_area_struct 
 	spin_unlock(&current->mm->page_table_lock);
 	return;
 }
-/*
- * Try to merge a vma with the previous flag, return 1 if successful or 0 if it
- * was impossible.
- */
-static int
-mprotect_attempt_merge(struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long end, int newflags)
-{
-	struct mm_struct * mm;
-
-	if (!prev || !vma)
-		return 0;
-	mm = vma->vm_mm;
-	if (prev->vm_end != vma->vm_start)
-		return 0;
-	if (!can_vma_merge(prev, newflags))
-		return 0;
-	if (vma->vm_file || (vma->vm_flags & VM_SHARED))
-		return 0;
-	if (!vma_mpol_equal(vma, prev))
-		return 0;
-
-	/*
-	 * If the whole area changes to the protection of the previous one
-	 * we can just get rid of it.
-	 */
-	if (end == vma->vm_end) {
-		spin_lock(&mm->page_table_lock);
-		prev->vm_end = end;
-		__vma_unlink(mm, vma, prev);
-		spin_unlock(&mm->page_table_lock);
-
-		mpol_free(vma_policy(vma));
-		kmem_cache_free(vm_area_cachep, vma);
-		mm->map_count--;
-		return 1;
-	} 
-
-	/*
-	 * Otherwise extend it.
-	 */
-	spin_lock(&mm->page_table_lock);
-	prev->vm_end = end;
-	vma->vm_start = end;
-	spin_unlock(&mm->page_table_lock);
-	return 1;
-}
 
 static int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
@@ -161,6 +114,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	struct mm_struct * mm = vma->vm_mm;
 	unsigned long charged = 0;
 	pgprot_t newprot;
+	pgoff_t pgoff;
 	int error;
 
 	if (newflags == vma->vm_flags) {
@@ -187,15 +141,18 @@ mprotect_fixup(struct vm_area_struct *vm
 
 	newprot = protection_map[newflags & 0xf];
 
-	if (start == vma->vm_start) {
-		/*
-		 * Try to merge with the previous vma.
-		 */
-		if (mprotect_attempt_merge(vma, *pprev, end, newflags)) {
-			vma = *pprev;
-			goto success;
-		}
-	} else {
+	/*
+	 * First try to merge with previous and/or next vma.
+	 */
+	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	*pprev = vma_merge(mm, *pprev, start, end, newflags,
+				vma->vm_file, pgoff, vma_policy(vma));
+	if (*pprev) {
+		vma = *pprev;
+		goto success;
+	}
+
+	if (start != vma->vm_start) {
 		error = split_vma(mm, vma, start, 1);
 		if (error)
 			goto fail;
@@ -212,13 +169,13 @@ mprotect_fixup(struct vm_area_struct *vm
 			goto fail;
 	}
 
+success:
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
 	 */
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
-success:
 	change_protection(vma, start, end, newprot);
 	return 0;
 
@@ -231,7 +188,7 @@ asmlinkage long
 sys_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
 	unsigned long vm_flags, nstart, end, tmp;
-	struct vm_area_struct * vma, * next, * prev;
+	struct vm_area_struct *vma, *prev;
 	int error = -EINVAL;
 	const int grows = prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	prot &= ~(PROT_GROWSDOWN|PROT_GROWSUP);
@@ -275,10 +232,11 @@ sys_mprotect(unsigned long start, size_t
 				goto out;
 		}
 	}
+	if (start > vma->vm_start)
+		prev = vma;
 
 	for (nstart = start ; ; ) {
 		unsigned int newflags;
-		int last = 0;
 
 		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
 
@@ -298,41 +256,25 @@ sys_mprotect(unsigned long start, size_t
 		if (error)
 			goto out;
 
-		if (vma->vm_end > end) {
-			error = mprotect_fixup(vma, &prev, nstart, end, newflags);
-			goto out;
-		}
-		if (vma->vm_end == end)
-			last = 1;
-
 		tmp = vma->vm_end;
-		next = vma->vm_next;
+		if (tmp > end)
+			tmp = end;
 		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
 			goto out;
-		if (last)
-			break;
 		nstart = tmp;
-		vma = next;
+
+		if (nstart < prev->vm_end)
+			nstart = prev->vm_end;
+		if (nstart >= end)
+			goto out;
+
+		vma = prev->vm_next;
 		if (!vma || vma->vm_start != nstart) {
 			error = -ENOMEM;
 			goto out;
 		}
 	}
-
-	if (next && prev->vm_end == next->vm_start &&
-			can_vma_merge(next, prev->vm_flags) &&
-	    	vma_mpol_equal(prev, next) &&
-			!prev->vm_file && !(prev->vm_flags & VM_SHARED)) {
-		spin_lock(&prev->vm_mm->page_table_lock);
-		prev->vm_end = next->vm_end;
-		__vma_unlink(prev->vm_mm, next, prev);
-		spin_unlock(&prev->vm_mm->page_table_lock);
-
-		mpol_free(vma_policy(next));
-		kmem_cache_free(vm_area_cachep, next);
-		prev->vm_mm->map_count--;
-	}
 out:
 	up_write(&current->mm->mmap_sem);
 	return error;

