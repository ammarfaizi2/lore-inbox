Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbULPIg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbULPIg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbULPIg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:36:27 -0500
Received: from almesberger.net ([63.105.73.238]:30217 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262644AbULPIbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:31:41 -0500
Date: Thu, 16 Dec 2004 05:31:18 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] Generalized prio_tree, revisited
Message-ID: <20041216053118.M1229@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajesh,

did you have a chance to look at the prio_tree generalization ?

I've attached the patch I posted a month ago (plus the trivial
"const" change). It's for 2.6.9, but also applies to 2.6.10-rc2,
which I've been using for a good while now.

The patch splits the radix priority search trees into two types:
the "raw" one with implicit keys, as it's currently used, and a
new, generalized one with explicit keys, which should be used by
new code.

There are currently no in-tree users of the generalized prio_tree,
but an example of one can be found in the elevator code of ABISS
(abiss.sourceforge.net), where it's used to detect overlapping
requests, which in turn is needed to improve barrier handling in
the elevator. Jens has also indicated interest in putting overlap
handling into the general block IO layer.

At a later point, also VMA could be converted to use explicit
keys. That would slightly enlarge struct vm_area_struct, but
simplify the code and save a few cycles for key access.

To make the changes clearly visible, this patch doesn't split
mm/prio_tree.c into the VMA-specific and the generic part and move
the latter to lib/. This can be done at a later time. I've noticed
that 2.6.10-rc3-mm1 dummies out prio_tree on systems without MMU.
So if combined with this change, the split will need to be done.

Are there any standard benchmarks I could run to show how/if this
affects VMA performance ? I'd be surprised if there was much of a
change, but you never know.

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
+++ linux-2.6.9/mm/prio_tree.c	Tue Nov 16 21:50:50 2004
@@ -12,7 +12,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/prio_tree.h>
 
@@ -49,18 +48,23 @@
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
+static void get_index(const struct prio_tree_root *root,
+    const struct prio_tree_node *node,
+    unsigned long *radix, unsigned long *heap)
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
 
@@ -81,8 +85,6 @@
 	return index_bits_to_maxindex[bits - 1];
 }
 
-static void prio_tree_remove(struct prio_tree_root *, struct prio_tree_node *);
-
 /*
  * Extend a priority search tree so that it can store a node with heap_index
  * max_heap_index. In the worst case, this algorithm takes O((log n)^2).
@@ -138,7 +140,7 @@
 /*
  * Replace a prio_tree_node with a new node and return the old node
  */
-static struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root,
+struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root,
 		struct prio_tree_node *old, struct prio_tree_node *node)
 {
 	INIT_PRIO_TREE_NODE(node);
@@ -182,7 +184,7 @@
  * the tree, then returns the address of the prior node. Otherwise, inserts
  * @node into the tree and returns @node.
  */
-static struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
+struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
 		struct prio_tree_node *node)
 {
 	struct prio_tree_node *cur, *res = node;
@@ -190,7 +192,7 @@
 	unsigned long r_index, h_index, index, mask;
 	int size_flag = 0;
 
-	GET_INDEX(node, radix_index, heap_index);
+	get_index(root, node, &radix_index, &heap_index);
 
 	if (prio_tree_empty(root) ||
 			heap_index > prio_tree_maxindex(root->index_bits))
@@ -200,7 +202,7 @@
 	mask = 1UL << (root->index_bits - 1);
 
 	while (mask) {
-		GET_INDEX(cur, r_index, h_index);
+		get_index(root, cur, &r_index, &h_index);
 
 		if (r_index == radix_index && h_index == heap_index)
 			return cur;
@@ -259,8 +261,7 @@
  * algorithm takes O(log n) time where 'log n' is the number of bits required
  * to represent the maximum heap_index.
  */
-static void prio_tree_remove(struct prio_tree_root *root,
-		struct prio_tree_node *node)
+void prio_tree_remove(struct prio_tree_root *root, struct prio_tree_node *node)
 {
 	struct prio_tree_node *cur;
 	unsigned long r_index, h_index_right, h_index_left;
@@ -269,14 +270,14 @@
 
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
@@ -291,7 +292,7 @@
 
 	if (prio_tree_root(cur)) {
 		BUG_ON(root->prio_tree_node != cur);
-		INIT_PRIO_TREE_ROOT(root);
+		INIT_PRIO_TREE_ROOT(root, root->raw);
 		return;
 	}
 
@@ -318,7 +319,7 @@
 	if (prio_tree_left_empty(iter->cur))
 		return NULL;
 
-	GET_INDEX(iter->cur->left, *r_index, *h_index);
+	get_index(iter->root, iter->cur->left, r_index, h_index);
 
 	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->left;
@@ -359,7 +360,7 @@
 	if (iter->h_index < value)
 		return NULL;
 
-	GET_INDEX(iter->cur->right, *r_index, *h_index);
+	get_index(iter->root, iter->cur->right, r_index, h_index);
 
 	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->right;
@@ -414,7 +415,7 @@
  * heap_index]. Note that always radix_index <= heap_index. We do a pre-order
  * traversal of the tree.
  */
-static struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter)
+struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter)
 {
 	struct prio_tree_root *root;
 	unsigned long r_index, h_index;
@@ -425,7 +426,7 @@
 	if (prio_tree_empty(root))
 		return NULL;
 
-	GET_INDEX(root->prio_tree_node, r_index, h_index);
+	get_index(root, root->prio_tree_node, &r_index, &h_index);
 
 	if (iter->r_index > h_index)
 		return NULL;
@@ -453,7 +454,7 @@
  *
  * Get the next prio_tree_node that overlaps with the input interval in iter
  */
-static struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter)
+struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter)
 {
 	unsigned long r_index, h_index;
 
@@ -551,8 +552,8 @@
 
 	vma->shared.vm_set.head = NULL;
 
-	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
-	if (ptr != &vma->shared.prio_tree_node) {
+	ptr = raw_prio_tree_insert(root, &vma->shared.prio_tree_node);
+	if (ptr != (struct prio_tree_node *) &vma->shared.prio_tree_node) {
 		old = prio_tree_entry(ptr, struct vm_area_struct,
 					shared.prio_tree_node);
 		vma_prio_tree_add(vma, old);
@@ -568,7 +569,7 @@
 		if (!vma->shared.vm_set.parent)
 			list_del_init(&vma->shared.vm_set.list);
 		else
-			prio_tree_remove(root, &vma->shared.prio_tree_node);
+			raw_prio_tree_remove(root, &vma->shared.prio_tree_node);
 	} else {
 		/* Leave this BUG_ON till prio_tree patch stabilizes */
 		BUG_ON(vma->shared.vm_set.head->shared.vm_set.head != vma);
@@ -583,7 +584,7 @@
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
