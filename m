Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbREOEoD>; Tue, 15 May 2001 00:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbREOEny>; Tue, 15 May 2001 00:43:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35601 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262625AbREOEnj>; Tue, 15 May 2001 00:43:39 -0400
Date: Mon, 14 May 2001 21:43:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105142054180.23578-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105142130480.23663-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 May 2001, Linus Torvalds wrote:
> 
> Or rather, there is a fundamental reason why we must NEVER EVER look at
> the buffer cache: it is not coherent with the page cache. 
> 
> And keeping it coherent would be _extremely_ expensive. How do we
> know? Because we used to do that. Remember the small mindcraft
> benchmark? Yup. Double copies all over the place, double lookups, double
> everything.

I think I should explain a bit more.

The current page cache is completely non-coherent (with _anything_: it's
not coherent with other files using a page cache because they have a
different index, and it's not coherent with the buffer cache because that
one isn't even in the same name space).

Now, being non-coherent is always the best option if you can get away with
it. It means that there is no way you can ever have _any_ performance
overhead from maintaining the coherency, and it's 100% reproducible -
there's no question where the page cache gets its data from (the raw disk
device. No if's, but's and why's).

The disadvantage of virtual caches is that they can have aliases. That's
fine, but you hav eto be aware of it, and you have to live with the
consequences. That's what we do now. There are no aliases that are worth
worrying about, so virtual caches work perfectly. This is not always true
(virtual CPU data caches tend to be a really bad idea, while virtual CPU
instruction caches tend to work fairly well, although potentially with a
lower utilization ratio than a physical one due to aliasing).

The other alternative is to have a physical cache. That's fine too: you
avoid aliases, but you have to look up the physical address when looking
up the cache. THIS is the real cost of the buffer cache - not the hashing
and the locking, but the fact that you have to know the physical
location. 

A mixed-mode cache is not a good idea. It gets the worst from both worlds,
without getting _any_ of the good qualities. You have the horrible
coherency issue, together with the overhead of having to find out the
physical address. 

You could choose to do "partial coherency", ie be coherent only one way,
for example. That would make the coherency overhead much less, but would
also make the caches basically act very unpredictably - you might have
somebody write through the page cache yet on a read actually not _see_
what he wrote, because it got written out to disk and was shadowed by
cached data in the buffer cache that didn't get updated.

So "partial coherency" might avoid some of the performance issues, but
it's unacceptable to me simply it's pretty non-repeatable and has some
strange behaviour that can be considered "obviously wrong" (see above
about one example).

Which leaves us with the fact that the page cache is best done the way it
is, and anybody who has coherency concerns might really think about those
concerns another way.

I'm really serious about doing "resume from disk". If you want a fast
boot, I will bet you a dollar that you cannot do it faster than by loading
a contiguous image of several megabytes contiguously into memory. There is
NO overhead, you're pretty much guaranteed platter speeds, and there are
no issues about trying to order accesses etc. There are also no issues
about messing up any run-time data structures.

Give it some thought.

		Linus

