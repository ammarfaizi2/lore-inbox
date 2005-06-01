Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVFASNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVFASNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVFASNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:13:24 -0400
Received: from mail.timesys.com ([65.117.135.102]:64728 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261508AbVFASHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:07:01 -0400
Message-ID: <429DF8DE.7060008@timesys.com>
Date: Wed, 01 Jun 2005 14:05:18 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>	 <1117312557.10746.6.camel@lade.trondhjem.org> <4299332F.6090900@timesys.com>	 <1117352410.10788.29.camel@lade.trondhjem.org> <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>
In-Reply-To: <429DC4A8.BFF69FB3@tv-sign.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2005 18:00:13.0875 (UTC) FILETIME=[C2973830:01C566D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> This all is very unlikely of course, but it would be nice to verify
> that kernel/timer.c is not the source of the problem.

The problem I am seeing is on a single CPU system.

> John, if it is easy to reproduce the problem, could you please retest
> with this patch?

I've done so and the second assert is generated
when running the test.  So here we have a case
of RPC_TASK_HAS_TIMER set but the associated
timer->base == NULL.  It would seem this could
easily be the scenario of executing in:

__run_timers()
     timer->base = NULL;
         rpc_run_timer()
             task->tk_timeout_fn(task)
             /* ksoftirqd preempted */
                                              :
                                          /* RPC client */
                                          rpc_execute()
                                             rpc_delete_timer()
                                                 del_timer() returns 0
                                                 BUG_ON(test_bit(RPC_TASK_HAS_TIMER,
                                                   &task->tk_runstate));
                                              :
          /* rpc_run_timer() resumes */
          clear_bit(RPC_TASK_HAS_TIMER,
            &task->tk_runstate);

I don't see how this would imply a kernel/timer.c
problem.  It also appears this wouldn't be causing
the timer cascade corruption I've seen as the
end result is deleting an already dequeued timer
which is safe here.

BTW, if preemption is explicitly disabled in rpc_run_timer()
the BUG_ON assert is not generated nor (as reported
earlier) does the cascade corruption occur.  I'm still
investigating.

-john



> --- 2.6.12-rc5/net/sunrpc/sched.c~	Wed Jun  1 17:49:57 2005
> +++ 2.6.12-rc5/net/sunrpc/sched.c	Wed Jun  1 18:00:31 2005
> @@ -137,8 +137,12 @@ rpc_delete_timer(struct rpc_task *task)
>  {
>  	if (RPC_IS_QUEUED(task))
>  		return;
> -	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
> -		del_singleshot_timer_sync(&task->tk_timer);
> +	if (test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
> +		if (del_singleshot_timer_sync(&task->tk_timer)) {
> +			BUG_ON(!test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate));
> +			clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate);
> +		} else
> +			BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate));
>  		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
>  	}
>  }
> 


-- 
john.cooper@timesys.com
