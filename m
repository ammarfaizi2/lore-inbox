Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUDZKcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUDZKcC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUDZKbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:31:08 -0400
Received: from ns.suse.de ([195.135.220.2]:56021 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264443AbUDZK2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:28:51 -0400
Subject: [PATCH 2/11] sunrpc-multiple-programs
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082975173.3295.72.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:28:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support multiple program numbers on one RPC transport

The NFS and NFSACL programs run on the same RPC transport. This patch
adds support for this by changing svc_program into a chained list of
programs instead of a single program (on the server side).

  Andreas Gruenbacher <agruen@suse.de>, SuSE Labs


Index: linux-2.6.6-rc2/fs/nfsd/nfsproc.c
===================================================================
--- linux-2.6.6-rc2.orig/fs/nfsd/nfsproc.c
+++ linux-2.6.6-rc2/fs/nfsd/nfsproc.c
@@ -588,6 +588,8 @@ nfserrno (int errno)
 		{ nfserr_jukebox, -ETIMEDOUT },
 		{ nfserr_dropit, -EAGAIN },
 		{ nfserr_dropit, -ENOMEM },
+		{ nfserr_notsupp, -ENOTSUPP },
+		{ nfserr_notsupp, -EOPNOTSUPP },
 		{ -1, -EIO }
 	};
 	int	i;
Index: linux-2.6.6-rc2/include/linux/sunrpc/svc.h
===================================================================
--- linux-2.6.6-rc2.orig/include/linux/sunrpc/svc.h
+++ linux-2.6.6-rc2/include/linux/sunrpc/svc.h
@@ -232,9 +232,10 @@ struct svc_deferred_req {
 };
 
 /*
- * RPC program
+ * List of RPC programs on the same transport endpoint
  */
 struct svc_program {
+	struct svc_program *	pg_next;	/* other programs (same xprt) */
 	u32			pg_prog;	/* program number */
 	unsigned int		pg_lovers;	/* lowest version */
 	unsigned int		pg_hivers;	/* lowest version */
Index: linux-2.6.6-rc2/net/sunrpc/svc.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/svc.c
+++ linux-2.6.6-rc2/net/sunrpc/svc.c
@@ -326,8 +326,10 @@ svc_process(struct svc_serv *serv, struc
 		goto sendit;
 	}
 		
-	progp = serv->sv_program;
-	if (prog != progp->pg_prog)
+	for (progp = serv->sv_program; progp; progp = progp->pg_next)
+		if (prog == progp->pg_prog)
+			break;
+	if (progp == NULL)
 		goto err_bad_prog;
 
 	if (vers >= progp->pg_nvers ||
@@ -440,7 +442,7 @@ err_bad_auth:
 
 err_bad_prog:
 #ifdef RPC_PARANOIA
-	if (prog != 100227 || progp->pg_prog != 100003)
+	if (prog != 100227 || serv->sv_program->pg_prog != 100003)
 		printk("svc: unknown program %d (me %d)\n", prog, progp->pg_prog);
 	/* else it is just a Solaris client seeing if ACLs are supported */
 #endif

