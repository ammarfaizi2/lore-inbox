Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVE1IoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVE1IoP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 04:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVE1IoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 04:44:14 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:15500 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262502AbVE1IoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 04:44:05 -0400
Message-ID: <42983135.C521F1C8@tv-sign.ru>
Date: Sat, 28 May 2005 12:52:05 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john cooper <john.cooper@timesys.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Olaf Kirch <okir@suse.de>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cooper wrote:
>
> Oleg Nesterov wrote:
> > john cooper wrote:
> >
> >> rpc_delete_timer(struct rpc_task *task)
> >> {
> >>-	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
> >>+	if (task->tk_timer.base) {
> >> 		del_singleshot_timer_sync(&task->tk_timer);
> >> 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
> >> 	}
> >
> >
> > I know nothing about rpc, but this looks completely wrong to me.
>
> > Next, timer_pending() == 0 does not mean that del_timer_sync() is
> > not needed, it may be running on the other CPU.
>
> Whether timer_pending() is SMP safe depends on the caller's
> context relative to the overall usage of the timer structure.
>
> For example we aren't holding base->lock in rpc_delete_timer()
> as would normally be expected.  The reason this is safe is
> the transition to "timer off base" and "timer.base <- NULL"
> follows this sequence in __run_timers().  So the worst we
> can do is to be racing with another cpu trying to expire this
> timer and we will delete an already inactive timer which is
> innocuous here.

CPU_0						CPU_1

rpc_release_task(task)
						__run_timers:
							timer->base = NULL;
	rpc_delete_timer()
		if (timer->base)
			// not taken
			del_timer_sync();

	mempool_free(task);
							timer->function(task):
								// task already freed/reused
								__rpc_default_timer(task);


This is totally pointless to do:

	if (timer_pending())
		del_singleshot_timer_sync();

If you need to ensure that timer's handler is not running on any
cpu then timer_pending() can't help. If you don't need this, you
should use plain del_timer().

> > Looking at the code for the first time, I can guess that RPC_TASK_HAS_TIMER
> > was invented to indicate when it is safe not to wait for timer
> > completition. This bit is cleared after ->tk_timeout_fn call in
> > the timer's handler. After that rpc_run_timer will not touch *task.
>
> The problem being it is possible in the now preemptible
> context in which rpc_run_timer() executes for the call
> of callback(task) to be preempted allowing another task
> restart the timer (via a call to __rpc_add_timer()).
> So the previous implied assumption in a nonpreemptive
> rpc_run_timer() of the timer known to be inactive (as
> that's how we arrived here) is no longer reliable.

I don't understand why this race is rt specific. I think
that PREEMPT_SOFTIRQS just enlarges the window. I believe
the right fix is just to call del_singleshot_timer_sync()
unconditionally and kill RPC_TASK_HAS_TIMER bit.

I have added Olaf Kirch to the CC: list.

> The fix removes the attempt to replicate timer queue
> status from the RPC code by removing the usage of the
> pre-calculated RPC_TASK_HAS_TIMER.

No, RPC_TASK_HAS_TIMER doesn't replicate timer queue status.
I believe, it was intended as optimization, to avoid costly
del_timer_sync() call.

Oleg.
