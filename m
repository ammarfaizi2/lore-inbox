Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWDYEwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWDYEwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 00:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWDYEwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 00:52:50 -0400
Received: from ns.suse.de ([195.135.220.2]:45471 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750937AbWDYEwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 00:52:49 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060303174218.10573.71812.sendpatchset@linux.site>
Subject: [patch 1/2] radix-tree: direct data
Date: Tue, 25 Apr 2006 06:52:43 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ability to have height 0 radix trees (a direct pointer to the data
item rather than going through a full node->slot) quietly disappeared
with old-2.6-bkcvs commit ffee171812d51652f9ba284302d9e5c5cc14bdfd. On
64-bit machines this causes nearly 600 bytes to be used for every <= 4K
file in pagecache. 

Re-introduce this feature, root tags stored in spare ->gfp_mask bits.

Simplify radix_tree_delete's complex tag clearing arrangement (which
would become even more complex) by just falling back to tag clearing
functions (the pagecache radix-tree never uses this path anyway, so
the icache savings will mean it's actually a speedup).

On my 4GB G5, this saves 8MB RAM per kernel kernel source+object tree
in pagecache.

Pagecache lookup, insertion, and removal speed for small files will
also be improved.

This makes RCU radix tree harder, but it's worth it.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -74,6 +74,11 @@ struct radix_tree_preload {
 };
 DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
 
+static inline gfp_t root_gfp_mask(struct radix_tree_root *root)
+{
+	return root->gfp_mask & __GFP_BITS_MASK;
+}
+
 /*
  * This assumes that the caller has performed appropriate preallocation, and
  * that the caller has pinned this thread of control to the current CPU.
@@ -82,9 +87,10 @@ static struct radix_tree_node *
 radix_tree_node_alloc(struct radix_tree_root *root)
 {
 	struct radix_tree_node *ret;
+	gfp_t gfp_mask = root_gfp_mask(root);
 
-	ret = kmem_cache_alloc(radix_tree_node_cachep, root->gfp_mask);
-	if (ret == NULL && !(root->gfp_mask & __GFP_WAIT)) {
+	ret = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+	if (ret == NULL && !(gfp_mask & __GFP_WAIT)) {
 		struct radix_tree_preload *rtp;
 
 		rtp = &__get_cpu_var(radix_tree_preloads);
@@ -152,6 +158,27 @@ static inline int tag_get(struct radix_t
 	return test_bit(offset, node->tags[tag]);
 }
 
+static inline void root_tag_set(struct radix_tree_root *root, unsigned int tag)
+{
+	root->gfp_mask |= (1 << (tag + __GFP_BITS_SHIFT));
+}
+
+
+static inline void root_tag_clear(struct radix_tree_root *root, unsigned int tag)
+{
+	root->gfp_mask &= ~(1 << (tag + __GFP_BITS_SHIFT));
+}
+
+static inline void root_tag_clear_all(struct radix_tree_root *root)
+{
+	root->gfp_mask &= __GFP_BITS_MASK;
+}
+
+static inline int root_tag_get(struct radix_tree_root *root, unsigned int tag)
+{
+	return root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT));
+}
+
 /*
  * Returns 1 if any slot in the node has this tag set.
  * Otherwise returns 0.
@@ -182,7 +209,6 @@ static int radix_tree_extend(struct radi
 {
 	struct radix_tree_node *node;
 	unsigned int height;
-	char tags[RADIX_TREE_MAX_TAGS];
 	int tag;
 
 	/* Figure out what the height should be.  */
@@ -195,16 +221,6 @@ static int radix_tree_extend(struct radi
 		goto out;
 	}
 
