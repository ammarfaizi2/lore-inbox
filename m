Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUDZKsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUDZKsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUDZK32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:29:28 -0400
Received: from ns.suse.de ([195.135.220.2]:55765 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264307AbUDZK2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:28:50 -0400
Subject: [PATCH 1/11] sunrpc-enosys-when-unavail
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082975161.3295.70.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:28:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Differentiate between program/procedure not available and other errors

  Andreas Gruenbacher <agruen@suse.de>, SUSE Labs

Index: linux-2.6.6-rc2/net/sunrpc/clnt.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/clnt.c
+++ linux-2.6.6-rc2/net/sunrpc/clnt.c
@@ -1018,23 +1018,28 @@ call_verify(struct rpc_task *task)
 	case RPC_SUCCESS:
 		return p;
 	case RPC_PROG_UNAVAIL:
-		printk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
+		if (task->tk_client->cl_prog != 100227) {
+			printk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
 				(unsigned int)task->tk_client->cl_prog,
 				task->tk_client->cl_server);
-		goto out_eio;
+		}
+		rpc_exit(task, -ENOSYS);
+		return NULL;
 	case RPC_PROG_MISMATCH:
 		printk(KERN_WARNING "RPC: call_verify: program %u, version %u unsupported by server %s\n",
 				(unsigned int)task->tk_client->cl_prog,
 				(unsigned int)task->tk_client->cl_vers,
 				task->tk_client->cl_server);
-		goto out_eio;
+		rpc_exit(task, -ENOSYS);
+		return NULL;
 	case RPC_PROC_UNAVAIL:
 		printk(KERN_WARNING "RPC: call_verify: proc %p unsupported by program %u, version %u on server %s\n",
 				task->tk_msg.rpc_proc,
 				task->tk_client->cl_prog,
 				task->tk_client->cl_vers,
 				task->tk_client->cl_server);
-		goto out_eio;
+		rpc_exit(task, -ENOSYS);
+		return NULL;
 	case RPC_GARBAGE_ARGS:
 		break;			/* retry */
 	default:

