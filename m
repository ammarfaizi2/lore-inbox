Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVBPPcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVBPPcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVBPPcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:32:55 -0500
Received: from news.suse.de ([195.135.220.2]:34784 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262042AbVBPPct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:32:49 -0500
Subject: Re: [patch 2/13] Return -ENOSYS for RPC programs that are
	unavailable
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108487069.10073.32.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.063713000@blunzn.suse.de>
	 <1108487069.10073.32.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-kqYhamRouuLlmKcnOub4"
Organization: SUSE Labs
Message-Id: <1108567950.30082.101.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Feb 2005 16:32:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kqYhamRouuLlmKcnOub4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

First, thanks for your feedback.

On Tue, 2005-02-15 at 18:04, Trond Myklebust wrote:
> No hacks in sunrpc, please: i.e. get rid of that NFSACL_PROGRAM
> exception...
> If you want to kill those warnings, please just convert them to
> dprintks().

Fine with me.

> Also, why are you converting "unknown error" into ENOSYS?

That's a bug.

> Finally, it might make sense to distinguish between "program" and
> "procedure" errors. How about converting that RPC_PROC_UNAVAIL error
> into EOPNOTSUPP (like we already do in the NFS layer itself).

Okay, that shouldn't hurt. Fixes attached.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

--=-kqYhamRouuLlmKcnOub4
Content-Disposition: attachment; filename*0=nfsacl-return-enosys-for-rpc-programs-that-are-unavailable-fi; filename*1=x.patch
Content-Type: text/x-patch; name*0=nfsacl-return-enosys-for-rpc-programs-that-are-unavailable-fix.pa; name*1=tch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.11-rc3/net/sunrpc/clnt.c
===================================================================
--- linux-2.6.11-rc3.orig/net/sunrpc/clnt.c
+++ linux-2.6.11-rc3/net/sunrpc/clnt.c
@@ -988,11 +988,11 @@ call_verify(struct rpc_task *task)
 				break;
 			case RPC_MISMATCH:
 				printk(KERN_WARNING "%s: RPC call version mismatch!\n", __FUNCTION__);
-				error = -ENOSYS;
+				error = -EIO;
 				goto out_err;
 			default:
 				printk(KERN_WARNING "%s: RPC call rejected, unknown error: %x\n", __FUNCTION__, n);
-				error = -ENOSYS;
+				error = -EIO;
 				goto out_err;
 		}
 		if (--len < 0)
@@ -1043,10 +1043,9 @@ call_verify(struct rpc_task *task)
 	case RPC_SUCCESS:
 		return p;
 	case RPC_PROG_UNAVAIL:
-		if (task->tk_client->cl_prog != NFSACL_PROGRAM) {
-			printk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
-				(unsigned int)task->tk_client->cl_prog,
-				task->tk_client->cl_server);
+		dprintk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
+			(unsigned int)task->tk_client->cl_prog,
+			task->tk_client->cl_server);
 		}
 		error = -ENOSYS;
 		goto out_err;
@@ -1063,7 +1062,7 @@ call_verify(struct rpc_task *task)
 				task->tk_client->cl_prog,
 				task->tk_client->cl_vers,
 				task->tk_client->cl_server);
-		error = -ENOSYS;
+		error = -EOPNOTSUPP;
 		goto out_err;
 	case RPC_GARBAGE_ARGS:
 		dprintk("RPC: %4d %s: server saw garbage\n", task->tk_pid, __FUNCTION__);

--=-kqYhamRouuLlmKcnOub4
Content-Disposition: attachment; filename=nfsacl-client-side-of-nfsacl-fix2.patch
Content-Type: text/x-patch; name=nfsacl-client-side-of-nfsacl-fix2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.11-rc3/fs/nfs/nfs3proc.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/nfs3proc.c
+++ linux-2.6.11-rc3/fs/nfs/nfs3proc.c
@@ -760,7 +760,7 @@ nfs3_proc_getacl(struct inode *inode, in
 		__free_page(args.pages[count]);
 
 	if (status) {
-		if (status == -ENOSYS) {
+		if (status == -ENOSYS || status == -EOPNOTSUPP) {
 			dprintk("NFS_ACL extension not supported; disabling\n");
 			server->flags &= ~NFSACL;
 			status = -EOPNOTSUPP;
@@ -845,7 +845,7 @@ nfs3_proc_setacls(struct inode *inode, s
 		__free_page(args.pages[count]);
 
 	if (status) {
-		if (status == -ENOSYS) {
+		if (status == -ENOSYS || status == -EOPNOTSUPP) {
 			dprintk("NFS_ACL SETACL RPC not supported"
 				"(will not retry)\n");
 			server->flags &= ~NFSACL;

--=-kqYhamRouuLlmKcnOub4--

