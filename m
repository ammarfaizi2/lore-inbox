Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWFNBEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWFNBEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWFNBD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:03:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8165 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964836AbWFNBDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:37 -0400
Date: Tue, 13 Jun 2006 18:03:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010330.859.98146.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
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
--- linux-2.6.17-rc6-cl.orig/arch/i386/mm/pgtable.c	2006-06-13 14:06:16.470959812 -0700
+++ linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c	2006-06-13 14:49:15.231436578 -0700
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
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-13 14:06:16.786369922 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 14:49:15.232413079 -0700
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
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-13 14:06:16.782463915 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-13 14:49:15.233389581 -0700
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
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 14:49:09.660493553 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 14:49:15.233389581 -0700
@@ -51,6 +51,7 @@ enum zone_stat_item {
 	NR_MAPPED,	/* pagecache pages mapped into pagetables.
 			   only modified from process context */
 	NR_PAGECACHE,
+	NR_SLAB,	/* Pages used by slab allocator */
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-13 14:06:16.689696235 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-13 14:49:15.235342585 -0700
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
--- linux-2.6.17-rc6-cl.orig/mm/slab.c	2006-06-13 11:11:42.552796740 -0700
+++ linux-2.6.17-rc6-cl/mm/slab.c	2006-06-13 14:49:15.237295589 -0700
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
--- linux-2.6.17-rc6-cl.orig/mm/vmscan.c	2006-06-13 14:49:09.665376062 -0700
+++ linux-2.6.17-rc6-cl/mm/vmscan.c	2006-06-13 14:49:15.238272090 -0700
@@ -1371,7 +1371,7 @@ unsigned long shrink_all_memory(unsigned
 	for_each_zone(zone)
 		lru_pages += zone->nr_active + zone->nr_inactive;
 
-	nr_slab = read_page_state(nr_slab);
+	nr_slab = global_page_state(NR_SLAB);
 	/* If slab caches are huge, it's better to hit them first */
 	while (nr_slab >= lru_pages) {
 		reclaim_state.reclaimed_slab = 0;
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 14:49:01.936363963 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 14:49:54.879364524 -0700
@@ -460,13 +460,13 @@ static char *vmstat_text[] = {
 	"nr_anon",
 	"nr_mapped",
 	"nr_pagecache",
+	"nr_slab",
 
 	/* Page state */
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
 	"nr_page_table_pages",
-	"nr_slab",
 
 	"pgpgin",
 	"pgpgout",
