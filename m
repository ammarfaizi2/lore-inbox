Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWCSClB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWCSClB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWCSCkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:40:16 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:3779 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751350AbWCSCex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:53 -0500
Message-Id: <20060319023449.844852000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:16 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 03/23] radixtree: hole scanning functions
Content-Disposition: inline; filename=radixtree-hole-scanning-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a pair of functions to scan radix tree for hole/empty item.

 include/linux/radix-tree.h |    4 +
 lib/radix-tree.c           |  104 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.16-rc6-mm2.orig/include/linux/radix-tree.h
+++ linux-2.6.16-rc6-mm2/include/linux/radix-tree.h
@@ -68,6 +68,10 @@ unsigned int radix_tree_cache_count(stru
 void *radix_tree_cache_lookup_node(struct radix_tree_root *root,
 				struct radix_tree_cache *cache,
 				unsigned long index, unsigned int level);
+unsigned long radix_tree_scan_hole_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
+unsigned long radix_tree_scan_hole(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
--- linux-2.6.16-rc6-mm2.orig/lib/radix-tree.c
+++ linux-2.6.16-rc6-mm2/lib/radix-tree.c
@@ -397,6 +397,110 @@ unsigned int radix_tree_cache_count(stru
 EXPORT_SYMBOL(radix_tree_cache_count);
 
 /**
+ *	radix_tree_scan_hole_backward    -    scan backward for hole
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      advice on max items to scan (it may scan a little more)
+ *
+ *      Scan backward from @index for a hole/empty item, stop when
+ *      - hit hole
+ *      - @max_scan or more items scanned
+ *      - hit index 0
+ *
+ *      Return the correponding index.
+ */
+unsigned long radix_tree_scan_hole_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	struct radix_tree_cache cache;
+	struct radix_tree_node *node;
+	unsigned long origin;
+	int i;
+
+	origin = index;
+        radix_tree_cache_init(&cache);
+
+	while (origin - index < max_scan) {
+		node = radix_tree_cache_lookup_node(root, &cache, index, 1);
+		if (!node)
+			break;
+
+		if (node->count == RADIX_TREE_MAP_SIZE) {
+			index = (index - RADIX_TREE_MAP_SIZE) |
+					RADIX_TREE_MAP_MASK;
+			goto check_underflow;
+		}
+
+		for (i = index & RADIX_TREE_MAP_MASK; i >= 0; i--, index--) {
+			if (!node->slots[i])
+				goto out;
+		}
+
+check_underflow:
+		if (unlikely(index == ULONG_MAX)) {
+			index = 0;
+			break;
+		}
+	}
+
+out:
+	return index;
+}
+EXPORT_SYMBOL(radix_tree_scan_hole_backward);
+
+/**
+ *	radix_tree_scan_hole    -    scan for hole
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      advice on max items to scan (it may scan a little more)
+ *
+ *      Scan forward from @index for a hole/empty item, stop when
+ *      - hit hole
+ *      - hit EOF
+ *      - hit index ULONG_MAX
+ *      - @max_scan or more items scanned
+ *
+ *      Return the correponding index.
+ */
+unsigned long radix_tree_scan_hole(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	struct radix_tree_cache cache;
+	struct radix_tree_node *node;
+	unsigned long origin;
+	int i;
+
+	origin = index;
+        radix_tree_cache_init(&cache);
+
+	while (index - origin < max_scan) {
+		node = radix_tree_cache_lookup_node(root, &cache, index, 1);
+		if (!node)
+			break;
+
+		if (node->count == RADIX_TREE_MAP_SIZE) {
+			index = (index | RADIX_TREE_MAP_MASK) + 1;
+			goto check_overflow;
+		}
+
+		for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE;
+								i++, index++) {
+			if (!node->slots[i])
+				goto out;
+		}
+
+check_overflow:
+		if (unlikely(!index)) {
+			index = ULONG_MAX;
+			break;
+		}
+	}
+out:
+	return index;
+}
+EXPORT_SYMBOL(radix_tree_scan_hole);
+
+/**
  *	radix_tree_tag_set - set a tag on a radix tree node
  *	@root:		radix tree root
  *	@index:		index key

--
