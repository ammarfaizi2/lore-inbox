Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVDZKkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVDZKkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVDZKi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:38:56 -0400
Received: from darwin.snarc.org ([81.56.210.228]:14213 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261469AbVDZKiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:38:06 -0400
To: "3/6][XEN]"@snarc.org, "[x86]"@snarc.org, <akpm@osdl.org>,
       ", <ian.pratt@cl.cam.ac.uk>,, <vincent.hanquez@cl.cam.ac.uk>"@snarc.org,
       Andrew@snarc.org, Hanquez@snarc.org, linux-kernel@vger.kernel.org,
       macro@snarc.org, ", Morton, Pratt, rename, usermode, Vincent"@snarc.org
Subject: "[PATCH
Cc: Ian@snarc.org
"From: 
Message-Id: <20050426103804.85A7B4BE16@darwin.snarc.org>
Date: Tue, 26 Apr 2005 12:38:04 +0200 (CEST)
From: tab@snarc.org (Vincent Hanquez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch rename user_mode to user_mode_vm and add a user_mode macro
similar to the x86-64 one.

This is useful for Xen because the linux xen kernel does not runs on the same
priviledge that a vanilla linux kernel, and with this we just need to redefine
user_mode().

Please apply, or comments.

	Signed-off-by: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>

diff -Naur linux-2.6.12-rc3/arch/i386/kernel/apic.c linux-2.6.12-rc3.1/arch/i386/kernel/apic.c
--- linux-2.6.12-rc3/arch/i386/kernel/apic.c	2005-04-21 11:45:45.000000000 +0100
+++ linux-2.6.12-rc3.1/arch/i386/kernel/apic.c	2005-04-25 18:13:00.000000000 +0100
@@ -1133,7 +1133,7 @@
 		}
 
 #ifdef CONFIG_SMP
-		update_process_times(user_mode(regs));
+		update_process_times(user_mode_vm(regs));
 #endif
 	}
 
diff -Naur linux-2.6.12-rc3/arch/i386/kernel/ptrace.c linux-2.6.12-rc3.1/arch/i386/kernel/ptrace.c
--- linux-2.6.12-rc3/arch/i386/kernel/ptrace.c	2005-04-21 11:45:46.000000000 +0100
+++ linux-2.6.12-rc3.1/arch/i386/kernel/ptrace.c	2005-04-25 18:12:39.000000000 +0100
@@ -667,7 +667,7 @@
 	info.si_code = TRAP_BRKPT;
 
 	/* User-mode eip? */
-	info.si_addr = user_mode(regs) ? (void __user *) regs->eip : NULL;
+	info.si_addr = user_mode_vm(regs) ? (void __user *) regs->eip : NULL;
 
 	/* Send us the fakey SIGTRAP */
 	force_sig_info(SIGTRAP, &info, tsk);
diff -Naur linux-2.6.12-rc3/arch/i386/mach-voyager/voyager_smp.c linux-2.6.12-rc3.1/arch/i386/mach-voyager/voyager_smp.c
--- linux-2.6.12-rc3/arch/i386/mach-voyager/voyager_smp.c	2005-04-21 11:45:46.000000000 +0100
+++ linux-2.6.12-rc3.1/arch/i386/mach-voyager/voyager_smp.c	2005-04-25 18:13:12.000000000 +0100
@@ -1289,7 +1289,7 @@
 						per_cpu(prof_counter, cpu);
 		}
 
-		update_process_times(user_mode(regs));
+		update_process_times(user_mode_vm(regs));
 	}
 
 	if( ((1<<cpu) & voyager_extended_vic_processors) == 0)
diff -Naur linux-2.6.12-rc3/arch/i386/oprofile/backtrace.c linux-2.6.12-rc3.1/arch/i386/oprofile/backtrace.c
--- linux-2.6.12-rc3/arch/i386/oprofile/backtrace.c	2005-04-21 11:45:46.000000000 +0100
+++ linux-2.6.12-rc3.1/arch/i386/oprofile/backtrace.c	2005-04-25 18:13:21.000000000 +0100
@@ -91,7 +91,7 @@
 	head = (struct frame_head *)regs->ebp;
 #endif
 
-	if (!user_mode(regs)) {
+	if (!user_mode_vm(regs)) {
 		while (depth-- && valid_kernel_stack(head, regs))
 			head = dump_backtrace(head);
 		return;
diff -Naur linux-2.6.12-rc3/include/asm-i386/ptrace.h linux-2.6.12-rc3.1/include/asm-i386/ptrace.h
--- linux-2.6.12-rc3/include/asm-i386/ptrace.h	2005-03-02 07:37:48.000000000 +0000
+++ linux-2.6.12-rc3.1/include/asm-i386/ptrace.h	2005-04-25 17:05:54.000000000 +0100
@@ -57,7 +57,8 @@
 #ifdef __KERNEL__
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
-#define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
+#define user_mode(regs)		(3 & (regs)->xcs)
+#define user_mode_vm(regs)	((VM_MASK & (regs)->eflags) || user_mode(regs))
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
