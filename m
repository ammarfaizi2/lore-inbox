Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWCSCfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWCSCfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWCSCfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:35:11 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:48322 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751306AbWCSCej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:39 -0500
Message-Id: <20060319023459.086278000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:34 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 21/23] readahead: debug radix tree new functions
Content-Disposition: inline; filename=readahead-debug-radix-tree.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do some sanity checkings on the newly added radix tree code.

It is meant to be removed after a while.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -80,6 +80,8 @@ enum ra_class {
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
+#define DEBUG_READAHEAD_RADIXTREE
+
 /* Read-ahead events to be accounted. */
 enum ra_event {
 	RA_EVENT_CACHE_MISS,		/* read cache misses */
@@ -1515,6 +1517,13 @@ static unsigned long query_page_cache_se
 	read_lock_irq(&mapping->tree_lock);
 	index = radix_tree_scan_hole_backward(&mapping->page_tree,
 							offset, ra_max);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	WARN_ON(index > offset);
+	if (index != offset)
+		WARN_ON(!__find_page(mapping, index + 1));
+	if (index && offset - index < ra_max)
+		WARN_ON(__find_page(mapping, index));
+#endif
 	read_unlock_irq(&mapping->tree_lock);
 
 	*remain = offset - index;
@@ -1550,6 +1559,11 @@ static unsigned long query_page_cache_se
 		struct radix_tree_node *node;
 		node = radix_tree_cache_lookup_node(&mapping->page_tree,
 						&cache, offset - count, 1);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+		if (node != radix_tree_lookup_node(&mapping->page_tree,
+							offset - count, 1))
+			BUG();
+#endif
 		if (!node)
 			break;
 	}
@@ -1614,6 +1628,16 @@ static inline pgoff_t find_segtail(struc
 	cond_resched();
 	read_lock_irq(&mapping->tree_lock);
 	ra_index = radix_tree_scan_hole(&mapping->page_tree, index, max_scan);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	BUG_ON(!__find_page(mapping, index));
+	WARN_ON(ra_index < index);
+	if (ra_index != index && !__find_page(mapping, ra_index - 1))
+		printk(KERN_ERR "radix_tree_scan_hole(index=%lu ra_index=%lu "
+				"max_scan=%lu nrpages=%lu) fooled!\n",
+				index, ra_index, max_scan, mapping->nrpages);
+	if (ra_index != ~0UL && ra_index - index < max_scan)
+		WARN_ON(__find_page(mapping, ra_index));
+#endif
 	read_unlock_irq(&mapping->tree_lock);
 
 	if (ra_index <= index + max_scan)

--
