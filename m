Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267667AbTAMAFt>; Sun, 12 Jan 2003 19:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267666AbTAMAFa>; Sun, 12 Jan 2003 19:05:30 -0500
Received: from pat.uio.no ([129.240.130.16]:28621 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267663AbTAMAFA>;
	Sun, 12 Jan 2003 19:05:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.1206.722640.400521@charged.uio.no>
Date: Mon, 13 Jan 2003 01:13:42 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [2/6]
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The RPCSEC_GSS user context defines a 'sequence number' in the AUTH header
fields in order to provide protection against replay attacks. This
number needs to lie within a given 'window', and is required to be updated
even when retransmitting dropped requests.

In order to allow this update to occur, move the XDR 'encode' phase
so that it is done immediately before writing the data to the socket.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.56-02-auth2/include/linux/sunrpc/xprt.h linux-2.5.56-03-rpc_encode/include/linux/sunrpc/xprt.h
--- linux-2.5.56-02-auth2/include/linux/sunrpc/xprt.h	2002-11-07 18:29:01.000000000 +0100
+++ linux-2.5.56-03-rpc_encode/include/linux/sunrpc/xprt.h	2003-01-12 22:39:47.000000000 +0100
@@ -187,6 +187,7 @@
 					unsigned long);
 
 void			xprt_reserve(struct rpc_task *);
+int			xprt_prepare_transmit(struct rpc_task *);
 void			xprt_transmit(struct rpc_task *);
 void			xprt_receive(struct rpc_task *);
 int			xprt_adjust_timeout(struct rpc_timeout *);
diff -u --recursive --new-file linux-2.5.56-02-auth2/net/sunrpc/clnt.c linux-2.5.56-03-rpc_encode/net/sunrpc/clnt.c
--- linux-2.5.56-02-auth2/net/sunrpc/clnt.c	2002-11-13 16:06:23.000000000 +0100
+++ linux-2.5.56-03-rpc_encode/net/sunrpc/clnt.c	2003-01-12 22:39:48.000000000 +0100
@@ -470,7 +470,7 @@
 
 	dprintk("RPC: %4d call_allocate (status %d)\n", 
 				task->tk_pid, task->tk_status);
-	task->tk_action = call_encode;
+	task->tk_action = call_bind;
 	if (task->tk_buffer)
 		return;
 
@@ -510,8 +510,6 @@
 	dprintk("RPC: %4d call_encode (status %d)\n", 
 				task->tk_pid, task->tk_status);
 
-	task->tk_action = call_bind;
-
 	/* Default buffer setup */
 	bufsiz = task->tk_bufsize >> 1;
 	sndbuf->head[0].iov_base = (void *)task->tk_buffer;
