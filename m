Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273110AbRIJA1l>; Sun, 9 Sep 2001 20:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273111AbRIJA1b>; Sun, 9 Sep 2001 20:27:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29454 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273110AbRIJA13>; Sun, 9 Sep 2001 20:27:29 -0400
Date: Sun, 9 Sep 2001 17:23:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <E15gEPC-00084T-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109091709290.22033-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Sep 2001, Alan Cox wrote:
>
> How do you plan to handle the situation where we have multiple instances
> of the same 4K disk block each of which contains 1K of data in the
> start of the page copy and 3K of zeroes.

Note that the file data is indexed by a completely different index, and
has been sicne the page cache was introduced. I am _not_ suggesting that
we get rid of _that_ alias. We've always had data aliasing with the page
cache, and it doesn't matter.

Think of it as an address space issue - where each address space has its
own indexing. One of the advantages of the page cache is the fact that it
has the notion of completely independent address spaces, after all.

So we have one index which is the "physical index", which is the one that
the getblk/bread interfaces use, and which is also the one that the
raw-device-in-pagecache code uses. There are no aliasing issues (as long
as we make sure that we have a "meta-inode" to create a single address
space for this index, and do not try to use different inodes for different
representations of the same block device major/minor number)

The other index is the one we already have, namely the file-virtual index.

And switching the first index over from the purely physically indexed
buffer cache to a new page-cache address space doesn't impact this
already-existing index _at_all_.

So in the physical index, you see one 1 4kB block.

In the virtual index, you have 4 4kB blocks, where the start contents just
happen to be gotten from different parts of the physical 4kB block..

And notice how this is NOT something new at all - this is _exactly_ what
we do now, except out physical index is currently not "wrapped" in any
page cache address space.

> > anyway, I very much doubt it has any good properties to make software more
> > complex by having that kind of readahead in sw.
>
> Even the complex stuff like the i2o raid controllers seems to benefit
> primarily from file level not physical readahead, that gives it enough to
> do intelligent scheduling and to keep the drive firmware busy making good
> decisions (hopefully)

Right. The advantages of read-ahead are two-fold:
 - give the disk (and low-level IO layer) more information about future
   patterns (so that they can generate better schedules for fetching the
   data)
 - overlap IO (especially seek and rotational delays) and computation.

HOWEVER, neither of those advantages actually exist for physical
read-ahead, simply because current disks will always end up doing
buffering anyway, which means that limited physical read-ahead is pretty
much guaranteed by the disk - and doing it in software is only going to
slow things down by generating more traffic over the control/data
channels.

Sure, you could do _extensive_ physical read-ahead (ie more than what
disks tend to do on their own), but that implies a fair number of sectors
(modern disks tend to do something akin to "track buffering" in the 64+kB
range, so you'd have to do noticeably more than that in software to have
any chance of making a difference), and then you'd probably often end up
reading too much and loading the line with data you may not actually need.

		Linus

