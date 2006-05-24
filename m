Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWEXL2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWEXL2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWEXL2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:28:23 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:31104 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932696AbWEXLTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:06 -0400
Message-ID: <348469537.15678@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111858.357709745@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:49 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 03/33] radixtree: hole scanning functions
Content-Disposition: inline; filename=radixtree-scan-hole.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a pair of functions to scan radix tree for hole/empty item.

 include/linux/radix-tree.h |    4 +
 lib/radix-tree.c           |  104 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.17-rc4-mm3.orig/include/linux/radix-tree.h
+++ linux-2.6.17-rc4-mm3/include/linux/radix-tree.h
@@ -74,6 +74,10 @@ unsigned int radix_tree_cache_count(stru
 void *radix_tree_cache_lookup_parent(struct radix_tree_root *root,
 				struct radix_tree_cache *cache,
 				unsigned long index, unsigned int level);
+unsigned long radix_tree_scan_hole_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
+unsigned long radix_tree_scan_hole(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
--- linux-2.6.17-rc4-mm3.orig/lib/radix-tree.c
+++ linux-2.6.17-rc4-mm3/lib/radix-tree.c
@@ -427,6 +427,110 @@ unsigned int radix_tree_cache_count(stru
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
+		node = radix_tree_cache_lookup_parent(root, &cache, index, 1);
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
+		node = radix_tree_cache_lookup_parent(root, &cache, index, 1);
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
