Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbUDLEcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 00:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUDLEcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 00:32:43 -0400
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:50311 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262733AbUDLEc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 00:32:26 -0400
Date: Mon, 12 Apr 2004 00:32:15 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@azure.engin.umich.edu
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <7220000.1081704484@[10.10.2.4]>
Message-ID: <Pine.GSO.4.58.0404120028200.11877@azure.engin.umich.edu>
References: <Pine.LNX.4.44.0404111650410.2008-100000@localhost.localdomain>
 <7220000.1081704484@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is an attempt at reducing the contention on i_shared_sem
by introducing a new semaphore i_mmap_sem. The i_shared_sem covers
i_mmap_shared tree and i_mmap_nonlinear list now, whereas i_mmap_sem
covers i_mmap tree. This may help to reduce the contention on
i_shared_sem if a file is mapped both private and shared. Kernel
compile time with and without this patch did not change much, though.

This patch is on top of 2.6.5-mjb1+anobjrmap9_prio. Compiled and
tested.

Martin! Are you interested in testing SDET with this patch ?



 fs/hugetlbfs/inode.c |    6 +++++-
 fs/inode.c           |    1 +
 include/linux/fs.h   |    3 ++-
 include/linux/mm.h   |   24 +++++++++++++++++++++++-
 kernel/fork.c        |    4 ++--
 mm/filemap.c         |    6 +++---
 mm/memory.c          |    6 +++++-
 mm/mmap.c            |   51 +++++++++++++++------------------------------------
 mm/mremap.c          |   29 ++++++++++++-----------------
 mm/rmap.c            |   32 ++++++++++++++++++++++++--------
 10 files changed, 92 insertions(+), 70 deletions(-)

