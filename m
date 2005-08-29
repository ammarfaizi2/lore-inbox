Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbVH2ApX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVH2ApX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 20:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVH2ApX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 20:45:23 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:64654 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751033AbVH2ApW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 20:45:22 -0400
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
	search
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050827105355.360bd26a.akpm@osdl.org>
References: <1125159996.5159.8.camel@mulgrave>
	 <20050827105355.360bd26a.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 19:45:12 -0500
Message-Id: <1125276312.5048.22.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-27 at 10:53 -0700, Andrew Morton wrote:
> a) fix radix_tree_gang_lookup() to use find_next_bit()
> 
> b) remove radix_tree_node.count
> 
> c) Add a new tag field which simply means "present"
> 
> d) remove radix_tree_gang_lookup() and __lookup() altogether
> 
> e) Implement radix_tree_gang_lookup() via radix_tree_gang_lookup_tag()

OK, here it is: the combined version which treats the present bits as a
private tag, combines __lookup and __lookup_tag and does a fast bitmap
search for both.

James

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -32,22 +32,29 @@
 
 
 #ifdef __KERNEL__
+#if BITS_PER_LONG == 32
+#define RADIX_TREE_MAP_SHIFT	5
+#elif BITS_PER_LONG == 64
 #define RADIX_TREE_MAP_SHIFT	6
 #else
+#error BITS_PER_LONG neither 32 nor 64
+#endif
+#define RADIX_TREE_MAP_FULL	(~0UL)
+#else
 #define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
+#define RADIX_TREE_MAP_FULL	((1UL << (1UL << RADIX_TREE_MAP_SHIFT)) - 1UL)
 #endif
-#define RADIX_TREE_TAGS		2
+#define RADIX_TREE_USER_TAGS	2
+#define RADIX_TREE_TAG_PRESENT	(RADIX_TREE_USER_TAGS + 0)
+/* Set this to the last private tag plus one */
+#define RADIX_TREE_TAGS		(RADIX_TREE_TAG_PRESENT + 1)
 
 #define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
 #define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
 
-#define RADIX_TREE_TAG_LONGS	\
-	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
-
 struct radix_tree_node {
-	unsigned int	count;
 	void		*slots[RADIX_TREE_MAP_SIZE];
-	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
+	unsigned long	tags[RADIX_TREE_TAGS];
 };
 
 struct radix_tree_path {
@@ -133,21 +140,22 @@ int radix_tree_preload(int gfp_mask)
 out:
 	return ret;
 }
+EXPORT_SYMBOL(radix_tree_preload);
 
 static inline void tag_set(struct radix_tree_node *node, int tag, int offset)
 {
-	if (!test_bit(offset, &node->tags[tag][0]))
-		__set_bit(offset, &node->tags[tag][0]);
+	if ((node->tags[tag] & (1UL << offset)) == 0)
+		node->tags[tag] |= (1UL << offset);
 }
 
 static inline void tag_clear(struct radix_tree_node *node, int tag, int offset)
 {
-	__clear_bit(offset, &node->tags[tag][0]);
+	node->tags[tag] &= ~(1UL << offset);
 }
 
 static inline int tag_get(struct radix_tree_node *node, int tag, int offset)
 {
-	return test_bit(offset, &node->tags[tag][0]);
+	return (node->tags[tag] & (1UL << offset)) ? 1 : 0;
 }
 
 /*
@@ -184,15 +192,9 @@ static int radix_tree_extend(struct radi
 	 * into the newly-pushed top-level node(s)
 	 */
 	for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
-		int idx;
-
 		tags[tag] = 0;
-		for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-			if (root->rnode->tags[tag][idx]) {
-				tags[tag] = 1;
-				break;
-			}
-		}
+		if (root->rnode->tags[tag])
+			tags[tag] = 1;
 	}
 
 	do {
@@ -208,7 +210,7 @@ static int radix_tree_extend(struct radi
 				tag_set(node, tag, 0);
 		}
 
-		node->count = 1;
+		node->tags[RADIX_TREE_TAG_PRESENT] = 1;
 		root->rnode = node;
 		root->height++;
 	} while (height > root->height);
@@ -251,8 +253,11 @@ int radix_tree_insert(struct radix_tree_
 			if (!(tmp = radix_tree_node_alloc(root)))
 				return -ENOMEM;
 			*slot = tmp;
-			if (node)
-				node->count++;
+			if (node) {
+				BUG_ON(tag_get(node, RADIX_TREE_TAG_PRESENT,
+					       offset));
+				tag_set(node, RADIX_TREE_TAG_PRESENT, offset);
+			}
 		}
 
 		/* Go a level down */
