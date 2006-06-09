Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWFISyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWFISyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWFISyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:54:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38800 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030390AbWFISyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:54:39 -0400
Date: Fri, 9 Jun 2006 11:54:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, hugh@veritas.com, npiggin@suse.de,
       linux-mm@kvack.org, ak@suse.de
Subject: zoned VM stats: Add NR_ANON
In-Reply-To: <20060608210056.9b2f3f13.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606091152490.916@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
 <20060608230305.25121.97821.sendpatchset@schroedinger.engr.sgi.com>
 <20060608210056.9b2f3f13.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, Andrew Morton wrote:

> On Thu, 8 Jun 2006 16:03:05 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > Caveat: The number of mapped pages includes anonymous pages.
> > The current check works but is a bit too cautious. We could perform
> > zone reclaim down to the last unmapped page if we would split NR_MAPPED
> > into NR_MAPPED_PAGECACHE and NR_MAPPED_ANON. Maybe later.
> 
> That caveat should be in a code comment, please.  Otherwise we'll forget.

Maybe we can deal with this issue immediately by introducing NR_ANON?


zoned VM stats: Add NR_ANON

The current NR_MAPPED is used by zone reclaim and the dirty load calculation
as the number of mapped pagecache pages. However, that is not true. NR_MAPPED
includes the mapped anonymous pages. This patch clearly separates those and
therefore allows an accurate tracking of the anonymous pages per zone and the
number of mapped pages in the pagecache of each zone.

We can then more accurately determine when zone reclaim is to be run.

Also it may now be possible to determine the mapped/unmapped
ratio in get_dirty_limit. Isnt the number of anonymous pages
irrelevant in that calculation?

Note that this will change the meaning of the number of mapped pages
reported in /proc/vmstat /proc/meminfo and in the per node statistics.
This may affect user space tools that monitor these counters!

However, NR_MAPPED then works like NR_DIRTY. It is only valid for
pagecache pages.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-09 10:30:52.414461763 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-09 11:26:59.385565250 -0700
@@ -65,6 +65,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
 		       "Node %d Unstable:     %8lu kB\n"
+		       "Node %d Anonymous:    %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
 		       "Node %d Pagecache:    %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n"
@@ -81,6 +82,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(nr[NR_DIRTY]),
 		       nid, K(nr[NR_WRITEBACK]),
 		       nid, K(nr[NR_UNSTABLE]),
+		       nid, K(nr[NR_ANON]),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
 		       nid, K(nr[NR_SLAB]),
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-09 10:30:52.414461763 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-09 11:41:32.525809812 -0700
@@ -629,8 +629,9 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 char *vm_stat_item_descr[NR_STAT_ITEMS] = {
-	"mapped", "pagecache", "slab", "pagetable", "dirty", "writeback",
-	"unstable", "bounce"
+	"anon", "mapped", "pagecache", "slab",
+	"pagetable", "dirty", "writeback", "unstable",
+	"bounce"
 };
 
 /*
@@ -2781,6 +2782,7 @@ struct seq_operations zoneinfo_op = {
 
 static char *vmstat_text[] = {
 	/* Zoned VM counters */
