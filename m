Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbTAPLpV>; Thu, 16 Jan 2003 06:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbTAPLpU>; Thu, 16 Jan 2003 06:45:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:53891 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266716AbTAPLpR>;
	Thu, 16 Jan 2003 06:45:17 -0500
Date: Thu, 16 Jan 2003 17:36:08 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 1/4 -- x86 arch
Message-ID: <20030116120608.GD13013@in.ibm.com>
References: <20030113122835.GC2714@in.ibm.com> <200301131210.47318.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301131210.47318.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:10:47PM -0800, Andrew Morton wrote:
> On Monday 13 January 2003 04:28 am, Ravikiran G Thirumalai wrote:
> >
> > Hi,
> > Here's  a patchset to make prof_counter use percpu area infrastructure.
> > ...
> >  	/* initialize the CPU structures (moved from smp_boot_cpus) */
> >  	for(i=0; i<NR_CPUS; i++) {
> > -		prof_counter[i] = 1;
> > +		per_cpu(prof_counter, i) = 1;
> 
> Please always use the cpu_online() test here.
> 

Even cpu_possible does not seem to be setup this early.  Seems like 
reinitialisation of prof_counter/prof_multiplier et al is redundant.
Here's a newer patch which removes this initialisation at smp_boot_cpus.
Works fine for me (tested same on a 4 way with difft profiling multipliers..
LOC interrupts seem to fire at the right intervals).

Only x86 and x86_64 arches had this reinits. Here's the corrected
x86 patch. x86_64 patch to follow

Thanks,
Kiran


diff -ruN -X dontdiff linux-2.5.58/arch/i386/kernel/apic.c prof_counter-2.5.58/arch/i386/kernel/apic.c
--- linux-2.5.58/arch/i386/kernel/apic.c	Tue Jan 14 11:29:32 2003
+++ prof_counter-2.5.58/arch/i386/kernel/apic.c	Thu Jan 16 16:16:53 2003
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
diff -ruN -X dontdiff linux-2.5.58/arch/i386/kernel/smpboot.c prof_counter-2.5.58/arch/i386/kernel/smpboot.c
--- linux-2.5.58/arch/i386/kernel/smpboot.c	Tue Jan 14 11:28:41 2003
+++ prof_counter-2.5.58/arch/i386/kernel/smpboot.c	Thu Jan 16 16:16:53 2003
@@ -935,10 +935,6 @@
  * Cycle through the processors sending APIC IPIs to boot each.
  */
 
-extern int prof_multiplier[NR_CPUS];
-extern int prof_old_multiplier[NR_CPUS];
-extern int prof_counter[NR_CPUS];
-
 static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
@@ -950,17 +946,6 @@
 	int apicid, cpu, bit;
 
 	/*
-	 * Initialize the logical to physical CPU number mapping
-	 * and the per-CPU profiling counter/multiplier
-	 */
-
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		prof_counter[cpu] = 1;
-		prof_old_multiplier[cpu] = 1;
-		prof_multiplier[cpu] = 1;
-	}
-
-	/*
 	 * Setup boot CPU information
 	 */
 	smp_store_cpu_info(0); /* Final full version of the data */
diff -ruN -X dontdiff linux-2.5.58/arch/i386/mach-voyager/voyager_smp.c prof_counter-2.5.58/arch/i386/mach-voyager/voyager_smp.c
--- linux-2.5.58/arch/i386/mach-voyager/voyager_smp.c	Tue Jan 14 11:28:33 2003
+++ prof_counter-2.5.58/arch/i386/mach-voyager/voyager_smp.c	Thu Jan 16 16:20:19 2003
@@ -236,7 +236,7 @@
 /* The per cpu profile stuff - used in smp_local_timer_interrupt */
 static unsigned int prof_multiplier[NR_CPUS] __cacheline_aligned = { 1, };
 static unsigned int prof_old_multiplier[NR_CPUS] __cacheline_aligned = { 1, };
-static unsigned int prof_counter[NR_CPUS] __cacheline_aligned = { 1, };
+static DEFINE_PER_CPU(unsigned int, prof_counter) =  1;
 
 /* the map used to check if a CPU has booted */
 static __u32 cpu_booted_map;
@@ -393,9 +393,6 @@
 
 	/* initialize the CPU structures (moved from smp_boot_cpus) */
 	for(i=0; i<NR_CPUS; i++) {
-		prof_counter[i] = 1;
-		prof_old_multiplier[i] = 1;
-		prof_multiplier[i] = 1;
 		cpu_irq_affinity[i] = ~0;
 	}
 	cpu_online_map = (1<<boot_cpu_id);
@@ -1312,7 +1309,7 @@
 
 	x86_do_profile(regs);
 
-	if (--prof_counter[cpu] <= 0) {
+	if (--per_cpu(prof_counter, cpu) <= 0) {
 		/*
 		 * The multiplier may have changed since the last time we got
 		 * to this point as a result of the user writing to
@@ -1321,10 +1318,10 @@
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
