Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWHRHT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWHRHT0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWHRHTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:19:25 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:23517 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750890AbWHRHTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:19:24 -0400
Date: Fri, 18 Aug 2006 11:16:06 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Daniel Phillips <phillips@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060818071606.GB23264@2ka.mipt.ru>
References: <1155189988.12225.100.camel@twins> <44DF888F.1010601@google.com> <20060814051323.GA1335@2ka.mipt.ru> <44E3F525.3060303@google.com> <20060817053636.GA30920@2ka.mipt.ru> <44E4AF10.5030308@google.com> <20060817184206.GA2873@2ka.mipt.ru> <1155842114.5696.310.camel@twins> <20060817194850.GA19647@2ka.mipt.ru> <44E4FAAA.2050104@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44E4FAAA.2050104@google.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 18 Aug 2006 11:18:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 04:24:26PM -0700, Daniel Phillips (phillips@google.com) wrote:
> >Feel free to implement any receiving policy inside _separated_ allocator
> >to meet your needs, but if allocator depends on main system's memory
> >conditions it is always possible that it will fail to make forward
> >progress.
> 
> Wrong.  Our main allocator has a special reserve that can be accessed
> only by a task that has its PF_MEMALLOC flag set.  This reserve exists
> in order to guarantee forward progress in just such situations as the
> network runs into when it is trying to receive responses from a remote
> disk.  Anything otherwise is a bug.

Ok, I see your point.
You create special fix for special config situation.
In general it does not work.

> >>>I do not argue that your approach is bad or does not solve the problem,
> >>>I'm just trying to show that further evolution of that idea eventually
> >>>ends up in separated allocator (as long as all most robust systems
> >>>separate operations), which can improve things in a lot of other sides
> >>>too.
> >>
> >>Not a separate allocator per-se, separate socket group, they are
> >>serviced by the kernel, they will never refuse to process data, and it
> >>is critical for the continued well-being of your kernel that they get
> >>their data.
> 
> The memalloc reserve is indeed a separate reserve, however it is a
> reserve that already exists, and you are busy creating another separate
> reserve to further partition memory.  Partitioning memory is not the
> direction we should be going, we should be trying to unify our reserves
> wherever possible, and find ways such as Andrew and others propose to
> implement "reserve on demand", or in other words, take advantage of
> "easily freeable" pages.

Such approach does not fix the problem.
Why no one complain that there is priveledge separation while "we can
fix all existing application"?
It is possible that there will not be any "easily freeable" pages, and
your special reserve will not be filled.

> If your allocation code is so much more efficient than slab then why
> don't you fix slab instead of replicating functionality that already
> exists elsewhere in the system, and has since day one?

No one need an exuse to rewrite something.

> >You do not know in advance which sockets must be separated (since only
> >in the simplest situation it is the same as in NBD and is
> >kernelspace-only),
> 
> Yes we do, they are exactly those sockets that lie in the block IO path.
> The VM cannot deadlock on any others.

There are some pieces of the world behind NBD and iSCSI.

> >you can not solve problem with ARP/ICMP/route changes and other control
> >messages, netfilter, IPsec and compression which still can happen in your 
> >setup, 
> 
> If you bothered to read the patches you would know that ICMP is indeed
> handled.  ARP I don't think so, we may need to do that since ARP can
> believably be required for remote disk interface failover.  Anybody
> who designs ssh into remote disk failover is an idiot.  Ssh for
> configuration, monitoring and administration is fine.  Ssh for fencing
> or whatever is just plain stupid, unless the nodes running both server
> and client are not allowed to mount the remote disk.

I only remember that socket with sk_memalloc is being handled, no ICMP,
no ARP. What about other control messages in bonding setup of failover?

> >if something goes wrong and receiving will require additional
> >allocation from network datapath, system is dead,
> >this strict conditions does not allow flexible control over possible
> >connections and does not allow to create additional connections.
> 
> You know that how?
> 
> >>Also, I do not think people would like it if say 100M of their 1G system
> >>just disappears, never to used again for eg. page-cache in periods of
> >>low network traffic.
> >
> >Just for clarification: network tree allocator gets 512kb and then
> >increases cache size when it is required. Default value can be changed
> >of course.
> 
> Great.  Now why does the network layer need its own, invented-in-netland
> allocator?  Why can't everybody use your allocator if it is better?

As far as I recall, I several times already said, that there is no
problem to use that allocator in any other places, MMU-less systems will
especially greatly benefit from it (since it was designed for them too).

> Also, please don't get the idea that your allocator by itself solves the
> block IO receive starvation problem.  At the very least you need to do
> something about network traffic that is unrelated to forward progress of
> memory writeout, yet can starve the memory writeout.  Oh wait, our patch
> set already does that.

It is not my allocator that solves the problem, but a situation when
pools are separated! 
And you slowly go that direction too (global reserve instead of per-socket 
is the first step).

Problem is not solved, when critical allocations depend on reserve which
depends on main system conditions.

> Regards,
> 
> Daniel

-- 
	Evgeniy Polyakov
