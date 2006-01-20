Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWATODn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWATODn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWATODn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:03:43 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:24209 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750990AbWATODm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:03:42 -0500
Date: Fri, 20 Jan 2006 14:02:13 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/5] Reducing fragmentation using zones
In-Reply-To: <20060120213210.126B.Y-GOTO@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0601201357450.14292@skynet>
References: <43D03A48.8090105@jp.fujitsu.com> <Pine.LNX.4.58.0601201154320.14292@skynet>
 <20060120213210.126B.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, Yasunori Goto wrote:

> > > > So, in terms of performance on this set of tests, both approachs perform
> > > > roughly the same as the stock kernel in terms of absolute performance. In
> > > > terms of high-order allocations, zone-based appears to do better under
> > > > load. However, if you look at the zones that are used, you will see that
> > > > zone-based appears to do as well as list-based *only* because it has the
> > > > EASYRCLM zone to play with. list-based was way better at keeping the
> > > > normal zone defragmented as well as highmem which is especially obvious
> > > > when tested at rest.  list-based was able to allocate 83 huge pages from
> > > > ZONE_NORMAL at rest while zone-based only managed 8.
> > > >
> > > yes, this is intersiting point :)
> > > list-based one can defrag NORMAL zone.
> > > The point will be "does we need to defrag NORMAL ?" , I think.
> >
> > The original intention was two fold. One, it helps HugeTLB in situations
> > where it was not configured correctly at boot-time. this is the case for a
> > number of sites running HPC-related jobs. The second objective was to help
> > high-order kernel allocations to potentially reduce things like
> > scatter-gather IO.
>
> Probably, Linus-san's wish is reduce high order kernel allocation
> to avoid fragment. (Did he say defragment is meaningless, right?)

Right.

> If there is a driver/kernel component which require high order
> allocation though physical contiguous memory is not necessary,
> it should be modified to collect pieces of pages.

Yes.

> (I guess there is some component like it. But I'm not sure....)
> If the scatter-gather IO is cause of bad performance,
> it might be desirable that trying highorder allocation at first,
> then collect peace of pages which can be allocated.
>

Figures have never been produced to show that high-order allocations would
help performnace for something like scatter/gather IO.

> It is just my guess.
> But, some of components might not be able to do it.
> If there are impossible components, it is good reason for
> defragment....
>
> > > > On the flip side, zone-based code changes are easier to understand than
> > > > the list-based ones (at least in terms of volume of code changes). The
> > > > zone-based gives guarantees on what will happen in the future while
> > > > list-based is best-effort.
> > > >
> > > > In terms of fragmentation, I still think that list-based is better overall
> > > > without configuration.
> > > I agree here.
> > >
> > > > The results above also represent the best possible
> > > > configuration with zone-based versus no configuration at all against
> > > > list-based. In an environment with changing workloads a constant reality,
> > > > I bet that list-based would win overall.
> > > >
> > > On x86, NORMAL is only 896M anyway. there is no discussion.
> > >
> >
> > There is a discussion with architecutes like ppc64 which do not have a
> > normal zone (only ZONE_DMA) and 64 bit architectures that have very large
> > normal zones.
> >
> > Take ppc64 as an example. Today, when memory is hot-added, it is available
> > for use by the kernel and userspace applications. Right now, hot-added
> > memory goes to ZONE_DMA but it should be going to ZONE_EASYRCLM. In this
> > case, the size of the kernel at the beginning is fixed. If you allow the
> > kernel zone to grow, it cannot be shrunk again and worse, if the kernel
> > expands to take up available memory, it loses all advantages.
>
> Just for correction, ZONE_EASYRCLM is useful only hot-remove.
> So, if kernel would like to have more memory, hot-add of ZONE_DMA(If its
> address is in DMA area) Zone_NORMAL should be OK.
> Only the new memory will not be able to be removed.
>

My understanding is that choosing what zone to add memory to is not an
option. The main case where memory is hot-added and hot-removed is to meet
changing demands of the workload. The memory is hot-added and removed by
an automated system which, no matter how well written, will end up adding
memory to the wrong zone some of the time.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
