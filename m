Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271966AbTG2R6f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271839AbTG2R4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:56:42 -0400
Received: from pat.uio.no ([129.240.130.16]:41463 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S271939AbTG2RyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:54:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16166.46256.737464.27553@charged.uio.no>
Date: Tue, 29 Jul 2003 19:53:52 +0200
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS weirdness in 2.6.0-test1
In-Reply-To: <20030726015007.GA18944@linux-sh.org>
References: <20030725151127.GA2947@linux-sh.org>
	<16161.25923.623651.618044@charged.uio.no>
	<20030726015007.GA18944@linux-sh.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Paul Mundt <lethal@linux-sh.org> writes:

     > I'm still left with corrupted data every time I get:

     > NFS: server cheating in read reply: count 1526 > recvd 1000
     > NFS: server cheating in read reply: count 4096 > recvd 1000
     > NFS: server cheating in read reply: count 1583 > recvd 1000

     > Any other suggestions?

Does the following patch fix it?

Note: I'm not entirely sure about whether or not we need those 2
smp_rmb(), but since the value of req->rq_received may be changed from
inside a softirq while we're working, I'm assuming that it is.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.6.0-test2/include/linux/sunrpc/xprt.h linux-2.6.0-01-fix_rcv/include/linux/sunrpc/xprt.h
--- linux-2.6.0-test2/include/linux/sunrpc/xprt.h	2003-05-07 13:03:10.000000000 +0200
+++ linux-2.6.0-01-fix_rcv/include/linux/sunrpc/xprt.h	2003-07-29 15:36:57.000000000 +0200
@@ -98,6 +98,10 @@
 
 	struct list_head	rq_list;
 
+	struct xdr_buf		rq_private_buf;		/* The receive buffer
+							 * used in the softirq.
+							 */
+
 	/*
 	 * For authentication (e.g. auth_des)
 	 */
diff -u --recursive --new-file linux-2.6.0-test2/net/sunrpc/clnt.c linux-2.6.0-01-fix_rcv/net/sunrpc/clnt.c
--- linux-2.6.0-test2/net/sunrpc/clnt.c	2003-07-16 02:02:31.000000000 +0200
+++ linux-2.6.0-01-fix_rcv/net/sunrpc/clnt.c	2003-07-29 19:47:55.380468376 +0200
@@ -659,7 +659,7 @@
 	if (task->tk_status < 0)
 		return;
 	task->tk_status = xprt_prepare_transmit(task);
-	if (task->tk_status < 0)
+	if (task->tk_status != 0)
 		return;
 	/* Encode here so that rpcsec_gss can use correct sequence number. */
 	if (!task->tk_rqstp->rq_bytes_sent)
@@ -685,7 +685,8 @@
 	struct rpc_rqst	*req = task->tk_rqstp;
 	int		status;
 
-	if (req->rq_received != 0)
+	smp_rmb();
+	if (req->rq_received > 0 && !req->rq_bytes_sent)
 		task->tk_status = req->rq_received;
 
 	dprintk("RPC: %4d call_status (status %d)\n", 
@@ -789,17 +790,21 @@
 		if (!clnt->cl_softrtry) {
 			task->tk_action = call_transmit;
 			clnt->cl_stats->rpcretrans++;
-		} else {
-			printk(KERN_WARNING "%s: too small RPC reply size (%d bytes)\n",
-				clnt->cl_protname, task->tk_status);
-			rpc_exit(task, -EIO);
+			goto out_retry;
 		}
+		printk(KERN_WARNING "%s: too small RPC reply size (%d bytes)\n",
+			clnt->cl_protname, task->tk_status);
+		rpc_exit(task, -EIO);
 		return;
 	}
 
+	/* Check that the softirq receive buffer is valid */
+	WARN_ON(memcmp(&req->rq_rcv_buf, &req->rq_private_buf,
+				sizeof(req->rq_rcv_buf)) != 0);
+
 	/* Verify the RPC header */
 	if (!(p = call_verify(task)))
-		return;
+		goto out_retry;
 
 	/*
 	 * The following is an NFS-specific hack to cater for setuid
@@ -812,7 +817,7 @@
 			task->tk_flags ^= RPC_CALL_REALUID;
 			task->tk_action = call_bind;
 			task->tk_suid_retry--;
-			return;
+			goto out_retry;
 		}
 	}
 
@@ -822,6 +827,10 @@
 		task->tk_status = decode(req, p, task->tk_msg.rpc_resp);
 	dprintk("RPC: %4d call_decode result %d\n", task->tk_pid,
 					task->tk_status);
+	return;
+out_retry:
+	req->rq_received = 0;
+	task->tk_status = 0;
 }
 
 /*
diff -u --recursive --new-file linux-2.6.0-test2/net/sunrpc/xprt.c linux-2.6.0-01-fix_rcv/net/sunrpc/xprt.c
--- linux-2.6.0-test2/net/sunrpc/xprt.c	2003-07-16 02:02:37.000000000 +0200
+++ linux-2.6.0-01-fix_rcv/net/sunrpc/xprt.c	2003-07-29 19:48:15.107469416 +0200
@@ -140,15 +140,20 @@
 static int
 __xprt_lock_write(struct rpc_xprt *xprt, struct rpc_task *task)
 {
+	struct rpc_rqst *req = task->tk_rqstp;
+
 	if (!xprt->snd_task) {
-		if (xprt->nocong || __xprt_get_cong(xprt, task))
+		if (xprt->nocong || __xprt_get_cong(xprt, task)) {
 			xprt->snd_task = task;
+			if (req)
+				req->rq_bytes_sent = 0;
+		}
 	}
 	if (xprt->snd_task != task) {
 		dprintk("RPC: %4d TCP write queue full\n", task->tk_pid);
 		task->tk_timeout = 0;
 		task->tk_status = -EAGAIN;
-		if (task->tk_rqstp && task->tk_rqstp->rq_nresend)
+		if (req && req->rq_nresend)
 			rpc_sleep_on(&xprt->resend, task, NULL, NULL);
 		else
 			rpc_sleep_on(&xprt->sending, task, NULL, NULL);
@@ -183,8 +188,12 @@
 		if (!task)
 			return;
 	}
-	if (xprt->nocong || __xprt_get_cong(xprt, task))
+	if (xprt->nocong || __xprt_get_cong(xprt, task)) {
+		struct rpc_rqst *req = task->tk_rqstp;
 		xprt->snd_task = task;
+		if (req)
+			req->rq_bytes_sent = 0;
+	}
 }
 
 /*
@@ -424,6 +433,9 @@
 	if (xprt_connected(xprt))
 		goto out_write;
 
+	if (task->tk_rqstp)
+		task->tk_rqstp->rq_bytes_sent = 0;
+
 	/*
 	 * We're here because the xprt was marked disconnected.
 	 * Start by resetting any existing state.
@@ -716,11 +728,11 @@
 
 	dprintk("RPC: %4d received reply\n", task->tk_pid);
 
-	if ((copied = rovr->rq_rlen) > repsize)
+	if ((copied = rovr->rq_private_buf.len) > repsize)
 		copied = repsize;
 
 	/* Suck it into the iovec, verify checksum if not done by hw. */
-	if (csum_partial_copy_to_xdr(&rovr->rq_rcv_buf, skb))
+	if (csum_partial_copy_to_xdr(&rovr->rq_private_buf, skb))
 		goto out_unlock;
 
 	/* Something worked... */
@@ -843,7 +855,7 @@
 		return;
 	}
 
