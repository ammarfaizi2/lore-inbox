Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWFNBLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWFNBLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWFNBDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:03:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:64740 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964836AbWFNBDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:01 -0400
Date: Tue, 13 Jun 2006 18:02:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010254.859.72764.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 03/21] Convert nr_mapped to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_mapped to per zone counter
From: Christoph Lameter <clameter@sgi.com>

nr_mapped is important because it allows a determination of how many pages of
a zone are not mapped, which would allow a more efficient means of determining
when we need to reclaim memory in a zone.

We take the nr_mapped field out of the page state structure and define a new
per zone counter named NR_MAPPED.

We replace the use of nr_mapped in various kernel locations.  This avoids the
looping over all processors in try_to_free_pages(), writeback, reclaim (swap +
zone reclaim).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/i386/mm/pgtable.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c	2006-06-13 10:16:27.147621215 -0700
@@ -61,7 +61,7 @@ void show_mem(void)
 	get_page_state(&ps);
 	printk(KERN_INFO "%lu pages dirty\n", ps.nr_dirty);
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
-	printk(KERN_INFO "%lu pages mapped\n", ps.nr_mapped);
+	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
 	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
 	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
 }
Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-12 12:42:42.797286410 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 10:16:27.147621215 -0700
@@ -54,8 +54,6 @@ static ssize_t node_read_meminfo(struct 
 		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
-	if ((long)ps.nr_mapped < 0)
-		ps.nr_mapped = 0;
 	if ((long)ps.nr_slab < 0)
 		ps.nr_slab = 0;
 
@@ -84,7 +82,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(ps.nr_dirty),
 		       nid, K(ps.nr_writeback),
-		       nid, K(ps.nr_mapped),
+		       nid, K(node_page_state(nid, NR_MAPPED)),
 		       nid, K(ps.nr_slab));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-12 12:42:48.170000806 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-13 10:16:27.149574219 -0700
@@ -190,7 +190,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeswap),
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
-		K(ps.nr_mapped),
+		K(global_page_state(NR_MAPPED)),
 		K(ps.nr_slab),
 		K(allowed),
 		K(committed),
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 10:16:22.331512915 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 10:16:27.149574219 -0700
@@ -47,6 +47,9 @@ struct zone_padding {
 #endif
 
 enum zone_stat_item {
+	NR_MAPPED,	/* mapped into pagetables.
+			   only modified from process context */
+
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-13 10:16:22.333465919 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-13 10:16:27.151527223 -0700
@@ -1409,7 +1409,7 @@ void show_free_areas(void)
 		ps.nr_unstable,
 		nr_free_pages(),
 		ps.nr_slab,
-		ps.nr_mapped,
+		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
 	for_each_zone(zone) {
Index: linux-2.6.17-rc6-cl/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page-writeback.c	2006-06-12 12:42:52.043784523 -0700
+++ linux-2.6.17-rc6-cl/mm/page-writeback.c	2006-06-13 10:16:27.152503726 -0700
@@ -111,7 +111,7 @@ static void get_writeback_state(struct w
 {
 	wbs->nr_dirty = read_page_state(nr_dirty);
 	wbs->nr_unstable = read_page_state(nr_unstable);
-	wbs->nr_mapped = read_page_state(nr_mapped);
+	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = read_page_state(nr_writeback);
 }
 
Index: linux-2.6.17-rc6-cl/mm/rmap.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/rmap.c	2006-06-12 12:42:52.051596540 -0700
+++ linux-2.6.17-rc6-cl/mm/rmap.c	2006-06-13 10:16:27.152503726 -0700
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
 
Index: linux-2.6.17-rc6-cl/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmscan.c	2006-06-13 10:09:38.236386570 -0700
+++ linux-2.6.17-rc6-cl/mm/vmscan.c	2006-06-13 10:16:55.059956905 -0700
@@ -996,7 +996,7 @@ unsigned long try_to_free_pages(struct z
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		sc.nr_mapped = read_page_state(nr_mapped);
+		sc.nr_mapped = global_page_state(NR_MAPPED);
 		sc.nr_scanned = 0;
 		if (!priority)
 			disable_swap_token();
@@ -1081,7 +1081,7 @@ loop_again:
 	total_scanned = 0;
 	nr_reclaimed = 0;
 	sc.may_writepage = !laptop_mode;
-	sc.nr_mapped = read_page_state(nr_mapped);
+	sc.nr_mapped = global_page_state(NR_MAPPED);
 
 	inc_page_state(pageoutrun);
 
@@ -1416,7 +1416,7 @@ unsigned long shrink_all_memory(unsigned
 		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
 			unsigned long nr_to_scan = nr_pages - ret;
 
-			sc.nr_mapped = read_page_state(nr_mapped);
+			sc.nr_mapped = global_page_state(NR_MAPPED);
 			sc.nr_scanned = 0;
 
 			ret += shrink_all_zones(nr_to_scan, prio, pass, &sc);
@@ -1558,7 +1558,7 @@ static int __zone_reclaim(struct zone *z
 	struct scan_control sc = {
 		.may_writepage = !!(zone_reclaim_mode & RECLAIM_WRITE),
 		.may_swap = !!(zone_reclaim_mode & RECLAIM_SWAP),
-		.nr_mapped = read_page_state(nr_mapped),
+		.nr_mapped = global_page_state(NR_MAPPED),
 		.swap_cluster_max = max_t(unsigned long, nr_pages,
 					SWAP_CLUSTER_MAX),
 		.gfp_mask = gfp_mask,
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 10:16:22.372526003 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 10:16:27.154456730 -0700
@@ -463,13 +463,13 @@ struct seq_operations fragmentation_op =
 
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
