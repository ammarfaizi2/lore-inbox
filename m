Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSGGSzo>; Sun, 7 Jul 2002 14:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSGGSzn>; Sun, 7 Jul 2002 14:55:43 -0400
Received: from pat.uio.no ([129.240.130.16]:37781 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316437AbSGGSzj>;
	Sun, 7 Jul 2002 14:55:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15656.36665.925483.877526@charged.uio.no>
Date: Sun, 7 Jul 2002 20:58:01 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.25 Clean up RPC receive code
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Divorces task xid<->request slot mapping from the internals of the
rpc_waitqueue xprt->pending. Instead xprt_lookup_rqst() is made to
search a dedicated list (xprt->recv) on which the request slot is
placed immediately after being allocated to a task. The new queue is
protected using the spinlock xprt->sock_lock rather than the generic
RPC task lock.

  Both udp_data_ready() and tcp_data_ready() (well tcp_read_request()
actually) now need to protect against the request being removed from
the xprt->recv list while they copy the RPC reply data from the skb.
On the other hand, they no longer need to worry about the task
disappearing from xprt->pending. This means that rpc_lock_task() hack
can be replaced by the spinlock xprt->sock_lock.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25-fix_refresh/include/linux/sunrpc/xprt.h linux-2.5.25-rpc_rep/include/linux/sunrpc/xprt.h
--- linux-2.5.25-fix_refresh/include/linux/sunrpc/xprt.h	Sat May 25 21:26:12 2002
+++ linux-2.5.25-rpc_rep/include/linux/sunrpc/xprt.h	Sun Jul  7 17:43:16 2002
@@ -83,7 +83,9 @@
 	struct rpc_task *	rq_task;	/* RPC task data */
 	__u32			rq_xid;		/* request XID */
 	struct rpc_rqst *	rq_next;	/* free list */
-	volatile unsigned char	rq_received : 1;/* receive completed */
+	int			rq_received;	/* receive completed */
+
+	struct list_head	rq_list;
 
 	/*
 	 * For authentication (e.g. auth_des)
@@ -149,6 +151,8 @@
 	spinlock_t		xprt_lock;	/* lock xprt info */
 	struct rpc_task *	snd_task;	/* Task blocked in send */
 
+	struct list_head	recv;
+
 
 	void			(*old_data_ready)(struct sock *, int);
 	void			(*old_state_change)(struct sock *);
Binary files linux-2.5.25-fix_refresh/net/sunrpc/.xprt.c.swp and linux-2.5.25-rpc_rep/net/sunrpc/.xprt.c.swp differ
diff -u --recursive --new-file linux-2.5.25-fix_refresh/net/sunrpc/clnt.c linux-2.5.25-rpc_rep/net/sunrpc/clnt.c
--- linux-2.5.25-fix_refresh/net/sunrpc/clnt.c	Thu May 23 16:34:52 2002
+++ linux-2.5.25-rpc_rep/net/sunrpc/clnt.c	Sun Jul  7 17:43:16 2002
@@ -595,13 +595,16 @@
 	dprintk("RPC: %4d call_status (status %d)\n", 
 				task->tk_pid, task->tk_status);
 
+	req = task->tk_rqstp;
+	if (req->rq_received != 0)
+		status = req->rq_received;
 	if (status >= 0) {
+		req->rq_received = 0;
 		task->tk_action = call_decode;
 		return;
 	}
 
 	task->tk_status = 0;
-	req = task->tk_rqstp;
 	switch(status) {
 	case -ETIMEDOUT:
 		task->tk_action = call_timeout;
diff -u --recursive --new-file linux-2.5.25-fix_refresh/net/sunrpc/xprt.c linux-2.5.25-rpc_rep/net/sunrpc/xprt.c
--- linux-2.5.25-fix_refresh/net/sunrpc/xprt.c	Fri May 24 13:32:02 2002
+++ linux-2.5.25-rpc_rep/net/sunrpc/xprt.c	Sun Jul  7 17:57:26 2002
@@ -68,8 +68,6 @@
 
 #include <asm/uaccess.h>
 
-extern spinlock_t rpc_queue_lock;
-
 /*
  * Local variables
  */
@@ -465,20 +463,16 @@
 static inline struct rpc_rqst *
 xprt_lookup_rqst(struct rpc_xprt *xprt, u32 xid)
 {
-	struct rpc_rqst	*req;
-	struct list_head *le;
-	struct rpc_task *task;
+	struct list_head *pos;
+	struct rpc_rqst	*req = NULL;
 
-	spin_lock_bh(&rpc_queue_lock);
-	task_for_each(task, le, &xprt->pending.tasks)
-		if ((req = task->tk_rqstp) && req->rq_xid == xid)
-			goto out;
-	dprintk("RPC:      unknown XID %08x in reply.\n", xid);
-	req = NULL;
- out:
-	if (req && !__rpc_lock_task(req->rq_task))
-		req = NULL;
-	spin_unlock_bh(&rpc_queue_lock);
+	list_for_each(pos, &xprt->recv) {
+		struct rpc_rqst *entry = list_entry(pos, struct rpc_rqst, rq_list);
+		if (entry->rq_xid == xid) {
+			req = entry;
+			break;
+		}
+	}
 	return req;
 }
 
@@ -515,7 +509,7 @@
 
 	dprintk("RPC: %4d has input (%d bytes)\n", task->tk_pid, copied);
 	task->tk_status = copied;
-	req->rq_received = 1;
+	req->rq_received = copied;
 
 	/* ... and wake up the process. */
 	rpc_wake_up_task(task);
@@ -613,9 +607,10 @@
 	}
 
 	/* Look up and lock the request corresponding to the given XID */
+	spin_lock(&xprt->sock_lock);
 	rovr = xprt_lookup_rqst(xprt, *(u32 *) (skb->h.raw + sizeof(struct udphdr)));
 	if (!rovr)
-		goto dropit;
+		goto out_unlock;
 	task = rovr->rq_task;
 
 	dprintk("RPC: %4d received reply\n", task->tk_pid);
@@ -635,8 +630,7 @@
 	xprt_complete_rqst(xprt, rovr, copied);
 
  out_unlock:
-	rpc_unlock_task(task);
-
+	spin_unlock(&xprt->sock_lock);
  dropit:
 	skb_free_datagram(sk, skb);
  out:
@@ -738,11 +732,13 @@
 	size_t len;
 
 	/* Find and lock the request corresponding to this xid */
+	spin_lock(&xprt->sock_lock);
 	req = xprt_lookup_rqst(xprt, xprt->tcp_xid);
 	if (!req) {
 		xprt->tcp_flags &= ~XPRT_COPY_DATA;
 		dprintk("RPC:      XID %08x request not found!\n",
 				xprt->tcp_xid);
+		spin_unlock(&xprt->sock_lock);
 		return;
 	}
 
@@ -776,7 +772,7 @@
 				req->rq_task->tk_pid);
 		xprt_complete_rqst(xprt, req, xprt->tcp_copied);
 	}
