Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264240AbUD0Rde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbUD0Rde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbUD0Rdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:33:31 -0400
Received: from ns.suse.de ([195.135.220.2]:23741 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264213AbUD0RdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:33:05 -0400
Subject: Re: [PATCH 11/11] nfs-acl
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1083013819.15282.56.camel@lade.trondhjem.org>
References: <1082975215.3295.81.camel@winden.suse.de>
	 <1083013819.15282.56.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1083087180.19655.263.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 27 Apr 2004 19:33:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 23:10, Trond Myklebust wrote:
> On Mon, 2004-04-26 at 06:28, Andreas Gruenbacher wrote:
> > Client nfsacl support
> > 
> > Add support for the nfsacl protocol extension to nfs.
> > 
> 
> Why do we have to allocate an extra socket here? Can't we always assume
> that the NFSACL server will listen on port 2049 (the same as the NFS
> server)?
> 
> If so, we can simply clone the NFS rpc_client in order to share the
> socket/security flavours/...

We can share the same socket, but the code gets slightly messier. How
about sharing the whole struct rpc_xprt (incremental patch)?

nfsacl-one-socket
-------------------------- 8< --------------------------
Index: linux-2.6.6-rc2/fs/nfs/inode.c
===================================================================
--- linux-2.6.6-rc2.orig/fs/nfs/inode.c	2004-04-27 17:43:30.000000000 +0200
+++ linux-2.6.6-rc2/fs/nfs/inode.c	2004-04-27 19:30:57.867697752 +0200
@@ -370,32 +370,38 @@
  * Create an RPC client handle.
  */
 static struct rpc_clnt *
-__nfs_create_client(struct nfs_server *server,
-		    const struct nfs_mount_data *data,
-		    struct rpc_program *program)
+nfs_create_client(struct nfs_server *server,
+		  const struct nfs_mount_data *data,
+		  struct rpc_program *program,
+		  struct rpc_xprt *xprt)
 {
-	struct rpc_timeout	timeparms;
-	struct rpc_xprt		*xprt = NULL;
 	struct rpc_clnt		*clnt = NULL;
-	int			tcp   = (data->flags & NFS_MOUNT_TCP);
 
-	/* Initialize timeout values */
-	timeparms.to_initval = data->timeo * HZ / 10;
-	timeparms.to_retries = data->retrans;
-	timeparms.to_maxval  = tcp ? RPC_MAX_TCP_TIMEOUT : RPC_MAX_UDP_TIMEOUT;
-	timeparms.to_exponential = 1;
+	if (xprt)
+		xprt = xprt_get_handle(xprt);
+	else {
+		struct rpc_timeout	timeparms;
+		int			tcp   = (data->flags & NFS_MOUNT_TCP);
+
+		/* Initialize timeout values */
+		timeparms.to_initval = data->timeo * HZ / 10;
+		timeparms.to_retries = data->retrans;
+		timeparms.to_maxval  = tcp ? RPC_MAX_TCP_TIMEOUT :
+					     RPC_MAX_UDP_TIMEOUT;
+		timeparms.to_exponential = 1;
 
-	if (!timeparms.to_initval)
-		timeparms.to_initval = (tcp ? 600 : 11) * HZ / 10;
-	if (!timeparms.to_retries)
-		timeparms.to_retries = 5;
-
-	/* create transport and client */
-	xprt = xprt_create_proto(tcp ? IPPROTO_TCP : IPPROTO_UDP,
-				 &server->addr, &timeparms);
-	if (IS_ERR(xprt)) {
-		printk(KERN_WARNING "NFS: cannot create RPC transport.\n");
-		return (struct rpc_clnt *)xprt;
+		if (!timeparms.to_initval)
+			timeparms.to_initval = (tcp ? 600 : 11) * HZ / 10;
+		if (!timeparms.to_retries)
+			timeparms.to_retries = 5;
+
+		/* create transport */
+		xprt = xprt_create_proto(tcp ? IPPROTO_TCP : IPPROTO_UDP,
+					 &server->addr, &timeparms);
+		if (IS_ERR(xprt)) {
+			printk(KERN_WARNING "NFS: cannot create RPC transport.\n");
+			return (struct rpc_clnt *)xprt;
+		}
 	}
 	clnt = rpc_create_client(xprt, server->hostname, program,
 				 server->rpc_ops->version, data->pseudoflavor);
@@ -416,12 +422,6 @@
 	return clnt;
 }
 
-static struct rpc_clnt *
-nfs_create_client(struct nfs_server *server, const struct nfs_mount_data *data)
-{
-	return __nfs_create_client(server, data, &nfs_program);
-}
-
 /*
  * The way this works is that the mount process passes a structure
  * in the data argument which contains the server's IP address
@@ -482,13 +482,13 @@
 	/* XXX maybe we want to add a server->pseudoflavor field */
 
 	/* Create RPC client handles */
-	server->client = nfs_create_client(server, data);
+	server->client = nfs_create_client(server, data, &nfs_program, NULL);
 	if (server->client == NULL)
 		goto out_fail;
 #ifdef CONFIG_NFS_ACL
 	if (server->flags & NFS_MOUNT_VER3) {
-		server->acl_client = __nfs_create_client(server, data,
-							 &nfsacl_program);
+		server->acl_client = nfs_create_client(server, data,
+			&nfsacl_program, server->client->cl_xprt);
 		if (server->acl_client == NULL)
 			goto out_shutdown;
 		/* Initially assume the nfsacl program is supported */
Index: linux-2.6.6-rc2/include/linux/sunrpc/xprt.h
===================================================================
--- linux-2.6.6-rc2.orig/include/linux/sunrpc/xprt.h	2004-04-20 23:29:45.000000000 +0200
+++ linux-2.6.6-rc2/include/linux/sunrpc/xprt.h	2004-04-27 17:44:51.000000000 +0200
@@ -194,12 +194,14 @@
 	void			(*old_write_space)(struct sock *);
 
 	wait_queue_head_t	cong_wait;
+	int			used;
 };
 
 #ifdef __KERNEL__
 
 struct rpc_xprt *	xprt_create_proto(int proto, struct sockaddr_in *addr,
 					struct rpc_timeout *toparms);
+struct rpc_xprt *	xprt_get_handle(struct rpc_xprt *);
 int			xprt_destroy(struct rpc_xprt *);
 void			xprt_shutdown(struct rpc_xprt *);
 void			xprt_default_timeout(struct rpc_timeout *, int);
Index: linux-2.6.6-rc2/net/sunrpc/xprt.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/xprt.c	2004-04-27 17:42:38.000000000 +0200
+++ linux-2.6.6-rc2/net/sunrpc/xprt.c	2004-04-27 17:44:51.000000000 +0200
@@ -1430,6 +1430,7 @@
 	if ((xprt = kmalloc(sizeof(struct rpc_xprt), GFP_KERNEL)) == NULL)
 		return ERR_PTR(-ENOMEM);
 	memset(xprt, 0, sizeof(*xprt)); /* Nnnngh! */
+	xprt->used = 1;
 	xprt->max_reqs = entries;
 	slot_table_size = entries * sizeof(xprt->slot[0]);
 	xprt->slot = kmalloc(slot_table_size, GFP_KERNEL);
@@ -1645,17 +1646,30 @@
 }
 
 /*
+ * Get another reference to an RPC transport.
+ */
+struct rpc_xprt *
+xprt_get_handle(struct rpc_xprt *xprt)
+{
+	xprt->used++;
+	return xprt;
+}
+
+/*
  * Destroy an RPC transport, killing off all requests.
  */
 int
 xprt_destroy(struct rpc_xprt *xprt)
 {
-	dprintk("RPC:      destroying transport %p\n", xprt);
-	xprt_shutdown(xprt);
-	xprt_disconnect(xprt);
-	xprt_close(xprt);
-	kfree(xprt->slot);
-	kfree(xprt);
+	xprt->used--;
+	if (!xprt->used) {
+		dprintk("RPC:      destroying transport %p\n", xprt);
+		xprt_shutdown(xprt);
+		xprt_disconnect(xprt);
+		xprt_close(xprt);
+		kfree(xprt->slot);
+		kfree(xprt);
+	}
 
 	return 0;
 }
-------------------------- 8< --------------------------


> BTW: why does the client side NFS_ACL select QSORT? Can't userland do
> all that for us?

The server and client code both are using fs/nfsacl.c:nfsacl_decode()
for converting from the xdr_buf to the internal representation. We could
skip the qsort in the client case, but then the resulting struct
posix_acl * would not work in all possible contexts anymore, and who
knows where we will pass around acls in the future?


Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

