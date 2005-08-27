Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVH0AUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVH0AUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVH0AUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:20:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:238 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965125AbVH0AUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:20:42 -0400
Date: Fri, 26 Aug 2005 17:20:39 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: nickpiggin@yahoo.com.au
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] radix-tree: Remove unnecessary indirections and clean up
 code
Message-ID: <Pine.LNX.4.62.0508261715370.17860@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking about Nick's lockless pagecache patches and had a look at 
radix-tree.c. At first I had some trouble with some of the way things 
were done but after getting used to the style it became clear. However, 
I'd like to have these things fixed so that others do not get tripped up 
too.

---
[PATCH] radix-tree: Remove unnecessary indirections and clean up code

- There is frequent use of indirections in the radix code. This patch
  removes those indirections, makes the code more readable and allows
  the compilers to generate better code.

- Removing indirections allows the removal of several casts.

- Removing indirections allows the reduction of the radix_tree_path
  size from 3 to 2 words.

- Use pathp-> consistently.

- Remove unnecessary tmp variable in radix_tree_insert

- Separate the upper layer processing from the lowest layer in __lookup()
  in order to make it easier to understand what is going on and allow
  compilers to generate better code for the loop.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.13-rc7/lib/radix-tree.c
===================================================================
--- linux-2.6.13-rc7.orig/lib/radix-tree.c	2005-08-23 20:39:14.000000000 -0700
+++ linux-2.6.13-rc7/lib/radix-tree.c	2005-08-26 17:10:54.000000000 -0700
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2001 Momchil Velikov
  * Portions Copyright (C) 2001 Christoph Hellwig
+ * Copyright (C) 2005 SGI, Christoph Lameter <clameter@sgi.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -51,7 +52,7 @@ struct radix_tree_node {
 };
 
 struct radix_tree_path {
-	struct radix_tree_node *node, **slot;
+	struct radix_tree_node *node;
 	int offset;
 };
 
