Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbSIRQv3>; Wed, 18 Sep 2002 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267911AbSIRQuh>; Wed, 18 Sep 2002 12:50:37 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:1408 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S267605AbSIRQtw>; Wed, 18 Sep 2002 12:49:52 -0400
Date: Wed, 18 Sep 2002 12:54:54 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] (2/2) clean up RPC over TCP transport socket connect
Message-ID: <Pine.LNX.4.44.0209181253550.1495-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this patch is a resubmission against 2.5.36 of the TCP transport socket 
patch i sent last week against 2.5.34.

this patch renames *reconn* to *conn* since the same code now handles both
initial TCP connect, and TCP reconnection, and corrects some comments.
against 2.5.36, requires earlier patch (1/1).


diff -drN -U2 02-connect1/include/linux/sunrpc/xprt.h 03-connect2/include/linux/sunrpc/xprt.h
--- 02-connect1/include/linux/sunrpc/xprt.h	Wed Sep 18 10:02:23 2002
+++ 03-connect2/include/linux/sunrpc/xprt.h	Wed Sep 18 10:03:45 2002
@@ -191,5 +191,5 @@
 int			xprt_adjust_timeout(struct rpc_timeout *);
 void			xprt_release(struct rpc_task *);
-void			xprt_reconnect(struct rpc_task *);
+void			xprt_connect(struct rpc_task *);
 int			xprt_clear_backlog(struct rpc_xprt *);
 void			xprt_sock_setbufsize(struct rpc_xprt *);
diff -drN -U2 02-connect1/net/sunrpc/clnt.c 03-connect2/net/sunrpc/clnt.c
--- 02-connect1/net/sunrpc/clnt.c	Wed Sep 18 10:02:23 2002
+++ 03-connect2/net/sunrpc/clnt.c	Wed Sep 18 10:03:45 2002
@@ -8,5 +8,5 @@
  *  -	RPC header generation and argument serialization.
  *  -	Credential refresh.
- *  -	TCP reconnect handling (when finished).
+ *  -	TCP connect handling.
  *  -	Retry of operation when it is suspected the operation failed because
  *	of uid squashing on the server, or when the credentials were stale
@@ -56,7 +56,7 @@
 static void	call_refreshresult(struct rpc_task *task);
 static void	call_timeout(struct rpc_task *task);
-static void	call_reconnect(struct rpc_task *task);
-static void	child_reconnect(struct rpc_task *);
-static void	child_reconnect_status(struct rpc_task *);
+static void	call_connect(struct rpc_task *task);
+static void	child_connect(struct rpc_task *task);
+static void	child_connect_status(struct rpc_task *task);
 static u32 *	call_header(struct rpc_task *task);
 static u32 *	call_verify(struct rpc_task *task);
@@ -562,8 +562,8 @@
 			xprt, (xprt_connected(xprt) ? "is" : "is not"));
 
