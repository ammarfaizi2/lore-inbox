Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTFKWmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTFKWly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:41:54 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:32007
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S264543AbTFKWkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:40:20 -0400
Subject: Pentium M (Centrino) cpufreq device driver (please test me)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: cpufreq list <cpufreq@www.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-tTz+HneN0BJhwzEsJEBR"
Organization: 
Message-Id: <1055371846.4071.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 15:50:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tTz+HneN0BJhwzEsJEBR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the latest version of my Enhanced SpeedStep driver for cpufreq. 
It supports current Pentium M CPUs.

Intel has not fully documented the MSRs used to control CPU core
frequency and voltage, but they're fairly easy to work out with a bit of
experimentation and from the Intel documentation.

The driver uses built-in tables for all the operating points of known
Pentium M processors, derived from the Table 5 in the Intel Pentium M
datasheet (25261202.pdf).  The tables derived from the datasheet exactly
match the tables in ACPI on my 1.3GHz Pentium M IBM ThinkPad X31.

Because this driver is using undocumented registers, it is careful to
only apply to CPUs which I'm confident that it will work with. 
Therefore, not only does it look for the EST feature bit, but will only
work on Family 6, Model 9, Stepping 5 processors.  It also needs an
exact match on model name when choosing which operating point table to
use.

This is the 3rd iteration of this driver; it adds proper use of the
cpufreq frequency change notifier, which fixes problems with the TSC
changing rate.

It does not (yet) attempt to deal with the processor autonomously
changing performance operating point as part of its automatic thermal
control stuff.

I'm very interested in people trying this on other models of Pentium M
processor.  I've had to guess what the model name string is for other
speed grades, and I'm not sure I got it right.  I'm fairly sure this
driver can't cause physical damage, but it could well cause instability
and/or outright crashes when enabled, so be careful.  It works fine for
me though.

Patch is against 2.5.70-mm8, but it should apply to base 2.5.70.

	J

--=-tTz+HneN0BJhwzEsJEBR
Content-Disposition: attachment; filename=cpufreq-centrino.patch
Content-Type: text/plain; name=cpufreq-centrino.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This implements an Enhanced SpeedStep cpufreq driver for Intel Pentium M CPUs.

It is based on my own experimentation with my laptop, along with
information gleaned from Intel documentation.


 Documentation/cpu-freq/user-guide.txt   |    1 
 arch/i386/kernel/cpu/cpufreq/Kconfig    |   29 +-
 arch/i386/kernel/cpu/cpufreq/Makefile   |    1 
 arch/i386/kernel/cpu/cpufreq/centrino.c |  375 ++++++++++++++++++++++++++++++++
 include/asm-i386/cpufeature.h           |    1 
 include/asm-i386/msr.h                  |    3 
 6 files changed, 401 insertions(+), 9 deletions(-)

