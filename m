Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUL0PJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUL0PJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbUL0PJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:09:49 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:27364 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261900AbUL0PIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:08:04 -0500
Message-ID: <41D033FE.7AD17627@tv-sign.ru>
Date: Mon, 27 Dec 2004 19:10:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@HansenPartnership.com,
       paulus@samba.org, wli@holomorphy.com, davem@davemloft.net,
       lethal@linux-sh.org, davidm@hpl.hp.com, schwidefsky@de.ibm.com,
       takata@inux-m32r.org, ak@suse.de, rth@twiddle.net, matthew@wil.cx
Subject: [PATCH] fix conflicting cpu_idle() declarations
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_idle() declared/defined in

init/main.c:				void cpu_idle(void)

i386/kernel/process.c			void cpu_idle(void)
i386/kernel/smpboot.c:			int  cpu_idle(void)
i386/mach-voyager/voyager_smp.c:	int  cpu_idle(void)

ppc/kernel/idle.c:			int  cpu_idle(void)
ppc/kernel/smp.c:			int  cpu_idle(void *unused)

ppc64/kernel/idle.c:			int  cpu_idle(void)
ppc64/kernel/smp.c:			int  cpu_idle(void *unused)

sparc/kernel/process.c:			int  cpu_idle(void)

sparc64/kernel/process.c:		int  cpu_idle(void)

sh/kernel/process.c:			void cpu_idle(void *unused)
sh/kernel/smp.c:			int  cpu_idle(void *unused)

ia64/kernel/smpboot.c:			int  cpu_idle(void)
ia64/kernel/process.c:			void cpu_idle(void *unused)

sh64/kernel/process.c:			void cpu_idle(void *unused)

s390/kernel/process.c:			int  cpu_idle(void)
s390/kernel/smp.c:			int  cpu_idle(void * unused)

m32r/kernel/process.c:			void cpu_idle(void)
m32r/kernel/smpboot.c			int  cpu_idle(void)

Other arches beleive that cpu_idle is void(void).

This patch puts 'void cpu_idle(void)' in include/linux/smp.h
and fixes conflicting definitions.

Also removes now unneeded declarations in x86_64, alpha, parisc.

Only i386 part is tested.

diffstat output:
 arch/alpha/kernel/proto.h            |    3 ---
 arch/i386/kernel/smpboot.c           |    6 ++----
 arch/i386/mach-voyager/voyager_smp.c |    5 ++---
 arch/ia64/kernel/process.c           |    2 +-
 arch/ia64/kernel/smpboot.c           |    5 ++---
 arch/m32r/kernel/smpboot.c           |    4 ++--
 arch/parisc/kernel/smp.c             |    1 -
 arch/ppc/kernel/idle.c               |    3 +--
 arch/ppc/kernel/smp.c                |    4 ++--
 arch/ppc64/kernel/idle.c             |    3 +--
 arch/ppc64/kernel/smp.c              |    4 ++--
 arch/s390/kernel/process.c           |    3 +--
 arch/s390/kernel/smp.c               |    4 ++--
 arch/sh/kernel/process.c             |    2 +-
 arch/sh/kernel/smp.c                 |    4 ++--
 arch/sh64/kernel/process.c           |    2 +-
 arch/sparc/kernel/process.c          |    9 +++------
 arch/sparc/kernel/sun4d_smp.c        |    1 -
 arch/sparc/kernel/sun4m_smp.c        |    1 -
 arch/sparc64/kernel/process.c        |    8 ++++----
 include/asm-x86_64/proto.h           |    1 -
 include/linux/smp.h                  |    2 ++
 init/main.c                          |    1 -
 23 files changed, 31 insertions(+), 47 deletions(-)

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10/include/linux/smp.h~1_common	2004-09-13 09:32:48.000000000 +0400
+++ 2.6.10/include/linux/smp.h	2004-12-27 16:27:17.948723368 +0300
@@ -8,6 +8,8 @@
 
 #include <linux/config.h>
 
+extern void cpu_idle(void);
+
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
--- 2.6.10/init/main.c~1_common	2004-11-15 17:12:20.000000000 +0300
+++ 2.6.10/init/main.c	2004-12-27 16:31:11.510216624 +0300
@@ -359,7 +359,6 @@ static int __init init_setup(char *str)
 __setup("init=", init_setup);
 
 extern void setup_arch(char **);
-extern void cpu_idle(void);
 
 #ifndef CONFIG_SMP
 
--- 2.6.10/arch/i386/kernel/smpboot.c~2_i386	2004-12-27 17:20:45.089163000 +0300
+++ 2.6.10/arch/i386/kernel/smpboot.c	2004-12-27 17:22:21.854453352 +0300
@@ -411,12 +411,10 @@ void __init smp_callin(void)
 
 int cpucount;
 
