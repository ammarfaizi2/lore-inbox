Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbSIYMg0>; Wed, 25 Sep 2002 08:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbSIYMg0>; Wed, 25 Sep 2002 08:36:26 -0400
Received: from pat.uio.no ([129.240.130.16]:46772 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261966AbSIYMgZ>;
	Wed, 25 Sep 2002 08:36:25 -0400
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: RE: [BUG] NFS in 2.4.20-pre6+ stalls
Date: Wed, 25 Sep 2002 14:41:37 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_D9VZYEF1K46NR08OQJXY"
Message-Id: <200209251441.37444.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_D9VZYEF1K46NR08OQJXY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

>   Hi, all. Just noticed this with 2.4.20-pre6 (and -pre7): NFS write
> sometimes (usually) stalls for minutes at a time. This problem wasn't

Richard,
  Does the appended patch make a difference?

Cheers,
  Trond


--------------Boundary-00=_D9VZYEF1K46NR08OQJXY
Content-Type: text/plain;
  charset="us-ascii";
  name="resend.dif"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="resend.dif"

--- linux/net/sunrpc/xprt.c.orig	Fri Aug 30 20:16:17 2002
+++ linux/net/sunrpc/xprt.c	Tue Sep 24 00:08:59 2002
@@ -171,10 +171,10 @@
 
 	if (xprt->snd_task)
 		return;
-	if (!xprt->nocong && RPCXPRT_CONGESTED(xprt))
-		return;
 	task = rpc_wake_up_next(&xprt->resend);
 	if (!task) {
+		if (!xprt->nocong && RPCXPRT_CONGESTED(xprt))
+			return;
 		task = rpc_wake_up_next(&xprt->sending);
 		if (!task)
 			return;
@@ -1013,7 +1013,6 @@
 		}
 		rpc_inc_timeo(&task->tk_client->cl_rtt);
 		xprt_adjust_cwnd(req->rq_xprt, -ETIMEDOUT);
-		__xprt_put_cong(xprt, req);
 	}
 	req->rq_nresend++;
 
@@ -1150,10 +1149,7 @@
 		req->rq_bytes_sent = 0;
 	}
  out_release:
-	spin_lock_bh(&xprt->sock_lock);
-	__xprt_release_write(xprt, task);
-	__xprt_put_cong(xprt, req);
-	spin_unlock_bh(&xprt->sock_lock);
+	xprt_release_write(xprt, task);
 	return;
  out_receive:
 	dprintk("RPC: %4d xmit complete\n", task->tk_pid);



--------------Boundary-00=_D9VZYEF1K46NR08OQJXY--
