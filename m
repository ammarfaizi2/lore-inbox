Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWJXQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWJXQkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWJXQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:22215 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030426AbWJXQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:40:20 -0400
Message-Id: <200610241839.46180.arnd@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:39:45 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 16/16] cell: add cpufreq driver for Cell BE processor
Content-Disposition: inline
Cc: Christian Krafft <krafft@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Krafft <krafft@de.ibm.com>

This patch adds a cpufreq backend driver to enable frequency scaling on cell.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6/arch/powerpc/platforms/cell/Kconfig
@@ -25,4 +25,13 @@ config CBE_THERM
 	default m
 	depends on CBE_RAS
 
+config CBE_CPUFREQ
+	tristate "CBE frequency scaling"
+	depends on CBE_RAS && CPU_FREQ
+	default m
+	help
+	  This adds the cpufreq driver for Cell BE processors.
+	  For details, take a look at <file:Documentation/cpu-freq/>.
+	  If you don't have such processor, say N
+
 endmenu
Index: linux-2.6/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6/arch/powerpc/platforms/cell/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PPC_CELL_NATIVE)		+= interr
 obj-$(CONFIG_CBE_RAS)			+= ras.o
 
 obj-$(CONFIG_CBE_THERM)			+= cbe_thermal.o
+obj-$(CONFIG_CBE_CPUFREQ)		+= cbe_cpufreq.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_cpufreq.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -0,0 +1,248 @@
+/*
+ * cpufreq driver for the cell processor
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Christian Krafft <krafft@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/timer.h>
+
+#include <asm/hw_irq.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+
+#include "cbe_regs.h"
+
+static DEFINE_MUTEX(cbe_switch_mutex);
+
+
+/* the CBE supports an 8 step frequency scaling */
+static struct cpufreq_frequency_table cbe_freqs[] = {
+	{1,	0},
+	{2,	0},
+	{3,	0},
+	{4,	0},
+	{5,	0},
+	{6,	0},
+	{8,	0},
+	{10,	0},
+	{0,	CPUFREQ_TABLE_END},
+};
+
+/* to write to MIC register */
+static u64 MIC_Slow_Fast_Timer_table[] = {
+	[0 ... 7] = 0x007fc00000000000ull,
+};
+
+/* more values for the MIC */
+static u64 MIC_Slow_Next_Timer_table[] = {
+	0x0000240000000000ull,
+	0x0000268000000000ull,
+	0x000029C000000000ull,
+	0x00002D0000000000ull,
+	0x0000300000000000ull,
+	0x0000334000000000ull,
+	0x000039C000000000ull,
+	0x00003FC000000000ull,
+};
+
+/*
+ * hardware specific functions
+ */
+
+static int get_pmode(int cpu)
+{
+	int ret;
+	struct cbe_pmd_regs __iomem *pmd_regs;
+
+	pmd_regs = cbe_get_cpu_pmd_regs(cpu);
+	ret = in_be64(&pmd_regs->pmsr) & 0x07;
+
+	return ret;
+}
+
+static int set_pmode(int cpu, unsigned int pmode)
+{
+	struct cbe_pmd_regs __iomem *pmd_regs;
+	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
+	u64 flags;
+	u64 value;
+
+	local_irq_save(flags);
+
+	mic_tm_regs = cbe_get_cpu_mic_tm_regs(cpu);
+	pmd_regs = cbe_get_cpu_pmd_regs(cpu);
+
+	pr_debug("pm register is mapped at %p\n", &pmd_regs->pmcr);
+	pr_debug("mic register is mapped at %p\n", &mic_tm_regs->slow_fast_timer_0);
+
+	out_be64(&mic_tm_regs->slow_fast_timer_0, MIC_Slow_Fast_Timer_table[pmode]);
+	out_be64(&mic_tm_regs->slow_fast_timer_1, MIC_Slow_Fast_Timer_table[pmode]);
+
+	out_be64(&mic_tm_regs->slow_next_timer_0, MIC_Slow_Next_Timer_table[pmode]);
+	out_be64(&mic_tm_regs->slow_next_timer_1, MIC_Slow_Next_Timer_table[pmode]);
+
+	value = in_be64(&pmd_regs->pmcr);
+	/* set bits to zero */
+	value &= 0xFFFFFFFFFFFFFFF8ull;
+	/* set bits to next pmode */
+	value |= pmode;
+
+	out_be64(&pmd_regs->pmcr, value);
+
+	/* wait until new pmode appears in status register */
+	value = in_be64(&pmd_regs->pmsr) & 0x07;
+	while(value != pmode) {
+		cpu_relax();
+		value = in_be64(&pmd_regs->pmsr) & 0x07;
+	}
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+/*
+ * cpufreq functions
+ */
+
+static int cbe_cpufreq_cpu_init (struct cpufreq_policy *policy)
+{
+	u32 *max_freq;
+	int i, cur_pmode;
+	struct device_node *cpu;
+
+	cpu = of_get_cpu_node(policy->cpu, NULL);
+
+	if(!cpu)
+		return -ENODEV;
+
+	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
+
+	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
+
+	if(!max_freq)
+		return -EINVAL;
+
+	// we need the freq in kHz
+	*max_freq /= 1000;
+
+	pr_debug("max clock-frequency is at %u kHz\n", *max_freq);
+	pr_debug("initializing frequency table\n");
+
+	// initialize frequency table
+	for (i=0; cbe_freqs[i].frequency!=CPUFREQ_TABLE_END; i++) {
+		cbe_freqs[i].frequency = *max_freq / cbe_freqs[i].index;
+		pr_debug("%d: %d\n", i, cbe_freqs[i].frequency);
+	}
+
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+	/* if DEBUG is enabled set_pmode() measures the correct latency of a transition */
+	policy->cpuinfo.transition_latency = 25000;
+
+	cur_pmode = get_pmode(policy->cpu);
+	pr_debug("current pmode is at %d\n",cur_pmode);
+
+	policy->cur = cbe_freqs[cur_pmode].frequency;
+
+#ifdef CONFIG_SMP
+	policy->cpus = cpu_sibling_map[policy->cpu];
+#endif
+
+	cpufreq_frequency_table_get_attr (cbe_freqs, policy->cpu);
+
+	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max are set correctly */
+	return cpufreq_frequency_table_cpuinfo (policy, cbe_freqs);
+}
+
+static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static int cbe_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, cbe_freqs);
+}
+
+
+static int cbe_cpufreq_target(struct cpufreq_policy *policy, unsigned int target_freq,
+			    unsigned int relation)
+{
+	int rc;
+	struct cpufreq_freqs freqs;
+	int cbe_pmode_new;
+
+	cpufreq_frequency_table_target(policy,
+				       cbe_freqs,
+				       target_freq,
+				       relation,
+				       &cbe_pmode_new);
+
+	freqs.old = policy->cur;
+	freqs.new = cbe_freqs[cbe_pmode_new].frequency;
+	freqs.cpu = policy->cpu;
+
+	mutex_lock (&cbe_switch_mutex);
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	pr_debug("setting frequency for cpu %d to %d kHz, 1/%d of max frequency\n",
+		 policy->cpu,
+		 cbe_freqs[cbe_pmode_new].frequency,
+		 cbe_freqs[cbe_pmode_new].index);
+
+	rc = set_pmode(policy->cpu, cbe_pmode_new);
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	mutex_unlock(&cbe_switch_mutex);
+
+	return rc;
+}
+
+static struct cpufreq_driver cbe_cpufreq_driver = {
+	.verify		= cbe_cpufreq_verify,
+	.target		= cbe_cpufreq_target,
+	.init		= cbe_cpufreq_cpu_init,
+	.exit		= cbe_cpufreq_cpu_exit,
+	.name		= "cbe-cpufreq",
+	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_CONST_LOOPS,
+};
+
+/*
+ * module init and destoy
+ */
+
+static int __init cbe_cpufreq_init(void)
+{
+	return cpufreq_register_driver(&cbe_cpufreq_driver);
+}
+
+static void __exit cbe_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&cbe_cpufreq_driver);
+}
+
+module_init(cbe_cpufreq_init);
+module_exit(cbe_cpufreq_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
Index: linux-2.6/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/cell_defconfig
+++ linux-2.6/arch/powerpc/configs/cell_defconfig
@@ -139,7 +139,19 @@ CONFIG_RTAS_FLASH=y
 CONFIG_MMIO_NVRAM=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
-# CONFIG_CPU_FREQ is not set
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_TABLE=y
+CONFIG_CPU_FREQ_DEBUG=y
+CONFIG_CPU_FREQ_STAT=y
+# CONFIG_CPU_FREQ_STAT_DETAILS is not set
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+# CONFIG_CPU_FREQ_PMAC64 is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 # CONFIG_MPIC is not set
 
@@ -150,6 +162,7 @@ CONFIG_SPU_FS=m
 CONFIG_SPU_BASE=y
 CONFIG_CBE_RAS=y
 CONFIG_CBE_THERM=m
+CONFIG_CBE_CPUFREQ=m
 
 #
 # Kernel options
Index: linux-2.6/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6/arch/powerpc/kernel/prom.c
@@ -1672,6 +1672,7 @@ struct device_node *of_get_cpu_node(int 
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(of_get_cpu_node);
 
 #ifdef DEBUG
 static struct debugfs_blob_wrapper flat_dt_blob;
Index: linux-2.6/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6/arch/powerpc/kernel/smp.c
@@ -65,6 +65,7 @@ cpumask_t cpu_sibling_map[NR_CPUS] = { [
 
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
+EXPORT_SYMBOL(cpu_sibling_map);
 
 /* SMP operations for this machine */
 struct smp_ops_t *smp_ops;

--

