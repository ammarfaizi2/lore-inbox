Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbSJBTuU>; Wed, 2 Oct 2002 15:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262563AbSJBTuU>; Wed, 2 Oct 2002 15:50:20 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:3456 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S262558AbSJBTuS>; Wed, 2 Oct 2002 15:50:18 -0400
Date: Wed, 2 Oct 2002 15:55:21 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] disable Nagle's algorithm for RPC over TCP sockets
Message-ID: <Pine.LNX.4.44.0210021552540.2050-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

please apply this patch to 2.5.40.  it disables Nagle's algorithm for TCP 
sockets used by the RPC client.  other RPC implementations on TCP also 
disable Nagle.  this reduces average RPC request latency on TCP, and makes 
network trace tools work a little nicer.

trond, alexey, and davem are all OK with this patch.

diff -drN -U2 01-iip/net/sunrpc/xprt.c 02-nagle/net/sunrpc/xprt.c
--- 01-iip/net/sunrpc/xprt.c	Fri Sep 27 17:50:23 2002
+++ 02-nagle/net/sunrpc/xprt.c	Tue Oct  1 10:59:06 2002
@@ -1447,4 +1447,6 @@
 		xprt_set_connected(xprt);
 	} else {
+		struct tcp_opt *tp = tcp_sk(sk);
+		tp->nonagle = 1;	/* disable Nagle's algorithm */
 		sk->data_ready = tcp_data_ready;
 		sk->state_change = tcp_state_change;

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

