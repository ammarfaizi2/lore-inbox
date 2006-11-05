Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbWKEGu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWKEGu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWKEGu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:50:56 -0500
Received: from pat.uio.no ([129.240.10.4]:731 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161163AbWKEGuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:50:55 -0500
Subject: Re: [PATCH] Fix SUNRPC wakeup/execute race condition
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org, NFS V4 Mailing List <nfsv4@linux-nfs.org>,
       "J. Bruce Fields" <bfields@citi.umich.edu>
In-Reply-To: <1162688688.5153.26.camel@leto.intern.saout.de>
References: <1157576316.3292.13.camel@dyn9047022153>
	 <20060907150146.GA22586@fieldses.org>
	 <1157731084.3292.25.camel@dyn9047022153>
	 <20060908160432.GB19234@fieldses.org>
	 <1162158228.11247.4.camel@leto.intern.saout.de>
	 <1162159282.11247.17.camel@leto.intern.saout.de>
	 <1162321027.23543.6.camel@leto.intern.saout.de>
	 <1162324141.23543.23.camel@leto.intern.saout.de>
	 <1162325490.5614.82.camel@lade.trondhjem.org>
	 <1162602386.26794.5.camel@leto.intern.saout.de>
	 <1162688688.5153.26.camel@leto.intern.saout.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 01:50:41 -0500
Message-Id: <1162709441.6271.62.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.731, required 12,
	autolearn=disabled, AWL 1.13, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 02:04 +0100, Christophe Saout wrote:
> The sunrpc scheduler contains a race condition that can let an RPC
> task end up being neither running nor on any wait queue. The race takes
> place between rpc_make_runnable (called from rpc_wake_up_task) and
> __rpc_execute under the following condition:
> 
> First __rpc_execute calls tk_action which puts the task on some wait
> queue. The task is dequeued by another process before __rpc_execute
> continues its execution. While executing rpc_make_runnable exactly after
> setting the task `running' bit and before clearing the `queued' bit
> __rpc_execute picks up execution, clears `running' and subsequently
> both functions fall through, both under the false assumption somebody
> else took the job.
> 
> Swapping rpc_test_and_set_running with rpc_clear_queued in
> rpc_make_runnable fixes that hole. The reordering hopefully doesn't
> introduce some new race condition, in fact the only possible one is
> already correctly detected and handled in __rpc_execute.
> 
> Bug noticed on a 4-way x86_64 system under XEN with an NFSv4 server
> on the same physical machine, apparently one of the few ways to hit
> this race condition at all.
> 
> Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
> Cc: J. Bruce Fields <bfields@citi.umich.edu>
> Cc: Olaf Kirch <okir@monad.swb.de>
> Signed-off-by: Christophe Saout <christophe@saout.de>
> 
> --- linux-2.6.18/net/sunrpc/sched.c	2006-09-20 05:42:06.000000000 +0200
> +++ linux/net/sunrpc/sched.c	2006-11-04 20:38:56.000000000 +0100
> @@ -302,12 +302,9 @@ EXPORT_SYMBOL(__rpc_wait_for_completion_
>   */
>  static void rpc_make_runnable(struct rpc_task *task)
>  {
> -	int do_ret;
> -
>  	BUG_ON(task->tk_timeout_fn);
> -	do_ret = rpc_test_and_set_running(task);
>  	rpc_clear_queued(task);
> -	if (do_ret)
> +	if (rpc_test_and_set_running(task))
>  		return;
>  	if (RPC_IS_ASYNC(task)) {
>  		int status;

This fix looks wrong to me. If we've made it to 'rpc_make_runnable',
then the rpc_task will have already been removed from the
rpc_wait_queue.
The only question left is "who is responsible for waking up the
synchronous task / setting up the asynchronous workqueue item?".

Cheers,
  Trond

