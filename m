Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVDDCVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVDDCVD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVDDCRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:17:38 -0400
Received: from fmr17.intel.com ([134.134.136.16]:16771 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261978AbVDDCJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:09:24 -0400
Subject: [RFC 6/6]Physcial CPU hotadd and S3 SMP support
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1112580369.4194.346.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:07:09 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boot a CPU at runtime and use it to support S3 SMP.

Thanks,
Shaohua

---

 linux-2.6.11-root/arch/i386/kernel/smpboot.c |   79 +++++++++++++++++++++++----
 linux-2.6.11-root/include/asm-i386/smp.h     |    4 +
 linux-2.6.11-root/kernel/power/main.c        |   30 ++++++++++
 3 files changed, 104 insertions(+), 9 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~warmboot_cpu arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~warmboot_cpu	2005-04-04 09:13:48.600255048 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-04 09:13:48.607253984 +0800
@@ -76,6 +76,12 @@ cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
 
+/* This is ugly, but TSC's upper 32 bits can't be written in eariler CPU
+ * (before prescott), there is no way to resync one AP against BP
+ * TBD: for prescott and above, we should use IA64's algorithm
+ */
+static int __devinit tsc_sync_disabled;
+
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
@@ -412,7 +418,7 @@ static void __devinit smp_callin(void)
 	/*
 	 *      Synchronize the TSC with the BP
 	 */
-	if (cpu_has_tsc && cpu_khz)
+	if (cpu_has_tsc && cpu_khz && !tsc_sync_disabled)
 		synchronize_tsc_ap();
 }
 
@@ -781,8 +787,19 @@ wakeup_secondary_cpu(int phys_apicid, un
 #endif	/* WAKE_SECONDARY_VIA_INIT */
 
 extern cpumask_t cpu_initialized;
+static inline int alloc_cpu_id(void)
+{
+	cpumask_t	tmp_map;
+	int cpu;
 
-static int __devinit do_boot_cpu(int apicid)
+	cpus_complement(tmp_map, cpu_present_map);
+	cpu = first_cpu(tmp_map);
+	if (cpu >= NR_CPUS)
+		return -ENODEV;
+	return cpu;
+}
+
+static int __devinit do_boot_cpu(int apicid, int cpu)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -791,15 +808,10 @@ static int __devinit do_boot_cpu(int api
 {
 	struct task_struct *idle;
 	unsigned long boot_error;
-	int timeout, cpu;
+	int timeout;
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
-	cpumask_t	tmp_map;
 
-	cpus_complement(tmp_map, cpu_present_map);
-	cpu = first_cpu(tmp_map);
-	if (cpu >= NR_CPUS)
-		return -ENODEV;
 	++cpucount;
 	/*
 	 * We can't use kernel_thread since we must avoid to
@@ -920,6 +932,53 @@ void cpu_exit_clear(int cpu)
 
 	do_exit_idle();
 }
+
+struct warm_boot_cpu_info {
+	struct completion *complete;
+	int apicid;
+	int cpu;
+};
+
+static void __devinit do_warm_boot_cpu(void *p)
+{
+	struct warm_boot_cpu_info *info = p;
+	do_boot_cpu(info->apicid, info->cpu);
+	complete(info->complete);
+}
+
+int __devinit smp_prepare_cpu(int apicid)
+{
+	DECLARE_COMPLETION(done);
+	struct warm_boot_cpu_info info;
+	struct work_struct task;
+	int cpu;
+
+	lock_cpu_hotplug();
+	cpu = alloc_cpu_id();
+
+	if (cpu < 0)
+		goto exit;
+
+	info.complete = &done;
+	info.apicid = apicid;
+	info.cpu = cpu;
+	INIT_WORK(&task, do_warm_boot_cpu, &info);
+
+	tsc_sync_disabled = 1;
+
+	/* init low mem mapping */
+	memcpy(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
+		sizeof(swapper_pg_dir[0]) * KERNEL_PGD_PTRS);
+	flush_tlb_all();
+	schedule_work(&task);
+	wait_for_completion(&done);
+
+	tsc_sync_disabled = 0;
+	zap_low_mappings();
+exit:
+	unlock_cpu_hotplug();
+	return cpu;
+}
 #endif
 static void smp_tune_scheduling (void)
 {
@@ -1064,7 +1123,7 @@ static void __init smp_boot_cpus(unsigne
 		if (max_cpus <= cpucount+1)
 			continue;
 
-		if (do_boot_cpu(apicid))
+		if (((cpu = alloc_cpu_id()) > 0) && do_boot_cpu(apicid, cpu))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
 		else
@@ -1253,10 +1312,12 @@ void __init smp_cpus_done(unsigned int m
 	setup_ioapic_dest();
 #endif
 	zap_low_mappings();
+#ifndef CONFIG_STR_SMP
 	/*
 	 * Disable executability of the SMP trampoline:
 	 */
 	set_kernel_exec((unsigned long)trampoline_base, trampoline_exec);
+#endif
 }
 
 void __init smp_intr_init(void)
diff -puN kernel/power/main.c~warmboot_cpu kernel/power/main.c
--- linux-2.6.11/kernel/power/main.c~warmboot_cpu	2005-04-04 09:13:48.601254896 +0800
+++ linux-2.6.11-root/kernel/power/main.c	2005-04-04 09:13:48.607253984 +0800
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/cpu.h>
 
 
 #include "power.h"
@@ -137,6 +138,24 @@ static char * pm_states[] = {
 static int enter_state(suspend_state_t state)
 {
 	int error;
+#ifdef CONFIG_STR_SMP
+	cpumask_t	phyid_map;
+	int		cpu;
+	int		phyid;
+
+	/* suspend to disk doesn't require physical CPU hotplug */
+	if (state != PM_SUSPEND_MEM &&
+		state != PM_SUSPEND_STANDBY)
+		goto skip_mp;
+	cpus_clear(phyid_map);
+	for_each_online_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+		cpu_set(cpu_to_phyid(cpu), phyid_map);
+		cpu_down(cpu);
+	}
+skip_mp:
+#endif
 
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
@@ -163,6 +182,17 @@ static int enter_state(suspend_state_t s
 	suspend_finish(state);
  Unlock:
 	up(&pm_sem);
+#ifdef CONFIG_STR_SMP
+	if (state != PM_SUSPEND_MEM &&
+		state != PM_SUSPEND_STANDBY)
+		return error;
+
+	for_each_cpu_mask(phyid, phyid_map) {
+		cpu = smp_prepare_cpu(phyid);
+		if (cpu > 0)
+			cpu_up(cpu);
+	}
+#endif
 	return error;
 }
 
diff -puN include/asm-i386/smp.h~warmboot_cpu include/asm-i386/smp.h
--- linux-2.6.11/include/asm-i386/smp.h~warmboot_cpu	2005-04-04 09:13:48.603254592 +0800
+++ linux-2.6.11-root/include/asm-i386/smp.h	2005-04-04 09:13:48.607253984 +0800
@@ -45,6 +45,10 @@ extern void zap_low_mappings (void);
 #define MAX_APICID 256
 extern u8 x86_cpu_to_apicid[];
 
+#ifdef CONFIG_STR_SMP
+#define cpu_to_phyid(cpu) (x86_cpu_to_apicid[cpu])
+extern int smp_prepare_cpu(int phyid);
+#endif
 /*
  * This function is needed by all SMP systems. It must _always_ be valid
  * from the initial startup. We map APIC_BASE very early in page_setup(),
_


