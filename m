Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVLMBsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVLMBsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 20:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLMBsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 20:48:46 -0500
Received: from fmr22.intel.com ([143.183.121.14]:8402 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932342AbVLMBsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 20:48:45 -0500
Date: Mon, 12 Dec 2005 17:48:19 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: [PATCH 1/3]i386,x86-64 (take 2) Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051212174819.B10234@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove the finer control of local APIC timer. We cannot provide a sub-jiffy
control like this when we use broadcast from external timer in place of 
local APIC. Instead of removing this only on systems that may end up using 
broadcast from external timer (due to C3), I am going the
"I'm feeling lucky" way to remove this fully. Basically, I am not sure about
usefulness of this code today. Few other architectures also don't seem to 
support this today. 

If you are using profiling and fine grained control and don't like this going
away in normal case, yell at me right now.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.15-rc3/arch/x86_64/kernel/apic.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/x86_64/kernel/apic.c
+++ linux-2.6.15-rc3/arch/x86_64/kernel/apic.c
@@ -41,10 +41,6 @@ int disable_apic_timer __initdata;
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer = 0;
 
-static DEFINE_PER_CPU(int, prof_multiplier) = 1;
-static DEFINE_PER_CPU(int, prof_old_multiplier) = 1;
-static DEFINE_PER_CPU(int, prof_counter) = 1;
-
 static void apic_pm_activate(void);
 
 void enable_NMI_through_LVT0 (void * dummy)
@@ -805,32 +801,9 @@ void enable_APIC_timer(void)
 	}
 }
 
-/*
- * the frequency of the profiling timer can be changed
- * by writing a multiplier value into /proc/profile.
- */
 int setup_profiling_timer(unsigned int multiplier)
 {
-	int i;
-
-	/*
-	 * Sanity check. [at least 500 APIC cycles should be
-	 * between APIC interrupts as a rule of thumb, to avoid
-	 * irqs flooding us]
-	 */
-	if ( (!multiplier) || (calibration_result/multiplier < 500))
-		return -EINVAL;
-
-	/* 
-	 * Set the new multiplier for each CPU. CPUs don't start using the
-	 * new values until the next timer interrupt in which they do process
-	 * accounting. At that time they also adjust their APIC timers
-	 * accordingly.
-	 */
-	for (i = 0; i < NR_CPUS; ++i)
-		per_cpu(prof_multiplier, i) = multiplier;
-
-	return 0;
+	return -EINVAL;
 }
 
 #ifdef CONFIG_X86_MCE_AMD
@@ -857,32 +830,10 @@ void setup_threshold_lvt(unsigned long l
 
 void smp_local_timer_interrupt(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
-
 	profile_tick(CPU_PROFILING, regs);
-	if (--per_cpu(prof_counter, cpu) <= 0) {
-		/*
-		 * The multiplier may have changed since the last time we got
-		 * to this point as a result of the user writing to
-		 * /proc/profile. In this case we need to adjust the APIC
-		 * timer accordingly.
-		 *
-		 * Interrupts are already masked off at this point.
-		 */
-		per_cpu(prof_counter, cpu) = per_cpu(prof_multiplier, cpu);
-		if (per_cpu(prof_counter, cpu) != 
-		    per_cpu(prof_old_multiplier, cpu)) {
-			__setup_APIC_LVTT(calibration_result/
-					per_cpu(prof_counter, cpu));
-			per_cpu(prof_old_multiplier, cpu) =
-				per_cpu(prof_counter, cpu);
-		}
-
 #ifdef CONFIG_SMP
-		update_process_times(user_mode(regs));
+	update_process_times(user_mode(regs));
 #endif
-	}
-
 	/*
 	 * We take the 'long' return path, and there every subsystem
 	 * grabs the appropriate locks (kernel lock/ irq lock).
Index: linux-2.6.15-rc3/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/i386/kernel/apic.c
+++ linux-2.6.15-rc3/arch/i386/kernel/apic.c
@@ -92,10 +92,6 @@ void __init apic_intr_init(void)
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer = 0;
 
-static DEFINE_PER_CPU(int, prof_multiplier) = 1;
-static DEFINE_PER_CPU(int, prof_old_multiplier) = 1;
-static DEFINE_PER_CPU(int, prof_counter) = 1;
-
 static int enabled_via_apicbase;
 
 void enable_NMI_through_LVT0 (void * dummy)
@@ -1092,34 +1088,6 @@ void enable_APIC_timer(void)
 	}
 }
 
-/*
- * the frequency of the profiling timer can be changed
- * by writing a multiplier value into /proc/profile.
- */
-int setup_profiling_timer(unsigned int multiplier)
-{
-	int i;
-
-	/*
-	 * Sanity check. [at least 500 APIC cycles should be
-	 * between APIC interrupts as a rule of thumb, to avoid
-	 * irqs flooding us]
-	 */
-	if ( (!multiplier) || (calibration_result/multiplier < 500))
-		return -EINVAL;
-
-	/* 
-	 * Set the new multiplier for each CPU. CPUs don't start using the
-	 * new values until the next timer interrupt in which they do process
-	 * accounting. At that time they also adjust their APIC timers
-	 * accordingly.
-	 */
-	for (i = 0; i < NR_CPUS; ++i)
-		per_cpu(prof_multiplier, i) = multiplier;
-
-	return 0;
-}
-
 #undef APIC_DIVISOR
 
 /*
@@ -1134,32 +1102,10 @@ int setup_profiling_timer(unsigned int m
 
 inline void smp_local_timer_interrupt(struct pt_regs * regs)
 {
-	int cpu = smp_processor_id();
-
 	profile_tick(CPU_PROFILING, regs);
-	if (--per_cpu(prof_counter, cpu) <= 0) {
-		/*
-		 * The multiplier may have changed since the last time we got
-		 * to this point as a result of the user writing to
-		 * /proc/profile. In this case we need to adjust the APIC
-		 * timer accordingly.
-		 *
-		 * Interrupts are already masked off at this point.
-		 */
-		per_cpu(prof_counter, cpu) = per_cpu(prof_multiplier, cpu);
-		if (per_cpu(prof_counter, cpu) !=
-					per_cpu(prof_old_multiplier, cpu)) {
-			__setup_APIC_LVTT(
-					calibration_result/
-					per_cpu(prof_counter, cpu));
-			per_cpu(prof_old_multiplier, cpu) =
-						per_cpu(prof_counter, cpu);
-		}
-
 #ifdef CONFIG_SMP
-		update_process_times(user_mode_vm(regs));
+	update_process_times(user_mode_vm(regs));
 #endif
-	}
 
 	/*
 	 * We take the 'long' return path, and there every subsystem
@@ -1206,6 +1152,11 @@ fastcall void smp_apic_timer_interrupt(s
 	irq_exit();
 }
 
+int setup_profiling_timer(unsigned int multiplier)
+{
+	return -EINVAL;
+}
+
 /*
  * This interrupt should _never_ happen with our APIC/SMP architecture
  */
