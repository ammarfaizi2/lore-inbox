Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWGFFJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWGFFJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWGFFJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:09:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:17114 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965158AbWGFFJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:09:33 -0400
Subject: [PATCH] powerpc: Add cpufreq support for Xserve G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 15:09:19 +1000
Message-Id: <1152162559.24632.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Xserve G5 are capable of frequency switching like other desktop G5s.
This enables it. It also fix a Kconfig issue which prevented from
building the G5 cpufreq support if CONFIG_PMAC_SMU was not set (the
first version of that driver only worked with SMU based macs, but this
isn't the case anymore).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/Kconfig
===================================================================
--- linux-irq-work.orig/arch/powerpc/Kconfig	2006-07-01 13:51:11.000000000 +1000
+++ linux-irq-work/arch/powerpc/Kconfig	2006-07-06 12:16:11.000000000 +1000
@@ -504,7 +504,7 @@
 
 config CPU_FREQ_PMAC64
 	bool "Support for some Apple G5s"
-	depends on CPU_FREQ && PMAC_SMU && PPC64
+	depends on CPU_FREQ && PPC64
 	select CPU_FREQ_TABLE
 	help
 	  This adds support for frequency switching on Apple iMac G5,
Index: linux-irq-work/arch/powerpc/platforms/powermac/cpufreq_64.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/powermac/cpufreq_64.c	2006-07-01 13:51:11.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/powermac/cpufreq_64.c	2006-07-06 14:58:31.000000000 +1000
@@ -10,6 +10,8 @@
  * that is iMac G5 and latest single CPU desktop.
  */
 
+#undef DEBUG
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -30,13 +32,7 @@
 #include <asm/smu.h>
 #include <asm/pmac_pfunc.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
+#define DBG(fmt...) pr_debug(fmt)
 
 /* see 970FX user manual */
 
@@ -82,8 +78,6 @@
 /* Power mode data is an array of the 32 bits PCR values to use for
  * the various frequencies, retrieved from the device-tree
  */
-static u32 *g5_pmode_data;
-static int g5_pmode_max;
 static int g5_pmode_cur;
 
 static void (*g5_switch_volt)(int speed_mode);
@@ -93,6 +87,11 @@
 static DEFINE_MUTEX(g5_switch_mutex);
 
 
+#ifdef CONFIG_PPC_SMU
+
+static u32 *g5_pmode_data;
+static int g5_pmode_max;
+
 static struct smu_sdbp_fvt *g5_fvt_table;	/* table of op. points */
 static int g5_fvt_count;			/* number of op. points */
 static int g5_fvt_cur;				/* current op. point */
@@ -210,6 +209,16 @@
 }
 
 /*
+ * Fake voltage switching for platforms with missing support
+ */
+
+static void g5_dummy_switch_volt(int speed_mode)
+{
+}
+
+#endif /* CONFIG_PPC_SMU */
+
+/*
  * Platform function based voltage switching for PowerMac7,2 & 7,3
  */
 
@@ -248,6 +257,9 @@
 	struct pmf_args args;
 	u32 done = 0;
 	unsigned long timeout;
+	int rc;
+
+	DBG("g5_pfunc_switch_freq(%d)\n", speed_mode);
 
 	/* If frequency is going up, first ramp up the voltage */
 	if (speed_mode < g5_pmode_cur)
@@ -255,9 +267,12 @@
 
 	/* Do it */
 	if (speed_mode == CPUFREQ_HIGH)
-		pmf_call_one(pfunc_cpu_setfreq_high, NULL);
+		rc = pmf_call_one(pfunc_cpu_setfreq_high, NULL);
 	else
-		pmf_call_one(pfunc_cpu_setfreq_low, NULL);
+		rc = pmf_call_one(pfunc_cpu_setfreq_low, NULL);
+
+	if (rc)
+		printk(KERN_WARNING "cpufreq: pfunc switch error %d\n", rc);
 
 	/* It's an irq GPIO so we should be able to just block here,
 	 * I'll do that later after I've properly tested the IRQ code for
@@ -296,13 +311,6 @@
 	return val ? CPUFREQ_HIGH : CPUFREQ_LOW;
 }
 
-/*
- * Fake voltage switching for platforms with missing support
- */
-
-static void g5_dummy_switch_volt(int speed_mode)
-{
-}
 
 /*
  * Common interface to the cpufreq core
@@ -375,6 +383,8 @@
 };
 
 
+#ifdef CONFIG_PPC_SMU
+
 static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 {
 	struct device_node *cpunode;
@@ -525,6 +535,9 @@
 	return rc;
 }
 
+#endif /* CONFIG_PPC_SMU */
+
+
 static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 {
 	struct device_node *cpuid = NULL, *hwclock = NULL, *cpunode = NULL;
@@ -533,6 +546,9 @@
 	u64 max_freq, min_freq, ih, il;
 	int has_volt = 1, rc = 0;
 
+	DBG("cpufreq: Initializing for PowerMac7,2, PowerMac7,3 and"
+	    " RackMac3,1...\n");
+
 	/* Get first CPU node */
 	for (cpunode = NULL;
 	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
@@ -636,6 +652,15 @@
 	 */
 	ih = *((u32 *)(eeprom + 0x10));
 	il = *((u32 *)(eeprom + 0x20));
+
+	/* Check for machines with no useful settings */
+	if (il == ih) {
+		printk(KERN_WARNING "cpufreq: No low frequency mode available"
+		       " on this model !\n");
+		rc = -ENODEV;
+		goto bail;
+	}
+
 	min_freq = 0;
 	if (ih != 0 && il != 0)
 		min_freq = (max_freq * il) / ih;
@@ -643,7 +668,7 @@
 	/* Sanity check */
 	if (min_freq >= max_freq || min_freq < 1000) {
 		printk(KERN_ERR "cpufreq: Can't calculate low frequency !\n");
-		rc = -ENODEV;
+		rc = -ENXIO;
 		goto bail;
 	}
 	g5_cpu_freqs[0].frequency = max_freq;
@@ -690,16 +715,10 @@
 	return rc;
 }
 
-static int __init g5_rm31_cpufreq_init(struct device_node *cpus)
-{
-	/* NYI */
-	return 0;
-}
-
 static int __init g5_cpufreq_init(void)
 {
 	struct device_node *cpus;
-	int rc;
+	int rc = 0;
 
 	cpus = of_find_node_by_path("/cpus");
 	if (cpus == NULL) {
@@ -708,12 +727,13 @@
 	}
 
 	if (machine_is_compatible("PowerMac7,2") ||
-	    machine_is_compatible("PowerMac7,3"))
+	    machine_is_compatible("PowerMac7,3") ||
+	    machine_is_compatible("RackMac3,1"))
 		rc = g5_pm72_cpufreq_init(cpus);
-	else if (machine_is_compatible("RackMac3,1"))
-		rc = g5_rm31_cpufreq_init(cpus);
+#ifdef CONFIG_PPC_SMU
 	else
 		rc = g5_neo2_cpufreq_init(cpus);
+#endif /* CONFIG_PPC_SMU */
 
 	of_node_put(cpus);
 	return rc;


