Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWCZCf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWCZCf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWCZCf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:35:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751284AbWCZCf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:35:57 -0500
Date: Sat, 25 Mar 2006 18:32:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 2/2] hrtimer
Message-Id: <20060325183213.63ab667c.akpm@osdl.org>
In-Reply-To: <20060325121223.966390000@localhost.localdomain>
References: <20060325121219.172731000@localhost.localdomain>
	<20060325121223.966390000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> 
> Replace the nanosleep private sleeper functionality by the generic
> hrtimer sleeper.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> 
>  kernel/hrtimer.c |   34 +++++++---------------------------
>  1 file changed, 7 insertions(+), 27 deletions(-)
> 
> Index: linux-2.6.16/kernel/hrtimer.c
> ===================================================================
> --- linux-2.6.16.orig/kernel/hrtimer.c
> +++ linux-2.6.16/kernel/hrtimer.c
> @@ -655,7 +655,6 @@ void hrtimer_run_queues(void)
>  /*
>   * Sleep related functions:
>   */
> -
>  static int hrtimer_wakeup(struct hrtimer *timer)
>  {
>  	struct hrtimer_sleeper *t =
> @@ -675,28 +674,9 @@ void hrtimer_init_sleeper(struct hrtimer
>  	sl->task = task;
>  }
>  
> -struct sleep_hrtimer {
> -	struct hrtimer timer;
> -	struct task_struct *task;
> -	int expired;
> -};
> -
> -static int nanosleep_wakeup(struct hrtimer *timer)
> -{
> -	struct sleep_hrtimer *t =
> -		container_of(timer, struct sleep_hrtimer, timer);
> -
> -	t->expired = 1;
> -	wake_up_process(t->task);
> -
> -	return HRTIMER_NORESTART;
> -}
> -
> -static int __sched do_nanosleep(struct sleep_hrtimer *t, enum hrtimer_mode mode)
> +static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode)
>  {
> -	t->timer.function = nanosleep_wakeup;
> -	t->task = current;
> -	t->expired = 0;
> +	hrtimer_init_sleeper(t, current);
>  
>  	do {
>  		set_current_state(TASK_INTERRUPTIBLE);
> @@ -704,18 +684,18 @@ static int __sched do_nanosleep(struct s
>  
>  		schedule();
>  
> -		if (unlikely(!t->expired)) {
> +		if (unlikely(t->task)) {
>  			hrtimer_cancel(&t->timer);
>  			mode = HRTIMER_ABS;
>  		}
> -	} while (!t->expired && !signal_pending(current));
> +	} while (t->task && !signal_pending(current));
>  
> -	return t->expired;
> +	return t->task == NULL;
>  }

This all looks vaguely racy.  hrtimer_wakeup() will set t->task to NULL
without barriers, locks or anything.  And the waiter here can break out of
schedule() due to signal delivery while a wakeup is in progress.

So the value of t->task here is fairly meaningless.  Ot just depends on how
far the waker has got through hrtimer_wakeup().

Maybe that doesn't matter, because hrtimer_cancel() will spin until
hrtimer_wakeup() has completed anyway, but could you please recheck and
confirm that this is all solid?

