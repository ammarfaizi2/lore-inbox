Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278422AbRJSOcP>; Fri, 19 Oct 2001 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278423AbRJSOcF>; Fri, 19 Oct 2001 10:32:05 -0400
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:18759 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S278422AbRJSOby>; Fri, 19 Oct 2001 10:31:54 -0400
Date: Fri, 19 Oct 2001 08:31:41 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] A try for a more fair scheduler ...
Message-ID: <20011019083141.A10035@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
In-Reply-To: <Pine.LNX.4.40.0110181724230.970-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.40.0110181724230.970-100000@blue1.dev.mcafeelabs.com>; from Davide Libenzi on Thu, Oct 18, 2001 at 05:56:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like a good approach. Could that be made more flexible.
Architectures today expose cache miss numbers, which 
through simple markovian chains approximation allow a much better estimation
of the cache footprint then inferring from time. 
Any chance to incoporate something like
this into your cost function flexibly or is this just too <way out there> ?

-- Hubertus

* Davide Libenzi <davidel@xmailserver.org> [20011018 20;56]:"
> 
> This patch try to achieve a better goodness() calculation through the
> introduction of the concept of 'cpu time spent onto a processor', aka
> probable cache footprint of the task.
> Right now if we've a couple of cpu bound tasks with the classical editor
> keyboard ticking, we can see the two cpu bound tasks swapped when the
> editor task kicks in.
> This is wrong coz the cpu bound task has probably run for a bunch of ms
> and hence has a quite big memory footprint on the cpu.
> While the editor task very likely run for a very short time by keeping the
> footprint of the cpu bound tasks amlost intact.
> This patch addresses in a better way even the proc change penalty problem
> that, right now, is constant.
> It's abvious that having to choose between the cpu bound task and the
> editor task, the better candidate should be the one that has less memory
> footprint aka the editor task.
> So we can change the constant penalty into a constant plus an estimate of
> the memory footprint.
> The patch tracks the number of jiffies that a task run as :
> 
> JR = Jin - Jout
> 
> where Jin is the jiffies value when the task in kicked in and Jout is the
> time when it's kicked out.
> In a given time the value of the footprint is :
> 
> W = JR > (J - Jout) ? JR - (J - Jout): 0
> 
> where J is the current time in jiffies.
> This means that if the task is run for 10 ms, 10 ms ago, it's current
> weight will be zero.
> This is quite clear coz the more a process does not run the more footprint
> will lose.
> I'm currently testing the patch by analyzing process migration and
> latencies with the latsched patch :
> 
> http://www.xmailserver.org/linux-patches/lnxsched.html
> 
> Comments ?
> 
> 
> 
> - Davide
> 
> 
> 
> diff -Nru linux-2.4.12.vanilla/include/linux/sched.h linux-2.4.12.scx/include/linux/sched.h
> --- linux-2.4.12.vanilla/include/linux/sched.h	Thu Oct 11 10:40:49 2001
> +++ linux-2.4.12.scx/include/linux/sched.h	Thu Oct 18 17:11:35 2001
> @@ -393,12 +393,14 @@
>  	int (*notifier)(void *priv);
>  	void *notifier_data;
>  	sigset_t *notifier_mask;
> -
> +
>  /* Thread group tracking */
>     	u32 parent_exec_id;
>     	u32 self_exec_id;
>  /* Protection of (de-)allocation: mm, files, fs, tty */
>  	spinlock_t alloc_lock;
> +/* a better place for these brothers must be found */
> +	unsigned long cpu_jtime, sched_jtime;
>  };
> 
>  /*
> diff -Nru linux-2.4.12.vanilla/kernel/fork.c linux-2.4.12.scx/kernel/fork.c
> --- linux-2.4.12.vanilla/kernel/fork.c	Mon Oct  1 12:56:42 2001
> +++ linux-2.4.12.scx/kernel/fork.c	Thu Oct 18 17:12:49 2001
> @@ -687,6 +687,9 @@
>  	if (!current->counter)
>  		current->need_resched = 1;
> 
> +	p->cpu_jtime = 0;
> +	p->sched_jtime = jiffies;
> +
>  	/*
>  	 * Ok, add it to the run-queues and make it
>  	 * visible to the rest of the system.
> diff -Nru linux-2.4.12.vanilla/kernel/sched.c linux-2.4.12.scx/kernel/sched.c
> --- linux-2.4.12.vanilla/kernel/sched.c	Tue Oct  9 19:00:29 2001
> +++ linux-2.4.12.scx/kernel/sched.c	Thu Oct 18 17:15:48 2001
> @@ -171,9 +171,15 @@
>  #ifdef CONFIG_SMP
>  		/* Give a largish advantage to the same processor...   */
>  		/* (this is equivalent to penalizing other processors) */
> -		if (p->processor == this_cpu)
> +		if (p->processor == this_cpu) {
>  			weight += PROC_CHANGE_PENALTY;
> -#endif
> +			if (p->cpu_jtime > jiffies)
> +				weight += p->cpu_jtime - jiffies;
> +		}
> +#else	/* #ifdef CONFIG_SMP */
> +		if (p->cpu_jtime > jiffies)
> +			weight += p->cpu_jtime - jiffies;
> +#endif	/* #ifdef CONFIG_SMP */
> 
>  		/* .. and a slight advantage to the current MM */
>  		if (p->mm == this_mm || !p->mm)
> @@ -382,7 +388,7 @@
>   * delivered to the current task. In this case the remaining time
>   * in jiffies will be returned, or 0 if the timer expired in time
>   *
> - * The current task state is guaranteed to be TASK_RUNNING when this
> + * The current task state is guaranteed to be TASK_RUNNING when this
>   * routine returns.
>   *
>   * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
> @@ -574,7 +580,10 @@
>  		case TASK_RUNNING:;
>  	}
>  	prev->need_resched = 0;
> -
> +	if (prev != idle_task(this_cpu)) {
> +		prev->cpu_jtime -= prev->cpu_jtime > prev->sched_jtime ? prev->sched_jtime: 0;
> +		prev->cpu_jtime += (jiffies - prev->sched_jtime) + jiffies;
> +	}
>  	/*
>  	 * this is the scheduler proper:
>  	 */
> @@ -611,6 +620,7 @@
>   	next->has_cpu = 1;
>  	next->processor = this_cpu;
>  #endif
> +	next->sched_jtime = jiffies;
>  	spin_unlock_irq(&runqueue_lock);
> 
>  	if (prev == next) {
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
