Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317920AbSGPSA3>; Tue, 16 Jul 2002 14:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317921AbSGPR6o>; Tue, 16 Jul 2002 13:58:44 -0400
Received: from pat.uio.no ([129.240.130.16]:6640 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317916AbSGPR4f>;
	Tue, 16 Jul 2002 13:56:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15668.24317.288351.710242@charged.uio.no>
Date: Tue, 16 Jul 2002 19:59:25 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] RPC over UDP congestion control updates [4/8]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleanups for the socket locking mechanism.

Improve RPC request ordering by ensuring that RPC tasks that are
already queued on xprt->sending get sent before tasks that happen to
get scheduled just when there is a free slot.

In case the socket send buffer is full, queue the tasks on
xprt->pending rather than xprt->sending in order to eliminate the risk
of accidental wakeups from xprt_release_write() and xprt_write_space().

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25-rtt3/net/sunrpc/xprt.c linux-2.5.25-xprt_write/net/sunrpc/xprt.c
--- linux-2.5.25-rtt3/net/sunrpc/xprt.c	Tue Jul 16 15:28:49 2002
+++ linux-2.5.25-xprt_write/net/sunrpc/xprt.c	Tue Jul 16 15:30:05 2002
@@ -154,17 +154,35 @@
 	return retval;
 }
 
+static void
+__xprt_lock_write_next(struct rpc_xprt *xprt)
+{
+	struct rpc_task *task;
+
+	if (xprt->snd_task)
+		return;
+	task = rpc_wake_up_next(&xprt->sending);
+	if (!task)
+		return;
+	xprt->snd_task = task;
+}
+
 /*
  * Releases the socket for use by other requests.
  */
 static void
+__xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *task)
+{
+	if (xprt->snd_task == task)
+		xprt->snd_task = NULL;
+	__xprt_lock_write_next(xprt);
+}
+
+static inline void
 xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *task)
 {
 	spin_lock_bh(&xprt->sock_lock);
-	if (xprt->snd_task == task) {
-		xprt->snd_task = NULL;
-		rpc_wake_up_next(&xprt->sending);
-	}
+	__xprt_release_write(xprt, task);
 	spin_unlock_bh(&xprt->sock_lock);
 }
 
@@ -429,7 +447,7 @@
 			/* if the socket is already closing, delay 5 secs */
 			if ((1<<inet->state) & ~(TCP_SYN_SENT|TCP_SYN_RECV))
 				task->tk_timeout = 5*HZ;
-			rpc_sleep_on(&xprt->sending, task, xprt_reconn_status, NULL);
+			rpc_sleep_on(&xprt->pending, task, xprt_reconn_status, NULL);
 			release_sock(inet);
 			return;
 		}
@@ -883,7 +901,7 @@
 		xprt->tcp_flags = XPRT_COPY_RECM | XPRT_COPY_XID;
 
 		spin_lock(&xprt->sock_lock);
-		if (xprt->snd_task && xprt->snd_task->tk_rpcwait == &xprt->sending)
+		if (xprt->snd_task && xprt->snd_task->tk_rpcwait == &xprt->pending)
 			rpc_wake_up_task(xprt->snd_task);
 		spin_unlock(&xprt->sock_lock);
 		break;
@@ -920,7 +938,7 @@
 
 	if (!xprt_test_and_set_wspace(xprt)) {
 		spin_lock(&xprt->sock_lock);
-		if (xprt->snd_task && xprt->snd_task->tk_rpcwait == &xprt->sending)
+		if (xprt->snd_task && xprt->snd_task->tk_rpcwait == &xprt->pending)
 			rpc_wake_up_task(xprt->snd_task);
 		spin_unlock(&xprt->sock_lock);
 	}
@@ -1078,7 +1096,7 @@
 		spin_lock_bh(&xprt->sock_lock);
 		if (!xprt_wspace(xprt)) {
 			task->tk_timeout = req->rq_timeout.to_current;
-			rpc_sleep_on(&xprt->sending, task, NULL, NULL);
+			rpc_sleep_on(&xprt->pending, task, NULL, NULL);
 		}
 		spin_unlock_bh(&xprt->sock_lock);
 		return;
@@ -1094,9 +1112,10 @@
 		if (xprt->stream)
 			xprt_disconnect(xprt);
 		req->rq_bytes_sent = 0;
-		goto out_release;
 	}
-
+ out_release:
+	xprt_release_write(xprt, task);
+	return;
  out_receive:
 	dprintk("RPC: %4d xmit complete\n", task->tk_pid);
 	/* Set the task's receive timeout value */
@@ -1111,9 +1130,8 @@
 	spin_lock_bh(&xprt->sock_lock);
 	if (!req->rq_received)
 		rpc_sleep_on(&xprt->pending, task, NULL, xprt_timer);
+	__xprt_release_write(xprt, task);
 	spin_unlock_bh(&xprt->sock_lock);
- out_release:
-	xprt_release_write(xprt, task);
 }
 
 /*
@@ -1218,14 +1236,10 @@
 	struct rpc_xprt	*xprt = task->tk_xprt;
 	struct rpc_rqst	*req;
 
-	if (xprt->snd_task == task) {
-		if (xprt->stream)
-			xprt_disconnect(xprt);
-		xprt_release_write(xprt, task);
-	}
 	if (!(req = task->tk_rqstp))
 		return;
 	spin_lock_bh(&xprt->sock_lock);
+	__xprt_release_write(xprt, task);
 	if (!list_empty(&req->rq_list))
 		list_del(&req->rq_list);
 	spin_unlock_bh(&xprt->sock_lock);
