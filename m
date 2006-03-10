Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752189AbWCJJye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbWCJJye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 04:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbWCJJye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 04:54:34 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:24039 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752189AbWCJJyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 04:54:33 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Implement swap prefetching tweaks
Date: Fri, 10 Mar 2006 20:54:19 +1100
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603102054.20077.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current swap prefetching implementation is far too aggressive to the point
of its cpu and disk access being noticed. This patch addresses that issue.

Andrew please apply this one and keep ignoring the yield patch the way you
rightly already were.

Cheers,
Con
---
Swap prefetch tweaks.

Add watermarks to swap prefetching, and prefetch when free memory is greater
than pages_high * 4 down to pages_high * 3.

Check cpu load and only prefetch when kprefetchd is the only process running.
Testing cpu load of just the cpu that kprefetchd is currently running on is
not enough to ensure that kprefetchd working does not consume resources in a
noticeable way on SMP.

Clear the busy bit only if it is set.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 mm/swap_prefetch.c |  154 ++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 118 insertions(+), 36 deletions(-)

Index: linux-2.6.16-rc5-mm3/mm/swap_prefetch.c
===================================================================
--- linux-2.6.16-rc5-mm3.orig/mm/swap_prefetch.c	2006-03-10 15:29:11.000000000 +1100
+++ linux-2.6.16-rc5-mm3/mm/swap_prefetch.c	2006-03-10 20:36:56.000000000 +1100
@@ -150,21 +150,31 @@ enum trickle_return {
 	TRICKLE_DELAY,
 };
 
+struct node_stats {
+	unsigned long	last_free;
+	/* Free ram after a cycle of prefetching */
+	unsigned long	current_free;
+	/* Free ram on this cycle of checking prefetch_suitable */
+	unsigned long	prefetch_watermark;
+	/* Maximum amount we will prefetch to */
+	unsigned long	highfree[MAX_NR_ZONES];
+	/* The amount of free ram before we start prefetching */
+	unsigned long	lowfree[MAX_NR_ZONES];
+	/* The amount of free ram where we will stop prefetching */
+	unsigned long	*pointfree[MAX_NR_ZONES];
+	/* highfree or lowfree depending on whether we've hit a watermark */
+};
+
 /*
  * prefetch_stats stores the free ram data of each node and this is used to
  * determine if a node is suitable for prefetching into.
  */
-struct prefetch_stats{
-	unsigned long	last_free[MAX_NUMNODES];
-	/* Free ram after a cycle of prefetching */
-	unsigned long	current_free[MAX_NUMNODES];
-	/* Free ram on this cycle of checking prefetch_suitable */
-	unsigned long	prefetch_watermark[MAX_NUMNODES];
-	/* Maximum amount we will prefetch to */
+struct prefetch_stats {
 	nodemask_t	prefetch_nodes;
 	/* Which nodes are currently suited to prefetching */
 	unsigned long	prefetched_pages;
 	/* Total pages we've prefetched on this wakeup of kprefetchd */
+	struct node_stats node[MAX_NUMNODES];
 };
 
 static struct prefetch_stats sp_stat;
@@ -211,7 +221,7 @@ static enum trickle_return trickle_swap_
 	}
 
 	sp_stat.prefetched_pages++;
-	sp_stat.last_free[node]--;
+	sp_stat.node[node].last_free--;
 
 	ret = TRICKLE_SUCCESS;
 out_release:
@@ -229,8 +239,11 @@ static void clear_last_prefetch_free(voi
 	 * update the data to take into account memory hotplug if desired..
 	 */
 	sp_stat.prefetch_nodes = node_online_map;
-	for_each_node_mask(node, sp_stat.prefetch_nodes)
-		sp_stat.last_free[node] = 0;
+	for_each_node_mask(node, sp_stat.prefetch_nodes) {
+		struct node_stats *ns = &sp_stat.node[node];
+
+		ns->last_free = 0;
+	}
 }
 
 static void clear_current_prefetch_free(void)
@@ -238,8 +251,43 @@ static void clear_current_prefetch_free(
 	int node;
 
 	sp_stat.prefetch_nodes = node_online_map;
-	for_each_node_mask(node, sp_stat.prefetch_nodes)
-		sp_stat.current_free[node] = 0;
+	for_each_node_mask(node, sp_stat.prefetch_nodes) {
+		struct node_stats *ns = &sp_stat.node[node];
+
+		ns->current_free = 0;
+	}
+}
+
+/*
+ * This updates the high and low watermarks of amount of free ram in each
+ * node used to start and stop prefetching. We prefetch from pages_high * 4
+ * down to pages_high * 3.
+ */
+static void examine_free_limits(void)
+{
+	struct zone *z;
+
+	for_each_zone(z) {
+		struct node_stats *ns;
+		int idx;
+
+		if (!populated_zone(z))
+			continue;
+
+		ns = &sp_stat.node[z->zone_pgdat->node_id];
+		idx = zone_idx(z);
+		ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[idx];
+		ns->highfree[idx] = ns->lowfree[idx] + z->pages_high;
+
+		if (z->free_pages > ns->highfree[idx]) {
+			/*
+			 * We've gotten above the high watermark of free pages
+			 * so we can start prefetching till we get to the low
+			 * watermark.
+			 */
+			ns->pointfree[idx] = &ns->lowfree[idx];
+		}
+	}
 }
 
 /*
@@ -247,14 +295,34 @@ static void clear_current_prefetch_free(
  */
 static int prefetch_suitable(void)
 {
-	struct page_state ps;
 	unsigned long limit;
 	struct zone *z;
-	int node, ret = 0;
+	int node, ret = 0, test_pagestate = 0;
 
-	/* Purposefully racy and might return false positive which is ok */
-	if (__test_and_clear_bit(0, &swapped.busy))
+	/* Purposefully racy */
+	if (test_bit(0, &swapped.busy)) {
+		__clear_bit(0, &swapped.busy);
 		goto out;
+	}
+
+	/*
+	 * get_page_state is super expensive so we only perform it every
+	 * SWAP_CLUSTER_MAX prefetched_pages. We also test if we're the only
+	 * task running anywhere. We want to have as little impact on all
+	 * resources (cpu, disk, bus etc). As this iterates over every cpu
+	 * we measure this infrequently.
+	 */
+	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
+		unsigned long cpuload = nr_running();
+
+		if (cpuload > 1)
+			goto out;
+		cpuload += nr_uninterruptible();
+		if (cpuload > 1)
+			goto out;
+
+		test_pagestate = 1;
+	}
 
 	clear_current_prefetch_free();
 
