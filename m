Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVLAWku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVLAWku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVLAWku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:40:50 -0500
Received: from hera.kernel.org ([140.211.167.34]:34209 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932534AbVLAWku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:40:50 -0500
Date: Thu, 1 Dec 2005 20:28:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051201222846.GA3646@dmt.cnet>
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201023714.612f0bbf.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Dec 01, 2005 at 02:37:14AM -0800, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> >  The zone aging rates are currently imbalanced,
> 
> ZONE_DMA is out of whack.  It shouldn't be, and I'm not aware of anyone
> getting in and working out why.  I certainly wouldn't want to go and add
> all this stuff without having a good understanding of _why_ it's out of
> whack.  Perhaps it's just some silly bug, like the thing I pointed at in
> the previous email.

I think that the problem is caused by the interaction between 
the way reclaiming is quantified and parallel allocators.

The zones have different sizes, and each zone reclaim iteration
scans the same number of pages. It is unfair.

On top of that, kswapd is likely to block while doing its job, 
which means that allocators have a chance to run.

It seems that scaling the number of isolated pages to zone 
size fixes the unbalancing problem, making the Normal zone
be _more_ scanned than DMA. Which is expected since the
lower zone protection logic decreases allocation pressure
from DMA sending it straight to the Normal zone (therefore 
zeroing lower_zone_protection should make the scanning 
proportionally equal).

Test used was FFSB using the following profile on a 128MB 
P-3 machine:

num_filesystems=1
num_threadgroups=1
directio=0
time=300

[filesystem0]
location=/mnt/hda4/
num_files=20
num_dirs=10
max_filesize=91534338
min_filesize=65535
[end0]

[threadgroup0]
num_threads=10
write_size=2816
write_blocksize=4096
read_size=2816
read_blocksize=4096
create_weight=100
write_weight=30
read_weight=100
[end0]

And the scanning ratios are:

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


I think it becomes pretty clear that this is really 
the case. On vanilla, for each DMA allocation, there 
are 6.415 NORMAL allocations, while the NORMAL zone 
is 7.000 times the size of DMA.

With the patch, there are 10.5 NORMAL allocations for each
DMA one.

Batching of reclaim is affected by the relative
isolation (now in smaller batches) though.

--- mm/vmscan.c.orig	2006-01-01 12:44:39.000000000 -0200
+++ mm/vmscan.c	2006-01-01 16:43:54.000000000 -0200
@@ -616,8 +616,12 @@
 {
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
+	int nr_to_isolate;
 	int max_scan = sc->nr_to_scan;
 
+	nr_to_isolate = (sc->swap_cluster_max * zone->present_pages)
+			/ total_memory;
+
 	pagevec_init(&pvec, 1);
 
 	lru_add_drain();
@@ -628,7 +632,8 @@
 		int nr_scan;
 		int nr_freed;
 
-		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
+
+		nr_taken = isolate_lru_pages(nr_to_isolate,
 					     &zone->inactive_list,
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;



