Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTLUAhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 19:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTLUAhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 19:37:13 -0500
Received: from imladris.surriel.com ([66.92.77.98]:27352 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261893AbTLUAhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 19:37:04 -0500
Date: Sat, 20 Dec 2003 19:37:18 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, ak@suse.de, mbligh@us.ibm.com
Subject: [PATCH] make try_to_free_pages walk zonelist
Message-ID: <Pine.LNX.4.55L.0312201928530.31547@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.6.0 both __alloc_pages() and the corresponding
wakeup_kswapd()s walk all zones in the zone list,
possibly spanning multiple nodes in a low numa factor
system like AMD64.

Also, if lower_zone_protection is set in /proc, then
it may be possible that kswapd never cleans out data
in zones further down the zonelist and try_to_free_pages
needs to do that.

However, in 2.6.0 try_to_free_pages() only frees pages
in the pgdat the first zone in the zonelist belongs to.

This is probably the wrong behaviour, since both the
page allocator and the kswapd wakeup free things from
all zones on the zonelist.  The following patch makes
try_to_free_pages() consistent with the allocator, by
passing the zonelist as an argument and freeing pages
from all zones in the list.

I do not have any numa systems myself, so I have only
tested it on my own little smp box.  Testing on NUMA
systems may be useful, though the patch really only
should have an impact in those rare cases where kswapd
can't keep up with allocations...

As a side effect, the patch shrinks the kernel by 2 lines
and replaces some subtle magic by a simpler array walk.

cheers,

Rik


===== include/linux/swap.h 1.79 vs edited =====
--- 1.79/include/linux/swap.h	Tue Oct  7 16:40:52 2003
+++ edited/include/linux/swap.h	Sat Dec 20 17:48:10 2003
@@ -173,7 +173,7 @@
 extern void swap_setup(void);

 /* linux/mm/vmscan.c */
-extern int try_to_free_pages(struct zone *, unsigned int, unsigned int);
+extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;

===== mm/page_alloc.c 1.174 vs edited =====
--- 1.174/mm/page_alloc.c	Tue Oct  7 22:53:44 2003
+++ edited/mm/page_alloc.c	Sat Dec 20 17:41:18 2003
@@ -537,7 +537,7 @@
 {
 	const int wait = gfp_mask & __GFP_WAIT;
 	unsigned long min;
-	struct zone **zones, *classzone;
+	struct zone **zones;
 	struct page *page;
 	struct reclaim_state reclaim_state;
 	struct task_struct *p = current;
@@ -552,8 +552,7 @@
 		cold = 1;

 	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
-	classzone = zones[0];
-	if (classzone == NULL)    /* no zones in the zonelist */
+	if (zones[0] == NULL)    /* no zones in the zonelist */
 		return NULL;

 	/* Go through the zonelist once, looking for a zone with enough free */
@@ -628,7 +627,7 @@
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;

-	try_to_free_pages(classzone, gfp_mask, order);
+	try_to_free_pages(zones, gfp_mask, order);

 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
===== mm/vmscan.c 1.173 vs edited =====
--- 1.173/mm/vmscan.c	Tue Oct  7 22:53:44 2003
+++ edited/mm/vmscan.c	Sat Dec 20 18:02:20 2003
@@ -803,16 +803,15 @@
  * scan then give up on it.
  */
 static int
-shrink_caches(struct zone *classzone, int priority, int *total_scanned,
+shrink_caches(struct zone **zones, int priority, int *total_scanned,
 		int gfp_mask, int nr_pages, struct page_state *ps)
 {
-	struct zone *first_classzone;
-	struct zone *zone;
 	int ret = 0;
+	int i;

-	first_classzone = classzone->zone_pgdat->node_zones;
-	for (zone = classzone; zone >= first_classzone; zone--) {
+	for (i = 0; zones[i] != NULL; i++) {
 		int to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX);
+		struct zone *zone = zones[i];
 		int nr_mapped = 0;
 		int max_scan;

@@ -855,27 +854,27 @@
  * excessive rotation of the inactive list, which is _supposed_ to be an LRU,
  * yes?
  */
-int try_to_free_pages(struct zone *cz,
+int try_to_free_pages(struct zone **zones,
 		unsigned int gfp_mask, unsigned int order)
 {
 	int priority;
 	int ret = 0;
 	const int nr_pages = SWAP_CLUSTER_MAX;
 	int nr_reclaimed = 0;
-	struct zone *zone;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
+	int i;

 	inc_page_state(allocstall);

-	for (zone = cz; zone >= cz->zone_pgdat->node_zones; --zone)
-		zone->temp_priority = DEF_PRIORITY;
+	for (i = 0; zones[i] != 0; i++)
+		zones[i]->temp_priority = DEF_PRIORITY;

 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int total_scanned = 0;
 		struct page_state ps;

 		get_page_state(&ps);
-		nr_reclaimed += shrink_caches(cz, priority, &total_scanned,
+		nr_reclaimed += shrink_caches(zones, priority, &total_scanned,
 						gfp_mask, nr_pages, &ps);
 		if (nr_reclaimed >= nr_pages) {
 			ret = 1;
@@ -892,7 +891,7 @@

 		/* Take a nap, wait for some writeback to complete */
 		blk_congestion_wait(WRITE, HZ/10);
-		if (cz - cz->zone_pgdat->node_zones < ZONE_HIGHMEM) {
+		if (zones[0] - zones[0]->zone_pgdat->node_zones < ZONE_HIGHMEM) {
 			shrink_slab(total_scanned, gfp_mask);
 			if (reclaim_state) {
 				nr_reclaimed += reclaim_state->reclaimed_slab;
@@ -903,8 +902,8 @@
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
 		out_of_memory();
 out:
-	for (zone = cz; zone >= cz->zone_pgdat->node_zones; --zone)
-		zone->prev_priority = zone->temp_priority;
+	for (i = 0; zones[i] != 0; i++)
+		zones[i]->prev_priority = zones[i]->temp_priority;
 	return ret;
 }

