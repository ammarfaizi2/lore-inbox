Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbSKOQ0S>; Fri, 15 Nov 2002 11:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbSKOQ0S>; Fri, 15 Nov 2002 11:26:18 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49066 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266431AbSKOQ0N>;
	Fri, 15 Nov 2002 11:26:13 -0500
Subject: Re: Non-blocking lock requests during the grace period
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF92154664.1C5EF07E-ON87256C72.005A0481@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Fri, 15 Nov 2002 08:31:28 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|November 8, 2002) at
 11/15/2002 09:32:33
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


Trond,

I think this would fix it but the patch I have tested locally is a bit
different.

1).-Instead of

+wait_on_grace:
+                        if (!argp->block)
+                                    return -EAGAIN;

I have

+wait_on_grace:
+                        if ((proc == NLMPROC_LOCK) && !argp->block)
+                                    return -EAGAIN;

2.-I also have this part enclosed in the if(resp->status ==
NLM_LCK_DENIED_GRACE_PERIOD) as follows:

if(resp->status == NLM_LCK_DENIED_GRACE_PERIOD) {

      blah blah...

wait_on_grace:
                         if ((proc == NLMPROC_LOCK) && !argp->block)
                                     return -EAGAIN
} else {

      ....
}

This with the intention to be very specific as to when we want the return
-EAGAIN to be called.

Juan



|---------+---------------------------->
|         |           Trond Myklebust  |
|         |           <trond.myklebust@|
|         |           fys.uio.no>      |
|         |                            |
|         |           11/14/02 06:33 PM|
|         |                            |
|---------+---------------------------->
  >-------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                         |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                            |
  |       cc:       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org                                                 |
  |       Subject:  Re: Non-blocking lock requests during the grace period                                                  |
  |                                                                                                                         |
  |                                                                                                                         |
  >-------------------------------------------------------------------------------------------------------------------------|



>>>>> " " == Juan Gomez <juang@us.ibm.com> writes:

     > I found out that the current Linux client of lockd blocks
     > non-blocking lock requests while the server is in the grace
     > period.  I think this is incorrect behavior and I am wondering
     > if the will exists out there to correct this and return
     > "resource not available" to the process when a request is for a
     > *non-blocking* lock while the server is in the grace period.

Would the following fix it?

Cheers,
  Trond

--- linux-2.5.47/fs/lockd/clntproc.c.orig        2002-09-29
10:15:13.000000000 -0400
+++ linux-2.5.47/fs/lockd/clntproc.c             2002-11-14
21:32:26.000000000 -0500
@@ -256,10 +256,8 @@
                         msg.rpc_cred = NULL;

             do {
-                        if (host->h_reclaiming && !argp->reclaim) {
-
interruptible_sleep_on(&host->h_gracewait);
-                                    continue;
-                        }
+                        if (host->h_reclaiming && !argp->reclaim)
+                                    goto wait_on_grace;

                         /* If we have no RPC client yet, create one. */
                         if ((clnt = nlm_bind_host(host)) == NULL)
@@ -296,6 +294,9 @@
                                     dprintk("lockd: server returns status
%d\n", resp->status);
                                     return 0;         /* Okay, call
complete */
                         }
+wait_on_grace:
+                        if (!argp->block)
+                                    return -EAGAIN;

                         /* Back off a little and try again */
                         interruptible_sleep_on_timeout(&host->h_gracewait,
15*HZ);



