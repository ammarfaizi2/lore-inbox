Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWIVMBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWIVMBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWIVMBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:01:46 -0400
Received: from ozlabs.org ([203.10.76.45]:63468 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932330AbWIVMBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:01:45 -0400
Subject: [PATCH 7/7] (Optional) implement current as a per-cpu var
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <1158926451.26261.18.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <1158926451.26261.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 22:01:42 +1000
Message-Id: <1158926502.26261.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This implements current as a per-cpu variable.  The generic code
expects it in thread_info still, so I don't remove it from there, but
reducing current from 9 bytes/3 insns to 6 bytes/1 insn is a nice
micro-optimization.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Index: ak-fresh/arch/i386/kernel/setup.c
===================================================================
--- ak-fresh.orig/arch/i386/kernel/setup.c	2006-09-22 17:03:49.000000000 +1000
+++ ak-fresh/arch/i386/kernel/setup.c	2006-09-22 17:04:29.000000000 +1000
@@ -148,6 +148,9 @@
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
+DEFINE_PER_CPU(struct task_struct *, current_task) = &init_task;
+EXPORT_PER_CPU_SYMBOL(current_task);
+
 static struct resource data_resource = {
 	.name	= "Kernel data",
 	.start	= 0,
Index: ak-fresh/arch/i386/kernel/smpboot.c
===================================================================
--- ak-fresh.orig/arch/i386/kernel/smpboot.c	2006-09-22 17:04:18.000000000 +1000
+++ ak-fresh/arch/i386/kernel/smpboot.c	2006-09-22 17:04:29.000000000 +1000
@@ -598,12 +598,13 @@
 	 * We don't actually need to load the full TSS,
 	 * basically just the stack pointer and the eip.
 	 */
-
+	/* Can't use current until setup_percpu_for_this_cpu */
 	asm volatile(
 		"movl %0,%%esp\n\t"
 		"jmp *%1"
 		:
-		:"r" (current->thread.esp),"r" (current->thread.eip));
+		:"r" (current_thread_info()->task->thread.esp),
+		 "r" (current_thread_info()->task->thread.eip));
 }
 
 extern struct {
@@ -946,6 +947,8 @@
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 	idle->thread.eip = (unsigned long) start_secondary;
+	per_cpu(current_task, cpu) = idle;
+
 	/* start_eip had better be page-aligned! */
 	start_eip = setup_trampoline();
 
Index: ak-fresh/include/asm-i386/current.h
===================================================================
--- ak-fresh.orig/include/asm-i386/current.h	2006-09-22 17:02:46.000000000 +1000
+++ ak-fresh/include/asm-i386/current.h	2006-09-22 17:04:29.000000000 +1000
@@ -1,15 +1,10 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
+#include <asm/percpu.h>
 #include <linux/thread_info.h>
 
-struct task_struct;
-
-static __always_inline struct task_struct * get_current(void)
-{
-	return current_thread_info()->task;
-}
- 
-#define current get_current()
+DECLARE_PER_CPU(struct task_struct *, current_task);
+#define current x86_read_percpu(current_task)
 
 #endif /* !(_I386_CURRENT_H) */
Index: ak-fresh/arch/i386/kernel/process.c
===================================================================
--- ak-fresh.orig/arch/i386/kernel/process.c	2006-09-22 17:02:46.000000000 +1000
+++ ak-fresh/arch/i386/kernel/process.c	2006-09-22 17:04:30.000000000 +1000
@@ -669,6 +669,7 @@
 	if (unlikely(prev->fs | next->fs))
 		loadsegment(fs, next->fs);
 
+	x86_write_percpu(current_task, next_p);
 
 	/*
 	 * Restore IOPL if needed.
Index: ak-fresh/arch/i386/kernel/cpu/common.c
===================================================================
--- ak-fresh.orig/arch/i386/kernel/cpu/common.c	2006-09-22 17:04:18.000000000 +1000
+++ ak-fresh/arch/i386/kernel/cpu/common.c	2006-09-22 17:05:25.000000000 +1000
@@ -597,9 +597,10 @@
  */
 void __cpuinit cpu_init(void)
 {
-	unsigned int cpu = current->thread_info->cpu;
+	/* Careful: can't use current() or smp_processor_id() yet! */
+	unsigned int cpu = current_thread_info()->cpu;
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
-	struct thread_struct *thread = &current->thread;
+	struct thread_struct *thread = &per_cpu(current_task, cpu)->thread;
 	struct desc_struct *gdt;
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
 

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

