Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264536AbUD1AKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbUD1AKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUD1AKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:10:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:62911 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264534AbUD1ADc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:03:32 -0400
Date: Wed, 28 Apr 2004 01:03:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 17 real prio_tree
In-Reply-To: <Pine.LNX.4.44.0404280055270.2444-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404280102420.2444-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian's implementation  of a radix priority search
tree of vmas, to handle object-based reverse mapping corner cases well.

Amongst the objections to object-based rmap were test cases by akpm and
by mingo, in which large numbers of vmas mapping disjoint or overlapping
parts of a file showed strikingly poor performance of the i_mmap lists.
Perhaps those tests are irrelevant in the real world?  We cannot be too
sure: the prio_tree is well-suited to solving precisely that problem,
so unless it turns out to bring too much overhead, let's include it.

Why is this prio_tree.c placed in mm rather than lib?  See GET_INDEX:
this implementation is geared throughout to use with vmas, though the
first half of the file appears more general than the second half.

Each node of the prio_tree is itself (contained within) a vma: might
save memory by allocating distinct nodes from which to hang vmas, but
wouldn't save much, and would complicate the usage with preallocations.
Off each node of the prio_tree itself hangs a list of like vmas, if any.

The connection from node to list is a little awkward, but probably the
best compromise: it would be more straightforward to list likes directly
from the tree node, but that would use more memory per vma, for the
list_head and to identify that head.  Instead, node's shared.vm_set.head
points to next vma (whose shared.vm_set.head points back to node vma),
and that next contains the list_head from which the rest hang - reusing
fields already used in the prio_tree node itself.

Currently lacks prefetch: Rajesh hopes to add some soon.

 include/linux/mm.h        |   37 +-
 include/linux/prio_tree.h |   57 +++-
 init/main.c               |    2 
 mm/Makefile               |    5 
 mm/mmap.c                 |   25 -
 mm/prio_tree.c            |  654 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 723 insertions(+), 57 deletions(-)

