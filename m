Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUCUWQV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCUWQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:16:21 -0500
Received: from reformers.mr.itd.umich.edu ([141.211.93.147]:35024 "EHLO
	reformers.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261430AbUCUWLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:11:05 -0500
Date: Sun, 21 Mar 2004 17:10:45 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@rust.engin.umich.edu
To: akpm@osdl.org
cc: torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com, andrea@suse.de,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, vrajesh@umich.edu
Subject: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
 fix
In-Reply-To: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is an attempt at fixing the much discussed search complexity issues
in objrmap design. The key idea is to replace the i_mmap{_shared} list with a
new tree data structure.

The radix priority search tree (prio_tree) first proposed by Edward M. McCreight
is used as the new data structure. A prio_tree is indexed by two indices which
we call radix_index and heap_index. The tree is a simple binary radix tree on
the radix_index with an additional heap tree like property that a parent node's
heap_index is always greater than or equal to the heap_indices of its children.

An interesting property of the prio_tree is that they are useful to store and
query intervals, for example, a file-mapped vm_area_struct can be considered
as an interval of file pages. If we store all vmas that map a file in a
prio_tree, then we can execute a stabbing query, i.e., choosing a set of vmas
that a map a single file page or a set of contiguous file pages, in O(log n + m)
time where "log n" indicates the height of the tree (maximum 64 in a 32 bit
machine) and "m" represents the number of vmas that map the page(s).

The test results below show that the prio_tree effectively solves the objrmap
i_mmap{_shared} search complexity problems. The tests were done on a PII
200 MHz machine with 256MB RAM using UP kernels.

This patch is for 2.6.5-rc2. The patch boots and works both on SMP and UP.
Further testing will help. If you like broken-out patches please check:

http://www-personal.engin.umich.edu/~vrajesh/~vrajesh/linux/prio_tree/

Some Results:

Kernel compile - 2.6.2 defconfig - make
2.6.5-rc2	 3313.97 user 261.08 system 1:00:11 elapsed 98% CPU
rc2+prio+objrmap 3315.30 user 258.59 system 1:00:14 elapsed 98% CPU
rc2+objrmap	 3316.41 user 257.77 system 1:00:10 elapsed 98% CPU

rmap-test 1 - ./rmap-test -l -i 10 -n 100 -s 600 -t 100 foo
2.6.5-rc2	 67.57 user 277.14 system 0:13:12 elapsed 43% CPU
rc2+prio+objrmap 71.99 user 203.90 system 0:13:30 elapsed 34% CPU
rc2+objrmap    70.45 user 19834.38 system 7:28:04 elapsed 74% CPU
	-I killed the process after 7 hours. System was responsive afer
	killing the process. Compared to previous results, the program
	should not lock or take so long. Maybe it is due to this problem
	identified by Andrea:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=107966438414248

	Andrea says the system may hang, however, in this case system
	does not hang.

rmap-test 2 - ./rmap-test -vv -V 2 -r -i 1 -n 100 -s 600 -t 100 foo
2.6.5-rc2	 0.58 user 212.50 system 0: 7:32 elapsed 47% CPU
rc2+prio+objrmap 0.63 user 101.77 system 0: 4:44 elapsed 36% CPU
rc2+objrmap	 0.60 user 605.97 system 0:14:35 elapsed 69% CPU


rmap-test 3 - ./rmap-test -v -l -i 10 -n 10000 -s 7 -t 1 foo
2.6.5-rc2	 1.07 user 31.08 system 0:16:06 elapsed 3% CPU
rc2+prio+objrmap 1.03 user 31.41 system 0:16:38 elapsed 3% CPU
rc2+objrmap    0.53 user 1588.40 system 2:25:27 elapsed 18% CPU
			-I killed the process after around 2 1/2 hours.
			 System was responsive afer killing the process.

test-mmap2                             H M Sec.
2.6.5-rc2	 0.00 user 0.34 system 0:0:01.55 elapsed 22% CPU
rc2+prio+objramp 0.00 user 0.35 system 0:0:01.49 elapsed 23% CPU
rc2+objrmap	 - didn't try - already known to lock the system


test-mmap3                             H M Sec.
2.6.5-rc2	 0.06 user 3.38 system 0:0:14.62 elapsed 23% CPU
rc2+prio+objrmap 0.09 user 3.65 system 0:0:13.99 elapsed 26% CPU
rc2+objrmap	 - didn't try - known to lock the system


Lowlights of the patch:

  * Adds a new tree data structure (around 500 lines of code + bugs?)
  	- code seems reasonably stable. More testing will help a lot.

  * Breaks compilation of hugetlbfs, xfs, and few archs.
  	- easily fixable.

  * Adds 2 extra pointers to vm_area_struct
  	- both of these pointers can be removed later.

	- Plan:

	   * Shove vm_list_head into vm_private_data.

	   * I need a single bit protected by i_shared_sem to
	     mark prio_tree nodes. When I get convinced that I can use
	     the least significant bit of the vm_list_head for marking
	     nodes (vm_area_struct alignment?), I plan to remove the parent
	     field and use percpu array in prio_tree_insert and
	     prio_tree_remove. In invalidate_mmap_range_list, we can try to
	     allocate an array from slab (helps to avoid high latency in
	     truncate), if we fail, we can fall back to percpu array.

Useful Links:

[1] Andrew Morton's rmap-test.c
	http://marc.theaimsgroup.com/?l=linux-kernel&m=104954444204356

[2] Ingo's test-mmap2.c
	http://marc.theaimsgroup.com/?l=linux-kernel&m=107883030601436

[3] Ingo's test-mmap3.c
	http://marc.theaimsgroup.com/?l=linux-kernel&m=107886160312419



 fs/exec.c                 |    2
 fs/inode.c                |    4
 fs/locks.c                |    6
 fs/proc/task_mmu.c        |    2
 include/linux/fs.h        |    5
 include/linux/mm.h        |  168 +++++++++++++
 include/linux/prio_tree.h |   78 ++++++
 init/main.c               |    2
 kernel/fork.c             |    4
 mm/Makefile               |    3
 mm/filemap.c              |    2
 mm/memory.c               |   15 -
 mm/mmap.c                 |   66 +++--
 mm/mremap.c               |   21 +
 mm/prio_tree.c            |  574 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/shmem.c                |    2
 mm/swap_state.c           |    4
 mm/vmscan.c               |    4
 18 files changed, 910 insertions(+), 52 deletions(-)

diff -puN fs/exec.c~prio_tree_core fs/exec.c
--- mmlinux-2.6/fs/exec.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/fs/exec.c	2004-03-21 16:25:34.000000000 -0500
@@ -430,7 +430,7 @@ int setup_arg_pages(struct linux_binprm
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
-		INIT_LIST_HEAD(&mpnt->shared);
+		INIT_VMA_SHARED(mpnt);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
diff -puN fs/inode.c~prio_tree_core fs/inode.c
--- mmlinux-2.6/fs/inode.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/fs/inode.c	2004-03-21 16:25:01.000000000 -0500
@@ -189,8 +189,8 @@ void inode_init_once(struct inode *inode
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
-	INIT_LIST_HEAD(&inode->i_data.i_mmap);
-	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
+	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
+	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap_shared);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
 }
diff -puN fs/locks.c~prio_tree_core fs/locks.c
--- mmlinux-2.6/fs/locks.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/fs/locks.c	2004-03-21 16:25:01.000000000 -0500
@@ -1455,8 +1455,7 @@ int fcntl_setlk(struct file *filp, unsig
 	if (IS_MANDLOCK(inode) &&
 	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID) {
 		struct address_space *mapping = filp->f_mapping;
-
-		if (!list_empty(&mapping->i_mmap_shared)) {
+		if (!prio_tree_empty(&mapping->i_mmap_shared)) {
 			error = -EAGAIN;
 			goto out;
 		}
@@ -1593,8 +1592,7 @@ int fcntl_setlk64(struct file *filp, uns
 	if (IS_MANDLOCK(inode) &&
 	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID) {
 		struct address_space *mapping = filp->f_mapping;
-
-		if (!list_empty(&mapping->i_mmap_shared)) {
+		if (!prio_tree_empty(&mapping->i_mmap_shared)) {
 			error = -EAGAIN;
 			goto out;
 		}
diff -puN fs/proc/task_mmu.c~prio_tree_core fs/proc/task_mmu.c
--- mmlinux-2.6/fs/proc/task_mmu.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/fs/proc/task_mmu.c	2004-03-21 16:25:01.000000000 -0500
@@ -65,7 +65,7 @@ int task_statm(struct mm_struct *mm, int
 				*shared += pages;
 			continue;
 		}
-		if (vma->vm_flags & VM_SHARED || !list_empty(&vma->shared))
+		if (vma->vm_flags & VM_SHARED || !vma_shared_empty(vma))
 			*shared += pages;
 		if (vma->vm_flags & VM_EXECUTABLE)
 			*text += pages;
diff -puN include/linux/fs.h~prio_tree_core include/linux/fs.h
--- mmlinux-2.6/include/linux/fs.h~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/include/linux/fs.h	2004-03-21 16:25:01.000000000 -0500
@@ -18,6 +18,7 @@
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
+#include <linux/prio_tree.h>
 #include <linux/kobject.h>
 #include <asm/atomic.h>

@@ -329,8 +330,8 @@ struct address_space {
 	struct list_head	io_pages;	/* being prepared for I/O */
 	unsigned long		nrpages;	/* number of total pages */
 	struct address_space_operations *a_ops;	/* methods */
-	struct list_head	i_mmap;		/* list of private mappings */
-	struct list_head	i_mmap_shared;	/* list of shared mappings */
+	struct prio_tree_root	i_mmap;		/* tree of private mappings */
+	struct prio_tree_root	i_mmap_shared;	/* tree of shared mappings */
 	struct semaphore	i_shared_sem;	/* protect both above lists */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		dirtied_when;	/* jiffies of first page dirtying */
diff -puN include/linux/mm.h~prio_tree_core include/linux/mm.h
--- mmlinux-2.6/include/linux/mm.h~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/include/linux/mm.h	2004-03-21 16:25:34.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/mmzone.h>
 #include <linux/rbtree.h>
+#include <linux/prio_tree.h>
 #include <linux/fs.h>

 #ifndef CONFIG_DISCONTIGMEM          /* Don't use mapnrs, do it properly */
@@ -67,8 +68,29 @@ struct vm_area_struct {
 	 * one of the address_space->i_mmap{,shared} lists,
 	 * for shm areas, the list of attaches, otherwise unused.
 	 */
-	struct list_head shared;
+	union {
+		struct {
+			struct list_head list;
+			void *parent;
+		} vm_set;
+
+		struct prio_tree_node  prio_tree_node;
+
+		struct {
+			void *first;
+			void *second;
+			void *parent;
+		} both;
+	} shared;

+	/*
+	 * shared.vm_set : list of vmas that map exactly the same set of pages
+	 * vm_set_head   : head of the vm_set list
+	 *
+	 * TODO: try to shove the following field into vm_private_data ??
+	 */
+	struct vm_area_struct *vm_set_head;
+
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;

@@ -129,6 +151,150 @@ struct vm_area_struct {
 #define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)

 /*
+ * The following macros are used for implementing prio_tree for i_mmap{_shared}
+ */
+
+#define	RADIX_INDEX(vma)  ((vma)->vm_pgoff)
+#define	VMA_SIZE(vma)	  (((vma)->vm_end - (vma)->vm_start) >> PAGE_SHIFT)
+/* avoid overflow */
+#define	HEAP_INDEX(vma)	  ((vma)->vm_pgoff + (VMA_SIZE(vma) - 1))
+
+#define GET_INDEX_VMA(vma, radix, heap)		\
+do {						\
+	radix = RADIX_INDEX(vma);		\
+	heap = HEAP_INDEX(vma);			\
+} while (0)
+
+#define GET_INDEX(node, radix, heap)		\
+do { 						\
+	struct vm_area_struct *__tmp = 		\
+	  prio_tree_entry(node, struct vm_area_struct, shared.prio_tree_node);\
+	GET_INDEX_VMA(__tmp, radix, heap); 	\
+} while (0)
+
+#define	INIT_VMA_SHARED_LIST(vma)			\
+do {							\
+	INIT_LIST_HEAD(&(vma)->shared.vm_set.list);	\
+	(vma)->shared.vm_set.parent = NULL;		\
+	(vma)->vm_set_head = NULL;			\
+} while (0)
+
+#define INIT_VMA_SHARED(vma)			\
+do {						\
+	(vma)->shared.both.first = NULL;	\
+	(vma)->shared.both.second = NULL;	\
+	(vma)->shared.both.parent = NULL;	\
+	(vma)->vm_set_head = NULL;		\
+} while (0)
+
+extern void __vma_prio_tree_insert(struct prio_tree_root *,
+	struct vm_area_struct *);
+
+extern void __vma_prio_tree_remove(struct prio_tree_root *,
+	struct vm_area_struct *);
+
+static inline int vma_shared_empty(struct vm_area_struct *vma)
+{
+	return vma->shared.both.first == NULL;
+}
+
+/*
+ * Helps to add a new vma that maps the same (identical) set of pages as the
+ * old vma to an i_mmap tree.
+ */
+static inline void __vma_prio_tree_add(struct vm_area_struct *vma,
+	struct vm_area_struct *old)
+{
+	INIT_VMA_SHARED_LIST(vma);
+
+	/* Leave these BUG_ONs till prio_tree patch stabilizes */
+	BUG_ON(RADIX_INDEX(vma) != RADIX_INDEX(old));
+	BUG_ON(HEAP_INDEX(vma) != HEAP_INDEX(old));
+
+	if (old->shared.both.parent) {
+		if (old->vm_set_head) {
+			list_add_tail(&vma->shared.vm_set.list,
+					&old->vm_set_head->shared.vm_set.list);
+			return;
+		}
+		else {
+			old->vm_set_head = vma;
+			vma->vm_set_head = old;
+		}
+	}
+	else
+		list_add(&vma->shared.vm_set.list, &old->shared.vm_set.list);
+}
+
+/*
+ * We cannot modify vm_start, vm_end, vm_pgoff fields of a vma that has been
+ * already present in an i_mmap{_shared} tree without modifying the tree. The
+ * following helper function should be used when such modifications are
+ * necessary. We should hold the mapping's i_shared_sem.
+ *
+ * This function can be (micro)optimized for some special cases (maybe later).
+ */
+static inline void __vma_modify(struct prio_tree_root *root,
+	struct vm_area_struct *vma, unsigned long start, unsigned long end,
+	unsigned long pgoff)
+{
+	if (root)
+		__vma_prio_tree_remove(root, vma);
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	if (root)
+		__vma_prio_tree_insert(root, vma);
+}
+
+/*
+ * Helper functions to enumerate vmas that map a given file page or a set of
+ * contiguous file pages. The functions return vmas that at least map a single
+ * page in the given range of contiguous file pages.
+ */
+static inline struct vm_area_struct *__vma_prio_tree_first(
+	struct prio_tree_root *root, struct prio_tree_iter *iter,
+	unsigned long begin, unsigned long end)
+{
+	struct prio_tree_node *ptr;
+
+	ptr = prio_tree_first(root, iter, begin, end);
+
+	if (ptr)
+		return prio_tree_entry(ptr, struct vm_area_struct,
+				shared.prio_tree_node);
+	else
+		return NULL;
+}
+
+static inline struct vm_area_struct *__vma_prio_tree_next(
+	struct vm_area_struct *vma, struct prio_tree_root *root,
+	struct prio_tree_iter *iter, unsigned long begin, unsigned long end)
+{
+	struct prio_tree_node *ptr;
+	struct vm_area_struct *next;
+
+	if (vma->shared.both.parent) {
+		if (vma->vm_set_head)
+			return vma->vm_set_head;
+	}
+	else {
+		next = list_entry(vma->shared.vm_set.list.next,
+				struct vm_area_struct, shared.vm_set.list);
+		if (!(next->vm_set_head))
+			return next;
+	}
+
+	ptr = prio_tree_next(root, iter, begin, end);
+
+	if (ptr)
+		return prio_tree_entry(ptr, struct vm_area_struct,
+				shared.prio_tree_node);
+	else
+		return NULL;
+}
+
+/*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
  */
diff -puN /dev/null include/linux/prio_tree.h
--- /dev/null	2003-01-30 05:24:37.000000000 -0500
+++ mmlinux-2.6-jaya/include/linux/prio_tree.h	2004-03-21 16:25:01.000000000 -0500
@@ -0,0 +1,78 @@
+#ifndef _LINUX_PRIO_TREE_H
+#define _LINUX_PRIO_TREE_H
+
+struct prio_tree_node {
+	struct prio_tree_node *left;
+	struct prio_tree_node *right;
+	struct prio_tree_node *parent;
+};
+
+struct prio_tree_root {
+	struct prio_tree_node	*prio_tree_node;
+	unsigned int 		index_bits;
+};
+
+struct prio_tree_iter {
+	struct prio_tree_node	*cur;
+	unsigned long		mask;
+	unsigned long		value;
+	int			size_level;
+};
+
+#define PRIO_TREE_ROOT	(struct prio_tree_root) {NULL, 1}
+
+#define PRIO_TREE_ROOT_INIT	{NULL, 1}
+
+#define INIT_PRIO_TREE_ROOT(ptr)	\
+do {					\
+	(ptr)->prio_tree_node = NULL;	\
+	(ptr)->index_bits = 1;		\
+} while (0)
+
+#define PRIO_TREE_NODE_INIT(name)	{&(name), &(name), &(name)}
+
+#define PRIO_TREE_NODE(name) \
+	struct prio_tree_node name = PRIO_TREE_NODE_INIT(name)
+
+#define INIT_PRIO_TREE_NODE(ptr)				\
+do {								\
+	(ptr)->left = (ptr)->right = (ptr)->parent = (ptr);	\
+} while (0)
+
+#define	prio_tree_entry(ptr, type, member) \
+       ((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+
+#define	PRIO_TREE_ITER	(struct prio_tree_iter) {NULL, 0UL, 0UL, 0}
+
+static inline int prio_tree_empty(const struct prio_tree_root *root)
+{
+	return root->prio_tree_node == NULL;
+}
+
+static inline int prio_tree_root(const struct prio_tree_node *node)
+{
+	return node->parent == node;
+}
+
+static inline int prio_tree_left_empty(const struct prio_tree_node *node)
+{
+	return node->left == node;
+}
+
+static inline int prio_tree_right_empty(const struct prio_tree_node *node)
+{
+	return node->right == node;
+}
+
+extern struct prio_tree_node *prio_tree_insert(struct prio_tree_root *,
+	struct prio_tree_node *);
+
+extern void prio_tree_remove(struct prio_tree_root *, struct prio_tree_node *);
+
+extern struct prio_tree_node *prio_tree_first(struct prio_tree_root *,
+	struct prio_tree_iter *, unsigned long, unsigned long);
+
+extern struct prio_tree_node *prio_tree_next(struct prio_tree_root *,
+	struct prio_tree_iter *, unsigned long, unsigned long);
+
+#endif
diff -puN init/main.c~prio_tree_core init/main.c
--- mmlinux-2.6/init/main.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/init/main.c	2004-03-21 16:25:01.000000000 -0500
@@ -86,6 +86,7 @@ extern void pidhash_init(void);
 extern void pidmap_init(void);
 extern void pte_chain_init(void);
 extern void radix_tree_init(void);
+extern void prio_tree_init(void);
 extern void free_initmem(void);
 extern void populate_rootfs(void);
 extern void driver_init(void);
@@ -460,6 +461,7 @@ asmlinkage void __init start_kernel(void
 	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
+	prio_tree_init();
 	pte_chain_init();
 #ifdef CONFIG_X86
 	if (efi_enabled)
diff -puN kernel/fork.c~prio_tree_core kernel/fork.c
--- mmlinux-2.6/kernel/fork.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/kernel/fork.c	2004-03-21 16:25:01.000000000 -0500
@@ -313,7 +313,7 @@ static inline int dup_mmap(struct mm_str
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
 		file = tmp->vm_file;
-		INIT_LIST_HEAD(&tmp->shared);
+		INIT_VMA_SHARED(tmp);
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
 			get_file(file);
@@ -322,7 +322,7 @@ static inline int dup_mmap(struct mm_str

 			/* insert tmp into the share list, just after mpnt */
 			down(&file->f_mapping->i_shared_sem);
-			list_add_tail(&tmp->shared, &mpnt->shared);
+			__vma_prio_tree_add(tmp, mpnt);
 			up(&file->f_mapping->i_shared_sem);
 		}

diff -puN mm/filemap.c~prio_tree_core mm/filemap.c
--- mmlinux-2.6/mm/filemap.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/mm/filemap.c	2004-03-21 16:25:01.000000000 -0500
@@ -630,7 +630,7 @@ page_ok:
 		 * virtual addresses, take care about potential aliasing
 		 * before reading the page on the kernel side.
 		 */
-		if (!list_empty(&mapping->i_mmap_shared))
+		if (!prio_tree_empty(&mapping->i_mmap_shared))
 			flush_dcache_page(page);

 		/*
diff -puN mm/Makefile~prio_tree_core mm/Makefile
--- mmlinux-2.6/mm/Makefile~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/mm/Makefile	2004-03-21 16:25:01.000000000 -0500
@@ -9,6 +9,7 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o

 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
-			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
+			   slab.o swap.o truncate.o vmscan.o prio_tree.o \
+			   $(mmu-y)

 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
diff -puN mm/memory.c~prio_tree_core mm/memory.c
--- mmlinux-2.6/mm/memory.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/mm/memory.c	2004-03-21 16:25:34.000000000 -0500
@@ -1097,11 +1097,11 @@ no_pte_chain:
  * An hlen of zero blows away the entire portion file after hba.
  */
 static void
-invalidate_mmap_range_list(struct list_head *head,
+invalidate_mmap_range_list(struct prio_tree_root *root,
 			   unsigned long const hba,
 			   unsigned long const hlen)
 {
-	struct list_head *curr;
+	struct prio_tree_iter iter;
 	unsigned long hea;	/* last page of hole. */
 	unsigned long vba;
 	unsigned long vea;	/* last page of corresponding uva hole. */
@@ -1112,17 +1112,16 @@ invalidate_mmap_range_list(struct list_h
 	hea = hba + hlen - 1;	/* avoid overflow. */
 	if (hea < hba)
 		hea = ULONG_MAX;
-	list_for_each(curr, head) {
-		vp = list_entry(curr, struct vm_area_struct, shared);
+	vp = __vma_prio_tree_first(root, &iter, hba, hea);
+	while(vp) {
 		vba = vp->vm_pgoff;
 		vea = vba + ((vp->vm_end - vp->vm_start) >> PAGE_SHIFT) - 1;
-		if (hea < vba || vea < hba)
-		    	continue;	/* Mapping disjoint from hole. */
 		zba = (hba <= vba) ? vba : hba;
 		zea = (vea <= hea) ? vea : hea;
 		zap_page_range(vp,
 			       ((zba - vba) << PAGE_SHIFT) + vp->vm_start,
 			       (zea - zba + 1) << PAGE_SHIFT);
+		vp = __vma_prio_tree_next(vp, root, &iter, hba, hea);
 	}
 }

@@ -1157,9 +1156,9 @@ void invalidate_mmap_range(struct addres
 	down(&mapping->i_shared_sem);
 	/* Protect against page fault */
 	atomic_inc(&mapping->truncate_count);
-	if (unlikely(!list_empty(&mapping->i_mmap)))
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen);
-	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		invalidate_mmap_range_list(&mapping->i_mmap_shared, hba, hlen);
 	up(&mapping->i_shared_sem);
 }
diff -puN mm/mmap.c~prio_tree_core mm/mmap.c
--- mmlinux-2.6/mm/mmap.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/mm/mmap.c	2004-03-21 16:25:01.000000000 -0500
@@ -64,12 +64,16 @@ EXPORT_SYMBOL(vm_committed_space);
  * Requires inode->i_mapping->i_shared_sem
  */
 static inline void
-__remove_shared_vm_struct(struct vm_area_struct *vma, struct inode *inode)
+__remove_shared_vm_struct(struct vm_area_struct *vma, struct inode *inode,
+	struct address_space *mapping)
 {
 	if (inode) {
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_inc(&inode->i_writecount);
-		list_del_init(&vma->shared);
+		if (vma->vm_flags & VM_SHARED)
+			__vma_prio_tree_remove(&mapping->i_mmap_shared, vma);
+		else
+			__vma_prio_tree_remove(&mapping->i_mmap, vma);
 	}
 }

@@ -83,7 +87,8 @@ static void remove_shared_vm_struct(stru
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 		down(&mapping->i_shared_sem);
-		__remove_shared_vm_struct(vma, file->f_dentry->d_inode);
+		__remove_shared_vm_struct(vma, file->f_dentry->d_inode,
+				mapping);
 		up(&mapping->i_shared_sem);
 	}
 }
@@ -257,10 +262,10 @@ static inline void __vma_link_file(struc
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&file->f_dentry->d_inode->i_writecount);

-		if (vma->vm_flags & VM_SHARED)
-			list_add_tail(&vma->shared, &mapping->i_mmap_shared);
-		else
-			list_add_tail(&vma->shared, &mapping->i_mmap);
+		if (vma->vm_flags & VM_SHARED)
+			__vma_prio_tree_insert(&mapping->i_mmap_shared, vma);
+		else
+			__vma_prio_tree_insert(&mapping->i_mmap, vma);
 	}
 }

@@ -390,7 +395,9 @@ static int vma_merge(struct mm_struct *m
 {
 	spinlock_t *lock = &mm->page_table_lock;
 	struct inode *inode = file ? file->f_dentry->d_inode : NULL;
+	struct address_space *mapping = file ? file->f_mapping : NULL;
 	struct semaphore *i_shared_sem;
+	struct prio_tree_root *root = NULL;

 	/*
 	 * We later require that vma->vm_flags == vm_flags, so this tests
@@ -401,6 +408,13 @@ static int vma_merge(struct mm_struct *m

 	i_shared_sem = file ? &file->f_mapping->i_shared_sem : NULL;

+	if (mapping) {
+		if (vm_flags & VM_SHARED)
+			root = &mapping->i_mmap_shared;
+		else
+			root = &mapping->i_mmap;
+	}
+
 	if (!prev) {
 		prev = rb_entry(rb_parent, struct vm_area_struct, vm_rb);
 		goto merge_next;
@@ -421,18 +435,18 @@ static int vma_merge(struct mm_struct *m
 			need_up = 1;
 		}
 		spin_lock(lock);
-		prev->vm_end = end;

 		/*
 		 * OK, it did.  Can we now merge in the successor as well?
 		 */
 		next = prev->vm_next;
-		if (next && prev->vm_end == next->vm_start &&
+		if (next && end == next->vm_start &&
 				can_vma_merge_before(next, vm_flags, file,
 					pgoff, (end - addr) >> PAGE_SHIFT)) {
-			prev->vm_end = next->vm_end;
+			__vma_modify(root, prev, prev->vm_start,
+					next->vm_end, prev->vm_pgoff);
 			__vma_unlink(mm, next, prev);
-			__remove_shared_vm_struct(next, inode);
+			__remove_shared_vm_struct(next, inode, mapping);
 			spin_unlock(lock);
 			if (need_up)
 				up(i_shared_sem);
@@ -443,6 +457,7 @@ static int vma_merge(struct mm_struct *m
 			kmem_cache_free(vm_area_cachep, next);
 			return 1;
 		}
+		__vma_modify(root, prev, prev->vm_start, end, prev->vm_pgoff);
 		spin_unlock(lock);
 		if (need_up)
 			up(i_shared_sem);
@@ -462,8 +477,8 @@ static int vma_merge(struct mm_struct *m
 			if (file)
 				down(i_shared_sem);
 			spin_lock(lock);
-			prev->vm_start = addr;
-			prev->vm_pgoff -= (end - addr) >> PAGE_SHIFT;
+			__vma_modify(root, prev, addr, prev->vm_end,
+				prev->vm_pgoff - ((end - addr) >> PAGE_SHIFT));
 			spin_unlock(lock);
 			if (file)
 				up(i_shared_sem);
@@ -649,7 +664,7 @@ munmap_back:
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 	vma->vm_next = NULL;
-	INIT_LIST_HEAD(&vma->shared);
+	INIT_VMA_SHARED(vma);

 	if (file) {
 		error = -EINVAL;
@@ -1196,6 +1211,7 @@ int split_vma(struct mm_struct * mm, str
 {
 	struct vm_area_struct *new;
 	struct address_space *mapping = NULL;
+	struct prio_tree_root *root = NULL;

 	if (mm->map_count >= MAX_MAP_COUNT)
 		return -ENOMEM;
@@ -1207,7 +1223,7 @@ int split_vma(struct mm_struct * mm, str
 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;

-	INIT_LIST_HEAD(&new->shared);
+	INIT_VMA_SHARED(new);

 	if (new_below)
 		new->vm_end = addr;
@@ -1222,18 +1238,24 @@ int split_vma(struct mm_struct * mm, str
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);

-	if (vma->vm_file)
+	if (vma->vm_file) {
 		 mapping = vma->vm_file->f_mapping;

+		 if (vma->vm_flags & VM_SHARED)
+			 root = &mapping->i_mmap_shared;
+		 else
+			 root = &mapping->i_mmap;
+	}
+
 	if (mapping)
 		down(&mapping->i_shared_sem);
 	spin_lock(&mm->page_table_lock);

-	if (new_below) {
-		vma->vm_start = addr;
-		vma->vm_pgoff += ((addr - new->vm_start) >> PAGE_SHIFT);
-	} else
-		vma->vm_end = addr;
+	if (new_below)
+		__vma_modify(root, vma, addr, vma->vm_end,
+			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT));
+	else
+		__vma_modify(root, vma, vma->vm_start, addr, vma->vm_pgoff);

 	__insert_vm_struct(mm, new);

@@ -1406,7 +1428,7 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_pgoff = 0;
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
-	INIT_LIST_HEAD(&vma->shared);
+	INIT_VMA_SHARED(vma);

 	vma_link(mm, vma, prev, rb_link, rb_parent);

diff -puN mm/mremap.c~prio_tree_core mm/mremap.c
--- mmlinux-2.6/mm/mremap.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/mm/mremap.c	2004-03-21 16:25:01.000000000 -0500
@@ -251,7 +251,7 @@ static unsigned long move_vma(struct vm_

 		if (allocated_vma) {
 			*new_vma = *vma;
-			INIT_LIST_HEAD(&new_vma->shared);
+			INIT_VMA_SHARED(new_vma);
 			new_vma->vm_start = new_addr;
 			new_vma->vm_end = new_addr+new_len;
 			new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;
@@ -309,6 +309,8 @@ unsigned long do_mremap(unsigned long ad
 	unsigned long flags, unsigned long new_addr)
 {
 	struct vm_area_struct *vma;
+	struct address_space *mapping = NULL;
+	struct prio_tree_root *root = NULL;
 	unsigned long ret = -EINVAL;
 	unsigned long charged = 0;

@@ -416,9 +418,24 @@ unsigned long do_mremap(unsigned long ad
 		/* can we just expand the current mapping? */
 		if (max_addr - addr >= new_len) {
 			int pages = (new_len - old_len) >> PAGE_SHIFT;
+
+			if (vma->vm_file) {
+				mapping = vma->vm_file->f_mapping;
+				if (vma->vm_flags & VM_SHARED)
+					root = &mapping->i_mmap_shared;
+				else
+					root = &mapping->i_mmap;
+				down(&mapping->i_shared_sem);
+			}
+
 			spin_lock(&vma->vm_mm->page_table_lock);
-			vma->vm_end = addr + new_len;
+			__vma_modify(root, vma, vma->vm_start,
+					addr + new_len, vma->vm_pgoff);
 			spin_unlock(&vma->vm_mm->page_table_lock);
+
+			if(mapping)
+				up(&mapping->i_shared_sem);
+
 			current->mm->total_vm += pages;
 			if (vma->vm_flags & VM_LOCKED) {
 				current->mm->locked_vm += pages;
diff -puN /dev/null mm/prio_tree.c
--- /dev/null	2003-01-30 05:24:37.000000000 -0500
+++ mmlinux-2.6-jaya/mm/prio_tree.c	2004-03-21 16:25:01.000000000 -0500
@@ -0,0 +1,574 @@
+/*
+ * mm/prio_tree.c - priority search tree for mapping->i_mmap{,_shared}
+ *
+ * Copyright (C) 2004, Rajesh Venkatasubramanian <vrajesh@umich.edu>
+ *
+ * Based on the radix priority search tree proposed by Edward M. McCreight
+ * SIAM Journal of Computing, vol. 14, no.2, pages 257-276, May 1985
+ *
+ * 02Feb2004	Initial version
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/prio_tree.h>
+
+/*
+ * A clever mix of heap and radix trees forms a radix priority search tree (PST)
+ * which is useful for storing intervals, e.g, we can consider a vma as a closed
+ * interval of file pages [offset_begin, offset_end], and store all vmas that
+ * map a file in a PST. Then, using the PST, we can answer a stabbing query,
+ * i.e., selecting a set of stored intervals (vmas) that overlap with (map) a
+ * given input interval X (a set of consecutive file pages), in "O(log n + m)"
+ * time where 'log n' is the height of the PST, and 'm' is the number of stored
+ * intervals (vmas) that overlap (map) with the input interval X (the set of
+ * consecutive file pages).
+ *
+ * In our implementation, we store closed intervals of the form [radix_index,
+ * heap_index]. We assume that always radix_index <= heap_index. McCreight's PST
+ * is designed for storing intervals with unique radix indices, i.e., each
+ * interval have different radix_index. However, this limitation can be easily
+ * overcome by using the size, i.e., heap_index - radix_index, as part of the
+ * index, so we index the tree using [(radix_index,size), heap_index].
+ *
+ * When the above-mentioned indexing scheme is used, theoretically, in a 32 bit
+ * machine, the maximum height of a PST can be 64. We can use a balanced version
+ * of the priority search tree to optimize the tree height, but the balanced
+ * tree proposed by McCreight is too complex and memory-hungry for our purpose.
+ */
+
+static unsigned long index_bits_to_maxindex[BITS_PER_LONG];
+
+/*
+ * Maximum heap_index that can be stored in a PST with index_bits bits
+ */
+static inline unsigned long prio_tree_maxindex(unsigned int bits)
+{
+	return index_bits_to_maxindex[bits - 1];
+}
+
+/*
+ * Extend a priority search tree so that it can store a node with heap_index
+ * max_heap_index. In the worst case, this algorithm takes O((log n)^2).
+ * However, this function is used rarely and the common case performance is
+ * not bad.
+ */
+static struct prio_tree_node *prio_tree_expand(struct prio_tree_root *root,
+	struct prio_tree_node *node, unsigned long max_heap_index)
+{
+	struct prio_tree_node *first = NULL, *prev, *last = NULL;
+
+	if (max_heap_index > prio_tree_maxindex(root->index_bits))
+		root->index_bits++;
+
+	while (max_heap_index > prio_tree_maxindex(root->index_bits)) {
+		root->index_bits++;
+
+		if (prio_tree_empty(root))
+			continue;
+
+		if (first == NULL) {
+			first = root->prio_tree_node;
+			prio_tree_remove(root, root->prio_tree_node);
+			INIT_PRIO_TREE_NODE(first);
+			last = first;
+		}
+		else {
+			prev = last;
+			last = root->prio_tree_node;
+			prio_tree_remove(root, root->prio_tree_node);
+			INIT_PRIO_TREE_NODE(last);
+			prev->left = last;
+			last->parent = prev;
+		}
+	}
+
+	INIT_PRIO_TREE_NODE(node);
+
+	if (first) {
+		node->left = first;
+		first->parent = node;
+	}
+	else
+		last = node;
+
+	if (!prio_tree_empty(root)) {
+		last->left = root->prio_tree_node;
+		last->left->parent = last;
+	}
+
+	root->prio_tree_node = node;
+	return node;
+}
+
+/*
+ * Replace a prio_tree_node with a new node and return the old node
+ */
+static inline struct prio_tree_node *prio_tree_replace(
+	struct prio_tree_root *root, struct prio_tree_node *old,
+	struct prio_tree_node *node)
+{
+	INIT_PRIO_TREE_NODE(node);
+
+	if (prio_tree_root(old)) {
+		BUG_ON(root->prio_tree_node != old);
+		/*
+		 * We can reduce root->index_bits here. However, it is complex
+		 * and does not help much to improve performance (IMO).
+		 */
+		node->parent = node;
+		root->prio_tree_node = node;
+	}
+	else {
+		node->parent = old->parent;
+		if (old->parent->left == old)
+			old->parent->left = node;
+		else {
+			BUG_ON(old->parent->right != old);
+			old->parent->right = node;
+		}
+	}
+
+	if (!prio_tree_left_empty(old)) {
+		node->left = old->left;
+		old->left->parent = node;
+	}
+
+	if (!prio_tree_right_empty(old)) {
+		node->right = old->right;
+		old->right->parent = node;
+	}
+
+	return old;
+}
+
+#undef	swap
+#define	swap(x,y,z)	do {z = x; x = y; y = z; } while (0)
+
+/*
+ * Insert a prio_tree_node @node into a radix priority search tree @root. The
+ * algorithm typically takes O(log n) time where 'log n' is the number of bits
+ * required to represent the maximum heap_index. In the worst case, the algo
+ * can take O((log n)^2) - check prio_tree_expand.
+ *
+ * If a prior node with same radix_index and heap_index is already found in
+ * the tree, then returns the address of the prior node. Otherwise, inserts
+ * @node into the tree and returns @node.
+ */
+
+struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
+			struct prio_tree_node *node)
+{
+	struct prio_tree_node *cur, *res = node;
+	unsigned long radix_index, heap_index;
+	unsigned long r_index, h_index, index, mask;
+	int size_flag = 0;
+
+	GET_INDEX(node, radix_index, heap_index);
+
+	if (prio_tree_empty(root) ||
+			heap_index > prio_tree_maxindex(root->index_bits))
+		return prio_tree_expand(root, node, heap_index);
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
+		{
+			struct prio_tree_node *tmp = node;
+			node = prio_tree_replace(root, cur, node);
+			cur = tmp;
+			swap(r_index, radix_index, index);
+			swap(h_index, heap_index, index);
+		}
+
+		if (size_flag)
+			index = heap_index - radix_index;
+		else
+			index = radix_index;
+
+		if (index & mask) {
+			if (prio_tree_right_empty(cur)) {
+				INIT_PRIO_TREE_NODE(node);
+				cur->right = node;
+				node->parent = cur;
+				return res;
+			}
+			else
+				cur = cur->right;
+		}
+		else {
+			if (prio_tree_left_empty(cur)) {
+				INIT_PRIO_TREE_NODE(node);
+				cur->left = node;
+				node->parent = cur;
+				return res;
+			}
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
+/*
+ * Remove a prio_tree_node @node from a radix priority search tree @root. The
+ * algorithm takes O(log n) time where 'log n' is the number of bits required
+ * to represent the maximum heap_index.
+ */
+
+void prio_tree_remove(struct prio_tree_root *root, struct prio_tree_node *node)
+{
+	struct prio_tree_node *cur;
+	unsigned long r_index, h_index_right, h_index_left;
+
+	cur = node;
+
+	while (!prio_tree_left_empty(cur) || !prio_tree_right_empty(cur)) {
+		if (!prio_tree_left_empty(cur))
+			GET_INDEX(cur->left, r_index, h_index_left);
+		else {
+			cur = cur->right;
+			continue;
+		}
+
+		if (!prio_tree_right_empty(cur))
+			GET_INDEX(cur->right, r_index, h_index_right);
+		else {
+			cur = cur->left;
+			continue;
+		}
+
+		/* both h_index_left and h_index_right cannot be 0 */
+		if (h_index_left >= h_index_right)
+			cur = cur->left;
+		else
+			cur = cur->right;
+	}
+
+	if (prio_tree_root(cur)) {
+		BUG_ON(root->prio_tree_node != cur);
+		*root = PRIO_TREE_ROOT;
+		return;
+	}
+
+	if (cur->parent->right == cur)
+		cur->parent->right = cur->parent;
+	else {
+		BUG_ON(cur->parent->left != cur);
+		cur->parent->left = cur->parent;
+	}
+
+	while (cur != node)
+		cur = prio_tree_replace(root, cur->parent, cur);
+
+	return;
+}
+
+/*
+ * Following functions help to enumerate all prio_tree_nodes in the tree that
+ * overlap with the input interval X [radix_index, heap_index]. The enumeration
+ * takes O(log n + m) time where 'log n' is the height of the tree (which is
+ * proportional to # of bits required to represent the maximum heap_index) and
+ * 'm' is the number of prio_tree_nodes that overlap the interval X.
+ */
+
+static inline struct prio_tree_node *__prio_tree_left(
+	struct prio_tree_root *root, struct prio_tree_iter *iter,
+	unsigned long radix_index, unsigned long heap_index,
+	unsigned long *r_index, unsigned long *h_index)
+{
+	if (prio_tree_left_empty(iter->cur))
+		return NULL;
+
+	GET_INDEX(iter->cur->left, *r_index, *h_index);
+
+	if (radix_index <= *h_index) {
+		iter->cur = iter->cur->left;
+		iter->mask >>= 1;
+		if (iter->mask) {
+			if (iter->size_level)
+				iter->size_level++;
+		}
+		else {
+			iter->size_level = 1;
+			iter->mask = 1UL << (root->index_bits - 1);
+		}
+		return iter->cur;
+	}
+
+	return NULL;
+}
+
+
+static inline struct prio_tree_node *__prio_tree_right(
+	struct prio_tree_root *root, struct prio_tree_iter *iter,
+	unsigned long radix_index, unsigned long heap_index,
+	unsigned long *r_index, unsigned long *h_index)
+{
+	unsigned long value;
+
+	if (prio_tree_right_empty(iter->cur))
+		return NULL;
+
+	if (iter->size_level)
+		value = iter->value;
+	else
+		value = iter->value | iter->mask;
+
+	if (heap_index < value)
+		return NULL;
+
+	GET_INDEX(iter->cur->right, *r_index, *h_index);
+
+	if (radix_index <= *h_index) {
+		iter->cur = iter->cur->right;
+		iter->mask >>= 1;
+		iter->value = value;
+		if (iter->mask) {
+			if (iter->size_level)
+				iter->size_level++;
+		}
+		else {
+			iter->size_level = 1;
+			iter->mask = 1UL << (root->index_bits - 1);
+		}
+		return iter->cur;
+	}
+
+	return NULL;
+}
+
+static inline struct prio_tree_node *__prio_tree_parent(
+	struct prio_tree_iter *iter)
+{
+	iter->cur = iter->cur->parent;
+	iter->mask <<= 1;
+	if (iter->size_level) {
+		if (iter->size_level == 1)
+			iter->mask = 1UL;
+		iter->size_level--;
+	}
+	else if (iter->value & iter->mask)
+		iter->value ^= iter->mask;
+	return iter->cur;
+}
+
+static inline int overlap(unsigned long radix_index, unsigned long heap_index,
+	unsigned long r_index, unsigned long h_index)
+{
+	if (heap_index < r_index || radix_index > h_index)
+		return 0;
+
+	return 1;
+}
+
+/*
+ * prio_tree_first:
+ *
+ * Get the first prio_tree_node that overlaps with the interval [radix_index,
+ * heap_index]. Note that always radix_index <= heap_index. We do a pre-order
+ * traversal of the tree.
+ */
+struct prio_tree_node *prio_tree_first(struct prio_tree_root *root,
+	struct prio_tree_iter *iter, unsigned long radix_index,
+	unsigned long heap_index)
+{
+	unsigned long r_index, h_index;
+
+	*iter = PRIO_TREE_ITER;
+
+	if (prio_tree_empty(root))
+		return NULL;
+
+	GET_INDEX(root->prio_tree_node, r_index, h_index);
+
+	if (radix_index > h_index)
+		return NULL;
+
+	iter->mask = 1UL << (root->index_bits - 1);
+	iter->cur = root->prio_tree_node;
+
+	while (1) {
+		if (overlap(radix_index, heap_index, r_index, h_index))
+			return iter->cur;
+
+		if (__prio_tree_left(root, iter, radix_index, heap_index,
+					&r_index, &h_index))
+			continue;
+
+		if (__prio_tree_right(root, iter, radix_index, heap_index,
+					&r_index, &h_index))
+			continue;
+
+		break;
+	}
+	return NULL;
+}
+
+/* Get the next prio_tree_node that overlaps with the input interval in iter */
+struct prio_tree_node *prio_tree_next(struct prio_tree_root *root,
+	struct prio_tree_iter *iter, unsigned long radix_index,
+	unsigned long heap_index)
+{
+	unsigned long r_index, h_index;
+
+repeat:
+	while (__prio_tree_left(root, iter, radix_index, heap_index,
+				&r_index, &h_index))
+		if (overlap(radix_index, heap_index, r_index, h_index))
+			return iter->cur;
+
+	while (!__prio_tree_right(root, iter, radix_index, heap_index,
+				&r_index, &h_index)) {
+	    	while (!prio_tree_root(iter->cur) &&
+				iter->cur->parent->right == iter->cur)
+			__prio_tree_parent(iter);
+
+		if (prio_tree_root(iter->cur))
+			return NULL;
+
+		__prio_tree_parent(iter);
+	}
+
+	if (overlap(radix_index, heap_index, r_index, h_index))
+			return iter->cur;
+
+	goto repeat;
+}
+
+/*
+ * Radix priority search tree for address_space->i_mmap_{_shared}
+ *
+ * For each vma that map a unique set of file pages i.e., unique [radix_index,
+ * heap_index] value, we have a corresponing priority search tree node. If
+ * multiple vmas have identical [radix_index, heap_index] value, then one of
+ * them is used as a tree node and others are stored in a vm_set list. The tree
+ * node points to the first vma (head) of the list using vm_set_head.
+ *
+ * prio_tree_root
+ *      |
+ *      A       vm_set_head
+ *     / \      /
+ *    L   R -> H-I-J-K-M-N-O-P-Q-S
+ *    ^   ^    <-- vm_set.list -->
+ *  tree nodes
+ *
+ * We need some way to identify whether a vma is a tree node, head of a vm_set
+ * list, or just a member of a vm_set list. We cannot use vm_flags to store
+ * such information. The reason is, in the above figure, it is possible that
+ * vm_flags' of R and H are covered by the different mmap_sems. When R is
+ * removed under R->mmap_sem, H replaces R as a tree node. Since we do not hold
+ * H->mmap_sem, we cannot use H->vm_flags for marking that H is a tree node now.
+ * That's why some trick involving shared.both.parent is used for identifying
+ * tree nodes and list head nodes. We can possibly use the least significant
+ * bit of the vm_set_head field to mark tree and list head nodes. I was worried
+ * about the alignment of vm_area_struct in various architectures.
+ *
+ * vma radix priority search tree node rules:
+ *
+ * vma->shared.both.parent != NULL	==>	a tree node
+ *
+ * vma->shared.both.parent == NULL
+ * 	vma->vm_set_head != NULL  ==>  list head of vmas that map same pages
+ * 	vma->vm_set_head == NULL  ==>  a list node
+ */
+
+void __vma_prio_tree_insert(struct prio_tree_root *root,
+	struct vm_area_struct *vma)
+{
+	struct prio_tree_node *ptr;
+	struct vm_area_struct *old;
+
+	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
+
+	if (ptr == &vma->shared.prio_tree_node) {
+		vma->vm_set_head = NULL;
+		return;
+	}
+
+	old = prio_tree_entry(ptr, struct vm_area_struct,
+			shared.prio_tree_node);
+
+	__vma_prio_tree_add(vma, old);
+}
+
+void __vma_prio_tree_remove(struct prio_tree_root *root,
+	struct vm_area_struct *vma)
+{
+	struct vm_area_struct *node, *head, *new_head;
+
+	if (vma->shared.both.parent == NULL && vma->vm_set_head == NULL) {
+		list_del_init(&vma->shared.vm_set.list);
+		INIT_VMA_SHARED(vma);
+		return;
+	}
+
+	if (vma->vm_set_head) {
+		/* Leave this BUG_ON till prio_tree patch stabilizes */
+		BUG_ON(vma->vm_set_head->vm_set_head != vma);
+		if (vma->shared.both.parent) {
+			head = vma->vm_set_head;
+			if (!list_empty(&head->shared.vm_set.list)) {
+				new_head = list_entry(
+					head->shared.vm_set.list.next,
+					struct vm_area_struct,
+					shared.vm_set.list);
+				list_del_init(&head->shared.vm_set.list);
+			}
+			else
+				new_head = NULL;
+
+			prio_tree_replace(root, &vma->shared.prio_tree_node,
+					&head->shared.prio_tree_node);
+			head->vm_set_head = new_head;
+			if (new_head)
+				new_head->vm_set_head = head;
+
+		}
+		else {
+			node = vma->vm_set_head;
+			if (!list_empty(&vma->shared.vm_set.list)) {
+				new_head = list_entry(
+					vma->shared.vm_set.list.next,
+					struct vm_area_struct,
+					shared.vm_set.list);
+				list_del_init(&vma->shared.vm_set.list);
+				node->vm_set_head = new_head;
+				new_head->vm_set_head = node;
+			}
+			else
+				node->vm_set_head = NULL;
+		}
+		INIT_VMA_SHARED(vma);
+		return;
+	}
+
+	prio_tree_remove(root, &vma->shared.prio_tree_node);
+	INIT_VMA_SHARED(vma);
+}
+
+void __init prio_tree_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(index_bits_to_maxindex) - 1; i++)
+		index_bits_to_maxindex[i] = (1UL << (i + 1)) - 1;
+	index_bits_to_maxindex[ARRAY_SIZE(index_bits_to_maxindex) - 1] = ~0UL;
+}
diff -puN mm/shmem.c~prio_tree_core mm/shmem.c
--- mmlinux-2.6/mm/shmem.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/mm/shmem.c	2004-03-21 16:25:01.000000000 -0500
@@ -1328,7 +1328,7 @@ static void do_shmem_file_read(struct fi
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (!list_empty(&mapping->i_mmap_shared))
+			if (!prio_tree_empty(&mapping->i_mmap_shared))
 				flush_dcache_page(page);
 			/*
 			 * Mark the page accessed if we read the beginning.
diff -puN mm/swap_state.c~prio_tree_core mm/swap_state.c
--- mmlinux-2.6/mm/swap_state.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/mm/swap_state.c	2004-03-21 16:25:01.000000000 -0500
@@ -32,8 +32,8 @@ struct address_space swapper_space = {
 	.locked_pages	= LIST_HEAD_INIT(swapper_space.locked_pages),
 	.a_ops		= &swap_aops,
 	.backing_dev_info = &swap_backing_dev_info,
-	.i_mmap		= LIST_HEAD_INIT(swapper_space.i_mmap),
-	.i_mmap_shared	= LIST_HEAD_INIT(swapper_space.i_mmap_shared),
+	.i_mmap		= PRIO_TREE_ROOT_INIT,
+	.i_mmap_shared	= PRIO_TREE_ROOT_INIT,
 	.i_shared_sem	= __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
 	.truncate_count  = ATOMIC_INIT(0),
 	.private_lock	= SPIN_LOCK_UNLOCKED,
diff -puN mm/vmscan.c~prio_tree_core mm/vmscan.c
--- mmlinux-2.6/mm/vmscan.c~prio_tree_core	2004-03-21 16:25:01.000000000 -0500
+++ mmlinux-2.6-jaya/mm/vmscan.c	2004-03-21 16:25:01.000000000 -0500
@@ -191,9 +191,9 @@ static inline int page_mapping_inuse(str
 		return 1;

 	/* File is mmap'd by somebody. */
-	if (!list_empty(&mapping->i_mmap))
+	if (!prio_tree_empty(&mapping->i_mmap))
 		return 1;
-	if (!list_empty(&mapping->i_mmap_shared))
+	if (!prio_tree_empty(&mapping->i_mmap_shared))
 		return 1;

 	return 0;

_

