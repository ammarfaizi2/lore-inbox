Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274415AbRITKwB>; Thu, 20 Sep 2001 06:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272839AbRITKvw>; Thu, 20 Sep 2001 06:51:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63649 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274415AbRITKvo>;
	Thu, 20 Sep 2001 06:51:44 -0400
Date: Thu, 20 Sep 2001 06:52:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010920043404.K720@athlon.random>
Message-ID: <Pine.GSO.4.21.0109200647030.3498-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Andrea Arcangeli wrote:

> On Wed, Sep 19, 2001 at 03:21:09PM -0400, Alexander Viro wrote:
> > int fd = open("/dev/ram0", O_RDWR);
> > ioctl(fd, BLKFLSBUF);
> > ioctl(fd, BLKFLSBUF);
> 
> here it is the fix below.
[snip]
> @@ -328,8 +369,16 @@
>  				bdev->bd_openers--;
>  				bdev->bd_cache_openers--;
>  				iput(rd_inode[minor]);
> +				/*
> +				 * Make sure the cache is flushed from here
> +				 * and not from close(2), somebody
> +				 * could reopen the device before we have a
> +				 * chance to close it ourself.
> +				 */
> +				truncate_inode_pages(rd_inode[minor]->i_mapping, 0);
>  				rd_inode[minor] = NULL;
>  				rd_blocksizes[minor] = rd_blocksize;
> +			unlock:
>  				up(&bdev->bd_sem);

Now think what happens if you go through that code twice.  What argument will
be passed to iput() the second time you call it?

