Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbTBQOcO>; Mon, 17 Feb 2003 09:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbTBQObF>; Mon, 17 Feb 2003 09:31:05 -0500
Received: from mons.uio.no ([129.240.130.14]:11722 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267126AbTBQOaL>;
	Mon, 17 Feb 2003 09:30:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15952.62528.98171.183442@charged.uio.no>
Date: Mon, 17 Feb 2003 15:40:00 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Race in svcsock.c in 2.5.61
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Neil,

knfsd needs to disable soft interrupts when calling
csum_partial_copy_to_xdr().

At the moment there's a nasty conflict between the RPC server and
client. The problem arises when you get to xdr_partial_copy_from_skb()
(and the kmap_atomic()); the RPC client can end up calling the same
function from a ->data_ready() soft interrupt, and corrupt any data
the knfsd process may have copied.

Cheers,
  Trond

--- linux-2.5.61-up/net/sunrpc/svcsock.c.orig	2003-01-11 02:00:08.000000000 +0100
+++ linux-2.5.61-up/net/sunrpc/svcsock.c	2003-02-17 15:04:07.000000000 +0100
@@ -577,12 +577,15 @@
 
 	if (skb_is_nonlinear(skb)) {
 		/* we have to copy */
+		local_bh_disable();
 		if (csum_partial_copy_to_xdr(&rqstp->rq_arg, skb)) {
+			local_bh_enable();
 			/* checksum error */
 			skb_free_datagram(svsk->sk_sk, skb);
 			svc_sock_received(svsk);
 			return 0;
 		}
+		local_bh_enable();
 		skb_free_datagram(svsk->sk_sk, skb); 
 	} else {
 		/* we can use it in-place */
