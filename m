Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbTJIQN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbTJIQN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:13:56 -0400
Received: from newsmtp.golden.net ([199.166.210.106]:1030 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S262374AbTJIQNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:13:54 -0400
Date: Thu, 9 Oct 2003 12:13:50 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] net/sunrpc/clnt.c compile fix
Message-ID: <20031009161350.GA9170@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Not sure if anyone has submitted this already, but as the subject implies,
net/sunrpc/clnt.c does not compile in either stock test7 or in current BK:

  CC      net/sunrpc/clnt.o
  net/sunrpc/clnt.c: In function `call_verify':
  net/sunrpc/clnt.c:965: structure has no member named `tk_pid'
  net/sunrpc/clnt.c:970: structure has no member named `tk_pid'
  net/sunrpc/clnt.c:976: structure has no member named `tk_pid'
  make[1]: *** [net/sunrpc/clnt.o] Error 1
  make: *** [net/sunrpc/clnt.o] Error 2

This is due to the fact that tk_pid is protected by RPC_DEBUG. Wrapping
through dprintk() fixes this.

--- linux-sh-2.6.0-test7.orig/net/sunrpc/clnt.c	Thu Oct  9 09:42:45 2003
+++ linux-sh-2.6.0-test7/net/sunrpc/clnt.c	Thu Oct  9 12:04:56 2003
@@ -961,18 +961,18 @@
 	case RPC_SUCCESS:
 		return p;
 	case RPC_PROG_UNAVAIL:
-		printk(KERN_WARNING "RPC: %4d call_verify: program %u is unsupported by server %s\n",
+		dprintk("RPC: %4d call_verify: program %u is unsupported by server %s\n",
 				task->tk_pid, (unsigned int)task->tk_client->cl_prog,
 				task->tk_client->cl_server);
 		goto out_eio;
 	case RPC_PROG_MISMATCH:
-		printk(KERN_WARNING "RPC: %4d call_verify: program %u, version %u unsupported by server %s\n",
+		dprintk("RPC: %4d call_verify: program %u, version %u unsupported by server %s\n",
 				task->tk_pid, (unsigned int)task->tk_client->cl_prog,
 				(unsigned int)task->tk_client->cl_vers,
 				task->tk_client->cl_server);
 		goto out_eio;
 	case RPC_PROC_UNAVAIL:
-		printk(KERN_WARNING "RPC: %4d call_verify: proc %p unsupported by program %u, version %u on server %s\n",
+		dprintk("RPC: %4d call_verify: proc %p unsupported by program %u, version %u on server %s\n",
 				task->tk_pid, task->tk_msg.rpc_proc,
 				task->tk_client->cl_prog,
 				task->tk_client->cl_vers,

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/hYk+1K+teJFxZ9wRAq+BAJ9crFIUx74G6xNFAUqvxCZrD9CcNACfezMX
/tubPnS03LPhliwkQ5Goiro=
=PkYC
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
