Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWFVOV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWFVOV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWFVOV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:21:29 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:12930 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751799AbWFVOV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:21:28 -0400
Date: Thu, 22 Jun 2006 10:20:59 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Thomas Gleixner <tglx@linutronix.de>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/3] rtmutex: Propagate priority settings into PI lock
 chains
In-Reply-To: <20060622082812.607857000@cruncher.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0606220959490.15236@gandalf.stny.rr.com>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
 <20060622082812.607857000@cruncher.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've stated these comments on the -rt thread, but it's more important to
repeat them here.

On Thu, 22 Jun 2006, Thomas Gleixner wrote:

>  /*
> + * Recheck the pi chain, in case we got a priority setting
> + *
> + * Called from sched_setscheduler
> + */
> +void rt_mutex_adjust_pi(struct task_struct *task)
> +{
> +	struct rt_mutex_waiter *waiter;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&task->pi_lock, flags);
> +
> +	waiter = task->pi_blocked_on;

Good to see you fixed the waiter race that I mentioned in the other
thread.  You did it before I mentioned it, but I didn't read this yet ;)

> +	if (!waiter || waiter->list_entry.prio == task->prio) {
> +		spin_unlock_irqrestore(&task->pi_lock, flags);
> +		return;
> +	}
> +
> +	/* gets dropped in rt_mutex_adjust_prio_chain()! */
> +	get_task_struct(task);
> +	spin_unlock_irqrestore(&task->pi_lock, flags);
> +
> +	rt_mutex_adjust_prio_chain(task, 0, NULL, NULL, task);

The above means that you cant ever call sched_setscheduler from a
interrupt handler (or softirq).  The rt_mutex_adjust_prio_chain since that
grabs wait_lock which is not for interrupt use.

> +}
> +
> +/*
>   * Slow path lock function:
>   */
>  static int __sched
> @@ -633,6 +663,7 @@
>  			if (unlikely(ret))
>  				break;
>  		}
> +
>  		spin_unlock(&lock->wait_lock);
>
>  		debug_rt_mutex_print_deadlock(&waiter);

[...]

>
>  extern void set_user_nice(task_t *p, long nice);
> Index: linux-2.6.17-mm/kernel/sched.c
> ===================================================================
> --- linux-2.6.17-mm.orig/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
> +++ linux-2.6.17-mm/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200

Oh and Thomas...

  export QUILT_DIFF_OPTS='-p'

> @@ -4119,6 +4119,8 @@

Can sched_setscheduler be called from interrupt context?

>  	__task_rq_unlock(rq);
>  	spin_unlock_irqrestore(&p->pi_lock, flags);
>
> +	rt_mutex_adjust_pi(p);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sched_setscheduler);

I haven't found any place that this was called from interrupt context, but
with this added, it can not be.  So it should be documented that
sched_setscheduler grabs locks that are not to be called from interrupt
context.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc4-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/kernel/sched.c	2006-06-22 10:13:50.000000000 -0400
+++ linux-2.6.17-rc4-mm1/kernel/sched.c	2006-06-22 10:15:09.000000000 -0400
@@ -4006,6 +4006,10 @@ static void __setscheduler(struct task_s
  * @p: the task in question.
  * @policy: new policy.
  * @param: structure containing the new RT priority.
+ *
+ *  Do not call this from interrupt context.  If RT_MUTEXES is configured
+ *  then it can grab spin locks that are not protected with interrupts
+ *  disabled.
  */
 int sched_setscheduler(struct task_struct *p, int policy,
 		       struct sched_param *param)
