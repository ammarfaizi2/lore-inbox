Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVLAKeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVLAKeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVLAKeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:34:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932134AbVLAKeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:34:24 -0500
Date: Thu, 1 Dec 2005 02:33:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, christoph@lameter.com, riel@redhat.com,
       a.p.zijlstra@chello.nl, npiggin@suse.de, andrea@suse.de,
       marcelo.tosatti@cyclades.com, magnus.damm@gmail.com,
       wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 01/12] vm: kswapd incmin
Message-Id: <20051201023330.3dd9c48f.akpm@osdl.org>
In-Reply-To: <20051201101918.396239000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101918.396239000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> Explicitly teach kswapd about the incremental min logic instead of just scanning
>  all zones under the first low zone. This should keep more even pressure applied
>  on the zones.

I spat this back a while ago.  See the changelog (below) for the logic
which you're removing.

This change appears to go back to performing reclaim in the highmem->lowmem
direction.  Page reclaim might go all lumpy again.


Shouldn't first_low_zone be initialised to ZONE_HIGHMEM (or pgdat->nr_zones
- 1) rather than to 0, or something?  I don't understand why we're passing
zero as the classzone_idx into zone_watermark_ok() in the first go around
the loop.

And this bit, which Nick didn't reply to (wimp!).  I think it's a bug.



Looking at it, I am confused.

 In the first loop:

 			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 				struct zone *zone = pgdat->node_zones + i;
 	...
 				if (!zone_watermark_ok(zone, order,
 						zone->pages_high, 0, 0)) {
 					end_zone = i;
 					goto scan;
 				}

 end_zone gets the value of the highest-numbered zone which needs scanning. 
 Where `0' corresponds to ZONE_DMA.  (correct?)

 In the second loop:

 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;

 Shouldn't that be

 		for (i = end_zone; ...; i++)

 or am I on crack?




 As kswapd is now scanning zones in the highmem->normal->dma direction it can
 get into competition with the page allocator: kswapd keep on trying to free
 pages from highmem, then kswapd moves onto lowmem.  By the time kswapd has
 done proportional scanning in lowmem, someone has come in and allocated a few
 pages from highmem.  So kswapd goes back and frees some highmem, then some
 lowmem again.  But nobody has allocated any lowmem yet.  So we keep on and on
 scanning lowmem in response to highmem page allocations.

 With a simple `dd' on a 1G box we get:

  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
  0  3      0  59340   4628 922348    0    0     4 28188 1072   808  0 10 46 44
  0  3      0  29932   4660 951760    0    0     0 30752 1078   441  1  6 30 64
  0  3      0  57568   4556 924052    0    0     0 30748 1075   478  0  8 43 49
  0  3      0  29664   4584 952176    0    0     0 30752 1075   472  0  6 34 60
  0  3      0   5304   4620 976280    0    0     4 40484 1073   456  1  7 52 41
  0  3      0 104856   4508 877112    0    0     0 18452 1074    97  0  7 67 26
  0  3      0  70768   4540 911488    0    0     0 35876 1078   746  0  7 34 59
  1  2      0  42544   4568 939680    0    0     0 21524 1073   556  0  5 43 51
  0  3      0   5520   4608 976428    0    0     4 37924 1076   836  0  7 41 51
  0  2      0   4848   4632 976812    0    0    32 12308 1092    94  0  1 33 66

 Simple fix: go back to scanning the zones in the dma->normal->highmem
 direction so we meet the page allocator in the middle somewhere.

  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
  1  3      0   5152   3468 976548    0    0     4 37924 1071   650  0  8 64 28
  1  2      0   4888   3496 976588    0    0     0 23576 1075   726  0  6 66 27
  0  3      0   5336   3532 976348    0    0     0 31264 1072   708  0  8 60 32
  0  3      0   6168   3560 975504    0    0     0 40992 1072   683  0  6 63 31
  0  3      0   4560   3580 976844    0    0     0 18448 1073   233  0  4 59 37
  0  3      0   5840   3624 975712    0    0     4 26660 1072   800  1  8 46 45
  0  3      0   4816   3648 976640    0    0     0 40992 1073   526  0  6 47 47
  0  3      0   5456   3672 976072    0    0     0 19984 1070   320  0  5 60 35



 ---

  25-akpm/mm/vmscan.c |   37 +++++++++++++++++++++++++++++++++++--
  1 files changed, 35 insertions(+), 2 deletions(-)

 diff -puN mm/vmscan.c~kswapd-avoid-higher-zones-reverse-direction mm/vmscan.c
 --- 25/mm/vmscan.c~kswapd-avoid-higher-zones-reverse-direction	2004-03-12 01:33:09.000000000 -0800
 +++ 25-akpm/mm/vmscan.c	2004-03-12 01:33:09.000000000 -0800
 @@ -924,8 +924,41 @@ static int balance_pgdat(pg_data_t *pgda
  	for (priority = DEF_PRIORITY; priority; priority--) {
  		int all_zones_ok = 1;
  		int pages_scanned = 0;
 +		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
  
 -		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 +
 +		if (nr_pages == 0) {
 +			/*
 +			 * Scan in the highmem->dma direction for the highest
 +			 * zone which needs scanning
 +			 */
 +			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 +				struct zone *zone = pgdat->node_zones + i;
 +
 +				if (zone->all_unreclaimable &&
 +						priority != DEF_PRIORITY)
 +					continue;
 +
 +				if (zone->free_pages <= zone->pages_high) {
 +					end_zone = i;
 +					goto scan;
 +				}
 +			}
 +			goto out;
 +		} else {
 +			end_zone = pgdat->nr_zones - 1;
 +		}
 +scan:
 +		/*
 +		 * Now scan the zone in the dma->highmem direction, stopping
 +		 * at the last zone which needs scanning.
 +		 *
 +		 * We do this because the page allocator works in the opposite
 +		 * direction.  This prevents the page allocator from allocating
 +		 * pages behind kswapd's direction of progress, which would
 +		 * cause too much scanning of the lower zones.
 +		 */
 +		for (i = 0; i <= end_zone; i++) {
  			struct zone *zone = pgdat->node_zones + i;
  			int total_scanned = 0;
  			int max_scan;
 @@ -965,7 +998,7 @@ static int balance_pgdat(pg_data_t *pgda
  		if (pages_scanned)
  			blk_congestion_wait(WRITE, HZ/10);
  	}
 -
 +out:
  	for (i = 0; i < pgdat->nr_zones; i++) {
  		struct zone *zone = pgdat->node_zones + i;
  

 _

