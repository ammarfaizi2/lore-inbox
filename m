Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137081AbREKI7A>; Fri, 11 May 2001 04:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137082AbREKI6u>; Fri, 11 May 2001 04:58:50 -0400
Received: from pat.uio.no ([129.240.130.16]:45238 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S137081AbREKI6i>;
	Fri, 11 May 2001 04:58:38 -0400
MIME-Version: 1.0
Message-ID: <15099.43446.132871.699151@charged.uio.no>
Date: Fri, 11 May 2001 10:58:30 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.4 linearize UDP RPC requests using GFP_KERNEL...
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

  The zero-copy TCP patch that was integrated in 2.4.4 has allowed us
to move the task of reassembling of the fragments into one buffer
until we're out of the ->data_ready() bottom half context.
  In 2.4.4 therefore, the nfsd thread can end up calling the function
skb_linearize(), in order to allocate a new buffer and copy over the
fragments.

  IMHO allocating the buffer using GFP_ATOMIC is a mistake. As I said
we're in a thread context, so sleeping in GFP_KERNEL is safe. In
addition, the cost of dropping the request if we can't allocate the
buffer is heavy in that the client has to wait for a timeout, and then
retry.

I'd therefore like to propose the following change.

Cheers,
  Trond

--- linux-2.4.4/net/sunrpc/svcsock.c.orig	Fri Apr 27 23:15:01 2001
+++ linux-2.4.4/net/sunrpc/svcsock.c	Fri May 11 10:08:36 2001
@@ -383,7 +383,7 @@
 
 	/* Sorry. */
 	if (skb_is_nonlinear(skb)) {
-		if (skb_linearize(skb, GFP_ATOMIC) != 0) {
+		if (skb_linearize(skb, GFP_KERNEL) != 0) {
 			kfree_skb(skb);
 			svc_sock_received(svsk, 0);
 			return 0;

