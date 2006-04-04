Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWDDJb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWDDJb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWDDJb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:31:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:1763 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932422AbWDDJb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:31:56 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060219020149.9923.74729.sendpatchset@linux.site>
In-Reply-To: <20060219020140.9923.43378.sendpatchset@linux.site>
References: <20060219020140.9923.43378.sendpatchset@linux.site>
Subject: [patch 1/3] radix tree: RCU lockless read-side
Date: Tue,  4 Apr 2006 11:31:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make radix tree lookups safe to be performed without locks. Readers
are protected against nodes being deleted by using RCU based freeing.
Readers are protected against new node insertion by using memory
barriers to ensure the node itself will be properly written before it
is visible in the radix tree.

Each radix tree node keeps a record of their height (above leaf
nodes). This height does not change after insertion -- when the radix
tree is extended, higher nodes are only inserted in the top. So a
lookup can take the pointer to what is *now* the root node, and
traverse down it even if the tree is concurrently extended and this
node becomes a subtree of a new root.

When a reader wants to traverse the next branch, they will take a
copy of the pointer. This pointer will be either NULL (and the branch
is empty) or non-NULL (and will point to a valid node).

Also introduce a lockfree gang_lookup_slot which will be used by a
future patch.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -30,6 +30,7 @@
 #include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
+#include <linux/rcupdate.h>
 
 
 #ifdef __KERNEL__
@@ -45,7 +46,9 @@
 	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
 struct radix_tree_node {
+	unsigned int	height;		/* Height from the bottom */
 	unsigned int	count;
+	struct rcu_head	rcu_head;
 	void		*slots[RADIX_TREE_MAP_SIZE];
 	unsigned long	tags[RADIX_TREE_MAX_TAGS][RADIX_TREE_TAG_LONGS];
 };
@@ -97,10 +100,17 @@ radix_tree_node_alloc(struct radix_tree_
 	return ret;
 }
 
+static void radix_tree_node_rcu_free(struct rcu_head *head)
+{
+	struct radix_tree_node *node =
+			container_of(head, struct radix_tree_node, rcu_head);
+	kmem_cache_free(radix_tree_node_cachep, node);
+}
+
 static inline void
 radix_tree_node_free(struct radix_tree_node *node)
 {
-	kmem_cache_free(radix_tree_node_cachep, node);
+	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
 /*
@@ -206,6 +216,7 @@ static int radix_tree_extend(struct radi
 	}
 
 	do {
+		unsigned int newheight;
 		if (!(node = radix_tree_node_alloc(root)))
 			return -ENOMEM;
 
@@ -218,9 +229,11 @@ static int radix_tree_extend(struct radi
 				tag_set(node, tag, 0);
 		}
 
+		newheight = root->height+1;
+		node->height = newheight;
 		node->count = 1;
-		root->rnode = node;
-		root->height++;
+		rcu_assign_pointer(root->rnode, node);
+		root->height = newheight;
 	} while (height > root->height);
 out:
 	return 0;
@@ -260,11 +273,12 @@ int radix_tree_insert(struct radix_tree_
 			/* Have to add a child node.  */
 			if (!(slot = radix_tree_node_alloc(root)))
 				return -ENOMEM;
+			slot->height = height;
 			if (node) {
-				node->slots[offset] = slot;
+				rcu_assign_pointer(node->slots[offset], slot);
 				node->count++;
 			} else
-				root->rnode = slot;
+				rcu_assign_pointer(root->rnode, slot);
 		}
 
 		/* Go a level down */
@@ -280,7 +294,7 @@ int radix_tree_insert(struct radix_tree_
 
 	BUG_ON(!node);
 	node->count++;
-	node->slots[offset] = item;
+	rcu_assign_pointer(node->slots[offset], item);
 	BUG_ON(tag_get(node, 0, offset));
 	BUG_ON(tag_get(node, 1, offset));
 
@@ -292,25 +306,29 @@ static inline void **__lookup_slot(struc
 				   unsigned long index)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *node, **slot;
 
-	height = root->height;
+	/* Must take a copy now because root->rnode may change */
+	node = rcu_dereference(root->rnode);
+	if (node == NULL)
+		return NULL;
+
+	height = node->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
 
-	while (height > 0) {
-		if (*slot == NULL)
+	do {
+		slot = (struct radix_tree_node **)
+			(node->slots + ((index>>shift) & RADIX_TREE_MAP_MASK));
+		node = rcu_dereference(*slot);
+		if (node == NULL)
 			return NULL;
 
-		slot = (struct radix_tree_node **)
-			((*slot)->slots +
-				((index >> shift) & RADIX_TREE_MAP_MASK));
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
-	}
+	} while (height > 0);
 
 	return (void **)slot;
 }
