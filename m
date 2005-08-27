Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbVH0RNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbVH0RNd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbVH0RNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 13:13:33 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:64387 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751544AbVH0RNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 13:13:33 -0400
Subject: [PATCH] add idr replacement functionality to radix tree
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 27 Aug 2005 12:02:56 -0500
Message-Id: <1125162176.5159.17.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current idr code suffers from three faults:

1) idr_pre_get() and idr_remove() take an internal lock, so can't be
called from interrupt level
2) idr_pre_get is racy, so you need to check for an EAGAIN return from
idr_get_new() and retry ... several callers seem to forget this
3) idr_pre_get() is a requirement, even if idr_get_new() is called from
non-atomic contexts

The radix tree code avoids all of these problems and runs completely
without internal locks.  Since idr is also a radix tree implementation,
it would be perfectly possible to graft all of the radix tree fixes into
it.  However, the idr API would have to change (radix tree uses per cpu
arrays in its prealloc routines necessitating a radix_tree_prealloc_end
()).  A better course of action seems to be to combine idr and radix
tree, since they share so much code anyway, which is what this patch
does.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

A separate set of patches will be posted converting all the current idr
users to be radix tree users and then removing the idr code.

Applies on top of the prior patch converting the gang lookup to bitmaps.

James

 include/linux/radix-tree.h |   10 +++
 lib/radix-tree.c           |  129 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 120 insertions(+), 19 deletions(-)


diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -62,10 +62,20 @@ unsigned int
 radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
 		unsigned long first_index, unsigned int max_items, int tag);
 int radix_tree_tagged(struct radix_tree_root *root, int tag);
+int radix_tree_get_new_above(struct radix_tree_root *root, void *item,
+			     unsigned long starting_index,
+			     unsigned long *index);
 
 static inline void radix_tree_preload_end(void)
 {
 	preempt_enable();
 }
 
+static inline int radix_tree_get_new(struct radix_tree_root *root, void *item,
+				     unsigned long *index)
+{
+	return radix_tree_get_new_above(root, item, 0, index);
+}
+
+
 #endif /* _LINUX_RADIX_TREE_H */
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -53,6 +53,7 @@
 	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
 struct radix_tree_node {
+	unsigned long	lower_occupied;
 	unsigned long	occupied;
 	void		*slots[RADIX_TREE_MAP_SIZE];
 	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
@@ -218,6 +219,8 @@ static int radix_tree_extend(struct radi
 		}
 
 		node->occupied = 1;
+		node->lower_occupied = (root->rnode->lower_occupied ==
+					RADIX_TREE_MAP_FULL) ? 1 : 0;
 		root->rnode = node;
 		root->height++;
 	} while (height > root->height);
