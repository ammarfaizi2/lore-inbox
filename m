Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUCRS5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUCRS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:57:13 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:4549 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262885AbUCRS4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:56:52 -0500
Message-ID: <4059F0EF.6070706@colorfullife.com>
Date: Thu, 18 Mar 2004 19:56:47 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [CFT,PATCH] cpu detection for 2.6.5-rc1-mm2
Content-Type: multipart/mixed;
 boundary="------------010807040206050202040505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807040206050202040505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

xHi all,

2.6.5-rc1-mm2 contains new slab code that is more memory efficient by 
setting (and thus reducing) the alignment of the objects based on the 
actual cpu cache line size. This means that the cpu identification must 
be done far earlier than before and that caused the boot problems with 
2.6.5-mm1.

Attached is a new proposal against 2.6.5-rc1-mm2 - could you give it a 
try? It's tested with Pentium 4, bochs (i.e. Intel Pentium) and Athlon 
XP cpus.

--
    Manfred

--------------010807040206050202040505
Content-Type: text/plain;
 name="patch-cpudetect-final"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cpudetect-final"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 5
//  EXTRAVERSION =-rc1-mm2
--- 2.6/arch/i386/kernel/cpu/common.c	2004-03-18 19:19:24.000000000 +0100
+++ build-2.6/arch/i386/kernel/cpu/common.c	2004-03-18 19:27:46.000000000 +0100
@@ -196,7 +196,6 @@
 void __init generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
-	int junk;
 
 	if (have_cpuid_p()) {
 		/* Get vendor name */
@@ -211,8 +210,8 @@
 	
 		/* Intel-defined flags: level 0x00000001 */
 		if ( c->cpuid_level >= 0x00000001 ) {
-			u32 capability, excap;
-			cpuid(0x00000001, &tfms, &junk, &excap, &capability);
+			u32 capability, excap, misc;
+			cpuid(0x00000001, &tfms, &misc, &excap, &capability);
 			c->x86_capability[0] = capability;
 			c->x86_capability[4] = excap;
 			c->x86 = (tfms >> 8) & 15;
@@ -222,6 +221,9 @@
 				c->x86_model += ((tfms >> 16) & 0xF) << 4;
 			} 
 			c->x86_mask = tfms & 15;
+
+			if (c->x86_capability[0] & (1<<19))
+				c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
 		} else {
 			/* Have CPUID level 0 only - unheard of */
 			c->x86 = 4;
@@ -261,16 +263,13 @@
 }
 __setup("serialnumber", x86_serial_nr_setup);
 
-
-
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
-void __init identify_cpu(struct cpuinfo_x86 *c)
+void __init early_identify_cpu(struct cpuinfo_x86 *c)
 {
 	int i;
 
-	c->loops_per_jiffy = loops_per_jiffy;
 	c->x86_cache_size = -1;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->cpuid_level = -1;	/* CPUID not detected */
@@ -279,6 +278,7 @@
 	c->x86_model_id[0] = '\0';  /* Unset */
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
 
+	c->x86_clflush_size = 0;
 	if (!have_cpuid_p()) {
 		/* First of all, decide if this is a 486 or higher */
 		/* It's a 486 if we can modify the AC flag */
@@ -299,12 +299,12 @@
 	if (this_cpu->c_identify) {
 		this_cpu->c_identify(c);
 
-	printk(KERN_DEBUG "CPU:     After vendor identify, caps: %08lx %08lx %08lx %08lx\n",
-		c->x86_capability[0],
-		c->x86_capability[1],
-		c->x86_capability[2],
-		c->x86_capability[3]);
-}
+		printk(KERN_DEBUG "CPU:     After vendor identify, caps: %08lx %08lx %08lx %08lx\n",
+			c->x86_capability[0],
+			c->x86_capability[1],
+			c->x86_capability[2],
+			c->x86_capability[3]);
+	}
 
 	/*
 	 * Vendor-specific initialization.  In this section we
@@ -360,6 +360,16 @@
 	       c->x86_capability[2],
 	       c->x86_capability[3]);
 
+	if (!c->x86_clflush_size) {
+		/* No cache line size autodetected - manual estimate: */
+		if (c->x86 <= 4)
+			c->x86_clflush_size = 16;
+		else
+			c->x86_clflush_size = 32;
+	}
+	printk(KERN_DEBUG "CPU: Cache line size %d.\n", c->x86_clflush_size);
+
+
 	/*
 	 * On SMP, boot_cpu_data holds the common feature set between
 	 * all CPUs; so make sure that we indicate which features are
@@ -371,12 +381,28 @@
 		for ( i = 0 ; i < NCAPINTS ; i++ )
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
 	}
+}
 
+void __init late_identify_cpu(struct cpuinfo_x86 *c)
+{
 	/* Init Machine Check Exception if available. */
 #ifdef CONFIG_X86_MCE
 	mcheck_init(c);
 #endif
