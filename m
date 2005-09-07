Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVIGQXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVIGQXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVIGQXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:23:40 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:57538 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751228AbVIGQXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:23:40 -0400
Date: Thu, 08 Sep 2005 01:24:50 +0900 (JST)
Message-Id: <20050908.012450.41200025.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: ralf@linux-mips.org, macro@linux-mips.org, akpm@osdl.org
Subject: [PATCH] more sigkill priority fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux/MIPS, a simple test program can create unkillable process.
The "sigkill priority fix" was introduced in 2.6.12, but it does not
effective for signals sent by force_sig() in kernel.  For detailed
behavior and testcase, please look at this thread in linux-mips ML:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20050907.014234.108739386.anemo%40mba.ocn.ne.jp

Here is a proposal fix for generic signal handling code.

Patch comment:
The "sigkill priority fix" does not work as it desired if any signal
(< SIGKILL) was queued by force_sig() in kernel.  Search SIGKILL in
tsk->pending and tsk->signal->shared_pending first, then search
another signals.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

--- linux-2.6.13/kernel/signal.c	2005-08-29 08:41:01.000000000 +0900
+++ linux/kernel/signal.c	2005-09-07 01:33:52.338420760 +0900
@@ -520,19 +520,14 @@
 }
 
 static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			siginfo_t *info)
+			siginfo_t *info, int sig)
 {
-	int sig = 0;
-
-	/* SIGKILL must have priority, otherwise it is quite easy
-	 * to create an unkillable process, sending sig < SIGKILL
-	 * to self */
-	if (unlikely(sigismember(&pending->signal, SIGKILL))) {
-		if (!sigismember(mask, SIGKILL))
-			sig = SIGKILL;
-	}
-
-	if (likely(!sig))
+	if (sig) {
+		/* check signal with priority first */
+		if (likely(!sigismember(&pending->signal, sig)) ||
+		    sigismember(mask, sig))
+			sig = 0;
+	} else
 		sig = next_signal(pending, mask);
 	if (sig) {
 		if (current->notifier) {
@@ -561,10 +556,18 @@
  */
 int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info)
 {
-	int signr = __dequeue_signal(&tsk->pending, mask, info);
+	/* SIGKILL must have priority, otherwise it is quite easy
+	 * to create an unkillable process, sending sig < SIGKILL
+	 * to self */
+	int signr = __dequeue_signal(&tsk->pending, mask, info, SIGKILL);
+	if (likely(!signr))
+		signr = __dequeue_signal(&tsk->signal->shared_pending,
+					 mask, info, SIGKILL);
+	if (likely(!signr))
+		signr = __dequeue_signal(&tsk->pending, mask, info, 0);
 	if (!signr)
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info);
+					 mask, info, 0);
  	if (signr && unlikely(sig_kernel_stop(signr))) {
  		/*
  		 * Set a marker that we have dequeued a stop signal.  Our

---
Atsushi Nemoto