-	rpc_unlock_task(req->rq_task); 
+	spin_unlock(&xprt->sock_lock);
 	tcp_check_recm(xprt);
 }
 
@@ -933,16 +929,21 @@
 xprt_timer(struct rpc_task *task)
 {
 	struct rpc_rqst	*req = task->tk_rqstp;
+	struct rpc_xprt *xprt = req->rq_xprt;
 
-	if (req)
-		xprt_adjust_cwnd(task->tk_xprt, -ETIMEDOUT);
+	spin_lock(&xprt->sock_lock);
+	if (req->rq_received)
+		goto out;
+	xprt_adjust_cwnd(xprt, -ETIMEDOUT);
 
 	dprintk("RPC: %4d xprt_timer (%s request)\n",
 		task->tk_pid, req ? "pending" : "backlogged");
 
 	task->tk_status  = -ETIMEDOUT;
+out:
 	task->tk_timeout = 0;
 	rpc_wake_up_task(task);
+	spin_unlock(&xprt->sock_lock);
 }
 
 /*
@@ -995,14 +996,6 @@
 	int status, retry = 0;
 
 
-	/* For fast networks/servers we have to put the request on
-	 * the pending list now:
-	 * Note that we don't want the task timing out during the
-	 * call to xprt_sendmsg(), so we initially disable the timeout,
-	 * and then reset it later...
-	 */
-	xprt_receive(task);
-
 	/* Continue transmitting the packet/record. We must be careful
 	 * to cope with writespace callbacks arriving _after_ we have
 	 * called xprt_sendmsg().
@@ -1034,15 +1027,11 @@
 		if (retry++ > 50)
 			break;
 	}
-	rpc_unlock_task(task);
 
 	/* Note: at this point, task->tk_sleeping has not yet been set,
 	 *	 hence there is no danger of the waking up task being put on
 	 *	 schedq, and being picked up by a parallel run of rpciod().
 	 */
-	rpc_wake_up_task(task);
-	if (!RPC_IS_RUNNING(task))
-		goto out_release;
 	if (req->rq_received)
 		goto out_release;
 
@@ -1077,31 +1066,15 @@
 	dprintk("RPC: %4d xmit complete\n", task->tk_pid);
 	/* Set the task's receive timeout value */
 	task->tk_timeout = req->rq_timeout.to_current;
-	rpc_add_timer(task, xprt_timer);
-	rpc_unlock_task(task);
+	spin_lock_bh(&xprt->sock_lock);
+	if (!req->rq_received)
+		rpc_sleep_on(&xprt->pending, task, NULL, xprt_timer);
+	spin_unlock_bh(&xprt->sock_lock);
  out_release:
 	xprt_release_write(xprt, task);
 }
 
 /*
- * Queue the task for a reply to our call.
- * When the callback is invoked, the congestion window should have
- * been updated already.
- */
-void
-xprt_receive(struct rpc_task *task)
-{
-	struct rpc_rqst	*req = task->tk_rqstp;
-	struct rpc_xprt	*xprt = req->rq_xprt;
-
-	dprintk("RPC: %4d xprt_receive\n", task->tk_pid);
-
-	req->rq_received = 0;
-	task->tk_timeout = 0;
-	rpc_sleep_locked(&xprt->pending, task, NULL, NULL);
-}
-
-/*
  * Reserve an RPC call slot.
  */
 int
@@ -1188,6 +1161,10 @@
 	req->rq_xid     = xid++;
 	if (!xid)
 		xid++;
+	INIT_LIST_HEAD(&req->rq_list);
+	spin_lock_bh(&xprt->sock_lock);
+	list_add_tail(&req->rq_list, &xprt->recv);
+	spin_unlock_bh(&xprt->sock_lock);
 }
 
 /*
@@ -1206,6 +1183,10 @@
 	}
 	if (!(req = task->tk_rqstp))
 		return;
+	spin_lock_bh(&xprt->sock_lock);
+	if (!list_empty(&req->rq_list))
+		list_del(&req->rq_list);
+	spin_unlock_bh(&xprt->sock_lock);
 	task->tk_rqstp = NULL;
 	memset(req, 0, sizeof(*req));	/* mark unused */
 
@@ -1280,6 +1261,8 @@
 	spin_lock_init(&xprt->xprt_lock);
 	init_waitqueue_head(&xprt->cong_wait);
 
+	INIT_LIST_HEAD(&xprt->recv);
+
 	/* Set timeout parameters */
 	if (to) {
 		xprt->timeout = *to;
