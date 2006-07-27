Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWG0I6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWG0I6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWG0I6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:58:36 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53125 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1161008AbWG0I6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:58:35 -0400
Date: Thu, 27 Jul 2006 12:58:13 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
Message-ID: <20060727085812.GA24529@2ka.mipt.ru>
References: <20060726062817.GA20636@2ka.mipt.ru> <20060726.231055.121220029.davem@davemloft.net> <20060727074902.GC5490@2ka.mipt.ru> <20060727.010255.87351515.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060727.010255.87351515.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 27 Jul 2006 12:58:17 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:02:55AM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Thu, 27 Jul 2006 11:49:02 +0400
> 
> > I.e. map skb's data to userspace? Not a good idea especially with it's
> > tricky lifetime and unability for userspace to inform kernel when it
> > finished and skb can be freed (without additional syscall).
> 
> Hmmm...
> 
> If it is paged based, I do not see the problem.  Events and calls to
> AIO I/O routines make transfer of buffer ownership.  The fact that
> while kernel (and thus networking stack) "owns" the buffer for an AIO
> call, the user can have a valid mapping to it is a unimportant detail.
> 
> If the user will scramble a piece of data that is in flight to or from
> the network card, it is his problem.
> 
> If we are using a primitive network card that does not support
> scatter-gather I/O and thus not page based SKBs, we will make
> copies.  But this is transparent to the user.
> 
> The idea is that DMA mappings have page granularity.
> 
> At least on transmit it should work well.  Receive side is more
> difficult and initial implementation will need to copy.

And what if several skb->data are placed on the same page?
Or do we want to allocate at least one page for one skb? 
Even if it is an 40 bytes ack?

> > I did it with af_tlb zero-copy sniffer (but I substitute mapped pages
> > with physical skb->data pages), and it was not very good.
> 
> Trying to be too clever with skb->data has always been catastrophic. :)

Yep :)

> > Well, I think preallocate some buffers and use that in AIO setup is a
> > plus, since in that case user does not care about when it is possible to
> > reuse the same buffer - when appropriate kevent is completed, that means
> > that provided buffer is no longer in use by kernel, and user can reuse
> > it.
> 
> We now enter the most interesting topic of AIO buffer pool management
> and where it belongs. :-)  We are assuming up to this point that the
> user manages this stuff with explicit DMA calls for allocation, then
> passes the key based references to those buffers as arguments to the
> AIO I/O calls.
> 
> But I want to suggest another possibility.  What if the kernel managed
> the AIO buffer pool for a task?  It could grow this dynamically based
> upon need.  The only implementation road block is how large to we
> allow this to grow, but I think normal VM mechanisms can take care
> of it.
> 
> On transmit this is not straightforward, but for receive it has really
> nice possibilities. :)

Btw, according to DMA allocations - there are some problems here too.
Some pieces of the world can not dma behind 16mb, and someone can do it
over 4gb. If only 16mb are used, it is just 8k packets with 1500 MTU,
and actually userspace does not know which NIC receives it's data, so it
is impossible in advance to allocate some pool, which will be used for
dma transfer, so we just need to allocate physical pages and use them
with memcpy() from skb->data.

Those physical pages can be managed within kernel and userspace can map
them. But there is another possibility - replace slab allocation for
network devices with allocation from premapped pool.
That naturally allows to manage that pool for AIO needs and have
zero-copy sending and receiving support. That is what I talked in
netchannel topic when question about allocation/freeing cost in atomic
context arised. I work on that solution, which can be used both for
netchannels (and full userspace processing) and usual networking code.

-- 
	Evgeniy Polyakov
