Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272372AbRIKKXb>; Tue, 11 Sep 2001 06:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272373AbRIKKXW>; Tue, 11 Sep 2001 06:23:22 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:60679 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272372AbRIKKXK>; Tue, 11 Sep 2001 06:23:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 12:27:20 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109101909010.1290-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109101909010.1290-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010911102325Z16364-26184+374@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[long, interesting only to hardcore readahead freaks]

On September 11, 2001 04:27 am, Linus Torvalds wrote:
> On Tue, 11 Sep 2001, Daniel Phillips wrote:
> > >
> > > Ehh.. So now you have two cases:
> > >  - you hit in the cache, in which case you've done an extra allocation,
> > >    and will have to do an extra memcpy.
> > >  - you don't hit in the cache, in which case you did IO that was
> > >    completely useless and just made the system slower.
> >
> > If the read comes from block_read then the data goes into the page cache.  If
> > it comes from getblk (because of physical readahead or "dd xxx >null") the
> > data goes into the buffer cache and may later be moved to the page cache,
> > once we know what the logical mapping is.
> 
> Note that practically all accesses will be through the logical mapping,
> and the virtual index.
> 
> While the physical mapping and the physical index is the only one you can
> do physical read-ahead into.
> 
> And the two DO NOT OVERLAP. They never will. You can't just swizzle
> pointers around - you will have to memcpy.
> 
> In short, you'll end up doing a memcpy() pretty much every single time you
> hit.

And *only* when we hit.  Even if we don't optimize away the memcpy, it's a
win, so long as we get enough hits to make up for the cost of any wasted
readaheads.  Any time physical readahead correctly hits a block of metadata
then chances are good we've eliminated a synchronous stall.

[...]
>  - we're invalidating buffer heads that we find to be aliasing the virtual
>    page we create, which is _also_ not at all the same thing, it's simply
>    an issue of making sure that we haven't had the (unlikely) case of a
>    meta-data block being free'd, but not yet written back.

Aha.  So we are going to do the buffer cache hash probe anyway, the thing I 
call the the reverse lookup.  Now I'm just suggesting we drop the other shoe 
and chain all the page cache blocks to the buffer hash.  The only extra cost 
will be the buffer hash insert and delete, and in return we get complete 
coherency.

> > > So please explain to me how you think this is all a good idea? Or explain
> > > why you think the memcpy is not going to be noticeable in disk throughput
> > > for normal loads?
> >
> > When we're forced to do a memcpy it's for a case where we're saving a read or
> > a seek.
> 
> No.
> 
> The above is assuming that the disk doesn't already have the data in its
> buffers. In which case the only thing we're doing is making the IO command
> and the DMA that filled the page happen earlier.
> 
> Which can be good for latency, but considering that the read-ahead is at
> least as likely to be _bad_ for latency, I don't believe in that argument
> very much. Especially not when you've dirtied the cache and introduced an
> extra memcop.

Wait, does dma dirty the cache?  I'd hope not.

> >	  Even then, the memcpy can be optimized away in the common case that
> > the blocksize matches page_size.
> 
> Well, you actually have to be very very careful: if you do that there is
> just a _ton_ of races there (you'd better be _really_ sure that nobody
> else has already found either of the pages, the "move page" operation is
> not exactly completely painless).

Is doesn't look that bad.  The buffer hash link doesn't change so we don't
need the hash_table_lock.  We basically do an add_to_page_cache less the
lru_cache_add and flags intialization.

> [...]
> You're making the (in my opinion untenable) argument that the logical
> read-ahead is flawed enough of the time that you win by doing an
> opportunistic physical read-ahead, even when that implies ore memory
> pressure both from an allocation standpoint (if you fail 10% of the time,
> you'll have 10% more page cache pages you need to get rid of gracefully,
> that never had _any_ useful information in them) and from a memory bus
> standpoint.

Yes, that's the main danger indeed.  So we'd better be sensitive to other 
disk traffic and not hog it for readahead.  The same with cache memory.  When
we do need to recover cache, the readahead blocks better be easy to recover.
It helps that they're clean.  To recover them efficiently they can live on
their own lru list, which can be readily canibalized.

> > An observation: logical readahead can *never* read a block before it knows
> > what the physical mapping is, whereas physical readahead can.
> 
> Sure. But the meta-data is usually on the order of 1% or less of the data,
> which means that you tend to need to read a meta-data block only 1% of the
> time you need to read a real data block.
> 
> Which makes _that_ optimization not all that useful.

