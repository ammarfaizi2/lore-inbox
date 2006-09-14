Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWINOuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWINOuD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWINOuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:50:02 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60849 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750699AbWINOt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:49:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        b=OnawiNBpnuO3O55ObAkWmWGkEIZJf5BSj9YoOct0XMCii6Tn0BcQ5vlE6IJUR9pgOO37nnlEQ0uXy87kDhbByMGVNGw3tJ/zeu7L7wsAqlX8dJKwaRbpaSEysQtAySJXWt9Q+ZF6LAEbwqpNmKIAtzMHxxFnUsEMxYOnXuiRFtU=
Message-ID: <45096C1A.7010008@gmail.com>
Date: Thu, 14 Sep 2006 18:50:02 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: pm list <linux-pm@lists.osdl.org>
CC: Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [RFC] CPUFreq PowerOP integration, Centrino PM Core and OPs registration
 2/3
Content-Type: multipart/mixed;
 boundary="------------060207060305070002040201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207060305070002040201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for centrino PM Core and operating points registration
module.

Operating points registration module uses hardcoded values or values retrieved
from ACPI to register operating points using PowerOP interface. The module is
completely independent from either cpufreq or centrino PM Core.

PM Core defines power parameters for the platform and handles all hw related
steps to set system to an operating point or retrieve a power parameter value.

Both speedstep-centrino-pm_core.c and speedstep-centrino.c do not belong to 
cpufreq anymore and should be removed from cpufreq
folder but were left there to simplify the diff investigation.



--------------060207060305070002040201
Content-Type: text/x-patch;
 name="centrino.pm.core.opt.regisration.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="centrino.pm.core.opt.regisration.patch"

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index f71fb4a..62d7523 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -814,6 +814,18 @@ source kernel/power/Kconfig
 
 source "drivers/acpi/Kconfig"
 
+menu "PM Core"
+
+config PM_CORE
+	tristate "PM Core"
+	depends POWEROP
+	help
+	This enables i386 PM Core to control platform freq/voltage via
+	PowerOP interface
+
+endmenu
+
+
 menu "APM (Advanced Power Management) BIOS Support"
 depends on PM && !X86_VISWS
 
diff --git a/arch/i386/kernel/cpu/cpufreq/Kconfig b/arch/i386/kernel/cpu/cpufreq/Kconfig
index ccc1edf..a1ce5a3 100644
--- a/arch/i386/kernel/cpu/cpufreq/Kconfig
+++ b/arch/i386/kernel/cpu/cpufreq/Kconfig
@@ -106,17 +106,11 @@ config X86_GX_SUSPMOD
 	 If in doubt, say N.
 
 config X86_SPEEDSTEP_CENTRINO
-	tristate "Intel Enhanced SpeedStep"
-	select CPU_FREQ_TABLE
+	tristate "SpeedStep operatin points registration"
+	depends on POWEROP
 	select X86_SPEEDSTEP_CENTRINO_TABLE if (!X86_SPEEDSTEP_CENTRINO_ACPI)
 	help
-	  This adds the CPUFreq driver for Enhanced SpeedStep enabled
-	  mobile CPUs.  This means Intel Pentium M (Centrino) CPUs. However,
-	  you also need to say Y to "Use ACPI tables to decode..." below
-	  [which might imply enabling ACPI] if you want to use this driver
-	  on non-Banias CPUs.
-
-	  For details, take a look at <file:Documentation/cpu-freq/>.
+	  Opeatin points registration module for SpeedStep Centrino
 
 	  If in doubt, say N.
 
diff --git a/arch/i386/kernel/cpu/cpufreq/Makefile b/arch/i386/kernel/cpu/cpufreq/Makefile
index 2e894f1..62753f6 100644
--- a/arch/i386/kernel/cpu/cpufreq/Makefile
+++ b/arch/i386/kernel/cpu/cpufreq/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_X86_LONGRUN)		+= longrun.o 
 obj-$(CONFIG_X86_GX_SUSPMOD)		+= gx-suspmod.o
 obj-$(CONFIG_X86_SPEEDSTEP_ICH)		+= speedstep-ich.o
 obj-$(CONFIG_X86_SPEEDSTEP_CENTRINO)	+= speedstep-centrino.o
