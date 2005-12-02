Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVLBViw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVLBViw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVLBVie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:38:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59273 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbVLBVic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:38:32 -0500
Date: Fri, 2 Dec 2005 13:39:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, christoph@lameter.com,
       riel@redhat.com, a.p.zijlstra@chello.nl, npiggin@suse.de,
       andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for
 balanced zone aging
Message-Id: <20051202133917.1ebbe851.akpm@osdl.org>
In-Reply-To: <20051202151352.GA3707@dmt.cnet>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101933.936973000@localhost.localdomain>
	<20051201023714.612f0bbf.akpm@osdl.org>
	<20051201222846.GA3646@dmt.cnet>
	<20051201150349.3538638e.akpm@osdl.org>
	<20051202011924.GA3516@mail.ustc.edu.cn>
	<20051201214931.2dbc35fe.akpm@osdl.org>
	<20051202151352.GA3707@dmt.cnet>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> 
> It all makes sense to me (Wu's description of the problem and your patch), 
> but still no good with reference to fair scanning.

Not so.  On a 4G x86 box doing a simple 8GB write this patch took the
highmem/normal scanning ratio from 0.7 to 3.5.  On that setup the highmem
zone has 3.6x as many pages as the normal zone, so it's bang-on-target.

There's not a lot of point in jumping straight into the complex stresstests
without having first tested the simple stuff.

> Moreover the patch hurts 
> interactivity _badly_, not sure why (ssh into the box with FFSB testcase 
> takes more than one minute to login, while vanilla takes few dozens of seconds). 

Well, we know that the revert reintroduces an overscanning problem.

How are you invoking FFSB?  Exactly?  On what sort of machine, with how
much memory?

> Follows an interesting part of "diff -u 2614-vanilla.vmstat 2614-akpm.vmstat"
> (they were not retrieve at the exact same point in the benchmark run, but 
> that should not matter much):
> 
> -slabs_scanned 37632
> -kswapd_steal 731859
> -kswapd_inodesteal 1363
> -pageoutrun 26573
> -allocstall 636
> -pgrotated 1898
> +slabs_scanned 2688
> +kswapd_steal 502946
> +kswapd_inodesteal 1
> +pageoutrun 10612
> +allocstall 90
> +pgrotated 68
>
> Note how direct reclaim (and slabs_scanned) are hugely affected. 

hm.  allocstall is much lower and pgrotated has improved and direct reclaim
has improved.  All of which would indicate that kswapd is doing more work. 
Yet kswapd reclaimed less pages.  It's hard to say what's going on as these
numbers came from different stages of the test.

> 
> Normal: 114688kB
> DMA: 16384kB
> 
> Normal/DMA ratio = 114688 / 16384 = 7.000
>
> pgscan_kswapd Normal/DMA = (450483 / 88869) = 5.069
> pgscan_direct Normal/DMA = (23826 / 4224) = 5.640
> pgscan Normal/DMA = (474309 / 88869) = 5.337
> pgscan_kswapd Normal/DMA = (441936 / 80520) = 5.488
> pgscan_direct Normal/DMA = (7392/1188) = 6.222
> pgscan Normal/DMA = (449328 / 81708) = 5.499
> pgalloc_normal_dma_ratio = (559994 / 8488) = 6.597
> pgscan_kswapd Normal/DMA (664883/82845) = 8.025
> pgscan_direct Normal/DMA = (13485/1745) = 7.727
> pgscan Normal/DMA = (678368 / 84590) = 8.019
> pgalloc_normal_dma_ratio = (699927/66313) = 10.554

All of these look close enough to me.  10-20% over- or under-scanning of
the teeny DMA zone doesn't seem very important.  Getting normal-vs-highmem
right is more important.

It's hard to say what effect the watermark thingies have on all of this. 
I'd sugget that you start out with much less complex tests and see if `echo
10000 10000 10000 > /proc/sys/vm/lowmem_reserve_ratio' changes anything. 
(I have that in my rc.local - the thing is a daft waste of memory).

I'd be more concerned about the interactivity thing, although it sounds
like the machine is so overloaded with this test that it'd be fairly
pointless to try to tune that workload first.  It's more important to tune
the system for more typical heavy loads.

Also, the choice of IO scheduler matters.  Which are you using?
