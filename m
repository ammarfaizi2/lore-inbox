Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbRENSgE>; Mon, 14 May 2001 14:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbRENSfy>; Mon, 14 May 2001 14:35:54 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:252 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262369AbRENSfg>; Mon, 14 May 2001 14:35:36 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105141833.f4EIXrQs001765@webber.adilger.int>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <01051304344501.02742@starship> "from Daniel Phillips at May 13,
 2001 04:34:45 am"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Mon, 14 May 2001 12:33:53 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danie, you write:
> This can go in ext2_bread, which already has dir-specific code in it
> (readahead), and ext2_getblk remains generic, for what it's worth.

Note that the dir-specific code in ext2_bread() is not readahead, but
rather directory block pre-allocation, which would totally break indexed
directory code (because the empty blocks would not be put into the index
and would remain unreferenced thereafter).

For that matter, I'm not sure whether the dir-prealloc feature even works.
The blocks are created/allocated, but are not initialized with the empty
dirent data (i.e. set rec_len = blocksize), so it would just create a
corrupt directory block.

> > ...(later)... I had a look at pulling out the ext2_check_page() code
> > so that it can be used for both ext2_get_page() and ext2_bread(), but
> > one thing concerns me - if we do checking on the whole page/buffer at
> > once, then any error in the page/buffer will discard all of the dir
> > entries in that page.  In the old code, we would at least return all
> > of the entries up to the bad dir entry.  Comments on this?
> 
> For a completely empty page that's the right thing to do, much better 
> than hanging as it does now.  We don't want to try to repair damage on 
> the fly do we?

What do you mean by hanging?  You refer to new (indexed) code or old code?
We definitely cannot repair this damage on-the-fly.  It would be hard/work
to find the next valid dir entry in the block, and that may be a false
positive.  Running e2fsck fixes this by clearing that dirent and setting
the rec_len to the rest of the block (hence deleting all of the remaining
dirents in the block).  The inodes they point to will be put in lost+found,
if that was the only link.

Note that e2fsck also guarantees that a directory start with "." and "..",
so we are pretty safe with the first block-split code.

> Now, if the check routine tells us how much good data it found we could 
> use that to set a limit for the dirent scan, thus keeping the same 
> robustness as the old code but without having all the checks in the 
> inner loop.  Or.  We could have separate loops for good blocks and bad 
> blocks, it's just a very small amount of code.

Yes, I was thinking about both of those as well.  I think the latter would
be easiest, because we only need to keep a single error bit per buffer.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
