Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSFFJOe>; Thu, 6 Jun 2002 05:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSFFJOd>; Thu, 6 Jun 2002 05:14:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316080AbSFFJOc>;
	Thu, 6 Jun 2002 05:14:32 -0400
Message-ID: <3CFF28C8.407FB932@zip.com.au>
Date: Thu, 06 Jun 2002 02:18:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's 
 bigger than queue could handle
In-Reply-To: <200206060849.BAA00355@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> Andrew Moreton wrote:
            ^ hey.

> >It looks like BIO_MAX_FOO needs to become an API function.
> >Question is: what should it return? Number of sectors, number
> >of bytes or number of pages?
> >
> >For my purposes, I'd prefer number of pages.  ie: the vector
> >count which gets passed into bio_alloc:
> >
> >        unsigned bio_max_iovecs(struct block_device *bdev);
> >
> >        nr_iovecs = bio_max_iovecs(bdev);
> >        bio = bio_alloc(GFP_KERNEL, nr_iovecs);
> >
> >would suit.
> >
> >And if, via this, we can submit BIOs which are larger than 64k
> >for the common "it's just a disk" case then that is icing.
> 
>         Here is my attempt at implimenting your idea.  I am composing
> this email on a machine that has this code compiled into the kernel,
> but I do not know if any of the effected code paths have ever been
> executed.

If you're using ext2 or ext3 they have.

>         The interface to the routine is:
> 
>         int bio_max_iovecs(request_queue_t *q, int *iovec_size)

hm.  OK.  But why not just a block_device, rather than
plucking out bd_queue at each call site?

>         iovec_size is both an input and output variable.  You give it
> the desired number of bytes you want to stuff in each iovec, and the
> number may come back chopped it exceeds q->max_sectors * 512.  It
> returns the number of iovecs of that size that you can safely stuff
> into a single bio for the underlying block device driver.
> 
>         Notes on these changes:
> 
>               1. BIO_MAX_SECTORS et al are gone.  Nothing uses them
>                  anymore.

Have to check that with Jens.  I was basing the bvec count on
q->max_sectors a while back and it had a problem.
 
>               2. I changed do_mpage_readpage and mpage_writepage to
>                  precompute bdev = inode->i_sb->s_bdev, rather than
>                  repeatedly getting it from a data returned from
>                  the get_block function.  This allow bio_max_iovecs()
>                  to be called once in each routine, rather than repeatedly
>                  within a loop.  If bdev really could have some other
>                  value, then my optimization needs to be undone.

That won't work for reads from blockdevs.  `cat /dev/hda1' will
probably go splat.  The blockdev superblock is shared between
all blockdevs.  We have to stick with the bdev which get_block()
gave us.
 
>               3. I assume that "goto confused" in these routines causes
>                  a safer but slower approach to be used.  I added jumps
>                  to these labels for the case where the underlying queue
>                  could not handle enough sectors in a single bio to cover
>                  even one page.

That looks fine.
 
-
