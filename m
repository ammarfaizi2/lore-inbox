Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTBGMVt>; Fri, 7 Feb 2003 07:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTBGMVt>; Fri, 7 Feb 2003 07:21:49 -0500
Received: from unthought.net ([212.97.129.24]:18392 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262201AbTBGMVr>;
	Fri, 7 Feb 2003 07:21:47 -0500
Date: Fri, 7 Feb 2003 13:31:23 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Race in RPC code
Message-ID: <20030207123123.GA25807@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@fys.uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hello all,

I think there is a race in the RPC code in 2.4.20, related to timeout
and congestion window handling.

The problem code is in net/sunrpc/xprt.c:

static void
xprt_timer(struct rpc_task *task)
{       
        struct rpc_rqst *req = task->tk_rqstp;
        struct rpc_xprt *xprt = req->rq_xprt;

        spin_lock(&xprt->sock_lock);
        if (req->rq_received)
                goto out;

        if (!xprt->nocong) {
                if (xprt_expbackoff(task, req)) {
                        rpc_add_timer(task, xprt_timer);
                        goto out_unlock;
                }
                rpc_inc_timeo(&task->tk_client->cl_rtt);
                xprt_adjust_cwnd(req->rq_xprt, -ETIMEDOUT);
        }
        req->rq_nresend++;

The call to xprt_adjust_cwnd is the problem - I experienced a panic
(null pointer dereference) in 

static void
xprt_adjust_cwnd(struct rpc_xprt *xprt, int result)
{
        unsigned long   cwnd;

        cwnd = xprt->cwnd;
        if (result >= 0 && cwnd <= xprt->cong) {

Here it is the "cwnd = xprt->cwnd" that causes the panic. xprt was 0.

This means, in the xprt_timer code, that req->rq_xprt must have been 0.

I guess this can happen because of the sequence:

 xprt = req->rq_xprt;
 spin_lock(&xprt->sock_lock);
...
 xprt_adjust_cwnd(req->rq_xprt);

We don't know whether req has been modified between the assignment and
the spin_lock.

Attached is a patch to solve the problem - please comment.

It does not solve the other potential (?) problem with:

 xprt = req->rq_xprt;
 spin_lock(&xprt->sock_lock);
 ...
                if (xprt_expbackoff(task, req)) {
 ...

Any suggestions to that one?

I cannot test whether my patch solve the problem, because this panic has
happened once on a *heavily* loaded box which has run 2.4.20 ever since
it came out.  The race is extremely rare.  It is an SMP box by the way.

Thanks a lot to "baldrick" on kernel-newbies for the help!

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=race-diff

--- linux-2.4.20-unpatched/net/sunrpc/xprt.c	Fri Feb  7 12:22:19 2003
+++ linux-2.4.20/net/sunrpc/xprt.c	Fri Feb  7 13:13:40 2003
@@ -1021,7 +1021,7 @@
 			goto out_unlock;
 		}
 		rpc_inc_timeo(&task->tk_client->cl_rtt);
-		xprt_adjust_cwnd(req->rq_xprt, -ETIMEDOUT);
+		xprt_adjust_cwnd(xprt, -ETIMEDOUT);
 	}
 	req->rq_nresend++;
 

--aM3YZ0Iwxop3KEKx--
