Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVE2DOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVE2DOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 23:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVE2DOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 23:14:25 -0400
Received: from mail.timesys.com ([65.117.135.102]:20688 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261226AbVE2DOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 23:14:16 -0400
Message-ID: <4299332F.6090900@timesys.com>
Date: Sat, 28 May 2005 23:12:47 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>	 <42983135.C521F1C8@tv-sign.ru>  <4298AED8.8000408@timesys.com> <1117312557.10746.6.camel@lade.trondhjem.org>
In-Reply-To: <1117312557.10746.6.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2005 03:07:40.0515 (UTC) FILETIME=[930FBB30:01C563FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> lau den 28.05.2005 Klokka 13:48 (-0400) skreiv john cooper:
> Could you please explain why you think such a scenario is possible? The
> timer functions themselves should never be causing a re-queue, and every
> iteration through the loop in __rpc_execute() should cause any pending
> timer to be killed, as should rpc_release_task().

I'm trying to pinpoint the cause of the RPC timer cascade
structure corruption.  Here is the data I've ascertained thus far:

1.  the failure only has been seen for the timer struct embedded
     in an rpc_task.  The callback function is always rpc_run_timer().

2.  the failure mode is an rpc_task's embedded timer struct being
     queued a second time in the timer cascade without having
     been dequeued from an existing cascade vector.  The failure
     is not immediate but causes a corrupt entry which is later
     encountered in timer cascade code.

3.  the problem occurs if rpc_run_timer() executes in preemptable
     context.  The problem was not encountered when preemption was
     explicitly disabled within rpc_run_timer().

4.  the problem appears related to RPC_TASK_HAS_TIMER not being set
     in rpc_release_task().  Specifically the problem arises when
     !RPC_TASK_HAS_TIMER but timer->base is non-zero.  Modifying
     rpc_delete_timer() to effect the del_singleshot_timer_sync()
     call when (RPC_TASK_HAS_TIMER || timer->base) prevents the
     failure.

5.  (a detail of #2 above) Instrumenting the number of logical
     add/mod/del operations on the timer struct the corruption
     occurs at a point when the tally of the operations:
     (mod == add == del + 1) ie: the timer is has been add/modified
     several times but one count greater than the number of delete
     operations (active in cascade).  The next operation on this
     timer struct is an add/mod operation with the state of the
     timer having been reinitialized in rpc_init_task():init_timer()
     with no intervening delete having been performed.

If it wasn't clear in my prior mail, please disregard the earlier
claim of RPC_TASK_HAS_TIMER replicating the state of timer->base.
 From Oleg's earlier mail I see that isn't the case as additional
RPC-specific state is attached to this flag.  The patch as well
should be disregarded.

> That's why we can use del_singleshot_timer_sync() in the first place:
> because there is no recursion, and no re-queueing that can cause races.
> I don't see how either preemption or RT will change that (and if they
> do, then _that_ is the real bug that needs fixing).

During the time I have been hunting this bug I've lost
count of the number of times I've alternatively suspected
either the kernel timer code or net/sunrpc/sched.c usage
of the same.  I still feel it is somehow related to the RPC
code but will need to refine the instrumentation to extract
further information from the failure scenario.

A few questions I'd like to pose:

1.  Can you correlate anything of rpc_run_timer() running in
     preemptive context which could explain the above behavior?

2.  Do you agree that (!RPC_TASK_HAS_TIMER && timer->base)
     is an inconsistent state at the time of
     rpc_release_task():rpc_delete_timer() ?


-john


-- 
john.cooper@timesys.com
