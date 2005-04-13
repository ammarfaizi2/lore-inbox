Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVDMDbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVDMDbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVDMD3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 23:29:33 -0400
Received: from fmr18.intel.com ([134.134.136.17]:16328 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262577AbVDMD0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 23:26:30 -0400
Subject: Re: [PATCH 5/6]physical CPU hot add
From: Li Shaohua <shaohua.li@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504120609350.14171@montezuma.fsmlabs.com>
References: <1113283863.27646.432.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.61.0504120609350.14171@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1113362611.7148.40.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Apr 2005 11:23:31 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 20:17, Zwane Mwaikambo wrote:
> On Tue, 12 Apr 2005, Li Shaohua wrote:
> 
> >  #ifdef CONFIG_HOTPLUG_CPU
> > +int __attribute__ ((weak)) smp_prepare_cpu(int cpu)
> > +{
> > +	return 0;
> > +}
> > +
> 
> Any way for you to avoid using weak attribute?
Replace weak attribute with define method as suggested.

Thanks,
Shaohua


---

 linux-2.6.11-root/arch/i386/kernel/smpboot.c |  112 ++++++++++++++++++++-------
 linux-2.6.11-root/drivers/base/cpu.c         |    7 +
 linux-2.6.11-root/include/asm-i386/smp.h     |    3 
 3 files changed, 93 insertions(+), 29 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~warm_boot_cpu arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~warm_boot_cpu	2005-04-13 10:58:37.152081456 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-13 10:58:37.159080392 +0800
@@ -80,6 +80,12 @@ cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
 
+/* TSC's upper 32 bits can't be written in eariler CPU (before prescott), there
+ * is no way to resync one AP against BP. TBD: for prescott and above, we
+ * should use IA64's algorithm
+ */
+static int __devinitdata tsc_sync_disabled;
+
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
@@ -416,7 +422,7 @@ static void __devinit smp_callin(void)
 	/*
 	 *      Synchronize the TSC with the BP
 	 */
-	if (cpu_has_tsc && cpu_khz)
+	if (cpu_has_tsc && cpu_khz && !tsc_sync_disabled)
 		synchronize_tsc_ap();
 }
 
@@ -809,6 +815,31 @@ static inline int alloc_cpu_id(void)
 	return cpu;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static struct task_struct * __devinitdata cpu_idle_tasks[NR_CPUS];
+static inline struct task_struct * alloc_idle_task(int cpu)
+{
+	struct task_struct *idle;
+
+	if ((idle = cpu_idle_tasks[cpu]) != NULL) {
+		/* initialize thread_struct.  we really want to avoid destroy
+		 * idle tread
+		 */
+		idle->thread.esp = (unsigned long)(((struct pt_regs *)
+			(THREAD_SIZE + (unsigned long) idle->thread_info)) - 1);
+		init_idle(idle, cpu);
+		return idle;
+	}
+	idle = fork_idle(cpu);
+
+	if (!IS_ERR(idle))
+		cpu_idle_tasks[cpu] = idle;
+	return idle;
+}
+#else
+#define alloc_idle_task(cpu) fork_idle(cpu)
+#endif
+
 static int __devinit do_boot_cpu(int apicid, int cpu)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
