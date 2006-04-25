Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWDYFOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWDYFOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWDYFOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:14:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:32146 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751389AbWDYFOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:14:15 -0400
From: Neil Brown <neilb@suse.de>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Date: Tue, 25 Apr 2006 15:13:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17485.45069.692725.551853@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [patch 1/2] raid6_end_write_request() spinlock fix
In-Reply-To: message from Coywolf Qi Hunt on Tuesday April 25
References: <20060425033542.GA4087@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 25, qiyong@fc-cn.com wrote:
> Hello,
> 
> Reduce the raid6_end_write_request() spinlock window.

Andrew: please don't include these in -mm.  This one and the
corresponding raid5 are wrong, and I'm not sure yet the unplug_device
changes.

In this case, the call to md_error, which in turn calls "error" in
raid6main.c, requires the lock to be held as it contains:
	if (!test_bit(Faulty, &rdev->flags)) {
		mddev->sb_dirty = 1;
		if (test_bit(In_sync, &rdev->flags)) {
			conf->working_disks--;
			mddev->degraded++;
			conf->failed_disks++;
			clear_bit(In_sync, &rdev->flags);
			/*
			 * if recovery was running, make sure it aborts.
			 */
			set_bit(MD_RECOVERY_ERR, &mddev->recovery);
		}
		set_bit(Faulty, &rdev->flags);

which is fairly clearly not safe without some locking.

Coywolf:  As I think I have already said, I appreciate your review of
the md/raid code and your attempts to improve it - I'm sure there is
plenty of room to make improvements.  
However posting patches with minimal commentary on code that you don't
fully understand is not the best way to work with the community.
If you see something that you think is wrong, it is much better to ask
why it is the way it is, explain why you think it isn't right, and
quite possibly include an example patch.  Then we can discuss the
issue and find the best solution.

So please feel free to post further patches, but please include more
commentary, and don't assume you understand something that you don't
really.

Thanks,
NeilBrown



> 
> Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
> ---
> 
> diff --git a/drivers/md/raid6main.c b/drivers/md/raid6main.c
> index bc69355..820536e 100644
> --- a/drivers/md/raid6main.c
> +++ b/drivers/md/raid6main.c
> @@ -468,7 +468,6 @@ static int raid6_end_write_request (stru
>   	struct stripe_head *sh = bi->bi_private;
>  	raid6_conf_t *conf = sh->raid_conf;
>  	int disks = conf->raid_disks, i;
> -	unsigned long flags;
>  	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
>  
>  	if (bi->bi_size)
> @@ -486,16 +485,14 @@ static int raid6_end_write_request (stru
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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
