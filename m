Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbTASUvT>; Sun, 19 Jan 2003 15:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTASUvT>; Sun, 19 Jan 2003 15:51:19 -0500
Received: from pat.uio.no ([129.240.130.16]:49393 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267042AbTASUvQ>;
	Sun, 19 Jan 2003 15:51:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15915.4574.380686.123067@charged.uio.no>
Date: Sun, 19 Jan 2003 22:00:14 +0100
To: Nix <nix@esperi.demon.co.uk>
Cc: ultralinux@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: strange sparc64 -> i586 intermittent but reproducible NFS write errors to one and only one fs
In-Reply-To: <87iswkx53u.fsf@amaterasu.srvr.nix>
References: <87bs2q3paq.fsf@amaterasu.srvr.nix>
	<200301100658.h0A6vxs14580@Port.imtp.ilyichevsk.odessa.ua>
	<87iswkx53u.fsf@amaterasu.srvr.nix>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == nix  <nix@esperi.demon.co.uk> writes:


     > Anyway, the problem appears in 2.4.20-pre10; I suspect

     > Trond Myklebust <trond.myklebust@fys.uio.no>:
     > o Workaround NFS hangs introduced in 2.4.20-pre

     > (so Cc:ed)

     > Does anyone have a pointer to this patch so I can try reversing
     > it from 2.4.20pre10? (I can't see it on l-k, but since I don't
     > know what it looks like it's hard to find it in the archives; I
     > don't have bitkeeper on this machine, and can't, as one of my
     > current projects involves version-control filesystems).

It sounds rather strange that this particular patch should introduce
an EIO, but here it is (fresh from BitKeeper)

Cheers,
  Trond

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.717.1.6 -> 1.717.1.7
#	   net/sunrpc/xprt.c	1.30    -> 1.31   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/07	trond.myklebust@fys.uio.no	1.717.1.7
# [PATCH] Workaround NFS hangs introduced in 2.4.20-pre
# 
# Alan,
# 
# Does the following patch make any difference to the hangs?
# 
# It reverts one effect of my changes, and ensures that requests get resent
# immediately after the timeout, even if doing so would violate the current
# congestion window size.
# Doing this ensures that we keep probing the `connection' to the server
# rather than just waiting for the entire window to time out. The latter
# can be very expensive due to the exponential backoff rule...
# 
# Cheers,
#   Trond
# --------------------------------------------
#
diff -Nru a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
--- a/net/sunrpc/xprt.c	Sun Jan 19 21:56:20 2003
+++ b/net/sunrpc/xprt.c	Sun Jan 19 21:56:20 2003
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