+obj-$(CONFIG_PM_CORE)			+= speedstep-centrino-pm_core.o
 obj-$(CONFIG_X86_SPEEDSTEP_LIB)		+= speedstep-lib.o
 obj-$(CONFIG_X86_SPEEDSTEP_SMI)		+= speedstep-smi.o
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
diff --git a/arch/i386/kernel/cpu/cpufreq/speedstep-centrino-pm_core.c b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino-pm_core.c
new file mode 100644
index 0000000..8ed9008
--- /dev/null
+++ b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino-pm_core.c
@@ -0,0 +1,644 @@
+/*
+ * PM Core driver for Enhanced SpeedStep, as found in Intel's Pentium
+ * M (part of the Centrino chipset).
+ *
+ * Since the original Pentium M, most new Intel CPUs support Enhanced
+ * SpeedStep.
+ *
+ * Despite the "SpeedStep" in the name, this is almost entirely unlike
+ * traditional SpeedStep.
+ *
+ * Modelled on speedstep.c
+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * Copyright (C) 2006 Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Based on code by
+ * Copyright (C) 2003 Jeremy Fitzhardinge <jeremy@goop.org>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>	/* current */
+#include <linux/delay.h>
+#include <linux/compiler.h>
+#include <linux/powerop.h>
+
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+#include <linux/acpi.h>
+#include <acpi/processor.h>
+#endif
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+#include <asm/cpufeature.h>
+#include <asm/pm_core.h>
+
+static cpumask_t acpi_get_shared_mask(int cpu);
+
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+struct acpi_processor_performance *acpi_perf_data[NR_CPUS];
+#endif
+
+static long 
+get_vtg(int cpu)
+{
+	int v = 0;
+	unsigned l, h;
+	cpumask_t saved_mask;
+
+	saved_mask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	if (smp_processor_id() != cpu)
+		return 0;
+
+	rdmsr(MSR_IA32_PERF_STATUS, l, h);
+	v = (l & 0xff) * 16 + 700;
+
+	set_cpus_allowed(current, saved_mask);
+
+	return v;
+}
+
+/* Return the current CPU frequency in kHz 
+ * FIXME: 0 on return means error but the rc almost never is checked 
+ * against 0
+ * FIXME: due to direct calculation from msr this may work not for all cases
+ */ 
+static unsigned int 
+get_freq(int cpu)
+{
+	unsigned l, h;
+	unsigned clock_freq;
+	cpumask_t saved_mask;
+
+	saved_mask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	if (smp_processor_id() != cpu)
+		return 0;
+
+	rdmsr(MSR_IA32_PERF_STATUS, l, h);
+	clock_freq = (l >> 8) & 0xff;
+
+	if (unlikely(clock_freq == 0)) {
+		/*
+		 * On some CPUs, we can see transient MSR values (which are
+		 * not present in _PSS), while CPU is doing some automatic
+		 * P-state transition (like TM2). Get the last freq set 
+		 * in PERF_CTL.
+		 */
+		rdmsr(MSR_IA32_PERF_CTL, l, h);
+		clock_freq = (l >> 8) & 0xff;
+	}
+
+	set_cpus_allowed(current, saved_mask);
+
+	return clock_freq * 100 * 1000;
+}
+
+
+/* FIXME: verification is incomplete */
+static int
+sc_pm_core_verify_opt(struct pm_core_point *opt)
+{
+	/* 
+	 * Let's do some upfront error checking. If we fail any of these, 
+	 * then the whole operating point is suspect and therefore invalid.
+	 *
+	 * Vrification includes but is not limited to checking that passed
+	 * parameters are withing ranges.
+	 */
+	if (opt == NULL)
+		return -EINVAL;
+
+	/* TODO: implement all necessary checking */
+
+	return 0;
+}
+
+#define PWR_PARAM_SET	1
+#define PWR_PARAM_GET	2
+
+/* 
+ * FIXME: very temporary implementation, just to prove the concept !! 
+ */
+static int 
+process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
+		  int va_arg)
+{
+	int cpu = 0;
+	char buf[8];
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	{
+		sprintf(buf, "v%d", cpu);
+
+		if (strcmp(param_name, buf) == 0) {
+			if (op == PWR_PARAM_SET)
+				opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V] = 
+									va_arg;
+			else if (opt != NULL)
+				*(int *)va_arg = 
+				     opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V];
+			else if ((*(int *)va_arg = get_vtg(cpu)) <= 0)
+				return -EINVAL;
+			return 0;
+		}
+
+		sprintf(buf, "freq%d", cpu);
+
+		if (strcmp(param_name, buf) == 0) {
+			if (op == PWR_PARAM_SET)
+				opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ] = 
+									va_arg;
+			else if (opt != NULL)
+				*(int *)va_arg = 
+				  opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ];
+			else if ((*(int *)va_arg = get_freq(cpu)) <= 0)
+				return -EINVAL;
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+#define PWR_PARAM_MAX_LENGTH	20
+static void *
+sc_pm_create_point(const char *pwr_params, va_list args)
+{
+	struct pm_core_point *opt;
+	char buf[PWR_PARAM_MAX_LENGTH + 1];
+	int i = 0;
+	int err;
+
+	opt = kmalloc(sizeof(struct pm_core_point), GFP_KERNEL);
+	if (opt == NULL)
+		return NULL;
+	/* 
+	 * PM Core puts '-1' for all power parameters which are 
+	 * not listed explicitly
+	 */
+	I386_PM_CORE_INIT_OPT(opt);
+
+	i = 0;
+	while (*pwr_params) {
+		if (*pwr_params != ' ') {
+			buf[i] = *pwr_params++;
+			i++;
+		}
+		else {
+			buf[i] = 0;
+			err = process_pwr_param(opt, PWR_PARAM_SET, buf, 
+			                        (int)va_arg(args, int));
+			if (err != 0)
+				goto out;
+			i = 0;
+		}
+	}
+
+	return (void *)opt;
+out:
+	kfree(opt);
+	return NULL;
+}
+
+static int 
+sc_pm_core_set_opt(void *md_opt)
+{
+	int rc = 0, i = 0;
+	struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+	unsigned int	msr, oldmsr = 0, h = 0, cpu = 0;
+	cpumask_t		online_policy_cpus;
+	cpumask_t		saved_mask;
+	cpumask_t		set_mask, cpus;
+	cpumask_t		covered_cpus;
+	int			retval = 0;
+	unsigned int		j, first_cpu;
+	
+	rc = sc_pm_core_verify_opt(opt);
+	if (rc != 0)
+		return rc;
+	/* 
+	 * here current i386 pm core implenetation relies on the fact that 
+	 * nowadays all operation points have the following view: 
+	 * { -1, -1, ..., vtlgN, freqN, -1, -1 }
+	 * once the assumption is not true implementation needs to be adjusted
+	 * properly
+	 */
+	for (i = 0; i < NR_CPUS; i++)
+		if (opt->opt[i].pwpr[_I386_PM_CORE_POINT_FREQ] != -1) {
+			cpu = i;
+			break;
+		}	
+
+	cpus = acpi_get_shared_mask(i);
+	
+#ifdef CONFIG_HOTPLUG_CPU
+	/* cpufreq holds the hotplug lock, so we are safe from here on */
+	cpus_and(online_policy_cpus, cpu_online_map, cpus);
+#else
+	online_policy_cpus = cpus;
+#endif
+
+	saved_mask = current->cpus_allowed;
+	first_cpu = 1;
+	cpus_clear(covered_cpus);
+	for_each_cpu_mask(j, online_policy_cpus) {
+		/*
+		 * Support for SMP systems.
+		 * Make sure we are running on CPU that wants to change freq
+		 */
+		cpus_clear(set_mask);
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+		if (acpi_perf_data[cpu]->shared_type == 
+						     DOMAIN_COORD_TYPE_SW_ANY)
+			cpus_or(set_mask, set_mask, online_policy_cpus);
+		else
+#endif
+			cpu_set(j, set_mask);
+
+		set_cpus_allowed(current, set_mask);
+		if (unlikely(!cpu_isset(smp_processor_id(), set_mask))) {
+			printk("couldn't limit to CPUs in this domain\n");
+			retval = -EAGAIN;
+			if (first_cpu) {
+				/* We haven't started the transition yet. */
+				goto migrate_end;
+			}
+			break;
+		}
+
+		msr = 
+		  (((opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ])/100) << 8) | 
+		   ((opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V] - 700) / 16);
+
+		if (first_cpu) {
+			rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+			if (msr == (oldmsr & 0xffff)) {
+				printk("no change needed - msr was and needs "
+					"to be %x\n", oldmsr);
+				retval = 0;
+				goto migrate_end;
+			}
+
+			first_cpu = 0;
+			/* all but 16 LSB are reserved, treat them with care */
+			oldmsr &= ~0xffff;
+			msr &= 0xffff;
+			oldmsr |= msr;
+		}
+
+		wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+		if (acpi_perf_data[cpu]->shared_type == 
+						      DOMAIN_COORD_TYPE_SW_ANY)
+			break;
+#endif
+		cpu_set(j, covered_cpus);
+	}
+
+	if (unlikely(retval)) {
+		/*
+		 * We have failed halfway through the frequency change.
+		 * We have sent callbacks to policy->cpus and
+		 * MSRs have already been written on coverd_cpus.
+		 * Best effort undo..
+		 */
+
+		if (!cpus_empty(covered_cpus)) {
+			for_each_cpu_mask(j, covered_cpus) {
+				set_cpus_allowed(current, cpumask_of_cpu(j));
+				wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+			}
+		}
+	}
+
+migrate_end:
+	set_cpus_allowed(current, saved_mask);
+
+	return retval;
+}
+
+static int
+sc_pm_core_get_opt(void *md_opt, const char *pwr_params, va_list args)
+{
+	int err = 0;
+	int i = 0;
+	struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+	char buf[PWR_PARAM_MAX_LENGTH + 1];
+
+	i = 0;
+	while (*pwr_params) {
+		if (*pwr_params != ' ') {
+			buf[i] = *pwr_params++;
+			i++;
+		}
+		else {
+			buf[i] = 0;
+			err = process_pwr_param(opt, PWR_PARAM_GET, buf, 
+			                        (int)va_arg(args, int));
+			if (err != 0)
+				return err;
+			i = 0;
+		}
+	}
+
+	return 0;
+}
+
+
+static struct powerop_driver sc_pm_core_driver = {
+	.name                   = "speedstep-centrino pm core driver",
+	.create_point           = sc_pm_create_point,
+	.get_point              = sc_pm_core_get_opt,
+	.set_point              = sc_pm_core_set_opt, 
+};
+
+/* 
+ * ACPI auxiliary routines are needed since PM Core needs access to 
+ * p->shared_cpu_map at set point time
+ * FIXME: all auxiliary routine might be elsewhere, especially 
+ * arch_get_shared_mask_on_cpu()
+ */
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+static cpumask_t 
+acpi_get_shared_mask(int cpu)
+{
+	struct acpi_processor_performance       *p;
+
+	p = acpi_perf_data[cpu];
+	if (p->shared_type == DOMAIN_COORD_TYPE_SW_ALL||
+	    p->shared_type == DOMAIN_COORD_TYPE_SW_ANY)
+		return p->shared_cpu_map;
+	else
+		return cpumask_of_cpu(cpu); 
+}
+
+/*
+ * cpu_early_init_acpi - Do the preregistering with ACPI P-States
+ * library
+ *
+ * Before doing the actual init, we need to do _PSD related setup whenever
+ * supported by the BIOS. These are handled by this early_init routine.
+ */
+static int 
+acpi_early_init(void)
+{
+	unsigned int	i, j;
+	struct acpi_processor_performance	*data;
+
+	for_each_possible_cpu(i) {
+		data = kzalloc(sizeof(struct acpi_processor_performance), 
+				GFP_KERNEL);
+		if (!data) {
+			for_each_possible_cpu(j) {
+				kfree(acpi_perf_data[j]);
+				acpi_perf_data[j] = NULL;
+			}
+			return -ENOMEM;
+		}
+		acpi_perf_data[i] = data;
+	}
+
+	acpi_processor_preregister_performance(acpi_perf_data);
+	return 0;
+}
+
+static int 
+acpi_cpu_data_init(int cpu)
+{
+	int result = 0;
+	struct cpuinfo_x86 *x86_cpu = &cpu_data[cpu];
+	int i;
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+	struct acpi_processor_performance *p;
+#endif
+
+	/* Only Intel makes Enhanced Speedstep-capable CPUs */
+	if (x86_cpu->x86_vendor != X86_VENDOR_INTEL ||
+	    !cpu_has(x86_cpu, X86_FEATURE_EST))
+		return -ENODEV;
+
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+	p = acpi_perf_data[cpu];
+
+	/* register with ACPI core */
+	if (acpi_processor_register_performance(p, cpu)) {
+		printk("obtaining ACPI data failed\n");
+		return -EIO;
+	}
+
+	/* verify the acpi_data */
+	if (p->state_count <= 1) {
+		printk("No P-States\n");
+		result = -ENODEV;
+		goto err_unreg;
+	}
+
+	if ((p->control_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) ||
+	    (p->status_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)) {
+		printk("Invalid control/status registers (%x - %x)\n",
+			p->control_register.space_id, 
+			p->status_register.space_id);
+		result = -EIO;
+		goto err_unreg;
+	}
+
+	for (i = 0; i < p->state_count; i++) {
+		if (p->states[i].control != p->states[i].status) {
+			printk("Different control (%llu) and status values"
+				" (%llu)\n",
+				p->states[i].control, p->states[i].status);
+			result = -EINVAL;
+			goto err_unreg;
+		}
+
+		if (!p->states[i].core_frequency) {
+			printk("Zero core frequency for state %u\n", i);
+			result = -EINVAL;
+			goto err_unreg;
+		}
+
+		if (p->states[i].core_frequency > p->states[0].core_frequency) {
+			printk("P%u has larger frequency (%llu) than P0 "
+				"(%llu), skipping\n", i,
+				p->states[i].core_frequency, 
+				p->states[0].core_frequency);
+			p->states[i].core_frequency = 0;
+			continue;
+		}
+	}
+
+	return 0;
+
+err_unreg:
+	acpi_processor_unregister_performance(p, cpu);
+	printk("invalid ACPI data\n");
+#endif	
+	return result;
+}
+#else
+static inline int acpi_early_init(void) { return 0; }
+static inline int acpi_cpu_data_init(int cpu) { return 0; }
+static cpumask_t acpi_get_shared_mask(int cpu) { return cpumask_of_cpu(cpu); }
+#endif
+
+cpumask_t 
+arch_get_dependent_cpus_mask(int cpu)
+{
+	return acpi_get_shared_mask(cpu);
+}
+EXPORT_SYMBOL_GPL(arch_get_dependent_cpus_mask);
+
+static int 
+sc_pm_core_add_dev(struct sys_device *sys_dev)
+{
+	unsigned int cpu = sys_dev->id;
+	struct cpuinfo_x86 *x86_cpu = &cpu_data[cpu];
+	int rc = 0, l, h;
+	cpumask_t saved_mask;
+
+	if ((x86_cpu->x86_vendor != X86_VENDOR_INTEL) || 
+	    !cpu_has(x86_cpu, X86_FEATURE_EST))
+		return -ENODEV;
+
+	/* 
+	 * Check to see if Enhanced SpeedStep is enabled, and try to
+	 * enable it if not. 
+	 */
+	saved_mask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+	if (smp_processor_id() != cpu) 
+		return -EAGAIN;
+
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+
+	if (!(l & (1<<16))) {
+		l |= (1<<16);
+
+		printk("trying to enable Enhanced SpeedStep (%x)\n", l);
+		wrmsr(MSR_IA32_MISC_ENABLE, l, h);
+
+		/* check to see if it stuck */
+		rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+		if (!(l & (1<<16))) {
+			printk("couldn't enable Enhanced SpeedStep\n");
+			set_cpus_allowed(current, saved_mask);
+			return -ENODEV;
+		}
+	}
+
+	set_cpus_allowed(current, saved_mask);
+
+	rc = acpi_cpu_data_init(cpu);
+	if (rc != 0)
+		return rc;
+	
+	/* notify BIOS that we exist */
+	acpi_processor_notify_smm(THIS_MODULE);
+
+	return rc;
+}
+
+static int 
+sc_pm_core_remove_dev (struct sys_device * sys_dev)
+{
+	unsigned int cpu = sys_dev->id;
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+	struct acpi_processor_performance *p;
+
+	if (acpi_perf_data[cpu]) {
+		p = acpi_perf_data[cpu];
+		acpi_processor_unregister_performance(p, cpu);
+	}
+#endif  
+	return 0;
+}
+
+static int 
+sc_pm_core_suspend(struct sys_device * sysdev, pm_message_t pmsg)
+{
+	return 0;
+}
+
+static int 
+sc_pm_core_resume(struct sys_device * sysdev)
+{
+	return 0;
+}
+
+static struct sysdev_driver pm_core_sysdev_driver = {
+	.add		= sc_pm_core_add_dev,
+	.remove		= sc_pm_core_remove_dev,
+	.suspend	= sc_pm_core_suspend,
+	.resume		= sc_pm_core_resume,
+};
+
+/* FIXME: will add HOTPLUG handler similar to cpureq as soon as understand
+ * why hotplug cannot be handled via sysdev driver
+ */
+int __init
+sc_pm_core_init(void)
+{
+	int rc = 0, j = 0;
+	rc = acpi_early_init();
+	if (rc != 0)
+		return rc;
+
+	rc = sysdev_driver_register(&cpu_sysdev_class, &pm_core_sysdev_driver);
+	if (rc != 0)
+		goto out_free;
+
+	rc = powerop_driver_register(&sc_pm_core_driver);
+	if (rc != 0) {
+		sysdev_driver_unregister(&cpu_sysdev_class, 
+					 &pm_core_sysdev_driver);
+		goto out_free;
+	}
+
+	return rc;
+out_free:
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+	for_each_possible_cpu(j) {
+		kfree(acpi_perf_data[j]);
+		acpi_perf_data[j] = NULL;
+	}
+#endif /* CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI */
+	return rc;
+}
+
+
+static void __exit 
+sc_pm_core_exit(void)
+{
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+	unsigned int j;
+#endif
+
+	powerop_driver_unregister(&sc_pm_core_driver);
+	sysdev_driver_unregister(&cpu_sysdev_class, &pm_core_sysdev_driver);
+
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+	for_each_possible_cpu(j) {
+		kfree(acpi_perf_data[j]);
+		acpi_perf_data[j] = NULL;
+	}
+#endif
+}
+
+
+module_init(sc_pm_core_init);
+module_exit(sc_pm_core_exit);
+
+
+MODULE_AUTHOR ("Eugeny S. Mints <eugeny.mints@gmail.com");
+MODULE_DESCRIPTION ("PM Core driver for Intel Pentium M processors.");
+MODULE_LICENSE ("GPL");
+
diff --git a/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
index b77f135..60e619d 100644
--- a/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
+++ b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
@@ -1,18 +1,19 @@
 /*
- * cpufreq driver for Enhanced SpeedStep, as found in Intel's Pentium
- * M (part of the Centrino chipset).
+ * This kernel module registeres a predefine set of operating points
+ * for x86 a speedstep-centrino platform with PowerOP. The operating points
+ * are either derived from data received from ACPI or defined as harcoded 
+ * tables if ACPI is not configured or functional. 
  *
- * Since the original Pentium M, most new Intel CPUs support Enhanced
- * SpeedStep.
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
  *
- * Despite the "SpeedStep" in the name, this is almost entirely unlike
- * traditional SpeedStep.
- *
- * Modelled on speedstep.c
+ * Copyright (C) 2006 Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  *
+ * Based on code by
  * Copyright (C) 2003 Jeremy Fitzhardinge <jeremy@goop.org>
  */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -20,6 +21,7 @@ #include <linux/cpufreq.h>
 #include <linux/sched.h>	/* current */
 #include <linux/delay.h>
 #include <linux/compiler.h>
