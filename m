Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319673AbSH3WSd>; Fri, 30 Aug 2002 18:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319676AbSH3WSd>; Fri, 30 Aug 2002 18:18:33 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:3200 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S319673AbSH3WSM>; Fri, 30 Aug 2002 18:18:12 -0400
Date: Fri, 30 Aug 2002 18:22:31 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] prevent oops in xprt_lock_write, against 2.4.20
Message-ID: <Pine.LNX.4.44.0208301817150.1653-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo-

when several RPC requests want to reconnect a TCP transport socket at
once, xprt_lock_write serializes the tasks to prevent multiple socket
connects.  however, TCP connects are always done by a RPC child task that
has no request slot.  xprt_lock_write can oops if there is no request slot
allocated to the invoking RPC task.  reviewed and accepted by Trond.

i had thought the 2.5.32 patch wouldn't apply to 2.4.20, but Trond pointed
out to me that his xprt_lock_write patches snuck into 2.4.20-pre5, which i
hadn't noticed.


--- 2.4.20-pre5/net/sunrpc/xprt.c.orig	Fri Aug 30 15:49:28 2002
+++ 2.4.20-pre5/net/sunrpc/xprt.c	Fri Aug 30 18:16:17 2002
@@ -147,5 +147,5 @@
 		task->tk_timeout = 0;
 		task->tk_status = -EAGAIN;
-		if (task->tk_rqstp->rq_nresend)
+		if (task->tk_rqstp && task->tk_rqstp->rq_nresend)
 			rpc_sleep_on(&xprt->resend, task, NULL, NULL);
 		else

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>


