Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWINRHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWINRHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWINRHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:07:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:16774 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750753AbWINRHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:07:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z7hGuuJ4IgE+U1XE3l364720Bo6iBV+kr68gHQ5aq7T4K/C9PYaYQZ66IgWatEBCxvFoXK2IPmGqIep0zjSDj6FDUE7zIIFpWvQ7WbnGHTteEqgSTuvhWON+nMu77ocQlmkpMnUwTED1SYiYOsauj2Qv3WJqrNaET0mULQxfDZM=
Message-ID: <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
Date: Thu, 14 Sep 2006 10:07:06 -0700
From: "David Singleton" <daviado@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: OpPoint summary
Cc: linux-pm@lists.osdl.org, "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060914055529.GA18031@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060911082025.GD1898@elf.ucw.cz>
	 <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912033700.GD27397@kroah.com>
	 <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	 <20060914055529.GA18031@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Care to resend your patches in the proper format, through email so that
> we can see them, and possibly get some testing in -mm if they look sane?

Greg,
   here's the patch that implements operating points for different frequencies
for the speedstep-centrino line of processors.  Operating points are created
in much the same manner that cpufreq tables are.  This works for both
simple implementations like the centrino and more complex SoC systems
like the arm-pxa72x which has several clocks to control, and different clock
divisors and multipliers.

David


Signed-Off-by: David Singleton <dsingleton@mvista.com>

 arch/i386/Kconfig                                |    2
 arch/i386/kernel/cpu/Makefile                    |    1
 arch/i386/kernel/cpu/power/Kconfig               |  168 ++++++++++
 arch/i386/kernel/cpu/power/Makefile              |    2
 arch/i386/kernel/cpu/power/centrino-on-the-fly.c |   72 ++++
 arch/i386/kernel/cpu/power/centrino-speedstep.c  |  368 +++++++++++++++++++++++
 arch/i386/kernel/i386_ksyms.c                    |    4
 7 files changed, 617 insertions(+)

Index: linux-2.6.17/arch/i386/kernel/cpu/Makefile
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/cpu/Makefile
+++ linux-2.6.17/arch/i386/kernel/cpu/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_X86_MCE) +=      mcheck/

 obj-$(CONFIG_MTRR)     +=      mtrr/
 obj-$(CONFIG_CPU_FREQ) +=      cpufreq/
+obj-$(CONFIG_PM)       +=      power/
Index: linux-2.6.17/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/i386_ksyms.c
+++ linux-2.6.17/arch/i386/kernel/i386_ksyms.c
@@ -28,3 +28,7 @@ EXPORT_SYMBOL(__read_lock_failed);
 #endif

 EXPORT_SYMBOL(csum_partial);
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+EXPORT_SYMBOL(pm_states);
+#endif
Index: linux-2.6.17/arch/i386/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/i386/Kconfig
+++ linux-2.6.17/arch/i386/Kconfig
@@ -964,6 +964,8 @@ config APM_REAL_MODE_POWER_OFF

 endmenu

+source "arch/i386/kernel/cpu/power/Kconfig"
+
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"

 endmenu
