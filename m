Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWFLVNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWFLVNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbWFLVNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:13:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48047 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751873AbWFLVN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:13:27 -0400
Date: Mon, 12 Jun 2006 14:13:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211321.20862.85253.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
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
NR_MAPPED works like NR_DIRTY.  It is only valid for pagecache pages.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-12 13:00:50.578578181 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-12 13:01:30.621020255 -0700
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
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-12 13:00:50.585413695 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-12 13:01:30.622973259 -0700
@@ -47,7 +47,8 @@ struct zone_padding {
 #endif
 
 enum zone_stat_item {
-	NR_MAPPED,	/* mapped into pagetables.
+	NR_ANON,	/* Mapped anonymous pages */
+	NR_MAPPED,	/* pagecache pages mapped into pagetables.
 			   only modified from process context */
 	NR_PAGECACHE,
 	NR_STAT_ITEMS };
Index: linux-2.6.17-rc6-cl/mm/rmap.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/rmap.c	2006-06-12 12:57:23.386331148 -0700
+++ linux-2.6.17-rc6-cl/mm/rmap.c	2006-06-12 13:01:30.623949761 -0700
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
--- linux-2.6.17-rc6-cl.orig/mm/vmscan.c	2006-06-12 13:01:27.580192947 -0700
+++ linux-2.6.17-rc6-cl/mm/vmscan.c	2006-06-12 13:01:30.624926263 -0700
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
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-12 13:00:50.587366699 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-12 13:01:30.625902765 -0700
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
--- linux-2.6.17-rc6-cl.orig/mm/page-writeback.c	2006-06-12 12:57:23.386331148 -0700
+++ linux-2.6.17-rc6-cl/mm/page-writeback.c	2006-06-12 13:01:30.625902765 -0700
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
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-12 13:01:24.304028650 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-12 13:02:08.289585892 -0700
@@ -465,6 +465,7 @@ static char *vmstat_text[] = {
 	/* Zoned VM counters */
 	"nr_mapped",
 	"nr_pagecache",
+	"nr_anon",
 
 	/* Page state */
 	"nr_dirty",
