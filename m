Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbUKQAI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUKQAI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbUKQAHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:07:42 -0500
Received: from almesberger.net ([63.105.73.238]:50439 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261905AbUKPXvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:51:53 -0500
Date: Tue, 16 Nov 2004 20:51:35 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Generalize prio_tree, 2nd try
Message-ID: <20041116205135.Y28802@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0411151814440.6691@lazuli.engin.umich.edu>; from vrajesh@umich.edu on Mon, Nov 15, 2004 at 07:07:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajesh,

this patch (for 2.6.9) implements roughly what we've discussed yesterday.
The main difference is that I didn't nest the two node structures, but
put them in parallel. This avoids a zillion trivial changes when making
this change, and another zillion un-changes when vma_* switches to the
non-raw structure.

The vma_ functions use wrappers to cast between the two types of
structures. Not necessarily the most beautiful way of doing things, but
again, that's hopefully just transitional.

Unlike the patch sent yesterday, this patch leaves everything in
mm/prio_tree.c, to make it easier to see the differences. Moving the
non-vma code to lib/ will be trivial, and there's no hurry for that.

I've also left out the debugging functions. I'll update them later.

I've tested the patch only very lightly under UML. Is there any good VMA
exerciser around that will yield meaningful results on a desktop PC, or
should I just leave the benchmarking to the guys with the big irons ?

Thanks,
- Werner

---------------------------------- cut here -----------------------------------

--- linux-2.6.9-orig/include/linux/prio_tree.h	Mon Oct 18 18:54:08 2004
+++ linux-2.6.9/include/linux/prio_tree.h	Tue Nov 16 20:07:43 2004
@@ -1,15 +1,38 @@
 #ifndef _LINUX_PRIO_TREE_H
 #define _LINUX_PRIO_TREE_H
 
+/*
+ * K&R 2nd ed. A8.3 somewhat obliquely hints that initial sequences of struct
+ * fields with identical types should end up at the same location. We'll use
+ * this until we can scrap struct raw_prio_tree_node.
+ *
+ * Note: all this could be dome more elegantly by using unnamed union/struct
+ * fields. However, gcc 2.95.3 and apparently also gcc 3.0.4 don't support this
+ * language extension.
+ */
+
+struct raw_prio_tree_node {
+	struct prio_tree_node	*left;
+	struct prio_tree_node	*right;
+	struct prio_tree_node	*parent;
+};
+
 struct prio_tree_node {
 	struct prio_tree_node	*left;
 	struct prio_tree_node	*right;
 	struct prio_tree_node	*parent;
+	unsigned long		start;
+	unsigned long		end;
 };
 
 struct prio_tree_root {
 	struct prio_tree_node	*prio_tree_node;
-	unsigned int 		index_bits;
+	unsigned short 		index_bits;
+	unsigned short		raw;
+		/*
+		 * 0: nodes are of type struct prio_tree_node
+		 * 1: nodes are of type raw_prio_tree_node
+		 */
 };
 
 struct prio_tree_iter {
@@ -31,10 +54,11 @@
 	iter->h_index = h_index;
 }
 
-#define INIT_PRIO_TREE_ROOT(ptr)	\
+#define INIT_PRIO_TREE_ROOT(ptr, _raw)	\
 do {					\
 	(ptr)->prio_tree_node = NULL;	\
 	(ptr)->index_bits = 1;		\
+	(ptr)->raw = (_raw);		\
 } while (0)
 
 #define INIT_PRIO_TREE_NODE(ptr)				\
@@ -73,4 +97,21 @@
 	return node->right == node;
 }
 
+
+struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root, 
+                struct prio_tree_node *old, struct prio_tree_node *node);
+struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root, 
+                struct prio_tree_node *node);
+void prio_tree_remove(struct prio_tree_root *root, struct prio_tree_node *node);
+struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter);
+struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter);
+
+#define raw_prio_tree_replace(root, old, node) \
+	prio_tree_replace(root, (struct prio_tree_node *) (old), \
+	    (struct prio_tree_node *) (node))
+#define raw_prio_tree_insert(root, node) \
+	prio_tree_insert(root, (struct prio_tree_node *) (node))
+#define raw_prio_tree_remove(root, node) \
+	prio_tree_remove(root, (struct prio_tree_node *) (node))
+
 #endif /* _LINUX_PRIO_TREE_H */
