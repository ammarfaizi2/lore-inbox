Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271847AbRIICV4>; Sat, 8 Sep 2001 22:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271848AbRIICVr>; Sat, 8 Sep 2001 22:21:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15989 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271847AbRIICVk>; Sat, 8 Sep 2001 22:21:40 -0400
Date: Sun, 9 Sep 2001 04:22:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909042229.K11329@athlon.random>
In-Reply-To: <20010909033848.J11329@athlon.random> <Pine.LNX.4.33.0109081845410.1447-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109081845410.1447-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Sep 08, 2001 at 06:53:39PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 06:53:39PM -0700, Linus Torvalds wrote:
> 
> On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
> > >
> > > So imagine that there is another user keeping the bdev active. Implying
> > > that you never even try to sync it at all. That sounds like a bad thing to
> > > do.
> >
> > If you would be right it would also be a bug when two users keep open
> > the same file at the same time on any filesystem. Tell me where we do
> > the fsync of the file when the first user closes it.
> 
> Look again - for regular files we _never_ fsync it. Not on the first
> close, not on the last one.

of course.

> 
> And I'm telling you that device files are different. Things like fdisk and
> fsck expect the data to be on the disk after they've closed the device.

Yes, provided they were the only openers. Nitpicking: fsck holds two
references on the device (breakpoint at blkdev_open and you'll see), not
just one like a 'cat', and only the second close(2) will trigger the
fsync.  all right here.

> They do not expect the data to be on disk only if they were the only
							     ^not
> opener, or other special cases.
> 
> End of story.
> 
> > The whole point is that the two users obviously are sharing the same
> > cache so there's no issue there.
> 
> There may not be any issue for _them_, but there may easily be an issue
> between the user that does the first close, and the next
> non-page-cache-user.

The only non page cache user can be the fs.

If an fs is mounted rw while any pagecache user is writing we cannot do
anything about that.

> This is not about coherency between those two users. That coherency is
> something we can take for granted if they both use the page cache, and as
> such you shouldn't even bring that issue up - it's not interesting.

Exactly.

> What _is_ interesting is the assumption of the disk state of _one_ of the
> users, and its expectations about the disk contents etc being up-to-date
> after a close(). Up-to-date enough that some other user that does NOT use
> the page cache (ie a mount) should see the correct data.
> 
> And it sounds very much like your current approach completely misses this.
>
> > The only case we need to care specially is the coherency between
> > filesystems and blkdev users and that's what I do with the algorithm
> > explained earlier.
> 
> Yeah, you explained that you had multiple different approaches depending
> on whether it was mounted read-only or not etc etc. Which sounds really
> silly to me.

It is not silly, if we didn't need to synchronize the caches it would
not be necessary, but we must synchronize the caches, see Andreas's
post. And we can safely synchronize the caches only if we have a ro
mounted fs under us while we hold the super lock.

> I'm telling you that ONE approach should be the right one. And I'm further
> telling you that that one approach is obviously a superset of your "many
> different modes of behaviour depending on what is going on".
> 
> Which sounds a lot cleaner, and a lot simpler than your special case
> heaven.

Simpler and broken, without my heaven it would either corrupt the fs at
the first hdparm or alternatively fsck forever the root at boot.

> 
> > We don't flush at every close even in current 2.4 buffercache backed.
> 
> Because we don't need to. There are no coherency issues wrt metadata
> (which is the only thing that fsck changes).

and so I'm not flushing at every close with the blkdev in pagecache
either. You're the one who said I should flush at every close.

> 
> If fsck changed data contents, we'd better flush dirty buffers, believe
> me.

After an fsck I flush, provided fsck is the only opener of the blkdev.
Fsck will flush and throw away the pagecache, then all the uptodate data
will be on disk. After that _only_ if there's a ro fs under us I
uptodate the pinned metadata in buffer cache to make sure the fs won't
clobber the changes did by fsck.

> 
> > > 	fsync(inode);
> > > 	invalidate_inode_pages(inode);
> > > 	invalidate_device(inode->b_dev);
> >
> > That's not enough.
> 
> Tell me why. Yes, you need the extension that I pointed out:
> 
> > > Yes. So you could make invalidate_device() stronger, trying to re-read
> > > buffers that aren't dirty. But that doesn't mean that you should act
> > > differently on FS mounted vs not-mounted vs some-other-user.


	last blkdev close()
	-	write pagecache to disk
	-	drop pagecache
	-	now all new data is on disk
	-	all the above and the below is done atomically with the
	 	bdev semaphore (no new openers or anything can play
		with the pagecache under us, only thing that could
		play under us on the disk is the fs if mounted rw)

	-	here _if_ we have an fs under us, it still has obsolete
	 	data in pinned buffer cache we need to fix it

	-	so start reading from disk the new data and writing it
		to the pinned buffer cache so the fs won't clobber our
		changes later and will run with the uptodate data, of
		course we can do this _only_ on a ro mounted fs, or we
		could corrupt the fs if the fs were mounted rw, but
		we don't care about the rw mounted fs case, if the
		fs was mounted rw and somebody wrote to the fs via
		blkdev we cannot do anything to save such box.

As far I can tell I'm completly backwards compatible and I'm covering
all the possible cases correctly.

Andrea
