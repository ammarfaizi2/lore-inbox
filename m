Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSIZTur>; Thu, 26 Sep 2002 15:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbSIZTur>; Thu, 26 Sep 2002 15:50:47 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:26241 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S261483AbSIZTuo>; Thu, 26 Sep 2002 15:50:44 -0400
Date: Thu, 26 Sep 2002 15:56:06 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] cast and signedness clean up for RPC
Message-ID: <Pine.LNX.4.44.0209261553050.28477-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this patch makes the RPC layer always use "int" for protocol (TCP v. UDP)  
and "unsigned short" for socket port.  more cleanup in the works.  against 
2.5.38.


diff -drN -U2 03-jiffies/include/linux/sunrpc/svc.h 04-proto/include/linux/sunrpc/svc.h
--- 03-jiffies/include/linux/sunrpc/svc.h	Sun Sep 22 00:25:11 2002
+++ 04-proto/include/linux/sunrpc/svc.h	Mon Sep 23 14:22:57 2002
@@ -108,5 +108,5 @@
 	u32			rq_vers;	/* program version */
 	u32			rq_proc;	/* procedure number */
-	u32			rq_prot;	/* IP protocol */
+	int			rq_prot;	/* IP protocol */
 	unsigned short		rq_verfed  : 1,	/* reply has verifier */
 				rq_userset : 1,	/* auth->setuser OK */
diff -drN -U2 03-jiffies/net/sunrpc/clnt.c 04-proto/net/sunrpc/clnt.c
--- 03-jiffies/net/sunrpc/clnt.c	Mon Sep 23 14:20:30 2002
+++ 04-proto/net/sunrpc/clnt.c	Mon Sep 23 14:22:57 2002
@@ -104,5 +104,5 @@
 	INIT_RPC_WAITQ(&clnt->cl_bindwait, "bindwait");
 
-	if (!clnt->cl_port)
+	if (clnt->cl_port == 0)
 		clnt->cl_autobind = 1;
 
@@ -565,5 +565,5 @@
 	task->tk_action = (xprt_connected(xprt)) ? call_transmit : call_connect;
 
