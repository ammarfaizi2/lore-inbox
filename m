Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbTGJKAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbTGJKAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:00:51 -0400
Received: from pat.uio.no ([129.240.130.16]:45019 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S269151AbTGJKAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:00:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16141.15548.109496.967464@charged.uio.no>
Date: Thu, 10 Jul 2003 12:15:24 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: NFS client errors with 2.5.74?
In-Reply-To: <20030710060744.GA27308@mail.jlokier.co.uk>
References: <20030710054121.GB27038@mail.jlokier.co.uk>
	<20030710060744.GA27308@mail.jlokier.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:
     > - Every so often, the client's kernel log gets:
     >       kernel: nfs: server 192.168.1.1 not responding, timed out

Sigh... I hate soft mounts...  Have I said that before? 8-)

     > Any idea about this?  Is it a known problem?

I can never guarantee you perfect service with soft mounts (a 5 second
network patition/server congestion is all it takes) but I do have a
patch that just went into 2.4.22 that backs out some of the
Van Jacobson exponential backoff changes. This helps stabilize things
a lot.

I haven't yet had time to port that patch to 2.5.x, but the code
should be pretty much identical, so if you want to give it a go, then
here it is...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.21-20-rdplus/net/sunrpc/clnt.c linux-2.4.21-21-soft/net/sunrpc/clnt.c
--- linux-2.4.21-20-rdplus/net/sunrpc/clnt.c	2003-06-15 14:49:35.000000000 -0700
+++ linux-2.4.21-21-soft/net/sunrpc/clnt.c	2003-06-17 10:38:56.000000000 -0700
@@ -709,14 +709,14 @@
 
 	dprintk("RPC: %4d call_timeout (major)\n", task->tk_pid);
 	if (clnt->cl_softrtry) {
-		if (clnt->cl_chatty && !task->tk_exit)
+		if (clnt->cl_chatty)
 			printk(KERN_NOTICE "%s: server %s not responding, timed out\n",
 				clnt->cl_protname, clnt->cl_server);
 		rpc_exit(task, -EIO);
 		return;
 	}
 
-	if (clnt->cl_chatty && !(task->tk_flags & RPC_CALL_MAJORSEEN) && rpc_ntimeo(&clnt->cl_rtt) > 7) {
+	if (clnt->cl_chatty && !(task->tk_flags & RPC_CALL_MAJORSEEN)) {
 		task->tk_flags |= RPC_CALL_MAJORSEEN;
 		printk(KERN_NOTICE "%s: server %s not responding, still trying\n",
 			clnt->cl_protname, clnt->cl_server);
diff -u --recursive --new-file linux-2.4.21-20-rdplus/net/sunrpc/xprt.c linux-2.4.21-21-soft/net/sunrpc/xprt.c
--- linux-2.4.21-20-rdplus/net/sunrpc/xprt.c	2003-06-15 15:14:14.000000000 -0700
+++ linux-2.4.21-21-soft/net/sunrpc/xprt.c	2003-06-17 09:48:18.000000000 -0700
@@ -1046,21 +1046,6 @@
 }
 
 /*
- * Exponential backoff for UDP retries
- */
-static inline int
-xprt_expbackoff(struct rpc_task *task, struct rpc_rqst *req)
-{
-	int backoff;
-
-	req->rq_ntimeo++;
-	backoff = min(rpc_ntimeo(&task->tk_client->cl_rtt), XPRT_MAX_BACKOFF);
-	if (req->rq_ntimeo < (1 << backoff))
-		return 1;
-	return 0;
-}
-
-/*
  * RPC receive timeout handler.
  */
 static void
@@ -1073,14 +1058,7 @@
 	if (req->rq_received)
 		goto out;
 
-	if (!xprt->nocong) {
-		if (xprt_expbackoff(task, req)) {
-			rpc_add_timer(task, xprt_timer);
-			goto out_unlock;
-		}
-		rpc_inc_timeo(&task->tk_client->cl_rtt);
-		xprt_adjust_cwnd(req->rq_xprt, -ETIMEDOUT);
-	}
+	xprt_adjust_cwnd(req->rq_xprt, -ETIMEDOUT);
 	req->rq_nresend++;
 
 	dprintk("RPC: %4d xprt_timer (%s request)\n",
@@ -1090,7 +1068,6 @@
 out:
 	task->tk_timeout = 0;
 	rpc_wake_up_task(task);
-out_unlock:
 	spin_unlock(&xprt->sock_lock);
 }
 
@@ -1228,16 +1205,17 @@
 	return;
  out_receive:
 	dprintk("RPC: %4d xmit complete\n", task->tk_pid);
+	spin_lock_bh(&xprt->sock_lock);
 	/* Set the task's receive timeout value */
 	if (!xprt->nocong) {
 		task->tk_timeout = rpc_calc_rto(&clnt->cl_rtt,
 				rpcproc_timer(clnt, task->tk_msg.rpc_proc));
-		req->rq_ntimeo = 0;
+		task->tk_timeout <<= clnt->cl_timeout.to_retries
+			- req->rq_timeout.to_retries;
 		if (task->tk_timeout > req->rq_timeout.to_maxval)
 			task->tk_timeout = req->rq_timeout.to_maxval;
 	} else
 		task->tk_timeout = req->rq_timeout.to_current;
-	spin_lock_bh(&xprt->sock_lock);
 	/* Don't race with disconnect */
 	if (!xprt_connected(xprt))
 		task->tk_status = -ENOTCONN;
