Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWIFNnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWIFNnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWIFNml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:42:41 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:53215 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750920AbWIFNia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:30 -0400
Message-Id: <20060906133954.468910000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:39 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH 09/21] nfs: make swap on NFS robust
Content-Disposition: inline; filename=nfs_vmio.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a proper a_ops->swapfile() implementation for NFS. This will set the
NFS socket to SOCK_VMIO and run socket reconnect under PF_MEMALLOC as well
as reset SOCK_VMIO before engaging the protocol ->connect() method.

PF_MEMALLOC should allow the allocation of struct socket and related objects
and the early (re)setting of SOCK_VMIO should allow us to receive the packets
required for the TCP connection buildup.

(swapping continues over a server reset during a large (4k) ping flood)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 fs/nfs/file.c               |    2 +-
 include/linux/sunrpc/xprt.h |    5 ++++-
 net/sunrpc/sched.c          |    4 ++--
 net/sunrpc/xprtsock.c       |   44 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 4 deletions(-)

Index: linux-2.6/fs/nfs/file.c
===================================================================
--- linux-2.6.orig/fs/nfs/file.c
+++ linux-2.6/fs/nfs/file.c
@@ -323,7 +323,7 @@ static int nfs_release_page(struct page 
 
 static int nfs_swapfile(struct address_space *mapping, int enable)
 {
-	return 0;
+	return xs_swapper(NFS_CLIENT(mapping->host)->cl_xprt, enable);
 }
 
 const struct address_space_operations nfs_file_aops = {
Index: linux-2.6/net/sunrpc/xprtsock.c
===================================================================
--- linux-2.6.orig/net/sunrpc/xprtsock.c
+++ linux-2.6/net/sunrpc/xprtsock.c
@@ -1014,6 +1014,7 @@ static void xs_udp_connect_worker(void *
 {
 	struct rpc_xprt *xprt = (struct rpc_xprt *) args;
 	struct socket *sock = xprt->sock;
+	unsigned long pflags = current->flags;
 	int err, status = -EIO;
 
 	if (xprt->shutdown || xprt->addr.sin_port == 0)
@@ -1021,6 +1022,9 @@ static void xs_udp_connect_worker(void *
 
 	dprintk("RPC:      xs_udp_connect_worker for xprt %p\n", xprt);
 
+	if (xprt->swapper)
+		current->flags |= PF_MEMALLOC;
+
 	/* Start by resetting any existing state */
 	xs_close(xprt);
 
@@ -1054,6 +1058,9 @@ static void xs_udp_connect_worker(void *
 		xprt->sock = sock;
 		xprt->inet = sk;
 
+		if (xprt->swapper)
+			sk_set_vmio(sk);
+
 		write_unlock_bh(&sk->sk_callback_lock);
 	}
 	xs_udp_do_set_buffer_size(xprt);
@@ -1061,6 +1068,7 @@ static void xs_udp_connect_worker(void *
 out:
 	xprt_wake_pending_tasks(xprt, status);
 	xprt_clear_connecting(xprt);
+	current->flags = pflags;
 }
 
 /*
@@ -1097,11 +1105,15 @@ static void xs_tcp_connect_worker(void *
 {
 	struct rpc_xprt *xprt = (struct rpc_xprt *)args;
 	struct socket *sock = xprt->sock;
+	unsigned long pflags = current->flags;
 	int err, status = -EIO;
 
 	if (xprt->shutdown || xprt->addr.sin_port == 0)
 		goto out;
 
+	if (xprt->swapper)
+		current->flags |= PF_MEMALLOC;
+
 	dprintk("RPC:      xs_tcp_connect_worker for xprt %p\n", xprt);
 
 	if (!xprt->sock) {
@@ -1148,6 +1160,10 @@ static void xs_tcp_connect_worker(void *
 		write_unlock_bh(&sk->sk_callback_lock);
 	}
 
+
+	if (xprt->swapper)
+		sk_set_vmio(xprt->inet);
+
 	/* Tell the socket layer to start connecting... */
 	xprt->stat.connect_count++;
 	xprt->stat.connect_start = jiffies;
@@ -1174,6 +1190,7 @@ out:
 	xprt_wake_pending_tasks(xprt, status);
 out_clear:
 	xprt_clear_connecting(xprt);
+	current->flags = pflags;
 }
 
 /**
@@ -1369,3 +1386,30 @@ int xs_setup_tcp(struct rpc_xprt *xprt, 
 
 	return 0;
 }
+
+/**
+ * xs_swapper - Tag this transport as being used for swap.
+ * @xprt: transport to tag
+ * @enable: enable/disable
+ *
+ */
+int xs_swapper(struct rpc_xprt *xprt, int enable)
+{
+	int err = 0;
+
+	if (enable) {
+		/*
+		 * keep one extra sock reference so the reserve won't dip
+		 * when the socket gets reconnected.
+		 */
+		sk_adjust_memalloc(1, TX_RESERVE_PAGES);
+		sk_set_vmio(xprt->inet);
+		xprt->swapper = 1;
+	} else if (xprt->swapper) {
+		xprt->swapper = 0;
+		sk_clear_vmio(xprt->inet);
+		sk_adjust_memalloc(-1, -TX_RESERVE_PAGES);
+	}
+
+	return err;
+}
Index: linux-2.6/include/linux/sunrpc/xprt.h
===================================================================
--- linux-2.6.orig/include/linux/sunrpc/xprt.h
+++ linux-2.6/include/linux/sunrpc/xprt.h
@@ -147,7 +147,9 @@ struct rpc_xprt {
 	unsigned int		max_reqs;	/* total slots */
 	unsigned long		state;		/* transport state */
 	unsigned char		shutdown   : 1,	/* being shut down */
-				resvport   : 1; /* use a reserved port */
+				resvport   : 1, /* use a reserved port */
+				swapper    : 1; /* we're swapping over this
+						   transport */
 
 	/*
 	 * XID
@@ -261,6 +263,7 @@ void			xprt_disconnect(struct rpc_xprt *
  */
 int			xs_setup_udp(struct rpc_xprt *xprt, struct rpc_timeout *to);
 int			xs_setup_tcp(struct rpc_xprt *xprt, struct rpc_timeout *to);
+int			xs_swapper(struct rpc_xprt *xprt, int enable);
 
 /*
  * Reserved bit positions in xprt->state
Index: linux-2.6/net/sunrpc/sched.c
===================================================================
--- linux-2.6.orig/net/sunrpc/sched.c
+++ linux-2.6/net/sunrpc/sched.c
@@ -736,8 +736,8 @@ void * rpc_malloc(struct rpc_task *task,
 	struct rpc_rqst *req = task->tk_rqstp;
 	gfp_t	gfp;
 
-	if (task->tk_flags & RPC_TASK_SWAPPER)
-		gfp = GFP_ATOMIC;
+	if (RPC_IS_SWAPPER(task))
+		gfp = GFP_ATOMIC | __GFP_EMERGENCY;
 	else
 		gfp = GFP_NOFS;
 

--
