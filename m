Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWHINIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWHINIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWHINIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:08:32 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:7315 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750753AbWHINIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:08:31 -0400
Date: Wed, 9 Aug 2006 17:07:52 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060809130752.GA17953@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155127040.12225.25.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 09 Aug 2006 17:07:53 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 02:37:20PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> On Wed, 2006-08-09 at 09:46 +0400, Evgeniy Polyakov wrote:
> > On Tue, Aug 08, 2006 at 09:33:25PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > >    http://lwn.net/Articles/144273/
> > >    "Kernel Summit 2005: Convergence of network and storage paths"
> > > 
> > > We believe that an approach very much like today's patch set is
> > > necessary for NBD, iSCSI, AoE or the like ever to work reliably. 
> > > We further believe that a properly working version of at least one of
> > > these subsystems is critical to the viability of Linux as a modern
> > > storage platform.
> > 
> > There is another approach for that - do not use slab allocator for
> > network dataflow at all. It automatically has all you pros amd if
> > implemented correctly can have a lot of additional usefull and
> > high-performance features like full zero-copy and total fragmentation
> > avoidance.
> 
> On your site where you explain the Network Tree Allocator:
> 
>  http://tservice.net.ru/~s0mbre/blog/devel/networking/nta/index.html
> 
> You only test the fragmentation scenario with the full scale of sizes.
> Fragmentation will look different if you use a limited number of sizes
> that share no factors (other than the block size); try 19, 37 and 79 
> blocks with 1:1:1 ratio.

19, 37 and 79 will be rounded by SLAB to 32, 64 and 128 bytes, with NTA it 
will be 32, 64 and 96 bytes. NTA wins in each allocation which is not
power-of-two (I use 32 bytes alignemnt, as the smallest one which SLAB
uses). And as you saw in the blog, network tree allocator is faster
than SLAB one, although it can have different side effects which are not
yet 100% discovered.

> Also, I have yet to see how you will do full zero-copy receives; full 
> zero-copy would mean getting the data from driver DMA to user-space
> without
> a single copy. The to user-space part almost requires that each packet
> live
> on its own page.

Each page can easily have several packets inside.

> As for the VM deadlock avoidance; I see no zero overhead allocation path
> - you do not want to deadlock your allocator. I see no critical resource 
> isolation (our SOCK_MEMALLOC). Without these things your allocator might
> improve the status quo but it will not aid in avoiding the deadlock we
> try to tackle here.

Because such reservation is not needed at all.
SLAB OOM can be handled by reserving pool using SOCK_MEMALLOC and
similar hacks, and different allocator, which obviously work with own
pool of pages, can not suffer from SLAB problems.

You say "critical resource isolation", but it is not the case - consider
NFS over UDP - remote side will not stop sending just because receiving 
socket code drops data due to OOM, or IPsec or compression, which can
requires reallocation. There is no "critical resource isolation", since
reserved pool _must_ be used by everyone in the kernel network stack.

And as you saw fragmentation issues are handled very good in NTA, just
consider usual packet with data with 1500 MTU - 500 bytes are wasted.
If you use jumbo frames... it is posible to end up with 32k allocation
for 9k jumbo frame with some hardware.

-- 
	Evgeniy Polyakov
