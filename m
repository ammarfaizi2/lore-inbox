Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbSKZTxT>; Tue, 26 Nov 2002 14:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSKZTxS>; Tue, 26 Nov 2002 14:53:18 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:8064 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266755AbSKZTxD>; Tue, 26 Nov 2002 14:53:03 -0500
Date: Tue, 26 Nov 2002 15:00:17 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] check initial RPC timeout values more carefully
Message-ID: <Pine.LNX.4.44.0211261457520.9482-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  this patch provides better checking of initial RPC timeout values, and
  moves protocol-specific setup (part of which is timeout value setup)
  into separate functions.  this will ease the addition of support for new
  networking protocols later.

Apply Against:
  2.5.49

Test status:
  Compiles, links, and boots.


diff -Naur 05-timeout/fs/nfs/inode.c 06-timeout-check/fs/nfs/inode.c
--- 05-timeout/fs/nfs/inode.c	Fri Nov 22 16:40:55 2002
+++ 06-timeout-check/fs/nfs/inode.c	Mon Nov 25 13:28:45 2002
@@ -392,7 +392,6 @@
 	/* Initialize timeout values */
 	timeparms.to_initval = data->timeo * HZ / 10;
 	timeparms.to_retries = data->retrans;
-	timeparms.to_maxval  = tcp? RPC_MAX_TCP_TIMEOUT : RPC_MAX_UDP_TIMEOUT;
 	timeparms.to_exponential = 1;
 
 	if (!timeparms.to_initval)
@@ -1307,12 +1306,10 @@
 	/* Which IP protocol do we use? */
 	switch (proto) {
 	case IPPROTO_TCP:
-		timeparms.to_maxval  = RPC_MAX_TCP_TIMEOUT;
 		if (!timeparms.to_initval)
 			timeparms.to_initval = 600 * HZ / 10;
 		break;
 	case IPPROTO_UDP:
-		timeparms.to_maxval  = RPC_MAX_UDP_TIMEOUT;
 		if (!timeparms.to_initval)
 			timeparms.to_initval = 11 * HZ / 10;
 		break;
diff -Naur 05-timeout/include/linux/sunrpc/xprt.h 06-timeout-check/include/linux/sunrpc/xprt.h
--- 05-timeout/include/linux/sunrpc/xprt.h	Mon Nov 25 13:26:36 2002
+++ 06-timeout-check/include/linux/sunrpc/xprt.h	Mon Nov 25 13:28:45 2002
@@ -40,7 +40,21 @@
 #define RPC_INITCWND		RPC_CWNDSCALE
 #define RPCXPRT_CONGESTED(xprt) ((xprt)->cong >= (xprt)->cwnd)
 
+/*
+ * RTO for stream transports should always be long.  The RPC client
+ * handles a major timeout by first closing and reconnecting the
+ * underlying stream transport socket.
+ */
+#define RPC_MIN_UDP_TIMEOUT    (HZ/10)
+#define RPC_MIN_TCP_TIMEOUT    (6*HZ)
+
 /* Default timeout values */
+#define RPC_DEF_UDP_TIMEOUT    (5*HZ)
+#define RPC_DEF_UDP_RETRIES    (5)
+#define RPC_DEF_TCP_TIMEOUT    (60*HZ)
+#define RPC_DEF_TCP_RETRIES    (2)
+
+/* Maximum timeout values */
 #define RPC_MAX_UDP_TIMEOUT	(60*HZ)
 #define RPC_MAX_TCP_TIMEOUT	(600*HZ)
 
@@ -175,7 +189,6 @@
 					struct rpc_timeout *toparms);
 int			xprt_destroy(struct rpc_xprt *);
 void			xprt_shutdown(struct rpc_xprt *);
-void			xprt_default_timeout(struct rpc_timeout *, int);
 void			xprt_set_timeout(struct rpc_timeout *, unsigned int,
 					unsigned long);
 
diff -Naur 05-timeout/net/sunrpc/xprt.c 06-timeout-check/net/sunrpc/xprt.c
--- 05-timeout/net/sunrpc/xprt.c	Mon Nov 25 13:26:36 2002
+++ 06-timeout-check/net/sunrpc/xprt.c	Mon Nov 25 13:28:45 2002
@@ -355,10 +355,6 @@
 		to->to_current = to->to_initval;
 	}
 