@@ -322,6 +340,12 @@ static inline void **__lookup_slot(struc
  *
  *	Lookup the slot corresponding to the position @index in the radix tree
  *	@root. This is useful for update-if-exists operations.
+ *
+ *	This function can be called under rcu_read_lock, however it is the
+ *	duty of the caller to manage the lifetimes of the leaf nodes (ie.
+ *	they would usually be RCU protected as well). Also, dereferencing
+ *	the slot pointer would require rcu_dereference, and modifying it
+ *	would require rcu_assign_pointer.
  */
 void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
 {
@@ -335,13 +359,18 @@ EXPORT_SYMBOL(radix_tree_lookup_slot);
  *	@index:		index key
  *
  *	Lookup the item at the position @index in the radix tree @root.
+ *
+ *	Like radix_tree_lookup_slot, this function can be called under
+ *	rcu_read_lock, and likewise the caller must manage lifetimes of
+ *	leaf nodes. No RCU barriers are required to access or modify the
+ *	returned item, however.
  */
 void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
 {
 	void **slot;
 
 	slot = __lookup_slot(root, index);
-	return slot != NULL ? *slot : NULL;
+	return slot != NULL ? rcu_dereference(*slot) : NULL;
 }
 EXPORT_SYMBOL(radix_tree_lookup);
 
@@ -505,7 +534,7 @@ EXPORT_SYMBOL(radix_tree_tag_get);
 #endif
 
 static unsigned int
-__lookup(struct radix_tree_root *root, void **results, unsigned long index,
+__lookup(struct radix_tree_root *root, void ***results, unsigned long index,
 	unsigned int max_items, unsigned long *next_index)
 {
 	unsigned int nr_found = 0;
@@ -513,18 +542,20 @@ __lookup(struct radix_tree_root *root, v
 	struct radix_tree_node *slot;
 	unsigned long i;
 
-	height = root->height;
-	if (height == 0)
+	slot = rcu_dereference(root->rnode);
+	if (!slot || slot->height == 0)
 		goto out;
 
+	height = slot->height;
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = root->rnode;
 
 	for ( ; height > 1; height--) {
+		struct radix_tree_node *__s;
 
 		for (i = (index >> shift) & RADIX_TREE_MAP_MASK ;
 				i < RADIX_TREE_MAP_SIZE; i++) {
-			if (slot->slots[i] != NULL)
+			__s = rcu_dereference(slot->slots[i]);
+			if (__s != NULL)
 				break;
 			index &= ~((1UL << shift) - 1);
 			index += 1UL << shift;
@@ -535,14 +566,14 @@ __lookup(struct radix_tree_root *root, v
 			goto out;
 
 		shift -= RADIX_TREE_MAP_SHIFT;
-		slot = slot->slots[i];
+		slot = __s;
 	}
 
 	/* Bottom level: grab some items */
 	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
 		index++;
 		if (slot->slots[i]) {
-			results[nr_found++] = slot->slots[i];
+			results[nr_found++] = &slot->slots[i];
 			if (nr_found == max_items)
 				goto out;
 		}
@@ -572,6 +603,46 @@ radix_tree_gang_lookup(struct radix_tree
 	const unsigned long max_index = radix_tree_maxindex(root->height);
 	unsigned long cur_index = first_index;
 	unsigned int ret = 0;
+	void ***__results = (void ***)results; /* use results as a temporary
+						* store for the pointers to
+						* the actual results */
+
+	while (ret < max_items) {
+		unsigned int nr_found, i;
+		unsigned long next_index;	/* Index of next search */
+
+		if (cur_index > max_index)
+			break;
+		nr_found = __lookup(root, __results + ret, cur_index,
+					max_items - ret, &next_index);
+		for (i = 0; i < nr_found; i++)
+			results[ret + i] = *rcu_dereference(__results[ret + i]);
+		ret += nr_found;
+		if (next_index == 0)
+			break;
+		cur_index = next_index;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(radix_tree_gang_lookup);
+
+/**
+ *	radix_tree_gang_lookup_slot - perform multiple lookup on a radix tree
+ *	@root:		radix tree root
+ *	@results:	where the results of the lookup are placed
+ *	@first_index:	start the lookup from this key
+ *	@max_items:	place up to this many items at *results
+ *
+ *	Same as radix_tree_gang_lookup, but returns an array of pointers
+ *	(slots) to the stored items instead of the items themselves.
+ */
+unsigned int
+radix_tree_gang_lookup_slot(struct radix_tree_root *root, void ***results,
+			unsigned long first_index, unsigned int max_items)
+{
+	const unsigned long max_index = radix_tree_maxindex(root->height);
+	unsigned long cur_index = first_index;
+	unsigned int ret = 0;
 
 	while (ret < max_items) {
 		unsigned int nr_found;
@@ -588,7 +659,8 @@ radix_tree_gang_lookup(struct radix_tree
 	}
 	return ret;
 }
-EXPORT_SYMBOL(radix_tree_gang_lookup);
+EXPORT_SYMBOL_GPL(radix_tree_gang_lookup_slot);
+
 
 /*
  * FIXME: the two tag_get()s here should use find_next_bit() instead of
@@ -694,6 +766,11 @@ static inline void radix_tree_shrink(str
 			root->rnode->slots[0]) {
 		struct radix_tree_node *to_free = root->rnode;
 
+		/*
+		 * this doesn't need an rcu_assign_pointer, because
+		 * we aren't touching the object that to_free->slots[0]
+		 * points to.
+		 */
 		root->rnode = to_free->slots[0];
 		root->height--;
 		/* must only free zeroed nodes into the slab */
@@ -809,7 +886,7 @@ EXPORT_SYMBOL(radix_tree_delete);
 int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag)
 {
   	struct radix_tree_node *rnode;
-  	rnode = root->rnode;
+  	rnode = rcu_dereference(root->rnode);
   	if (!rnode)
   		return 0;
 	return any_tag_set(rnode, tag);
Index: linux-2.6/include/linux/radix-tree.h
===================================================================
--- linux-2.6.orig/include/linux/radix-tree.h
+++ linux-2.6/include/linux/radix-tree.h
@@ -54,6 +54,9 @@ void *radix_tree_delete(struct radix_tre
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
+unsigned int
+radix_tree_gang_lookup_slot(struct radix_tree_root *root, void ***results,
+			unsigned long first_index, unsigned int max_items);
 int radix_tree_preload(gfp_t gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
