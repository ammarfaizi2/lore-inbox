Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbVLJA4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVLJA4H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVLJAzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:55:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15503 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932696AbVLJAzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:55:14 -0500
Date: Fri, 9 Dec 2005 16:55:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210005506.3887.94758.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 5/6] Make nr_slab a per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The number of slab pages in use is currently a counter split per cpu.
Make the number of slab pages a per zone counter so that we can see how
many slab pages have been allocated in each zone.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/base/node.c	2005-12-09 16:32:53.000000000 -0800
+++ linux-2.6.15-rc5/drivers/base/node.c	2005-12-09 16:32:57.000000000 -0800
@@ -88,7 +88,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(ps.nr_writeback),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
-		       nid, K(ps.nr_slab));
+		       nid, K(nr[NR_SLAB]));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
Index: linux-2.6.15-rc5/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/proc/proc_misc.c	2005-12-09 16:32:28.000000000 -0800
+++ linux-2.6.15-rc5/fs/proc/proc_misc.c	2005-12-09 16:32:57.000000000 -0800
@@ -191,7 +191,7 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
 		K(global_page_state(NR_MAPPED)),
-		K(ps.nr_slab),
+		K(global_page_state(NR_SLAB)),
 		K(allowed),
 		K(committed),
 		K(ps.nr_page_table_pages),
Index: linux-2.6.15-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/page_alloc.c	2005-12-09 16:32:53.000000000 -0800
+++ linux-2.6.15-rc5/mm/page_alloc.c	2005-12-09 16:32:57.000000000 -0800
@@ -556,7 +556,7 @@ static int rmqueue_bulk(struct zone *zon
 	return allocated;
 }
 
-char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache" };
+char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab" };
 
 /*
  * Manage combined zone based / global counters
@@ -1430,7 +1430,7 @@ void show_free_areas(void)
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
-		ps.nr_slab,
+		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
Index: linux-2.6.15-rc5/mm/slab.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/slab.c	2005-12-09 16:27:13.000000000 -0800
+++ linux-2.6.15-rc5/mm/slab.c	2005-12-09 16:32:57.000000000 -0800
@@ -1213,7 +1213,7 @@ static void *kmem_getpages(kmem_cache_t 
 	i = (1 << cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		atomic_add(i, &slab_reclaim_pages);
-	add_page_state(nr_slab, i);
+	add_zone_page_state(page_zone(page), NR_SLAB, i);
 	while (i--) {
 		SetPageSlab(page);
 		page++;
@@ -1235,7 +1235,7 @@ static void kmem_freepages(kmem_cache_t 
 			BUG();
 		page++;
 	}
-	sub_page_state(nr_slab, nr_freed);
+	sub_zone_page_state(page_zone(page), NR_SLAB, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
Index: linux-2.6.15-rc5/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/page-flags.h	2005-12-09 16:31:45.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/page-flags.h	2005-12-09 16:32:57.000000000 -0800
@@ -85,8 +85,7 @@ struct page_state {
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_slab;		/* In slab */
-#define GET_PAGE_STATE_LAST nr_slab
+#define GET_PAGE_STATE_LAST nr_page_table_pages
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.15-rc5/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/mmzone.h	2005-12-09 16:27:13.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/mmzone.h	2005-12-09 16:32:57.000000000 -0800
@@ -44,8 +44,8 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-enum zone_stat_item { NR_MAPPED, NR_PAGECACHE };
-#define NR_STAT_ITEMS 2
+enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB };
+#define NR_STAT_ITEMS 3
 
 /*
  * A hacky way of defining atomic long. Remove when
