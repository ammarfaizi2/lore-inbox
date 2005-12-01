Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVLAKNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVLAKNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVLAKNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:13:44 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:11162 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932113AbVLAKNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:13:22 -0500
Message-Id: <20051201102035.606043000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:16 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 06/12] mm: balance active/inactive list scan rates
Content-Disposition: inline; filename=mm-balance-active-inactive-list-aging.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shrink_zone() has two major design goals:
1) let active/inactive lists have equal scan rates
2) do the scans in small chunks

But the implementation has some problems:
- reluctant to scan small zones
  the callers often have to dip into low priority to free memory.

- the balance is quite rough
  the break statement in the loop breaks it.

- may scan few pages in one batch
  refill_inactive_zone can be called twice to scan 32 and 1 pages.

The new design:
1) keep perfect balance
   let active_list follow inactive_list in scan rate

2) always scan in SWAP_CLUSTER_MAX sized chunks
   simple and efficient

3) will scan at least one chunk
   the expected behavior from the callers

The perfect balance may or may not yield better performance, though it
a) is a more understandable and dependable behavior
b) together with inter-zone balancing, makes the zoned memories consistent

The atomic reclaim_in_progress is there to prevent most concurrent reclaims.
If concurrent reclaims did happen, there will be no fatal errors.


I tested the patch with the following commands:
	dd if=/dev/zero of=hot bs=1M seek=800 count=1
	dd if=/dev/zero of=cold bs=1M seek=50000 count=1
	./test-aging.sh; ./active-inactive-aging-rate.sh

Before the patch:
-----------------------------------------------------------------------------
active/inactive sizes on 2.6.14-2-686-smp:
0/1000          = 0 / 1241
563/1000        = 73343 / 130108
887/1000        = 137348 / 154816

active/inactive scan rates:
dma      38/1000        = 7731 / (198924 + 0)
normal   465/1000       = 2979780 / (6394740 + 0)
high     680/1000       = 4354230 / (6396786 + 0)

             total       used       free     shared    buffers     cached
Mem:          2027       1978         49          0          4       1923
-/+ buffers/cache:         49       1977
Swap:            0          0          0
-----------------------------------------------------------------------------

After the patch, the scan rates and the size ratios are kept roughly the same
for all zones:
-----------------------------------------------------------------------------
active/inactive sizes on 2.6.15-rc3-mm1:
0/1000          = 0 / 961
236/1000        = 38385 / 162429
319/1000        = 70607 / 221101

active/inactive scan rates:
dma      0/1000         = 0 / (42176 + 0)
normal   234/1000       = 1714688 / (7303456 + 1088)
high     317/1000       = 3151936 / (9933792 + 96)
             
             total       used       free     shared    buffers     cached
Mem:          2020       1969         50          0          5       1908
-/+ buffers/cache:         54       1965
Swap:            0          0          0
-----------------------------------------------------------------------------

script test-aging.sh:
------------------------------
#!/bin/zsh
cp cold /dev/null&

while {pidof cp > /dev/null};
do
        cp hot /dev/null
done
------------------------------

script active-inactive-aging-rate.sh:
-----------------------------------------------------------------------------
#!/bin/sh

echo active/inactive sizes on `uname -r`:
egrep '(active|inactive)' /proc/zoneinfo |
while true
do
	read name value
	[[ -z $name ]] && break
	eval $name=$value
	[[ $name = "inactive" ]] && echo -e "$((active * 1000 / (1 + inactive)))/1000  \t= $active / $inactive"
done

while true
do
	read name value
	[[ -z $name ]] && break
	eval $name=$value
done < /proc/vmstat

echo
echo active/inactive scan rates:
echo -e "dma \t $((pgrefill_dma * 1000 / (1 + pgscan_kswapd_dma + pgscan_direct_dma)))/1000 \t= $pgrefill_dma / ($pgscan_kswapd_dma + $pgscan_direct_dma)"
echo -e "normal \t $((pgrefill_normal * 1000 / (1 + pgscan_kswapd_normal + pgscan_direct_normal)))/1000 \t= $pgrefill_normal / ($pgscan_kswapd_normal + $pgscan_direct_normal)"
echo -e "high \t $((pgrefill_high * 1000 / (1 + pgscan_kswapd_high + pgscan_direct_high)))/1000 \t= $pgrefill_high / ($pgscan_kswapd_high + $pgscan_direct_high)"

