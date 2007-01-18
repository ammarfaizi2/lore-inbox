Return-Path: <linux-kernel-owner+w=401wt.eu-S932112AbXARSfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbXARSfj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 13:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbXARSfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 13:35:39 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:42110 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbXARSfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 13:35:38 -0500
Date: Thu, 18 Jan 2007 21:34:30 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: Possible ways of dealing with OOM conditions.
Message-ID: <20070118183430.GA3345@2ka.mipt.ru>
References: <20070116153315.GB710@2ka.mipt.ru> <1168963695.22935.78.camel@twins> <20070117045426.GA20921@2ka.mipt.ru> <1169024848.22935.109.camel@twins> <20070118104144.GA20925@2ka.mipt.ru> <1169122724.6197.50.camel@twins> <20070118135839.GA7075@2ka.mipt.ru> <1169133052.6197.96.camel@twins> <20070118155003.GA6719@2ka.mipt.ru> <1169141513.6197.115.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1169141513.6197.115.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 18 Jan 2007 21:34:31 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 06:31:53PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:

> > skbs are the most extensively used path.
> > Actually the same is applied to route - dst_entries and rtable are
> > allocated through own wrappers.
> 
> Still, edit all places and perhaps forget one and make sure all new code
> doesn't forget about it, or pick a solution that covers everything.

There is _one_ place for allocation of any kind of object.
skb path has two places.

> > With power-of-two allocation SLAB wastes 500 bytes for each 1500 MTU
> > packet (roughly), it is actaly one ACK packet - and I hear it from
> > person who develops a system, which is aimed to guarantee ACK
> > allocation in OOM :)
> 
> I need full data traffic during OOM, not just a single ACK.

But your code exactly limit codepath to several allocaions, which must
be ACK. You do not have enough reserve to support whole traffic.
So the right solution, IMO, is to _prevent_ such situation, which means
that allocation is not allowed to depend on external conditions like
VFS.

Actually my above sentences were about the case, when anly having
different allocator, it is possible to dramatically change memory usage
model, which supffers greatly from power-of-two allocations. OOM
condition is one of the results which has big SLAB overhead among other
roots. Actually all pathes which work with kmem_cache are safe against
it, since kernel cache packs objects, but thos who uses raw kmalloc has
problems.

> > SLAB overhead is _very_ expensive for network - what if jumbo frame is
> > used? It becomes incredible in that case, although modern NICs allows
> > scatter-gather, which is aimed to fix the problem.
> 
> Jumbo frames are fine if the hardware can do SG-DMA..

Notice word _IF_ in you sentence. e1000 for example can not (or it can,
but driver is not developed for such scenario).

> > Cache misses for small packet flow due to the fact, that the same data
> > is allocated and freed  and accessed on different CPUs will become an
> > issue soon, not right now, since two-four core CPUs are not yet to be
> > very popular and price for the cache miss is not _that_ high.
> 
> SGI does networking too, right?

Yep, Cristoph Lameter developed own allocator too.

I agreee with you, that if that price is too high already, then it is a
dditional sign to look into network tree allocator (yep, name is bad)
again.

> > That is wrong definition just because no one developed different system.
> > Defragmentation is a result of broken system.
> > 
> > Existing design _does_not_ allow to have the situation when whole page
> > belongs to the same cache after it was actively used, the same is
> > applied to the situation when several pages, which create contiguous
> > region, are used by different users, so people start develop VM tricks
> > to move pages around so they would be placed near in address space.
> > 
> > Do not fix the result, fix the reason.
> 
> *plonk* 30+yrs of research ignored.

30 years to develop SLAB allocator? In what universe that is all about?

> > > > The whole pool of pages becomes reserve, since no one (and mainly VFS)
> > > > can consume that reserve.
> > > 
> > > Ah, but there you violate my requirement, any network allocation can
> > > claim the last bit of memory. The whole idea was that the reserve is
> > > explicitly managed.
> > > 
> > > It not only needs protection from other users but also from itself.
> > 
> > Specifying some users as good and others as bad generally tends to very
> > bad behaviour. Your appwoach only covers some users, mine does not
> > differentiate between users,
> 
> The kernel is special, right? It has priority over whatever user-land
> does.

Kernel only does ACK generation and allocation for userspace.
Kernel does not know that some of users are potentially good or bad, and
if you will export this socket option to the userspace, everyone will
think that his application is good enough to use reserve.

So, for kernel-only side you just need to preallocate pool of packets
and use them when system is in OOM (reclaim). For the long direction,
new approach of memory allocaiton should be developed, and there are
different works in that direction - NTA is one of them and not the only
one, for the best resutlts it must be combined with vm-tricks
defragmentation too.

> >  but prevents system from such situation at all.
> 
> I'm not seeing that, with your approach nobody stops the kernel from
> filling up the memory with user-space network traffic.
> 
> swapping is not some random user process, its a fundamental kernel task,
> if this fails the machine is history.

You completely misses the point. The main goal is to
1. reduce fragmentation and/or enable self defragmentation (which is
done in NTA), this also reduces memory usage.
2. perform correct recover steps in OOM - reduce memory usage, use
different allocator and/or reserve (which is the case, where NTA can be
used)
3. do not allow OOM condition - unfortunately it is not always possible,
but having separated allocation allows to not depend on external
conditions such as VFS memory usage, thus this approach reduces
condition when memory deadlock related to network path can happen.

Let me briefly describe your approach and possible drawbacks in it.
You start reserving some memory when systems is under memory pressure.
when system is in real trouble, you start using that reserve for special
tasks mainly for network path to allocate packets and process them in
order to get committed some memory swapping.

So, the problems I see here, are following:
1. it is possible that when you are starting to create a reserve, there
will not be enough memeory at all. So the solution is to reserve in
advance.
2. You differentiate by hand between critical and non-critical
allocations by specifying some kernel users as potentially possible to
allocate from reserve. This does not prevent from NVIDIA module to
allocate from that reserve too, does it? And you artificially limit
system to process only tiny bits of what it must do, thus potentially
leaking pathes which must use reserve too.

So, solution is to have a reserve in advance, and manage it using
special path when system is in OOM. So you will have network memory
reserve, which will be used when system is in trouble. It is very
similar to what you had.

But the whole reserve can never be used at all, so it should be used,
but not by those who can create OOM condition, thus it should be
exported to, for example, network only, and when system is in trouble,
network would be still functional (although only critical pathes).

Even further development of such idea is to prevent such OOM condition
at all - by starting swapping early (but wisely) and reduce memory
usage.

Network tree allocator does exactly above cases.
Here advertisement is over.

-- 
	Evgeniy Polyakov
