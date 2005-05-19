Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVESJqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVESJqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 05:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVESJqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 05:46:50 -0400
Received: from fmr16.intel.com ([192.55.52.70]:48859 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262476AbVESJnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 05:43:09 -0400
Subject: [PATCH 2/2] porting lockless mce from x86_64 to i386
From: Guo Racing <racing.guo@intel.com>
Reply-To: racing.guo@intel.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116495351.18666.47.camel@guorj.sh.intel.com>
References: <1116495351.18666.47.camel@guorj.sh.intel.com>
Content-Type: text/plain
Organization: Intel Corp.
Message-Id: <1116495706.18666.55.camel@guorj.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 May 2005 17:41:46 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lockless MCE(machine check exception) is ported from
x86-64 to i386. This patch is for implementation.

Signed-off-by: Racing Guo <racing.guo@intel.com>
---

 arch/i386/Kconfig                          |   48 ++++++++---------------------
 arch/i386/defconfig                        |    3 -
 arch/i386/kernel/apic.c                    |    6 +--
 arch/i386/kernel/cpu/common.c              |    4 +-
 arch/i386/kernel/cpu/mcheck/Makefile       |    6 ++-
 arch/i386/kernel/cpu/mcheck/init.c         |   40 ++++++------------------
 arch/i386/kernel/cpu/mcheck/p5.c           |    5 ---
 arch/i386/kernel/cpu/mcheck/winchip.c      |    2 -
 arch/x86_64/kernel/mce.c                   |   42 ++++++++++++++++---------
 arch/x86_64/kernel/mce.h                   |   32 +++++++++++--------
 arch/x86_64/kernel/mce_intel.c             |    4 +-
 include/asm-i386/mach-default/entry_arch.h |    2 -
 12 files changed, 86 insertions(+), 108 deletions(-)

diff -rNu 2.6.11.10-mce-prep/arch/i386/defconfig 2.6.11.10-mce-impl/arch/i386/defconfig
--- 2.6.11.10-mce-prep/arch/i386/defconfig	2005-05-18 16:57:15.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/i386/defconfig	2005-05-18 17:20:29.000000000 +0800
@@ -99,8 +99,7 @@
 CONFIG_X86_IO_APIC=y
 CONFIG_X86_TSC=y
 CONFIG_X86_MCE=y
-CONFIG_X86_MCE_NONFATAL=y
-CONFIG_X86_MCE_P4THERMAL=y
+CONFIG_X86_MCE_INTEL=y
 # CONFIG_TOSHIBA is not set
 # CONFIG_I8K is not set
 # CONFIG_MICROCODE is not set
diff -rNu 2.6.11.10-mce-prep/arch/i386/Kconfig 2.6.11.10-mce-impl/arch/i386/Kconfig
--- 2.6.11.10-mce-prep/arch/i386/Kconfig	2005-05-18 16:57:15.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/i386/Kconfig	2005-05-18 17:20:29.000000000 +0800
@@ -574,41 +574,21 @@
 	default y
 
 config X86_MCE
-	bool "Machine Check Exception"
-	depends on !X86_VOYAGER
-	---help---
-	  Machine Check Exception support allows the processor to notify the
-	  kernel if it detects a problem (e.g. overheating, component failure).
-	  The action the kernel takes depends on the severity of the problem,
-	  ranging from a warning message on the console, to halting the machine.
-	  Your processor must be a Pentium or newer to support this - check the
-	  flags in /proc/cpuinfo for mce.  Note that some older Pentium systems
-	  have a design flaw which leads to false MCE events - hence MCE is
-	  disabled on all P5 processors, unless explicitly enabled with "mce"
-	  as a boot argument.  Similarly, if MCE is built in and creates a
-	  problem on some new non-standard machine, you can boot with "nomce"
-	  to disable it.  MCE support simply ignores non-MCE processors like
-	  the 386 and 486, so nearly everyone can say Y here.
-
-config X86_MCE_NONFATAL
-	tristate "Check for non-fatal errors on AMD Athlon/Duron / Intel Pentium 4"
-	depends on X86_MCE
-	help
-	  Enabling this feature starts a timer that triggers every 5 seconds which
-	  will look at the machine check registers to see if anything happened.
-	  Non-fatal problems automatically get corrected (but still logged).
-	  Disable this if you don't want to see these messages.
-	  Seeing the messages this option prints out may be indicative of dying hardware,
-	  or out-of-spec (ie, overclocked) hardware.
-	  This option only does something on certain CPUs.
-	  (AMD Athlon/Duron and Intel Pentium 4)
-
-config X86_MCE_P4THERMAL
-	bool "check for P4 thermal throttling interrupt."
-	depends on X86_MCE && (X86_UP_APIC || SMP) && !X86_VISWS
+	bool "Machine check support" if EMBEDDED
+	default y
+	help
+	   Include a machine check error handler to report hardware errors.
+	   This version will require the mcelog utility to decode some
+	   machine check error logs. See
+	   ftp://ftp.x86-64.org/pub/linux/tools/mcelog
+
+config X86_MCE_INTEL
+	bool "Intel MCE features"
+	depends on X86_MCE && X86_LOCAL_APIC
+	default y
 	help
-	  Enabling this feature will cause a message to be printed when the P4
-	  enters thermal throttling.
+	   Additional support for intel specific MCE features such as
+	   the thermal monitor.
 
 config TOSHIBA
 	tristate "Toshiba Laptop support"
diff -rNu 2.6.11.10-mce-prep/arch/i386/kernel/apic.c 2.6.11.10-mce-impl/arch/i386/kernel/apic.c
--- 2.6.11.10-mce-prep/arch/i386/kernel/apic.c	2005-05-18 16:57:16.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/i386/kernel/apic.c	2005-05-18 17:20:29.000000000 +0800
@@ -78,7 +78,7 @@
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
 
 	/* thermal monitor LVT interrupt */
-#ifdef CONFIG_X86_MCE_P4THERMAL
+#ifdef CONFIG_X86_MCE_INTEL
 	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 #endif
 }