-	rcvbuf = &req->rq_rcv_buf;
+	rcvbuf = &req->rq_private_buf;
 	len = desc->count;
 	if (len > xprt->tcp_reclen - xprt->tcp_offset) {
 		skb_reader_t my_desc;
@@ -861,7 +873,7 @@
 	xprt->tcp_copied += len;
 	xprt->tcp_offset += len;
 
-	if (xprt->tcp_copied == req->rq_rlen)
+	if (xprt->tcp_copied == req->rq_private_buf.len)
 		xprt->tcp_flags &= ~XPRT_COPY_DATA;
 	else if (xprt->tcp_offset == xprt->tcp_reclen) {
 		if (xprt->tcp_flags & XPRT_LAST_FRAG)
@@ -1106,10 +1118,11 @@
 	if (xprt->shutdown)
 		return -EIO;
 
-	if (task->tk_rpcwait)
-		rpc_remove_wait_queue(task);
-
 	spin_lock_bh(&xprt->sock_lock);
+	if (req->rq_received && !req->rq_bytes_sent) {
+		err = req->rq_received;
+		goto out_unlock;
+	}
 	if (!__xprt_lock_write(xprt, task)) {
 		err = -EAGAIN;
 		goto out_unlock;
@@ -1119,11 +1132,6 @@
 		err = -ENOTCONN;
 		goto out_unlock;
 	}
-
-	if (list_empty(&req->rq_list)) {
-		list_add_tail(&req->rq_list, &xprt->recv);
-		req->rq_received = 0;
-	}
 out_unlock:
 	spin_unlock_bh(&xprt->sock_lock);
 	return err;
@@ -1148,6 +1156,20 @@
 		*marker = htonl(0x80000000|(req->rq_slen-sizeof(*marker)));
 	}
 
+	smp_rmb();
+	if (!req->rq_received) {
+		if (list_empty(&req->rq_list)) {
+			spin_lock_bh(&xprt->sock_lock);
+			/* Update the softirq receive buffer */
+			memcpy(&req->rq_private_buf, &req->rq_rcv_buf,
+					sizeof(req->rq_private_buf));
+			/* Add request to the receive list */
+			list_add_tail(&req->rq_list, &xprt->recv);
+			spin_unlock_bh(&xprt->sock_lock);
+		}
+	} else if (!req->rq_bytes_sent)
+		return;
+
 	/* Continue transmitting the packet/record. We must be careful
 	 * to cope with writespace callbacks arriving _after_ we have
 	 * called xprt_sendmsg().
@@ -1162,8 +1184,12 @@
 		if (xprt->stream) {
 			req->rq_bytes_sent += status;
 
-			if (req->rq_bytes_sent >= req->rq_slen)
+			/* If we've sent the entire packet, immediately
+			 * reset the count of bytes sent. */
+			if (req->rq_bytes_sent >= req->rq_slen) {
+				req->rq_bytes_sent = 0;
 				goto out_receive;
+			}
 		} else {
 			if (status >= req->rq_slen)
 				goto out_receive;
@@ -1184,9 +1210,6 @@
 	 *	 hence there is no danger of the waking up task being put on
 	 *	 schedq, and being picked up by a parallel run of rpciod().
 	 */
-	if (req->rq_received)
-		goto out_release;
-
 	task->tk_status = status;
 
 	switch (status) {
@@ -1216,13 +1239,12 @@
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
@@ -1231,7 +1253,6 @@
 			task->tk_timeout = req->rq_timeout.to_maxval;
 	} else
 		task->tk_timeout = req->rq_timeout.to_current;
-	spin_lock_bh(&xprt->sock_lock);
 	/* Don't race with disconnect */
 	if (!xprt_connected(xprt))
 		task->tk_status = -ENOTCONN;
@@ -1239,7 +1260,6 @@
 		rpc_sleep_on(&xprt->pending, task, NULL, xprt_timer);
 	__xprt_release_write(xprt, task);
 	spin_unlock_bh(&xprt->sock_lock);
-	req->rq_bytes_sent = 0;
 }
 
 /*
