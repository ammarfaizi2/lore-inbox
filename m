Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVLJAy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVLJAy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVLJAy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:54:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:3471 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932536AbVLJAy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:54:56 -0500
Date: Fri, 9 Dec 2005 16:54:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210005450.3887.22932.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 2/6] Make nr_mapped a per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make nr_mapped a per zone counter

The per cpu nr_mapped counter is important because it allows a determination
how many pages of a zone are not mapped, which would allow a more efficient
means of determining when we need to reclaim memory in a zone.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/page-flags.h	2005-12-09 16:27:13.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/page-flags.h	2005-12-09 16:31:45.000000000 -0800
@@ -85,7 +85,6 @@ struct page_state {
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_mapped;	/* mapped into pagetables */
 	unsigned long nr_slab;		/* In slab */
 #define GET_PAGE_STATE_LAST nr_slab
 
Index: linux-2.6.15-rc5/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/base/node.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/drivers/base/node.c	2005-12-09 16:32:25.000000000 -0800
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
Index: linux-2.6.15-rc5/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/proc/proc_misc.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/fs/proc/proc_misc.c	2005-12-09 16:31:45.000000000 -0800
@@ -190,7 +190,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeswap),
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
-		K(ps.nr_mapped),
+		K(global_page_state(NR_MAPPED)),
 		K(ps.nr_slab),
 		K(allowed),
 		K(committed),
Index: linux-2.6.15-rc5/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/vmscan.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/mm/vmscan.c	2005-12-09 16:31:45.000000000 -0800
@@ -967,7 +967,7 @@ int try_to_free_pages(struct zone **zone
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		sc.nr_mapped = read_page_state(nr_mapped);
+		sc.nr_mapped = global_page_state(NR_MAPPED);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
@@ -1056,7 +1056,7 @@ loop_again:
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
 	sc.may_swap = 1;
-	sc.nr_mapped = read_page_state(nr_mapped);
+	sc.nr_mapped = global_page_state(NR_MAPPED);
 
 	inc_page_state(pageoutrun);
 
@@ -1373,7 +1373,7 @@ int zone_reclaim(struct zone *zone, gfp_
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 	sc.may_swap = 0;
-	sc.nr_mapped = read_page_state(nr_mapped);
+	sc.nr_mapped = global_page_state(NR_MAPPED);
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
 	/* scan at the highest priority */
Index: linux-2.6.15-rc5/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/page-writeback.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/mm/page-writeback.c	2005-12-09 16:31:45.000000000 -0800
@@ -111,7 +111,7 @@ static void get_writeback_state(struct w
 {
 	wbs->nr_dirty = read_page_state(nr_dirty);
 	wbs->nr_unstable = read_page_state(nr_unstable);
-	wbs->nr_mapped = read_page_state(nr_mapped);
+	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = read_page_state(nr_writeback);
 }
 
Index: linux-2.6.15-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/page_alloc.c	2005-12-09 16:28:30.000000000 -0800
+++ linux-2.6.15-rc5/mm/page_alloc.c	2005-12-09 16:31:45.000000000 -0800
@@ -1435,7 +1435,7 @@ void show_free_areas(void)
 		ps.nr_unstable,
 		nr_free_pages(),
 		ps.nr_slab,
-		ps.nr_mapped,
+		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
 	for_each_zone(zone) {
Index: linux-2.6.15-rc5/mm/rmap.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/rmap.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/mm/rmap.c	2005-12-09 16:31:45.000000000 -0800
@@ -454,7 +454,7 @@ void page_add_anon_rmap(struct page *pag
 
 		page->index = linear_page_index(vma, address);
 
-		inc_page_state(nr_mapped);
+		inc_zone_page_state(page_zone(page), NR_MAPPED);
 	}
 	/* else checking page index and mapping is racy */
 }
@@ -471,7 +471,7 @@ void page_add_file_rmap(struct page *pag
 	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
 	if (atomic_inc_and_test(&page->_mapcount))
-		inc_page_state(nr_mapped);
+		inc_zone_page_state(page_zone(page), NR_MAPPED);
 }
 
 /**
@@ -495,7 +495,7 @@ void page_remove_rmap(struct page *page)
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		dec_page_state(nr_mapped);
+		dec_zone_page_state(page_zone(page), NR_MAPPED);
 	}
 }
 
