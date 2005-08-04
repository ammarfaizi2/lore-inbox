Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVHDAo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVHDAo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVHDAo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:44:27 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:20499 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261535AbVHDAo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:44:26 -0400
Date: Wed, 3 Aug 2005 17:43:04 -0700
From: zach@vmware.com
Message-Id: <200508040043.j740h4wB004166@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 1/5 more-asm-cleanup
X-OriginalArrivalTime: 04 Aug 2005 00:43:09.0000 (UTC) FILETIME=[7C1CCC80:01C5988D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more assembler cleanups I noticed along the way.

Diffs against: 2.6.13-rc4-mm1

Signed-off-by: Zachary Amsden <zach@vmware.com)
Index: linux-2.6.13/arch/i386/kernel/crash.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/crash.c	2005-08-03 15:18:18.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/crash.c	2005-08-03 15:19:39.000000000 -0700
@@ -153,7 +153,7 @@
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
-	__asm__("hlt");
+	halt();
 	for(;;);
 
 	return 1;
Index: linux-2.6.13/arch/i386/kernel/machine_kexec.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/machine_kexec.c	2005-08-03 15:18:18.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/machine_kexec.c	2005-08-03 15:19:39.000000000 -0700
@@ -93,10 +93,7 @@
 	curidt.size    = limit;
 	curidt.address = (unsigned long)newidt;
 
-	__asm__ __volatile__ (
-		"lidtl %0\n"
-		: : "m" (curidt)
-		);
+	load_idt(&curidt);
 };
 
 
@@ -108,10 +105,7 @@
 	curgdt.size    = limit;
 	curgdt.address = (unsigned long)newgdt;
 
-	__asm__ __volatile__ (
-		"lgdtl %0\n"
-		: : "m" (curgdt)
-		);
+	load_gdt(&curgdt);
 };
 
 static void load_segments(void)
Index: linux-2.6.13/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-08-03 15:18:18.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/process.c	2005-08-03 17:27:48.000000000 -0700
@@ -165,7 +165,7 @@
 	 */
 	local_irq_disable();
 	while (1)
-		__asm__ __volatile__("hlt":::"memory");
+		halt();
 }
 #else
 static inline void play_dead(void)
Index: linux-2.6.13/arch/i386/kernel/msr.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/msr.c	2005-08-03 15:18:18.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/msr.c	2005-08-03 15:19:39.000000000 -0700
@@ -46,23 +46,13 @@
 
 static struct class *msr_class;
 
-/* Note: "err" is handled in a funny way below.  Otherwise one version
-   of gcc or another breaks. */
-
 static inline int wrmsr_eio(u32 reg, u32 eax, u32 edx)
 {
 	int err;
 
-	asm volatile ("1:	wrmsr\n"
-		      "2:\n"
-		      ".section .fixup,\"ax\"\n"
-		      "3:	movl %4,%0\n"
-		      "	jmp 2b\n"
-		      ".previous\n"
-		      ".section __ex_table,\"a\"\n"
-		      "	.align 4\n" "	.long 1b,3b\n" ".previous":"=&bDS" (err)
-		      :"a"(eax), "d"(edx), "c"(reg), "i"(-EIO), "0"(0));
-
+	err = wrmsr_safe(reg, eax, edx);
+	if (err)
+		err = -EIO;
 	return err;
 }
 
@@ -70,18 +60,9 @@
 {
 	int err;
 
-	asm volatile ("1:	rdmsr\n"
-		      "2:\n"
-		      ".section .fixup,\"ax\"\n"
-		      "3:	movl %4,%0\n"
-		      "	jmp 2b\n"
-		      ".previous\n"
-		      ".section __ex_table,\"a\"\n"
-		      "	.align 4\n"
-		      "	.long 1b,3b\n"
-		      ".previous":"=&bDS" (err), "=a"(*eax), "=d"(*edx)
-		      :"c"(reg), "i"(-EIO), "0"(0));
-
+	err = rdmsr_safe(reg, eax, edx);
+	if (err)
+		err = -EIO;
 	return err;
 }
 
Index: linux-2.6.13/arch/i386/kernel/cpu/intel.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/cpu/intel.c	2005-08-03 15:18:18.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/cpu/intel.c	2005-08-03 15:19:39.000000000 -0700
@@ -82,16 +82,12 @@
  */
 static int __devinit num_cpu_cores(struct cpuinfo_x86 *c)
 {
-	unsigned int eax;
+	unsigned int eax, ebx, ecx, edx;
 
 	if (c->cpuid_level < 4)
 		return 1;
 
-	__asm__("cpuid"
-		: "=a" (eax)
-		: "0" (4), "c" (0)
-		: "bx", "dx");
-
+	cpuid(4, &eax, &ebx, &ecx, &edx);
 	if (eax & 0x1f)
 		return ((eax >> 26) + 1);
 	else
Index: linux-2.6.13/arch/i386/mach-voyager/voyager_basic.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mach-voyager/voyager_basic.c	2005-08-03 15:18:18.000000000 -0700
+++ linux-2.6.13/arch/i386/mach-voyager/voyager_basic.c	2005-08-03 15:19:39.000000000 -0700
@@ -234,10 +234,9 @@
 #endif
 	}
 	/* and wait for it to happen */
-	for(;;) {
-		__asm("cli");
-		__asm("hlt");
-	}
+	local_irq_disable();
+	for(;;) 
+		halt();
 }
 
 /* copied from process.c */
@@ -272,10 +271,9 @@
 		outb(basebd | 0x08, VOYAGER_MC_SETUP);
 		outb(0x02, catbase + 0x21);
 	}
-	for(;;) {
-		asm("cli");
-		asm("hlt");
-	}
+	local_irq_disable();
+	for(;;) 
+		halt();
 }
 
 void
Index: linux-2.6.13/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mach-voyager/voyager_smp.c	2005-08-03 15:18:18.000000000 -0700
+++ linux-2.6.13/arch/i386/mach-voyager/voyager_smp.c	2005-08-03 15:19:39.000000000 -0700
@@ -1015,7 +1015,7 @@
 	cpu_clear(smp_processor_id(), cpu_online_map);
 	local_irq_disable();
 	for(;;)
-	       __asm__("hlt");
+		halt();
 }
 
 static DEFINE_SPINLOCK(call_lock);
Index: linux-2.6.13/include/asm-i386/msr.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/msr.h	2005-08-03 15:18:18.000000000 -0700
+++ linux-2.6.13/include/asm-i386/msr.h	2005-08-03 17:16:07.000000000 -0700
@@ -47,6 +47,21 @@
 		     : "c" (msr), "0" (a), "d" (b), "i" (-EFAULT));\
 	ret__; })
 
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr,a,b) ({ int ret__;						\
+	asm volatile("2: rdmsr ; xorl %0,%0\n"						\
+		     "1:\n\t"								\
+		     ".section .fixup,\"ax\"\n\t"					\
+		     "3:  movl %4,%0 ; jmp 1b\n\t"					\
+		     ".previous\n\t"							\
+ 		     ".section __ex_table,\"a\"\n"					\
+		     "   .align 4\n\t"							\
+		     "   .long 	2b,3b\n\t"						\
+		     ".previous"							\
+		     : "=r" (ret__), "=a" (*(a)), "=d" (*(b))				\
+		     : "c" (msr), "i" (-EFAULT));\
+	ret__; })
+
 #define rdtsc(low,high) \
      __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
 