@@ -157,7 +157,7 @@
 	}
 
 /* lets not touch this if we didn't frob it */
-#ifdef CONFIG_X86_MCE_P4THERMAL
+#ifdef CONFIG_X86_MCE_INTEL
 	if (maxlvt >= 5) {
 		v = apic_read(APIC_LVTTHMR);
 		apic_write_around(APIC_LVTTHMR, v | APIC_LVT_MASKED);
@@ -174,7 +174,7 @@
 	if (maxlvt >= 4)
 		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
 
-#ifdef CONFIG_X86_MCE_P4THERMAL
+#ifdef CONFIG_X86_MCE_INTEL
 	if (maxlvt >= 5)
 		apic_write_around(APIC_LVTTHMR, APIC_LVT_MASKED);
 #endif
diff -rNu 2.6.11.10-mce-prep/arch/i386/kernel/cpu/common.c 2.6.11.10-mce-impl/arch/i386/kernel/cpu/common.c
--- 2.6.11.10-mce-prep/arch/i386/kernel/cpu/common.c	2005-05-18 16:57:16.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/i386/kernel/cpu/common.c	2005-05-18 17:20:29.000000000 +0800
@@ -27,7 +27,7 @@
 
 struct cpu_dev * cpu_devs[X86_VENDOR_NUM] = {};
 
-extern void mcheck_init(struct cpuinfo_x86 *c);
+extern void machine_check_init(struct cpuinfo_x86 *c);
 
 extern int disable_pse;
 
@@ -423,7 +423,7 @@
 
 	/* Init Machine Check Exception if available. */
 #ifdef CONFIG_X86_MCE
-	mcheck_init(c);
+	machine_check_init(c);
 #endif
 }
 /*
diff -rNu 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/init.c 2.6.11.10-mce-impl/arch/i386/kernel/cpu/mcheck/init.c
--- 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/init.c	2005-05-18 16:57:16.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/i386/kernel/cpu/mcheck/init.c	2005-05-19 13:55:42.000000000 +0800
@@ -14,12 +14,12 @@
 #include <asm/processor.h> 
 #include <asm/system.h>
 
-#include "mce.h"
+extern int __init mce_dont_init;
+extern void __init intel_p5_mcheck_init(struct cpuinfo_x86 *c);
+void __init winchip_mcheck_init(struct cpuinfo_x86 *c);
+void __init mcheck_init(struct cpuinfo_x86 *c);
 
-int mce_disabled __initdata = 0;
-int nr_mce_banks;
-
-EXPORT_SYMBOL_GPL(nr_mce_banks);	/* non-fatal.o */
+fastcall void do_machine_check(struct pt_regs * regs, long error_code);
 
 /* Handle unconfigured int18 (should never happen) */
 static fastcall void unexpected_machine_check(struct pt_regs * regs, long error_code)
@@ -31,24 +31,16 @@
 void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
 /* This has to be run for each processor */
