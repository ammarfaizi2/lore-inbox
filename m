Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVDZL0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVDZL0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVDZL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:26:11 -0400
Received: from hades.snarc.org ([212.85.152.11]:16913 "EHLO hades.snarc.org")
	by vger.kernel.org with ESMTP id S261429AbVDZL0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:26:07 -0400
Date: Tue, 26 Apr 2005 13:26:04 +0200
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: ian.pratt@cl.cam.ac.uk, akpm@osdl.org
Subject: [PATCH 3/6][XEN][x86] Rename usermode macro
Message-ID: <20050426112604.GC26614@snarc.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ian.pratt@cl.cam.ac.uk, akpm@osdl.org
References: <20050426103804.85A7B4BE16@darwin.snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426103804.85A7B4BE16@darwin.snarc.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch rename user_mode to user_mode_vm and add a user_mode macro
similar to the x86-64 one.

This is useful for Xen because the linux xen kernel does not runs on the same
priviledge that a vanilla linux kernel, and with this we just need to redefine
user_mode().

ignore my previous mail, really sorry for the noise.

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
