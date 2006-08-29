Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWH2Jzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWH2Jzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWH2Jzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:55:35 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:51611 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S964853AbWH2Jze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:55:34 -0400
Subject: Re: [PATCH 1/4] net: VM deadlock avoidance framework
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
In-Reply-To: <3994.81.207.0.53.1156809691.squirrel@81.207.0.53>
References: <20060825153946.24271.42758.sendpatchset@twins>
	 <20060825153957.24271.6856.sendpatchset@twins>
	 <1396.81.207.0.53.1156559843.squirrel@81.207.0.53>
	 <1156760564.23000.31.camel@twins>
	 <3720.81.207.0.53.1156780999.squirrel@81.207.0.53>
	 <1156786344.23000.47.camel@twins>
	 <3994.81.207.0.53.1156809691.squirrel@81.207.0.53>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 11:49:41 +0200
Message-Id: <1156844981.23000.75.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 02:01 +0200, Indan Zupancic wrote:
> On Mon, August 28, 2006 19:32, Peter Zijlstra said:

> > Ah, no accident there, I'm fully aware that there would need to be a
> > spinlock in adjust_memalloc_reserve() if there were another caller.
> > (I even had it there for some time) - added comment.
> 
> Good that you're aware of it. Thing is, how much sense does the split-up into
> adjust_memalloc_reserve() and sk_adjust_memalloc() make at this point? Why not
> merge the code of adjust_memalloc_reserve() with sk_adjust_memalloc() and only
> add adjust_memalloc_reserve() when it's really needed? It saves an export.

mm/ vs net/core/

> Better to put the lock next to min_free_kbytes, both for readability and
> cache behaviour. And it satisfies the "lock data, not code" mantra.

True enough.

> If you prefer to avoid cmpxchg (which is often used in atomic_add_unless
> and can be expensive) then you can use something like:

Yes, way too large, out of lined it already. Don't care about the
cmpxchg, its not a fast path anyway.

> > @@ -195,6 +196,86 @@ __u32 sysctl_rmem_default = SK_RMEM_MAX;
> >  /* Maximal space eaten by iovec or ancilliary data plus some space */
> >  int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
> >
> > +static DEFINE_SPINLOCK(memalloc_lock);
> > +static int memalloc_reserve;
> > +static unsigned int vmio_request_queues;
> > +
> > +atomic_t vmio_socks;
> > +atomic_t emergency_rx_pages_used;
> > +EXPORT_SYMBOL_GPL(vmio_socks);
> 
> Is this export needed? It's only used in net/core/skbuff.c and net/core/sock.c,
> which are compiled into one module.
> 
> > +EXPORT_SYMBOL_GPL(emergency_rx_pages_used);
> 
> Same here. It's only used by code in sock.c and skbuff.c, and no external
> code calls emergency_rx_alloc(), nor emergency_rx_free().

Good point, I've gone over the link relations of these things and was
indeed capable of removing several EXPORTs. Thanks.

> I think I depleted my usefulness, there isn't much left to say for me.
> It's up to the big guys to decide about the merrit of this patch.

Thanks for all your feedback.

> IMHO:
> 
> - This patch isn't really a framework, more a minimal fix for one specific,
> though important problem. But it's small and doesn't have much impact

Well, perhaps, its merit is that is allows for full service for a few
sockets even under severe memory pressure. And it provides the
primitives to solve this problem for all instances, (NBD, iSCSI, NFS,
AoE, ...) hence framework.

Evgeniy's allocator does not cater for this, so even if it were to
replace all the allocation stuff, we would still need the SOCK_VMIO and
all protocol hooks this patch introduces.

> - If Evgeniy's network allocator is as good as it looks, then why can't it
> replace the existing one? Just adding private subsystem specific memory
> allocators seems wrong. I might be missing the big picture, but it looks
> like memory allocator things should be at least synchronized and discussed
> with Christoph Lameter and his "modular slab allocator" patch.

SLAB is very very good in that is will not suffer from external
fragmentation (one could suffer from external fragmentation when viewing
the slab allocator from the page allocation layer - but most of that is
avoidable by allocation strategies in the slab layer), it does however
suffer from internal fragmentation - by design.

For variable size allocators it has been proven that for each allocator
there is an allocation pattern that will defeat it. And figuring the
pattern out and proving it will not happen in a long-running system is
hard hard work.

(free block coalescence is not a guarantee against fragmentation; there
is even evidence that delayed coalescence will reduce fragmentation - it
introduces history and this extra information can help predict the
future.)

This is exactly why long running systems (like our kernel) love slabs.

For those interested in memory allocators, this paper is a good (albeit
a bit dated) introduction:
	http://citeseer.ist.psu.edu/wilson95dynamic.html

That said, it might be that Evgeniy's allocator works out for our
network load - only time will tell, the math is not tractable afaik.

> All in all it seems it will take a while until Evgeniy's code will be merged,
> so I think applying Peter's patch soonish and removing it again the moment it
> becomes unnecessary is reasonable.

Thanks and like said, I think even then most of this patch will need to
survive.

