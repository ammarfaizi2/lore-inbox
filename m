Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318546AbSHPQrV>; Fri, 16 Aug 2002 12:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318552AbSHPQrV>; Fri, 16 Aug 2002 12:47:21 -0400
Received: from wasala.fi ([212.50.129.162]:8463 "EHLO wasala.fi")
	by vger.kernel.org with ESMTP id <S318546AbSHPQrU>;
	Fri, 16 Aug 2002 12:47:20 -0400
Date: Fri, 16 Aug 2002 19:50:57 +0300
From: Antti Salmela <asalmela@iki.fi>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.20-pre1-ac3, SMP (Dual PIII)
Message-ID: <20020816195057.A26010@wasala.fi>
References: <20020814145454.A21254@wasala.fi> <1029328630.26226.21.camel@irongate.swansea.linux.org.uk> <20020814161037.A22388@wasala.fi> <1029331629.26227.36.camel@irongate.swansea.linux.org.uk> <20020814185505.A23923@wasala.fi> <20020814173057.18028.qmail@thales.mathematik.uni-ulm.de> <1029375182.28236.31.camel@irongate.swansea.linux.org.uk> <20020816141718.4766.qmail@thales.mathematik.uni-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020816141718.4766.qmail@thales.mathematik.uni-ulm.de>; from ehrhardt@mathematik.uni-ulm.de on Fri, Aug 16, 2002 at 04:17:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 04:17:18PM +0200, Christian Ehrhardt wrote:
> On Thu, Aug 15, 2002 at 02:33:02AM +0100, Alan Cox wrote:
> > Thanks - your analysis is informative to say the least. It looks like
> > the PIV load balancing code is the problem. 
> 
> The (untested) patch below should correct this problem along with
> a locking oddity (last hunk) that IMHO either needs fixing or a BIG
> comment. Be prepared for a few (up to 4) lines of fuzz due to additional
> BUG_ONs in both versions of the file.

With this patch I could boot 2.4.20-pre2-ac3 and it has now run nearly an
hour without any problems.

>      regards   Christian Ehrhardt
> 
> [1] http://www.atnf.csiro.au/people/rgooch/benchmarks/linux-scheduler.html
> 
> 
> --- /usr/src/linux-2.4.20-pre1-ac3/kernel/sched.c	Thu Aug 15 20:03:01 2002
> +++ sched.c	Fri Aug 16 16:15:57 2002
> @@ -769,7 +772,7 @@
>  			set_tsk_need_resched(p);
>  
>  			/* put it at the end of the queue: */
> -			dequeue_task(p, rq->active);
> +			dequeue_task(p, p->array);
>  			enqueue_task(p, rq->active);
>  		}
>  		goto out;
> @@ -785,7 +788,7 @@
>  	if (p->sleep_avg)
>  		p->sleep_avg--;
>  	if (!--p->time_slice) {
> -		dequeue_task(p, rq->active);
> +		dequeue_task(p, p->array);
>  		set_tsk_need_resched(p);
>  		p->prio = effective_prio(p);
>  		p->time_slice = TASK_TIMESLICE(p);
> @@ -1396,7 +1399,7 @@
>  	 */
>  	if (likely(current->prio == MAX_PRIO-1)) {
>  		if (current->time_slice <= 1) {
> -			dequeue_task(current, rq->active);
> +			dequeue_task(current, array);
>  			enqueue_task(current, rq->expired);
>  		} else
>  			current->time_slice--;
> @@ -1411,7 +1414,7 @@
>  		list_add_tail(&current->run_list, array->queue + current->prio);
>  		__set_bit(current->prio, array->bitmap);
>  	}
> -	spin_unlock(&rq->lock);
> +	rq_unlock (rq);
>  
>  	schedule();
>  

-- 
Antti Salmela
