Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbUKXX2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUKXX2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUKXX0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:26:18 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:26116
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262944AbUKXXUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:20:35 -0500
Message-Id: <200411242307.iAON7Mbn005428@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] UML - Unregister signal handlers at reboot
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Nov 2004 18:07:22 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

In most cases reboot failed on my system. After
"Restarting system.", UML exited without further messages.
I found an SIGIO being processed by sig_handler() resp.
sig_handler_common_skas(). Don't know, why this exits,
maybe the context is no longer valid at this time.
So, I changed the sequence in the reboot part of main()
to stop the timers and disable the fds before unblocking
the signals. Since this wasn't enough, I also added
set_handler(SIGXXX, SIG_IGN) calls to disable_timer() and
deactivate_all_fds().
Now reboot works fine in SKAS and it still works in TT.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/irq_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/irq_user.c	2004-11-24 12:29:17.000000000 -0500
+++ 2.6.9/arch/um/kernel/irq_user.c	2004-11-24 12:29:36.000000000 -0500
@@ -377,6 +377,8 @@
 		if(err)
 			return(err);
 	}
+	/* If there is a signal already queued, after unblocking ignore it */
+	set_handler(SIGIO, SIG_IGN, 0, -1);
 
 	return(0);
 }
Index: 2.6.9/arch/um/kernel/main.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/main.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/main.c	2004-11-24 12:29:36.000000000 -0500
@@ -155,18 +155,20 @@
 		int err;
 
 		printf("\n");
-
-		/* Let any pending signals fire, then disable them.  This
-		 * ensures that they won't be delivered after the exec, when
-		 * they are definitely not expected.
-		 */
-		unblock_signals();
+		/* stop timers and set SIG*ALRM to be ignored */
 		disable_timer();
+		/* disable SIGIO for the fds and set SIGIO to be ignored */
 		err = deactivate_all_fds();
 		if(err)
 			printf("deactivate_all_fds failed, errno = %d\n",
 			       -err);
 
+		/* Let any pending signals fire now.  This ensures
+		 * that they won't be delivered after the exec, when
+		 * they are definitely not expected.
+		 */
+		unblock_signals();
+
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
 		ret = 1;
Index: 2.6.9/arch/um/kernel/time.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/time.c	2004-11-24 12:23:12.000000000 -0500
+++ 2.6.9/arch/um/kernel/time.c	2004-11-24 12:29:36.000000000 -0500
@@ -60,6 +60,9 @@
 	   (setitimer(ITIMER_REAL, &disable, NULL) < 0))
 		printk("disnable_timer - setitimer failed, errno = %d\n",
 		       errno);
+	/* If there are signals already queued, after unblocking ignore them */
+	set_handler(SIGALRM, SIG_IGN, 0, -1);
+	set_handler(SIGVTALRM, SIG_IGN, 0, -1);
 }
 
 void switch_timers(int to_real)

