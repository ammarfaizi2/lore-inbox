Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWDVT0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWDVT0e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWDVT0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:26:33 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:59067 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751056AbWDVT0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:26:02 -0400
From: Neil Brown <neilb@suse.de>
To: Qi Yong <qiyong@fc-cn.com>
Date: Sat, 22 Apr 2006 15:45:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17481.49894.531724.339182@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] raid5_end_write_request spinlock fix
In-Reply-To: message from Qi Yong on Friday April 21
References: <20060421125949.GA15550@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday April 21, qiyong@fc-cn.com wrote:
> Hello,
> 
> Reduce the raid5_end_write_request() spinlock window.

Thank you for reviewing the md code and suggesting improvements.
However it would help if you used a few more words to describe your
patches.  E.g. explain why  you are convinced that it is safe to
reduce the range of the lock like this.

NeilBrown

> 
> Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
> ---
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 3184360..9c24377 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -581,7 +581,6 @@ static int raid5_end_write_request (stru
>   	struct stripe_head *sh = bi->bi_private;
>  	raid5_conf_t *conf = sh->raid_conf;
>  	int disks = sh->disks, i;
> -	unsigned long flags;
>  	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
>  
>  	if (bi->bi_size)
> @@ -599,16 +598,14 @@ static int raid5_end_write_request (stru
>  		return 0;
>  	}
>  
> -	spin_lock_irqsave(&conf->device_lock, flags);
>  	if (!uptodate)
>  		md_error(conf->mddev, conf->disks[i].rdev);
>  
>  	rdev_dec_pending(conf->disks[i].rdev, conf->mddev);
> -	
>  	clear_bit(R5_LOCKED, &sh->dev[i].flags);
>  	set_bit(STRIPE_HANDLE, &sh->state);
> -	__release_stripe(conf, sh);
> -	spin_unlock_irqrestore(&conf->device_lock, flags);
> +	release_stripe(sh);
> +
>  	return 0;
>  }
>  
> 
> -- 
> Coywolf Qi Hunt
