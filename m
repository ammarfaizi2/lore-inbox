Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUFVUT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUFVUT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbUFVUSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:18:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:24234 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265265AbUFVUNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:13:43 -0400
Subject: [PATCH] ppc32: Support for new Apple laptop models
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1087934829.1832.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 15:07:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds support for newer Apple laptop models. It adds the basic
identification for the new motherboards and the cpufreq support for models
using the new 7447A CPU from Motorola.

This is mostly the work of John Steele Scott <toojays@toojays.net> with
some bits from Sebastian Henschel <linux@kodeaffe.de> and some rework
by myself. Please apply,

Signed-off-by: John Steele Scott <toojays@toojays.net>
Signed-off-by: Sebastian Henschel <linux@kodeaffe.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -Nru a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S	2004-06-22 15:04:07 -05:00
+++ b/arch/ppc/kernel/misc.S	2004-06-22 15:04:07 -05:00
@@ -253,6 +253,24 @@
 	mtmsr	r7
 	blr
 
+_GLOBAL(low_choose_7447a_dfs)
+	/* Clear MSR:EE */
+	mfmsr	r7
+	rlwinm	r0,r7,0,17,15
+	mtmsr	r0
+	
+	/* Calc new HID1 value */
+	mfspr	r4,SPRN_HID1
+	insrwi	r4,r3,1,9	/* insert parameter into bit 9 */
+	sync
+	mtspr	SPRN_HID1,r4
+	sync
+	isync
+
+	/* Return */
+	mtmsr	r7
+	blr
+
 #endif /* CONFIG_CPU_FREQ_PMAC && CONFIG_6xx */
 
 /* void local_save_flags_ptr(unsigned long *flags) */
diff -Nru a/arch/ppc/platforms/pmac_cpufreq.c b/arch/ppc/platforms/pmac_cpufreq.c
--- a/arch/ppc/platforms/pmac_cpufreq.c	2004-06-22 15:04:07 -05:00
+++ b/arch/ppc/platforms/pmac_cpufreq.c	2004-06-22 15:04:07 -05:00
@@ -1,7 +1,8 @@
 /*
  *  arch/ppc/platforms/pmac_cpufreq.c
  *
- *  Copyright (C) 2002 - 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  Copyright (C) 2002 - 2004 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  Copyright (C) 2004        John Steele Scott <toojays@toojays.net>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -47,6 +48,7 @@
 #warning "WARNING, CPUFREQ not recommended on SMP kernels"
 #endif
 
+extern void low_choose_7447a_dfs(int dfs);
 extern void low_choose_750fx_pll(int pll);
 extern void low_sleep_handler(void);
 extern void openpic_suspend(struct sys_device *sysdev, u32 state);
@@ -54,18 +56,27 @@
 extern void enable_kernel_altivec(void);
 extern void enable_kernel_fp(void);
 
+/*
+ * Currently, PowerMac cpufreq supports only high & low frequencies
+ * that are set by the firmware
+ */
 static unsigned int low_freq;
 static unsigned int hi_freq;
 static unsigned int cur_freq;
 
-/* Clean that up some day ... use a func ptr or at least an enum... */
-static int cpufreq_uses_pmu;
-static int cpufreq_uses_gpios;
+/*
+ * Different models uses different mecanisms to switch the frequency
+ */
+static int (*set_speed_proc)(int low_speed);
 
+/*
+ * Some definitions used by the various speedprocs
+ */
 static u32 voltage_gpio;
 static u32 frequency_gpio;
 static u32 slew_done_gpio;
 
+
 #define PMAC_CPU_LOW_SPEED	1
 #define PMAC_CPU_HIGH_SPEED	0
 
@@ -123,9 +134,39 @@
 	return 0;
 }
 
+/* Switch CPU speed using DFS */
+static int __pmac dfs_set_cpu_speed(int low_speed)
+{
+	if (low_speed == 0) {
+		/* ramping up, set voltage first */
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/1000);
+	} else {
+		/* ramping down, enable aack delay first */
+		pmac_call_feature(PMAC_FTR_AACK_DELAY_ENABLE, NULL, 1, 0);
+	}
+
+	/* set frequency */
+	low_choose_7447a_dfs(low_speed);
+
+	if (low_speed == 1) {
+		/* ramping down, set voltage last */
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x04);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/1000);
+	} else {
+		/* ramping up, disable aack delay last */
+		pmac_call_feature(PMAC_FTR_AACK_DELAY_ENABLE, NULL, 0, 0);
+	}
+
+	return 0;
+}
+
+
 /* Switch CPU speed using slewing GPIOs
  */
