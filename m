Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbVLOFKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbVLOFKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVLOFKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:10:21 -0500
Received: from waste.org ([64.81.244.121]:6279 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S965151AbVLOFKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:10:19 -0500
Date: Wed, 14 Dec 2005 21:02:50 -0800
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: sri@us.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051215050250.GT8637@waste.org>
References: <20051214092228.GC18862@brahms.suse.de> <1134582945.8698.17.camel@w-sridhar2.beaverton.ibm.com> <20051215033937.GC11856@waste.org> <20051214.203023.129054759.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214.203023.129054759.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 08:30:23PM -0800, David S. Miller wrote:
> From: Matt Mackall <mpm@selenic.com>
> Date: Wed, 14 Dec 2005 19:39:37 -0800
> 
> > I think we need a global receive pool and per-socket send pools.
> 
> Mind telling everyone how you plan to make use of the global receive
> pool when the allocation happens in the device driver and we have no
> idea which socket the packet is destined for?  What should be done for
> non-local packets being routed?  The device drivers allocate packets
> for the entire system, long before we know who the eventually received
> packets are for.  It is fully anonymous memory, and it's easy to
> design cases where the whole pool can be eaten up by non-local
> forwarded packets.

There needs to be two rules:

iff global memory critical flag is set
- allocate from the global critical receive pool on receive
- return packet to global pool if not destined for a socket with an
  attached send mempool

I think this will provide the desired behavior, though only
probabilistically. That is, we can fill the global receive pool with
uninteresting packets such that we're forced to drop critical ACKs,
but the boring packets will eventually be discarded as we walk up the
stack and we'll eventually have room to receive retried ACKs.

> I truly dislike these patches being discussed because they are a
> complete hack, and admittedly don't even solve the problem fully.  I
> don't have any concrete better ideas but that doesn't mean this stuff
> should go into the tree.

Agreed. I'm fairly convinced a full fix is doable, if you make a
couple assumptions (limited fragmentation), but will unavoidably be
less than pretty as it needs to cross some layers.

> I think GFP_ATOMIC memory pools are more powerful than they are given
> credit for.  There is nothing preventing the implementation of dynamic
> GFP_ATOMIC watermarks, and having "critical" socket behavior "kick in"
> in response to hitting those water marks.

There are two problems with GFP_ATOMIC. The first is that its users
don't pre-state their worst-case usage, which means sizing the pool to
reliably avoid deadlocks is impossible. The second is that there
aren't any guarantees that GFP_ATOMIC allocations are actually
critical in the needed-to-make-forward-VM-progress sense or will be
returned to the pool in a timely fashion.

So I do think we need a distinct pool if we want to tackle this
problem. Though it's probably worth mentioning that Linus was rather
adamantly against even trying at KS.

-- 
Mathematics is the supreme nostalgia of our time.
