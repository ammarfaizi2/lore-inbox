Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVE3Vft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVE3Vft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVE3Vfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:35:48 -0400
Received: from a34-mta01.direcpc.com ([66.82.4.90]:1917 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S261765AbVE3VeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:34:15 -0400
Date: Mon, 30 May 2005 17:32:40 -0400
From: john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
In-reply-to: <1117352410.10788.29.camel@lade.trondhjem.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>,
       john cooper <john.cooper@timesys.com>
Message-id: <429B8678.1000706@timesys.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>
 <1117312557.10746.6.camel@lade.trondhjem.org> <4299332F.6090900@timesys.com>
 <1117352410.10788.29.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> I've appended a patch that
> should check for strict compliance of the above rules. Could you try it
> out and see if it triggers any Oopses?

Yes, the assert in rpc_delete_timer() occurs just before
the cascade list corruption.  This is consistent with
what I have seen.  ie: the timer in a released rpc_task
is still active.

BTW, the patch from Oleg is relative to 2.6.12 and didn't
look to apply to the 2.6.11-derived base with which I'm
working (the RPC_IS_QUEUED() test at the head of rpc_delete_timer()
does not exist).  In any case the relocation of restarted: in
__rpc_execute() did not influence the failure.  I'd like to
move to a 2.6.12-based -RT patch however I'm dealing with
"code in the pipe" and unfortunately don't have that option.

Sorry I'm just responding new.  We're in the middle of a
long holiday weekend.  I will have more time come tomorrow
to analyze this further.

-john


> ------------------------------------------------------------------------
> 
>  sched.c |    8 ++++++++
>  1 files changed, 8 insertions(+)
> 
> Index: linux-2.6.12-rc4/net/sunrpc/sched.c
> ===================================================================
> --- linux-2.6.12-rc4.orig/net/sunrpc/sched.c
> +++ linux-2.6.12-rc4/net/sunrpc/sched.c
> @@ -135,6 +135,8 @@ __rpc_add_timer(struct rpc_task *task, r
>  static void
>  rpc_delete_timer(struct rpc_task *task)
>  {
> +	BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) == 0 &&
> +			timer_pending(&task->tk_timer));
>  	if (RPC_IS_QUEUED(task))
>  		return;
>  	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
> @@ -337,6 +339,8 @@ static void __rpc_sleep_on(struct rpc_wa
>  void rpc_sleep_on(struct rpc_wait_queue *q, struct rpc_task *task,
>  				rpc_action action, rpc_action timer)
>  {
> +	BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
> +			timer_pending(&task->tk_timer));
>  	/*
>  	 * Protect the queue operations.
>  	 */
> @@ -594,6 +598,8 @@ static int __rpc_execute(struct rpc_task
>  			unlock_kernel();
>  		}
>  
> +		BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
> +			timer_pending(&task->tk_timer));
>  		/*
>  		 * Perform the next FSM step.
>  		 * tk_action may be NULL when the task has been killed
> @@ -925,6 +931,8 @@ fail:
>  
>  void rpc_run_child(struct rpc_task *task, struct rpc_task *child, rpc_action func)
>  {
> +	BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
> +			timer_pending(&task->tk_timer));
>  	spin_lock_bh(&childq.lock);
>  	/* N.B. Is it possible for the child to have already finished? */
>  	__rpc_sleep_on(&childq, task, func, NULL);


-- 
john.cooper@timesys.com
