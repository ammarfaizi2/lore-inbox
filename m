Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVJYWF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVJYWF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVJYWFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:05:43 -0400
Received: from [151.97.230.9] ([151.97.230.9]:56037 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932425AbVJYWFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:05:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 03/11] uml: fix signal code x86-64 [for 2.6.15]
Date: Wed, 26 Oct 2005 00:01:18 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025220117.20010.78137.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The problems in this area came to light while fixing a compile failure with
GCC 4, in commit bcb01b8a67476e6f748086e626df8424cc27036d. I went comparing this
code with x86_64 frame construction (which we should ABI compatible with) and
resync'ed the code a bit.

It isn't yet perfect, because we don't yet save floating point context. But that
will come later.

Please give a critical eye, even because things currently have no reported
misbehaviour, and this code is complex enough.

CC: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-x86_64/signal.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -164,6 +164,7 @@ struct rt_sigframe
 
 #define round_down(m, n) (((m) / (n)) * (n))
 
+/* Taken from arch/x86_64/kernel/signal.c:setup_rt_frame(). */
 int setup_signal_stack_si(unsigned long stack_top, int sig,
 			  struct k_sigaction *ka, struct pt_regs * regs,
 			  siginfo_t *info, sigset_t *set)
@@ -173,9 +174,21 @@ int setup_signal_stack_si(unsigned long 
 	int err = 0;
 	struct task_struct *me = current;
 
-	frame = (struct rt_sigframe __user *)
-		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-        frame = (struct rt_sigframe *) ((unsigned long) frame - 128);
+	/* Leave space on the stack for the Red Zone, and for saving FP
+	 * registers, even if this doesn't happen. We don't have a way to test
+	 * used_math(), so we do that inconditionally.
+	 *
+	 * XXX: RED-PEN: currently, we're using a Red Zone also for any
+	 * alternate stack set up by sigaltstack(), which x86-64 doesn't do
+	 * (because there shouldn't be any code executing there). This could
+	 * cause failures if user setup a too little alternate stack.*/
+
+        fp = (struct rt_sigframe *) round_down(stack_top - 128 -
+				sizeof(struct _fpstate), 16);
+
+	/* Now leave the space for the rest of signal frame. */
+	frame = (void __user *) round_down((unsigned long) fp -
+			sizeof(struct rt_sigframe), 16) - 8;
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;

