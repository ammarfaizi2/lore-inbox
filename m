Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbWEXLT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWEXLT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWEXLTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:11 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:30592 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932688AbWEXLTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:03 -0400
Message-ID: <348469536.15678@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111857.983845462@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:48 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 02/33] radixtree: look-aside cache
Content-Disposition: inline; filename=radixtree-lookaside-cache.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a set of lookup functions to radix tree for the read-ahead logic.
Other access patterns with high locality may also benefit from them.

- radix_tree_lookup_parent(root, index, level)
	Perform partial lookup, return the @level'th parent of the slot at
	@index.

- radix_tree_cache_xxx()
	Init/Query the cache.
- radix_tree_cache_lookup(root, cache, index)
	Perform lookup with the aid of a look-aside cache.
	For sequential scans, it has a time complexity of 64*O(1) + 1*O(logN).

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

Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/radix-tree.h |   83 +++++++++++++++++++++++++++++++++++
 lib/radix-tree.c           |  104 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 161 insertions(+), 26 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/radix-tree.h
+++ linux-2.6.17-rc4-mm3/include/linux/radix-tree.h
@@ -26,12 +26,29 @@
 #define RADIX_TREE_MAX_TAGS 2
 
 /* root tags are stored in gfp_mask, shifted by __GFP_BITS_SHIFT */
+#ifdef __KERNEL__
+#define RADIX_TREE_MAP_SHIFT	(CONFIG_BASE_SMALL ? 4 : 6)
+#else
+#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
+#endif
+
+#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
+#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
+
 struct radix_tree_root {
 	unsigned int		height;
 	gfp_t			gfp_mask;
 	struct radix_tree_node	*rnode;
 };
 
+/*
+ * Lookaside cache to support access patterns with strong locality.
+ */
+struct radix_tree_cache {
+	unsigned long first_index;
+	struct radix_tree_node *tree_node;
+};
+
 #define RADIX_TREE_INIT(mask)	{					\
 	.height = 0,							\
 	.gfp_mask = (mask),						\
@@ -49,9 +66,14 @@ do {									\
 } while (0)
 
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
-void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
-void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
+void *radix_tree_lookup_parent(struct radix_tree_root *, unsigned long,
+							unsigned int);
+void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
+unsigned int radix_tree_cache_count(struct radix_tree_cache *cache);
+void *radix_tree_cache_lookup_parent(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index, unsigned int level);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
@@ -74,4 +96,61 @@ static inline void radix_tree_preload_en
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
+	return radix_tree_lookup_parent(root, index, 0);
+}
+
+/**
+ *	radix_tree_cache_init    -    init a look-aside cache
+ *	@cache:		look-aside cache
+ *
+ *	Init the radix tree look-aside cache @cache.
+ */
+static inline void radix_tree_cache_init(struct radix_tree_cache *cache)
+{
+	cache->first_index = RADIX_TREE_MAP_MASK;
+	cache->tree_node = NULL;
+}
+
+/**
+ *	radix_tree_cache_lookup    -    cached lookup on a radix tree
+ *	@root:		radix tree root
+ *	@cache:		look-aside cache
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root,
+ *	and make use of @cache to speedup the lookup process.
+ */
+static inline void *radix_tree_cache_lookup(struct radix_tree_root *root,
+						struct radix_tree_cache *cache,
+						unsigned long index)
+{
+	return radix_tree_cache_lookup_parent(root, cache, index, 0);
+}
+
+static inline unsigned int radix_tree_cache_size(struct radix_tree_cache *cache)
+{
+	return RADIX_TREE_MAP_SIZE;
+}
+
+static inline int radix_tree_cache_full(struct radix_tree_cache *cache)
+{
+	return radix_tree_cache_count(cache) == radix_tree_cache_size(cache);
+}
+
+static inline unsigned long
+radix_tree_cache_first_index(struct radix_tree_cache *cache)
+{
+	return cache->first_index;
+}
+
 #endif /* _LINUX_RADIX_TREE_H */
