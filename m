Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262121AbSIYVaJ>; Wed, 25 Sep 2002 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262124AbSIYVaJ>; Wed, 25 Sep 2002 17:30:09 -0400
Received: from thunk.org ([140.239.227.29]:8607 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262121AbSIYV3w>;
	Wed, 25 Sep 2002 17:29:52 -0400
Date: Wed, 25 Sep 2002 17:34:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Jones <davej@codemonkey.org.uk>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020925213419.GB9557@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dave Jones <davej@codemonkey.org.uk>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <20020925204101.GA5420@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925204101.GA5420@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 09:41:01PM +0100, Dave Jones wrote:
> Just curious.. what measurable overhead (if any) is there of indexing
> dirs with smaller numbers of files vs non-indexed ?
> If so, where would be the break-even point ?

It should be negligible to the point of being non-measurable.  If the
number of files fit within a single block, the format doesn't change
at all.  Once the directory is grows so there are two block's worth of
directory entries, then we move to an indexed format, and every file
will be found within two disk block reads, and on average we will need
to do comparisons on half a block worth of directory names.  Without
directory indexing, on average a lookup will succeed in 1.5 disk reads
(50% will require one disk block read, and 50% will require two disk
block reads), and on average we will need to do comparisons on a full
block's worth of directory entries.

So when the directory is two blocks' worth of data, it's a slight lose
if you are looking at things from the point of view of disk reads, but
we're winning already from the point of view of CPU time.  Not that
this matters; it won't be measureable because the block read
statistics only apply the first time you search the directory.  After
that, the directory blocks will be in cache, and the only thing that
matters is the CPU time.  And the amount of CPU time that it takes to
search directory entries, whether it we need to search on average 1
block or half a block worth of directory entries, is small enough to
be not an issue.

Not that it matters, but for the record though, we break-even on disk
reads once the directory is 3 blocks long.  At that point, linear
search will require on average reading 2 blocks (1*1/3 + 2*1/3 + 3*1/3
== 2) and the indexed directory will still require 2 disk reads.  On
the CPU front, the linear search will require comparisons with 1.5
blocks worth of directory entries, while the indexed directory will
still require only 0.5 blocks worth of directory comparisons.  (I'm
ignoring here the CPU time it takes to calculate the hash, but it's
the time to search the directory blocks that matters, since that's
where you'll have all of the memory cache misses that will slow down
the search.)

Oh, and finally, for a small directory, it won't be measurable because
after the first time around, all of the directory entries will fit in
the dcache.  :-)

						- Ted