diff -puN /dev/null arch/i386/kernel/cpu/cpufreq/centrino.c
--- /dev/null	2003-01-30 02:24:37.000000000 -0800
+++ local-2.5-jeremy/arch/i386/kernel/cpu/cpufreq/centrino.c	2003-06-11 12:51:51.000000000 -0700
@@ -0,0 +1,375 @@
+/*
+ * cpufreq driver for Enhanced SpeedStep, as found in Intel's Pentium
+ * M (part of the Centrino chipset).
+ *
+ * Despite the "SpeedStep" in the name, this is almost entirely unlike
+ * traditional SpeedStep.
+ *
+ * Modelled on speedstep.c
+ *
+ * Copyright (C) 2003 Jeremy Fitzhardinge <jeremy@goop.org>
+ *
+ * WARNING WARNING WARNING
+ * 
+ * This driver manipulates the PERF_CTL MSR, which is only somewhat
+ * documented.  While it seems to work on my laptop, it has not been
+ * tested anywhere else, and it may not work for you, do strange
+ * things or simply crash.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+#include <asm/cpufeature.h>
+
+#define MAINTAINER	"Jeremy Fitzhardinge <jeremy@goop.org>"
+
+#define CENTRINO_DEBUG
+
+#ifdef CENTRINO_DEBUG
+#define dprintk(msg...) printk(msg)
+#else
+#define dprintk(msg...) do { } while(0)
+#endif
+
+struct cpu_model
+{
+	const char	*model_name;
+	unsigned	max_freq; /* max clock in kHz */
+
+	struct cpufreq_frequency_table *op_points; /* clock/voltage pairs */
+};
+
+/* Operating points for current CPU */
+static const struct cpu_model *centrino_model;
+
+/* Computes the correct form for IA32_PERF_CTL MSR for a particular
+   frequency/voltage operating point; frequency in MHz, volts in mV.
+   This is stored as "index" in the structure. */
+#define OP(mhz, mv)							\
+	{								\
+		.frequency = (mhz) * 1000,				\
+		.index = (((mhz)/100) << 8) | ((mv - 700) / 16)		\
+	}
+
+/* 
+ * These voltage tables were derived from the Intel Pentium M
+ * datasheet, document 25261202.pdf, Table 5.  I have verified they
+ * are consistent with my IBM ThinkPad X31, which has a 1.3GHz Pentium
+ * M.
+ */
+
+/* Ultra Low Voltage Intel Pentium M processor 900MHz */
+static struct cpufreq_frequency_table op_900[] =
+{
+	OP(600,  844),
+	OP(800,  988),
+	OP(900, 1004),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Low Voltage Intel Pentium M processor 1.10GHz */
+static struct cpufreq_frequency_table op_1100[] =
+{
+	OP( 600,  956),
+	OP( 800, 1020),
+	OP( 900, 1100),
+	OP(1000, 1164),
+	OP(1100, 1180),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+
+/* Low Voltage Intel Pentium M processor 1.20GHz */
+static struct cpufreq_frequency_table op_1200[] =
+{
+	OP( 600,  956),
+	OP( 800, 1004),
+	OP( 900, 1020),
+	OP(1000, 1100),
+	OP(1100, 1164),
+	OP(1200, 1180),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.30GHz */
+static struct cpufreq_frequency_table op_1300[] = 
+{
+	OP( 600,  956),
+	OP( 800, 1260),
+	OP(1000, 1292),
+	OP(1200, 1356),
+	OP(1300, 1388),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.40GHz */
+static struct cpufreq_frequency_table op_1400[] = 
+{
+	OP( 600,  956),
+	OP( 800, 1180),
+	OP(1000, 1308),
+	OP(1200, 1436),
+	OP(1400, 1484),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.50GHz */
+static struct cpufreq_frequency_table op_1500[] = 
+{
+	OP( 600,  956),
+	OP( 800, 1116),
+	OP(1000, 1228),
+	OP(1200, 1356),
+	OP(1400, 1452),
+	OP(1500, 1484),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.60GHz */
+static struct cpufreq_frequency_table op_1600[] = 
+{
+	OP( 600,  956),
+	OP( 800, 1036),
+	OP(1000, 1164),
+	OP(1200, 1276),
+	OP(1400, 1420),
+	OP(1600, 1484),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.70GHz */
+static struct cpufreq_frequency_table op_1700[] =
+{
+	OP( 600,  956),
+	OP( 800, 1004),
+	OP(1000, 1116),
+	OP(1200, 1228),
+	OP(1400, 1308),
+	OP(1700, 1484),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+#undef OP
+
+#define CPU(max)	\
+	{ "Intel(R) Pentium(R) M processor " #max "MHz", (max)*1000, op_##max }
+
+/* CPU models, their operating frequency range, and freq/voltage
+   operating points */
+static const struct cpu_model models[] = 
+{
+	CPU( 900),
+	CPU(1100),
+	CPU(1200),
+	CPU(1300),
+	CPU(1400),
+	CPU(1500),
+	CPU(1600),
+	CPU(1700),
+	{ 0, }
+};
+#undef CPU
+
+/* Extract clock in kHz from PERF_CTL value */
+static unsigned extract_clock(unsigned msr)
+{
+	msr = (msr >> 8) & 0xff;
+	return msr * 100000;
+}
+
+/* Return the current CPU frequency in kHz */
+static unsigned get_cur_freq(void)
+{
+	unsigned l, h;
+
+	rdmsr(MSR_IA32_PERF_STATUS, l, h);
+	return extract_clock(l);
+}
+
+static int centrino_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned freq;
+
+	if (policy->cpu != 0 || centrino_model == NULL)
+		return -ENODEV;
+
+	freq = get_cur_freq();
+
+	policy->policy = (freq == centrino_model->max_freq) ? 
+		CPUFREQ_POLICY_PERFORMANCE : 
+		CPUFREQ_POLICY_POWERSAVE;
+	policy->cpuinfo.transition_latency = 10; /* 10uS transition latency */
+	policy->cur = freq;
+
+	dprintk(KERN_INFO "centrino_cpu_init: policy=%d cur=%dkHz\n",
+		policy->policy, policy->cur);
+	
+	return cpufreq_frequency_table_cpuinfo(policy, centrino_model->op_points);
+}
+
+/**
+ * centrino_verify - verifies a new CPUFreq policy
+ * @freq: new policy
+ *
+ * Limit must be within this model's frequency range at least one
+ * border included.
+ */
+static int centrino_verify (struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, centrino_model->op_points);
+}
+
+/**
+ * centrino_setpolicy - set a new CPUFreq policy
+ * @policy: new policy
+ *
+ * Sets a new CPUFreq policy.
+ */
+static int centrino_target (struct cpufreq_policy *policy,
+			    unsigned int target_freq,
+			    unsigned int relation)
+{
+	unsigned int    newstate = 0;
+	unsigned int	msr, oldmsr, h;
+	struct cpufreq_freqs	freqs;
+
+	if (centrino_model == NULL)
+		return -ENODEV;
+
+	if (cpufreq_frequency_table_target(policy, centrino_model->op_points, target_freq,
+					   relation, &newstate))
+		return -EINVAL;
+
+	msr = centrino_model->op_points[newstate].index;
+	rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+	if (msr == (oldmsr & 0xffff))
+		return 0;
+
+	/* Hm, old frequency can either be the last value we put in
+	   PERF_CTL, or whatever it is now. The trouble is that TC2
+	   can change it behind our back, which means we never get to
+	   see the speed change.  Reading back the current speed would
+	   tell us something happened, but it may leave the things on
+	   the notifier chain confused; we therefore stick to using
+	   the last programmed speed rather than the current speed for
+	   "old". 
+
+	   TODO: work out how the TCC interrupts work, and try to
+	   catch the CPU changing things under us.
+	*/
+	freqs.cpu = 0;
+	freqs.old = extract_clock(oldmsr);
+	freqs.new = extract_clock(msr);
+	
+	dprintk(KERN_INFO "centrino: target=%dkHz old=%d new=%d msr=%04x\n",
+		target_freq, freqs.old, freqs.new, msr);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);	
+
+	/* all but 16 LSB are "reserved", so treat them with
+	   care */
+	oldmsr &= ~0xffff;
+	msr &= 0xffff;
+	oldmsr |= msr;
+	
+	wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return 0;
+}
+
+static struct cpufreq_driver centrino_driver = {
+	.name		= "centrino",
+	.init		= centrino_cpu_init,
+	.verify 	= centrino_verify,
+	.target 	= centrino_target,
+	.owner		= THIS_MODULE,
+};
+
+
+/**
+ * centrino_init - initializes the Enhanced SpeedStep CPUFreq driver
+ *
+ * Initializes the Enhanced SpeedStep support. Returns -ENODEV on
+ * unsupported devices, -ENOENT if there's no voltage table for this
+ * particular CPU model, -EINVAL on problems during initiatization,
+ * and zero on success.
+ *
+ * This is quite picky.  Not only does the CPU have to advertise the
+ * "est" flag in the cpuid capability flags, we look for a specific
+ * CPU model and stepping, and we need to have the exact model name in
+ * our voltage tables.  That is, be paranoid about not releasing
+ * someone's valuable magic smoke.
+ */
+static int __init centrino_init(void)
+{
+	struct cpuinfo_x86 *cpu = cpu_data;
+	const struct cpu_model *model;
+	unsigned l, h;
+
+	if (!cpu_has(cpu, X86_FEATURE_EST))
+		return -ENODEV;
+
+	/* Only Intel Pentium M stepping 5 for now - add new CPUs as
+	   they appear after making sure they use PERF_CTL in the same
+	   way. */
+	if (cpu->x86_vendor != X86_VENDOR_INTEL ||
+	    cpu->x86        != 6 ||
+	    cpu->x86_model  != 9 ||
+	    cpu->x86_mask   != 5) {
+		printk(KERN_INFO "centrino: found unsupported CPU with Enhanced SpeedStep: "
+		       "send /proc/cpuinfo to " MAINTAINER "\n");
+		return -ENODEV;
+	}
+
+	/* Check to see if Enhanced SpeedStep is enabled, and try to
+	   enable it if not. */
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+		
+	if (!(l & (1<<16))) {
+		l |= (1<<16);
+		wrmsr(MSR_IA32_MISC_ENABLE, l, h);
+		
+		/* check to see if it stuck */
+		rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+		if (!(l & (1<<16))) {
+			printk(KERN_INFO "centrino: couldn't enable Enhanced SpeedStep\n");
+			return -ENODEV;
+		}
+	}
+
+	for(model = models; model->model_name != NULL; model++)
+		if (strcmp(cpu->x86_model_id, model->model_name) == 0)
+			break;
+	if (model->model_name == NULL) {
+		printk(KERN_INFO "centrino: no support for CPU model \"%s\": "
+		       "send /proc/cpuinfo to " MAINTAINER "\n",
+		       cpu->x86_model_id);
+		return -ENOENT;
+	}
+
+	centrino_model = model;
+		
+	printk(KERN_INFO "centrino: found \"%s\": max frequency: %dkHz\n",
+	       model->model_name, model->max_freq);
+
+	return cpufreq_register_driver(&centrino_driver);
+}
+
+static void __exit centrino_exit(void)
+{
+	cpufreq_unregister_driver(&centrino_driver);
+}
+
+MODULE_AUTHOR ("Jeremy Fitzhardinge <jeremy@goop.org>");
+MODULE_DESCRIPTION ("Enhanced SpeedStep driver for Intel Pentium M processors.");
+MODULE_LICENSE ("GPL");
+
+module_init(centrino_init);
+module_exit(centrino_exit);
diff -puN arch/i386/kernel/cpu/cpufreq/Kconfig~cpufreq-centrino arch/i386/kernel/cpu/cpufreq/Kconfig
--- local-2.5/arch/i386/kernel/cpu/cpufreq/Kconfig~cpufreq-centrino	2003-06-11 10:18:55.000000000 -0700
+++ local-2.5-jeremy/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-06-11 10:18:55.000000000 -0700
@@ -38,7 +38,7 @@ config X86_ACPI_CPUFREQ
 	  This driver adds a CPUFreq driver which utilizes the ACPI
 	  Processor Performance States.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at linux/Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -63,7 +63,7 @@ config ELAN_CPUFREQ
 	  parameter: elanfreq=maxspeed (in kHz) or as module
 	  parameter "max_freq".
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at linux/Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -74,7 +74,7 @@ config X86_POWERNOW_K6
 	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
 	  AMD K6-3+ processors.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at linux/Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -84,7 +84,7 @@ config X86_POWERNOW_K7
 	help
 	  This adds the CPUFreq driver for mobile AMD K7 mobile processors.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at linux/Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -95,7 +95,7 @@ config X86_GX_SUSPMOD
 	 This add the CPUFreq driver for NatSemi Geode processors which
 	 support suspend modulation.
 
-	 For details, take a look at linux/Documentation/cpufreq.
+	 For details, take a look at linux/Documentation/cpu-freq.
 
 	 If in doubt, say N.
 
@@ -107,10 +107,21 @@ config X86_SPEEDSTEP
 	  (Coppermine), all mobile Intel Pentium III-M (Tulatin) and all
 	  mobile Intel Pentium 4 P4-Ms.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at linux/Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
+config X86_ENHANCED_SPEEDSTEP
+	tristate "Intel Enhanced SpeedStep"
+	depends on CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for Enhanced SpeedStep enabled
+	  mobile CPUs.  This means Intel Pentium M (Centrino) CPUs.
+	  
+	  For details, take a look at linux/Documentation/cpu-freq. 
+	  
+	  If in doubt, say N.
+
 config X86_P4_CLOCKMOD
 	tristate "Intel Pentium 4 clock modulation"
 	depends on CPU_FREQ_TABLE
@@ -118,7 +129,7 @@ config X86_P4_CLOCKMOD
 	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
 	  processors.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at linux/Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -129,7 +140,7 @@ config X86_LONGRUN
 	  This adds the CPUFreq driver for Transmeta Crusoe processors which
 	  support LongRun.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at linux/Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -141,7 +152,7 @@ config X86_LONGHAUL
 	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
 	  processors.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at linux/Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
diff -puN include/asm-i386/msr.h~cpufreq-centrino include/asm-i386/msr.h
--- local-2.5/include/asm-i386/msr.h~cpufreq-centrino	2003-06-11 10:18:55.000000000 -0700
+++ local-2.5-jeremy/include/asm-i386/msr.h	2003-06-11 10:18:55.000000000 -0700
@@ -77,6 +77,9 @@
 #define MSR_P6_EVNTSEL0			0x186
 #define MSR_P6_EVNTSEL1			0x187
 
+#define MSR_IA32_PERF_STATUS		0x198
+#define MSR_IA32_PERF_CTL		0x199
+
 #define MSR_IA32_THERM_CONTROL		0x19a
 #define MSR_IA32_THERM_INTERRUPT	0x19b
 #define MSR_IA32_THERM_STATUS		0x19c
diff -puN arch/i386/kernel/cpu/cpufreq/Makefile~cpufreq-centrino arch/i386/kernel/cpu/cpufreq/Makefile
--- local-2.5/arch/i386/kernel/cpu/cpufreq/Makefile~cpufreq-centrino	2003-06-11 10:18:55.000000000 -0700
+++ local-2.5-jeremy/arch/i386/kernel/cpu/cpufreq/Makefile	2003-06-11 10:18:55.000000000 -0700
@@ -7,6 +7,7 @@ obj-$(CONFIG_ELAN_CPUFREQ)	+= elanfreq.o
 obj-$(CONFIG_X86_LONGRUN)	+= longrun.o  
 obj-$(CONFIG_X86_GX_SUSPMOD)    += gx-suspmod.o
 obj-$(CONFIG_X86_ACPI_CPUFREQ)	+= acpi.o
+obj-$(CONFIG_X86_ENHANCED_SPEEDSTEP) += centrino.o
 
 ifdef CONFIG_X86_ACPI_CPUFREQ
   ifdef CONFIG_ACPI_DEBUG
diff -puN include/asm-i386/cpufeature.h~cpufreq-centrino include/asm-i386/cpufeature.h
--- local-2.5/include/asm-i386/cpufeature.h~cpufreq-centrino	2003-06-11 10:18:55.000000000 -0700
+++ local-2.5-jeremy/include/asm-i386/cpufeature.h	2003-06-11 10:18:55.000000000 -0700
@@ -70,6 +70,7 @@
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
+#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
 
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
 #define X86_FEATURE_XSTORE	(5*32+ 2) /* on-CPU RNG present (xstore insn) */
diff -puN Documentation/cpu-freq/user-guide.txt~cpufreq-centrino Documentation/cpu-freq/user-guide.txt
--- local-2.5/Documentation/cpu-freq/user-guide.txt~cpufreq-centrino	2003-06-11 10:18:55.000000000 -0700
+++ local-2.5-jeremy/Documentation/cpu-freq/user-guide.txt	2003-06-11 10:18:55.000000000 -0700
@@ -56,6 +56,7 @@ AMD mobile K6-3+
 Cyrix Media GXm
 Intel mobile PIII [*] and Intel mobile PIII-M on certain chipsets
 Intel Pentium 4, Intel Xeon
+Intel Pentium M (Centrino)
 National Semiconductors Geode GX
 Transmeta Crusoe
 VIA Cyrix 3 / C3

_

--=-tTz+HneN0BJhwzEsJEBR--

