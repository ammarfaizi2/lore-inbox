Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVDTGaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVDTGaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 02:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVDTGac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 02:30:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65441 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261444AbVDTGaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 02:30:17 -0400
Date: Wed, 20 Apr 2005 08:30:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, Christoph Hellwig <hch@infradead.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 01/05] scsi: make blk layer set REQ_SOFTBARRIER when a request is dispatched
Message-ID: <20050420063009.GB9371@suse.de>
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.2DEBE102@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419231435.2DEBE102@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20 2005, Tejun Heo wrote:
> 01_scsi_blk_make_started_requests_ordered.patch
> 
> 	Reordering already started requests is without any real
> 	benefit and causes problems if the request has its
> 	driver-specific resources allocated (as in SCSI).  This patch
> 	makes elv_next_request() set REQ_SOFTBARRIER automatically
> 	when a request is dispatched.
> 
> 	As both as and cfq schedulers don't allow passing requeued
> 	requests, the only behavior change is that requests deferred
> 	by prep_fn won't be passed by other requests.  This change
> 	shouldn't cause any problem.  The only affected driver other
> 	than SCSI is i2o_block.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
>  elevator.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> Index: scsi-reqfn-export/drivers/block/elevator.c
> ===================================================================
> --- scsi-reqfn-export.orig/drivers/block/elevator.c	2005-04-20 08:13:01.000000000 +0900
> +++ scsi-reqfn-export/drivers/block/elevator.c	2005-04-20 08:13:33.000000000 +0900
> @@ -370,11 +370,11 @@ struct request *elv_next_request(request
>  
>  	while ((rq = __elv_next_request(q)) != NULL) {
>  		/*
> -		 * just mark as started even if we don't start it, a request
> -		 * that has been delayed should not be passed by new incoming
> -		 * requests
> +		 * just mark as started even if we don't start it.
> +		 * also, as a request that has been delayed should not
> +		 * be passed by new incoming requests, set softbarrier.
>  		 */
> -		rq->flags |= REQ_STARTED;
> +		rq->flags |= REQ_STARTED | REQ_SOFTBARRIER;
>  
>  		if (rq == q->last_merge)
>  			q->last_merge = NULL;

Do it on requeue, please - not on the initial spotting of the request.

-- 
Jens Axboe

