Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272516AbRIKQpr>; Tue, 11 Sep 2001 12:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272517AbRIKQpi>; Tue, 11 Sep 2001 12:45:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:50693 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272516AbRIKQp2>; Tue, 11 Sep 2001 12:45:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 18:52:57 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109110821520.8078-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109110821520.8078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010911164544Z16026-1365+38@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 05:39 pm, Linus Torvalds wrote:
> On Tue, 11 Sep 2001, Daniel Phillips wrote:
> > > In short, you'll end up doing a memcpy() pretty much every single time you
> > > hit.
> >
> > And *only* when we hit.  Even if we don't optimize away the memcpy, it's a
> > win, so long as we get enough hits to make up for the cost of any wasted
> > readaheads.  Any time physical readahead correctly hits a block of metadata
> > then chances are good we've eliminated a synchronous stall.
> 
> Ehh..
> 
> Your argument seems to be "it won't cost us anything if we don't hit".
> 
> But hey, if we don't hit, then it _will_ cost us - that implies that the
> read-ahead was _completely_ wasted. That's the worst case, not the "good"
> case. You've just wasted CPU cycles in setting up the bogus IO, and disk
> and bus cycles in executing it.

My fault for being imprecise.  By "hit" I meant "hit readahead data in the 
buffer cache".  Hits on data already in the page cache will work exactly as 
they do now, and page cache data that is originally accessed through the page 
cache (i.e., whenever we know its mapping) will not take a side trip through 
the buffer cache.

> > Aha.  So we are going to do the buffer cache hash probe anyway, the thing I
> > call the the reverse lookup.  Now I'm just suggesting we drop the other shoe
> > and chain all the page cache blocks to the buffer hash.  The only extra cost
> > will be the buffer hash insert and delete, and in return we get complete
> > coherency.
> 
> "complete"? No. The coherency is very much one-way: we'd better not have
> anything that actually dirties the buffer cache, because that dirtying
> will _not_ be seen by a virtual cache.

Then I haven't communicated what I had in mind to do.  Dirtying data through 
the buffer cache would be ok.  There are two cases: 1) the block is in the 
page cache, but we get to it through the buffer hash chain instead of the 
page hash chain.  Fine, we can dirty it.  2) the block is not in the page 
cache.  We can still dirty it, because if the page cache tries to add that 
block it will first go look for it in the "buffer cache" (which is really 
just a way of saying "not in the page cache") and move it into the page
cache.

> [...]
> Your argument is fundamentally flawed: remember that you cannot actually
> _use_ the data you read ahead before you actually have the linear mapping.
> And you have to get the meta-data information before you can _create_ the
> linear mapping.

You are seeing an inconsistency I'm not seeing.

> Doing physical read-ahead does not mean you can avoid reading meta-data,
> and if you claim that as a "win", you're just lying to yourself.
> 
> Doing physical read-ahead only means that you can read-ahead _before_
> reading meta-data: it does not remove the need for meta-data, it only
> potentially removes a ordering dependency.

Right.

> But it potentially removes that ordering dependency through speculation
> (only if the speculation ends up being correct, of course), and
> speculation has a cost. This is nothing new - people have been doing
> things like this at other levels for a long time (doing things like data
> speculation inside CPU's, for example).
> 
> Basically, you do not decrease IO - you only try to potentially make it
> more parallel. Which can be a win.
> 
> But it can be a big loss too. Speculation always ends up depending ont he
> fact that you have more "throughput" than you actually take advantage of.
> By implication, you can also clearly see that speculation is bound to be
> provably _bad_ in any case where you can already saturate your resources.

Absolutely, so such a facility must shut itself down when there are other 
demands for the bandwidth.

> [...]
> Marginally better is not good enough if other loads are marginally worse.

Of course I did not mean that.  I meant marginally better on average.

> And I will bet that you _will_ see marginally worse numbers. Which is why
> I think you want "clearly better" just to offset the marginally worse
> numbers.

OK, I'll buy that.
 
> > > Basically, the things where physical read-ahead might win:
> > >  - it can be done without metadata (< 1%)
> >
> > See above.  It's not the actual size of the metadata that matters, it's
> > the way it serializes access to the data blocks.
> 
> See above. It always will. There is NO WAY you can actually return the
> file data to the user before having read the metadata. QED.

Fine, but you may already have read the *data* by the time you read the 
metadata, and so don't have to wait for it, it's already in cache.  That's
where the win is.

> You ONLY remove ordering constraints, nothing more.

Agreed.  But that's a big deal.

> [...]
> With 2MB of disk cache (which is what all the IDE disks _I_ have access to
> have), the disk will have more of a read-ahead buffer than you'd
> reasonably do in software. How much did you imagine you'd read ahead
> physically? Megabytes? I don't think so..

Yes, I was thinking megabytes in order to get anything close to the 5X 
improvement that appears to be possible.  But first I was planning to start 
more modestly, just pick up a few preemptive data reads here and there that 
the logical readahead mechanism would miss, in addition to servicing the 
logical readahead just as we do now.

To do the more ambitious multi-megabyte readahead, I had in mind something
that would combine information from some highlevel sources - directory 
operations, generic_read, etc - with information picked up at the
physical level, massaging it all into a kind of display from which we'd
be able to determine easily that we have a trend going on like "reading
the whole damm directory".  Once we know that's what we're doing it's not 
hard to see what to do about it.

Just to do a reality check on that: if somebody reads the first 1/10 of
the files in a directory tree in getdents order, it's a pretty safe bet
they're going to read the other 9/10ths, right?

--
Daniel
