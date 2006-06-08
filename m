Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWFHXH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWFHXH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWFHXH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:07:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50401 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965058AbWFHXDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:19 -0400
Date: Thu, 8 Jun 2006 16:03:10 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230310.25121.77780.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 06/14] Add per zone counters to zone node and global VM statistics
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend per node and per zone statistics by printing the additional counters now available.

- Add new counters to per node statistics

- Add new counters to per zone statistics

- Provide an array describing zoned VM counters

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-08 14:29:45.931956736 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-08 14:57:17.733967150 -0700
@@ -44,12 +44,14 @@ static ssize_t node_read_meminfo(struct 
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
-	unsigned long nr_mapped;
+	int j;
+	unsigned long nr[NR_STAT_ITEMS];
 
 	si_meminfo_node(&i, nid);
 	get_page_state_node(&ps, nid);
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
-	nr_mapped = node_page_state(nid, NR_MAPPED);
+	for (j = 0; j < NR_STAT_ITEMS; j++)
+		nr[j] = node_page_state(nid, j);
 
 	/* Check for negative values in these approximate counters */
 	if ((long)ps.nr_dirty < 0)
@@ -72,6 +74,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
+		       "Node %d Pagecache:    %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
@@ -84,7 +87,8 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(ps.nr_dirty),
 		       nid, K(ps.nr_writeback),
-		       nid, K(nr_mapped),
+		       nid, K(nr[NR_MAPPED]),
+		       nid, K(nr[NR_PAGECACHE]),
 		       nid, K(ps.nr_slab));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 14:29:46.317675014 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 14:57:05.712250246 -0700
@@ -628,6 +628,8 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
+char *vm_stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache" };
+
 /*
  * Manage combined zone based / global counters
  *
@@ -2724,6 +2726,11 @@ static int zoneinfo_show(struct seq_file
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
 			   zone->present_pages);
+		for(i = 0; i < NR_STAT_ITEMS; i++)
+			seq_printf(m, "\n        %-8s %lu",
+					vm_stat_item_descr[i],
+					zone_page_state(zone, i));
+
 		seq_printf(m,
 			   "\n        protection: (%lu",
 			   zone->lowmem_reserve[0]);
