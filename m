Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTBOKQR>; Sat, 15 Feb 2003 05:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTBOKQR>; Sat, 15 Feb 2003 05:16:17 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:32993 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264749AbTBOKQJ>; Sat, 15 Feb 2003 05:16:09 -0500
Date: Sat, 15 Feb 2003 11:23:41 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.61] cpufreq: move frequency table helpers to extra module
Message-ID: <20030215102341.GA11502@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU frequency table helpers can easily be modularized --
especially as they are not needed on all architectures, or for 
all drivers (even on x86 -- see longrun and gx-suspmod)

 arch/i386/Kconfig            |   22 +++-
 arch/sparc64/Kconfig         |    7 +
 drivers/Makefile             |    1
 drivers/cpufreq/Makefile     |    2
 drivers/cpufreq/freq_table.c |  203 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h      |    3
 kernel/cpufreq.c             |  188 ---------------------------------------
 7 files changed, 231 insertions(+), 195 deletions(-)

diff -ruN linux-original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-original/arch/i386/Kconfig	2003-02-15 10:12:03.000000000 +0100
+++ linux/arch/i386/Kconfig	2003-02-15 10:15:27.000000000 +0100
@@ -994,9 +994,19 @@
 
 	  If in doubt, say N.
 
+config CPU_FREQ_TABLE
+       tristate "CPU frequency table helpers"
+       depends on CPU_FREQ
+       default y
+       help
+         Many CPUFreq drivers use these helpers, so only say N here if
+	 the CPUFreq driver of your choice doesn't need these helpers.
+
+	 If in doubt, say Y.
+
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
-	depends on CPU_FREQ && ACPI_PROCESSOR
+	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
 	help
 	  This driver adds a CPUFreq driver which utilizes the ACPI
 	  Processor Performance States.
@@ -1007,7 +1017,7 @@
 
 config X86_POWERNOW_K6
 	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
-	depends on CPU_FREQ
+	depends on CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
 	  AMD K6-3+ processors.
@@ -1018,7 +1028,7 @@
 
 config X86_POWERNOW_K7
 	tristate "AMD Mobile Athlon/Duron PowerNow!"
-	depends on CPU_FREQ
+	depends on CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for mobile AMD K7 mobile processors.
 
@@ -1028,7 +1038,7 @@
 
 config ELAN_CPUFREQ
 	tristate "AMD Elan"
-	depends on CPU_FREQ && MELAN
+	depends on CPU_FREQ_TABLE && MELAN
 	---help---
 	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
 	  processors.
@@ -1055,7 +1065,7 @@
 
 config X86_SPEEDSTEP
 	tristate "Intel Speedstep"
-	depends on CPU_FREQ
+	depends on CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for certain mobile Intel Pentium III
 	  (Coppermine), all mobile Intel Pentium III-M (Tulatin) and all
@@ -1067,7 +1077,7 @@
 
 config X86_P4_CLOCKMOD
 	tristate "Intel Pentium 4 clock modulation"
-	depends on CPU_FREQ
+	depends on CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
 	  processors.
diff -ruN linux-original/arch/sparc64/Kconfig linux/arch/sparc64/Kconfig
--- linux-original/arch/sparc64/Kconfig	2003-02-15 10:12:08.000000000 +0100
+++ linux/arch/sparc64/Kconfig	2003-02-15 10:15:00.000000000 +0100
@@ -162,9 +162,14 @@
 	  
 	  If in doubt, say N.
 
+config CPU_FREQ_TABLE
+       tristate
+       default y
+
+
 config US3_FREQ
 	tristate "UltraSPARC-III CPU Frequency driver"
-	depends on CPU_FREQ
+	depends on CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for UltraSPARC-III processors.
 
