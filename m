Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWIVMAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWIVMAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWIVMAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:00:55 -0400
Received: from ozlabs.org ([203.10.76.45]:59884 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932329AbWIVMAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:00:54 -0400
Subject: [PATCH 6/7] (Optional) implement smp_processor_id() as a per-cpu
	var
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <1158926386.26261.17.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 22:00:51 +1000
Message-Id: <1158926451.26261.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This implements smp_processor_id() as a per-cpu variable.  The generic
code expects it in thread_info still, so we can't remove it from
there, but reducing smp_processor_id() from 9 bytes/3 insns to 6
bytes/1 insn is a nice micro-optimization.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Index: ak-pda-gs/arch/i386/kernel/smpboot.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/smpboot.c	2006-09-20 19:55:07.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/smpboot.c	2006-09-20 22:36:06.000000000 +1000
@@ -105,6 +105,9 @@
 DEFINE_PER_CPU(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
+DEFINE_PER_CPU(u32, processor_id);
+EXPORT_PER_CPU_SYMBOL(processor_id);
+
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -1355,6 +1358,7 @@
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	per_cpu(this_cpu_off, cpu) = __per_cpu_offset[cpu];
+	per_cpu(processor_id, cpu) = cpu;
 	setup_percpu_descriptor(&gdt[GDT_ENTRY_PERCPU],	__per_cpu_offset[cpu]);
 	cpu_gdt_descr->address = (unsigned long)gdt;
 	cpu_gdt_descr->size = GDT_SIZE - 1;
Index: ak-pda-gs/include/asm-i386/smp.h
===================================================================
--- ak-pda-gs.orig/include/asm-i386/smp.h	2006-09-20 20:20:50.000000000 +1000
+++ ak-pda-gs/include/asm-i386/smp.h	2006-09-20 22:36:22.000000000 +1000
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include <asm/percpu.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -56,7 +57,8 @@
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+DECLARE_PER_CPU(u32, processor_id);
+#define raw_smp_processor_id() x86_read_percpu(processor_id)
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;
Index: ak-pda-gs/arch/i386/kernel/cpu/common.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/cpu/common.c	2006-09-20 21:28:28.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/cpu/common.c	2006-09-20 22:37:17.000000000 +1000
@@ -597,7 +597,7 @@
  */
 void __cpuinit cpu_init(void)
 {
-	int cpu = smp_processor_id();
+	unsigned int cpu = current->thread_info->cpu;
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 	struct desc_struct *gdt;

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

