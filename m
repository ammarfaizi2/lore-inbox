Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSEZWSB>; Sun, 26 May 2002 18:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316159AbSEZWSA>; Sun, 26 May 2002 18:18:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17392 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316158AbSEZWR7>; Sun, 26 May 2002 18:17:59 -0400
Subject: Re: O(1) count_active_tasks()
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@transmeta.com
In-Reply-To: <20020526035115.GM14918@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 May 2002 15:17:52 -0700
Message-Id: <1022451477.20316.24.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-05-25 at 20:51, William Lee Irwin III wrote:
> rml, I heard you're interested in this, but regardless, here it is.
> AFAICT it computes a faithful load average. Against latest 2.5.18 bk.
> rml, don't worry about stomping on this if you need the counters
> ticking for something else and you can do the same thing(s).

I like.  Very clean.

One question...

>  	rq = task_rq_lock(p, &flags);
> +	if (p->state == TASK_UNINTERRUPTIBLE)
> +		uninterruptible = 1;
>  	p->state = TASK_RUNNING;
>  	if (!p->array) {
> +		if (uninterruptible)
> +			rq->nr_uninterruptible--;
>  		activate_task(p, rq);
>  		if (p->prio < rq->curr->prio)
>  			resched_task(rq->curr);

Why only decrement nr_uninterruptible if it is not already on a
runqueue?  I suspect because then you assume it is a spurious wakeup and
did not have a corresponding deactivate_task?  Same reason we increment
nr_running in activate_task and not here, I suspect... makes sense.

One thought on a quick way to test if the new method is returning
accurate results would be to leave the current count_active_task code
and then add:

	if (nr != (nr_running() + nr_uninterruptible()))
		printk("Danger Will Robinson!\n");

but you probably already did something similar.

	Robert Love