diff -ruN linux-original/drivers/Makefile linux/drivers/Makefile
--- linux-original/drivers/Makefile	2003-02-15 10:12:51.000000000 +0100
+++ linux/drivers/Makefile	2003-02-15 10:15:00.000000000 +0100
@@ -45,3 +45,4 @@
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
diff -ruN linux-original/drivers/cpufreq/Makefile linux/drivers/cpufreq/Makefile
--- linux-original/drivers/cpufreq/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/cpufreq/Makefile	2003-02-15 10:15:00.000000000 +0100
@@ -0,0 +1,2 @@
+#CPUfreq governors and cross-arch helpers
+obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o
diff -ruN linux-original/drivers/cpufreq/freq_table.c linux/drivers/cpufreq/freq_table.c
--- linux-original/drivers/cpufreq/freq_table.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/cpufreq/freq_table.c	2003-02-15 10:16:27.000000000 +0100
@@ -0,0 +1,203 @@
+/*
+ * linux/drivers/cpufreq/freq_table.c
+ *
+ * Copyright (C) 2002 - 2003 Dominik Brodowski
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+
+/*********************************************************************
+ *                     FREQUENCY TABLE HELPERS                       *
+ *********************************************************************/
+
+int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
+				    struct cpufreq_frequency_table *table)
+{
+	unsigned int min_freq = ~0;
+	unsigned int max_freq = 0;
+	unsigned int i = 0;
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		unsigned int freq = table[i].frequency;
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if (freq < min_freq)
+			min_freq = freq;
+		if (freq > max_freq)
+			max_freq = freq;
+	}
+
+	policy->min = policy->cpuinfo.min_freq = min_freq;
+	policy->max = policy->cpuinfo.max_freq = max_freq;
+
+	if (policy->min == ~0)
+		return -EINVAL;
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_cpuinfo);
+
+
+int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
+				   struct cpufreq_frequency_table *table)
+{
+	unsigned int next_larger = ~0;
+	unsigned int i = 0;
+	unsigned int count = 0;
+
+	if (!cpu_online(policy->cpu))
+		return -EINVAL;
+
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		unsigned int freq = table[i].frequency;
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if ((freq >= policy->min) && (freq <= policy->max))
+			count++;
+		else if ((next_larger > freq) && (freq > policy->max))
+			next_larger = freq;
+	}
+
+	if (!count)
+		policy->max = next_larger;
+
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
+
+
+int cpufreq_frequency_table_setpolicy(struct cpufreq_policy *policy,
+				      struct cpufreq_frequency_table *table,
+				      unsigned int *index)
+{
+	struct cpufreq_frequency_table optimal = { .index = ~0, };
+	unsigned int i;
+
+	switch (policy->policy) {
+	case CPUFREQ_POLICY_PERFORMANCE:
+		optimal.frequency = 0;
+		break;
+	case CPUFREQ_POLICY_POWERSAVE:
+		optimal.frequency = ~0;
+		break;
+	}
+
+	if (!cpu_online(policy->cpu))
+		return -EINVAL;
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		unsigned int freq = table[i].frequency;
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+		switch(policy->policy) {
+		case CPUFREQ_POLICY_PERFORMANCE:
+			if (optimal.frequency <= freq) {
+				optimal.frequency = freq;
+				optimal.index = i;
+			}
+			break;
+		case CPUFREQ_POLICY_POWERSAVE:
+			if (optimal.frequency >= freq) {
+				optimal.frequency = freq;
+				optimal.index = i;
+			}
+			break;
+		}
+	}
+	if (optimal.index > i)
+		return -EINVAL;
+
+	*index = optimal.index;
+	
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_setpolicy);
+
+
+int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
+				   struct cpufreq_frequency_table *table,
+				   unsigned int target_freq,
+				   unsigned int relation,
+				   unsigned int *index)
+{
+	struct cpufreq_frequency_table optimal = { .index = ~0, };
+	struct cpufreq_frequency_table suboptimal = { .index = ~0, };
+	unsigned int i;
+
+	switch (relation) {
+	case CPUFREQ_RELATION_H:
+		optimal.frequency = 0;
+		suboptimal.frequency = ~0;
+		break;
+	case CPUFREQ_RELATION_L:
+		optimal.frequency = ~0;
+		suboptimal.frequency = 0;
+		break;
+	}
+
+	if (!cpu_online(policy->cpu))
+		return -EINVAL;
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		unsigned int freq = table[i].frequency;
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+		switch(relation) {
+		case CPUFREQ_RELATION_H:
+			if (freq <= target_freq) {
+				if (freq >= optimal.frequency) {
+					optimal.frequency = freq;
+					optimal.index = i;
+				}
+			} else {
+				if (freq <= suboptimal.frequency) {
+					suboptimal.frequency = freq;
+					suboptimal.index = i;
+				}
+			}
+			break;
+		case CPUFREQ_RELATION_L:
+			if (freq >= target_freq) {
+				if (freq <= optimal.frequency) {
+					optimal.frequency = freq;
+					optimal.index = i;
+				}
+			} else {
+				if (freq >= suboptimal.frequency) {
+					suboptimal.frequency = freq;
+					suboptimal.index = i;
+				}
+			}
+			break;
+		}
+	}
+	if (optimal.index > i) {
+		if (suboptimal.index > i)
+			return -EINVAL;
+		*index = suboptimal.index;
+	} else
+		*index = optimal.index;
+	
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
+
+
+MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION ("CPUfreq frequency table helpers");
+MODULE_LICENSE ("GPL");
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-02-15 10:13:30.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-02-15 10:15:00.000000000 +0100
@@ -297,6 +297,7 @@
 
 #endif /* CONFIG_CPU_FREQ_24_API */
 
+#if defined(CONFIG_CPU_FREQ_TABLE) || defined(CONFIG_CPU_FREQ_TABLE_MODULE)
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
@@ -326,4 +327,6 @@
 				   unsigned int relation,
 				   unsigned int *index);
 
+#endif /* CONFIG_CPU_FREQ_TABLE */
+
 #endif /* _LINUX_CPUFREQ_H */
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-02-15 10:13:53.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-02-15 10:15:00.000000000 +0100
@@ -1582,191 +1582,3 @@
 #else
 #define cpufreq_restore() do {} while (0)
 #endif /* CONFIG_PM */