+	/*
+	 * The timer is not yet running when identify cpu is called for the
+	 * first cpu - check_bugs() calls late_identify_cpu and transfers
+	 * loops_per_jiffy from calibrate_delay into the cpu data area.
+	 */
+	c->loops_per_jiffy = loops_per_jiffy;
+}
+
+void __init identify_cpu(struct cpuinfo_x86 *c)
+{
+	early_identify_cpu(c);
+	late_identify_cpu(c);
 }
+
 /*
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
  */
--- 2.6/arch/i386/kernel/setup.c	2004-03-18 19:19:24.000000000 +0100
+++ build-2.6/arch/i386/kernel/setup.c	2004-03-18 19:25:43.000000000 +0100
@@ -1137,6 +1137,7 @@
 
 	max_low_pfn = setup_memory();
 
+	early_identify_cpu(&boot_cpu_data);
 	/*
 	 * NOTE: before this point _nobody_ is allowed to allocate
 	 * any memory using the bootmem allocator.
--- 2.6/include/asm-i386/processor.h	2004-03-18 19:19:31.000000000 +0100
+++ build-2.6/include/asm-i386/processor.h	2004-03-18 19:25:50.000000000 +0100
@@ -63,6 +63,7 @@
 	int	f00f_bug;
 	int	coma_bug;
 	unsigned long loops_per_jiffy;
+	int     x86_clflush_size;	/* cache line size of L2 */
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL 0
@@ -96,7 +97,9 @@
 
 extern char ignore_fpu_irq;
 
+extern void early_identify_cpu(struct cpuinfo_x86 *);
 extern void identify_cpu(struct cpuinfo_x86 *);
+extern void late_identify_cpu(struct cpuinfo_x86 *c);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern void dodgy_tsc(void);
 
@@ -673,4 +676,6 @@
 #define ARCH_HAS_SCHED_WAKE_BALANCE
 #endif
 
+#define cache_line_size() (boot_cpu_data.x86_clflush_size)
+
 #endif /* __ASM_I386_PROCESSOR_H */
--- 2.6/include/asm-i386/bugs.h	2004-03-18 19:19:31.000000000 +0100
+++ build-2.6/include/asm-i386/bugs.h	2004-03-18 19:25:43.000000000 +0100
@@ -212,7 +212,7 @@
 
 static void __init check_bugs(void)
 {
-	identify_cpu(&boot_cpu_data);
+	late_identify_cpu(&boot_cpu_data);
 #ifndef CONFIG_SMP
 	printk("CPU: ");
 	print_cpu_info(&boot_cpu_data);
--- 2.6/arch/i386/kernel/cpu/intel.c	2004-03-18 19:19:24.000000000 +0100
+++ build-2.6/arch/i386/kernel/cpu/intel.c	2004-03-18 19:25:43.000000000 +0100
@@ -147,30 +147,34 @@
 }
 
 
-static void __init init_intel(struct cpuinfo_x86 *c)
-{
-	char *p = NULL;
-	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
-
 #ifdef CONFIG_X86_F00F_BUG
+static int __init check_f00f(void)
+{
 	/*
 	 * All current models of Pentium and Pentium with MMX technology CPUs
 	 * have the F0 0F bug, which lets nonprivileged users lock up the system.
-	 * Note that the workaround only should be initialized once...
+	 *
+	 * Only the boot cpu is checked - there are no mixed Pentium and P6 systems.
 	 */
-	c->f00f_bug = 0;
-	if ( c->x86 == 5 ) {
-		static int f00f_workaround_enabled = 0;
-
-		c->f00f_bug = 1;
-		if ( !f00f_workaround_enabled ) {
-			trap_init_virtual_IDT();
-			printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\n");
-			f00f_workaround_enabled = 1;
-		}
+	boot_cpu_data.f00f_bug = 0;
+	if ( boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+			boot_cpu_data.x86 == 5 ) {
+		boot_cpu_data.f00f_bug = 1;
+
+		trap_init_virtual_IDT();
+		printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\n");
 	}
+	return 0;
+}
+__initcall(check_f00f);
 #endif
 
+
+static void __init init_intel(struct cpuinfo_x86 *c)
+{
+	char *p = NULL;
+	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
+
 	select_idle_routine(c);
 	if (c->cpuid_level > 1) {
 		/* supports eax=2  call */

--------------010807040206050202040505--

