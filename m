Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSJOQFC>; Tue, 15 Oct 2002 12:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSJOQFC>; Tue, 15 Oct 2002 12:05:02 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:33461 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263837AbSJOQFA>;
	Tue, 15 Oct 2002 12:05:00 -0400
Subject: kNFS(lockd) patch for linux-2.4.19
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.1 (Intl) 16 July 1999
Message-ID: <OF12A74DE8.11CDD1B1-ON87256C53.0058AEE0@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Tue, 15 Oct 2002 09:10:34 -0700
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/15/2002 10:10:39
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

Have you had a chance to include this?

Juan

----- Forwarded by Juan Gomez/Almaden/IBM on 10/15/02 09:11 AM -----
                                                                                                                                             
                      Juan Gomez                                                                                                             
                      <gomez@cs.sjsu.edu>            To:       marcelo@conectiva.com.br                                                      
                      Sent by:                       cc:       trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org                      
                      linux-kernel-owner@vger        Subject:  kNFS(lockd) patch for linux-2.4.19                                            
                      .kernel.org                                                                                                            
                                                                                                                                             
                                                                                                                                             
                      10/08/02 01:59 PM                                                                                                      
                                                                                                                                             
                                                                                                                                             




Marcelo,

Would you please consider the attached patch for inclusion in 2.4..*?
The patch solves a faulty delay observed by the first client that access
lockd just after the grace period.

Juan
diff -ru linux-2.4.19/fs/lockd/svc.c
linux-2.4.19-plus-delay-patch/fs/lockd/svc.c
--- linux-2.4.19/fs/lockd/svc.c            Sun Oct 21 10:32:33 2001
+++ linux-2.4.19-plus-delay-patch/fs/lockd/svc.c             Tue Oct  8
13:19:40 2002
@@ -144,8 +144,7 @@
                          */
                         if (!nlmsvc_grace_period) {
                                     timeout = nlmsvc_retry_blocked();
-                        } else if (time_before(grace_period_expire,
jiffies))
-                                    clear_grace_period();
+                        }

                         /*
                          * Find a socket with data available and call its
@@ -163,6 +162,22 @@

                         dprintk("lockd: request from %08x\n",

(unsigned)ntohl(rqstp->rq_addr.sin_addr.s_addr));
+                /*
+                 * We need to do the clear/grace period here and not
before
+                 * svc_recv() because svc_recv() may sleep longer than the

+                 * grace period and the first request may be falsely
processed
+                 * as if the server was in the grace period when it was
not
+                 * causing unnecessary delays for the first request
received.
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
                          * Look up the NFS client handle. The handle is
needed for

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