-
-
-/*********************************************************************
- *                     FREQUENCY TABLE HELPERS                       *
- *********************************************************************/
-
-int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
-				    struct cpufreq_frequency_table *table)
-{
-	unsigned int min_freq = ~0;
-	unsigned int max_freq = 0;
-	unsigned int i = 0;
-
-	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		unsigned int freq = table[i].frequency;
-		if (freq == CPUFREQ_ENTRY_INVALID)
-			continue;
-		if (freq < min_freq)
-			min_freq = freq;
-		if (freq > max_freq)
-			max_freq = freq;
-	}
-
-	policy->min = policy->cpuinfo.min_freq = min_freq;
-	policy->max = policy->cpuinfo.max_freq = max_freq;
-
-	if (policy->min == ~0)
-		return -EINVAL;
-	else
-		return 0;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_cpuinfo);
-
-
-int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
-				   struct cpufreq_frequency_table *table)
-{
-	unsigned int next_larger = ~0;
-	unsigned int i = 0;
-	unsigned int count = 0;
-
-	if (!cpu_online(policy->cpu))
-		return -EINVAL;
-
-	cpufreq_verify_within_limits(policy, 
-				     policy->cpuinfo.min_freq, 
-				     policy->cpuinfo.max_freq);
-
-	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		unsigned int freq = table[i].frequency;
-		if (freq == CPUFREQ_ENTRY_INVALID)
-			continue;
-		if ((freq >= policy->min) && (freq <= policy->max))
-			count++;
-		else if ((next_larger > freq) && (freq > policy->max))
-			next_larger = freq;
-	}
-
-	if (!count)
-		policy->max = next_larger;
-
-	cpufreq_verify_within_limits(policy, 
-				     policy->cpuinfo.min_freq, 
-				     policy->cpuinfo.max_freq);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
-
-
-int cpufreq_frequency_table_setpolicy(struct cpufreq_policy *policy,
-				      struct cpufreq_frequency_table *table,
-				      unsigned int *index)
-{
-	struct cpufreq_frequency_table optimal = { .index = ~0, };
-	unsigned int i;
-
-	switch (policy->policy) {
-	case CPUFREQ_POLICY_PERFORMANCE:
-		optimal.frequency = 0;
-		break;
-	case CPUFREQ_POLICY_POWERSAVE:
-		optimal.frequency = ~0;
-		break;
-	}
-
-	if (!cpu_online(policy->cpu))
-		return -EINVAL;
-
-	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		unsigned int freq = table[i].frequency;
-		if (freq == CPUFREQ_ENTRY_INVALID)
-			continue;
-		if ((freq < policy->min) || (freq > policy->max))
-			continue;
-		switch(policy->policy) {
-		case CPUFREQ_POLICY_PERFORMANCE:
-			if (optimal.frequency <= freq) {
-				optimal.frequency = freq;
-				optimal.index = i;
-			}
-			break;
-		case CPUFREQ_POLICY_POWERSAVE:
-			if (optimal.frequency >= freq) {
-				optimal.frequency = freq;
-				optimal.index = i;
-			}
-			break;
-		}
-	}
-	if (optimal.index > i)
-		return -EINVAL;
-
-	*index = optimal.index;
-	
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_setpolicy);
-
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   struct cpufreq_frequency_table *table,
-				   unsigned int target_freq,
-				   unsigned int relation,
-				   unsigned int *index)
-{
-	struct cpufreq_frequency_table optimal = { .index = ~0, };
-	struct cpufreq_frequency_table suboptimal = { .index = ~0, };
-	unsigned int i;
-
-	switch (relation) {
-	case CPUFREQ_RELATION_H:
-		optimal.frequency = 0;
-		suboptimal.frequency = ~0;
-		break;
-	case CPUFREQ_RELATION_L:
-		optimal.frequency = ~0;
-		suboptimal.frequency = 0;
-		break;
-	}
-
-	if (!cpu_online(policy->cpu))
-		return -EINVAL;
-
-	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		unsigned int freq = table[i].frequency;
-		if (freq == CPUFREQ_ENTRY_INVALID)
-			continue;
-		if ((freq < policy->min) || (freq > policy->max))
-			continue;
-		switch(relation) {
-		case CPUFREQ_RELATION_H:
-			if (freq <= target_freq) {
-				if (freq >= optimal.frequency) {
-					optimal.frequency = freq;
-					optimal.index = i;
-				}
-			} else {
-				if (freq <= suboptimal.frequency) {
-					suboptimal.frequency = freq;
-					suboptimal.index = i;
-				}
-			}
-			break;
-		case CPUFREQ_RELATION_L:
-			if (freq >= target_freq) {
-				if (freq <= optimal.frequency) {
-					optimal.frequency = freq;
-					optimal.index = i;
-				}
-			} else {
-				if (freq >= suboptimal.frequency) {
-					suboptimal.frequency = freq;
-					suboptimal.index = i;
-				}
-			}
-			break;
-		}
-	}
-	if (optimal.index > i) {
-		if (suboptimal.index > i)
-			return -EINVAL;
-		*index = suboptimal.index;
-	} else
-		*index = optimal.index;
-	
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