-static int __pmac gpios_set_cpu_speed(unsigned int low_speed)
+static int __pmac gpios_set_cpu_speed(int low_speed)
 {
 	int gpio;
 
@@ -138,7 +179,8 @@
 	}
 
 	/* Set frequency */
-	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, frequency_gpio, low_speed ? 0x04 : 0x05);
+	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, frequency_gpio,
+			  low_speed ? 0x04 : 0x05);
 	udelay(200);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -163,7 +205,7 @@
 
 /* Switch CPU speed under PMU control
  */
-static int __pmac pmu_set_cpu_speed(unsigned int low_speed)
+static int __pmac pmu_set_cpu_speed(int low_speed)
 {
 	struct adb_request req;
 	unsigned long save_l2cr;
@@ -269,12 +311,7 @@
 		return 0;
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	if (cpufreq_uses_pmu)
-		rc = pmu_set_cpu_speed(speed_mode);
-	else if (cpufreq_uses_gpios)
-		rc = gpios_set_cpu_speed(speed_mode);
-	else
-		rc = cpu_750fx_cpu_speed(speed_mode);
+	set_speed_proc(speed_mode == PMAC_CPU_LOW_SPEED);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	cur_freq = (speed_mode == PMAC_CPU_HIGH_SPEED) ? hi_freq : low_freq;
 
@@ -338,20 +375,137 @@
 };
 
 
