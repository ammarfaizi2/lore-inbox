Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965768AbWKEBEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965768AbWKEBEz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 20:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965770AbWKEBEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 20:04:55 -0500
Received: from websrv.werbeagentur-aufwind.de ([88.198.253.206]:20953 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S965768AbWKEBEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 20:04:54 -0500
Subject: [PATCH] Fix SUNRPC wakeup/execute race condition
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Cc: NFS V4 Mailing List <nfsv4@linux-nfs.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Olaf Kirch <okir@monad.swb.de>
In-Reply-To: <1162602386.26794.5.camel@leto.intern.saout.de>
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
Content-Type: text/plain
Date: Sun, 05 Nov 2006 02:04:48 +0100
Message-Id: <1162688688.5153.26.camel@leto.intern.saout.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
rpc_make_runnable fixes that hole. The reordering hopefully doesn't
introduce some new race condition, in fact the only possible one is
already correctly detected and handled in __rpc_execute.

Bug noticed on a 4-way x86_64 system under XEN with an NFSv4 server
on the same physical machine, apparently one of the few ways to hit
this race condition at all.

Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: J. Bruce Fields <bfields@citi.umich.edu>
Cc: Olaf Kirch <okir@monad.swb.de>
Signed-off-by: Christophe Saout <christophe@saout.de>

--- linux-2.6.18/net/sunrpc/sched.c	2006-09-20 05:42:06.000000000 +0200
+++ linux/net/sunrpc/sched.c	2006-11-04 20:38:56.000000000 +0100
@@ -302,12 +302,9 @@ EXPORT_SYMBOL(__rpc_wait_for_completion_
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
 	if (RPC_IS_ASYNC(task)) {
 		int status;


