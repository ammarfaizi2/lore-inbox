Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136430AbREINQ5>; Wed, 9 May 2001 09:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136432AbREINQs>; Wed, 9 May 2001 09:16:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7494 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136430AbREINQc>; Wed, 9 May 2001 09:16:32 -0400
Date: Wed, 9 May 2001 15:16:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Jens Axboe <axboe@suse.de>
Subject: Re: blkdev in pagecache
Message-ID: <20010509151612.D2506@athlon.random>
In-Reply-To: <20010509043456.A2506@athlon.random> <3AF90A3D.7DD7A605@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AF90A3D.7DD7A605@evision-ventures.com>; from dalecki@evision-ventures.com on Wed, May 09, 2001 at 11:13:33AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 11:13:33AM +0200, Martin Dalecki wrote:
> >   (buffered and direct) to work with a 4096 bytes granularity instead of
> 
> You mean PAGE_SIZE :-).

In my first patch it is really 4096 bytes, but yes I agree we should
change that to PAGE_CACHE_SIZE. The _only_ reason it's 4096 fixed bytes is that
I wasn't sure all the device drivers out there can digest a bh->b_size of
8k/32k/64k (for the non x86 archs) and I checked the minimal PAGE_SIZE
supported by linux is 4k. If Jens says I can sumbit 64k b_size without
any problem for all the relevant blkdevices then I will change that in a
jiffy ;). Anyways changing that is truly easy, just define
BUFFERED_BLOCKSIZE to PAGE_CACHE_SIZE instad of 4096 (plus the .._BITS as
well) and it should do the trick automatically. So for now I only cared
to make it easy to change that.

> Exactly, please see my former explanation... BTW.> If you are gogin into
> the range of PAGE_SIZE, it may be very well possible to remove the
> whole page assoociated mechanisms of a buffer_head?

I wouldn't be that trivial to drop it, not much different than dropping
it when a fs has a 4k blocksize. I think the dynamic allocation of the
bh is not that a bad thing, or at least it's an orthogonal problem to
moving the blkdev in pagecache ;).

> Basically this is something which should come down to the strategy
> routine
> of the corresponding device and be fixed there... And then we have this

so you mean the device driver should make sure blk_size is PAGE_CACHE_SIZE
aligned and to take care of writing zero in the pagecache beyond the end
of the device? That would be fine from my part but I'm not yet sure
that's the cleanest manner to handle that.

> Some notes about the code:
> 
>  	kdev_t dev = inode->i_rdev;
> -	struct buffer_head * bh, *bufferlist[NBUF];
> -	register char * p;
> +	int err;
>  
> -	if (is_read_only(dev))
> -		return -EPERM;
> +	err = -EIO;
> +	if (iblock >= (blk_size[MAJOR(dev)][MINOR(dev)] >>
> (BUFFERED_BLOCKSIZE_BITS - BLOCK_SIZE_BITS)))
> 		     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> blk_size[MAJOR(dev)] can very well be equal NULL! In this case one is
> supposed to assume blk_size[MAJOR(dev)][MINOR(dev)] to be INT_MAX.
> Are you shure it's guaranteed here to be already preset?
> 
> Same question goes for calc_end_index and calc_rsize.

that's a bug indeed (a minor one at least because all the relevant
blkdevices initialize such array and if it's not initialized you notice
before you can make any damage ;), thanks for pointing it out!

Andrea
