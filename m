Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270440AbTGPIdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270427AbTGPIch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:32:37 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:25515 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S270420AbTGPI3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:29:51 -0400
Date: Wed, 16 Jul 2003 01:44:26 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow unattended nfs3/krb5 mounts
Message-ID: <20030716014426.A9725@google.com>
References: <20030715232605.A9418@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030715232605.A9418@google.com>; from fcusack@fcusack.com on Tue, Jul 15, 2003 at 11:26:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 11:26:05PM -0700, Frank Cusack wrote:
> - This doesn't actually work as-is.  A separate patch is needed for
>   rpc_setbufsize() which I will provide separately, after getting
>   feedback for this patch.

Since I don't expect a known-broken patch to be applied ... here's
the bufsize patch.

	- fix null dereference on xprt->inet if !connected,
	  which happens if a rpc cred wasn't available (root+auth_gss case)
	- set bufsize on reconnect

diff -uNrp linux-2.6.0-test1.2/net/sunrpc/clnt.c linux-2.6.0-test1.3/net/sunrpc/clnt.c
--- linux-2.6.0-test1.2/net/sunrpc/clnt.c	Tue Jul 15 23:29:15 2003
+++ linux-2.6.0-test1.3/net/sunrpc/clnt.c	Wed Jul 16 00:02:31 2003
@@ -385,7 +385,8 @@ rpc_setbufsize(struct rpc_clnt *clnt, un
 	xprt->rcvsize = 0;
 	if (rcvsize)
 		xprt->rcvsize = rcvsize + RPC_SLACK_SPACE;
-	xprt_sock_setbufsize(xprt);
+	if (xprt_connected(xprt))
+		xprt_sock_setbufsize(xprt);
 }
 
 /*
diff -uNrp linux-2.6.0-test1.2/net/sunrpc/xprt.c linux-2.6.0-test1.3/net/sunrpc/xprt.c
--- linux-2.6.0-test1.2/net/sunrpc/xprt.c	Tue Jul 15 23:29:15 2003
+++ linux-2.6.0-test1.3/net/sunrpc/xprt.c	Wed Jul 16 00:02:37 2003
@@ -436,6 +436,7 @@ xprt_connect(struct rpc_task *task)
 		goto out_write;
 	}
 	xprt_bind_socket(xprt, sock);
+	xprt_sock_setbufsize(xprt);
 
 	if (!xprt->stream)
 		goto out_write;
