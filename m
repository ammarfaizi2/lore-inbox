Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVHVVh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVHVVh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVHVVh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:37:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41213 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751287AbVHVVh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:37:56 -0400
Message-ID: <430A4599.7060501@mvista.com>
Date: Mon, 22 Aug 2005 14:37:29 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
References: <20050818060126.GA13152@elte.hu>	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>	 <430739D4.681DB651@tv-sign.ru> <1124553848.23647.635.camel@tglx.tec.linutronix.de>
In-Reply-To: <1124553848.23647.635.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Sat, 2005-08-20 at 18:10 +0400, Oleg Nesterov wrote:
> 
> 
>>posix_timer_event() first checks that the thread (SIGEV_THREAD_ID
>>case) does not have PF_EXITING flag, then it calls send_sigqueue()
>>which locks task list. But if the thread exits in between the kernel
>>will oops.
> 
> 
>>posix_timer_event() runs under k_itimer.it_lock, but this does not
>>help if that thread was not the only one in thread group, in this
>>case we don't call exit_itimers().
> 
> 
> I added exit_notify_itimers() for that case. It is synchronized vs.
> posix_timer_event() via the timer lock and therefor protects against the
> race described above.

It seems to me that exit (or exec) calling the timer release code 
covered this.  I haven't gone through the exact sequence being 
discussed, however.  In any case, I don't think we should send the 
signal to the group leader instead, but rather should release the timer 
and cancel any pending signal.  AFAIKT there is no reason the group 
leader can not exit prior to other threads, but I may have missed this...

George
> 
> It solves the problem for the only user of send_sigqueue for now, but I
> think we should have a more general interface to such functionality to
> allow simple usage.
> 
> tglx
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> 
> diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/include/linux/sched.h linux-2.6.13-rc6.work/include/linux/sched.h
> --- linux-2.6.13-rc6/include/linux/sched.h	2005-08-13 12:25:56.000000000 +0200
> +++ linux-2.6.13-rc6.work/include/linux/sched.h	2005-08-20 17:43:36.000000000 +0200
> @@ -1051,6 +1051,7 @@ extern void __exit_signal(struct task_st
>  extern void exit_sighand(struct task_struct *);
>  extern void __exit_sighand(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
> +extern void exit_notify_itimers(struct signal_struct *);
>  
>  extern NORET_TYPE void do_group_exit(int);
>  
> diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/posix-timers.c linux-2.6.13-rc6.work/kernel/posix-timers.c
> --- linux-2.6.13-rc6/kernel/posix-timers.c	2005-08-13 12:25:58.000000000 +0200
> +++ linux-2.6.13-rc6.work/kernel/posix-timers.c	2005-08-20 17:43:36.000000000 +0200
> @@ -1169,6 +1169,33 @@ void exit_itimers(struct signal_struct *
>  }
>  
>  /*
> + * This is called by __exit_signal, when there are still references to
> + * the shared signal_struct
> + */
> +void exit_notify_itimers(struct signal_struct *sig)
> +{
> +	struct k_itimer *timer;
> +	struct list_head *tmp;
> +	unsigned long flags;
> +
> +	list_for_each(tmp, &sig->posix_timers) {
> +
> +		timer = list_entry(tmp, struct k_itimer, list);
> +
> +		/* Protect against posix_timer_fn */
> +		spin_lock_irqsave(&timer->it_lock, flags);
> +		if (timer->it_process == current) {
> +			
> +			if (timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
> +				timer->it_sigev_notify = SIGEV_SIGNAL;
> +			
> +			timer->it_process = timer->it_process->group_leader;
> +		} 
> +		spin_lock_irqrestore(&timer->it_lock, flags);
> +	}
> +}
> +
> +/*
>   * And now for the "clock" calls
>   *
>   * These functions are called both from timer functions (with the timer
> diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/signal.c linux-2.6.13-rc6.work/kernel/signal.c
> --- linux-2.6.13-rc6/kernel/signal.c	2005-08-13 12:25:58.000000000 +0200
> +++ linux-2.6.13-rc6.work/kernel/signal.c	2005-08-20 17:57:46.000000000 +0200
> @@ -390,6 +390,7 @@ void __exit_signal(struct task_struct *t
>  		sig->nvcsw += tsk->nvcsw;
>  		sig->nivcsw += tsk->nivcsw;
>  		sig->sched_time += tsk->sched_time;
> +		exit_notify_itimers(sig);
>  		spin_unlock(&sighand->siglock);
>  		sig = NULL;	/* Marker for below.  */
>  	}
> @@ -1381,13 +1382,12 @@ send_sigqueue(int sig, struct sigqueue *
>  	int ret = 0;
>  
>  	/*
> -	 * We need the tasklist lock even for the specific
> -	 * thread case (when we don't need to follow the group
> -	 * lists) in order to avoid races with "p->sighand"
> -	 * going away or changing from under us.
> +	 * No need to hold tasklist lock here. 
> +	 * posix_timer_event() is synchronized via 
> +	 * exit_itimers() and exit_notify_itimers() to 
> +	 * be protected against p->sighand == NULL
>  	 */
>  	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> -	read_lock(&tasklist_lock);  
>  	spin_lock_irqsave(&p->sighand->siglock, flags);
>  	
>  	if (unlikely(!list_empty(&q->list))) {
> @@ -1414,7 +1414,6 @@ send_sigqueue(int sig, struct sigqueue *
>  
>  out:
>  	spin_unlock_irqrestore(&p->sighand->siglock, flags);
> -	read_unlock(&tasklist_lock);
>  	return(ret);
>  }
>  
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
