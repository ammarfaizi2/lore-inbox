Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUBVJNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 04:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbUBVJNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 04:13:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:61654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261205AbUBVJNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 04:13:52 -0500
Date: Sun, 22 Feb 2004 01:13:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: piggin@cyberone.com.au, mfedyk@matchmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-Id: <20040222011350.58f756e8.akpm@osdl.org>
In-Reply-To: <20040222083637.GA15589@dingdong.cryptoapps.com>
References: <20040222033111.GA14197@dingdong.cryptoapps.com>
	<4038299E.9030907@cyberone.com.au>
	<40382BAA.1000802@cyberone.com.au>
	<4038307B.2090405@cyberone.com.au>
	<40383300.5010203@matchmail.com>
	<4038402A.4030708@cyberone.com.au>
	<40384325.1010802@matchmail.com>
	<403845CB.8040805@cyberone.com.au>
	<20040221221721.42e734d6.akpm@osdl.org>
	<40384D9D.6040604@cyberone.com.au>
	<20040222083637.GA15589@dingdong.cryptoapps.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Sun, Feb 22, 2004 at 05:35:09PM +1100, Nick Piggin wrote:
> 
> > Can you maybe use this patch then, please?
> 
> I probably need to do more testing, but the quick patch I was using
> against mainline (bk head) works better than this against 2.5.3-mm2.

The patch which went in six months or so back which said "only reclaim slab
if we're scanning lowmem pagecache" was wrong.  I must have been asleep at
the time.

We do need to scan slab in response to highmem page reclaim as well. 
Because all the math is based around the total amount of memory in the
machine, and we know that if we're performing highmem page reclaim then the
lower zones have no free memory.

Also, the fact that this patch makes such a difference on the 1.5G machine
points at a problem in balancing the reclaim rate against the different
zones.  I'll take a look at that separate problem.

This should apply to 2.6.3-mm2.


 mm/vmscan.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff -puN mm/vmscan.c~a mm/vmscan.c
--- 25/mm/vmscan.c~a	2004-02-22 00:37:09.000000000 -0800
+++ 25-akpm/mm/vmscan.c	2004-02-22 00:37:49.000000000 -0800
@@ -922,12 +922,10 @@ int try_to_free_pages(struct zone **zone
 		nr_reclaimed += shrink_caches(zones, priority, &total_scanned,
 						gfp_mask, nr_pages, &ps);
 
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
 
 		if (nr_reclaimed >= nr_pages) {
@@ -1021,11 +1019,9 @@ static int balance_pgdat(pg_data_t *pgda
 			zone->temp_priority = priority;
 			reclaimed = shrink_zone(zone, GFP_KERNEL,
 					to_reclaim, &nr_scanned, ps, priority);
-			if (i < ZONE_HIGHMEM) {
-				reclaim_state->reclaimed_slab = 0;
-				shrink_slab(nr_scanned, GFP_KERNEL);
-				reclaimed += reclaim_state->reclaimed_slab;
-			}
+			reclaim_state->reclaimed_slab = 0;
+			shrink_slab(nr_scanned, GFP_KERNEL);
+			reclaimed += reclaim_state->reclaimed_slab;
 			to_free -= reclaimed;
 			if (zone->all_unreclaimable)
 				continue;

_

