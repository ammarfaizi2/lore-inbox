Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVKIOUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVKIOUU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVKIOOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:14:17 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:24812 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750831AbVKIOOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:06 -0500
Message-Id: <20051109141448.974675000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:42 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/16] radix-tree: look-aside cache
Content-Disposition: inline; filename=radixtree-lookaside-cache.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a set of lookup functions to radix tree for the read-ahead
logic.  Other access patterns with high locality may also benefit from them.

Most of them are best inlined, so some macros/structs in .c are moved into .h.

- radix_tree_lookup_node(root, index, level)
	Perform partial lookup, return the @level'th parent of the slot at
	@index.

- radix_tree_cache_lookup(root, cache, index)
	Perform lookup with the aid of a look-aside cache.
- radix_tree_cache_xxx()
	Init/Query the cache.

- radix_tree_lookup_head(root, index, max_scan)
- radix_tree_lookup_tail(root, index, max_scan)
	[head, tail) is a segment with continuous pages. The functions
	search for the head and tail index of the segment at @index.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/radix-tree.h |  150 ++++++++++++++++++++++++++++++++++++++++++++-
 lib/radix-tree.c           |  142 ++++++++++++++++++++++++++++++++----------
 2 files changed, 255 insertions(+), 37 deletions(-)

--- linux-2.6.14-mm1.orig/include/linux/radix-tree.h
+++ linux-2.6.14-mm1/include/linux/radix-tree.h
@@ -22,12 +22,39 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#ifdef __KERNEL__
+#define RADIX_TREE_MAP_SHIFT	6
+#else
+#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
+#endif
+#define RADIX_TREE_TAGS		2
+
+#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
+#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
+
+#define RADIX_TREE_TAG_LONGS	\
+	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
+
+struct radix_tree_node {
+	unsigned int	count;
+	void		*slots[RADIX_TREE_MAP_SIZE];
+	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
+};
+
 struct radix_tree_root {
 	unsigned int		height;
 	gfp_t			gfp_mask;
 	struct radix_tree_node	*rnode;
 };
 
+/*
+ * Support access patterns with strong locality.
+ */
+struct radix_tree_cache {
+	unsigned long first_index;
+	struct radix_tree_node *tree_node;
+};
+
 #define RADIX_TREE_INIT(mask)	{					\
 	.height = 0,							\
 	.gfp_mask = (mask),						\
@@ -45,9 +72,13 @@ do {									\
 } while (0)
 
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
-void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
-void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
+void *radix_tree_lookup_node(struct radix_tree_root *, unsigned long,
+							unsigned int);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
+unsigned long radix_tree_lookup_head(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan);
+unsigned long radix_tree_lookup_tail(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
@@ -69,4 +100,119 @@ static inline void radix_tree_preload_en
 	preempt_enable();
 }
 
