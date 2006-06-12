Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWFLVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWFLVOS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWFLVON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:14:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54703 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932277AbWFLVNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:13:47 -0400
Date: Mon, 12 Jun 2006 14:13:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211336.20862.5128.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 10/21] Conversion of nr_slab to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_slab to per zone counter
From: Christoph Lameter <clameter@sgi.com>

- Allows reclaim to access counter without looping over processor counts.

- Allows accurate statistics on how many pages are used in a zone by
  the slab. This may become useful to balance slab allocations over
  various zones.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/i386/mm/pgtable.c	2006-06-12 12:57:23.381448638 -0700
+++ linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c	2006-06-12 13:02:16.916004785 -0700
@@ -62,7 +62,7 @@ void show_mem(void)
 	printk(KERN_INFO "%lu pages dirty\n", ps.nr_dirty);
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
 	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
-	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
+	printk(KERN_INFO "%lu pages slab\n", global_page_state(NR_SLAB));
 	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
 }
 
Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-12 13:01:30.625902765 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-12 13:02:16.916981287 -0700
@@ -54,8 +54,6 @@ static ssize_t node_read_meminfo(struct 
 		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
-	if ((long)ps.nr_slab < 0)
-		ps.nr_slab = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
@@ -87,7 +85,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(node_page_state(nid, NR_PAGECACHE)),
 		       nid, K(node_page_state(nid, NR_MAPPED)),
 		       nid, K(node_page_state(nid, NR_ANON)),
-		       nid, K(ps.nr_slab));
+		       nid, K(node_page_state(nid, NR_SLAB)));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-12 13:01:30.621020255 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-12 13:02:16.917957789 -0700
@@ -194,7 +194,7 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_writeback),
 		K(global_page_state(NR_ANON)),
 		K(global_page_state(NR_MAPPED)),
-		K(ps.nr_slab),
+		K(global_page_state(NR_SLAB)),
 		K(allowed),
 		K(committed),
 		K(ps.nr_page_table_pages),
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-12 13:02:14.488420750 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-12 13:02:16.918934291 -0700
@@ -51,6 +51,7 @@ enum zone_stat_item {
 	NR_MAPPED,	/* pagecache pages mapped into pagetables.
 			   only modified from process context */
 	NR_PAGECACHE,
+	NR_SLAB,	/* Pages used by slab allocator */
 	NR_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-12 13:00:50.584437193 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-12 13:02:16.920887295 -0700
@@ -1408,7 +1408,7 @@ void show_free_areas(void)
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
-		ps.nr_slab,
+		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
Index: linux-2.6.17-rc6-cl/mm/slab.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/slab.c	2006-06-12 12:54:33.242570771 -0700
+++ linux-2.6.17-rc6-cl/mm/slab.c	2006-06-12 13:02:16.923816801 -0700
@@ -1525,7 +1525,7 @@ static void *kmem_getpages(struct kmem_c
 	nr_pages = (1 << cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		atomic_add(nr_pages, &slab_reclaim_pages);
-	add_page_state(nr_slab, nr_pages);
+	add_zone_page_state(page_zone(page), NR_SLAB, nr_pages);
 	for (i = 0; i < nr_pages; i++)
 		__SetPageSlab(page + i);
 	return page_address(page);
@@ -1545,7 +1545,7 @@ static void kmem_freepages(struct kmem_c
 		__ClearPageSlab(page);
 		page++;
 	}
-	sub_page_state(nr_slab, nr_freed);
+	sub_zone_page_state(page_zone(page), NR_SLAB, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
Index: linux-2.6.17-rc6-cl/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmscan.c	2006-06-12 13:02:14.493303260 -0700
+++ linux-2.6.17-rc6-cl/mm/vmscan.c	2006-06-12 13:02:16.924793303 -0700
@@ -1372,7 +1372,7 @@ unsigned long shrink_all_memory(unsigned
 	for_each_zone(zone)
 		lru_pages += zone->nr_active + zone->nr_inactive;
 
-	nr_slab = read_page_state(nr_slab);
+	nr_slab = global_page_state(NR_SLAB);
 	/* If slab caches are huge, it's better to hit them first */
 	while (nr_slab >= lru_pages) {
 		reclaim_state.reclaimed_slab = 0;
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-12 13:02:08.289585892 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-12 13:02:26.602904877 -0700
@@ -466,13 +466,13 @@ static char *vmstat_text[] = {
 	"nr_mapped",
 	"nr_pagecache",
 	"nr_anon",
+	"nr_slab",
 
 	/* Page state */
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
 	"nr_page_table_pages",
-	"nr_slab",
 
 	"pgpgin",
 	"pgpgout",
