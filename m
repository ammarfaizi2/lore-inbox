Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVLTWCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVLTWCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVLTWCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:02:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25064 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932170AbVLTWCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:02:31 -0500
Date: Tue, 20 Dec 2005 14:02:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051220220227.30326.11894.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zoned counters V1 [ 7/14]: Convert nr_slab
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert nr_slab

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/base/node.c	2005-12-20 12:57:57.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/base/node.c	2005-12-20 12:58:02.000000000 -0800
@@ -88,7 +88,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(ps.nr_writeback),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
-		       nid, K(ps.nr_slab));
+		       nid, K(nr[NR_SLAB]));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
Index: linux-2.6.15-rc5-mm3/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/fs/proc/proc_misc.c	2005-12-20 12:57:55.000000000 -0800
+++ linux-2.6.15-rc5-mm3/fs/proc/proc_misc.c	2005-12-20 12:58:02.000000000 -0800
@@ -191,7 +191,7 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
 		K(global_page_state(NR_MAPPED)),
-		K(ps.nr_slab),
+		K(global_page_state(NR_SLAB)),
 		K(allowed),
 		K(committed),
 		K(ps.nr_page_table_pages),
Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 12:57:57.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 12:58:17.000000000 -0800
@@ -597,7 +597,7 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
-char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache" };
+char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab" };
 
 /*
  * Manage combined zone based / global counters
@@ -1784,7 +1784,7 @@ void show_free_areas(void)
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
-		ps.nr_slab,
+		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
 		ps.nr_page_table_pages);
 
@@ -2677,13 +2677,13 @@ static char *vmstat_text[] = {
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
Index: linux-2.6.15-rc5-mm3/mm/slab.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/slab.c	2005-12-20 12:57:37.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/slab.c	2005-12-20 12:58:02.000000000 -0800
@@ -1236,7 +1236,7 @@ static void *kmem_getpages(kmem_cache_t 
 	i = (1 << cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		atomic_add(i, &slab_reclaim_pages);
-	add_page_state(nr_slab, i);
+	add_zone_page_state(page_zone(page), NR_SLAB, i);
 	while (i--) {
 		SetPageSlab(page);
 		page++;
@@ -1258,7 +1258,7 @@ static void kmem_freepages(kmem_cache_t 
 			BUG();
 		page++;
 	}
-	sub_page_state(nr_slab, nr_freed);
+	sub_zone_page_state(page_zone(page), NR_SLAB, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
Index: linux-2.6.15-rc5-mm3/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/mmzone.h	2005-12-20 12:57:55.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/mmzone.h	2005-12-20 12:58:02.000000000 -0800
@@ -48,6 +48,7 @@ enum zone_stat_item {
 	NR_MAPPED,	/* mapped into pagetables.
 			   only modified from process context */
 	NR_PAGECACHE,	/* file backed pages */
+	NR_SLAB,	/* used by slab allocator */
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-20 12:57:42.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 12:58:02.000000000 -0800
@@ -95,8 +95,7 @@ struct page_state {
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_slab;		/* In slab */
-#define GET_PAGE_STATE_LAST nr_slab
+#define GET_PAGE_STATE_LAST nr_page_table_pages
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
