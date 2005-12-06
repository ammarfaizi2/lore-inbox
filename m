Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVLFNgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVLFNgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVLFNf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:35:58 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:21977 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932562AbVLFNfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:35:51 -0500
Message-Id: <20051206135804.825753000@localhost.localdomain>
References: <20051206135608.860737000@localhost.localdomain>
Date: Tue, 06 Dec 2005 21:56:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 05/13] mm: balance zone aging in kswapd reclaim path
Content-Disposition: inline; filename=mm-balance-zone-aging-in-kswapd-reclaim.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vm subsystem is rather complex. System memory is divided into zones,
lower zones act as fallback of higher zones in memory allocation.  The page
reclaim algorithm should generally keep zone aging rates in sync. But if a
zone under watermark has many unreclaimable pages, it has to be scanned much
more to get enough free pages. While doing this,

- lower zones should also be scanned more, since their pages are also usable
  for higher zone allocations.
- higher zones should not be scanned just to keep the aging in sync, which
  can evict large amount of pages without saving the problem(and may well
  worsen it).

With that in mind, the patch does the rebalance in kswapd as follows:
1) reclaim from the lowest zone when
	- under pages_high
	- under pages_high+lowmem_reserve, and less/equal aged than highest
	  zone(or out of sync with it)
2) reclaim from higher zones when
	- under pages_high+lowmem_reserve, and less/equal aged than its
	  immediate lower neighbor(or out of sync with it)

Note that the zone age is a normalized value in range 0-4096 on i386/4G. 4096
corresponds to a full scan of one zone. And the comparison of ages are only
deemed ok if the gap is less than 4096/8, or they will be regarded as out of
sync.

On exit, the code ensures:
1) the lowest zone will be pages_high ok
2) at least one zone will be pages_high+lowmem_reserve ok
3) a very strong force of rebalancing with the exception of
	- some lower zones are unreclaimable: we must let them go ahead
	  alone, leaving higher zones back
	- shrink_zone() scans too much and creates huge imbalance in one
	  run(Nick is working on this)

The logic can deal with known normal/abnormal situations gracefully:
1) Normal case
	- zone ages are cyclicly tied together: taking over each other, and
	  keeping close enough

2) A Zone is unreclaimable, scanned much more, and become out of sync
	- if ever a troublesome zone is being overscanned, the logic brings
	  its lower neighbors ahead together, leaving higher neighbors back.
	- the aging tie between the two groups is broken, and the relevant
	  zones are reclaimed when pages_high+lowmem_reserve not ok, just as
	  before the patch.
	- at some time the zone ages meet again and back to normal
	- a possiblely better strategy, as soon as the pressure disappeared,
	  might be relunctant to reclaim from the already overscanned lower
	  group, and let the higher group slowly catch up.

3) Zone is truncated
	- will not reclaim from it until under watermark

With this patch, the meaning of zone->pages_high+lowmem_reserve changed from
the _required_ watermark to the _recommended_ watermark. Someone might be
willing to increase them somehow.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

--- linux-2.6.15-rc5-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc5-mm1/mm/vmscan.c
@@ -1359,6 +1359,7 @@ static int balance_pgdat(pg_data_t *pgda
 	int total_scanned, total_reclaimed;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
+	struct zone *prev_zone = pgdat->node_zones;
 
 loop_again:
 	total_scanned = 0;
@@ -1374,6 +1375,9 @@ loop_again:
 		struct zone *zone = pgdat->node_zones + i;
 
 		zone->temp_priority = DEF_PRIORITY;
+
+		if (populated_zone(zone))
+			prev_zone = zone;
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
@@ -1404,14 +1408,25 @@ loop_again:
 			if (!populated_zone(zone))
 				continue;
 
-			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone_watermark_ok(zone, order,
-					zone->pages_high, 0, 0))
-					continue;
+			if (nr_pages) 	/* software suspend */
+				goto scan_swspd;
 
-				all_zones_ok = 0;
+			if (zone < prev_zone &&
+					!zone_watermark_ok(zone, order,
+						zone->pages_high, 0, 0)) {
+			} else if (!age_gt(zone, prev_zone) &&
+					!zone_watermark_ok(zone, order,
+						zone->pages_high,
+						pgdat->nr_zones - 1, 0)) {
+			} else {
+				prev_zone = zone;
+				continue;
 			}
 
+			prev_zone = zone;
+			all_zones_ok = 0;
+
+scan_swspd:
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 

--
