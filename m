Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317914AbSGPR6L>; Tue, 16 Jul 2002 13:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317913AbSGPR6K>; Tue, 16 Jul 2002 13:58:10 -0400
Received: from pat.uio.no ([129.240.130.16]:7664 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317931AbSGPR4w>;
	Tue, 16 Jul 2002 13:56:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15668.24334.163508.811101@charged.uio.no>
Date: Tue, 16 Jul 2002 19:59:42 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] RPC over UDP congestion control updates [5/8]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Clean up the Van Jacobson network congestion control code.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25-xprt_write/include/linux/sunrpc/xprt.h linux-2.5.25-rpc_cong1/include/linux/sunrpc/xprt.h
--- linux-2.5.25-xprt_write/include/linux/sunrpc/xprt.h	Tue Jul 16 15:28:49 2002
+++ linux-2.5.25-rpc_cong1/include/linux/sunrpc/xprt.h	Tue Jul 16 15:32:03 2002
@@ -19,7 +19,7 @@
  * The transport code maintains an estimate on the maximum number of out-
  * standing RPC requests, using a smoothed version of the congestion
  * avoidance implemented in 44BSD. This is basically the Van Jacobson
- * slow start algorithm: If a retransmit occurs, the congestion window is
+ * congestion algorithm: If a retransmit occurs, the congestion window is
  * halved; otherwise, it is incremented by 1/cwnd when
  *
  *	-	a reply is received and
@@ -32,15 +32,13 @@
  * Note: on machines with low memory we should probably use a smaller
  * MAXREQS value: At 32 outstanding reqs with 8 megs of RAM, fragment
  * reassembly will frequently run out of memory.
- * Come Linux 2.3, we'll handle fragments directly.
  */
 #define RPC_MAXCONG		16
 #define RPC_MAXREQS		(RPC_MAXCONG + 1)
 #define RPC_CWNDSCALE		256
 #define RPC_MAXCWND		(RPC_MAXCONG * RPC_CWNDSCALE)
 #define RPC_INITCWND		RPC_CWNDSCALE
-#define RPCXPRT_CONGESTED(xprt) \
-	((xprt)->cong >= (xprt)->cwnd)
+#define RPCXPRT_CONGESTED(xprt) ((xprt)->cong >= (xprt)->cwnd)
 
 /* Default timeout values */
 #define RPC_MAX_UDP_TIMEOUT	(60*HZ)
@@ -83,6 +81,7 @@
 	struct rpc_task *	rq_task;	/* RPC task data */
 	__u32			rq_xid;		/* request XID */
 	struct rpc_rqst *	rq_next;	/* free list */
+	int			rq_cong;	/* has incremented xprt->cong */
 	int			rq_received;	/* receive completed */
 
 	struct list_head	rq_list;
diff -u --recursive --new-file linux-2.5.25-xprt_write/net/sunrpc/xprt.c linux-2.5.25-rpc_cong1/net/sunrpc/xprt.c
--- linux-2.5.25-xprt_write/net/sunrpc/xprt.c	Tue Jul 16 15:30:05 2002
+++ linux-2.5.25-rpc_cong1/net/sunrpc/xprt.c	Tue Jul 16 15:32:03 2002
@@ -89,6 +89,7 @@
 static void	xprt_reconn_status(struct rpc_task *task);
 static struct socket *xprt_create_socket(int, struct rpc_timeout *);
 static int	xprt_bind_socket(struct rpc_xprt *, struct socket *);
+static int      __xprt_get_cong(struct rpc_xprt *, struct rpc_task *);
 
 #ifdef RPC_DEBUG_DATA
 /*
@@ -254,6 +255,40 @@
 }
 
 /*
+ * Van Jacobson congestion avoidance. Check if the congestion window
+ * overflowed. Put the task to sleep if this is the case.
+ */
+static int
+__xprt_get_cong(struct rpc_xprt *xprt, struct rpc_task *task)
+{
+	struct rpc_rqst *req = task->tk_rqstp;
+
+	if (req->rq_cong)
+		return 1;
+	dprintk("RPC: %4d xprt_cwnd_limited cong = %ld cwnd = %ld\n",
+			task->tk_pid, xprt->cong, xprt->cwnd);
+	if (RPCXPRT_CONGESTED(xprt))
+		return 0;
+	req->rq_cong = 1;
+	xprt->cong += RPC_CWNDSCALE;
+	return 1;
+}
+
+/*
+ * Adjust the congestion window, and wake up the next task
+ * that has been sleeping due to congestion
+ */
+static void
+__xprt_put_cong(struct rpc_xprt *xprt, struct rpc_rqst *req)
+{
+	if (!req->rq_cong)
+		return;
+	req->rq_cong = 0;
+	xprt->cong -= RPC_CWNDSCALE;
+	__xprt_lock_write_next(xprt);
+}
+
+/*
  * Adjust RPC congestion window
  * We use a time-smoothed congestion estimator to avoid heavy oscillation.
  */
@@ -1146,8 +1181,6 @@
 	if (task->tk_rqstp)
 		return 0;
 
-	dprintk("RPC: %4d xprt_reserve cong = %ld cwnd = %ld\n",
-				task->tk_pid, xprt->cong, xprt->cwnd);
 	spin_lock_bh(&xprt->xprt_lock);
 	xprt_reserve_status(task);
 	if (task->tk_rqstp) {
@@ -1181,13 +1214,14 @@
 	} else if (task->tk_rqstp) {
 		/* We've already been given a request slot: NOP */
 	} else {
-		if (RPCXPRT_CONGESTED(xprt) || !(req = xprt->free))
+		if (!(req = xprt->free))
+			goto out_nofree;
+		if (!(xprt->nocong || __xprt_get_cong(xprt, req)))
 			goto out_nofree;
 		/* OK: There's room for us. Grab a free slot and bump
 		 * congestion value */
 		xprt->free     = req->rq_next;
 		req->rq_next   = NULL;
-		xprt->cong    += RPC_CWNDSCALE;
 		task->tk_rqstp = req;
 		xprt_request_init(task, xprt);
 
@@ -1252,9 +1286,7 @@
 	req->rq_next = xprt->free;
 	xprt->free   = req;
 
-	/* Decrease congestion value. */
-	xprt->cong -= RPC_CWNDSCALE;
-
+	__xprt_put_cong(xprt, req);
 	xprt_clear_backlog(xprt);
 	spin_unlock_bh(&xprt->xprt_lock);
 }
