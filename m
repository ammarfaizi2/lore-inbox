Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSKOC1T>; Thu, 14 Nov 2002 21:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSKOC1S>; Thu, 14 Nov 2002 21:27:18 -0500
Received: from mons.uio.no ([129.240.130.14]:44761 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265587AbSKOC1O>;
	Thu, 14 Nov 2002 21:27:14 -0500
To: Juan Gomez <juang@us.ibm.com>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Non-blocking lock requests during the grace period
References: <OFCACC2A48.A38B3611-ON87256C71.006D0CEB@us.ibm.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 15 Nov 2002 03:33:56 +0100
In-Reply-To: <OFCACC2A48.A38B3611-ON87256C71.006D0CEB@us.ibm.com>
Message-ID: <shswunf8stn.fsf@helicity.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

--- linux-2.5.47/fs/lockd/clntproc.c.orig	2002-09-29 10:15:13.000000000 -0400
+++ linux-2.5.47/fs/lockd/clntproc.c	2002-11-14 21:32:26.000000000 -0500
@@ -256,10 +256,8 @@
 		msg.rpc_cred = NULL;
 
 	do {
-		if (host->h_reclaiming && !argp->reclaim) {
-			interruptible_sleep_on(&host->h_gracewait);
-			continue;
-		}
+		if (host->h_reclaiming && !argp->reclaim)
+			goto wait_on_grace;
 
 		/* If we have no RPC client yet, create one. */
 		if ((clnt = nlm_bind_host(host)) == NULL)
@@ -296,6 +294,9 @@
 			dprintk("lockd: server returns status %d\n", resp->status);
 			return 0;	/* Okay, call complete */
 		}
+wait_on_grace:
+		if (!argp->block)
+			return -EAGAIN;
 
 		/* Back off a little and try again */
 		interruptible_sleep_on_timeout(&host->h_gracewait, 15*HZ);
