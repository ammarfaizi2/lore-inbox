Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWHUAVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWHUAVn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWHUAVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:21:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28393 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932121AbWHUAVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:21:42 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Mon, 21 Aug 2006 10:21:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17640.64647.311004.869344@cse.unsw.edu.au>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG?] possible recursive locking detected (blkdev_open)
In-Reply-To: message from Peter Zijlstra on Friday August 18
References: <200608090757.32006.eike-kernel@sf-tec.de>
	<1155897321.5696.374.camel@twins>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 18, a.p.zijlstra@chello.nl wrote:
> 
> blkdev_open() calls
>   do_open(bdev, ...,BD_MUTEX_NORMAL) and takes
>     mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_NORMAL)
>     
> then something fails, and we're thrown to:
> 
> out_first: where
>     if (bdev != bdev->bd_contains)
>       blkdev_put(bdev->bd_contains) which is
>         __blkdev_put(bdev->bd_contains, BD_MUTEX_NORMAL) which does
>           mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_NORMAL) <--- lockdep trigger
> 
> When going to out_first, dbev->bd_contains is either bdev or whole, and
> since we take the branch it must be whole. So it seems to me the
> following patch would be the right one:

Looks sensible to me.

> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: NeilBrown <neilb@suse.de>

NeilBrown

> ---
>  fs/block_dev.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/fs/block_dev.c
> ===================================================================
> --- linux-2.6.orig/fs/block_dev.c
> +++ linux-2.6/fs/block_dev.c
> @@ -980,7 +980,7 @@ out_first:
>  	bdev->bd_disk = NULL;
>  	bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
>  	if (bdev != bdev->bd_contains)
> -		blkdev_put(bdev->bd_contains);
> +		__blkdev_put(bdev->bd_contains, BD_MUTEX_WHOLE);
>  	bdev->bd_contains = NULL;
>  	put_disk(disk);
>  	module_put(owner);
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