@@ -263,18 +331,29 @@ static int prefetch_suitable(void)
 	 * will occur to prevent ping-ponging between them.
 	 */
 	for_each_zone(z) {
+		struct node_stats *ns;
 		unsigned long free;
+		int idx;
 
 		if (!populated_zone(z))
 			continue;
+
 		node = z->zone_pgdat->node_id;
+		ns = &sp_stat.node[node];
+		idx = zone_idx(z);
 
 		free = z->free_pages;
-		if (z->pages_high * 3 + z->lowmem_reserve[zone_idx(z)] > free) {
+		if (free < *ns->pointfree[idx]) {
+			/*
+			 * Free pages have dropped below the low watermark so
+			 * we won't start prefetching again till we hit the
+			 * high watermark of free pages.
+			 */
+			ns->pointfree[idx] = &ns->highfree[idx];
 			node_clear(node, sp_stat.prefetch_nodes);
 			continue;
 		}
-		sp_stat.current_free[node] += free;
+		ns->current_free += free;
 	}
 
 	/*
@@ -282,28 +361,26 @@ static int prefetch_suitable(void)
 	 * prefetching and clear the nodemask if it is not.
 	 */
 	for_each_node_mask(node, sp_stat.prefetch_nodes) {
+		struct node_stats *ns = &sp_stat.node[node];
+		struct page_state ps;
+
 		/*
 		 * We check to see that pages are not being allocated
 		 * elsewhere at any significant rate implying any
 		 * degree of memory pressure (eg during file reads)
 		 */
-		if (sp_stat.last_free[node]) {
-			if (sp_stat.current_free[node] + SWAP_CLUSTER_MAX <
-				sp_stat.last_free[node]) {
-					sp_stat.last_free[node] =
-						sp_stat.current_free[node];
+		if (ns->last_free) {
+			if (ns->current_free + SWAP_CLUSTER_MAX <
+				ns->last_free) {
+					ns->last_free = ns->current_free;
 					node_clear(node,
 						sp_stat.prefetch_nodes);
 					continue;
 			}
 		} else
-			sp_stat.last_free[node] = sp_stat.current_free[node];
+			ns->last_free = ns->current_free;
 
-		/*
-		 * get_page_state is super expensive so we only perform it
-		 * every SWAP_CLUSTER_MAX prefetched_pages
-		 */
-		if (sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)
+		if (!test_pagestate)
 			continue;
 
 		get_page_state_node(&ps, node);
@@ -324,7 +401,7 @@ static int prefetch_suitable(void)
 		 */
 		limit = ps.nr_mapped + ps.nr_slab + ps.nr_dirty +
 			ps.nr_unstable + total_swapcache_pages;
-		if (limit > sp_stat.prefetch_watermark[node]) {
+		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
 			continue;
 		}
@@ -370,6 +447,7 @@ static enum trickle_return trickle_swap(
 	if (!swap_prefetch || laptop_mode)
 		return ret;
 
+	examine_free_limits();
 	entry = NULL;
 
 	for ( ; ; ) {
@@ -459,8 +537,7 @@ static int kprefetchd(void *__unused)
  */
 void __init prepare_swap_prefetch(void)
 {
-	pg_data_t *pgdat;
-	int node;
+	struct zone *zone;
 
 	swapped.cache = kmem_cache_create("swapped_entry",
 		sizeof(struct swapped_entry), 0, SLAB_PANIC, NULL, NULL);
@@ -471,14 +548,19 @@ void __init prepare_swap_prefetch(void)
 	 */
 	swapped.maxcount = nr_free_pagecache_pages() / 3 * 2;
 
-	for_each_online_pgdat(pgdat) {
+	for_each_zone(zone) {
 		unsigned long present;
+		struct node_stats *ns;
+		int idx;
 
-		present = pgdat->node_present_pages;
+		present = zone->present_pages;
 		if (!present)
 			continue;
-		node = pgdat->node_id;
-		sp_stat.prefetch_watermark[node] += present / 3 * 2;
+
+		ns = &sp_stat.node[zone->zone_pgdat->node_id];
+		ns->prefetch_watermark += present / 3 * 2;
+		idx = zone_idx(zone);
+		ns->pointfree[idx] = &ns->highfree[idx];
 	}
 }
 
