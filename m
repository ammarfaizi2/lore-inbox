Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWESDIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWESDIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 23:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWESDIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 23:08:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:49365 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932185AbWESDIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 23:08:19 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH] sched: fix interactive ceiling code
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org
In-Reply-To: <200605191130.59282.kernel@kolivas.org>
References: <4t153d$14oruq@azsmga001.ch.intel.com>
	 <200605191130.59282.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 04:02:57 +0200
Message-Id: <1148004177.8422.6.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 11:30 +1000, Con Kolivas wrote:
> Ingo, Andrew, I think these are minor logic fixes and comments that correct 
> a patch that has already been pushed to 2.6.17- and I would like them short
> circuited to mainline if everyone is comfortable with it.
>  
> Ken, Mike can I ask you to put a signed off on this patch for your 
> contributions please?

Done.

(I hope nobody ever rolls a patch from 30 contributors;)

> Martin can I please ask for this to be put on test.kernel.org as a last
> minute sanity check? I know URLs are easier so here is the patch for 2.6.17-rc4:
> http://ck.kolivas.org/patches/crap/sched-fix_interactive_ceiling.patch
> 
> ---
> The relationship between INTERACTIVE_SLEEP and the ceiling is not perfect
> and not explicit enough. The sleep boost is not supposed to be any larger
> than without this code and the comment is not clear enough about what exactly
> it does, just the reason it does it. Fix it.
> 
> There is a ceiling to the priority beyond which tasks that only ever sleep
> for very long periods cannot surpass. Fix it.
> 
> Prevent the on-runqueue bonus logic from defeating the idle sleep logic.
> 
> Opportunity to micro-optimise.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>

Signed-off-by: Mike Galbraith <efault@gmx.de>

> 
> ---
>  kernel/sched.c |   52 +++++++++++++++++++++++++++-------------------------
>  1 files changed, 27 insertions(+), 25 deletions(-)
> 
> Index: linux-2.6.17-rc4/kernel/sched.c
> ===================================================================
> --- linux-2.6.17-rc4.orig/kernel/sched.c	2006-05-19 11:25:01.000000000 +1000
> +++ linux-2.6.17-rc4/kernel/sched.c	2006-05-19 11:25:14.000000000 +1000
> @@ -731,33 +731,35 @@ static inline void __activate_idle_task(
>  static int recalc_task_prio(task_t *p, unsigned long long now)
>  {
>  	/* Caller must always ensure 'now >= p->timestamp' */
> -	unsigned long long __sleep_time = now - p->timestamp;
> -	unsigned long sleep_time;
> +	unsigned long sleep_time = now - p->timestamp;
>  
>  	if (batch_task(p))
>  		sleep_time = 0;
> -	else {
> -		if (__sleep_time > NS_MAX_SLEEP_AVG)
> -			sleep_time = NS_MAX_SLEEP_AVG;
> -		else
> -			sleep_time = (unsigned long)__sleep_time;
> -	}
>  
>  	if (likely(sleep_time > 0)) {
>  		/*
> -		 * User tasks that sleep a long time are categorised as
> -		 * idle. They will only have their sleep_avg increased to a
> -		 * level that makes them just interactive priority to stay
> -		 * active yet prevent them suddenly becoming cpu hogs and
> -		 * starving other processes.
> +		 * This ceiling is set to the lowest priority that would allow
> +		 * a task to be reinserted into the active array on timeslice
> +		 * completion.
>  		 */
> -		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
> -				unsigned long ceiling;
> +		unsigned long ceiling = INTERACTIVE_SLEEP(p);
>  
> -				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
> -					DEF_TIMESLICE);
> -				if (p->sleep_avg < ceiling)
> -					p->sleep_avg = ceiling;
> +		if (p->mm && sleep_time > ceiling && p->sleep_avg < ceiling) {
> +			/*
> +			 * Prevents user tasks from achieving best priority
> +			 * with one single large enough sleep.
> +			 */
> +			p->sleep_avg = ceiling;
> +			/*
> +			 * Using INTERACTIVE_SLEEP() as a ceiling places a
> +			 * nice(0) task 1ms sleep away from promotion, and
> +			 * gives it 700ms to round-robin with no chance of
> +			 * being demoted.  This is more than generous, so
> +			 * mark this sleep as non-interactive to prevent the
> +			 * on-runqueue bonus logic from intervening should
> +			 * this task not receive cpu immediately.
> +			 */
> +			p->sleep_type = SLEEP_NONINTERACTIVE;
>  		} else {
>  			/*
>  			 * Tasks waking from uninterruptible sleep are
> @@ -765,12 +767,12 @@ static int recalc_task_prio(task_t *p, u
>  			 * are likely to be waiting on I/O
>  			 */
>  			if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
> -				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
> +				if (p->sleep_avg >= ceiling)
>  					sleep_time = 0;
>  				else if (p->sleep_avg + sleep_time >=
> -						INTERACTIVE_SLEEP(p)) {
> -					p->sleep_avg = INTERACTIVE_SLEEP(p);
> -					sleep_time = 0;
> +					 ceiling) {
> +						p->sleep_avg = ceiling;
> +						sleep_time = 0;
>  				}
>  			}
>  
> @@ -784,9 +786,9 @@ static int recalc_task_prio(task_t *p, u
>  			 */
>  			p->sleep_avg += sleep_time;
>  
> -			if (p->sleep_avg > NS_MAX_SLEEP_AVG)
> -				p->sleep_avg = NS_MAX_SLEEP_AVG;
>  		}
> +		if (p->sleep_avg > NS_MAX_SLEEP_AVG)
> +			p->sleep_avg = NS_MAX_SLEEP_AVG;
>  	}
>  
>  	return effective_prio(p);

