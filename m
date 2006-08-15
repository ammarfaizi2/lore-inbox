Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965375AbWHOOPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965375AbWHOOPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965374AbWHOOPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:15:33 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:32681 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965372AbWHOOPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:15:32 -0400
Date: Tue, 15 Aug 2006 18:15:01 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060815141501.GA10998@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <1155558313.5696.167.camel@twins> <20060814123530.GA5019@2ka.mipt.ru> <1155639302.5696.210.camel@twins> <20060815112617.GB21736@2ka.mipt.ru> <1155643405.5696.236.camel@twins> <20060815123438.GA29896@2ka.mipt.ru> <1155649768.5696.262.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155649768.5696.262.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 15 Aug 2006 18:15:06 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 03:49:28PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> On Tue, 2006-08-15 at 16:34 +0400, Evgeniy Polyakov wrote:
> > On Tue, Aug 15, 2006 at 02:03:25PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > On Tue, 2006-08-15 at 15:26 +0400, Evgeniy Polyakov wrote:
> > > > On Tue, Aug 15, 2006 at 12:55:02PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > > > > Userspace can sak for next packet and pointer to the new location will
> > > > > > be removed.
> > > > > 
> > > > > /sak/ask/?
> > > > > 
> > > > > I'm not understanding, if you have a page A with two packets, a and b;
> > > > > once you map that page into user-space that process has access to both
> > > > > packets, which is a security problem. How are you going to solve this?
> > > > 
> > > > Yep, there is such issue.
> > > > But no one is ever going to replace socket code with zero-copy
> > > > interfaces - Linux has backward compatibility noone ever had, so
> > > > send()/recv() will be there.
> > > 
> > > The new AIO network API should be able to provide the needed userspace
> > > changes.
> > 
> > Kevent based network AIO already handle it.
> > This changes are different.
> 
> You said you couldn't do zero-copy because the userspace interface
> didn't allow it.
> I assume the network AIO interface does, but still you have your initial
> allocation problem, one cannot put more than 1 packet on each page.

Kevent network AIO is completely different from network tree allocator.

> > > > TCP has 768kb limit on my amd64 with 1gb of ram, so I expect allocator
> > > > can handle all requests.
> > > 
> > > But the capacity of the network stack is larger than this (arbitrary)
> > > limit. It is possible to have all 768kb worth of packets stuck on
> > > blocked sockets.
> > 
> > And so what? 
> 
> Well, if all packets are stuck, you have a dead system.

Do you remember what we are talking about?
About network tree allocator, it does not know how and where packets are
processed, it only provides a memory. 
It was shown several times that with appropriate reserve it is possible
to satisfy all system network requests, even if system is in OOM
conditions.

> > You said, that separated from main allocator can not handle
> > all memory requests being done by the stack, as you can see it easily
> > can.
> 
> It could if you can provide adequate detection of memory pressure and
> fallback to a degraded mode within the same allocator/stack and can
> guarantee limited service to critical parts.

It is not needed, since network allocations are separated from main
system ones.
I think I need to show an example here.

Let's main system works only with TCP for simplicity.
Let's maximum allowed memory is limited by 1mb (it is 768k on machine
with 1gb of ram).

So network allocator reserves above megabyte and works with it in a
smart way (without too much overhead).
Then system goes into OOM and requires to swap a page, which
notification was sent to remote swap storage.
Swap storage then sends an ack for that data, since network allocations
are separated from main system ones, network allocator easily gets 60
(or 4k, since it has a reserve, which exeeds maximum allowed TCP memory
limit) bytes for ack and process than notification thus "freeing" acked
data and main system can work with that free memory.
No need to detect OOM or something other - it just works.

I expect you will give me an example, when all above megabyte is going
to be stuck somewhere.
But... If it is not acked, each new packet goes slow path since VJ header 
prediction fails and falls into memory limit check which will drop that
packet immediately without event trying to select a socket.

> > > > And there is a simple task in TODO list to dynamically grow cache when
> > > > threshold of memory is in use. It is really simple task and will be
> > > > implemented as soon as I complete suggestions mentioned by Andrew Morton.
> > > 
> > > Growing will not help, the problem is you are out of memory, you cannot
> > > grow at that point.
> > 
> > You do not see the point of network tree allocator.
> > 
> > It can live with main system OOM since it has preallocated separate
> > pool, which can be increased when there is a requirement for that, for
> > example when system is not in OOM.
> 
> It cannot increase enough, ever. The total capacity of the network stack
> is huge.
> And the sole problem I'm addressing is getting the system to work
> reliably in tight memory situations, that is during reclaim; one cannot
> decide to grow then, nor postpone, too late.

Network *is* limited, it is not terabyte array which is going to be
placed into VFS cache.

> > > skbuff_head_cache and skbuff_fclone_cache are SLABs.
> > 
> > It is quite small part of the stack, isn't it?
> > And btw, they still suffer from SLAB design, since it is possibly to get
> > another smaller object right after all skbs are allocated from given page.
> > It is a minor thing of course, but nevertheless worh mentioning.
> 
> Small but crucial, that is why I've been replacing all.

Sigh, replace kmem_cache_alloc() with avl_alloc() - it does not matter.

> > > Yes SLAB is a horrid thing on some points but very good at a lot of
> > > other things. But surely there are frequently used sizes, kmalloc will
> > > not know, but a developer with profiling tools might.
> > 
> > Does not scale - admin must run system under profiling, add new
> > entries into kmalloc_sizes.h recompile the kernel... No way.
> 
> s/admin/developer/
> It has been the way so far.

Could you say what are preferred sizes in my testing machines here? :)
For example MMIO-read based chips (excellent realtek 8139 adapter) can
allocate not only 1500 bytes of memory, but real size of received frame.
I even used it for receiving zero-copy (really excellent hardware
for it's price) into VFS cache implementation (without any kind of
page-per-packet stuff), but it is not related to our discussion.

> > Plese check e1000_alloc_rx_buffers() function and rx_buffer_len value.
> > You are wrong.
> 
> e1000_alloc_rx_buffers_ps()
> 
> but it does not take away that any card/driver that does depend on
> higher order allocations is unreliable.

Have you seen how many adapters support packet split?

-- 
	Evgeniy Polyakov
