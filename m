Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVB0P7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVB0P7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVB0P54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:57:56 -0500
Received: from news.suse.de ([195.135.220.2]:22740 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261420AbVB0P4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:55 -0500
Message-Id: <20050227152350.946934000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:48 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 05/16] Allow multiple programs to listen on the same port
Content-Disposition: inline; filename=nfsacl-allow-multiple-programs-to-listen-on-the-same-port.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NFS and NFSACL programs run on the same RPC transport.  This patch adds
support for this by converting svc_program into a chained list of programs
(server-side).

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc5/include/linux/sunrpc/svc.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/sunrpc/svc.h
+++ linux-2.6.11-rc5/include/linux/sunrpc/svc.h
@@ -240,9 +240,10 @@ struct svc_deferred_req {
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
Index: linux-2.6.11-rc5/net/sunrpc/svc.c
===================================================================
--- linux-2.6.11-rc5.orig/net/sunrpc/svc.c
+++ linux-2.6.11-rc5/net/sunrpc/svc.c
@@ -35,20 +35,24 @@ svc_create(struct svc_program *prog, uns
 	if (!(serv = (struct svc_serv *) kmalloc(sizeof(*serv), GFP_KERNEL)))
 		return NULL;
 	memset(serv, 0, sizeof(*serv));
+	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
 	serv->sv_nrthreads = 1;
 	serv->sv_stats     = prog->pg_stats;
 	serv->sv_bufsz	   = bufsize? bufsize : 4096;
-	prog->pg_lovers = prog->pg_nvers-1;
 	xdrsize = 0;
-	for (vers=0; vers<prog->pg_nvers ; vers++)
-		if (prog->pg_vers[vers]) {
-			prog->pg_hivers = vers;
-			if (prog->pg_lovers > vers)
-				prog->pg_lovers = vers;
-			if (prog->pg_vers[vers]->vs_xdrsize > xdrsize)
-				xdrsize = prog->pg_vers[vers]->vs_xdrsize;
-		}
+	while (prog) {
+		prog->pg_lovers = prog->pg_nvers-1;
+		for (vers=0; vers<prog->pg_nvers ; vers++)
+			if (prog->pg_vers[vers]) {
+				prog->pg_hivers = vers;
+				if (prog->pg_lovers > vers)
+					prog->pg_lovers = vers;
+				if (prog->pg_vers[vers]->vs_xdrsize > xdrsize)
+					xdrsize = prog->pg_vers[vers]->vs_xdrsize;
+			}
+		prog = prog->pg_next;
+	}
 	serv->sv_xdrsize   = xdrsize;
 	INIT_LIST_HEAD(&serv->sv_threads);
 	INIT_LIST_HEAD(&serv->sv_sockets);
@@ -56,8 +60,6 @@ svc_create(struct svc_program *prog, uns
 	INIT_LIST_HEAD(&serv->sv_permsocks);
 	spin_lock_init(&serv->sv_lock);
 
-	serv->sv_name      = prog->pg_name;
-
 	/* Remove any stale portmap registrations */
 	svc_register(serv, 0, 0);
 
@@ -332,7 +334,10 @@ svc_process(struct svc_serv *serv, struc
 		goto sendit;
 	}
 		
-	if (prog != progp->pg_prog)
+	for (progp = serv->sv_program; progp; progp = progp->pg_next)
+		if (prog == progp->pg_prog)
+			break;
+	if (progp == NULL)
 		goto err_bad_prog;
 
 	if (vers >= progp->pg_nvers ||
@@ -444,11 +449,7 @@ err_bad_auth:
 	goto sendit;
 
 err_bad_prog:
-#ifdef RPC_PARANOIA
-	if (prog != 100227 || progp->pg_prog != 100003)
-		printk("svc: unknown program %d (me %d)\n", prog, progp->pg_prog);
-	/* else it is just a Solaris client seeing if ACLs are supported */
-#endif
+	dprintk("svc: unknown program %d\n", prog);
 	serv->sv_stats->rpcbadfmt++;
 	svc_putu32(resv, rpc_prog_unavail);
 	goto sendit;

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

