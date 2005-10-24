Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVJXXf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVJXXf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 19:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVJXXf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 19:35:58 -0400
Received: from pop.gmx.net ([213.165.64.20]:11718 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751382AbVJXXf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 19:35:57 -0400
X-Authenticated: #2724694
Message-ID: <435D6FD3.6010901@gmx.net>
Date: Tue, 25 Oct 2005 01:35:47 +0200
From: Peter Beutner <p.beutner@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: ak@suse.de
CC: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: fix single step handling for 32bit processes
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be more careful with TF handling to fix some copy protection codes in wine

patch originally for i386 by Linus, then ported to x86_64 by Andi Kleen
see: [PATCH] x86_64: Some fixes for single step handling
commit: be61bff789fe44bfb6d9282d8f7eccc860bdcfb6

But it was never applied to the ia32 emulation code which breaks some
copy-protection schemes under wine when running on x86_64.

Signed-off-by: Peter Beutner <p.beutner@gmx.net>

--- linux-2.6/arch/x86_64/ia32/ia32_signal.c.old	2005-10-25 00:52:29.000000000 +0200
+++ linux-2.6/arch/x86_64/ia32/ia32_signal.c	2005-10-25 00:52:59.000000000 +0200
@@ -353,7 +353,6 @@ ia32_setup_sigcontext(struct sigcontext_
 		 struct pt_regs *regs, unsigned int mask)
 {
 	int tmp, err = 0;
-	u32 eflags;

 	tmp = 0;
 	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
@@ -378,10 +377,7 @@ ia32_setup_sigcontext(struct sigcontext_
 	err |= __put_user(current->thread.trap_no, &sc->trapno);
 	err |= __put_user(current->thread.error_code, &sc->err);
 	err |= __put_user((u32)regs->rip, &sc->eip);
-	eflags = regs->eflags;
-	if (current->ptrace & PT_PTRACED)
-		eflags &= ~TF_MASK;
-	err |= __put_user((u32)eflags, &sc->eflags);
+	err |= __put_user((u32)regs->eflags, &sc->eflags);
 	err |= __put_user((u32)regs->rsp, &sc->esp_at_signal);

 	tmp = save_i387_ia32(current, fpstate, regs, 0);
@@ -505,13 +501,9 @@ int ia32_setup_frame(int sig, struct k_s
 	regs->ss = __USER32_DS;

 	set_fs(USER_DS);
-	if (regs->eflags & TF_MASK) {
-		if (current->ptrace & PT_PTRACED) {
-			ptrace_notify(SIGTRAP);
-		} else {
-			regs->eflags &= ~TF_MASK;
-		}
-	}
+    regs->eflags &= ~TF_MASK;
+    if (test_thread_flag(TIF_SINGLESTEP))
+        ptrace_notify(SIGTRAP);

 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -605,13 +597,9 @@ int ia32_setup_rt_frame(int sig, struct
 	regs->ss = __USER32_DS;

 	set_fs(USER_DS);
-	if (regs->eflags & TF_MASK) {
-		if (current->ptrace & PT_PTRACED) {
-			ptrace_notify(SIGTRAP);
-		} else {
-			regs->eflags &= ~TF_MASK;
-		}
-	}
+    regs->eflags &= ~TF_MASK;
+    if (test_thread_flag(TIF_SINGLESTEP))
+        ptrace_notify(SIGTRAP);

 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
