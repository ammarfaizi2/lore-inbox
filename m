Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268919AbTBZUXD>; Wed, 26 Feb 2003 15:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268921AbTBZUXD>; Wed, 26 Feb 2003 15:23:03 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:17811 "EHLO
	dyn9-47-17-83.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id <S268919AbTBZUXB>; Wed, 26 Feb 2003 15:23:01 -0500
Message-ID: <3E5D1EF2.1BC379DD@us.ibm.com>
Date: Wed, 26 Feb 2003 12:09:22 -0800
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: maneesh@in.ibm.com, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, bruce.allan@us.ibm.com
Subject: Re: 2.5.62 Oops during nfs mount
References: <3E56E58D.6B047A23@us.ibm.com>
		<20030224123622.GB1103@in.ibm.com> <15962.20933.457919.169668@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> >>>>> " " == Maneesh Soni <maneesh@in.ibm.com> writes:
>
>      > Following patch should fix this problem. I think Trond can say
>      > whether it is correct or not. In my opinion rpc_rmdir should
>      > test for negative dentry after lookup_hash() returns, like
>      > rpc_unlink() does.
>
> No. You are 'fixing' a symptom of a more fundamental
> bug/misunderstanding: lookup_path("") returns no error, and is
> sometimes causing us to remove the top level directory.
> See the 2-line patch I posted yesterday. It should fix the Oops you
> are reporting.

Thanks Trond, your patch below indeed fixed the Oops I reported:

--- linux-2.5.61-up/net/sunrpc/clnt.c.orig      2003-02-15
21:05:02.000000000 +0100
+++ linux-2.5.61-up/net/sunrpc/clnt.c   2003-02-17 19:39:20.000000000
+0100
@@ -208,7 +208,8 @@
                rpcauth_destroy(clnt->cl_auth);
                clnt->cl_auth = NULL;
        }
-       rpc_rmdir(clnt->cl_pathname);
+       if (clnt->cl_pathname[0])
+               rpc_rmdir(clnt->cl_pathname);
        if (clnt->cl_xprt) {
                xprt_destroy(clnt->cl_xprt);
                clnt->cl_xprt = NULL;

