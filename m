Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVIUPnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVIUPnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVIUPnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:43:43 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:46416 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751095AbVIUPnm (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 21 Sep 2005 11:43:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type;
  b=JC3ik0W5kgnC350xnl7sj1ucd3ZWMPlTX/bbkwhWiqzzDHpGQQTkXNg9cTFJeRW9ZW8vZOXgdJgj8oWWYTWF1QZ0kbikGpcSRBIq5MQE0wnrx+/kZnP7kvYu2KW8cC4wDj+JFuQf/s8u2HirS5w8/zDddc24sJbr9FKEv95qum0=  ;
Message-ID: <43317F3E.9090207@yahoo.com.au>
Date: Thu, 22 Sep 2005 01:41:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Ian Molton <spyro@f2s.com>
Subject: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
Content-Type: multipart/mixed;
 boundary="------------030003000006030106010109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030003000006030106010109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch should hopefully fix Nigel's bug.

Split out from sched-resched-opt.patch. Tested on i386 with acpi idle
and poll idle (previous iterations tested on various other architectures).

CCed Ian because I am amazed that arm26 ever managed to reschedule
out of the idle task without this... what am I missing?

Andrew please apply

Nick

-- 
SUSE Labs, Novell Inc.


--------------030003000006030106010109
Content-Type: text/plain;
 name="sched-no-preempt-idle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-no-preempt-idle.patch"

Run idle threads with preempt disabled.

Also corrected a bugs in arm26's cpu_idle (make it actually call schedule()).
How did it ever work before?

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/init/main.c
===================================================================
--- linux-2.6.orig/init/main.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/init/main.c	2005-09-22 01:04:03.000000000 +1000
@@ -394,14 +394,16 @@ static void noinline rest_init(void)
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
 
Index: linux-2.6/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/smpboot.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/i386/kernel/smpboot.c	2005-09-22 01:04:03.000000000 +1000
@@ -478,6 +478,8 @@ set_cpu_sibling_map(int cpu)
  */
 static void __devinit start_secondary(void *unused)
 {
+	preempt_disable();
+
 	/*
 	 * Dont put anything before smp_callin(), SMP
 	 * booting is too fragile that we want to limit the
Index: linux-2.6/arch/ia64/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/smpboot.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/smpboot.c	2005-09-22 01:04:03.000000000 +1000
@@ -394,6 +394,8 @@ smp_callin (void)
 int __devinit
 start_secondary (void *unused)
 {
+	preempt_disable();
+
 	/* Early console may use I/O ports */
 	ia64_set_kr(IA64_KR_IO_BASE, __pa(ia64_iobase));
 	Dprintk("start_secondary: starting CPU 0x%x\n", hard_smp_processor_id());
Index: linux-2.6/arch/ppc64/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/sparc64/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/sparc64/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
@@ -147,6 +147,9 @@ void __init smp_callin(void)
 		rmb();
 
 	cpu_set(cpuid, cpu_online_map);
+
+	/* idle thread is expected to have preempt disabled */
+	preempt_disable();
 }
 
 void cpu_panic(void)
Index: linux-2.6/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/s390/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
@@ -531,6 +531,8 @@ extern void pfault_fini(void);
 
 int __devinit start_secondary(void *cpuvoid)
 {
+	preempt_disable();
+
         /* Setup the cpu */
         cpu_init();
         /* init per CPU timer */
Index: linux-2.6/arch/m32r/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/m32r/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
@@ -104,7 +104,9 @@ void cpu_idle (void)
 
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/frv/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/frv/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
 
Index: linux-2.6/arch/cris/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/cris/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/cris/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
@@ -218,7 +218,9 @@ void cpu_idle (void)
 				idle = default_idle;
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/mips/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/ppc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/ppc/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
@@ -339,6 +339,8 @@ int __devinit start_secondary(void *unus
 {
 	int cpu;
 
+	preempt_disable();
+
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
Index: linux-2.6/arch/m68k/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/m68k/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
@@ -102,7 +102,9 @@ void cpu_idle(void)
 	while (1) {
 		while (!need_resched())
 			idle();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/mips/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/mips/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
@@ -58,7 +58,9 @@ ATTRIB_NORET void cpu_idle(void)
 		while (!need_resched())
 			if (cpu_wait)
 				(*cpu_wait)();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable()
 	}
 }
 
Index: linux-2.6/arch/sh/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/sh/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
@@ -109,7 +109,11 @@ int __cpu_up(unsigned int cpu)
 
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
Index: linux-2.6/arch/parisc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/parisc/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
@@ -462,6 +462,8 @@ void __init smp_callin(void)
 	void *istack;
 #endif
 
+	preempt_disable();
+
 	smp_cpu_init(slave_id);
 
 #if 0	/* NOT WORKING YET - see entry.S */
Index: linux-2.6/arch/m32r/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/smpboot.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/m32r/kernel/smpboot.c	2005-09-22 01:04:03.000000000 +1000
@@ -425,6 +425,7 @@ void __init smp_cpus_done(unsigned int m
  *==========================================================================*/
 int __init start_secondary(void *unused)
 {
+	preempt_disable();
 	cpu_init();
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
Index: linux-2.6/arch/arm26/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arm26/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/arm26/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/arm/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/arm/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
 
Index: linux-2.6/arch/h8300/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/h8300/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/xtensa/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/xtensa/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
 
Index: linux-2.6/arch/v850/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/v850/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/v850/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/ppc64/kernel/iSeries_setup.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/iSeries_setup.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/iSeries_setup.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/smpboot.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/x86_64/kernel/smpboot.c	2005-09-22 01:04:03.000000000 +1000
@@ -473,6 +473,7 @@ void __cpuinit start_secondary(void)
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
+	preempt_disable();
 	cpu_init();
 	smp_callin();
 
Index: linux-2.6/arch/arm/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/arm/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
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
 
Index: linux-2.6/arch/cris/arch-v32/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/kernel/smp.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/cris/arch-v32/kernel/smp.c	2005-09-22 01:04:03.000000000 +1000
@@ -144,6 +144,8 @@ void __init smp_callin(void)
 	int cpu = cpu_now_booting;
 	reg_intr_vect_rw_mask vect_mask = {0};
 
+	preempt_disable();
+
 	/* Initialise the idle task for this CPU */
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
Index: linux-2.6/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/i386/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
@@ -181,7 +181,7 @@ static inline void play_dead(void)
  */
 void cpu_idle(void)
 {
-	int cpu = raw_smp_processor_id();
+	int cpu = smp_processor_id();
 
 	/* endless idle loop with no priority at all */
 	while (1) {
@@ -203,7 +203,9 @@ void cpu_idle(void)
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/parisc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/parisc/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/s390/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/s390/kernel/process.c	2005-09-22 01:05:06.000000000 +1000
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
Index: linux-2.6/arch/sh/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/sh/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
@@ -64,7 +64,9 @@ void default_idle(void)
 				cpu_sleep();
 		}
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/sh64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sh64/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/sh64/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
@@ -334,7 +334,9 @@ void default_idle(void)
 			}
 			local_irq_enable();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/sparc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/sparc/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/sparc64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/sparc64/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/process.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/x86_64/kernel/process.c	2005-09-22 01:04:03.000000000 +1000
@@ -204,7 +204,9 @@ void cpu_idle (void)
 			idle();
 		}
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/ppc/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/idle.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/ppc/kernel/idle.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/ppc64/kernel/pSeries_setup.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/pSeries_setup.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/pSeries_setup.c	2005-09-22 01:04:03.000000000 +1000
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
Index: linux-2.6/arch/ppc64/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/idle.c	2005-09-22 01:03:51.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/idle.c	2005-09-22 01:04:03.000000000 +1000
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

--------------030003000006030106010109--
Send instant messages to your online friends http://au.messenger.yahoo.com 
