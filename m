Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264492AbSIQS6v>; Tue, 17 Sep 2002 14:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264488AbSIQS6u>; Tue, 17 Sep 2002 14:58:50 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:640 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S264492AbSIQS6k>; Tue, 17 Sep 2002 14:58:40 -0400
Date: Tue, 17 Sep 2002 15:03:34 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] (1/2) clean up RPC over TCP transport socket connect
Message-ID: <Pine.LNX.4.44.0209171501320.1591-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this patch is a resubmission against 2.5.35 of last week's TCP transport
socket patch against 2.5.34.  it provides clean up and bug fixes for the
RPC layer's TCP socket connection management logic.  Trond, Alexey, and
DaveM have seen this patch.  i've been running it for several weeks here
and feel it is ready for wider testing.  these two patches are
prerequisites for further clean-ups and fixes for RPC over TCP.

bugs fixed:
+  TCP connection establishment now times out after 60 seconds instead of
   hanging for ten minutes.  60 seconds is more in line with how long a
   server takes to reboot.
+  on a soft-mounted file system, TCP reconnections now time out and fail 
   the RPC request, like most other NFS clients, instead of hanging the
   NFS client until the server comes back.
+  on hard-mounted file systems, the RPC layer now delays 15 seconds
   before retrying after a failed connection attempt instead of retrying
   as soon as it can.
+  TCP connection error recovery is now more verbose so users can see why
   their NFS sessions are hung.  this can be tuned with future patches if
   it is unreasonably noisy.
+  the TCP connect logic is cleaned up so adding checks for new errnos 
   is easier.
+  the same code now handles both initial connection and reconnection.
   the original initial connection code did not have comprehensive error
   handling.
+  some obscure design elements are now documented in comments.
+  kfree was used by mistake in xprt_destroy.

diff -drN -U2 01-iip/include/linux/sunrpc/xprt.h 02-connect1/include/linux/sunrpc/xprt.h
--- 01-iip/include/linux/sunrpc/xprt.h	Sun Sep 15 22:18:45 2002
+++ 02-connect1/include/linux/sunrpc/xprt.h	Tue Sep 17 14:04:25 2002
@@ -45,4 +45,17 @@
 #define RPC_MAX_TCP_TIMEOUT	(600*HZ)
 
+/*
+ * Wait duration for an RPC TCP connection to be established.  Solaris
+ * NFS over TCP uses 60 seconds, for example, which is in line with how
+ * long a server takes to reboot.
+ */
+#define RPC_CONNECT_TIMEOUT	(60*HZ)
+
+/*
+ * Delay an arbitrary number of seconds before attempting to reconnect
+ * after an error.
+ */
+#define RPC_REESTABLISH_TIMEOUT	(15*HZ)
+
 /* RPC call and reply header size as number of 32bit words (verifier
  * size computed separately)
diff -drN -U2 01-iip/net/sunrpc/clnt.c 02-connect1/net/sunrpc/clnt.c
--- 01-iip/net/sunrpc/clnt.c	Sun Sep 15 22:18:26 2002
+++ 02-connect1/net/sunrpc/clnt.c	Tue Sep 17 14:04:25 2002
@@ -566,5 +566,5 @@
 	if (!clnt->cl_port) {
 		task->tk_action = call_reconnect;
-		task->tk_timeout = clnt->cl_timeout.to_maxval;
+		task->tk_timeout = RPC_CONNECT_TIMEOUT;
 		rpc_getport(task, clnt);
 	}
@@ -639,5 +639,4 @@
 {
 	struct rpc_clnt	*clnt = task->tk_client;
-	struct rpc_xprt *xprt = clnt->cl_xprt;
 	struct rpc_rqst	*req = task->tk_rqstp;
 	int		status;
@@ -662,23 +661,15 @@
 	case -ECONNREFUSED:
 	case -ENOTCONN:
-		req->rq_bytes_sent = 0;
-		if (clnt->cl_autobind || !clnt->cl_port) {
+		if (clnt->cl_autobind)
 			clnt->cl_port = 0;
-			task->tk_action = call_bind;
-			break;
-		}
-		if (xprt->stream) {
-			task->tk_action = call_reconnect;
-			break;
-		}
-		/*
-		 * Sleep and dream of an open connection
-		 */
-		task->tk_timeout = 5 * HZ;
-		rpc_sleep_on(&xprt->sending, task, NULL, NULL);
-	case -ENOMEM:
+		task->tk_action = call_bind;
+		break;
 	case -EAGAIN:
 		task->tk_action = call_transmit;
 		break;
+	case -EIO:
+		/* shutdown or soft timeout */
+		rpc_exit(task, status);
+		break;
 	default:
 		if (clnt->cl_chatty)
@@ -686,4 +677,5 @@
 			       clnt->cl_protname, -status);
 		rpc_exit(task, status);
+		break;
 	}
 }
diff -drN -U2 01-iip/net/sunrpc/xprt.c 02-connect1/net/sunrpc/xprt.c
--- 01-iip/net/sunrpc/xprt.c	Sun Sep 15 22:18:41 2002
+++ 02-connect1/net/sunrpc/xprt.c	Tue Sep 17 14:04:25 2002
@@ -88,6 +88,8 @@
 static void	xprt_disconnect(struct rpc_xprt *);
 static void	xprt_reconn_status(struct rpc_task *task);
+static struct rpc_xprt * xprt_setup(int proto, struct sockaddr_in *ap,
+						struct rpc_timeout *to);
 static struct socket *xprt_create_socket(int, struct rpc_timeout *);
-static int	xprt_bind_socket(struct rpc_xprt *, struct socket *);
+static void	xprt_bind_socket(struct rpc_xprt *, struct socket *);
 static int      __xprt_get_cong(struct rpc_xprt *, struct rpc_task *);
 
@@ -420,17 +422,15 @@
 	int		status;
 
-	dprintk("RPC: %4d xprt_reconnect %p connected %d\n",
-				task->tk_pid, xprt, xprt_connected(xprt));
-	if (xprt->shutdown)
-		return;
+	dprintk("RPC: %4d xprt_reconnect xprt %p %s connected\n", task->tk_pid,
+			xprt, (xprt_connected(xprt) ? "is" : "is not"));
 
-	if (!xprt->stream)
+	if (xprt->shutdown) {
+		task->tk_status = -EIO;
 		return;
-
+	}
 	if (!xprt->addr.sin_port) {
 		task->tk_status = -EIO;
 		return;
 	}
-
 	if (!xprt_lock_write(xprt, task))
 		return;
@@ -438,58 +438,85 @@
 		goto out_write;
 
