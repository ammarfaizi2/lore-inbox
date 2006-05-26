Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWEZLw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWEZLw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEZLw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:52:59 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:4057 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932360AbWEZLw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:52:58 -0400
Message-ID: <348644374.68709@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115259.809011306@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:09 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH 03/33] radixtree: introduce radix_tree_scan_hole[_backward]()
Content-Disposition: inline; filename=radixtree-scan-hole.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a pair of functions to scan radix tree for hole/empty item.
	- radix_tree_scan_hole(root, index, max_scan)
	- radix_tree_scan_hole_backward(root, index, max_scan)

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux.orig/include/linux/radix-tree.h
+++ linux/include/linux/radix-tree.h
@@ -56,6 +56,10 @@ void *radix_tree_delete(struct radix_tre
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
+unsigned long radix_tree_scan_hole_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
+unsigned long radix_tree_scan_hole(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
 int radix_tree_preload(gfp_t gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
--- linux.orig/lib/radix-tree.c
+++ linux/lib/radix-tree.c
@@ -371,6 +371,112 @@ void **radix_tree_lookup_slot(struct rad
 EXPORT_SYMBOL(radix_tree_lookup_slot);
 
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
+	struct radix_tree_node *node;
+	unsigned long origin;
+	int i;
+
+	if (root->height == 0)
+		goto out;
+
+	for (origin = index; origin - index < max_scan; ) {
+		node = __radix_tree_lookup_parent(root, index, 1);
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
+	struct radix_tree_node *node;
+	unsigned long origin;
+	int i;
+
+	if (root->height == 0) {
+		if (root->rnode && index == 0)
+			index++;
+		goto out;
+	}
+
+	for (origin = index; index - origin < max_scan; ) {
+		node = __radix_tree_lookup_parent(root, index, 1);
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
+
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
