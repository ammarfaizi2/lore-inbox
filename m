Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbVLFFG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbVLFFG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbVLFFG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:06:28 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:18585 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751649AbVLFFG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:06:27 -0500
Subject: Nick's preempt nosched patch.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133844903.5501.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 15:02:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

A while ago I had a problem with cpu hotplug failing to take down cpus
due to preemption problems. Nick prepared a patch (included below) that
fixed this, but it's not yet in mainline. The problem seems to have
disappeared on my work desktop (so I thought it had been applied until I
did a quick check), but a suspend2 user has just reported the problem
again. Can look at applying this or something better in mainline,
please?

Regards,

Nigel

 arch/arm/kernel/process.c         |    4 ++--
 arch/arm/kernel/smp.c             |    5 ++++-
 arch/arm26/kernel/process.c       |   12 +++++-------
 arch/cris/arch-v32/kernel/smp.c   |    2 ++
 arch/cris/kernel/process.c        |    2 ++
 arch/frv/kernel/process.c         |    6 +++++-
 arch/h8300/kernel/process.c       |   28 +++++++++++++++-------------
 arch/i386/kernel/process.c        |    4 +++-
 arch/i386/kernel/smpboot.c        |    2 ++
 arch/ia64/kernel/process.c        |    2 ++
 arch/ia64/kernel/smpboot.c        |    2 ++
 arch/m32r/kernel/process.c        |    2 ++
 arch/m32r/kernel/smpboot.c        |    1 +
 arch/m68k/kernel/process.c        |    2 ++
 arch/mips/kernel/process.c        |    2 ++
 arch/mips/kernel/smp.c            |    6 +++++-
 arch/parisc/kernel/process.c      |    2 ++
 arch/parisc/kernel/smp.c          |    2 ++
 arch/ppc/kernel/idle.c            |   15 ++++++++++-----
 arch/ppc/kernel/smp.c             |    2 ++
 arch/ppc64/kernel/iSeries_setup.c |    4 ++++
 arch/ppc64/kernel/idle.c          |    4 ++++
 arch/ppc64/kernel/pSeries_setup.c |    4 ++++
 arch/ppc64/kernel/smp.c           |    5 ++++-
 arch/s390/kernel/process.c        |   11 ++++++++---
 arch/s390/kernel/smp.c            |    2 ++
 arch/sh/kernel/process.c          |    2 ++
 arch/sh/kernel/smp.c              |    6 +++++-
 arch/sh64/kernel/process.c        |    2 ++
 arch/sparc/kernel/process.c       |    4 ++++
 arch/sparc64/kernel/process.c     |    4 ++++
 arch/sparc64/kernel/smp.c         |    3 +++
 arch/v850/kernel/process.c        |   16 ++++++++++------
 arch/x86_64/kernel/process.c      |    2 ++
 arch/x86_64/kernel/smpboot.c      |    1 +
 arch/xtensa/kernel/process.c      |    3 ++-
 init/main.c                       |    4 +++-
 37 files changed, 136 insertions(+), 44 deletions(-)
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/arm/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/arm/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/arm/kernel/process.c	2005-11-11 13:11:53.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/arm/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -107,13 +107,13 @@ void cpu_idle(void)
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
-		preempt_disable();
 		leds_event(led_idle_start);
 		while (!need_resched())
 			idle();
 		leds_event(led_idle_end);
-		preempt_enable();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/arm/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/arm/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/arm/kernel/smp.c	2005-11-11 13:11:53.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/arm/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -162,7 +162,10 @@ int __cpuinit __cpu_up(unsigned int cpu)
 asmlinkage void __cpuinit secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	preempt_disable();
+	cpu = smp_processor_id();
 
 	printk("CPU%u: Booted secondary processor\n", cpu);
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/arm26/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/arm26/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/arm26/kernel/process.c	2005-11-11 13:11:56.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/arm26/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -74,15 +74,13 @@ __setup("hlt", hlt_setup);
 void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
-	preempt_disable();
 	while (1) {
-		while (!need_resched()) {
-			local_irq_disable();
-			if (!need_resched() && !hlt_counter)
-				local_irq_enable();
-		}
+		while (!need_resched())
+			cpu_relax();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
 	}
