Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753099AbWKCEf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbWKCEf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbWKCEf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:35:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:52168 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751415AbWKCEf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:35:26 -0500
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Fri, 3 Nov 2006 15:35:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17738.50949.287850.74986@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bdev: fix ->bd_part_count leak
In-Reply-To: message from Peter Zijlstra on Thursday November 2
References: <1162464485.27131.13.camel@taijtu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 2, a.p.zijlstra@chello.nl wrote:
> 
> Don't leak a ->bd_part_count when the partition open fails with -ENXIO.
> 

Acked-by: NeilBrown <neilb@suse.de>

Thanks.  It took me a while to see why that was a correct fix.  I
wasn't noticing the 'if (bdev != bdev->bd_contains)' which is only
true after __blkdev_get(whole, ...., 1) has been called.

NeilBrown

> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  fs/block_dev.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6-mm/fs/block_dev.c
> ===================================================================
> --- linux-2.6-mm.orig/fs/block_dev.c
> +++ linux-2.6-mm/fs/block_dev.c
> @@ -907,6 +907,7 @@ EXPORT_SYMBOL(bd_set_size);
>  
>  static int __blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags,
>  			int for_part);
> +static int __blkdev_put(struct block_device *bdev, int for_part);
>  
>  static int do_open(struct block_device *bdev, struct file *file, int for_part)
>  {
> @@ -992,7 +993,7 @@ out_first:
>  	bdev->bd_disk = NULL;
>  	bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
>  	if (bdev != bdev->bd_contains)
> -		blkdev_put(bdev->bd_contains);
> +		__blkdev_put(bdev->bd_contains, 1);
>  	bdev->bd_contains = NULL;
>  	put_disk(disk);
>  	module_put(owner);
> 
