Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUCWLqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbUCWLqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:46:54 -0500
Received: from av7-1-sn4.m-sp.skanova.net ([81.228.10.110]:34265 "EHLO
	av7-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S262511AbUCWLqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:46:52 -0500
Date: Tue, 23 Mar 2004 12:46:44 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd bug (MODE_SENSE/CDROM_SEND_PACKET)
Message-ID: <20040323114644.GA954@ibrium.se>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <20040323004049.GA931@ibrium.se> <20040323104846.GZ1481@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323104846.GZ1481@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 11:48:47AM +0100, Jens Axboe wrote:
> Could you check if this works for you?
> 
> ===== drivers/block/elevator.c 1.53 vs edited =====
> --- 1.53/drivers/block/elevator.c	Mon Jan 19 07:38:36 2004
> +++ edited/drivers/block/elevator.c	Tue Mar 23 11:47:53 2004
> @@ -210,10 +210,14 @@
>  			rq = NULL;
>  			break;
>  		} else if (ret == BLKPREP_KILL) {
> +			int nr_bytes = rq->hard_nr_sectors << 9;
> +
> +			if (!nr_bytes)
> +				nr_bytes = rq->data_len;
> +
>  			blkdev_dequeue_request(rq);
>  			rq->flags |= REQ_QUIET;
> -			while (end_that_request_first(rq, 0, rq->nr_sectors))
> -				;
> +			end_that_request_chunk(rq, 0, nr_bytes);
>  			end_that_request_last(rq);
>  		} else {
>  			printk("%s: bad return=%d\n", __FUNCTION__, ret);
> 

Yes, this fixes the problem.

/Samuel
