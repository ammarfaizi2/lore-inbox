Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271864AbRIID35>; Sat, 8 Sep 2001 23:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271863AbRIID3i>; Sat, 8 Sep 2001 23:29:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:4475 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271865AbRIID3Z>; Sat, 8 Sep 2001 23:29:25 -0400
Date: Sun, 9 Sep 2001 05:30:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909053015.L11329@athlon.random>
In-Reply-To: <20010909042229.K11329@athlon.random> <Pine.LNX.4.33.0109081924390.971-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109081924390.971-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Sep 08, 2001 at 07:31:57PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 07:31:57PM -0700, Linus Torvalds wrote:
> 
> On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
> >
> > 	last blkdev close()
> 
> I repeat: why last? What if there's a read-only user that has the thing
> open for some reason, like gathering statistics every once in a while with
> ioctl's or whatever?
> 
> That "last" is a bug.

The only case where we must synchronize is for tune2fs fsck etc...
there's no ioctl gathering issue running under those. The ioctl
gathering will be started after fsck returned, then it doesn't matter if
the ioctl stays there forever.

Infact it would be particularly bad to synchronize at every close for
the real users of the blkdev, that really want to simply work on a file
as much transparently and fast as possible.

However in theory we could do the fsync + synchronize at every ->release but I
doubt we really need that. At least it wasn't a "bug" but it is a
very intentional behaviour.

> > 	-	write pagecache to disk
> > 	-	drop pagecache
> > 	-	now all new data is on disk
> > 	-	all the above and the below is done atomically with the
> > 	 	bdev semaphore (no new openers or anything can play
> > 		with the pagecache under us, only thing that could
> > 		play under us on the disk is the fs if mounted rw)
> >
> > 	-	here _if_ we have an fs under us, it still has obsolete
> > 	 	data in pinned buffer cache we need to fix it
> 
> Agreed. But you should NOT make that a special case.
> 
> I'm saying that you can, and should, just _unconditionally_ call
> 
> 	invalidate_device()
> 
> which in turn will walk the buffer cache for that device, and try to throw
> it away.
> 
> With the simple (again unconditional) addition of: If it cannot throw it
> away because it is pinned through bh->b_count, it knows somebody is using
> the buffer cache (obviously), so regardless of _what_ kind of user it is,
> be it a direct-io one or a magic kernel module or whatever, it does
> 
> 	lock_buffer(bh);
> 	if (!buffer_dirty(bh))
> 		submit_bh(bh, READ);
> 	else {
> 		/* we just have to assume that the aliasing is ok */
> 		unlock_buffer(bh);
> 	}
> 
> UNCONDITIONALLY.

This will corrupt the fs at the first hdparm -t on a rw mounted disk
_unless_ the fs always lock_buffer(superblock_bh) before modifying any
metadata _and_ marks the buffer dirty before the unlock_super, which is
not the case. We could possibly rely solely on the lock_super around the
update_buffers() but that would be too weak too since the fs is allowed
not to use the lock_super around all its metadata updates, while it is
well defined where we set/reset MSRDONLY, that always happens with the
super lock acquired and so I only rely on the MSRDONLY plus super lock
acquired which is certainly (and I think the only) safe approch
completly backwards compatible.

> Without caring about things like "is there a filesystem mounted". No
> silly rules. The _only_ rule becomes: "try to make the buffer cache as
> up-to-date as possible".
> 
> See? I'm saying that your approach tries to make decisions that it just
> should not make. It shouldn't care or know about things like "a filesystem

I wish I didn't need to make those decisions, infact if you pick the first
patches and you'll see they were not making those decisions and the
early patches were less safe than the latest ones (though the window for
the race was small).

I wish the cache coherency logic would be simpler but just doing
something unconditionally it's going to break things in one way or
another as far I can tell.

Andrea
