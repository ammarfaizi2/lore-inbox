Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUGFMFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUGFMFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 08:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGFMFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 08:05:44 -0400
Received: from gprs214-134.eurotel.cz ([160.218.214.134]:43648 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263804AbUGFMFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 08:05:32 -0400
Date: Tue, 6 Jul 2004 14:05:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: len.brown@intel.com, shaohua.li@intel.com,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: smp support for s3 (not yet working)
Message-ID: <20040706120513.GA26356@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Supporting SMP on S3 will be harder than SMP on swsusp... For swsusp,
all cpus are initialized by kernel doing the resume, so we can just
stop them and restart them. For S3, we'll have to kick start cpus by
hand :-(.

If you remove code in acpi_restore_state_mem, it will actually resume,
enable to type commands into bash, but die very soon because second
cpu is not active.

If there's easy way to kick c to life, let me know...

								Pavel

--- clean.amd/arch/i386/kernel/acpi/sleep.c	2003-08-10 21:22:29.000000000 +0200
+++ linux/arch/i386/kernel/acpi/sleep.c	2004-07-06 13:24:29.000000000 +0200
@@ -60,6 +60,12 @@
  */
 void acpi_restore_state_mem (void)
 {
+	printk("Preparing cpus...\n");
+	smp_prepare_cpus(2);
+
+	printk("CPUs ready\n");
+
+	printk("Zapping mappings\n");
 	zap_low_mappings();
 }
 
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' -x '*.cmd' clean.amd/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- clean.amd/arch/i386/kernel/smpboot.c	2004-06-22 12:37:44.000000000 +0200
+++ linux/arch/i386/kernel/smpboot.c	2004-07-06 13:32:02.000000000 +0200
@@ -56,8 +56,10 @@
 #include <mach_wakecpu.h>
 #include <smpboot_hooks.h>
 
+#define DEBUG
+
 /* Set if we find a B stepping CPU */
-static int __initdata smp_b_stepping;
+static int smp_b_stepping;
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -90,7 +92,7 @@
  * has made sure it's suitably aligned.
  */
 
-static unsigned long __init setup_trampoline(void)
+static unsigned long  setup_trampoline(void)
 {
 	memcpy(trampoline_base, trampoline_data, trampoline_end - trampoline_data);
 	return virt_to_phys(trampoline_base);
@@ -100,7 +102,7 @@
  * We are called very early to get the low memory for the
  * SMP bootup trampoline page.
  */
-void __init smp_alloc_memory(void)
+void  smp_alloc_memory(void)
 {
 	trampoline_base = (void *) alloc_bootmem_low_pages(PAGE_SIZE);
 	/*
@@ -116,7 +118,7 @@
  * a given CPU
  */
 
-static void __init smp_store_cpu_info(int id)
+static void  smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c = cpu_data + id;
 
@@ -195,7 +197,7 @@
  *		    ^---- (this multiplication can overflow)
  */
 
-static unsigned long long __init div64 (unsigned long long a, unsigned long b0)
+static unsigned long long  div64 (unsigned long long a, unsigned long b0)
 {
 	unsigned int a1, a2;
 	unsigned long long res;
@@ -211,7 +213,7 @@
 	return res;
 }
 
-static void __init synchronize_tsc_bp (void)
+static void  synchronize_tsc_bp (void)
 {
 	int i;
 	unsigned long long t0;
@@ -307,7 +309,7 @@
 		;
 }
 
-static void __init synchronize_tsc_ap (void)
+static void  synchronize_tsc_ap (void)
 {
 	int i;
 
@@ -337,7 +339,7 @@
 
 static atomic_t init_deasserted;
 
-void __init smp_callin(void)
+void  smp_callin(void)
 {
 	int cpuid, phys_id;
 	unsigned long timeout;
@@ -421,11 +423,13 @@
 	 */
 	cpu_set(cpuid, cpu_callin_map);
 
+#if 0
 	/*
 	 *      Synchronize the TSC with the BP
 	 */
 	if (cpu_has_tsc && cpu_khz)
 		synchronize_tsc_ap();
+#endif
 }
 
 int cpucount;
@@ -435,7 +439,7 @@
 /*
  * Activate a secondary processor.
  */
-int __init start_secondary(void *unused)
+int  start_secondary(void *unused)
 {
 	/*
 	 * Dont put anything before smp_callin(), SMP
@@ -469,7 +473,7 @@
  * from the task structure
  * This function must not return.
  */
-void __init initialize_secondary(void)
+void  initialize_secondary(void)
 {
 	/*
 	 * We don't actually need to load the full TSS,
@@ -488,7 +492,7 @@
 	unsigned short ss;
 } stack_start;
 
-static struct task_struct * __init fork_by_hand(void)
+static struct task_struct *  fork_by_hand(void)
 {
 	struct pt_regs regs;
 	/*
@@ -593,7 +597,7 @@
  * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
  * won't ... remember to clear down the APIC, etc later.
  */
-static int __init
+static int 
 wakeup_secondary_cpu(int logical_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
@@ -639,7 +643,7 @@
 #endif	/* WAKE_SECONDARY_VIA_NMI */
 
 #ifdef WAKE_SECONDARY_VIA_INIT
-static int __init
+static int 
 wakeup_secondary_cpu(int phys_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
@@ -775,7 +779,7 @@
 
 extern cpumask_t cpu_initialized;
 
-static int __init do_boot_cpu(int apicid)
+static int  do_boot_cpu(int apicid)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -939,7 +943,7 @@
 
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 
-static void __init smp_boot_cpus(unsigned int max_cpus)
+static void  smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit, kicked;
 	unsigned long bogosum = 0;
@@ -1136,7 +1140,7 @@
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
-__init void arch_init_sched_domains(void)
+ void arch_init_sched_domains(void)
 {
 	int i;
 	struct sched_group *first = NULL, *last = NULL;
@@ -1256,7 +1260,7 @@
 static struct sched_group sched_group_phys[NR_CPUS];
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-__init void arch_init_sched_domains(void)
+ void arch_init_sched_domains(void)
 {
 	int i;
 	struct sched_group *first = NULL, *last = NULL;
@@ -1333,7 +1337,7 @@
 
 /* These are wrappers to interface to the new boot process.  Someone
    who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
-void __init smp_prepare_cpus(unsigned int max_cpus)
+void  smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_boot_cpus(max_cpus);
 }
@@ -1366,7 +1370,7 @@
 	return 0;
 }
 
-void __init smp_cpus_done(unsigned int max_cpus)
+void  smp_cpus_done(unsigned int max_cpus)
 {
 #ifdef CONFIG_X86_IO_APIC
 	setup_ioapic_dest();
@@ -1374,7 +1378,7 @@
 	zap_low_mappings();
 }
 
-void __init smp_intr_init(void)
+void  smp_intr_init(void)
 {
 	/*
 	 * IRQ0 must be given a fixed assignment and initialized,
--- clean.amd/kernel/power/main.c	2004-05-20 23:12:03.000000000 +0200
+++ linux/kernel/power/main.c	2004-07-06 12:36:00.000000000 +0200
@@ -64,9 +64,11 @@
 		goto Thaw;
 	}
 
+	disable_nonboot_cpus();
+
 	if (pm_ops->prepare) {
 		if ((error = pm_ops->prepare(state)))
-			goto Thaw;
+			goto Thaw2;
 	}
 
 	if ((error = device_suspend(state)))
@@ -75,6 +77,10 @@
  Finish:
 	if (pm_ops->finish)
 		pm_ops->finish(state);
+
+ Thaw2:
+	printk("Enabling all cpus\n");
+	enable_nonboot_cpus();
  Thaw:
 	thaw_processes();
 	pm_restore_console();
@@ -144,12 +150,14 @@
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
 
+#if 0
 	/* Suspend is hard to get right on SMP. */
 	if (num_online_cpus() != 1) {
+		printk("Suspends not supported on SMP\n");
 		error = -EPERM;
 		goto Unlock;
 	}
-
+#endif
 	if (state == PM_SUSPEND_DISK) {
 		error = pm_suspend_disk();
 		goto Unlock;
@@ -164,6 +172,7 @@
 
 	pr_debug("PM: Finishing up.\n");
 	suspend_finish(state);
+
  Unlock:
 	up(&pm_sem);
 	return error;


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
