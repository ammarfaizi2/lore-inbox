Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbVLOAcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbVLOAcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVLOAci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:32:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45202 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932661AbVLOAc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:32:28 -0500
Date: Wed, 14 Dec 2005 16:32:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215003227.31788.82881.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 07/14] Expanded node and zone statistics
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend zone, node and global statistics by printing all counters from the stats
array.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/drivers/base/node.c	2005-12-14 14:57:29.000000000 -0800
+++ linux-2.6.15-rc5-mm2/drivers/base/node.c	2005-12-14 15:28:34.000000000 -0800
@@ -43,12 +43,14 @@ static ssize_t node_read_meminfo(struct 
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
@@ -71,6 +73,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
+		       "Node %d Pagecache:    %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
@@ -83,7 +86,8 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(ps.nr_dirty),
 		       nid, K(ps.nr_writeback),
-		       nid, K(nr_mapped),
+		       nid, K(nr[NR_MAPPED]),
+		       nid, K(nr[NR_PAGECACHE]),
 		       nid, K(ps.nr_slab));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 15:27:43.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 15:28:34.000000000 -0800
@@ -596,6 +596,8 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
+char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache" };
+
 /*
  * Manage combined zone based / global counters
  */
@@ -2602,6 +2604,11 @@ static int zoneinfo_show(struct seq_file
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
 			   zone->present_pages);
+		for(i = 0; i < NR_STAT_ITEMS; i++)
+			seq_printf(m, "\n        %-8s %lu",
+					stat_item_descr[i],
+					zone_page_state(zone, i));
+
 		seq_printf(m,
 			   "\n        protection: (%lu",
 			   zone->lowmem_reserve[0]);
