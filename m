Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271844AbRIIBiS>; Sat, 8 Sep 2001 21:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271845AbRIIBiH>; Sat, 8 Sep 2001 21:38:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23922 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271844AbRIIBh5>; Sat, 8 Sep 2001 21:37:57 -0400
Date: Sun, 9 Sep 2001 03:38:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909033848.J11329@athlon.random>
In-Reply-To: <20010909030913.G11329@athlon.random> <Pine.LNX.4.31.0109081811230.24270-100000@p4.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0109081811230.24270-100000@p4.transmeta.com>; from torvalds@transmeta.com on Sat, Sep 08, 2001 at 06:20:51PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 06:20:51PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
> > >
> > > Hmm. And if two openers have the device open at the same time? One dirties
> >
> > of course I described what happens under the bdev semaphore at the very
> > latest release, so there is no "two" opener case here. If some reference
> > of the file is still open I don't even attempt to sync anything. (if the
> > user didn't asked for O_SYNC of course, in such a case the
> > generic_file_write would take care of it)
> 
> That's also a bug.

it's not.

> 
> So imagine that there is another user keeping the bdev active. Implying
> that you never even try to sync it at all. That sounds like a bad thing to
> do.

If you would be right it would also be a bug when two users keep open
the same file at the same time on any filesystem. Tell me where we do
the fsync of the file when the first user closes it.

The whole point is that the two users obviously are sharing the same
cache so there's no issue there.

The only case we need to care specially is the coherency between
filesystems and blkdev users and that's what I do with the algorithm
explained earlier.

> > > data after the first one has done __block_fsync? And the truncate will
> > > throw the dirtied page away?
> >
> > There can't be any truncate because the blkdev isn't a regular file.
> 
> You said you used truncate_inode_pages(), which _does_ throw the pages
> away.  Dirty or not.

I said I do __block_fsync and then truncate_inode_pages. By the time I
drop the pagecache on the blkdev inode I just committed all the changes
to disk, all the uptodate data is on disk then.

No other user can be messing under us because we're serialized by the
bdev semaphore.

> What I'm saying is that you at _every_ close (sane semantics for block
> devices really do expect the writes to be flushed by close time - how
> would they otherwise ever be flushed reliably?) do something like

We don't flush at every close even in current 2.4 buffercache backed.
Even more obviously when there's more than one fd open on the file when
->release isn't even recalled.

> 	fsync(inode);
> 	invalidate_inode_pages(inode);
> 	invalidate_device(inode->b_dev);
> 
> and be done with it. That syncs the pages that we've dirtied, and it
> invalidates all pages that aren't pinned some way. Which is exactly what
> you want.

That's not enough.

> > that's definitely not enough, see the other issue mentioned by Andreas
> > in this thread, the reason I wrote the algorithm I explained in the
> > previous email is as first thing to eventually avoid infinite long fsck
> > of the root fs.
> 
> Ehh? Why? The above writes back exactly the same thing that our current
> block filesystem writes back. While "invalidate_device()" also throws away
> all buffers that aren't pinned.
> 
> And the superblock isn't in the buffer cache - it's cached separately, so

The superblock is cached in pinned buffer cache.

> invalidate_device() will throw away the buffer associated with it - to be
> re-read and re-written by the rw remount.
> 
> Will it be different than the current behaviour wrt some other metadata?
> Yes. So you could make invalidate_device() stronger, trying to re-read
> buffers that aren't dirty. But that doesn't mean that you should act
> differently on FS mounted vs not-mounted vs some-other-user.

Trying to resync a rw mounted fs would corrupt the fs for example, we
definitely want to allow reads on a rw mounted fs, but we don't want to
corrupt the fs once we close, we cannot threat the two cases the same
way.

Also the only case where we need to do the synchronization of the caches
is the blkdev_close, so I don't think it makes sense to change the other
calls that are currently used by code that doesn't need to synchronize.

Andrea
