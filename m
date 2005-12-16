Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVLPMoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVLPMoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVLPMoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:44:55 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:32396 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932227AbVLPMox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:44:53 -0500
Message-Id: <20051216130813.283112000@localhost.localdomain>
References: <20051216130738.300284000@localhost.localdomain>
Date: Fri, 16 Dec 2005 21:07:39 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 01/12] radixtree: look-aside cache
Content-Disposition: inline; filename=radixtree-lookaside-cache.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a set of lookup functions to radix tree for the read-ahead
logic.  Other access patterns with high locality may also benefit from them.

- radix_tree_lookup_node(root, index, level)
	Perform partial lookup, return the @level'th parent of the slot at
	@index.

- radix_tree_cache_xxx()
	Init/Query the cache.
- radix_tree_cache_lookup(root, cache, index)
	Perform lookup with the aid of a look-aside cache.
	For sequential scans, it has a time complexity of 64*O(1) + 1*O(logn).

	Typical usage:

   void func() {
  +       struct radix_tree_cache cache;
  +
  +       radix_tree_cache_init(&cache);
          read_lock_irq(&mapping->tree_lock);
          for(;;) {
  -               page = radix_tree_lookup(&mapping->page_tree, index);
  +               page = radix_tree_cache_lookup(&mapping->page_tree, &cache, index);
          }
          read_unlock_irq(&mapping->tree_lock);
   }                                                                                                                       	

- radix_tree_lookup_head(root, index, max_scan)
- radix_tree_lookup_tail(root, index, max_scan)
	Assume [head, tail) to be a segment with continuous pages. The two
	functions search for the head and tail index of the segment at @index.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/radix-tree.h |   80 ++++++++++++++++-
 lib/radix-tree.c           |  208 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 259 insertions(+), 29 deletions(-)

--- linux.orig/include/linux/radix-tree.h
+++ linux/include/linux/radix-tree.h
@@ -23,12 +23,24 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#define RADIX_TREE_MAP_SHIFT	6
+#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
+#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
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
@@ -46,9 +58,18 @@ do {									\
 } while (0)
 
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
-void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
-void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
+void *radix_tree_lookup_node(struct radix_tree_root *, unsigned long,
+							unsigned int);
+void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
+int radix_tree_cache_count(struct radix_tree_cache *cache);
+void *radix_tree_cache_lookup_node(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index, unsigned int level);
+unsigned long radix_tree_lookup_head(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan);
+unsigned long radix_tree_lookup_tail(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
@@ -70,4 +91,59 @@ static inline void radix_tree_preload_en
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
+ *	radix_tree_cache_init    -    init the cache
+ *	@cache:		look-aside cache
+ *
+ *	Init the @cache.
+ */
+static inline void radix_tree_cache_init(struct radix_tree_cache *cache)
+{
+	cache->first_index = RADIX_TREE_MAP_MASK;
+	cache->tree_node = NULL;
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
+static inline int radix_tree_cache_size(struct radix_tree_cache *cache)
+{
+	return RADIX_TREE_MAP_SIZE;
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
--- linux.orig/lib/radix-tree.c
+++ linux/lib/radix-tree.c
@@ -32,16 +32,7 @@
 #include <linux/bitops.h>
 
 
-#ifdef __KERNEL__
-#define RADIX_TREE_MAP_SHIFT	6
-#else
-#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
-#endif
 #define RADIX_TREE_TAGS		2
-
-#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
-#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
-
 #define RADIX_TREE_TAG_LONGS	\
 	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
@@ -287,32 +278,86 @@ int radix_tree_insert(struct radix_tree_
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
-	struct radix_tree_node **slot;
+	struct radix_tree_node *slot;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
+	slot = root->rnode;
 
-	while (height > 0) {
-		if (*slot == NULL)
+	while (height > level) {
+		if (slot == NULL)
 			return NULL;
 
-		slot = (struct radix_tree_node **)
-			((*slot)->slots +
-				((index >> shift) & RADIX_TREE_MAP_MASK));
+		slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	return (void **)slot;
+	return slot;
 }
+EXPORT_SYMBOL(radix_tree_lookup_node);
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
+void *radix_tree_cache_lookup_node(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index, unsigned int level)
+{
+	struct radix_tree_node *node;
+        unsigned long i;
+        unsigned long mask;
+
+        if (level >= root->height)
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
+EXPORT_SYMBOL(radix_tree_cache_lookup_node);
 
 /**
  *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
@@ -324,25 +369,134 @@ static inline void **__lookup_slot(struc
  */
 void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
 {
-	return __lookup_slot(root, index);
+	struct radix_tree_node *node;
+
+	node = radix_tree_lookup_node(root, index, 1);
+	return node->slots + (index & RADIX_TREE_MAP_MASK);
 }
 EXPORT_SYMBOL(radix_tree_lookup_slot);
 
 /**
- *	radix_tree_lookup    -    perform lookup operation on a radix tree
+ *	radix_tree_cache_count    -    items in the cached node
+ *	@cache:      radix tree look-aside cache
+ *
+ *      Query the number of items contained in the cached node.
+ */
+int radix_tree_cache_count(struct radix_tree_cache *cache)
+{
+	if (!(cache->first_index & RADIX_TREE_MAP_MASK))
+		return cache->tree_node->count;
+	else
+		return 0;
+}
+EXPORT_SYMBOL(radix_tree_cache_count);
+
+/**
+ *	radix_tree_lookup_head    -    lookup the head index
  *	@root:		radix tree root
  *	@index:		index key
+ *	@max_scan:      max items to scan
  *
- *	Lookup the item at the position @index in the radix tree @root.
+ *      Lookup head index of the segment which contains @index. A segment is
+ *      a set of continuous pages in a file.
+ *      CASE                       RETURN VALUE
+ *      no page at @index          (not head) = @index + 1
+ *      found in the range         @index - @max_scan < (head index) <= @index
+ *      not found in range         (unfinished head) <= @index - @max_scan
  */
-void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
+unsigned long radix_tree_lookup_head(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan)
 {
-	void **slot;
+	struct radix_tree_cache cache;
+	struct radix_tree_node *node;
+	int i;
+	unsigned long origin;
 
-	slot = __lookup_slot(root, index);
-	return slot != NULL ? *slot : NULL;
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
+}
+EXPORT_SYMBOL(radix_tree_lookup_head);
+
+/**
+ *	radix_tree_lookup_tail    -    lookup the tail index
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      max items to scan
+ *
+ *      Lookup tail(pass the end) index of the segment which contains @index.
+ *      A segment is a set of continuous pages in a file.
+ *      CASE                       RETURN VALUE
+ *      found in the range         @index <= (tail index) < @index + @max_scan
+ *      not found in range         @index + @max_scan <= (non tail)
+ */
+unsigned long radix_tree_lookup_tail(struct radix_tree_root *root,
+				unsigned long index, unsigned int max_scan)
+{
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
+
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
