Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbSKZTuo>; Tue, 26 Nov 2002 14:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSKZTuo>; Tue, 26 Nov 2002 14:50:44 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:7296 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266746AbSKZTuj>; Tue, 26 Nov 2002 14:50:39 -0500
Date: Tue, 26 Nov 2002 14:57:45 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] new timeout behavior for RPC requests on TCP sockets
Message-ID: <Pine.LNX.4.44.0211261447320.9482-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  make RPC timeout behavior over TCP sockets behave more like reference
  client implementations.  reference behavior is to transmit the same
  request three times at 60 second intervals; if there is no response,
  close and reestablish the socket connection.  note that this patch
  provides a way to support NFSv4 (RFC3010) reliable stream retrans-
  mission behavior as well.

  we modify the Linux RPC client as follows:

+  after a minor RPC retransmit timeout, the RPC client uses the same
   retransmit timeout value when retransmitting the request rather than
   doubling the value, as it would on a UDP socket.

+  after a major RPC retransmit timeout, close the socket.  the RPC
   finite state machine will notice the socket is no longer connected,
   and attempt to reestablish a fresh TCP connection when it retries
   the request again.

  today, mount uses a 6 second timeout with 5 retries for NFS over
  TCP by default; proper default behavior is 2 retries each with 60
  second timeouts.  a separate patch for mount is pending, but in the
  meantime, sysadmins can use "timeo=600,retrans=2" to get standard
  behavior for NFSv2 and NFSv3 over TCP.  for NFSv4, which does not
  use RPC retransmits over reliable network connections (RFC3010), use
  "timeo=600,retrans=0".

Apply Against:
  2.5.49

Test status:
  Pull ethernet cable and watch RPC debug output.  Passes Connectathon
  '02 and other stress tests.  Tested with NFSv2 and NFSv3.

diff -Naur 04-connect3/include/linux/sunrpc/xprt.h 05-timeout/include/linux/sunrpc/xprt.h
--- 04-connect3/include/linux/sunrpc/xprt.h	Mon Nov 25 13:24:29 2002
+++ 05-timeout/include/linux/sunrpc/xprt.h	Mon Nov 25 13:26:36 2002
@@ -182,9 +182,10 @@
 void			xprt_reserve(struct rpc_task *);
 void			xprt_transmit(struct rpc_task *);
 void			xprt_receive(struct rpc_task *);
-int			xprt_adjust_timeout(struct rpc_timeout *);
+void			xprt_adjust_timeout(struct rpc_timeout *);
 void			xprt_release(struct rpc_task *);
 void			xprt_connect(struct rpc_task *);
+void			xprt_disconnect(struct rpc_xprt *);
 int			xprt_clear_backlog(struct rpc_xprt *);
 void			xprt_sock_setbufsize(struct rpc_xprt *);
 
diff -Naur 04-connect3/net/sunrpc/clnt.c 05-timeout/net/sunrpc/clnt.c
--- 04-connect3/net/sunrpc/clnt.c	Mon Nov 25 13:24:29 2002
+++ 05-timeout/net/sunrpc/clnt.c	Mon Nov 25 13:26:36 2002
@@ -656,6 +656,9 @@
 		if (clnt->cl_autobind)
 			clnt->cl_port = 0;
 		task->tk_action = call_bind;
+		/* A disconnect can happen after only part of an RPC was
+		 * sent on a TCP socket.  send all of this request again */
+		req->rq_bytes_sent = 0;
 		break;
 	case -EAGAIN:
 		task->tk_action = call_transmit;
@@ -677,20 +680,34 @@
  * 6a.	Handle RPC timeout
  * 	We do not release the request slot, so we keep using the
  *	same XID for all retransmits.
+ *	For stream transports, shut down the transport socket when
+ *	a request sees a major time out.  When any request on this
+ *	connection is retried, the FSM notices the socket has been
+ *	shut down, and attempts to reconnect.
  */
 static void
 call_timeout(struct rpc_task *task)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
