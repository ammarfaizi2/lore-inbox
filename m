Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317928AbSGPSA3>; Tue, 16 Jul 2002 14:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317920AbSGPR6i>; Tue, 16 Jul 2002 13:58:38 -0400
Received: from mons.uio.no ([129.240.130.14]:52713 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317944AbSGPR50>;
	Tue, 16 Jul 2002 13:57:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15668.24369.437063.733011@charged.uio.no>
Date: Tue, 16 Jul 2002 20:00:17 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] RPC over UDP congestion control updates [8/8]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When determining who gets access to the socket, give priority to
requests that are being resent. Despite the fact that congestion
control now applies to resends, we still want to ensure that resends
get ACKed as soon as possible (and before we start sending off new
requests).

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25-rpc_cong3/include/linux/sunrpc/xprt.h linux-2.5.25-rpc_cong4/include/linux/sunrpc/xprt.h
--- linux-2.5.25-rpc_cong3/include/linux/sunrpc/xprt.h	Tue Jul 16 15:32:36 2002
+++ linux-2.5.25-rpc_cong4/include/linux/sunrpc/xprt.h	Tue Jul 16 15:33:01 2002
@@ -123,6 +123,7 @@
 	unsigned long		cwnd;		/* congestion window */
 
 	struct rpc_wait_queue	sending;	/* requests waiting to send */
+	struct rpc_wait_queue	resend;		/* requests waiting to resend */
 	struct rpc_wait_queue	pending;	/* requests in flight */
 	struct rpc_wait_queue	backlog;	/* waiting for slot */
 	struct rpc_rqst *	free;		/* free slots */
diff -u --recursive --new-file linux-2.5.25-rpc_cong3/net/sunrpc/xprt.c linux-2.5.25-rpc_cong4/net/sunrpc/xprt.c
--- linux-2.5.25-rpc_cong3/net/sunrpc/xprt.c	Tue Jul 16 15:32:36 2002
+++ linux-2.5.25-rpc_cong4/net/sunrpc/xprt.c	Tue Jul 16 15:34:04 2002
@@ -150,7 +150,10 @@
 			task->tk_pid, xprt->snd_task->tk_pid);
 		task->tk_timeout = 0;
 		task->tk_status = -EAGAIN;
-		rpc_sleep_on(&xprt->sending, task, NULL, NULL);
+		if (task->tk_rqstp->rq_nresend)
+			rpc_sleep_on(&xprt->resend, task, NULL, NULL);
+		else
+			rpc_sleep_on(&xprt->sending, task, NULL, NULL);
 	}
 	retval = xprt->snd_task == task;
 	spin_unlock_bh(&xprt->sock_lock);
@@ -166,9 +169,12 @@
 		return;
 	if (!xprt->nocong && RPCXPRT_CONGESTED(xprt))
 		return;
-	task = rpc_wake_up_next(&xprt->sending);
-	if (!task)
-		return;
+	task = rpc_wake_up_next(&xprt->resend);
+	if (!task) {
+		task = rpc_wake_up_next(&xprt->sending);
+		if (!task)
+			return;
+	}
 	if (xprt->nocong || __xprt_get_cong(xprt, task))
 		xprt->snd_task = task;
 }
@@ -1346,6 +1352,7 @@
 
 	INIT_RPC_WAITQ(&xprt->pending, "xprt_pending");
 	INIT_RPC_WAITQ(&xprt->sending, "xprt_sending");
+	INIT_RPC_WAITQ(&xprt->resend, "xprt_resend");
 	INIT_RPC_WAITQ(&xprt->backlog, "xprt_backlog");
 
 	/* initialize free list */
@@ -1477,6 +1484,7 @@
 {
 	xprt->shutdown = 1;
 	rpc_wake_up(&xprt->sending);
+	rpc_wake_up(&xprt->resend);
 	rpc_wake_up(&xprt->pending);
 	rpc_wake_up(&xprt->backlog);
 	if (waitqueue_active(&xprt->cong_wait))
