Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSJCWpl>; Thu, 3 Oct 2002 18:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbSJCWpG>; Thu, 3 Oct 2002 18:45:06 -0400
Received: from pat.uio.no ([129.240.130.16]:42479 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261413AbSJCWow>;
	Thu, 3 Oct 2002 18:44:52 -0400
To: Andreas Pfaller <apfaller@yahoo.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.20-pre8-ac3: NFS performance regression
References: <200210032024.47664.apfaller@yahoo.com.au>
	<1033683184.28814.35.camel@irongate.swansea.linux.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Oct 2002 00:50:04 +0200
In-Reply-To: <1033683184.28814.35.camel@irongate.swansea.linux.org.uk>
Message-ID: <shsu1k316jn.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > On Thu, 2002-10-03 at 19:32, Andreas Pfaller wrote:
    >> However I noticed a significant NFS performance drop with
    >> 2.4.20-pre8-ac3. Other network throughput is not affected.

     > I see this with all recent 2.4.20pre and 2.4.20pre-ac
     > kernels. I've not had time to retest with Trond's fixes to
     > recheck it all

FYI, here is the 'fix' Alan is talking about. It could be worth
trying...

Cheers,
  Trond

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


