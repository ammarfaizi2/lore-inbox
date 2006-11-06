Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753745AbWKFU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbWKFU3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbWKFU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:29:54 -0500
Received: from brick.kernel.dk ([62.242.22.158]:11534 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1753733AbWKFU3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:29:53 -0500
Date: Mon, 6 Nov 2006 21:32:00 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 9/12] repost: cciss: add busy_configuring flag
Message-ID: <20061106203200.GG19471@kernel.dk>
References: <20061106202559.GI17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106202559.GI17847@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06 2006, Mike Miller (OS Dev) wrote:
> PATCH 9 of 12
> 
> This patch adds a check for busy_configuring to prevent starting a queue
> on a drive that may be in the midst of updating, configuring, deleting, etc.
> 
> This had a test for if the queue was stopped or plugged but that seemed
> to cause issues.
> Please consider this for inclusion.
> 
> Thanks,
> mikem
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>
> 
> --------------------------------------------------------------------------------
> 
> ---
> 
>  drivers/block/cciss.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/block/cciss.c~cciss_busy_conf_for_lx2619-rc4 drivers/block/cciss.c
> --- linux-2.6/drivers/block/cciss.c~cciss_busy_conf_for_lx2619-rc4	2006-11-06 13:27:53.000000000 -0600
> +++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:27:53.000000000 -0600
> @@ -1190,8 +1190,11 @@ static void cciss_check_queues(ctlr_info
>  		/* make sure the disk has been added and the drive is real
>  		 * because this can be called from the middle of init_one.
>  		 */
> -		if (!(h->drv[curr_queue].queue) || !(h->drv[curr_queue].heads))
> +		if (!(h->drv[curr_queue].queue) ||
> +		    !(h->drv[curr_queue].heads) ||
> +		    h->drv[curr_queue].busy_configuring)
>  			continue;
> +
>  		blk_start_queue(h->gendisk[curr_queue]->queue);

This is racy, because you don't start the queue when you unset
->busy_configuring later on. For this to be safe, you need to call
blk_start_queue() when you set ->busy_configuring to 0.

-- 
Jens Axboe