+#include <linux/powerop.h>
 
 #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
 #include <linux/acpi.h>
@@ -30,11 +32,14 @@ #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
-#define PFX		"speedstep-centrino: "
-#define MAINTAINER	"cpufreq@lists.linux.org.uk"
+#define PFX		"speedstep-centrino-op-points: "
+#define MAINTAINER	"linux-pm@lists.osld.org"
 
 #define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, "speedstep-centrino", msg)
 
+#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
+extern struct acpi_processor_performance *acpi_perf_data[];
+#endif
 
 struct cpu_id
 {
@@ -62,22 +67,37 @@ static const struct cpu_id cpu_ids[] = {
 };
 #define N_IDS	ARRAY_SIZE(cpu_ids)
 
+#define CENTRINO_EXTRACT_VLTG(index) (((index) & 0xFF) * 16 + 700) 
+#define SC_TABLE_END_MARK  ~1
+/* 
+ * please note that this structure has nothing to do with pm_core_point, it's
+ * completely internal structure of this particula "registration" driver which
+ * is an instance of a layer above PowerOP
+ * for example 'index' field value is not a voltage value but an aggregated 
+ * value initially designed to match format returned by ACPI
+ *
+ * this strucure may be improved to be more straightforward by replacing index
+ * with real voltage value since now PowerOP is underneath interface but left
+ * almost untouched to order to leave cprufreq code recognazible 
+ */
+struct sc_opt {
+	unsigned int frequency;
+	unsigned int index;
+};
+
 struct cpu_model
 {
 	const struct cpu_id *cpu_id;
-	const char	*model_name;
-	unsigned	max_freq; /* max clock in kHz */
-
-	struct cpufreq_frequency_table *op_points; /* clock/voltage pairs */
+	const char          *model_name;
+	unsigned             max_freq; /* max clock in kHz */
+	struct sc_opt       *op_points; /* clock/voltage pairs */
 };
 static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c, const struct cpu_id *x);
 