+	"nr_anon",
 	"nr_mapped",
 	"nr_pagecache",
 	"nr_slab",
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-09 10:30:52.400790734 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-09 11:26:59.388494756 -0700
@@ -47,7 +47,8 @@ struct zone_padding {
 #endif
 
 enum zone_stat_item {
-	NR_MAPPED,	/* mapped into pagetables.
+	NR_ANON,	/* Mapped anonymous pages */
+	NR_MAPPED,	/* pagecache pages mapped into pagetables.
 			   only modified from process context */
 	NR_PAGECACHE,	/* file backed pages */
 	NR_SLAB,	/* used by slab allocator */
Index: linux-2.6.17-rc6-mm1/mm/rmap.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/rmap.c	2006-06-09 10:30:51.768993888 -0700
+++ linux-2.6.17-rc6-mm1/mm/rmap.c	2006-06-09 11:26:59.389471258 -0700
@@ -455,7 +455,7 @@ static void __page_set_anon_rmap(struct 
 	 * nr_mapped state can be updated without turning off
 	 * interrupts because it is not modified via interrupt.
 	 */
-	__inc_zone_page_state(page, NR_MAPPED);
+	__inc_zone_page_state(page, NR_ANON);
 }
 
 /**
@@ -531,7 +531,7 @@ void page_remove_rmap(struct page *page)
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		__dec_zone_page_state(page, NR_MAPPED);
+		__dec_zone_page_state(page, PageAnon(page) ? NR_ANON : NR_MAPPED);
 	}
 }
 
Index: linux-2.6.17-rc6-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/vmscan.c	2006-06-09 11:17:08.125321243 -0700
+++ linux-2.6.17-rc6-mm1/mm/vmscan.c	2006-06-09 11:30:34.159368970 -0700
@@ -747,7 +747,8 @@ static void shrink_active_list(unsigned 
 		 * how much memory
 		 * is mapped.
 		 */
-		mapped_ratio = global_page_state(NR_MAPPED) / vm_total_pages;
+		mapped_ratio = (global_page_state(NR_MAPPED) +
+				global_page_state(NR_ANON)) / vm_total_pages;
 
 		/*
 		 * Now decide how much we really want to unmap some pages.  The
@@ -1603,13 +1604,16 @@ int zone_reclaim(struct zone *zone, gfp_
 
 	/*
 	 * Do not reclaim if there are not enough reclaimable pages in this
-	 * zone. We decide this based on the number of mapped pages
-	 * in relation to the number of page cache pages in this zone.
-	 * If there are more pagecache pages than mapped pages then we can
-	 * be certain that pages can be reclaimed.
+	 * zone that would satify this allocations.
+	 *
+	 * All unmapped pagecache pages are reclaimable.
+	 *
+	 * Both counters may be temporarily off a bit so we use
+	 * SWAP_CLUSTER_MAX as the boundary. It may also be good to
+	 * leave a few frequently used unmapped pagecache pages around.
 	 */
-	if (zone_page_state(zone, NR_PAGECACHE) <
-		zone_page_state(zone, NR_MAPPED))
+	if (zone_page_state(zone, NR_PAGECACHE) -
+		zone_page_state(zone, NR_MAPPED) < SWAP_CLUSTER_MAX)
 			return 0;
 
 	/*
Index: linux-2.6.17-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap_prefetch.c	2006-06-09 11:17:22.126406920 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap_prefetch.c	2006-06-09 11:27:25.602691036 -0700
@@ -388,6 +388,7 @@ static int prefetch_suitable(void)
 		 * dirty, we need to leave some free for pagecache.
 		 */
 		limit = global_page_state(NR_MAPPED) +
+			global_page_state(NR_ANON) +
 			global_page_state(NR_SLAB) +
 			global_page_state(NR_DIRTY) +
 			global_page_state(NR_UNSTABLE) +
Index: linux-2.6.17-rc6-mm1/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page-writeback.c	2006-06-09 10:30:52.452545344 -0700
+++ linux-2.6.17-rc6-mm1/mm/page-writeback.c	2006-06-09 11:32:08.435754999 -0700
@@ -137,7 +137,9 @@ get_dirty_limits(long *pbackground, long
 #endif
 
 
-	unmapped_ratio = 100 - (global_page_state(NR_MAPPED) * 100) / total_pages;
+	unmapped_ratio = 100 - ((global_page_state(NR_MAPPED) +
+				 global_page_state(NR_ANON)) * 100) /
+					total_pages;
 
 	dirty_ratio = vm_dirty_ratio;
 	if (dirty_ratio > unmapped_ratio / 2)
Index: linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/proc/proc_misc.c	2006-06-09 10:30:52.363683655 -0700
+++ linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c	2006-06-09 11:33:46.053730933 -0700
@@ -165,6 +165,7 @@ static int meminfo_read_proc(char *page,
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
 		"Writeback:    %8lu kB\n"
+		"Anonymous:    %8lu kB\n"
 		"Mapped:       %8lu kB\n"
 		"Slab:         %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
@@ -188,6 +189,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeswap),
 		K(global_page_state(NR_DIRTY)),
 		K(global_page_state(NR_WRITEBACK)),
+		K(global_page_state(NR_ANON)),
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
 		K(allowed),
