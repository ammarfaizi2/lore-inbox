Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTKIWEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 17:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTKIWEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 17:04:13 -0500
Received: from pat.uio.no ([129.240.130.16]:413 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262761AbTKIWEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 17:04:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16302.47573.483168.397844@charged.uio.no>
Date: Sun, 9 Nov 2003 17:04:05 -0500
To: Voluspa <wormprotection-lista3@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS on 2.6.0-test9:
In-Reply-To: <20031109222358.78a8d403.wormprotection-lista3@comhem.se>
References: <20031103163455.57d24178.lista2@comhem.se>
	<shssml5o2lp.fsf@charged.uio.no>
	<20031109222358.78a8d403.wormprotection-lista3@comhem.se>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK. That points squarely at the RTO timeout "inheritance" change.
There are 2 differences as it stands in 2.6.0 w.r.t. the 2.4.23-pre
code: the no upper limit, and the inheritance update algorithm.

Could you therefore try the following patch.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.6.0-test9/include/linux/sunrpc/timer.h linux/include/linux/sunrpc/timer.h
--- linux-2.6.0-test9/include/linux/sunrpc/timer.h	2003-11-07 21:03:45.000000000 -0500
+++ linux/include/linux/sunrpc/timer.h	2003-11-09 16:55:43.000000000 -0500
@@ -25,9 +25,18 @@
 
 static inline void rpc_set_timeo(struct rpc_rtt *rt, int timer, int ntimeo)
 {
+	int *t;
 	if (!timer)
 		return;
-	rt->ntimeouts[timer-1] = ntimeo;
+	t = &rt->ntimeouts[timer-1];
+	if (ntimeo < *t) {
+		if (*t > 0)
+			(*t)--;
+	} else {
+		if (ntimeo > 8)
+			ntimeo = 8;
+		*t = ntimeo;
+	}
 }
 
 static inline int rpc_ntimeo(struct rpc_rtt *rt, int timer)
diff -u --recursive --new-file linux-2.6.0-test9/net/sunrpc/timer.c linux/net/sunrpc/timer.c
--- linux-2.6.0-test9/net/sunrpc/timer.c	2003-11-07 21:06:11.000000000 -0500
+++ linux/net/sunrpc/timer.c	2003-11-09 16:57:15.000000000 -0500
@@ -40,6 +40,7 @@
 		rt->srtt[i] = init;
 		rt->sdrtt[i] = RPC_RTO_INIT;
 	}
+	memset(rt->ntimeouts, 0, sizeof(rt->ntimeouts));
 }
 
 /*

