Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317918AbSGPR6Z>; Tue, 16 Jul 2002 13:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317913AbSGPR6O>; Tue, 16 Jul 2002 13:58:14 -0400
Received: from pat.uio.no ([129.240.130.16]:8432 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317930AbSGPR5E>;
	Tue, 16 Jul 2002 13:57:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15668.24345.723792.226636@charged.uio.no>
Date: Tue, 16 Jul 2002 19:59:53 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] RPC over UDP congestion control updates [6/8]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eliminate the arbitrary timeouts in xprt_adjust_cwnd(). Strict
enforcement of the congestion avoidance algorithm as detailed in Van
Jacobson's 1998 paper http://www-nrg.ee.lbl.gov/nrg-papers.html
Congestion Avoidance and Control.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25-rpc_cong1/include/linux/sunrpc/xprt.h linux-2.5.25-rpc_cong2/include/linux/sunrpc/xprt.h
--- linux-2.5.25-rpc_cong1/include/linux/sunrpc/xprt.h	Tue Jul 16 15:32:03 2002
+++ linux-2.5.25-rpc_cong2/include/linux/sunrpc/xprt.h	Tue Jul 16 15:32:36 2002
@@ -33,11 +33,11 @@
  * MAXREQS value: At 32 outstanding reqs with 8 megs of RAM, fragment
  * reassembly will frequently run out of memory.
  */
-#define RPC_MAXCONG		16
-#define RPC_MAXREQS		(RPC_MAXCONG + 1)
-#define RPC_CWNDSCALE		256
+#define RPC_MAXCONG		(16)
+#define RPC_MAXREQS		RPC_MAXCONG
+#define RPC_CWNDSCALE		(256)
 #define RPC_MAXCWND		(RPC_MAXCONG * RPC_CWNDSCALE)
-#define RPC_INITCWND		RPC_CWNDSCALE
+#define RPC_INITCWND		(RPC_MAXCWND >> 1)
 #define RPCXPRT_CONGESTED(xprt) ((xprt)->cong >= (xprt)->cwnd)
 
 /* Default timeout values */
@@ -121,7 +121,6 @@
 
 	unsigned long		cong;		/* current congestion */
 	unsigned long		cwnd;		/* congestion window */
-	unsigned long		congtime;	/* hold cwnd until then */
 
 	struct rpc_wait_queue	sending;	/* requests waiting to send */
 	struct rpc_wait_queue	pending;	/* requests in flight */
diff -u --recursive --new-file linux-2.5.25-rpc_cong1/net/sunrpc/xprt.c linux-2.5.25-rpc_cong2/net/sunrpc/xprt.c
--- linux-2.5.25-rpc_cong1/net/sunrpc/xprt.c	Tue Jul 16 15:32:03 2002
+++ linux-2.5.25-rpc_cong2/net/sunrpc/xprt.c	Tue Jul 16 15:46:36 2002
@@ -304,30 +304,20 @@
 	 */
 	spin_lock(&xprt->xprt_lock);
 	cwnd = xprt->cwnd;
-	if (result >= 0) {
-		if (xprt->cong < cwnd || time_before(jiffies, xprt->congtime))
-			goto out;
+	if (result >= 0 && xprt->cong <= cwnd) {
 		/* The (cwnd >> 1) term makes sure
 		 * the result gets rounded properly. */
 		cwnd += (RPC_CWNDSCALE * RPC_CWNDSCALE + (cwnd >> 1)) / cwnd;
 		if (cwnd > RPC_MAXCWND)
 			cwnd = RPC_MAXCWND;
-		else
-			pprintk("RPC: %lu %ld cwnd\n", jiffies, cwnd);
-		xprt->congtime = jiffies + ((cwnd * HZ) << 2) / RPC_CWNDSCALE;
-		dprintk("RPC:      cong %08lx, cwnd was %08lx, now %08lx, "
-			"time %ld ms\n", xprt->cong, xprt->cwnd, cwnd,
-			(xprt->congtime-jiffies)*1000/HZ);
+		__xprt_lock_write_next(xprt);
 	} else if (result == -ETIMEDOUT) {
-		if ((cwnd >>= 1) < RPC_CWNDSCALE)
+		cwnd >>= 1;
+		if (cwnd < RPC_CWNDSCALE)
 			cwnd = RPC_CWNDSCALE;
-		xprt->congtime = jiffies + ((cwnd * HZ) << 3) / RPC_CWNDSCALE;
-		dprintk("RPC:      cong %ld, cwnd was %ld, now %ld, "
-			"time %ld ms\n", xprt->cong, xprt->cwnd, cwnd,
-			(xprt->congtime-jiffies)*1000/HZ);
-		pprintk("RPC: %lu %ld cwnd\n", jiffies, cwnd);
 	}
-
+	dprintk("RPC:      cong %ld, cwnd was %ld, now %ld\n",
+			xprt->cong, xprt->cwnd, cwnd);
 	xprt->cwnd = cwnd;
  out:
 	spin_unlock(&xprt->xprt_lock);
@@ -1344,7 +1334,6 @@
 		xprt->nocong = 1;
 	} else
 		xprt->cwnd = RPC_INITCWND;
-	xprt->congtime = jiffies;
 	spin_lock_init(&xprt->sock_lock);
 	spin_lock_init(&xprt->xprt_lock);
 	init_waitqueue_head(&xprt->cong_wait);
