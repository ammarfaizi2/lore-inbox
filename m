Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUG1Vxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUG1Vxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUG1Vxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:53:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:64901 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264984AbUG1VwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:52:19 -0400
Date: Wed, 28 Jul 2004 23:52:10 +0200 (MEST)
Message-Id: <200407282152.i6SLqA7p016113@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc2-mm1] s390 signal handling fixes
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The signal-race-fixes patch in 2.6.8-rc2-mm1 appears to
be a bit broken on s390.

When forcing a SIGSEGV the old code updated "*ka", where
ka was a pointer to current's k_sigaction for SIGSEGV.
Now "ka_copy" points to a copy of that structure, so
assigning "*ka_copy" doesn't do what we want. Instead
do the assignment via current->... just like i386 and
x86_64 do.

Furthermore, the SA_ONESHOT handling wasn't deleted.
That is now handled by generic code in the kernel.

This patch has not been tested.

/Mikael Pettersson

diff -rupN linux-2.6.8-rc2-mm1/arch/s390/kernel/compat_signal.c linux-2.6.8-rc2-mm1.s390-signal-fixes/arch/s390/kernel/compat_signal.c
--- linux-2.6.8-rc2-mm1/arch/s390/kernel/compat_signal.c	2004-07-28 18:51:59.000000000 +0200
+++ linux-2.6.8-rc2-mm1.s390-signal-fixes/arch/s390/kernel/compat_signal.c	2004-07-28 23:41:47.397133944 +0200
@@ -506,7 +506,7 @@ static void setup_frame32(int sig, struc
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka_copy->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -559,7 +559,7 @@ static void setup_rt_frame32(int sig, st
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka_copy->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -577,9 +577,6 @@ handle_signal32(unsigned long sig, struc
 	else
 		setup_frame32(sig, ka_copy, oldset, regs);
 
-	if (ka_copy->sa.sa_flags & SA_ONESHOT)
-		ka_copy->sa.sa_handler = SIG_DFL;
-
 	if (!(ka_copy->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,
diff -rupN linux-2.6.8-rc2-mm1/arch/s390/kernel/signal.c linux-2.6.8-rc2-mm1.s390-signal-fixes/arch/s390/kernel/signal.c
--- linux-2.6.8-rc2-mm1/arch/s390/kernel/signal.c	2004-07-28 18:51:59.000000000 +0200
+++ linux-2.6.8-rc2-mm1.s390-signal-fixes/arch/s390/kernel/signal.c	2004-07-28 23:41:47.397133944 +0200
@@ -359,7 +359,7 @@ static void setup_frame(int sig, struct 
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka_copy->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -415,7 +415,7 @@ static void setup_rt_frame(int sig, stru
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka_copy->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -433,9 +433,6 @@ handle_signal(unsigned long sig, struct 
 	else
 		setup_frame(sig, ka_copy, oldset, regs);
 
-	if (ka_copy->sa.sa_flags & SA_ONESHOT)
-		ka_copy->sa.sa_handler = SIG_DFL;
-
 	if (!(ka_copy->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,