-	schedule();
 }
 
 static char reboot_mode = 'h';
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/cris/arch-v32/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/cris/arch-v32/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/cris/arch-v32/kernel/smp.c	2005-11-11 13:11:57.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/cris/arch-v32/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -146,6 +146,8 @@ void __init smp_callin(void)
 	int cpu = cpu_now_booting;
 	reg_intr_vect_rw_mask vect_mask = {0};
 
+	preempt_disable();
+
 	/* Initialise the idle task for this CPU */
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/cris/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/cris/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/cris/kernel/process.c	2005-11-11 13:11:57.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/cris/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -218,7 +218,9 @@ void cpu_idle (void)
 				idle = default_idle;
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/frv/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/frv/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/frv/kernel/process.c	2005-11-11 13:11:57.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/frv/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -77,16 +77,20 @@ void (*idle)(void) = core_sleep_idle;
  */
 void cpu_idle(void)
 {
+	int cpu = smp_processor_id();
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
+			irq_stat[cpu].idle_timestamp = jiffies;
 
 			if (!frv_dma_inprogress && idle)
 				idle();
 		}
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/h8300/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/h8300/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/h8300/kernel/process.c	2005-11-11 13:11:57.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/h8300/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -53,22 +53,18 @@ asmlinkage void ret_from_fork(void);
 #if !defined(CONFIG_H8300H_SIM) && !defined(CONFIG_H8S_SIM)
 void default_idle(void)
 {
-	while(1) {
-		if (!need_resched()) {
-			local_irq_enable();
-			__asm__("sleep");
-			local_irq_disable();
-		}
-		schedule();
-	}
+	local_irq_disable();
+	if (!need_resched()) {
+		local_irq_enable();
+		/* XXX: race here! What if need_resched() gets set now? */
+		__asm__("sleep");
+	} else
+		local_irq_enable();
 }
 #else
 void default_idle(void)
 {
-	while(1) {
-		if (need_resched())
-			schedule();
-	}
+	cpu_relax();
 }
 #endif
 void (*idle)(void) = default_idle;