@@ -227,7 +228,7 @@ out:
 int radix_tree_insert(struct radix_tree_root *root,
 			unsigned long index, void *item)
 {
-	struct radix_tree_node *node = NULL, *tmp, **slot;
+	struct radix_tree_node *node = NULL, *slot;
 	unsigned int height, shift;
 	int offset;
 	int error;
@@ -240,38 +241,42 @@ int radix_tree_insert(struct radix_tree_
 			return error;
 	}
 
-	slot = &root->rnode;
+	slot = root->rnode;
 	height = root->height;
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 
 	offset = 0;			/* uninitialised var warning */
 	while (height > 0) {
-		if (*slot == NULL) {
+		if (slot == NULL) {
 			/* Have to add a child node.  */
-			if (!(tmp = radix_tree_node_alloc(root)))
+			if (!(slot = radix_tree_node_alloc(root)))
 				return -ENOMEM;
-			*slot = tmp;
-			if (node)
+			if (node) {
+				node->slots[offset] = slot;
 				node->count++;
+			} else
+				root->rnode = slot;
 		}
 
 		/* Go a level down */
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
-		node = *slot;
-		slot = (struct radix_tree_node **)(node->slots + offset);
+		node = slot;
+		slot = node->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	if (*slot != NULL)
+	if (slot != NULL)
 		return -EEXIST;
+
 	if (node) {
 		node->count++;
+		node->slots[offset] = item;
 		BUG_ON(tag_get(node, 0, offset));
 		BUG_ON(tag_get(node, 1, offset));
-	}
+	} else
+		root->rnode = item;
 
-	*slot = item;
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_insert);
@@ -286,27 +291,25 @@ EXPORT_SYMBOL(radix_tree_insert);
 void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *slot;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
+	slot = root->rnode;
 
 	while (height > 0) {
-		if (*slot == NULL)
+		if (slot == NULL)
 			return NULL;
 
-		slot = (struct radix_tree_node **)
-			((*slot)->slots +
-				((index >> shift) & RADIX_TREE_MAP_MASK));
+		slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	return *slot;
+	return slot;
 }
 EXPORT_SYMBOL(radix_tree_lookup);
 
@@ -326,27 +329,27 @@ void *radix_tree_tag_set(struct radix_tr
 			unsigned long index, int tag)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *slot;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
+	slot = root->rnode;
 
 	while (height > 0) {
 		int offset;
 
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
-		tag_set(*slot, tag, offset);
-		slot = (struct radix_tree_node **)((*slot)->slots + offset);
-		BUG_ON(*slot == NULL);
+		tag_set(slot, tag, offset);
+		slot = slot->slots[offset];
+		BUG_ON(slot == NULL);
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	return *slot;
+	return slot;
 }
 EXPORT_SYMBOL(radix_tree_tag_set);
 
@@ -367,6 +370,7 @@ void *radix_tree_tag_clear(struct radix_
 			unsigned long index, int tag)
 {
 	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
+	struct radix_tree_node *slot;
 	unsigned int height, shift;
 	void *ret = NULL;
 
@@ -376,38 +380,37 @@ void *radix_tree_tag_clear(struct radix_
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	pathp->node = NULL;
-	pathp->slot = &root->rnode;
+	slot = root->rnode;
 
 	while (height > 0) {
 		int offset;
 
-		if (*pathp->slot == NULL)
+		if (slot == NULL)
 			goto out;
 
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
 		pathp[1].offset = offset;
-		pathp[1].node = *pathp[0].slot;
-		pathp[1].slot = (struct radix_tree_node **)
-				(pathp[1].node->slots + offset);
+		pathp[1].node = slot;
+		slot = slot->slots[offset];
 		pathp++;
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	ret = *pathp[0].slot;
+	ret = slot;
 	if (ret == NULL)
 		goto out;
 
 	do {
 		int idx;
 
-		tag_clear(pathp[0].node, tag, pathp[0].offset);
+		tag_clear(pathp->node, tag, pathp->offset);
 		for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-			if (pathp[0].node->tags[tag][idx])
+			if (pathp->node->tags[tag][idx])
 				goto out;
 		}
 		pathp--;
-	} while (pathp[0].node);
+	} while (pathp->node);
 out:
 	return ret;
 }
@@ -429,7 +432,7 @@ int radix_tree_tag_get(struct radix_tree
 			unsigned long index, int tag)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *slot;
 	int saw_unset_tag = 0;
 
 	height = root->height;
@@ -437,12 +440,12 @@ int radix_tree_tag_get(struct radix_tree
 		return 0;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
+	slot = root->rnode;
 
 	for ( ; ; ) {
 		int offset;
 
-		if (*slot == NULL)
+		if (slot == NULL)
 			return 0;
 
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
@@ -451,15 +454,15 @@ int radix_tree_tag_get(struct radix_tree
 		 * This is just a debug check.  Later, we can bale as soon as
 		 * we see an unset tag.
 		 */
-		if (!tag_get(*slot, tag, offset))
+		if (!tag_get(slot, tag, offset))
 			saw_unset_tag = 1;
 		if (height == 1) {
-			int ret = tag_get(*slot, tag, offset);
+			int ret = tag_get(slot, tag, offset);
 
 			BUG_ON(ret && saw_unset_tag);
 			return ret;
 		}
-		slot = (struct radix_tree_node **)((*slot)->slots + offset);
+		slot = slot->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
@@ -472,17 +475,21 @@ __lookup(struct radix_tree_root *root, v
 	unsigned int max_items, unsigned long *next_index)
 {
 	unsigned int nr_found = 0;
-	unsigned int shift;
-	unsigned int height = root->height;
+	unsigned int shift, height;
 	struct radix_tree_node *slot;
+	unsigned long i;
+
+	height = root->height;
+	if (height == 0)
+		goto out;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
-	while (height > 0) {
-		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
+	for ( ; height > 1; height--) {
 
-		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
+		for (i = (index >> shift) & RADIX_TREE_MAP_MASK ;
+				i < RADIX_TREE_MAP_SIZE; i++) {
 			if (slot->slots[i] != NULL)
 				break;
 			index &= ~((1UL << shift) - 1);
@@ -492,22 +499,20 @@ __lookup(struct radix_tree_root *root, v
 		}
 		if (i == RADIX_TREE_MAP_SIZE)
 			goto out;
-		height--;
-		if (height == 0) {	/* Bottom level: grab some items */
-			unsigned long j = index & RADIX_TREE_MAP_MASK;
 
-			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
-				index++;
-				if (slot->slots[j]) {
-					results[nr_found++] = slot->slots[j];
-					if (nr_found == max_items)
-						goto out;
-				}
-			}
-		}
 		shift -= RADIX_TREE_MAP_SHIFT;
 		slot = slot->slots[i];
 	}
+
+	/* Bottom level: grab some items */
+	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
+		index++;
+		if (slot->slots[i]) {
+			results[nr_found++] = slot->slots[i];
+			if (nr_found == max_items)
+				goto out;
+		}
+	}
 out:
 	*next_index = index;
 	return nr_found;
@@ -655,6 +660,7 @@ void *radix_tree_delete(struct radix_tre
 {
 	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
 	struct radix_tree_path *orig_pathp;
+	struct radix_tree_node *slot;
 	unsigned int height, shift;
 	void *ret = NULL;
 	char tags[RADIX_TREE_TAGS];
@@ -666,25 +672,23 @@ void *radix_tree_delete(struct radix_tre
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	pathp->node = NULL;
-	pathp->slot = &root->rnode;
+	slot = root->rnode;
 
-	while (height > 0) {
+	for ( ; height > 0; height--) {
 		int offset;
 
-		if (*pathp->slot == NULL)
+		if (slot == NULL)
 			goto out;
 
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
 		pathp[1].offset = offset;
-		pathp[1].node = *pathp[0].slot;
-		pathp[1].slot = (struct radix_tree_node **)
-				(pathp[1].node->slots + offset);
+		pathp[1].node = slot;
+		slot = slot->slots[offset];
 		pathp++;
 		shift -= RADIX_TREE_MAP_SHIFT;
-		height--;
 	}
 
-	ret = *pathp[0].slot;
+	ret = slot;
 	if (ret == NULL)
 		goto out;
 
@@ -704,10 +708,10 @@ void *radix_tree_delete(struct radix_tre
 			if (tags[tag])
 				continue;
 
-			tag_clear(pathp[0].node, tag, pathp[0].offset);
+			tag_clear(pathp->node, tag, pathp->offset);
 
 			for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-				if (pathp[0].node->tags[tag][idx]) {
+				if (pathp->node->tags[tag][idx]) {
 					tags[tag] = 1;
 					nr_cleared_tags--;
 					break;
@@ -715,18 +719,19 @@ void *radix_tree_delete(struct radix_tre
 			}
 		}
 		pathp--;
-	} while (pathp[0].node && nr_cleared_tags);
+	} while (pathp->node && nr_cleared_tags);
 
-	pathp = orig_pathp;
-	*pathp[0].slot = NULL;
-	while (pathp[0].node && --pathp[0].node->count == 0) {
-		pathp--;
-		BUG_ON(*pathp[0].slot == NULL);
-		*pathp[0].slot = NULL;
-		radix_tree_node_free(pathp[1].node);
+	/* Now free the nodes we do not need anymore */
+	for(pathp = orig_pathp; pathp->node; pathp--) {
+		pathp->node->slots[pathp->offset] = NULL;
+		if (--pathp->node->count)
+			goto out;
+
+		/* Node with zero slots in use so free it */
+		radix_tree_node_free(pathp->node);
 	}
-	if (root->rnode == NULL)
-		root->height = 0;
+	root->rnode = NULL;
+	root->height = 0;
 out:
 	return ret;
 }
