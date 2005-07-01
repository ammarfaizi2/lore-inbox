Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263391AbVGAQuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263391AbVGAQuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbVGAQuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:50:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30594 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263389AbVGAQuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:50:03 -0400
Date: Fri, 1 Jul 2005 18:51:24 +0200
From: Jens Axboe <axboe@suse.de>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] cciss per disk queue for 2.6
Message-ID: <20050701165124.GA5117@suse.de>
References: <D4CFB69C345C394284E4B78B876C1CF107DC0868@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DC0868@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01 2005, Miller, Mike (OS Dev) wrote:
> > > This has been tested in our labs. There is no difference in 
> > > performance, it just fixes the Oops. Please consider this patch for 
> > > inclusion.
> > 
> > Going to per-disk queues is undoubtedly a good idea, 
> > performance will be much better this way. So far, so good.
> > 
> > But you need to do something about the queueing for this to 
> > be acceptable, imho. You have a per-controller queueing limit 
> > in place, you need to enforce some fairness to ensure an 
> > equal distribution of commands between the disks.
> 
> Sometime back I submitted what we called the "fair enough" algorithm. I
> don't know how I managed to separate the two. :( But it was accepted and
> is in the mainstream kernel. Here's a snippet:
> ------------------------------------------------------------------------
> -
> -	/*
> -	 * See if we can queue up some more IO
> -	 * check every disk that exists on this controller
> -	 * and start it's IO
> -	 */
> -	for(j=0; j < NWD; j++){
> -		/* make sure the disk has been added and the drive is
> real */
> -		/* because this can be called from the middle of
> init_one */
> -		if(!(h->gendisk[j]->queue) || !(h->drv[j].heads))
> +	/* check to see if we have maxed out the number of commands that
> can
> +	 * be placed on the queue.  If so then exit.  We do this check
> here
> +	 * in case the interrupt we serviced was from an ioctl and did
> not
> +	 * free any new commands.
> +	*/
> +	if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS)
> +		goto cleanup;
> +
> +	/* We have room on the queue for more commands.  Now we need to
> queue
> +	 * them up.  We will also keep track of the next queue to run so
> +	 * that every queue gets a chance to be started first.
> +	*/
> +	for (j=0; j < NWD; j++){
> +		int curr_queue = (start_queue + j) % NWD;
> +		/* make sure the disk has been added and the drive is
> real
> +		 * because this can be called from the middle of
> init_one.
> +		*/
> +		if(!(h->gendisk[curr_queue]->queue) || 
> +		   !(h->drv[curr_queue].heads))

I suppose that will be fair-enough, at least as long as NR_CMDS >>
q->nr_requests. With eg 4 volumes, I don't think this will be the case.
Just making sure you round-robin start the queues is not enough to
ensure fair queueing between them.

> > Perhaps just limit the per-queue depth to something sane, 
> > instead of the huuuge 384 commands you have now. I've had 
> > several people complain to me, that ciss is doing some nasty 
> > starvation with that many commands in flight and we've 
> > effectively had to limit the queueing depth to something 
> > really low to get adequate read performance in presence of writes.
> 
> The combination of per disk queues and this "fairness" prevents
> starvation on different LV's. Ex: if volumes 0 & 1 are being written and
> volume 3 is being read all will get _almost_ equal time. We believe the

Different thing, I'm talking about single volume starvation, not
volume-to-volume.

> elevator algoritm(s) may be causing writes to starve reads on the same
> logical volume. We continue to investigate our other performance issues.

I completely disagree. Even with an intelligent io scheduler, starvation
is seen on ciss that does not happen on other queueing hardware such as
'normal' scsi controllers/drives. So something else is going on, and the
only 'fix' so far is to limit the ciss queue depth heavily.

-- 
Jens Axboe

