Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261465AbSJHUyd>; Tue, 8 Oct 2002 16:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263811AbSJHUyd>; Tue, 8 Oct 2002 16:54:33 -0400
Received: from mailhub.cs.sjsu.edu ([130.65.86.58]:32150 "EHLO
	mailhub.cs.sjsu.edu") by vger.kernel.org with ESMTP
	id <S261465AbSJHUya>; Tue, 8 Oct 2002 16:54:30 -0400
Date: Tue, 8 Oct 2002 13:59:01 -0700 (PDT)
From: Juan Gomez <gomez@cs.sjsu.edu>
To: marcelo@conectiva.com.br
cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: kNFS(lockd) patch for linux-2.4.19
Message-ID: <Pine.GSO.4.05.10210081342240.16984-100000@eniac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

Would you please consider the attached patch for inclusion in 2.4..*?
The patch solves a faulty delay observed by the first client that access
lockd just after the grace period.

Juan
diff -ru linux-2.4.19/fs/lockd/svc.c linux-2.4.19-plus-delay-patch/fs/lockd/svc.c
--- linux-2.4.19/fs/lockd/svc.c	Sun Oct 21 10:32:33 2001
+++ linux-2.4.19-plus-delay-patch/fs/lockd/svc.c	Tue Oct  8 13:19:40 2002
@@ -144,8 +144,7 @@
 		 */
 		if (!nlmsvc_grace_period) {
 			timeout = nlmsvc_retry_blocked();
-		} else if (time_before(grace_period_expire, jiffies))
-			clear_grace_period();
+		} 
 
 		/*
 		 * Find a socket with data available and call its
@@ -163,6 +162,22 @@
 
 		dprintk("lockd: request from %08x\n",
 			(unsigned)ntohl(rqstp->rq_addr.sin_addr.s_addr));
+                /* 
+                 * We need to do the clear/grace period here and not before 
+                 * svc_recv() because svc_recv() may sleep longer than the 
+                 * grace period and the first request may be falsely processed
+                 * as if the server was in the grace period when it was not 
+                 * causing unnecessary delays for the first request received.
+                 * Juan C. Gomez j_carlos_gome@yahoo.com
+                 */
+                
+                if (nlmsvc_grace_period 
+                    &&
+                    time_before(grace_period_expire, jiffies)) {
+                         clear_grace_period();
+                }
+                  
+
 
 		/*
 		 * Look up the NFS client handle. The handle is needed for

