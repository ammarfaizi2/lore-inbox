Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbUKITBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUKITBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUKITBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:01:52 -0500
Received: from mail.aknet.ru ([217.67.122.194]:1289 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261622AbUKITB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:01:29 -0500
Message-ID: <4191141A.5090202@aknet.ru>
Date: Tue, 09 Nov 2004 22:01:46 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch] kprobes: dont steal interrupts from vm86
Content-Type: multipart/mixed;
 boundary="------------090603050807040901070104"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090603050807040901070104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

With kprobes enabled, vm86 doesn't feel
good. The problem is that kprobes steal
the interrupts (mainly int3 I think) from
it for no good reason.
The attached patch fixes the problem by
checking the VM flag where it makes sense.

Andrew, can this please be applied?

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------090603050807040901070104
Content-Type: text/x-patch;
 name="kprb_vm86.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kprb_vm86.diff"

--- linux-2.6.10-rc1/arch/i386/kernel/traps.c	2004-11-09 12:59:20.000000000 +0300
+++ linux-2.6.10-rc1-kprb/linux/arch/i386/kernel/traps.c	2004-11-09 13:35:18.625427704 +0300
@@ -408,7 +408,8 @@
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+	if (!(regs->eflags & VM_MASK) && \
+		notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
 						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
@@ -422,7 +423,8 @@
 	info.si_errno = 0; \
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+	if (!(regs->eflags & VM_MASK) && \
+		notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
 						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 0, regs, error_code, &info); \
@@ -431,7 +433,8 @@
 #define DO_VM86_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+	if (!(regs->eflags & VM_MASK) && \
+		notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
 						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
@@ -445,7 +448,8 @@
 	info.si_errno = 0; \
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+	if (!(regs->eflags & VM_MASK) && \
+		notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
 						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 1, regs, error_code, &info); \
@@ -652,7 +656,8 @@
 #ifdef CONFIG_KPROBES
 asmlinkage int do_int3(struct pt_regs *regs, long error_code)
 {
-	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
+	if (!(regs->eflags & VM_MASK) &&
+		notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
 			== NOTIFY_STOP)
 		return 1;
 	/* This is an interrupt gate, because kprobes wants interrupts
@@ -693,7 +698,8 @@
 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
-	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
+	if (!(regs->eflags & VM_MASK) && 
+		notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
 					SIGTRAP) == NOTIFY_STOP)
 		return;
 	/* It's safe to allow irq's after DR6 has been saved */

--------------090603050807040901070104--
