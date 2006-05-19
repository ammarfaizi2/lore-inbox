Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWESOhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWESOhr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 10:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWESOhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 10:37:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:48790 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751092AbWESOhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 10:37:46 -0400
Message-Id: <4t16i2$14qld0@orsmga001.jf.intel.com>
X-IronPort-AV: i="4.05,146,1146466800"; 
   d="scan'208"; a="38622624:sNHT73693368"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: "Mike Galbraith" <efault@gmx.de>, <tim.c.chen@linux.intel.com>,
       <linux-kernel@vger.kernel.org>, <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, <mbligh@mbligh.org>
Subject: RE: [PATCH] sched: fix interactive ceiling code
Date: Fri, 19 May 2006 07:37:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcZ64+wMWcKzlp8PQR6E5FGOJkarYQAbJ4qw
In-Reply-To: <200605191130.59282.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Thursday, May 18, 2006 6:31 PM
> Ingo, Andrew, I think these are minor logic fixes and comments that correct 
> a patch that has already been pushed to 2.6.17- and I would like them short
> circuited to mainline if everyone is comfortable with it.
>  
> Ken, Mike can I ask you to put a signed off on this patch for your 
> contributions please?

Yup, looks good. Thanks for all the explanation and certainly your patience.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>



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
> -- 
> -ck
