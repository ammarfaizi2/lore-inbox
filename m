Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUDNUWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUDNUWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:22:38 -0400
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:36525 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261648AbUDNUTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:19:00 -0400
Date: Wed, 14 Apr 2004 16:18:38 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@rust.engin.umich.edu
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <69200000.1081804458@flay>
Message-ID: <Pine.LNX.4.58.0404141616530.25848@rust.engin.umich.edu>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain>
 <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu> <69200000.1081804458@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is another attempt at reducing the contention on i_shared_sem.
The patch converts i_shared_sem from normal semaphore to read-write
semaphore. The locking rules used are:

  1) A prio_tree cannot be modified without holding write lock.
  2) However, vmas can be added and removed from a vm_set list
     by just holding the read lock and a bit lock (vm_set_lock)
     in the corresponding prio_tree node.
  3) All objrmap functions just hold read lock now. So when we
     walk a vm_set list we have to hold the corresponding
     vm_set_lock.
  4) Since truncate uses write lock (provides exclusion) we don't
     have to take vm_set_locks.

Martin! When you get time to test your SDET with this patch, please
let me know whether this patch helps you at all. The patch applies
on top of 2.6.5-mjb1+anobjrmap9_prio_tree.


 fs/hugetlbfs/inode.c      |    4 -
 fs/inode.c                |    2
 include/linux/fs.h        |    2
 include/linux/mm.h        |  127 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/prio_tree.h |    3 +
 kernel/fork.c             |   34 +++++++++++-
 mm/fremap.c               |    4 -
 mm/memory.c               |    4 -
 mm/mmap.c                 |  120 ++++++++++++++++++++++++++++++++-----------
 mm/mremap.c               |    8 +-
 mm/prio_tree.c            |  117 ++++++++++++++++++++++++++++--------------
 mm/rmap.c                 |   46 ++++++++++------
 12 files changed, 365 insertions(+), 106 deletions(-)

diff -puN fs/hugetlbfs/inode.c~110_sem_contention fs/hugetlbfs/inode.c
--- mmlinux-2.6/fs/hugetlbfs/inode.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/fs/hugetlbfs/inode.c	2004-04-14 15:49:01.000000000 -0400
@@ -325,14 +325,14 @@ static int hugetlb_vmtruncate(struct ino
 	pgoff = offset >> HPAGE_SHIFT;

 	inode->i_size = offset;
-	down(&mapping->i_shared_sem);
+	down_write(&mapping->i_shared_sem);
 	/* Protect against page fault */
 	atomic_inc(&mapping->truncate_count);
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		hugetlb_vmtruncate_list(&mapping->i_mmap_shared, pgoff);
-	up(&mapping->i_shared_sem);
+	up_write(&mapping->i_shared_sem);
 	truncate_hugepages(mapping, offset);
 	return 0;
 }
