Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWBEMXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWBEMXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 07:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWBEMXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 07:23:30 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:58532 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751747AbWBEMXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 07:23:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] swsusp: finally solve mysqld problem
Date: Sun, 5 Feb 2006 13:21:54 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602051321.55519.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch from Pavel moves userland freeze signals handling into
more logical place.  It now hits even with mysqld running.

Please apply.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.16-rc1-mm5/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.16-rc1-mm5.orig/arch/i386/kernel/signal.c
+++ linux-2.6.16-rc1-mm5/arch/i386/kernel/signal.c
@@ -582,9 +582,6 @@ static void fastcall do_signal(struct pt
 	if (!user_mode(regs))
 		return;
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
 		oldset = &current->saved_sigmask;
 	else
@@ -613,7 +610,6 @@ static void fastcall do_signal(struct pt
 		return;
 	}
 
-no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* Restart the system call - no handlers present */
Index: linux-2.6.16-rc1-mm5/arch/x86_64/kernel/signal.c
===================================================================
--- linux-2.6.16-rc1-mm5.orig/arch/x86_64/kernel/signal.c
+++ linux-2.6.16-rc1-mm5/arch/x86_64/kernel/signal.c
@@ -443,9 +443,6 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -463,7 +460,6 @@ int do_signal(struct pt_regs *regs, sigs
 		return handle_signal(signr, &info, &ka, oldset, regs);
 	}
 
- no_signal:
 	/* Did we come from a system call? */
 	if ((long)regs->orig_rax >= 0) {
 		/* Restart the system call - no handlers present */
Index: linux-2.6.16-rc1-mm5/kernel/signal.c
===================================================================
--- linux-2.6.16-rc1-mm5.orig/kernel/signal.c
+++ linux-2.6.16-rc1-mm5/kernel/signal.c
@@ -1922,6 +1922,8 @@ int get_signal_to_deliver(siginfo_t *inf
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
 
+	try_to_freeze();
+
 relock:
 	spin_lock_irq(&current->sighand->siglock);
 	for (;;) {
@@ -2307,7 +2309,6 @@ sys_rt_sigtimedwait(const sigset_t __use
 
 			timeout = schedule_timeout_interruptible(timeout);
 
-			try_to_freeze();
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
 			current->blocked = current->real_blocked;