-	if (sock && sock->state != SS_UNCONNECTED)
-		xprt_close(xprt);
-	status = -ENOTCONN;
-	if (!(inet = xprt->inet)) {
-		/* Create an unconnected socket */
-		if (!(sock = xprt_create_socket(xprt->prot, &xprt->timeout)))
-			goto defer;
-		xprt_bind_socket(xprt, sock);
-		inet = sock->sk;
+	/*
+	 * We're here because the xprt was marked disconnected.
+	 * Start by resetting any existing state.
+	 */
+	xprt_close(xprt);
+	if (!(sock = xprt_create_socket(xprt->prot, &xprt->timeout))) {
+		/* couldn't create socket or bind to reserved port;
+		 * this is likely a permanent error, so cause an abort */
+		task->tk_status = -EIO;
+		goto out_write;
 	}
+	xprt_bind_socket(xprt, sock);
+	inet = sock->sk;
 
-	/* Now connect it asynchronously. */
-	dprintk("RPC: %4d connecting new socket\n", task->tk_pid);
+	/*
+	 * Tell the socket layer to start connecting...
+	 */
 	status = sock->ops->connect(sock, (struct sockaddr *) &xprt->addr,
 				sizeof(xprt->addr), O_NONBLOCK);
+	dprintk("RPC: %4d  connect status %d connected %d sock state %d\n",
+		task->tk_pid, -status, xprt_connected(xprt), inet->state);
 
-	if (status < 0) {
-		switch (status) {
-		case -EALREADY:
-		case -EINPROGRESS:
-			status = 0;
-			break;
-		case -EISCONN:
-		case -EPIPE:
-			status = 0;
-			xprt_close(xprt);
-			goto defer;
-		default:
-			printk("RPC: TCP connect error %d!\n", -status);
-			xprt_close(xprt);
-			goto defer;
-		}
-
+	switch (status) {
+	case -EINPROGRESS:
+	case -EALREADY:
 		/* Protect against TCP socket state changes */
 		lock_sock(inet);
-		dprintk("RPC: %4d connect status %d connected %d\n",
-				task->tk_pid, status, xprt_connected(xprt));
-
 		if (inet->state != TCP_ESTABLISHED) {
-			task->tk_timeout = xprt->timeout.to_maxval;
-			/* if the socket is already closing, delay 5 secs */
-			if ((1<<inet->state) & ~(TCPF_SYN_SENT|TCPF_SYN_RECV))
-				task->tk_timeout = 5*HZ;
-			rpc_sleep_on(&xprt->pending, task, xprt_reconn_status, NULL);
+			dprintk("RPC: %4d  waiting for connection\n",
+					task->tk_pid);
+			task->tk_timeout = RPC_CONNECT_TIMEOUT;
+			/* if the socket is already closing, delay briefly */
+			if ((1 << inet->state) & ~(TCPF_SYN_SENT|TCPF_SYN_RECV))
+				task->tk_timeout = RPC_REESTABLISH_TIMEOUT;
+			rpc_sleep_on(&xprt->pending, task, xprt_reconn_status,
+									NULL);
 			release_sock(inet);
+			/* task status set when task wakes up again */
 			return;
 		}
 		release_sock(inet);
-	}
-defer:
-	if (status < 0) {
-		rpc_delay(task, 5*HZ);
+		task->tk_status = 0;
+		break;
+
+	case 0:
+	case -EISCONN:	/* not likely, but just in case */
+		/* Half closed state.  No race -- this socket is dead. */
+		if (inet->state != TCP_ESTABLISHED) {
+			xprt_close(xprt);
+			task->tk_status = -EAGAIN;
+			goto out_write;
+		}
+
+		/* Otherwise, the connection is already established. */
+		task->tk_status = 0;
+		break;
+
+	case -EPIPE:
+		xprt_close(xprt);
 		task->tk_status = -ENOTCONN;
+		goto out_write;
+
+	default:
+		/* Report myriad other possible returns.  If this file
+		 * system is soft mounted, just error out, like Solaris.  */
+		xprt_close(xprt);
+		if (task->tk_client->cl_softrtry) {
+			printk(KERN_WARNING
+			"RPC: error %d connecting to server %s, exiting\n",
+					-status, task->tk_client->cl_server);
+			task->tk_status = -EIO;
+		} else {
+			printk(KERN_WARNING
+			"RPC: error %d connecting to server %s\n",
+					-status, task->tk_client->cl_server);
+			rpc_delay(task, RPC_REESTABLISH_TIMEOUT);
+			task->tk_status = status;
+		}
+		break;
 	}
+
  out_write:
 	xprt_release_write(xprt, task);
@@ -505,7 +532,27 @@
 	struct rpc_xprt	*xprt = task->tk_xprt;
 
-	dprintk("RPC: %4d xprt_reconn_timeout %d\n",
-				task->tk_pid, task->tk_status);
+	switch (task->tk_status) {
+	case 0:
+		dprintk("RPC: %4d xprt_reconn_status: connection established\n",
+				task->tk_pid);
+		goto out;
+	case -ETIMEDOUT:
+		dprintk("RPC: %4d xprt_reconn_status: timed out\n",
+				task->tk_pid);
+		/* prevent TCP from continuing to retry SYNs */
+		xprt_close(xprt);
+		break;
+	default:
+		printk(KERN_ERR "RPC: error %d connecting to server %s\n",
+				-task->tk_status, task->tk_client->cl_server);
+		xprt_close(xprt);
+		rpc_delay(task, RPC_REESTABLISH_TIMEOUT);
+		break;
+	}
+	/* if soft mounted, cause this RPC to fail */
+	if (task->tk_client->cl_softrtry)
+		task->tk_status = -EIO;
 
+ out:
 	xprt_release_write(xprt, task);
 }
@@ -1155,6 +1202,10 @@
 	case -ECONNREFUSED:
 	case -ENOTCONN:
-		if (!xprt->stream)
+		if (!xprt->stream) {
+			task->tk_timeout = RPC_REESTABLISH_TIMEOUT;
+			rpc_sleep_on(&xprt->sending, task, NULL, NULL);
 			return;
+		}
+		/* fall through */
 	default:
 		if (xprt->stream)
@@ -1306,6 +1357,5 @@
  */
 static struct rpc_xprt *
-xprt_setup(struct socket *sock, int proto,
-			struct sockaddr_in *ap, struct rpc_timeout *to)
+xprt_setup(int proto, struct sockaddr_in *ap, struct rpc_timeout *to)
 {
 	struct rpc_xprt	*xprt;
@@ -1354,5 +1404,4 @@
 	dprintk("RPC:      created transport %p\n", xprt);
 	
-	xprt_bind_socket(xprt, sock);
 	return xprt;
 }
@@ -1382,5 +1431,5 @@
 }
 