-void __init mcheck_init(struct cpuinfo_x86 *c)
+void __init machine_check_init(struct cpuinfo_x86 *c)
 {
-	if (mce_disabled==1)
+	if (mce_dont_init)
 		return;
 
 	switch (c->x86_vendor) {
-		case X86_VENDOR_AMD:
-			if (c->x86==6 || c->x86==15)
-				amd_mcheck_init(c);
-			break;
 
 		case X86_VENDOR_INTEL:
 			if (c->x86==5)
 				intel_p5_mcheck_init(c);
-			if (c->x86==6)
-				intel_p6_mcheck_init(c);
-			if (c->x86==15)
-				intel_p4_mcheck_init(c);
 			break;
 
 		case X86_VENDOR_CENTAUR:
@@ -57,21 +49,9 @@
 			break;
 
 		default:
+			machine_check_vector = do_machine_check;
+			wmb();
+			mcheck_init(c);
 			break;
 	}
 }
-
-static int __init mcheck_disable(char *str)
-{
-	mce_disabled = 1;
-	return 0;
-}
-
-static int __init mcheck_enable(char *str)
-{
-	mce_disabled = -1;
-	return 0;
-}
-
-__setup("nomce", mcheck_disable);
-__setup("mce", mcheck_enable);
diff -rNu 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/Makefile 2.6.11.10-mce-impl/arch/i386/kernel/cpu/mcheck/Makefile
--- 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/Makefile	2005-05-18 16:57:16.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/i386/kernel/cpu/mcheck/Makefile	2005-05-18 17:20:29.000000000 +0800
@@ -1,2 +1,4 @@
-obj-y	=	mce.o k7.o p4.o p5.o p6.o winchip.o
-obj-$(CONFIG_X86_MCE_NONFATAL)	+=	non-fatal.o
+obj-y				:= init.o mce.o p5.o winchip.o
+obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
+mce-y				+= ../../../../x86_64/kernel/mce.o
+mce_intel-y			+= ../../../../x86_64/kernel/mce_intel.o
diff -rNu 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/p5.c 2.6.11.10-mce-impl/arch/i386/kernel/cpu/mcheck/p5.c
--- 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/p5.c	2005-05-18 16:57:16.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/i386/kernel/cpu/mcheck/p5.c	2005-05-18 17:20:29.000000000 +0800
@@ -14,7 +14,7 @@
 #include <asm/system.h>
 #include <asm/msr.h>
 
-#include "mce.h"
+extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
 
 /* Machine check handler for Pentium class Intel */
 static fastcall void pentium_machine_check(struct pt_regs * regs, long error_code)
@@ -37,9 +37,6 @@
 	if( !cpu_has(c, X86_FEATURE_MCE) )
 		return;	
 
-	/* Default P5 to off as its often misconnected */
-	if(mce_disabled != -1)
-		return;
 	machine_check_vector = pentium_machine_check;
 	wmb();
 
diff -rNu 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/winchip.c 2.6.11.10-mce-impl/arch/i386/kernel/cpu/mcheck/winchip.c
--- 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/winchip.c	2005-05-18 16:57:16.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/i386/kernel/cpu/mcheck/winchip.c	2005-05-18 17:20:29.000000000 +0800
@@ -13,7 +13,7 @@
 #include <asm/system.h>
 #include <asm/msr.h>
 
-#include "mce.h"
+extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
 
 /* Machine check handler for WinChip C6 */
 static fastcall void winchip_machine_check(struct pt_regs * regs, long error_code)
diff -rNu 2.6.11.10-mce-prep/arch/x86_64/kernel/mce.c 2.6.11.10-mce-impl/arch/x86_64/kernel/mce.c
--- 2.6.11.10-mce-prep/arch/x86_64/kernel/mce.c	2005-05-18 16:57:20.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/x86_64/kernel/mce.c	2005-05-19 14:23:01.108177896 +0800
@@ -3,6 +3,7 @@
  * K8 parts Copyright 2002,2003 Andi Kleen, SuSE Labs.
  * Rest from unknown author(s). 
  * 2004 Andi Kleen. Rewrote most of it. 
+ * 2005 Racing Guo port from x86_64 to i386
  */
 
 #include <linux/init.h>
@@ -17,18 +18,18 @@
 #include <linux/fs.h>
 #include <asm/processor.h> 
 #include <asm/msr.h>
-#include <asm/mce.h>
 #include <asm/kdebug.h>
 #include <asm/uaccess.h>