@@ -533,7 +531,8 @@
 	if (!(p = call_header(task))) {
 		printk(KERN_INFO "RPC: call_header failed, exit EIO\n");
 		rpc_exit(task, -EIO);
-	} else
+		return;
+	}
 	if (encode && (status = encode(req, p, task->tk_msg.rpc_argp)) < 0) {
 		printk(KERN_WARNING "%s: can't encode arguments: %d\n",
 				clnt->cl_protname, -status);
@@ -617,8 +616,17 @@
 	task->tk_action = call_status;
 	if (task->tk_status < 0)
 		return;
+	task->tk_status = xprt_prepare_transmit(task);
+	if (task->tk_status < 0)
+		return;
+	/* Encode here so that rpcsec_gss can use correct sequence number. */
+	call_encode(task);
+	if (task->tk_status < 0)
+		return;
 	xprt_transmit(task);
-	if (!task->tk_msg.rpc_proc->p_decode && task->tk_status >= 0) {
+	if (task->tk_status < 0)
+		return;
+	if (!task->tk_msg.rpc_proc->p_decode) {
 		task->tk_action = NULL;
 		rpc_wake_up_task(task);
 	}
@@ -758,7 +766,7 @@
 		if (RPC_IS_SETUID(task) && task->tk_suid_retry) {
 			dprintk("RPC: %4d retry squashed uid\n", task->tk_pid);
 			task->tk_flags ^= RPC_CALL_REALUID;
-			task->tk_action = call_encode;
+			task->tk_action = call_bind;
 			task->tk_suid_retry--;
 			return;
 		}
@@ -864,7 +872,7 @@
 			task->tk_garb_retry--;
 			dprintk("RPC: %4d call_verify: retry garbled creds\n",
 							task->tk_pid);
-			task->tk_action = call_encode;
+			task->tk_action = call_bind;
 			return NULL;
 		case RPC_AUTH_TOOWEAK:
 			printk(KERN_NOTICE "call_verify: server requires stronger "
@@ -899,7 +907,7 @@
 	if (task->tk_garb_retry) {
 		task->tk_garb_retry--;
 		dprintk(KERN_WARNING "RPC: garbage, retrying %4d\n", task->tk_pid);
-		task->tk_action = call_encode;
+		task->tk_action = call_bind;
 		return NULL;
 	}
 	printk(KERN_WARNING "RPC: garbage, exit EIO\n");
diff -u --recursive --new-file linux-2.5.56-02-auth2/net/sunrpc/xprt.c linux-2.5.56-03-rpc_encode/net/sunrpc/xprt.c
--- linux-2.5.56-02-auth2/net/sunrpc/xprt.c	2002-11-18 02:12:26.000000000 +0100
+++ linux-2.5.56-03-rpc_encode/net/sunrpc/xprt.c	2003-01-12 22:39:48.000000000 +0100
@@ -83,7 +83,6 @@
  * Local functions
  */
 static void	xprt_request_init(struct rpc_task *, struct rpc_xprt *);
-static void	do_xprt_transmit(struct rpc_task *);
 static inline void	do_xprt_reserve(struct rpc_task *);
 static void	xprt_disconnect(struct rpc_xprt *);
 static void	xprt_conn_status(struct rpc_task *task);
@@ -1091,51 +1090,40 @@
  * Place the actual RPC call.
  * We have to copy the iovec because sendmsg fiddles with its contents.
  */
-void
-xprt_transmit(struct rpc_task *task)
+int
+xprt_prepare_transmit(struct rpc_task *task)
 {
 	struct rpc_rqst	*req = task->tk_rqstp;
 	struct rpc_xprt	*xprt = req->rq_xprt;
+	int err = 0;
 
-	dprintk("RPC: %4d xprt_transmit(%x)\n", task->tk_pid, 
-				*(u32 *)(req->rq_svec[0].iov_base));
+	dprintk("RPC: %4d xprt_prepare_transmit\n", task->tk_pid);
 
 	if (xprt->shutdown)
-		task->tk_status = -EIO;
+		return -EIO;
 
 	if (!xprt_connected(xprt))
-		task->tk_status = -ENOTCONN;
-
-	if (task->tk_status < 0)
-		return;
+		return -ENOTCONN;
 
 	if (task->tk_rpcwait)
 		rpc_remove_wait_queue(task);
 
-	/* set up everything as needed. */
-	/* Write the record marker */
-	if (xprt->stream) {
-		u32	*marker = req->rq_svec[0].iov_base;
-
-		*marker = htonl(0x80000000|(req->rq_slen-sizeof(*marker)));
-	}
-
 	spin_lock_bh(&xprt->sock_lock);
 	if (!__xprt_lock_write(xprt, task)) {
-		spin_unlock_bh(&xprt->sock_lock);
-		return;
+		err = -EAGAIN;
+		goto out_unlock;
 	}
 	if (list_empty(&req->rq_list)) {
 		list_add_tail(&req->rq_list, &xprt->recv);
 		req->rq_received = 0;
 	}
+out_unlock:
 	spin_unlock_bh(&xprt->sock_lock);
-
-	do_xprt_transmit(task);
+	return err;
 }
 
-static void
-do_xprt_transmit(struct rpc_task *task)
+void
+xprt_transmit(struct rpc_task *task)
 {
 	struct rpc_clnt *clnt = task->tk_client;
 	struct rpc_rqst	*req = task->tk_rqstp;
@@ -1143,6 +1131,16 @@
 	int status, retry = 0;
 
 
+	dprintk("RPC: %4d xprt_transmit(%u)\n", task->tk_pid, req->rq_slen);
+
+	/* set up everything as needed. */
+	/* Write the record marker */
+	if (xprt->stream) {
+		u32	*marker = req->rq_svec[0].iov_base;
+
+		*marker = htonl(0x80000000|(req->rq_slen-sizeof(*marker)));
+	}
+
 	/* Continue transmitting the packet/record. We must be careful
 	 * to cope with writespace callbacks arriving _after_ we have
 	 * called xprt_sendmsg().
