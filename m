Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVDMEaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVDMEaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVDLTA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:00:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:63433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262224AbVDLKco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:44 -0400
Message-Id: <200504121032.j3CAWG9N005545@shell0.pdx.osdl.net>
Subject: [patch 102/198] x86_64: Switch SMP bootup over to new CPU hotplug state machine
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, mingo@elte.hu,
       rusty@rustcorp.com.au
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

This will allow hotplug CPU in the future and in general cleans up a lot of
crufty code.  It also should plug some races that the old hackish way
introduces.  Remove one old race workaround in NMI watchdog setup that is not
needed anymore.

I removed the old total sum of bogomips reporting code.  The brag value of
BogoMips has been greatly devalued in the last years on the open market.

Real CPU hotplug will need some more work, but the infrastructure for it is
there now.

One drawback: the new TSC sync algorithm is less accurate than before.  The
old way of zeroing TSCs is too intrusive to do later.  Instead the TSC of the
BP is duplicated now, which is less accurate.

akpm:

- sync_tsc_bp_init seems to have the sense of `init' inverted.

- SPIN_LOCK_UNLOCKED is deprecated - use DEFINE_SPINLOCK.

Cc: <rusty@rustcorp.com.au>
Cc: <mingo@elte.hu>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/nmi.c     |    6 
 25-akpm/arch/x86_64/kernel/smp.c     |   25 +
 25-akpm/arch/x86_64/kernel/smpboot.c |  684 ++++++++++++++++-------------------
 25-akpm/arch/x86_64/kernel/time.c    |    9 
 25-akpm/include/asm-x86_64/msr.h     |    1 
 25-akpm/include/asm-x86_64/proto.h   |    2 
 25-akpm/include/asm-x86_64/smp.h     |   29 -
 7 files changed, 369 insertions(+), 387 deletions(-)

diff -puN arch/x86_64/kernel/nmi.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state arch/x86_64/kernel/nmi.c
--- 25/arch/x86_64/kernel/nmi.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state	2005-04-12 03:21:27.384973752 -0700
+++ 25-akpm/arch/x86_64/kernel/nmi.c	2005-04-12 03:21:27.396971928 -0700
@@ -130,12 +130,6 @@ int __init check_nmi_watchdog (void)
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-#ifdef CONFIG_SMP
-		/* Check cpu_callin_map here because that is set
-		   after the timer is started. */
-		if (!cpu_isset(cpu, cpu_callin_map))
-			continue;
-#endif
 		if (cpu_pda[cpu].__nmi_count - counts[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck (%d)!\n", 
 			       cpu,
diff -puN arch/x86_64/kernel/smpboot.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state arch/x86_64/kernel/smpboot.c
--- 25/arch/x86_64/kernel/smpboot.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state	2005-04-12 03:21:27.386973448 -0700
+++ 25-akpm/arch/x86_64/kernel/smpboot.c	2005-04-12 03:21:27.401971168 -0700
@@ -12,8 +12,7 @@
  *	Pentium Pro and Pentium-II/Xeon MP machines.
  *	Original development of Linux SMP code supported by Caldera.
  *
- *	This code is released under the GNU General Public License version 2 or
- *	later.
+ *	This code is released under the GNU General Public License version 2
  *
  *	Fixes
  *		Felix Koop	:	NR_CPUS used properly
@@ -31,9 +30,13 @@
  *		Tigran Aivazian	:	fixed "0.00 in /proc/uptime on SMP" bug.
  *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
  *	Andi Kleen		:	Changed for SMP boot into long mode.
- *		Rusty Russell	:	Hacked into shape for new "hotplug" boot process. 
+ *		Rusty Russell	:	Hacked into shape for new "hotplug" boot process.
+ *      Andi Kleen              :       Converted to new state machine.
+ *					Various cleanups.
+ *					Probably mostly hotplug CPU ready now.
  */
 
+
 #include <linux/config.h>
 #include <linux/init.h>
 
@@ -54,11 +57,15 @@
 #include <asm/tlbflush.h>
 #include <asm/proto.h>
 
+/* Change for real CPU hotplug. Note other files need to be fixed
+   first too. */
+#define __cpuinit __init
+#define __cpuinitdata __initdata
+
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 /* Package ID of each logical CPU */
 u8 phys_proc_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
-/* Core ID of each logical CPU */
 u8 cpu_core_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 EXPORT_SYMBOL(phys_proc_id);
 EXPORT_SYMBOL(cpu_core_id);
@@ -66,13 +73,24 @@ EXPORT_SYMBOL(cpu_core_id);
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map;
 
+EXPORT_SYMBOL(cpu_online_map);
+
+/*
+ * Private maps to synchronize booting between AP and BP.
+ * Probably not needed anymore, but it makes for easier debugging. -AK
+ */
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
-static cpumask_t smp_commenced_mask;
+
+cpumask_t cpu_possible_map;
+EXPORT_SYMBOL(cpu_possible_map);
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
+/* Set when the idlers are all forked */
+int smp_threads_ready;
+
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 
@@ -80,8 +98,8 @@ cpumask_t cpu_core_map[NR_CPUS] __cachel
  * Trampoline 80x86 program as an array.
  */
 
-extern unsigned char trampoline_data [];
-extern unsigned char trampoline_end  [];
+extern unsigned char trampoline_data[];
+extern unsigned char trampoline_end[];
 
 /*
  * Currently trivial. Write the real->protected mode
@@ -89,7 +107,7 @@ extern unsigned char trampoline_end  [];
  * has made sure it's suitably aligned.
  */
 
-static unsigned long __init setup_trampoline(void)
+static unsigned long __cpuinit setup_trampoline(void)
 {
 	void *tramp = __va(SMP_TRAMPOLINE_BASE); 
 	memcpy(tramp, trampoline_data, trampoline_end - trampoline_data);
@@ -101,7 +119,7 @@ static unsigned long __init setup_trampo
  * a given CPU
  */
 
-static void __init smp_store_cpu_info(int id)
+static void __cpuinit smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c = cpu_data + id;
 
@@ -110,145 +128,101 @@ static void __init smp_store_cpu_info(in
 }
 
 /*
- * TSC synchronization.
+ * Synchronize TSCs of CPUs
  *
- * We first check whether all CPUs have their TSC's synchronized,
- * then we print a warning if not, and always resync.
+ * This new algorithm is less accurate than the old "zero TSCs"
+ * one, but we cannot zero TSCs anymore in the new hotplug CPU
+ * model.
  */
 
-static atomic_t tsc_start_flag = ATOMIC_INIT(0);
-static atomic_t tsc_count_start = ATOMIC_INIT(0);
-static atomic_t tsc_count_stop = ATOMIC_INIT(0);
-static unsigned long long tsc_values[NR_CPUS];
+static atomic_t __cpuinitdata tsc_flag;
+static __cpuinitdata DEFINE_SPINLOCK(tsc_sync_lock);
+static unsigned long long __cpuinitdata bp_tsc, ap_tsc;
 
 #define NR_LOOPS 5
 
-extern unsigned int fast_gettimeoffset_quotient;
-
-static void __init synchronize_tsc_bp (void)
+static void __cpuinit sync_tsc_bp_init(int init)
 {
-	int i;
-	unsigned long long t0;
-	unsigned long long sum, avg;
-	long long delta;
-	long one_usec;
-	int buggy = 0;
-
-	printk(KERN_INFO "checking TSC synchronization across %u CPUs: ",num_booting_cpus());
-
-	one_usec = cpu_khz; 
-
-	atomic_set(&tsc_start_flag, 1);
-	wmb();
-
-	/*
-	 * We loop a few times to get a primed instruction cache,
-	 * then the last pass is more or less synchronized and
-	 * the BP and APs set their cycle counters to zero all at
-	 * once. This reduces the chance of having random offsets
-	 * between the processors, and guarantees that the maximum
-	 * delay between the cycle counters is never bigger than
-	 * the latency of information-passing (cachelines) between
-	 * two CPUs.
-	 */
-	for (i = 0; i < NR_LOOPS; i++) {
-		/*
-		 * all APs synchronize but they loop on '== num_cpus'
-		 */
-		while (atomic_read(&tsc_count_start) != num_booting_cpus()-1) mb();
-		atomic_set(&tsc_count_stop, 0);
-		wmb();
-		/*
-		 * this lets the APs save their current TSC:
-		 */
-		atomic_inc(&tsc_count_start);
-
-		sync_core();
-		rdtscll(tsc_values[smp_processor_id()]);
-		/*
-		 * We clear the TSC in the last loop:
-		 */
-		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
-
-		/*
-		 * Wait for all APs to leave the synchronization point:
-		 */
-		while (atomic_read(&tsc_count_stop) != num_booting_cpus()-1) mb();
-		atomic_set(&tsc_count_start, 0);
-		wmb();
-		atomic_inc(&tsc_count_stop);
-	}
-
-	sum = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_isset(i, cpu_callout_map)) {
-		t0 = tsc_values[i];
-		sum += t0;
-	}
-	}
-	avg = sum / num_booting_cpus();
-
-	sum = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_isset(i, cpu_callout_map))
-			continue;
-
-		delta = tsc_values[i] - avg;
-		if (delta < 0)
-			delta = -delta;
-		/*
-		 * We report bigger than 2 microseconds clock differences.
-		 */
-		if (delta > 2*one_usec) {
-			long realdelta;
-			if (!buggy) {
-				buggy = 1;
-				printk("\n");
-			}
-			realdelta = delta / one_usec;
-			if (tsc_values[i] < avg)
-				realdelta = -realdelta;
+	if (init)
+		_raw_spin_lock(&tsc_sync_lock);
+	else
+		_raw_spin_unlock(&tsc_sync_lock);
+	atomic_set(&tsc_flag, 0);
+}
 
-			printk("BIOS BUG: CPU#%d improperly initialized, has %ld usecs TSC skew! FIXED.\n",
-				i, realdelta);
-		}
+/*
+ * Synchronize TSC on AP with BP.
+ */
+static void __cpuinit __sync_tsc_ap(void)
+{
+	if (!cpu_has_tsc)
+		return;
+	Dprintk("AP %d syncing TSC\n", smp_processor_id());
 
-		sum += delta;
-	}
-	if (!buggy)
-		printk("passed.\n");
+	while (atomic_read(&tsc_flag) != 0)
+		cpu_relax();
+	atomic_inc(&tsc_flag);
+	mb();
+	_raw_spin_lock(&tsc_sync_lock);
+	wrmsrl(MSR_IA32_TSC, bp_tsc);
+	_raw_spin_unlock(&tsc_sync_lock);
+	rdtscll(ap_tsc);
+	mb();
+	atomic_inc(&tsc_flag);
+	mb();
 }
 
-static void __init synchronize_tsc_ap (void)
+static void __cpuinit sync_tsc_ap(void)
 {
 	int i;
+	for (i = 0; i < NR_LOOPS; i++)
+		__sync_tsc_ap();
+}
 
-	/*
-	 * Not every cpu is online at the time
-	 * this gets called, so we first wait for the BP to
-	 * finish SMP initialization:
-	 */
-	while (!atomic_read(&tsc_start_flag)) mb();
-
-	for (i = 0; i < NR_LOOPS; i++) {
-		atomic_inc(&tsc_count_start);
-		while (atomic_read(&tsc_count_start) != num_booting_cpus()) mb();
+/*
+ * Synchronize TSC from BP to AP.
+ */
+static void __cpuinit __sync_tsc_bp(int cpu)
+{
+	if (!cpu_has_tsc)
+		return;
 
-		sync_core();
-		rdtscll(tsc_values[smp_processor_id()]);
-		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
+	/* Wait for AP */
+	while (atomic_read(&tsc_flag) == 0)
+		cpu_relax();
+	/* Save BPs TSC */
+	sync_core();
+	rdtscll(bp_tsc);
+	/* Don't do the sync core here to avoid too much latency. */
+	mb();
+	/* Start the AP */
+	_raw_spin_unlock(&tsc_sync_lock);
+	/* Wait for AP again */
+	while (atomic_read(&tsc_flag) < 2)
+		cpu_relax();
+	rdtscl(bp_tsc);
+	barrier();
+}
 
-		atomic_inc(&tsc_count_stop);
-		while (atomic_read(&tsc_count_stop) != num_booting_cpus()) mb();
+static void __cpuinit sync_tsc_bp(int cpu)
+{
+	int i;
+	for (i = 0; i < NR_LOOPS - 1; i++) {
+		__sync_tsc_bp(cpu);
+		sync_tsc_bp_init(1);
 	}
+	__sync_tsc_bp(cpu);
+	printk(KERN_INFO "Synced TSC of CPU %d difference %Ld\n",
+	       cpu, ap_tsc - bp_tsc);
 }
-#undef NR_LOOPS
 
-static atomic_t init_deasserted;
+static atomic_t init_deasserted __cpuinitdata;
 
-static void __init smp_callin(void)
+/*
+ * Report back to the Boot Processor.
+ * Running on AP.
+ */
+void __cpuinit smp_callin(void)
 {
 	int cpuid, phys_id;
 	unsigned long timeout;
@@ -259,7 +233,8 @@ static void __init smp_callin(void)
 	 * our local APIC.  We have to wait for the IPI or we'll
 	 * lock up on an APIC access.
 	 */
-	while (!atomic_read(&init_deasserted));
+	while (!atomic_read(&init_deasserted))
+		cpu_relax();
 
 	/*
 	 * (This works even if the APIC is not enabled.)
@@ -290,7 +265,7 @@ static void __init smp_callin(void)
 		 */
 		if (cpu_isset(cpuid, cpu_callout_map))
 			break;
-		rep_nop();
+		cpu_relax();
 	}
 
 	if (!time_before(jiffies, timeout)) {
@@ -325,20 +300,12 @@ static void __init smp_callin(void)
 	 * Allow the master to continue.
 	 */
 	cpu_set(cpuid, cpu_callin_map);
-
-	/*
-	 *      Synchronize the TSC with the BP
-	 */
-	if (cpu_has_tsc)
-		synchronize_tsc_ap();
 }
 
-static int cpucount;
-
 /*
- * Activate a secondary processor.
+ * Setup code on secondary processor (after comming out of the trampoline)
  */
-void __init start_secondary(void)
+void __cpuinit start_secondary(void)
 {
 	/*
 	 * Dont put anything before smp_callin(), SMP
@@ -348,17 +315,18 @@ void __init start_secondary(void)
 	cpu_init();
 	smp_callin();
 
+	/*
+	 * Synchronize the TSC with the BP
+	 */
+	sync_tsc_ap();
+
 	/* otherwise gcc will move up the smp_processor_id before the cpu_init */
 	barrier();
 
-	Dprintk("cpu %d: waiting for commence\n", smp_processor_id()); 
-	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
-		rep_nop();
-
 	Dprintk("cpu %d: setting up apic clock\n", smp_processor_id()); 	
 	setup_secondary_APIC_clock();
 
-	Dprintk("cpu %d: enabling apic timer\n", smp_processor_id()); 
+	Dprintk("cpu %d: enabling apic timer\n", smp_processor_id());
 
 	if (nmi_watchdog == NMI_IO_APIC) {
 		disable_8259A_irq(0);
@@ -367,26 +335,22 @@ void __init start_secondary(void)
 	}
 
 
-	enable_APIC_timer(); 
+	enable_APIC_timer();
 
 	/*
-	 * low-memory mappings have been cleared, flush them from
-	 * the local TLBs too.
+	 * Allow the master to continue.
 	 */
-	local_flush_tlb();
-
-	Dprintk("cpu %d eSetting cpu_online_map\n", smp_processor_id()); 
 	cpu_set(smp_processor_id(), cpu_online_map);
-	wmb();
-	
+	mb();
+
 	cpu_idle();
 }
 
-extern volatile unsigned long init_rsp; 
+extern volatile unsigned long init_rsp;
 extern void (*initial_code)(void);
 
 #if APIC_DEBUG
-static inline void inquire_remote_apic(int apicid)
+static void inquire_remote_apic(int apicid)
 {
 	unsigned i, regs[] = { APIC_ID >> 4, APIC_LVR >> 4, APIC_SPIV >> 4 };
 	char *names[] = { "ID", "VERSION", "SPIV" };
@@ -423,7 +387,10 @@ static inline void inquire_remote_apic(i
 }
 #endif
 
-static int __init wakeup_secondary_via_INIT(int phys_apicid, unsigned int start_rip)
+/*
+ * Kick the secondary to wake up.
+ */
+static int __cpuinit wakeup_secondary_via_INIT(int phys_apicid, unsigned int start_rip)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int maxlvt, timeout, num_starts, j;
@@ -546,33 +513,36 @@ static int __init wakeup_secondary_via_I
 	return (send_status | accept_status);
 }
 
-static void __init do_boot_cpu (int apicid)
+/*
+ * Boot one CPU.
+ */
+static int __cpuinit do_boot_cpu(int cpu, int apicid)
 {
 	struct task_struct *idle;
 	unsigned long boot_error;
-	int timeout, cpu;
+	int timeout;
 	unsigned long start_rip;
-
-	cpu = ++cpucount;
 	/*
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
 	idle = fork_idle(cpu);
-	if (IS_ERR(idle))
-		panic("failed fork for CPU %d", cpu);
+	if (IS_ERR(idle)) {
+		printk("failed fork for CPU %d\n", cpu);
+		return PTR_ERR(idle);
+	}
 	x86_cpu_to_apicid[cpu] = apicid;
 
 	cpu_pda[cpu].pcurrent = idle;
 
 	start_rip = setup_trampoline();
 
-	init_rsp = idle->thread.rsp; 
+	init_rsp = idle->thread.rsp;
 	per_cpu(init_tss,cpu).rsp0 = init_rsp;
 	initial_code = start_secondary;
 	clear_ti_thread_flag(idle->thread_info, TIF_FORK);
 
-	printk(KERN_INFO "Booting processor %d/%d rip %lx rsp %lx\n", cpu, apicid, 
+	printk(KERN_INFO "Booting processor %d/%d rip %lx rsp %lx\n", cpu, apicid,
 	       start_rip, init_rsp);
 
 	/*
@@ -609,7 +579,7 @@ static void __init do_boot_cpu (int apic
 	/*
 	 * Starting actual IPI sequence...
 	 */
-	boot_error = wakeup_secondary_via_INIT(apicid, start_rip); 
+	boot_error = wakeup_secondary_via_INIT(apicid, start_rip);
 
 	if (!boot_error) {
 		/*
@@ -650,58 +620,131 @@ static void __init do_boot_cpu (int apic
 	if (boot_error) {
 		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
-		cpucount--;
+		cpu_clear(cpu, cpu_present_map);
+		cpu_clear(cpu, cpu_possible_map);
 		x86_cpu_to_apicid[cpu] = BAD_APICID;
 		x86_cpu_to_log_apicid[cpu] = BAD_APICID;
+		return -EIO;
 	}
+
+	return 0;
 }
 
-static void smp_tune_scheduling (void)
+cycles_t cacheflush_time;
+unsigned long cache_decay_ticks;
+
+/*
+ * Construct cpu_sibling_map[], so that we can tell the sibling CPU
+ * on SMT systems efficiently.
+ */
+static __cpuinit void detect_siblings(void)
 {
-	int cachesize;       /* kB   */
-	unsigned long bandwidth = 1000; /* MB/s */
-	/*
-	 * Rough estimation for SMP scheduling, this is the number of
-	 * cycles it takes for a fully memory-limited process to flush
-	 * the SMP-local cache.
-	 *
-	 * (For a P5 this pretty much means we will choose another idle
-	 *  CPU almost always at wakeup time (this is due to the small
-	 *  L1 cache), on PIIs it's around 50-100 usecs, depending on
-	 *  the cache size)
-	 */
+	int cpu;
 
-	if (!cpu_khz) {
-		return;
-	} else {
-		cachesize = boot_cpu_data.x86_cache_size;
-		if (cachesize == -1) {
-			cachesize = 16; /* Pentiums, 2x8kB cache */
-			bandwidth = 100;
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		cpus_clear(cpu_sibling_map[cpu]);
+		cpus_clear(cpu_core_map[cpu]);
+	}
+
+	for_each_online_cpu (cpu) {
+		struct cpuinfo_x86 *c = cpu_data + cpu;
+		int siblings = 0;
+		int i;
+		if (smp_num_siblings > 1) {
+			for_each_online_cpu (i) {
+				if (cpu_core_id[cpu] == phys_proc_id[i]) {
+					siblings++;
+					cpu_set(i, cpu_sibling_map[cpu]);
+				}
+			}
+		} else {
+			siblings++;
+			cpu_set(cpu, cpu_sibling_map[cpu]);
 		}
+
+		if (siblings != smp_num_siblings) {
+			printk(KERN_WARNING
+	       "WARNING: %d siblings found for CPU%d, should be %d\n",
+			       siblings, cpu, smp_num_siblings);
+			smp_num_siblings = siblings;
+		}
+		if (c->x86_num_cores > 1) {
+			for_each_online_cpu(i) {
+				if (phys_proc_id[cpu] == phys_proc_id[i])
+					cpu_set(i, cpu_core_map[cpu]);
+			}
+		} else
+			cpu_core_map[cpu] = cpu_sibling_map[cpu];
 	}
 }
 
 /*
- * Cycle through the processors sending APIC IPIs to boot each.
+ * Cleanup possible dangling ends...
  */
-
-static void __init smp_boot_cpus(unsigned int max_cpus)
+static __cpuinit void smp_cleanup_boot(void)
 {
-	unsigned apicid, cpu, bit, kicked;
+	/*
+	 * Paranoid:  Set warm reset code and vector here back
+	 * to default values.
+	 */
+	CMOS_WRITE(0, 0xf);
 
-	nmi_watchdog_default();
+	/*
+	 * Reset trampoline flag
+	 */
+	*((volatile int *) phys_to_virt(0x467)) = 0;
 
+#ifndef CONFIG_HOTPLUG_CPU
 	/*
-	 * Setup boot CPU information
+	 * Free pages reserved for SMP bootup.
+	 * When you add hotplug CPU support later remove this
+	 * Note there is more work to be done for later CPU bootup.
 	 */
-	smp_store_cpu_info(0); /* Final full version of the data */
-	printk(KERN_INFO "CPU%d: ", 0);
-	print_cpu_info(&cpu_data[0]);
 
-	current_thread_info()->cpu = 0;
-	smp_tune_scheduling();
+	free_page((unsigned long) __va(PAGE_SIZE));
+	free_page((unsigned long) __va(SMP_TRAMPOLINE_BASE));
+#endif
+}
+
+/*
+ * Fall back to non SMP mode after errors.
+ *
+ * RED-PEN audit/test this more. I bet there is more state messed up here.
+ */
+static __cpuinit void disable_smp(void)
+{
+	cpu_present_map = cpumask_of_cpu(0);
+	cpu_possible_map = cpumask_of_cpu(0);
+	if (smp_found_config)
+		phys_cpu_present_map = physid_mask_of_physid(boot_cpu_id);
+	else
+		phys_cpu_present_map = physid_mask_of_physid(0);
+	cpu_set(0, cpu_sibling_map[0]);
+	cpu_set(0, cpu_core_map[0]);
+}
+
+/*
+ * Handle user cpus=... parameter.
+ */
+static __cpuinit void enforce_max_cpus(unsigned max_cpus)
+{
+	int i, k;
+	k = 0;
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		if (++k > max_cpus) {
+			cpu_clear(i, cpu_possible_map);
+			cpu_clear(i, cpu_present_map);
+		}
+	}
+}
 
+/*
+ * Various sanity checks.
+ */
+static int __cpuinit smp_sanity_check(unsigned max_cpus)
+{
 	if (!physid_isset(hard_smp_processor_id(), phys_cpu_present_map)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
 		       hard_smp_processor_id());
@@ -714,15 +757,11 @@ static void __init smp_boot_cpus(unsigne
 	 */
 	if (!smp_found_config) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
-		io_apic_irqs = 0;
-		cpu_online_map = cpumask_of_cpu(0);
-		cpu_set(0, cpu_sibling_map[0]);
-		cpu_set(0, cpu_core_map[0]);
-		phys_cpu_present_map = physid_mask_of_physid(0);
+		disable_smp();
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
-		goto smp_done;
+		return -1;
 	}
 
 	/*
@@ -742,213 +781,146 @@ static void __init smp_boot_cpus(unsigne
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_id);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
-		io_apic_irqs = 0;
-		cpu_online_map = cpumask_of_cpu(0);
-		cpu_set(0, cpu_sibling_map[0]);
-		cpu_set(0, cpu_core_map[0]);
-		phys_cpu_present_map = physid_mask_of_physid(0);
-		disable_apic = 1;
-		goto smp_done;
+		nr_ioapics = 0;
+		return -1;
 	}
 
-	verify_local_APIC();
-
 	/*
 	 * If SMP should be disabled, then really disable it!
 	 */
 	if (!max_cpus) {
-		smp_found_config = 0;
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
-		io_apic_irqs = 0;
-		cpu_online_map = cpumask_of_cpu(0);
-		cpu_set(0, cpu_sibling_map[0]);
-		cpu_set(0, cpu_core_map[0]);
-		phys_cpu_present_map = physid_mask_of_physid(0);
-		disable_apic = 1;
-		goto smp_done;
+		nr_ioapics = 0;
+		return -1;
 	}
 
-	connect_bsp_APIC();
-	setup_local_APIC();
-
-	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_id)
-		BUG();
-
-	x86_cpu_to_apicid[0] = boot_cpu_id;
-
-	/*
-	 * Now scan the CPU present map and fire up the other CPUs.
-	 */
-	Dprintk("CPU present map: %lx\n", physids_coerce(phys_cpu_present_map));
+	return 0;
+}
 
-	kicked = 1;
-	for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
-		apicid = cpu_present_to_apicid(bit);
-		/*
-		 * Don't even attempt to start the boot CPU!
-		 */
-		if (apicid == boot_cpu_id || (apicid == BAD_APICID))
-			continue;
+/*
+ * Prepare for SMP bootup.  The MP table or ACPI has been read
+ * earlier.  Just do some sanity checking here and enable APIC mode.
+ */
+void __cpuinit smp_prepare_cpus(unsigned int max_cpus)
+{
+	int i;
 
-		if (!physid_isset(apicid, phys_cpu_present_map))
-			continue;
-		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
-			continue;
+	nmi_watchdog_default();
+	current_cpu_data = boot_cpu_data;
+	current_thread_info()->cpu = 0;  /* needed? */
 
-		do_boot_cpu(apicid);
-		++kicked;
-	}
+	enforce_max_cpus(max_cpus);
 
 	/*
-	 * Cleanup possible dangling ends...
+	 * Fill in cpu_present_mask
 	 */
-	{
-		/*
-		 * Install writable page 0 entry to set BIOS data area.
-		 */
-		local_flush_tlb();
-
-		/*
-		 * Paranoid:  Set warm reset code and vector here back
-		 * to default values.
-		 */
-		CMOS_WRITE(0, 0xf);
-
-		*((volatile int *) phys_to_virt(0x467)) = 0;
+	for (i = 0; i < NR_CPUS; i++) {
+		int apicid = cpu_present_to_apicid(i);
+		if (physid_isset(apicid, phys_cpu_present_map)) {
+			cpu_set(i, cpu_present_map);
+			/* possible map would be different if we supported real
+			   CPU hotplug. */
+			cpu_set(i, cpu_possible_map);
+		}
 	}
 
-	/*
-	 * Allow the user to impress friends.
-	 */
-
-	Dprintk("Before bogomips.\n");
-	if (!cpucount) {
-		printk(KERN_INFO "Only one processor found.\n");
-	} else {
-		unsigned long bogosum = 0;
-		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			if (cpu_isset(cpu, cpu_callout_map))
-				bogosum += cpu_data[cpu].loops_per_jiffy;
-		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
-			cpucount+1,
-			bogosum/(500000/HZ),
-			(bogosum/(5000/HZ))%100);
-		Dprintk("Before bogocount - setting activated=1.\n");
+	if (smp_sanity_check(max_cpus) < 0) {
+		printk(KERN_INFO "SMP disabled\n");
+		disable_smp();
+		return;
 	}
 
+
 	/*
-	 * Construct cpu_sibling_map[], so that we can tell the
-	 * sibling CPU efficiently.
+	 * Switch from PIC to APIC mode.
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		cpus_clear(cpu_sibling_map[cpu]);
-		cpus_clear(cpu_core_map[cpu]);
-	}
-
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-  		struct cpuinfo_x86 *c = cpu_data + cpu;
-		int siblings = 0;
-		int i;
-		if (!cpu_isset(cpu, cpu_callout_map))
-			continue;
-
-		if (smp_num_siblings > 1) {
-			for (i = 0; i < NR_CPUS; i++) {
-				if (!cpu_isset(i, cpu_callout_map))
-					continue;
-				if (phys_proc_id[cpu] == cpu_core_id[i]) {
-					siblings++;
-					cpu_set(i, cpu_sibling_map[cpu]);
-				}
-			}
-		} else { 
-			siblings++;
-			cpu_set(cpu, cpu_sibling_map[cpu]);
-		}
+	connect_bsp_APIC();
+	setup_local_APIC();
 
-		if (siblings != smp_num_siblings) {
-			printk(KERN_WARNING 
-	       "WARNING: %d siblings found for CPU%d, should be %d\n", 
-			       siblings, cpu, smp_num_siblings);
-			smp_num_siblings = siblings;
-		}       
- 		if (c->x86_num_cores > 1) {
-			for (i = 0; i < NR_CPUS; i++) {
-				if (!cpu_isset(i, cpu_callout_map))
-					continue;
- 				if (phys_proc_id[cpu] == phys_proc_id[i]) {
- 					cpu_set(i, cpu_core_map[cpu]);
- 				}
- 			}
- 		} else
- 			cpu_core_map[cpu] = cpu_sibling_map[cpu];
+	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_id) {
+		panic("Boot APIC ID in local APIC unexpected (%d vs %d)",
+		      GET_APIC_ID(apic_read(APIC_ID)), boot_cpu_id);
+		/* Or can we switch back to PIC here? */
 	}
-
-	Dprintk("Boot done.\n");
+	x86_cpu_to_apicid[0] = boot_cpu_id;
 
 	/*
-	 * Here we can be sure that there is an IO-APIC in the system. Let's
-	 * go and set it up:
+	 * Now start the IO-APICs
 	 */
 	if (!skip_ioapic_setup && nr_ioapics)
 		setup_IO_APIC();
 	else
 		nr_ioapics = 0;
 
-	setup_boot_APIC_clock();
-
 	/*
-	 * Synchronize the TSC with the AP
+	 * Set up local APIC timer on boot CPU.
 	 */
-	if (cpu_has_tsc && cpucount)
-		synchronize_tsc_bp();
 
- smp_done:
-	time_init_smp();
+	setup_boot_APIC_clock();
 }
 
-/* These are wrappers to interface to the new boot process.  Someone
-   who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
-void __init smp_prepare_cpus(unsigned int max_cpus)
+/*
+ * Early setup to make printk work.
+ */
+void __init smp_prepare_boot_cpu(void)
 {
-	smp_boot_cpus(max_cpus);
+	int me = smp_processor_id();
+	cpu_set(me, cpu_online_map);
+	cpu_set(me, cpu_callout_map);
 }
 
-void __devinit smp_prepare_boot_cpu(void)
+/*
+ * Entry point to boot a CPU.
+ *
+ * This is all __cpuinit, not __devinit for now because we don't support
+ * CPU hotplug (yet).
+ */
+int __cpuinit __cpu_up(unsigned int cpu)
 {
-	cpu_set(smp_processor_id(), cpu_online_map);
-	cpu_set(smp_processor_id(), cpu_callout_map);
-}
+	int err;
+	int apicid = cpu_present_to_apicid(cpu);
 
-int __devinit __cpu_up(unsigned int cpu)
-{
-	/* This only works at boot for x86.  See "rewrite" above. */
-	if (cpu_isset(cpu, smp_commenced_mask)) {
-		local_irq_enable();
-		return -ENOSYS;
+	WARN_ON(irqs_disabled());
+
+	Dprintk("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
+
+	if (apicid == BAD_APICID || apicid == boot_cpu_id ||
+	    !physid_isset(apicid, phys_cpu_present_map)) {
+		printk("__cpu_up: bad cpu %d\n", cpu);
+		return -EINVAL;
 	}
+	sync_tsc_bp_init(1);
 
-	/* In case one didn't come up */
-	if (!cpu_isset(cpu, cpu_callin_map)) {
-		local_irq_enable();
-		return -EIO;
+	/* Boot it! */
+	err = do_boot_cpu(cpu, apicid);
+	if (err < 0) {
+		sync_tsc_bp_init(0);
+		Dprintk("do_boot_cpu failed %d\n", err);
+		return err;
 	}
-	local_irq_enable();
+
+	sync_tsc_bp(cpu);
 
 	/* Unleash the CPU! */
 	Dprintk("waiting for cpu %d\n", cpu);
 
-	cpu_set(cpu, smp_commenced_mask);
 	while (!cpu_isset(cpu, cpu_online_map))
-		mb();
+		cpu_relax();
 	return 0;
 }
 
-void __init smp_cpus_done(unsigned int max_cpus)
+/*
+ * Finish the SMP boot.
+ */
+void __cpuinit smp_cpus_done(unsigned int max_cpus)
 {
+	zap_low_mappings();
+	smp_cleanup_boot();
+
 #ifdef CONFIG_X86_IO_APIC
 	setup_ioapic_dest();
 #endif
-	zap_low_mappings();
-}
 
+	detect_siblings();
+	time_init_gtod();
+}
diff -puN arch/x86_64/kernel/smp.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state arch/x86_64/kernel/smp.c
--- 25/arch/x86_64/kernel/smp.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state	2005-04-12 03:21:27.387973296 -0700
+++ 25-akpm/arch/x86_64/kernel/smp.c	2005-04-12 03:21:27.401971168 -0700
@@ -27,6 +27,7 @@
 #include <asm/mach_apic.h>
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
+#include <asm/apicdef.h>
 
 /*
  *	Smarter SMP flushing macros. 
@@ -413,3 +414,27 @@ asmlinkage void smp_call_function_interr
 		atomic_inc(&call_data->finished);
 	}
 }
+
+int safe_smp_processor_id(void)
+{
+	int apicid, i;
+
+	if (disable_apic)
+		return 0;
+
+	apicid = hard_smp_processor_id();
+	if (x86_cpu_to_apicid[apicid] == apicid)
+		return apicid;
+
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (x86_cpu_to_apicid[i] == apicid)
+			return i;
+	}
+
+	/* No entries in x86_cpu_to_apicid?  Either no MPS|ACPI,
+	 * or called too early.  Either way, we must be CPU 0. */
+      	if (x86_cpu_to_apicid[0] == BAD_APICID)
+		return 0;
+
+	return 0; /* Should not happen */
+}
diff -puN arch/x86_64/kernel/time.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state arch/x86_64/kernel/time.c
--- 25/arch/x86_64/kernel/time.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state	2005-04-12 03:21:27.389972992 -0700
+++ 25-akpm/arch/x86_64/kernel/time.c	2005-04-12 03:21:27.402971016 -0700
@@ -916,9 +916,16 @@ void __init time_init(void)
 	setup_irq(0, &irq0);
 
 	set_cyc2ns_scale(cpu_khz / 1000);
+
+#ifndef CONFIG_SMP
+	time_init_gtod();
+#endif
 }
 
-void __init time_init_smp(void)
+/*
+ * Decide after all CPUs are booted what mode gettimeofday should use.
+ */
+void __init time_init_gtod(void)
 {
 	char *timetype;
 
diff -puN include/asm-x86_64/msr.h~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state include/asm-x86_64/msr.h
--- 25/include/asm-x86_64/msr.h~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state	2005-04-12 03:21:27.390972840 -0700
+++ 25-akpm/include/asm-x86_64/msr.h	2005-04-12 03:21:27.403970864 -0700
@@ -163,6 +163,7 @@ extern inline unsigned int cpuid_edx(uns
 #define EFER_NX (1<<_EFER_NX)
 
 /* Intel MSRs. Some also available on other CPUs */
+#define MSR_IA32_TSC		0x10
 #define MSR_IA32_PLATFORM_ID	0x17
 
 #define MSR_IA32_PERFCTR0      0xc1
diff -puN include/asm-x86_64/proto.h~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state include/asm-x86_64/proto.h
--- 25/include/asm-x86_64/proto.h~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state	2005-04-12 03:21:27.391972688 -0700
+++ 25-akpm/include/asm-x86_64/proto.h	2005-04-12 03:21:27.403970864 -0700
@@ -29,7 +29,7 @@ extern void config_acpi_tables(void);
 extern void ia32_syscall(void);
 extern void iommu_hole_init(void);
 
-extern void time_init_smp(void);
+extern void time_init_gtod(void);
 
 extern void do_softirq_thunk(void);
 
diff -puN include/asm-x86_64/smp.h~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state include/asm-x86_64/smp.h
--- 25/include/asm-x86_64/smp.h~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state	2005-04-12 03:21:27.392972536 -0700
+++ 25-akpm/include/asm-x86_64/smp.h	2005-04-12 03:21:27.404970712 -0700
@@ -31,12 +31,16 @@ extern int disable_apic;
 
 struct pt_regs;
 
+extern cpumask_t cpu_present_mask;
+extern cpumask_t cpu_possible_map;
+extern cpumask_t cpu_online_map;
+extern cpumask_t cpu_callout_map;
+
 /*
  * Private routines/data
  */
  
 extern void smp_alloc_memory(void);
-extern cpumask_t cpu_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
 extern int smp_num_siblings;
@@ -44,7 +48,6 @@ extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_send_reschedule(int cpu);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
-extern void (*mtrr_hook) (void);
 extern void zap_low_mappings(void);
 void smp_stop_cpu(void);
 extern cpumask_t cpu_sibling_map[NR_CPUS];
@@ -60,10 +63,6 @@ extern u8 cpu_core_id[NR_CPUS];
  * compresses data structures.
  */
 
-extern cpumask_t cpu_callout_map;
-extern cpumask_t cpu_callin_map;
-#define cpu_possible_map cpu_callout_map
-
 static inline int num_booting_cpus(void)
 {
 	return cpus_weight(cpu_callout_map);
@@ -77,7 +76,7 @@ extern __inline int hard_smp_processor_i
 	return GET_APIC_ID(*(unsigned int *)(APIC_BASE+APIC_ID));
 }
 
-#define safe_smp_processor_id() (disable_apic ? 0 : x86_apicid_to_cpu(hard_smp_processor_id()))
+extern int safe_smp_processor_id(void);
 
 #endif /* !ASSEMBLY */
 
@@ -99,22 +98,6 @@ static inline unsigned int cpu_mask_to_a
 	return cpus_addr(cpumask)[0];
 }
 
-static inline int x86_apicid_to_cpu(u8 apicid)
-{
-	int i;
-
-	for (i = 0; i < NR_CPUS; ++i)
-		if (x86_cpu_to_apicid[i] == apicid)
-			return i;
-
-	/* No entries in x86_cpu_to_apicid?  Either no MPS|ACPI,
-	 * or called too early.  Either way, we must be CPU 0. */
-      	if (x86_cpu_to_apicid[0] == BAD_APICID)
-		return 0;
-
-	return -1;
-}
-
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < NR_CPUS)
_
