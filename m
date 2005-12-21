Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVLUGAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVLUGAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 01:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVLUGAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 01:00:42 -0500
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:35490 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932248AbVLUGAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 01:00:41 -0500
Message-ID: <43A8EF87.1080108@bigpond.net.au>
Date: Wed, 21 Dec 2005 17:00:39 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: Fix adverse effects of NFS client on interactive response
Content-Type: multipart/mixed;
 boundary="------------000309050908090407020705"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Dec 2005 06:00:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000309050908090407020705
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
SUNRPC are NOT interactive sleeps.

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
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------000309050908090407020705
Content-Type: text/plain;
 name="make-nfs-sleeps-noninteractive"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make-nfs-sleeps-noninteractive"

Index: GIT-warnings/fs/nfs/inode.c
===================================================================
--- GIT-warnings.orig/fs/nfs/inode.c	2005-12-21 16:22:09.000000000 +1100
+++ GIT-warnings/fs/nfs/inode.c	2005-12-21 16:22:11.000000000 +1100
@@ -937,7 +937,8 @@ static int nfs_wait_on_inode(struct inod
 
 	rpc_clnt_sigmask(clnt, &oldmask);
 	error = wait_on_bit_lock(&nfsi->flags, NFS_INO_REVALIDATING,
-					nfs_wait_schedule, TASK_INTERRUPTIBLE);
+					nfs_wait_schedule,
+					TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 	rpc_clnt_sigunmask(clnt, &oldmask);
 
 	return error;
Index: GIT-warnings/fs/nfs/nfs4proc.c
===================================================================
--- GIT-warnings.orig/fs/nfs/nfs4proc.c	2005-12-21 16:22:09.000000000 +1100
+++ GIT-warnings/fs/nfs/nfs4proc.c	2005-12-21 16:22:11.000000000 +1100
@@ -2547,7 +2547,7 @@ static int nfs4_wait_clnt_recover(struct
 	rpc_clnt_sigmask(clnt, &oldset);
 	interruptible = TASK_UNINTERRUPTIBLE;
 	if (clnt->cl_intr)
-		interruptible = TASK_INTERRUPTIBLE;
+		interruptible = TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE;
 	prepare_to_wait(&clp->cl_waitq, &wait, interruptible);
 	nfs4_schedule_state_recovery(clp);
 	if (clnt->cl_intr && signalled())
Index: GIT-warnings/fs/nfs/pagelist.c
===================================================================
--- GIT-warnings.orig/fs/nfs/pagelist.c	2005-12-21 16:22:09.000000000 +1100
+++ GIT-warnings/fs/nfs/pagelist.c	2005-12-21 16:22:11.000000000 +1100
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
Index: GIT-warnings/fs/nfs/write.c
===================================================================
--- GIT-warnings.orig/fs/nfs/write.c	2005-12-21 16:22:09.000000000 +1100
+++ GIT-warnings/fs/nfs/write.c	2005-12-21 16:22:11.000000000 +1100
@@ -595,7 +595,8 @@ static int nfs_wait_on_write_congestion(
 		sigset_t oldset;
 
 		rpc_clnt_sigmask(clnt, &oldset);
-		prepare_to_wait(&nfs_write_congestion, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&nfs_write_congestion, &wait,
+				TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 		if (bdi_write_congested(bdi)) {
 			if (signalled())
 				ret = -ERESTARTSYS;
Index: GIT-warnings/net/sunrpc/sched.c
===================================================================
--- GIT-warnings.orig/net/sunrpc/sched.c	2005-12-21 16:22:09.000000000 +1100
+++ GIT-warnings/net/sunrpc/sched.c	2005-12-21 16:22:11.000000000 +1100
@@ -659,7 +659,7 @@ static int __rpc_execute(struct rpc_task
 		/* Note: Caller should be using rpc_clnt_sigmask() */
 		status = out_of_line_wait_on_bit(&task->tk_runstate,
 				RPC_TASK_QUEUED, rpc_wait_bit_interruptible,
-				TASK_INTERRUPTIBLE);
+				TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 		if (status == -ERESTARTSYS) {
 			/*
 			 * When a sync task receives a signal, it exits with
Index: GIT-warnings/net/sunrpc/svcsock.c
===================================================================
--- GIT-warnings.orig/net/sunrpc/svcsock.c	2005-12-21 16:22:09.000000000 +1100
+++ GIT-warnings/net/sunrpc/svcsock.c	2005-12-21 16:22:11.000000000 +1100
@@ -1213,7 +1213,7 @@ svc_recv(struct svc_serv *serv, struct s
 		 * We have to be able to interrupt this wait
 		 * to bring down the daemons ...
 		 */
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 		add_wait_queue(&rqstp->rq_wait, &wait);
 		spin_unlock_bh(&serv->sv_lock);
 

--------------000309050908090407020705--
