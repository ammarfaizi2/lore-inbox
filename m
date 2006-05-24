Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbWEXLZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWEXLZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWEXLTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:37 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:32642 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932715AbWEXLTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:15 -0400
Message-ID: <348469551.84998@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111912.485160282@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:17 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 31/33] readahead: debug radix tree new functions
Content-Disposition: inline; filename=readahead-debug-radix-tree.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do some sanity checkings on the newly added radix tree code.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -63,6 +63,8 @@ enum ra_class {
 	RA_CLASS_COUNT
 };
 
+#define DEBUG_READAHEAD_RADIXTREE
+
 /* Read-ahead events to be accounted. */
 enum ra_event {
 	RA_EVENT_CACHE_MISS,		/* read cache misses */
@@ -1315,6 +1317,16 @@ static pgoff_t find_segtail(struct addre
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
@@ -1407,6 +1419,13 @@ static unsigned long query_page_cache_se
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
@@ -1442,6 +1461,11 @@ static unsigned long query_page_cache_se
 		struct radix_tree_node *node;
 		node = radix_tree_cache_lookup_parent(&mapping->page_tree,
 						&cache, offset - count, 1);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+		if (node != radix_tree_lookup_parent(&mapping->page_tree,
+							offset - count, 1))
+			BUG();
+#endif
 		if (!node)
 			break;
 	}

--