-extern int cpu_idle(void);
-
 /*
  * Activate a secondary processor.
  */
-int __init start_secondary(void *unused)
+static void __init start_secondary(void *unused)
 {
 	/*
 	 * Dont put anything before smp_callin(), SMP
@@ -441,7 +439,7 @@ int __init start_secondary(void *unused)
 	local_flush_tlb();
 	cpu_set(smp_processor_id(), cpu_online_map);
 	wmb();
-	return cpu_idle();
+	cpu_idle();
 }
 
 /*
--- 2.6.10/arch/i386/mach-voyager/voyager_smp.c~2_i386	2004-12-25 16:55:37.000000000 +0300
+++ 2.6.10/arch/i386/mach-voyager/voyager_smp.c	2004-12-27 17:30:53.201716752 +0300
@@ -457,13 +457,12 @@ setup_trampoline(void)
 }
 
 /* Routine initially called when a non-boot CPU is brought online */
-int __init
+static void __init
 start_secondary(void *unused)
 {
 	__u8 cpuid = hard_smp_processor_id();
 	/* external functions not defined in the headers */
 	extern void calibrate_delay(void);
-	extern int cpu_idle(void);
 
 	cpu_init();
 
@@ -520,7 +519,7 @@ start_secondary(void *unused)
 
 	cpu_set(cpuid, cpu_online_map);
 	wmb();
-	return cpu_idle();
+	cpu_idle();
 }
 
 
--- 2.6.10/arch/ppc/kernel/idle.c~3_ppc	2004-09-13 09:31:27.000000000 +0400
+++ 2.6.10/arch/ppc/kernel/idle.c	2004-12-27 17:50:07.372530568 +0300
@@ -57,14 +57,13 @@ void default_idle(void)
 /*
  * The body of the idle task.
  */
-int cpu_idle(void)
+void cpu_idle(void)
 {
 	for (;;)
 		if (ppc_md.idle != NULL)
 			ppc_md.idle();
 		else
 			default_idle();
-	return 0;
 }
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_6xx)
--- 2.6.10/arch/ppc/kernel/smp.c~3_ppc	2004-09-13 09:33:37.000000000 +0400
+++ 2.6.10/arch/ppc/kernel/smp.c	2004-12-27 17:51:21.440270560 +0300
@@ -60,7 +60,6 @@ static struct smp_ops_t *smp_ops;
 volatile unsigned long cpu_callin_map[NR_CPUS];
 
 int start_secondary(void *);
-extern int cpu_idle(void *unused);
 void smp_call_function_interrupt(void);
 static int __smp_call_function(void (*func) (void *info), void *info,
 			       int wait, int target);
@@ -358,7 +357,8 @@ int __devinit start_secondary(void *unus
 	smp_ops->take_timebase();
 	printk("CPU %i done timebase take...\n", cpu);
 
-	return cpu_idle(NULL);
+	cpu_idle();
+	return 0;
 }
 
 int __cpu_up(unsigned int cpu)
--- 2.6.10/arch/ppc64/kernel/smp.c~4_ppc64	2004-12-25 16:55:50.000000000 +0300
+++ 2.6.10/arch/ppc64/kernel/smp.c	2004-12-27 18:04:38.840047368 +0300
@@ -74,7 +74,6 @@ static volatile unsigned int cpu_callin_
 
 extern unsigned char stab_array[];
 
-extern int cpu_idle(void *unused);
 void smp_call_function_interrupt(void);
 
 int smt_enabled_at_boot = 1;
@@ -523,7 +522,8 @@ int __devinit start_secondary(void *unus
 
 	local_irq_enable();
 
-	return cpu_idle(NULL);
+	cpu_idle();
+	return 0;
 }
 
 int setup_profiling_timer(unsigned int multiplier)
--- 2.6.10/arch/ppc64/kernel/idle.c~4_ppc64	2004-11-15 17:12:13.000000000 +0300
+++ 2.6.10/arch/ppc64/kernel/idle.c	2004-12-27 18:07:19.299653800 +0300
@@ -298,10 +298,9 @@ static int native_idle(void)
 
 #endif /* CONFIG_PPC_ISERIES */
 
-int cpu_idle(void)
+void cpu_idle(void)
 {
 	idle_loop();
-	return 0;
 }
 
 int powersave_nap;
--- 2.6.10/arch/sparc/kernel/sun4d_smp.c~5_sparc	2004-09-13 09:31:31.000000000 +0400
+++ 2.6.10/arch/sparc/kernel/sun4d_smp.c	2004-12-27 18:13:46.034861112 +0300
@@ -146,7 +146,6 @@ void __init smp4d_callin(void)
 	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
 }
 
