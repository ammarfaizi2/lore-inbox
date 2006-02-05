Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWBELtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWBELtt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWBELts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:49:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5577 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751722AbWBELts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:49:48 -0500
Date: Sun, 5 Feb 2006 12:49:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [RFC] swsusp: finally solve mysqld problem
Message-ID: <20060205114934.GA3148@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move userland freezing into more logical place. It now hits even with
mysqld running.

(Rafael, I'm a bit afraid this will clash with your refrigerator
changes, plus I'm lazy and don't -mm here. Do you think you could
forward it to akpm?)

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
index 963616d..5917835 100644
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
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
diff --git a/arch/x86_64/kernel/signal.c b/arch/x86_64/kernel/signal.c
index 5876df1..e5f5ce7 100644
--- a/arch/x86_64/kernel/signal.c
+++ b/arch/x86_64/kernel/signal.c
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
diff --git a/kernel/signal.c b/kernel/signal.c
index b373fc2..50eb4f5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
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

-- 
Thanks, Sharp!
