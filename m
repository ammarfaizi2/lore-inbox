Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSGWUbj>; Tue, 23 Jul 2002 16:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSGWUbi>; Tue, 23 Jul 2002 16:31:38 -0400
Received: from pat.uio.no ([129.240.130.16]:51885 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318249AbSGWUbh>;
	Tue, 23 Jul 2002 16:31:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15677.48609.62376.119269@charged.uio.no>
Date: Tue, 23 Jul 2002 22:34:41 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 fix potential spinlocking race.
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In case of socket transmission errors etc. kfree_skb(), and hence
xprt_write_space() can potentially get called outside of a bh-safe
context.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.27/net/sunrpc/xprt.c linux-2.5.27-fix_wspace/net/sunrpc/xprt.c
--- linux-2.5.27/net/sunrpc/xprt.c	Sat Jul 20 21:11:08 2002
+++ linux-2.5.27-fix_wspace/net/sunrpc/xprt.c	Tue Jul 23 22:20:48 2002
@@ -966,10 +966,10 @@
 		return;
 
 	if (!xprt_test_and_set_wspace(xprt)) {
-		spin_lock(&xprt->sock_lock);
+		spin_lock_bh(&xprt->sock_lock);
 		if (xprt->snd_task && xprt->snd_task->tk_rpcwait == &xprt->pending)
 			rpc_wake_up_task(xprt->snd_task);
-		spin_unlock(&xprt->sock_lock);
+		spin_unlock_bh(&xprt->sock_lock);
 	}
 
 	if (test_bit(SOCK_NOSPACE, &sock->flags)) {
