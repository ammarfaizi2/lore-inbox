Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTFFQhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTFFQhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:37:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261998AbTFFQht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:37:49 -0400
Date: Fri, 6 Jun 2003 09:51:53 -0700
From: Dave Olien <dmo@osdl.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: DAC960 crash dequeueing request
Message-ID: <20030606165153.GA20224@osdl.org>
References: <20030604220415.GA15621@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604220415.GA15621@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mary,

How's this for a response to Andrew and lkml?

------------------------------------------------------------------------

Andrew,

After running several iterations of the database workload, it seems
the patch below did indeed eliminate the BUG() we were hitting.

In addition, the patched kernel seems to perform somwhat better.
The workload performance is improved by about 2%, and the standard
deviation in performance between iterations of the work load was reduced
from 137 to 48.

A performance results comparison can be found at

http://www.osdl.org/projects/dbt2dev/results/8way/70AKPM/results.html

Thanks to Mary Meredith  <maryedie@osdl.org> for the performance
measurements and comparisons, and for hitting the BUG() in the first place.

Andrew Morton wrote:
> 
> Dave Olien wrote:
> > 
> > In linux 2.5.70, with no patches applied, we've had one BUG of the form:
> > 
> > kernel BUG at include/linux/blkdev.h:407!
> 
> 
> 
> The below should fix it.
> 
> 
> diff -puN drivers/block/deadline-iosched.c~deadline-hash-removal-fix drivers/block/deadline-iosched.c
> --- 25/drivers/block/deadline-iosched.c~deadline-hash-removal-fix	2003-06-04 00:50:36.000000000 -0700
> +++ 25-akpm/drivers/block/deadline-iosched.c	2003-06-04 00:50:36.000000000 -0700
> @@ -121,6 +121,15 @@ static inline void deadline_del_drq_hash
>  		__deadline_del_drq_hash(drq);
>  }
>  
> +static void
> +deadline_remove_merge_hints(request_queue_t *q, struct deadline_rq *drq)
> +{
> +	deadline_del_drq_hash(drq);
> +
> +	if (q->last_merge == &drq->request->queuelist)
> +		q->last_merge = NULL;
> +}
> +
>  static inline void
>  deadline_add_drq_hash(struct deadline_data *dd, struct deadline_rq *drq)
>  {
> @@ -310,7 +319,7 @@ static void deadline_remove_request(requ
>  		struct deadline_data *dd = q->elevator.elevator_data;
>  
>  		list_del_init(&drq->fifo);
> -		deadline_del_drq_hash(drq);
> +		deadline_remove_merge_hints(q, drq);
>  		deadline_del_drq_rb(dd, drq);
>  	}
>  }
> 
> _
> 
> ----- End forwarded message -----
> 
> --=-OFfR5BGtLWFFgyRX7TNt--