diff -puN include/linux/fs.h~010_sem_contention include/linux/fs.h
--- mmlinux-2.6/include/linux/fs.h~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/include/linux/fs.h	2004-04-11 22:07:40.000000000 -0400
@@ -333,7 +333,8 @@ struct address_space {
 	struct prio_tree_root	i_mmap;		/* tree of private mappings */
 	struct prio_tree_root	i_mmap_shared;	/* tree of shared mappings */
 	struct list_head	i_mmap_nonlinear;/*list of nonlinear mappings */
-	struct semaphore	i_shared_sem;	/* protect both above lists */
+	struct semaphore	i_mmap_sem;	/* protect i_mmap prio_tree */
+	struct semaphore	i_shared_sem;	/* protect shared and nonlinear */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
diff -puN include/linux/mm.h~010_sem_contention include/linux/mm.h
--- mmlinux-2.6/include/linux/mm.h~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/include/linux/mm.h	2004-04-11 22:08:13.000000000 -0400
@@ -232,7 +232,7 @@ static inline void __vma_prio_tree_add(s
  * We cannot modify vm_start, vm_end, vm_pgoff fields of a vma that has been
  * already present in an i_mmap{_shared} tree without modifying the tree. The
  * following helper function should be used when such modifications are
- * necessary. We should hold the mapping's i_shared_sem.
+ * necessary. We should hold the mapping's i_shared_sem or i_mmap_sem.
  *
  * This function can be (micro)optimized for some special cases (maybe later).
  */
@@ -296,6 +296,28 @@ static inline struct vm_area_struct *__v
 		return NULL;
 }

+/* Caller should hold mmap_sem */
+static inline void vma_mapping_lock(struct vm_area_struct *vma)
+{
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			down(&vma->vm_file->f_mapping->i_shared_sem);
+		else
+			down(&vma->vm_file->f_mapping->i_mmap_sem);
+	}
+}
+
+/* Caller should hold mmap_sem */
+static inline void vma_mapping_unlock(struct vm_area_struct *vma)
+{
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			up(&vma->vm_file->f_mapping->i_shared_sem);
+		else
+			up(&vma->vm_file->f_mapping->i_mmap_sem);
+	}
+}
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff -puN kernel/fork.c~010_sem_contention kernel/fork.c
--- mmlinux-2.6/kernel/fork.c~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/kernel/fork.c	2004-04-11 22:07:40.000000000 -0400
@@ -332,9 +332,9 @@ static inline int dup_mmap(struct mm_str
 				atomic_dec(&inode->i_writecount);

 			/* insert tmp into the share list, just after mpnt */
-			down(&file->f_mapping->i_shared_sem);
+			vma_mapping_lock(tmp);
 			__vma_prio_tree_add(tmp, mpnt);
-			up(&file->f_mapping->i_shared_sem);
+			vma_mapping_unlock(tmp);
 		}

 		/*
diff -puN mm/mmap.c~010_sem_contention mm/mmap.c
--- mmlinux-2.6/mm/mmap.c~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/mm/mmap.c	2004-04-11 22:07:40.000000000 -0400
@@ -67,7 +67,7 @@ int mmap_use_hugepages = 0;
 int mmap_hugepages_map_sz = 256;

 /*
- * Requires inode->i_mapping->i_shared_sem
+ * Requires inode->i_mapping->i_shared_sem or i_mmap_sem
  */
 static inline void
 __remove_shared_vm_struct(struct vm_area_struct *vma, struct inode *inode,
@@ -96,10 +96,10 @@ static void remove_shared_vm_struct(stru

 	if (file) {
 		struct address_space *mapping = file->f_mapping;
-		down(&mapping->i_shared_sem);
+		vma_mapping_lock(vma);
 		__remove_shared_vm_struct(vma, file->f_dentry->d_inode,
 				mapping);
-		up(&mapping->i_shared_sem);
+		vma_mapping_unlock(vma);
 	}
 }

@@ -298,18 +298,11 @@ static void vma_link(struct mm_struct *m
 			struct vm_area_struct *prev, struct rb_node **rb_link,
 			struct rb_node *rb_parent)
 {
-	struct address_space *mapping = NULL;
-
-	if (vma->vm_file)
-		mapping = vma->vm_file->f_mapping;
-
-	if (mapping)
-		down(&mapping->i_shared_sem);
+	vma_mapping_lock(vma);
 	spin_lock(&mm->page_table_lock);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	spin_unlock(&mm->page_table_lock);
-	if (mapping)
-		up(&mapping->i_shared_sem);
+	vma_mapping_unlock(vma);

 	mark_mm_hugetlb(mm, vma);
 	mm->map_count++;
@@ -318,8 +311,8 @@ static void vma_link(struct mm_struct *m

 /*
  * Insert vm structure into process list sorted by address and into the inode's
- * i_mmap ring. The caller should hold mm->page_table_lock and
- * ->f_mappping->i_shared_sem if vm_file is non-NULL.
+ * i_mmap ring. The caller should hold mm->page_table_lock and i_shared_sem or
+ * i_mmap_sem if vm_file is non-NULL.
  */
 static void
 __insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
@@ -410,7 +403,6 @@ static struct vm_area_struct *vma_merge(
 	spinlock_t *lock = &mm->page_table_lock;
 	struct inode *inode = file ? file->f_dentry->d_inode : NULL;
 	struct address_space *mapping = file ? file->f_mapping : NULL;
-	struct semaphore *i_shared_sem;
 	struct prio_tree_root *root = NULL;

 	/*
@@ -420,8 +412,6 @@ static struct vm_area_struct *vma_merge(
 	if (vm_flags & VM_SPECIAL)
 		return NULL;

-	i_shared_sem = file ? &file->f_mapping->i_shared_sem : NULL;
-
 	if (mapping) {
 		if (vm_flags & VM_SHARED) {
 			if (likely(!(vm_flags & VM_NONLINEAR)))
@@ -442,13 +432,8 @@ static struct vm_area_struct *vma_merge(
 	if (prev->vm_end == addr &&
 			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
 		struct vm_area_struct *next;
-		int need_up = 0;

-		if (unlikely(file && prev->vm_next &&
-				prev->vm_next->vm_file == file)) {
-			down(i_shared_sem);
-			need_up = 1;
-		}
+		vma_mapping_lock(prev);
 		spin_lock(lock);

 		/*
@@ -463,8 +448,7 @@ static struct vm_area_struct *vma_merge(
 					next->vm_end, prev->vm_pgoff);
 			__remove_shared_vm_struct(next, inode, mapping);
 			spin_unlock(lock);
-			if (need_up)
-				up(i_shared_sem);
+			vma_mapping_unlock(prev);
 			if (file)
 				fput(file);

@@ -475,8 +459,7 @@ static struct vm_area_struct *vma_merge(

 		__vma_modify(root, prev, prev->vm_start, end, prev->vm_pgoff);
 		spin_unlock(lock);
-		if (need_up)
-			up(i_shared_sem);
+		vma_mapping_unlock(prev);
 		return prev;
 	}

@@ -490,14 +473,12 @@ static struct vm_area_struct *vma_merge(
 				pgoff, (end - addr) >> PAGE_SHIFT))
 			return NULL;
 		if (end == prev->vm_start) {
-			if (file)
-				down(i_shared_sem);
+			vma_mapping_lock(prev);
 			spin_lock(lock);
 			__vma_modify(root, prev, addr, prev->vm_end,
 				prev->vm_pgoff - ((end - addr) >> PAGE_SHIFT));
 			spin_unlock(lock);
-			if (file)
-				up(i_shared_sem);
+			vma_mapping_unlock(prev);
 			return prev;
 		}
 	}
@@ -1361,8 +1342,7 @@ int split_vma(struct mm_struct * mm, str
 			 root = &mapping->i_mmap;
 	}

-	if (mapping)
-		down(&mapping->i_shared_sem);
+	vma_mapping_lock(vma);
 	spin_lock(&mm->page_table_lock);

 	if (new_below)
@@ -1374,8 +1354,7 @@ int split_vma(struct mm_struct * mm, str
 	__insert_vm_struct(mm, new);

 	spin_unlock(&mm->page_table_lock);
-	if (mapping)
-		up(&mapping->i_shared_sem);
+	vma_mapping_unlock(vma);

 	return 0;
 }
@@ -1609,7 +1588,7 @@ void exit_mmap(struct mm_struct *mm)

 /* Insert vm structure into process list sorted by address
  * and into the inode's i_mmap ring.  If vm_file is non-NULL
- * then i_shared_sem is taken here.
+ * then i_shared_sem or i_mmap_sem is taken here.
  */
 void insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
 {
diff -puN mm/memory.c~010_sem_contention mm/memory.c
--- mmlinux-2.6/mm/memory.c~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/mm/memory.c	2004-04-11 22:07:40.000000000 -0400
@@ -1133,11 +1133,15 @@ void invalidate_mmap_range(struct addres
 		if (holeend & ~(long long)ULONG_MAX)
 			hlen = ULONG_MAX - hba + 1;
 	}
-	down(&mapping->i_shared_sem);
+	down(&mapping->i_mmap_sem);
 	/* Protect against page fault */
 	atomic_inc(&mapping->truncate_count);
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen);
+	up(&mapping->i_mmap_sem);
+	down(&mapping->i_shared_sem);
+	/* Protect against page fault -- not sure this is required */
+	atomic_inc(&mapping->truncate_count);
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		invalidate_mmap_range_list(&mapping->i_mmap_shared, hba, hlen);
 	up(&mapping->i_shared_sem);
diff -puN mm/filemap.c~010_sem_contention mm/filemap.c
--- mmlinux-2.6/mm/filemap.c~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/mm/filemap.c	2004-04-11 22:07:40.000000000 -0400
@@ -55,17 +55,17 @@
 /*
  * Lock ordering:
  *
- *  ->i_shared_sem		(vmtruncate)
+ *  ->i_shared{_mmap}_sem	(vmtruncate)
  *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
  *      ->swap_list_lock
  *        ->swap_device_lock	(exclusive_swap_page, others)
  *          ->mapping->page_lock
  *
  *  ->i_sem
- *    ->i_shared_sem		(truncate->invalidate_mmap_range)
+ *    ->i_shared{_mmap}_sem	(truncate->invalidate_mmap_range)
  *
  *  ->mmap_sem
- *    ->i_shared_sem		(various places)
+ *    ->i_shared{_mmap}_sem	(various places)
  *
  *  ->mmap_sem
  *    ->lock_page		(access_process_vm)
diff -puN mm/mremap.c~010_sem_contention mm/mremap.c
--- mmlinux-2.6/mm/mremap.c~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/mm/mremap.c	2004-04-11 22:07:40.000000000 -0400
@@ -267,7 +267,6 @@ static unsigned long move_vma(struct vm_
 		unsigned long new_len, unsigned long new_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct address_space *mapping = NULL;
 	struct vm_area_struct *new_vma;
 	unsigned long vm_flags = vma->vm_flags;
 	unsigned long new_pgoff;
@@ -287,16 +286,14 @@ static unsigned long move_vma(struct vm_
 	if (!new_vma)
 		return -ENOMEM;

-	if (vma->vm_file) {
-		/*
-		 * Subtle point from Rajesh Venkatasubramanian: before
-		 * moving file-based ptes, we must lock vmtruncate out,
-		 * since it might clean the dst vma before the src vma,
-		 * and we propagate stale pages into the dst afterward.
-		 */
-		mapping = vma->vm_file->f_mapping;
-		down(&mapping->i_shared_sem);
-	}
+	/*
+	 * Subtle point from Rajesh Venkatasubramanian: before
+	 * moving file-based ptes, we must lock vmtruncate out,
+	 * since it might clean the dst vma before the src vma,
+	 * and we propagate stale pages into the dst afterward.
+	 */
+	vma_mapping_lock(vma);
+
 	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
 	if (moved_len < old_len) {
 		/*
@@ -310,8 +307,8 @@ static unsigned long move_vma(struct vm_
 		old_addr = new_addr;
 		new_addr = -ENOMEM;
 	}
-	if (mapping)
-		up(&mapping->i_shared_sem);
+
+	vma_mapping_unlock(vma);

 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT) {
@@ -476,16 +473,14 @@ unsigned long do_mremap(unsigned long ad
 				}
 				else
 					root = &mapping->i_mmap;
-				down(&mapping->i_shared_sem);
 			}

+			vma_mapping_lock(vma);
 			spin_lock(&vma->vm_mm->page_table_lock);
 			__vma_modify(root, vma, vma->vm_start,
 					addr + new_len, vma->vm_pgoff);
 			spin_unlock(&vma->vm_mm->page_table_lock);
-
-			if(mapping)
-				up(&mapping->i_shared_sem);
+			vma_mapping_unlock(vma);

 			current->mm->total_vm += pages;
 			if (vma->vm_flags & VM_LOCKED) {
diff -puN mm/rmap.c~010_sem_contention mm/rmap.c
--- mmlinux-2.6/mm/rmap.c~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/mm/rmap.c	2004-04-11 22:07:40.000000000 -0400
@@ -267,8 +267,8 @@ out:
  *
  * This function is only called from page_referenced for object-based pages.
  *
- * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
- * assume a reference count of 0, so try_to_unmap will then have a go.
+ * The semaphores ->i_mmap_sem and ->i_shared_sem are tried.  If they can't be
+ * gotten, assume a reference count of 0, so try_to_unmap will then have a go.
  */
 static inline int page_referenced_obj(struct page *page, int *mapcount)
 {
@@ -276,12 +276,14 @@ static inline int page_referenced_obj(st
 	unsigned long pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma;
 	struct prio_tree_iter iter;
+	struct semaphore *semaphore;
 	unsigned long address;
 	int referenced = 0;

-	if (down_trylock(&mapping->i_shared_sem))
+	if (down_trylock(&mapping->i_mmap_sem))
 		return 0;

+	semaphore = &mapping->i_mmap_sem;
 	vma = __vma_prio_tree_first(&mapping->i_mmap,
 					&iter, pgoff, pgoff);
 	while (vma) {
@@ -301,6 +303,12 @@ static inline int page_referenced_obj(st
 						&iter, pgoff, pgoff);
 	}

+	up(&mapping->i_mmap_sem);
+
+	if (down_trylock(&mapping->i_shared_sem))
+		return 0;
+
+	semaphore = &mapping->i_shared_sem;
 	vma = __vma_prio_tree_first(&mapping->i_mmap_shared,
 					&iter, pgoff, pgoff);
 	while (vma) {
@@ -322,7 +330,7 @@ static inline int page_referenced_obj(st
 	if (list_empty(&mapping->i_mmap_nonlinear))
 		WARN_ON(*mapcount > 0);
 out:
-	up(&mapping->i_shared_sem);
+	up(semaphore);
 	return referenced;
 }

@@ -696,8 +704,8 @@ out:
  *
  * This function is only called from try_to_unmap for object-based pages.
  *
- * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
- * return a temporary error.
+ * The semaphores ->i_mmap_sem and ->i_shared_sem are tried.  If they can't be
+ * gotten, return a temporary error.
  */
 static inline int try_to_unmap_obj(struct page *page, int *mapcount)
 {
@@ -705,15 +713,17 @@ static inline int try_to_unmap_obj(struc
 	unsigned long pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma;
 	struct prio_tree_iter iter;
+	struct semaphore *semaphore;
 	unsigned long address;
 	int ret = SWAP_AGAIN;
 	unsigned long cursor;
 	unsigned long max_nl_cursor = 0;
 	unsigned long max_nl_size = 0;

-	if (down_trylock(&mapping->i_shared_sem))
+	if (down_trylock(&mapping->i_mmap_sem))
 		return ret;

+	semaphore = &mapping->i_mmap_sem;
 	vma = __vma_prio_tree_first(&mapping->i_mmap,
 					&iter, pgoff, pgoff);
 	while (vma) {
@@ -728,6 +738,12 @@ static inline int try_to_unmap_obj(struc
 						&iter, pgoff, pgoff);
 	}

+	up(&mapping->i_mmap_sem);
+
+	if (down_trylock(&mapping->i_shared_sem))
+		return ret;
+
+	semaphore = &mapping->i_shared_sem;
 	vma = __vma_prio_tree_first(&mapping->i_mmap_shared,
 					&iter, pgoff, pgoff);
 	while (vma) {
@@ -813,7 +829,7 @@ static inline int try_to_unmap_obj(struc
 relock:
 	rmap_lock(page);
 out:
-	up(&mapping->i_shared_sem);
+	up(semaphore);
 	return ret;
 }

diff -puN fs/inode.c~010_sem_contention fs/inode.c
--- mmlinux-2.6/fs/inode.c~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/fs/inode.c	2004-04-11 22:07:40.000000000 -0400
@@ -185,6 +185,7 @@ void inode_init_once(struct inode *inode
 	sema_init(&inode->i_sem, 1);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	spin_lock_init(&inode->i_data.page_lock);
+	init_MUTEX(&inode->i_data.i_mmap_sem);
 	init_MUTEX(&inode->i_data.i_shared_sem);
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
diff -puN fs/hugetlbfs/inode.c~010_sem_contention fs/hugetlbfs/inode.c
--- mmlinux-2.6/fs/hugetlbfs/inode.c~010_sem_contention	2004-04-11 22:07:40.000000000 -0400
+++ mmlinux-2.6-jaya/fs/hugetlbfs/inode.c	2004-04-11 22:07:40.000000000 -0400
@@ -325,11 +325,15 @@ static int hugetlb_vmtruncate(struct ino
 	pgoff = offset >> HPAGE_SHIFT;

 	inode->i_size = offset;
-	down(&mapping->i_shared_sem);
+	down(&mapping->i_mmap_sem);
 	/* Protect against page fault */
 	atomic_inc(&mapping->truncate_count);
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
+	up(&mapping->i_mmap_sem);
+	down(&mapping->i_shared_sem);
+	/* Protect against page fault -- not sure this is required */
+	atomic_inc(&mapping->truncate_count);
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		hugetlb_vmtruncate_list(&mapping->i_mmap_shared, pgoff);
 	up(&mapping->i_shared_sem);

_

