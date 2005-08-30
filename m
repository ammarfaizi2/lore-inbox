Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVH3WfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVH3WfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVH3We7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:34:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2300 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932142AbVH3We7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:34:59 -0400
Subject: Re: 2.6.13-rt1
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1125407163.5675.16.camel@localhost.localdomain>
References: <20050829084829.GA23176@elte.hu>
	 <1125372830.6096.7.camel@localhost.localdomain>
	 <20050830055321.GB5743@elte.hu>
	 <1125407163.5675.16.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 30 Aug 2005 15:34:34 -0700
Message-Id: <1125441274.18150.39.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have you tried turning on 
"Non-preemptible critical section latency timing" or "Latency tracing"

I don't know if it's related to the PI changes, but I'm getting a crash
with those on em64t .

With both above options I get

<0>init[1]: segfault at ffffffff8010ef44 rip ffffffff8010ef44 rsp 00007fffferror 5
<0>init[1]: segfault at ffffffff8010ef44 rip ffffffff8010ef44 rsp 00007ffffffe8de8 error 5

printed never ending right after init starts.

If I only turn on "Non-preemptible critical section latency timing",
then when I enter the command,
"echo 0 > /proc/sys/kernel/preempt_max_latency"

The kernel will spit out a couple of max critical section updates , then
it will hang silently.

This is all new in 2.6.13-rtX . It could have just come in with 2.6.13 ,
but I thought I'd mention it.

Daniel

On Tue, 2005-08-30 at 09:06 -0400, Steven Rostedt wrote:
> Hi Ingo,
> 
> Looks like the BKL is a little more complicated than what I first sent.
> I've been analyzing the logic and found that there's a point in time
> where the BKL->P1->L1->P2->BKL can exist without any of the spinlocks
> protecting it.  That is after P1 blocks on L1 but before it schedules
> out and releases the BKL.  In this time another process on another CPU
> could loop here.
> 
> The supplied patch fixes this.
> 
> Also, I need to look more into the logic of __up to see if the BKL can't
> cause a deadlock with the grabbing and releasing of locks there.  So I
> might be sending more patches to clean this up.
> 
> Do me a favor, and just take a quick look at the logic here, and make
> sure that the situation is OK to break there, and that there won't be
> any other side-effects, wrt. priority leaks.
> 
> Thanks,
> 
> -- Steve
> 
> Patch is against rt2
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux_realtime_goliath/kernel/rt.c
> ===================================================================
> --- linux_realtime_goliath/kernel/rt.c	(revision 310)
> +++ linux_realtime_goliath/kernel/rt.c	(working copy)
> @@ -760,11 +760,12 @@
>   */
>  static void pi_setprio(struct rt_mutex *lock, struct task_struct *task, int prio)
>  {
> -	struct rt_mutex *l = lock;
> -	struct task_struct *p = task;
>  	/*
>  	 * We don't want to release the parameters locks.
>  	 */
> +	struct rt_mutex *l = lock;
> +	struct task_struct *p = task;
> +	int bkl = 0;
>  
>  	if (unlikely(!p->pid)) {
>  		pi_null++;
> @@ -800,7 +801,7 @@
>  #endif
>  
>  		mutex_setprio(p, prio);
> -		if (!w)
> +		if (!w || unlikely(bkl))
>  			break;
>  		/*
>  		 * If the task is blocked on a lock, and we just made
> @@ -817,18 +818,31 @@
>  		TRACE_BUG_ON_LOCKED(!lock);
>  
>  		/*
> -		 * The BKL can really be a pain.  It can happen that the lock
> -		 * we are blocked on is owned by a task that is waiting for
> -		 * the BKL, and we own it.  So, if this is the BKL and we own
> -		 * it, then end the loop here.
> +		 * The BKL can really be a pain. It can happen where the
> +		 * BKL is being held by one task that is just about to 
> +		 * block on another task that is waiting for the BKL.
> +		 * This isn't a deadlock, since the BKL is released
> +		 * when the task goes to sleep.  This also means that
> +		 * all holders of the BKL are not blocked, or are just
> +		 * about to be blocked.
> +		 *
> +		 * Another side-effect of this is that there's a small
> +		 * window where the spinlocks are not held, and the blocked
> +		 * process hasn't released the BKL.  So if we are going
> +		 * to boost the owner of the BKL, stop after that,
> +		 * since that owner is either running, or about to sleep
> +		 * but don't go any further or we are in a loop.
>  		 */
> -		if (unlikely(l == &kernel_sem.lock) && lock_owner(l) == current_thread_info()) {
> -			/*
> -			 * No locks are held for locks, so fool the unlocking code
> -			 * by thinking the last lock was the original.
> -			 */
> -			l = lock;
> -			break;
> +		if (unlikely(l == &kernel_sem.lock)) {
> +			if (lock_owner(l) == current_thread_info()) {
> +				/*
> +				 * No locks are held for locks, so fool the unlocking code
> +				 * by thinking the last lock was the original.
> +				 */
> +				l = lock;
> +				break;
> +			}
> +			bkl = 1;
>  		}
>  
>  		if (l != lock)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