@@ -81,7 +77,13 @@ void (*idle)(void) = default_idle;
  */
 void cpu_idle(void)
 {
-	idle();
+	while (1) {
+		while (!need_resched())
+			idle();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 void machine_restart(char * __unused)
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/i386/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/i386/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/i386/kernel/process.c	2005-11-11 13:11:58.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/i386/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -179,7 +179,7 @@ static inline void play_dead(void)
  */
 void cpu_idle(void)
 {
-	int cpu = raw_smp_processor_id();
+	int cpu = smp_processor_id();
 
 	/* endless idle loop with no priority at all */
 	while (1) {
@@ -201,7 +201,9 @@ void cpu_idle(void)
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/i386/kernel/smpboot.c 9210-sched-no-preempt-idle.patch-new/arch/i386/kernel/smpboot.c
--- 9210-sched-no-preempt-idle.patch-old/arch/i386/kernel/smpboot.c	2005-12-06 14:50:23.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/i386/kernel/smpboot.c	2005-12-06 14:49:24.000000000 +1000
@@ -485,6 +485,8 @@ set_cpu_sibling_map(int cpu)
  */
 static void __devinit start_secondary(void *unused)
 {
+	preempt_disable();
+
 	/*
 	 * Dont put anything before smp_callin(), SMP
 	 * booting is too fragile that we want to limit the
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/ia64/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/ia64/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/ia64/kernel/process.c	2005-11-11 13:12:00.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/ia64/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -292,7 +292,9 @@ cpu_idle (void)
 #ifdef CONFIG_SMP
 		normal_xtp();
 #endif
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 		if (cpu_is_offline(smp_processor_id()))
 			play_dead();
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/ia64/kernel/smpboot.c 9210-sched-no-preempt-idle.patch-new/arch/ia64/kernel/smpboot.c
--- 9210-sched-no-preempt-idle.patch-old/arch/ia64/kernel/smpboot.c	2005-11-11 13:12:00.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/ia64/kernel/smpboot.c	2005-12-06 14:49:24.000000000 +1000
@@ -394,6 +394,8 @@ smp_callin (void)
 int __devinit
 start_secondary (void *unused)
 {
+	preempt_disable();
+
 	/* Early console may use I/O ports */
 	ia64_set_kr(IA64_KR_IO_BASE, __pa(ia64_iobase));
 	Dprintk("start_secondary: starting CPU 0x%x\n", hard_smp_processor_id());
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/m32r/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/m32r/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/m32r/kernel/process.c	2005-11-11 13:12:00.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/m32r/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -104,7 +104,9 @@ void cpu_idle (void)
 
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/m32r/kernel/smpboot.c 9210-sched-no-preempt-idle.patch-new/arch/m32r/kernel/smpboot.c
--- 9210-sched-no-preempt-idle.patch-old/arch/m32r/kernel/smpboot.c	2005-11-11 13:12:01.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/m32r/kernel/smpboot.c	2005-12-06 14:49:24.000000000 +1000
@@ -425,6 +425,7 @@ void __init smp_cpus_done(unsigned int m
  *==========================================================================*/
 int __init start_secondary(void *unused)
 {
+	preempt_disable();
 	cpu_init();
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/m68k/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/m68k/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/m68k/kernel/process.c	2005-11-11 13:12:01.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/m68k/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -102,7 +102,9 @@ void cpu_idle(void)
 	while (1) {
 		while (!need_resched())
 			idle();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/mips/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/mips/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/mips/kernel/process.c	2005-11-11 13:12:03.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/mips/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -58,7 +58,9 @@ ATTRIB_NORET void cpu_idle(void)
 		while (!need_resched())
 			if (cpu_wait)
 				(*cpu_wait)();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable()
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/mips/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/mips/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/mips/kernel/smp.c	2005-11-11 13:12:03.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/mips/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -83,7 +83,11 @@ extern ATTRIB_NORET void cpu_idle(void);
  */
 asmlinkage void start_secondary(void)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	preempt_disable();
+
+	cpu = smp_processor_id();
 
 	cpu_probe();
 	cpu_report();
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/parisc/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/parisc/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/parisc/kernel/process.c	2005-11-11 13:12:05.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/parisc/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -92,7 +92,9 @@ void cpu_idle(void)
 	while (1) {
 		while (!need_resched())
 			barrier();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/parisc/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/parisc/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/parisc/kernel/smp.c	2005-11-11 13:12:05.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/parisc/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -462,6 +462,8 @@ void __init smp_callin(void)
 	void *istack;
 #endif
 
+	preempt_disable();
+
 	smp_cpu_init(slave_id);
 
 #if 0	/* NOT WORKING YET - see entry.S */
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/ppc/kernel/idle.c 9210-sched-no-preempt-idle.patch-new/arch/ppc/kernel/idle.c
--- 9210-sched-no-preempt-idle.patch-old/arch/ppc/kernel/idle.c	2005-11-11 13:12:06.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/ppc/kernel/idle.c	2005-12-06 14:49:24.000000000 +1000
@@ -52,10 +52,6 @@ void default_idle(void)
 		}
 #endif
 	}
-	if (need_resched())
-		schedule();
-	if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
-		cpu_die();
 }
 
 /*
@@ -63,11 +59,20 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
-	for (;;)
+	for (;;) {
 		if (ppc_md.idle != NULL)
 			ppc_md.idle();
 		else
 			default_idle();
+		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
+			cpu_die();
+		if (need_resched()) {
+			preempt_enable_no_resched();
+			schedule();
+			preempt_disable();
+		}
+
+	}
 }
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_6xx)
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/ppc/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/ppc/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/ppc/kernel/smp.c	2005-11-11 13:12:06.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/ppc/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -339,6 +339,8 @@ int __devinit start_secondary(void *unus
 {
 	int cpu;
 
+	preempt_disable();
+
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/ppc64/kernel/idle.c 9210-sched-no-preempt-idle.patch-new/arch/ppc64/kernel/idle.c
--- 9210-sched-no-preempt-idle.patch-old/arch/ppc64/kernel/idle.c	2005-11-11 13:12:08.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/ppc64/kernel/idle.c	2005-12-06 14:49:24.000000000 +1000
@@ -60,7 +60,9 @@ int default_idle(void)
 		}
 
 		ppc64_runlatch_on();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
@@ -78,7 +80,9 @@ int native_idle(void)
 
 		if (need_resched()) {
 			ppc64_runlatch_on();
+			preempt_enable_no_resched();
 			schedule();
+			preempt_disable();
 		}
 
 		if (cpu_is_offline(smp_processor_id()) &&
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/ppc64/kernel/iSeries_setup.c 9210-sched-no-preempt-idle.patch-new/arch/ppc64/kernel/iSeries_setup.c
--- 9210-sched-no-preempt-idle.patch-old/arch/ppc64/kernel/iSeries_setup.c	2005-11-11 13:12:08.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/ppc64/kernel/iSeries_setup.c	2005-12-06 14:49:24.000000000 +1000
@@ -898,7 +898,9 @@ static int iseries_shared_idle(void)
 		if (hvlpevent_is_pending())
 			process_iSeries_events();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 
 	return 0;
@@ -932,7 +934,9 @@ static int iseries_dedicated_idle(void)
 		}
 
 		ppc64_runlatch_on();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 
 	return 0;
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/ppc64/kernel/pSeries_setup.c 9210-sched-no-preempt-idle.patch-new/arch/ppc64/kernel/pSeries_setup.c
--- 9210-sched-no-preempt-idle.patch-old/arch/ppc64/kernel/pSeries_setup.c	2005-11-11 13:12:08.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/ppc64/kernel/pSeries_setup.c	2005-12-06 14:49:24.000000000 +1000
@@ -537,7 +537,9 @@ static int pseries_dedicated_idle(void)
 		lpaca->lppaca.idle = 0;
 		ppc64_runlatch_on();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 
 		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
@@ -581,7 +583,9 @@ static int pseries_shared_idle(void)
 		lpaca->lppaca.idle = 0;
 		ppc64_runlatch_on();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 
 		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/ppc64/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/ppc64/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/ppc64/kernel/smp.c	2005-11-11 13:12:08.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/ppc64/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -545,7 +545,10 @@ int __devinit __cpu_up(unsigned int cpu)
 /* Activate a secondary processor. */
 int __devinit start_secondary(void *unused)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	preempt_disable();
+	cpu = smp_processor_id();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/s390/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/s390/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/s390/kernel/process.c	2005-11-11 13:12:10.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/s390/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -102,7 +102,6 @@ void default_idle(void)
 	local_irq_disable();
         if (need_resched()) {
 		local_irq_enable();
-                schedule();
                 return;
         }
 
@@ -139,8 +138,14 @@ void default_idle(void)
 
 void cpu_idle(void)
 {
-	for (;;)
-		default_idle();
+	for (;;) {
+		while (!need_resched())
+			default_idle();
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 void show_regs(struct pt_regs *regs)
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/s390/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/s390/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/s390/kernel/smp.c	2005-11-11 13:12:10.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/s390/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -531,6 +531,8 @@ extern void pfault_fini(void);
 
 int __devinit start_secondary(void *cpuvoid)
 {
+	preempt_disable();
+
         /* Setup the cpu */
         cpu_init();
         /* init per CPU timer */
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/sh/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/sh/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/sh/kernel/process.c	2005-11-11 13:12:11.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/sh/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -64,7 +64,9 @@ void default_idle(void)
 				cpu_sleep();
 		}
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/sh/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/sh/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/sh/kernel/smp.c	2005-11-11 13:12:11.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/sh/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -112,7 +112,11 @@ int __cpu_up(unsigned int cpu)
 
 int start_secondary(void *unused)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	preempt_disable();
+
+	cpu = smp_processor_id();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/sh64/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/sh64/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/sh64/kernel/process.c	2005-11-11 13:12:11.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/sh64/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -334,7 +334,9 @@ void default_idle(void)
 			}
 			local_irq_enable();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/sparc/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/sparc/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/sparc/kernel/process.c	2005-11-11 13:12:11.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/sparc/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -120,7 +120,9 @@ void cpu_idle(void)
 			(*pm_idle)();
 		}
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
@@ -133,7 +135,9 @@ void cpu_idle(void)
 	/* endless idle loop with no priority at all */
 	while(1) {
 		if(need_resched()) {
+			preempt_enable_no_resched();
 			schedule();
+			preempt_disable();
 			check_pgt_cache();
 		}
 		barrier(); /* or else gcc optimizes... */
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/sparc64/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/sparc64/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/sparc64/kernel/process.c	2005-11-11 13:12:12.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/sparc64/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -74,7 +74,9 @@ void cpu_idle(void)
 		while (!need_resched())
 			barrier();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
@@ -93,7 +95,9 @@ void cpu_idle(void)
 		if (need_resched()) {
 			unidle_me();
 			clear_thread_flag(TIF_POLLING_NRFLAG);
+			preempt_enable_no_resched();
 			schedule();
+			preempt_disable();
 			set_thread_flag(TIF_POLLING_NRFLAG);
 			check_pgt_cache();
 		}
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/sparc64/kernel/smp.c 9210-sched-no-preempt-idle.patch-new/arch/sparc64/kernel/smp.c
--- 9210-sched-no-preempt-idle.patch-old/arch/sparc64/kernel/smp.c	2005-11-11 13:12:12.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/sparc64/kernel/smp.c	2005-12-06 14:49:24.000000000 +1000
@@ -168,6 +168,9 @@ void __init smp_callin(void)
 		rmb();
 
 	cpu_set(cpuid, cpu_online_map);
+
+	/* idle thread is expected to have preempt disabled */
+	preempt_disable();
 }
 
 void cpu_panic(void)
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/v850/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/v850/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/v850/kernel/process.c	2005-11-11 13:12:14.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/v850/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -36,11 +36,8 @@ extern void ret_from_fork (void);
 /* The idle loop.  */
 void default_idle (void)
 {
-	while (1) {
-		while (! need_resched ())
-			asm ("halt; nop; nop; nop; nop; nop" ::: "cc");
-		schedule ();
-	}
+	while (! need_resched ())
+		asm ("halt; nop; nop; nop; nop; nop" ::: "cc");
 }
 
 void (*idle)(void) = default_idle;
@@ -54,7 +51,14 @@ void (*idle)(void) = default_idle;
 void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
-	(*idle) ();
+	while (1) {
+		while (!need_resched())
+			(*idle) ();
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 /*
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/x86_64/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/x86_64/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/x86_64/kernel/process.c	2005-11-11 13:12:15.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/x86_64/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -204,7 +204,9 @@ void cpu_idle (void)
 			idle();
 		}
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/x86_64/kernel/smpboot.c 9210-sched-no-preempt-idle.patch-new/arch/x86_64/kernel/smpboot.c
--- 9210-sched-no-preempt-idle.patch-old/arch/x86_64/kernel/smpboot.c	2005-11-11 13:12:15.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/x86_64/kernel/smpboot.c	2005-12-06 14:49:29.000000000 +1000
@@ -474,6 +474,7 @@ void __cpuinit start_secondary(void)
 	 * things done here to the most necessary things.
 	 */
 	cpu_init();
+	preempt_disable();
 	smp_callin();
 
 	/* otherwise gcc will move up the smp_processor_id before the cpu_init */
diff -ruNp 9210-sched-no-preempt-idle.patch-old/arch/xtensa/kernel/process.c 9210-sched-no-preempt-idle.patch-new/arch/xtensa/kernel/process.c
--- 9210-sched-no-preempt-idle.patch-old/arch/xtensa/kernel/process.c	2005-11-11 13:12:15.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/arch/xtensa/kernel/process.c	2005-12-06 14:49:24.000000000 +1000
@@ -96,8 +96,9 @@ void cpu_idle(void)
 	while (1) {
 		while (!need_resched())
 			platform_idle();
-		preempt_enable();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
diff -ruNp 9210-sched-no-preempt-idle.patch-old/init/main.c 9210-sched-no-preempt-idle.patch-new/init/main.c
--- 9210-sched-no-preempt-idle.patch-old/init/main.c	2005-12-06 14:50:30.000000000 +1000
+++ 9210-sched-no-preempt-idle.patch-new/init/main.c	2005-12-06 14:49:24.000000000 +1000
@@ -418,14 +418,16 @@ static void noinline rest_init(void)
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
 	unlock_kernel();
-	preempt_enable_no_resched();
 
 	/*
 	 * The boot idle thread must execute schedule()
 	 * at least one to get things moving:
 	 */
+	preempt_enable_no_resched();
 	schedule();
+	preempt_disable();
 
+	/* Call into cpu_idle with preempt disabled */
 	cpu_idle();
 } 
 