--- rmap16/include/linux/mm.h	2004-04-27 19:18:42.775736040 +0100
+++ rmap17/include/linux/mm.h	2004-04-27 19:18:54.262989712 +0100
@@ -72,7 +72,15 @@ struct vm_area_struct {
 	 * For areas with an address space and backing store,
 	 * one of the address_space->i_mmap{,shared} trees.
 	 */
-	struct list_head shared;
+	union {
+		struct {
+			struct list_head list;
+			void *parent;	/* aligns with prio_tree_node parent */
+			struct vm_area_struct *head;
+		} vm_set;
+
+		struct prio_tree_node prio_tree_node;
+	} shared;
 
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
@@ -553,27 +561,16 @@ extern void si_meminfo_node(struct sysin
 
 static inline void vma_prio_tree_init(struct vm_area_struct *vma)
 {
-	INIT_LIST_HEAD(&vma->shared);
-}
-
-static inline void vma_prio_tree_add(struct vm_area_struct *vma,
-				     struct vm_area_struct *old)
-{
-	list_add(&vma->shared, &old->shared);
-}
-
-static inline void vma_prio_tree_insert(struct vm_area_struct *vma,
-					struct prio_tree_root *root)
-{
-	list_add_tail(&vma->shared, &root->list);
-}
-
-static inline void vma_prio_tree_remove(struct vm_area_struct *vma,
-					struct prio_tree_root *root)
-{
-	list_del_init(&vma->shared);
+	vma->shared.vm_set.list.next = NULL;
+	vma->shared.vm_set.list.prev = NULL;
+	vma->shared.vm_set.parent = NULL;
+	vma->shared.vm_set.head = NULL;
 }
 
+/* prio_tree.c */
+void vma_prio_tree_add(struct vm_area_struct *, struct vm_area_struct *old);
+void vma_prio_tree_insert(struct vm_area_struct *, struct prio_tree_root *);
+void vma_prio_tree_remove(struct vm_area_struct *, struct prio_tree_root *);
 struct vm_area_struct *vma_prio_tree_next(
 	struct vm_area_struct *, struct prio_tree_root *,
 	struct prio_tree_iter *, pgoff_t begin, pgoff_t end);
--- rmap16/include/linux/prio_tree.h	2004-04-27 19:18:42.776735888 +0100
+++ rmap17/include/linux/prio_tree.h	2004-04-27 19:18:54.264989408 +0100
@@ -1,27 +1,64 @@
 #ifndef _LINUX_PRIO_TREE_H
 #define _LINUX_PRIO_TREE_H
-/*
- * Dummy version of include/linux/prio_tree.h, just for this patch:
- * no radix priority search tree whatsoever, just implement interfaces
- * using the old lists.
- */
+
+struct prio_tree_node {
+	struct prio_tree_node	*left;
+	struct prio_tree_node	*right;
+	struct prio_tree_node	*parent;
+};
 
 struct prio_tree_root {
-	struct list_head	list;
+	struct prio_tree_node	*prio_tree_node;
+	unsigned int 		index_bits;
 };
 
 struct prio_tree_iter {
-	int			not_used_yet;
+	struct prio_tree_node	*cur;
+	unsigned long		mask;
+	unsigned long		value;
+	int			size_level;
 };
 
 #define INIT_PRIO_TREE_ROOT(ptr)	\
 do {					\
-	INIT_LIST_HEAD(&(ptr)->list);	\
-} while (0)				\
+	(ptr)->prio_tree_node = NULL;	\
+	(ptr)->index_bits = 1;		\
+} while (0)
+
+#define INIT_PRIO_TREE_NODE(ptr)				\
+do {								\
+	(ptr)->left = (ptr)->right = (ptr)->parent = (ptr);	\
+} while (0)
+
+#define INIT_PRIO_TREE_ITER(ptr)	\
+do {					\
+	(ptr)->cur = NULL;		\
+	(ptr)->mask = 0UL;		\
+	(ptr)->value = 0UL;		\
+	(ptr)->size_level = 0;		\
+} while (0)
+
+#define prio_tree_entry(ptr, type, member) \
+       ((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
 
 static inline int prio_tree_empty(const struct prio_tree_root *root)
 {
-	return list_empty(&root->list);
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
 }
 
 #endif /* _LINUX_PRIO_TREE_H */
--- rmap16/init/main.c	2004-04-26 12:39:46.693108928 +0100
+++ rmap17/init/main.c	2004-04-27 19:18:54.265989256 +0100
@@ -88,6 +88,7 @@ extern void signals_init(void);
 extern void buffer_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);
+extern void prio_tree_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
 extern void populate_rootfs(void);
@@ -523,6 +524,7 @@ asmlinkage void __init start_kernel(void
 	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
+	prio_tree_init();
 #ifdef CONFIG_X86
 	if (efi_enabled)
 		efi_enter_virtual_mode();
--- rmap16/mm/Makefile	2004-04-26 12:39:46.941071232 +0100
+++ rmap17/mm/Makefile	2004-04-27 19:18:54.266989104 +0100
@@ -8,8 +8,9 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 			   shmem.o vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
-			   page_alloc.o page-writeback.o pdflush.o readahead.o \
-			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
+			   page_alloc.o page-writeback.o pdflush.o prio_tree.o \
+			   readahead.o slab.o swap.o truncate.o vmscan.o \
+			   $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
--- rmap16/mm/mmap.c	2004-04-27 19:18:42.784734672 +0100
+++ rmap17/mm/mmap.c	2004-04-27 19:18:54.268988800 +0100
@@ -321,31 +321,6 @@ __insert_vm_struct(struct mm_struct * mm
 }
 
 /*
- * Dummy version of vma_prio_tree_next, just for this patch:
- * no radix priority search tree whatsoever, just implement interface
- * using the old lists: return the next vma overlapping [begin,end].
- */
-struct vm_area_struct *vma_prio_tree_next(
-	struct vm_area_struct *vma, struct prio_tree_root *root,
-	struct prio_tree_iter *iter, pgoff_t begin, pgoff_t end)
-{
-	struct list_head *next;
-	pgoff_t vba, vea;
-
-	next = vma? vma->shared.next: root->list.next;
-	while (next != &root->list) {
-		vma = list_entry(next, struct vm_area_struct, shared);
-		vba = vma->vm_pgoff;
-		vea = vba + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) - 1;
-		/* Return vma if it overlaps [begin,end] */
-		if (vba <= end && vea >= begin)
-			return vma;
-		next = next->next;
-	}
-	return NULL;
-}
-
-/*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that is
  * already present in an i_mmap{_shared} tree without adjusting the tree.
  * The following helper function should be used when such adjustments
--- rmap16/mm/prio_tree.c	1970-01-01 01:00:00.000000000 +0100
+++ rmap17/mm/prio_tree.c	2004-04-27 19:18:54.272988192 +0100
@@ -0,0 +1,654 @@
+/*
+ * mm/prio_tree.c - priority search tree for mapping->i_mmap{,_shared}
+ *
+ * Copyright (C) 2004, Rajesh Venkatasubramanian <vrajesh@umich.edu>
+ *
+ * This file is released under the GPL v2.
+ *
+ * Based on the radix priority search tree proposed by Edward M. McCreight
+ * SIAM Journal of Computing, vol. 14, no.2, pages 257-276, May 1985
+ *
+ * 02Feb2004	Initial version
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
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
+/*
+ * The following macros are used for implementing prio_tree for i_mmap{_shared}
+ */
+
+#define RADIX_INDEX(vma)  ((vma)->vm_pgoff)
+#define VMA_SIZE(vma)	  (((vma)->vm_end - (vma)->vm_start) >> PAGE_SHIFT)
+/* avoid overflow */
+#define HEAP_INDEX(vma)	  ((vma)->vm_pgoff + (VMA_SIZE(vma) - 1))
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
+static unsigned long index_bits_to_maxindex[BITS_PER_LONG];
+
+void __init prio_tree_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(index_bits_to_maxindex) - 1; i++)
+		index_bits_to_maxindex[i] = (1UL << (i + 1)) - 1;
+	index_bits_to_maxindex[ARRAY_SIZE(index_bits_to_maxindex) - 1] = ~0UL;
+}
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
+		struct prio_tree_node *node, unsigned long max_heap_index)
+{
+	static void prio_tree_remove(struct prio_tree_root *,
+					struct prio_tree_node *);
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
+		} else {
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
+	} else
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
+static struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root,
+		struct prio_tree_node *old, struct prio_tree_node *node)
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
+	} else {
+		node->parent = old->parent;
+		if (old->parent->left == old)
+			old->parent->left = node;
+		else
+			old->parent->right = node;
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
+static struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
+		struct prio_tree_node *node)
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
+                if (h_index < heap_index ||
+		    (h_index == heap_index && r_index > radix_index)) {
+			struct prio_tree_node *tmp = node;
+			node = prio_tree_replace(root, cur, node);
+			cur = tmp;
+			/* swap indices */
+			index = r_index;
+			r_index = radix_index;
+			radix_index = index;
+			index = h_index;
+			h_index = heap_index;
+			heap_index = index;
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
+			} else
+				cur = cur->right;
+		} else {
+			if (prio_tree_left_empty(cur)) {
+				INIT_PRIO_TREE_NODE(node);
+				cur->left = node;
+				node->parent = cur;
+				return res;
+			} else
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
+static void prio_tree_remove(struct prio_tree_root *root,
+		struct prio_tree_node *node)
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
+		INIT_PRIO_TREE_ROOT(root);
+		return;
+	}
+
+	if (cur->parent->right == cur)
+		cur->parent->right = cur->parent;
+	else
+		cur->parent->left = cur->parent;
+
+	while (cur != node)
+		cur = prio_tree_replace(root, cur->parent, cur);
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
+static struct prio_tree_node *prio_tree_left(
+		struct prio_tree_root *root, struct prio_tree_iter *iter,
+		unsigned long radix_index, unsigned long heap_index,
+		unsigned long *r_index, unsigned long *h_index)
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
+		} else {
+			if (iter->size_level) {
+				BUG_ON(!prio_tree_left_empty(iter->cur));
+				BUG_ON(!prio_tree_right_empty(iter->cur));
+				iter->size_level++;
+				iter->mask = ULONG_MAX;
+			} else {
+				iter->size_level = 1;
+				iter->mask = 1UL << (root->index_bits - 1);
+			}
+		}
+		return iter->cur;
+	}
+
+	return NULL;
+}
+
+static struct prio_tree_node *prio_tree_right(
+		struct prio_tree_root *root, struct prio_tree_iter *iter,
+		unsigned long radix_index, unsigned long heap_index,
+		unsigned long *r_index, unsigned long *h_index)
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
+		} else {
+			if (iter->size_level) {
+				BUG_ON(!prio_tree_left_empty(iter->cur));
+				BUG_ON(!prio_tree_right_empty(iter->cur));
+				iter->size_level++;
+				iter->mask = ULONG_MAX;
+			} else {
+				iter->size_level = 1;
+				iter->mask = 1UL << (root->index_bits - 1);
+			}
+		}
+		return iter->cur;
+	}
+
+	return NULL;
+}
+
+static struct prio_tree_node *prio_tree_parent(struct prio_tree_iter *iter)
+{
+	iter->cur = iter->cur->parent;
+	if (iter->mask == ULONG_MAX)
+		iter->mask = 1UL;
+	else if (iter->size_level == 1)
+		iter->mask = 1UL;
+	else
+		iter->mask <<= 1;
+	if (iter->size_level)
+		iter->size_level--;
+	if (!iter->size_level && (iter->value & iter->mask))
+		iter->value ^= iter->mask;
+	return iter->cur;
+}
+
+static inline int overlap(unsigned long radix_index, unsigned long heap_index,
+		unsigned long r_index, unsigned long h_index)
+{
+	return heap_index >= r_index && radix_index <= h_index;
+}
+
+/*
+ * prio_tree_first:
+ *
+ * Get the first prio_tree_node that overlaps with the interval [radix_index,
+ * heap_index]. Note that always radix_index <= heap_index. We do a pre-order
+ * traversal of the tree.
+ */
+static struct prio_tree_node *prio_tree_first(struct prio_tree_root *root,
+		struct prio_tree_iter *iter, unsigned long radix_index,
+		unsigned long heap_index)
+{
+	unsigned long r_index, h_index;
+
+	INIT_PRIO_TREE_ITER(iter);
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
+		if (prio_tree_left(root, iter, radix_index, heap_index,
+					&r_index, &h_index))
+			continue;
+
+		if (prio_tree_right(root, iter, radix_index, heap_index,
+					&r_index, &h_index))
+			continue;
+
+		break;
+	}
+	return NULL;
+}
+
+/*
+ * prio_tree_next:
+ *
+ * Get the next prio_tree_node that overlaps with the input interval in iter
+ */
+static struct prio_tree_node *prio_tree_next(struct prio_tree_root *root,
+		struct prio_tree_iter *iter, unsigned long radix_index,
+		unsigned long heap_index)
+{
+	unsigned long r_index, h_index;
+
+repeat:
+	while (prio_tree_left(root, iter, radix_index,
+				heap_index, &r_index, &h_index)) {
+		if (overlap(radix_index, heap_index, r_index, h_index))
+			return iter->cur;
+	}
+
+	while (!prio_tree_right(root, iter, radix_index,
+				heap_index, &r_index, &h_index)) {
+	    	while (!prio_tree_root(iter->cur) &&
+				iter->cur->parent->right == iter->cur)
+			prio_tree_parent(iter);
+
+		if (prio_tree_root(iter->cur))
+			return NULL;
+
+		prio_tree_parent(iter);
+	}
+
+	if (overlap(radix_index, heap_index, r_index, h_index))
+		return iter->cur;
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
+ * node points to the first vma (head) of the list using vm_set.head.
+ *
+ * prio_tree_root
+ *      |
+ *      A       vm_set.head
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
+ * That's why some trick involving shared.vm_set.parent is used for identifying
+ * tree nodes and list head nodes.
+ *
+ * vma radix priority search tree node rules:
+ *
+ * vma->shared.vm_set.parent != NULL    ==> a tree node
+ *      vma->shared.vm_set.head != NULL ==> list of others mapping same range
+ *      vma->shared.vm_set.head == NULL ==> no others map the same range      
+ *
+ * vma->shared.vm_set.parent == NULL
+ * 	vma->shared.vm_set.head != NULL ==> list head of vmas mapping same range
+ * 	vma->shared.vm_set.head == NULL ==> a list node
+ */
+
+/*
+ * Add a new vma known to map the same set of pages as the old vma:
+ * useful for fork's dup_mmap as well as vma_prio_tree_insert below.
+ */
+void vma_prio_tree_add(struct vm_area_struct *vma, struct vm_area_struct *old)
+{
+	/* Leave these BUG_ONs till prio_tree patch stabilizes */
+	BUG_ON(RADIX_INDEX(vma) != RADIX_INDEX(old));
+	BUG_ON(HEAP_INDEX(vma) != HEAP_INDEX(old));
+
+	if (!old->shared.vm_set.parent)
+		list_add(&vma->shared.vm_set.list,
+				&old->shared.vm_set.list);
+	else if (old->shared.vm_set.head)
+		list_add_tail(&vma->shared.vm_set.list,
+				&old->shared.vm_set.head->shared.vm_set.list);
+	else {
+		INIT_LIST_HEAD(&vma->shared.vm_set.list);
+		vma->shared.vm_set.head = old;
+		old->shared.vm_set.head = vma;
+	}
+}
+
+void vma_prio_tree_insert(struct vm_area_struct *vma,
+			  struct prio_tree_root *root)
+{
+	struct prio_tree_node *ptr;
+	struct vm_area_struct *old;
+
+	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
+	if (ptr != &vma->shared.prio_tree_node) {
+		old = prio_tree_entry(ptr, struct vm_area_struct,
+					shared.prio_tree_node);
+		vma_prio_tree_add(vma, old);
+	}
+}
+
+void vma_prio_tree_remove(struct vm_area_struct *vma,
+			  struct prio_tree_root *root)
+{
+	struct vm_area_struct *node, *head, *new_head;
+
+	if (!vma->shared.vm_set.head) {
+		if (!vma->shared.vm_set.parent)
+			list_del_init(&vma->shared.vm_set.list);
+		else
+			prio_tree_remove(root, &vma->shared.prio_tree_node);
+	} else {
+		/* Leave this BUG_ON till prio_tree patch stabilizes */
+		BUG_ON(vma->shared.vm_set.head->shared.vm_set.head != vma);
+		if (vma->shared.vm_set.parent) {
+			head = vma->shared.vm_set.head;
+			if (!list_empty(&head->shared.vm_set.list)) {
+				new_head = list_entry(
+					head->shared.vm_set.list.next,
+					struct vm_area_struct,
+					shared.vm_set.list);
+				list_del_init(&head->shared.vm_set.list);
+			} else
+				new_head = NULL;
+
+			prio_tree_replace(root, &vma->shared.prio_tree_node,
+					&head->shared.prio_tree_node);
+			head->shared.vm_set.head = new_head;
+			if (new_head)
+				new_head->shared.vm_set.head = head;
+
+		} else {
+			node = vma->shared.vm_set.head;
+			if (!list_empty(&vma->shared.vm_set.list)) {
+				new_head = list_entry(
+					vma->shared.vm_set.list.next,
+					struct vm_area_struct,
+					shared.vm_set.list);
+				list_del_init(&vma->shared.vm_set.list);
+				node->shared.vm_set.head = new_head;
+				new_head->shared.vm_set.head = node;
+			} else
+				node->shared.vm_set.head = NULL;
+		}
+	}
+}
+
+/*
+ * Helper function to enumerate vmas that map a given file page or a set of
+ * contiguous file pages. The function returns vmas that at least map a single
+ * page in the given range of contiguous file pages.
+ */
+struct vm_area_struct *vma_prio_tree_next(struct vm_area_struct *vma,
+		struct prio_tree_root *root, struct prio_tree_iter *iter,
+		pgoff_t begin, pgoff_t end)
+{
+	struct prio_tree_node *ptr;
+	struct vm_area_struct *next;
+
+	if (!vma) {
+		/*
+		 * First call is with NULL vma
+		 */
+		ptr = prio_tree_first(root, iter, begin, end);
+		if (ptr)
+			return prio_tree_entry(ptr, struct vm_area_struct,
+						shared.prio_tree_node);
+		else
+			return NULL;
+	}
+
+	if (vma->shared.vm_set.parent) {
+		if (vma->shared.vm_set.head)
+			return vma->shared.vm_set.head;
+	} else {
+		next = list_entry(vma->shared.vm_set.list.next,
+				struct vm_area_struct, shared.vm_set.list);
+		if (!next->shared.vm_set.head)
+			return next;
+	}
+
+	ptr = prio_tree_next(root, iter, begin, end);
+	if (ptr)
+		return prio_tree_entry(ptr, struct vm_area_struct,
+					shared.prio_tree_node);
+	else
+		return NULL;
+}
+EXPORT_SYMBOL(vma_prio_tree_next);

