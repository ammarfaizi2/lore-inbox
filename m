Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUHLDOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUHLDOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 23:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268388AbUHLDOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 23:14:44 -0400
Received: from [12.177.129.25] ([12.177.129.25]:3012 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268378AbUHLDO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 23:14:27 -0400
Message-Id: <200408120415.i7C4FVJd010489@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] 2.6.8-rc4-mm1 - UML updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Aug 2004 00:15:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below brings UML up to date with interface changes and the like 
	irq.c includes profile.h to bring in a missing definition
	use the cpu_{set,clear} interface
	use the new get_signal_to_deliver interface
	define instruction_pointer

				Jeff
	

Index: 2.6.8-rc4-mm1/arch/um/kernel/irq.c
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/irq.c	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/irq.c	2004-08-11 23:03:14.000000000 -0400
@@ -18,6 +18,7 @@
 #include "linux/proc_fs.h"
 #include "linux/init.h"
 #include "linux/seq_file.h"
+#include "linux/profile.h"
 #include "asm/irq.h"
 #include "asm/hw_irq.h"
 #include "asm/hardirq.h"
Index: 2.6.8-rc4-mm1/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/process_kern.c	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/process_kern.c	2004-08-11 23:03:14.000000000 -0400
@@ -114,10 +114,11 @@
 void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
 	       struct task_struct *tsk)
 {
-	unsigned cpu = smp_processor_id();
+	int cpu = smp_processor_id();
+
 	if (prev != next) 
-		clear_bit(cpu, &prev->cpu_vm_mask);
-	set_bit(cpu, &next->cpu_vm_mask);
+		cpu_clear(cpu, prev->cpu_vm_mask);
+	cpu_set(cpu, next->cpu_vm_mask);
 }
 
 void set_current(void *t)
Index: 2.6.8-rc4-mm1/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/signal_kern.c	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/signal_kern.c	2004-08-11 23:03:14.000000000 -0400
@@ -130,21 +130,21 @@
 
 static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset, int error)
 {
+	struct k_sigaction ka_copy;
 	siginfo_t info;
-	struct k_sigaction *ka;
 	int err, sig;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
-	sig = get_signal_to_deliver(&info, regs, NULL);
+	sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if(sig == 0)
 		return(0);
 
 	/* Whee!  Actually deliver the signal.  */
-	ka = &current->sighand->action[sig -1 ];
-	err = handle_signal(regs, sig, ka, &info, oldset, error);
-	if(!err) return(1);
+	err = handle_signal(regs, sig, &ka_copy, &info, oldset, error);
+	if(!err) 
+		return(1);
 
 	/* Did we come from a system call? */
 	if(PT_REGS_SYSCALL_NR(regs) >= 0){
Index: 2.6.8-rc4-mm1/include/asm-um/ptrace-generic.h
===================================================================
--- 2.6.8-rc4-mm1.orig/include/asm-um/ptrace-generic.h	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/include/asm-um/ptrace-generic.h	2004-08-11 23:03:14.000000000 -0400
@@ -45,6 +45,8 @@
 
 #define PT_REGS_SC(r) UPT_SC(&(r)->regs)
 
+#define instruction_pointer(regs) PT_REGS_IP(regs)
+
 struct task_struct;
 
 extern unsigned long getreg(struct task_struct *child, int regno);

