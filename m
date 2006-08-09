Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWHITao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWHITao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWHITao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:30:44 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56000 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751258AbWHITan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:30:43 -0400
Date: Wed, 9 Aug 2006 23:29:45 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060809192945.GB2102@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155130353.12225.53.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 09 Aug 2006 23:29:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 03:32:33PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > > >    http://lwn.net/Articles/144273/
> > > > >    "Kernel Summit 2005: Convergence of network and storage paths"
> > > > > 
> > > > > We believe that an approach very much like today's patch set is
> > > > > necessary for NBD, iSCSI, AoE or the like ever to work reliably. 
> > > > > We further believe that a properly working version of at least one of
> > > > > these subsystems is critical to the viability of Linux as a modern
> > > > > storage platform.
> > > > 
> > > > There is another approach for that - do not use slab allocator for
> > > > network dataflow at all. It automatically has all you pros amd if
> > > > implemented correctly can have a lot of additional usefull and
> > > > high-performance features like full zero-copy and total fragmentation
> > > > avoidance.
> > > 
> > > On your site where you explain the Network Tree Allocator:
> > > 
> > >  http://tservice.net.ru/~s0mbre/blog/devel/networking/nta/index.html
> > > 
> > > You only test the fragmentation scenario with the full scale of sizes.
> > > Fragmentation will look different if you use a limited number of sizes
> > > that share no factors (other than the block size); try 19, 37 and 79 
> > > blocks with 1:1:1 ratio.
>      ^^^^^^
> 
> > 19, 37 and 79 will be rounded by SLAB to 32, 64 and 128 bytes, with NTA it 
> > will be 32, 64 and 96 bytes. NTA wins in each allocation which is not
> > power-of-two (I use 32 bytes alignemnt, as the smallest one which SLAB
> > uses). And as you saw in the blog, network tree allocator is faster
> > than SLAB one, although it can have different side effects which are not
> > yet 100% discovered.
> 
> So that would end up being 19*32 = 608 bytes, etc..
> As for speed, sure.

NTA aligns data to 32bytes, SLAB to power of two, so overhead becomes
extremely large for unaligned access for almost every sizes.

> > > Also, I have yet to see how you will do full zero-copy receives; full 
> > > zero-copy would mean getting the data from driver DMA to user-space
> > > without
> > > a single copy. The to user-space part almost requires that each packet
> > > live
> > > on its own page.
> > 
> > Each page can easily have several packets inside.
> 
> For sure, the problem is: do you know for which user-space process a
> packet
> is going to be before you receive it?

That is not a problem for sniffer, if some process wants that data it
can be copied, it can be checked if neighbour packet is for the same
socket and do not copy in that case - there are a lot of things which
can be done, when data _is_ in place. NTA allows zero-copy access to
the whole network traffic, how system is going to work with it is
another task.

> > > As for the VM deadlock avoidance; I see no zero overhead allocation path
> > > - you do not want to deadlock your allocator. I see no critical resource 
> > > isolation (our SOCK_MEMALLOC). Without these things your allocator might
> > > improve the status quo but it will not aid in avoiding the deadlock we
> > > try to tackle here.
> > 
> > Because such reservation is not needed at all.
> > SLAB OOM can be handled by reserving pool using SOCK_MEMALLOC and
> > similar hacks, and different allocator, which obviously work with own
> > pool of pages, can not suffer from SLAB problems.
> > 
> > You say "critical resource isolation", but it is not the case - consider
> > NFS over UDP - remote side will not stop sending just because receiving 
> > socket code drops data due to OOM, or IPsec or compression, which can
> > requires reallocation. There is no "critical resource isolation", since
> > reserved pool _must_ be used by everyone in the kernel network stack.
> 
> The idea is to drop all !NFS packets (or even more specific only keep
> those
> NFS packets that belong to the critical mount), and everybody doing
> critical
> IO over layered networks like IPSec or other tunnel constructs asks for 
> trouble - Just DON'T do that.

Well, such approach does not scale well - either it must be generic
enough to fully solve the problem, or solve it at least at the most
casees, but when you turn anything off - that is not what is expected
I suppose.

> Dropping these non-essential packets makes sure the reserve memory
> doesn't 
> get stuck in some random blocked user-space process, hence you can make 
> progress.

It still requires to receive and analyze the packet before deciding to
drop it. Different allocator is just next step in idea of reserved pool.

> > And as you saw fragmentation issues are handled very good in NTA, just
> > consider usual packet with data with 1500 MTU - 500 bytes are wasted.
> > If you use jumbo frames... it is posible to end up with 32k allocation
> > for 9k jumbo frame with some hardware.
> 
> Sure, SLAB does suck at some things, and I don't argue that NTA will
> not 
> improve. Its just that 'total fragmentation avoidance' it too strong
> and 
> this deadlock avoidance needs more.

Well, you approach seems to solve the problem.
It's extrapolation ends up in different allocator, which solves the
problem too.
So... Different people - different opinions.

-- 
	Evgeniy Polyakov