+/**
+ *	radix_tree_lookup    -    perform lookup operation on a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root.
+ */
+static inline void *radix_tree_lookup(struct radix_tree_root *root,
+							unsigned long index)
+{
+	return radix_tree_lookup_node(root, index, 0);
+}
+
+/**
+ *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the slot corresponding to the position @index in the radix tree
+ *	@root. This is useful for update-if-exists operations.
+ */
+static inline void **radix_tree_lookup_slot(struct radix_tree_root *root,
+							unsigned long index)
+{
+	struct radix_tree_node *node;
+
+	node = radix_tree_lookup_node(root, index, 1);
+	return node->slots + (index & RADIX_TREE_MAP_MASK);
+}
+
+/**
+ *	radix_tree_cache_lookup_node    -    cached lookup node
+ *	@root:		radix tree root
+ *	@cache:		look-aside cache
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root,
+ *	and return the node @level levels from the bottom in the search path.
+ *	@cache stores the last accessed upper level tree node by this
+ *	function, and is always checked first before searching in the tree.
+ *	It can improve speed for access patterns with strong locality.
+ *	NOTE:
+ *	- The cache becomes invalid on leaving the lock;
+ *	- Do not intermix calls with different @level.
+ */
+static inline void *radix_tree_cache_lookup_node(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index, unsigned int level)
+{
+	struct radix_tree_node *node;
+        unsigned long i;
+        unsigned long mask;
+
+        if (level && level >= root->height)
+                return root->rnode;
+
+        i = ((index >> (level * RADIX_TREE_MAP_SHIFT)) & RADIX_TREE_MAP_MASK);
+        mask = ~((RADIX_TREE_MAP_SIZE << (level * RADIX_TREE_MAP_SHIFT)) - 1);
+
+	if ((index & mask) == cache->first_index)
+                return cache->tree_node->slots[i];
+
+	node = radix_tree_lookup_node(root, index, level + 1);
+	if (!node)
+		return 0;
+
+	cache->tree_node = node;
+	cache->first_index = (index & mask);
+        return node->slots[i];
+}
+
+/**
+ *	radix_tree_cache_lookup    -    cached lookup page
+ *	@root:		radix tree root
+ *	@cache:		look-aside cache
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root.
+ */
+static inline void *radix_tree_cache_lookup(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index)
+{
+	return radix_tree_cache_lookup_node(root, cache, index, 0);
+}
+
+static inline void radix_tree_cache_init(struct radix_tree_cache *cache)
+{
+	cache->first_index = 0x77;
+	cache->tree_node = NULL;
+}
+
+static inline int radix_tree_cache_size(struct radix_tree_cache *cache)
+{
+	return RADIX_TREE_MAP_SIZE;
+}
+
+static inline int radix_tree_cache_count(struct radix_tree_cache *cache)
+{
+	if (cache->first_index != 0x77)
+		return cache->tree_node->count;
+	else
+		return 0;
+}
+
+static inline int radix_tree_cache_full(struct radix_tree_cache *cache)
+{
+	return radix_tree_cache_count(cache) == radix_tree_cache_size(cache);
+}
+
+static inline int radix_tree_cache_first_index(struct radix_tree_cache *cache)
+{
+	return cache->first_index;
+}
+
 #endif /* _LINUX_RADIX_TREE_H */
--- linux-2.6.14-mm1.orig/lib/radix-tree.c
+++ linux-2.6.14-mm1/lib/radix-tree.c
@@ -32,25 +32,6 @@
 #include <linux/bitops.h>
 
 