echo
free -m
-----------------------------------------------------------------------------

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mmzone.h |    3 --
 include/linux/swap.h   |    2 -
 mm/page_alloc.c        |    5 +---
 mm/vmscan.c            |   52 +++++++++++++++++++++++++++----------------------
 4 files changed, 33 insertions(+), 29 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -911,7 +911,7 @@ static void shrink_cache(struct zone *zo
 		int nr_scan;
 		int nr_freed;
 
-		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
+		nr_taken = isolate_lru_pages(sc->nr_to_scan,
 					     &zone->inactive_list,
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;
@@ -1105,56 +1105,56 @@ refill_inactive_zone(struct zone *zone, 
 
 /*
  * This is a basic per-zone page freer.  Used by both kswapd and direct reclaim.
+ * The reclaim process:
+ * a) scan always in batch of SWAP_CLUSTER_MAX pages
+ * b) scan inactive list at least one batch
+ * c) balance the scan rate of active/inactive list
+ * d) finish on either scanned or reclaimed enough pages
  */
 static void
 shrink_zone(struct zone *zone, struct scan_control *sc)
 {
+	unsigned long long next_scan_active;
 	unsigned long nr_active;
 	unsigned long nr_inactive;
 
 	atomic_inc(&zone->reclaim_in_progress);
 
+	next_scan_active = sc->nr_scanned;
+
 	/*
 	 * Add one to `nr_to_scan' just to make sure that the kernel will
 	 * slowly sift through the active list.
 	 */
-	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
-	nr_active = zone->nr_scan_active;
-	if (nr_active >= sc->swap_cluster_max)
-		zone->nr_scan_active = 0;
-	else
-		nr_active = 0;
-
-	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
-	nr_inactive = zone->nr_scan_inactive;
-	if (nr_inactive >= sc->swap_cluster_max)
-		zone->nr_scan_inactive = 0;
-	else
-		nr_inactive = 0;
+	nr_active = zone->nr_scan_active + 1;
+	nr_inactive = (zone->nr_inactive >> sc->priority) + SWAP_CLUSTER_MAX;
+	nr_inactive &= ~(SWAP_CLUSTER_MAX - 1);
 
+	sc->nr_to_scan = SWAP_CLUSTER_MAX;
 	sc->nr_to_reclaim = sc->swap_cluster_max;
 
-	while (nr_active || nr_inactive) {
-		if (nr_active) {
-			sc->nr_to_scan = min(nr_active,
-					(unsigned long)sc->swap_cluster_max);
-			nr_active -= sc->nr_to_scan;
+	while (nr_active >= SWAP_CLUSTER_MAX * 1024 || nr_inactive) {
+		if (nr_active >= SWAP_CLUSTER_MAX * 1024) {
+			nr_active -= SWAP_CLUSTER_MAX * 1024;
 			refill_inactive_zone(zone, sc);
 		}
 
 		if (nr_inactive) {
-			sc->nr_to_scan = min(nr_inactive,
-					(unsigned long)sc->swap_cluster_max);
-			nr_inactive -= sc->nr_to_scan;
+			nr_inactive -= SWAP_CLUSTER_MAX;
 			shrink_cache(zone, sc);
 			if (sc->nr_to_reclaim <= 0)
 				break;
 		}
 	}
 
-	throttle_vm_writeout();
+	next_scan_active = (sc->nr_scanned - next_scan_active) * 1024ULL *
+					(unsigned long long)zone->nr_active;
+	do_div(next_scan_active, zone->nr_inactive | 1);
+	zone->nr_scan_active = nr_active + (unsigned long)next_scan_active;
 
 	atomic_dec(&zone->reclaim_in_progress);
+
+	throttle_vm_writeout();
 }
 
 /*
@@ -1195,6 +1195,9 @@ shrink_caches(struct zone **zones, struc
 		if (zone->all_unreclaimable && sc->priority < DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
+		if (atomic_read(&zone->reclaim_in_progress))
+			continue;
+
 		/*
 		 * Balance page aging in local zones and following headless
 		 * zones.
@@ -1415,6 +1418,9 @@ loop_again:
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
+			if (atomic_read(&zone->reclaim_in_progress))
+				continue;
+
 			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -2146,7 +2146,6 @@ static void __init free_area_init_core(s
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
 		zone->nr_scan_active = 0;
-		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
 		zone->aging_total = 0;
@@ -2302,7 +2301,7 @@ static int zoneinfo_show(struct seq_file
 			   "\n        inactive %lu"
 			   "\n        aging    %lu"
 			   "\n        age      %lu"
-			   "\n        scanned  %lu (a: %lu i: %lu)"
+			   "\n        scanned  %lu (a: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
 			   zone->free_pages,
@@ -2314,7 +2313,7 @@ static int zoneinfo_show(struct seq_file
 			   zone->aging_total,
 			   zone->page_age,
 			   zone->pages_scanned,
-			   zone->nr_scan_active, zone->nr_scan_inactive,
+			   zone->nr_scan_active / 1024,
 			   zone->spanned_pages,
 			   zone->present_pages);
 		seq_printf(m,
--- linux.orig/include/linux/swap.h
+++ linux/include/linux/swap.h
@@ -111,7 +111,7 @@ enum {
 	SWP_SCANNING	= (1 << 8),	/* refcount in scan_swap_map */
 };
 
-#define SWAP_CLUSTER_MAX 32
+#define SWAP_CLUSTER_MAX 32		/* must be power of 2 */
 
 #define SWAP_MAP_MAX	0x7fff
 #define SWAP_MAP_BAD	0x8000
--- linux.orig/include/linux/mmzone.h
+++ linux/include/linux/mmzone.h
@@ -142,8 +142,7 @@ struct zone {
 	spinlock_t		lru_lock;	
 	struct list_head	active_list;
 	struct list_head	inactive_list;
-	unsigned long		nr_scan_active;
-	unsigned long		nr_scan_inactive;
+	unsigned long		nr_scan_active;	/* x1024 to be more precise */
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
 	unsigned long		pages_scanned;	   /* since last reclaim */

--