-	if (!clnt->cl_port) {
+	if (clnt->cl_port == 0) {
 		task->tk_action = call_connect;
 		task->tk_timeout = RPC_CONNECT_TIMEOUT;
diff -drN -U2 03-jiffies/net/sunrpc/pmap_clnt.c 04-proto/net/sunrpc/pmap_clnt.c
--- 03-jiffies/net/sunrpc/pmap_clnt.c	Mon Sep 23 14:02:52 2002
+++ 04-proto/net/sunrpc/pmap_clnt.c	Mon Sep 23 14:22:57 2002
@@ -47,5 +47,5 @@
 	struct rpc_task	*child;
 
-	dprintk("RPC: %4d rpc_getport(%s, %d, %d, %d)\n",
+	dprintk("RPC: %4d rpc_getport(%s, %u, %u, %d)\n",
 			task->tk_pid, clnt->cl_server,
 			map->pm_prog, map->pm_vers, map->pm_prot);
@@ -91,10 +91,10 @@
 rpc_getport_external(struct sockaddr_in *sin, __u32 prog, __u32 vers, int prot)
 {
-	struct rpc_portmap map = { prog, vers, prot, 0 };
+	struct rpc_portmap map = { prog, vers, (__u32) prot, 0 };
 	struct rpc_clnt	*pmap_clnt;
 	char		hostname[32];
 	int		status;
 
-	dprintk("RPC:      rpc_getport_external(%u.%u.%u.%u, %d, %d, %d)\n",
+	dprintk("RPC:      rpc_getport_external(%u.%u.%u.%u, %u, %u, %d)\n",
 			NIPQUAD(sin->sin_addr.s_addr), prog, vers, prot);
 
@@ -120,5 +120,5 @@
 	struct rpc_clnt	*clnt = task->tk_client;
 
-	dprintk("RPC: %4d pmap_getport_done(status %d, port %d)\n",
+	dprintk("RPC: %4d pmap_getport_done(status %d, port %u)\n",
 			task->tk_pid, task->tk_status, clnt->cl_port);
 	if (task->tk_status < 0) {
@@ -152,5 +152,5 @@
 	unsigned int		error = 0;
 
-	dprintk("RPC: registering (%d, %d, %d, %d) with portmapper.\n",
+	dprintk("RPC: registering (%u, %u, %d, %u) with portmapper.\n",
 			prog, vers, prot, port);
 
@@ -164,8 +164,8 @@
 	map.pm_prog = prog;
 	map.pm_vers = vers;
-	map.pm_prot = prot;
+	map.pm_prot = (__u32) prot;
 	map.pm_port = port;
 
-	error = rpc_call(pmap_clnt, port? PMAP_SET : PMAP_UNSET,
+	error = rpc_call(pmap_clnt, (port != 0)? PMAP_SET : PMAP_UNSET,
 					&map, okay, 0);
 
@@ -218,5 +218,5 @@
 xdr_encode_mapping(struct rpc_rqst *req, u32 *p, struct rpc_portmap *map)
 {
-	dprintk("RPC: xdr_encode_mapping(%d, %d, %d, %d)\n",
+	dprintk("RPC: xdr_encode_mapping(%u, %u, %u, %u)\n",
 		map->pm_prog, map->pm_vers, map->pm_prot, map->pm_port);
 	*p++ = htonl(map->pm_prog);
diff -drN -U2 03-jiffies/net/sunrpc/svc.c 04-proto/net/sunrpc/svc.c
--- 03-jiffies/net/sunrpc/svc.c	Sun Sep 22 00:25:25 2002
+++ 04-proto/net/sunrpc/svc.c	Mon Sep 23 14:22:57 2002
@@ -198,5 +198,5 @@
 		progp->pg_name, proto == IPPROTO_UDP? "udp" : "tcp", port);
 
-	if (!port)
+	if (port == 0)
 		clear_thread_flag(TIF_SIGPENDING);
 
@@ -213,5 +213,5 @@
 	}
 
-	if (!port) {
+	if (port == 0) {
 		spin_lock_irqsave(&current->sigmask_lock, flags);
 		recalc_sigpending();
diff -drN -U2 03-jiffies/net/sunrpc/svcsock.c 04-proto/net/sunrpc/svcsock.c
--- 03-jiffies/net/sunrpc/svcsock.c	Sun Sep 22 00:25:00 2002
+++ 04-proto/net/sunrpc/svcsock.c	Mon Sep 23 14:22:57 2002
@@ -1177,5 +1177,5 @@
 	/* Register socket with portmapper */
 	if (*errp >= 0 && pmap_register)
-		*errp = svc_register(serv, inet->protocol,
+		*errp = svc_register(serv, (int) inet->protocol,
 				     ntohs(inet_sk(inet)->sport));
 
diff -drN -U2 03-jiffies/net/sunrpc/xprt.c 04-proto/net/sunrpc/xprt.c
--- 03-jiffies/net/sunrpc/xprt.c	Mon Sep 23 14:20:30 2002
+++ 04-proto/net/sunrpc/xprt.c	Mon Sep 23 15:36:03 2002
@@ -429,5 +429,5 @@
 		return;
 	}
-	if (!xprt->addr.sin_port) {
+	if (xprt->addr.sin_port == 0) {
 		task->tk_status = -EIO;
 		return;
@@ -456,5 +456,5 @@
 	 */
 	status = sock->ops->connect(sock, (struct sockaddr *) &xprt->addr,
-				sizeof(xprt->addr), O_NONBLOCK);
+				(int) sizeof(xprt->addr), O_NONBLOCK);
 	dprintk("RPC: %4d  connect status %d connected %d sock state %d\n",
 		task->tk_pid, -status, xprt_connected(xprt), inet->state);
@@ -1365,5 +1365,5 @@
 
 	dprintk("RPC:      setting up %s transport...\n",
-				proto == IPPROTO_UDP? "UDP" : "TCP");
+				(proto == IPPROTO_UDP)? "UDP" : "TCP");
 
 	if ((xprt = kmalloc(sizeof(struct rpc_xprt), GFP_KERNEL)) == NULL)
@@ -1415,5 +1415,6 @@
 {
 	struct sockaddr_in myaddr;
-	int		err, port;
+	unsigned short	port;
+	int		err;
 
 	memset(&myaddr, 0, sizeof(myaddr));

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

