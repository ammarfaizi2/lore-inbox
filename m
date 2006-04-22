Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWDVScH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWDVScH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWDVScG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:32:06 -0400
Received: from ns.suse.de ([195.135.220.2]:23252 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750874AbWDVScE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:32:04 -0400
Date: Sat, 22 Apr 2006 20:31:54 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: [rfc][patch] radix-tree: direct data
Message-ID: <20060422183154.GF30503@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew is (rightfully) worried about the several % radix_node size
increase introduced by RCU radix-tree for my lockless pagecache
(the conversation happened offline due to me forgetting to cc).

Here is my penance. 

---
The ability to have height 0 radix trees (a direct pointer to the data item
rather than going through a full node->slot) quietly disappeared with 
old-2.6-bkcvs commit ffee171812d51652f9ba284302d9e5c5cc14bdfd. On 64-bit
machines this causes nearly 600 bytes to be used for every <= 4K file
in pagecache. 

Re-introduce this feature, root tags are stored in spare ->gfp_mask bits.

Simplify radix_tree_delete's complex tag clearing arrangement (which
would become even more complex) by just falling back to tag clearing
functions (the pagecache radix-tree never uses this path anyway, so
the icache savings will mean it's actually a speedup).

This saves around 16MB in tags on my 4GB G5 with a couple of kernel source
and object trees in pagecache. It's almost 8MB per kernel tree, + KDE/etc.

Pagecache lookup speed for small files should also be improved marginally,
as should insertion / removal of the single pagecache page because it no
longer has to allocate memory (not measured).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -83,7 +83,8 @@ radix_tree_node_alloc(struct radix_tree_
 {
 	struct radix_tree_node *ret;
 
-	ret = kmem_cache_alloc(radix_tree_node_cachep, root->gfp_mask);
+	ret = kmem_cache_alloc(radix_tree_node_cachep,
+					root->gfp_mask & __GFP_BITS_MASK);
 	if (ret == NULL && !(root->gfp_mask & __GFP_WAIT)) {
 		struct radix_tree_preload *rtp;
 
@@ -182,7 +183,7 @@ static int radix_tree_extend(struct radi
 {
 	struct radix_tree_node *node;
 	unsigned int height;
-	char tags[RADIX_TREE_MAX_TAGS];
+	unsigned int tags;
 	int tag;
 
 	/* Figure out what the height should be.  */
@@ -199,11 +200,7 @@ static int radix_tree_extend(struct radi
 	 * Prepare the tag status of the top-level node for propagation
 	 * into the newly-pushed top-level node(s)
 	 */
-	for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-		tags[tag] = 0;
-		if (any_tag_set(root->rnode, tag))
-			tags[tag] = 1;
-	}
+	tags = root->gfp_mask >> __GFP_BITS_SHIFT;
 
 	do {
 		if (!(node = radix_tree_node_alloc(root)))
@@ -214,7 +211,7 @@ static int radix_tree_extend(struct radi
 
 		/* Propagate the aggregated tag info into the new root */
 		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-			if (tags[tag])
+			if (tags & (1 << tag))
 				tag_set(node, tag, 0);
 		}
 
@@ -243,8 +240,7 @@ int radix_tree_insert(struct radix_tree_
 	int error;
 
 	/* Make sure the tree is high enough.  */
-	if ((!index && !root->rnode) ||
-			index > radix_tree_maxindex(root->height)) {
+	if (index > radix_tree_maxindex(root->height)) {
 		error = radix_tree_extend(root, index);
 		if (error)
 			return error;
@@ -255,7 +251,7 @@ int radix_tree_insert(struct radix_tree_
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 
 	offset = 0;			/* uninitialised var warning */
-	do {
+	while (height > 0) {
 		if (slot == NULL) {
 			/* Have to add a child node.  */
 			if (!(slot = radix_tree_node_alloc(root)))
@@ -273,16 +269,18 @@ int radix_tree_insert(struct radix_tree_
 		slot = node->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
-	} while (height > 0);
+	}
 
 	if (slot != NULL)
 		return -EEXIST;
 
-	BUG_ON(!node);
-	node->count++;
-	node->slots[offset] = item;
-	BUG_ON(tag_get(node, 0, offset));
-	BUG_ON(tag_get(node, 1, offset));
+	if (node) {
+		node->count++;
+		node->slots[offset] = item;
+		BUG_ON(tag_get(node, 0, offset));
+		BUG_ON(tag_get(node, 1, offset));
+	} else
+		root->rnode = item;
 
 	return 0;
 }
@@ -368,8 +366,8 @@ void *radix_tree_tag_set(struct radix_tr
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
-	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
+	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 
 	while (height > 0) {
 		int offset;
@@ -383,6 +381,10 @@ void *radix_tree_tag_set(struct radix_tr
 		height--;
 	}
 
+	/* set the root's tag bit */
+	if (slot && !(root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT))))
+		root->gfp_mask |= (1 << (tag + __GFP_BITS_SHIFT));
+
 	return slot;
 }
 EXPORT_SYMBOL(radix_tree_tag_set);
@@ -405,9 +407,8 @@ void *radix_tree_tag_clear(struct radix_
 			unsigned long index, unsigned int tag)
 {
 	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
-	struct radix_tree_node *slot;
+	struct radix_tree_node *slot = NULL;
 	unsigned int height, shift;
-	void *ret = NULL;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
@@ -432,20 +433,24 @@ void *radix_tree_tag_clear(struct radix_
 		height--;
 	}
 
-	ret = slot;
-	if (ret == NULL)
+	if (slot == NULL)
 		goto out;
 
-	do {
+	while (pathp->node) {
 		if (!tag_get(pathp->node, tag, pathp->offset))
 			goto out;
 		tag_clear(pathp->node, tag, pathp->offset);
 		if (any_tag_set(pathp->node, tag))
 			goto out;
 		pathp--;
-	} while (pathp->node);
+	}
+
+	/* clear the root's tag bit */
+	if (root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT)))
+		root->gfp_mask &= ~(1 << (tag + __GFP_BITS_SHIFT));
+
 out:
-	return ret;
+	return slot;
 }
 EXPORT_SYMBOL(radix_tree_tag_clear);
 
@@ -458,9 +463,8 @@ EXPORT_SYMBOL(radix_tree_tag_clear);
  *
  * Return values:
  *
- *  0: tag not present
- *  1: tag present, set
- * -1: tag present, unset
+ *  0: tag not present or not set
+ *  1: tag set
  */
 int radix_tree_tag_get(struct radix_tree_root *root,
 			unsigned long index, unsigned int tag)
@@ -473,6 +477,13 @@ int radix_tree_tag_get(struct radix_tree
 	if (index > radix_tree_maxindex(height))
 		return 0;
 
+	/* check the root's tag bit */
+	if (!(root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT))))
+		return 0;
+
+	if (height == 0)
+		return 1;
+
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
@@ -494,7 +505,7 @@ int radix_tree_tag_get(struct radix_tree
 			int ret = tag_get(slot, tag, offset);
 
 			BUG_ON(ret && saw_unset_tag);
-			return ret ? 1 : -1;
+			return ret;
 		}
 		slot = slot->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
@@ -514,8 +525,11 @@ __lookup(struct radix_tree_root *root, v
 	unsigned long i;
 
 	height = root->height;
-	if (height == 0)
+	if (height == 0) {
+		if (root->rnode && index == 0)
+			results[nr_found++] = root->rnode;
 		goto out;
+	}
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
@@ -603,10 +617,16 @@ __lookup_tag(struct radix_tree_root *roo
 	unsigned int height = root->height;
 	struct radix_tree_node *slot;
 
+	if (height == 0) {
+		if (root->rnode && index == 0)
+			results[nr_found++] = root->rnode;
+		goto out;
+	}
+
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
-	while (height > 0) {
+	do {
 		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
 
 		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
@@ -637,7 +657,7 @@ __lookup_tag(struct radix_tree_root *roo
 		}
 		shift -= RADIX_TREE_MAP_SHIFT;
 		slot = slot->slots[i];
-	}
+	} while (height > 0);
 out:
 	*next_index = index;
 	return nr_found;
@@ -665,6 +685,10 @@ radix_tree_gang_lookup_tag(struct radix_
 	unsigned long cur_index = first_index;
 	unsigned int ret = 0;
 
+	/* check the root's tag bit */
+	if (!(root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT))))
+		return 0;
+
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
@@ -689,7 +713,7 @@ EXPORT_SYMBOL(radix_tree_gang_lookup_tag
 static inline void radix_tree_shrink(struct radix_tree_root *root)
 {
 	/* try to shrink tree height */
-	while (root->height > 1 &&
+	while (root->height > 0 &&
 			root->rnode->count == 1 &&
 			root->rnode->slots[0]) {
 		struct radix_tree_node *to_free = root->rnode;
@@ -717,12 +741,8 @@ static inline void radix_tree_shrink(str
 void *radix_tree_delete(struct radix_tree_root *root, unsigned long index)
 {
 	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
-	struct radix_tree_path *orig_pathp;
-	struct radix_tree_node *slot;
+	struct radix_tree_node *slot = NULL;
 	unsigned int height, shift;
-	void *ret = NULL;
-	char tags[RADIX_TREE_MAX_TAGS];
-	int nr_cleared_tags;
 	int tag;
 	int offset;
 
@@ -730,11 +750,18 @@ void *radix_tree_delete(struct radix_tre
 	if (index > radix_tree_maxindex(height))
 		goto out;
 
+	slot = root->rnode;
+	if (height == 0 && root->rnode) {
+		/* clear the root's tag bits */
+		root->gfp_mask &= __GFP_BITS_MASK;
+		root->rnode = NULL;
+		goto out;
+	}
+
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	pathp->node = NULL;
-	slot = root->rnode;
 
-	for ( ; height > 0; height--) {
+	do {
 		if (slot == NULL)
 			goto out;
 
@@ -744,44 +771,22 @@ void *radix_tree_delete(struct radix_tre
 		pathp->node = slot;
 		slot = slot->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
-	}
+		height--;
+	} while (height > 0);
 
-	ret = slot;
-	if (ret == NULL)
+	if (slot == NULL)
 		goto out;
 
-	orig_pathp = pathp;
-
 	/*
 	 * Clear all tags associated with the just-deleted item
 	 */
-	nr_cleared_tags = 0;
 	for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-		tags[tag] = 1;
-		if (tag_get(pathp->node, tag, pathp->offset)) {
-			tag_clear(pathp->node, tag, pathp->offset);
-			if (!any_tag_set(pathp->node, tag)) {
-				tags[tag] = 0;
-				nr_cleared_tags++;
-			}
-		}
-	}
-
-	for (pathp--; nr_cleared_tags && pathp->node; pathp--) {
-		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-			if (tags[tag])
-				continue;
-
-			tag_clear(pathp->node, tag, pathp->offset);
-			if (any_tag_set(pathp->node, tag)) {
-				tags[tag] = 1;
-				nr_cleared_tags--;
-			}
-		}
+		if (tag_get(pathp->node, tag, pathp->offset))
+			radix_tree_tag_clear(root, index, tag);
 	}
 
 	/* Now free the nodes we do not need anymore */
-	for (pathp = orig_pathp; pathp->node; pathp--) {
+	while (pathp->node) {
 		pathp->node->slots[pathp->offset] = NULL;
 		pathp->node->count--;
 
@@ -793,11 +798,15 @@ void *radix_tree_delete(struct radix_tre
 
 		/* Node with zero slots in use so free it */
 		radix_tree_node_free(pathp->node);
+
+		pathp--;
 	}
-	root->rnode = NULL;
+	root->gfp_mask &= __GFP_BITS_MASK;
 	root->height = 0;
+	root->rnode = NULL;
+
 out:
-	return ret;
+	return slot;
 }
 EXPORT_SYMBOL(radix_tree_delete);
 
Index: linux-2.6/include/linux/radix-tree.h
===================================================================
--- linux-2.6.orig/include/linux/radix-tree.h
+++ linux-2.6/include/linux/radix-tree.h
@@ -23,6 +23,9 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#define RADIX_TREE_MAX_TAGS 2
+
+/* root tags are stored in gfp_mask, shifted by __GFP_BITS_SHIFT */
 struct radix_tree_root {
 	unsigned int		height;
 	gfp_t			gfp_mask;
@@ -45,8 +48,6 @@ do {									\
 	(root)->rnode = NULL;						\
 } while (0)
 
-#define RADIX_TREE_MAX_TAGS 2
-
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
 void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
 void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
