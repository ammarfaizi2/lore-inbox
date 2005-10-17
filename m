Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbVJQPLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVJQPLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVJQPLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:11:06 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:54995 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751389AbVJQPLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:11:04 -0400
Subject: Re: [patch] TASK_NONINTERACTIVE (was: Machine Freezes while
	Running Crossover Office)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601073544.GA21384@elte.hu>
References: <1117291619.9665.6.camel@localhost>
	 <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
	 <84144f0205052911202863ecd5@mail.gmail.com>
	 <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
	 <1117399764.9619.12.camel@localhost>
	 <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
	 <1117466611.9323.6.camel@localhost>
	 <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
	 <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
	 <20050601073544.GA21384@elte.hu>
Date: Mon, 17 Oct 2005 18:10:51 +0300
Message-Id: <1129561851.19040.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

On Wed, 2005-06-01 at 09:35 +0200, Ingo Molnar wrote:
> Pekka, could you check whether the patch below solves your Wine problem 
> (without hurting interactivity otherwise)?

Any chance of getting this merged to the mainline? I am on 2.6.13.4 now
and I still need to manually apply this patch to make Crossover Office
usable. I can confirm that it fixes the problem without introducing any
interactivity regressions as I have been running this for the past four
months or so.

			Pekka

> 
> ----
> 
> this patch implements a task state bit (TASK_NONINTERACTIVE), which can 
> be used by blocking points to mark the task's wait as "non-interactive".
> This does not mean the task will be considered a CPU-hog - the wait will
> simply not have an effect on the waiting task's priority - positive or
> negative alike. Right now only pipe_wait() will make use of it, because
> it's a common source of not-so-interactive waits (kernel compilation
> jobs, etc.).
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> --- linux/fs/pipe.c.orig
> +++ linux/fs/pipe.c
> @@ -39,7 +39,11 @@ void pipe_wait(struct inode * inode)
>  {
>  	DEFINE_WAIT(wait);
>  
> -	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE);
> +	/*
> +	 * Pipes are system-local resources, so sleeping on them
> +	 * is considered a noninteractive wait:
> +	 */
> +	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
>  	up(PIPE_SEM(*inode));
>  	schedule();
>  	finish_wait(PIPE_WAIT(*inode), &wait);
> --- linux/kernel/sched.c.orig
> +++ linux/kernel/sched.c
> @@ -1085,6 +1085,16 @@ out_activate:
>  	}
>  
>  	/*
> +	 * Tasks that have marked their sleep as noninteractive get
> +	 * woken up without updating their sleep average. (i.e. their
> +	 * sleep is handled in a priority-neutral manner, no priority
> +	 * boost and no penalty.)
> +	 */
> +	if (old_state & TASK_NONINTERACTIVE)
> +		__activate_task(p, rq);
> +	else
> +		activate_task(p, rq, cpu == this_cpu);
> +	/*
>  	 * Sync wakeups (i.e. those types of wakeups where the waker
>  	 * has indicated that it will leave the CPU in short order)
>  	 * don't trigger a preemption, if the woken up task will run on
> @@ -1092,7 +1102,6 @@ out_activate:
>  	 * the waker guarantees that the freshly woken up task is going
>  	 * to be considered on this CPU.)
>  	 */
> -	activate_task(p, rq, cpu == this_cpu);
>  	if (!sync || cpu != this_cpu) {
>  		if (TASK_PREEMPTS_CURR(p, rq))
>  			resched_task(rq->curr);
> --- linux/include/linux/sched.h.orig
> +++ linux/include/linux/sched.h
> @@ -112,6 +112,7 @@ extern unsigned long nr_iowait(void);
>  #define TASK_TRACED		8
>  #define EXIT_ZOMBIE		16
>  #define EXIT_DEAD		32
> +#define TASK_NONINTERACTIVE	64
>  
>  #define __set_task_state(tsk, state_value)		\
>  	do { (tsk)->state = (state_value); } while (0)