diff -puN fs/inode.c~110_sem_contention fs/inode.c
--- mmlinux-2.6/fs/inode.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/fs/inode.c	2004-04-14 15:49:01.000000000 -0400
@@ -185,7 +185,7 @@ void inode_init_once(struct inode *inode
 	sema_init(&inode->i_sem, 1);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	spin_lock_init(&inode->i_data.page_lock);
-	init_MUTEX(&inode->i_data.i_shared_sem);
+	init_rwsem(&inode->i_data.i_shared_sem);
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
diff -puN include/linux/fs.h~110_sem_contention include/linux/fs.h
--- mmlinux-2.6/include/linux/fs.h~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/include/linux/fs.h	2004-04-14 15:49:01.000000000 -0400
@@ -333,7 +333,7 @@ struct address_space {
 	struct prio_tree_root	i_mmap;		/* tree of private mappings */
 	struct prio_tree_root	i_mmap_shared;	/* tree of shared mappings */
 	struct list_head	i_mmap_nonlinear;/*list of nonlinear mappings */
-	struct semaphore	i_shared_sem;	/* protect both above lists */
+	struct rw_semaphore	i_shared_sem;	/* protect both above lists */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
diff -puN include/linux/mm.h~110_sem_contention include/linux/mm.h
--- mmlinux-2.6/include/linux/mm.h~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/include/linux/mm.h	2004-04-14 15:49:01.000000000 -0400
@@ -87,6 +87,10 @@ struct vm_area_struct {
 	/*
 	 * shared.vm_set : list of vmas that map exactly the same set of pages
 	 * vm_set_head   : head of the vm_set list
+	 *
+	 * Both shared.vm_set.list and vm_set_head are protected by VM_SET_LOCK
+	 * bit of the corresponding tree node's vm_flags when accessed under
+	 * down_read(i_shared_sem)
 	 */
 	struct vm_area_struct *vm_set_head;

@@ -133,6 +137,8 @@ struct vm_area_struct {
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */

+#define	VM_SET_LOCK	24		/* Lock bit for vm_set list, head */
+
 /* It makes sense to apply VM_ACCOUNT to this vma. */
 #define VM_MAYACCT(vma) (!!((vma)->vm_flags & VM_HUGETLB))

@@ -156,6 +162,13 @@ struct vm_area_struct {
  * The following macros are used for implementing prio_tree for i_mmap{_shared}
  */

+#define	vm_set_lock(vma)	bit_spin_lock(VM_SET_LOCK, \
+					(unsigned long *)&(vma->vm_flags))
+#define	vm_set_trylock(vma)	bit_spin_trylock(VM_SET_LOCK, \
+					(unsigned long *)&(vma->vm_flags))
+#define	vm_set_unlock(vma)	bit_spin_unlock(VM_SET_LOCK, \
+					(unsigned long *)&(vma->vm_flags))
+
 #define	RADIX_INDEX(vma)  ((vma)->vm_pgoff)
 #define	VMA_SIZE(vma)	  (((vma)->vm_end - (vma)->vm_start) >> PAGE_SHIFT)
 /* avoid overflow */
@@ -202,7 +215,8 @@ static inline int vma_shared_empty(struc

 /*
  * Helps to add a new vma that maps the same (identical) set of pages as the
- * old vma to an i_mmap tree.
+ * old vma to an i_mmap tree. No new tree node is added by this function.
+ * The new vma is added to an already existing tree node's vm_set list.
  */
 static inline void __vma_prio_tree_add(struct vm_area_struct *vma,
 	struct vm_area_struct *old)
@@ -229,6 +243,37 @@ static inline void __vma_prio_tree_add(s
 }

 /*
+ * Delete a vm_set list node from an i_mmap tree. Note that this function
+ * should not be called with a tree node, i.e., shared.both.parent != NULL.
+ */
+static inline void __vma_prio_tree_del(struct vm_area_struct *vma)
+{
+	/* Leave this BUG_ON till prio_tree patch stabilizes */
+	BUG_ON(vma->shared.both.parent);
+
+	if (vma->vm_set_head) {
+		struct vm_area_struct *tree_node, *new_head;
+		/* Leave this BUG_ON till prio_tree patch stabilizes */
+		BUG_ON(vma->vm_set_head->vm_set_head != vma);
+		tree_node = vma->vm_set_head;
+		if (!list_empty(&vma->shared.vm_set.list)) {
+			new_head = list_entry(
+				vma->shared.vm_set.list.next,
+				struct vm_area_struct,
+				shared.vm_set.list);
+			list_del_init(&vma->shared.vm_set.list);
+			tree_node->vm_set_head = new_head;
+			new_head->vm_set_head = tree_node;
+		}
+		else
+			tree_node->vm_set_head = NULL;
+	} else
+		list_del_init(&vma->shared.vm_set.list);
+
+	INIT_VMA_SHARED(vma);
+}
+
+/*
  * We cannot modify vm_start, vm_end, vm_pgoff fields of a vma that has been
  * already present in an i_mmap{_shared} tree without modifying the tree. The
  * following helper function should be used when such modifications are
@@ -250,6 +295,25 @@ static inline void __vma_modify(struct p
 }

 /*
+ * Find a vma with given radix_index and heap_index in the prio_tree. Return
+ * the vma pointer if found, NULL otherwise.
+ */
+static inline struct vm_area_struct *__vma_prio_tree_find(
+		struct prio_tree_root *root, unsigned long radix_index,
+		unsigned long heap_index)
+{
+	struct prio_tree_node *ptr;
+
+	ptr = prio_tree_find(root, radix_index, heap_index);
+
+	if (ptr)
+		return prio_tree_entry(ptr, struct vm_area_struct,
+				shared.prio_tree_node);
+	else
+		return NULL;
+}
+
+/*
  * Helper functions to enumerate vmas that map a given file page or a set of
  * contiguous file pages. The functions return vmas that at least map a single
  * page in the given range of contiguous file pages.
@@ -269,11 +333,19 @@ static inline struct vm_area_struct *__v
 		return NULL;
 }

-static inline struct vm_area_struct *__vma_prio_tree_next(
-	struct vm_area_struct *vma, struct prio_tree_root *root,
-	struct prio_tree_iter *iter, unsigned long begin, unsigned long end)
+static inline struct vm_area_struct *__vma_prio_tree_first_lock(
+	struct prio_tree_root *root, struct prio_tree_iter *iter,
+	unsigned long begin, unsigned long end)
+{
+	struct vm_area_struct *vma;
+	vma = __vma_prio_tree_first(root, iter, begin,  end);
+	if (vma)
+		vm_set_lock(vma);
+	return vma;
+}
+
+static inline struct vm_area_struct *__vm_set_next(struct vm_area_struct *vma)
 {
-	struct prio_tree_node *ptr;
 	struct vm_area_struct *next;

 	if (vma->shared.both.parent) {
@@ -286,6 +358,19 @@ static inline struct vm_area_struct *__v
 		if (!(next->vm_set_head))
 			return next;
 	}
+	return NULL;
+}
+
+static inline struct vm_area_struct *__vma_prio_tree_next(
+	struct vm_area_struct *vma, struct prio_tree_root *root,
+	struct prio_tree_iter *iter, unsigned long begin, unsigned long end)
+{
+	struct prio_tree_node *ptr;
+	struct vm_area_struct *next;
+
+	next = __vm_set_next(vma);
+	if (next)
+		return next;

 	ptr = prio_tree_next(root, iter, begin, end);

@@ -296,6 +381,38 @@ static inline struct vm_area_struct *__v
 		return NULL;
 }

+static inline void __vma_prio_tree_iter_unlock(struct prio_tree_iter *iter)
+{
+	struct vm_area_struct *vma;
+	vma = prio_tree_entry(iter->cur, struct vm_area_struct,
+				shared.prio_tree_node);
+	vm_set_unlock(vma);
+}
+
+static inline struct vm_area_struct *__vma_prio_tree_next_lock(
+	struct vm_area_struct *vma, struct prio_tree_root *root,
+	struct prio_tree_iter *iter, unsigned long begin, unsigned long end)
+{
+	struct prio_tree_node *ptr;
+	struct vm_area_struct *next;
+
+	next = __vm_set_next(vma);
+	if (next)
+		return next;
+
+	__vma_prio_tree_iter_unlock(iter);
+	ptr = prio_tree_next(root, iter, begin, end);
+
+	if (ptr) {
+		next = prio_tree_entry(ptr, struct vm_area_struct,
+				shared.prio_tree_node);
+		vm_set_lock(next);
+		return next;
+	} else
+		return NULL;
+}
+
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff -puN include/linux/prio_tree.h~110_sem_contention include/linux/prio_tree.h
--- mmlinux-2.6/include/linux/prio_tree.h~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/include/linux/prio_tree.h	2004-04-14 15:49:01.000000000 -0400
@@ -67,6 +67,9 @@ static inline int prio_tree_right_empty(
 extern struct prio_tree_node *prio_tree_insert(struct prio_tree_root *,
 	struct prio_tree_node *);

+extern struct prio_tree_node *prio_tree_find(struct prio_tree_root *,
+	unsigned long, unsigned long);
+
 extern void prio_tree_remove(struct prio_tree_root *, struct prio_tree_node *);

 extern struct prio_tree_node *prio_tree_first(struct prio_tree_root *,
diff -puN kernel/fork.c~110_sem_contention kernel/fork.c
--- mmlinux-2.6/kernel/fork.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/kernel/fork.c	2004-04-14 15:49:01.000000000 -0400
@@ -326,15 +326,43 @@ static inline int dup_mmap(struct mm_str
 		file = tmp->vm_file;
 		INIT_VMA_SHARED(tmp);
 		if (file) {
+			struct address_space *mapping = file->f_mapping;
 			struct inode *inode = file->f_dentry->d_inode;
 			get_file(file);
 			if (tmp->vm_flags & VM_DENYWRITE)
 				atomic_dec(&inode->i_writecount);

 			/* insert tmp into the share list, just after mpnt */
-			down(&file->f_mapping->i_shared_sem);
-			__vma_prio_tree_add(tmp, mpnt);
-			up(&file->f_mapping->i_shared_sem);
+			if (down_write_trylock(&mapping->i_shared_sem)) {
+				__vma_prio_tree_add(tmp, mpnt);
+				up_write(&mapping->i_shared_sem);
+			}
+			else {
+				if (unlikely(mpnt->vm_flags & VM_NONLINEAR)) {
+					down_write(&mapping->i_shared_sem);
+					list_add(&tmp->shared.vm_set.list,
+						    &mpnt->shared.vm_set.list);
+					up_write(&mapping->i_shared_sem);
+				}
+				else {
+					struct vm_area_struct *tree_node;
+					struct prio_tree_root *root;
+					if (mpnt->vm_flags & VM_SHARED)
+						root = &mapping->i_mmap_shared;
+					else
+						root = &mapping->i_mmap;
+
+					down_read(&mapping->i_shared_sem);
+					tree_node = __vma_prio_tree_find(root,
+							RADIX_INDEX(mpnt),
+							HEAP_INDEX(mpnt));
+					BUG_ON(!tree_node);
+					vm_set_lock(tree_node);
+					__vma_prio_tree_add(tmp, mpnt);
+					vm_set_unlock(tree_node);
+					up_read(&mapping->i_shared_sem);
+				}
+			}
 		}

 		/*
diff -puN mm/fremap.c~110_sem_contention mm/fremap.c
--- mmlinux-2.6/mm/fremap.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/mm/fremap.c	2004-04-14 15:49:01.000000000 -0400
@@ -203,13 +203,13 @@ asmlinkage long sys_remap_file_pages(uns
 		linear_pgoff += ((start - vma->vm_start) >> PAGE_SHIFT);
 		if (pgoff != linear_pgoff && !(vma->vm_flags & VM_NONLINEAR)) {
 			mapping = vma->vm_file->f_mapping;
-			down(&mapping->i_shared_sem);
+			down_write(&mapping->i_shared_sem);
 			vma->vm_flags |= VM_NONLINEAR;
 			__vma_prio_tree_remove(&mapping->i_mmap_shared, vma);
 			INIT_VMA_SHARED_LIST(vma);
 			list_add_tail(&vma->shared.vm_set.list,
 					&mapping->i_mmap_nonlinear);
-			up(&mapping->i_shared_sem);
+			up_write(&mapping->i_shared_sem);
 		}

 		/* ->populate can take a long time, so downgrade the lock. */
diff -puN mm/memory.c~110_sem_contention mm/memory.c
--- mmlinux-2.6/mm/memory.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/mm/memory.c	2004-04-14 15:49:01.000000000 -0400
@@ -1133,14 +1133,14 @@ void invalidate_mmap_range(struct addres
 		if (holeend & ~(long long)ULONG_MAX)
 			hlen = ULONG_MAX - hba + 1;
 	}
-	down(&mapping->i_shared_sem);
+	down_write(&mapping->i_shared_sem);
 	/* Protect against page fault */
 	atomic_inc(&mapping->truncate_count);
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen);
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		invalidate_mmap_range_list(&mapping->i_mmap_shared, hba, hlen);
-	up(&mapping->i_shared_sem);
+	up_write(&mapping->i_shared_sem);
 }
 EXPORT_SYMBOL_GPL(invalidate_mmap_range);

