Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRALMpm>; Fri, 12 Jan 2001 07:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRALMpX>; Fri, 12 Jan 2001 07:45:23 -0500
Received: from mons.uio.no ([129.240.130.14]:44703 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129183AbRALMpP>;
	Fri, 12 Jan 2001 07:45:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14942.64595.157544.350302@charged.uio.no>
Date: Fri, 12 Jan 2001 13:45:07 +0100 (CET)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS devel <nfs-devel@linux.kernel.org>
Subject: Spinlocking patch for in xprt.c
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch (taken from the zero copy networking) upgrades the
spinlocking of the xprt_(up|down)_transmit() 'semaphores' in order to
work safely with the networking bottom halves. Several of the latter
(cf. xprt.c:tcp_write_space() & friends) do want to test the value of
'xprt->snd_task'.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.1-fh_align/net/sunrpc/xprt.c linux-2.4.1-xprt/net/sunrpc/xprt.c
--- linux-2.4.1-fh_align/net/sunrpc/xprt.c	Wed Nov 29 07:34:01 2000
+++ linux-2.4.1-xprt/net/sunrpc/xprt.c	Fri Jan 12 11:58:42 2001
@@ -1116,7 +1116,7 @@
 	struct rpc_xprt *xprt = task->tk_rqstp->rq_xprt;
 	struct rpc_rqst	*req = task->tk_rqstp;
 
-	spin_lock(&xprt_lock);
+	spin_lock_bh(&xprt_sock_lock);
 	if (xprt->snd_task && xprt->snd_task != task) {
 		dprintk("RPC: %4d TCP write queue full (task %d)\n",
 			task->tk_pid, xprt->snd_task->tk_pid);
@@ -1130,7 +1130,7 @@
 #endif
 		req->rq_bytes_sent = 0;
 	}
-	spin_unlock(&xprt_lock);
+	spin_unlock_bh(&xprt_sock_lock);
 	return xprt->snd_task == task;
 }
 
@@ -1143,10 +1143,10 @@
 	struct rpc_xprt *xprt = task->tk_rqstp->rq_xprt;
 
 	if (xprt->snd_task && xprt->snd_task == task) {
-		spin_lock(&xprt_lock);
+		spin_lock_bh(&xprt_sock_lock);
 		xprt->snd_task = NULL;
 		rpc_wake_up_next(&xprt->sending);
-		spin_unlock(&xprt_lock);
+		spin_unlock_bh(&xprt_sock_lock);
 	}
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
