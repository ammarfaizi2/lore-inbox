Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWFTOtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWFTOtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWFTOtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:49:09 -0400
Received: from mx1.suse.de ([195.135.220.2]:27552 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751190AbWFTOsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:48:54 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060408134707.22479.33814.sendpatchset@linux.site>
In-Reply-To: <20060408134635.22479.79269.sendpatchset@linux.site>
References: <20060408134635.22479.79269.sendpatchset@linux.site>
Subject: [patch 3/3] radix-tree: RCU lockless readside
Date: Tue, 20 Jun 2006 16:48:48 +0200 (CEST)
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

"Direct" pointers (tree height of 0, where root->rnode points directly
to the data item) are handled by using the low bit of the pointer to
signal whether rnode is a direct pointer or a pointer to a radix tree
node.

When a reader wants to traverse the next branch, they will take a
copy of the pointer. This pointer will be either NULL (and the branch
is empty) or non-NULL (and will point to a valid node).

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
@@ -100,13 +103,21 @@ radix_tree_node_alloc(struct radix_tree_
 			rtp->nr--;
 		}
 	}
+	BUG_ON(radix_tree_is_direct_ptr(ret));
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
@@ -222,11 +233,12 @@ static int radix_tree_extend(struct radi
 	}
 
 	do {
+		unsigned int newheight;
 		if (!(node = radix_tree_node_alloc(root)))
 			return -ENOMEM;
 
 		/* Increase the height.  */
-		node->slots[0] = root->rnode;
+		node->slots[0] = radix_tree_direct_to_ptr(root->rnode);
 
 		/* Propagate the aggregated tag info into the new root */
 		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
@@ -234,9 +246,11 @@ static int radix_tree_extend(struct radi
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
@@ -258,6 +272,8 @@ int radix_tree_insert(struct radix_tree_
 	int offset;
 	int error;
 
+	BUG_ON(radix_tree_is_direct_ptr(item));
+
 	/* Make sure the tree is high enough.  */
 	if (index > radix_tree_maxindex(root->height)) {
 		error = radix_tree_extend(root, index);
@@ -275,11 +291,12 @@ int radix_tree_insert(struct radix_tree_
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
@@ -295,11 +312,11 @@ int radix_tree_insert(struct radix_tree_
 
 	if (node) {
 		node->count++;
-		node->slots[offset] = item;
+		rcu_assign_pointer(node->slots[offset], item);
 		BUG_ON(tag_get(node, 0, offset));
 		BUG_ON(tag_get(node, 1, offset));
 	} else {
-		root->rnode = item;
+		rcu_assign_pointer(root->rnode, radix_tree_ptr_to_direct(item));
 		BUG_ON(root_tag_get(root, 0));
 		BUG_ON(root_tag_get(root, 1));
 	}
@@ -308,49 +325,51 @@ int radix_tree_insert(struct radix_tree_
 }
 EXPORT_SYMBOL(radix_tree_insert);
 
-static inline void **__lookup_slot(struct radix_tree_root *root,
-				   unsigned long index)
+/**
+ *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the slot corresponding to the position @index in the radix tree
+ *	@root. This is useful for update-if-exists operations.
+ *
+ *	This function cannot be called under rcu_read_lock, it must be
+ *	excluded from writers, as must the returned slot.
+ */
+void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
-
-	height = root->height;
+	struct radix_tree_node *node, **slot;
 
-	if (index > radix_tree_maxindex(height))
+	node = rcu_dereference(root->rnode);
+	if (node == NULL)
 		return NULL;
 
-	if (height == 0 && root->rnode)
+	if (radix_tree_is_direct_ptr(node)) {
+		if (index > 0)
+			return NULL;
 		return (void **)&root->rnode;
+	}
+
+	height = node->height;
+	if (index > radix_tree_maxindex(height))
+		return NULL;
 
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
-
-/**
- *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
- *	@root:		radix tree root
- *	@index:		index key
- *
- *	Lookup the slot corresponding to the position @index in the radix tree
- *	@root. This is useful for update-if-exists operations.
- */
-void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
-{
-	return __lookup_slot(root, index);
-}
 EXPORT_SYMBOL(radix_tree_lookup_slot);
 
 /**
@@ -359,13 +378,45 @@ EXPORT_SYMBOL(radix_tree_lookup_slot);
  *	@index:		index key
  *
  *	Lookup the item at the position @index in the radix tree @root.
+ *
+ *	This function can be called under rcu_read_lock, however the caller
+ *	must manage lifetimes of leaf nodes (eg. RCU may also be used to free
+ *	them safely). No RCU barriers are required to access or modify the
+ *	returned item, however.
  */
 void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
 {
-	void **slot;
+	unsigned int height, shift;
+	struct radix_tree_node *node, **slot;
+
+	node = rcu_dereference(root->rnode);
+	if (node == NULL)
+		return NULL;
+
+	if (radix_tree_is_direct_ptr(node)) {
+		if (index > 0)
+			return NULL;
+		return radix_tree_direct_to_ptr(node);
+	}
+
+	height = node->height;
+	if (index > radix_tree_maxindex(height))
+		return NULL;
 
-	slot = __lookup_slot(root, index);
-	return slot != NULL ? *slot : NULL;
+	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
+
+	do {
+		slot = (struct radix_tree_node **)
+			(node->slots + ((index>>shift) & RADIX_TREE_MAP_MASK));
+		node = rcu_dereference(*slot);
+		if (node == NULL)
+			return NULL;
+
+		shift -= RADIX_TREE_MAP_SHIFT;
+		height--;
+	} while (height > 0);
+
+	return node;
 }
 EXPORT_SYMBOL(radix_tree_lookup);
 
@@ -542,29 +593,25 @@ EXPORT_SYMBOL(radix_tree_tag_get);
 #endif
 
 static unsigned int
-__lookup(struct radix_tree_root *root, void **results, unsigned long index,
+__lookup(struct radix_tree_node *slot, void **results, unsigned long index,
 	unsigned int max_items, unsigned long *next_index)
 {
 	unsigned int nr_found = 0;
 	unsigned int shift, height;
-	struct radix_tree_node *slot;
 	unsigned long i;
 
-	height = root->height;
-	if (height == 0) {
-		if (root->rnode && index == 0)
-			results[nr_found++] = root->rnode;
+	height = slot->height;
+	if (height == 0)
 		goto out;
-	}
-
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
@@ -575,14 +622,16 @@ __lookup(struct radix_tree_root *root, v
 			goto out;
 
 		shift -= RADIX_TREE_MAP_SHIFT;
-		slot = slot->slots[i];
+		slot = __s;
 	}
 
 	/* Bottom level: grab some items */
 	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
+		struct radix_tree_node *node;
 		index++;
-		if (slot->slots[i]) {
-			results[nr_found++] = slot->slots[i];
+		node = slot->slots[i];
+		if (node) {
+			results[nr_found++] = node;
 			if (nr_found == max_items)
 				goto out;
 		}
@@ -604,28 +653,54 @@ out:
  *	*@results.
  *
  *	The implementation is naive.
+ *
+ *	Like radix_tree_lookup, radix_tree_gang_lookup may be called under
+ *	rcu_read_lock. In this case, rather than the returned results being
+ *	an atomic snapshot of the tree at a single point in time, the semantics
+ *	of an RCU protected gang lookup are as though multiple radix_tree_lookups
+ *	have been issued in individual locks, and results stored in 'results'.
  */
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items)
 {
-	const unsigned long max_index = radix_tree_maxindex(root->height);
+	unsigned long max_index;
+	struct radix_tree_node *node;
 	unsigned long cur_index = first_index;
-	unsigned int ret = 0;
+	unsigned int ret;
+
+	node = rcu_dereference(root->rnode);
+	if (!node)
+		return 0;
+
+	if (radix_tree_is_direct_ptr(node)) {
+		if (first_index > 0)
+			return 0;
+		results[0] = radix_tree_direct_to_ptr(node);
+		ret = 1;
+		goto out;
+	}
 
+	max_index = radix_tree_maxindex(node->height);
+
+	ret = 0;
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
 
 		if (cur_index > max_index)
 			break;
-		nr_found = __lookup(root, results + ret, cur_index,
+		nr_found = __lookup(node, results + ret, cur_index,
 					max_items - ret, &next_index);
 		ret += nr_found;
 		if (next_index == 0)
 			break;
 		cur_index = next_index;
 	}
+
+out:
+	(void)rcu_dereference(results); /* single barrier for all results */
+
 	return ret;
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup);
@@ -635,24 +710,16 @@ EXPORT_SYMBOL(radix_tree_gang_lookup);
  * open-coding the search.
  */
 static unsigned int
-__lookup_tag(struct radix_tree_root *root, void **results, unsigned long index,
+__lookup_tag(struct radix_tree_node *slot, void **results, unsigned long index,
 	unsigned int max_items, unsigned long *next_index, unsigned int tag)
 {
 	unsigned int nr_found = 0;
 	unsigned int shift;
-	unsigned int height = root->height;
-	struct radix_tree_node *slot;
-
-	if (height == 0) {
-		if (root->rnode && index == 0)
-			results[nr_found++] = root->rnode;
-		goto out;
-	}
+	unsigned int height = slot->height;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
-	slot = root->rnode;
 
-	do {
+	while (height > 0) {
 		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
 
 		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
@@ -683,7 +750,7 @@ __lookup_tag(struct radix_tree_root *roo
 		}
 		shift -= RADIX_TREE_MAP_SHIFT;
 		slot = slot->slots[i];
-	} while (height > 0);
+	}
 out:
 	*next_index = index;
 	return nr_found;
@@ -707,7 +774,8 @@ radix_tree_gang_lookup_tag(struct radix_
 		unsigned long first_index, unsigned int max_items,
 		unsigned int tag)
 {
-	const unsigned long max_index = radix_tree_maxindex(root->height);
+	struct radix_tree_node *node;
+	unsigned long max_index;
 	unsigned long cur_index = first_index;
 	unsigned int ret = 0;
 
@@ -715,13 +783,27 @@ radix_tree_gang_lookup_tag(struct radix_
 	if (!root_tag_get(root, tag))
 		return 0;
 
+	node = rcu_dereference(root->rnode);
+	if (!node)
+		return ret;
+
+	if (radix_tree_is_direct_ptr(node)) {
+		if (first_index > 0)
+			return 0;
+		node = radix_tree_direct_to_ptr(node);
+		results[0] = node;
+		return 1;
+	}
+
+	max_index = radix_tree_maxindex(node->height);
+
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
 
 		if (cur_index > max_index)
 			break;
-		nr_found = __lookup_tag(root, results + ret, cur_index,
+		nr_found = __lookup_tag(node, results + ret, cur_index,
 					max_items - ret, &next_index, tag);
 		ret += nr_found;
 		if (next_index == 0)
@@ -743,8 +825,17 @@ static inline void radix_tree_shrink(str
 			root->rnode->count == 1 &&
 			root->rnode->slots[0]) {
 		struct radix_tree_node *to_free = root->rnode;
+		void *newptr;
 
-		root->rnode = to_free->slots[0];
+		/*
+		 * this doesn't need an rcu_assign_pointer, because
+		 * we aren't touching the object that to_free->slots[0]
+		 * points to.
+		 */
+		newptr = to_free->slots[0];
+		if (root->height == 1)
+			newptr = radix_tree_ptr_to_direct(newptr);
+		root->rnode = newptr;
 		root->height--;
 		/* must only free zeroed nodes into the slab */
 		tag_clear(to_free, 0, 0);
@@ -768,6 +859,7 @@ void *radix_tree_delete(struct radix_tre
 {
 	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
 	struct radix_tree_node *slot = NULL;
+	struct radix_tree_node *to_free;
 	unsigned int height, shift;
 	int tag;
 	int offset;
@@ -778,6 +870,7 @@ void *radix_tree_delete(struct radix_tre
 
 	slot = root->rnode;
 	if (height == 0 && root->rnode) {
+		slot = radix_tree_direct_to_ptr(slot);
 		root_tag_clear_all(root);
 		root->rnode = NULL;
 		goto out;
@@ -810,8 +903,11 @@ void *radix_tree_delete(struct radix_tre
 			radix_tree_tag_clear(root, index, tag);
 	}
 
+	to_free = NULL;
 	/* Now free the nodes we do not need anymore */
 	while (pathp->node) {
+		if (to_free)
+			radix_tree_node_free(to_free);
 		pathp->node->slots[pathp->offset] = NULL;
 		pathp->node->count--;
 
@@ -822,13 +918,15 @@ void *radix_tree_delete(struct radix_tre
 		}
 
 		/* Node with zero slots in use so free it */
-		radix_tree_node_free(pathp->node);
-
+		to_free = pathp->node;
 		pathp--;
+
 	}
 	root_tag_clear_all(root);
 	root->height = 0;
 	root->rnode = NULL;
+	if (to_free)
+		radix_tree_node_free(to_free);
 
 out:
 	return slot;
Index: linux-2.6/include/linux/radix-tree.h
===================================================================
--- linux-2.6.orig/include/linux/radix-tree.h
+++ linux-2.6/include/linux/radix-tree.h
@@ -22,6 +22,8 @@
 #include <linux/sched.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/rcupdate.h>
 
 #define RADIX_TREE_MAX_TAGS 2
 
@@ -48,6 +50,37 @@ do {									\
 	(root)->rnode = NULL;						\
 } while (0)
 
+#define RADIX_TREE_DIRECT_PTR	1
+
+static inline void *radix_tree_ptr_to_direct(void *ptr)
+{
+	return (void *)((unsigned long)ptr | RADIX_TREE_DIRECT_PTR);
+}
+
+static inline void *radix_tree_direct_to_ptr(void *ptr)
+{
+	return (void *)((unsigned long)ptr & ~RADIX_TREE_DIRECT_PTR);
+}
+
+static inline int radix_tree_is_direct_ptr(void *ptr)
+{
+	return (int)((unsigned long)ptr & RADIX_TREE_DIRECT_PTR);
+}
+
+static inline void *__radix_tree_deref_slot(void **slot)
+{
+	return rcu_dereference(radix_tree_direct_to_ptr(*slot));
+}
+
+#define radix_tree_deref_slot(slot) __radix_tree_deref_slot((void **)slot)
+
+static inline void radix_tree_replace_slot(void **slot, void *item)
+{
+	BUG_ON(radix_tree_is_direct_ptr(item));
+	rcu_assign_pointer(*slot,
+		(void *)((unsigned long)item | ((unsigned long)*slot & RADIX_TREE_DIRECT_PTR)));
+}
+
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
 void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
 void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
Index: linux-2.6/mm/migrate.c
===================================================================
--- linux-2.6.orig/mm/migrate.c
+++ linux-2.6/mm/migrate.c
@@ -228,7 +228,7 @@ int migrate_page_remove_references(struc
 						page_index(page));
 
 	if (!page_mapping(page) || page_count(page) != nr_refs ||
-			*radix_pointer != page) {
+			radix_tree_deref_slot(radix_pointer) != page) {
 		write_unlock_irq(&mapping->tree_lock);
 		return -EAGAIN;
 	}
@@ -249,7 +249,7 @@ int migrate_page_remove_references(struc
 		set_page_private(newpage, page_private(page));
 	}
 
-	*radix_pointer = newpage;
+	radix_tree_replace_slot(radix_pointer, newpage);
 	__put_page(page);
 	write_unlock_irq(&mapping->tree_lock);
 
