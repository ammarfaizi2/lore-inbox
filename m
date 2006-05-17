Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWEQOME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWEQOME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 10:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWEQOMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 10:12:03 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:39321 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932565AbWEQOMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 10:12:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: limit lowmem_reserve
Date: Thu, 18 May 2006 00:11:41 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <200604021401.13331.kernel@kolivas.org> <200604081101.06066.kernel@kolivas.org> <443710F7.3040201@yahoo.com.au>
In-Reply-To: <443710F7.3040201@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4899
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200605180011.43216.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hate to resuscitate this old thread, sorry but I'm still not sure we 
resolved it and I want to make sure this issue isn't here as I see it.

On Saturday 08 April 2006 11:25, Nick Piggin wrote:
> Con Kolivas wrote:
> > Ok. I think I presented enough information for why I thought
> > zone_watermark_ok would fail (for ZONE_DMA). With 16MB ZONE_DMA and a
> > vmsplit of 3GB we have a lowmem_reserve of 12MB. It's pretty hard to keep
> > that much ZONE_DMA free, I don't think I've ever seen that much free on
> > my ZONE_DMA on an ordinary desktop without any particular ZONE_DMA users.
> > Changing the tunable can make the lowmem_reserve larger than ZONE_DMA is
> > on any vmsplit too as far as I understand the ratio.
>
> Umm, for ZONE_DMA allocations, ZONE_DMA isn't a lower zone. So that
> 12MB protection should never come into it (unless it is buggy?).

An i386 pc with a 3GB split will have approx

4000 pages ZONE_DMA

and lowmem reserve will set lowmem reserve to approx

0 0 3000 3000

So if we call zone_watermark_ok with zone of ZONE_DMA and a classzone_idx of a 
ZONE_NORMAL we will fail a zone_watermark_ok test almost always since it's 
almost impossible to have 3000 free ZONE_DMA pages. I believe it can happen 
like this:

In balance_pgdat (vmscan.c:1116) if we end up with end_zone being a 
ZONE_NORMAL zone, then during the scan below we (vmscan.c:1137) iterate over 
all zones from 0 to end_zone and (vmscan.c:1147) we end up calling

if (!zone_watermark_ok(zone, order, zone->pages_high, end_zone, 0))

which would now call zone_watermark_ok with zone being a ZONE_DMA, and 
end_zone being the idx of a ZONE_NORMAL.

So in summary if I'm not mistaken (and I'm good at being mistaken), if we 
balance pgdat and find that ZONE_NORMAL or higher needs scanning, we'll end 
up trying to flush the crap out of ZONE_DMA.

On my test case this indeed happens and my ZONE_DMA never goes below 3000
pages free. If I lower the reserve even further my pages free gets stuck at
3208 and can't free any more, and doesn't ever drop below that either.

Here is the patch I was proposing

---
It is possible with a low enough lowmem_reserve ratio to make
zone_watermark_ok fail repeatedly if the lower_zone is small enough.
Impose a lower limit on the ratio to only allow 1/4 of the lower_zone
size to be set as lowmem_reserve. This limit is hit in ZONE_DMA by changing
the default vmsplit on i386 even without changing the default sysctl values.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 mm/page_alloc.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc1-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc1-mm1.orig/mm/page_alloc.c	2006-04-06 10:32:31.000000000 +1000
+++ linux-2.6.17-rc1-mm1/mm/page_alloc.c	2006-04-06 11:28:11.000000000 +1000
@@ -2566,14 +2566,32 @@ static void setup_per_zone_lowmem_reserv
 			zone->lowmem_reserve[j] = 0;
 
 			for (idx = j-1; idx >= 0; idx--) {
+				unsigned long max_reserve;
+				unsigned long reserve;
 				struct zone *lower_zone;
 
+				lower_zone = pgdat->node_zones + idx;
+				/*
+				 * Put an upper limit on the reserve at 1/4
+				 * the lower_zone size. This prevents large
+				 * zone size differences such as 3G VMSPLIT
+				 * or low sysctl values from making
+				 * zone_watermark_ok always fail. This
+				 * enforces a lower limit on the reserve_ratio
+				 */
+				max_reserve = lower_zone->present_pages / 4;
+
 				if (sysctl_lowmem_reserve_ratio[idx] < 1)
 					sysctl_lowmem_reserve_ratio[idx] = 1;
-
-				lower_zone = pgdat->node_zones + idx;
-				lower_zone->lowmem_reserve[j] = present_pages /
+				reserve = present_pages /
 					sysctl_lowmem_reserve_ratio[idx];
+				if (max_reserve && reserve > max_reserve) {
+					reserve = max_reserve;
+					sysctl_lowmem_reserve_ratio[idx] =
+						present_pages / max_reserve;
+				}
+
+				lower_zone->lowmem_reserve[j] = reserve;
 				present_pages += lower_zone->present_pages;
 			}
 		}


-- 
-ck