-extern int cpu_idle(void *unused);
 extern void init_IRQ(void);
 extern void cpu_panic(void);
 
--- 2.6.10/arch/sparc/kernel/sun4m_smp.c~5_sparc	2004-09-13 09:33:23.000000000 +0400
+++ 2.6.10/arch/sparc/kernel/sun4m_smp.c	2004-12-27 18:15:40.670433856 +0300
@@ -121,7 +121,6 @@ void __init smp4m_callin(void)
 	local_irq_enable();
 }
 
-extern int cpu_idle(void *unused);
 extern void init_IRQ(void);
 extern void cpu_panic(void);
 
--- 2.6.10/arch/sparc/kernel/process.c~5_sparc	2004-12-25 16:55:38.000000000 +0300
+++ 2.6.10/arch/sparc/kernel/process.c	2004-12-27 18:22:16.053326520 +0300
@@ -81,10 +81,8 @@ void default_idle(void)
 /*
  * the idle loop on a Sparc... ;)
  */
-int cpu_idle(void)
+void cpu_idle(void)
 {
-	int ret = -EPERM;
-
 	if (current->pid != 0)
 		goto out;
 
@@ -128,15 +126,14 @@ int cpu_idle(void)
 		schedule();
 		check_pgt_cache();
 	}
-	ret = 0;
 out:
-	return ret;
+	return;
 }
 
 #else
 
 /* This is being executed in task 0 'user space'. */
-int cpu_idle(void)
+void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while(1) {
--- 2.6.10/arch/sparc64/kernel/process.c~6_sparc64	2004-11-08 19:43:21.000000000 +0300
+++ 2.6.10/arch/sparc64/kernel/process.c	2004-12-27 18:29:58.234064368 +0300
@@ -60,10 +60,10 @@ void default_idle(void)
 /*
  * the idle loop on a Sparc... ;)
  */
-int cpu_idle(void)
+void cpu_idle(void)
 {
 	if (current->pid != 0)
-		return -EPERM;
+		return;
 
 	/* endless idle loop with no priority at all */
 	for (;;) {
@@ -80,7 +80,7 @@ int cpu_idle(void)
 		schedule();
 		check_pgt_cache();
 	}
-	return 0;
+	return;
 }
 
 #else
@@ -90,7 +90,7 @@ int cpu_idle(void)
  */
 #define idle_me_harder()	(cpu_data(smp_processor_id()).idle_volume += 1)
 #define unidle_me()		(cpu_data(smp_processor_id()).idle_volume = 0)
-int cpu_idle(void)
+void cpu_idle(void)
 {
 	set_thread_flag(TIF_POLLING_NRFLAG);
 	while(1) {
--- 2.6.10/arch/sh/kernel/process.c~7_sh	2004-11-08 19:43:21.000000000 +0300
+++ 2.6.10/arch/sh/kernel/process.c	2004-12-27 18:49:36.302970672 +0300
@@ -68,7 +68,7 @@ void default_idle(void)
 	}
 }
 
-void cpu_idle(void *unused)
+void cpu_idle(void)
 {
 	default_idle();
 }
--- 2.6.10/arch/sh/kernel/smp.c~7_sh	2004-09-13 09:32:27.000000000 +0400
+++ 2.6.10/arch/sh/kernel/smp.c	2004-12-27 18:51:04.487564576 +0300
@@ -37,7 +37,6 @@
 int smp_threads_ready = 0;
 struct sh_cpuinfo cpu_data[NR_CPUS];
 
-extern int cpu_idle(void *unused);
 extern void per_cpu_trap_init(void);
 
 cpumask_t cpu_possible_map;
@@ -124,7 +123,8 @@ int start_secondary(void *unused)
 	
 	atomic_inc(&cpus_booted);
 
-	return cpu_idle(0);
+	cpu_idle();
+	return 0;
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
--- 2.6.10/arch/ia64/kernel/smpboot.c~8_ia64	2004-11-08 19:43:20.000000000 +0300
+++ 2.6.10/arch/ia64/kernel/smpboot.c	2004-12-27 18:53:42.049611504 +0300
@@ -343,8 +343,6 @@ smp_callin (void)
 int __devinit
 start_secondary (void *unused)
 {
-	extern int cpu_idle (void);
-
 	/* Early console may use I/O ports */
 	ia64_set_kr(IA64_KR_IO_BASE, __pa(ia64_iobase));
 
@@ -353,7 +351,8 @@ start_secondary (void *unused)
 	cpu_init();
 	smp_callin();
 
-	return cpu_idle();
+	cpu_idle();
+	return 0;
 }
 
 struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
--- 2.6.10/arch/ia64/kernel/process.c~8_ia64	2004-12-25 16:55:37.000000000 +0300
+++ 2.6.10/arch/ia64/kernel/process.c	2004-12-27 18:55:46.969620776 +0300
@@ -226,7 +226,7 @@ static inline void play_dead(void)
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void __attribute__((noreturn))
-cpu_idle (void *unused)
+cpu_idle (void)
 {
 	void (*mark_idle)(int) = ia64_mark_idle;
 
--- 2.6.10/arch/sh64/kernel/process.c~9_sh64	2004-11-08 19:43:21.000000000 +0300
+++ 2.6.10/arch/sh64/kernel/process.c	2004-12-27 18:59:06.968216368 +0300
@@ -338,7 +338,7 @@ void default_idle(void)
 	}
 }
 