-	/*
-	 * Prepare the tag status of the top-level node for propagation
-	 * into the newly-pushed top-level node(s)
-	 */
-	for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-		tags[tag] = 0;
-		if (any_tag_set(root->rnode, tag))
-			tags[tag] = 1;
-	}
-
 	do {
 		if (!(node = radix_tree_node_alloc(root)))
 			return -ENOMEM;
@@ -214,7 +230,7 @@ static int radix_tree_extend(struct radi
 
 		/* Propagate the aggregated tag info into the new root */
 		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-			if (tags[tag])
+			if (root_tag_get(root, tag))
 				tag_set(node, tag, 0);
 		}
 
@@ -243,8 +259,7 @@ int radix_tree_insert(struct radix_tree_
 	int error;
 
 	/* Make sure the tree is high enough.  */
-	if ((!index && !root->rnode) ||
-			index > radix_tree_maxindex(root->height)) {
+	if (index > radix_tree_maxindex(root->height)) {
 		error = radix_tree_extend(root, index);
 		if (error)
 			return error;
@@ -255,7 +270,7 @@ int radix_tree_insert(struct radix_tree_
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 
 	offset = 0;			/* uninitialised var warning */
-	do {
+	while (height > 0) {
 		if (slot == NULL) {
 			/* Have to add a child node.  */
 			if (!(slot = radix_tree_node_alloc(root)))
@@ -273,16 +288,21 @@ int radix_tree_insert(struct radix_tree_
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
+	} else {
+		root->rnode = item;
+		BUG_ON(root_tag_get(root, 0));
+		BUG_ON(root_tag_get(root, 1));
+	}
 
 	return 0;
 }
@@ -295,9 +315,13 @@ static inline void **__lookup_slot(struc
 	struct radix_tree_node **slot;
 
 	height = root->height;
+
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
+	if (height == 0 && root->rnode)
+		return (void **)&root->rnode;
+
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = &root->rnode;
 
@@ -368,8 +392,8 @@ void *radix_tree_tag_set(struct radix_tr
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
-	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
+	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 
 	while (height > 0) {
 		int offset;
@@ -383,6 +407,10 @@ void *radix_tree_tag_set(struct radix_tr
 		height--;
 	}
 
+	/* set the root's tag bit */
+	if (slot && !root_tag_get(root, tag))
+		root_tag_set(root, tag);
+
 	return slot;
 }
 EXPORT_SYMBOL(radix_tree_tag_set);
@@ -405,9 +433,8 @@ void *radix_tree_tag_clear(struct radix_
 			unsigned long index, unsigned int tag)
 {
 	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
-	struct radix_tree_node *slot;
+	struct radix_tree_node *slot = NULL;
 	unsigned int height, shift;
-	void *ret = NULL;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
@@ -432,20 +459,24 @@ void *radix_tree_tag_clear(struct radix_
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
+	if (root_tag_get(root, tag))
+		root_tag_clear(root, tag);
+
 out:
-	return ret;
+	return slot;
 }
 EXPORT_SYMBOL(radix_tree_tag_clear);
 
@@ -458,9 +489,8 @@ EXPORT_SYMBOL(radix_tree_tag_clear);
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
@@ -473,6 +503,13 @@ int radix_tree_tag_get(struct radix_tree
 	if (index > radix_tree_maxindex(height))
 		return 0;
 
+	/* check the root's tag bit */
+	if (!root_tag_get(root, tag))
+		return 0;
+
+	if (height == 0)
+		return 1;
+
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
@@ -494,7 +531,7 @@ int radix_tree_tag_get(struct radix_tree
 			int ret = tag_get(slot, tag, offset);
 
 			BUG_ON(ret && saw_unset_tag);
-			return ret ? 1 : -1;
+			return ret;
 		}
 		slot = slot->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
@@ -514,8 +551,11 @@ __lookup(struct radix_tree_root *root, v
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
@@ -603,10 +643,16 @@ __lookup_tag(struct radix_tree_root *roo
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
@@ -637,7 +683,7 @@ __lookup_tag(struct radix_tree_root *roo
 		}
 		shift -= RADIX_TREE_MAP_SHIFT;
 		slot = slot->slots[i];
-	}
+	} while (height > 0);
 out:
 	*next_index = index;
 	return nr_found;
@@ -665,6 +711,10 @@ radix_tree_gang_lookup_tag(struct radix_
 	unsigned long cur_index = first_index;
 	unsigned int ret = 0;
 
+	/* check the root's tag bit */
+	if (!root_tag_get(root, tag))
+		return 0;
+
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
@@ -689,7 +739,7 @@ EXPORT_SYMBOL(radix_tree_gang_lookup_tag
 static inline void radix_tree_shrink(struct radix_tree_root *root)
 {
 	/* try to shrink tree height */
-	while (root->height > 1 &&
+	while (root->height > 0 &&
 			root->rnode->count == 1 &&
 			root->rnode->slots[0]) {
 		struct radix_tree_node *to_free = root->rnode;
@@ -717,12 +767,8 @@ static inline void radix_tree_shrink(str
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
 
@@ -730,11 +776,17 @@ void *radix_tree_delete(struct radix_tre
 	if (index > radix_tree_maxindex(height))
 		goto out;
 
+	slot = root->rnode;
+	if (height == 0 && root->rnode) {
+		root_tag_clear_all(root);
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
 
@@ -744,44 +796,22 @@ void *radix_tree_delete(struct radix_tre
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
 
@@ -793,11 +823,15 @@ void *radix_tree_delete(struct radix_tre
 
 		/* Node with zero slots in use so free it */
 		radix_tree_node_free(pathp->node);
+
+		pathp--;
 	}
-	root->rnode = NULL;
+	root_tag_clear_all(root);
 	root->height = 0;
+	root->rnode = NULL;
+
 out:
-	return ret;
+	return slot;
 }
 EXPORT_SYMBOL(radix_tree_delete);
 
@@ -808,11 +842,7 @@ EXPORT_SYMBOL(radix_tree_delete);
  */
 int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag)
 {
-  	struct radix_tree_node *rnode;
-  	rnode = root->rnode;
-  	if (!rnode)
-  		return 0;
-	return any_tag_set(rnode, tag);
+	return root_tag_get(root, tag);
 }
 EXPORT_SYMBOL(radix_tree_tagged);
 
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
