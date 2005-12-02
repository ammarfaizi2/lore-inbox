Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVLBPQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVLBPQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 10:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVLBPQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 10:16:24 -0500
Received: from hera.kernel.org ([140.211.167.34]:14209 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750780AbVLBPQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 10:16:23 -0500
Date: Fri, 2 Dec 2005 13:13:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202151352.GA3707@dmt.cnet>
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201214931.2dbc35fe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201214931.2dbc35fe.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 09:49:31PM -0800, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> >      865                         if (sc->nr_to_reclaim <= 0)
> >      866                                 break;
> >      867                 }
> >      868         }
> > 
> >  Line 843 is the core of the scan balancing logic:
> > 
> >  priority                12      11      10
> > 
> >  On each call nr_scan_inactive is increased by:
> >  DMA(2k pages)           +1      +2      +3
> >  Normal(64k pages)      +17      +33     +65 
> > 
> >  Round it up to SWAP_CLUSTER_MAX=32, we get (scan batches/accumulate rounds):
> >  DMA                     1/32    1/16    2/11
> >  Normal                  2/2     2/1     3/1
> >  DMA:Normal ratio        1:32    1:32    2:33
> > 
> >  This keeps the scan rate roughly balanced(i.e. 1:32) in low vm pressure.
> > 
> >  But lines 865-866 together with line 846 make most shrink_zone() invocations
> >  only run one batch of scan.
> 
> Yes, this seems to be the problem.  Sigh.  By the time 2.6.8 came around I
> just didn't have time to do the amount of testing which any page reclaim
> tweak necessitates.

Hi Andrew,

It all makes sense to me (Wu's description of the problem and your patch), 
but still no good with reference to fair scanning. Moreover the patch hurts 
interactivity _badly_, not sure why (ssh into the box with FFSB testcase 
takes more than one minute to login, while vanilla takes few dozens of seconds). 

Follows an interesting part of "diff -u 2614-vanilla.vmstat 2614-akpm.vmstat"
(they were not retrieve at the exact same point in the benchmark run, but 
that should not matter much):

-slabs_scanned 37632
-kswapd_steal 731859
-kswapd_inodesteal 1363
-pageoutrun 26573
-allocstall 636
-pgrotated 1898
+slabs_scanned 2688
+kswapd_steal 502946
+kswapd_inodesteal 1
+pageoutrun 10612
+allocstall 90
+pgrotated 68

Note how direct reclaim (and slabs_scanned) are hugely affected. 

Normal: 114688kB
DMA: 16384kB

Normal/DMA ratio = 114688 / 16384 = 7.000

******* 2.6.14 vanilla ********

* kswapd scanning rates
pgscan_kswapd_normal 450483
pgscan_kswapd_dma 84645
pgscan_kswapd Normal/DMA = (450483 / 88869) = 5.069

* direct scanning rates
pgscan_direct_normal 23826
pgscan_direct_dma 4224
pgscan_direct Normal/DMA = (23826 / 4224) = 5.640

* global (kswapd+direct) scanning rates
pgscan_normal = (450483 + 23826) = 474309
pgscan_dma = (84645 + 4224) = 88869
pgscan Normal/DMA = (474309 / 88869) = 5.337

pgalloc_normal = 794293
pgalloc_dma = 123805
pgalloc_normal_dma_ratio = (794293/123805) = 6.415

******* 2.6.14 akpm-no-nr_to_reclaim ********

* kswapd scanning rates
pgscan_kswapd_normal 441936
pgscan_kswapd_dma 80520
pgscan_kswapd Normal/DMA = (441936 / 80520) = 5.488

* direct scanning rates
pgscan_direct_normal 7392
pgscan_direct_dma 1188
pgscan_direct Normal/DMA = (7392/1188) = 6.222

* global (kswapd+direct) scanning rates
pgscan_normal = (441936 + 7392) = 449328
pgscan_dma = (80520 + 1188) = 81708
pgscan Normal/DMA = (449328 / 81708) = 5.499

pgalloc_normal = 559994
pgalloc_dma = 84883
pgalloc_normal_dma_ratio = (559994 / 8488) = 6.597

****** 2.6.14 isolate relative ***** 

* kswapd scanning rates
pgscan_kswapd_normal 664883
pgscan_kswapd_dma 82845
pgscan_kswapd Normal/DMA (664883/82845) = 8.025

* direct scanning rates
pgscan_direct_normal 13485
pgscan_direct_dma 1745
pgscan_direct Normal/DMA = (13485/1745) = 7.727

* global (kswapd+direct) scanning rates
pgscan_normal = (664883 + 13485) = 678368
pgscan_dma = (82845 + 1745) = 84590
pgscan Normal/DMA = (678368 / 84590) = 8.019

pgalloc_normal 699927
pgalloc_dma 66313
pgalloc_normal_dma_ratio = (699927/66313) = 10.554

