Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136471AbREDRld>; Fri, 4 May 2001 13:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136462AbREDRlX>; Fri, 4 May 2001 13:41:23 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:62482 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136470AbREDRlD>; Fri, 4 May 2001 13:41:03 -0400
Date: Fri, 4 May 2001 10:40:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010504172940.U3762@athlon.random>
Message-ID: <Pine.LNX.4.21.0105041031370.521-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 May 2001, Andrea Arcangeli wrote:

> On Fri, May 04, 2001 at 01:56:14PM +0200, Jens Axboe wrote:
> > Or you can rewrite block_read/write to use the page cache, in which case
> > you'd have more luck doing the above.
> 
> once block_dev is in pagecache there will obviously be no-way to share
> cache between the block device and the filesystem, because all the
> caches will be in completly different address spaces.

They already pretty much are.

I do want to re-write block_read/write to use the page cache, but not
because it would impact anything in this discussion. I want to do it early
in 2.5.x, because:

 - it will speed up accesses
 - it will re-use existing code better and conceptualize things more
   cleanly (ie it would turn a disk into a _really_ simple filesystem with
   just one big file ;).
 - it will make MM handling much better for things like fsck - the memory
   pressure is designed to work on page cache things.
 - it will be one less thing that uses the buffer cache as a "cache" (I
   want people to think of, and use, the buffer cache as an _IO_ entity,
   not a cache).

It will not make the "cache at bootup" thing change at all (because even
in the page cache, there is no commonality between a virtual mapping of a
_file_ (or metadata) and a virtual mapping of a _disk_). 

It would have hidden the problem with "dd" or "dump" touching buffer cache
blocks that the filesystem was using, so the original metadata corruption
that started this thread would not happen. But that's not a design issue
or a design goal, that would just have been a random result.

		Linus