diff -puN mm/mmap.c~110_sem_contention mm/mmap.c
--- mmlinux-2.6/mm/mmap.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/mm/mmap.c	2004-04-14 15:49:01.000000000 -0400
@@ -96,10 +96,43 @@ static void remove_shared_vm_struct(stru

 	if (file) {
 		struct address_space *mapping = file->f_mapping;
-		down(&mapping->i_shared_sem);
-		__remove_shared_vm_struct(vma, file->f_dentry->d_inode,
-				mapping);
-		up(&mapping->i_shared_sem);
+		struct inode *inode = file->f_dentry->d_inode;
+
+		if (down_write_trylock(&mapping->i_shared_sem)) {
+			__remove_shared_vm_struct(vma, inode, mapping);
+			up_write(&mapping->i_shared_sem);
+			return;
+		}
+
+		if (likely(!(vma->vm_flags & VM_NONLINEAR) &&
+					!vma->shared.both.parent)) {
+			struct prio_tree_root *root;
+			struct vm_area_struct *tree_node;
+			if (vma->vm_flags & VM_SHARED)
+				root = &mapping->i_mmap_shared;
+			else
+				root = &mapping->i_mmap;
+
+			down_read(&mapping->i_shared_sem);
+			if (unlikely(vma->shared.both.parent)) {
+				up_read(&mapping->i_shared_sem);
+				goto get_write;
+			}
+			tree_node = __vma_prio_tree_find(root,
+					RADIX_INDEX(vma), HEAP_INDEX(vma));
+			BUG_ON(!tree_node);
+			vm_set_lock(tree_node);
+			if (vma->vm_flags & VM_DENYWRITE)
+				atomic_inc(&inode->i_writecount);
+			__vma_prio_tree_del(vma);
+			vm_set_unlock(tree_node);
+			up_read(&mapping->i_shared_sem);
+			return;
+		}
+get_write:
+		down_write(&mapping->i_shared_sem);
+		__remove_shared_vm_struct(vma, inode, mapping);
+		up_write(&mapping->i_shared_sem);
 	}
 }

