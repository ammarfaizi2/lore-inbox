Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274592AbRITSSg>; Thu, 20 Sep 2001 14:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274587AbRITSS1>; Thu, 20 Sep 2001 14:18:27 -0400
Received: from [195.223.140.107] ([195.223.140.107]:5620 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274592AbRITSSI>;
	Thu, 20 Sep 2001 14:18:08 -0400
Date: Thu, 20 Sep 2001 20:18:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010920201832.M729@athlon.random>
In-Reply-To: <20010920043404.K720@athlon.random> <Pine.GSO.4.21.0109200647030.3498-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109200647030.3498-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Sep 20, 2001 at 06:52:07AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 06:52:07AM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 20 Sep 2001, Andrea Arcangeli wrote:
> 
> > On Wed, Sep 19, 2001 at 03:21:09PM -0400, Alexander Viro wrote:
> > > int fd = open("/dev/ram0", O_RDWR);
> > > ioctl(fd, BLKFLSBUF);
> > > ioctl(fd, BLKFLSBUF);
> > 
> > here it is the fix below.
> [snip]
> > @@ -328,8 +369,16 @@
> >  				bdev->bd_openers--;
> >  				bdev->bd_cache_openers--;
> >  				iput(rd_inode[minor]);
> > +				/*
> > +				 * Make sure the cache is flushed from here
> > +				 * and not from close(2), somebody
> > +				 * could reopen the device before we have a
> > +				 * chance to close it ourself.
> > +				 */
> > +				truncate_inode_pages(rd_inode[minor]->i_mapping, 0);
> >  				rd_inode[minor] = NULL;
> >  				rd_blocksizes[minor] = rd_blocksize;
> > +			unlock:
> >  				up(&bdev->bd_sem);
> 
> Now think what happens if you go through that code twice.  What argument will
> be passed to iput() the second time you call it?

the second time we won't go through that code.

Andrea
