Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSLLKWL>; Thu, 12 Dec 2002 05:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSLLKWL>; Thu, 12 Dec 2002 05:22:11 -0500
Received: from mons.uio.no ([129.240.130.14]:12691 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262201AbSLLKWJ>;
	Thu, 12 Dec 2002 05:22:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15864.25890.940522.749823@charged.uio.no>
Date: Thu, 12 Dec 2002 11:29:54 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 2.4.21-pre] Fix accounting error in /proc/net/rpc/nfs
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch by Chuck Lever fixes a couple of accounting errors
in /proc/net/rpc/nfs.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.20-pre4/net/sunrpc/clnt.c linux-2.5.20-call_start/net/sunrpc/clnt.c
--- linux-2.5.20-pre4/net/sunrpc/clnt.c	Thu Aug 15 03:05:32 2002
+++ linux-2.5.20-call_start/net/sunrpc/clnt.c	Wed Aug 21 18:48:11 2002
@@ -43,6 +43,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(destroy_wait);
 
 
+static void	call_start(struct rpc_task *task);
 static void	call_reserve(struct rpc_task *task);
 static void	call_reserveresult(struct rpc_task *task);
 static void	call_allocate(struct rpc_task *task);
@@ -326,13 +327,9 @@
 		rpcauth_bindcred(task);
 
 	if (task->tk_status == 0)
-		task->tk_action = call_reserve;
+		task->tk_action = call_start;
 	else
 		task->tk_action = NULL;
-
-	/* Increment call count */
-	if (task->tk_msg.rpc_proc < task->tk_client->cl_maxproc)
-		rpcproc_count(task->tk_client, task->tk_msg.rpc_proc)++;
 }
 
 void
@@ -359,26 +356,48 @@
 	if (RPC_ASSASSINATED(task))
 		return;
 
-	task->tk_action = call_reserve;
-	rpcproc_count(task->tk_client, task->tk_msg.rpc_proc)++;
+	task->tk_action = call_start;
 }
 
 /*
- * 1.	Reserve an RPC call slot
+ * 0.  Initial state
+ *
+ *     Other FSM states can be visited zero or more times, but
+ *     this state is visited exactly once for each RPC.
  */
 static void
-call_reserve(struct rpc_task *task)
+call_start(struct rpc_task *task)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 
 	if (task->tk_msg.rpc_proc > clnt->cl_maxproc) {
-		printk(KERN_WARNING "%s (vers %d): bad procedure number %d\n",
-			clnt->cl_protname, clnt->cl_vers, task->tk_msg.rpc_proc);
+		printk(KERN_ERR "%s (vers %d): bad procedure number %d\n",
+				clnt->cl_protname, clnt->cl_vers,
+				task->tk_msg.rpc_proc);
 		rpc_exit(task, -EIO);
 		return;
 	}
 
+	dprintk("RPC: %4d call_start %s%d proc %d (%s)\n", task->tk_pid,
+		clnt->cl_protname, clnt->cl_vers, task->tk_msg.rpc_proc,
+		(RPC_IS_ASYNC(task) ? "async" : "sync"));
+
+	/* Increment call count */
+	rpcproc_count(clnt, task->tk_msg.rpc_proc)++;
+	clnt->cl_stats->rpccnt++;
+	task->tk_action = call_reserve;
+}
+
+/*
+ * 1.	Reserve an RPC call slot
+ */
+static void
+call_reserve(struct rpc_task *task)
+{
+	struct rpc_clnt	*clnt = task->tk_client;
+
 	dprintk("RPC: %4d call_reserve\n", task->tk_pid);
+
 	if (!rpcauth_uptodatecred(task)) {
 		task->tk_action = call_refresh;
 		return;
@@ -387,7 +406,6 @@
 	task->tk_status  = 0;
 	task->tk_action  = call_reserveresult;
 	task->tk_timeout = clnt->cl_timeout.to_resrvval;
-	clnt->cl_stats->rpccnt++;
 	xprt_reserve(task);
 }
 
@@ -645,7 +663,6 @@
 	case -ENOMEM:
 	case -EAGAIN:
 		task->tk_action = call_transmit;
-		clnt->cl_stats->rpcretrans++;
 		break;
 	default:
 		if (clnt->cl_chatty)