@@ -828,7 +859,7 @@ static int __devinit do_boot_cpu(int api
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	idle = fork_idle(cpu);
+	idle = alloc_idle_task(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 	idle->thread.eip = (unsigned long) start_secondary;
@@ -931,6 +962,55 @@ void cpu_exit_clear(void)
 	cpu_clear(cpu, smp_commenced_mask);
 	unmap_cpu_to_logical_apicid(cpu);
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
+int __devinit smp_prepare_cpu(int cpu)
+{
+	DECLARE_COMPLETION(done);
+	struct warm_boot_cpu_info info;
+	struct work_struct task;
+	int	apicid, ret;
+
+	lock_cpu_hotplug();
+	apicid = x86_cpu_to_apicid[cpu];
+	if (apicid == BAD_APICID) {
+		ret = -ENODEV;
+		goto exit;
+	}
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
+			sizeof(swapper_pg_dir[0]) * KERNEL_PGD_PTRS);
+	flush_tlb_all();
+	schedule_work(&task);
+	wait_for_completion(&done);
+
+	tsc_sync_disabled = 0;
+	zap_low_mappings();
+	ret = 0;
+exit:
+	unlock_cpu_hotplug();
+	return ret;
+}
 #endif
 
 static void smp_tune_scheduling (void)
@@ -1169,24 +1249,6 @@ void __devinit smp_prepare_boot_cpu(void
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-
-/* must be called with the cpucontrol mutex held */
-static int __devinit cpu_enable(unsigned int cpu)
-{
-	/* get the target out of its holding state */
-	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
-	wmb();
-
-	/* wait for the processor to ack it. timeout? */
-	while (!cpu_online(cpu))
-		cpu_relax();
-
-	fixup_irqs(cpu_online_map);
-	/* counter the disable in fixup_irqs() */
-	local_irq_enable();
-	return 0;
-}
-
 static void
 remove_siblinginfo(int cpu)
 {
@@ -1270,14 +1332,6 @@ int __devinit __cpu_up(unsigned int cpu)
 		return -EIO;
 	}
 
-#ifdef CONFIG_HOTPLUG_CPU
-	/* Already up, and in cpu_quiescent now? */
-	if (cpu_isset(cpu, smp_commenced_mask)) {
-		cpu_enable(cpu);
-		return 0;
-	}
-#endif
-
 	local_irq_enable();
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
@@ -1292,10 +1346,12 @@ void __init smp_cpus_done(unsigned int m
 	setup_ioapic_dest();
 #endif
 	zap_low_mappings();
+#ifndef CONFIG_HOTPLUG_CPU
 	/*
 	 * Disable executability of the SMP trampoline:
 	 */
 	set_kernel_exec((unsigned long)trampoline_base, trampoline_exec);
+#endif
 }
 
 void __init smp_intr_init(void)
diff -puN drivers/base/cpu.c~warm_boot_cpu drivers/base/cpu.c
--- linux-2.6.11/drivers/base/cpu.c~warm_boot_cpu	2005-04-13 10:58:37.153081304 +0800
+++ linux-2.6.11-root/drivers/base/cpu.c	2005-04-13 10:58:37.159080392 +0800
@@ -16,6 +16,10 @@ struct sysdev_class cpu_sysdev_class = {
 EXPORT_SYMBOL(cpu_sysdev_class);
 
 #ifdef CONFIG_HOTPLUG_CPU
+#ifndef __HAVE_ARCH_SMP_PREPARE_CPU
+#define smp_prepare_cpu(cpu) (0)
+#endif
+
 static ssize_t show_online(struct sys_device *dev, char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
@@ -36,7 +40,8 @@ static ssize_t store_online(struct sys_d
 			kobject_hotplug(&dev->kobj, KOBJ_OFFLINE);
 		break;
 	case '1':
-		ret = cpu_up(cpu->sysdev.id);
+		if ((ret = smp_prepare_cpu(cpu->sysdev.id)) == 0)
+			ret = cpu_up(cpu->sysdev.id);
 		break;
 	default:
 		ret = -EINVAL;
diff -puN include/asm-i386/smp.h~warm_boot_cpu include/asm-i386/smp.h
--- linux-2.6.11/include/asm-i386/smp.h~warm_boot_cpu	2005-04-13 10:58:37.155081000 +0800
+++ linux-2.6.11-root/include/asm-i386/smp.h	2005-04-13 11:00:26.353480320 +0800
@@ -52,6 +52,9 @@ extern u8 x86_cpu_to_apicid[];
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpu_exit_clear(void);
 extern void cpu_uninit(void);
+
+#define __HAVE_ARCH_SMP_PREPARE_CPU
+extern int smp_prepare_cpu(int cpu);
 #endif
 
 /*
_


