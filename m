Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSJSUXc>; Sat, 19 Oct 2002 16:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSJSUXc>; Sat, 19 Oct 2002 16:23:32 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:3456 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S265667AbSJSUX3>; Sat, 19 Oct 2002 16:23:29 -0400
Date: Sat, 19 Oct 2002 16:29:24 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] improved RPC statistics
Message-ID: <Pine.LNX.4.44.0210191623230.7700-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add several new RPC statistics counters to help sysadmins more easily
debug client-side NFS performance and reliability problems.  make the RPC 
counters longs instead of ints to take advantage of 64-bit counters on 
platforms that can support them.

it adds some new counter values in /proc/net/rpc/nfs, so it should be
applied before the feature freeze deadline.  please apply this to your 
tree.


diff -drN -U3 00-stock/include/linux/sunrpc/stats.h 01-counters/include/linux/sunrpc/stats.h
--- 00-stock/include/linux/sunrpc/stats.h	Tue Oct 15 23:28:20 2002
+++ 01-counters/include/linux/sunrpc/stats.h	Sat Oct 19 15:48:23 2002
@@ -1,7 +1,7 @@
 /*
  * linux/include/linux/sunrpc/stats.h
  *
- * Client statistics collection for SUN RPC
+ * Statistics collection for SUN RPC
  *
  * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
  */
@@ -11,33 +11,40 @@
 
 #include <linux/config.h>
 #include <linux/proc_fs.h>
+#include <linux/cache.h>
 
 struct rpc_stat {
 	struct rpc_program *	program;
 
-	unsigned int		netcnt,
+	unsigned long		netcnt,
 				netudpcnt,
 				nettcpcnt,
 				nettcpconn,
 				netreconn;
-	unsigned int		rpccnt,
+	unsigned long		rpccnt,
 				rpcretrans,
 				rpcauthrefresh,
-				rpcgarbage;
-};
+				rpcgarbage,
+				rpcnospace,
+				rpcbadxids,
+				rpcbadverfs,
+				rpccantconn,
+				rpcnomem,
+				rpccantsend;
+} ____cacheline_aligned;
 
 struct svc_stat {
 	struct svc_program *	program;
 
-	unsigned int		netcnt,
+	unsigned long		netcnt,
 				netudpcnt,
 				nettcpcnt,
 				nettcpconn;
-	unsigned int		rpccnt,
+	unsigned long		rpccnt,
 				rpcbadfmt,
 				rpcbadauth,
 				rpcbadclnt;
-};
+} ____cacheline_aligned;
 
 void			rpc_proc_init(void);
 void			rpc_proc_exit(void);
diff -drN -U3 00-stock/include/linux/sunrpc/xprt.h 01-counters/include/linux/sunrpc/xprt.h
--- 00-stock/include/linux/sunrpc/xprt.h	Tue Oct 15 23:28:32 2002
+++ 01-counters/include/linux/sunrpc/xprt.h	Sat Oct 19 15:54:19 2002
@@ -146,6 +146,7 @@
 	unsigned long		sockstate;	/* Socket state */
 	unsigned char		shutdown   : 1,	/* being shut down */
 				nocong	   : 1,	/* no congestion control */
+				neverconn  : 1,	/* no connection attempt yet */
 				resvport   : 1, /* use a reserved port */
 				stream     : 1;	/* TCP */
 
diff -drN -U3 00-stock/net/sunrpc/clnt.c 01-counters/net/sunrpc/clnt.c
--- 00-stock/net/sunrpc/clnt.c	Tue Oct 15 23:27:53 2002
+++ 01-counters/net/sunrpc/clnt.c	Sat Oct 19 15:48:23 2002
@@ -453,6 +453,8 @@
 		xprt_release(task);
 	}
 
+	task->tk_client->cl_stats->rpcnomem++;
+
 	switch (status) {
 	case -EAGAIN:	/* woken up; retry */
 		task->tk_action = call_reserve;
@@ -494,6 +496,7 @@
 	if (RPC_IS_ASYNC(task) || !(task->tk_client->cl_intr && signalled())) {
 		xprt_release(task);
 		task->tk_action = call_reserve;
+		task->tk_client->cl_stats->rpcnomem++;
 		rpc_delay(task, HZ>>4);
 		return;
 	}
@@ -669,6 +672,7 @@
 		task->tk_action = call_bind;
 		break;
 	case -EAGAIN:
+		clnt->cl_stats->rpcnospace++;
 		task->tk_action = call_transmit;
 		break;
 	case -EIO:
@@ -757,14 +761,16 @@
 	}
 
 	/* Verify the RPC header */
-	if (!(p = call_verify(task)))
+	if (!(p = call_verify(task))) {
+		clnt->cl_stats->rpcbadverfs++;
 		return;
+	}
 
 	/*
 	 * The following is an NFS-specific hack to cater for setuid
 	 * processes whose uid is mapped to nobody on the server.
 	 */
