Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274614AbRITTA1>; Thu, 20 Sep 2001 15:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274612AbRITTAH>; Thu, 20 Sep 2001 15:00:07 -0400
Received: from [195.223.140.107] ([195.223.140.107]:29940 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274615AbRITS7s>;
	Thu, 20 Sep 2001 14:59:48 -0400
Date: Thu, 20 Sep 2001 20:59:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010920205942.V729@athlon.random>
In-Reply-To: <20010920201832.M729@athlon.random> <Pine.GSO.4.21.0109201418450.3498-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109201418450.3498-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Sep 20, 2001 at 02:33:34PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 02:33:34PM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 20 Sep 2001, Andrea Arcangeli wrote:
> 
> > > > +				truncate_inode_pages(rd_inode[minor]->i_mapping, 0);
> > > >  				rd_inode[minor] = NULL;
> > > >  				rd_blocksizes[minor] = rd_blocksize;
> > > > +			unlock:
> > > >  				up(&bdev->bd_sem);
> > > 
> > > Now think what happens if you go through that code twice.  What argument will
> > > be passed to iput() the second time you call it?
> > 
> > the second time we won't go through that code.
> 
> IOW, subsequent calls of ioctl(fd, BLKFLSBUF) will not work.  Which is
> better than oopsing, but doesn't look right.

The second call will do the work if there's something to do. If somebody
did an open/read/writes/close in the middle, it should do the work as
usual. I actually can see a problem if you use the different inodes, but
that will be sorted out too automatically as soon as we stop pinning the
inodes.

> Question: why the hell do we bother with iput() and decrementing counters
> at all?

Yes, that part should be rewritten using the bdev as you did recently,
the ipinning of the ramdisk also in the previous 2.4 kernels (before
your recent patch) had the same problem of my ipinning in the blkdev
highlevel (it looked only a cleanup but it wasn't).

Andrea
