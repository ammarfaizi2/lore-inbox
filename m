Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271848AbRIICgS>; Sat, 8 Sep 2001 22:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271849AbRIICgH>; Sat, 8 Sep 2001 22:36:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6159 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271848AbRIICfw>; Sat, 8 Sep 2001 22:35:52 -0400
Date: Sat, 8 Sep 2001 19:31:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010909042229.K11329@athlon.random>
Message-ID: <Pine.LNX.4.33.0109081924390.971-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
>
> 	last blkdev close()

I repeat: why last? What if there's a read-only user that has the thing
open for some reason, like gathering statistics every once in a while with
ioctl's or whatever?

That "last" is a bug.

> 	-	write pagecache to disk
> 	-	drop pagecache
> 	-	now all new data is on disk
> 	-	all the above and the below is done atomically with the
> 	 	bdev semaphore (no new openers or anything can play
> 		with the pagecache under us, only thing that could
> 		play under us on the disk is the fs if mounted rw)
>
> 	-	here _if_ we have an fs under us, it still has obsolete
> 	 	data in pinned buffer cache we need to fix it

Agreed. But you should NOT make that a special case.

I'm saying that you can, and should, just _unconditionally_ call

	invalidate_device()

which in turn will walk the buffer cache for that device, and try to throw
it away.

With the simple (again unconditional) addition of: If it cannot throw it
away because it is pinned through bh->b_count, it knows somebody is using
the buffer cache (obviously), so regardless of _what_ kind of user it is,
be it a direct-io one or a magic kernel module or whatever, it does

	lock_buffer(bh);
	if (!buffer_dirty(bh))
		submit_bh(bh, READ);
	else {
		/* we just have to assume that the aliasing is ok */
		unlock_buffer(bh);
	}

UNCONDITIONALLY.

Without caring about things like "is there a filesystem mounted". No
silly rules. The _only_ rule becomes: "try to make the buffer cache as
up-to-date as possible".

See? I'm saying that your approach tries to make decisions that it just
should not make. It shouldn't care or know about things like "a filesystem
has this device mounted".  It should do _one_ thing, and one thing only:
"somebody has written to the device through the page cache, let's try to
invalidate or re-validate as much of the buffer cache as humanly
possible".

Special-case code is bad. Always doing the same thing is good.

		Linus

