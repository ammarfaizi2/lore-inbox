Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135741AbQLaC7w>; Sat, 30 Dec 2000 21:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLaC7n>; Sat, 30 Dec 2000 21:59:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31251 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135710AbQLaC73>; Sat, 30 Dec 2000 21:59:29 -0500
Date: Sat, 30 Dec 2000 18:28:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Andrea Arcangeli <andrea@suse.de>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.10.10012310241300.8887-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.LNX.4.10.10012301816410.1743-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2000, Roman Zippel wrote:
> 
> On Sun, 31 Dec 2000, Andrea Arcangeli wrote:
> 
> > > estimate than just the data blocks it should not be hard to add an
> > > extra callback to the filesystem.  
> > 
> > Yes, I was thinking at this callback too. Such a callback is nearly the only
> > support we need from the filesystem to provide allocate on flush.
> 
> Actually the getblock function could be split into 3 functions:
> - alloc_block: mostly just decrementing a counter (and quota)
> - get_block: allocating a block from the bitmap
> - commit_block: inserting the new block into the inode
> 
> This would be really useful for streaming, one could get as fast as
> possible the block number and the data could be very quickly written,
> while keeping the cache usage low. Or streaming directly from a device
> to disk also wants to get rid of the data as fast as possible.

Now, to insert a small note of sanity here: I think people are starting to
overdesign stuff.

The fact is that currently the "get_block()" interface that the page cache
helper functions use does NOT have to be very expensive at all.

In fact, in a properly designed filesystem just a bit of low-level caching
would easily make the average "get_block()" be very fast indeed. The fact
that right now ext2 has not been optimized for this is _not_ a reason to
design the VFS layer around a slow get_block() operation.

If you look at the generic block-based writing routines, they are actually
not all that expensive. Any kind of complication is only going to make
those functions more complex, and any performance gained could easily be
lost in extra complexity.

There are only two real advantages to deferred writing:

 - not having to do get_block() at all for temp-files, as we never have to
   do the allocation if we end up removing the file.

   NOTE NOTE NOTE! The overhead for trying to get ENOSPC and quota errors
   right is quite possibly big enough that this advantage is possibly very
   questionable.  It's very possible that people could speed things up
   using this approach, but I also suspect that it is equally (if not
   more) possible to speed things up by just making sure that the
   low-level FS has a fast get_block().

 - Using "global" access patterns to do a better job of "get_block()", ie
   taking advantage of issues with journalling etc and deferring the write
   in order to get a bigger journal.

The second point is completely different, and THIS is where I think there
are potentially real advantages. However, I also think that this is not
actually about deferred writes at all: it's really a question of the
filesystem having access to the page when the physical write is actually
started so that the filesystem might choose to _change_ the allocation it
did - it might have allocated a backing store block at "get_block()" time,
but by the time it actually writes the stuff out to disk it may have
allocated a bigger contiguous area somewhere else for the data..

I really think that the #2 thing is the more interesting one, and that
anybody looking at ext2 should look at just improving the locking and
making the block allocation functions run faster. Which should not be all
that difficult - the last time I looked at the thing it was quite
horrible.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
