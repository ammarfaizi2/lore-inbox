Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263258AbSJHTQI>; Tue, 8 Oct 2002 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbSJHTPO>; Tue, 8 Oct 2002 15:15:14 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:896 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S261429AbSJHTOf>; Tue, 8 Oct 2002 15:14:35 -0400
Date: Tue, 8 Oct 2002 15:20:07 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] better RPC statistics
Message-ID: <Pine.LNX.4.44.0210081517370.1273-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this is the only patch i have that probably should be in 2.5 before 
October 20.  the rest i will save until things calm down.

this patch, against 2.5.41, adds some new statistics in the RPC layer.  
these are similar to stats kept in reference client implementations, and 
are designed to help sysadmins track down NFS client issues more quickly.
since this changes a "kernel interface" it should go in now.

if there are no objections, please apply this.

diff -drN -U2 00-stock/include/linux/sunrpc/stats.h 01-counters/include/linux/sunrpc/stats.h
--- 00-stock/include/linux/sunrpc/stats.h	Mon Oct  7 14:24:14 2002
+++ 01-counters/include/linux/sunrpc/stats.h	Tue Oct  8 11:04:21 2002
@@ -2,5 +2,5 @@
  * linux/include/linux/sunrpc/stats.h
  *
- * Client statistics collection for SUN RPC
+ * Statistics collection for SUN RPC
  *
  * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
@@ -12,31 +12,38 @@
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
diff -drN -U2 00-stock/net/sunrpc/clnt.c 01-counters/net/sunrpc/clnt.c
--- 00-stock/net/sunrpc/clnt.c	Mon Oct  7 14:24:06 2002
+++ 01-counters/net/sunrpc/clnt.c	Tue Oct  8 11:04:21 2002
@@ -454,4 +454,6 @@
 	}
 
+	task->tk_client->cl_stats->rpcnomem++;
+
 	switch (status) {
 	case -EAGAIN:	/* woken up; retry */
@@ -495,4 +497,5 @@
 		xprt_release(task);
 		task->tk_action = call_reserve;
+		task->tk_client->cl_stats->rpcnomem++;
 		rpc_delay(task, HZ>>4);
 		return;
@@ -670,4 +673,5 @@
 		break;
 	case -EAGAIN:
+		clnt->cl_stats->rpcnospace++;
 		task->tk_action = call_transmit;
 		break;
@@ -720,5 +724,5 @@
 
 retry:
-	clnt->cl_stats->rpcretrans++;
+	clnt->cl_stats->netreconn++;
 	task->tk_action = call_bind;
 	task->tk_status = 0;
@@ -758,6 +762,8 @@
 
 	/* Verify the RPC header */
-	if (!(p = call_verify(task)))
+	if (!(p = call_verify(task))) {
+		clnt->cl_stats->rpcbadverfs++;
 		return;
+	}
 
 	/*
@@ -765,5 +771,5 @@
 	 * processes whose uid is mapped to nobody on the server.
 	 */
-	if (task->tk_client->cl_droppriv && 
+	if (clnt->cl_droppriv && 
             (ntohl(*p) == NFSERR_ACCES || ntohl(*p) == NFSERR_PERM)) {
 		if (RPC_IS_SETUID(task) && task->tk_suid_retry) {
diff -drN -U2 00-stock/net/sunrpc/stats.c 01-counters/net/sunrpc/stats.c
--- 00-stock/net/sunrpc/stats.c	Mon Oct  7 14:25:21 2002
+++ 01-counters/net/sunrpc/stats.c	Tue Oct  8 11:04:21 2002
@@ -41,5 +41,5 @@
 
 	len = sprintf(buffer,
-		"net %d %d %d %d\n",
+		"net %lu %lu %lu %lu\n",
 			statp->netcnt,
 			statp->netudpcnt,
@@ -47,8 +47,15 @@
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
@@ -89,5 +96,5 @@
 
 	len = sprintf(buffer,
-		"net %d %d %d %d\n",
+		"net %lu %lu %lu %lu\n",
 			statp->netcnt,
 			statp->netudpcnt,
@@ -95,5 +102,5 @@
 			statp->nettcpconn);
 	len += sprintf(buffer + len,
-		"rpc %d %d %d %d %d\n",
+		"rpc %lu %lu %lu %lu %lu\n",
 			statp->rpccnt,
 			statp->rpcbadfmt+statp->rpcbadauth+statp->rpcbadclnt,
diff -drN -U2 00-stock/net/sunrpc/xprt.c 01-counters/net/sunrpc/xprt.c
--- 00-stock/net/sunrpc/xprt.c	Mon Oct  7 14:24:45 2002
+++ 01-counters/net/sunrpc/xprt.c	Tue Oct  8 11:04:21 2002
@@ -214,4 +214,5 @@
 xprt_sendmsg(struct rpc_xprt *xprt, struct rpc_rqst *req)
 {
+	struct rpc_stat	*stats = req->rq_task->tk_client->cl_stats;
 	struct socket	*sock = xprt->sock;
 	struct msghdr	msg;
@@ -225,4 +226,10 @@
 		return -ENOTCONN;
 
+	stats->netcnt++;
+	if (xprt->stream)
+		stats->nettcpcnt++;
+	else
+		stats->netudpcnt++;
+
 	xprt_pktdump("packet data:",
 				req->rq_svec->iov_base,
@@ -259,4 +266,7 @@
 		 * prompts ECONNREFUSED.
 		 */
+		if (!xprt->stream)
+			stats->rpccantsend++;
+		break;
 	case -EAGAIN:
 		break;
@@ -266,7 +276,11 @@
 		if (xprt->stream)
 			result = -ENOTCONN;
+		else
+			stats->rpccantsend++;
 		break;
 	default:
 		printk(KERN_NOTICE "RPC: sendmsg returned error %d\n", -result);
+		stats->rpccantsend++;
+		break;
 	}
 	return result;
@@ -417,4 +431,5 @@
 xprt_connect(struct rpc_task *task)
 {
+	struct rpc_stat *stats = task->tk_client->cl_stats;
 	struct rpc_xprt	*xprt = task->tk_xprt;
 	struct socket	*sock = xprt->sock;
@@ -488,4 +503,5 @@
 			xprt_close(xprt);
 			task->tk_status = -EAGAIN;
+			stats->nettcpconn++;
 			goto out_write;
 		}
@@ -498,4 +514,5 @@
 		xprt_close(xprt);
 		task->tk_status = -ENOTCONN;
+		stats->rpccantconn++;
 		goto out_write;
 
@@ -504,4 +521,5 @@
 		 * system is soft mounted, just error out, like Solaris.  */
 		xprt_close(xprt);
+		stats->rpccantconn++;
 		if (task->tk_client->cl_softrtry) {
 			printk(KERN_WARNING
@@ -529,4 +547,5 @@
 xprt_conn_status(struct rpc_task *task)
 {
+	struct rpc_stat *stats = task->tk_client->cl_stats;
 	struct rpc_xprt	*xprt = task->tk_xprt;
 
@@ -535,4 +554,5 @@
 		dprintk("RPC: %4d xprt_conn_status: connection established\n",
 				task->tk_pid);
+		stats->nettcpconn++;
 		goto out;
 	case -ETIMEDOUT:
@@ -549,4 +569,5 @@
 		break;
 	}
+	stats->rpccantconn++;
 	/* if soft mounted, cause this RPC to fail */
 	if (task->tk_client->cl_softrtry)

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

