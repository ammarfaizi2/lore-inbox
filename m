Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSHZUCL>; Mon, 26 Aug 2002 16:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSHZUCK>; Mon, 26 Aug 2002 16:02:10 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:11525
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318208AbSHZUCE>; Mon, 26 Aug 2002 16:02:04 -0400
Subject: [PATCH] make lockd and rpciod drop locks on exit
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 16:06:20 -0400
Message-Id: <1030392380.861.420.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Neither lockd nor rpciod properly drop the BKL on exit.

Yes, the BKL is automatically relinquished on schedule but the failure
to drop the lock throws off the atomic accounting.

This makes them play fair.  Please, apply.

	Robert Love

diff -urN linux-2.5.31/fs/lockd/svc.c linux/fs/lockd/svc.c
--- linux-2.5.31/fs/lockd/svc.c	Sat Aug 10 21:41:42 2002
+++ linux/fs/lockd/svc.c	Sat Aug 24 20:18:08 2002
@@ -203,6 +203,7 @@
 	rpciod_down();
 
 	/* Release module */
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 }
 
diff -urN linux-2.5.31/net/sunrpc/sched.c linux/net/sunrpc/sched.c
--- linux-2.5.31/net/sunrpc/sched.c	Sat Aug 10 21:41:36 2002
+++ linux/net/sunrpc/sched.c	Sat Aug 24 20:18:08 2002
@@ -1030,6 +1030,7 @@
 	wake_up(assassin);
 
 	dprintk("RPC: rpciod exiting\n");
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }


