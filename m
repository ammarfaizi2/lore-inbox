Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262123AbSJNT0P>; Mon, 14 Oct 2002 15:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262115AbSJNT0P>; Mon, 14 Oct 2002 15:26:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65522 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262123AbSJNT0N>;
	Mon, 14 Oct 2002 15:26:13 -0400
Date: Mon, 14 Oct 2002 15:32:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@infradead.org>
cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
Subject: Re: Linux v2.5.42
In-Reply-To: <20021014202158.A27076@infradead.org>
Message-ID: <Pine.GSO.4.21.0210141524550.6505-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Oct 2002, Christoph Hellwig wrote:

> +{
> +	int r;
> +
> +	if (d->bdev)
> +		BUG();
> +
> +	if (!(d->bdev = bdget(kdev_t_to_nr(d->dev))))
> +		return -ENOMEM;
> +
> + 	r = blkdev_get(d->bdev, d->mode, 0, BDEV_RAW);
> +	if (r) {
> +		bdput(d->bdev);

*blam*
failing blkdev_get() does bdput() itself.

> +
> +	if (sscanf(path, "%x:%x", &major, &minor) == 2) {
> +		/* Extract the major/minor numbers */
> +		dev = mk_kdev(major, minor);
> +	} else {
> +		/* convert the path to a device */
> +		if ((r = lookup_device(path, &dev)))
> +			return r;
> +	}
> 
> What do you need the major/minor version for?

... and in any case, both branches should result in struct block_device *
(the former - via bdget(MKDEV(...));)
 
> +	switch (command) {
> +	case BLKGETSIZE:
> +		l_size = (long) size;
> +		if (copy_to_user((void *) a, &l_size, sizeof(long)))
> +			return -EFAULT;
> +		break;

> These two are in generic code and odn't need to be implemented
> by a lowlevel driver (won't ever be called).

Not only that, but BLKGETSIZE above is missing overflow check.
(these two are still called, with generic version called if we
get -EINVAL; with patches submitted to Linus they won't be even
tried).

