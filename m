Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbUJYMpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUJYMpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUJYMpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:45:00 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:11445 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261786AbUJYMno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:43:44 -0400
Date: Mon, 25 Oct 2004 14:44:43 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041025124443.GV14325@dualathlon.random>
References: <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au> <20041022165809.GH14325@dualathlon.random> <4179DF23.4030402@yahoo.com.au> <20041023095955.GR14325@dualathlon.random> <417A30EE.1030205@yahoo.com.au> <20041023110334.GS14325@dualathlon.random> <417A86AC.2080505@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417A86AC.2080505@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The more I read the old protection setting the more it seems broken. It
even looks it would buffer overflow if it wasn't by luck that
GFP_ZONETYPES == GFP_ZONEMASK, and I suspect the Non-loner version of
GFP_ZONETYPES would trigger it. I don't understand what loner means.
online dict returns:

loner
     n : a person who avoids the company or assistance of others

nosense for non-english speaker in GFP_ZONETYPES context:

/* #define GFP_ZONETYPES	(GFP_ZONEMASK + 1) */		/* Non-loner */
#define GFP_ZONETYPES	((GFP_ZONEMASK + 1) / 2 + 1)		/* Loner */


anyways GFP_ZONETYPES has absolutely nothing to do with this code, no
idea how it splipped into it, this is not a zonelist, this is a
node_zones array only in function of MAX_NR_ZONES and it makes no sense
to me to use anything but MAX_NR_ZONES to initialialize it.

This is my forward port from 2.4 that should fix it.

static void setup_per_zone_lowmem_reserve(void)
{
	struct pglist_data *pgdat;
	int j, idx;

	for_each_pgdat(pgdat) {
		for (j = 0; j < MAX_NR_ZONES; j++) {
			zone_t *zone = pgdat->node_zones + j;
			unsigned long presentpages = zone->presentpages;

			zone->lowmem_reserve[j] = 0;

			for (idx = j-1; idx >= 0; idx--) {
				zone_t * lower_zone = pgdat->node_zones + idx;

				lower_zone->lowmem_reserve[j] = presetpages / lower_zone_reserve_ratio[idx];
				presentpages += lower_zone->presentpages;
			}
		}
	}
}

here a diff to compare it with current 2.6 code.

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids -u sles-ref/mm/page_alloc.c sles/mm/page_alloc.c
--- sles-ref/mm/page_alloc.c	2004-10-25 13:50:37.287995072 +0200
+++ sles/mm/page_alloc.c	2004-10-25 14:37:23.358407528 +0200
@@ -1905,87 +1892,29 @@ void __init page_alloc_init(void)
 	hotcpu_notifier(page_alloc_cpu_notify, 0);
 }
 
-static unsigned long higherzone_val(struct zone *z, int max_zone,
-					int alloc_type)
-{
-	int z_idx = zone_idx(z);
-	struct zone *higherzone;
-	unsigned long pages;
-
-	/* there is no higher zone to get a contribution from */
-	if (z_idx == MAX_NR_ZONES-1)
-		return 0;
-
-	higherzone = &z->zone_pgdat->node_zones[z_idx+1];
-
-	/* We always start with the higher zone's protection value */
-	pages = higherzone->protection[alloc_type];
-
-	/*
-	 * We get a lower-zone-protection contribution only if there are
-	 * pages in the higher zone and if we're not the highest zone
-	 * in the current zonelist.  e.g., never happens for GFP_DMA. Happens
-	 * only for ZONE_DMA in a GFP_KERNEL allocation and happens for ZONE_DMA
-	 * and ZONE_NORMAL for a GFP_HIGHMEM allocation.
-	 */
-	if (higherzone->present_pages && z_idx < alloc_type)
-		pages += higherzone->pages_low * sysctl_lower_zone_protection;
-
-	return pages;
-}
-
 /*
- * setup_per_zone_protection - called whenver min_free_kbytes or
- *	sysctl_lower_zone_protection changes.  Ensures that each zone
- *	has a correct pages_protected value, so an adequate number of
+ * setup_per_zone_lowmem_reserve - called whenever
+ *	sysctl_lower_zone_reserve_ratio changes.  Ensures that each zone
+ *	has a correct pages reserved value, so an adequate number of
  *	pages are left in the zone after a successful __alloc_pages().
- *
- *	This algorithm is way confusing.  I tries to keep the same behavior
- *	as we had with the incremental min iterative algorithm.
  */
-static void setup_per_zone_protection(void)
+static void setup_per_zone_lowmem_reserve(void)
 {
 	struct pglist_data *pgdat;
-	struct zone *zones, *zone;
-	int max_zone;
-	int i, j;
+	int j, idx;
 
 	for_each_pgdat(pgdat) {
-		zones = pgdat->node_zones;
+		for (j = 0; j < MAX_NR_ZONES; j++) {
+			zone_t *zone = pgdat->node_zones + j;
+			unsigned long presentpages = zone->presentpages;
 
-		for (i = 0, max_zone = 0; i < MAX_NR_ZONES; i++)
-			if (zones[i].present_pages)
-				max_zone = i;
+			zone->lowmem_reserve[j] = 0;
 
-		/*
-		 * For each of the different allocation types:
-		 * GFP_DMA -> GFP_KERNEL -> GFP_HIGHMEM
-		 */
-		for (i = 0; i < GFP_ZONETYPES; i++) {
-			/*
-			 * For each of the zones:
-			 * ZONE_HIGHMEM -> ZONE_NORMAL -> ZONE_DMA
-			 */
-			for (j = MAX_NR_ZONES-1; j >= 0; j--) {
-				zone = &zones[j];
+			for (idx = j-1; idx >= 0; idx--) {
+				zone_t * lower_zone = pgdat->node_zones + idx;
 
-				/*
-				 * We never protect zones that don't have memory
-				 * in them (j>max_zone) or zones that aren't in
-				 * the zonelists for a certain type of
-				 * allocation (j>=i).  We have to assign these
-				 * to zero because the lower zones take
-				 * contributions from the higher zones.
-				 */
-				if (j > max_zone || j >= i) {
-					zone->protection[i] = 0;
-					continue;
-				}
-				/*
-				 * The contribution of the next higher zone
-				 */
-				zone->protection[i] = higherzone_val(zone,
-								max_zone, i);
+				lower_zone->lowmem_reserve[j] = presetpages / lower_zone_reserve_ratio[idx];
+				presentpages += lower_zone->presentpages;
 			}
 		}
 	}

quite some garbage got deleted:

andrea@dualathlon:~/devel/kernel> diffstat /tmp/z
 page_alloc.c |   84 +++++++++--------------------------------------------------
 1 files changed, 13 insertions(+), 71 deletions(-)
andrea@dualathlon:~/devel/kernel> 

I'll adapt the rest of the code to deal with this and test it in a few
more minutes.
