Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbVH0Q06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVH0Q06 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 12:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbVH0Q06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 12:26:58 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:40067 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751498AbVH0Q05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 12:26:57 -0400
Subject: [PATCH] make radix tree gang lookup faster by using a bitmap search
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@vger.kernel.org
Content-Type: text/plain
Date: Sat, 27 Aug 2005 11:26:36 -0500
Message-Id: <1125159996.5159.8.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current gang lookup is rather naive and slow.  This patch replaces
the integer count with an unsigned long representing the bitmap of
occupied elements.  We then use that bitmap to find the first occupied
entry instead of looping over all the entries from the beginning of the
radix node.

The penalty of doing this is that on 32 bit machines, the size of the
radix tree array is reduced from 64 to 32 (so an unsigned long can
represent the bitmap).

I also exported radix_tree_preload() so modules can make use of radix
trees.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

James

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -32,9 +32,17 @@
 
 
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
 #define RADIX_TREE_TAGS		2
 
@@ -45,7 +53,7 @@
 	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
 struct radix_tree_node {
-	unsigned int	count;
+	unsigned long	occupied;
 	void		*slots[RADIX_TREE_MAP_SIZE];
 	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
 };
@@ -133,6 +141,7 @@ int radix_tree_preload(int gfp_mask)
 out:
 	return ret;
 }
+EXPORT_SYMBOL(radix_tree_preload);
 
 static inline void tag_set(struct radix_tree_node *node, int tag, int offset)
 {
@@ -208,7 +217,7 @@ static int radix_tree_extend(struct radi
 				tag_set(node, tag, 0);
 		}
 
-		node->count = 1;
+		node->occupied = 1;
 		root->rnode = node;
 		root->height++;
 	} while (height > root->height);
@@ -251,8 +260,10 @@ int radix_tree_insert(struct radix_tree_
 			if (!(tmp = radix_tree_node_alloc(root)))
 				return -ENOMEM;
 			*slot = tmp;
-			if (node)
-				node->count++;
+			if (node) {
+				BUG_ON(node->occupied & (1UL << offset));
+				node->occupied |= (1UL << offset);
+			}
 		}
 
 		/* Go a level down */
@@ -265,11 +276,11 @@ int radix_tree_insert(struct radix_tree_
 
 	if (*slot != NULL)
 		return -EEXIST;
-	if (node) {
-		node->count++;
-		BUG_ON(tag_get(node, 0, offset));
-		BUG_ON(tag_get(node, 1, offset));
-	}
+	BUG_ON(!node);
+	BUG_ON(node->occupied & (1UL << offset));
+	node->occupied |= (1UL << offset);
+	BUG_ON(tag_get(node, 0, offset));
+	BUG_ON(tag_get(node, 1, offset));
 
 	*slot = item;
 	return 0;
@@ -480,30 +491,48 @@ __lookup(struct radix_tree_root *root, v
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
+		occupied_mask |= ~slot->occupied;
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
+				occupied_mask |= ~slot->occupied;
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
@@ -719,7 +748,9 @@ void *radix_tree_delete(struct radix_tre
 
 	pathp = orig_pathp;
 	*pathp[0].slot = NULL;
-	while (pathp[0].node && --pathp[0].node->count == 0) {
+	BUG_ON(pathp[0].node && (pathp[0].node->occupied & (1UL << pathp[0].offset)) == 0);
+	while (pathp[0].node && 
+	       (pathp[0].node->occupied &= ~(1UL << pathp[0].offset)) == 0) {
 		pathp--;
 		BUG_ON(*pathp[0].slot == NULL);
 		*pathp[0].slot = NULL;