@@ -265,11 +270,11 @@ int radix_tree_insert(struct radix_tree_
 
 	if (*slot != NULL)
 		return -EEXIST;
-	if (node) {
-		node->count++;
-		BUG_ON(tag_get(node, 0, offset));
-		BUG_ON(tag_get(node, 1, offset));
-	}
+	BUG_ON(!node);
+	BUG_ON(tag_get(node, RADIX_TREE_TAG_PRESENT, offset));
+	tag_set(node, RADIX_TREE_TAG_PRESENT, offset);
+	BUG_ON(tag_get(node, 0, offset));
+	BUG_ON(tag_get(node, 1, offset));
 
 	*slot = item;
 	return 0;
@@ -399,13 +404,10 @@ void *radix_tree_tag_clear(struct radix_
 		goto out;
 
 	do {
-		int idx;
-
 		tag_clear(pathp[0].node, tag, pathp[0].offset);
-		for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-			if (pathp[0].node->tags[tag][idx])
-				goto out;
-		}
+		if (pathp[0].node->tags[tag])
+			goto out;
+
 		pathp--;
 	} while (pathp[0].node);
 out:
@@ -468,8 +470,8 @@ EXPORT_SYMBOL(radix_tree_tag_get);
 #endif
 
 static unsigned int
-__lookup(struct radix_tree_root *root, void **results, unsigned long index,
-	unsigned int max_items, unsigned long *next_index)
+__lookup_tag(struct radix_tree_root *root, void **results, unsigned long index,
+	     unsigned int max_items, unsigned long *next_index, int tag)
 {
 	unsigned int nr_found = 0;
 	unsigned int shift;
@@ -480,30 +482,48 @@ __lookup(struct radix_tree_root *root, v
 	slot = root->rnode;
 
 	while (height > 0) {
-		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
+		unsigned long j = (index >> shift) & RADIX_TREE_MAP_MASK, i;
+		unsigned long occupied_mask = 0;
 
-		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
-			if (slot->slots[i] != NULL)
-				break;
-			index &= ~((1UL << shift) - 1);
-			index += 1UL << shift;
-			if (index == 0)
-				goto out;	/* 32-bit wraparound */
-		}
-		if (i == RADIX_TREE_MAP_SIZE)
+		/* mark all the slots up to but excluding the starting
+		 * index occupied */
+		occupied_mask = (1UL << j) - 1;
+		/* Now or in the remaining occupations (inverted so
+		 * we can use ffz to find the next occupied slot) */
+		occupied_mask |= ~slot->tags[tag];
+
+		/* If everything from this on up is empty, then there's
+		 * nothing more in the tree */
+		if (occupied_mask == RADIX_TREE_MAP_FULL) {
+			index = 0;
 			goto out;
+		}
+
+		i = ffz(occupied_mask);
+		if (i != j) {
+			index &= ~((1UL << (shift + RADIX_TREE_MAP_SHIFT)) - 1);
+			index |= i << shift;
+		}
+
 		height--;
 		if (height == 0) {	/* Bottom level: grab some items */
-			unsigned long j = index & RADIX_TREE_MAP_MASK;
-
-			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
-				index++;
-				if (slot->slots[j]) {
-					results[nr_found++] = slot->slots[j];
-					if (nr_found == max_items)
-						goto out;
+			while (i < RADIX_TREE_MAP_SIZE) {
+				unsigned long occupied_mask;
+				BUG_ON(!slot->slots[i]);
+				results[nr_found++] = slot->slots[i];
+				if (nr_found == max_items) {
+					index++;
+					goto out;
 				}
+				occupied_mask = (1UL << i) - 1 + (1UL << i);
+				occupied_mask |= ~slot->tags[tag];
+				if (occupied_mask == RADIX_TREE_MAP_FULL)
+					break;
+				j = i;
+				i = ffz(occupied_mask);
+				index += i-j;
 			}
+			goto out;
 		}
 		shift -= RADIX_TREE_MAP_SHIFT;
 		slot = slot->slots[i];
@@ -540,8 +560,9 @@ radix_tree_gang_lookup(struct radix_tree
 
 		if (cur_index > max_index)
 			break;
-		nr_found = __lookup(root, results + ret, cur_index,
-					max_items - ret, &next_index);
+		nr_found = __lookup_tag(root, results + ret, cur_index,
+					max_items - ret, &next_index,
+					RADIX_TREE_TAG_PRESENT);
 		ret += nr_found;
 		if (next_index == 0)
 			break;
@@ -551,59 +572,6 @@ radix_tree_gang_lookup(struct radix_tree
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup);
 
-/*
- * FIXME: the two tag_get()s here should use find_next_bit() instead of
- * open-coding the search.
- */
-static unsigned int
-__lookup_tag(struct radix_tree_root *root, void **results, unsigned long index,
-	unsigned int max_items, unsigned long *next_index, int tag)
-{
-	unsigned int nr_found = 0;
-	unsigned int shift;
-	unsigned int height = root->height;
-	struct radix_tree_node *slot;
-
-	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
-	slot = root->rnode;
-
-	while (height > 0) {
-		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
-
-		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
-			if (tag_get(slot, tag, i)) {
-				BUG_ON(slot->slots[i] == NULL);
-				break;
-			}
-			index &= ~((1UL << shift) - 1);
-			index += 1UL << shift;
-			if (index == 0)
-				goto out;	/* 32-bit wraparound */
-		}
-		if (i == RADIX_TREE_MAP_SIZE)
-			goto out;
-		height--;
-		if (height == 0) {	/* Bottom level: grab some items */
-			unsigned long j = index & RADIX_TREE_MAP_MASK;
-
-			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
-				index++;
-				if (tag_get(slot, tag, j)) {
-					BUG_ON(slot->slots[j] == NULL);
-					results[nr_found++] = slot->slots[j];
-					if (nr_found == max_items)
-						goto out;
-				}
-			}
-		}
-		shift -= RADIX_TREE_MAP_SHIFT;
-		slot = slot->slots[i];
-	}
-out:
-	*next_index = index;
-	return nr_found;
-}
-
 /**
  *	radix_tree_gang_lookup_tag - perform multiple lookup on a radix tree
  *	                             based on a tag
@@ -657,7 +625,7 @@ void *radix_tree_delete(struct radix_tre
 	struct radix_tree_path *orig_pathp;
 	unsigned int height, shift;
 	void *ret = NULL;
-	char tags[RADIX_TREE_TAGS];
+	char tags[RADIX_TREE_TAGS - 1];
 	int nr_cleared_tags;
 
 	height = root->height;
@@ -691,27 +659,25 @@ void *radix_tree_delete(struct radix_tre
 	orig_pathp = pathp;
 
 	/*
-	 * Clear all tags associated with the just-deleted item
+	 * Clear all user tags associated with the just-deleted item
 	 */
 	memset(tags, 0, sizeof(tags));
 	do {
 		int tag;
 
-		nr_cleared_tags = RADIX_TREE_TAGS;
-		for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
-			int idx;
-
+		/* The private tag RADIX_TREE_TAG_PRESENT is used to
+		 * free the slots below, so don't clear it */
+		nr_cleared_tags = RADIX_TREE_TAGS - 1;
+		for (tag = 0; tag < RADIX_TREE_TAGS - 1;
+		     tag++) {
 			if (tags[tag])
 				continue;
 
 			tag_clear(pathp[0].node, tag, pathp[0].offset);
 
-			for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-				if (pathp[0].node->tags[tag][idx]) {
-					tags[tag] = 1;
-					nr_cleared_tags--;
-					break;
-				}
+			if (pathp[0].node->tags[tag]) {
+				tags[tag] = 1;
+				nr_cleared_tags--;
 			}
 		}
 		pathp--;
@@ -719,7 +685,12 @@ void *radix_tree_delete(struct radix_tre
 
 	pathp = orig_pathp;
 	*pathp[0].slot = NULL;
-	while (pathp[0].node && --pathp[0].node->count == 0) {
+	BUG_ON(pathp[0].node &&
+	       !tag_get(pathp[0].node, RADIX_TREE_TAG_PRESENT, 
+			pathp[0].offset));
+	while (pathp[0].node && 
+	       (pathp[0].node->tags[RADIX_TREE_TAG_PRESENT] &=
+		~(1UL << pathp[0].offset)) == 0) {
 		pathp--;
 		BUG_ON(*pathp[0].slot == NULL);
 		*pathp[0].slot = NULL;
@@ -739,14 +710,11 @@ EXPORT_SYMBOL(radix_tree_delete);
  */
 int radix_tree_tagged(struct radix_tree_root *root, int tag)
 {
-	int idx;
-
 	if (!root->rnode)
 		return 0;
-	for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-		if (root->rnode->tags[tag][idx])
-			return 1;
-	}
+	if (root->rnode->tags[tag])
+		return 1;
+
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_tagged);


