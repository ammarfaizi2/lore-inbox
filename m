Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265210AbSJPQro>; Wed, 16 Oct 2002 12:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265202AbSJPQrh>; Wed, 16 Oct 2002 12:47:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12934 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265195AbSJPQqr>; Wed, 16 Oct 2002 12:46:47 -0400
Subject: kNFS(lockd) patch linux 2.5.41
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFEF1EC5DE.D14F89EF-ON87256C54.005C30B4@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Wed, 16 Oct 2002 09:52:30 -0700
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/16/2002 10:52:31
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In an effort to avoid this patch to die before in someone's mailbox I am
bringing it back....
As requested by Linus I am forwarding this to you Neil for review/inclusion
in a soon-to-be released 2.5.* version
Trond has looked at it and has given thumbs up but I think he said he was
too busy to put it in.

I have not gotten any answer from Marcelo either to include this in 2.4.*
so I will resend that to you as well, its basically the same single line
patch...

Juan


On Tue, 15 Oct 2002, Juan Gomez wrote:
>
> Have you had the chance to look at the patch I submitted to eliminate
long
> delays in serving the first lockd request?

Nope, sorry, it's lost somewhere. Can you get Neil to look them over too,
I have a hard time judging anything that has to do with lockd..

                         Linus


----- Forwarded by Juan Gomez/Almaden/IBM on 10/16/02 09:48 AM -----
                                                                                                                                            
                      Juan Gomez                                                                                                            
                      <gomez@cs.sjsu.edu>            To:       torvalds@transmeta.com                                                       
                      Sent by:                       cc:       linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no                     
                      linux-kernel-owner@vger        Subject:  kNFS(lockd) patch linux 2.5.41                                               
                      .kernel.org                                                                                                           
                                                                                                                                            
                                                                                                                                            
                      10/08/02 11:42 AM                                                                                                     
                                                                                                                                            
                                                                                                                                            




Linus,

Would you please review the attached patch and include in the dist?

If fixes a faulty delay experienced by lockd clients just after the grace
period and during the first request to lockd.

diff -ru linux-2.5.41/fs/lockd/svc.c
linux-2.5.41-plus-delay-patch/fs/lockd/svc.c
--- linux-2.5.41/fs/lockd/svc.c            Mon Oct  7 11:24:41 2002
+++ linux-2.5.41-plus-delay-patch/fs/lockd/svc.c             Tue Oct  8
11:21:00 2002
@@ -143,8 +143,7 @@
                          */
                         if (!nlmsvc_grace_period) {
                                     timeout = nlmsvc_retry_blocked();
-                        } else if (time_before(grace_period_expire,
jiffies))
-                                    clear_grace_period();
+                        }

                         /*
                          * Find a socket with data available and call its
@@ -163,6 +162,21 @@
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
+                       clear_grace_period();
+                }
+
                         svc_process(serv, rqstp);

             }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



