Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbULQSmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbULQSmf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbULQSmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:42:35 -0500
Received: from almesberger.net ([63.105.73.238]:38151 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262110AbULQSjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:39:24 -0500
Date: Fri, 17 Dec 2004 15:39:09 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel@vger.kernel.org
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] prio_tree: generalization
Message-ID: <20041217153909.B21393@almesberger.net>
References: <20041217153602.D31842@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217153602.D31842@almesberger.net>; from werner@almesberger.net on Fri, Dec 17, 2004 at 03:36:02PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export prio_tree functions such that they can be used by other
subsystems than only VMAs. Also adds a mode to prio_tree to use
it with keys explicitly included in the prio_tree meta-data.

The plan is to also consider converting VMAs to use explicit
keys, so that the old "raw" mode can be removed.

- Werner

---------------------------------- cut here -----------------------------------

Signed-off-by: Werner Almesberger <werner@almesberger.net>

--- linux-2.6.10-rc3-bk10/include/linux/prio_tree.h.roll_first	Fri Dec 17 00:38:47 2004
+++ linux-2.6.10-rc3-bk10/include/linux/prio_tree.h	Fri Dec 17 01:23:45 2004
@@ -1,15 +1,38 @@
 #ifndef _LINUX_PRIO_TREE_H
 #define _LINUX_PRIO_TREE_H
 
+/*
+ * K&R 2nd ed. A8.3 somewhat obliquely hints that initial sequences of struct
+ * fields with identical types should end up at the same location. We'll use
+ * this until we can scrap struct raw_prio_tree_node.
+ *
+ * Note: all this could be done more elegantly by using unnamed union/struct
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
+	unsigned long		last;	/* last location _in_ interval */
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
@@ -32,12 +55,16 @@ static inline void prio_tree_iter_init(s
 	iter->cur = NULL;
 }
 
-#define INIT_PRIO_TREE_ROOT(ptr)	\
+#define __INIT_PRIO_TREE_ROOT(ptr, _raw)	\
 do {					\
 	(ptr)->prio_tree_node = NULL;	\
 	(ptr)->index_bits = 1;		\
+	(ptr)->raw = (_raw);		\
 } while (0)
 
+#define INIT_PRIO_TREE_ROOT(ptr)	__INIT_PRIO_TREE_ROOT(ptr, 0)
+#define INIT_RAW_PRIO_TREE_ROOT(ptr)	__INIT_PRIO_TREE_ROOT(ptr, 1)
+
 #define INIT_PRIO_TREE_NODE(ptr)				\
 do {								\
 	(ptr)->left = (ptr)->right = (ptr)->parent = (ptr);	\
@@ -74,4 +101,20 @@ static inline int prio_tree_right_empty(
 	return node->right == node;
 }
 
+
+struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root,
+                struct prio_tree_node *old, struct prio_tree_node *node);
+struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root, 
+                struct prio_tree_node *node);
+void prio_tree_remove(struct prio_tree_root *root, struct prio_tree_node *node);
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
--- linux-2.6.10-rc3-bk10/include/linux/mm.h.orig	Thu Dec 16 23:59:14 2004
+++ linux-2.6.10-rc3-bk10/include/linux/mm.h	Fri Dec 17 00:53:27 2004
@@ -85,7 +85,7 @@ struct vm_area_struct {
 			struct vm_area_struct *head;
 		} vm_set;
 
-		struct prio_tree_node prio_tree_node;
+		struct raw_prio_tree_node prio_tree_node;
 	} shared;
 
 	/*
--- linux-2.6.10-rc3-bk10/mm/prio_tree.c.roll_first	Fri Dec 17 00:39:02 2004
+++ linux-2.6.10-rc3-bk10/mm/prio_tree.c	Fri Dec 17 01:24:01 2004
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
+		*heap = node->last;
+	}
+}
 
 static unsigned long index_bits_to_maxindex[BITS_PER_LONG];
 
@@ -81,8 +85,6 @@ static inline unsigned long prio_tree_ma
 	return index_bits_to_maxindex[bits - 1];
 }
 
-static void prio_tree_remove(struct prio_tree_root *, struct prio_tree_node *);
-
 /*
  * Extend a priority search tree so that it can store a node with heap_index
  * max_heap_index. In the worst case, this algorithm takes O((log n)^2).
@@ -138,7 +140,7 @@ static struct prio_tree_node *prio_tree_
 /*
  * Replace a prio_tree_node with a new node and return the old node
  */
