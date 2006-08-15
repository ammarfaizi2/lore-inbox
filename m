Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWHOPF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWHOPF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWHOPF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:05:29 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:59045 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030330AbWHOPF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:05:28 -0400
Date: Tue, 15 Aug 2006 19:05:07 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060815150507.GA9734@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <1155558313.5696.167.camel@twins> <20060814123530.GA5019@2ka.mipt.ru> <1155639302.5696.210.camel@twins> <20060815112617.GB21736@2ka.mipt.ru> <1155643405.5696.236.camel@twins> <20060815123438.GA29896@2ka.mipt.ru> <1155649768.5696.262.camel@twins> <20060815141501.GA10998@2ka.mipt.ru> <1155653339.5696.282.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155653339.5696.282.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 15 Aug 2006 19:05:09 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 04:48:59PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> On Tue, 2006-08-15 at 18:15 +0400, Evgeniy Polyakov wrote:
> 
> > Kevent network AIO is completely different from network tree allocator.
> 
> How can that be? packets still need to be received, yes?

Kevent network AIO uses usual alloc_skb(), naio is called when packet is 
received and checked on IP layer similar to where tcp_v4_do_rcv() is
called.

> > So network allocator reserves above megabyte and works with it in a
> > smart way (without too much overhead).
> > Then system goes into OOM and requires to swap a page, which
> > notification was sent to remote swap storage.
> > Swap storage then sends an ack for that data, since network allocations
> > are separated from main system ones, network allocator easily gets 60
> > (or 4k, since it has a reserve, which exeeds maximum allowed TCP memory
> > limit) bytes for ack and process than notification thus "freeing" acked
> > data and main system can work with that free memory.
> > No need to detect OOM or something other - it just works.
> > 
> > I expect you will give me an example, when all above megabyte is going
> > to be stuck somewhere.
> > But... If it is not acked, each new packet goes slow path since VJ header 
> > prediction fails and falls into memory limit check which will drop that
> > packet immediately without event trying to select a socket.

I mean without trying to queue data into socket.

> Not sure on the details; but you say: when we reach the threshold all
> following packets will be dropped. So if you provide enough memory to
> exceed the limit, you have some extra. If you then use that extra bit to
> allow ACKs to pass through, then you're set.
> 
> Sounds good, but you'd have to carve a path for the ACKs, right? Or is
> that already there?

Acks with or without attached data are processed before data queueing.
See tcp_rcv_established().

> Also, I'm worried with the effects of external fragmentation esp. after
> long run times. Analysing non trivial memory allocators is hard, very
> often too hard.
>
> > > > > > And there is a simple task in TODO list to dynamically grow cache when
> > > > > > threshold of memory is in use. It is really simple task and will be
> > > > > > implemented as soon as I complete suggestions mentioned by Andrew Morton.
> > > > > 
> > > > > Growing will not help, the problem is you are out of memory, you cannot
> > > > > grow at that point.
> > > > 
> > > > You do not see the point of network tree allocator.
> > > > 
> > > > It can live with main system OOM since it has preallocated separate
> > > > pool, which can be increased when there is a requirement for that, for
> > > > example when system is not in OOM.
> > > 
> > > It cannot increase enough, ever. The total capacity of the network stack
> > > is huge.
> > > And the sole problem I'm addressing is getting the system to work
> > > reliably in tight memory situations, that is during reclaim; one cannot
> > > decide to grow then, nor postpone, too late.
> > 
> > Network *is* limited, it is not terabyte array which is going to be
> > placed into VFS cache.
> 
> No it is not, but you bound it.

I expect we will not convince each other :)

> > > > > skbuff_head_cache and skbuff_fclone_cache are SLABs.
> > > > 
> > > > It is quite small part of the stack, isn't it?
> > > > And btw, they still suffer from SLAB design, since it is possibly to get
> > > > another smaller object right after all skbs are allocated from given page.
> > > > It is a minor thing of course, but nevertheless worh mentioning.
> > > 
> > > Small but crucial, that is why I've been replacing all.
> > 
> > Sigh, replace kmem_cache_alloc() with avl_alloc() - it does not matter.
> 
> It does matter, you need the whole packet, if you cannot allocate a
> sk_buff you're still stuck.

Multiple above megabyte to 2.5 (if we assume the smallest packet as
100 bytes and add 150 bytes of skb) and you win.

> > > > > Yes SLAB is a horrid thing on some points but very good at a lot of
> > > > > other things. But surely there are frequently used sizes, kmalloc will
> > > > > not know, but a developer with profiling tools might.
> > > > 
> > > > Does not scale - admin must run system under profiling, add new
> > > > entries into kmalloc_sizes.h recompile the kernel... No way.
> > > 
> > > s/admin/developer/
> > > It has been the way so far.
> > 
> > Could you say what are preferred sizes in my testing machines here? :)
> > For example MMIO-read based chips (excellent realtek 8139 adapter) can
> > allocate not only 1500 bytes of memory, but real size of received frame.
> > I even used it for receiving zero-copy (really excellent hardware
> > for it's price) into VFS cache implementation (without any kind of
> > page-per-packet stuff), but it is not related to our discussion.
> 
> Well generally the developer of the driver can say, and very often it
> just doesn't matter, but see the wide spread use of private SLABs to see
> there is benefit in manually tuning stuff.

It can not be tuned in network, since packet can have any size from
about 60 to 16k bytes. Doing tricky stuff with allocation will end up in NTA
in some or other way.

-- 
	Evgeniy Polyakov