Oh no, the metadata blocks have a far greater impact than that: they are
serializers in the sense that you have to read the metadata before reading
the data blocks.  This causes the head has to return to locations it's
already visited, because it didn't know that the blocks at that location
would be needed soon.  I'm tentatively adopting this as the explanation for
the 5X gap between current read performance and what we know to be possible.

> So I'm claiming that in order to get any useful performance improvments,
> your physical read-ahead has to be _clearly_ better than the logical one.
> I doubt it is.

Even marginally better will satisfy me, because what I'm really after is the
coherency across buffer and page cache.  Also, I'm not presenting it as an
either/or.  I see physical readahead as complementary to logical readahead.

> Basically, the things where physical read-ahead might win:
>  - it can be done without metadata (< 1%)

See above.  It's not the actual size of the metadata that matters, it's
the way it serializes access to the data blocks.

>  - it can be done "between files" (very uncommon, especially as you have
>    to assume that different files are physically close)

Entire files can lie "between files".  That is, you have files A B C D in 
order on the disk and the directory happens to order them A D C B.  Relying
only on logical readahead there is a good chance of incurring an extra seek.

Disk fragmentation makes the out-of-order problem a lot more common.

> Can you see any others?

Yes:

  - Lots of ide drives don't have any cache at all.  It's not in question
    that *some* physical readahead is good, right?  At least we should be
    able to buffer a couple of tracks even for those dumb disks.  This is
    particularly helpful in the case where we're reading lots of little
    files.  With logical readahead, even if the inode happens to be in
    memory by virtue of being on the same block (physical readahead for
    free) we have to set up a new set of reads for each file, plenty of
    time for the file data to pass under the read head.  The result is
    one complete revolution per file, 6 ms.  Whereas with physical
    readahead we could pick those files up at a rate of 1 ms each.

  - The disk firmware ought to be smart enough to evict already-read
    blocks from its cache early, in which case our readahead
    effectively frees up space in its cache.

And not connected with readhead per se, but with the associated cache
coherency:

  - It lets us use dd for preload, which takes maximimum advantage of
    the user's prescience.  It's also a natural interface for programs
    that know more about expected use patterns than the kernel.  For
    example: a GUI, we could certainly use some improvement there.  Or
    a jvm, or even a browser (hello mozilla).

We have the case of the diffs to show us that, with a little prescience,
we can do a *lot* better with physical readahead.  Now what remains is to 
approximate that prescience with useful heuristics.

The point about dd doesn't rely on readahead at all, it just requires that
the page cache snoop and copy from the buffer cache.  I'm quite prepared to 
implement that, just to see how it works.  Then I can imagine a trivial 
algorithm that traverses a directory tree bmapping all the files, sorts that 
then dd's all the heavily clustered parts into the cache in one pass.  That 
should run quite a bit faster than your find command.

Something else we get for free is the ability to getblk a block that's
already in page cache, with full cache coherency.  You mentioned this could
be useful for on-the-fly fsck (it requires cooperation between the fs and
the fsck).  It could also be useful for distributed filesystems.

As far as robustness goes, we get rid of the aliasing problem and gain the
ability to detect cross-linked data blocks.

So we should see some benefit even before attempting to improve readahead.

> I doubt you can get physical read-ahead that gets
> more than a few percentage points better hits than the logical one. AND I
> further claim that you'll get a _lot_ more misses on physical read-ahead,
> which means that your physical read-ahead window should probably be larger
> than our current logical read-ahead.

Yes, that's true.  More misses balanced against fewer seeks and disk 
rotations, and improved latency.

> I have seen no arguments from you that might imply anything else, really.
> 
> Which in turn also implies that the _overhead_ of physical read-ahead is
> larger. And that is without even the issue of memcpy and/or switching
> pages around, _and_ completely ignoring all the complexity-issues.
> 
> But hey, at the end of the day, numbers rule.

Yes, for sure.  As far as I'm concerned, the diff test and your find example 
prove that there is gold to be mined here.

>From my point of view, the advantages of increased robustness and error 
detection by themselves are worth the price of admission alone.  So if I
only managed to get say, 2% improvement it would be a solid victory.  It
just has to cover the cost of the extra hash probes.

We already know we can do much better than that, a factor of 5-6 for the
diff under good conditions.  Surely over time we'll learn how to come
closer to that with a predictive as opposed to prescient algorithm.

--
Daniel
