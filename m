Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966430AbWKOHuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966430AbWKOHuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966591AbWKOHuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:50:52 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:9934 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966430AbWKOHuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:46 -0500
Message-ID: <363577024.11779@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075027.832896629@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:18 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 11/28] readahead: min/max sizes
Content-Disposition: inline; filename=readahead-min-max-sizes.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Enlarge VM_MAX_READAHEAD to 1024 if new read-ahead code is compiled in.
  This value is no longer tightly coupled with the thrashing problem,
  therefore constrained by it. The adaptive read-ahead logic merely takes
  it as an upper bound, and will not stick to it under memory pressure.

- Slightly enlarge minimal/initial read-ahead size on big memory systems.
  Memory bounty systems are less likely to suffer from thrashing on small
  read-ahead sizes. A bigger initial value helps the ra_size scaling up
  progress.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/include/linux/mm.h
+++ linux-2.6.19-rc5-mm2/include/linux/mm.h
@@ -1046,7 +1046,11 @@ extern int filemap_populate(struct vm_ar
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+#define VM_MAX_READAHEAD	1024	/* kbytes */
+#else
 #define VM_MAX_READAHEAD	128	/* kbytes */
+#endif
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 #define VM_MAX_CACHE_HIT    	256	/* max pages in a row in cache before
 					 * turning readahead off */
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -814,6 +814,30 @@ out:
 	return nr_pages;
 }
 
+/*
+ * ra_min is mainly determined by the size of cache memory. Reasonable?
+ *
+ * Table of concrete numbers for 4KB page size:
+ *   inactive + free (MB):    4   8   16   32   64  128  256  512 1024
+ *            ra_min (KB):   16  16   16   16   20   24   32   48   64
+ */
+static inline void get_readahead_bounds(struct file_ra_state *ra,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long active;
+	unsigned long inactive;
+	unsigned long free;
+
+	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
+
+	free += inactive;
+	*ra_max = min(min(ra->ra_pages, 0xFFFFUL), free / 2);
+	*ra_min = min(min(MIN_RA_PAGES + (free >> 14),
+			  DIV_ROUND_UP(64*1024, PAGE_CACHE_SIZE)),
+			  *ra_max / 8);
+}
+
 #endif /* CONFIG_ADAPTIVE_READAHEAD */
 
 /*

--