--- linux-2.6.9-orig/include/linux/mm.h	Mon Oct 18 18:53:07 2004
+++ linux-2.6.9/include/linux/mm.h	Tue Nov 16 19:26:55 2004
@@ -83,7 +83,7 @@
 			struct vm_area_struct *head;
 		} vm_set;
 
-		struct prio_tree_node prio_tree_node;
+		struct raw_prio_tree_node prio_tree_node;
 	} shared;
 
 	/*
--- linux-2.6.9-orig/mm/prio_tree.c	Mon Oct 18 18:55:28 2004
+++ linux-2.6.9/mm/prio_tree.c	Tue Nov 16 20:22:02 2004
@@ -12,7 +12,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/prio_tree.h>
 
@@ -49,18 +48,22 @@
 /* avoid overflow */
 #define HEAP_INDEX(vma)	  ((vma)->vm_pgoff + (VMA_SIZE(vma) - 1))
 
-#define GET_INDEX_VMA(vma, radix, heap)		\
-do {						\
-	radix = RADIX_INDEX(vma);		\
-	heap = HEAP_INDEX(vma);			\
-} while (0)
-
-#define GET_INDEX(node, radix, heap)		\
-do { 						\
-	struct vm_area_struct *__tmp = 		\
-	  prio_tree_entry(node, struct vm_area_struct, shared.prio_tree_node);\
-	GET_INDEX_VMA(__tmp, radix, heap); 	\
-} while (0)
+
+static void get_index(struct prio_tree_root *root, struct prio_tree_node *node,
+		      unsigned long *radix, unsigned long *heap)
+{
+	if (root->raw) {
+		struct vm_area_struct *vma = prio_tree_entry(
+		    node, struct vm_area_struct, shared.prio_tree_node);
+
+		*radix = RADIX_INDEX(vma);
+		*heap = HEAP_INDEX(vma);
+	}
+	else {
+		*radix = node->start;
+		*heap = node->end;
+	}
+}
 
 static unsigned long index_bits_to_maxindex[BITS_PER_LONG];
 
@@ -81,8 +84,6 @@
 	return index_bits_to_maxindex[bits - 1];
 }
 
-static void prio_tree_remove(struct prio_tree_root *, struct prio_tree_node *);
-
 /*
  * Extend a priority search tree so that it can store a node with heap_index
  * max_heap_index. In the worst case, this algorithm takes O((log n)^2).
@@ -138,7 +139,7 @@
 /*
  * Replace a prio_tree_node with a new node and return the old node
  */