-#ifdef __KERNEL__
-#define RADIX_TREE_MAP_SHIFT	6
-#else
-#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
-#endif
-#define RADIX_TREE_TAGS		2
-
-#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
-#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
-
-#define RADIX_TREE_TAG_LONGS	\
-	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
-
-struct radix_tree_node {
-	unsigned int	count;
-	void		*slots[RADIX_TREE_MAP_SIZE];
-	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
-};
-
 struct radix_tree_path {
 	struct radix_tree_node *node;
 	int offset;
@@ -287,8 +268,21 @@ int radix_tree_insert(struct radix_tree_
 }
 EXPORT_SYMBOL(radix_tree_insert);
 
-static inline void **__lookup_slot(struct radix_tree_root *root,
-				   unsigned long index)
+/**
+ *	radix_tree_lookup_node    -    low level lookup routine
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@level:		stop at that many levels from bottom
+ *
+ *	Lookup the item at the position @index in the radix tree @root.
+ *	The return value is:
+ *	@level == 0:      page at @index;
+ *	@level == 1:      the corresponding bottom level tree node;
+ *	@level < height:  (height - @level)th level tree node;
+ *	@level >= height: root node.
+ */
+void *radix_tree_lookup_node(struct radix_tree_root *root,
+				unsigned long index, unsigned int level)
 {
 	unsigned int height, shift;
 	struct radix_tree_node *slot;
@@ -300,7 +294,7 @@ static inline void **__lookup_slot(struc
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
-	while (height > 0) {
+	while (height > level) {
 		if (slot == NULL)
 			return NULL;
 
@@ -311,36 +305,114 @@ static inline void **__lookup_slot(struc
 
 	return slot;
 }
+EXPORT_SYMBOL(radix_tree_lookup_node);
 
 /**
- *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
+ *	radix_tree_lookup_head    -    lookup the head index
  *	@root:		radix tree root
  *	@index:		index key
+ *	@max_scan:      max items to scan
  *
- *	Lookup the slot corresponding to the position @index in the radix tree
- *	@root. This is useful for update-if-exists operations.
+ *      Lookup head index of the segment which contains @index. A segment is
+ *      a set of continuous pages in a file.
+ *      CASE                       RETURN VALUE
+ *      no page at @index          (not head) = @index + 1
+ *      found in the range         @index - @max_scan < (head index) <= @index
+ *      not found in range         (unfinished head) <= @index - @max_scan
  */
-void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
+unsigned long radix_tree_lookup_head(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan)
 {
-	return __lookup_slot(root, index);
+	struct radix_tree_cache cache;
+	struct radix_tree_node *node;
+	int i;
+	unsigned long origin;
+
+	origin = index;
+	if (unlikely(max_scan > index))
+		max_scan = index;
+        radix_tree_cache_init(&cache);
+
+next_node:
+	if (origin - index > max_scan)
+		goto out;
+
+	node = radix_tree_cache_lookup_node(root, &cache, index, 1);
+	if (!node)
+		goto out;
+
+	if (node->count == RADIX_TREE_MAP_SIZE) {
+		if (index < RADIX_TREE_MAP_SIZE) {
+			index = -1;
+			goto out;
+		}
+		index = (index - RADIX_TREE_MAP_SIZE) | RADIX_TREE_MAP_MASK;
+		goto next_node;
+	}
+
+	for (i = index & RADIX_TREE_MAP_MASK; i >= 0; i--, index--) {
+		if (!node->slots[i])
+			goto out;
+	}
+
+	goto next_node;
+
+out:
+	return index + 1;
 }
-EXPORT_SYMBOL(radix_tree_lookup_slot);
+EXPORT_SYMBOL(radix_tree_lookup_head);
 
 /**
- *	radix_tree_lookup    -    perform lookup operation on a radix tree
+ *	radix_tree_lookup_tail    -    lookup the tail index
  *	@root:		radix tree root
  *	@index:		index key
+ *	@max_scan:      max items to scan
  *
- *	Lookup the item at the position @index in the radix tree @root.
+ *      Lookup tail(pass the end) index of the segment which contains @index.
+ *      A segment is a set of continuous pages in a file.
+ *      CASE                       RETURN VALUE
+ *      found in the range         @index <= (tail index) < @index + @max_scan
+ *      not found in range         @index + @max_scan <= (non tail)
  */
-void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
+unsigned long radix_tree_lookup_tail(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan)
 {
-	void **slot;
+	struct radix_tree_cache cache;
+	struct radix_tree_node *node;
+	int i;
+	unsigned long origin;
+
+	origin = index;
+	if (unlikely(index + max_scan < index))
+		max_scan = LONG_MAX - index;
+        radix_tree_cache_init(&cache);
+
+next_node:
+	if (index - origin >= max_scan)
+		goto out;
 
-	slot = __lookup_slot(root, index);
-	return slot != NULL ? *slot : NULL;
+	node = radix_tree_cache_lookup_node(root, &cache, index, 1);
+	if (!node)
+		goto out;
+
+	if (node->count == RADIX_TREE_MAP_SIZE) {
+		index = (index | RADIX_TREE_MAP_MASK) + 1;
+		if (unlikely(!index))
+			goto out;
+		goto next_node;
+	}
+
+	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++, index++) {
+		if (!node->slots[i])
+			goto out;
+	}
+
+	goto next_node;
+
+out:
+	return index;
 }
-EXPORT_SYMBOL(radix_tree_lookup);
+EXPORT_SYMBOL(radix_tree_lookup_tail);
 
 /**
  *	radix_tree_tag_set - set a tag on a radix tree node

--
