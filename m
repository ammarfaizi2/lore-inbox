Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUC3Wv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbUC3Wuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:50:39 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50160 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261505AbUC3WqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:46:09 -0500
Date: Tue, 30 Mar 2004 23:45:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] mremap move_vma
In-Reply-To: <Pine.LNX.4.44.0403302340220.24019-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403302344410.24019-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Partial rewrite of mremap's move_vma.  Rajesh Venkatasubramanian has
pointed out that vmtruncate could miss ptes, leaving orphaned pages,
because move_vma only made the new vma visible after filling it.  We
see no good reason for that, and time to make move_vma more robust.

Removed all its vma merging decisions, leave them to mmap.c's vma_merge,
with copy_vma added.  Removed duplicated is_mergeable_vma test from
vma_merge, and duplicated validate_mm from insert_vm_struct.

move_vma move from old to new then unmap old; but on error move back
from new to old and unmap new.  Don't unwind within move_page_tables,
let move_vma call it explicitly to unwind, with the right source vma.
Get the VM_ACCOUNTing right even when the final do_munmap fails.

--- mremap2/include/linux/mm.h	2004-03-30 13:04:18.468694360 +0100
+++ mremap3/include/linux/mm.h	2004-03-30 21:24:48.666410384 +0100
@@ -538,6 +538,8 @@ extern void si_meminfo_node(struct sysin
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 	struct rb_node **, struct rb_node *);
+extern struct vm_area_struct *copy_vma(struct vm_area_struct *,
+	unsigned long addr, unsigned long len, unsigned long pgoff);
 extern void exit_mmap(struct mm_struct *);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
--- mremap2/mm/mmap.c	2004-03-30 13:04:19.396553304 +0100
+++ mremap3/mm/mmap.c	2004-03-30 21:24:48.668410080 +0100
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
@@ -1484,5 +1484,36 @@ void insert_vm_struct(struct mm_struct *
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
 }
--- mremap2/mm/mremap.c	2004-03-30 21:24:37.254145312 +0100
+++ mremap3/mm/mremap.c	2004-03-30 21:24:48.671409624 +0100
@@ -148,7 +148,7 @@ out:
 static int move_page_tables(struct vm_area_struct *vma,
 	unsigned long new_addr, unsigned long old_addr, unsigned long len)
 {
-	unsigned long offset = len;
+	unsigned long offset;
 
 	flush_cache_range(vma, old_addr, old_addr + len);
 
@@ -157,137 +157,75 @@ static int move_page_tables(struct vm_ar
 	 * easy way out on the assumption that most remappings will be
 	 * only a few pages.. This also makes error recovery easier.
 	 */
-	while (offset) {
-		offset -= PAGE_SIZE;
-		if (move_one_page(vma, old_addr + offset, new_addr + offset))
-			goto oops_we_failed;
+	for (offset = 0; offset < len; offset += PAGE_SIZE) {
+		if (move_one_page(vma, old_addr+offset, new_addr+offset) < 0)
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
+	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
+	new_vma = copy_vma(vma, new_addr, new_len, new_pgoff);
+	if (!new_vma)
+		return -ENOMEM;
+
+	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
+	if (moved_len < old_len) {
+		/*
+		 * On error, move entries back from new area to old,
+		 * which will succeed since page tables still there,
+		 * and then proceed to unmap new area instead of old.
+		 */
+		move_page_tables(new_vma, old_addr, new_addr, moved_len);
+		vma = new_vma;
+		old_len = new_len;
+		old_addr = new_addr;
+		new_addr = -ENOMEM;
 	}
 
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
+	/* Conceal VM_ACCOUNT so old reservation is not undone */
+	if (vm_flags & VM_ACCOUNT) {
+		vma->vm_flags &= ~VM_ACCOUNT;
+		excess = vma->vm_end - vma->vm_start - old_len;
+		if (old_addr > vma->vm_start &&
+		    old_addr + old_len < vma->vm_end)
+			split = 1;
+	}
 
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
-
-		do_munmap(current->mm, addr, old_len);
-
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