-static int 
+static void
 xprt_bind_socket(struct rpc_xprt *xprt, struct socket *sock)
 {
@@ -1388,5 +1437,5 @@
 
 	if (xprt->inet)
-		return -EBUSY;
+		return;
 
 	sk->user_data = xprt;
@@ -1414,5 +1463,5 @@
 		rpciod_up();
 
-	return 0;
+	return;
 }
 
@@ -1458,6 +1507,8 @@
 
 	/* If the caller has the capability, bind to a reserved port */
-	if (capable(CAP_NET_BIND_SERVICE) && xprt_bindresvport(sock) < 0)
+	if (capable(CAP_NET_BIND_SERVICE) && xprt_bindresvport(sock) < 0) {
+		printk("RPC: can't bind to reserved port.\n");
 		goto failed;
+	}
 
 	return sock;
@@ -1474,15 +1525,30 @@
 xprt_create_proto(int proto, struct sockaddr_in *sap, struct rpc_timeout *to)
 {
-	struct socket	*sock;
 	struct rpc_xprt	*xprt;
 
-	dprintk("RPC:      xprt_create_proto called\n");
-
-	if (!(sock = xprt_create_socket(proto, to)))
-		return NULL;
+	xprt = xprt_setup(proto, sap, to);
+	if (!xprt)
+		goto out;
 
-	if (!(xprt = xprt_setup(sock, proto, sap, to)))
-		sock_release(sock);
+	if (!xprt->stream) {
+		struct socket *sock = xprt_create_socket(proto, to);
+		if (sock)
+			xprt_bind_socket(xprt, sock);
+		else {
+			rpc_free(xprt);
+			xprt = NULL;
+		}
+	} else
+		/*
+		 * Don't allow a TCP service user unless they have
+		 * enough capability to bind a reserved port.
+		 */
+		if (!capable(CAP_NET_BIND_SERVICE)) {
+			rpc_free(xprt);
+			xprt = NULL;
+		}
 
+ out:
+	dprintk("RPC:      xprt_create_proto created xprt %p\n", xprt);
 	return xprt;
 }
@@ -1523,5 +1589,5 @@
 	xprt_shutdown(xprt);
 	xprt_close(xprt);
-	kfree(xprt);
+	rpc_free(xprt);
 
 	return 0;

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>


