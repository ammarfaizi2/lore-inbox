Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWCTNiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWCTNiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWCTNiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:38:12 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:17705 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964789AbWCTNhr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:37:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tiIF0YUBl7P3SN0bSb1Mhdp+adUZxgm9pYgGVuWschak15iNd6w7rAXMLfbKdAUJNlCaCFjWuYxI+Rglesp+IFCujDw9yde2DLIcgrKsgt6NNoePoS95y48LlVcfQedr/VUkbq4b4WQt515t85AmdUljhENPXGY2yHi1QJga6NM=
Message-ID: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:37:46 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo: Wired"
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export mlock(wired) info through file /proc/meminfo.

Signed-off-by: Shaoping Wang <pwstone@gmail.com>

--
 fs/proc/proc_misc.c    |    5 ++++-
 include/linux/mm.h     |    4 ++++
 include/linux/mmzone.h |    4 ++--
 mm/page_alloc.c        |   26 +++++++++++++++++++-------
 mm/readahead.c         |    3 ++-
 5 files changed, 31 insertions(+), 11 deletions(-)

diff -urN linux-2.6.15.orig/fs/proc/proc_misc.c linux-2.6.15/fs/proc/proc_misc.c
--- linux-2.6.15.orig/fs/proc/proc_misc.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/proc/proc_misc.c	2006-03-06 06:44:50.000000000 -0500
@@ -123,6 +123,7 @@
 	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
+	unsigned long wired;
 	unsigned long free;
 	unsigned long committed;
 	unsigned long allowed;
@@ -130,7 +131,7 @@
 	long cached;

 	get_page_state(&ps);
-	get_zone_counts(&active, &inactive, &free);
+	get_zone_counts(&active, &inactive, &wired, &free);

 /*
  * display in kilobytes.
@@ -159,6 +160,7 @@
 		"SwapCached:   %8lu kB\n"
 		"Active:       %8lu kB\n"
 		"Inactive:     %8lu kB\n"
+		"Wired:        %8lu kB\n"
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
@@ -182,6 +184,7 @@
 		K(total_swapcache_pages),
 		K(active),
 		K(inactive),
+		K(wired),
 		K(i.totalhigh),
 		K(i.freehigh),
 		K(i.totalram-i.totalhigh),
diff -urN linux-2.6.15.orig/include/linux/mmzone.h
linux-2.6.15/include/linux/mmzone.h
--- linux-2.6.15.orig/include/linux/mmzone.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/mmzone.h	2006-03-07 01:58:26.000000000 -0500
@@ -315,9 +317,9 @@
 extern struct pglist_data *pgdat_list;

 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat);
+		unsigned long *wired, unsigned long *free, struct pglist_data *pgdat);
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free);
+		unsigned long *wired, unsigned long *free);
 void build_all_zonelists(void);
 void wakeup_kswapd(struct zone *zone, int order);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
diff -urN linux-2.6.15.orig/mm/page_alloc.c linux-2.6.15/mm/page_alloc.c
--- linux-2.6.15.orig/mm/page_alloc.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/page_alloc.c	2006-03-06 06:30:08.000000000 -0500
@@ -1252,35 +1254,39 @@
 EXPORT_SYMBOL(__mod_page_state);

 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat)
+			unsigned long *wired,unsigned long *free, struct pglist_data *pgdat)
 {
 	struct zone *zones = pgdat->node_zones;
 	int i;

 	*active = 0;
 	*inactive = 0;
+	*wired = 0;
 	*free = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		*active += zones[i].nr_active;
 		*inactive += zones[i].nr_inactive;
+		*wired += zones[i].nr_wired;
 		*free += zones[i].free_pages;
 	}
 }

 void get_zone_counts(unsigned long *active,
-		unsigned long *inactive, unsigned long *free)
+		unsigned long *inactive, unsigned long *wired, unsigned long *free)
 {
 	struct pglist_data *pgdat;

 	*active = 0;
 	*inactive = 0;
+	*wired = 0;
 	*free = 0;
 	for_each_pgdat(pgdat) {
-		unsigned long l, m, n;
-		__get_zone_counts(&l, &m, &n, pgdat);
+		unsigned long l, m, n, o;
+		__get_zone_counts(&l, &m, &n, &o, pgdat);
 		*active += l;
 		*inactive += m;
-		*free += n;
+		*wired += n;
+		*free += o;
 	}
 }

@@ -1328,6 +1334,7 @@
 	int cpu, temperature;
 	unsigned long active;
 	unsigned long inactive;
+	unsigned long wired;
 	unsigned long free;
 	struct zone *zone;

@@ -1358,16 +1365,17 @@
 	}

 	get_page_state(&ps);
-	get_zone_counts(&active, &inactive, &free);
+	get_zone_counts(&active, &inactive, &wired, &free);

 	printk("Free pages: %11ukB (%ukB HighMem)\n",
 		K(nr_free_pages()),
 		K(nr_free_highpages()));

-	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
+	printk("Active:%lu inactive:%lu wired:%lu dirty:%lu writeback:%lu "
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
+		wired,
 		ps.nr_dirty,
 		ps.nr_writeback,
 		ps.nr_unstable,
@@ -1387,6 +1395,7 @@
 			" high:%lukB"
 			" active:%lukB"
 			" inactive:%lukB"
+			" wired:%lukB"
 			" present:%lukB"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
@@ -1398,6 +1407,7 @@
 			K(zone->pages_high),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
+			K(zone->nr_wired),
 			K(zone->present_pages),
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
@@ -2009,10 +2019,12 @@
 		zone_pcp_init(zone);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
+		INIT_LIST_HEAD(&zone->wired_list);
 		zone->nr_scan_active = 0;
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->nr_wired = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2161,6 +2173,7 @@
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        wired    %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2170,6 +2183,7 @@
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->nr_wired,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
diff -urN linux-2.6.15.orig/include/linux/mm.h linux-2.6.15/include/linux/mm.h
--- linux-2.6.15.orig/include/linux/mm.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/mm.h	2006-03-07 01:49:12.000000000 -0500
@@ -218,6 +221,10 @@
 	unsigned long flags;		/* Atomic flags, some possibly
 					 * updated asynchronously */
 	atomic_t _count;		/* Usage count, see below. */
+	unsigned short wired_count; /* Count of wirings of the page.
+					 * If not zero,the page would be SetPageWired,
+					 * and put on Wired list of the zone.
+					 */
 	atomic_t _mapcount;		/* Count of ptes mapped in mms,
 					 * to show when page is mapped
 					 * & limit reverse map searches.
diff -urN linux-2.6.15.orig/mm/readahead.c linux-2.6.15/mm/readahead.c
--- linux-2.6.15.orig/mm/readahead.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/readahead.c	2006-03-06 06:30:08.000000000 -0500
@@ -564,8 +564,9 @@
 {
 	unsigned long active;
 	unsigned long inactive;
+	unsigned long wired;
 	unsigned long free;

-	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
+	__get_zone_counts(&active, &inactive, &wired, &free,
NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
