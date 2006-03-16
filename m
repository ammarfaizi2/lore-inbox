Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752430AbWCPRNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbWCPRNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWCPRNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:13:21 -0500
Received: from vena.lwn.net ([206.168.112.25]:51598 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1752430AbWCPRNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:13:21 -0500
Message-ID: <20060316171320.1572.qmail@lwn.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: radix tree safety 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 14 Mar 2006 16:24:40 +1100."
             <44165398.2090900@yahoo.com.au> 
Date: Thu, 16 Mar 2006 10:13:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> How about making the code self-documenting and more useful at the same
> time: put RADIX_TREE_TAGS in radix-tree.h, and call it RADIX_TREE_MAX_TAGS

I like that idea - how's the following?  I also took the liberty of
making the tag arguments be unsigned, since that is clearly the way they
are intended to be used.

jon


Documentation changes to help radix tree users avoid overrunning the
tags array.  RADIX_TREE_TAGS moves to linux/radix-tree.h and is now
known as RADIX_TREE_MAX_TAGS (Nick Piggin's idea).  Tag parameters are
changed to unsigned, and some comments are updated.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

diff -urNp -X 2.6.16-rc6/Documentation/dontdiff 2.6.16-rc6/include/linux/radix-tree.h 2.6.16-rc6-rtree/include/linux/radix-tree.h
--- 2.6.16-rc6/include/linux/radix-tree.h	2006-03-13 14:42:00.000000000 -0700
+++ 2.6.16-rc6-rtree/include/linux/radix-tree.h	2006-03-16 09:42:21.000000000 -0700
@@ -45,6 +45,8 @@ do {									\
 	(root)->rnode = NULL;						\
 } while (0)
 
+#define RADIX_TREE_MAX_TAGS 2
+
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
 void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
 void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
@@ -55,15 +57,16 @@ radix_tree_gang_lookup(struct radix_tree
 int radix_tree_preload(gfp_t gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
-			unsigned long index, int tag);
+			unsigned long index, unsigned int tag);
 void *radix_tree_tag_clear(struct radix_tree_root *root,
-			unsigned long index, int tag);
+			unsigned long index, unsigned int tag);
 int radix_tree_tag_get(struct radix_tree_root *root,
-			unsigned long index, int tag);
+			unsigned long index, unsigned int tag);
 unsigned int
 radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