-static struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root,
+struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root,
 		struct prio_tree_node *old, struct prio_tree_node *node)
 {
 	INIT_PRIO_TREE_NODE(node);
@@ -182,7 +183,7 @@
  * the tree, then returns the address of the prior node. Otherwise, inserts
  * @node into the tree and returns @node.
  */
-static struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
+struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
 		struct prio_tree_node *node)
 {
 	struct prio_tree_node *cur, *res = node;
@@ -190,7 +191,7 @@
 	unsigned long r_index, h_index, index, mask;
 	int size_flag = 0;
 
-	GET_INDEX(node, radix_index, heap_index);
+	get_index(root, node, &radix_index, &heap_index);
 
 	if (prio_tree_empty(root) ||
 			heap_index > prio_tree_maxindex(root->index_bits))
@@ -200,7 +201,7 @@
 	mask = 1UL << (root->index_bits - 1);
 
 	while (mask) {
-		GET_INDEX(cur, r_index, h_index);
+		get_index(root, cur, &r_index, &h_index);
 
 		if (r_index == radix_index && h_index == heap_index)
 			return cur;
@@ -259,8 +260,7 @@
  * algorithm takes O(log n) time where 'log n' is the number of bits required
  * to represent the maximum heap_index.
  */
-static void prio_tree_remove(struct prio_tree_root *root,
-		struct prio_tree_node *node)
+void prio_tree_remove(struct prio_tree_root *root, struct prio_tree_node *node)
 {
 	struct prio_tree_node *cur;
 	unsigned long r_index, h_index_right, h_index_left;
@@ -269,14 +269,14 @@
 
 	while (!prio_tree_left_empty(cur) || !prio_tree_right_empty(cur)) {
 		if (!prio_tree_left_empty(cur))
-			GET_INDEX(cur->left, r_index, h_index_left);
+			get_index(root, cur->left, &r_index, &h_index_left);
 		else {
 			cur = cur->right;
 			continue;
 		}
 
 		if (!prio_tree_right_empty(cur))
-			GET_INDEX(cur->right, r_index, h_index_right);
+			get_index(root, cur->right, &r_index, &h_index_right);
 		else {
 			cur = cur->left;
 			continue;
@@ -291,7 +291,7 @@
 
 	if (prio_tree_root(cur)) {
 		BUG_ON(root->prio_tree_node != cur);
-		INIT_PRIO_TREE_ROOT(root);
+		INIT_PRIO_TREE_ROOT(root, root->raw);
 		return;
 	}
 
@@ -318,7 +318,7 @@
 	if (prio_tree_left_empty(iter->cur))
 		return NULL;
 
-	GET_INDEX(iter->cur->left, *r_index, *h_index);
+	get_index(iter->root, iter->cur->left, r_index, h_index);
 
 	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->left;
@@ -359,7 +359,7 @@
 	if (iter->h_index < value)
 		return NULL;
 
-	GET_INDEX(iter->cur->right, *r_index, *h_index);
+	get_index(iter->root, iter->cur->right, r_index, h_index);
 
 	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->right;
@@ -414,7 +414,7 @@
  * heap_index]. Note that always radix_index <= heap_index. We do a pre-order
  * traversal of the tree.
  */
-static struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter)
+struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter)
 {
 	struct prio_tree_root *root;
 	unsigned long r_index, h_index;
@@ -425,7 +425,7 @@
 	if (prio_tree_empty(root))
 		return NULL;
 
-	GET_INDEX(root->prio_tree_node, r_index, h_index);
+	get_index(root, root->prio_tree_node, &r_index, &h_index);
 
 	if (iter->r_index > h_index)
 		return NULL;
@@ -453,7 +453,7 @@
  *
  * Get the next prio_tree_node that overlaps with the input interval in iter
  */
-static struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter)
+struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter)
 {
 	unsigned long r_index, h_index;
 
@@ -551,8 +551,8 @@
 
 	vma->shared.vm_set.head = NULL;
 
-	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
-	if (ptr != &vma->shared.prio_tree_node) {
+	ptr = raw_prio_tree_insert(root, &vma->shared.prio_tree_node);
+	if (ptr != (struct prio_tree_node *) &vma->shared.prio_tree_node) {
 		old = prio_tree_entry(ptr, struct vm_area_struct,
 					shared.prio_tree_node);
 		vma_prio_tree_add(vma, old);
@@ -568,7 +568,7 @@
 		if (!vma->shared.vm_set.parent)
 			list_del_init(&vma->shared.vm_set.list);
 		else
-			prio_tree_remove(root, &vma->shared.prio_tree_node);
+			raw_prio_tree_remove(root, &vma->shared.prio_tree_node);
 	} else {
 		/* Leave this BUG_ON till prio_tree patch stabilizes */
 		BUG_ON(vma->shared.vm_set.head->shared.vm_set.head != vma);
@@ -583,7 +583,7 @@
 			} else
 				new_head = NULL;
 
-			prio_tree_replace(root, &vma->shared.prio_tree_node,
+			raw_prio_tree_replace(root, &vma->shared.prio_tree_node,
 					&head->shared.prio_tree_node);
 			head->shared.vm_set.head = new_head;
 			if (new_head)
--- linux-2.6.9-orig/fs/inode.c	Mon Oct 18 18:55:29 2004
+++ linux-2.6.9/fs/inode.c	Tue Nov 16 20:09:46 2004
@@ -201,7 +201,7 @@
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
-	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
+	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap, 1);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
