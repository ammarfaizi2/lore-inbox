Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267688AbTAMMHO>; Mon, 13 Jan 2003 07:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267839AbTAMMHO>; Mon, 13 Jan 2003 07:07:14 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:64735 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267688AbTAMMHM>;
	Mon, 13 Jan 2003 07:07:12 -0500
Date: Mon, 13 Jan 2003 17:58:35 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Make prof_counter use per-cpu areas patch 1/4 -- x86 arch
Message-ID: <20030113122835.GC2714@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here's  a patchset to make prof_counter use percpu area infrastructure.
Right now, prof_counter is a NR_CPUS array which gets modified every
local timer interrupt causing cacheline ping-pong for i386, ppc, x86_64 and
sparc arches.  Other arches have made this var truly per-cpu.

This one's for i386 (voyager included).

Thanks,
Kiran


diff -ruN -X dontdiff linux-2.5.55/arch/i386/kernel/apic.c prof_counter-2.5.54/arch/i386/kernel/apic.c
--- linux-2.5.55/arch/i386/kernel/apic.c	Thu Jan  9 09:34:27 2003
+++ prof_counter-2.5.54/arch/i386/kernel/apic.c	Fri Jan 10 13:02:06 2003
@@ -52,7 +52,7 @@
 
 int prof_multiplier[NR_CPUS] = { 1, };
 int prof_old_multiplier[NR_CPUS] = { 1, };
-int prof_counter[NR_CPUS] = { 1, };
+DEFINE_PER_CPU(int, prof_counter) = 1;
 
 int get_maxlvt(void)
 {
@@ -997,7 +997,7 @@
 
 	x86_do_profile(regs);
 
-	if (--prof_counter[cpu] <= 0) {
+	if (--per_cpu(prof_counter, cpu) <= 0) {
 		/*
 		 * The multiplier may have changed since the last time we got
 		 * to this point as a result of the user writing to
@@ -1006,10 +1006,12 @@
 		 *
 		 * Interrupts are already masked off at this point.
 		 */
-		prof_counter[cpu] = prof_multiplier[cpu];
-		if (prof_counter[cpu] != prof_old_multiplier[cpu]) {
-			__setup_APIC_LVTT(calibration_result/prof_counter[cpu]);
-			prof_old_multiplier[cpu] = prof_counter[cpu];
+		per_cpu(prof_counter, cpu) = prof_multiplier[cpu];
+		if (per_cpu(prof_counter, cpu) != prof_old_multiplier[cpu]) {
+			__setup_APIC_LVTT(
+					calibration_result/
+					per_cpu(prof_counter, cpu));
+			prof_old_multiplier[cpu] = per_cpu(prof_counter, cpu);
 		}
 
 #ifdef CONFIG_SMP
diff -ruN -X dontdiff linux-2.5.55/arch/i386/kernel/smpboot.c prof_counter-2.5.54/arch/i386/kernel/smpboot.c
--- linux-2.5.55/arch/i386/kernel/smpboot.c	Thu Jan  9 09:34:14 2003
+++ prof_counter-2.5.54/arch/i386/kernel/smpboot.c	Fri Jan 10 13:52:02 2003
@@ -937,7 +937,7 @@
 
 extern int prof_multiplier[NR_CPUS];
 extern int prof_old_multiplier[NR_CPUS];
-extern int prof_counter[NR_CPUS];
+DECLARE_PER_CPU(int, prof_counter);
 
 static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
@@ -955,7 +955,7 @@
 	 */
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		prof_counter[cpu] = 1;
+		per_cpu(prof_counter, cpu) = 1;
 		prof_old_multiplier[cpu] = 1;
 		prof_multiplier[cpu] = 1;
 	}
diff -ruN -X dontdiff linux-2.5.55/arch/i386/mach-voyager/voyager_smp.c prof_counter-2.5.54/arch/i386/mach-voyager/voyager_smp.c
--- linux-2.5.55/arch/i386/mach-voyager/voyager_smp.c	Thu Jan  9 09:34:00 2003
+++ prof_counter-2.5.54/arch/i386/mach-voyager/voyager_smp.c	Fri Jan 10 13:53:14 2003
@@ -236,7 +236,7 @@
 /* The per cpu profile stuff - used in smp_local_timer_interrupt */
 static unsigned int prof_multiplier[NR_CPUS] __cacheline_aligned = { 1, };
 static unsigned int prof_old_multiplier[NR_CPUS] __cacheline_aligned = { 1, };
-static unsigned int prof_counter[NR_CPUS] __cacheline_aligned = { 1, };
+static DEFINE_PER_CPU(unsigned int, prof_counter) =  1;
 
 /* the map used to check if a CPU has booted */
 static __u32 cpu_booted_map;
@@ -393,7 +393,7 @@
 
 	/* initialize the CPU structures (moved from smp_boot_cpus) */
 	for(i=0; i<NR_CPUS; i++) {
-		prof_counter[i] = 1;
+		per_cpu(prof_counter, i) = 1;
 		prof_old_multiplier[i] = 1;
 		prof_multiplier[i] = 1;
 		cpu_irq_affinity[i] = ~0;
@@ -1312,7 +1312,7 @@
 
 	x86_do_profile(regs);
 
-	if (--prof_counter[cpu] <= 0) {
+	if (--per_cpu(prof_counter, cpu) <= 0) {
 		/*
 		 * The multiplier may have changed since the last time we got
 		 * to this point as a result of the user writing to
@@ -1321,10 +1321,10 @@
 		 *
 		 * Interrupts are already masked off at this point.
 		 */
-		prof_counter[cpu] = prof_multiplier[cpu];
-		if (prof_counter[cpu] != prof_old_multiplier[cpu]) {
+		per_cpu(prof_counter,cpu) = prof_multiplier[cpu];
+		if (per_cpu(prof_counter, cpu) != prof_old_multiplier[cpu]) {
 			/* FIXME: need to update the vic timer tick here */
-			prof_old_multiplier[cpu] = prof_counter[cpu];
+			prof_old_multiplier[cpu] = per_cpu(prof_counter, cpu);
 		}
 
 		update_process_times(user_mode(regs));
