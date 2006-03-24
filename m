Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWCXLiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWCXLiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWCXLiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:38:13 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:3278 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932078AbWCXLiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:38:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
Date: Fri, 24 Mar 2006 22:37:36 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1143198208.7741.8.camel@homer>
In-Reply-To: <1143198208.7741.8.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603242237.38100.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 22:03, Mike Galbraith wrote:
> Greetings,

/me waves

> Ignore timewarps caused by SMP timestamp rounding.  Also, don't stamp a
> task with a computed timestamp, stamp with the already called clock.

Looks good. Actually now < p->timestamp is not going to only happen on SMP. 
Once every I don't know how often the sched_clock seems to return a value 
that appears to have been in the past (I believe Peter has instrumented 
this).

> Signed-off-by: Mike Galbraith <efault@gmx.de>

> +		__sleep_time = 0ULL;

I don't think the ULL is necessary.

> -	unsigned long long now;
> +	unsigned long long now, comp;
>
> -	now = sched_clock();
> +	now = comp = sched_clock();
>  #ifdef CONFIG_SMP
>  	if (!local) {
>  		/* Compensate for drifting sched_clock */
>  		runqueue_t *this_rq = this_rq();
> -		now = (now - this_rq->timestamp_last_tick)
> +		comp = (now - this_rq->timestamp_last_tick)
>  			+ rq->timestamp_last_tick;
>  	}
>  #endif
>
>  	if (!rt_task(p))
> -		p->prio = recalc_task_prio(p, now);
> +		p->prio = recalc_task_prio(p, comp);

Seems wasteful of a very expensive (on 32bit) unsigned long long on 
uniprocessor builds.

Cheers,
Con
