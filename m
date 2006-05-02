Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWEBBrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWEBBrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 21:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEBBrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 21:47:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932351AbWEBBrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 21:47:06 -0400
Message-ID: <4456BAA5.9030709@redhat.com>
Date: Mon, 01 May 2006 21:49:25 -0400
From: Jim Paradis <jparadis@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040924
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Use correct APIC ID for boot processor
Content-Type: multipart/mixed;
 boundary="------------060805030104070507010603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060805030104070507010603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is against 2.6.16-12

This patch implements the i386 side of a patch posted back in
September by Andi Kleen (originally from Stuart Hayes).  Since
phys_cpu_present_map is indexed by APIC ID we need to initialize
it with the APIC ID of the boot processor rather than 0.  The
upstream kernel has the fix for the x86_64 side but not for the
i386 side.  This patch is needed in order to boot the 32-bit kernel
on systems where the boot processor is not APIC ID 0.

Similarly, I fixed the definition of hard_smp_processor_id for
the uniprocessor case.  Since this is supposed to return an APIC
ID, it should not just default to zero when CONFIG_SMP is off.
In order to do this, I had to move the hard_smp_processor_id()
macro into the arch-specific include file.  Since I don't have
access to all of the affected archs, it would be nice to have
a few more eyes look at that part.

This fix allowed me to boot both the 32-bit UP and SMP kernels on a
16-way x86_64 system.

--jim

--------------060805030104070507010603
Content-Type: text/plain;
 name="2.6.16-apicid-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.16-apicid-fix"