Index: linux-2.6.17/arch/i386/kernel/cpu/power/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/power/Makefile
@@ -0,0 +1,2 @@
+obj-m                                  += centrino-on-the-fly.o
+obj-$(CONFIG_X86_SPEEDSTEP_CENTRINO)   += centrino-speedstep.o
Index: linux-2.6.17/arch/i386/kernel/cpu/power/centrino-speedstep.c
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/power/centrino-speedstep.c
@@ -0,0 +1,368 @@
+/*
+ * OpPoint support for Enhanced SpeedStep, as found in Intel's Pentium
+ * M (part of the Centrino chipset).
+ *
+ * Modelled on speedstep-centrino.c
+ *
+ * Author: David Singleton dsingleton@mvista.com MontaVista Software, Inc.
+ *
+ * 2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+#include <linux/cpufreq.h>
+#include <linux/moduleparam.h>
+#include <linux/moduleloader.h>
+
+struct cpu_id
+{
+       __u8    x86;            /* CPU family */
+       __u8    x86_model;      /* model */
+       __u8    x86_mask;       /* stepping */
+};
+
+enum {
+       CPU_BANIAS,
+       CPU_DOTHAN_A1,
+       CPU_DOTHAN_A2,
+       CPU_DOTHAN_B0,
+       CPU_MP4HT_D0,
+       CPU_MP4HT_E0,
+};
+
+static const struct cpu_id cpu_ids[] = {
+       [CPU_BANIAS]    = { 6,  9, 5 },
+       [CPU_DOTHAN_A1] = { 6, 13, 1 },
+       [CPU_DOTHAN_A2] = { 6, 13, 2 },
+       [CPU_DOTHAN_B0] = { 6, 13, 6 },
+       [CPU_MP4HT_D0]  = {15,  3, 4 },
+       [CPU_MP4HT_E0]  = {15,  4, 1 },
+};
+#define N_IDS  ARRAY_SIZE(cpu_ids)
+
+struct cpu_model
+{
+       const struct cpu_id *cpu_id;
+       const char      *model_name;
+       unsigned        max_freq; /* max clock in kHz */
+
+};
+static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c, const
struct cpu_id *x);
+
+void centrino_set_frequency(struct oppoint *op, uint freq, uint volt)
+{
+       op->frequency = freq * 1000;
+       op->voltage = volt;
+       op->md_data = (void *)(((freq / 100) << 8) | (volt - 700) / 16);
+}
+EXPORT_SYMBOL(centrino_set_frequency);
+
+int centrino_transition(struct oppoint *cur, struct oppoint *new)
+{
+       unsigned int msr, oldmsr = 0, h = 0;
+
+       if (cur == new)
+               return 0;
+
+       msr = (unsigned int)new->md_data;
+       rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+       /* all but 16 LSB are reserved, treat them with care */
+       oldmsr &= ~0xffff;
+       msr &= 0xffff;
+       oldmsr |= msr;
+
+       wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+       udelay(new->latency);
+
+       return 0;
+}
+EXPORT_SYMBOL(centrino_transition);
+
+#define _BANIAS(cpuid, max, name)      \
+{      .cpu_id         = cpuid,        \
+       .model_name     = "Intel(R) Pentium(R) M processor " name "MHz", \
+       .max_freq       = (max)*1000,   \
+}
+#define BANIAS(max)    _BANIAS(&cpu_ids[CPU_BANIAS], max, #max)
+
+/*
+ * CPU models, their operating frequency range, and freq/voltage
+ * operating points
+ */
+static struct cpu_model models[] =
+{
+       _BANIAS(&cpu_ids[CPU_BANIAS], 900, " 900"),
+       BANIAS(1000),
+       BANIAS(1100),
+       BANIAS(1200),
+       BANIAS(1300),
+       BANIAS(1400),
+       BANIAS(1500),
+       BANIAS(1600),
+       BANIAS(1700),
+
+       /* NULL model_name is a wildcard */
+       { &cpu_ids[CPU_DOTHAN_A1], NULL, 0},
+       { &cpu_ids[CPU_DOTHAN_A2], NULL, 0},
+       { &cpu_ids[CPU_DOTHAN_B0], NULL, 0},
+       { &cpu_ids[CPU_MP4HT_D0], NULL, 0},
+       { &cpu_ids[CPU_MP4HT_E0], NULL, 0},
+
+       { NULL, }
+};
+#undef _BANIAS
+#undef BANIAS
+
+static struct oppoint lowest = {
+       .name = "lowest",
+       .type = PM_FREQ_CHANGE,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 15,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = centrino_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint low = {
+       .name = "low",
+       .type = PM_FREQ_CHANGE,
+       .latency = 15,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = centrino_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint mediumlow = {
+       .name = "mediumlow",
+       .type = PM_FREQ_CHANGE,
+       .latency = 15,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = centrino_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint medium = {
+       .name = "medium",
+       .type = PM_FREQ_CHANGE,
+       .latency = 15,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = centrino_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint mediumhigh = {
+       .name = "mediumhigh",
+       .type = PM_FREQ_CHANGE,
+       .latency = 15,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = centrino_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint high = {
+       .name = "high",
+       .type = PM_FREQ_CHANGE,
+       .latency = 15,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = centrino_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint highest = {
+       .name = "highest",
+       .type = PM_FREQ_CHANGE,
+       .latency = 15,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = centrino_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static int __init centrino_init_oppoint(void)
+{
+       struct cpuinfo_x86 *cpu = &cpu_data[0];
+       struct cpu_model *model;
+
+       for(model = models; model->cpu_id != NULL; model++) {
+               if (centrino_verify_cpu_id(cpu, model->cpu_id) &&
+                   (model->model_name == NULL ||
+                    strcmp(cpu->x86_model_id, model->model_name) == 0))
+                       break;
+       }
+
+       if (model->cpu_id == NULL) {
+               /* No match at all */
+               printk("OpPoint: no support for CPU model %s\n",
+                   cpu->x86_model_id);
+               return -ENOENT;
+       }
+
+       switch (model->max_freq) {
+       /* Ultra Low Voltage Intel Pentium M processor 900MHz (Banias) */
+           case (900000) :
+           {
+               centrino_set_frequency(&low, 600, 844);
+               centrino_set_frequency(&medium, 800, 988);
+               centrino_set_frequency(&high, 900, 1004);
+               break;
+           }
+       /* Ultra Low Voltage Intel Pentium M processor 1.00GHz (Banias) */
+           case (1000000) :
+           {
+               centrino_set_frequency(&low, 600, 844);
+               centrino_set_frequency(&medium, 800, 972);
+               centrino_set_frequency(&high, 900, 988);
+               centrino_set_frequency(&highest, 1000, 1004);
+               break;
+           }
+       /* Ultra Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+           case (1100000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1020);
+               centrino_set_frequency(&medium, 900, 1100);
+               centrino_set_frequency(&high, 1000, 1164);
+               centrino_set_frequency(&highest, 1100, 1180);
+               break;
+           }
+       /* Ultra Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+           case (1200000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1004);
+               centrino_set_frequency(&medium, 900, 1020);
+               centrino_set_frequency(&mediumhigh, 1000, 1100);
+               centrino_set_frequency(&high, 1100, 1164);
+               centrino_set_frequency(&highest, 1200, 1180);
+               break;
+           }
+       /* Ultra Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+           case (1300000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1260);
+               centrino_set_frequency(&medium, 1000, 1292);
+               centrino_set_frequency(&high, 1200, 1356);
+               centrino_set_frequency(&highest, 1300, 1388);
+               break;
+           }
+       /* Ultra Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+           case (1400000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1180);
+               centrino_set_frequency(&medium, 1000, 1308);
+               centrino_set_frequency(&high, 1200, 1436);
+               centrino_set_frequency(&highest, 1400, 1484);
+               break;
+           }
+       /* Ultra Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+           case (1500000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1116);
+               centrino_set_frequency(&medium, 1000, 1228);
+               centrino_set_frequency(&mediumhigh, 1200, 1356);
+               centrino_set_frequency(&high, 1400, 1452);
+               centrino_set_frequency(&highest, 1500, 1484);
+               break;
+           }
+       /* Ultra Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+           case (1600000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1036);
+               centrino_set_frequency(&medium, 1000, 1164);
+               centrino_set_frequency(&mediumhigh, 1200, 1276);
+               centrino_set_frequency(&high, 1400, 1420);
+               centrino_set_frequency(&highest, 1600, 1484);
+               break;
+           }
+       /* Ultra Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+           case (1700000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1004);
+               centrino_set_frequency(&medium, 1000, 1116);
+               centrino_set_frequency(&mediumhigh, 1200, 1228);
+               centrino_set_frequency(&high, 1400, 1308);
+               centrino_set_frequency(&highest, 1700, 1484);
+               break;
+           }
+       }
+       if (lowest.frequency) {
+               register_operating_point(&lowest);
+               list_add_tail(&lowest.list, &pm_states.list);
+       }
+       if (low.frequency) {
+               register_operating_point(&low);
+               list_add_tail(&low.list, &pm_states.list);
+       }
+       if (mediumlow.frequency) {
+               register_operating_point(&mediumlow);
+               list_add_tail(&mediumlow.list, &pm_states.list);
+       }
+       if (medium.frequency) {
+               register_operating_point(&medium);
+               list_add_tail(&medium.list, &pm_states.list);
+       }
+       if (mediumhigh.frequency) {
+               register_operating_point(&mediumhigh);
+               list_add_tail(&mediumhigh.list, &pm_states.list);
+       }
+       if (high.frequency) {
+               register_operating_point(&high);
+               list_add_tail(&high.list, &pm_states.list);
+               current_state = &high;
+       }
+       if (highest.frequency) {
+               register_operating_point(&highest);
+               list_add_tail(&highest.list, &pm_states.list);
+               current_state = &highest;
+       }
+       return 0;
+}
+
+static void centrino_exit_oppoint(void)
+{
+       if (lowest.frequency)
+               list_del_init(&lowest.list);
+       if (low.frequency)
+               list_del_init(&low.list);
+       if (mediumlow.frequency)
+               list_del_init(&mediumlow.list);
+       if (medium.frequency)
+               list_del_init(&medium.list);
+       if (mediumhigh.frequency)
+               list_del_init(&mediumhigh.list);
+       if (high.frequency)
+               list_del_init(&high.list);
+       if (highest.frequency)
+               list_del_init(&highest.list);
+       return;
+}
+
+static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c, const
struct cpu_id *x)
+{
+       if ((c->x86 == x->x86) &&
+           (c->x86_model == x->x86_model) &&
+           (c->x86_mask == x->x86_mask))
+               return 1;
+       return 0;
+}
+
+MODULE_AUTHOR ("David Singleton <dsingleton@mvista.com>");
+MODULE_DESCRIPTION ("OpPoint operting points for Intel Pentium M processors.");
+MODULE_LICENSE ("GPL");
+
+late_initcall(centrino_init_oppoint);
+module_exit(centrino_exit_oppoint);
Index: linux-2.6.17/arch/i386/kernel/cpu/power/Kconfig
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/power/Kconfig
@@ -0,0 +1,168 @@
+#
+# Operating Point support for frequency/voltage scaling
+#
+
+menu "CPU Frequency/Voltage scaling"
+
+if CPU_PM
+
+comment "OpPoint processor support"
+
+config ELAN_OPPOINT
+       tristate "AMD Elan SC400 and SC410"
+       depends on X86_ELAN
+       ---help---
+         This adds the OpPoint support for AMD Elan SC400 and SC410
+         processors.
+
+         You need to specify the processor maximum speed as boot
+         parameter: elanfreq=maxspeed (in kHz) or as module
+         parameter "max_freq".
+
+         If in doubt, say N.
+
+config SC520_OPPOINT
+       tristate "AMD Elan SC520"
+       depends on X86_ELAN
+       ---help---
+         This adds OpPoint support for AMD Elan SC520 processor.
+
+         If in doubt, say N.
+
+
+config X86_POWERNOW_K6
+       tristate "AMD Mobile K6-2/K6-3 PowerNow!"
+       help
+         This adds OpPoint support for mobile AMD K6-2+ and mobile
+         AMD K6-3+ processors.
+
+         If in doubt, say N.
+
+config X86_POWERNOW_K7
+       tristate "AMD Mobile Athlon/Duron PowerNow!"
+       help
+         This adds OpPoint support for mobile AMD K7 mobile processors.
+
+         If in doubt, say N.
+
+config X86_POWERNOW_K7_ACPI
+       bool
+       depends on X86_POWERNOW_K7 && ACPI_PROCESSOR
+       depends on !(X86_POWERNOW_K7 = y && ACPI_PROCESSOR = m)
+       default y
+
+config X86_POWERNOW_K8
+       tristate "AMD Opteron/Athlon64 PowerNow!"
+       depends on EXPERIMENTAL
+       help
+         This adds OpPoint support for mobile AMD Opteron/Athlon64 processors.
+
+         If in doubt, say N.
+
+config X86_POWERNOW_K8_ACPI
+       bool
+       depends on X86_POWERNOW_K8 && ACPI_PROCESSOR
+       depends on !(X86_POWERNOW_K8 = y && ACPI_PROCESSOR = m)
+       default y
+
+config X86_GX_SUSPMOD
+       tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
+       depends on PCI
+       help
+        This add OpPoint support for NatSemi Geode processors which
+        support suspend modulation.
+
+        If in doubt, say N.
+
+config X86_SPEEDSTEP_CENTRINO
+       tristate "Intel Enhanced SpeedStep"
+       select X86_SPEEDSTEP_CENTRINO_TABLE if (!X86_SPEEDSTEP_CENTRINO_ACPI)
+       help
+         This adds OpPoint support for Enhanced SpeedStep enabled
+         mobile CPUs.  This means Intel Pentium M (Centrino) CPUs. However,
+         you also need to say Y to "Use ACPI tables to decode..." below
+         [which might imply enabling ACPI] if you want to use this driver
+         on non-Banias CPUs.
+
+         If in doubt, say N.
+
+config X86_SPEEDSTEP_CENTRINO_ACPI
+       bool "Use ACPI tables to decode valid frequency/voltage pairs"
+       depends on X86_SPEEDSTEP_CENTRINO && ACPI_PROCESSOR
+       depends on !(X86_SPEEDSTEP_CENTRINO = y && ACPI_PROCESSOR = m)
+       default y
+       help
+         Use primarily the information provided in the BIOS ACPI tables
+         to determine valid CPU frequency and voltage pairings. It is
+         required for the driver to work on non-Banias CPUs.
+
+         If in doubt, say Y.
+
+config X86_SPEEDSTEP_CENTRINO_TABLE
+       bool "Built-in tables for Banias CPUs"
+       depends on X86_SPEEDSTEP_CENTRINO
+       default y
+       help
+         Use built-in tables for Banias CPUs if ACPI encoding
+         is not available.
+
+         If in doubt, say N.
+
+config X86_SPEEDSTEP_ICH
+       tristate "Intel Speedstep on ICH-M chipsets (ioport interface)"
+       help
+         This adds the OpPoint support for certain mobile Intel Pentium III
+         (Coppermine), all mobile Intel Pentium III-M (Tualatin) and all
+         mobile Intel Pentium 4 P4-M on systems which have an Intel ICH2,
+         ICH3 or ICH4 southbridge.
+
+         If in doubt, say N.
+
+config X86_SPEEDSTEP_SMI
+       tristate "Intel SpeedStep on 440BX/ZX/MX chipsets (SMI interface)"
+       depends on EXPERIMENTAL
+       help
+         This adds OpPoint support for certain mobile Intel Pentium III
+         (Coppermine), all mobile Intel Pentium III-M (Tualatin)
+         on systems which have an Intel 440BX/ZX/MX southbridge.
+
+         If in doubt, say N.
+
+config X86_P4_CLOCKMOD
+       tristate "Intel Pentium 4 clock modulation"
+       help
+         This adds OpPoint support for Intel Pentium 4 / XEON
+         processors.
+
+         If in doubt, say N.
+
+config X86_OPPOINT_NFORCE2
+       tristate "nVidia nForce2 FSB changing"
+       depends on EXPERIMENTAL
+       help
+         This adds OpPoint support for FSB changing on nVidia nForce2
+         platforms.
+
+         If in doubt, say N.
+
+config X86_LONGRUN
+       tristate "Transmeta LongRun"
+       help
+         This adds OpPoint support for Transmeta Crusoe and Efficeon processors
+         which support LongRun.
+
+         If in doubt, say N.
+
+config X86_LONGHAUL
+       tristate "VIA Cyrix III Longhaul"
+       depends on ACPI_PROCESSOR
+       help
+         This adds OpPoint support for VIA Samuel/CyrixIII,
+         VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T
+         processors.
+
+         If in doubt, say N.
+
+endif  #  CONFIG_PM
+
+endmenu
Index: linux-2.6.17/arch/i386/kernel/cpu/power/centrino-on-the-fly.c
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/power/centrino-on-the-fly.c
@@ -0,0 +1,72 @@
+/*
+ * power/centrino-on-the-fly.c
+ *
+ * This is the template to create a dynamic operating point.
+ *
+ * Author: David Singleton dsingleton@mvista.com MontaVista Software, Inc.
+ *
+ * 2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/pm.h>
+#include <linux/cpufreq.h>
+#include <linux/moduleparam.h>
+#include <linux/moduleloader.h>
+
+int centrino_transition(struct oppoint *cur, struct oppoint *new);
+
+static unsigned int frequency = 1000;
+static unsigned int voltage = 1308;
+static unsigned int latency = 100;
+module_param_named(frequency, frequency, uint, 0);
+module_param_named(voltage, voltage, uint, 0);
+module_param_named(latency, latency, uint, 0);
+MODULE_PARM_DESC(frequency, "cpu frequency in kHz");
+MODULE_PARM_DESC(voltage, "cpu voltage in mV");
+MODULE_PARM_DESC(latency, "transition latency in us");
+
+/* Register both the driver and the device */
+
+static struct oppoint dynamic_op = {
+       .type = PM_FREQ_CHANGE,
+       .name = "dynamic",
+       .prepare_transition = cpufreq_prepare_transition,
+       .transition = centrino_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+extern void centrino_set_frequency(struct oppoint *op, uint freq, uint volt);
+
+int __init dynamic_oppoint_init(void)
+{
+
+       printk("Dynamic OpPoint operating point for speedstep centrino\n");
+       dynamic_op.frequency = frequency;
+       dynamic_op.voltage = voltage;
+       dynamic_op.latency = latency;
+       centrino_set_frequency(&dynamic_op, frequency / 1000, voltage);
+       register_operating_point(&dynamic_op);
+       printk("OpPoint: freq %d volt %d msr 0x%x\n", dynamic_op.frequency,
+          dynamic_op.voltage, (unsigned int)dynamic_op.md_data);
+       list_add_tail(&dynamic_op.list, &pm_states.list);
+       return 0;
+}
+
+void __exit dynamic_oppoint_cleanup(void)
+{
+       unregister_operating_point(&dynamic_op);
+       list_del_init(&dynamic_op.list);
+}
+
+module_init(dynamic_oppoint_init);
+module_exit(dynamic_oppoint_cleanup);
+
+MODULE_AUTHOR("David Singleton <dsingleton@mvista.com>");
+MODULE_DESCRIPTION("Dynamic OpPoint for Intel Pentium M processor module");
+MODULE_LICENSE("GPL");

>
> thanks,
>
> greg k-h
>
