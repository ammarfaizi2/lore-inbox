Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVLOAgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVLOAgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVLOAcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:32:22 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:50133 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932649AbVLOAcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:32:08 -0500
Date: Wed, 14 Dec 2005 16:32:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215003207.31788.49421.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 03/14] Convert nr_mapped
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make nr_mapped a per zone counter

nr_mapped is important because it allows a determination how many pages of a
zone are not mapped, which would allow a more efficient means of determining
when we need to reclaim memory in a zone.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/page-flags.h	2005-12-14 14:45:40.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/page-flags.h	2005-12-14 14:57:29.000000000 -0800
@@ -86,7 +86,6 @@ struct page_state {
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_mapped;	/* mapped into pagetables */
 	unsigned long nr_slab;		/* In slab */
 #define GET_PAGE_STATE_LAST nr_slab
 
Index: linux-2.6.15-rc5-mm2/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/drivers/base/node.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm2/drivers/base/node.c	2005-12-14 14:57:29.000000000 -0800
@@ -43,18 +43,18 @@ static ssize_t node_read_meminfo(struct 
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
+	unsigned long nr_mapped;
 
 	si_meminfo_node(&i, nid);
 	get_page_state_node(&ps, nid);
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
+	nr_mapped = node_page_state(nid, NR_MAPPED);
 
 	/* Check for negative values in these approximate counters */
 	if ((long)ps.nr_dirty < 0)
 		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
-	if ((long)ps.nr_mapped < 0)
-		ps.nr_mapped = 0;
 	if ((long)ps.nr_slab < 0)
 		ps.nr_slab = 0;
 
@@ -83,7 +83,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(ps.nr_dirty),
 		       nid, K(ps.nr_writeback),
-		       nid, K(ps.nr_mapped),
+		       nid, K(nr_mapped),
 		       nid, K(ps.nr_slab));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/proc/proc_misc.c	2005-12-12 09:10:33.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c	2005-12-14 14:57:29.000000000 -0800
@@ -190,7 +190,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeswap),
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
-		K(ps.nr_mapped),
+		K(global_page_state(NR_MAPPED)),
 		K(ps.nr_slab),
 		K(allowed),
 		K(committed),
Index: linux-2.6.15-rc5-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/vmscan.c	2005-12-13 20:41:05.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/vmscan.c	2005-12-14 14:57:29.000000000 -0800
@@ -1429,7 +1429,7 @@ int try_to_free_pages(struct zone **zone
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		sc.nr_mapped = read_page_state(nr_mapped);
+		sc.nr_mapped = global_page_state(NR_MAPPED);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
@@ -1517,7 +1517,7 @@ loop_again:
 	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
-	sc.nr_mapped = read_page_state(nr_mapped);
+	sc.nr_mapped = global_page_state(NR_MAPPED);
 
 	inc_page_state(pageoutrun);
 
Index: linux-2.6.15-rc5-mm2/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page-writeback.c	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page-writeback.c	2005-12-14 14:57:29.000000000 -0800
@@ -111,7 +111,7 @@ static void get_writeback_state(struct w
 {
 	wbs->nr_dirty = read_page_state(nr_dirty);
 	wbs->nr_unstable = read_page_state(nr_unstable);
-	wbs->nr_mapped = read_page_state(nr_mapped);
+	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = read_page_state(nr_writeback);
 }
 
Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 14:57:22.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 14:57:29.000000000 -0800
@@ -1784,7 +1784,7 @@ void show_free_areas(void)
 		ps.nr_unstable,
 		nr_free_pages(),
 		ps.nr_slab,
-		ps.nr_mapped,
+		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
 	for_each_zone(zone) {
Index: linux-2.6.15-rc5-mm2/mm/rmap.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/rmap.c	2005-12-14 10:54:05.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/rmap.c	2005-12-14 14:57:29.000000000 -0800
@@ -473,7 +473,7 @@ static void __page_set_anon_rmap(struct 
 
 	page->index = linear_page_index(vma, address);
 
-	inc_page_state(nr_mapped);
+	inc_zone_page_state(page, NR_MAPPED);
 }
 
 /**
@@ -520,7 +520,7 @@ void page_add_file_rmap(struct page *pag
 	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
 	if (atomic_inc_and_test(&page->_mapcount))
-		inc_page_state(nr_mapped);
+		inc_zone_page_state(page, NR_MAPPED);
 }
 
 /**
@@ -544,7 +544,7 @@ void page_remove_rmap(struct page *page)
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		dec_page_state(nr_mapped);
+		dec_zone_page_state(page, NR_MAPPED);
 	}
 }
 
Index: linux-2.6.15-rc5-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/swap_prefetch.c	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/swap_prefetch.c	2005-12-14 14:57:29.000000000 -0800
@@ -327,7 +327,7 @@ static int prefetch_suitable(void)
 	 * >2/3 of the ram is mapped or swapcache, we need some free for
 	 * pagecache
 	 */
-	limit = ps.nr_mapped + ps.nr_slab + pending_writes +
+	limit = global_page_state(NR_MAPPED) + ps.nr_slab + pending_writes +
 		total_swapcache_pages;
 	if (limit > mapped_limit)
 		goto out;
Index: linux-2.6.15-rc5-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mmzone.h	2005-12-14 14:46:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mmzone.h	2005-12-14 14:57:29.000000000 -0800
@@ -44,8 +44,8 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-enum zone_stat_item { };
-#define NR_STAT_ITEMS 0
+enum zone_stat_item { NR_MAPPED };
+#define NR_STAT_ITEMS 1
 
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
