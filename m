Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWFHXDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWFHXDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWFHXDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43745 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965053AbWFHXDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:04 -0400
Date: Thu, 8 Jun 2006 16:02:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230255.25121.15659.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 03/14] Conversion of nr_mapped to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of nr_mapped to a per zone counter

nr_mapped is important because it allows a determination how many pages of a
zone are not mapped, which would allow a more efficient means of determining
when we need to reclaim memory in a zone.

We take the nr_mapped field out of the page state structure and
define a new per zone counter named NR_MAPPED.

We replace the use of nr_mapped in various kernel locations. This avoids
the looping over all processors in try_to_free_pages(), writeback, reclaim
(swap + zone reclaim).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-08 15:20:05.426540998 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-08 15:44:58.889749567 -0700
@@ -44,18 +44,18 @@ static ssize_t node_read_meminfo(struct 
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
 
@@ -84,7 +84,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(ps.nr_dirty),
 		       nid, K(ps.nr_writeback),
-		       nid, K(ps.nr_mapped),
+		       nid, K(nr_mapped),
 		       nid, K(ps.nr_slab));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/proc/proc_misc.c	2006-06-08 15:20:08.334564156 -0700
+++ linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c	2006-06-08 15:44:58.890726069 -0700
@@ -190,7 +190,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeswap),
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
-		K(ps.nr_mapped),
+		K(global_page_state(NR_MAPPED)),
 		K(ps.nr_slab),
 		K(allowed),
 		K(committed),
Index: linux-2.6.17-rc6-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/vmscan.c	2006-06-08 15:20:11.595104562 -0700
+++ linux-2.6.17-rc6-mm1/mm/vmscan.c	2006-06-08 15:44:58.891702571 -0700
@@ -997,7 +997,7 @@ unsigned long try_to_free_pages(struct z
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		sc.nr_mapped = read_page_state(nr_mapped);
+		sc.nr_mapped = global_page_state(NR_MAPPED);
 		sc.nr_scanned = 0;
 		if (!priority)
 			disable_swap_token();
@@ -1082,7 +1082,7 @@ loop_again:
 	total_scanned = 0;
 	nr_reclaimed = 0;
 	sc.may_writepage = !laptop_mode,
-	sc.nr_mapped = read_page_state(nr_mapped);
+	sc.nr_mapped = global_page_state(NR_MAPPED);
 
 	inc_page_state(pageoutrun);
 
@@ -1417,7 +1417,7 @@ unsigned long shrink_all_memory(unsigned
 		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
 			unsigned long nr_to_scan = nr_pages - ret;
 
-			sc.nr_mapped = read_page_state(nr_mapped);
+			sc.nr_mapped = global_page_state(NR_MAPPED);
 			sc.nr_scanned = 0;
 
 			ret += shrink_all_zones(nr_to_scan, prio, pass, &sc);
@@ -1559,7 +1559,7 @@ static int __zone_reclaim(struct zone *z
 	struct scan_control sc = {
 		.may_writepage = !!(zone_reclaim_mode & RECLAIM_WRITE),
 		.may_swap = !!(zone_reclaim_mode & RECLAIM_SWAP),
-		.nr_mapped = read_page_state(nr_mapped),
+		.nr_mapped = global_page_state(NR_MAPPED),
 		.swap_cluster_max = max_t(unsigned long, nr_pages,
 					SWAP_CLUSTER_MAX),
 		.gfp_mask = gfp_mask,
Index: linux-2.6.17-rc6-mm1/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page-writeback.c	2006-06-08 15:20:11.553114973 -0700
+++ linux-2.6.17-rc6-mm1/mm/page-writeback.c	2006-06-08 15:44:58.892679074 -0700
@@ -111,7 +111,7 @@ static void get_writeback_state(struct w
 {
 	wbs->nr_dirty = read_page_state(nr_dirty);
 	wbs->nr_unstable = read_page_state(nr_unstable);
-	wbs->nr_mapped = read_page_state(nr_mapped);
+	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = read_page_state(nr_writeback);
 }
 
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 15:44:55.859663761 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 15:44:58.893655576 -0700
@@ -1815,7 +1815,7 @@ void show_free_areas(void)
 		ps.nr_unstable,
 		nr_free_pages(),
 		ps.nr_slab,
-		ps.nr_mapped,
+		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
 	for_each_zone(zone) {
@@ -2801,13 +2801,13 @@ struct seq_operations zoneinfo_op = {
 
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
Index: linux-2.6.17-rc6-mm1/mm/rmap.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/rmap.c	2006-06-08 15:20:11.579480529 -0700
+++ linux-2.6.17-rc6-mm1/mm/rmap.c	2006-06-08 15:44:58.894632078 -0700
@@ -455,7 +455,7 @@ static void __page_set_anon_rmap(struct 
 	 * nr_mapped state can be updated without turning off
 	 * interrupts because it is not modified via interrupt.
 	 */
-	__inc_page_state(nr_mapped);
+	__inc_zone_page_state(page, NR_MAPPED);
 }
 
 /**
@@ -499,7 +499,7 @@ void page_add_new_anon_rmap(struct page 
 void page_add_file_rmap(struct page *page)
 {
 	if (atomic_inc_and_test(&page->_mapcount))
-		__inc_page_state(nr_mapped);
+		__inc_zone_page_state(page, NR_MAPPED);
 }
 
 /**
@@ -531,7 +531,7 @@ void page_remove_rmap(struct page *page)
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		__dec_page_state(nr_mapped);
+		__dec_zone_page_state(page, NR_MAPPED);
 	}
 }
 
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 15:42:25.204930191 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 15:44:58.895608580 -0700
@@ -47,6 +47,9 @@ struct zone_padding {
 #endif
 
 enum zone_stat_item {
+	NR_MAPPED,	/* mapped into pagetables.
+			   only modified from process context */
+
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 15:42:25.205906693 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 15:44:58.896585082 -0700
@@ -123,8 +123,6 @@ struct page_state {
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_mapped;	/* mapped into pagetables.
-					 * only modified from process context */
 	unsigned long nr_slab;		/* In slab */
 #define GET_PAGE_STATE_LAST nr_slab
 
Index: linux-2.6.17-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap_prefetch.c	2006-06-08 15:20:11.590222051 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap_prefetch.c	2006-06-08 15:44:58.896585082 -0700
@@ -394,7 +394,7 @@ static int prefetch_suitable(void)
 		 * even if the slab is being allocated on a remote node. This
 		 * would be expensive to fix and not of great significance.
 		 */
-		limit = ps.nr_mapped + ps.nr_slab + ps.nr_dirty +
+		limit = global_page_state(NR_MAPPED) + ps.nr_slab + ps.nr_dirty +
 			ps.nr_unstable + total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
Index: linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/arch/i386/mm/pgtable.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c	2006-06-08 15:45:17.903220642 -0700
@@ -61,7 +61,7 @@ void show_mem(void)
 	get_page_state(&ps);
 	printk(KERN_INFO "%lu pages dirty\n", ps.nr_dirty);
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
-	printk(KERN_INFO "%lu pages mapped\n", ps.nr_mapped);
+	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
 	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
 	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
 }
