Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVDLTni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVDLTni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVDLTnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:43:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:65480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262110AbVDLKcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:03 -0400
Message-Id: <200504121031.j3CAVs8E005443@shell0.pdx.osdl.net>
Subject: [patch 079/198] x86_64: Fix interaction of single stepping with debuggers
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Ported from i386/Linus

Fix another TF corner case.  Need to do the special TF handling for all
signals to make debuggers happy

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/signal.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN arch/x86_64/kernel/signal.c~x86_64-fix-interaction-of-single-stepping-with-debuggers arch/x86_64/kernel/signal.c
--- 25/arch/x86_64/kernel/signal.c~x86_64-fix-interaction-of-single-stepping-with-debuggers	2005-04-12 03:21:22.220758832 -0700
+++ 25-akpm/arch/x86_64/kernel/signal.c	2005-04-12 03:21:22.223758376 -0700
@@ -368,6 +368,18 @@ handle_signal(unsigned long sig, siginfo
 		}
 	}
 
+	/*
+	 * If TF is set due to a debugger (PT_DTRACE), clear the TF
+	 * flag so that register information in the sigcontext is
+	 * correct.
+	 */
+	if (unlikely(regs->eflags & TF_MASK)) {
+		if (likely(current->ptrace & PT_DTRACE)) {
+			current->ptrace &= ~PT_DTRACE;
+			regs->eflags &= ~TF_MASK;
+		}
+	}
+
 #ifdef CONFIG_IA32_EMULATION
 	if (test_thread_flag(TIF_IA32)) {
 		if (ka->sa.sa_flags & SA_SIGINFO)
_
