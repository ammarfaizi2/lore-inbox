Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVEaXLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVEaXLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVEaXLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:11:42 -0400
Received: from mail.timesys.com ([65.117.135.102]:58375 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261312AbVEaXLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:11:25 -0400
Message-ID: <429CEEB8.1010404@timesys.com>
Date: Tue, 31 May 2005 19:09:44 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: john cooper <john.cooper@timesys.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Olaf Kirch <okir@suse.de>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com> <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com> <1117312557.10746.6.camel@lade.trondhjem.org> <4299332F.6090900@timesys.com> <1117352410.10788.29.camel@lade.trondhjem.org> <429B8678.1000706@timesys.com>
In-Reply-To: <429B8678.1000706@timesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 May 2005 23:04:40.0328 (UTC) FILETIME=[1FD50080:01C56635]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cooper wrote:
> Trond Myklebust wrote:
> 
>> I've appended a patch that
>> should check for strict compliance of the above rules. Could you try it
>> out and see if it triggers any Oopses?
> 
> 
> Yes, the assert in rpc_delete_timer() occurs just before
> the cascade list corruption.  This is consistent with
> what I have seen.  ie: the timer in a released rpc_task
> is still active.

I've captured more data in the instrumentation and found
the rpc_task's timer is being requeued by an application
task which is preempting ksoftirqd when it wakes up in
xprt_transmit().  This is what I had originally suspected
but likely didn't communicate it effectively.

The scenario unfolds as:

                                          [high priority app task]
                                              :
                                          call_transmit()
                                             xprt_transmit()
                                             /* blocks in xprt_transmit() */
ksoftirqd()
     __run_timers()
         list_del("rpc_task_X.timer") /* logically off cascade */
         rpc_run_timer(data)
             task->tk_timeout_fn(task)

             /* ksoftirqd preempted */

                                              :
                                              ---------------------------------------------------------
                                              /* Don't race with disconnect */
                                              if (!xprt_connected(xprt))
                                                  task->tk_status = -ENOTCONN;
                                              else if (!req->rq_received)
                                                  rpc_sleep_on(&xprt->pending, task, NULL, xprt_timer);
                                              ---------------------------------------------------------
                                                      __rpc_sleep_on()
                                                          __mod_timer("rpc_task_X.timer")  /* requeued in cascade */
                                              /* blocks */

         /* rpc_run_timer resumes from preempt */
         clear_bit(RPC_TASK_HAS_TIMER, "rpc_task_X.tk_runstate");

         /* rpc_task_X.timer is now enqueued in cascade without
            RPC_TASK_HAS_TIMER set and will not be dequeued
            in rpc_release_task()/rpc_delete_timer() */


The usage of "rpc_task_X.timer" indicates the same KVA
observed for the timer struct at the associated points
in the instrumented code.

The above was gathered by logging usage of the
kernel/timer.c primitives.  Thus I don't have more
detailed state of the rpc_task in RPC context.
However I did verify which of the three calls to
rpc_sleep_on() in xprt_transmit() was being invoked
(as above).

So the root cause appears to be the rpc_task's timer
being requeued in xprt_transmit() when rpc_run_timer
is preempted.  From looking at the code I'm unsure
if modifying xprt_transmit()/out_receive is appropriate
to synchronize with rpc_release_task().  It seems
allowing rpc_sleep_on() to occur is more natural and
for rpc_release_task() to detect the pending timer and
remove it before proceeding.  I'm still in the process
of trying to digest the logic here but I thought there
was enough information here to be of use.  Suggestions,
warnings welcome.

-john


-- 
john.cooper@timesys.com
