Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272492AbRIKPjx>; Tue, 11 Sep 2001 11:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272489AbRIKPjo>; Tue, 11 Sep 2001 11:39:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12038 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272485AbRIKPji>; Tue, 11 Sep 2001 11:39:38 -0400
Date: Tue, 11 Sep 2001 08:39:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010911102325Z16364-26184+374@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109110821520.8078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Sep 2001, Daniel Phillips wrote:
> >
> > In short, you'll end up doing a memcpy() pretty much every single time you
> > hit.
>
> And *only* when we hit.  Even if we don't optimize away the memcpy, it's a
> win, so long as we get enough hits to make up for the cost of any wasted
> readaheads.  Any time physical readahead correctly hits a block of metadata
> then chances are good we've eliminated a synchronous stall.

Ehh..

Your argument seems to be "it won't cost us anything if we don't hit".

But hey, if we don't hit, then it _will_ cost us - that implies that the
read-ahead was _completely_ wasted. That's the worst case, not the "good"
case. You've just wasted CPU cycles in setting up the bogus IO, and disk
and bus cycles in executing it.

> >  - we're invalidating buffer heads that we find to be aliasing the virtual
> >    page we create, which is _also_ not at all the same thing, it's simply
> >    an issue of making sure that we haven't had the (unlikely) case of a
> >    meta-data block being free'd, but not yet written back.
>
> Aha.  So we are going to do the buffer cache hash probe anyway, the thing I
> call the the reverse lookup.  Now I'm just suggesting we drop the other shoe
> and chain all the page cache blocks to the buffer hash.  The only extra cost
> will be the buffer hash insert and delete, and in return we get complete
> coherency.

"complete"? No. The coherency is very much one-way: we'd better not have
anything that actually dirties the buffer cache, because that dirtying
will _not_ be seen by a virtual cache.

Note that this is not anything new, though.

> > The above is assuming that the disk doesn't already have the data in its
> > buffers. In which case the only thing we're doing is making the IO command
> > and the DMA that filled the page happen earlier.
> >
> > Which can be good for latency, but considering that the read-ahead is at
> > least as likely to be _bad_ for latency, I don't believe in that argument
> > very much. Especially not when you've dirtied the cache and introduced an
> > extra memcop.
>
> Wait, does dma dirty the cache?  I'd hope not.

It can do so (many architectures like the ARM actually do DMA in
software), but no, I wasn't talking about the DMA, but about the memcpy.

> > Well, you actually have to be very very careful: if you do that there is
> > just a _ton_ of races there (you'd better be _really_ sure that nobody
> > else has already found either of the pages, the "move page" operation is
> > not exactly completely painless).
>
> Is doesn't look that bad.  The buffer hash link doesn't change so we don't
> need the hash_table_lock.  We basically do an add_to_page_cache less the
> lru_cache_add and flags intialization.

Wrong.

You need the hash_table_lock for _another_ reason: you need to make really
sure that nobody is traversing the hash table right then - because you can
NOT afford to have somebody else find one of the pages or buffers while
you're doing the operation (you have to test for all the counts being
zero, and you have to do that test when you can guarantee that nobody else
suddenly finds it).

> > > An observation: logical readahead can *never* read a block before it knows
> > > what the physical mapping is, whereas physical readahead can.
> >
> > Sure. But the meta-data is usually on the order of 1% or less of the data,
> > which means that you tend to need to read a meta-data block only 1% of the
> > time you need to read a real data block.
> >
> > Which makes _that_ optimization not all that useful.
>
> Oh no, the metadata blocks have a far greater impact than that: they are
> serializers in the sense that you have to read the metadata before reading
> the data blocks.

Ehh.. You _have_ to read them anyway before you can use your data.

Your argument is fundamentally flawed: remember that you cannot actually
_use_ the data you read ahead before you actually have the linear mapping.
And you have to get the meta-data information before you can _create_ the
linear mapping.

Doing physical read-ahead does not mean you can avoid reading meta-data,
and if you claim that as a "win", you're just lying to yourself.

Doing physical read-ahead only means that you can read-ahead _before_
reading meta-data: it does not remove the need for meta-data, it only
potentially removes a ordering dependency.

But it potentially removes that ordering dependency through speculation
(only if the speculation ends up being correct, of course), and
speculation has a cost. This is nothing new - people have been doing
things like this at other levels for a long time (doing things like data
speculation inside CPU's, for example).

Basically, you do not decrease IO - you only try to potentially make it
more parallel. Which can be a win.

But it can be a big loss too. Speculation always ends up depending ont he
fact that you have more "throughput" than you actually take advantage of.
By implication, you can also clearly see that speculation is bound to be
provably _bad_ in any case where you can already saturate your resources.

> > So I'm claiming that in order to get any useful performance improvments,
> > your physical read-ahead has to be _clearly_ better than the logical one.
> > I doubt it is.
>
> Even marginally better will satisfy me, because what I'm really after is the
> coherency across buffer and page cache.  Also, I'm not presenting it as an
> either/or.  I see physical readahead as complementary to logical readahead.

Marginally better is not good enough if other loads are marginally worse.

And I will bet that you _will_ see marginally worse numbers. Which is why
I think you want "clearly better" just to offset the marginally worse
numbers.

> > Basically, the things where physical read-ahead might win:
> >  - it can be done without metadata (< 1%)
>
> See above.  It's not the actual size of the metadata that matters, it's
> the way it serializes access to the data blocks.

See above. It always will. There is NO WAY you can actually return the
file data to the user before having read the metadata. QED. You ONLY
remove ordering constraints, nothing more.

> > Can you see any others?
>
> Yes:
>
>   - Lots of ide drives don't have any cache at all.  It's not in question
>     that *some* physical readahead is good, right?

Every single IDE drive I know of has cache. Some of them only has a single
buffer, but quite frankly, I've not seen a new IDE drive in the last few
years with less than 1MB of cache. And that's not a "single 1MB buffer".

And this trend hasn't been going backwards. Disks have _always_ been
getting more intelligent, rather than less.

In short, you're betting against history here. And against technology
getting better. It's not a bet that I would ever do..

>   - The disk firmware ought to be smart enough to evict already-read
>     blocks from its cache early, in which case our readahead
>     effectively frees up space in its cache.

With 2MB of disk cache (which is what all the IDE disks _I_ have access to
have), the disk will have more of a read-ahead buffer than you'd
reasonably do in software. How much did you imagine you'd read ahead
physically? Megabytes? I don't think so..

		Linus