@@ -236,9 +239,9 @@ out:
 int radix_tree_insert(struct radix_tree_root *root,
 			unsigned long index, void *item)
 {
-	struct radix_tree_node *node = NULL, *tmp, **slot;
+	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
+	struct radix_tree_node *tmp;
 	unsigned int height, shift;
-	int offset;
 	int error;
 
 	/* Make sure the tree is high enough.  */
@@ -249,40 +252,51 @@ int radix_tree_insert(struct radix_tree_
 			return error;
 	}
 
-	slot = &root->rnode;
+	pathp->slot = &root->rnode;
+	pathp->node = NULL;
 	height = root->height;
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 
-	offset = 0;			/* uninitialised var warning */
 	while (height > 0) {
-		if (*slot == NULL) {
+		if (*pathp->slot == NULL) {
 			/* Have to add a child node.  */
 			if (!(tmp = radix_tree_node_alloc(root)))
 				return -ENOMEM;
-			*slot = tmp;
-			if (node) {
-				BUG_ON(node->occupied & (1UL << offset));
-				node->occupied |= (1UL << offset);
+			*pathp->slot = tmp;
+			if (pathp->node) {
+				BUG_ON(pathp->node->occupied & 
+				       (1UL << pathp->offset));
+				pathp->node->occupied |=
+					(1UL << pathp->offset);
 			}
 		}
 
 		/* Go a level down */
-		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
-		node = *slot;
-		slot = (struct radix_tree_node **)(node->slots + offset);
+		pathp[1].offset = (index >> shift) & RADIX_TREE_MAP_MASK;
+		pathp[1].node = *pathp->slot;
+		pathp[1].slot = 
+			(struct radix_tree_node **)(pathp[1].node->slots +
+						    pathp[1].offset);
+		pathp++;
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	if (*slot != NULL)
+	if (*pathp->slot != NULL)
 		return -EEXIST;
-	BUG_ON(!node);
-	BUG_ON(node->occupied & (1UL << offset));
-	node->occupied |= (1UL << offset);
-	BUG_ON(tag_get(node, 0, offset));
-	BUG_ON(tag_get(node, 1, offset));
+	BUG_ON(!pathp->node);
+	BUG_ON(pathp->node->occupied & (1UL << pathp->offset));
+	pathp->node->occupied |= (1UL << pathp->offset);
+	BUG_ON(tag_get(pathp->node, 0, pathp->offset));
+	BUG_ON(tag_get(pathp->node, 1, pathp->offset));
+
+	*pathp->slot = item;
+
+	while(pathp->node &&
+	      (pathp->node->lower_occupied |= (1UL << pathp->offset)) ==
+	      RADIX_TREE_MAP_FULL)
+		pathp--;
 
-	*slot = item;
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_insert);
@@ -672,6 +686,75 @@ radix_tree_gang_lookup_tag(struct radix_
 EXPORT_SYMBOL(radix_tree_gang_lookup_tag);
 
 /**
+ * radix_tree_get_new_above - allocate radix tree entry above or equal to index
+ * @root:	the root of the radix tree
+ * @item:	the item to insert
+ * @index:	the index to begin with
+ * @next_index:	the index where item was inserted
+ *
+ * This function allocates and returns a new index.  It should be called
+ * with any required locks or semaphores
+ */
+int radix_tree_get_new_above(struct radix_tree_root *root, void *item,
+			     unsigned long index,
+			     unsigned long *next_index)
+{
+	unsigned int shift;
+	unsigned int height = root->height;
+	struct radix_tree_node *slot;
+
+	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
+	slot = root->rnode;
+
+	while (height > 0) {
+		unsigned long j = (index >> shift) & RADIX_TREE_MAP_MASK, i;
+		unsigned long occupied_mask = 0;
+
+		/* mark all the slots up to but excluding the starting
+		 * index occupied */
+		occupied_mask = (1UL << j) - 1;
+		/* Now or in the remaining occupations */
+		occupied_mask |= slot->lower_occupied;
+
+		/* If everything from this on up is full, then there's
+		 * nothing more in the tree, move up to next level */
+		if (occupied_mask == RADIX_TREE_MAP_FULL) {
+			index = radix_tree_maxindex(root->height) + 1;
+			goto out;
+		}
+
+		i = ffz(occupied_mask);
+		if (i != j) {
+			index &= ~((1UL << (shift + RADIX_TREE_MAP_SHIFT)) - 1);
+			index |= i << shift;
+		}
+
+		height--;
+		if (height == 0) {
+			/* Bottom level: slot should be empty */
+			BUG_ON(slot->slots[i]);
+			goto out;
+		}
+		shift -= RADIX_TREE_MAP_SHIFT;
+		slot = slot->slots[i];
+		if (slot == NULL)
+			/* in this case, lower level is fully empty */
+			break;
+	}
+out:
+	*next_index = index;
+	if (item == NULL)
+		/* NULL means empty slot to the radix tree, so put a
+		 * bogus entry there.  Things passing in NULL items
+		 * never want to retrieve them anyway ...
+		 */
+		item = (void *)1UL;
+
+	return radix_tree_insert(root, index, item);
+}
+EXPORT_SYMBOL(radix_tree_get_new_above);
+
+/**
  *	radix_tree_delete    -    delete an item from a radix tree
  *	@root:		radix tree root
  *	@index:		index key
@@ -747,6 +830,14 @@ void *radix_tree_delete(struct radix_tre
 	} while (pathp[0].node && nr_cleared_tags);
 
 	pathp = orig_pathp;
+	while (pathp->node) {
+		if ((pathp->node->lower_occupied & (1UL << pathp->offset))
+		    == 0)
+			break;
+		pathp->node->lower_occupied &= ~(1UL << pathp->offset);
+		pathp--;
+	}
+	pathp = orig_pathp;
 	*pathp[0].slot = NULL;
 	BUG_ON(pathp[0].node && (pathp[0].node->occupied & (1UL << pathp[0].offset)) == 0);
 	while (pathp[0].node && 



