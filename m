Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWCSCfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWCSCfB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWCSCe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:34:58 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:44738 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751319AbWCSCeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:46 -0500
Message-Id: <20060319023454.369874000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:25 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 12/23] readahead: min/max sizes
Content-Disposition: inline; filename=readahead-parameter-minmax-sizes.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Enlarge VM_MAX_READAHEAD to 1024 if new read-ahead code is compiled in.
  This value is no longer tightly coupled with the thrashing problem,
  therefore constrained by it. The adaptive read-ahead logic merely takes
  it as an upper bound, and will not stick to it under memory pressure.

- Slightly enlarge minimal/initial read-ahead size on big memory systems.
  Memory bounty systems are less likely to suffer from thrashing on small
  read-ahead sizes. A bigger initial value helps speed up the ra_size
  growing progress.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h |    4 ++++
 mm/readahead.c     |   17 +++++++++++++++++
 2 files changed, 21 insertions(+)

--- linux-2.6.16-rc6-mm2.orig/include/linux/mm.h
+++ linux-2.6.16-rc6-mm2/include/linux/mm.h
@@ -998,7 +998,11 @@ extern int filemap_populate(struct vm_ar
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
--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -1008,4 +1008,21 @@ out:
 	return nr_pages;
 }
 
+/*
+ * ra_min is mainly determined by the size of cache memory.
+ * Table of concrete numbers for 4KB page size:
+ *   inactive + free (MB):    4   8   16   32   64  128  256  512 1024
+ *            ra_min (KB):   16  16   16   16   20   24   32   48   64
+ */
+static inline void get_readahead_bounds(struct file_ra_state *ra,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long pages;
+
+	pages = max_sane_readahead(KB(1024*1024));
+	*ra_max = min(min(pages, 0xFFFFUL), ra->ra_pages);
+	*ra_min = min(min(MIN_RA_PAGES + (pages>>13), KB(128)), *ra_max/2);
+}
+
 #endif /* CONFIG_ADAPTIVE_READAHEAD */

--
