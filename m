Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbVJTLUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbVJTLUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 07:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbVJTLUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 07:20:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57378 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751485AbVJTLUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 07:20:21 -0400
Date: Thu, 20 Oct 2005 13:21:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 02/05] blk: update ioscheds to use generic dispatch queue
Message-ID: <20051020112109.GC2811@suse.de>
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.D377069C@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019123429.D377069C@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19 2005, Tejun Heo wrote:
> 02_blk_generic-dispatch-queue-update-for-ioscheds.patch
> 
> 	This patch updates all four ioscheds to use generic dispatch
> 	queue.  There's one behavior change in as-iosched.
> 
> 	* In as-iosched, when force dispatching
> 	  (ELEVATOR_INSERT_BACK), batch_data_dir is reset to REQ_SYNC
> 	  and changed_batch and new_batch are cleared to zero.  This
> 	  prevernts AS from doing incorrect update_write_batch after
> 	  the forced dispatched requests are finished.
> 
> 	* In cfq-iosched, cfqd->rq_in_driver currently counts the
> 	  number of activated (removed) requests to determine
> 	  whether queue-kicking is needed and cfq_max_depth has been
> 	  reached.  With generic dispatch queue, I think counting
> 	  the number of dispatched requests would be more appropriate.
> 
> 	* cfq_max_depth can be lowered to 1 again.

I applied this one as well, with some minor changes. The biggest one is
a cleanup of the 'force' logic, it seems to be a little mixed up in this
patch. You use it for forcing dispatch, which is fine. But then it also
doubles as whether you want to sort insert on the generic queue or just
add to the tail?
  
> -		if (cfq_class_idle(cfqq))
> -			max_dispatch = 1;
> +		if (force)
> +			max_dispatch = INT_MAX;
> +		else
> +			max_dispatch =
> +				cfq_class_idle(cfqq) ? 1 : cfqd->cfq_quantum;

Also, please don't use these ?: constructs, I absolutely hate them as
they are weird to read.

-- 
Jens Axboe