-	if (!to->to_current) {
-		printk(KERN_WARNING "xprt_adjust_timeout: to_current = 0!\n");
-		to->to_current = 5 * HZ;
-	}
 	pprintk("RPC: %lu %s\n", jiffies,
 			to->to_retries? "retrans" : "timeout");
 	return;
@@ -1327,18 +1323,6 @@
 }
 
 /*
- * Set default timeout parameters
- */
-void
-xprt_default_timeout(struct rpc_timeout *to, int proto)
-{
-	if (proto == IPPROTO_UDP)
-		xprt_set_timeout(to, 5,  5 * HZ);
-	else
-		xprt_set_timeout(to, 5, 60 * HZ);
-}
-
-/*
  * Set constant timeout
  */
 void
@@ -1352,6 +1336,56 @@
 	to->to_exponential = 0;
 }
 
+static void
+xprt_udp_setup(struct rpc_xprt *xprt, struct rpc_timeout *to)
+{
+	xprt->prot = IPPROTO_UDP;
+
+	xprt->cwnd = RPC_INITCWND;
+
+	/* Set timeout parameters */
+	if (to) {
+		xprt->timeout = *to;
+
+		to->to_maxval = RPC_MAX_UDP_TIMEOUT;
+
+		if (to->to_initval < RPC_MIN_UDP_TIMEOUT)
+			to->to_initval = RPC_MIN_UDP_TIMEOUT;
+		if (to->to_initval > RPC_MAX_UDP_TIMEOUT)
+			to->to_initval = RPC_MAX_UDP_TIMEOUT;
+
+		xprt->timeout.to_current = to->to_initval;
+	} else
+		xprt_set_timeout(&xprt->timeout,
+				 RPC_DEF_UDP_RETRIES, RPC_DEF_UDP_TIMEOUT);
+}
+
+static void
+xprt_tcp_setup(struct rpc_xprt *xprt, struct rpc_timeout *to)
+{
+	xprt->prot = IPPROTO_TCP;
+
+	xprt->stream = 1;
+	xprt->nocong = 1;
+	xprt->cwnd = RPC_MAXCWND;
+
+	/* Set timeout parameters */
+	if (to) {
+		xprt->timeout = *to;
+
+		to->to_maxval = RPC_MAX_TCP_TIMEOUT;
+
+		if (to->to_initval < RPC_MIN_TCP_TIMEOUT)
+			to->to_initval = RPC_MIN_TCP_TIMEOUT;
+		if (to->to_initval > RPC_MAX_TCP_TIMEOUT)
+			to->to_initval = RPC_MAX_TCP_TIMEOUT;
+
+		xprt->timeout.to_current = to->to_initval;
+	} else
+		xprt_set_timeout(&xprt->timeout,
+				 RPC_DEF_TCP_RETRIES, RPC_DEF_TCP_TIMEOUT);
+}
+
 /*
  * Initialize an RPC client
  */
@@ -1370,26 +1404,26 @@
 	memset(xprt, 0, sizeof(*xprt)); /* Nnnngh! */
 
 	xprt->addr = *ap;
-	xprt->prot = proto;
-	xprt->stream = (proto == IPPROTO_TCP)? 1 : 0;
-	if (xprt->stream) {
-		xprt->cwnd = RPC_MAXCWND;
-		xprt->nocong = 1;
-	} else
-		xprt->cwnd = RPC_INITCWND;
+
+	switch (proto) {
+	case IPPROTO_UDP:
+		xprt_udp_setup(xprt, to);
+		break;
+	case IPPROTO_TCP:
+		xprt_tcp_setup(xprt, to);
+		break;
+	default:
+		printk(KERN_WARNING "RPC: unsupported protocol %d\n", proto);
+		kfree(xprt);
+		return NULL;
+	}
+
 	spin_lock_init(&xprt->sock_lock);
 	spin_lock_init(&xprt->xprt_lock);
 	init_waitqueue_head(&xprt->cong_wait);
 
 	INIT_LIST_HEAD(&xprt->recv);
 
-	/* Set timeout parameters */
-	if (to) {
-		xprt->timeout = *to;
-		xprt->timeout.to_current = to->to_initval;
-	} else
-		xprt_default_timeout(&xprt->timeout, xprt->prot);
-
 	INIT_RPC_WAITQ(&xprt->pending, "xprt_pending");
 	INIT_RPC_WAITQ(&xprt->sending, "xprt_sending");
 	INIT_RPC_WAITQ(&xprt->resend, "xprt_resend");

