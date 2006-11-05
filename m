Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWKERm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWKERm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWKERm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:42:56 -0500
Received: from websrv.werbeagentur-aufwind.de ([88.198.253.206]:44702 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S1161431AbWKERmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:42:55 -0500
Subject: Re: [PATCH] Fix SUNRPC wakeup/execute race condition
From: Christophe Saout <christophe@saout.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, NFS V4 Mailing List <nfsv4@linux-nfs.org>,
       "J. Bruce Fields" <bfields@citi.umich.edu>
In-Reply-To: <1162746093.5652.39.camel@lade.trondhjem.org>
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
	 <1162709441.6271.62.camel@lade.trondhjem.org>
	 <1162722728.19690.4.camel@leto.intern.saout.de>
	 <1162746093.5652.39.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 18:42:48 +0100
Message-Id: <1162748568.22904.28.camel@leto.intern.saout.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 12:01 -0500, Trond Myklebust wrote:
> On Sun, 2006-11-05 at 11:32 +0100, Christophe Saout wrote:
> > Am Sonntag, den 05.11.2006, 01:50 -0500 schrieb Trond Myklebust:
> > 
> > > > --- linux-2.6.18/net/sunrpc/sched.c	2006-09-20 05:42:06.000000000 +0200
> > > > +++ linux/net/sunrpc/sched.c	2006-11-04 20:38:56.000000000 +0100
> > > > @@ -302,12 +302,9 @@ EXPORT_SYMBOL(__rpc_wait_for_completion_
> > > >   */
> > > >  static void rpc_make_runnable(struct rpc_task *task)
> > > >  {
> > > > -	int do_ret;
> > > > -
> > > >  	BUG_ON(task->tk_timeout_fn);
> > > > -	do_ret = rpc_test_and_set_running(task);
> > > >  	rpc_clear_queued(task);
> > > > -	if (do_ret)
> > > > +	if (rpc_test_and_set_running(task))
> > > >  		return;
> > > >  	if (RPC_IS_ASYNC(task)) {
> > > >  		int status;
> > > 
> > > This fix looks wrong to me. If we've made it to 'rpc_make_runnable',
> > > then the rpc_task will have already been removed from the
> > > rpc_wait_queue.
> > 
> > I just flipped the two lines, changed nothing else. Why exactly do you
> > think that's wrong, I don't see anything particular that could be broken
> > by chaning the ordering. Anyway, the fsstress has been running for 18
> > hours straight now without showing any signs of problems.
> 
> OK. I finally see the bug that you've spotted. The problem occurs when
> __rpc_execute clears RPC_TASK_RUNNING after rpc_make_runnable has called
> rpc_test_and_set_running, but before it has called rpc_clear_queued.

Yes, exactly.

> However if you just swap the two lines, you run into a new race:
> __rpc_execute() may just put the rpc_task back to sleep before your call
> to rpc_test_and_set_running() finishes executing.
> We therefore need an extra test for RPC_IS_QUEUED() in
> rpc_make_runnable().

Damn, you're right. I missed that one. What about that:

----
The sunrpc scheduler contains a race condition that can let an RPC
task end up being neither running nor on any wait queue. The race takes
place between rpc_make_runnable (called from rpc_wake_up_task) and
__rpc_execute under the following condition:

First __rpc_execute calls tk_action which puts the task on some wait
queue. The task is dequeued by another process before __rpc_execute
continues its execution. While executing rpc_make_runnable exactly after
setting the task `running' bit and before clearing the `queued' bit
__rpc_execute picks up execution, clears `running' and subsequently
both functions fall through, both under the false assumption somebody
else took the job.

Swapping rpc_test_and_set_running with rpc_clear_queued in
rpc_make_runnable fixes that hole. This introduces another possible
race condition that can be handled by checking for `queued' after
setting the `running' bit.

Bug noticed on a 4-way x86_64 system under XEN with an NFSv4 server
on the same physical machine, apparently one of the few ways to hit
this race condition at all.

Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Christophe Saout <christophe@saout.de>

--- linux-2.6.18/net/sunrpc/sched.c	2006-09-20 05:42:06.000000000 +0200
+++ linux/net/sunrpc/sched.c	2006-11-04 20:38:56.000000000 +0100
@@ -302,12 +302,15 @@ EXPORT_SYMBOL(__rpc_wait_for_completion_
  */
 static void rpc_make_runnable(struct rpc_task *task)
 {
-	int do_ret;
-
 	BUG_ON(task->tk_timeout_fn);
-	do_ret = rpc_test_and_set_running(task);
 	rpc_clear_queued(task);
-	if (do_ret)
+	if (rpc_test_and_set_running(task))
 		return;
+	/* We might have raced */
+	if (RPC_IS_QUEUED(task)) {
+		rpc_clear_running(task);
+		return;
+	}
 	if (RPC_IS_ASYNC(task)) {
 		int status;

-	int do_ret;
-
 	BUG_ON(task->tk_timeout_fn);
-	do_ret = rpc_test_and_set_running(task);
 	rpc_clear_queued(task);
-	if (do_ret)
+	if (rpc_test_and_set_running(task))
 		return;
+	/* We might have raced with __rpc_execute */
+	if (RPC_IS_QUEUED(task)) {
+		rpc_clear_running(task);
+		return;
+	}
 	if (RPC_IS_ASYNC(task)) {
 		int status;