+static int __pmac pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
+{
+	struct device_node *volt_gpio_np = of_find_node_by_name(NULL,
+								"voltage-gpio");
+	struct device_node *freq_gpio_np = of_find_node_by_name(NULL,
+								"frequency-gpio");
+	struct device_node *slew_done_gpio_np = of_find_node_by_name(NULL,
+								     "slewing-done");
+	u32 *value;
+
+	/*
+	 * Check to see if it's GPIO driven or PMU only
+	 *
+	 * The way we extract the GPIO address is slightly hackish, but it
+	 * works well enough for now. We need to abstract the whole GPIO
+	 * stuff sooner or later anyway
+	 */
+
+	if (volt_gpio_np)
+		voltage_gpio = read_gpio(volt_gpio_np);
+	if (freq_gpio_np)
+		frequency_gpio = read_gpio(freq_gpio_np);
+	if (slew_done_gpio_np)
+		slew_done_gpio = read_gpio(slew_done_gpio_np);
+
+	/* If we use the frequency GPIOs, calculate the min/max speeds based
+	 * on the bus frequencies
+	 */
+	if (frequency_gpio && slew_done_gpio) {
+		int lenp, rc;
+		u32 *freqs, *ratio;
+
+		freqs = (u32 *)get_property(cpunode, "bus-frequencies", &lenp);
+		lenp /= sizeof(u32);
+		if (freqs == NULL || lenp != 2) {
+			printk(KERN_ERR "cpufreq: bus-frequencies incorrect or missing\n");
+			return 1;
+		}
+		ratio = (u32 *)get_property(cpunode, "processor-to-bus-ratio*2", NULL);
+		if (ratio == NULL) {
+			printk(KERN_ERR "cpufreq: processor-to-bus-ratio*2 missing\n");
+			return 1;
+		}
+
+		/* Get the min/max bus frequencies */
+		low_freq = min(freqs[0], freqs[1]);
+		hi_freq = max(freqs[0], freqs[1]);
+
+		/* Grrrr.. It _seems_ that the device-tree is lying on the low bus
+		 * frequency, it claims it to be around 84Mhz on some models while
+		 * it appears to be approx. 101Mhz on all. Let's hack around here...
+		 * fortunately, we don't need to be too precise
+		 */
+		if (low_freq < 98000000)
+			low_freq = 101000000;
+			
+		/* Convert those to CPU core clocks */
+		low_freq = (low_freq * (*ratio)) / 2000;
+		hi_freq = (hi_freq * (*ratio)) / 2000;
+
+		/* Now we get the frequencies, we read the GPIO to see what is out current
+		 * speed
+		 */
+		rc = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, frequency_gpio, 0);
+		cur_freq = (rc & 0x01) ? hi_freq : low_freq;
+
+		set_speed_proc = gpios_set_cpu_speed;
+		return 1;
+	}
+
+	/* If we use the PMU, look for the min & max frequencies in the
+	 * device-tree
+	 */
+	value = (u32 *)get_property(cpunode, "min-clock-frequency", NULL);
+	if (!value)
+		return 1;
+	low_freq = (*value) / 1000;
+	/* The PowerBook G4 12" (PowerBook6,1) has an error in the device-tree
+	 * here */
+	if (low_freq < 100000)
+		low_freq *= 10;
+
+	value = (u32 *)get_property(cpunode, "max-clock-frequency", NULL);
+	if (!value)
+		return 1;
+	hi_freq = (*value) / 1000;
+	set_speed_proc = pmu_set_cpu_speed;
+
+	return 0;
+}
+
+static int __pmac pmac_cpufreq_init_7447A(struct device_node *cpunode)
+{
+	struct device_node *volt_gpio_np;
+
+	/* OF only reports the high frequency */
+	hi_freq = cur_freq;
+	low_freq = cur_freq/2;
+	if (mfspr(HID1) & HID1_DFS)
+		cur_freq = low_freq;
+	else
+		cur_freq = hi_freq;
+
+	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
+	if (!volt_gpio_np){
+		printk(KERN_ERR "cpufreq: missing cpu-vcore-select gpio\n");
+		return 1;
+	}
+
+	u32 *reg = (u32 *)get_property(volt_gpio_np, "reg", NULL);
+	voltage_gpio = *reg;
+	set_speed_proc = dfs_set_cpu_speed;
+
+	return 0;
+}
+
 /* Currently, we support the following machines:
  *
  *  - Titanium PowerBook 1Ghz (PMU based, 667Mhz & 1Ghz)
  *  - Titanium PowerBook 800 (PMU based, 667Mhz & 800Mhz)
+ *  - Titanium PowerBook 400 (PMU based, 300Mhz & 400Mhz)
  *  - Titanium PowerBook 500 (PMU based, 300Mhz & 500Mhz)
  *  - iBook2 500 (PMU based, 400Mhz & 500Mhz)
  *  - iBook2 700 (CPU based, 400Mhz & 700Mhz, support low voltage)
- *  - Recent MacRISC3 machines
+ *  - Recent MacRISC3 laptops
+ *  - iBook G4s and PowerBook G4s with 7447A CPUs
  */
 static int __init pmac_cpufreq_setup(void)
 {
 	struct device_node	*cpunode;
 	u32			*value;
-	int			has_freq_ctl = 0;
 
 	if (strstr(cmd_line, "nocpufreq"))
 		return 0;
@@ -367,113 +521,36 @@
 		goto out;
 	cur_freq = (*value) / 1000;
 
-	/* Check for newer machines */
-	if (machine_is_compatible("PowerBook3,4") ||
-	    machine_is_compatible("PowerBook3,5") ||
-	    machine_is_compatible("MacRISC3")) {
-		struct device_node *volt_gpio_np = of_find_node_by_name(NULL, "voltage-gpio");
-		struct device_node *freq_gpio_np = of_find_node_by_name(NULL, "frequency-gpio");
-		struct device_node *slew_done_gpio_np = of_find_node_by_name(NULL, "slewing-done");
-
-		/*
-		 * Check to see if it's GPIO driven or PMU only
-		 *
-		 * The way we extract the GPIO address is slightly hackish, but it
-		 * works well enough for now. We need to abstract the whole GPIO
-		 * stuff sooner or later anyway
-		 */
-
-		if (volt_gpio_np)
-			voltage_gpio = read_gpio(volt_gpio_np);
-		if (freq_gpio_np)
-			frequency_gpio = read_gpio(freq_gpio_np);
-		if (slew_done_gpio_np)
-			slew_done_gpio = read_gpio(slew_done_gpio_np);
-
-		/* If we use the frequency GPIOs, calculate the min/max speeds based
-		 * on the bus frequencies
-		 */
-		if (frequency_gpio && slew_done_gpio) {
-			int lenp, rc;
-			u32 *freqs, *ratio;
-
-			freqs = (u32 *)get_property(cpunode, "bus-frequencies", &lenp);
-			lenp /= sizeof(u32);
-			if (freqs == NULL || lenp != 2) {
-				printk(KERN_ERR "cpufreq: bus-frequencies incorrect or missing\n");
-				goto out;
-			}
-			ratio = (u32 *)get_property(cpunode, "processor-to-bus-ratio*2", NULL);
-			if (ratio == NULL) {
-				printk(KERN_ERR "cpufreq: processor-to-bus-ratio*2 missing\n");
-				goto out;
-			}
-
-			/* Get the min/max bus frequencies */
-			low_freq = min(freqs[0], freqs[1]);
-			hi_freq = max(freqs[0], freqs[1]);
-
-			/* Grrrr.. It _seems_ that the device-tree is lying on the low bus
-			 * frequency, it claims it to be around 84Mhz on some models while
-			 * it appears to be approx. 101Mhz on all. Let's hack around here...
-			 * fortunately, we don't need to be too precise
-			 */
-			if (low_freq < 98000000)
-				low_freq = 101000000;
-			
-			/* Convert those to CPU core clocks */
-			low_freq = (low_freq * (*ratio)) / 2000;
-			hi_freq = (hi_freq * (*ratio)) / 2000;
-
-			/* Now we get the frequencies, we read the GPIO to see what is out current
-			 * speed
-			 */
-			rc = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, frequency_gpio, 0);
-			cur_freq = (rc & 0x01) ? hi_freq : low_freq;
-
-			has_freq_ctl = 1;
-			cpufreq_uses_gpios = 1;
-			goto out;
-		}
-
-		/* If we use the PMU, look for the min & max frequencies in the
-		 * device-tree
-		 */
-		value = (u32 *)get_property(cpunode, "min-clock-frequency", NULL);
-		if (!value)
-			goto out;
-		low_freq = (*value) / 1000;
-		/* The PowerBook G4 12" (PowerBook6,1) has an error in the device-tree
-		 * here */
-		if (low_freq < 100000)
-			low_freq *= 10;
-
-		value = (u32 *)get_property(cpunode, "max-clock-frequency", NULL);
-		if (!value)
-			goto out;
-		hi_freq = (*value) / 1000;
-		has_freq_ctl = 1;
-		cpufreq_uses_pmu = 1;
-	}
+	/*  Check for 7447A based iBook G4 or PowerBook */
+	if (machine_is_compatible("PowerBook6,5") ||
+	    machine_is_compatible("PowerBook6,4") ||
+	    machine_is_compatible("PowerBook5,5") ||
+	    machine_is_compatible("PowerBook5,4")) {
+		pmac_cpufreq_init_7447A(cpunode);
+	/* Check for other MacRISC3 machines */
+	} else if (machine_is_compatible("PowerBook3,4") ||
+		   machine_is_compatible("PowerBook3,5") ||
+		   machine_is_compatible("MacRISC3")) {
+		pmac_cpufreq_init_MacRISC3(cpunode);
 	/* Else check for iBook2 500 */
-	else if (machine_is_compatible("PowerBook4,1")) {
+	} else if (machine_is_compatible("PowerBook4,1")) {
 		/* We only know about 500Mhz model */
 		if (cur_freq < 450000 || cur_freq > 550000)
 			goto out;
 		hi_freq = cur_freq;
 		low_freq = 400000;
-		has_freq_ctl = 1;
-		cpufreq_uses_pmu = 1;
+		set_speed_proc = pmu_set_cpu_speed;
 	}
-	/* Else check for TiPb 500 */
+	/* Else check for TiPb 400 & 500 */
 	else if (machine_is_compatible("PowerBook3,2")) {
-		/* We only know about 500Mhz model */
-		if (cur_freq < 450000 || cur_freq > 550000)
+		/* We only know about the 400 MHz and the 500Mhz model
+		 * they both have 300 MHz as low frequency
+		 */
+		if (cur_freq < 350000 || cur_freq > 550000)
 			goto out;
 		hi_freq = cur_freq;
 		low_freq = 300000;
-		has_freq_ctl = 1;
-		cpufreq_uses_pmu = 1;
+		set_speed_proc = pmu_set_cpu_speed;
 	}
 	/* Else check for 750FX */
 	else if (PVR_VER(mfspr(PVR)) == 0x7000) {
@@ -483,21 +560,19 @@
 		value = (u32 *)get_property(cpunode, "reduced-clock-frequency", NULL);
 		if (!value)
 			goto out;
-		low_freq = (*value) / 1000;
-		cpufreq_uses_pmu = 0;
-		has_freq_ctl = 1;
+		low_freq = (*value) / 1000;		
+		set_speed_proc = cpu_750fx_cpu_speed;
 	}
 out:
-	if (!has_freq_ctl)
+	if (set_speed_proc == NULL)
 		return -ENODEV;
 
 	pmac_cpu_freqs[CPUFREQ_LOW].frequency = low_freq;
 	pmac_cpu_freqs[CPUFREQ_HIGH].frequency = hi_freq;
 
 	printk(KERN_INFO "Registering PowerMac CPU frequency driver\n");
-	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Boot: %d Mhz, switch method: %s\n",
-	       low_freq/1000, hi_freq/1000, cur_freq/1000,
-	       cpufreq_uses_pmu ? "PMU" : (cpufreq_uses_gpios ? "GPIOs" : "CPU"));
+	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Boot: %d Mhz\n",
+	       low_freq/1000, hi_freq/1000, cur_freq/1000);
 
 	return cpufreq_register_driver(&pmac_cpufreq_driver);
 }
