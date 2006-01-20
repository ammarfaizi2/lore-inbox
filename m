Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWATMFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWATMFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWATMFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:05:03 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:21125 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750873AbWATMFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:05:01 -0500
Date: Fri, 20 Jan 2006 12:03:53 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/5] Reducing fragmentation using zones
In-Reply-To: <43D03A48.8090105@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0601201154320.14292@skynet>
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
 <43CFE77B.3090708@austin.ibm.com> <Pine.LNX.4.58.0601200011190.15823@skynet>
 <43D03A48.8090105@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, KAMEZAWA Hiroyuki wrote:

> Mel Gorman wrote:
> > To satisfy this request, I did a quick rebase of the list-based approach
> > against 2.6.16-rc1-mm1 to have a comparable set of benchmarks. I will post
> > the patches in the morning after a re-read.
> >
> Thank you.
>
>
> > So, in terms of performance on this set of tests, both approachs perform
> > roughly the same as the stock kernel in terms of absolute performance. In
> > terms of high-order allocations, zone-based appears to do better under
> > load. However, if you look at the zones that are used, you will see that
> > zone-based appears to do as well as list-based *only* because it has the
> > EASYRCLM zone to play with. list-based was way better at keeping the
> > normal zone defragmented as well as highmem which is especially obvious
> > when tested at rest.  list-based was able to allocate 83 huge pages from
> > ZONE_NORMAL at rest while zone-based only managed 8.
> >
> yes, this is intersiting point :)
> list-based one can defrag NORMAL zone.
> The point will be "does we need to defrag NORMAL ?" , I think.

The original intention was two fold. One, it helps HugeTLB in situations
where it was not configured correctly at boot-time. this is the case for a
number of sites running HPC-related jobs. The second objective was to help
high-order kernel allocations to potentially reduce things like
scatter-gather IO.

> IMHO, I don't like to use NORMAL zone to alloc higher-order pages...
>

Neither do a lot of people apparently.

> > Secondly, zone-based requires careful configuration to be successful.  If
> > booted with kernelcore=896MB for example, it only performs slightly better
> > than the standard kernel. If booted with kernelcore=1024MB, it tends to
> > perform slightly worse (more zone fallbacks I guess) and still only
> > manages slighly better satisfaction of high order pages.
> This is because HIGHMEM is too small, right ?
>

Yes and it ends up falling back more to ZONE_NORMAL.

>
> > On the flip side, zone-based code changes are easier to understand than
> > the list-based ones (at least in terms of volume of code changes). The
> > zone-based gives guarantees on what will happen in the future while
> > list-based is best-effort.
> >
> > In terms of fragmentation, I still think that list-based is better overall
> > without configuration.
> I agree here.
>
> > The results above also represent the best possible
> > configuration with zone-based versus no configuration at all against
> > list-based. In an environment with changing workloads a constant reality,
> > I bet that list-based would win overall.
> >
> On x86, NORMAL is only 896M anyway. there is no discussion.
>

There is a discussion with architecutes like ppc64 which do not have a
normal zone (only ZONE_DMA) and 64 bit architectures that have very large
normal zones.

Take ppc64 as an example. Today, when memory is hot-added, it is available
for use by the kernel and userspace applications. Right now, hot-added
memory goes to ZONE_DMA but it should be going to ZONE_EASYRCLM. In this
case, the size of the kernel at the beginning is fixed. If you allow the
kernel zone to grow, it cannot be shrunk again and worse, if the kernel
expands to take up available memory, it loses all advantages.

>
> Honestly, I don't have enough experience with machines which doesn't
> have Highmem. How large kernelcore should be ? It looks using list-based
> and zone-based at the same time will make all people happy...
>

How large kernelcore should be is the million dollar question. The
administrator needs to know how much memory the kernel will require for
the workload. That is no universal answer to this question. That was one
reason we liked the list-based approach to anti-fragmentation. It could
grow or shrink the regions used by user and kernel allocations as
required. To do the same with zones is quite complex.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