-/* Operating points for current CPU */
 static struct cpu_model *centrino_model[NR_CPUS];
 static const struct cpu_id *centrino_cpu[NR_CPUS];
 
-static struct cpufreq_driver centrino_driver;
-
+/* Operating point tables */
 #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE
 
 /* Computes the correct form for IA32_PERF_CTL MSR for a particular
@@ -97,38 +117,38 @@ #define OP(mhz, mv)							\
  */
 
 /* Ultra Low Voltage Intel Pentium M processor 900MHz (Banias) */
-static struct cpufreq_frequency_table banias_900[] =
+static struct sc_opt banias_900[] =
 {
 	OP(600,  844),
 	OP(800,  988),
 	OP(900, 1004),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 
 /* Ultra Low Voltage Intel Pentium M processor 1000MHz (Banias) */
-static struct cpufreq_frequency_table banias_1000[] =
+static struct sc_opt banias_1000[] =
 {
 	OP(600,   844),
 	OP(800,   972),
 	OP(900,   988),
 	OP(1000, 1004),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 
 /* Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
-static struct cpufreq_frequency_table banias_1100[] =
+static struct sc_opt banias_1100[] =
 {
 	OP( 600,  956),
 	OP( 800, 1020),
 	OP( 900, 1100),
 	OP(1000, 1164),
 	OP(1100, 1180),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 
 
 /* Low Voltage Intel Pentium M processor 1.20GHz (Banias) */
-static struct cpufreq_frequency_table banias_1200[] =
+static struct sc_opt banias_1200[] =
 {
 	OP( 600,  956),
 	OP( 800, 1004),
@@ -136,33 +156,33 @@ static struct cpufreq_frequency_table ba
 	OP(1000, 1100),
 	OP(1100, 1164),
 	OP(1200, 1180),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 
 /* Intel Pentium M processor 1.30GHz (Banias) */
-static struct cpufreq_frequency_table banias_1300[] =
+static struct sc_opt banias_1300[] =
 {
 	OP( 600,  956),
 	OP( 800, 1260),
 	OP(1000, 1292),
 	OP(1200, 1356),
 	OP(1300, 1388),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 
 /* Intel Pentium M processor 1.40GHz (Banias) */
-static struct cpufreq_frequency_table banias_1400[] =
+static struct sc_opt banias_1400[] =
 {
 	OP( 600,  956),
 	OP( 800, 1180),
 	OP(1000, 1308),
 	OP(1200, 1436),
 	OP(1400, 1484),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 
 /* Intel Pentium M processor 1.50GHz (Banias) */
-static struct cpufreq_frequency_table banias_1500[] =
+static struct sc_opt banias_1500[] =
 {
 	OP( 600,  956),
 	OP( 800, 1116),
@@ -170,11 +190,11 @@ static struct cpufreq_frequency_table ba
 	OP(1200, 1356),
 	OP(1400, 1452),
 	OP(1500, 1484),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 
 /* Intel Pentium M processor 1.60GHz (Banias) */
-static struct cpufreq_frequency_table banias_1600[] =
+static struct sc_opt banias_1600[] =
 {
 	OP( 600,  956),
 	OP( 800, 1036),
@@ -182,11 +202,11 @@ static struct cpufreq_frequency_table ba
 	OP(1200, 1276),
 	OP(1400, 1420),
 	OP(1600, 1484),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 
 /* Intel Pentium M processor 1.70GHz (Banias) */
-static struct cpufreq_frequency_table banias_1700[] =
+static struct sc_opt banias_1700[] =
 {
 	OP( 600,  956),
 	OP( 800, 1004),
@@ -194,7 +214,7 @@ static struct cpufreq_frequency_table ba
 	OP(1200, 1228),
 	OP(1400, 1308),
 	OP(1700, 1484),
-	{ .frequency = CPUFREQ_TABLE_END }
+	{ .frequency = SC_TABLE_END_MARK }
 };
 #undef OP
 
@@ -232,10 +252,13 @@ static struct cpu_model models[] =
 #undef _BANIAS
 #undef BANIAS
 
-static int centrino_cpu_init_table(struct cpufreq_policy *policy)
+
+static int 
+centrino_register_table_operating_points(int cpu_idx)
 {
-	struct cpuinfo_x86 *cpu = &cpu_data[policy->cpu];
+	struct cpuinfo_x86 *cpu = &cpu_data[cpu_idx];
 	struct cpu_model *model;
+	int i = 0, rc = 0;
 
 	for(model = models; model->cpu_id != NULL; model++)
 		if (centrino_verify_cpu_id(cpu, model->cpu_id) &&
@@ -261,16 +284,36 @@ #endif
 		return -ENOENT;
 	}
 
-	centrino_model[policy->cpu] = model;
+	/* register operating points */
+	for (i = 0; model->op_points[i].frequency != SC_TABLE_END_MARK; i++) {
+		char opt_params[CPUFREQ_FREQ_OP_SIZE];
+		char opt_name[CPUFREQ_OP_NAME_SIZE];
+
+		CPUFREQ_CPU_N_FREQ_V(opt_params, cpu_idx);
+		CPUFREQ_CPU_N_GNRT_OP_NAME(opt_name, cpu_idx, i);
+
+		rc = powerop_register_point(opt_name, opt_params, 
+			CENTRINO_EXTRACT_VLTG(model->op_points[i].index),
+			model->op_points[i].frequency);
+		if (rc != 0) {
+			dprintk("%s: registration of operating point %s"
+				" failed %d\n", __FUNCTION__, opt_name, rc);
+			return rc;
+		}
+		
+	}	
+
+	centrino_model[cpu_idx] = model;
 
 	dprintk("found \"%s\": max frequency: %dkHz\n",
 	       model->model_name, model->max_freq);
 
 	return 0;
 }
-
 #else
-static inline int centrino_cpu_init_table(struct cpufreq_policy *policy) { return -ENODEV; }
+static inline int 
+centrino_register_table_operating_points(int cpu_idx) 
+{ return -ENODEV; }
 #endif /* CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE */
 
 static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c, const struct cpu_id *x)
@@ -282,8 +325,8 @@ static int centrino_verify_cpu_id(const 
 	return 0;
 }
 
-/* To be called only after centrino_model is initialized */
-static unsigned extract_clock(unsigned msr, unsigned int cpu, int failsafe)
+static unsigned 
+decode_clock(unsigned value2decode, unsigned int cpu, int failsafe)
 {
 	int i;
 
@@ -295,16 +338,19 @@ static unsigned extract_clock(unsigned m
 	if ((centrino_cpu[cpu] == &cpu_ids[CPU_BANIAS]) ||
 	    (centrino_cpu[cpu] == &cpu_ids[CPU_DOTHAN_A1]) ||
 	    (centrino_cpu[cpu] == &cpu_ids[CPU_DOTHAN_B0])) {
-		msr = (msr >> 8) & 0xff;
-		return msr * 100000;
+		value2decode = (value2decode >> 8) & 0xff;
+		return value2decode * 100;
 	}
 
 	if ((!centrino_model[cpu]) || (!centrino_model[cpu]->op_points))
 		return 0;
 
-	msr &= 0xffff;
-	for (i=0;centrino_model[cpu]->op_points[i].frequency != CPUFREQ_TABLE_END; i++) {
-		if (msr == centrino_model[cpu]->op_points[i].index)
+	value2decode &= 0xffff;
+	for (i = 0; 
+	     centrino_model[cpu]->op_points[i].frequency != SC_TABLE_END_MARK;
+	     i++) 
+	{
+		if (value2decode == centrino_model[cpu]->op_points[i].index)
 			return centrino_model[cpu]->op_points[i].frequency;
 	}
 	if (failsafe)
@@ -313,513 +359,138 @@ static unsigned extract_clock(unsigned m
 		return 0;
 }
 
-/* Return the current CPU frequency in kHz */
-static unsigned int get_cur_freq(unsigned int cpu)
+/* 
+ * Return the current CPU frequency in kHz
+ * FIXME: not necessary to be implemented via powerop
+ */ 
+static unsigned int 
+get_cur_freq(unsigned int cpu)
 {
-	unsigned l, h;
-	unsigned clock_freq;
-	cpumask_t saved_mask;
+	int clock_freq = 0;
+	char freq_n[CPUFREQ_FREQ_STR_SIZE];
 
-	saved_mask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(cpu));
-	if (smp_processor_id() != cpu)
+	CPUFREQ_CPU_N_FREQ(freq_n, cpu);
+	if (powerop_get_point(NULL, freq_n, &clock_freq))
 		return 0;
 
-	rdmsr(MSR_IA32_PERF_STATUS, l, h);
-	clock_freq = extract_clock(l, cpu, 0);
-
-	if (unlikely(clock_freq == 0)) {
-		/*
-		 * On some CPUs, we can see transient MSR values (which are
-		 * not present in _PSS), while CPU is doing some automatic
-		 * P-state transition (like TM2). Get the last freq set 
-		 * in PERF_CTL.
-		 */
-		rdmsr(MSR_IA32_PERF_CTL, l, h);
-		clock_freq = extract_clock(l, cpu, 1);
-	}
-
-	set_cpus_allowed(current, saved_mask);
 	return clock_freq;
 }
 
-
 #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-
-static struct acpi_processor_performance *acpi_perf_data[NR_CPUS];
-
-/*
- * centrino_cpu_early_init_acpi - Do the preregistering with ACPI P-States
- * library
- *
- * Before doing the actual init, we need to do _PSD related setup whenever
- * supported by the BIOS. These are handled by this early_init routine.
- */
-static int centrino_cpu_early_init_acpi(void)
-{
-	unsigned int	i, j;
-	struct acpi_processor_performance	*data;
-
-	for_each_possible_cpu(i) {
-		data = kzalloc(sizeof(struct acpi_processor_performance), 
-				GFP_KERNEL);
-		if (!data) {
-			for_each_possible_cpu(j) {
-				kfree(acpi_perf_data[j]);
-				acpi_perf_data[j] = NULL;
-			}
-			return (-ENOMEM);
-		}
-		acpi_perf_data[i] = data;
-	}
-
-	acpi_processor_preregister_performance(acpi_perf_data);
-	return 0;
-}
-
 /*
- * centrino_cpu_init_acpi - register with ACPI P-States library
+ * centrino_register_acpi_operating_points - register operating points based
+ * on data coming from  ACPI 
  *
- * Register with the ACPI P-States library (part of drivers/acpi/processor.c)
- * in order to determine correct frequency and voltage pairings by reading
- * the _PSS of the ACPI DSDT or SSDT tables.
+ * ASSUMPTIONS:
+ *   acpi_perf_data[] is successfully initialized by PM Core
  */
-static int centrino_cpu_init_acpi(struct cpufreq_policy *policy)
+static int 
+centrino_register_acpi_operating_points(int cpu)
 {
-	unsigned long			cur_freq;
-	int				result = 0, i;
-	unsigned int			cpu = policy->cpu;
-	struct acpi_processor_performance	*p;
+	struct acpi_processor_performance *p;
+	unsigned long cur_freq;
+	int i, result = 0;
 
 	p = acpi_perf_data[cpu];
 
-	/* register with ACPI core */
-	if (acpi_processor_register_performance(p, cpu)) {
-		dprintk(PFX "obtaining ACPI data failed\n");
-		return -EIO;
-	}
-	policy->shared_type = p->shared_type;
-	/*
-	 * Will let policy->cpus know about dependency only when software 
-	 * coordination is required.
-	 */
-	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL ||
-	    policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
-		policy->cpus = p->shared_cpu_map;
-
-	/* verify the acpi_data */
-	if (p->state_count <= 1) {
-		dprintk("No P-States\n");
-		result = -ENODEV;
-		goto err_unreg;
-	}
-
-	if ((p->control_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) ||
-	    (p->status_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)) {
-		dprintk("Invalid control/status registers (%x - %x)\n",
-			p->control_register.space_id, p->status_register.space_id);
-		result = -EIO;
-		goto err_unreg;
-	}
-
-	for (i=0; i<p->state_count; i++) {
-		if (p->states[i].control != p->states[i].status) {
-			dprintk("Different control (%llu) and status values (%llu)\n",
-				p->states[i].control, p->states[i].status);
-			result = -EINVAL;
-			goto err_unreg;
-		}
-
-		if (!p->states[i].core_frequency) {
-			dprintk("Zero core frequency for state %u\n", i);
-			result = -EINVAL;
-			goto err_unreg;
-		}
-
-		if (p->states[i].core_frequency > p->states[0].core_frequency) {
-			dprintk("P%u has larger frequency (%llu) than P0 (%llu), skipping\n", i,
-				p->states[i].core_frequency, p->states[0].core_frequency);
-			p->states[i].core_frequency = 0;
-			continue;
-		}
-	}
+	cur_freq = get_cur_freq(cpu);
 
-	centrino_model[cpu] = kzalloc(sizeof(struct cpu_model), GFP_KERNEL);
-	if (!centrino_model[cpu]) {
-		result = -ENOMEM;
-		goto err_unreg;
-	}
+        for (i = 0; i < p->state_count; i++) {
+		char opt_params[CPUFREQ_FREQ_OP_SIZE];
+		char opt_name[CPUFREQ_OP_NAME_SIZE];
 
-	centrino_model[cpu]->model_name=NULL;
-	centrino_model[cpu]->max_freq = p->states[0].core_frequency * 1000;
-	centrino_model[cpu]->op_points =  kmalloc(sizeof(struct cpufreq_frequency_table) *
-					     (p->state_count + 1), GFP_KERNEL);
-        if (!centrino_model[cpu]->op_points) {
-                result = -ENOMEM;
-                goto err_kfree;
-        }
-
-        for (i=0; i<p->state_count; i++) {
-		centrino_model[cpu]->op_points[i].index = p->states[i].control;
-		centrino_model[cpu]->op_points[i].frequency = p->states[i].core_frequency * 1000;
-		dprintk("adding state %i with frequency %u and control value %04x\n", 
-			i, centrino_model[cpu]->op_points[i].frequency, centrino_model[cpu]->op_points[i].index);
-	}
-	centrino_model[cpu]->op_points[p->state_count].frequency = CPUFREQ_TABLE_END;
+		CPUFREQ_CPU_N_FREQ_V(opt_params, cpu);
+		CPUFREQ_CPU_N_GNRT_OP_NAME(opt_name, cpu, i);
 
-	cur_freq = get_cur_freq(cpu);
+		dprintk("%s: adding state %i with name %s, frequency %u and "
+			"voltage value %04x\n (control 0x%x)", __FUNCTION__,
+			opt_name, p->states[i].core_frequency * 1000,
+			CENTRINO_EXTRACT_VLTG(p->states[i].control)
+			p->states[i].control);
 
-	for (i=0; i<p->state_count; i++) {
 		if (!p->states[i].core_frequency) {
 			dprintk("skipping state %u\n", i);
-			centrino_model[cpu]->op_points[i].frequency = CPUFREQ_ENTRY_INVALID;
 			continue;
 		}
-		
-		if (extract_clock(centrino_model[cpu]->op_points[i].index, cpu, 0) !=
-		    (centrino_model[cpu]->op_points[i].frequency)) {
-			dprintk("Invalid encoded frequency (%u vs. %u)\n",
-				extract_clock(centrino_model[cpu]->op_points[i].index, cpu, 0),
-				centrino_model[cpu]->op_points[i].frequency);
-			result = -EINVAL;
-			goto err_kfree_all;
-		}
-
-		if (cur_freq == centrino_model[cpu]->op_points[i].frequency)
-			p->state = i;
-	}
-
-	/* notify BIOS that we exist */
-	acpi_processor_notify_smm(THIS_MODULE);
-
-	return 0;
-
- err_kfree_all:
-	kfree(centrino_model[cpu]->op_points);
- err_kfree:
-	kfree(centrino_model[cpu]);
- err_unreg:
-	acpi_processor_unregister_performance(p, cpu);
-	dprintk(PFX "invalid ACPI data\n");
-	return (result);
-}
-#else
-static inline int centrino_cpu_init_acpi(struct cpufreq_policy *policy) { return -ENODEV; }
-static inline int centrino_cpu_early_init_acpi(void) { return 0; }
-#endif
-
-static int centrino_cpu_init(struct cpufreq_policy *policy)
-{
-	struct cpuinfo_x86 *cpu = &cpu_data[policy->cpu];
-	unsigned freq;
-	unsigned l, h;
-	int ret;
-	int i;
-
-	/* Only Intel makes Enhanced Speedstep-capable CPUs */
-	if (cpu->x86_vendor != X86_VENDOR_INTEL || !cpu_has(cpu, X86_FEATURE_EST))
-		return -ENODEV;
-
-	if (cpu_has(cpu, X86_FEATURE_CONSTANT_TSC))
-		centrino_driver.flags |= CPUFREQ_CONST_LOOPS;
-
-	if (centrino_cpu_init_acpi(policy)) {
-		if (policy->cpu != 0)
-			return -ENODEV;
-
-		for (i = 0; i < N_IDS; i++)
-			if (centrino_verify_cpu_id(cpu, &cpu_ids[i]))
-				break;
-
-		if (i != N_IDS)
-			centrino_cpu[policy->cpu] = &cpu_ids[i];
-
-		if (!centrino_cpu[policy->cpu]) {
-			dprintk("found unsupported CPU with "
-			"Enhanced SpeedStep: send /proc/cpuinfo to "
-			MAINTAINER "\n");
-			return -ENODEV;
-		}
 
-		if (centrino_cpu_init_table(policy)) {
-			return -ENODEV;
+		if (decode_clock(p->states[i].control, cpu, 0) !=
+		    (p->states[i].core_frequency * 1000)) {
+			dprintk("Invalid encoded frequency (%u vs. %u)\n",
+				decode_clock(p->states[i].control, cpu, 0),
+				p->states[i].core_frequency * 1000);
+			continue;
 		}
-	}
-
-	/* Check to see if Enhanced SpeedStep is enabled, and try to
-	   enable it if not. */
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-
-	if (!(l & (1<<16))) {
-		l |= (1<<16);
-		dprintk("trying to enable Enhanced SpeedStep (%x)\n", l);
-		wrmsr(MSR_IA32_MISC_ENABLE, l, h);
 
-		/* check to see if it stuck */
-		rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-		if (!(l & (1<<16))) {
-			printk(KERN_INFO PFX "couldn't enable Enhanced SpeedStep\n");
-			return -ENODEV;
+		/* register operating point w/ PowerOP Core */
+		result = powerop_register_point(opt_name, opt_params, 
+				   CENTRINO_EXTRACT_VLTG(p->states[i].control),
+			 	   p->states[i].core_frequency * 1000);
+		if (result != 0) {
+			dprintk("%s: registration of operating point %s"
+				" failed %d\n", __FUNCTION__, 
+				opt_name, result);
+			continue;
 		}
-	}
-
-	freq = get_cur_freq(policy->cpu);
-
-	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
-	policy->cpuinfo.transition_latency = 10000; /* 10uS transition latency */
-	policy->cur = freq;
-
-	dprintk("centrino_cpu_init: cur=%dkHz\n", policy->cur);
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, centrino_model[policy->cpu]->op_points);
-	if (ret)
-		return (ret);
-
-	cpufreq_frequency_table_get_attr(centrino_model[policy->cpu]->op_points, policy->cpu);
-
-	return 0;
-}
-
-static int centrino_cpu_exit(struct cpufreq_policy *policy)
-{
-	unsigned int cpu = policy->cpu;
-
-	if (!centrino_model[cpu])
-		return -ENODEV;
-
-	cpufreq_frequency_table_put_attr(cpu);
+		/* FIXME: why freq is still what we've got in cur_freq */
+		if (p->states[i].core_frequency * 1000 == cur_freq)
+			p->state = i;
 
-#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-	if (!centrino_model[cpu]->model_name) {
-		static struct acpi_processor_performance *p;
-
-		if (acpi_perf_data[cpu]) {
-			p = acpi_perf_data[cpu];
-			dprintk("unregistering and freeing ACPI data\n");
-			acpi_processor_unregister_performance(p, cpu);
-			kfree(centrino_model[cpu]->op_points);
-			kfree(centrino_model[cpu]);
-		}
 	}
-#endif
-
-	centrino_model[cpu] = NULL;
 
 	return 0;
 }
-
-/**
- * centrino_verify - verifies a new CPUFreq policy
- * @policy: new policy
- *
- * Limit must be within this model's frequency range at least one
- * border included.
- */
-static int centrino_verify (struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, centrino_model[policy->cpu]->op_points);
-}
-
-/**
- * centrino_setpolicy - set a new CPUFreq policy
- * @policy: new policy
- * @target_freq: the target frequency
- * @relation: how that frequency relates to achieved frequency (CPUFREQ_RELATION_L or CPUFREQ_RELATION_H)
- *
- * Sets a new CPUFreq policy.
- */
-static int centrino_target (struct cpufreq_policy *policy,
-			    unsigned int target_freq,
-			    unsigned int relation)
-{
-	unsigned int    newstate = 0;
-	unsigned int	msr, oldmsr = 0, h = 0, cpu = policy->cpu;
-	struct cpufreq_freqs	freqs;
-	cpumask_t		online_policy_cpus;
-	cpumask_t		saved_mask;
-	cpumask_t		set_mask;
-	cpumask_t		covered_cpus;
-	int			retval = 0;
-	unsigned int		j, k, first_cpu, tmp;
-
-	if (unlikely(centrino_model[cpu] == NULL))
-		return -ENODEV;
-
-	if (unlikely(cpufreq_frequency_table_target(policy,
-			centrino_model[cpu]->op_points,
-			target_freq,
-			relation,
-			&newstate))) {
-		return -EINVAL;
-	}
-
-#ifdef CONFIG_HOTPLUG_CPU
-	/* cpufreq holds the hotplug lock, so we are safe from here on */
-	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
 #else
-	online_policy_cpus = policy->cpus;
+static inline int 
+centrino_register_acpi_operating_points(int cpu) 
+{ return -ENODEV; }
 #endif
 
-	saved_mask = current->cpus_allowed;
-	first_cpu = 1;
-	cpus_clear(covered_cpus);
-	for_each_cpu_mask(j, online_policy_cpus) {
-		/*
-		 * Support for SMP systems.
-		 * Make sure we are running on CPU that wants to change freq
-		 */
-		cpus_clear(set_mask);
-		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
-			cpus_or(set_mask, set_mask, online_policy_cpus);
-		else
-			cpu_set(j, set_mask);
-
-		set_cpus_allowed(current, set_mask);
-		if (unlikely(!cpu_isset(smp_processor_id(), set_mask))) {
-			dprintk("couldn't limit to CPUs in this domain\n");
-			retval = -EAGAIN;
-			if (first_cpu) {
-				/* We haven't started the transition yet. */
-				goto migrate_end;
-			}
-			break;
-		}
-
-		msr = centrino_model[cpu]->op_points[newstate].index;
-
-		if (first_cpu) {
-			rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
-			if (msr == (oldmsr & 0xffff)) {
-				dprintk("no change needed - msr was and needs "
-					"to be %x\n", oldmsr);
-				retval = 0;
-				goto migrate_end;
-			}
-
-			freqs.old = extract_clock(oldmsr, cpu, 0);
-			freqs.new = extract_clock(msr, cpu, 0);
+int
+centrino_register_operating_points(void)
+{
+	int cpu,i;
 
-			dprintk("target=%dkHz old=%d new=%d msr=%04x\n",
-				target_freq, freqs.old, freqs.new, msr);
+	for_each_possible_cpu(cpu) {
+		if (centrino_register_acpi_operating_points(cpu)) {
+			if (cpu != 0)
+				return -ENODEV;
 
-			for_each_cpu_mask(k, online_policy_cpus) {
-				freqs.cpu = k;
-				cpufreq_notify_transition(&freqs,
-					CPUFREQ_PRECHANGE);
+			for (i = 0; i < N_IDS; i++)
+				if (centrino_verify_cpu_id(&cpu_data[cpu], 
+							   &cpu_ids[i]))
+					break;
+	
+			if (i != N_IDS)
+				centrino_cpu[cpu] = &cpu_ids[i];
+
+			if (!centrino_cpu[cpu]) {
+				dprintk("found unsupported CPU with "
+				"Enhanced SpeedStep: send /proc/cpuinfo to "
+				MAINTAINER "\n");
+				return -ENODEV;
 			}
 
-			first_cpu = 0;
-			/* all but 16 LSB are reserved, treat them with care */
-			oldmsr &= ~0xffff;
-			msr &= 0xffff;
-			oldmsr |= msr;
-		}
-
-		wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
-		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
-			break;
-
-		cpu_set(j, covered_cpus);
-	}
-
-	for_each_cpu_mask(k, online_policy_cpus) {
-		freqs.cpu = k;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
-
-	if (unlikely(retval)) {
-		/*
-		 * We have failed halfway through the frequency change.
-		 * We have sent callbacks to policy->cpus and
-		 * MSRs have already been written on coverd_cpus.
-		 * Best effort undo..
-		 */
-
-		if (!cpus_empty(covered_cpus)) {
-			for_each_cpu_mask(j, covered_cpus) {
-				set_cpus_allowed(current, cpumask_of_cpu(j));
-				wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+			if (centrino_register_table_operating_points(cpu)) {
+				return -ENODEV;
 			}
 		}
-
-		tmp = freqs.new;
-		freqs.new = freqs.old;
-		freqs.old = tmp;
-		for_each_cpu_mask(j, online_policy_cpus) {
-			freqs.cpu = j;
-			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-		}
 	}
 
-migrate_end:
-	set_cpus_allowed(current, saved_mask);
 	return 0;
 }
 
-static struct freq_attr* centrino_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
-static struct cpufreq_driver centrino_driver = {
-	.name		= "centrino", /* should be speedstep-centrino,
-					 but there's a 16 char limit */
-	.init		= centrino_cpu_init,
-	.exit		= centrino_cpu_exit,
-	.verify		= centrino_verify,
-	.target		= centrino_target,
-	.get		= get_cur_freq,
-	.attr           = centrino_attr,
-	.owner		= THIS_MODULE,
-};
-
-
-/**
- * centrino_init - initializes the Enhanced SpeedStep CPUFreq driver
- *
- * Initializes the Enhanced SpeedStep support. Returns -ENODEV on
- * unsupported devices, -ENOENT if there's no voltage table for this
- * particular CPU model, -EINVAL on problems during initiatization,
- * and zero on success.
- *
- * This is quite picky.  Not only does the CPU have to advertise the
- * "est" flag in the cpuid capability flags, we look for a specific
- * CPU model and stepping, and we need to have the exact model name in
- * our voltage tables.  That is, be paranoid about not releasing
- * someone's valuable magic smoke.
- */
-static int __init centrino_init(void)
+/* see comments in the file header for deprecated */
+void
+centrino_unregister_operating_points(void)
 {
-	struct cpuinfo_x86 *cpu = cpu_data;
-
-	if (!cpu_has(cpu, X86_FEATURE_EST))
-		return -ENODEV;
-
-	centrino_cpu_early_init_acpi();
-
-	return cpufreq_register_driver(&centrino_driver);
+	/* FIXME: TODO */
 }
 
-static void __exit centrino_exit(void)
-{
-#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-	unsigned int j;
-#endif
-	
-	cpufreq_unregister_driver(&centrino_driver);
-
-#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-	for_each_possible_cpu(j) {
-		kfree(acpi_perf_data[j]);
-		acpi_perf_data[j] = NULL;
-	}
-#endif
-}
+module_init(centrino_register_operating_points);
+module_exit(centrino_unregister_operating_points);
 
-MODULE_AUTHOR ("Jeremy Fitzhardinge <jeremy@goop.org>");
-MODULE_DESCRIPTION ("Enhanced SpeedStep driver for Intel Pentium M processors.");
+MODULE_AUTHOR ("Eugeny S. Mints <eugeny@nomadgs.com>");
+MODULE_DESCRIPTION ("Centrino operating points registration module");
 MODULE_LICENSE ("GPL");
 
-late_initcall(centrino_init);
-module_exit(centrino_exit);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 7ba5e49..277b4d2 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -682,12 +682,8 @@ int acpi_processor_preregister_performan
 		/* Validate the Domain info */
 		count_target = pdomain->num_processors;
 		count = 1;
-		if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
-			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
-		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
-			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_HW;
-		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
-			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+
+		pr->performance->shared_type = pdomain->coord_type;
 
 		for_each_possible_cpu(j) {
 			if (i == j)
@@ -751,7 +747,7 @@ err_ret:
 		if (retval) {
 			cpus_clear(pr->performance->shared_cpu_map);
 			cpu_set(i, pr->performance->shared_cpu_map);
-			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+			pr->performance->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
 		}
 		pr->performance = NULL; /* Will be set for real in register */
 	}
diff --git a/include/asm-i386/pm_core.h b/include/asm-i386/pm_core.h
new file mode 100644
index 0000000..ea56c40
--- /dev/null
+++ b/include/asm-i386/pm_core.h
@@ -0,0 +1,72 @@
+/*
+ * Definition of operating point structure (power parameters set) for i386
+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * 2006 (c) Nomad Global Solutions. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ */
+#ifndef __ASM_I386_PM_CORE_H__
+#define __ASM_I386_PM_CORE_H__
+
+#define _I386_PM_CORE_POINT_V        0
+#define _I386_PM_CORE_POINT_FREQ     1
+
+#define _I386_PM_CORE_PWRP_LAST      (_I386_PM_CORE_POINT_FREQ + 1)
+#define _I386_PWRP_NUM               _I386_PM_CORE_PWRP_LAST
+
+/* per CPU parameters: voltage and frquency */ 
+struct _cpu_pwr_params {
+	int pwpr[_I386_PWRP_NUM]; /* voltage in mV, freq in KHz */
+};
+
+/* 
+ * an i386 platfrom operating point structure. an operating point 
+ * contains volage/frequency pair for each possible CPU on a certain 
+ * platform. Any additional power parameters may be defined here if 
+ * supported by a platform.
+ *
+ * Instances of this structure define operating points
+ *
+ * Any power parameter value may be a positive value, zero, or reserved '-1'
+ * value. 
+ *
+ * IMPORTANT: 
+ *
+ * '-1' means any value from a range of valid values for a certain 
+ * parameter may be used during switch to this particular point. I.e. 
+ * assuming a platform power parameters are: p1, p2 (i.e. 
+ * struct pm_core_point {
+ *	int p1;
+ * 	int p2;
+ * }
+ * ) and that value ranges are {v1, v2} and {v3, v4} for p1 and p2 respectivly
+ * defining a point 
+ * struct pm_core_point point1 = {
+ * 	.p1 = v1; 
+ * 	.p2 = -1;
+ * }
+ * _must_ mean that both combinations {v1, v3} and {v1, v4} are valid (i.e.
+ * system will now hang or crash).  
+ *
+ * It's strickly upto a platform power designer to utilize '-1' value 
+ * properly given the above assumption.   
+ */
+struct pm_core_point {
+	struct _cpu_pwr_params opt[NR_CPUS];
+};
+
+#define I386_PM_CORE_INIT_OPT(point)                   \
+	do {                                           \
+		int i = 0, j = 0;                      \
+		for (j = 0; j < _I386_PWRP_NUM; j++)   \
+			(point)->opt[i].pwpr[j] = -1;  \
+		i++;                                   \
+	} while (i < NR_CPUS)   
+
+
+#endif /* __ASM_I386_PM_CORE_H__ */
+

--------------060207060305070002040201--
