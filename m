Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbUCJJCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 04:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUCJJCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 04:02:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53914 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262283AbUCJJCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 04:02:44 -0500
Date: Wed, 10 Mar 2004 10:02:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] set request fastfail bit
Message-ID: <20040310090241.GB4949@suse.de>
References: <404EB824.1030806@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404EB824.1030806@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09 2004, Mike Christie wrote:
> The first three bio and request flags are no longer identical.
> The bio barrier and rw flags are getting set in __make_request
> and get_request respectively, and failfast is getting
> left out. The attached patch (built against 2.6.4-rc3)
> sets the request's failfast flag in __make_request when the bio's
> flag is set.
> 
> Mike Chrisite

> --- linux-2.6.4-rc3-orig/drivers/block/ll_rw_blk.c	2004-03-09 22:21:26.819208694 -0800
> +++ linux-2.6.4-rc3-ff/drivers/block/ll_rw_blk.c	2004-03-09 22:37:02.395169904 -0800
> @@ -2121,11 +2121,14 @@ get_rq:
>  		goto again;
>  	}
>  
> +	req->flags |= REQ_CMD;
> +
>  	/*
> -	 * first three bits are identical in rq->flags and bio->bi_rw,
> -	 * see bio.h and blkdev.h
> +	 * inherit FAILFAST from bio and don't stack up
> +	 * retries for read ahead
>  	 */
> -	req->flags = (bio->bi_rw & 7) | REQ_CMD;
> +	if (ra || test_bit(BIO_RW_FAILFAST, &bio->bi_rw))	
> +		req->flags |= REQ_FAILFAST;
>  
>  	/*
>  	 * REQ_BARRIER implies no merging, but lets make it explicit
> @@ -2133,12 +2136,6 @@ get_rq:
>  	if (barrier)
>  		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
>  
> -	/*
> -	 * don't stack up retries for read ahead
> -	 */
> -	if (ra)
> -		req->flags |= REQ_FAILFAST;
> -
>  	req->errors = 0;
>  	req->hard_sector = req->sector = sector;
>  	req->hard_nr_sectors = req->nr_sectors = nr_sectors;

Thanks Mike, patch looks good.

-- 
Jens Axboe