--- linux-2.6.17-rc4-mm3.orig/lib/radix-tree.c
+++ linux-2.6.17-rc4-mm3/lib/radix-tree.c
@@ -309,36 +309,90 @@ int radix_tree_insert(struct radix_tree_
 }
 EXPORT_SYMBOL(radix_tree_insert);
 
-static inline void **__lookup_slot(struct radix_tree_root *root,
-				   unsigned long index)
+/**
+ *	radix_tree_lookup_parent    -    low level lookup routine
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@level:		stop at that many levels from the tree leaf
+ *
+ *	Lookup the @level'th parent of the slot at @index in radix tree @root.
+ *	The return value is:
+ *	@level == 0:      page at @index;
+ *	@level == 1:      the corresponding bottom level tree node;
+ *	@level < height:  (@level-1)th parent node of the bottom node
+ *			  that contains @index;
+ *	@level >= height: the root node.
+ */
+void *radix_tree_lookup_parent(struct radix_tree_root *root,
+				unsigned long index, unsigned int level)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *slot;
 
 	height = root->height;
 
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
-	if (height == 0 && root->rnode)
-		return (void **)&root->rnode;
-
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
+}
+EXPORT_SYMBOL(radix_tree_lookup_parent);
+
+/**
+ *	radix_tree_cache_lookup_parent    -    cached lookup node
+ *	@root:		radix tree root
+ *	@cache:		look-aside cache
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root,
+ *	and return the node @level levels from the bottom in the search path.
+ *
+ *	@cache stores the last accessed upper level tree node by this
+ *	function, and is always checked first before searching in the tree.
+ *	It can improve speed for access patterns with strong locality.
+ *
+ *	NOTE:
+ *	- The cache becomes invalid on leaving the lock;
+ *	- Do not intermix calls with different @level.
+ */
+void *radix_tree_cache_lookup_parent(struct radix_tree_root *root,
+				struct radix_tree_cache *cache,
+				unsigned long index, unsigned int level)
+{
+	struct radix_tree_node *node;
+        unsigned long i;
+        unsigned long mask;
+
+        if (level >= root->height)
+                return radix_tree_lookup_parent(root, index, level);
+
+        i = (index >> (level * RADIX_TREE_MAP_SHIFT)) & RADIX_TREE_MAP_MASK;
+        mask = (~0UL) << ((level + 1) * RADIX_TREE_MAP_SHIFT);
+
+	if ((index & mask) == cache->first_index)
+                return cache->tree_node->slots[i];
+
+	node = radix_tree_lookup_parent(root, index, level + 1);
+	if (!node)
+		return 0;
+
+	cache->tree_node = node;
+	cache->first_index = (index & mask);
+        return node->slots[i];
 }
+EXPORT_SYMBOL(radix_tree_cache_lookup_parent);
 
 /**
  *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
@@ -350,25 +404,27 @@ static inline void **__lookup_slot(struc
  */
 void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
 {
-	return __lookup_slot(root, index);
+	struct radix_tree_node *node;
+
+	node = radix_tree_lookup_parent(root, index, 1);
+	return node->slots + (index & RADIX_TREE_MAP_MASK);
 }
 EXPORT_SYMBOL(radix_tree_lookup_slot);
 
 /**
- *	radix_tree_lookup    -    perform lookup operation on a radix tree
- *	@root:		radix tree root
- *	@index:		index key
+ *	radix_tree_cache_count    -    items in the cached node
+ *	@cache:      radix tree look-aside cache
  *
- *	Lookup the item at the position @index in the radix tree @root.
+ *      Query the number of items contained in the cached node.
  */
-void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
+unsigned int radix_tree_cache_count(struct radix_tree_cache *cache)
 {
-	void **slot;
-
-	slot = __lookup_slot(root, index);
-	return slot != NULL ? *slot : NULL;
+	if (!(cache->first_index & RADIX_TREE_MAP_MASK))
+		return cache->tree_node->count;
+	else
+		return 0;
 }
-EXPORT_SYMBOL(radix_tree_lookup);
+EXPORT_SYMBOL(radix_tree_cache_count);
 
 /**
  *	radix_tree_tag_set - set a tag on a radix tree node

--
