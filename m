Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272681AbTG1G4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272688AbTG1G4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:56:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21946 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S272681AbTG1G4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:56:46 -0400
Date: Mon, 28 Jul 2003 09:12:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       NeilBrown <neilb@cse.unsw.edu.au>
Subject: Re: [PATCH 2.6.0-test2] fix broken blk_start_queue behavior
Message-ID: <20030728071200.GC25356@suse.de>
References: <3F2418D9.1020703@aros.net> <3F24CA0D.4050901@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F24CA0D.4050901@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28 2003, Lou Langholtz wrote:
> This patch changes the behavior of blk_start_queue() so that request 
> queues really do start up again after blk_start_queue() is called (on 
> queues that were previously stopped via blk_stop_queue). The patch 
> applies against 2.6.0-test2. I have tested this patch with the use of 
> blk_stop_queue and blk_start_queue in my branch of the nbd block device 
> driver (not yet released). blk_start_queue is also used in 
> ./drivers/{block/cciss.c,ide/ide-io.c} which should see things function 
> as intended now w.r.t. stopping and starting the request queue (but I do 
> not know if anybody noticed that they weren't working correctly before). 
> ide-io.c uses queue stop and start for power management handling. Please 
> let me know if you've seen a problem before with that, especially if 
> this patch fixes it - that will be happy news ;-)

> diff -urN linux-2.6.0-test2/drivers/block/ll_rw_blk.c linux-2.6.0-test2-unplug/drivers/block/ll_rw_blk.c
> --- linux-2.6.0-test2/drivers/block/ll_rw_blk.c	2003-07-27 19:02:48.000000000 -0600
> +++ linux-2.6.0-test2-unplug/drivers/block/ll_rw_blk.c	2003-07-28 00:36:35.366537142 -0600
> @@ -1027,10 +1027,10 @@
>   */
>  static inline void __generic_unplug_device(request_queue_t *q)
>  {
> -	if (!blk_remove_plug(q))
> +	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
>  		return;
>  
> -	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
> +	if (!blk_remove_plug(q))
>  		return;
>  
>  	del_timer(&q->unplug_timer);

Patch looks correct, thanks! Guess our mails crossed in mid-air :)

-- 
Jens Axboe

