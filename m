Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTFROiJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbTFROiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:38:08 -0400
Received: from ns.suse.de ([213.95.15.193]:46864 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265269AbTFROht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:37:49 -0400
Date: Wed, 18 Jun 2003 16:51:45 +0200
From: Andi Kleen <ak@suse.de>
To: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: [PATCH] Support non reserved ports for NFS client
Message-ID: <20030618145145.GA5204@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently you cannot have more than 1024 mounts for a single local
IP address because the NFS client always tries to get a "secure"
port <1024. 

This patch adds a new noreserved mount option to disable this.

It is off by default because most NFS servers (including linux knfsd)
check it by default, unless special options are given.

Patch for 2.4.21. Also requires a small patch to util-linux/mount,
which I'm sending separately.

-Andi


diff -u linux-2.4.21-work/fs/lockd/host.c-NONRES linux-2.4.21-work/fs/lockd/host.c
--- linux-2.4.21-work/fs/lockd/host.c-NONRES	2002-09-25 01:49:40.000000000 +0200
+++ linux-2.4.21-work/fs/lockd/host.c	2003-06-18 16:09:58.000000000 +0200
@@ -193,7 +193,7 @@
 		/* Create RPC socket as root user so we get a priv port */
 		current->fsuid = 0;
 		cap_raise (current->cap_effective, CAP_NET_BIND_SERVICE);
-		xprt = xprt_create_proto(host->h_proto, &host->h_addr, NULL);
+		xprt = xprt_create_proto(host->h_proto, &host->h_addr, NULL, 1);
 		current->fsuid = saved_fsuid;
 		current->cap_effective = saved_cap;
 		if (xprt == NULL)
diff -u linux-2.4.21-work/fs/lockd/mon.c-NONRES linux-2.4.21-work/fs/lockd/mon.c
--- linux-2.4.21-work/fs/lockd/mon.c-NONRES	2002-09-25 01:49:40.000000000 +0200
+++ linux-2.4.21-work/fs/lockd/mon.c	2003-06-18 16:09:58.000000000 +0200
@@ -110,7 +110,7 @@
 	sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 	sin.sin_port = 0;
 
-	xprt = xprt_create_proto(IPPROTO_UDP, &sin, NULL);
+	xprt = xprt_create_proto(IPPROTO_UDP, &sin, NULL, 1);
 	if (!xprt)
 		goto out;
 
diff -u linux-2.4.21-work/fs/nfs/inode.c-NONRES linux-2.4.21-work/fs/nfs/inode.c
--- linux-2.4.21-work/fs/nfs/inode.c-NONRES	2002-11-30 00:37:12.000000000 +0100
+++ linux-2.4.21-work/fs/nfs/inode.c	2003-06-18 16:09:58.000000000 +0200
@@ -361,7 +361,8 @@
 
 	/* Now create transport and client */
 	xprt = xprt_create_proto(tcp? IPPROTO_TCP : IPPROTO_UDP,
-						&srvaddr, &timeparms);
+						&srvaddr, &timeparms, 
+				 !(data->flags & NFS_MOUNT_NONRESERVED));
 	if (xprt == NULL)
 		goto out_no_xprt;
 
