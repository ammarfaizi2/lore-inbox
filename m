Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSGTUTu>; Sat, 20 Jul 2002 16:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317491AbSGTUTI>; Sat, 20 Jul 2002 16:19:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40692 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317493AbSGTUTB>; Sat, 20 Jul 2002 16:19:01 -0400
Subject: [PATCH] lockd and rpciod do not correctly drop locks
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 13:22:05 -0700
Message-Id: <1027196525.1086.771.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, 

lockd and rpciod exit without properly relinquishing the locks they
hold.  This pisses off the preempt_count debugging in do_exit.

While in this case it is safe since the lock is the BKL, it is unclean
in my opinion.

I also hate seeing the debug message on unmount ;)

Patch is against 2.5.27, please apply.

        Robert Love

diff -urN linux-2.5.27/fs/lockd/svc.c linux/fs/lockd/svc.c
--- linux-2.5.27/fs/lockd/svc.c	Sat Jul 20 12:11:25 2002
+++ linux/fs/lockd/svc.c	Sat Jul 20 12:52:21 2002
@@ -203,6 +203,7 @@
 	rpciod_down();
 
 	/* Release module */
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 }
 
diff -urN linux-2.5.27/net/sunrpc/sched.c linux/net/sunrpc/sched.c
--- linux-2.5.27/net/sunrpc/sched.c	Sat Jul 20 12:11:22 2002
+++ linux/net/sunrpc/sched.c	Sat Jul 20 12:52:21 2002
@@ -1030,6 +1030,7 @@
 	wake_up(assassin);
 
 	dprintk("RPC: rpciod exiting\n");
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }

