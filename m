Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTKGWWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTKGWV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:21:58 -0500
Received: from fmr05.intel.com ([134.134.136.6]:37561 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264486AbTKGRGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 12:06:41 -0500
Subject: Re: [PATCH] SMP signal latency fix up.
From: Mark Gross <mgross@linux.co.intel.com>
Reply-To: mgross@linux.co.intel.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Gross <mgross@linux.co.intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0311070918310.18447@earth>
References: <Pine.LNX.4.44.0311061510440.1842-100000@home.osdl.org>
	 <Pine.LNX.4.56.0311070918310.18447@earth>
Content-Type: text/plain
Organization: TSP
Message-Id: <1068224623.1746.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Nov 2003 09:03:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is very close to mine.  It fixes that bug I had with my
change to success, and it adds a test to check if the kick target is
current.  

Its hard for me to tell if its better to being more careful with
throughing around the IPI's at the cost of the extra opperations within
your kick code.

Looks correct, and works good too!  I just verified that it solves my
signal latency issue on both my HT system and my dual PIII box. Where I
first found the problem.

FWIW  I would like to see your patch go into 2.6.  

Thanks!


On Fri, 2003-11-07 at 01:39, Ingo Molnar wrote:

> but i fully agree with your other suggestion - there's no problem with
> sending the IPI later and outside of the wakeup spinlock. In fact doing so
> removes a variable from the wakeup hotpath and cleans up stuff. Hence i'd
> suggest to apply the attached patch which implements your suggestion. I've
> tested it and it solves the latency problem of the code Mark posted. It
> compiles & boots on both UP and SMP x86.
> 
> 	Ingo
> 
> --- linux/include/linux/sched.h.orig	
> +++ linux/include/linux/sched.h	
> @@ -574,7 +574,11 @@ extern void do_timer(struct pt_regs *);
>  
>  extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
>  extern int FASTCALL(wake_up_process(struct task_struct * tsk));
> -extern int FASTCALL(wake_up_process_kick(struct task_struct * tsk));
> +#ifdef CONFIG_SMP
> + extern void FASTCALL(kick_process(struct task_struct * tsk));
> +#else
> + static inline void kick_process(struct task_struct *tsk) { }
> +#endif
>  extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
>  extern void FASTCALL(sched_exit(task_t * p));
>  
> --- linux/kernel/sched.c.orig	
> +++ linux/kernel/sched.c	
> @@ -530,6 +530,15 @@ static inline void resched_task(task_t *
>  #endif
>  }
>  
> +/**
> + * task_curr - is this task currently executing on a CPU?
> + * @p: the task in question.
> + */
> +inline int task_curr(task_t *p)
> +{
> +	return cpu_curr(task_cpu(p)) == p;
> +}
> +
>  #ifdef CONFIG_SMP
>  
>  /*
> @@ -568,6 +577,27 @@ repeat:
>  	task_rq_unlock(rq, &flags);
>  	preempt_enable();
>  }
> +
> +/***
> + * kick_process - kick a running thread to enter/exit the kernel
> + * @p: the to-be-kicked thread
> + *
> + * Cause a process which is running on another CPU to enter
> + * kernel-mode, without any delay. (to get signals handled.)
> + */
> +void kick_process(task_t *p)
> +{
> +	int cpu;
> +
> +	preempt_disable();
> +	cpu = task_cpu(p);
> +	if ((cpu != smp_processor_id()) && task_curr(p))
> +		smp_send_reschedule(cpu);
> +	preempt_enable();
> +}
> +
> +EXPORT_SYMBOL_GPL(kick_process);
> +
>  #endif
>  
>  /***
> @@ -575,7 +605,6 @@ repeat:
>   * @p: the to-be-woken-up thread
>   * @state: the mask of task states that can be woken
>   * @sync: do a synchronous wakeup?
> - * @kick: kick the CPU if the task is already running?
>   *
>   * Put it on the run-queue if it's not already there. The "current"
>   * thread is always on the run-queue (except when the actual
> @@ -585,7 +614,7 @@ repeat:
>   *
>   * returns failure only if the task is already active.
>   */
> -static int try_to_wake_up(task_t * p, unsigned int state, int sync, int kick)
> +static int try_to_wake_up(task_t * p, unsigned int state, int sync)
>  {
>  	unsigned long flags;
>  	int success = 0;
> @@ -626,33 +655,22 @@ repeat_lock_task:
>  			}
>  			success = 1;
>  		}
> -#ifdef CONFIG_SMP
> -	       	else
> -			if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> -				smp_send_reschedule(task_cpu(p));
> -#endif
>  		p->state = TASK_RUNNING;
>  	}
>  	task_rq_unlock(rq, &flags);
>  
>  	return success;
>  }
> -
>  int wake_up_process(task_t * p)
>  {
> -	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 0);
> +	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
>  }
>  
>  EXPORT_SYMBOL(wake_up_process);
>  
> -int wake_up_process_kick(task_t * p)
> -{
> -	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 1);
> -}
> -
>  int wake_up_state(task_t *p, unsigned int state)
>  {
> -	return try_to_wake_up(p, state, 0, 0);
> +	return try_to_wake_up(p, state, 0);
>  }
>  
>  /*
> @@ -1621,7 +1639,7 @@ EXPORT_SYMBOL(preempt_schedule);
>  int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
>  {
>  	task_t *p = curr->task;
> -	return try_to_wake_up(p, mode, sync, 0);
> +	return try_to_wake_up(p, mode, sync);
>  }
>  
>  EXPORT_SYMBOL(default_wake_function);
> @@ -1942,15 +1960,6 @@ int task_nice(task_t *p)
>  EXPORT_SYMBOL(task_nice);
>  
>  /**
> - * task_curr - is this task currently executing on a CPU?
> - * @p: the task in question.
> - */
> -int task_curr(task_t *p)
> -{
> -	return cpu_curr(task_cpu(p)) == p;
> -}
> -
> -/**
>   * idle_cpu - is a given cpu idle currently?
>   * @cpu: the processor in question.
>   */
> --- linux/kernel/signal.c.orig	
> +++ linux/kernel/signal.c	
> @@ -538,8 +538,9 @@ int dequeue_signal(struct task_struct *t
>  inline void signal_wake_up(struct task_struct *t, int resume)
>  {
>  	unsigned int mask;
> +	int woken;
>  
> -	set_tsk_thread_flag(t,TIF_SIGPENDING);
> +	set_tsk_thread_flag(t, TIF_SIGPENDING);
>  
>  	/*
>  	 * If resume is set, we want to wake it up in the TASK_STOPPED case.
> @@ -551,10 +552,11 @@ inline void signal_wake_up(struct task_s
>  	mask = TASK_INTERRUPTIBLE;
>  	if (resume)
>  		mask |= TASK_STOPPED;
> -	if (t->state & mask) {
> -		wake_up_process_kick(t);
> -		return;
> -	}
> +	woken = 0;
> +	if (t->state & mask)
> +		woken = wake_up_state(t, mask);
> +	if (!woken)
> +		kick_process(t);
>  }
>  
>  /*

