Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbSLJJRD>; Tue, 10 Dec 2002 04:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSLJJRD>; Tue, 10 Dec 2002 04:17:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:65445 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266728AbSLJJQ5>;
	Tue, 10 Dec 2002 04:16:57 -0500
Message-ID: <3DF5B2D1.FD134082@digeo.com>
Date: Tue, 10 Dec 2002 01:24:33 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
References: <3DB9A314.6CECA1AC@mvista.com> <3DF2F965.59D7CD84@mvista.com> <3DF3D706.977AC5BB@digeo.com> <3DF4487C.67FD90EF@mvista.com> <3DF44E98.DD173EE8@digeo.com> <3DF5A62C.242E171@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2002 09:24:34.0473 (UTC) FILETIME=[F3D72190:01C2A02D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> ...
> > radix-trees do not currently have a "find next empty slot from this
> > offset" function but that is quite straightforward.  Not quite
> > as fast, unless an occupancy bitmap is added to the radix-tree
> > node.  That's something whcih I have done before - in fact it was
> > an array of occupancy maps so I could do an efficient in-order
> > gang lookup of "all dirty pages from this offset" and "all locked
> > pages from this offset".  It was before its time, and mouldered.
> 
> Gosh, I think this is what I have.  Is it already in the
> kernel tree somewhere?  Oh, I found it.  I will look at
> this, tomorrow...
> 

A simple way of doing the "find an empty slot" is to descend the
tree, following the trail of nodes which have `count < 64' until
you hit the bottom.  At each node you'll need to walk the slots[]
array to locate the first empty one.

That's quite a few cache misses.  It can be optimised by adding
a 64-bit DECLARE_BITMAP to struct radix_tree_node.  This actually
obsoletes `count', because you can just replace the test for
zero count with a test for `all 64 bits are zero'.

Such a search would be an extension to or variant of radix_tree_gang_lookup.
Something like the (old, untested) code below.

But it's a big job.  First thing to do is to write a userspace
test harness for the radix-tree code.  That's something I need to
do anyway, because radix_tree_gang_lookup fails for offests beyond
the 8TB mark, and it's such a pita fixing that stuff in-kernel.

Good luck ;)

 include/linux/radix-tree.h |   11 ++
 lib/radix-tree.c           |  209 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 191 insertions(+), 29 deletions(-)

--- 2.5.34/lib/radix-tree.c~radix_tree_tagged_lookup	Wed Sep 11 11:49:28 2002
+++ 2.5.34-akpm/lib/radix-tree.c	Wed Sep 11 11:49:28 2002
@@ -32,9 +32,11 @@
 #define RADIX_TREE_MAP_SHIFT  6
 #define RADIX_TREE_MAP_SIZE  (1UL << RADIX_TREE_MAP_SHIFT)
 #define RADIX_TREE_MAP_MASK  (RADIX_TREE_MAP_SIZE-1)
+#define NR_TAGS	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
 struct radix_tree_node {
 	unsigned int	count;
+	unsigned long	tags[NR_TAGS];
 	void		*slots[RADIX_TREE_MAP_SIZE];
 };
 
@@ -221,15 +223,70 @@ void *radix_tree_lookup(struct radix_tre
 }
 EXPORT_SYMBOL(radix_tree_lookup);
 
+/**
+ * radix_tree_tag - tag an existing node
+ * @root:		radix tree root
+ * @index:		index key
+ *
+ * Tag a path down to a known-to-exist item.
+ */
+void radix_tree_tag(struct radix_tree_root *root, unsigned long index)
+{
+	unsigned int height, shift;
+	struct radix_tree_node **slot;
+
+	height = root->height;
+	if (index > radix_tree_maxindex(height))
+		return;
+
+	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
+	slot = &root->rnode;
+	root->tag = 1;
+
+	while (height > 0) {
+		unsigned int offset;
+
+		BUG_ON(*slot == NULL);
+		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
+		if (slot != &root->rnode) {
+			if (!test_bit(offset, (*slot)->tags))
+				set_bit(offset, (*slot)->tags);
+		}
+		slot = (struct radix_tree_node **)((*slot)->slots + offset);
+		shift -= RADIX_TREE_MAP_SHIFT;
+		height--;
+	}
+}
+EXPORT_SYMBOL(radix_tree_tag);
+
+enum tag_mode {
+	TM_NONE,
+	TM_TEST,
+	TM_TEST_CLEAR,
+};
+
+static inline int tags_clear(struct radix_tree_node *node)
+{
+	int i;
+
+	for (i = 0; i < NR_TAGS; i++) {
+		if (node->tags[i])
+			return 0;
+	}
+	return 1;
+}
+
 static /* inline */ unsigned int
 __lookup(struct radix_tree_root *root, void **results, unsigned long index,
 	unsigned int max_items, unsigned long *next_index,
-	unsigned long max_index)
+	unsigned long max_index, enum tag_mode tag_mode)
 {
 	unsigned int nr_found = 0;
 	unsigned int shift;
 	unsigned int height = root->height;
 	struct radix_tree_node *slot;
+	struct radix_tree_node *path[RADIX_TREE_MAX_PATH];
+	struct radix_tree_node **pathp = path;
 
 	if (index > max_index)
 		return 0;
@@ -239,8 +296,12 @@ __lookup(struct radix_tree_root *root, v
 	while (height > 0) {
 		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
 		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
-			if (slot->slots[i] != NULL)
-				break;
+			if (slot->slots[i] != NULL) {
+				if (tag_mode == TM_NONE)
+					break;
+				if (test_bit(i, slot->tags))
+					break;
+			}
 			index &= ~((1 << shift) - 1);
 			index += 1 << shift;
 		}
@@ -248,6 +309,7 @@ __lookup(struct radix_tree_root *root, v
 			goto out;
 		height--;
 		shift -= RADIX_TREE_MAP_SHIFT;
+		*pathp++ = slot;
 		if (height == 0) {
 			/* Bottom level: grab some items */
 			unsigned long j;
@@ -257,36 +319,46 @@ __lookup(struct radix_tree_root *root, v
 			j = index & RADIX_TREE_MAP_MASK;
 			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
 				index++;
-				if (slot->slots[j]) {
-					results[nr_found++] = slot->slots[j];
-					if (nr_found == max_items)
-						goto out;
+				if (!slot->slots[j])
+					continue;
+				if (tag_mode == TM_TEST) {
+					if (!test_bit(j, slot->tags))
+						continue;
+				}
+				if (tag_mode == TM_TEST_CLEAR) {
+					if (!test_and_clear_bit(j, slot->tags))
+						continue;
 				}
+				results[nr_found++] = slot->slots[j];
+				if (nr_found == max_items)
+					goto out;
 			}
 		}
 		slot = slot->slots[i];
 	}
 out:
+	if (tag_mode == TM_TEST_CLEAR) {
+		while (pathp > path) {
+			if (tags_clear(pathp[1])) {
+				unsigned int offset;
+
+				offset = (void **)pathp[1] - pathp[0]->slots;
+				BUG_ON(offset >= RADIX_TREE_MAP_SIZE);
+				clear_bit(offset, pathp[0]->tags);
+			} else {
+				break;
+			}
+		}
+	}
 	*next_index = index;
 	return nr_found;
 	
 }
-/**
- *	radix_tree_gang_lookup - perform multiple lookup on a radix tree
- *	@root:		radix tree root
- *	@results:	where the results of the lookup are placed
- *	@first_index:	start the lookup from this key
- *	@max_items:	place up to this many items at *results
- *
- *	Performs an index-ascending scan of the tree for present items.  Places
- *	them at *@results and returns the number of items which were placed at
- *	*@results.
- *
- *	The implementation is naive.
- */
-unsigned int
-radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
-			unsigned long first_index, unsigned int max_items)
+
+static unsigned int
+gang_lookup(struct radix_tree_root *root, void **results,
+	unsigned long first_index, unsigned int max_items,
+	enum tag_mode tag_mode)
 {
 	const unsigned long max_index = radix_tree_maxindex(root->height);
 	unsigned long cur_index = first_index;
@@ -297,18 +369,37 @@ radix_tree_gang_lookup(struct radix_tree
 	if (max_index == 0) {			/* Bah.  Special case */
 		if (first_index == 0) {
 			if (max_items > 0) {
-				*results = root->rnode;
-				ret = 1;
+				switch (tag_mode) {
+				case TM_NONE:
+					*results = root->rnode;
+					ret = 1;
+					break;
+				case TM_TEST:
+					if (root->tag) {
+						*results = root->rnode;
+						ret = 1;
+					}
+					break;
+				case TM_TEST_CLEAR:
+					if (root->tag) {
+						*results = root->rnode;
+						ret = 1;
+						root->tag = 0;
+					}
+					break;
+				}
 			}
 		}
 		goto out;
 	}
+
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
 
 		nr_found = __lookup(root, results + ret, cur_index,
-				max_items - ret, &next_index, max_index);
+				max_items - ret, &next_index,
+				max_index, tag_mode);
 		if (nr_found == 0)
 			break;
 		ret += nr_found;
@@ -317,9 +408,70 @@ radix_tree_gang_lookup(struct radix_tree
 out:
 	return ret;
 }
+
+/**
+ * radix_tree_gang_lookup - perform multiple lookup on a radix tree
+ * @root:		radix tree root
+ * @results:		where the results of the lookup are placed
+ * @first_index:	start the lookup from this key
+ * @max_items:		place up to this many items at *results
+ *
+ * Performs an index-ascending scan of the tree for present items.  Places them
+ * at *@results and returns the number of items which were placed at *@results.
+ *
+ *	The implementation is naive.
+ */
+unsigned int
+radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
+			unsigned long first_index, unsigned int max_items)
+{
+	return gang_lookup(root, results, first_index, max_items, TM_NONE);
+}
 EXPORT_SYMBOL(radix_tree_gang_lookup);
 
 /**
+ * radix_tree_test_gang_lookup - perform multiple lookup on a radix tree
+ * @root:		radix tree root
+ * @results:		where the results of the lookup are placed
+ * @first_index:	start the lookup from this key
+ * @max_items:		place up to this many items at *results
+ *
+ * Performs an index-ascending scan of the tree for present items which are
+ * tagged.  Places them at *@results and returns the number of items which were
+ * placed at *@results.
+ */
+unsigned int
+radix_tree_test_gang_lookup(struct radix_tree_root *root, void **results,
+			unsigned long first_index, unsigned int max_items)
+{
+	return gang_lookup(root, results, first_index, max_items, TM_TEST);
+}
+EXPORT_SYMBOL(radix_tree_test_gang_lookup);
+
+/**
+ * radix_tree_test_clear_gang_lookup - perform multiple lookup on a radix tree,
+ *                                     clearing its tag tree.
+ * @root:		radix tree root
+ * @results:		where the results of the lookup are placed
+ * @first_index:	start the lookup from this key
+ * @max_items:		place up to this many items at *results
+ *
+ * Performs an index-ascending scan of the tree for present items which are
+ * tagged.  Places them at *@results and returns the number of items which were
+ * placed at *@results.
+ *
+ * The tags are cleared on the path back up from the found items.
+ */
+unsigned int
+radix_tree_test_clear_gang_lookup(struct radix_tree_root *root, void **results,
+			unsigned long first_index, unsigned int max_items)
+{
+	return gang_lookup(root, results, first_index,
+				max_items, TM_TEST_CLEAR);
+}
+EXPORT_SYMBOL(radix_tree_test_clear_gang_lookup);
+
+/**
  *	radix_tree_delete    -    delete an item from a radix tree
  *	@root:		radix tree root
  *	@index:		index key
@@ -366,7 +518,8 @@ int radix_tree_delete(struct radix_tree_
 
 EXPORT_SYMBOL(radix_tree_delete);
 
-static void radix_tree_node_ctor(void *node, kmem_cache_t *cachep, unsigned long flags)
+static void
+radix_tree_node_ctor(void *node, kmem_cache_t *cachep, unsigned long flags)
 {
 	memset(node, 0, sizeof(struct radix_tree_node));
 }
@@ -390,7 +543,7 @@ void __init radix_tree_init(void)
 {
 	radix_tree_node_cachep = kmem_cache_create("radix_tree_node",
 			sizeof(struct radix_tree_node), 0,
-			SLAB_HWCACHE_ALIGN, radix_tree_node_ctor, NULL);
+			0, radix_tree_node_ctor, NULL);
 	if (!radix_tree_node_cachep)
 		panic ("Failed to create radix_tree_node cache\n");
 	radix_tree_node_pool = mempool_create(512, radix_tree_node_pool_alloc,
--- 2.5.34/include/linux/radix-tree.h~radix_tree_tagged_lookup	Wed Sep 11 11:49:28 2002
+++ 2.5.34-akpm/include/linux/radix-tree.h	Wed Sep 11 11:49:28 2002
@@ -26,10 +26,11 @@ struct radix_tree_node;
 struct radix_tree_root {
 	unsigned int		height;
 	int			gfp_mask;
+	int			tag;	/* ugh.  dirtiness of the top node */
 	struct radix_tree_node	*rnode;
 };
 
-#define RADIX_TREE_INIT(mask)	{0, (mask), NULL}
+#define RADIX_TREE_INIT(mask)	{0, (mask), 0, NULL}
 
 #define RADIX_TREE(name, mask) \
 	struct radix_tree_root name = RADIX_TREE_INIT(mask)
@@ -38,6 +39,7 @@ struct radix_tree_root {
 do {					\
 	(root)->height = 0;		\
 	(root)->gfp_mask = (mask);	\
+	(root)->tag = 0;		\
 	(root)->rnode = NULL;		\
 } while (0)
 
@@ -48,5 +50,12 @@ extern int radix_tree_delete(struct radi
 extern unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
+extern unsigned int
+radix_tree_test_gang_lookup(struct radix_tree_root *root, void **results,
+			unsigned long first_index, unsigned int max_items);
+extern unsigned int
+radix_tree_test_clear_gang_lookup(struct radix_tree_root *root, void **results,
+			unsigned long first_index, unsigned int max_items);
+void radix_tree_tag(struct radix_tree_root *root, unsigned long index);
 
 #endif /* _LINUX_RADIX_TREE_H */

.
