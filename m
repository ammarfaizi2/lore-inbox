Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVB0QDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVB0QDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 11:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVB0QCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 11:02:30 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:26836 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261427AbVB0P44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:56 -0500
Message-Id: <20050227152351.423693000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:49 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 06/16] Allow multiple programs to share the same transport
Content-Disposition: inline; filename=nfsacl-allow-multiple-programs-to-share-the-same-transport.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a clone of an RPC client (created with rpc_clone_client()) to change to
another program.  This allows the NFS and NFSACL programs to share the same
transport.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Acked-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc5/include/linux/sunrpc/clnt.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/sunrpc/clnt.h
+++ linux-2.6.11-rc5/include/linux/sunrpc/clnt.h
@@ -22,6 +22,7 @@
  * This defines an RPC port mapping
  */
 struct rpc_portmap {
+	struct rpc_portmap	*pm_parent;
 	__u32			pm_prog;
 	__u32			pm_vers;
 	__u32			pm_prot;
@@ -116,6 +117,8 @@ struct rpc_clnt *rpc_clone_client(struct
 int		rpc_shutdown_client(struct rpc_clnt *);
 int		rpc_destroy_client(struct rpc_clnt *);
 void		rpc_release_client(struct rpc_clnt *);
+void		rpc_change_program(struct rpc_clnt *, struct rpc_program *,
+				   int);
 void		rpc_getport(struct rpc_task *, struct rpc_clnt *);
 int		rpc_register(u32, u32, int, unsigned short, int *);
 
Index: linux-2.6.11-rc5/net/sunrpc/clnt.c
===================================================================
--- linux-2.6.11-rc5.orig/net/sunrpc/clnt.c
+++ linux-2.6.11-rc5/net/sunrpc/clnt.c
@@ -139,6 +139,7 @@ rpc_create_client(struct rpc_xprt *xprt,
 	clnt->cl_maxproc  = version->nrprocs;
 	clnt->cl_protname = program->name;
 	clnt->cl_pmap	  = &clnt->cl_pmap_default;
+	clnt->cl_pmap->pm_parent = clnt->cl_pmap;
 	clnt->cl_port     = xprt->addr.sin_port;
 	clnt->cl_prog     = program->number;
 	clnt->cl_vers     = version->number;
@@ -207,6 +208,9 @@ rpc_clone_client(struct rpc_clnt *clnt)
 	rpc_init_rtt(&new->cl_rtt_default, clnt->cl_xprt->timeout.to_initval);
 	if (new->cl_auth)
 		atomic_inc(&new->cl_auth->au_count);
+	new->cl_pmap		= &new->cl_pmap_default;
+	new->cl_pmap->pm_parent = clnt->cl_pmap->pm_parent;
+	rpc_init_wait_queue(&new->cl_pmap_default.pm_bindwait, "bindwait");
 	return new;
 out_no_clnt:
 	printk(KERN_INFO "RPC: out of memory in %s\n", __FUNCTION__);
@@ -296,6 +300,25 @@ rpc_release_client(struct rpc_clnt *clnt
 }
 
 /*
+ * Change the program of a (usually cloned) client
+ */
+void
+rpc_change_program(struct rpc_clnt *clnt, struct rpc_program *program,
+		   int vers)
+{
+	struct rpc_version *version;
+
+	BUG_ON(vers >= program->nrvers || !program->version[vers]);
+	version = program->version[vers];
+	clnt->cl_procinfo = version->procs;
+	clnt->cl_maxproc  = version->nrprocs;
+	clnt->cl_protname = program->name;
+	clnt->cl_prog     = program->number;
+	clnt->cl_vers     = version->number;
+	clnt->cl_stats    = program->stats;
+}
+
+/*
  * Default callback for async RPC calls
  */
 static void
Index: linux-2.6.11-rc5/net/sunrpc/pmap_clnt.c
===================================================================
--- linux-2.6.11-rc5.orig/net/sunrpc/pmap_clnt.c
+++ linux-2.6.11-rc5/net/sunrpc/pmap_clnt.c
@@ -41,7 +41,7 @@ static spinlock_t		pmap_lock = SPIN_LOCK
 void
 rpc_getport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
-	struct rpc_portmap *map = clnt->cl_pmap;
+	struct rpc_portmap *map = clnt->cl_pmap->pm_parent;
 	struct sockaddr_in *sap = &clnt->cl_xprt->addr;
 	struct rpc_message msg = {
 		.rpc_proc	= &pmap_procedures[PMAP_GETPORT],
@@ -132,7 +132,7 @@ static void
 pmap_getport_done(struct rpc_task *task)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
-	struct rpc_portmap *map = clnt->cl_pmap;
+	struct rpc_portmap *map = clnt->cl_pmap->pm_parent;
 
 	dprintk("RPC: %4d pmap_getport_done(status %d, port %d)\n",
 			task->tk_pid, task->tk_status, clnt->cl_port);
Index: linux-2.6.11-rc5/net/sunrpc/sunrpc_syms.c
===================================================================
--- linux-2.6.11-rc5.orig/net/sunrpc/sunrpc_syms.c
+++ linux-2.6.11-rc5/net/sunrpc/sunrpc_syms.c
@@ -42,6 +42,7 @@ EXPORT_SYMBOL(rpc_release_task);
 /* RPC client functions */
 EXPORT_SYMBOL(rpc_create_client);
 EXPORT_SYMBOL(rpc_clone_client);
+EXPORT_SYMBOL(rpc_change_program);
 EXPORT_SYMBOL(rpc_destroy_client);
 EXPORT_SYMBOL(rpc_shutdown_client);
 EXPORT_SYMBOL(rpc_release_client);

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

