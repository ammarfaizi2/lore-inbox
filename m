Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVCKDzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVCKDzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVCKDyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:54:12 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:64696 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261671AbVCKDrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:47:13 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 14:47:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.5302.475967.516593@berry.gelato.unsw.EDU.AU>
Subject: Microstate Accounting for 2.6.11, patch 3/
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Microstate Accounting: Track time in system calls and interrupts, i386 code.

Signed-off-by; Peter Chubb <peterc@gelato.unsw.edu.au>

 arch/i386/kernel/entry.S |   16 ++++++++++++++++
 arch/i386/kernel/irq.c |   13 ++++++++++++-


Index: linux-2.6-ustate/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6-ustate.orig/arch/i386/kernel/entry.S	2005-03-10 09:13:01.448604031 +1100
+++ linux-2.6-ustate/arch/i386/kernel/entry.S	2005-03-10 09:16:14.888575341 +1100
@@ -222,10 +222,18 @@
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
 	testw $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)
 	jnz syscall_trace_entry
+#ifdef CONFIG_MICROSTATE
+	pushl	%eax
+	call msa_start_syscall
+	popl	%eax
+#endif
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
+#ifdef CONFIG_MICROSTATE
+	call msa_end_syscall
+#endif
 	cli
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
@@ -250,9 +258,17 @@
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 syscall_call:
+#ifdef CONFIG_MICROSTATE
+	pushl	%eax
+	call msa_start_syscall
+	popl	%eax
+#endif
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
+#ifdef CONFIG_MICROSTATE
+	call msa_end_syscall
+#endif
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret


Index: linux-2.6-ustate/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6-ustate.orig/arch/i386/kernel/irq.c	2005-03-10 09:13:00.115606274 +1100
+++ linux-2.6-ustate/arch/i386/kernel/irq.c	2005-03-10 09:16:16.032121680 +1100
@@ -55,6 +55,8 @@
 #endif
 
 	irq_enter();
+	msa_start_irq(irq);
+	
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
 	{
@@ -101,6 +103,7 @@
 #endif
 		__do_IRQ(irq, regs);
 
+	msa_finish_irq(irq);
 	irq_exit();
 
 	return 1;
@@ -221,10 +224,18 @@
 		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
+#ifdef CONFIG_MICROSTATE
+		seq_printf(p, "%10llu", msa_irq_time(0, i));
+#endif
 #else
 		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
+			if (cpu_online(j)) {
 				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+#ifdef CONFIG_MICROSTATE
+				seq_printf(p, "%10llu", msa_irq_time(j, i));
+#endif
+			}
+
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
