Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317916AbSGPSAd>; Tue, 16 Jul 2002 14:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317913AbSGPR6a>; Tue, 16 Jul 2002 13:58:30 -0400
Received: from pat.uio.no ([129.240.130.16]:9712 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317935AbSGPR5Q>;
	Tue, 16 Jul 2002 13:57:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15668.24358.596386.459941@charged.uio.no>
Date: Tue, 16 Jul 2002 20:00:06 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] RPC over UDP congestion control updates [7/8]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  - Divorce the allocation of free request slots and the congestion
    control. Make the congestion control apply only to when we
    actually send data over the wire. This means that we *do* apply
    congestion control to resent requests: if a timeout has occured,
    and there are too many requests on the wire, delay resending until
    the congestion algorithm allows it.

  - Improve spinlocking by putting the congestion avoidance algoritm
    under xprt->sock_lock. This lock has to be taken *anyway* in
    (almost) all cases where we are updating the congestion control
    data.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25-rpc_cong2/net/sunrpc/xprt.c linux-2.5.25-rpc_cong3/net/sunrpc/xprt.c
--- linux-2.5.25-rpc_cong2/net/sunrpc/xprt.c	Tue Jul 16 15:46:36 2002
+++ linux-2.5.25-rpc_cong3/net/sunrpc/xprt.c	Tue Jul 16 15:32:36 2002
@@ -141,9 +141,11 @@
 {
 	int retval;
 	spin_lock_bh(&xprt->sock_lock);
-	if (!xprt->snd_task)
-		xprt->snd_task = task;
-	else if (xprt->snd_task != task) {
+	if (!xprt->snd_task) {
+		if (xprt->nocong || __xprt_get_cong(xprt, task))
+			xprt->snd_task = task;
+	}
+	if (xprt->snd_task != task) {
 		dprintk("RPC: %4d TCP write queue full (task %d)\n",
 			task->tk_pid, xprt->snd_task->tk_pid);
 		task->tk_timeout = 0;
@@ -162,10 +164,13 @@
 
 	if (xprt->snd_task)
 		return;
+	if (!xprt->nocong && RPCXPRT_CONGESTED(xprt))
+		return;
 	task = rpc_wake_up_next(&xprt->sending);
 	if (!task)
 		return;
-	xprt->snd_task = task;
+	if (xprt->nocong || __xprt_get_cong(xprt, task))
+		xprt->snd_task = task;
 }
 
 /*
@@ -297,12 +302,6 @@
 {
 	unsigned long	cwnd;
 
-	if (xprt->nocong)
-		return;
-	/*
-	 * Note: we're in a BH context
-	 */
-	spin_lock(&xprt->xprt_lock);
 	cwnd = xprt->cwnd;
 	if (result >= 0 && xprt->cong <= cwnd) {
 		/* The (cwnd >> 1) term makes sure
@@ -319,8 +318,6 @@
 	dprintk("RPC:      cong %ld, cwnd was %ld, now %ld\n",
 			xprt->cong, xprt->cwnd, cwnd);
 	xprt->cwnd = cwnd;
- out:
-	spin_unlock(&xprt->xprt_lock);
 }
 
 /*
@@ -534,6 +531,7 @@
 	/* Adjust congestion window */
 	if (!xprt->nocong) {
 		xprt_adjust_cwnd(xprt, copied);
+		__xprt_put_cong(xprt, req);
 	       	if (!req->rq_nresend) {
 			int timer = rpcproc_timer(clnt, task->tk_msg.rpc_proc);
 			if (timer)
@@ -1011,6 +1009,7 @@
 		}
 		rpc_inc_timeo(&task->tk_client->cl_rtt);
 		xprt_adjust_cwnd(req->rq_xprt, -ETIMEDOUT);
+		__xprt_put_cong(xprt, req);
 	}
 	req->rq_nresend++;
 
@@ -1139,7 +1138,10 @@
 		req->rq_bytes_sent = 0;
 	}
  out_release:
-	xprt_release_write(xprt, task);
+	spin_lock_bh(&xprt->sock_lock);
+	__xprt_release_write(xprt, task);
+	__xprt_put_cong(xprt, req);
+	spin_unlock_bh(&xprt->sock_lock);
 	return;
  out_receive:
 	dprintk("RPC: %4d xmit complete\n", task->tk_pid);
@@ -1171,7 +1173,7 @@
 	if (task->tk_rqstp)
 		return 0;
 
-	spin_lock_bh(&xprt->xprt_lock);
+	spin_lock(&xprt->xprt_lock);
 	xprt_reserve_status(task);
 	if (task->tk_rqstp) {
 		task->tk_timeout = 0;
@@ -1182,7 +1184,7 @@
 		task->tk_status = -EAGAIN;
 		rpc_sleep_on(&xprt->backlog, task, NULL, NULL);
 	}
-	spin_unlock_bh(&xprt->xprt_lock);
+	spin_unlock(&xprt->xprt_lock);
 	dprintk("RPC: %4d xprt_reserve returns %d\n",
 				task->tk_pid, task->tk_status);
 	return task->tk_status;
@@ -1206,17 +1208,11 @@
 	} else {
 		if (!(req = xprt->free))
 			goto out_nofree;
-		if (!(xprt->nocong || __xprt_get_cong(xprt, req)))
-			goto out_nofree;
-		/* OK: There's room for us. Grab a free slot and bump
-		 * congestion value */
+		/* OK: There's room for us. Grab a free slot */
 		xprt->free     = req->rq_next;
 		req->rq_next   = NULL;
 		task->tk_rqstp = req;
 		xprt_request_init(task, xprt);
-
-		if (xprt->free)
-			xprt_clear_backlog(xprt);
 	}
 
 	return;
@@ -1264,6 +1260,7 @@
 		return;
 	spin_lock_bh(&xprt->sock_lock);
 	__xprt_release_write(xprt, task);
+	__xprt_put_cong(xprt, req);
 	if (!list_empty(&req->rq_list))
 		list_del(&req->rq_list);
 	spin_unlock_bh(&xprt->sock_lock);
@@ -1272,13 +1269,12 @@
 
 	dprintk("RPC: %4d release request %p\n", task->tk_pid, req);
 
-	spin_lock_bh(&xprt->xprt_lock);
+	spin_lock(&xprt->xprt_lock);
 	req->rq_next = xprt->free;
 	xprt->free   = req;
 
-	__xprt_put_cong(xprt, req);
 	xprt_clear_backlog(xprt);
-	spin_unlock_bh(&xprt->xprt_lock);
+	spin_unlock(&xprt->xprt_lock);
 }
 
 /*
@@ -1492,8 +1488,6 @@
  */
 int
 xprt_clear_backlog(struct rpc_xprt *xprt) {
-	if (RPCXPRT_CONGESTED(xprt))
-		return 0;
 	rpc_wake_up_next(&xprt->backlog);
 	if (waitqueue_active(&xprt->cong_wait))
 		wake_up(&xprt->cong_wait);
