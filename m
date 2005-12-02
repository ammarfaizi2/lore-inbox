Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751738AbVLBFuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbVLBFuF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 00:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbVLBFuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 00:50:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751738AbVLBFuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 00:50:03 -0500
Date: Thu, 1 Dec 2005 21:49:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for
 balanced zone aging
Message-Id: <20051201214931.2dbc35fe.akpm@osdl.org>
In-Reply-To: <20051202011924.GA3516@mail.ustc.edu.cn>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101933.936973000@localhost.localdomain>
	<20051201023714.612f0bbf.akpm@osdl.org>
	<20051201222846.GA3646@dmt.cnet>
	<20051201150349.3538638e.akpm@osdl.org>
	<20051202011924.GA3516@mail.ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
>      865                         if (sc->nr_to_reclaim <= 0)
>      866                                 break;
>      867                 }
>      868         }
> 
>  Line 843 is the core of the scan balancing logic:
> 
>  priority                12      11      10
> 
>  On each call nr_scan_inactive is increased by:
>  DMA(2k pages)           +1      +2      +3
>  Normal(64k pages)      +17      +33     +65 
> 
>  Round it up to SWAP_CLUSTER_MAX=32, we get (scan batches/accumulate rounds):
>  DMA                     1/32    1/16    2/11
>  Normal                  2/2     2/1     3/1
>  DMA:Normal ratio        1:32    1:32    2:33
> 
>  This keeps the scan rate roughly balanced(i.e. 1:32) in low vm pressure.
> 
>  But lines 865-866 together with line 846 make most shrink_zone() invocations
>  only run one batch of scan.

Yes, this seems to be the problem.  Sigh.  By the time 2.6.8 came around I
just didn't have time to do the amount of testing which any page reclaim
tweak necessitates.



From: Andrew Morton <akpm@osdl.org>

Revert a patch which went into 2.6.8-rc1.  The changelog for that patch was:

  The shrink_zone() logic can, under some circumstances, cause far too many
  pages to be reclaimed.  Say, we're scanning at high priority and suddenly
  hit a large number of reclaimable pages on the LRU.

  Change things so we bale out when SWAP_CLUSTER_MAX pages have been
  reclaimed.

Problem is, this change caused significant imbalance in inter-zone scan
balancing by truncating scans of larger zones.

Suppose, for example, ZONE_HIGHMEM is 10x the size of ZONE_NORMAL.  The zone
balancing algorithm would require that if we're scanning 100 pages of
ZONE_HIGHMEM, we should scan 10 pages of ZONE_NORMAL.  But this logic will
cause the scanning of ZONE_HIGHMEM to bale out after only 32 pages are
reclaimed.  Thus effectively causing smaller zones to be scanned relatively
harder than large ones.

Now I need to remember what the workload was which caused me to write this
patch originally, then fix it up in a different way...

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/vmscan.c |    8 --------
 1 files changed, 8 deletions(-)

diff -puN mm/vmscan.c~vmscan-balancing-fix mm/vmscan.c
--- devel/mm/vmscan.c~vmscan-balancing-fix	2005-12-01 21:20:44.000000000 -0800
+++ devel-akpm/mm/vmscan.c	2005-12-01 21:21:38.000000000 -0800
@@ -63,9 +63,6 @@ struct scan_control {
 
 	unsigned long nr_mapped;	/* From page_state */
 
-	/* How many pages shrink_cache() should reclaim */
-	int nr_to_reclaim;
-
 	/* Ask shrink_caches, or shrink_zone to scan at this priority */
 	unsigned int priority;
 
@@ -901,7 +898,6 @@ static void shrink_cache(struct zone *zo
 		if (current_is_kswapd())
 			mod_page_state(kswapd_steal, nr_freed);
 		mod_page_state_zone(zone, pgsteal, nr_freed);
-		sc->nr_to_reclaim -= nr_freed;
 
 		spin_lock_irq(&zone->lru_lock);
 		/*
@@ -1101,8 +1097,6 @@ shrink_zone(struct zone *zone, struct sc
 	else
 		nr_inactive = 0;
 
-	sc->nr_to_reclaim = sc->swap_cluster_max;
-
 	while (nr_active || nr_inactive) {
 		if (nr_active) {
 			sc->nr_to_scan = min(nr_active,
@@ -1116,8 +1110,6 @@ shrink_zone(struct zone *zone, struct sc
 					(unsigned long)sc->swap_cluster_max);
 			nr_inactive -= sc->nr_to_scan;
 			shrink_cache(zone, sc);
-			if (sc->nr_to_reclaim <= 0)
-				break;
 		}
 	}
 
_

