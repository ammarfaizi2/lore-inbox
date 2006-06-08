Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWFHXDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWFHXDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWFHXDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:53217 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965054AbWFHXD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:29 -0400
Date: Thu, 8 Jun 2006 16:03:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230316.25121.39380.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 07/14] Conversion of nr_slab to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of nr_slab to a per zone counter

- Allows reclaim to access counter without looping over processor counts.

- Allows accurate statistics on how many pages are used in a zone by
  the slab. This may become useful to balance slab allocations over
  various zones.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-08 15:45:42.633134614 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-08 15:45:44.040274043 -0700
@@ -58,8 +58,6 @@ static ssize_t node_read_meminfo(struct 
 		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
-	if ((long)ps.nr_slab < 0)
-		ps.nr_slab = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
@@ -89,7 +87,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(ps.nr_writeback),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
-		       nid, K(ps.nr_slab));
+		       nid, K(nr[NR_SLAB]));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
Index: linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/proc/proc_misc.c	2006-06-08 15:45:25.571691103 -0700
+++ linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c	2006-06-08 15:45:44.041250545 -0700
@@ -191,7 +191,7 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
 		K(global_page_state(NR_MAPPED)),
-		K(ps.nr_slab),
+		K(global_page_state(NR_SLAB)),
 		K(allowed),
 		K(committed),
 		K(ps.nr_page_table_pages),
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 15:45:42.636064120 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 15:45:44.043203549 -0700
@@ -628,7 +628,7 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
-char *vm_stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache" };
+char *vm_stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab" };
 
 /*
  * Manage combined zone based / global counters
@@ -1810,7 +1810,7 @@ void show_free_areas(void)
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
-		ps.nr_slab,
+		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
@@ -2804,13 +2804,13 @@ static char *vmstat_text[] = {
 	/* Zoned VM counters */
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
Index: linux-2.6.17-rc6-mm1/mm/slab.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/slab.c	2006-06-08 15:42:25.210789203 -0700
+++ linux-2.6.17-rc6-mm1/mm/slab.c	2006-06-08 15:45:44.046133055 -0700
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
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 15:45:41.276773291 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 15:45:44.046133055 -0700
@@ -50,6 +50,7 @@ enum zone_stat_item {
 	NR_MAPPED,	/* mapped into pagetables.
 			   only modified from process context */
 	NR_PAGECACHE,	/* file backed pages */
+	NR_SLAB,	/* used by slab allocator */
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 15:44:58.896585082 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 15:45:44.047109557 -0700
@@ -123,8 +123,7 @@ struct page_state {
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_slab;		/* In slab */
-#define GET_PAGE_STATE_LAST nr_slab
+#define GET_PAGE_STATE_LAST nr_page_table_pages
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.17-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap_prefetch.c	2006-06-08 15:44:58.896585082 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap_prefetch.c	2006-06-08 15:45:44.048086059 -0700
@@ -394,7 +394,9 @@ static int prefetch_suitable(void)
 		 * even if the slab is being allocated on a remote node. This
 		 * would be expensive to fix and not of great significance.
 		 */
-		limit = global_page_state(NR_MAPPED) + ps.nr_slab + ps.nr_dirty +
+		limit = global_page_state(NR_MAPPED) +
+			global_page_state(NR_SLAB) +
+			ps.nr_dirty +
 			ps.nr_unstable + total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
Index: linux-2.6.17-rc6-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/vmscan.c	2006-06-08 15:45:41.273843785 -0700
+++ linux-2.6.17-rc6-mm1/mm/vmscan.c	2006-06-08 15:45:44.049062561 -0700
@@ -1375,7 +1375,7 @@ unsigned long shrink_all_memory(unsigned
 	for_each_zone(zone)
 		lru_pages += zone->nr_active + zone->nr_inactive;
 
-	nr_slab = read_page_state(nr_slab);
+	nr_slab = global_page_state(NR_SLAB);
 	/* If slab caches are huge, it's better to hit them first */
 	while (nr_slab >= lru_pages) {
 		reclaim_state.reclaimed_slab = 0;
Index: linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/arch/i386/mm/pgtable.c	2006-06-08 15:45:17.903220642 -0700
+++ linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c	2006-06-08 15:46:08.094448609 -0700
@@ -62,7 +62,7 @@ void show_mem(void)
 	printk(KERN_INFO "%lu pages dirty\n", ps.nr_dirty);
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
 	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
-	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
+	printk(KERN_INFO "%lu pages slab\n", global_page_state(NR_SLAB));
 	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
 }
 