-void cpu_idle(void *unused)
+void cpu_idle(void)
 {
 	default_idle();
 }
--- 2.6.10/arch/s390/kernel/process.c~10_s390	2004-11-08 19:43:21.000000000 +0300
+++ 2.6.10/arch/s390/kernel/process.c	2004-12-27 19:03:10.364214552 +0300
@@ -159,11 +159,10 @@ void default_idle(void)
 #endif /* CONFIG_ARCH_S390X */
 }
 
-int cpu_idle(void)
+void cpu_idle(void)
 {
 	for (;;)
 		default_idle();
-	return 0;
 }
 
 void show_regs(struct pt_regs *regs)
--- 2.6.10/arch/s390/kernel/smp.c~10_s390	2004-09-13 09:31:26.000000000 +0400
+++ 2.6.10/arch/s390/kernel/smp.c	2004-12-27 19:04:49.981070488 +0300
@@ -42,7 +42,6 @@
 #include <asm/tlbflush.h>
 
 /* prototypes */
-extern int cpu_idle(void * unused);
 
 extern volatile int __cpu_logical_map[];
 
@@ -557,7 +556,8 @@ int __devinit start_secondary(void *cpuv
         /* Print info about this processor */
         print_cpu_info(&S390_lowcore.cpu_data);
         /* cpu_idle will call schedule for us */
-        return cpu_idle(NULL);
+        cpu_idle();
+        return 0;
 }
 
 static void __init smp_create_idle(unsigned int cpu)
--- 2.6.10/arch/m32r/kernel/smpboot.c~11_m32	2004-11-15 17:12:12.000000000 +0300
+++ 2.6.10/arch/m32r/kernel/smpboot.c	2004-12-27 19:20:27.142600280 +0300
@@ -58,7 +58,6 @@
 #define Dprintk(x...)
 #endif
 
-extern int cpu_idle(void);
 extern cpumask_t cpu_initialized;
 
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
@@ -443,7 +442,8 @@ int __init start_secondary(void *unused)
 	 */
 	local_flush_tlb_all();
 
-	return cpu_idle();
+	cpu_idle();
+	return 0;
 }
 
 /*==========================================================================*
--- 2.6.10/include/asm-x86_64/proto.h~12_x86_64	2004-11-15 17:12:20.000000000 +0300
+++ 2.6.10/include/asm-x86_64/proto.h	2004-12-27 21:08:05.135836080 +0300
@@ -26,7 +26,6 @@ extern void ia32_cstar_target(void); 
 extern void ia32_sysenter_target(void); 
 
 extern void calibrate_delay(void);
-extern void cpu_idle(void);
 extern void config_acpi_tables(void);
 extern void ia32_syscall(void);
 extern void iommu_hole_init(void);
--- 2.6.10/arch/alpha/kernel/proto.h~13_alpha	2004-09-13 09:31:57.000000000 +0400
+++ 2.6.10/arch/alpha/kernel/proto.h	2004-12-27 21:11:43.330665424 +0300
@@ -167,9 +167,6 @@ extern void entSys(void);
 extern void entUna(void);
 extern void entDbg(void);
 
-/* process.c */
-extern void cpu_idle(void) __attribute__((noreturn));
-
 /* ptrace.c */
 extern int ptrace_set_bpt (struct task_struct *child);
 extern int ptrace_cancel_bpt (struct task_struct *child);
--- 2.6.10/arch/parisc/kernel/smp.c~14_parisc	2004-11-15 17:12:12.000000000 +0300
+++ 2.6.10/arch/parisc/kernel/smp.c	2004-12-27 21:12:33.967967384 +0300
@@ -459,7 +459,6 @@ smp_cpu_init(int cpunum)
  */
 void __init smp_callin(void)
 {
-	extern void cpu_idle(void);	/* arch/parisc/kernel/process.c */
 	int slave_id = cpu_now_booting;
 #if 0
 	void *istack;