@@ -560,6 +561,7 @@
 		char *str;
 		char *nostr;
 	} nfs_info[] = {
+		{ NFS_MOUNT_NONRESERVED, ",nonreserved", ",reserved" },
 		{ NFS_MOUNT_SOFT, ",soft", ",hard" },
 		{ NFS_MOUNT_INTR, ",intr", "" },
 		{ NFS_MOUNT_POSIX, ",posix", "" },
diff -u linux-2.4.21-work/fs/nfs/mount_clnt.c-NONRES linux-2.4.21-work/fs/nfs/mount_clnt.c
--- linux-2.4.21-work/fs/nfs/mount_clnt.c-NONRES	2002-11-30 00:37:12.000000000 +0100
+++ linux-2.4.21-work/fs/nfs/mount_clnt.c	2003-06-18 16:09:58.000000000 +0200
@@ -70,7 +70,7 @@
 	struct rpc_xprt	*xprt;
 	struct rpc_clnt	*clnt;
 
-	if (!(xprt = xprt_create_proto(protocol, srvaddr, NULL)))
+	if (!(xprt = xprt_create_proto(protocol, srvaddr, NULL, 1)))
 		return NULL;
 
 	clnt = rpc_create_client(xprt, hostname,
diff -u linux-2.4.21-work/include/linux/sunrpc/xprt.h-NONRES linux-2.4.21-work/include/linux/sunrpc/xprt.h
--- linux-2.4.21-work/include/linux/sunrpc/xprt.h-NONRES	2003-05-27 13:44:14.000000000 +0200
+++ linux-2.4.21-work/include/linux/sunrpc/xprt.h	2003-06-18 16:27:23.000000000 +0200
@@ -134,7 +134,8 @@
 	unsigned long		sockstate;	/* Socket state */
 	unsigned char		shutdown   : 1,	/* being shut down */
 				nocong	   : 1,	/* no congestion control */
-				stream     : 1;	/* TCP */
+				stream     : 1,	/* TCP */
+				reserved : 1;	/* reserved source port */     
 
 	/*
 	 * State of TCP reply receive stuff
@@ -166,7 +167,7 @@
 #ifdef __KERNEL__
 
 struct rpc_xprt *	xprt_create_proto(int proto, struct sockaddr_in *addr,
-					struct rpc_timeout *toparms);
+					struct rpc_timeout *toparms, int res);
 int			xprt_destroy(struct rpc_xprt *);
 void			xprt_shutdown(struct rpc_xprt *);
 void			xprt_default_timeout(struct rpc_timeout *, int);
diff -u linux-2.4.21-work/include/linux/nfs_mount.h-NONRES linux-2.4.21-work/include/linux/nfs_mount.h
--- linux-2.4.21-work/include/linux/nfs_mount.h-NONRES	2003-05-27 12:04:18.000000000 +0200
+++ linux-2.4.21-work/include/linux/nfs_mount.h	2003-06-18 16:31:16.000000000 +0200
@@ -53,6 +53,8 @@
 #define NFS_MOUNT_KERBEROS	0x0100	/* 3 */
 #define NFS_MOUNT_NONLM		0x0200	/* 3 */
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
+/* 0x800 for NOACL */
+#define NFS_MOUNT_NONRESERVED	0x1000
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif
diff -u linux-2.4.21-work/net/sunrpc/xprt.c-NONRES linux-2.4.21-work/net/sunrpc/xprt.c
--- linux-2.4.21-work/net/sunrpc/xprt.c-NONRES	2003-06-16 11:37:56.000000000 +0200
+++ linux-2.4.21-work/net/sunrpc/xprt.c	2003-06-18 16:10:01.000000000 +0200
@@ -86,7 +86,7 @@
 static void	xprt_reserve_status(struct rpc_task *task);
 static void	xprt_disconnect(struct rpc_xprt *);
 static void	xprt_reconn_status(struct rpc_task *task);
-static struct socket *xprt_create_socket(int, struct rpc_timeout *);
+static struct socket *xprt_create_socket(int, struct rpc_timeout *, int res);
 static int	xprt_bind_socket(struct rpc_xprt *, struct socket *);
 static int      __xprt_get_cong(struct rpc_xprt *, struct rpc_task *);
 
@@ -450,7 +450,8 @@
 	status = -ENOTCONN;
 	if (!(inet = xprt->inet)) {
 		/* Create an unconnected socket */
-		if (!(sock = xprt_create_socket(xprt->prot, &xprt->timeout)))
+		if (!(sock = xprt_create_socket(xprt->prot, &xprt->timeout, 
+						xprt->reserved)))
 			goto defer;
 		xprt_bind_socket(xprt, sock);
 		inet = sock->sk;
@@ -1349,7 +1350,7 @@
  */
 static struct rpc_xprt *
 xprt_setup(struct socket *sock, int proto,
-			struct sockaddr_in *ap, struct rpc_timeout *to)
+			struct sockaddr_in *ap, struct rpc_timeout *to, int res)
 {
 	struct rpc_xprt	*xprt;
 	struct rpc_rqst	*req;
@@ -1394,7 +1395,8 @@
 		req->rq_next = req + 1;
 	req->rq_next = NULL;
 	xprt->free = xprt->slot;
-
+	xprt->reserved = res; 
+	
 	dprintk("RPC:      created transport %p\n", xprt);
 	
 	xprt_bind_socket(xprt, sock);
@@ -1487,7 +1489,7 @@
  * Create a client socket given the protocol and peer address.
  */
 static struct socket *
-xprt_create_socket(int proto, struct rpc_timeout *to)
+xprt_create_socket(int proto, struct rpc_timeout *to, int res)
 {
 	struct socket	*sock;
 	int		type, err;
@@ -1503,7 +1505,7 @@
 	}
 
 	/* If the caller has the capability, bind to a reserved port */
-	if (capable(CAP_NET_BIND_SERVICE) && xprt_bindresvport(sock) < 0)
+	if (res && capable(CAP_NET_BIND_SERVICE) && xprt_bindresvport(sock) < 0)
 		goto failed;
 
 	return sock;
@@ -1517,17 +1519,17 @@
  * Create an RPC client transport given the protocol and peer address.
  */
 struct rpc_xprt *
-xprt_create_proto(int proto, struct sockaddr_in *sap, struct rpc_timeout *to)
+xprt_create_proto(int proto, struct sockaddr_in *sap, struct rpc_timeout *to, int res)
 {
 	struct socket	*sock;
 	struct rpc_xprt	*xprt;
 
 	dprintk("RPC:      xprt_create_proto called\n");
 
-	if (!(sock = xprt_create_socket(proto, to)))
+	if (!(sock = xprt_create_socket(proto, to, res)))
 		return NULL;
 
-	if (!(xprt = xprt_setup(sock, proto, sap, to)))
+	if (!(xprt = xprt_setup(sock, proto, sap, to, res)))
 		sock_release(sock);
 
 	return xprt;
diff -u linux-2.4.21-work/net/sunrpc/pmap_clnt.c-NONRES linux-2.4.21-work/net/sunrpc/pmap_clnt.c
--- linux-2.4.21-work/net/sunrpc/pmap_clnt.c-NONRES	2002-09-25 01:49:41.000000000 +0200
+++ linux-2.4.21-work/net/sunrpc/pmap_clnt.c	2003-06-18 16:10:01.000000000 +0200
@@ -187,7 +187,8 @@
 	struct rpc_clnt	*clnt;
 
 	/* printk("pmap: create xprt\n"); */
-	if (!(xprt = xprt_create_proto(proto, srvaddr, NULL)))
+	/* use non reserved ports for now. I hope that's ok. -AK */
+	if (!(xprt = xprt_create_proto(proto, srvaddr, NULL, 0)))
 		return NULL;
 	xprt->addr.sin_port = htons(RPC_PMAP_PORT);
 



