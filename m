Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSHVWK7>; Thu, 22 Aug 2002 18:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSHVWK7>; Thu, 22 Aug 2002 18:10:59 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:4224 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S317392AbSHVWK6>; Thu, 22 Aug 2002 18:10:58 -0400
Date: Thu, 22 Aug 2002 18:15:04 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] eliminate hangs during RPC client shutdown
Message-ID: <Pine.LNX.4.44.0208221806330.1253-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linus-

this is against 2.5.31 with the recent RPC call_start/reserve patches
applied, and eliminates an infinite loop in rpciod if an RPC client's
reference counter accidentally goes negative.  i've been running this
under load since 2.5.30 with no ill effects.


diff -drN -U2 06-connect2/net/sunrpc/clnt.c 07-shutdown/net/sunrpc/clnt.c
--- 06-connect2/net/sunrpc/clnt.c	Mon Aug 12 16:31:53 2002
+++ 07-shutdown/net/sunrpc/clnt.c	Mon Aug 12 16:53:24 2002
@@ -138,11 +138,9 @@
 rpc_shutdown_client(struct rpc_clnt *clnt)
 {
-	dprintk("RPC: shutting down %s client for %s\n",
-		clnt->cl_protname, clnt->cl_server);
-	while (atomic_read(&clnt->cl_users)) {
-#ifdef RPC_DEBUG
-		dprintk("RPC: rpc_shutdown_client: client %s, tasks=%d\n",
-			clnt->cl_protname, atomic_read(&clnt->cl_users));
-#endif
+	dprintk("RPC: shutting down %s client for %s, tasks=%d\n",
+			clnt->cl_protname, clnt->cl_server,
+			atomic_read(&clnt->cl_users));
+
+	while (atomic_read(&clnt->cl_users) > 0) {
 		/* Don't let rpc_release_client destroy us */
 		clnt->cl_oneshot = 0;
@@ -151,4 +149,14 @@
 		sleep_on_timeout(&destroy_wait, 1*HZ);
 	}
+
+	if (atomic_read(&clnt->cl_users) < 0) {
+		printk(KERN_ERR "RPC: rpc_shutdown_client clnt %p tasks=%d\n",
+				clnt, atomic_read(&clnt->cl_users));
+#ifdef RPC_DEBUG
+		rpc_show_tasks();
+#endif
+		BUG();
+	}
+
 	return rpc_destroy_client(clnt);
 }

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

