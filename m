Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVB0SMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVB0SMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVB0RrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:47:13 -0500
Received: from mail.suse.de ([195.135.220.2]:11427 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261461AbVB0RXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:23:05 -0500
Message-Id: <20050227170311.727719000@blunzn.suse.de>
References: <20050227165954.566746000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 17:59:57 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [nfsacl v2 03/16] Return -ENOSYS for RPC programs that are unavailable
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
@@ -1041,23 +1041,26 @@ call_verify(struct rpc_task *task)
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
 		dprintk("RPC: %4d %s: server saw garbage\n", task->tk_pid, __FUNCTION__);
 		break;			/* retry */

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