-		unsigned long first_index, unsigned int max_items, int tag);
-int radix_tree_tagged(struct radix_tree_root *root, int tag);
+		unsigned long first_index, unsigned int max_items,
+		unsigned int tag);
+int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag);
 
 static inline void radix_tree_preload_end(void)
 {
diff -urNp -X 2.6.16-rc6/Documentation/dontdiff 2.6.16-rc6/lib/radix-tree.c 2.6.16-rc6-rtree/lib/radix-tree.c
--- 2.6.16-rc6/lib/radix-tree.c	2006-03-16 09:03:30.000000000 -0700
+++ 2.6.16-rc6-rtree/lib/radix-tree.c	2006-03-16 10:06:21.000000000 -0700
@@ -37,7 +37,6 @@
 #else
 #define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
 #endif
-#define RADIX_TREE_TAGS		2
 
 #define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
 #define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
@@ -48,7 +47,7 @@
 struct radix_tree_node {
 	unsigned int	count;
 	void		*slots[RADIX_TREE_MAP_SIZE];
-	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
+	unsigned long	tags[RADIX_TREE_MAX_TAGS][RADIX_TREE_TAG_LONGS];
 };
 
 struct radix_tree_path {
@@ -135,17 +134,20 @@ out:
 	return ret;
 }
 
-static inline void tag_set(struct radix_tree_node *node, int tag, int offset)
+static inline void tag_set(struct radix_tree_node *node, unsigned int tag,
+		int offset)
 {
 	__set_bit(offset, node->tags[tag]);
 }
 
-static inline void tag_clear(struct radix_tree_node *node, int tag, int offset)
+static inline void tag_clear(struct radix_tree_node *node, unsigned int tag,
+		int offset)
 {
 	__clear_bit(offset, node->tags[tag]);
 }
 
-static inline int tag_get(struct radix_tree_node *node, int tag, int offset)
+static inline int tag_get(struct radix_tree_node *node, unsigned int tag,
+		int offset)
 {
 	return test_bit(offset, node->tags[tag]);
 }
@@ -154,7 +156,7 @@ static inline int tag_get(struct radix_t
  * Returns 1 if any slot in the node has this tag set.
  * Otherwise returns 0.
  */
-static inline int any_tag_set(struct radix_tree_node *node, int tag)
+static inline int any_tag_set(struct radix_tree_node *node, unsigned int tag)
 {
 	int idx;
 	for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
@@ -180,7 +182,7 @@ static int radix_tree_extend(struct radi
 {
 	struct radix_tree_node *node;
 	unsigned int height;
-	char tags[RADIX_TREE_TAGS];
+	char tags[RADIX_TREE_MAX_TAGS];
 	int tag;
 
 	/* Figure out what the height should be.  */
@@ -197,7 +199,7 @@ static int radix_tree_extend(struct radi
 	 * Prepare the tag status of the top-level node for propagation
 	 * into the newly-pushed top-level node(s)
 	 */
-	for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
+	for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
 		tags[tag] = 0;
 		if (any_tag_set(root->rnode, tag))
 			tags[tag] = 1;
@@ -211,7 +213,7 @@ static int radix_tree_extend(struct radi
 		node->slots[0] = root->rnode;
 
 		/* Propagate the aggregated tag info into the new root */
-		for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
+		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
 			if (tags[tag])
 				tag_set(node, tag, 0);
 		}
@@ -349,14 +351,15 @@ EXPORT_SYMBOL(radix_tree_lookup);
  *	@index:		index key
  *	@tag: 		tag index
  *
- *	Set the search tag corresponging to @index in the radix tree.  From
+ *	Set the search tag (which must be < RADIX_TREE_MAX_TAGS)
+ *	corresponding to @index in the radix tree.  From
  *	the root all the way down to the leaf node.
  *
  *	Returns the address of the tagged item.   Setting a tag on a not-present
  *	item is a bug.
  */
 void *radix_tree_tag_set(struct radix_tree_root *root,
-			unsigned long index, int tag)
+			unsigned long index, unsigned int tag)
 {
 	unsigned int height, shift;
 	struct radix_tree_node *slot;
@@ -390,7 +393,8 @@ EXPORT_SYMBOL(radix_tree_tag_set);
  *	@index:		index key
  *	@tag: 		tag index
  *
- *	Clear the search tag corresponging to @index in the radix tree.  If
+ *	Clear the search tag (which must be < RADIX_TREE_MAX_TAGS)
+ *	corresponding to @index in the radix tree.  If
  *	this causes the leaf node to have no tags set then clear the tag in the
  *	next-to-leaf node, etc.
  *
@@ -398,7 +402,7 @@ EXPORT_SYMBOL(radix_tree_tag_set);
  *	has the same return value and semantics as radix_tree_lookup().
  */
 void *radix_tree_tag_clear(struct radix_tree_root *root,
-			unsigned long index, int tag)
+			unsigned long index, unsigned int tag)
 {
 	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
 	struct radix_tree_node *slot;
@@ -450,7 +454,7 @@ EXPORT_SYMBOL(radix_tree_tag_clear);
  * radix_tree_tag_get - get a tag on a radix tree node
  * @root:		radix tree root
  * @index:		index key
- * @tag: 		tag index
+ * @tag: 		tag index (< RADIX_TREE_MAX_TAGS)
  *
  * Return values:
  *
@@ -459,7 +463,7 @@ EXPORT_SYMBOL(radix_tree_tag_clear);
  * -1: tag present, unset
  */
 int radix_tree_tag_get(struct radix_tree_root *root,
-			unsigned long index, int tag)
+			unsigned long index, unsigned int tag)
 {
 	unsigned int height, shift;
 	struct radix_tree_node *slot;
@@ -592,7 +596,7 @@ EXPORT_SYMBOL(radix_tree_gang_lookup);
  */
 static unsigned int
 __lookup_tag(struct radix_tree_root *root, void **results, unsigned long index,
-	unsigned int max_items, unsigned long *next_index, int tag)
+	unsigned int max_items, unsigned long *next_index, unsigned int tag)
 {
 	unsigned int nr_found = 0;
 	unsigned int shift;
@@ -646,7 +650,7 @@ out:
  *	@results:	where the results of the lookup are placed
  *	@first_index:	start the lookup from this key
  *	@max_items:	place up to this many items at *results
- *	@tag:		the tag index
+ *	@tag:		the tag index (< RADIX_TREE_MAX_TAGS)
  *
  *	Performs an index-ascending scan of the tree for present items which
  *	have the tag indexed by @tag set.  Places the items at *@results and
@@ -654,7 +658,8 @@ out:
  */
 unsigned int
 radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
-		unsigned long first_index, unsigned int max_items, int tag)
+		unsigned long first_index, unsigned int max_items,
+		unsigned int tag)
 {
 	const unsigned long max_index = radix_tree_maxindex(root->height);
 	unsigned long cur_index = first_index;
@@ -716,7 +721,7 @@ void *radix_tree_delete(struct radix_tre
 	struct radix_tree_node *slot;
 	unsigned int height, shift;
 	void *ret = NULL;
-	char tags[RADIX_TREE_TAGS];
+	char tags[RADIX_TREE_MAX_TAGS];
 	int nr_cleared_tags;
 	int tag;
 	int offset;
@@ -751,7 +756,7 @@ void *radix_tree_delete(struct radix_tre
 	 * Clear all tags associated with the just-deleted item
 	 */
 	nr_cleared_tags = 0;
-	for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
+	for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
 		tags[tag] = 1;
 		if (tag_get(pathp->node, tag, pathp->offset)) {
 			tag_clear(pathp->node, tag, pathp->offset);
@@ -763,7 +768,7 @@ void *radix_tree_delete(struct radix_tre
 	}
 
 	for (pathp--; nr_cleared_tags && pathp->node; pathp--) {
-		for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
+		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
 			if (tags[tag])
 				continue;
 
@@ -801,7 +806,7 @@ EXPORT_SYMBOL(radix_tree_delete);
  *	@root:		radix tree root
  *	@tag:		tag to test
  */
-int radix_tree_tagged(struct radix_tree_root *root, int tag)
+int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag)
 {
   	struct radix_tree_node *rnode;
   	rnode = root->rnode;
