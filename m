Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbTGDGVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 02:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbTGDGVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 02:21:03 -0400
Received: from [213.24.247.63] ([213.24.247.63]:58245 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S265792AbTGDGU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 02:20:56 -0400
Message-ID: <3F052025.5020303@relex.ru>
Date: Fri, 04 Jul 2003 10:35:17 +0400
From: Yaroslav Rastrigin <yarick@relex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030621 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O2int 0307041440 for 2.5.74-mm1
References: <200307041459.33326.kernel@kolivas.org>
In-Reply-To: <200307041459.33326.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Here is a patch against the current O1int patch in 2.5.74-mm1.
> Since the O1int didn't mean anything I thought I'd call this O2int.
> 
> This one wont blow you away but tames those corner cases.
> 
> Changes:
> The child penalty is set on 80% which means that tasks that wait on their 
> children have children forking just on the edge of the interactive delta so 
> they shouldn't starve their own children.
> 
> The non linear sleep avg boost is scaled down slightly to prevent this 
> particular boost from being capable of making a task highly interactive. This 
> makes very new tasks less likely to have a little spurt of too high priority.
> 
> Idle tasks now get their static priority over the full time they've been 
> running rather than starting again at 1 second. This makes it harder for idle 
> tasks to suddenly become highly interactive and _then_ fork an interactive 
> bomb. Not sure on this one yet.
> 
> The sched_exit penalty to parents of cpu hungry children is scaled accordingly 
> (was missed on the original conversion so works better now).
> 
> Hysteresis on interactive buffer removed (was unecessary).
> 
> Minor cleanup.
> 
> Known issue remaining:
> Mozilla acts just like X in that it is mostly interactive but has bursts of 
> heavy cpu activity so it gets the same bonus as X. However it makes X jerky 
> during it's heavy cpu activity, and might in some circumstances make audio 
> skip. Fixing this kills X smoothness as they seem very similar to the 
> estimator. Still haven't sorted a workaround for this one but I'm working on 
> it. Ingo's original timeslice granularity patch helps a little and may be 
> worth resuscitating (and the desktop only people can change the granularity 
> down to 10ms to satisfy their needs).
> 
> Con
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
> 
> iD8DBQE/BQmjF6dfvkL3i1gRAiYhAKCnpZN//FkD1iO5b2SZ6HTURMUULwCfS43B
> Pn/1kRndvUz/lnjFI+lUpEc=
> =O+VS
> -----END PGP SIGNATURE-----
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.5.74/kernel/sched.c	2003-07-04 14:30:11.000000000 +1000
> +++ linux-2.5.74-test/kernel/sched.c	2003-07-04 14:41:22.000000000 +1000
> @@ -68,7 +68,7 @@
>   */
>  #define MIN_TIMESLICE		( 10 * HZ / 1000)
>  #define MAX_TIMESLICE		(200 * HZ / 1000)
> -#define CHILD_PENALTY		50
> +#define CHILD_PENALTY		80
>  #define PARENT_PENALTY		100
>  #define EXIT_WEIGHT		3
>  #define PRIO_BONUS_RATIO	25
> @@ -405,30 +405,30 @@ static inline void activate_task(task_t 
>  		 * from continually getting larger.
>  		 */
>  		if (runtime < MAX_SLEEP_AVG)
> -			p->sleep_avg += (runtime - p->sleep_avg) * (MAX_SLEEP_AVG - runtime) / MAX_SLEEP_AVG;
> +			p->sleep_avg += (runtime - p->sleep_avg) * (MAX_SLEEP_AVG - runtime) *
> +				(10 - INTERACTIVE_DELTA) / 10 / MAX_SLEEP_AVG;
>  
>  		/*
> -		 * Keep a buffer of 10-20% bonus sleep_avg with hysteresis
> +		 * Keep a buffer of 10% sleep_avg
>  		 * to prevent short bursts of cpu activity from making
>  		 * interactive tasks lose their bonus
>  		 */
> -		if (p->sleep_avg > MAX_SLEEP_AVG * 12/10)
> +		if (p->sleep_avg > MAX_SLEEP_AVG * 11/10)
>  			p->sleep_avg = MAX_SLEEP_AVG * 11/10;
>  
>  		/*
>  		 * Tasks that sleep a long time are categorised as idle and
>  		 * get their static priority only
>  		 */
> -		if (sleep_time > MIN_SLEEP_AVG){
> -			p->avg_start = jiffies - MIN_SLEEP_AVG;
> -			p->sleep_avg = MIN_SLEEP_AVG / 2;
> -		}
> +		if (sleep_time > MIN_SLEEP_AVG)
> +			p->sleep_avg = runtime / 2;
> +
>  		if (unlikely(p->avg_start > jiffies)){
>  			p->avg_start = jiffies;
>  			p->sleep_avg = 0;
>  		}
> -		p->prio = effective_prio(p);
>  	}
> +	p->prio = effective_prio(p);
>  	__activate_task(p, rq);
>  }
>  
> @@ -605,7 +605,6 @@ void wake_up_forked_process(task_t * p)
>  	 * from forking tasks that are max-interactive.
>  	 */
>  	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
> -	p->avg_start = current->avg_start;
>  	normalise_sleep(p);
>  	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
>  	p->prio = effective_prio(p);
> @@ -647,6 +646,8 @@ void sched_exit(task_t * p)
>  	 * If the child was a (relative-) CPU hog then decrease
>  	 * the sleep_avg of the parent as well.
>  	 */
> +	normalise_sleep(p);
> +	normalise_sleep(p->parent);
>  	if (p->sleep_avg < p->parent->sleep_avg)
>  		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
>  			p->sleep_avg) / (EXIT_WEIGHT + 1);


