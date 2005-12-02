Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVLBBTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVLBBTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbVLBBTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:19:30 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:48833 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932593AbVLBBT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:19:29 -0500
Date: Fri, 2 Dec 2005 09:19:24 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, christoph@lameter.com, riel@redhat.com,
       a.p.zijlstra@chello.nl, npiggin@suse.de, andrea@suse.de,
       magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202011924.GA3516@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, christoph@lameter.com,
	riel@redhat.com, a.p.zijlstra@chello.nl, npiggin@suse.de,
	andrea@suse.de, magnus.damm@gmail.com
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201150349.3538638e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 03:03:49PM -0800, Andrew Morton wrote:
> > > ZONE_DMA is out of whack.  It shouldn't be, and I'm not aware of anyone
> > > getting in and working out why.  I certainly wouldn't want to go and add
> > > all this stuff without having a good understanding of _why_ it's out of
> > > whack.  Perhaps it's just some silly bug, like the thing I pointed at in
> > > the previous email.
> > 
> > I think that the problem is caused by the interaction between 
> > the way reclaiming is quantified and parallel allocators.
> 
> Could be.  But what about the bug which I think is there?  That'll cause
> overscanning of the DMA zone.

Take for example these numbers:
--------------------------------------------------------------------------------
active/inactive sizes on 2.6.14-1-k7-smp:
43/1000         = 116 / 2645
819/1000        = 54023 / 65881

active/inactive scan rates:
dma      480/1000       = 31364 / (58377 + 6963)
normal   985/1000       = 719219 / (645051 + 84579)
high     0/1000         = 0 / (0 + 0)
             
             total       used       free     shared    buffers     cached
Mem:           503        497          6          0          0        328
-/+ buffers/cache:        168        335
Swap:          127          2        125
--------------------------------------------------------------------------------

cold-page-scan-rate = K * (direct-reclaim-count * direct-scan-prob +
                           kswapd-reclaim-count * kswapd-scan-prob) * shrink-zone-prob

(direct-reclaim-count : kswapd-reclaim-count) depends on memory pressure.
Here it is
        DMA:    8 = 58377 / 6963
        Normal: 7 = 645051 / 84579

(direct-scan-prob) is roughly equal for all zones.
(kswapd-scan-prob) is expected to be equal too.

So the equation can be simplified to:
cold-page-scan-rate ~= C * shrink-zone-prob

It depends largely on the shrink_zone() function:

    843         zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
    844         nr_inactive = zone->nr_scan_inactive;
    845         if (nr_inactive >= sc->swap_cluster_max)
    846                 zone->nr_scan_inactive = 0;
    847         else
    848                 nr_inactive = 0;
    849         
    850         sc->nr_to_reclaim = sc->swap_cluster_max;
    851         
    852         while (nr_active || nr_inactive) {
                        //...
    860                 if (nr_inactive) {
    861                         sc->nr_to_scan = min(nr_inactive,
    862                                         (unsigned long)sc->swap_cluster_max);
    863                         nr_inactive -= sc->nr_to_scan;
    864                         shrink_cache(zone, sc);
    865                         if (sc->nr_to_reclaim <= 0)
    866                                 break;
    867                 }
    868         }

Line 843 is the core of the scan balancing logic:

priority                12      11      10

On each call nr_scan_inactive is increased by:
DMA(2k pages)           +1      +2      +3
Normal(64k pages)      +17      +33     +65 

Round it up to SWAP_CLUSTER_MAX=32, we get (scan batches/accumulate rounds):
DMA                     1/32    1/16    2/11
Normal                  2/2     2/1     3/1
DMA:Normal ratio        1:32    1:32    2:33

This keeps the scan rate roughly balanced(i.e. 1:32) in low vm pressure.

But lines 865-866 together with line 846 make most shrink_zone() invocations
only run one batch of scan. The numbers become:

DMA                     1/32    1/16    1/11
Normal                  1/2     1/1     1/1
DMA:Normal ratio        1:16    1:16    1:11

Now the scan ratio turns into something between 2:1 ~ 3:1 !

Another problem is that the equation in line 843 is quite coarse, 64k/127k
pages result in the same result, leading to a large variance range.

Thanks,
Wu
