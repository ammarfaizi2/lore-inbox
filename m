Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268705AbTCCS3T>; Mon, 3 Mar 2003 13:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268706AbTCCS3T>; Mon, 3 Mar 2003 13:29:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14087 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268705AbTCCS3R>; Mon, 3 Mar 2003 13:29:17 -0500
Date: Mon, 3 Mar 2003 19:39:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make nbd working in 2.5.x
Message-ID: <20030303183940.GA15943@atrey.karlin.mff.cuni.cz>
References: <20030303172946.GA20197@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303172946.GA20197@vana.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    we use nbd for our diskless systems, and it looks to me like that
> it has some serious problems in 2.5.x... Can you apply this patch
> and forward it to Linus? 
> 
> There were:
> * Missing disk's queue initialization
> * Driver should use list_del_init: put_request now verifies
>   that req->queuelist is empty, and list_del was incompatible
>   with this.
> * I converted nbd_end_request back to end_that_request_{first,last}
>   as I saw no reason why driver should do it itself... and 
>   blk_put_request has no place under queue_lock, so apparently when
>   semantic changed nobody went through drivers...

I do not think this is good idea. I am not sure who converted it to
bio, but he surely had good reason to do that.

> diff -urdN linux/drivers/block/nbd.c linux/drivers/block/nbd.c
> --- linux/drivers/block/nbd.c	2003-02-28 20:56:05.000000000 +0100
> +++ linux/drivers/block/nbd.c	2003-03-01 22:53:36.000000000 +0100
> @@ -76,22 +76,15 @@
>  {
>  	int uptodate = (req->errors == 0) ? 1 : 0;
>  	request_queue_t *q = req->q;
> -	struct bio *bio;
> -	unsigned nsect;
>  	unsigned long flags;
>  
>  #ifdef PARANOIA
>  	requests_out++;
>  #endif
>  	spin_lock_irqsave(q->queue_lock, flags);
> -	while((bio = req->bio) != NULL) {
> -		nsect = bio_sectors(bio);
> -		blk_finished_io(nsect);
> -		req->bio = bio->bi_next;
> -		bio->bi_next = NULL;
> -		bio_endio(bio, nsect << 9, uptodate ? 0 : -EIO);
> +	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
> +		end_that_request_last(req);
>  	}
> -	blk_put_request(req);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }
>  

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
