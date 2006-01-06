Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWAFGp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWAFGp1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 01:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWAFGp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 01:45:27 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:61942 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750728AbWAFGp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 01:45:27 -0500
Message-ID: <43BE1203.4060600@bigpond.net.au>
Date: Fri, 06 Jan 2006 17:45:23 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH, RESUBMIT] sched: Fix adverse effects of NFS client on interactive
 response
Content-Type: multipart/mixed;
 boundary="------------090901040100030509070603"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 6 Jan 2006 06:45:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090901040100030509070603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch addresses the adverse effect that the NFS client can have on
interactive response when CPU bound tasks (such as a kernel build)
operate on files mounted via NFS.  (NB It is emphasized that this has
nothing to do with the effects of interactive tasks accessing NFS
mounted files themselves.)

The problem occurs because tasks accessing NFS mounted files for data
can undergo quite a lot of TASK_INTERRUPTIBLE sleep depending on the
load on the server and the quality of the network connection.  This can
result in these tasks getting quite high values for sleep_avg and
consequently a large priority bonus.  On the system where I noticed this
problem they were getting the full 10 bonus points and being given the
same dynamic priority as genuine interactive tasks such as the X server
and rythmbox.

The solution to this problem is to use TASK_NONINTERACTIVE to tell the
scheduler that the TASK_INTERRUPTIBLE sleeps in the NFS client and
SUNRPC are NOT interactive sleeps. NB (In spite of its name) the 
TASK_NONINTERACTIVE flag is not asserting that the task involved is non 
interactive just that this particular sleep is non interactive and 
should not be used as evidence that the task is interactive.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

--

   fs/nfs/inode.c       |    3 ++-
   fs/nfs/nfs4proc.c    |    2 +-
   fs/nfs/pagelist.c    |    3 ++-
   fs/nfs/write.c       |    3 ++-
   net/sunrpc/sched.c   |    2 +-
   net/sunrpc/svcsock.c |    2 +-
   6 files changed, 9 insertions(+), 6 deletions(-)

--

As the furore seems to have subsided without raising valid technical 
reasons for excluding this patch and it fixes a demonstrable problem 
without incurring any costs, I'm resubmitting this patch (against 
2.6.15-mm1) for testing in the -mm branch.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
   -- Ambrose Bierce


--------------090901040100030509070603
Content-Type: text/plain;
 name="make-nfs-sleeps-noninteractive"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make-nfs-sleeps-noninteractive"

Index: MM-2.6.X/fs/nfs/inode.c
===================================================================
--- MM-2.6.X.orig/fs/nfs/inode.c	2006-01-06 14:38:54.000000000 +1100
+++ MM-2.6.X/fs/nfs/inode.c	2006-01-06 17:29:14.000000000 +1100
@@ -927,7 +927,8 @@ static int nfs_wait_on_inode(struct inod
 
 	rpc_clnt_sigmask(clnt, &oldmask);
 	error = wait_on_bit_lock(&nfsi->flags, NFS_INO_REVALIDATING,
-					nfs_wait_schedule, TASK_INTERRUPTIBLE);
+					nfs_wait_schedule,
+					TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 	rpc_clnt_sigunmask(clnt, &oldmask);
 
 	return error;
Index: MM-2.6.X/fs/nfs/nfs4proc.c
===================================================================
--- MM-2.6.X.orig/fs/nfs/nfs4proc.c	2006-01-06 14:38:54.000000000 +1100
+++ MM-2.6.X/fs/nfs/nfs4proc.c	2006-01-06 17:29:14.000000000 +1100
@@ -2786,7 +2786,7 @@ static int nfs4_wait_clnt_recover(struct
 	rpc_clnt_sigmask(clnt, &oldset);
 	res = wait_on_bit(&clp->cl_state, NFS4CLNT_STATE_RECOVER,
 			nfs4_wait_bit_interruptible,
-			TASK_INTERRUPTIBLE);
+			TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 	rpc_clnt_sigunmask(clnt, &oldset);
 	return res;
 }
Index: MM-2.6.X/fs/nfs/pagelist.c
===================================================================
--- MM-2.6.X.orig/fs/nfs/pagelist.c	2005-10-28 10:02:08.000000000 +1000
+++ MM-2.6.X/fs/nfs/pagelist.c	2006-01-06 17:29:14.000000000 +1100
@@ -210,7 +210,8 @@ nfs_wait_on_request(struct nfs_page *req
 	 */
 	rpc_clnt_sigmask(clnt, &oldmask);
 	ret = out_of_line_wait_on_bit(&req->wb_flags, PG_BUSY,
-			nfs_wait_bit_interruptible, TASK_INTERRUPTIBLE);
+			nfs_wait_bit_interruptible,
+			TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 	rpc_clnt_sigunmask(clnt, &oldmask);
 out:
 	return ret;
Index: MM-2.6.X/fs/nfs/write.c
===================================================================
--- MM-2.6.X.orig/fs/nfs/write.c	2006-01-06 14:38:55.000000000 +1100
+++ MM-2.6.X/fs/nfs/write.c	2006-01-06 17:29:14.000000000 +1100
@@ -603,7 +603,8 @@ static int nfs_wait_on_write_congestion(
 		sigset_t oldset;
 
 		rpc_clnt_sigmask(clnt, &oldset);
-		prepare_to_wait(&nfs_write_congestion, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&nfs_write_congestion, &wait,
+				TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 		if (bdi_write_congested(bdi)) {
 			if (signalled())
 				ret = -ERESTARTSYS;
Index: MM-2.6.X/net/sunrpc/sched.c
===================================================================
--- MM-2.6.X.orig/net/sunrpc/sched.c	2006-01-06 14:39:38.000000000 +1100
+++ MM-2.6.X/net/sunrpc/sched.c	2006-01-06 17:29:14.000000000 +1100
@@ -285,7 +285,7 @@ int __rpc_wait_for_completion_task(struc
 	if (action == NULL)
 		action = rpc_wait_bit_interruptible;
 	return wait_on_bit(&task->tk_runstate, RPC_TASK_ACTIVE,
-			action, TASK_INTERRUPTIBLE);
+			action, TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 }
 EXPORT_SYMBOL(__rpc_wait_for_completion_task);
 
@@ -676,7 +676,7 @@ static int __rpc_execute(struct rpc_task
 		/* Note: Caller should be using rpc_clnt_sigmask() */
 		status = out_of_line_wait_on_bit(&task->tk_runstate,
 				RPC_TASK_QUEUED, rpc_wait_bit_interruptible,
-				TASK_INTERRUPTIBLE);
+				TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 		if (status == -ERESTARTSYS) {
 			/*
 			 * When a sync task receives a signal, it exits with
Index: MM-2.6.X/net/sunrpc/svcsock.c
===================================================================
--- MM-2.6.X.orig/net/sunrpc/svcsock.c	2006-01-06 14:39:38.000000000 +1100
+++ MM-2.6.X/net/sunrpc/svcsock.c	2006-01-06 17:29:14.000000000 +1100
@@ -1213,7 +1213,7 @@ svc_recv(struct svc_serv *serv, struct s
 		 * We have to be able to interrupt this wait
 		 * to bring down the daemons ...
 		 */
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 		add_wait_queue(&rqstp->rq_wait, &wait);
 		spin_unlock_bh(&serv->sv_lock);
 

--------------090901040100030509070603--
