Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284876AbRLKF1g>; Tue, 11 Dec 2001 00:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284894AbRLKF1R>; Tue, 11 Dec 2001 00:27:17 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:43156 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S284876AbRLKF1L>; Tue, 11 Dec 2001 00:27:11 -0500
Date: Mon, 10 Dec 2001 21:27:05 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [uPATCH] 2.4.17-preX compile fix for RedHat gcc 3.1-0.10
Message-ID: <Pine.LNX.4.33.0112102048390.17524-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I recently upgraded to "gcc version 3.1 20011127 (Red Hat Linux Rawhide
3.1-0.10)".  It compiles the recent 2.4.17-preX kernels OK, with one small
hitch:  rpciod_tcp_dispatcher in module net/sunrpc/sunrpc.o is an
unresolved symbol.  The patch below (or an equivalent) is required for
net/sunrpc/sched.c to compile properly with this version of gcc.

The situation is that net/sunrpc/sched.c (the only caller of
rpciod_tcp_dispatcher) includes linux/sunrpc/clnt.h, which includes
linux/sunrpc/xprt.h.  linux/sunrpc/clnt.h defines rpciod_tcp_dispatcher as
extern void, while linux/sunrpc/xprt.h defines it as static inline.  
Apparently this latter definition is the intended one, and while earlier
versions of gcc chose it, the above version of gcc choses the first
definition.

Since I'm no C expert, I don't know what the correct behavior for gcc is.
So maybe this is a bug in the kernel, or maybe it is a bug in the above
version of gcc.

Cheers,
Wayne

--- linux-2.4.17-pre6/include/linux/sunrpc/clnt.h	Mon Dec 10 20:36:26 2001
+++ linux-2.4.17-pre7/include/linux/sunrpc/clnt.h	Mon Dec 10 20:50:39 2001
@@ -136,7 +136,6 @@
 	xprt_set_timeout(&clnt->cl_timeout, retr, incr);
 }
 
-extern void rpciod_tcp_dispatcher(void);
 extern void rpciod_wake_up(void);
 
 /*

