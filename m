Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTJ2G5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 01:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTJ2G5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 01:57:08 -0500
Received: from www12.mailshell.com ([209.157.66.248]:52964 "HELO mailshell.com")
	by vger.kernel.org with SMTP id S261903AbTJ2G5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 01:57:02 -0500
Message-ID: <20031029065701.171.qmail@mailshell.com>
Date: Wed, 29 Oct 2003 08:56:57 +0200
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
References: <20031028154920.1905.qmail@mailshell.com> <20031028141329.13443875.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028141329.13443875.akpm@osdl.org>
From: lkml-031028@amos.mailshell.com
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 02:13:29PM -0800, Andrew Morton wrote:
> I've been waiting a year for someone who can reproduce this.

Looks like it's reproducible right now - I got exactly the same
message when I boot again later.

I'll try not to move things too much so I can test this more.
(You don't think it's critical, do you?)

> Are you using initrd?

Nope. Just plain old /boot/vmlinuz on a simple IDE disk with
a single ReiserFS partition and ReiserFS code compiled into
the kernel.

> Could you please add this patch, and send the new dmesg output?

Will do it gladly, when I'm back home tonight.

Thanks for everything,

--Amos

PS I'm not on lkml, so please keep me cc'ed about this.

> 
> 
>  25-akpm/fs/block_dev.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff -puN fs/block_dev.c~a fs/block_dev.c
> --- 25/fs/block_dev.c~a	Tue Oct 28 14:11:20 2003
> +++ 25-akpm/fs/block_dev.c	Tue Oct 28 14:11:24 2003
> @@ -50,17 +50,26 @@ int set_blocksize(struct block_device *b
>  {
>  	int oldsize;
>  
> +	printk("%s: size=%d\n", __FUNCTION__, size);
> +
>  	/* Size must be a power of two, and between 512 and PAGE_SIZE */
> -	if (size > PAGE_SIZE || size < 512 || (size & (size-1)))
> +	if (size > PAGE_SIZE || size < 512 || (size & (size-1))) {
> +		printk("%s: EINVAL 1\n", __FUNCTION__);
>  		return -EINVAL;
> +	}
>  
>  	/* Size cannot be smaller than the size supported by the device */
> -	if (size < bdev_hardsect_size(bdev))
> +	if (size < bdev_hardsect_size(bdev)) {
> +		printk("%s: %d < %d\n", __FUNCTION__, size,
> +					bdev_hardsect_size(bdev));
>  		return -EINVAL;
> +	}
>  
>  	oldsize = bdev->bd_block_size;
> -	if (oldsize == size)
> +	if (oldsize == size) {
> +		printk("%s: %d OK\n", __FUNCTION__, size);
>  		return 0;
> +	}
>  
>  	/* Ok, we're actually changing the blocksize.. */
>  	sync_blockdev(bdev);
> 
> _
> 
> 
> 
