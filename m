Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751735AbVLBGhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbVLBGhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 01:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVLBGhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 01:37:15 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:3207 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751735AbVLBGhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 01:37:14 -0500
Date: Fri, 2 Dec 2005 14:38:39 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, christoph@lameter.com, riel@redhat.com,
       a.p.zijlstra@chello.nl, npiggin@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202063839.GA3606@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
	christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
	npiggin@suse.de, magnus.damm@gmail.com
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201173015.675f4d80.akpm@osdl.org> <20051202020407.GA4445@mail.ustc.edu.cn> <20051202021811.GB28539@opteron.random> <20051201204549.68d3efac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201204549.68d3efac.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 08:45:49PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > low_mem_reserve
> 
> I've a suspicion that the addition of the dma32 zone might have
> broken this.

And there is a danger of (the last zone != the largest zone). This breaks my
assumption. Either we should remove the two lines in shrink_zone():

>      865                         if (sc->nr_to_reclaim <= 0)
>      866                                 break;

Or explicitly add more weight to the balancing efforts with
mm-add-weight-to-reclaim-for-aging.patch below.

Thanks,
Wu

Subject: mm: add more weight to reclaim for aging
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>

Let HighMem = the last zone, we get in normal cases:
- HighMem zone is the largest zone
- HighMem zone is mainly reclaimed for watermark, other zones is almost always
  reclaimed for aging
- While HighMem is reclaimed N times for watermark, other zones has N+1 chances
  to reclaim for aging
- shrink_zone() only scans one chunk of SWAP_CLUSTER_MAX pages to get
  SWAP_CLUSTER_MAX free pages

In the above situation, the force of balancing will win out the force of
unbalancing. But if HighMem(or the last zone) is not the largest zone, the
other larger zones can no longer catch up.

This patch multiplies the force of balancing by 8 times, which should be more
than enough.  It just prevents shrink_zone() to return prematurely, and will
not cause DMA zone to be scanned more than SWAP_CLUSTER_MAX at one time in
normal cases.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1453,12 +1453,14 @@ loop_again:
 							SC_RECLAIM_FROM_KSWAPD|
 							SC_RECLAIM_FOR_WATERMARK);
 					all_zones_ok = 0;
+					sc.nr_to_reclaim = SWAP_CLUSTER_MAX;
 				} else if (zone == youngest_zone &&
 						pages_more_aged(oldest_zone,
 								youngest_zone)) {
 					debug_reclaim(&sc,
 							SC_RECLAIM_FROM_KSWAPD|
 							SC_RECLAIM_FOR_AGING);
+					sc.nr_to_reclaim = SWAP_CLUSTER_MAX * 8;
 				} else
 					continue;
 			}
