Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312832AbSDBJUN>; Tue, 2 Apr 2002 04:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312833AbSDBJUF>; Tue, 2 Apr 2002 04:20:05 -0500
Received: from mons.uio.no ([129.240.130.14]:65431 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S312832AbSDBJUA>;
	Tue, 2 Apr 2002 04:20:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15529.30637.746149.701791@charged.uio.no>
Date: Tue, 2 Apr 2002 11:19:41 +0200
To: Kurt Garloff <garloff@suse.de>
Cc: NFS maillist <nfs@lists.sourceforge.net>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: linux-2.4.18-rpc_tweaks.dif
In-Reply-To: <20020327032736.G15481@gum01m.etpnet.phys.tue.nl>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Kurt Garloff <garloff@suse.de> writes:

     > Hi Trond,
     > http://www.fys.uio.no/~trondmy/src/2.4.18/linux-2.4.18-rpc_tweaks.dif
     > contains a change that causes devastating NFS client
     > performance: My NFS read performance on a switched 100BaseT
     > went down from >9MB/s to 500kB/s.  (NFSv3, rsize=8192, 2.4.16
     > AXP kernel nfsd server)

     > The reason is that xprt_adjust_cwnd() does no longer do what
     > the comment above says it should do: _slowly_ increase cwnd
     > until we start to hit the limit (which we see from timed out
     > requests). Instead cwnd gets bumped very fast resulting in lots
     > of timed out requests. This way you get fast oscillations in
     > cwnd.

'slow start' actually only means that you start off with 1 request and
then build up by doubling the window size each time all requests have
been acked. (see Van Jacobson paper's 'Congestion Avoidance and
Control' on http://www-nrg.ee.lbl.gov/nrg-papers.html)

The problem is that the current algorithm is way too slow in building
up: it rarely gets to use more than 1 slot at a time even on a perfect
network+server setup. The reason for this is the 'xprt->congtime' hack
that I introduced in order to deliberately slow the window buildup
(and the shrinkages) while the issues were being figured out.

I've now had a little time during the easter break to look into things
again. I think that part of the problem is the fact that resends do
not get limited when the cwnd shrinks. This means that when a window
times out due to server congestion, you continue to flood the server
by resending the same requests over again, rather than backing off...


The appended patch should apply on top of NFS_ALL (with the rpc_tweaks
applied). Since you are one of the people to report a problem I'd be
interested to hear how it affects your setup.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.18-rpc_tweaks/include/linux/sunrpc/xprt.h linux-2.4.18-rpc_cong/include/linux/sunrpc/xprt.h
--- linux-2.4.18-rpc_tweaks/include/linux/sunrpc/xprt.h	Wed Feb 20 17:26:00 2002
+++ linux-2.4.18-rpc_cong/include/linux/sunrpc/xprt.h	Tue Apr  2 06:37:52 2002
@@ -44,7 +44,7 @@
 #define RPC_MAXCWND		(RPC_MAXCONG * RPC_CWNDSCALE)
 #define RPC_INITCWND		RPC_CWNDSCALE
 #define RPCXPRT_CONGESTED(xprt) \
-	((xprt)->cong >= (xprt)->cwnd)
+	((xprt)->cong > (xprt)->cwnd)
 #define RPCXPRT_SUPERCONGESTED(xprt) \
 				((xprt)->cwnd < 2*RPC_CWNDSCALE)
 
@@ -98,6 +98,7 @@
 	struct rpc_task *	rq_task;	/* RPC task data */
 	__u32			rq_xid;		/* request XID */
 	struct rpc_rqst *	rq_next;	/* free list */
+	unsigned char		rq_cong     : 1;/* incremented xprt->cong */
 	volatile unsigned char	rq_received : 1;/* receive completed */
 
 	/*
diff -u --recursive --new-file linux-2.4.18-rpc_tweaks/net/sunrpc/ping.c linux-2.4.18-rpc_cong/net/sunrpc/ping.c
--- linux-2.4.18-rpc_tweaks/net/sunrpc/ping.c	Wed Feb 20 17:19:18 2002
+++ linux-2.4.18-rpc_cong/net/sunrpc/ping.c	Tue Apr  2 06:56:15 2002
@@ -168,7 +168,7 @@
 		task->tk_pid, task->tk_status);
 
 	task->tk_action = NULL;
-	xprt_ping_release(task);
+	xprt_release(task);
 
 	/* Sigh. rpc_delay() clears task->tk_status */
 	if (task->tk_status == 0 && xprt_norespond(xprt))
diff -u --recursive --new-file linux-2.4.18-rpc_tweaks/net/sunrpc/xprt.c linux-2.4.18-rpc_cong/net/sunrpc/xprt.c
--- linux-2.4.18-rpc_tweaks/net/sunrpc/xprt.c	Wed Mar 20 22:32:52 2002
+++ linux-2.4.18-rpc_cong/net/sunrpc/xprt.c	Tue Apr  2 06:55:36 2002
@@ -85,7 +85,7 @@
  */
 static void	xprt_request_init(struct rpc_task *, struct rpc_xprt *);
 static void	do_xprt_transmit(struct rpc_task *);
-static void	xprt_alloc_slot(struct rpc_xprt *, struct rpc_task *);
+static void	xprt_alloc_slot(struct rpc_xprt *, struct rpc_task *, int);
 static void	xprt_disconnect(struct rpc_xprt *);
 static void	xprt_reconn_status(struct rpc_task *task);
 static struct socket *xprt_create_socket(int, struct rpc_timeout *);
@@ -311,32 +311,81 @@
 
 
 /*
+ * Van Jacobson congestion avoidance. Check if the congestion window
+ * overflowed. Put the task to sleep if this is the case.
+ */
+static int
+xprt_cwnd_limited(struct rpc_xprt *xprt, struct rpc_rqst *req)
+{
+	struct rpc_task *task = req->rq_task;
+	unsigned long oldcong;
+
+	if (req->rq_cong || xprt->nocong)
+		return 0;
+	dprintk("RPC: %4d xprt_cwnd_limited cong = %ld cwnd = %ld\n",
+		task->tk_pid, xprt->cong, xprt->cwnd);
+	spin_lock_bh(&xprt->sock_lock);
+	oldcong = xprt->cong;
+	xprt->cong += RPC_CWNDSCALE;
+	if (!RPCXPRT_CONGESTED(xprt)) {
+		spin_unlock_bh(&xprt->sock_lock);
+		req->rq_cong = 1;
+		return 0;
+	}
+	xprt->cong = oldcong;
+	task->tk_timeout = 0;
+	task->tk_status = -EAGAIN;
+	rpc_sleep_on(&xprt->sending, task, NULL, NULL);
+	spin_unlock_bh(&xprt->sock_lock);
+	return 1;
+}
+
+/*
  * Adjust RPC congestion window
  * We use a time-smoothed congestion estimator to avoid heavy oscillation.
  */
-static void
-xprt_adjust_cwnd(struct rpc_xprt *xprt, int result)
+static inline void
+__xprt_adjust_cwnd(struct rpc_xprt *xprt, int result)
 {
 	unsigned long	cwnd;
 
-	if (xprt->nocong)
-		return;
-	/*
-	 * Note: we're in a BH context
-	 */
-	spin_lock(&xprt->xprt_lock);
 	cwnd = xprt->cwnd;
-	if (result >= 0 && cwnd < RPC_MAXCWND && xprt->cong == cwnd) {
-		cwnd += RPC_CWNDSCALE;
-		xprt_clear_backlog(xprt);
-	} else if (result == -ETIMEDOUT && cwnd > RPC_CWNDSCALE)
-		cwnd -= RPC_CWNDSCALE;
+	if (result >= 0) {
+		/* The (cwnd >> 1) term makes sure
+		 * the result gets rounded properly. */
+		cwnd += (RPC_CWNDSCALE * RPC_CWNDSCALE + (cwnd >> 1)) / cwnd;
+		if (cwnd > RPC_MAXCWND)
+			cwnd = RPC_MAXCWND;
+	} else if (result == -ETIMEDOUT) {
+		if ((cwnd >>= 1) < RPC_CWNDSCALE)
+			cwnd = RPC_CWNDSCALE;
+	}
 
-	dprintk("RPC:      cong %08lx, cwnd was %08lx, now %08lx\n",
+	dprintk("RPC:      cong %ld, cwnd was %ld, now %ld\n",
 		xprt->cong, xprt->cwnd, cwnd);
-
 	xprt->cwnd = cwnd;
-	spin_unlock(&xprt->xprt_lock);
+}
+
+/*
+ * Adjust the congestion window, and wake up the next task
+ * that has been sleeping due to congestion
+ */
+static void
+xprt_adjust_cwnd(struct rpc_xprt *xprt, struct rpc_rqst *req, int adjust)
+{
+	if (!req->rq_cong)
+		return;
+	req->rq_cong = 0;
+	spin_lock_bh(&xprt->sock_lock);
+	if (adjust)
+		__xprt_adjust_cwnd(xprt, adjust);
+	if (!RPCXPRT_CONGESTED(xprt)) {
+		struct rpc_task *next = xprt->snd_task;
+		if (next && !next->tk_rqstp->rq_cong)
+			rpc_wake_up_task(next);
+	}
+	xprt->cong -= RPC_CWNDSCALE;
+	spin_unlock_bh(&xprt->sock_lock);
 }
 
 /*
@@ -565,7 +614,7 @@
 	struct rpc_task	*task = req->rq_task;
 
 	/* Adjust congestion window */
-	xprt_adjust_cwnd(xprt, copied);
+	xprt_adjust_cwnd(xprt, req, copied);
 
 #ifdef RPC_PROFILE
 	/* Profile only reads for now */
@@ -1139,7 +1188,7 @@
 	struct rpc_rqst	*req = task->tk_rqstp;
 
 	if (req)
-		xprt_adjust_cwnd(task->tk_xprt, -ETIMEDOUT);
+		xprt_adjust_cwnd(task->tk_xprt, req, -ETIMEDOUT);
 
 	dprintk("RPC: %4d xprt_timer (%s request)\n",
 		task->tk_pid, req ? "pending" : "backlogged");
@@ -1184,6 +1233,8 @@
 
 	if (!xprt_lock_write(xprt, task))
 		return;
+	if (xprt_cwnd_limited(xprt, req))
+		return;
 
 #ifdef RPC_PROFILE
 	req->rq_xtime = jiffies;
@@ -1239,6 +1290,7 @@
 			break;
 	}
 	rpc_unlock_task(task);
+	xprt_adjust_cwnd(xprt, req, 0);
 
 	/* Note: at this point, task->tk_sleeping has not yet been set,
 	 *	 hence there is no danger of the waking up task being put on
@@ -1317,11 +1369,9 @@
 	dprintk("RPC: %4d xprt_reserve cong = %ld cwnd = %ld\n",
 				task->tk_pid, xprt->cong, xprt->cwnd);
 	spin_lock_bh(&xprt->xprt_lock);
-	if (!RPCXPRT_CONGESTED(xprt))
-		xprt_alloc_slot(xprt, task);
+	xprt_alloc_slot(xprt, task, 0);
 	if (task->tk_rqstp) {
 		task->tk_timeout = 0;
-		xprt->cong    += RPC_CWNDSCALE;
 	} else if (!task->tk_timeout) {
 		task->tk_status = -ENOBUFS;
 	} else {
@@ -1350,7 +1400,7 @@
 	dprintk("RPC: %4d xprt_ping_reserve cong = %ld cwnd = %ld\n",
 				task->tk_pid, xprt->cong, xprt->cwnd);
 	spin_lock_bh(&xprt->xprt_lock);
-	xprt_alloc_slot(xprt, task);
+	xprt_alloc_slot(xprt, task, 1);
  	if (!task->tk_rqstp)
 		task->tk_status = -ENOBUFS;
 	spin_unlock_bh(&xprt->xprt_lock);
@@ -1363,12 +1413,14 @@
  * Reserve a slot
  */
 static void
-xprt_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
+xprt_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task, int is_ping)
 {
 	struct rpc_rqst	*req;
 
 	if (!(req = xprt->free))
 		goto out_nofree;
+	if (!is_ping && !req->rq_next)
+		goto out_nofree;
 	/* OK: There's room for us. Grab a free slot and bump
 	 * congestion value */
 	xprt->free     = req->rq_next;
@@ -1406,8 +1458,8 @@
 /*
  * Release an RPC call slot
  */
-static void
-__xprt_release(struct rpc_task *task, int congvalue)
+void
+xprt_release(struct rpc_task *task)
 {
 	struct rpc_xprt	*xprt = task->tk_xprt;
 	struct rpc_rqst	*req;
@@ -1427,27 +1479,11 @@
 	spin_lock_bh(&xprt->xprt_lock);
 	req->rq_next = xprt->free;
 	xprt->free   = req;
-
-	if (congvalue) {
-		/* Decrease congestion value. */
-		xprt->cong -= congvalue;
+	if (req->rq_next)
 		xprt_clear_backlog(xprt);
-	}
 	spin_unlock_bh(&xprt->xprt_lock);
 }
 
-void
-xprt_release(struct rpc_task *task)
-{
-	__xprt_release(task, RPC_CWNDSCALE);
-}
-
-void
-xprt_ping_release(struct rpc_task *task)
-{
-	__xprt_release(task, 0);
-}
-
 /*
  * Set default timeout parameters
  */
@@ -1694,8 +1730,6 @@
  */
 int
 xprt_clear_backlog(struct rpc_xprt *xprt) {
-	if (RPCXPRT_CONGESTED(xprt))
-		return 0;
 	rpc_wake_up_next(&xprt->backlog);
 	if (waitqueue_active(&xprt->cong_wait))
 		wake_up(&xprt->cong_wait);