+#include "mce.h"
 
 #define MISC_MCELOG_MINOR 227
 #define NR_BANKS 5
 
-static int mce_dont_init;
+int __initdata mce_dont_init = 0;
 
 /* 0: always panic, 1: panic if deadlock possible, 2: try to avoid panic,
    3: never panic or exit (for testing only) */
-static int tolerant = 1;
+static unsigned long tolerant = 1;
 static int banks;
 static unsigned long bank[NR_BANKS] = { [0 ... NR_BANKS-1] = ~0UL };
 static unsigned long console_logged;
@@ -55,7 +56,13 @@
 		/* When the buffer fills up discard new entries. Assume 
 		   that the earlier errors are the more interesting. */
 		if (entry >= MCE_LOG_LEN) {
-			set_bit(MCE_OVERFLOW, &mcelog.flags);
+			/* cast &mcelog.flags to (unsigned long *) in
+			   order to prevent compiler warning in i386.
+			   It is OK to cast (unsigned *) to 
+			   (unsigned long *) in set_bit on little-endian
+			   machine
+                         */
+			set_bit(MCE_OVERFLOW, (unsigned long*)&mcelog.flags);
 			return;
 		}
 		/* Old left over entry. Skip. */
@@ -98,13 +105,16 @@
 	printk("\n");
 }
 
