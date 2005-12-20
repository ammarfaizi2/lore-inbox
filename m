Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVLTWDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVLTWDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVLTWCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:02:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15336 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932164AbVLTWCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:02:16 -0500
Date: Tue, 20 Dec 2005 14:02:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051220220211.30326.97635.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zoned counters V1 [ 4/14]: Convert nr_mapped
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert nr_mapped

nr_mapped is important because it allows a determination how many pages of a
zone are not mapped, which would allow a more efficient means of determining
when we need to reclaim memory in a zone.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/base/node.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/base/node.c	2005-12-20 12:57:42.000000000 -0800
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
Index: linux-2.6.15-rc5-mm3/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/fs/proc/proc_misc.c	2005-12-16 11:44:08.000000000 -0800
+++ linux-2.6.15-rc5-mm3/fs/proc/proc_misc.c	2005-12-20 12:57:42.000000000 -0800
@@ -190,7 +190,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeswap),
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
-		K(ps.nr_mapped),
+		K(global_page_state(NR_MAPPED)),
 		K(ps.nr_slab),
 		K(allowed),
 		K(committed),
Index: linux-2.6.15-rc5-mm3/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/vmscan.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/vmscan.c	2005-12-20 12:57:42.000000000 -0800
@@ -1195,7 +1195,7 @@ int try_to_free_pages(struct zone **zone
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		sc.nr_mapped = read_page_state(nr_mapped);
+		sc.nr_mapped = global_page_state(NR_MAPPED);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
@@ -1283,7 +1283,7 @@ loop_again:
 	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
-	sc.nr_mapped = read_page_state(nr_mapped);
+	sc.nr_mapped = global_page_state(NR_MAPPED);
 
 	inc_page_state(pageoutrun);
 
Index: linux-2.6.15-rc5-mm3/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page-writeback.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page-writeback.c	2005-12-20 12:57:42.000000000 -0800
@@ -111,7 +111,7 @@ static void get_writeback_state(struct w
 {
 	wbs->nr_dirty = read_page_state(nr_dirty);
 	wbs->nr_unstable = read_page_state(nr_unstable);
-	wbs->nr_mapped = read_page_state(nr_mapped);
+	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = read_page_state(nr_writeback);
 }
 
Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 12:57:39.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 12:57:51.000000000 -0800
@@ -1789,7 +1789,7 @@ void show_free_areas(void)
 		ps.nr_unstable,
 		nr_free_pages(),
 		ps.nr_slab,
-		ps.nr_mapped,
+		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
 	for_each_zone(zone) {
@@ -2674,13 +2674,13 @@ struct seq_operations zoneinfo_op = {
 
 static char *vmstat_text[] = {
 	/* Zoned VM counters */
+	"nr_mapped",
 
 	/* Page state */
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
 	"nr_page_table_pages",
-	"nr_mapped",
 	"nr_slab",
 
 	"pgpgin",
Index: linux-2.6.15-rc5-mm3/mm/rmap.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/rmap.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/rmap.c	2005-12-20 12:57:42.000000000 -0800
@@ -455,7 +455,7 @@ static void __page_set_anon_rmap(struct 
 	 * nr_mapped state can be updated without turning off
 	 * interrupts because it is not modified via interrupt.
 	 */
-	__inc_page_state(nr_mapped);
+	__inc_zone_page_state(page, NR_MAPPED);
 }
 
 /**
@@ -502,7 +502,7 @@ void page_add_file_rmap(struct page *pag
 	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
 	if (atomic_inc_and_test(&page->_mapcount))
-		__inc_page_state(nr_mapped);
+		__inc_zone_page_state(page, NR_MAPPED);
 }
 
 /**
@@ -526,7 +526,7 @@ void page_remove_rmap(struct page *page)
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		__dec_page_state(nr_mapped);
+		__dec_zone_page_state(page, NR_MAPPED);
 	}
 }
 
Index: linux-2.6.15-rc5-mm3/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/mmzone.h	2005-12-20 12:57:37.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/mmzone.h	2005-12-20 12:57:42.000000000 -0800
@@ -45,6 +45,9 @@ struct zone_padding {
 #endif
 
 enum zone_stat_item {
+	NR_MAPPED,	/* mapped into pagetables.
+			   only modified from process context */
+
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-20 12:57:37.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 12:57:42.000000000 -0800
@@ -95,8 +95,6 @@ struct page_state {
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_mapped;	/* mapped into pagetables.
-					 * only modified from process context */
 	unsigned long nr_slab;		/* In slab */
 #define GET_PAGE_STATE_LAST nr_slab
 
