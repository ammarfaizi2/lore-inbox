Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUAHKoy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbUAHKow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:44:52 -0500
Received: from mail1.ugr.es ([150.214.35.28]:29889 "EHLO mail1.ugr.es")
	by vger.kernel.org with ESMTP id S264313AbUAHKoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:44:46 -0500
Message-ID: <3FFD34D5.1080605@ugr.es>
Date: Thu, 08 Jan 2004 11:45:41 +0100
From: Ruben Garcia <ruben@ugr.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, ja, en, es-es
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: loop device changes the block size and causes misaligned
 accesses to the real device, which can't be processed
References: <3FFC3BF4.6080105@ugr.es> <20040108040414.GA5017@fukurou.paranoiacs.org>
In-Reply-To: <20040108040414.GA5017@fukurou.paranoiacs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, Ben's patch will make the loop device work as any other device, and 
then ext2 will complain that the hard blocksize is bigger than the 
blocksize used for ext2 (in my example of 1k for ext2) and fail to mount 
it.

This is better than getting misaligned transfers et all, and is 
consistent with using the real device.

On the other hand, it is much more useful being able to actually mount 
the ext2 fs, and I managed to do that with the loop-aes patch (Thanks 
Jari Ruusu)

I confirm this bug closed. Thanks to all


Ben Slusky wrote:
> On Wed, 07 Jan 2004 18:03:48 +0100, Ruben Garcia wrote:
> 
>>The loop device advertises a block size of 1024 even when configured 
>>over a cdrom.
>>
>>When burning a ext2 on a cd, and mounting it directly, I get:
>>
>>blocksize=2048;
>>
>>when I losetup /dev/loop0 /dev/cdrom, and then try to mount, I get:
>>
>>blocksize=1024; and then misaligned transfer; this results in not being 
>>able to read the superblock.
>>
>>The loop device should be changed to export the same blocksize of the 
>>underlying device
> 
> 
> Huh, if you look at loop.c it appears to do that already (line 735) but
> it doesn't. This patch makes it so.
> 
> --- linux-2.6.0/drivers/block/loop.c-orig	2004-01-07 22:47:37.755375858 -0500
> +++ linux-2.6.0/drivers/block/loop.c	2004-01-07 22:48:04.990990082 -0500
> @@ -732,8 +732,6 @@
>  	mapping_set_gfp_mask(inode->i_mapping,
>  			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
>  
> -	set_blocksize(bdev, lo_blocksize);
> -
>  	lo->lo_bio = lo->lo_biotail = NULL;
>  
>  	/*
> @@ -749,6 +747,7 @@
>  	if (S_ISBLK(inode->i_mode)) {
>  		request_queue_t *q = bdev_get_queue(lo_device);
>  
> +		blk_queue_hardsect_size(lo->lo_queue, q->hardsect_size);
>  		blk_queue_max_sectors(lo->lo_queue, q->max_sectors);
>  		blk_queue_max_phys_segments(lo->lo_queue,q->max_phys_segments);
>  		blk_queue_max_hw_segments(lo->lo_queue, q->max_hw_segments);
> @@ -757,6 +756,8 @@
>  		blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);
>  	}
>  
> +	set_blocksize(bdev, lo_blocksize);
> +
>  	kernel_thread(loop_thread, lo, CLONE_KERNEL);
>  	down(&lo->lo_sem);
>  
> HTH,
> 