-static void mce_panic(char *msg, struct mce *backup, unsigned long start)
+static void mce_panic(char *msg, struct mce *backup, u64 start)
 { 
 	int i;
+
+#ifdef CONFIG_X86_64
 	oops_begin();
+#endif
 	for (i = 0; i < MCE_LOG_LEN; i++) {
-		unsigned long tsc = mcelog.entry[i].tsc;
-		if (time_before(tsc, start))
+		u64 tsc = mcelog.entry[i].tsc;
+		if (time_before64(tsc, start))
 			continue;
 		print_mce(&mcelog.entry[i]); 
 		if (backup && mcelog.entry[i].tsc == backup->tsc)
@@ -120,15 +130,14 @@
 
 static int mce_available(struct cpuinfo_x86 *c)
 {
-	return test_bit(X86_FEATURE_MCE, &c->x86_capability) &&
-	       test_bit(X86_FEATURE_MCA, &c->x86_capability);
+	return test_bit(X86_FEATURE_MCE, c->x86_capability) &&
+	       test_bit(X86_FEATURE_MCA, c->x86_capability);
 }
 
 /* 
  * The actual machine check handler
  */
-
-void do_machine_check(struct pt_regs * regs, long error_code)
+fastcall void do_machine_check(struct pt_regs * regs, long error_code)
 {
 	struct mce m, panicm;
 	int nowayout = (tolerant < 1); 
@@ -143,7 +152,7 @@
 		return;
 
 	memset(&m, 0, sizeof(struct mce));
-	m.cpu = hard_smp_processor_id();
+	m.cpu = smp_processor_id();
 	rdmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
 	if (!(m.mcgstatus & MCG_STATUS_RIPV))
 		kill_it = 1;
@@ -177,8 +186,13 @@
 			rdmsrl(MSR_IA32_MC0_ADDR + i*4, m.addr);
 
 		if (regs && (m.mcgstatus & MCG_STATUS_RIPV)) {
+#if CONFIG_X86_64
 			m.rip = regs->rip;
 			m.cs = regs->cs;
+#else
+			m.rip = regs->eip;
+			m.cs = regs->xcs;
+#endif
 		} else {
 			m.rip = 0;
 			m.cs = 0;
@@ -359,13 +373,13 @@
 
 static void collect_tscs(void *data) 
 { 
-	unsigned long *cpu_tsc = (unsigned long *)data;
+	u64 *cpu_tsc = (u64 *)data;
 	rdtscll(cpu_tsc[smp_processor_id()]);
 } 
 
 static ssize_t mce_read(struct file *filp, char __user *ubuf, size_t usize, loff_t *off)
 {
-	unsigned long cpu_tsc[NR_CPUS];
+	u64 cpu_tsc[NR_CPUS];
 	static DECLARE_MUTEX(mce_read_sem);
 	unsigned next;
 	char __user *buf = ubuf;
diff -rNu 2.6.11.10-mce-prep/arch/x86_64/kernel/mce.h 2.6.11.10-mce-impl/arch/x86_64/kernel/mce.h
--- 2.6.11.10-mce-prep/arch/x86_64/kernel/mce.h	2005-05-18 16:57:39.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/x86_64/kernel/mce.h	2005-05-18 18:19:23.000000000 +0800
@@ -8,19 +8,20 @@
  * Machine Check support for x86
  */
 
-#define MCG_CTL_P        (1UL<<8)   /* MCG_CAP register available */
+#define MCG_CTL_P        (1ULL<<8)   /* MCG_CAP register available */
+#define MCG_EXT_P        (1ULL<<9)   /* extended MSRs present */
 
-#define MCG_STATUS_RIPV  (1UL<<0)   /* restart ip valid */
-#define MCG_STATUS_EIPV  (1UL<<1)   /* eip points to correct instruction */
-#define MCG_STATUS_MCIP  (1UL<<2)   /* machine check in progress */
-
-#define MCI_STATUS_VAL   (1UL<<63)  /* valid error */
-#define MCI_STATUS_OVER  (1UL<<62)  /* previous errors lost */
-#define MCI_STATUS_UC    (1UL<<61)  /* uncorrected error */
-#define MCI_STATUS_EN    (1UL<<60)  /* error enabled */
-#define MCI_STATUS_MISCV (1UL<<59)  /* misc error reg. valid */
-#define MCI_STATUS_ADDRV (1UL<<58)  /* addr reg. valid */
-#define MCI_STATUS_PCC   (1UL<<57)  /* processor context corrupt */
+#define MCG_STATUS_RIPV  (1ULL<<0)   /* restart ip valid */
+#define MCG_STATUS_EIPV  (1ULL<<1)   /* eip points to correct instruction */
+#define MCG_STATUS_MCIP  (1ULL<<2)   /* machine check in progress */
+
+#define MCI_STATUS_VAL   (1ULL<<63)  /* valid error */
+#define MCI_STATUS_OVER  (1ULL<<62)  /* previous errors lost */
+#define MCI_STATUS_UC    (1ULL<<61)  /* uncorrected error */
+#define MCI_STATUS_EN    (1ULL<<60)  /* error enabled */
+#define MCI_STATUS_MISCV (1ULL<<59)  /* misc error reg. valid */
+#define MCI_STATUS_ADDRV (1ULL<<58)  /* addr reg. valid */
+#define MCI_STATUS_PCC   (1ULL<<57)  /* processor context corrupt */
 
 /* Fields are zero when not available */
 struct mce {
@@ -52,7 +53,6 @@
 	unsigned len;  	    /* = MCE_LOG_LEN */ 
 	unsigned next;
 	unsigned flags;
-	unsigned pad0; 
 	struct mce entry[MCE_LOG_LEN];
 };
 
@@ -77,4 +77,10 @@
 }
 #endif
 
+/*Fix Me:copy from include/linux/jiffies.h and modify it*/
+#define time_after64(a,b)         \
+        (typecheck(__u64, a) && \
+         typecheck(__u64, b) && \
+         ((__s64)(b) - (__s64)(a) < 0))
+#define time_before64(a,b)        time_after64(b,a)
 #endif
diff -rNu 2.6.11.10-mce-prep/arch/x86_64/kernel/mce_intel.c 2.6.11.10-mce-impl/arch/x86_64/kernel/mce_intel.c
--- 2.6.11.10-mce-prep/arch/x86_64/kernel/mce_intel.c	2005-05-18 16:57:20.000000000 +0800
+++ 2.6.11.10-mce-impl/arch/x86_64/kernel/mce_intel.c	2005-05-19 14:25:14.326925568 +0800
@@ -8,12 +8,12 @@
 #include <linux/percpu.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
-#include <asm/mce.h>
 #include <asm/hw_irq.h>
+#include "mce.h"
 
 static DEFINE_PER_CPU(unsigned long, next_check);
 
-asmlinkage void smp_thermal_interrupt(void)
+fastcall void smp_thermal_interrupt(void)
 {
 	struct mce m;
 
diff -rNu 2.6.11.10-mce-prep/include/asm-i386/mach-default/entry_arch.h 2.6.11.10-mce-impl/include/asm-i386/mach-default/entry_arch.h
--- 2.6.11.10-mce-prep/include/asm-i386/mach-default/entry_arch.h	2005-05-18 16:57:35.000000000 +0800
+++ 2.6.11.10-mce-impl/include/asm-i386/mach-default/entry_arch.h	2005-05-18 17:20:29.000000000 +0800
@@ -27,7 +27,7 @@
 BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
 BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
 
-#ifdef CONFIG_X86_MCE_P4THERMAL
+#ifdef CONFIG_X86_MCE_INTEL
 BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
 #endif
 



