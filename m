Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbTASXPo>; Sun, 19 Jan 2003 18:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267715AbTASXPo>; Sun, 19 Jan 2003 18:15:44 -0500
Received: from pat.uio.no ([129.240.130.16]:18173 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267714AbTASXPn>;
	Sun, 19 Jan 2003 18:15:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15915.13242.291976.585239@charged.uio.no>
Date: Mon, 20 Jan 2003 00:24:42 +0100
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with nfs-server in 2.5 bk as of 030115
In-Reply-To: <1043016608.727.0.camel@tux.rsn.bth.se>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
	<15915.8496.899499.957528@charged.uio.no>
	<1043016608.727.0.camel@tux.rsn.bth.se>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:

     > On Sun, 2003-01-19 at 23:05, Trond Myklebust wrote:
    >> Could you apply the following patch, so that I can see what the
    >> actual returned error is?

     > RPC: Couldn't create pipefs entry /portmap/clnteb11b574, error
     > -17 RPC: Couldn't create pipefs entry /portmap/clnteb11b574,
     > error -17 RPC: Couldn't create pipefs entry
     > /portmap/clnteb11b574, error -17

OK. That's what I thought it might be...

Looks like rmdir() is failing, so that when 'clnt' gets reused, then
a directory with the old pathname still exists so mkdir() fails...

Could you try applying the following extra patch, just in order to
confirm that this is indeed the case (and to trace what the eventual
rmdir() error might be)?

Cheers,
  Trond

--- linux-2.5.59-00-fix/net/sunrpc/clnt.c.orig	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.59-00-fix/net/sunrpc/clnt.c	2003-01-20 00:19:15.000000000 +0100
@@ -135,7 +135,12 @@
 	printk(KERN_INFO "RPC: out of memory in rpc_create_client\n");
 	goto out;
 out_no_auth:
-	rpc_rmdir(clnt->cl_pathname);
+	{
+		int error = rpc_rmdir(clnt->cl_pathname);
+		if (error)
+			printk(KERN_INFO "%s: rpc_rmdir(%s) failed with error %d\n",
+					__FUNCTION__, clnt->cl_pathname, error)
+	}
 out_no_path:
 	kfree(clnt);
 	clnt = NULL;
@@ -188,7 +193,12 @@
 		rpcauth_destroy(clnt->cl_auth);
 		clnt->cl_auth = NULL;
 	}
-	rpc_rmdir(clnt->cl_pathname);
+	{
+		int error = rpc_rmdir(clnt->cl_pathname);
+		if (error)
+			printk(KERN_INFO "%s: rpc_rmdir(%s) failed with error %d\n",
+					__FUNCTION__, clnt->cl_pathname, error)
+	}
 	if (clnt->cl_xprt) {
 		xprt_destroy(clnt->cl_xprt);
 		clnt->cl_xprt = NULL;
