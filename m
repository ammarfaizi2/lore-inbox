Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVE1OEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVE1OEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 10:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVE1OEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 10:04:15 -0400
Received: from mail.timesys.com ([65.117.135.102]:29580 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262723AbVE1OEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 10:04:06 -0400
Message-ID: <429879FD.30002@timesys.com>
Date: Sat, 28 May 2005 10:02:37 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Olaf Kirch <okir@suse.de>, john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com> <42983135.C521F1C8@tv-sign.ru>
In-Reply-To: <42983135.C521F1C8@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2005 13:57:31.0468 (UTC) FILETIME=[311140C0:01C5638D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:

[race scenario deleted]

This was not the race scenario of concern.

> This is totally pointless to do:
> 
> 	if (timer_pending())
> 		del_singleshot_timer_sync();

However this is the action the RPC code was attempting
to take originally based upon stale/incorrect data.
Again the failure mode was of the RPC_TASK_HAS_TIMER
bit not being set when the embedded timer actually was
still present in the timer cascade structure (eg:
timer->base != 0 or timer_pending()).  This caused the
rpc_task to be recycled with the embedded timer struct
still linked in the timer cascade.

> If you need to ensure that timer's handler is not running on any
> cpu then timer_pending() can't help. If you don't need this, you
> should use plain del_timer().

That's not the goal of the timer_pending() usage here.
Rather we're at a point in rpc_release_task where we
want to tear down an rpc_task.  The call to timer_pending()
determines if the embedded timer is still linked in the
timer cascade structure.

The embedded timer may be running on another CPU.  We
may even check timer->base during this race when it is
non-NULL and wind up deleting a timer which the path
running on another CPU has already deleted.  That is
allowable.  We simply want to idle the timer.

> I don't understand why this race is rt specific. I think
> that PREEMPT_SOFTIRQS just enlarges the window.

That is certainly possible.  However this code has been
around for some time and this problem apparently hasn't
otherwise surfaced.  I suspect it depends on the
combination of timer cascade structures existing
per-CPU and the execution context of callback(task)
invoked in rpc_run_timer() now being preemptive (ie:
preemption is required on the same CPU for this
problem to surface).

> I believe
> the right fix is just to call del_singleshot_timer_sync()
> unconditionally and kill RPC_TASK_HAS_TIMER bit.

Ignoring RPC_TASK_HAS_TIMER and always calling
del_singleshot_timer_sync() will work but seems
excessive.

> I have added Olaf Kirch to the CC: list.

Welcome.

>>The fix removes the attempt to replicate timer queue
>>status from the RPC code by removing the usage of the
>>pre-calculated RPC_TASK_HAS_TIMER.
> 
> 
> No, RPC_TASK_HAS_TIMER doesn't replicate timer queue status.
> I believe, it was intended as optimization, to avoid costly
> del_timer_sync() call.

If true its chosen name seems a misnomer.  In any case
the embedded timer in the rpc_task structure must be
quiesced before the rpc_task is made available for
reuse.  The fix under discussion here does so.  Note the
goal was not to rearchitecture the RPC code but rather to
address this very specific bug which surfaced during
stress testing.

If anyone with more ownership of the RPC code would like
to comment, any insight would be most welcome.

-john


-- 
john.cooper@timesys.com
