Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271836AbRIIBVE>; Sat, 8 Sep 2001 21:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271843AbRIIBUz>; Sat, 8 Sep 2001 21:20:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1294 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271836AbRIIBUo>; Sat, 8 Sep 2001 21:20:44 -0400
Date: Sat, 8 Sep 2001 18:20:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010909030913.G11329@athlon.random>
Message-ID: <Pine.LNX.4.31.0109081811230.24270-100000@p4.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
> >
> > Hmm. And if two openers have the device open at the same time? One dirties
>
> of course I described what happens under the bdev semaphore at the very
> latest release, so there is no "two" opener case here. If some reference
> of the file is still open I don't even attempt to sync anything. (if the
> user didn't asked for O_SYNC of course, in such a case the
> generic_file_write would take care of it)

That's also a bug.

So imagine that there is another user keeping the bdev active. Implying
that you never even try to sync it at all. That sounds like a bad thing to
do.

> > data after the first one has done __block_fsync? And the truncate will
> > throw the dirtied page away?
>
> There can't be any truncate because the blkdev isn't a regular file.

You said you used truncate_inode_pages(), which _does_ throw the pages
away.  Dirty or not.

What I'm saying is that you at _every_ close (sane semantics for block
devices really do expect the writes to be flushed by close time - how
would they otherwise ever be flushed reliably?) do something like

	fsync(inode);
	invalidate_inode_pages(inode);
	invalidate_device(inode->b_dev);

and be done with it. That syncs the pages that we've dirtied, and it
invalidates all pages that aren't pinned some way. Which is exactly what
you want.

> that's definitely not enough, see the other issue mentioned by Andreas
> in this thread, the reason I wrote the algorithm I explained in the
> previous email is as first thing to eventually avoid infinite long fsck
> of the root fs.

Ehh? Why? The above writes back exactly the same thing that our current
block filesystem writes back. While "invalidate_device()" also throws away
all buffers that aren't pinned.

And the superblock isn't in the buffer cache - it's cached separately, so
invalidate_device() will throw away the buffer associated with it - to be
re-read and re-written by the rw remount.

Will it be different than the current behaviour wrt some other metadata?
Yes. So you could make invalidate_device() stronger, trying to re-read
buffers that aren't dirty. But that doesn't mean that you should act
differently on FS mounted vs not-mounted vs some-other-user.

		Linus

