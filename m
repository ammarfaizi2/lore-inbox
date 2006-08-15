Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932774AbWHOMfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbWHOMfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbWHOMfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:35:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38104 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932527AbWHOMfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:35:10 -0400
Date: Tue, 15 Aug 2006 16:34:38 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060815123438.GA29896@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <1155558313.5696.167.camel@twins> <20060814123530.GA5019@2ka.mipt.ru> <1155639302.5696.210.camel@twins> <20060815112617.GB21736@2ka.mipt.ru> <1155643405.5696.236.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155643405.5696.236.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 15 Aug 2006 16:34:39 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 02:03:25PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> On Tue, 2006-08-15 at 15:26 +0400, Evgeniy Polyakov wrote:
> > On Tue, Aug 15, 2006 at 12:55:02PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > > Userspace can sak for next packet and pointer to the new location will
> > > > be removed.
> > > 
> > > /sak/ask/?
> > > 
> > > I'm not understanding, if you have a page A with two packets, a and b;
> > > once you map that page into user-space that process has access to both
> > > packets, which is a security problem. How are you going to solve this?
> > 
> > Yep, there is such issue.
> > But no one is ever going to replace socket code with zero-copy
> > interfaces - Linux has backward compatibility noone ever had, so
> > send()/recv() will be there.
> 
> The new AIO network API should be able to provide the needed userspace
> changes.

Kevent based network AIO already handle it.
This changes are different.

> > It is new interface which can be changed as described in previous
> > e-mails - copy if next chunk belongs to different socket and so on.
> 
> But if you copy you're not zero-copy anymore. If you copy every second
> packet you have a 1/2 copy receive, but not zero.
>
> > Initial user will be sniffer, which should get all packets.
> 
> Only the root user may get all packets. And most enterprise systems I've
> seen don't generally run a sniffer. That is usually done by
> redirecting/copying the data stream in a router and attach a second host
> to analyse the data.

Nice words. And what "second host" is supposed to do with that traffic?
I expect it should not be Linux (not an "enterprise system"?). WIll it
copy to userspace or have some kind of a zero-copy?

> > > > > > As described in recent threads [3] it is also possible to eliminate any 
> > > > > > kind of main system OOM influence on network dataflow processing, thus 
> > > > > > it is possible to prevent deadlock for systems, which use network as 
> > > > > > memory storage (swap over network, iSCSI, NBD and so on).
> > > > > 
> > > > > How? You have never stated how you will avoid getting all packets stuck
> > > > > in blocked sockets.
> > > > 
> > > > Each socket has it's limit, so if allocator got enough memory, blocked
> > > > sockets will not affect it's behaviour.
> > > 
> > > But isn't the total capacity of the network stack much larger than any
> > > allocator can provide?
> > 
> > TCP has 768kb limit on my amd64 with 1gb of ram, so I expect allocator
> > can handle all requests.
> 
> But the capacity of the network stack is larger than this (arbitrary)
> limit. It is possible to have all 768kb worth of packets stuck on
> blocked sockets.

And so what? You said, that separated from main allocator can not handle
all memory requests being done by the stack, as you can see it easily
can.

> > And there is a simple task in TODO list to dynamically grow cache when
> > threshold of memory is in use. It is really simple task and will be
> > implemented as soon as I complete suggestions mentioned by Andrew Morton.
> 
> Growing will not help, the problem is you are out of memory, you cannot
> grow at that point.

You do not see the point of network tree allocator.

It can live with main system OOM since it has preallocated separate
pool, which can be increased when there is a requirement for that, for
example when system is not in OOM.

> > > > > On another note, I think you misunderstand our SLAB allocator; we do not
> > > > > round up to nearest order page alloc per object; SLAB is build to avoid
> > > > > that and is designed to pack equal size objects into pages. The kmalloc
> > > > > allocator is build on top of several SLAB allocators; each with its
> > > > > specific size objects to serve.
> > > > > 
> > > > > For example, the 64 byte SLAB will serve 64 byte objects, and packs
> > > > > about PAGE_SIZE/64 per page (about since there is some overhead).
> > > > > 
> > > > > So the actual internal fragmentation of the current kmalloc/SLAB
> > > > > allocator is not as bad as you paint it. The biggest problem we have
> > > > > with the SLAB thing is getting pages back from it. (And the horrific
> > > > > complexity of the current implementation)
> > > > 
> > > > Ok, not SLAB, but kmaloc/SLAB.
> > > 
> > > The page-allocator does what you describe, but hardly anybody uses that
> > > to store small objects.
> > 
> > Network stack uses kmalloc.
> 
> skbuff_head_cache and skbuff_fclone_cache are SLABs.

It is quite small part of the stack, isn't it?
And btw, they still suffer from SLAB design, since it is possibly to get
another smaller object right after all skbs are allocated from given page.
It is a minor thing of course, but nevertheless worh mentioning.