-	struct rpc_timeout *to = &task->tk_rqstp->rq_timeout;
+	struct rpc_xprt *xprt = clnt->cl_xprt;
+	struct rpc_rqst *req = task->tk_rqstp;
+	struct rpc_timeout *to = &req->rq_timeout;
 
-	if (xprt_adjust_timeout(to)) {
-		dprintk("RPC: %4d call_timeout (minor)\n", task->tk_pid);
+	if (!xprt->stream)
+		xprt_adjust_timeout(to);
+
+	if (to->to_retries--) {
+		dprintk("RPC: %4d call_timeout (minor, retries=%d)\n",
+				task->tk_pid, to->to_retries);
 		goto retry;
 	}
-	to->to_retries = clnt->cl_timeout.to_retries;
+	to->to_retries = xprt->timeout.to_retries;
 
 	dprintk("RPC: %4d call_timeout (major)\n", task->tk_pid);
+
+	if (xprt->stream)
+		xprt_disconnect(xprt);
+
 	if (clnt->cl_softrtry) {
 		if (clnt->cl_chatty && !task->tk_exit)
 			printk(KERN_NOTICE "%s: server %s not responding, timed out\n",
@@ -699,15 +716,18 @@
 		return;
 	}
 
-	if (clnt->cl_chatty && !(task->tk_flags & RPC_CALL_MAJORSEEN) && rpc_ntimeo(&clnt->cl_rtt) > 7) {
-		task->tk_flags |= RPC_CALL_MAJORSEEN;
-		printk(KERN_NOTICE "%s: server %s not responding, still trying\n",
-			clnt->cl_protname, clnt->cl_server);
+	if (clnt->cl_chatty && !(task->tk_flags & RPC_CALL_MAJORSEEN)) {
+		if (xprt->stream || (rpc_ntimeo(&clnt->cl_rtt) > 7)) {
+			task->tk_flags |= RPC_CALL_MAJORSEEN;
+			printk(KERN_NOTICE "%s: server %s not responding, still trying\n",
+				clnt->cl_protname, clnt->cl_server);
+		}
 	}
 	if (clnt->cl_autobind)
 		clnt->cl_port = 0;
 
 retry:
+	req->rq_bytes_sent = 0;		/* send all of this request again */
 	clnt->cl_stats->rpcretrans++;
 	task->tk_action = call_bind;
 	task->tk_status = 0;
diff -Naur 04-connect3/net/sunrpc/xprt.c 05-timeout/net/sunrpc/xprt.c
--- 04-connect3/net/sunrpc/xprt.c	Mon Nov 25 13:24:29 2002
+++ 05-timeout/net/sunrpc/xprt.c	Mon Nov 25 13:26:36 2002
@@ -85,7 +85,6 @@
 static void	xprt_request_init(struct rpc_task *, struct rpc_xprt *);
 static void	do_xprt_transmit(struct rpc_task *);
 static inline void	do_xprt_reserve(struct rpc_task *);
-static void	xprt_disconnect(struct rpc_xprt *);
 static void	xprt_conn_status(struct rpc_task *task);
 static struct rpc_xprt * xprt_setup(int proto, struct sockaddr_in *ap,
 						struct rpc_timeout *to);
@@ -336,7 +335,7 @@
 /*
  * Adjust timeout values etc for next retransmit
  */
-int
+void
 xprt_adjust_timeout(struct rpc_timeout *to)
 {
 	if (to->to_retries > 0) {
@@ -362,7 +361,7 @@
 	}
 	pprintk("RPC: %lu %s\n", jiffies,
 			to->to_retries? "retrans" : "timeout");
-	return to->to_retries-- > 0;
+	return;
 }
 
 /*
@@ -394,7 +393,7 @@
 /*
  * Mark a transport as disconnected
  */
-static void
+void
 xprt_disconnect(struct rpc_xprt *xprt)
 {
 	dprintk("RPC:      disconnected transport %p\n", xprt);

