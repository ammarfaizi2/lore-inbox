Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbUB0TD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUB0TDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:03:24 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:48631 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262938AbUB0TCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:02:54 -0500
Message-ID: <403F9433.5070009@matchmail.com>
Date: Fri, 27 Feb 2004 11:02:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com> <403D5174.6050302@cyberone.com.au> <403D7C7D.5090902@matchmail.com>
In-Reply-To: <403D7C7D.5090902@matchmail.com>
Content-Type: multipart/mixed;
 boundary="------------060306030102050907070100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060306030102050907070100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mike Fedyk wrote:
> Nick Piggin wrote:
> 
>> IMO, shrink_slab-for-all-zones.patch and zone-balancing-fix.patch
>> should be all you need although they won't shrink the slab as
>> much as mm3. They should be pretty easy to port by hand.
> 
> 
> How does this patch for 2.6.3 look?

Never mind, I was brain dead at the time.

This one should be better.

Mike

--------------060306030102050907070100
Content-Type: text/x-patch;
 name="2.6.3-shrink_slab-for-all-zones-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.3-shrink_slab-for-all-zones-2.patch"

--- linux-2.6.3/mm/vmscan.c	2004-02-25 20:50:35.000000000 -0800
+++ linux-2.6.3-slab-lofft/mm/vmscan.c	2004-02-25 20:41:45.000000000 -0800
@@ -885,12 +885,10 @@
 
 		/* Take a nap, wait for some writeback to complete */
 		blk_congestion_wait(WRITE, HZ/10);
-		if (zones[0] - zones[0]->zone_pgdat->node_zones < ZONE_HIGHMEM) {
-			shrink_slab(total_scanned, gfp_mask);
-			if (reclaim_state) {
-				nr_reclaimed += reclaim_state->reclaimed_slab;
-				reclaim_state->reclaimed_slab = 0;
-			}
+		shrink_slab(total_scanned, gfp_mask);
+		if (reclaim_state) {
+			nr_reclaimed += reclaim_state->reclaimed_slab;
+			reclaim_state->reclaimed_slab = 0;
 		}
 	}
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
@@ -962,11 +960,9 @@
 				max_scan = SWAP_CLUSTER_MAX;
 			to_free -= shrink_zone(zone, max_scan, GFP_KERNEL,
 					to_reclaim, &nr_mapped, ps, priority);
-			if (i < ZONE_HIGHMEM) {
-				reclaim_state->reclaimed_slab = 0;
-				shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
-				to_free -= reclaim_state->reclaimed_slab;
-			}
+			reclaim_state->reclaimed_slab = 0;
+			shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
+			to_free -= reclaim_state->reclaimed_slab;
 			if (zone->all_unreclaimable)
 				continue;
 			if (zone->pages_scanned > zone->present_pages * 2)

--------------060306030102050907070100--