-static struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root,
+struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root,
 		struct prio_tree_node *old, struct prio_tree_node *node)
 {
 	INIT_PRIO_TREE_NODE(node);
@@ -182,7 +184,7 @@ static struct prio_tree_node *prio_tree_
  * the tree, then returns the address of the prior node. Otherwise, inserts
  * @node into the tree and returns @node.
  */
-static struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
+struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
 		struct prio_tree_node *node)
 {
 	struct prio_tree_node *cur, *res = node;
@@ -190,7 +192,7 @@ static struct prio_tree_node *prio_tree_
 	unsigned long r_index, h_index, index, mask;
 	int size_flag = 0;
 
-	GET_INDEX(node, radix_index, heap_index);
+	get_index(root, node, &radix_index, &heap_index);
 
 	if (prio_tree_empty(root) ||
 			heap_index > prio_tree_maxindex(root->index_bits))
@@ -200,7 +202,7 @@ static struct prio_tree_node *prio_tree_
 	mask = 1UL << (root->index_bits - 1);
 
 	while (mask) {
-		GET_INDEX(cur, r_index, h_index);
+		get_index(root, cur, &r_index, &h_index);
 
 		if (r_index == radix_index && h_index == heap_index)
 			return cur;
@@ -259,8 +261,7 @@ static struct prio_tree_node *prio_tree_
  * algorithm takes O(log n) time where 'log n' is the number of bits required
  * to represent the maximum heap_index.
  */
-static void prio_tree_remove(struct prio_tree_root *root,
-		struct prio_tree_node *node)
+void prio_tree_remove(struct prio_tree_root *root, struct prio_tree_node *node)
 {
 	struct prio_tree_node *cur;
 	unsigned long r_index, h_index_right, h_index_left;
@@ -269,14 +270,14 @@ static void prio_tree_remove(struct prio
 
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
@@ -291,7 +292,7 @@ static void prio_tree_remove(struct prio
 
 	if (prio_tree_root(cur)) {
 		BUG_ON(root->prio_tree_node != cur);
-		INIT_PRIO_TREE_ROOT(root);
+		__INIT_PRIO_TREE_ROOT(root, root->raw);
 		return;
 	}
 
@@ -318,7 +319,7 @@ static struct prio_tree_node *prio_tree_
 	if (prio_tree_left_empty(iter->cur))
 		return NULL;
 
-	GET_INDEX(iter->cur->left, *r_index, *h_index);
+	get_index(iter->root, iter->cur->left, r_index, h_index);
 
 	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->left;
@@ -359,7 +360,7 @@ static struct prio_tree_node *prio_tree_
 	if (iter->h_index < value)
 		return NULL;
 
-	GET_INDEX(iter->cur->right, *r_index, *h_index);
+	get_index(iter->root, iter->cur->right, r_index, h_index);
 
 	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->right;
@@ -425,7 +426,7 @@ static struct prio_tree_node *prio_tree_
 	if (prio_tree_empty(root))
 		return NULL;
 
-	GET_INDEX(root->prio_tree_node, r_index, h_index);
+	get_index(root, root->prio_tree_node, &r_index, &h_index);
 
 	if (iter->r_index > h_index)
 		return NULL;
@@ -453,7 +454,7 @@ static struct prio_tree_node *prio_tree_
  *
  * Get the next prio_tree_node that overlaps with the input interval in iter
  */
-static struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter)
+struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter)
 {
 	unsigned long r_index, h_index;
 
@@ -554,8 +555,8 @@ void vma_prio_tree_insert(struct vm_area
 
 	vma->shared.vm_set.head = NULL;
 
-	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
-	if (ptr != &vma->shared.prio_tree_node) {
+	ptr = raw_prio_tree_insert(root, &vma->shared.prio_tree_node);
+	if (ptr != (struct prio_tree_node *) &vma->shared.prio_tree_node) {
 		old = prio_tree_entry(ptr, struct vm_area_struct,
 					shared.prio_tree_node);
 		vma_prio_tree_add(vma, old);
@@ -571,7 +572,7 @@ void vma_prio_tree_remove(struct vm_area
 		if (!vma->shared.vm_set.parent)
 			list_del_init(&vma->shared.vm_set.list);
 		else
-			prio_tree_remove(root, &vma->shared.prio_tree_node);
+			raw_prio_tree_remove(root, &vma->shared.prio_tree_node);
 	} else {
 		/* Leave this BUG_ON till prio_tree patch stabilizes */
 		BUG_ON(vma->shared.vm_set.head->shared.vm_set.head != vma);
@@ -586,7 +587,7 @@ void vma_prio_tree_remove(struct vm_area
 			} else
 				new_head = NULL;
 
-			prio_tree_replace(root, &vma->shared.prio_tree_node,
+			raw_prio_tree_replace(root, &vma->shared.prio_tree_node,
 					&head->shared.prio_tree_node);
 			head->shared.vm_set.head = new_head;
 			if (new_head)
--- linux-2.6.10-rc3-bk10/fs/inode.c.orig	Fri Dec 17 00:58:27 2004
+++ linux-2.6.10-rc3-bk10/fs/inode.c	Fri Dec 17 00:53:36 2004
@@ -201,7 +201,7 @@ void inode_init_once(struct inode *inode
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
-	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
+	INIT_RAW_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
