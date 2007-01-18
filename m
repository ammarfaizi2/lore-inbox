Return-Path: <linux-kernel-owner+w=401wt.eu-S1752077AbXARRdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXARRdp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 12:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbXARRdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 12:33:45 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:34875 "EHLO
	amsfep20-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbXARRdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 12:33:44 -0500
Subject: Re: Possible ways of dealing with OOM conditions.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
In-Reply-To: <20070118155003.GA6719@2ka.mipt.ru>
References: <20070116132503.GA23144@2ka.mipt.ru>
	 <1168955274.22935.47.camel@twins> <20070116153315.GB710@2ka.mipt.ru>
	 <1168963695.22935.78.camel@twins> <20070117045426.GA20921@2ka.mipt.ru>
	 <1169024848.22935.109.camel@twins> <20070118104144.GA20925@2ka.mipt.ru>
	 <1169122724.6197.50.camel@twins> <20070118135839.GA7075@2ka.mipt.ru>
	 <1169133052.6197.96.camel@twins>  <20070118155003.GA6719@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 18:31:53 +0100
Message-Id: <1169141513.6197.115.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 18:50 +0300, Evgeniy Polyakov wrote:
> On Thu, Jan 18, 2007 at 04:10:52PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > On Thu, 2007-01-18 at 16:58 +0300, Evgeniy Polyakov wrote:
> > 
> > > Network is special in this regard, since it only has one allocation path
> > > (actually it has one cache for skb, and usual kmalloc, but they are
> > > called from only two functions).
> > > 
> > > So it would become 
> > > ptr = network_alloc();
> > > and network_alloc() would be usual kmalloc or call for own allocator in
> > > case of deadlock.
> > 
> > There is more to networking that skbs only, what about route cache,
> > there is quite a lot of allocs in this fib_* stuff, IGMP etc...
> 
> skbs are the most extensively used path.
> Actually the same is applied to route - dst_entries and rtable are
> allocated through own wrappers.

Still, edit all places and perhaps forget one and make sure all new code
doesn't forget about it, or pick a solution that covers everything.

> With power-of-two allocation SLAB wastes 500 bytes for each 1500 MTU
> packet (roughly), it is actaly one ACK packet - and I hear it from
> person who develops a system, which is aimed to guarantee ACK
> allocation in OOM :)

I need full data traffic during OOM, not just a single ACK.

> SLAB overhead is _very_ expensive for network - what if jumbo frame is
> used? It becomes incredible in that case, although modern NICs allows
> scatter-gather, which is aimed to fix the problem.

Jumbo frames are fine if the hardware can do SG-DMA..

> Cache misses for small packet flow due to the fact, that the same data
> is allocated and freed  and accessed on different CPUs will become an
> issue soon, not right now, since two-four core CPUs are not yet to be
> very popular and price for the cache miss is not _that_ high.

SGI does networking too, right?

> > > > > performs self-defragmentation of the memeory, 
> > > > 
> > > > Does it move memory about? 
> > > 
> > > It works in a page, not as pages - when neighbour regions are freed,
> > > they are combined into single one with bigger size
> > 
> > Yeah, that is not defragmentation, defragmentation is moving active
> > regions about to create contiguous free space. What you do is free space
> > coalescence.
> 
> That is wrong definition just because no one developed different system.
> Defragmentation is a result of broken system.
> 
> Existing design _does_not_ allow to have the situation when whole page
> belongs to the same cache after it was actively used, the same is
> applied to the situation when several pages, which create contiguous
> region, are used by different users, so people start develop VM tricks
> to move pages around so they would be placed near in address space.
> 
> Do not fix the result, fix the reason.

*plonk* 30+yrs of research ignored.

> > > The whole pool of pages becomes reserve, since no one (and mainly VFS)
> > > can consume that reserve.
> > 
> > Ah, but there you violate my requirement, any network allocation can
> > claim the last bit of memory. The whole idea was that the reserve is
> > explicitly managed.
> > 
> > It not only needs protection from other users but also from itself.
> 
> Specifying some users as good and others as bad generally tends to very
> bad behaviour. Your appwoach only covers some users, mine does not
> differentiate between users,

The kernel is special, right? It has priority over whatever user-land
does.

>  but prevents system from such situation at all.

I'm not seeing that, with your approach nobody stops the kernel from
filling up the memory with user-space network traffic.

swapping is not some random user process, its a fundamental kernel task,
if this fails the machine is history.

