Return-Path: <linux-kernel-owner+w=401wt.eu-S965058AbWLTNrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWLTNrF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWLTNrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:47:05 -0500
Received: from brick.kernel.dk ([62.242.22.158]:29090 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965058AbWLTNrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:47:02 -0500
Date: Wed, 20 Dec 2006 14:48:49 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be called  from interrupt context
Message-ID: <20061220134848.GF10535@kernel.dk>
References: <20061219.171119.18572687.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219.171119.18572687.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19 2006, Kiyoshi Ueda wrote:
> Currently, blk_get_request() is not ready for being called from
> interrupt context because it enables interrupt forcibly in it.
> 
> Request-based device-mapper sometimes needs to get a request
> in interrupt context to create a clone.
> Calling blk_get_request() from interrupt context should be OK
> because blk_get_request() returns NULL without sleep if no memory
> unless __GFP_WAIT mask is specified, and then the interrupt context
> can plug queue to retry after and return immediately.
> 
> So this patch allows blk_get_request() to be called from interrupt
> context by save/restore current state of irq.
> 
> 
> Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> 
> diff -rupN 2.6.19.1/block/ll_rw_blk.c 1-blk-get-request-irqrestore/block/ll_rw_blk.c
> --- 2.6.19.1/block/ll_rw_blk.c	2006-12-11 14:32:53.000000000 -0500
> +++ 1-blk-get-request-irqrestore/block/ll_rw_blk.c	2006-12-15 10:21:29.000000000 -0500
> @@ -2064,9 +2064,10 @@ static void freed_request(request_queue_
>   * Get a free request, queue_lock must be held.
>   * Returns NULL on failure, with queue_lock held.
>   * Returns !NULL on success, with queue_lock *not held*.
> + * If flags is given, the irq state is kept when unlocking the queue_lock.
>   */
>  static struct request *get_request(request_queue_t *q, int rw, struct bio *bio,
> -				   gfp_t gfp_mask)
> +				   gfp_t gfp_mask, unsigned long *flags)
>  {
>  	struct request *rq = NULL;
>  	struct request_list *rl = &q->rq;
> @@ -2119,7 +2120,10 @@ static struct request *get_request(reque
>  	if (priv)
>  		rl->elvpriv++;
>  
> -	spin_unlock_irq(q->queue_lock);
> +	if (flags)
> +		spin_unlock_irqrestore(q->queue_lock, *flags);
> +	else
> +		spin_unlock_irq(q->queue_lock);

Big NACK on this - it's not only really ugly, it's also buggy to pass
interrupt flags as function arguments. As you also mention in the 0/1
mail, this also breaks CFQ.

Why do you need in-interrupt request allocation?

-- 
Jens Axboe