-	task->tk_action = (xprt_connected(xprt)) ? call_transmit : call_reconnect;
+	task->tk_action = (xprt_connected(xprt)) ? call_transmit : call_connect;
 
 	if (!clnt->cl_port) {
-		task->tk_action = call_reconnect;
+		task->tk_action = call_connect;
 		task->tk_timeout = RPC_CONNECT_TIMEOUT;
 		rpc_getport(task, clnt);
@@ -572,13 +572,13 @@
 
 /*
- * 4a.	Reconnect to the RPC server (TCP case)
+ * 4a.	Connect to the RPC server (TCP case)
  */
 static void
-call_reconnect(struct rpc_task *task)
+call_connect(struct rpc_task *task)
 {
 	struct rpc_clnt *clnt = task->tk_client;
 	struct rpc_task *child;
 
-	dprintk("RPC: %4d call_reconnect status %d\n",
+	dprintk("RPC: %4d call_connect status %d\n",
 				task->tk_pid, task->tk_status);
 
@@ -587,24 +587,27 @@
 		return;
 
-	/* Run as a child to ensure it runs as an rpciod task */
+	/* Run as a child to ensure it runs as an rpciod task.  Rpciod
+	 * guarantees we have the correct capabilities for socket bind
+	 * to succeed. */
 	child = rpc_new_child(clnt, task);
 	if (child) {
-		child->tk_action = child_reconnect;
+		child->tk_action = child_connect;
 		rpc_run_child(task, child, NULL);
 	}
 }
 
-static void child_reconnect(struct rpc_task *task)
+static void
+child_connect(struct rpc_task *task)
 {
-	task->tk_client->cl_stats->netreconn++;
 	task->tk_status = 0;
-	task->tk_action = child_reconnect_status;
-	xprt_reconnect(task);
+	task->tk_action = child_connect_status;
+	xprt_connect(task);
 }
 
-static void child_reconnect_status(struct rpc_task *task)
+static void
+child_connect_status(struct rpc_task *task)
 {
 	if (task->tk_status == -EAGAIN)
-		task->tk_action = child_reconnect;
+		task->tk_action = child_connect;
 	else
 		task->tk_action = NULL;
diff -drN -U2 02-connect1/net/sunrpc/xprt.c 03-connect2/net/sunrpc/xprt.c
--- 02-connect1/net/sunrpc/xprt.c	Wed Sep 18 10:02:23 2002
+++ 03-connect2/net/sunrpc/xprt.c	Wed Sep 18 10:03:45 2002
@@ -87,5 +87,5 @@
 static inline void	do_xprt_reserve(struct rpc_task *);
 static void	xprt_disconnect(struct rpc_xprt *);
-static void	xprt_reconn_status(struct rpc_task *task);
+static void	xprt_conn_status(struct rpc_task *task);
 static struct rpc_xprt * xprt_setup(int proto, struct sockaddr_in *ap,
 						struct rpc_timeout *to);
@@ -137,5 +137,5 @@
  * Serialize write access to sockets, in order to prevent different
  * requests from interfering with each other.
- * Also prevents TCP socket reconnections from colliding with writes.
+ * Also prevents TCP socket connects from colliding with writes.
  */
 static int
@@ -410,10 +410,10 @@
 
 /*
- * Reconnect a broken TCP connection.
+ * Attempt to connect a TCP socket.
  *
- * Note: This cannot collide with the TCP reads, as both run from rpciod
+ * NB: This never collides with TCP reads, as both run from rpciod
  */
 void
-xprt_reconnect(struct rpc_task *task)
+xprt_connect(struct rpc_task *task)
 {
 	struct rpc_xprt	*xprt = task->tk_xprt;
@@ -422,5 +422,5 @@
 	int		status;
 
-	dprintk("RPC: %4d xprt_reconnect xprt %p %s connected\n", task->tk_pid,
+	dprintk("RPC: %4d xprt_connect xprt %p %s connected\n", task->tk_pid,
 			xprt, (xprt_connected(xprt) ? "is" : "is not"));
 
@@ -472,5 +472,5 @@
 			if ((1 << inet->state) & ~(TCPF_SYN_SENT|TCPF_SYN_RECV))
 				task->tk_timeout = RPC_REESTABLISH_TIMEOUT;
-			rpc_sleep_on(&xprt->pending, task, xprt_reconn_status,
+			rpc_sleep_on(&xprt->pending, task, xprt_conn_status,
 									NULL);
 			release_sock(inet);
@@ -524,9 +524,8 @@
 
 /*
- * Reconnect timeout. We just mark the transport as not being in the
- * process of reconnecting, and leave the rest to the upper layers.
+ * We arrive here when awoken from waiting on connection establishment.
  */
 static void
-xprt_reconn_status(struct rpc_task *task)
+xprt_conn_status(struct rpc_task *task)
 {
 	struct rpc_xprt	*xprt = task->tk_xprt;
@@ -534,9 +533,9 @@
 	switch (task->tk_status) {
 	case 0:
-		dprintk("RPC: %4d xprt_reconn_status: connection established\n",
+		dprintk("RPC: %4d xprt_conn_status: connection established\n",
 				task->tk_pid);
 		goto out;
 	case -ETIMEDOUT:
-		dprintk("RPC: %4d xprt_reconn_status: timed out\n",
+		dprintk("RPC: %4d xprt_conn_status: timed out\n",
 				task->tk_pid);
 		/* prevent TCP from continuing to retry SYNs */
@@ -1488,5 +1487,6 @@
 
 /*
- * Create a client socket given the protocol and peer address.
+ * Datastream sockets are created here, but xprt_connect will create
+ * and connect stream sockets.
  */
 static struct socket *

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>



