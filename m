Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVAVUkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVAVUkA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAVUgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:36:44 -0500
Received: from news.suse.de ([195.135.220.2]:45008 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262728AbVAVUea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:30 -0500
Message-Id: <20050122203619.063713000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:02 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 2/13] Return -ENOSYS for RPC programs that are unavailable
Content-Disposition: inline; filename=patches.suse/sunrpc-enosys-when-unavail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The issuer of an RPC call should be able to tell the difference
between an I/O error and program unavailable / program version
unavailable / procedure unavailable. Return -ENOSYS for unavailable
RPCs instead of -EIO.

Only issue a program unavailable warning for program numbers other
than the one for nfsacl: Clients with nfsacl support are quite
common already; no need to clutter the syslog.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc2/include/linux/nfs.h
===================================================================
--- linux-2.6.11-rc2.orig/include/linux/nfs.h
+++ linux-2.6.11-rc2/include/linux/nfs.h
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 
 #define NFS_PROGRAM	100003
+#define NFSACL_PROGRAM	100227
 #define NFS_PORT	2049
 #define NFS_MAXDATA	8192
 #define NFS_MAXPATHLEN	1024
Index: linux-2.6.11-rc2/net/sunrpc/clnt.c
===================================================================
--- linux-2.6.11-rc2.orig/net/sunrpc/clnt.c
+++ linux-2.6.11-rc2/net/sunrpc/clnt.c
@@ -988,10 +988,12 @@ call_verify(struct rpc_task *task)
 				break;
 			case RPC_MISMATCH:
 				printk(KERN_WARNING "%s: RPC call version mismatch!\n", __FUNCTION__);
-				goto out_eio;
+				error = -ENOSYS;
+				goto out_err;
 			default:
 				printk(KERN_WARNING "%s: RPC call rejected, unknown error: %x\n", __FUNCTION__, n);
-				goto out_eio;
+				error = -ENOSYS;
+				goto out_err;
 		}
 		if (--len < 0)
 			goto out_overflow;
@@ -1041,23 +1043,28 @@ call_verify(struct rpc_task *task)
 	case RPC_SUCCESS:
 		return p;
 	case RPC_PROG_UNAVAIL:
-		printk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
+		if (task->tk_client->cl_prog != NFSACL_PROGRAM) {
+			printk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
 				(unsigned int)task->tk_client->cl_prog,
 				task->tk_client->cl_server);
-		goto out_eio;
+		}
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
+		error = -ENOSYS;
+		goto out_err;
 	case RPC_GARBAGE_ARGS:
 		dprintk("RPC: %4d %s: server saw garbage\n", task->tk_pid, __FUNCTION__);
 		break;			/* retry */
@@ -1075,7 +1082,6 @@ out_retry:
 		return NULL;
 	}
 	printk(KERN_WARNING "RPC %s: retry failed, exit EIO\n", __FUNCTION__);
-out_eio:
 	error = -EIO;
 out_err:
 	rpc_exit(task, error);

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

