Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbSLIWVD>; Mon, 9 Dec 2002 17:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSLIWVC>; Mon, 9 Dec 2002 17:21:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:57486 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266278AbSLIWU6>;
	Mon, 9 Dec 2002 17:20:58 -0500
Message-ID: <3DF44E98.DD173EE8@digeo.com>
Date: Mon, 09 Dec 2002 00:04:40 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
References: <3DB9A314.6CECA1AC@mvista.com> <3DF2F965.59D7CD84@mvista.com> <3DF3D706.977AC5BB@digeo.com> <3DF4487C.67FD90EF@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2002 08:04:41.0048 (UTC) FILETIME=[A052C580:01C29F59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Andrew Morton wrote:
> >
> > george anzinger wrote:
> > >
> > > --- linux-2.5.50-bk7-kb/include/linux/id_reuse.h        Wed Dec 31 16:00:00 1969
> > > +++ linux/include/linux/id_reuse.h      Sat Dec  7 21:37:58 2002
> >
> > Maybe I'm thick, but this whole id_resue layer seems rather obscure.
> >
> > As it is being positioned as a general-purpose utility it needs
> > API documentation as well as a general description.
> 
> Hm... This whole thing came up to solve and issue related to
> having a finite number of timers.  The ID layer is just a
> way of saving a pointer to a given "thing" (a timer
> structure in this case) in a way that it can be recovered
> quickly.  It is really just a tree structure with 32
> branches (or is it sizeof long branches) at each node.
> There is a bit map to indicate if any free slots are
> available and if so under which branch.  This makes
> allocation of a new ID quite fast.  The "reuse" thing is
> there to separate it from the original code which
> "attempted" to not reuse and ID for some time.

Sounds a bit like the pid allocator?

Is the "don't reuse an ID for some time" requirement still there?

I think you can use radix trees for this.  Just put the pointer
to your "thing" direct into the tree.  The space overhead will
be about the same.

radix-trees do not currently have a "find next empty slot from this
offset" function but that is quite straightforward.  Not quite
as fast, unless an occupancy bitmap is added to the radix-tree
node.  That's something whcih I have done before - in fact it was
an array of occupancy maps so I could do an efficient in-order
gang lookup of "all dirty pages from this offset" and "all locked
pages from this offset".  It was before its time, and mouldered.

> ...
> > A lot of the functions in this header are too large to be inlined.
> 
> Hm...  What is "too large", i.e. how much code.

A few lines, I suspect.

>  Also, is it used more than once?

Don't trust the compiler too much ;)  Uninlining mpage_writepage()
saved a couple of hundred bytes of code, even though it has only
one call site.

> ...
> > Please, just open-code the locking.  This simply makes it harder to follow the
> > main code.
> 
> But makes it easy to change the lock method, to, for
> example, use irq or irqsave or "shudder" RCU.

A diligent programmer would visit all sites as part of that conversion
anyway.

> >
> > > +
> > > +static struct idr_layer *id_free;
> > > +static int id_free_cnt;
> >
> > hm.  We seem to have a global private freelist here.  Is the more SMP-friendly
> > slab not suitable?
> 
> There is a short local free list to avoid calling slab with
> a spinlock held.  Only enough entries are kept to allocate a
> new node at each branch from the root to leaf, and only for
> this reason.

Fair enough. There are similar requirements elsewhere and the plan
there is to create a page reservation API, so you can ensure that
the page allocator will be able to provide at least N pages.  Then
take the lock and go for it.

I have code for that which is about to bite the bit bucket.   But the
new version should be in place soon.   Other users will be radix tree
nodes, pte_chains and mm_chains (shared pagetable patch).

> ...
> >
> > Recursion!
> 
> Yes, it is a tree after all.

lib/radix_tree.c does everything iteratively.

> >
> > > +void idr_init(struct idr *idp)
> >
> > Please tell us a bit about this id layer: what problems it solves, how it
> > solves them, why it is needed and why existing kernel facilities are
> > unsuitable.
> >
> The prior version of the code had a CONFIG option to set the
> maximum number of timers.  This caused enough memory to be
> "compiled" in to keep pointers to this many timers.  The ID
> layer was invented (by Jim Houston, by the way) to eliminate
> this CONFIG thing.  If I were to ask for a capability from
> slab that would eliminate the need for this it would be the
> ability to, given an address and a slab pool, to validate
> that the address was "live" and from that pool.  I.e. that
> the address is a pointer to currently allocated block from
> that memory pool.  With this, I could just pass the address
> to the user as the timer_id.

That might cause problems with 64-bit kernel/32-bit userspace.
Passing out kernel addresses in this way may have other problems..

>  As it is, I need a way to give
> the user a handle that he can pass back that will allow me
> to quickly find his timer and, along the way, validate that
> he was not spoofing, or just plain confused.
> 
> So what the ID layer does is pass back an available <id>
> (which I can pass to the user) while storing a pointer to
> the timer which is <id>ed.  Later, given the <id>, it passes
> back the pointer, or NULL if the id is not in use.

OK.
 
> As I said above, the pointers are kept in "nodes" of 32
> along with a few bits of overhead, and these are arranged in
> a dynamic tree which grows as the number of allocated timers
> increases.  The depth of the tree is 1 for up to 32 , 2 for
> up to 1024, and so on.  The depth can never get beyond 5, by
> which time the system will, long since, be out of memory.
> At this time the leaf nodes are release when empty but the
> branch nodes are not.  (This is an enhancement saved for
> later, if it seems useful.)
> 
> I am open to a better method that solves the problem...

It seems reasonable.  It would be nice to be able to use radix trees,
but that's a lot of work if the patch isn't going anywhere.

If radix trees are unsuitable then yes, dressing this up as a
new core kernel capability (documentation!  separate patch!)
would be appropriate.

But I suspect the radix-tree _will_ suit, and it would be nice to grow
the usefulness of radix-trees rather than creating similar-but-different
trees.  We can do whizzy things with radix-trees; more than at present.

Of course, that was only a teeny part of your patch. I just happened
to spy it as it flew past.  Given that you're at rev 20, perhaps a
splitup and more accessible presentation would help.