diff -up --recursive linux-2.6.16.12.orig/arch/i386/kernel/smpboot.c linux-2.6.16.12/arch/i386/kernel/smpboot.c
--- linux-2.6.16.12.orig/arch/i386/kernel/smpboot.c	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/arch/i386/kernel/smpboot.c	2006-05-01 18:32:02.000000000 -0400
@@ -1138,7 +1138,7 @@ static void __init smp_boot_cpus(unsigne
 	if (!smp_found_config && !acpi_lapic) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = physid_mask_of_physid(0);
+		phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
@@ -1167,7 +1167,7 @@ static void __init smp_boot_cpus(unsigne
 			boot_cpu_physical_apicid);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = physid_mask_of_physid(0);
+		phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
 		cpu_set(0, cpu_sibling_map[0]);
 		cpu_set(0, cpu_core_map[0]);
 		return;
@@ -1182,7 +1182,7 @@ static void __init smp_boot_cpus(unsigne
 		smp_found_config = 0;
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = physid_mask_of_physid(0);
+		phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
 		cpu_set(0, cpu_sibling_map[0]);
 		cpu_set(0, cpu_core_map[0]);
 		return;
diff -up --recursive linux-2.6.16.12.orig/include/asm-alpha/smp.h linux-2.6.16.12/include/asm-alpha/smp.h
--- linux-2.6.16.12.orig/include/asm-alpha/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-alpha/smp.h	2006-05-01 20:47:22.000000000 -0400
@@ -54,6 +54,7 @@ int smp_call_function_on_cpu(void (*func
 
 #else /* CONFIG_SMP */
 
+#define hard_smp_processor_id()	0
 #define smp_call_function_on_cpu(func,info,retry,wait,cpu)    ({ 0; })
 
 #endif /* CONFIG_SMP */
diff -up --recursive linux-2.6.16.12.orig/include/asm-arm/arch-integrator/smp.h linux-2.6.16.12/include/asm-arm/arch-integrator/smp.h
--- linux-2.6.16.12.orig/include/asm-arm/arch-integrator/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-arm/arch-integrator/smp.h	2006-05-01 20:48:16.000000000 -0400
@@ -16,4 +16,9 @@
 
 extern void secondary_scan_irqs(void);
 
+#ifndef CONFIG_SMP
+#define hard_smp_processor_id()	0
+#endif
+
+
 #endif
diff -up --recursive linux-2.6.16.12.orig/include/asm-arm/arch-realview/smp.h linux-2.6.16.12/include/asm-arm/arch-realview/smp.h
--- linux-2.6.16.12.orig/include/asm-arm/arch-realview/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-arm/arch-realview/smp.h	2006-05-01 20:48:50.000000000 -0400
@@ -5,6 +5,7 @@
 
 #include <asm/hardware/gic.h>
 
+#ifdef CONFIG_SMP
 #define hard_smp_processor_id()			\
 	({						\
 		unsigned int cpunum;			\
@@ -12,6 +13,9 @@
 			: "=r" (cpunum));		\
 		cpunum &= 0x0F;				\
 	})
+#else
+#define hard_smp_processor_id()	0
+#endif
 
 /*
  * We use IRQ1 as the IPI
diff -up --recursive linux-2.6.16.12.orig/include/asm-i386/smp.h linux-2.6.16.12/include/asm-i386/smp.h
--- linux-2.6.16.12.orig/include/asm-i386/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-i386/smp.h	2006-05-01 20:46:32.000000000 -0400
@@ -96,6 +96,8 @@ extern void __cpu_die(unsigned int cpu);
 
 #else /* CONFIG_SMP */
 
+#define hard_smp_processor_id()	(boot_cpu_physical_apicid)
+
 #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
diff -up --recursive linux-2.6.16.12.orig/include/asm-ia64/smp.h linux-2.6.16.12/include/asm-ia64/smp.h
--- linux-2.6.16.12.orig/include/asm-ia64/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-ia64/smp.h	2006-05-01 20:49:21.000000000 -0400
@@ -132,6 +132,7 @@ extern void identify_siblings (struct cp
 
 #else
 
+#define hard_smp_processor_id()	0
 #define cpu_logical_id(i)		0
 #define cpu_physical_id(i)		ia64_get_lid()
 
diff -up --recursive linux-2.6.16.12.orig/include/asm-m32r/smp.h linux-2.6.16.12/include/asm-m32r/smp.h
--- linux-2.6.16.12.orig/include/asm-m32r/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-m32r/smp.h	2006-05-01 20:49:46.000000000 -0400
@@ -112,6 +112,10 @@ extern unsigned long send_IPI_mask_phys(
 #define IPI_SHIFT	(0)
 #define NR_IPIS		(8)
 
+#else
+
+#define hard_smp_processor_id()	0
+
 #endif	/* CONFIG_SMP */
 
 #endif	/* _ASM_M32R_SMP_H */
diff -up --recursive linux-2.6.16.12.orig/include/asm-powerpc/smp.h linux-2.6.16.12/include/asm-powerpc/smp.h
--- linux-2.6.16.12.orig/include/asm-powerpc/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-powerpc/smp.h	2006-05-01 20:55:17.000000000 -0400
@@ -86,6 +86,7 @@ extern void __cpu_die(unsigned int cpu);
 #else
 /* for UP */
 #define smp_setup_cpu_maps()
+#define hard_smp_processor_id() 0
 
 #endif /* CONFIG_SMP */
 
@@ -99,6 +100,7 @@ extern void smp_release_cpus(void);
 #else
 /* 32-bit */
 #ifndef CONFIG_SMP
+#define hard_smp_processor_id() 0
 #define get_hard_smp_processor_id(cpu) 	boot_cpuid_phys
 #define set_hard_smp_processor_id(cpu, phys)
 #endif
diff -up --recursive linux-2.6.16.12.orig/include/asm-s390/smp.h linux-2.6.16.12/include/asm-s390/smp.h
--- linux-2.6.16.12.orig/include/asm-s390/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-s390/smp.h	2006-05-01 20:56:02.000000000 -0400
@@ -106,6 +106,7 @@ smp_call_function_on(void (*func) (void 
 #define smp_get_cpu(cpu) ({ 0; })
 #define smp_put_cpu(cpu) ({ 0; })
 #define smp_setup_cpu_possible_map()
+#define hard_smp_processor_id() 0
 #endif
 
 #endif
diff -up --recursive linux-2.6.16.12.orig/include/asm-sparc/smp.h linux-2.6.16.12/include/asm-sparc/smp.h
--- linux-2.6.16.12.orig/include/asm-sparc/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-sparc/smp.h	2006-05-01 20:59:29.000000000 -0400
@@ -169,6 +169,10 @@ static inline int hard_smp_processor_id(
 #define MBOX_IDLECPU2         0xFD
 #define MBOX_STOPCPU2         0xFE
 
+#else /* !CONFIG_SMP */
+
+#define hard_smp_processor_id() 0
+
 #endif /* SMP */
 
 #define NO_PROC_ID            0xFF
diff -up --recursive linux-2.6.16.12.orig/include/asm-sparc64/smp.h linux-2.6.16.12/include/asm-sparc64/smp.h
--- linux-2.6.16.12.orig/include/asm-sparc64/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-sparc64/smp.h	2006-05-01 20:58:13.000000000 -0400
@@ -72,6 +72,7 @@ extern void smp_setup_cpu_possible_map(v
 
 #else
 
+#define hard_smp_processor_id() 0
 #define smp_setup_cpu_possible_map() do { } while (0)
 
 #endif /* !(CONFIG_SMP) */
diff -up --recursive linux-2.6.16.12.orig/include/asm-um/smp.h linux-2.6.16.12/include/asm-um/smp.h
--- linux-2.6.16.12.orig/include/asm-um/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-um/smp.h	2006-05-01 20:58:41.000000000 -0400
@@ -25,6 +25,10 @@ extern inline void smp_cpus_done(unsigne
 
 extern struct task_struct *idle_threads[NR_CPUS];
 
+#else
+
+#define hard_smp_processor_id() 0
+
 #endif
 
 #endif
diff -up --recursive linux-2.6.16.12.orig/include/asm-x86_64/smp.h linux-2.6.16.12/include/asm-x86_64/smp.h
--- linux-2.6.16.12.orig/include/asm-x86_64/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/asm-x86_64/smp.h	2006-05-01 20:46:42.000000000 -0400
@@ -116,6 +116,7 @@ static inline int cpu_present_to_apicid(
 #endif /* !ASSEMBLY */
 
 #ifndef CONFIG_SMP
+#define hard_smp_processor_id() (boot_cpu_id)
 #define stack_smp_processor_id() 0
 #define safe_smp_processor_id() 0
 #define cpu_logical_map(x) (x)
diff -up --recursive linux-2.6.16.12.orig/include/linux/smp.h linux-2.6.16.12/include/linux/smp.h
--- linux-2.6.16.12.orig/include/linux/smp.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12/include/linux/smp.h	2006-05-01 20:46:12.000000000 -0400
@@ -91,8 +91,9 @@ void smp_prepare_boot_cpu(void);
 /*
  *	These macros fold the SMP functionality into a single CPU system
  */
+
 #define raw_smp_processor_id()			0
-#define hard_smp_processor_id()			0
+
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }

--------------060805030104070507010603--

