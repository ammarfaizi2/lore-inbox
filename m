Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbSJHShy>; Tue, 8 Oct 2002 14:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSJHShx>; Tue, 8 Oct 2002 14:37:53 -0400
Received: from mailhub.cs.sjsu.edu ([130.65.86.58]:25237 "EHLO
	mailhub.cs.sjsu.edu") by vger.kernel.org with ESMTP
	id <S261447AbSJHShu>; Tue, 8 Oct 2002 14:37:50 -0400
Date: Tue, 8 Oct 2002 11:42:10 -0700 (PDT)
From: Juan Gomez <gomez@cs.sjsu.edu>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: kNFS(lockd) patch linux 2.5.41
Message-ID: <Pine.GSO.4.05.10210081135300.12288-100000@eniac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Would you please review the attached patch and include in the dist?

If fixes a faulty delay experienced by lockd clients just after the grace
period and during the first request to lockd.

diff -ru linux-2.5.41/fs/lockd/svc.c linux-2.5.41-plus-delay-patch/fs/lockd/svc.c
--- linux-2.5.41/fs/lockd/svc.c	Mon Oct  7 11:24:41 2002
+++ linux-2.5.41-plus-delay-patch/fs/lockd/svc.c	Tue Oct  8 11:21:00 2002
@@ -143,8 +143,7 @@
 		 */
 		if (!nlmsvc_grace_period) {
 			timeout = nlmsvc_retry_blocked();
-		} else if (time_before(grace_period_expire, jiffies))
-			clear_grace_period();
+		} 
 
 		/*
 		 * Find a socket with data available and call its
@@ -163,6 +162,21 @@
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
+                       clear_grace_period();
+                }
+                
 		svc_process(serv, rqstp);
 
 	}

