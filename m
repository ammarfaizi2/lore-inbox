Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWE0Pvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWE0Pvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWE0Pvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:51:51 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:29917 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751612AbWE0Pvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:43 -0400
Message-ID: <348745100.16246@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155141.697607086@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:19 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 30/32] readahead: debug radix tree new functions
Content-Disposition: inline; filename=readahead-debug-radix-tree.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do some sanity checkings on the newly added radix tree code.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -70,6 +70,8 @@ enum ra_class {
 	RA_CLASS_COUNT
 };
 
+#define DEBUG_READAHEAD_RADIXTREE
+
 /* Read-ahead events to be accounted. */
 enum ra_event {
 	RA_EVENT_CACHE_MISS,		/* read cache misses */
@@ -1294,6 +1296,16 @@ static pgoff_t find_segtail(struct addre
 	cond_resched();
 	read_lock_irq(&mapping->tree_lock);
 	ra_index = radix_tree_scan_hole(&mapping->page_tree, index, max_scan);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	BUG_ON(!__probe_page(mapping, index));
+	WARN_ON(ra_index < index);
+	if (ra_index != index && !__probe_page(mapping, ra_index - 1))
+		printk(KERN_ERR "radix_tree_scan_hole(index=%lu ra_index=%lu "
+				"max_scan=%lu nrpages=%lu) fooled!\n",
+				index, ra_index, max_scan, mapping->nrpages);
+	if (ra_index != ~0UL && ra_index - index < max_scan)
+		WARN_ON(__probe_page(mapping, ra_index));
+#endif
 	read_unlock_irq(&mapping->tree_lock);
 
 	if (ra_index <= index + max_scan)
@@ -1377,6 +1389,13 @@ static unsigned long query_page_cache_se
 	read_lock_irq(&mapping->tree_lock);
 	index = radix_tree_scan_hole_backward(&mapping->page_tree,
 							offset - 1, ra_max);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	WARN_ON(index > offset - 1);
+	if (index != offset - 1)
+		WARN_ON(!__probe_page(mapping, index + 1));
+	if (index && offset - 1 - index < ra_max)
+		WARN_ON(__probe_page(mapping, index));
+#endif
 
 	*remain = offset - index;
 

--
