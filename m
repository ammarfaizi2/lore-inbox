Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272002AbTHDRNQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272004AbTHDRNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:13:15 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:54764
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S272002AbTHDRMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:12:07 -0400
Date: Mon, 4 Aug 2003 21:15:13 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
Message-ID: <20030804191513.GB814@wind.cocodriloo.com>
References: <200308050207.18096.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308050207.18096.kernel@kolivas.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 02:07:18AM +1000, Con Kolivas wrote:
> Changes:
> 
> Reverted the child penalty to 95 as new changes help this from hurting
> 
> Changed the logic behind loss of interactive credits to those that burn off 
> all their sleep_avg
> 
> Now all tasks get proportionately more sleep as their relative bonus drops 
> off. This has the effect of detecting a change from a cpu burner to an 
> interactive task more rapidly as in O10. 
> 
> The _major_ change in this patch is that tasks on uninterruptible sleep do not 
> earn any sleep avg during that sleep; it is not voluntary sleep so they should 
> not get it. This has the effect of stopping cpu hogs from gaining dynamic 
> priority during periods of heavy I/O. Very good for the jerks you may 
> see in X or audio skips when you start a whole swag of disk intensive cpu hogs 
> (eg make -j large number). I've simply dropped all their sleep_avg, but 
> weighting it may be more appropriate. This has the side effect that pure
> disk tasks (eg cp) have relatively low priority which is why weighting may
> be better. We shall see.
> 
> Please test this one extensively. It should _not_ affect I/O throughput per 
> se, but I'd like to see some of the I/O benchmarks on this. I do not want to 
> have detrimental effects elsewhere.
> 
> patch-O12.3-O13int applies on top of 2.6.0-test2-mm4 that has been 
> patched with O12.3int and is available on my site, and a full patch
> against 2.6.0-test2 called patch-test2-O13int is here:
> 
> http://kernel.kolivas.org/2.5
> 
> patch-O12.3-O13int:
> 
> --- linux-2.6.0-test2-mm4-O12.3/kernel/sched.c	2003-08-05 01:30:27.000000000 +1000
> +++ linux-2.6.0-test2-mm4-O13/kernel/sched.c	2003-08-05 01:36:20.000000000 +1000
> @@ -78,7 +78,7 @@
>  #define MAX_TIMESLICE		(200 * HZ / 1000)
>  #define TIMESLICE_GRANULARITY	(HZ/40 ?: 1)
>  #define ON_RUNQUEUE_WEIGHT	30
> -#define CHILD_PENALTY		90
> +#define CHILD_PENALTY		95
>  #define PARENT_PENALTY		100
>  #define EXIT_WEIGHT		3
>  #define PRIO_BONUS_RATIO	25
> @@ -365,6 +365,9 @@ static void recalc_task_prio(task_t *p, 
>  	unsigned long long __sleep_time = now - p->timestamp;
>  	unsigned long sleep_time;
>  
> +	if (!p->sleep_avg)
> +		p->interactive_credit--;
> +
>  	if (__sleep_time > NS_MAX_SLEEP_AVG)
>  		sleep_time = NS_MAX_SLEEP_AVG;
>  	else
> @@ -384,17 +387,19 @@ static void recalc_task_prio(task_t *p, 
>  					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p));
>  		else {
>  			/*
> -			 * Tasks with interactive credits get boosted more
> -			 * rapidly if their bonus has dropped off. Other
> -			 * tasks are limited to one timeslice worth of
> -			 * sleep avg.
> +			 * The lower the sleep avg a task has the more
> +			 * rapidly it will rise with sleep time. Tasks
> +			 * without interactive_credit are limited to
> +			 * one timeslice worth of sleep avg bonus.
>  			 */
> -			if (p->interactive_credit > 0)
> -				sleep_time *= (MAX_BONUS + 1 -
> +			sleep_time *= (MAX_BONUS + 1 -
>  					(NS_TO_JIFFIES(p->sleep_avg) *
>  					MAX_BONUS / MAX_SLEEP_AVG));
> -			else if (sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
> -				sleep_time = JIFFIES_TO_NS(task_timeslice(p));
> +
> +			if (p->interactive_credit < 0 &&
> +				sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
> +					sleep_time =
> +						JIFFIES_TO_NS(task_timeslice(p));
>  
>  			/*
>  			 * This code gives a bonus to interactive tasks.
> @@ -435,20 +440,26 @@ static inline void activate_task(task_t 
>  	recalc_task_prio(p, now);
>  
>  	/*
> -	 * Tasks which were woken up by interrupts (ie. hw events)
> -	 * are most likely of interactive nature. So we give them
> -	 * the credit of extending their sleep time to the period
> -	 * of time they spend on the runqueue, waiting for execution
> -	 * on a CPU, first time around:
> +	 * This checks to make sure it's not an uninterruptible task
> +	 * that is now waking up.
>  	 */
> -	if (in_interrupt())
> -		p->activated = 2;
> -	else
> -	/*
> -	 * Normal first-time wakeups get a credit too for on-runqueue time,
> -	 * but it will be weighted down:
> -	 */
> -		p->activated = 1;
> +	if (!p->activated){

[1]

> +		/*
> +		 * Tasks which were woken up by interrupts (ie. hw events)
> +		 * are most likely of interactive nature. So we give them
> +		 * the credit of extending their sleep time to the period
> +		 * of time they spend on the runqueue, waiting for execution
> +		 * on a CPU, first time around:
> +		 */
> +		if (in_interrupt())
> +			p->activated = 2;
> +		else
> +		/*
> +		 * Normal first-time wakeups get a credit too for on-runqueue
> +		 * time, but it will be weighted down:
> +		 */
> +			p->activated = 1;

[3]

> +	}
>  
>  	p->timestamp = now;
>  
> @@ -572,8 +583,15 @@ repeat_lock_task:
>  				task_rq_unlock(rq, &flags);
>  				goto repeat_lock_task;
>  			}
> -			if (old_state == TASK_UNINTERRUPTIBLE)
> +			if (old_state == TASK_UNINTERRUPTIBLE){
> +				/*
> +				 * Tasks on involuntary sleep don't earn
> +				 * sleep_avg
> +				 */
>  				rq->nr_uninterruptible--;
> +				p->timestamp = sched_clock();
> +				p->activated = -1;

[2]

> +			}
>  			if (sync)
>  				__activate_task(p, rq);
>  			else {
> @@ -1326,7 +1344,6 @@ void scheduler_tick(int user_ticks, int 
>  		p->prio = effective_prio(p);
>  		p->time_slice = task_timeslice(p);
>  		p->first_time_slice = 0;
> -		p->interactive_credit--;
>  
>  		if (!rq->expired_timestamp)
>  			rq->expired_timestamp = jiffies;
> @@ -1459,7 +1476,7 @@ pick_next_task:
>  	queue = array->queue + idx;
>  	next = list_entry(queue->next, task_t, run_list);
>  
> -	if (next->activated && next->interactive_credit > 0) {
> +	if (next->activated > 0) {
>  		unsigned long long delta = now - next->timestamp;
>  
>  		if (next->activated == 1)
> 

Con, I will probably be wrong, but in [1] you are testing
"activated != 0" and [2] is setting "activated = -1", which
_is_ != 0 and thus would enter the "if->else" branch and
do "activated = 1" in [3].

Perhaps you meant to set "activated = 0" in [2]???

Note I've not read the rest of the scheduler code,
so perhaps the "activated = 0" is in another place...
just in case, I prefer asking.

Greets for your hard work, Antonio.

-- 

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
