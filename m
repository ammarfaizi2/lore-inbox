Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUC3FeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbUC3FeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:34:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:52373 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263121AbUC3Fd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:33:59 -0500
Subject: [PATCH] ppc32: Even more preempt fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080624830.1216.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 15:33:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a warning if enable_kernel_{fp,altivec} is called with preempt
enabled since this is always an error, and make sure the alignement
exception handler properly disables preempt when doing FP operations.

Please, apply,
Ben.

diff -urN linux-2.5/arch/ppc/kernel/align.c linuxppc-2.5-benh/arch/ppc/kernel/align.c
--- linux-2.5/arch/ppc/kernel/align.c	2004-03-30 08:55:49.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc/kernel/align.c	2004-03-30 13:00:44.000000000 +1000
@@ -325,14 +325,18 @@
 	 * the kernel with -msoft-float so it doesn't use the
 	 * fp regs for copying 8-byte objects. */
 	case LD+F+S:
+		preempt_disable();
 		enable_kernel_fp();
 		cvt_fd(&data.f, &current->thread.fpr[reg], &current->thread.fpscr);
 		/* current->thread.fpr[reg] = data.f; */
+		preempt_enable();
 		break;
 	case ST+F+S:
+		preempt_disable();
 		enable_kernel_fp();
 		cvt_df(&current->thread.fpr[reg], &data.f, &current->thread.fpscr);
 		/* data.f = current->thread.fpr[reg]; */
+		preempt_enable();
 		break;
 	default:
 		printk("align: can't handle flags=%x\n", flags);
diff -urN linux-2.5/arch/ppc/kernel/process.c linuxppc-2.5-benh/arch/ppc/kernel/process.c
--- linux-2.5/arch/ppc/kernel/process.c	2004-03-29 12:54:12.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc/kernel/process.c	2004-03-30 14:55:42.000000000 +1000
@@ -163,7 +163,8 @@
 void
 enable_kernel_altivec(void)
 {
-	preempt_disable();
+	WARN_ON(current_thread_info()->preempt_count == 0 && !irqs_disabled());
+
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
 		giveup_altivec(current);
@@ -172,14 +173,15 @@
 #else
 	giveup_altivec(last_task_used_altivec);
 #endif /* __SMP __ */
-	preempt_enable();
 }
+EXPORT_SYMBOL(enable_kernel_altivec);
 #endif /* CONFIG_ALTIVEC */
 
 void
 enable_kernel_fp(void)
 {
-	preempt_disable();
+	WARN_ON(current_thread_info()->preempt_count == 0 && !irqs_disabled());
+
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
 		giveup_fpu(current);
@@ -188,8 +190,8 @@
 #else
 	giveup_fpu(last_task_used_math);
 #endif /* CONFIG_SMP */
-	preempt_enable();
 }
+EXPORT_SYMBOL(enable_kernel_fp);
 
 int
 dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)


