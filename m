Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSGREWn>; Thu, 18 Jul 2002 00:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318011AbSGREUw>; Thu, 18 Jul 2002 00:20:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:10162 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318007AbSGRETi>;
	Thu, 18 Jul 2002 00:19:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Hotplug CPU Boot Change 2/2
Date: Thu, 18 Jul 2002 14:21:59 +1000
Message-Id: <20020718042317.CD693417B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.... And this fixes up x86.

Name: Hot-plug CPU Boot Rewrite for i386
Author: Rusty Russell
Status: Tested 2.5.25, dual SMP
Depends: Hotcpu/hotcpu-boot.patch.gz

D: This modifies the i386 boot sequence to "plug in" CPUs one at a
D: time.  This is the minimal change to make it work (the CPUs are
D: brought up as normal during the "smp_prepare_cpus()" probe phase).

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/apic.c working-2.5.25-hotcpu/arch/i386/kernel/apic.c
--- linux-2.5.25/arch/i386/kernel/apic.c	Thu Jun 20 01:28:47 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/apic.c	Mon Jul 15 18:23:12 2002
@@ -798,9 +798,9 @@
 	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
 
-void setup_APIC_timer(void * data)
+static void setup_APIC_timer(unsigned int clocks)
 {
-	unsigned int clocks = (unsigned int) data, slice, t0, t1;
+	unsigned int slice, t0, t1;
 	unsigned long flags;
 	int delta;
 
@@ -926,7 +926,7 @@
 
 int dont_use_local_apic_timer __initdata = 0;
 
-void __init setup_APIC_clocks (void)
+void __init setup_boot_APIC_clock(void)
 {
 	/* Disabled by DMI scan or kernel option? */
 	if (dont_use_local_apic_timer)
@@ -941,12 +941,16 @@
 	/*
 	 * Now set up the timer for real.
 	 */
-	setup_APIC_timer((void *)calibration_result);
+	setup_APIC_timer(calibration_result);
 
 	__sti();
+}
 
-	/* and update all other cpus */
-	smp_call_function(setup_APIC_timer, (void *)calibration_result, 1, 1);
+void __init setup_secondary_APIC_clock(void)
+{
+	__cli(); /* FIXME: Do we need this? --RR */
+	setup_APIC_timer(calibration_result);
+	__sti();
 }
 
 void __init disable_APIC_timer(void)
@@ -1178,7 +1182,7 @@
 		if (!skip_ioapic_setup && nr_ioapics)
 			setup_IO_APIC();
 #endif
-	setup_APIC_clocks();
+	setup_boot_APIC_clock();
 
 	return 0;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/apm.c working-2.5.25-hotcpu/arch/i386/kernel/apm.c
--- linux-2.5.25/arch/i386/kernel/apm.c	Sun Jul  7 02:12:17 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/apm.c	Mon Jul 15 14:42:18 2002
@@ -1587,7 +1587,7 @@
 
 	p = buf;
 
-	if ((num_online_cpus() == 1) &&
+	if ((num_possible_cpus() == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
@@ -1718,7 +1718,7 @@
 		}
 	}
 
-	if (debug && (num_online_cpus() == 1)) {
+	if (debug && (num_possible_cpus() == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1762,7 +1762,7 @@
 		pm_power_off = apm_power_off;
 	register_sysrq_key('o', &sysrq_poweroff_op);
 
-	if (num_online_cpus() == 1) {
+	if (num_possible_cpus() == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
@@ -1905,9 +1905,7 @@
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
-	/* FIXME: When boot code changes, this will need to be
-           deactivated when/if a CPU comes up --RR */
-	if ((num_online_cpus() > 1) && !power_off) {
+	if ((num_possible_cpus() > 1) && !power_off) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
 		return -ENODEV;
 	}
@@ -1961,9 +1959,7 @@
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
-	/* FIXME: When boot code changes, this will need to be
-           deactivated when/if a CPU comes up --RR */
-	if (num_online_cpus() > 1) {
+	if (num_possible_cpus() > 1) {
 		printk(KERN_NOTICE
 		   "apm: disabled - APM is not SMP safe (power off active).\n");
 		return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/mtrr.c working-2.5.25-hotcpu/arch/i386/kernel/mtrr.c
--- linux-2.5.25/arch/i386/kernel/mtrr.c	Thu Jun 20 01:28:47 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/mtrr.c	Mon Jul 15 14:42:42 2002
@@ -1055,7 +1055,7 @@
     wait_barrier_cache_disable = TRUE;
     wait_barrier_execute = TRUE;
     wait_barrier_cache_enable = TRUE;
-    atomic_set (&undone_count, num_online_cpus() - 1);
+    atomic_set (&undone_count, num_booting_cpus() - 1);
     /*  Start the ball rolling on other CPUs  */
     if (smp_call_function (ipi_handler, &data, 1, 0) != 0)
 	panic ("mtrr: timed out waiting for other CPUs\n");
@@ -1064,14 +1064,14 @@
     /*  Wait for all other CPUs to flush and disable their caches  */
     while (atomic_read (&undone_count) > 0) { rep_nop(); barrier(); }
     /* Set up for completion wait and then release other CPUs to change MTRRs*/
-    atomic_set (&undone_count, num_online_cpus() - 1);
+    atomic_set (&undone_count, num_booting_cpus() - 1);
     wait_barrier_cache_disable = FALSE;
     set_mtrr_cache_disable (&ctxt);
 
     /*  Wait for all other CPUs to flush and disable their caches  */
     while (atomic_read (&undone_count) > 0) { rep_nop(); barrier(); }
     /* Set up for completion wait and then release other CPUs to change MTRRs*/
-    atomic_set (&undone_count, num_online_cpus() - 1);
+    atomic_set (&undone_count, num_booting_cpus() - 1);
     wait_barrier_execute = FALSE;
     (*set_mtrr_up) (reg, base, size, type, FALSE);
     /*  Now wait for other CPUs to complete the function  */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/nmi.c working-2.5.25-hotcpu/arch/i386/kernel/nmi.c
--- linux-2.5.25/arch/i386/kernel/nmi.c	Thu Jun 20 01:28:47 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/nmi.c	Mon Jul 15 15:30:34 2002
@@ -81,6 +81,8 @@
 	sti();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
+	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
+           as they come up. */
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/smpboot.c working-2.5.25-hotcpu/arch/i386/kernel/smpboot.c
--- linux-2.5.25/arch/i386/kernel/smpboot.c	Fri Jun 21 09:41:52 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/smpboot.c	Mon Jul 15 17:44:05 2002
@@ -31,7 +31,7 @@
  *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
  *		Martin J. Bligh	: 	Added support for multi-quad systems
  *		Dave Jones	:	Report invalid combinations of Athlon CPUs.
- */
+*		Rusty Russell	:	Hacked into shape for new "hotplug" boot process. */
 
 #include <linux/config.h>
 #include <linux/init.h>
@@ -53,9 +53,6 @@
 /* Set if we find a B stepping CPU */
 static int __initdata smp_b_stepping;
 
-/* Setup configured maximum number of CPUs to activate */
-static int __initdata max_cpus = NR_CPUS;
-
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 int __initdata phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
@@ -64,7 +61,8 @@
 unsigned long cpu_online_map;
 
 static volatile unsigned long cpu_callin_map;
-static volatile unsigned long cpu_callout_map;
+volatile unsigned long cpu_callout_map;
+static unsigned long smp_commenced_mask;
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
@@ -73,33 +71,6 @@
 int smp_threads_ready;
 
 /*
- * Setup routine for controlling SMP activation
- *
- * Command-line option of "nosmp" or "maxcpus=0" will disable SMP
- * activation entirely (the MPS table probe still happens, though).
- *
- * Command-line option of "maxcpus=<NUM>", where <NUM> is an integer
- * greater than 0, limits the maximum number of CPUs activated in
- * SMP mode to <NUM>.
- */
-
-static int __init nosmp(char *str)
-{
-	max_cpus = 0;
-	return 1;
-}
-
-__setup("nosmp", nosmp);
-
-static int __init maxcpus(char *str)
-{
-	get_option(&str, &max_cpus);
-	return 1;
-}
-
-__setup("maxcpus=", maxcpus);
-
-/*
  * Trampoline 80x86 program as an array.
  */
 
@@ -139,7 +110,7 @@
  * a given CPU
  */
 
-void __init smp_store_cpu_info(int id)
+static void __init smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c = cpu_data + id;
 
@@ -193,29 +164,6 @@
 }
 
 /*
- * Architecture specific routine called by the kernel just before init is
- * fired off. This allows the BP to have everything in order [we hope].
- * At the end of this all the APs will hit the system scheduling and off
- * we go. Each AP will load the system gdt's and jump through the kernel
- * init into idle(). At this point the scheduler will one day take over
- * and give them jobs to do. smp_callin is a standard routine
- * we use to track CPUs as they power up.
- */
-
-static atomic_t smp_commenced = ATOMIC_INIT(0);
-
-void __init smp_commence(void)
-{
-	/*
-	 * Lets the callins below out of their loop.
-	 */
-	Dprintk("Setting commenced=1, go go go\n");
-
-	wmb();
-	atomic_set(&smp_commenced,1);
-}
-
-/*
  * TSC synchronization.
  *
  * We first check wether all CPUs have their TSC's synchronized,
@@ -268,7 +216,7 @@
 	unsigned long one_usec;
 	int buggy = 0;
 
-	printk("checking TSC synchronization across CPUs: ");
+	printk("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
 
 	one_usec = ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
 
@@ -289,7 +237,7 @@
 		/*
 		 * all APs synchronize but they loop on '== num_cpus'
 		 */
-		while (atomic_read(&tsc_count_start) != num_online_cpus()-1)
+		while (atomic_read(&tsc_count_start) != num_booting_cpus()-1)
 			mb();
 		atomic_set(&tsc_count_stop, 0);
 		wmb();
@@ -308,7 +256,7 @@
 		/*
 		 * Wait for all APs to leave the synchronization point:
 		 */
-		while (atomic_read(&tsc_count_stop) != num_online_cpus()-1)
+		while (atomic_read(&tsc_count_stop) != num_booting_cpus()-1)
 			mb();
 		atomic_set(&tsc_count_start, 0);
 		wmb();
@@ -317,16 +265,16 @@
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i)) {
+		if (test_bit(i, &cpu_callout_map)) {
 			t0 = tsc_values[i];
 			sum += t0;
 		}
 	}
-	avg = div64(sum, num_online_cpus());
+	avg = div64(sum, num_booting_cpus());
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!test_bit(i, &cpu_callout_map))
 			continue;
 		delta = tsc_values[i] - avg;
 		if (delta < 0)
@@ -359,7 +307,7 @@
 	int i;
 
 	/*
-	 * num_online_cpus is not necessarily known at the time
+	 * Not every cpu is online at the time
 	 * this gets called, so we first wait for the BP to
 	 * finish SMP initialization:
 	 */
@@ -367,7 +315,7 @@
 
 	for (i = 0; i < NR_LOOPS; i++) {
 		atomic_inc(&tsc_count_start);
-		while (atomic_read(&tsc_count_start) != num_online_cpus())
+		while (atomic_read(&tsc_count_start) != num_booting_cpus())
 			mb();
 
 		rdtscll(tsc_values[smp_processor_id()]);
@@ -375,7 +323,7 @@
 			write_tsc(0, 0);
 
 		atomic_inc(&tsc_count_stop);
-		while (atomic_read(&tsc_count_stop) != num_online_cpus()) mb();
+		while (atomic_read(&tsc_count_stop) != num_booting_cpus()) mb();
 	}
 }
 #undef NR_LOOPS
@@ -403,7 +351,7 @@
 	 */
 	phys_id = GET_APIC_ID(apic_read(APIC_ID));
 	cpuid = smp_processor_id();
-	if (test_and_set_bit(cpuid, &cpu_online_map)) {
+	if (test_bit(cpuid, &cpu_callin_map)) {
 		printk("huh, phys CPU#%d, CPU#%d already present??\n",
 					phys_id, cpuid);
 		BUG();
@@ -501,15 +449,17 @@
 	 */
 	cpu_init();
 	smp_callin();
-	while (!atomic_read(&smp_commenced))
+	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
 		rep_nop();
+	setup_secondary_APIC_clock();
 	enable_APIC_timer();
 	/*
 	 * low-memory mappings have been cleared, flush them from
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
-
+	set_bit(smp_processor_id(), &cpu_online_map);
+	wmb();
 	return cpu_idle();
 }
 
@@ -943,7 +893,6 @@
 		unmap_cpu_to_boot_apicid(cpu, apicid);
 		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
-		clear_bit(cpu, &cpu_online_map);  /* was set in smp_callin() */
 		cpucount--;
 	}
 
@@ -1015,7 +964,7 @@
 
 int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 
-void __init smp_boot_cpus(void)
+static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit;
 
@@ -1057,6 +1006,7 @@
 	 * We have the boot CPU online for sure.
 	 */
 	set_bit(0, &cpu_online_map);
+	set_bit(0, &cpu_callout_map);
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
 
@@ -1073,11 +1023,11 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
+		phys_cpu_present_map = 1;
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
-		goto smp_done;
+		return;
 	}
 
 	/*
@@ -1102,8 +1052,8 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
-		goto smp_done;
+		phys_cpu_present_map = 1;
+		return;
 	}
 
 	verify_local_APIC();
@@ -1117,8 +1067,8 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
-		goto smp_done;
+		phys_cpu_present_map = 1;
+		return;
 	}
 
 	connect_bsp_APIC();
@@ -1190,7 +1140,7 @@
 	} else {
 		unsigned long bogosum = 0;
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			if (cpu_online_map & (1<<cpu))
+			if (cpu_callout_map & (1<<cpu))
 				bogosum += cpu_data[cpu].loops_per_jiffy;
 		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 			cpucount+1,
@@ -1213,10 +1163,10 @@
 		
 		for (cpu = 0; cpu < NR_CPUS; cpu++) {
 			int 	i;
-			if (!cpu_online(cpu)) continue;
+			if (!test_bit(cpu, &cpu_callout_map)) continue;
 
 			for (i = 0; i < NR_CPUS; i++) {
-				if (i == cpu || !cpu_online(i))
+				if (i == cpu || !test_bit(i, &cpu_callout_map))
 					continue;
 				if (phys_proc_id[cpu] == phys_proc_id[i]) {
 					cpu_sibling_map[cpu] = i;
@@ -1240,17 +1190,40 @@
 		setup_IO_APIC();
 #endif
 
-	/*
-	 * Set up all local APIC timers in the system:
-	 */
-	setup_APIC_clocks();
+	setup_boot_APIC_clock();
 
 	/*
 	 * Synchronize the TSC with the AP
 	 */
 	if (cpu_has_tsc && cpucount)
 		synchronize_tsc_bp();
+}
 
-smp_done:
+/* These are wrappers to interface to the new boot process.  Someone
+   who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	smp_boot_cpus(max_cpus);
+}
+
+int __devinit __cpu_up(unsigned int cpu)
+{
+	/* This only works at boot for x86.  See "rewrite" above. */
+	if (test_bit(cpu, &smp_commenced_mask))
+		return -ENOSYS;
+
+	/* In case one didn't come up */
+	if (!test_bit(cpu, &cpu_callin_map))
+		return -EIO;
+
+	/* Unleash the CPU! */
+	set_bit(cpu, &smp_commenced_mask);
+	while (!test_bit(cpu, &cpu_online_map))
+		mb();
+	return 0;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
 	zap_low_mappings();
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/asm-i386/apic.h working-2.5.25-hotcpu/include/asm-i386/apic.h
--- linux-2.5.25/include/asm-i386/apic.h	Mon Apr 15 11:47:44 2002
+++ working-2.5.25-hotcpu/include/asm-i386/apic.h	Mon Jul 15 18:22:21 2002
@@ -76,7 +76,8 @@
 extern void setup_local_APIC (void);
 extern void init_apic_mappings (void);
 extern void smp_local_timer_interrupt (struct pt_regs * regs);
-extern void setup_APIC_clocks (void);
+extern void setup_boot_APIC_clock (void);
+extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
 extern inline void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/asm-i386/smp.h working-2.5.25-hotcpu/include/asm-i386/smp.h
--- linux-2.5.25/include/asm-i386/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.25-hotcpu/include/asm-i386/smp.h	Mon Jul 15 14:46:12 2002
@@ -79,19 +79,13 @@
 extern volatile int logical_apicid_to_cpu[MAX_APICID];
 
 /*
- * General functions that each host system must provide.
- */
- 
-extern void smp_boot_cpus(void);
-extern void smp_store_cpu_info(int id);		/* Store per CPU info (like the initial udelay numbers */
-
-/*
  * This function is needed by all SMP systems. It must _always_ be valid
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
 #define smp_processor_id() (current_thread_info()->cpu)
 
+#define cpu_possible(cpu) (phys_cpu_present_map & (1<<(cpu)))
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 
 extern inline unsigned int num_online_cpus(void)
@@ -117,6 +111,13 @@
 {
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
+}
+
+extern volatile unsigned long cpu_callout_map;
+/* We don't mark CPUs online until __cpu_up(), so we need another measure */
+static inline int num_booting_cpus(void)
+{
+	return hweight32(cpu_callout_map);
 }
 
 #endif /* !__ASSEMBLY__ */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