diff -Nru a/arch/ppc/platforms/pmac_feature.c b/arch/ppc/platforms/pmac_feature.c
--- a/arch/ppc/platforms/pmac_feature.c	2004-06-22 15:04:07 -05:00
+++ b/arch/ppc/platforms/pmac_feature.c	2004-06-22 15:04:07 -05:00
@@ -1282,6 +1282,25 @@
 	return 0;
 }
 
+static long __pmac
+intrepid_aack_delay_enable(struct device_node* node, long param, long value)
+{
+	unsigned long flags;
+
+    	if (uninorth_rev < 0xd2)
+		return -ENODEV;
+
+	LOCK(flags);
+	if (param)
+		UN_BIS(UNI_N_AACK_DELAY, UNI_N_AACK_DELAY_ENABLE);
+	else
+		UN_BIC(UNI_N_AACK_DELAY, UNI_N_AACK_DELAY_ENABLE);
+	UNLOCK(flags);
+
+    	return 0;
+}
+
+
 #endif /* CONFIG_POWER4 */
 
 static long __pmac
@@ -1914,6 +1933,7 @@
 	{ PMAC_FTR_SLEEP_STATE,		core99_sleep_state },
 	{ PMAC_FTR_READ_GPIO,		core99_read_gpio },
 	{ PMAC_FTR_WRITE_GPIO,		core99_write_gpio },