-	if (task->tk_client->cl_droppriv && 
+	if (clnt->cl_droppriv && 
             (ntohl(*p) == NFSERR_ACCES || ntohl(*p) == NFSERR_PERM)) {
 		if (RPC_IS_SETUID(task) && task->tk_suid_retry) {
 			dprintk("RPC: %4d retry squashed uid\n", task->tk_pid);
diff -drN -U3 00-stock/net/sunrpc/stats.c 01-counters/net/sunrpc/stats.c
--- 00-stock/net/sunrpc/stats.c	Tue Oct 15 23:29:07 2002
+++ 01-counters/net/sunrpc/stats.c	Sat Oct 19 15:48:23 2002
@@ -40,16 +40,23 @@
 	int		len, i, j;
 
 	len = sprintf(buffer,
-		"net %d %d %d %d\n",
+		"net %lu %lu %lu %lu\n",
 			statp->netcnt,
 			statp->netudpcnt,
 			statp->nettcpcnt,
 			statp->nettcpconn);
 	len += sprintf(buffer + len,
-		"rpc %d %d %d\n",
+		"rpc %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
 			statp->rpccnt,
 			statp->rpcretrans,
-			statp->rpcauthrefresh);
+			statp->rpcauthrefresh,
+			statp->rpcgarbage,
+			statp->rpcnospace,
+			statp->rpcbadxids,
+			statp->rpcbadverfs,
+			statp->rpccantconn,
+			statp->rpcnomem,
+			statp->rpccantsend);
 
 	for (i = 0; i < prog->nrvers; i++) {
 		if (!(vers = prog->version[i]))
@@ -88,13 +95,13 @@
 	int		len, i, j;
 
 	len = sprintf(buffer,
-		"net %d %d %d %d\n",
+		"net %lu %lu %lu %lu\n",
 			statp->netcnt,
 			statp->netudpcnt,
 			statp->nettcpcnt,
 			statp->nettcpconn);
 	len += sprintf(buffer + len,
-		"rpc %d %d %d %d %d\n",
+		"rpc %lu %lu %lu %lu %lu\n",
 			statp->rpccnt,
 			statp->rpcbadfmt+statp->rpcbadauth+statp->rpcbadclnt,
 			statp->rpcbadfmt,
diff -drN -U3 00-stock/net/sunrpc/xprt.c 01-counters/net/sunrpc/xprt.c
--- 00-stock/net/sunrpc/xprt.c	Tue Oct 15 23:28:29 2002
+++ 01-counters/net/sunrpc/xprt.c	Sat Oct 19 16:21:26 2002
@@ -213,6 +213,7 @@
 static inline int
 xprt_sendmsg(struct rpc_xprt *xprt, struct rpc_rqst *req)
 {
+	struct rpc_stat	*stats = req->rq_task->tk_client->cl_stats;
 	struct socket	*sock = xprt->sock;
 	struct msghdr	msg;
 	struct xdr_buf	*xdr = &req->rq_snd_buf;
@@ -224,6 +225,12 @@
 	if (!sock)
 		return -ENOTCONN;
 
+	stats->netcnt++;
+	if (xprt->stream)
+		stats->nettcpcnt++;
+	else
+		stats->netudpcnt++;
+
 	xprt_pktdump("packet data:",
 				req->rq_svec->iov_base,
 				req->rq_svec->iov_len);
@@ -258,16 +265,21 @@
 		/* When the server has died, an ICMP port unreachable message
 		 * prompts ECONNREFUSED.
 		 */
+		stats->rpccantsend++;
+		break;
 	case -EAGAIN:
 		break;
 	case -ENOTCONN:
 	case -EPIPE:
 		/* connection broken */
+		stats->rpccantsend++;
 		if (xprt->stream)
 			result = -ENOTCONN;
 		break;
 	default:
+		stats->rpccantsend++;
 		printk(KERN_NOTICE "RPC: sendmsg returned error %d\n", -result);
+		break;
 	}
 	return result;
 }
@@ -416,6 +428,7 @@
 void
 xprt_connect(struct rpc_task *task)
 {
+	struct rpc_stat *stats = task->tk_client->cl_stats;
 	struct rpc_xprt	*xprt = task->tk_xprt;
 	struct socket	*sock = xprt->sock;
 	struct sock	*inet;
@@ -487,6 +500,11 @@
 		if (inet->state != TCP_ESTABLISHED) {
 			xprt_close(xprt);
 			task->tk_status = -EAGAIN;
+			stats->nettcpconn++;
+			if (!xprt->neverconn) {
+				stats->netreconn++;
+				xprt->neverconn = 0;
+			}
 			goto out_write;
 		}
 
@@ -497,12 +515,14 @@
 	case -EPIPE:
 		xprt_close(xprt);
 		task->tk_status = -ENOTCONN;
+		stats->rpccantconn++;
 		goto out_write;
 
 	default:
 		/* Report myriad other possible returns.  If this file
 		 * system is soft mounted, just error out, like Solaris.  */
 		xprt_close(xprt);
+		stats->rpccantconn++;
 		if (task->tk_client->cl_softrtry) {
 			printk(KERN_WARNING
 			"RPC: error %d connecting to server %s, exiting\n",
@@ -528,12 +548,18 @@
 static void
 xprt_conn_status(struct rpc_task *task)
 {
+	struct rpc_stat *stats = task->tk_client->cl_stats;
 	struct rpc_xprt	*xprt = task->tk_xprt;
 
 	switch (task->tk_status) {
 	case 0:
 		dprintk("RPC: %4d xprt_conn_status: connection established\n",
 				task->tk_pid);
+		stats->nettcpconn++;
+		if (!xprt->neverconn) {
+			stats->netreconn++;
+			xprt->neverconn = 0;
+		}
 		goto out;
 	case -ETIMEDOUT:
 		dprintk("RPC: %4d xprt_conn_status: timed out\n",
@@ -548,6 +574,8 @@
 		rpc_delay(task, RPC_REESTABLISH_TIMEOUT);
 		break;
 	}
+	stats->rpccantconn++;
+
 	/* if soft mounted, cause this RPC to fail */
 	if (task->tk_client->cl_softrtry)
 		task->tk_status = -EIO;
@@ -1374,6 +1402,7 @@
 	if (xprt->stream) {
 		xprt->cwnd = RPC_MAXCWND;
 		xprt->nocong = 1;
+		xprt->neverconn = 1;
 	} else
 		xprt->cwnd = RPC_INITCWND;
 	spin_lock_init(&xprt->sock_lock);


