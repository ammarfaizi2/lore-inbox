Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVB0P7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVB0P7R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVB0P5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:57:24 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:21204 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261418AbVB0P4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:55 -0500
Message-Id: <20050227152349.852124000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:46 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 03/16] Return -ENOSYS for RPC programs that are unavailable
Content-Disposition: inline; filename=nfsacl-return-enosys-for-rpc-programs-that-are-unavailable.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The issuer of an RPC call should be able to tell the difference between
an I/O error and program unavailable / program version unavailable /
procedure unavailable.  Return -ENOSYS for unavailable RPCs instead of
-EIO.

Only issue a program unavailable warning for program numbers other than
the one for nfsacl: Clients with nfsacl support are quite common
already; no need to clutter the syslog.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc5/net/sunrpc/clnt.c
===================================================================
--- linux-2.6.11-rc5.orig/net/sunrpc/clnt.c
+++ linux-2.6.11-rc5/net/sunrpc/clnt.c
@@ -970,6 +970,7 @@ call_verify(struct rpc_task *task)
 	struct kvec *iov = &task->tk_rqstp->rq_rcv_buf.head[0];
 	int len = task->tk_rqstp->rq_rcv_buf.len >> 2;
 	u32	*p = iov->iov_base, n;
+	int error = -EACCES;
 
 	if ((len -= 3) < 0)
 		goto garbage;
@@ -980,8 +981,6 @@ call_verify(struct rpc_task *task)
 		goto garbage;
 	}
 	if ((n = ntohl(*p++)) != RPC_MSG_ACCEPTED) {
-		int	error = -EACCES;
-
 		if (--len < 0)
 			goto garbage;
 		if ((n = ntohl(*p++)) != RPC_AUTH_ERROR) {
@@ -1035,23 +1034,26 @@ call_verify(struct rpc_task *task)
 	case RPC_SUCCESS:
 		return p;
 	case RPC_PROG_UNAVAIL:
-		printk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
-				(unsigned int)task->tk_client->cl_prog,
-				task->tk_client->cl_server);
-		goto out_eio;
+		dprintk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
+			(unsigned int)task->tk_client->cl_prog,
+			task->tk_client->cl_server);
+		error = -ENOSYS;
+		goto out_err;
 	case RPC_PROG_MISMATCH:
 		printk(KERN_WARNING "RPC: call_verify: program %u, version %u unsupported by server %s\n",
 				(unsigned int)task->tk_client->cl_prog,
 				(unsigned int)task->tk_client->cl_vers,
 				task->tk_client->cl_server);
-		goto out_eio;
+		error = -ENOSYS;
+		goto out_err;
 	case RPC_PROC_UNAVAIL:
 		printk(KERN_WARNING "RPC: call_verify: proc %p unsupported by program %u, version %u on server %s\n",
 				task->tk_msg.rpc_proc,
 				task->tk_client->cl_prog,
 				task->tk_client->cl_vers,
 				task->tk_client->cl_server);
-		goto out_eio;
+		error = -EOPNOTSUPP;
+		goto out_err;
 	case RPC_GARBAGE_ARGS:
 		break;			/* retry */
 	default:
@@ -1069,7 +1071,8 @@ garbage:
 		return NULL;
 	}
 	printk(KERN_WARNING "RPC: garbage, exit EIO\n");
-out_eio:
-	rpc_exit(task, -EIO);
+	error = -EIO;
+out_err:
+	rpc_exit(task, error);
 	return NULL;
 }

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

