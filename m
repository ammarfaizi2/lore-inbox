Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbVKBLha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbVKBLha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVKBLha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:37:30 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:18081 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932648AbVKBLh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:37:29 -0500
Date: Wed, 2 Nov 2005 11:37:26 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Joel Schopp <jschopp@austin.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <43681100.1000603@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0511021125170.5235@skynet>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au>
 <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]>
 <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet>
 <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com>
 <43681100.1000603@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Nick Piggin wrote:

> Joel Schopp wrote:
>
> > The patches do ad a reasonable amount of complexity to the page allocator.
> > In my opinion that is the only downside of these patches, even though it is
> > a big one.  What we need to decide as a community is if there is a less
> > complex way to do this, and if there isn't a less complex way then is the
> > benefit worth the increased complexity.
> >
> > As to the non-zero performance cost, I think hard numbers should carry more
> > weight than they have been given in this area.  Mel has posted hard numbers
> > that say the patches are a wash with respect to performance.  I don't see
> > any evidence to contradict those results.
> >
>
> The numbers I have seen show that performance is decreased. People
> like Ken Chen spend months trying to find a 0.05% improvement in
> performance.

Fine, that is understandable. The AIM9 benchmarks also show performance
improvements in other areas like fork_test. About a 5% difference which is
also important for kernel builds. Wider testing would be needed to see if
the improvements are specific to my tests or not. Every set of patches
have had a performance regression test run with Aim9 so I certainly have
not been ignoring perforkmance.

> Not long ago I just spent days getting our cached
> kbuild performance back to where 2.4 is on my build system.
>

Then it would be interesting to find out how 2.6.14-rc5-mm1 compares
against 2.6.14-rc5-mm1-mbuddy-v19?

> I can simply see they will cost more icache, more dcache, more branches,
> etc. in what is the hottest part of the kernel in some workloads (kernel
> compiles, for one).
>
> I'm sorry if I sound like a wet blanket. I just don't look at a patch
> and think "wow all those 3 guys with Linux on IBM mainframes and using
> lpars are going to be so much happier now, this is something we need".
>

I developed this as the beginning of a long term solution for on-demand
HugeTLB pages as part of a PhD.  This could potentially help desktop
workloads in the future. Hotplug machines are a benefit that was picked up
by the work on the way. We can help hotplug to some extent today and
desktop users in the future (and given time, all of the hotplug problems
as well). But if we tell desktop users "Yeah, your applications will run a
bit better with HugeTLB pages as long as you configure the size of the
zone correctly" at any stage, we'll be told where to go.

> > > > The will need high order allocations if we want to provide HugeTLB pages
> > > > to userspace on-demand rather than reserving at boot-time. This is a
> > > > future problem, but it's one that is not worth tackling until the
> > > > fragmentation problem is fixed first.
> > > >
> > >
> > > Sure. In what form, we haven't agreed. I vote zones! :)
> >
> >
> > I'd like to hear more details of how zones would be less complex while still
> > solving the problem.  I just don't get it.
> >
>
> You have an extra zone. You size that zone at boot according to the
> amount of memory you need to be able to free. Only easy-reclaim stuff
> goes in that zone.
>

Helps hotplug, no one else. Rules out HugeTLB on demand for userspace
unless we are willing to tell desktop users to configure this tunable.

> It is less complex because zones are a complexity we already have to
> live with. 99% of the infrastructure is already there to do this.
>

The simplicity of zones is still in dispute. I am putting together a mail
of pros, cons, situations and future work for both approaches. I hope to
sent it out fairly soon.

> If you want to hot unplug memory or guarantee hugepage allocation,
> this is the way to do it. Nobody has told me why this *doesn't* work.
>

Hot unplug the configured zone of memory and guarantee hugepage allocation
only for userspace. There is no help for kernel allocations to steal a
huge page under any circumstance. Our approach allows the kernel to get
the large page at the cost of fragmentation degrading slowly over time. To
stop it fragmenting slowly over time, more work is needed.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