@@ -291,26 +324,58 @@ __vma_link(struct mm_struct *mm, struct
 {
 	__vma_link_list(mm, vma, prev, rb_parent);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
-	__vma_link_file(vma);
 }

 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev, struct rb_node **rb_link,
 			struct rb_node *rb_parent)
 {
+	struct prio_tree_root *root;
+	struct vm_area_struct *tree_node;
 	struct address_space *mapping = NULL;

 	if (vma->vm_file)
 		mapping = vma->vm_file->f_mapping;

-	if (mapping)
-		down(&mapping->i_shared_sem);
-	spin_lock(&mm->page_table_lock);
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
-	spin_unlock(&mm->page_table_lock);
-	if (mapping)
-		up(&mapping->i_shared_sem);
+	if (mapping) {
+		if (unlikely(vma->vm_flags & VM_NONLINEAR))
+			goto get_write;
+		if (vma->vm_flags & VM_SHARED)
+			root = &mapping->i_mmap_shared;
+		else
+			root = &mapping->i_mmap;

+		down_read(&mapping->i_shared_sem);
+		tree_node = __vma_prio_tree_find(root,
+				RADIX_INDEX(vma), HEAP_INDEX(vma));
+		if (tree_node) {
+			struct inode *inode = vma->vm_file->f_dentry->d_inode;
+			if (vma->vm_flags & VM_DENYWRITE)
+				atomic_dec(&inode->i_writecount);
+			spin_lock(&mm->page_table_lock);
+			__vma_link(mm, vma, prev, rb_link, rb_parent);
+			spin_unlock(&mm->page_table_lock);
+			vm_set_lock(tree_node);
+			__vma_prio_tree_add(vma, tree_node);
+			vm_set_unlock(tree_node);
+			up_read(&mapping->i_shared_sem);
+		}
+		else {
+			up_read(&mapping->i_shared_sem);
+get_write:
+			down_write(&mapping->i_shared_sem);
+			spin_lock(&mm->page_table_lock);
+			__vma_link(mm, vma, prev, rb_link, rb_parent);
+			__vma_link_file(vma);
+			spin_unlock(&mm->page_table_lock);
+			up_write(&mapping->i_shared_sem);
+		}
+	}
+	else {
+		spin_lock(&mm->page_table_lock);
+		__vma_link(mm, vma, prev, rb_link, rb_parent);
+		spin_unlock(&mm->page_table_lock);
+	}
 	mark_mm_hugetlb(mm, vma);
 	mm->map_count++;
 	validate_mm(mm);
@@ -331,6 +396,7 @@ __insert_vm_struct(struct mm_struct * mm
 	if (__vma && __vma->vm_start < vma->vm_end)
 		BUG();
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	__vma_link_file(vma);
 	mark_mm_hugetlb(mm, vma);
 	mm->map_count++;
 	validate_mm(mm);
@@ -410,7 +476,7 @@ static struct vm_area_struct *vma_merge(
 	spinlock_t *lock = &mm->page_table_lock;
 	struct inode *inode = file ? file->f_dentry->d_inode : NULL;
 	struct address_space *mapping = file ? file->f_mapping : NULL;
-	struct semaphore *i_shared_sem;
+	struct rw_semaphore *i_shared_sem;
 	struct prio_tree_root *root = NULL;

 	/*
@@ -442,13 +508,9 @@ static struct vm_area_struct *vma_merge(
 	if (prev->vm_end == addr &&
 			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
 		struct vm_area_struct *next;
-		int need_up = 0;

-		if (unlikely(file && prev->vm_next &&
-				prev->vm_next->vm_file == file)) {
-			down(i_shared_sem);
-			need_up = 1;
-		}
+		if (file)
+			down_write(i_shared_sem);
 		spin_lock(lock);

 		/*
@@ -463,20 +525,18 @@ static struct vm_area_struct *vma_merge(
 					next->vm_end, prev->vm_pgoff);
 			__remove_shared_vm_struct(next, inode, mapping);
 			spin_unlock(lock);
-			if (need_up)
-				up(i_shared_sem);
-			if (file)
+			if (file) {
+				up_write(i_shared_sem);
 				fput(file);
-
+			}
 			mm->map_count--;
 			kmem_cache_free(vm_area_cachep, next);
 			return prev;
 		}
-
 		__vma_modify(root, prev, prev->vm_start, end, prev->vm_pgoff);
 		spin_unlock(lock);
-		if (need_up)
-			up(i_shared_sem);
+		if (file)
+			up_write(i_shared_sem);
 		return prev;
 	}

@@ -491,13 +551,13 @@ static struct vm_area_struct *vma_merge(
 			return NULL;
 		if (end == prev->vm_start) {
 			if (file)
-				down(i_shared_sem);
+				down_write(i_shared_sem);
 			spin_lock(lock);
 			__vma_modify(root, prev, addr, prev->vm_end,
 				prev->vm_pgoff - ((end - addr) >> PAGE_SHIFT));
 			spin_unlock(lock);
 			if (file)
-				up(i_shared_sem);
+				up_write(i_shared_sem);
 			return prev;
 		}
 	}
@@ -1362,7 +1422,7 @@ int split_vma(struct mm_struct * mm, str
 	}

 	if (mapping)
-		down(&mapping->i_shared_sem);
+		down_write(&mapping->i_shared_sem);
 	spin_lock(&mm->page_table_lock);

 	if (new_below)
@@ -1375,7 +1435,7 @@ int split_vma(struct mm_struct * mm, str

 	spin_unlock(&mm->page_table_lock);
 	if (mapping)
-		up(&mapping->i_shared_sem);
+		up_write(&mapping->i_shared_sem);

 	return 0;
 }
diff -puN mm/mremap.c~110_sem_contention mm/mremap.c
--- mmlinux-2.6/mm/mremap.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/mm/mremap.c	2004-04-14 15:49:01.000000000 -0400
@@ -295,7 +295,7 @@ static unsigned long move_vma(struct vm_
 		 * and we propagate stale pages into the dst afterward.
 		 */
 		mapping = vma->vm_file->f_mapping;
-		down(&mapping->i_shared_sem);
+		down_read(&mapping->i_shared_sem);
 	}
 	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
 	if (moved_len < old_len) {
@@ -311,7 +311,7 @@ static unsigned long move_vma(struct vm_
 		new_addr = -ENOMEM;
 	}
 	if (mapping)
-		up(&mapping->i_shared_sem);
+		up_read(&mapping->i_shared_sem);

 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT) {
@@ -476,7 +476,7 @@ unsigned long do_mremap(unsigned long ad
 				}
 				else
 					root = &mapping->i_mmap;
-				down(&mapping->i_shared_sem);
+				down_write(&mapping->i_shared_sem);
 			}

 			spin_lock(&vma->vm_mm->page_table_lock);
@@ -485,7 +485,7 @@ unsigned long do_mremap(unsigned long ad
 			spin_unlock(&vma->vm_mm->page_table_lock);

 			if(mapping)
-				up(&mapping->i_shared_sem);
+				up_write(&mapping->i_shared_sem);

 			current->mm->total_vm += pages;
 			if (vma->vm_flags & VM_LOCKED) {
diff -puN mm/prio_tree.c~110_sem_contention mm/prio_tree.c
--- mmlinux-2.6/mm/prio_tree.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/mm/prio_tree.c	2004-04-14 15:49:01.000000000 -0400
@@ -279,6 +279,66 @@ void prio_tree_remove(struct prio_tree_r
 }

 /*
+ * Find a prio_tree node with the given radix_index and heap_index. This
+ * algorithm takes 0(log n) time. At most 64 (less than 32 in common case)
+ * nodes are visited in a 32 bit machine.
+ */
+struct prio_tree_node *prio_tree_find(struct prio_tree_root *root,
+		unsigned long radix_index, unsigned long heap_index)
+{
+	struct prio_tree_node *cur;
+	unsigned long r_index, h_index, index, mask;
+	int size_flag = 0;
+
+	if (prio_tree_empty(root) ||
+			heap_index > prio_tree_maxindex(root->index_bits))
+		return NULL;
+
+	cur = root->prio_tree_node;
+	mask = 1UL << (root->index_bits - 1);
+
+	while (mask) {
+		GET_INDEX(cur, r_index, h_index);
+
+		if (r_index == radix_index && h_index == heap_index)
+			return cur;
+
+                if (h_index < heap_index || (h_index == heap_index &&
+						r_index > radix_index))
+			return NULL;
+
+		if (size_flag)
+			index = heap_index - radix_index;
+		else
+			index = radix_index;
+
+		if (index & mask) {
+			if (prio_tree_right_empty(cur))
+				return NULL;
+			else
+				cur = cur->right;
+		}
+		else {
+			if (prio_tree_left_empty(cur))
+				return NULL;
+			else
+				cur = cur->left;
+		}
+
+		mask >>= 1;
+
+		if (!mask) {
+			mask = 1UL << (root->index_bits - 1);
+			size_flag = 1;
+		}
+	}
+	/* Should not reach here */
+	BUG();
+	return NULL;
+}
+
+
+/*
  * Following functions help to enumerate all prio_tree_nodes in the tree that
  * overlap with the input interval X [radix_index, heap_index]. The enumeration
  * takes O(log n + m) time where 'log n' is the height of the tree (which is
@@ -529,55 +589,34 @@ void __vma_prio_tree_insert(struct prio_
 void __vma_prio_tree_remove(struct prio_tree_root *root,
 	struct vm_area_struct *vma)
 {
-	struct vm_area_struct *node, *head, *new_head;
+	struct vm_area_struct *head, *new_head;

-	if (vma->shared.both.parent == NULL && vma->vm_set_head == NULL) {
-		list_del_init(&vma->shared.vm_set.list);
-		INIT_VMA_SHARED(vma);
+	if (!vma->shared.both.parent) {
+		__vma_prio_tree_del(vma);
 		return;
 	}

 	if (vma->vm_set_head) {
 		/* Leave this BUG_ON till prio_tree patch stabilizes */
 		BUG_ON(vma->vm_set_head->vm_set_head != vma);
-		if (vma->shared.both.parent) {
-			head = vma->vm_set_head;
-			if (!list_empty(&head->shared.vm_set.list)) {
-				new_head = list_entry(
-					head->shared.vm_set.list.next,
-					struct vm_area_struct,
-					shared.vm_set.list);
-				list_del_init(&head->shared.vm_set.list);
-			}
-			else
-				new_head = NULL;
+		head = vma->vm_set_head;
+		if (!list_empty(&head->shared.vm_set.list)) {
+			new_head = list_entry(head->shared.vm_set.list.next,
+				struct vm_area_struct, shared.vm_set.list);
+			list_del_init(&head->shared.vm_set.list);
+		}
+		else
+			new_head = NULL;

-			prio_tree_replace(root, &vma->shared.prio_tree_node,
-					&head->shared.prio_tree_node);
-			head->vm_set_head = new_head;
-			if (new_head)
-				new_head->vm_set_head = head;
+		prio_tree_replace(root, &vma->shared.prio_tree_node,
+				&head->shared.prio_tree_node);
+		head->vm_set_head = new_head;
+		if (new_head)
+			new_head->vm_set_head = head;

-		}
-		else {
-			node = vma->vm_set_head;
-			if (!list_empty(&vma->shared.vm_set.list)) {
-				new_head = list_entry(
-					vma->shared.vm_set.list.next,
-					struct vm_area_struct,
-					shared.vm_set.list);
-				list_del_init(&vma->shared.vm_set.list);
-				node->vm_set_head = new_head;
-				new_head->vm_set_head = node;
-			}
-			else
-				node->vm_set_head = NULL;
-		}
-		INIT_VMA_SHARED(vma);
-		return;
-	}
+	} else
+		prio_tree_remove(root, &vma->shared.prio_tree_node);

-	prio_tree_remove(root, &vma->shared.prio_tree_node);
 	INIT_VMA_SHARED(vma);
 }

diff -puN mm/rmap.c~110_sem_contention mm/rmap.c
--- mmlinux-2.6/mm/rmap.c~110_sem_contention	2004-04-14 15:49:01.000000000 -0400
+++ mmlinux-2.6-jaya/mm/rmap.c	2004-04-14 15:49:01.000000000 -0400
@@ -279,10 +279,10 @@ static inline int page_referenced_obj(st
 	unsigned long address;
 	int referenced = 0;

-	if (down_trylock(&mapping->i_shared_sem))
+	if (!down_read_trylock(&mapping->i_shared_sem))
 		return 0;

-	vma = __vma_prio_tree_first(&mapping->i_mmap,
+	vma = __vma_prio_tree_first_lock(&mapping->i_mmap,
 					&iter, pgoff, pgoff);
 	while (vma) {
 		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
@@ -297,11 +297,11 @@ static inline int page_referenced_obj(st
 			if (!*mapcount)
 				goto out;
 		}
-		vma = __vma_prio_tree_next(vma, &mapping->i_mmap,
+		vma = __vma_prio_tree_next_lock(vma, &mapping->i_mmap,
 						&iter, pgoff, pgoff);
 	}

-	vma = __vma_prio_tree_first(&mapping->i_mmap_shared,
+	vma = __vma_prio_tree_first_lock(&mapping->i_mmap_shared,
 					&iter, pgoff, pgoff);
 	while (vma) {
 		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
@@ -315,14 +315,17 @@ static inline int page_referenced_obj(st
 			if (!*mapcount)
 				goto out;
 		}
-		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+		vma = __vma_prio_tree_next_lock(vma, &mapping->i_mmap_shared,
 						&iter, pgoff, pgoff);
 	}
-
+
 	if (list_empty(&mapping->i_mmap_nonlinear))
-		WARN_ON(*mapcount > 0);
+		WARN_ON(*mapcount > 0);
+	up_read(&mapping->i_shared_sem);
+	return referenced;
 out:
-	up(&mapping->i_shared_sem);
+	__vma_prio_tree_iter_unlock(&iter);
+	up_read(&mapping->i_shared_sem);
 	return referenced;
 }

@@ -711,10 +714,10 @@ static inline int try_to_unmap_obj(struc
 	unsigned long max_nl_cursor = 0;
 	unsigned long max_nl_size = 0;

-	if (down_trylock(&mapping->i_shared_sem))
+	if (!down_read_trylock(&mapping->i_shared_sem))
 		return ret;

-	vma = __vma_prio_tree_first(&mapping->i_mmap,
+	vma = __vma_prio_tree_first_lock(&mapping->i_mmap,
 					&iter, pgoff, pgoff);
 	while (vma) {
 		if (vma->vm_mm->rss) {
@@ -722,13 +725,13 @@ static inline int try_to_unmap_obj(struc
 			ret = try_to_unmap_one(
 				page, vma->vm_mm, address, mapcount, vma);
 			if (ret == SWAP_FAIL || !*mapcount)
-				goto out;
+				goto out_read;
 		}
-		vma = __vma_prio_tree_next(vma, &mapping->i_mmap,
+		vma = __vma_prio_tree_next_lock(vma, &mapping->i_mmap,
 						&iter, pgoff, pgoff);
 	}

-	vma = __vma_prio_tree_first(&mapping->i_mmap_shared,
+	vma = __vma_prio_tree_first_lock(&mapping->i_mmap_shared,
 					&iter, pgoff, pgoff);
 	while (vma) {
 		if (vma->vm_mm->rss) {
@@ -736,14 +739,18 @@ static inline int try_to_unmap_obj(struc
 			ret = try_to_unmap_one(
 				page, vma->vm_mm, address, mapcount, vma);
 			if (ret == SWAP_FAIL || !*mapcount)
-				goto out;
+				goto out_read;
 		}
-		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+		vma = __vma_prio_tree_next_lock(vma, &mapping->i_mmap_shared,
 						&iter, pgoff, pgoff);
 	}

 	if (list_empty(&mapping->i_mmap_nonlinear))
-		goto out;
+		goto nolock;
+
+	up_read(&mapping->i_shared_sem);
+	if (!down_write_trylock(&mapping->i_shared_sem))
+		return ret;

 	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
 						shared.vm_set.list) {
@@ -813,7 +820,12 @@ static inline int try_to_unmap_obj(struc
 relock:
 	rmap_lock(page);
 out:
-	up(&mapping->i_shared_sem);
+	up_write(&mapping->i_shared_sem);
+	return ret;
+out_read:
+	__vma_prio_tree_iter_unlock(&iter);
+nolock:
+	up_read(&mapping->i_shared_sem);
 	return ret;
 }


_