+	{ PMAC_FTR_AACK_DELAY_ENABLE,	intrepid_aack_delay_enable },
 	{ 0, NULL }
 };
 
@@ -2116,6 +2136,14 @@
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook5,4",			"PowerBook G4 15\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
+	{	"PowerBook5,5",			"PowerBook G4 17\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
@@ -2125,6 +2153,10 @@
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,3",			"iBook G4",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
+	{	"PowerBook6,4",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
diff -Nru a/include/asm-ppc/pmac_feature.h b/include/asm-ppc/pmac_feature.h
--- a/include/asm-ppc/pmac_feature.h	2004-06-22 15:04:07 -05:00
+++ b/include/asm-ppc/pmac_feature.h	2004-06-22 15:04:07 -05:00
@@ -273,6 +273,12 @@
  */
 #define PMAC_FTR_ENABLE_MPIC		PMAC_FTR_DEF(19)
 
+/* PMAC_FTR_AACK_DELAY_ENABLE	(NULL, int enable, 0)
+ *
+ * Enable/disable the AACK delay on the northbridge for systems using DFS
+ */
+#define PMAC_FTR_AACK_DELAY_ENABLE     	PMAC_FTR_DEF(20)
+
 
 /* Don't use those directly, they are for the sake of pmac_setup.c */
 extern long pmac_do_feature_call(unsigned int selector, ...);
diff -Nru a/include/asm-ppc/reg.h b/include/asm-ppc/reg.h
--- a/include/asm-ppc/reg.h	2004-06-22 15:04:07 -05:00
+++ b/include/asm-ppc/reg.h	2004-06-22 15:04:07 -05:00
@@ -174,6 +174,7 @@
 
 #define SPRN_HID1	0x3F1		/* Hardware Implementation Register 1 */
 #define HID1_EMCP	(1<<31)		/* 7450 Machine Check Pin Enable */
+#define HID1_DFS	(1<<22)		/* 7447A Dynamic Frequency Scaling */
 #define HID1_PC0	(1<<16)		/* 7450 PLL_CFG[0] */
 #define HID1_PC1	(1<<15)		/* 7450 PLL_CFG[1] */
 #define HID1_PC2	(1<<14)		/* 7450 PLL_CFG[2] */
diff -Nru a/include/asm-ppc/uninorth.h b/include/asm-ppc/uninorth.h
--- a/include/asm-ppc/uninorth.h	2004-06-22 15:04:07 -05:00
+++ b/include/asm-ppc/uninorth.h	2004-06-22 15:04:07 -05:00
@@ -142,6 +142,12 @@
  */
 #define UNI_N_HWINIT_STATE_CPU1_FLAG	0x10000000
 
+/* This register controls AACK delay, which is set when 2004 iBook/PowerBook
+ * is in low speed mode.
+ */
+#define UNI_N_AACK_DELAY		0x0100
+#define UNI_N_AACK_DELAY_ENABLE		0x00000001
+
 /* Uninorth 1.5 rev. has additional perf. monitor registers at 0xf00-0xf50 */
 
 


