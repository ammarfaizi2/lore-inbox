Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272256AbRIKC1m>; Mon, 10 Sep 2001 22:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272258AbRIKC1c>; Mon, 10 Sep 2001 22:27:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38919 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272256AbRIKC1U>; Mon, 10 Sep 2001 22:27:20 -0400
Date: Mon, 10 Sep 2001 19:27:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010911020707Z16564-26185+172@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109101909010.1290-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Sep 2001, Daniel Phillips wrote:
> >
> > Ehh.. So now you have two cases:
> >  - you hit in the cache, in which case you've done an extra allocation,
> >    and will have to do an extra memcpy.
> >  - you don't hit in the cache, in which case you did IO that was
> >    completely useless and just made the system slower.
>
> If the read comes from block_read then the data goes into the page cache.  If
> it comes from getblk (because of physical readahead or "dd xxx >null") the
> data goes into the buffer cache and may later be moved to the page cache,
> once we know what the logical mapping is.

Note that practically all accesses will be through the logical mapping,
and the virtual index.

While the physical mapping and the physical index is the only one you can
do physical read-ahead into.

And the two DO NOT OVERLAP. They never will. You can't just swizzle
pointers around - you will have to memcpy.

In short, you'll en dup doing a memcpy() pretty much every single time you
hit.

> > Considering that the extra allocation and memcpy is likely to seriously
> > degrade performance on any high-end hardware if it happens any noticeable
> > percentage of the time, I don't see how your suggest can _ever_ be a win.
> > The only time you avoid the memcpy is when you wasted the IO completely.
>
> We don't have any extra allocation in the cases we're already handling now,
> it works exactly the same.  The only overhead is an extra hash probe on cache
> miss.

No it doesn't. We're already handing _nothing_: the only thing we're
handling right now is:

 - swap cache read-ahead (which is _not_ a physical read-ahead, but a
   logical one, and as such is not at all the case you're handling)

 - we're invalidating buffer heads that we find to be aliasing the virtual
   page we create, which is _also_ not at all the same thing, it's simply
   an issue of making sure that we haven't had the (unlikely) case of a
   meta-data block being free'd, but not yet written back.

So in the first case we don't have an aliasing issue at all (it's really a
virtual index, although in the case of a swap partition the virtual
address ends up being a 1:1 mapping of the physical address), and in the
second case we do not intend to use the physical mapping we find, we just
intend to get rid of it.

> > So please explain to me how you think this is all a good idea? Or explain
> > why you think the memcpy is not going to be noticeable in disk throughput
> > for normal loads?
>
> When we're forced to do a memcpy it's for a case where we're saving a read or
> a seek.

No.

The above is assuming that the disk doesn't already have the data in its
buffers. In which case the only thing we're doing is making the IO command
and the DMA that filled the page happen earlier.

Which can be good for latency, but considering that the read-ahead is at
least as likely to be _bad_ for latency, I don't believe in that argument
very much. Especially not when you've dirtied the cache and introduced an
extra memcop.

>	  Even then, the memcpy can be optimized away in the common case that
> the blocksize matches page_size.

Well, you actually have to be very very careful: if you do that there is
just a _ton_ of races there (you'd better be _really_ sure that nobody
else has already found either of the pages, the "move page" operation is
not exactly completely painless).

>				  Sometimes, even when the blocksize doesn't
> match this optimization would be possible.  But the memcpy optimization isn't
> important, the goal is to save reads and seeks by combining reads and reading
> blocks in physical order as opposed to file order.

Try it. I'll be convinced by numbers, and I'll bet you won't have the
numbers for the common cases to prove yourself right.

You're making the (in my opinion untenable) argument that the logical
read-ahead is flawed enough of the time that you win by doing an
opportunistic physical read-ahead, even when that implies ore memory
pressure both from an allocation standpoint (if you fail 10% of the time,
you'll have 10% more page cache pages you need to get rid of gracefully,
that never had _any_ useful information in them) and from a memory bus
standpoint.

> An observation: logical readahead can *never* read a block before it knows
> what the physical mapping is, whereas physical readahead can.

Sure. But the meta-data is usually on the order of 1% or less of the data,
which means that you tend to need to read a meta-data block only 1% of the
time you need to read a real data block.

Which makes _that_ optimization not all that useful.

So I'm claiming that in order to get any useful performance improvments,
your physical read-ahead has to be _clearly_ better than the logical one.
I doubt it is.

Basically, the things where physical read-ahead might win:
 - it can be done without metadata (< 1%)
 - it can be done "between files" (very uncommon, especially as you have
   to assume that different files are physically close)

Can you see any others? I doubt you can get physical read-ahead that gets
more than a few percentage points better hits than the logical one. AND I
further claim that you'll get a _lot_ more misses on physical read-ahead,
which means that your physical read-ahead window should probably be larger
than our current logical read-ahead.

I have seen no arguments from you that might imply anything else, really.

Which in turn also implies that the _overhead_ of physical read-ahead is
larger. And that is without even the issue of memcpy and/or switching
pages around, _and_ completely ignoring all the complexity-issues.

But hey, at the end of the day, numbers rule.

		Linus

