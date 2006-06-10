Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWFJGtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWFJGtr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 02:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWFJGtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 02:49:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50373 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932404AbWFJGtq (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Sat, 10 Jun 2006 02:49:46 -0400
Date: Sat, 10 Jun 2006 08:48:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kerneL@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Message-ID: <20060610064850.GA11002@elte.hu>
References: <200606091701.55185.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606091701.55185.dvhltc@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=AWL,BAYES_80 autolearn=no SpamAssassin version=3.0.3
	2.0 BAYES_80               BODY: Bayesian spam probability is 80 to 95%
	[score: 0.9302]
	-1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <dvhltc@us.ibm.com> wrote:

> @@ -1543,6 +1543,17 @@ static int try_to_wake_up(task_t *p, uns
>  		}
>  	}
>  
> +	/*
> +	 * XXX  Don't send RT task elsewhere unless it can preempt current
> +	 * XXX  on other CPU.  Better yet would be for awakened RT tasks to
> +	 * XXX  examine this(and all other) CPU(s) to see what is the best
> +	 * XXX  fit.  For example there is no check here to see if the
> +	 * XXX  currently running task can be preempted (which would be the
> +	 * XXX  ideal case).
> +	 */
> +	if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq))
> +		goto out_set_cpu;
> +

Great testcase! Note that we already do RT-overload wakeups further 
below:

                /*
                 * If a newly woken up RT task cannot preempt the
                 * current (RT) task then try to find another
                 * CPU it can preempt:
                 */
                if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq)) {
                        smp_send_reschedule_allbutself();
                        rt_overload_wakeup++;
                }

what i think happened is that the above logic misses the case you have 
described in detail, and doesnt mark the current CPU for rescheduling. 

I.e. it sends an IPI to all _other_ CPUs, including the 'wrong target' - 
but it doesnt mark the current CPU for reschedule - hence if the current 
CPU is the only right target we might fail to handle this task!

could you try the (untested) patch below, does it solve your testcase 
too?

	Ingo

Index: linux-rt.q/kernel/sched.c
===================================================================
--- linux-rt.q.orig/kernel/sched.c
+++ linux-rt.q/kernel/sched.c
@@ -1587,11 +1587,15 @@ out_set_cpu:
 	} else {
 		/*
 		 * If a newly woken up RT task cannot preempt the
-		 * current (RT) task then try to find another
-		 * CPU it can preempt:
+		 * current (RT) task (on a target runqueue) then try
+		 * to find another CPU it can preempt:
 		 */
 		if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq)) {
 			smp_send_reschedule_allbutself();
+			/*
+			 * Trigger a reschedule check on the current CPU too:
+			 */
+			set_tsk_need_resched(current);
 			rt_overload_wakeup++;
 		}
 	}
