Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbUKOSOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUKOSOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 13:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUKOSOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 13:14:22 -0500
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:16332 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261657AbUKOSOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 13:14:00 -0500
Date: Mon, 15 Nov 2004 13:13:48 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@red.engin.umich.edu
To: Werner Almesberger <werner@almesberger.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
In-Reply-To: <20041114235646.K28802@almesberger.net>
Message-ID: <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu>
References: <20041114235646.K28802@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Nov 2004, Werner Almesberger wrote:

> perhaps you remember me posting a long time ago about generalizing
> prio_tree. Now I finally got to make that patch. In fact, there are
> three parts:
>
>  - the prio_tree "core" in lib/
>  - switching mm/prio_tree.c to use the "core"
>  - some debugging extensions
>
[snip]
>
> The patch below puts an includeable version of prio_tree to lib/.
> This should be included similar to how inflate.c is used.

I don't like including prio_tree. I will only choose to go the
include way if and only if every other choice leads to significant
performance overhead.

Currently I prefer the following way, but I didn't implement it
because I don't have a strong reason to generalize prio_tree and
the generalization may lead to some preformance loss (which may be
insignificant loss in real world apps). We have to test to know
the performance loss.

Again I don't like the following approach fully. I couldn't come
out with a clean generalization something like rb_tree code. I don't
think such a clean generalization exists for prio_tree. Therefore,
if we have a strong reason to generalize the prio_tree, then we have to
choose one of the options we have. Untested prototype patch below.

prio_tree generalization...

---

 linux-2.6.9-testuser/fs/inode.c                |    2
 linux-2.6.9-testuser/include/linux/prio_tree.h |   10 +++-
 linux-2.6.9-testuser/mm/prio_tree.c            |   56 ++++++++++++++-----------
 3 files changed, 41 insertions(+), 27 deletions(-)

