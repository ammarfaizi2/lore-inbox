Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUEFGUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUEFGUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 02:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUEFGUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 02:20:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63115 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261673AbUEFGUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 02:20:32 -0400
Date: Thu, 6 May 2004 08:20:28 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cache queue_congestion_on/off_threshold
Message-ID: <20040506062028.GB10069@suse.de>
References: <200405052212.i45MC0F28121@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405052212.i45MC0F28121@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05 2004, Chen, Kenneth W wrote:
> It's kind of redundant that queue_congestion_on/off_threshold gets
> calculated on every I/O and they produce the same number over and
> over again unless q->nr_requests gets changed (which is probably a
> very rare event).  Can we cache those values in the request_queue
> structure?
> 
> - Ken
> 
> 
> diff -Nurp linux-2.6.6-rc3/drivers/block/ll_rw_blk.c linux-2.6.6-rc3.blk/drivers/block/ll_rw_blk.c
> --- linux-2.6.6-rc3/drivers/block/ll_rw_blk.c	2004-05-05 14:32:31.000000000 -0700
> +++ linux-2.6.6-rc3.blk/drivers/block/ll_rw_blk.c	2004-05-05 15:04:59.000000000 -0700
> @@ -70,14 +70,7 @@ EXPORT_SYMBOL(blk_max_pfn);
>   */
>  static inline int queue_congestion_on_threshold(struct request_queue *q)
>  {
> -	int ret;
> -
> -	ret = q->nr_requests - (q->nr_requests / 8) + 1;
> -
> -	if (ret > q->nr_requests)
> -		ret = q->nr_requests;
> -
> -	return ret;
> +	return q->nr_congestion_on;
>  }
> 
>  /*
> @@ -85,14 +78,22 @@ static inline int queue_congestion_on_th
>   */
>  static inline int queue_congestion_off_threshold(struct request_queue *q)
>  {
> -	int ret;
> +	return q->nr_congestion_off;
> +}
> 
> -	ret = q->nr_requests - (q->nr_requests / 8) - 1;
> +static inline void blk_queue_congestion_threshold(struct request_queue *q)
> +{
> +	int nr;
> 
> -	if (ret < 1)
> -		ret = 1;
> +	nr = q->nr_requests - (q->nr_requests / 8) + 1;
> +	if (nr > q->nr_requests)
> +		nr = q->nr_requests;
> +	q->nr_congestion_on = nr;
> 
> -	return ret;
> +	nr = q->nr_requests - (q->nr_requests / 8) - 1;
> +	if (nr < 1)
> +		nr = 1;
> +	q->nr_congestion_off = nr;
>  }
> 
>  void clear_backing_dev_congested(struct backing_dev_info *bdi, int rw)
> @@ -235,6 +236,7 @@ void blk_queue_make_request(request_queu
>  	blk_queue_max_sectors(q, MAX_SECTORS);
>  	blk_queue_hardsect_size(q, 512);
>  	blk_queue_dma_alignment(q, 511);
> +	blk_queue_congestion_threshold(q);
> 
>  	q->unplug_thresh = 4;		/* hmm */
>  	q->unplug_delay = (3 * HZ) / 1000;	/* 3 milliseconds */
> @@ -2953,6 +2955,7 @@ queue_requests_store(struct request_queu
>  	int ret = queue_var_store(&q->nr_requests, page, count);
>  	if (q->nr_requests < BLKDEV_MIN_RQ)
>  		q->nr_requests = BLKDEV_MIN_RQ;
> +	blk_queue_congestion_threshold(q);
> 
>  	if (rl->count[READ] >= queue_congestion_on_threshold(q))
>  		set_queue_congested(q, READ);
> diff -Nurp linux-2.6.6-rc3/include/linux/blkdev.h linux-2.6.6-rc3.blk/include/linux/blkdev.h
> --- linux-2.6.6-rc3/include/linux/blkdev.h	2004-04-27 18:35:21.000000000 -0700
> +++ linux-2.6.6-rc3.blk/include/linux/blkdev.h	2004-05-05 15:04:59.000000000 -0700
> @@ -334,6 +334,8 @@ struct request_queue
>  	 * queue settings
>  	 */
>  	unsigned long		nr_requests;	/* Max # of requests */
> +	unsigned int		nr_congestion_on;
> +	unsigned int		nr_congestion_off;
> 
>  	unsigned short		max_sectors;
>  	unsigned short		max_phys_segments;

Do you have any numbers at all for this? I'd say these calculations are
severly into the noise area when submitting io.

-- 
Jens Axboe

