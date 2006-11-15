Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966059AbWKOH5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966059AbWKOH5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbWKOHua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:50:30 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:13517 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755479AbWKOHu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:27 -0500
Message-ID: <363577020.13886@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075024.503627543@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:09 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 02/28] radixtree: introduce scan hole/data functions
Content-Disposition: inline; filename=radixtree-introduce-radix_tree_scan_functions.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a set of functions to scan radix tree for hole/data item.
	- radix_tree_scan_hole(root, index, max_scan)
	- radix_tree_scan_hole_backward(root, index, max_scan)
	- radix_tree_scan_data_backward(root, index, max_scan)

The implementation is dumb and obviously correct.
It will help to debug the smart ones to be introduced in future.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc4-mm1.orig/include/linux/radix-tree.h
+++ linux-2.6.19-rc4-mm1/include/linux/radix-tree.h
@@ -156,6 +156,12 @@ void *radix_tree_delete(struct radix_tre
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
+unsigned long radix_tree_scan_hole(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
+unsigned long radix_tree_scan_hole_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
+unsigned long radix_tree_scan_data_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan);
 int radix_tree_preload(gfp_t gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
--- linux-2.6.19-rc4-mm1.orig/lib/radix-tree.c
+++ linux-2.6.19-rc4-mm1/lib/radix-tree.c
@@ -598,6 +598,99 @@ int radix_tree_tag_get(struct radix_tree
 EXPORT_SYMBOL(radix_tree_tag_get);
 #endif
 
+static unsigned long
+radix_tree_scan_hole_dumb(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	unsigned long i;
+
+	for (i = 0; i < max_scan; i++)
+		if (!radix_tree_lookup(root, index) || ++index == 0)
+			break;
+
+	return index;
+}
+
+static unsigned long
+radix_tree_scan_hole_backward_dumb(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	unsigned long i;
+
+	for (i = 0; i < max_scan; i++)
+		if (!radix_tree_lookup(root, index) || --index == ULONG_MAX)
+			break;
+
+	return index;
+}
+
+static unsigned long
+radix_tree_scan_data_backward_dumb(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	unsigned long i;
+
+	for (i = 0; i < max_scan; i++)
+		if (radix_tree_lookup(root, index) || --index == ULONG_MAX)
+			break;
+
+	return index;
+}
+
+/**
+ *	radix_tree_scan_hole    -    scan for hole
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      advice on max items to scan (it may scan a little more)
+ *
+ *      Scan forward from @index for a hole/empty item, stop when
+ *      - hit hole
+ *      - wrap-around to index 0
+ *      - @max_scan or more items scanned
+ */
+unsigned long radix_tree_scan_hole(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	return radix_tree_scan_hole_dumb(root, index, max_scan);
+}
+EXPORT_SYMBOL(radix_tree_scan_hole);
+
+/**
+ *	radix_tree_scan_hole_backward    -    scan backward for hole
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      advice on max items to scan (it may scan a little more)
+ *
+ *      Scan backward from @index for a hole/empty item, stop when
+ *      - hit hole
+ *      - wrap-around to index ULONG_MAX
+ *      - @max_scan or more items scanned
+ */
+unsigned long radix_tree_scan_hole_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	return radix_tree_scan_hole_backward_dumb(root, index, max_scan);
+}
+EXPORT_SYMBOL(radix_tree_scan_hole_backward);
+
+/**
+ *	radix_tree_scan_data_backward    -    scan backward for data
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@max_scan:      advice on max items to scan (it may scan a little more)
+ *
+ *      Scan backward from @index for a data item, stop when
+ *      - hit data
+ *      - wrap-around to index ULONG_MAX
+ *      - @max_scan or more items scanned
+ */
+unsigned long radix_tree_scan_data_backward(struct radix_tree_root *root,
+				unsigned long index, unsigned long max_scan)
+{
+	return radix_tree_scan_data_backward_dumb(root, index, max_scan);
+}
+EXPORT_SYMBOL(radix_tree_scan_data_backward);
+
 static unsigned int
 __lookup(struct radix_tree_node *slot, void **results, unsigned long index,
 	unsigned int max_items, unsigned long *next_index)

--
