Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWGCV5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWGCV5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWGCV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:56:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27040 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932114AbWGCVz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:55:58 -0400
Date: Mon, 3 Jul 2006 14:55:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060703215545.7566.79158.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 2/8] Make display of highmem counters conditional on CONFIG_HIGHMEM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change HIGHMEM dependent texts and make display of highmem counters optional

Some texts are depending on CONFIG_HIGHMEM.

Remove those strings and remove the display of zero highmem values if
CONFIG_HIGHMEM is not set.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/drivers/base/node.c
===================================================================
--- linux-2.6.17-mm6.orig/drivers/base/node.c	2006-07-03 13:47:14.847034002 -0700
+++ linux-2.6.17-mm6/drivers/base/node.c	2006-07-03 14:00:54.064935322 -0700
@@ -54,10 +54,12 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d MemUsed:      %8lu kB\n"
 		       "Node %d Active:       %8lu kB\n"
 		       "Node %d Inactive:     %8lu kB\n"
+#ifdef CONFIG_HIGHMEM
 		       "Node %d HighTotal:    %8lu kB\n"
 		       "Node %d HighFree:     %8lu kB\n"
 		       "Node %d LowTotal:     %8lu kB\n"
 		       "Node %d LowFree:      %8lu kB\n"
+#endif
 		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
 		       "Node %d FilePages:    %8lu kB\n"
@@ -72,10 +74,12 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.totalram - i.freeram),
 		       nid, K(active),
 		       nid, K(inactive),
+#ifdef CONFIG_HIGHMEM
 		       nid, K(i.totalhigh),
 		       nid, K(i.freehigh),
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
+#endif
 		       nid, K(node_page_state(nid, NR_FILE_DIRTY)),
 		       nid, K(node_page_state(nid, NR_WRITEBACK)),
 		       nid, K(node_page_state(nid, NR_FILE_PAGES)),
Index: linux-2.6.17-mm6/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-mm6.orig/fs/proc/proc_misc.c	2006-07-03 13:47:19.547915149 -0700
+++ linux-2.6.17-mm6/fs/proc/proc_misc.c	2006-07-03 14:01:28.790330184 -0700
@@ -157,10 +157,12 @@ static int meminfo_read_proc(char *page,
 		"SwapCached:   %8lu kB\n"
 		"Active:       %8lu kB\n"
 		"Inactive:     %8lu kB\n"
+#ifdef CONFIG_HIGHMEM
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
 		"LowFree:      %8lu kB\n"
+#endif
 		"SwapTotal:    %8lu kB\n"
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
@@ -183,10 +185,12 @@ static int meminfo_read_proc(char *page,
 		K(total_swapcache_pages),
 		K(active),
 		K(inactive),
+#ifdef CONFIG_HIGHMEM
 		K(i.totalhigh),
 		K(i.freehigh),
 		K(i.totalram-i.totalhigh),
 		K(i.freeram-i.freehigh),
+#endif
 		K(i.totalswap),
 		K(i.freeswap),
 		K(global_page_state(NR_FILE_DIRTY)),
Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-03 13:58:32.611757801 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-03 14:03:19.964129358 -0700
@@ -1394,9 +1394,13 @@ void show_free_areas(void)
 
 	get_zone_counts(&active, &inactive, &free);
 
+#ifdef CONFIG_HIGHMEM
 	printk("Free pages: %11ukB (%ukB HighMem)\n",
 		K(nr_free_pages()),
 		K(nr_free_highpages()));
+#else
+	printk("Free pages: %11ukB\n", K(nr_free_pages()));
+#endif
 
 	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