> > > Page allocator - buddy allocator, gives out memory in 1<<n pages.
> > > 
> > > SLAB allocator - uses the page allocator for backing, each SLAB issues
> > > objects of a fixed, predetermined size, packed in pages.
> > > 
> > > kmalloc - uses a collection of SLAB allocators to issue 'variable' size
> > > objects (see kmalloc_sizes.h - as you will see internal fragmentation
> > > can become quite large for larger objects, but small objects do rather
> > > well - and one could always add a frequently used size if it shows to be
> > > beneficial).
> > 
> > There is no "frequently used size", kmalloc() does not know what size is
> > frequent and what is not. And there are other mentioned problems with
> > kmalloc/SLAB besides power-of-two, which prevent fragmentation problem
> > resolution.
> 
> Yes SLAB is a horrid thing on some points but very good at a lot of
> other things. But surely there are frequently used sizes, kmalloc will
> not know, but a developer with profiling tools might.

Does not scale - admin must run system under profiling, add new
entries into kmalloc_sizes.h recompile the kernel... No way.

> > > > That allocator uses power-of-two allocation, so there is extremely
> > > > large overhead for several (and in some cases for all) usage cases
> > > > (e1000 with jumbo frames and unix sockets).
> > > 
> > > Wrong example :-), e1000 is the only driver that doesn't do high order
> > > allocs for jumbo frames. But yes, the other drivers should be fixed,
> > > relying on higher order allocations is unsound.
> > 
> > :) do you read netdev@? There are several quite long recent discussions 
> > where network hackers blame exactly e1000 for it's hardware problems and
> > ugly memory usage model.
> > We even think how to change struct sk_buff - Holy Grail of network code
> > - just to help e1000 driver (well, not exactly for e1000, but that
> > driver was a cause).
> 
> Have you seen the latest code? It allocates single pages and puts them
> in the skb_shared_info fragments. Surely it might have been the one
> pushing for these changes, but they are done. Current status.

Plese check e1000_alloc_rx_buffers() function and rx_buffer_len value.
You are wrong.

> > > > SLAB allows to have chunks of memory from differenct CPU, so it is
> > > > impossible to create defragmentation, thus kmalloc/SLAB by design will
> > > > suffer from fragmentation.
> > > 
> > > *confused* memory is not bound to CPUs other than by NUMA, but even
> > > there there is only a single address space. 
> > 
> > Each slab can have objects allocated in different CPUs, it was done to
> > reduce freeing algorithm. If system wants to defragment several objects
> > into bigger one, it must check all CPUs and find in which cache those
> > objects are placed, which is extremely expensive, so SLAB can not
> > perform defragmentation.
> 
> What you are referring to is coalescence, and yes coalescing over page
> boundaries is hard in the SLAB layer, the page allocator does that.

Page boundaries is only minor part of the problem.
Objects from the same page can live in different (per-cpu) SLAB caches.

> > > > Graphs of power-of-two vs. NTA overhead is shown on projects' homepage 
> > > > - overhead is extremely large.
> > > 
> > > Yes seen that, but as stated, hardly anybody uses the page allocator to
> > > store small objects. However if you do, you get large internal
> > > fragmentation but zero external fragmentation (on that allocation
> > > level).
> > 
> > Truncated cat /proc/slabinfo on my machine (usual desktop):
> > size-32             1170   1232     32
> > size-128             663    780    128
> > size-64             4239   9558     64
> 
> Sure, point being?
> 
> size-64             4497   4602     64   59    1 : tunables  120   60
> 8 : slabdata     78     78      0
> 
> 4497 objects used out of 4602 available, object size 64 bytes, 59
> objects per slab of 1 page. .... 78 pages with active objects out of 78
> pages allocated. 

It was your words quoted above that "hardly anybody uses the page
allocator to store small objects", as you can see, there are quite a few
of them allocated through kmalloc but not through kmem_cache.
 
> > > This is where my SROG allocator comes in, it is used to group objects by
> > > lifetime and returns the pages to the page allocator. This makes the
> > > whole allocator short-lived and hence cannot add (external)
> > > fragmentation on this level. The use I have for that is that I can then
> > > properly gauge how much memory there is available. External
> > > fragmentation and guarantees can be difficult to reconcile.
> > > 
> > > I have no idea how fast/slow the SROG allocator is, and don't really
> > > care since its only used as a fallback allocator; what I do care about
> > > is determinism (in space).
> > > 
> > > However, I do have a patch that converts the whole skb layer to use the
> > > SROG allocator, not only the payload, so I could do some test. But this
> > > is not a serious candidate until all jumbo frame capable drivers have
> > > been converted to skb fragments instead of high order allocations - a
> > > Good Thing [tm].
> > 
> > You created SROG after my suggestion and discussion about NTA and it works 
> > well for it's purpose (doesn't it?), further extension could lead to creation 
> > of NTA (or could not).
> 
> I started with a very broken in-situ allocator (that tried to do the
> same thing) in the very first patch. It was only later that I realised
> the full extend of the skbuff requirements.
> 
> And no, NTA is too complex an allocator to do what I need. And more
> specifically its design is quite contrary to what I have done. I
> create/destroy an allocator instance per packet, you have one allocator
> instance and serve multiple packets.
> 
> > SROG is a wrapper on top of alloc_pages and list of free objects,
> > there are "several" differencies between allocators and I do not see how
> > they can compete right now.
> 
> Yes allocators are build in layers, the page allocator the the basic
> building block in Linux.

Ok, it's your point.
Actum est, ilicet.

-- 
	Evgeniy Polyakov
