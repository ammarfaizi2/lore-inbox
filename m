Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271841AbRIIBIj>; Sat, 8 Sep 2001 21:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271842AbRIIBIa>; Sat, 8 Sep 2001 21:08:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33392 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271841AbRIIBIV>; Sat, 8 Sep 2001 21:08:21 -0400
Date: Sun, 9 Sep 2001 03:09:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909030913.G11329@athlon.random>
In-Reply-To: <20010908195730.D11329@athlon.random> <Pine.LNX.4.33.0109081055440.936-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109081055440.936-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Sep 08, 2001 at 11:01:59AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 11:01:59AM -0700, Linus Torvalds wrote:
> 
> On Sat, 8 Sep 2001, Andrea Arcangeli wrote:
> >
> > First of all I just __block_fsync + truncate_inode_pages(inode->i_mapping, 0) so
> > all pagecache updates are commited to disk after that, so the latest uptodate
> > data is on disk and nothing uptodate is in memory.
> 
> Hmm. And if two openers have the device open at the same time? One dirties

of course I described what happens under the bdev semaphore at the very
latest release, so there is no "two" opener case here. If some reference
of the file is still open I don't even attempt to sync anything. (if the
user didn't asked for O_SYNC of course, in such a case the
generic_file_write would take care of it)

> data after the first one has done __block_fsync? And the truncate will
> throw the dirtied page away?

There can't be any truncate because the blkdev isn't a regular file.

> Now, I don't think we need to be _too_ careful about cache coherency: it's
> probably ok to do something like
> 
> 	__block_fsync(dev) - sync _our_ changes
> 	invalidate_inode_pages(dev) - this will only invalidate unused pages
> 	invalidate_device(dev)

that's definitely not enough, see the other issue mentioned by Andreas
in this thread, the reason I wrote the algorithm I explained in the
previous email is as first thing to eventually avoid infinite long fsck
of the root fs.

Andrea
