Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSKZT4Q>; Tue, 26 Nov 2002 14:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSKZT4Q>; Tue, 26 Nov 2002 14:56:16 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:8576 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266771AbSKZT4K>; Tue, 26 Nov 2002 14:56:10 -0500
Date: Tue, 26 Nov 2002 15:03:24 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] better RPC error counters
Message-ID: <Pine.LNX.4.44.0211261500230.9482-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  add new error counters to the RPC client to help sysadmins identify 
  problems with their NFS clients.  this patch adds counting of:

+  TCP socket connection attempts, reconnects, and connection errors
+  garbage RPC replies
+  partial TCP writes (these indicate socket output buffer shortages)
+  RPC replies with unrecognized XIDs (due to client races or server bugs)
+  RPC replies with bad RPC verifiers (due to request corruption)
+  UDP send errors (due to problems in the network layer)
+  RPC client memory shortages

  the new counters appear in /proc/net/rpc/nfs on the "rpc" line.  the
  extra values in this file do not affect the operation of commands like
  "nfsstat."

Apply Against:
  2.5.49

Test status:
  Compiles, links, boots.  Counters appear in /proc/net/rpc/nfs.


diff -Naur 06-timeout-check/include/linux/sunrpc/stats.h 07-counters/include/linux/sunrpc/stats.h
--- 06-timeout-check/include/linux/sunrpc/stats.h	Fri Nov 22 16:40:42 2002
+++ 07-counters/include/linux/sunrpc/stats.h	Mon Nov 25 13:30:58 2002
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
diff -Naur 06-timeout-check/include/linux/sunrpc/xprt.h 07-counters/include/linux/sunrpc/xprt.h
--- 06-timeout-check/include/linux/sunrpc/xprt.h	Mon Nov 25 13:28:45 2002
+++ 07-counters/include/linux/sunrpc/xprt.h	Mon Nov 25 13:30:58 2002
@@ -153,6 +153,7 @@
 	unsigned long		sockstate;	/* Socket state */
 	unsigned char		shutdown   : 1,	/* being shut down */
 				nocong	   : 1,	/* no congestion control */
+				firstconn  : 1,	/* no connection attempt yet */
 				resvport   : 1, /* use a reserved port */
 				stream     : 1;	/* TCP */
 
diff -Naur 06-timeout-check/net/sunrpc/clnt.c 07-counters/net/sunrpc/clnt.c
--- 06-timeout-check/net/sunrpc/clnt.c	Mon Nov 25 13:26:36 2002
+++ 07-counters/net/sunrpc/clnt.c	Mon Nov 25 13:30:58 2002
@@ -445,6 +445,8 @@
 		xprt_release(task);
 	}
 
+	task->tk_client->cl_stats->rpcnomem++;
+
 	switch (status) {
 	case -EAGAIN:	/* woken up; retry */
 		task->tk_action = call_reserve;
@@ -485,6 +487,7 @@
 	if (RPC_IS_ASYNC(task) || !(task->tk_client->cl_intr && signalled())) {
 		xprt_release(task);
 		task->tk_action = call_reserve;
+		task->tk_client->cl_stats->rpcnomem++;
 		rpc_delay(task, HZ>>4);
 		return;
 	}
@@ -661,6 +664,7 @@
 		req->rq_bytes_sent = 0;
 		break;
 	case -EAGAIN:
+		clnt->cl_stats->rpcnospace++;
 		task->tk_action = call_transmit;
 		break;
 	case -EIO:
@@ -766,14 +770,16 @@
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
diff -Naur 06-timeout-check/net/sunrpc/stats.c 07-counters/net/sunrpc/stats.c
--- 06-timeout-check/net/sunrpc/stats.c	Fri Nov 22 16:41:13 2002
+++ 07-counters/net/sunrpc/stats.c	Mon Nov 25 13:30:58 2002
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
diff -Naur 06-timeout-check/net/sunrpc/xprt.c 07-counters/net/sunrpc/xprt.c
--- 06-timeout-check/net/sunrpc/xprt.c	Mon Nov 25 13:28:45 2002
+++ 07-counters/net/sunrpc/xprt.c	Mon Nov 25 13:30:58 2002
@@ -212,6 +212,7 @@
 static inline int
 xprt_sendmsg(struct rpc_xprt *xprt, struct rpc_rqst *req)
 {
+	struct rpc_stat	*stats = req->rq_task->tk_client->cl_stats;
 	struct socket	*sock = xprt->sock;
 	struct msghdr	msg;
 	struct xdr_buf	*xdr = &req->rq_snd_buf;
@@ -223,6 +224,12 @@
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
@@ -257,16 +264,21 @@
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
@@ -405,6 +417,7 @@
 void
 xprt_connect(struct rpc_task *task)
 {
+	struct rpc_stat *stats = task->tk_client->cl_stats;
 	struct rpc_xprt	*xprt = task->tk_xprt;
 	struct socket	*sock = xprt->sock;
 	struct sock	*inet;
@@ -476,6 +489,11 @@
 		if (inet->state != TCP_ESTABLISHED) {
 			xprt_close(xprt);
 			task->tk_status = -EAGAIN;
+			stats->nettcpconn++;
+			if (!xprt->firstconn) {
+				stats->netreconn++;
+				xprt->firstconn = 0;
+			}
 			break;
 		}
 
@@ -486,11 +504,13 @@
 	case -EPIPE:
 		xprt_close(xprt);
 		task->tk_status = -ENOTCONN;
+		stats->rpccantconn++;
 		break;
 
 	default:
 		/* Report myriad other possible returns, and exit. */
 		xprt_close(xprt);
+		stats->rpccantconn++;
 		printk(KERN_WARNING
 			"RPC: error %d connecting to server %s, exiting\n",
 					-status, task->tk_client->cl_server);
@@ -507,12 +527,18 @@
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
+		if (!xprt->firstconn) {
+			stats->netreconn++;
+			xprt->firstconn = 0;
+		}
 		xprt_release_write(xprt, task);
 		return;
 	case -ETIMEDOUT:
@@ -544,6 +570,8 @@
 	 * requests from retrying the connect */
 	if (task->tk_status != -EAGAIN)
 		xprt_release_write(xprt, task);
+	else
+		stats->rpccantconn++;
 }
 
 /*
@@ -1367,6 +1395,7 @@
 
 	xprt->stream = 1;
 	xprt->nocong = 1;
+	xprt->firstconn = 1;
 	xprt->cwnd = RPC_MAXCWND;
 
 	/* Set timeout parameters */

