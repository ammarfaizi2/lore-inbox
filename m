Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWHOK4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWHOK4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHOK4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:56:32 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:32147 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030212AbWHOK4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:56:31 -0400
Subject: Re: [PATCH 1/1] network memory allocator.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20060814123530.GA5019@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru>
	 <1155558313.5696.167.camel@twins>  <20060814123530.GA5019@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 12:55:02 +0200
Message-Id: <1155639302.5696.210.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 16:35 +0400, Evgeniy Polyakov wrote:
> On Mon, Aug 14, 2006 at 02:25:13PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > On Mon, 2006-08-14 at 15:04 +0400, Evgeniy Polyakov wrote:
> > 
> > > Defragmentation is a part of freeing algorithm and initial fragmentation
> > > avoidance is being done at allocation time by removing power-of-two
> > > allocations. Rate of fragmentation can be found in some userspace
> > > modlling tests being done for both power-of-two SLAB-like and NTA
> > > allocators. (more details on project's homepage [4]).
> > 
> > Only with a perfect allocation pattern. And then still only internal
> > fragmentation; your allocator is still vulnerable to external
> > fragmentation - you cannot move allocated chunks around because there
> > are pointers into it, hence you will suffer from external fragmentation.
> > 
> > http://en.wikipedia.org/wiki/Fragmentation_%28computer%29
> 
> Nature of network dataflow does not obey to that requirements - all
> chunks are "short-lives", i.e. sooner or later they will be put back and
> thus initial region will be repaired.
> With existing allocator it never happens by deisgn.
> 
> > > Benchmarks with trivial epoll based web server showed noticeble (more
> > > than 40%) imrovements of the request rates (1600-1800 requests per
> > > second vs. more than 2300 ones). It can be described by more
> > > cache-friendly freeing algorithm, by tighter objects packing and thus
> > > reduced cache line ping-pongs, reduced lookups into higher-layer caches
> > > and so on.
> > 
> > Nice :-)
> > 
> > > Design of allocator allows to map all node's pages into userspace thus
> > > allows to have true zero-copy support for both sending and receiving
> > > dataflows.
> > 
> > I'm still not clear on how you want to do this, only the trivial case of
> > a sniffer was mentioned by you. To be able to do true zero-copy receive
> > each packet will have to have its own page(s). Simply because you do not
> > know the destination before you receive it, the packet could end up
> > going to a whole different socket that the prev/next. As soon as you
> > start packing multiple packets on 1 page, you've lost the zero-copy
> > receive game.
> 
> Userspace can sak for next packet and pointer to the new location will
> be removed.

/sak/ask/?

I'm not understanding, if you have a page A with two packets, a and b;
once you map that page into user-space that process has access to both
packets, which is a security problem. How are you going to solve this?

Also note that zero-copy sending does not have this problem, since data
is already grouped by socket.

> > > As described in recent threads [3] it is also possible to eliminate any 
> > > kind of main system OOM influence on network dataflow processing, thus 
> > > it is possible to prevent deadlock for systems, which use network as 
> > > memory storage (swap over network, iSCSI, NBD and so on).
> > 
> > How? You have never stated how you will avoid getting all packets stuck
> > in blocked sockets.
> 
> Each socket has it's limit, so if allocator got enough memory, blocked
> sockets will not affect it's behaviour.

But isn't the total capacity of the network stack much larger than any
allocator can provide?

> > On another note, I think you misunderstand our SLAB allocator; we do not
> > round up to nearest order page alloc per object; SLAB is build to avoid
> > that and is designed to pack equal size objects into pages. The kmalloc
> > allocator is build on top of several SLAB allocators; each with its
> > specific size objects to serve.
> > 
> > For example, the 64 byte SLAB will serve 64 byte objects, and packs
> > about PAGE_SIZE/64 per page (about since there is some overhead).
> > 
> > So the actual internal fragmentation of the current kmalloc/SLAB
> > allocator is not as bad as you paint it. The biggest problem we have
> > with the SLAB thing is getting pages back from it. (And the horrific
> > complexity of the current implementation)
> 
> Ok, not SLAB, but kmaloc/SLAB.

The page-allocator does what you describe, but hardly anybody uses that
to store small objects.

Page allocator - buddy allocator, gives out memory in 1<<n pages.

SLAB allocator - uses the page allocator for backing, each SLAB issues
objects of a fixed, predetermined size, packed in pages.

kmalloc - uses a collection of SLAB allocators to issue 'variable' size
objects (see kmalloc_sizes.h - as you will see internal fragmentation
can become quite large for larger objects, but small objects do rather
well - and one could always add a frequently used size if it shows to be
beneficial).

> That allocator uses power-of-two allocation, so there is extremely
> large overhead for several (and in some cases for all) usage cases
> (e1000 with jumbo frames and unix sockets).

Wrong example :-), e1000 is the only driver that doesn't do high order
allocs for jumbo frames. But yes, the other drivers should be fixed,
relying on higher order allocations is unsound.

> SLAB allows to have chunks of memory from differenct CPU, so it is
> impossible to create defragmentation, thus kmalloc/SLAB by design will
> suffer from fragmentation.

*confused* memory is not bound to CPUs other than by NUMA, but even
there there is only a single address space. 

> Graphs of power-of-two vs. NTA overhead is shown on projects' homepage 
> - overhead is extremely large.

Yes seen that, but as stated, hardly anybody uses the page allocator to
store small objects. However if you do, you get large internal
fragmentation but zero external fragmentation (on that allocation
level).

This is where my SROG allocator comes in, it is used to group objects by
lifetime and returns the pages to the page allocator. This makes the
whole allocator short-lived and hence cannot add (external)
fragmentation on this level. The use I have for that is that I can then
properly gauge how much memory there is available. External
fragmentation and guarantees can be difficult to reconcile.

I have no idea how fast/slow the SROG allocator is, and don't really
care since its only used as a fallback allocator; what I do care about
is determinism (in space).

However, I do have a patch that converts the whole skb layer to use the
SROG allocator, not only the payload, so I could do some test. But this
is not a serious candidate until all jumbo frame capable drivers have
been converted to skb fragments instead of high order allocations - a
Good Thing [tm].

