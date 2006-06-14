Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWFNBDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWFNBDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWFNBDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:03:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4325 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964845AbWFNBDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:22 -0400
Date: Tue, 13 Jun 2006 18:03:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010314.859.14985.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 07/21] Split NR_ANON off from NR_MAPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned VM stats: Add NR_ANON
From: Christoph Lameter <clameter@sgi.com>

The current NR_MAPPED is used by zone reclaim and the dirty load
calculation as the number of mapped pagecache pages.  However, that is not
true.  NR_MAPPED includes the mapped anonymous pages.  This patch
separates those and therefore allows an accurate tracking of the anonymous
pages per zone.

It then becomes possible to determine the number of unmapped pages
per zone and we can avoid scanning for unmapped pages if there
are none.

Also it may now be possible to determine the mapped/unmapped ratio in
get_dirty_limit.  Isnt the number of anonymous pages irrelevant in that
calculation?

Note that this will change the meaning of the number of mapped pages
reported in /proc/vmstat /proc/meminfo and in the per node statistics.
This may affect user space tools that monitor these counters!
NR_MAPPED works like NR_DIRTY. It is only valid for pagecache pages.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-13 14:06:16.634035628 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-13 14:06:16.782463915 -0700
@@ -168,6 +168,7 @@ static int meminfo_read_proc(char *page,
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
 		"Writeback:    %8lu kB\n"
+		"Anonymous:    %8lu kB\n"
 		"Mapped:       %8lu kB\n"
 		"Slab:         %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
@@ -191,6 +192,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeswap),
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
+		K(global_page_state(NR_ANON)),
 		K(global_page_state(NR_MAPPED)),
 		K(ps.nr_slab),
 		K(allowed),
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 14:06:16.691649239 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 14:06:16.783440416 -0700
@@ -47,7 +47,8 @@ struct zone_padding {
 #endif
 
 enum zone_stat_item {
-	NR_MAPPED,	/* mapped into pagetables.
+	NR_ANON,	/* Mapped anonymous pages */
+	NR_MAPPED,	/* pagecache pages mapped into pagetables.
 			   only modified from process context */
 	NR_PAGECACHE,
 	NR_VM_ZONE_STAT_ITEMS };
Index: linux-2.6.17-rc6-cl/mm/rmap.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/rmap.c	2006-06-13 14:06:16.503184375 -0700
+++ linux-2.6.17-rc6-cl/mm/rmap.c	2006-06-13 14:06:16.784416918 -0700
@@ -455,7 +455,7 @@ static void __page_set_anon_rmap(struct 
 	 * nr_mapped state can be updated without turning off
 	 * interrupts because it is not modified via interrupt.
 	 */
-	__inc_zone_page_state(page, NR_MAPPED);
+	__inc_zone_page_state(page, NR_ANON);
 }
 
 /**
@@ -531,7 +531,8 @@ void page_remove_rmap(struct page *page)
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		__dec_zone_page_state(page, NR_MAPPED);
+		__dec_zone_page_state(page,
+				PageAnon(page) ? NR_ANON : NR_MAPPED);
 	}
 }
 
Index: linux-2.6.17-rc6-cl/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmscan.c	2006-06-13 14:06:16.745356843 -0700
+++ linux-2.6.17-rc6-cl/mm/vmscan.c	2006-06-13 14:06:16.785393420 -0700
@@ -747,7 +747,8 @@ static void shrink_active_list(unsigned 
 		 * how much memory
 		 * is mapped.
 		 */
-		mapped_ratio = (global_page_state(NR_MAPPED) * 100) /
+		mapped_ratio = ((global_page_state(NR_MAPPED) +
+				global_page_state(NR_ANON)) * 100) /
 					vm_total_pages;
 
 		/*
Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-13 14:06:16.706296767 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 14:06:16.786369922 -0700
@@ -71,6 +71,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Writeback:    %8lu kB\n"
 		       "Node %d PageCache:    %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
+		       "Node %d Anonymous:    %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
@@ -85,6 +86,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(ps.nr_writeback),
 		       nid, K(node_page_state(nid, NR_PAGECACHE)),
 		       nid, K(node_page_state(nid, NR_MAPPED)),
+		       nid, K(node_page_state(nid, NR_ANON)),
 		       nid, K(ps.nr_slab));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.17-rc6-cl/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page-writeback.c	2006-06-13 14:06:16.502207873 -0700
+++ linux-2.6.17-rc6-cl/mm/page-writeback.c	2006-06-13 14:06:16.787346424 -0700
@@ -111,7 +111,8 @@ static void get_writeback_state(struct w
 {
 	wbs->nr_dirty = read_page_state(nr_dirty);
 	wbs->nr_unstable = read_page_state(nr_unstable);
-	wbs->nr_mapped = global_page_state(NR_MAPPED);
+	wbs->nr_mapped = global_page_state(NR_MAPPED) +
+				global_page_state(NR_ANON);
 	wbs->nr_writeback = read_page_state(nr_writeback);
 }
 
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 14:06:16.707273269 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 14:49:01.936363963 -0700
@@ -457,6 +457,7 @@ struct seq_operations fragmentation_op =
 
 static char *vmstat_text[] = {
 	/* Zoned VM counters */
+	"nr_anon",
 	"nr_mapped",
 	"nr_pagecache",
 
