Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966439AbWKOHyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966439AbWKOHyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966457AbWKOHu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:50:59 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:10446 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966439AbWKOHul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:41 -0500
Message-ID: <363577024.21908@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075028.178039166@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:19 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 12/28] readahead: state based method - aging accounting
Content-Disposition: inline; filename=readahead-state-based-method-aging-accounting.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Collect info about the global available memory and its consumption speed.
The data are used by the stateful method to estimate the thrashing threshold.

They are the decisive factor of the correctness/accuracy of the resulting
read-ahead size.

The accountings are done on a per-node basis. On NUMA systems, it works for
the two common real-world schemes:
	- the reader process allocates caches in a node affined manner;
	- the reader process allocates caches _balancely_ from a set of nodes.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
DESC
Apply type enum zone_type (readahead)
EDESC
From: Christoph Lameter <clameter@sgi.com>

After we have done this we can now do some typing cleanup.

The memory policy layer keeps a policy_zone that specifies
the zone that gets memory policies applied. This variable
can now be of type enum zone_type.

The check_highest_zone function and the build_zonelists funnctionm must
then also take a enum zone_type parameter.

Plus there are a number of loops over zones that also should use
zone_type.

We run into some troubles at some points with functions that need a
zone_type variable to become -1. Fix that up.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/include/linux/mmzone.h
+++ linux-2.6.19-rc5-mm2/include/linux/mmzone.h
@@ -218,6 +218,7 @@ struct zone {
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
 	unsigned long		pages_scanned;	   /* since last reclaim */
+	unsigned long		total_scanned;	   /* accumulated, may overflow */
 	int			all_unreclaimable; /* All pages pinned */
 
 	/* A count of how many reclaimers are scanning this zone */
@@ -464,6 +465,8 @@ void __get_zone_counts(unsigned long *ac
 			unsigned long *free, struct pglist_data *pgdat);
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free);
+unsigned long nr_free_inactive_pages_node(int nid);
+unsigned long nr_scanned_pages_node(int nid);
 void build_all_zonelists(void);
 void wakeup_kswapd(struct zone *zone, int order);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
--- linux-2.6.19-rc5-mm2.orig/mm/page_alloc.c
+++ linux-2.6.19-rc5-mm2/mm/page_alloc.c
@@ -1489,6 +1489,37 @@ unsigned int nr_free_pagecache_pages(voi
 	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER));
 }
 
+/*
+ * Amount of free+inactive RAM in a node.
+ */
+unsigned long nr_free_inactive_pages_node(int nid)
+{
+	enum zone_type i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(nid)->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_inactive +
+			zones[i].free_pages - zones[i].pages_low;
+
+	return sum;
+}
+
+/*
+ * Accumulated scanned pages in a node.
+ */
+unsigned long nr_scanned_pages_node(int nid)
+{
+       enum zone_type i;
+       unsigned long sum = 0;
+       struct zone *zones = NODE_DATA(nid)->node_zones;
+
+       for (i = 0; i < MAX_NR_ZONES; i++)
+	       sum += zones[i].total_scanned;
+
+       return sum;
+}
+
 static inline void show_node(struct zone *zone)
 {
 	if (NUMA_BUILD)
--- linux-2.6.19-rc5-mm2.orig/mm/vmscan.c
+++ linux-2.6.19-rc5-mm2/mm/vmscan.c
@@ -683,6 +683,7 @@ static unsigned long shrink_inactive_lis
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
+		zone->total_scanned += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
 		nr_scanned += nr_scan;

--
