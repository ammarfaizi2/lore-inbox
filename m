Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSHJDsy>; Fri, 9 Aug 2002 23:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSHJDsy>; Fri, 9 Aug 2002 23:48:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25101 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316580AbSHJDsx>; Fri, 9 Aug 2002 23:48:53 -0400
Date: Fri, 9 Aug 2002 20:53:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <3D548E3D.4F8DC107@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208092046430.1354-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Andrew Morton wrote:

> Linus Torvalds wrote:
> > 
> > ...
> >         repeat:
> >                 kmap_atomic(..); // this increments preempt count
> >                 nr = copy_from_user(..);
> >                 kunmap_atomic(..);
> > 
> >                 /* bytes uncopied? */
> >                 if (nr) {
> >                         if (!get_user(dummy, start_addr) &&
> >                             !get_user(dummy, end_addr))
> >                                 goto repeat;
> >                         .. handle EFAULT ..
> >                 }
> > 
> > Yes, the above requires some care about getting the details right, but
> > notice how it requires absolutely no magic new code, and how it actually
> > uses existing well-documented (and has-to-work-anyway) features.
> > 
> 
> OK.  The kunmap_atomic() could happen on a different CPU, which will
> die with CONFIG_DEBUG_HIGHMEM but apart from that, looks much saner.

No no no.

It cannot happen on another CPU, since even if we take a page fault, we 
will all be inside a preempt-safe region (the first thing kmap_atomic() 
does is to increment the preempt count, the last thing the kunmap does is 
to decrement it).

There's nothing that sleeps anywhere, there's nothing that can cause a 
schedule. Exactly because the page fault handler will _see_ that we're in 
a critical region, and will do the "fixup()" thing for us.

> We'll need need to manually fault in the user page on the
> generic_file_read() path before taking the kmap, because reading
> into an unmapped page is a common case: malloc/read.

I actually suspect that most reads are fairly small, and the page already
exists. But who knows.. pre-loading is certainly easy (a single
instruction).

> > And notice how it works as a _much_ more generic fix - the above actually
> > allows the true anti-deadlock thing where you can basically "test" whether
> > the page is already mapped with zero cost, and if it isn't mapped (and you
> > worry about deadlocking because you've already locked the page that we're
> > writing into), you can make the slow path do a careful "look up the page
> > tables by hand" thing.
> 
> I don't understand what the pagetable walk is here for?
>
> The kernel will sometimes need to read the page from disk to service
> the fault, but it's locked...
> 
> We could drop the page lock before the __get_user, but that may
> break the expectations of some filesystem's prepare/commit pair.

The thing is, we can _notice_ when the bad case happens (same page), and 
we can for that special case do special logic.

We couldn't do that before, simply because we can't afford to do the page
table walk all the time. But we _can_ afford to do it for the rare cases
that would trap (the deadlock being one of them).

		Linus

