Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319235AbSH2P1h>; Thu, 29 Aug 2002 11:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319237AbSH2P1h>; Thu, 29 Aug 2002 11:27:37 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:51207
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319235AbSH2P1f>; Thu, 29 Aug 2002 11:27:35 -0400
Subject: [PATCH] have lockd and rpciod drop locks on exit
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 11:31:54 -0400
Message-Id: <1030635115.978.2553.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Neither lockd nor rpciod properly drop the BKL on exit.

Yes, the BKL is automatically relinquished on schedule but the failure
to drop the lock throws off the atomic accounting and results in a
preempt_count warning on exit.

This makes them play fair - it does not hurt.

Patch is against 2.5.32-bk.  Please, apply.

        Robert Love

diff -urN linux-2.5.32/fs/lockd/svc.c linux/fs/lockd/svc.c
--- linux-2.5.32/fs/lockd/svc.c	Tue Aug 27 15:26:51 2002
+++ linux/fs/lockd/svc.c	Wed Aug 28 17:42:50 2002
@@ -203,6 +203,7 @@
 	rpciod_down();
 
 	/* Release module */
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 }
 
diff -urN linux-2.5.32/net/sunrpc/sched.c linux/net/sunrpc/sched.c
--- linux-2.5.32/net/sunrpc/sched.c	Tue Aug 27 15:26:43 2002
+++ linux/net/sunrpc/sched.c	Wed Aug 28 17:42:50 2002
@@ -1030,6 +1030,7 @@
 	wake_up(assassin);
 
 	dprintk("RPC: rpciod exiting\n");
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }


