Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319634AbSH3SJZ>; Fri, 30 Aug 2002 14:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319638AbSH3SJZ>; Fri, 30 Aug 2002 14:09:25 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:896 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S319634AbSH3SJY>; Fri, 30 Aug 2002 14:09:24 -0400
Date: Fri, 30 Aug 2002 14:13:47 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] prevent oops in xprt_lock_write, against 2.5.32
Message-ID: <Pine.LNX.4.44.0208301408060.7274-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi linus-

when several RPC requests want to reconnect a TCP transport socket at
once, xprt_lock_write serializes the tasks to prevent multiple socket
connects.  however, TCP connects are always done by a RPC child task that
has no request slot.  xprt_lock_write can oops if there is no request slot
allocated to the invoking RPC task.  reviewed and accepted by Trond.

the xprt_lock_write changes are not yet in 2.4, so this patch does not 
apply to 2.4.

diff -drN -U2 00-stock/net/sunrpc/xprt.c 01-lock_write/net/sunrpc/xprt.c
--- 00-stock/net/sunrpc/xprt.c	Tue Aug 27 15:26:35 2002
+++ 01-lock_write/net/sunrpc/xprt.c	Thu Aug 29 10:10:00 2002
@@ -148,5 +148,5 @@
 		task->tk_timeout = 0;
 		task->tk_status = -EAGAIN;
-		if (task->tk_rqstp->rq_nresend)
+		if (task->tk_rqstp && task->tk_rqstp->rq_nresend)
 			rpc_sleep_on(&xprt->resend, task, NULL, NULL);
 		else

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

