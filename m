Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTH1XWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTH1XWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:22:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:34748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264392AbTH1XV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:21:58 -0400
Date: Thu, 28 Aug 2003 16:22:29 -0700
From: Dave Olien <dmo@osdl.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4-mm2 drivers/char.c ---> drivers/char/raw.c
Message-ID: <20030828232228.GA7242@osdl.org>
References: <20030828231853.GA7192@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828231853.GA7192@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mistake in subject line... should refer to drivers/char/raw.c

On Thu, Aug 28, 2003 at 04:18:53PM -0700, Dave Olien wrote:
> 
> The raw.c character device Oopses dereferencing a NULL pointer in bd_claim()
> This problem occurred after bd_claim() in block_dev.c was modified to "claim
> the whole device when a partition is claimed".
> 
> raw_open() made the mistake of calling bd_claim BEFORE calling
> blkdev_get().  At that time, the bdev->bd_contains field. has't been
> initialized yet.  Switching the order allows blkdev_get() to initialize
> those fields before calling bd_claim().
> 
> Also fixed up some error return paths:
> 
> igrab() should never fail under these circumstances since the caller
> already has a reference to that inode through the bdev at that time.
> 
> In the event of blkdev_get() failure or set_blocksize() failure, not
> all the work to unwind from the error was done.
> 
> --- linux-2.6.0-test4-mm2_original/drivers/char/raw.c	2003-08-28 13:16:03.000000000 -0700
> +++ linux-2.6.0-test4-mm2_raw/drivers/char/raw.c	2003-08-28 14:07:44.000000000 -0700
> @@ -60,25 +60,25 @@
>  	bdev = raw_devices[minor].binding;
>  	err = -ENODEV;
>  	if (bdev) {
> -		err = bd_claim(bdev, raw_open);
> +		err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
>  		if (err)
>  			goto out;
> -		err = -ENODEV;
> -		if (!igrab(bdev->bd_inode))
> +		igrab(bdev->bd_inode);
> +		err = bd_claim(bdev, raw_open);
> +		if (err) {
> +			blkdev_put(bdev, BDEV_RAW);
>  			goto out;
> -		err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
> +		}
> +		err = set_blocksize(bdev, bdev_hardsect_size(bdev));
>  		if (err) {
>  			bd_release(bdev);
> +			blkdev_put(bdev, BDEV_RAW);
>  			goto out;
> -		} else {
> -			err = set_blocksize(bdev, bdev_hardsect_size(bdev));
> -			if (err == 0) {
> -				filp->f_flags |= O_DIRECT;
> -				if (++raw_devices[minor].inuse == 1)
> -					filp->f_dentry->d_inode->i_mapping =
> -						bdev->bd_inode->i_mapping;
> -			}
>  		}
> +		filp->f_flags |= O_DIRECT;
> +		if (++raw_devices[minor].inuse == 1)
> +			filp->f_dentry->d_inode->i_mapping =
> +				bdev->bd_inode->i_mapping;
>  	}
>  	filp->private_data = bdev;
>  out:
