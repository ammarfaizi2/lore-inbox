Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269697AbTGJXWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269702AbTGJXWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:22:38 -0400
Received: from pat.uio.no ([129.240.130.16]:49894 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S269697AbTGJXVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:21:42 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0YcCfUSPHm"
Content-Transfer-Encoding: 7bit
Message-ID: <16141.63602.314666.241727@charged.uio.no>
Date: Fri, 11 Jul 2003 01:36:18 +0200
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client errors with 2.5.74?
In-Reply-To: <20030710153557.GD29113@mail.jlokier.co.uk>
References: <20030710053944.GA27038@mail.jlokier.co.uk>
	<16141.15245.367725.364913@charged.uio.no>
	<20030710150012.GA29113@mail.jlokier.co.uk>
	<16141.32852.39625.891724@charged.uio.no>
	<20030710153557.GD29113@mail.jlokier.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0YcCfUSPHm
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


OK... I have two patches for you... (I've attached them as plaintext
MIME thingmajigs)...

The first one should fix the problem of the kernel missing replies
while we are busy trying to resend a request.

The second, solves a problem of resource starvation. The fact that we
can currently just submit arbitrary numbers of asynchronous requests
means that we can exhaust resources to the point where the socket
starts dropping replies.
This patch limits the number of outstanding asynchronous requests to
16 per socket (the maximum number of xprt/transport slots).

Cheers,
  Trond


--0YcCfUSPHm
Content-Type: text/plain
Content-Description: patch 1/2
Content-Disposition: inline;
	filename="linux-2.5.74-13-resends.dif"
Content-Transfer-Encoding: 7bit

diff -u --recursive --new-file linux-2.5.74/include/linux/sunrpc/xprt.h linux-2.5.74-13-resends/include/linux/sunrpc/xprt.h
--- linux-2.5.74/include/linux/sunrpc/xprt.h	2003-07-10 22:52:35.000000000 +0200
+++ linux-2.5.74-13-resends/include/linux/sunrpc/xprt.h	2003-07-10 22:53:45.000000000 +0200
@@ -111,7 +111,7 @@
 
 	unsigned long		rq_xtime;	/* when transmitted */
 	int			rq_ntimeo;
-	int			rq_nresend;
+	int			rq_ntrans;
 };
 #define rq_svec			rq_snd_buf.head
 #define rq_slen			rq_snd_buf.len
diff -u --recursive --new-file linux-2.5.74/net/sunrpc/clnt.c linux-2.5.74-13-resends/net/sunrpc/clnt.c
--- linux-2.5.74/net/sunrpc/clnt.c	2003-06-12 04:22:40.000000000 +0200
+++ linux-2.5.74-13-resends/net/sunrpc/clnt.c	2003-07-10 21:43:21.000000000 +0200
@@ -658,7 +658,7 @@
 	if (task->tk_status < 0)
 		return;
 	task->tk_status = xprt_prepare_transmit(task);
-	if (task->tk_status < 0)
+	if (task->tk_status != 0)
 		return;
 	/* Encode here so that rpcsec_gss can use correct sequence number. */
 	if (!task->tk_rqstp->rq_bytes_sent)
@@ -684,7 +684,7 @@
 	struct rpc_rqst	*req = task->tk_rqstp;
 	int		status;
 
-	if (req->rq_received != 0)
+	if (req->rq_received != 0 && !req->rq_bytes_sent)
 		task->tk_status = req->rq_received;
 
 	dprintk("RPC: %4d call_status (status %d)\n", 
@@ -743,7 +743,7 @@
 
 	dprintk("RPC: %4d call_timeout (major)\n", task->tk_pid);
 	if (clnt->cl_softrtry) {
-		if (clnt->cl_chatty && !task->tk_exit)
+		if (clnt->cl_chatty)
 			printk(KERN_NOTICE "%s: server %s not responding, timed out\n",
 				clnt->cl_protname, clnt->cl_server);
 		rpc_exit(task, -EIO);
@@ -786,8 +786,9 @@
 
 	if (task->tk_status < 12) {
 		if (!clnt->cl_softrtry) {
-			task->tk_action = call_transmit;
+			task->tk_action = call_bind;
 			clnt->cl_stats->rpcretrans++;
+			req->rq_received = 0;
 		} else {
 			printk(KERN_WARNING "%s: too small RPC reply size (%d bytes)\n",
 				clnt->cl_protname, task->tk_status);
@@ -797,8 +798,10 @@
 	}
 
 	/* Verify the RPC header */
-	if (!(p = call_verify(task)))
+	if (!(p = call_verify(task))) {
+		req->rq_received = 0;
 		return;
+	}
 
 	/*
 	 * The following is an NFS-specific hack to cater for setuid
diff -u --recursive --new-file linux-2.5.74/net/sunrpc/xprt.c linux-2.5.74-13-resends/net/sunrpc/xprt.c
--- linux-2.5.74/net/sunrpc/xprt.c	2003-06-10 06:26:58.000000000 +0200
+++ linux-2.5.74-13-resends/net/sunrpc/xprt.c	2003-07-10 22:53:36.000000000 +0200
@@ -140,15 +140,21 @@
 static int
 __xprt_lock_write(struct rpc_xprt *xprt, struct rpc_task *task)
 {
+	struct rpc_rqst *req = task->tk_rqstp;
 	if (!xprt->snd_task) {
-		if (xprt->nocong || __xprt_get_cong(xprt, task))
+		if (xprt->nocong || __xprt_get_cong(xprt, task)) {
 			xprt->snd_task = task;
+			if (req) {
+				req->rq_bytes_sent = 0;
+				req->rq_ntrans++;
+			}
+		}
 	}
 	if (xprt->snd_task != task) {
 		dprintk("RPC: %4d TCP write queue full\n", task->tk_pid);
 		task->tk_timeout = 0;
 		task->tk_status = -EAGAIN;
-		if (task->tk_rqstp && task->tk_rqstp->rq_nresend)
+		if (req && req->rq_ntrans)
 			rpc_sleep_on(&xprt->resend, task, NULL, NULL);
 		else
 			rpc_sleep_on(&xprt->sending, task, NULL, NULL);
@@ -183,8 +189,14 @@
 		if (!task)
 			return;
 	}
-	if (xprt->nocong || __xprt_get_cong(xprt, task))
+	if (xprt->nocong || __xprt_get_cong(xprt, task)) {
+		struct rpc_rqst *req = task->tk_rqstp;
 		xprt->snd_task = task;
+		if (req) {
+			req->rq_bytes_sent = 0;
+			req->rq_ntrans++;
+		}
+	}
 }
 
 /*
@@ -424,6 +436,9 @@
 	if (xprt_connected(xprt))
 		goto out_write;
 
+	if (task->tk_rqstp)
+		task->tk_rqstp->rq_bytes_sent = 0;
+
 	/*
 	 * We're here because the xprt was marked disconnected.
 	 * Start by resetting any existing state.
@@ -567,7 +582,7 @@
 	if (!xprt->nocong) {
 		xprt_adjust_cwnd(xprt, copied);
 		__xprt_put_cong(xprt, req);
-	       	if (!req->rq_nresend) {
+	       	if (req->rq_ntrans == 1) {
 			unsigned timer =
 				task->tk_msg.rpc_proc->p_timer;
 			if (timer)
@@ -1075,8 +1090,8 @@
 		}
 		rpc_inc_timeo(&task->tk_client->cl_rtt);
 		xprt_adjust_cwnd(req->rq_xprt, -ETIMEDOUT);
+		__xprt_put_cong(xprt, req);
 	}
-	req->rq_nresend++;
 
 	dprintk("RPC: %4d xprt_timer (%s request)\n",
 		task->tk_pid, req ? "pending" : "backlogged");
@@ -1109,6 +1124,11 @@
 		rpc_remove_wait_queue(task);
 
 	spin_lock_bh(&xprt->sock_lock);
+	if (req->rq_received) {
+		err = req->rq_received;
+		goto out_unlock;
+	}
+
 	if (!__xprt_lock_write(xprt, task)) {
 		err = -EAGAIN;
 		goto out_unlock;
@@ -1119,10 +1139,8 @@
 		goto out_unlock;
 	}
 
-	if (list_empty(&req->rq_list)) {
+	if (list_empty(&req->rq_list))
 		list_add_tail(&req->rq_list, &xprt->recv);
-		req->rq_received = 0;
-	}
 out_unlock:
 	spin_unlock_bh(&xprt->sock_lock);
 	return err;
@@ -1136,7 +1154,6 @@
 	struct rpc_xprt	*xprt = req->rq_xprt;
 	int status, retry = 0;
 
-
 	dprintk("RPC: %4d xprt_transmit(%u)\n", task->tk_pid, req->rq_slen);
 
 	/* set up everything as needed. */
@@ -1161,8 +1178,10 @@
 		if (xprt->stream) {
 			req->rq_bytes_sent += status;
 
-			if (req->rq_bytes_sent >= req->rq_slen)
+			if (req->rq_bytes_sent >= req->rq_slen) {
+				req->rq_bytes_sent = 0;
 				goto out_receive;
+			}
 		} else {
 			if (status >= req->rq_slen)
 				goto out_receive;
@@ -1183,9 +1202,6 @@
 	 *	 hence there is no danger of the waking up task being put on
 	 *	 schedq, and being picked up by a parallel run of rpciod().
 	 */
-	if (req->rq_received)
-		goto out_release;
-
 	task->tk_status = status;
 
 	switch (status) {
@@ -1215,13 +1231,12 @@
 		if (xprt->stream)
 			xprt_disconnect(xprt);
 	}
- out_release:
 	xprt_release_write(xprt, task);
-	req->rq_bytes_sent = 0;
 	return;
  out_receive:
 	dprintk("RPC: %4d xmit complete\n", task->tk_pid);
 	/* Set the task's receive timeout value */
+	spin_lock_bh(&xprt->sock_lock);
 	if (!xprt->nocong) {
 		task->tk_timeout = rpc_calc_rto(&clnt->cl_rtt,
 				task->tk_msg.rpc_proc->p_timer);
@@ -1230,7 +1245,6 @@
 			task->tk_timeout = req->rq_timeout.to_maxval;
 	} else
 		task->tk_timeout = req->rq_timeout.to_current;
-	spin_lock_bh(&xprt->sock_lock);
 	/* Don't race with disconnect */
 	if (!xprt_connected(xprt))
 		task->tk_status = -ENOTCONN;
@@ -1238,7 +1252,6 @@
 		rpc_sleep_on(&xprt->pending, task, NULL, xprt_timer);
 	__xprt_release_write(xprt, task);
 	spin_unlock_bh(&xprt->sock_lock);
-	req->rq_bytes_sent = 0;
 }
 
 /*

--0YcCfUSPHm
Content-Type: text/plain
Content-Description: patch 2/2
Content-Disposition: inline;
	filename="linux-2.5.74-15-mem.dif"
Content-Transfer-Encoding: 7bit

diff -u --recursive --new-file linux-2.5.74-14-soft/include/linux/sunrpc/clnt.h linux-2.5.74-15-mem/include/linux/sunrpc/clnt.h
--- linux-2.5.74-14-soft/include/linux/sunrpc/clnt.h	2003-02-13 13:57:46.000000000 +0100
+++ linux-2.5.74-15-mem/include/linux/sunrpc/clnt.h	2003-07-11 00:48:39.000000000 +0200
@@ -35,6 +35,7 @@
  */
 struct rpc_clnt {
 	atomic_t		cl_users;	/* number of references */
+	atomic_t		cl_active;	/* number of active calls */
 	struct rpc_xprt *	cl_xprt;	/* transport */
 	struct rpc_procinfo *	cl_procinfo;	/* procedure info */
 	u32			cl_maxproc;	/* max procedure number */
@@ -57,6 +58,7 @@
 
 	struct rpc_portmap	cl_pmap;	/* port mapping */
 	struct rpc_wait_queue	cl_bindwait;	/* waiting on getport() */
+	wait_queue_head_t	cl_waitq;	/* wait queue */
 
 	int			cl_nodelen;	/* nodename length */
 	char 			cl_nodename[UNX_MAXNODENAME];
@@ -124,6 +126,15 @@
 void		rpc_clnt_sigmask(struct rpc_clnt *clnt, sigset_t *oldset);
 void		rpc_clnt_sigunmask(struct rpc_clnt *clnt, sigset_t *oldset);
 void		rpc_setbufsize(struct rpc_clnt *, unsigned int, unsigned int);
+int		rpc_congestion_wait(struct rpc_clnt *);
+
+static inline void rpc_mark_active(struct rpc_task *task)
+{
+	struct rpc_clnt *clnt = task->tk_client;
+	task->tk_active = 1;
+	if (clnt)
+		atomic_inc(&clnt->cl_active);
+}
 
 static __inline__
 int rpc_call(struct rpc_clnt *clnt, u32 proc, void *argp, void *resp, int flags)
diff -u --recursive --new-file linux-2.5.74-14-soft/net/sunrpc/clnt.c linux-2.5.74-15-mem/net/sunrpc/clnt.c
--- linux-2.5.74-14-soft/net/sunrpc/clnt.c	2003-07-10 21:46:14.000000000 +0200
+++ linux-2.5.74-15-mem/net/sunrpc/clnt.c	2003-07-11 00:49:31.000000000 +0200
@@ -127,6 +127,7 @@
 	clnt->cl_prot     = xprt->prot;
 	clnt->cl_stats    = program->stats;
 	INIT_RPC_WAITQ(&clnt->cl_bindwait, "bindwait");
+	init_waitqueue_head(&clnt->cl_waitq);
 
 	if (!clnt->cl_port)
 		clnt->cl_autobind = 1;
@@ -389,6 +390,37 @@
 }
 
 /*
+ * Throttle the number of active RPC requests
+ */
+int
+rpc_congestion_wait(struct rpc_clnt *clnt)
+{
+	int ret = 0;
+	DECLARE_WAITQUEUE(wait, current);
+
+	if (atomic_read(&clnt->cl_active) < RPC_MAXCONG)
+		goto out;
+	add_wait_queue(&clnt->cl_waitq, &wait);
+	for (;;) {
+		if (clnt->cl_intr)
+			set_current_state(TASK_INTERRUPTIBLE);
+		else
+			set_current_state(TASK_UNINTERRUPTIBLE);
+		if (atomic_read(&clnt->cl_active) < RPC_MAXCONG)
+			break;
+		if (clnt->cl_intr && signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+		io_schedule();
+	}
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&clnt->cl_waitq, &wait);
+out:
+	return ret;
+}
+
+/*
  * Restart an (async) RPC call. Usually called from within the
  * exit handler.
  */
diff -u --recursive --new-file linux-2.5.74-14-soft/net/sunrpc/sched.c linux-2.5.74-15-mem/net/sunrpc/sched.c
--- linux-2.5.74-14-soft/net/sunrpc/sched.c	2003-06-20 22:16:26.000000000 +0200
+++ linux-2.5.74-15-mem/net/sunrpc/sched.c	2003-07-11 00:47:23.000000000 +0200
@@ -257,13 +257,11 @@
 				return;
 			}
 			rpc_clear_sleeping(task);
-			if (waitqueue_active(&rpciod_idle))
-				wake_up(&rpciod_idle);
+			wake_up(&rpciod_idle);
 		}
 	} else {
 		rpc_clear_sleeping(task);
-		if (waitqueue_active(&task->tk_wait))
-			wake_up(&task->tk_wait);
+		wake_up(&task->tk_wait);
 	}
 }
 
@@ -276,7 +274,7 @@
 	/* Don't run a child twice! */
 	if (RPC_IS_ACTIVATED(task))
 		return;
-	task->tk_active = 1;
+	rpc_mark_active(task);
 	rpc_set_sleeping(task);
 	rpc_make_runnable(task);
 }
@@ -289,8 +287,7 @@
 {
 	if(rpciod_pid==0)
 		printk(KERN_ERR "rpciod: wot no daemon?\n");
-	if (waitqueue_active(&rpciod_idle))
-		wake_up(&rpciod_idle);
+	wake_up(&rpciod_idle);
 }
 
 /*
@@ -315,7 +312,7 @@
 
 	/* Mark the task as being activated if so needed */
 	if (!RPC_IS_ACTIVATED(task)) {
-		task->tk_active = 1;
+		rpc_mark_active(task);
 		rpc_set_sleeping(task);
 	}
 
@@ -488,7 +485,8 @@
 static int
 __rpc_execute(struct rpc_task *task)
 {
-	int		status = 0;
+	int interruptible = task->tk_client->cl_intr;
+	int status = 0;
 
 	dprintk("RPC: %4d rpc_execute flgs %x\n",
 				task->tk_pid, task->tk_flags);
@@ -547,14 +545,24 @@
 		}
 		spin_unlock_bh(&rpc_queue_lock);
 
-		while (RPC_IS_SLEEPING(task)) {
+		if (RPC_IS_SLEEPING(task)) {
+			DEFINE_WAIT(wait);
+
 			/* sync task: sleep here */
 			dprintk("RPC: %4d sync task going to sleep\n",
 							task->tk_pid);
 			if (current->pid == rpciod_pid)
 				printk(KERN_ERR "RPC: rpciod waiting on sync task!\n");
 
-			__wait_event(task->tk_wait, !RPC_IS_SLEEPING(task));
+			prepare_to_wait(&task->tk_wait, &wait,
+					interruptible ? TASK_INTERRUPTIBLE :
+							TASK_UNINTERRUPTIBLE);
+			if (likely(RPC_IS_SLEEPING(task))) {
+				if (likely(!(signalled() && interruptible)))
+					io_schedule();
+			}
+			finish_wait(&task->tk_wait, &wait);
+
 			dprintk("RPC: %4d sync task resuming\n", task->tk_pid);
 
 			/*
@@ -563,7 +571,7 @@
 			 * clean up after sleeping on some queue, we don't
 			 * break the loop here, but go around once more.
 			 */
-			if (task->tk_client->cl_intr && signalled()) {
+			if (unlikely(signalled() && interruptible)) {
 				dprintk("RPC: %4d got signal\n", task->tk_pid);
 				task->tk_flags |= RPC_TASK_KILLED;
 				rpc_exit(task, -ERESTARTSYS);
@@ -620,7 +628,12 @@
 		goto out_err;
 	}
 
-	task->tk_active = 1;
+	if (task->tk_client) {
+		status = rpc_congestion_wait(task->tk_client);
+		if (status < 0)
+			goto out_release;
+	}
+	rpc_mark_active(task);
 	rpc_set_running(task);
 	return __rpc_execute(task);
  out_release:
@@ -818,8 +831,6 @@
 	/* Remove from any wait queue we're still on */
 	__rpc_remove_wait_queue(task);
 
-	task->tk_active = 0;
-
 	spin_unlock_bh(&rpc_queue_lock);
 
 	/* Synchronously delete any running timer */
@@ -832,6 +843,10 @@
 		rpcauth_unbindcred(task);
 	rpc_free(task);
 	if (task->tk_client) {
+		if (task->tk_active) {
+			atomic_dec(&task->tk_client->cl_active);
+			wake_up(&task->tk_client->cl_waitq);
+		}
 		rpc_release_client(task->tk_client);
 		task->tk_client = NULL;
 	}
@@ -979,8 +994,20 @@
 		}
 
 		if (!rpciod_task_pending()) {
+			DEFINE_WAIT(wait);
+
 			dprintk("RPC: rpciod back to sleep\n");
-			wait_event_interruptible(rpciod_idle, rpciod_task_pending());
+
+			prepare_to_wait(&rpciod_idle, &wait, TASK_INTERRUPTIBLE);
+			spin_lock_bh(&rpc_queue_lock);
+			if (likely(!rpciod_task_pending())) {
+				spin_unlock_bh(&rpc_queue_lock);
+				if (likely(!signalled()))
+					schedule();
+			} else
+				spin_unlock_bh(&rpc_queue_lock);
+			finish_wait(&rpciod_idle, &wait);
+
 			dprintk("RPC: switch to rpciod\n");
 			rounds = 0;
 		}

--0YcCfUSPHm--
