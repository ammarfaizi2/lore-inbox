Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263209AbREaWo2>; Thu, 31 May 2001 18:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbREaWoI>; Thu, 31 May 2001 18:44:08 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:22268 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S263209AbREaWn6>; Thu, 31 May 2001 18:43:58 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105312242.f4VMg2S3017158@webber.adilger.int>
Subject: Re: [Ext2-devel] [UPDATE] Directory index for ext2
In-Reply-To: <0105312302061N.06233@starship> "from Daniel Phillips at May 31,
 2001 11:02:06 pm"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Thu, 31 May 2001 16:42:02 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> On Thursday 31 May 2001 21:44, Andreas Dilger wrote:
> > I think Al's idea of doing the validation once on the initial
> > read is a good one.
> 
> I'm doing that in the current patch, for leaf blocks, look at 
> ext2_bread.  For index blocks, ext2_bread needs help to know that a 
> block is supposed to be an index block.  Add a parameter?

I think we should just get rid of the misconception that ext2_bread()
is a block read function.  It is only used by directory functions.
Instead we should have separate ext2_bread_leaf(), ext2_bread_root(),
ext2_bread_node() which do the appropriate validation for each type
of block.

In ext2_bread_dir() if we really think directory block prealloc is a win
(in addition to the existing in-memory contiguous block prealloc), we
may as well do it each time we split a leaf block, and make them valid
in-use leaf blocks instead of just wasting space on disk (i.e. each split
block has the hash space split into 1/N of the existing space, and we
distribute existing entries across all N blocks).

This way we don't have to split the each directory block so many times.
For indexed directories this is (probably) a net win because we avoid
N extra block splits (i.e. extra copying of leaf blocks), and make the
leaf search space smaller.  On non-indexed ext2 it would be a net loss
because we would still have to read and search each directory block,
even if they are empty.

> It's normal for it to start by putting all the entries into the first 
> two blocks, but after those are split it should be pretty uniform 
> across the resulting 4, and so on.  Can you confirm it's unbalanced?

I don't think that is what I was seeing, because the hash block numbers
were not "->1" and "->2" (which would be the case right after a split),
but rather 30's, 40's, etc.

> > Running mongo has shown up another bug, I see, but haven't had a
> > chance to look into yet.  It involves not being able to delete files
> > from an indexed directory:
> >
> > rm: cannot remove `/mnt/tmp/testdir1-0-0/d0/d1/d2/d3/509.r':
> > Input/output error
> >
> > This is after the files had been renamed (.r suffix).  Do we re-hash
> > directory entries if the file is renamed?  If not, then that would
> > explain this problem.  It _looks_ like we do the right thing, but the
> > mongo testing wipes out the filesystem after each test, and the above
> > message is from a logfile only.
> 
> The rename creates the new entry via ext2_add_entry so the hash must be 
> correct.  Time to get out the bug swatter.  I'll get mongo and try it.

One other point of information.  In the test I was running, it was
always the file "509.r" which had the I/O error (new filesystem each
test run, btw, and no IDE errors in the log).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
