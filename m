Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752901AbWKFMcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbWKFMcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbWKFMcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:32:21 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:22702 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752900AbWKFMcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:32:20 -0500
Date: Mon, 6 Nov 2006 07:31:25 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <20061105193457.GA3082@oleg>
Message-ID: <Pine.LNX.4.58.0611060729370.14553@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Oleg Nesterov wrote:

> When task->array != NULL, try_to_wake_up() just goes to "out_running" and sets
> task->state = TASK_RUNNING.
>
> In that case hrtimer_wakeup() does:
>
> 	timeout->task = NULL;		<----- [1]
>
> 	spin_lock(runqueues->lock);
>
> 	task->state = TASK_RUNNING;	<----- [2]
>
> from Documentation/memory-barriers.txt
>
> 	Memory operations that occur before a LOCK operation may appear to
> 	happen after it completes.
>
> This means that [2] may be completed before [1], and
>
> CPU_0							CPU_1
> rt_mutex_slowlock:
>
> for (;;) {
> 	...
> 		if (timeout && !timeout->task)
> 			return -ETIMEDOUT;
> 	...
>
> 	schedule();
> 							hrtimer_wakeup() sets
> 	...						task->state = TASK_RUNNING,
> 							but "timeout->task = NULL"
> 							is not completed
> 	set_current_state(TASK_INTERRUPTIBLE);
> }
>
> we can miss a timeout.
>
> Of course, this all is scholasticism, this can't happen in practice, but
> may be this patch makes sense as a documentation update.
>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
> --- STATS/kernel/hrtimer.c~1_hrtw	2006-10-22 18:24:03.000000000 +0400
> +++ STATS/kernel/hrtimer.c	2006-11-05 22:32:36.000000000 +0300
> @@ -662,9 +662,12 @@ static int hrtimer_wakeup(struct hrtimer
>  		container_of(timer, struct hrtimer_sleeper, timer);
>  	struct task_struct *task = t->task;
>
> -	t->task = NULL;
> -	if (task)
> +	if (task) {
> +		t->task = NULL;
> +		/* must be visible before task->state = TASK_RUNNING */
> +		smp_wmb();
>  		wake_up_process(task);
> +	}
>
>  	return HRTIMER_NORESTART;
>  }
>
>

Ingo, Thomas, could you ack this too, or Nack it with an explaination.

Ingo, you might want to read the whole thread here.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