diff -puN include/linux/prio_tree.h~prio_tree_gen include/linux/prio_tree.h
--- linux-2.6.9/include/linux/prio_tree.h~prio_tree_gen	2004-11-15 12:30:34.513076512 -0500
+++ linux-2.6.9-testuser/include/linux/prio_tree.h	2004-11-15 13:04:55.772717416 -0500
@@ -9,7 +9,8 @@ struct prio_tree_node {

 struct prio_tree_root {
 	struct prio_tree_node	*prio_tree_node;
-	unsigned int 		index_bits;
+	unsigned short		index_bits;
+	unsigned short		type;
 };

 struct prio_tree_iter {
@@ -31,10 +32,15 @@ static inline void prio_tree_iter_init(s
 	iter->h_index = h_index;
 }

-#define INIT_PRIO_TREE_ROOT(ptr)	\
+/* prio_tree types */
+#define VMA_PRIO_TREE		0
+#define ABISS_PRIO_TREE		1
+
+#define INIT_PRIO_TREE_ROOT(ptr, t)	\
 do {					\
 	(ptr)->prio_tree_node = NULL;	\
 	(ptr)->index_bits = 1;		\
+	(ptr)->type = t;		\
 } while (0)

 #define INIT_PRIO_TREE_NODE(ptr)				\
diff -puN mm/prio_tree.c~prio_tree_gen mm/prio_tree.c
--- linux-2.6.9/mm/prio_tree.c~prio_tree_gen	2004-11-15 12:32:39.010150080 -0500
+++ linux-2.6.9-testuser/mm/prio_tree.c	2004-11-15 12:54:00.085397040 -0500
@@ -44,23 +44,10 @@
  * The following macros are used for implementing prio_tree for i_mmap
  */

-#define RADIX_INDEX(vma)  ((vma)->vm_pgoff)
-#define VMA_SIZE(vma)	  (((vma)->vm_end - (vma)->vm_start) >> PAGE_SHIFT)
+#define VMA_RADIX_INDEX(vma)	((vma)->vm_pgoff)
+#define VMA_SIZE(vma)		(((vma)->vm_end - (vma)->vm_start) >> PAGE_SHIFT)
 /* avoid overflow */
-#define HEAP_INDEX(vma)	  ((vma)->vm_pgoff + (VMA_SIZE(vma) - 1))
-
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
+#define VMA_HEAP_INDEX(vma)	((vma)->vm_pgoff + (VMA_SIZE(vma) - 1))

 static unsigned long index_bits_to_maxindex[BITS_PER_LONG];

@@ -83,6 +70,27 @@ static inline unsigned long prio_tree_ma

 static void prio_tree_remove(struct prio_tree_root *, struct prio_tree_node *);

+static void get_index(struct prio_tree_root *root, struct prio_tree_node *node,
+		unsigned long *radix, unsigned long *heap)
+{
+	switch (root->type) {
+	case VMA_PRIO_TREE:
+		struct vm_area_struct *vma;
+		vma = prio_tree_entry(node, struct vm_area_struct,
+				shared.prio_tree_node);
+		*radix = VMA_RADIX_INDEX(vma);
+		*heap = VMA_HEAP_INDEX(vma);
+		break;
+	case ABISS_PRIO_TREE:
+		...
+		break;
+	default:
+		BUG();
+		break;
+	}
+}
+
+
 /*
  * Extend a priority search tree so that it can store a node with heap_index
  * max_heap_index. In the worst case, this algorithm takes O((log n)^2).
@@ -190,7 +198,7 @@ static struct prio_tree_node *prio_tree_
 	unsigned long r_index, h_index, index, mask;
 	int size_flag = 0;

-	GET_INDEX(node, radix_index, heap_index);
+	get_index(root, node, &radix_index, &heap_index);

 	if (prio_tree_empty(root) ||
 			heap_index > prio_tree_maxindex(root->index_bits))
@@ -200,7 +208,7 @@ static struct prio_tree_node *prio_tree_
 	mask = 1UL << (root->index_bits - 1);

 	while (mask) {
-		GET_INDEX(cur, r_index, h_index);
+		get_index(root, cur, &r_index, &h_index);

 		if (r_index == radix_index && h_index == heap_index)
 			return cur;
@@ -269,14 +277,14 @@ static void prio_tree_remove(struct prio

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
@@ -291,7 +299,7 @@ static void prio_tree_remove(struct prio

 	if (prio_tree_root(cur)) {
 		BUG_ON(root->prio_tree_node != cur);
-		INIT_PRIO_TREE_ROOT(root);
+		INIT_PRIO_TREE_ROOT(root, root->type);
 		return;
 	}

@@ -318,7 +326,7 @@ static struct prio_tree_node *prio_tree_
 	if (prio_tree_left_empty(iter->cur))
 		return NULL;

-	GET_INDEX(iter->cur->left, *r_index, *h_index);
+	get_index(iter->root, iter->cur->left, r_index, h_index);

 	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->left;
@@ -359,7 +367,7 @@ static struct prio_tree_node *prio_tree_
 	if (iter->h_index < value)
 		return NULL;

-	GET_INDEX(iter->cur->right, *r_index, *h_index);
+	get_index(iter->root, iter->cur->right, r_index, h_index);

 	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->right;
@@ -425,7 +433,7 @@ static struct prio_tree_node *prio_tree_
 	if (prio_tree_empty(root))
 		return NULL;

-	GET_INDEX(root->prio_tree_node, r_index, h_index);
+	get_index(root, root->prio_tree_node, &r_index, &h_index);

 	if (iter->r_index > h_index)
 		return NULL;
diff -puN fs/inode.c~prio_tree_gen fs/inode.c
--- linux-2.6.9/fs/inode.c~prio_tree_gen	2004-11-15 12:50:22.393491240 -0500
+++ linux-2.6.9-testuser/fs/inode.c	2004-11-15 12:51:18.155014200 -0500
@@ -201,7 +201,7 @@ void inode_init_once(struct inode *inode
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
-	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
+	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap, VMA_PRIO_TREE);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
_
