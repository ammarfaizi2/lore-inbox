Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVAOQ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVAOQ1M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 11:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVAOQ1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 11:27:12 -0500
Received: from zork.zork.net ([64.81.246.102]:54502 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262297AbVAOQ1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 11:27:05 -0500
From: Sean Neakums <sneakums@zork.net>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] sunrpc: clarify the source of some messages
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Date: Sat, 15 Jan 2005 16:26:57 +0000
Message-ID: <6uu0pizmi6.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes cl_protname is "portmap", which can make it seem as if the
userspace portmapper is complaining, when in fact it is sunrpc that is
complaining.  The second hunk also adds a missing printk level.
Against 2.6.11-rc1.


diff -urN --exclude '*~' S11-rc1/net/sunrpc/clnt.c S11-rc1~sunrpc/net/sunrpc/clnt.c
--- S11-rc1/net/sunrpc/clnt.c	2005-01-15 11:45:16.000000000 +0000
+++ S11-rc1~sunrpc/net/sunrpc/clnt.c	2005-01-15 16:15:10.000000000 +0000
@@ -631,7 +631,7 @@
 	}
 	if (encode && (status = rpcauth_wrap_req(task, encode, req, p,
 						 task->tk_msg.rpc_argp)) < 0) {
-		printk(KERN_WARNING "%s: can't encode arguments: %d\n",
+		printk(KERN_WARNING "RPC: %s: can't encode arguments: %d\n",
 				clnt->cl_protname, -status);
 		rpc_exit(task, status);
 	}
@@ -781,7 +781,7 @@
 		break;
 	default:
 		if (clnt->cl_chatty)
-			printk("%s: RPC call returned error %d\n",
+			printk(KERN_NOTICE "RPC: %s: RPC call returned error %d\n",
 			       clnt->cl_protname, -status);
 		rpc_exit(task, status);
 		break;
@@ -806,7 +806,7 @@
 	dprintk("RPC: %4d call_timeout (major)\n", task->tk_pid);
 	if (RPC_IS_SOFT(task)) {
 		if (clnt->cl_chatty)
-			printk(KERN_NOTICE "%s: server %s not responding, timed out\n",
+			printk(KERN_NOTICE "RPC: %s: server %s not responding, timed out\n",
 				clnt->cl_protname, clnt->cl_server);
 		rpc_exit(task, -EIO);
 		return;
@@ -814,7 +814,7 @@
 
 	if (clnt->cl_chatty && !(task->tk_flags & RPC_CALL_MAJORSEEN)) {
 		task->tk_flags |= RPC_CALL_MAJORSEEN;
-		printk(KERN_NOTICE "%s: server %s not responding, still trying\n",
+		printk(KERN_NOTICE "RPC: %s: server %s not responding, still trying\n",
 			clnt->cl_protname, clnt->cl_server);
 	}
 	if (clnt->cl_autobind)
@@ -841,7 +841,7 @@
 				task->tk_pid, task->tk_status);
 
 	if (clnt->cl_chatty && (task->tk_flags & RPC_CALL_MAJORSEEN)) {
-		printk(KERN_NOTICE "%s: server %s OK\n",
+		printk(KERN_NOTICE "RPC: %s: server %s OK\n",
 			clnt->cl_protname, clnt->cl_server);
 		task->tk_flags &= ~RPC_CALL_MAJORSEEN;
 	}
@@ -852,7 +852,7 @@
 			clnt->cl_stats->rpcretrans++;
 			goto out_retry;
 		}
-		printk(KERN_WARNING "%s: too small RPC reply size (%d bytes)\n",
+		printk(KERN_WARNING "RPC: %s: too small RPC reply size (%d bytes)\n",
 			clnt->cl_protname, task->tk_status);
 		rpc_exit(task, -EIO);
 		return;
