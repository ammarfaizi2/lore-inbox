Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbTAMOyK>; Mon, 13 Jan 2003 09:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbTAMOyK>; Mon, 13 Jan 2003 09:54:10 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:9167 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261337AbTAMOxs>; Mon, 13 Jan 2003 09:53:48 -0500
Date: Mon, 13 Jan 2003 16:02:25 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.56-bk3] cpufreq: per-CPU initialization in x86 + ACPI drivers
Message-ID: <20030113150225.GA10835@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds per-CPU initialization to a couple of cpufreq
drivers. It's a large simplification of many code paths, but
especially in the ACPI cpufreq driver.

	 Dominik

 arch/i386/kernel/cpu/cpufreq/elanfreq.c    |  104 ++++++--------
 arch/i386/kernel/cpu/cpufreq/longrun.c     |  102 ++++++--------
 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |  136 ++++++++----------
 arch/i386/kernel/cpu/cpufreq/powernow-k6.c |  122 ++++++++--------
 arch/i386/kernel/cpu/cpufreq/speedstep.c   |  130 +++++++-----------
 drivers/acpi/processor.c                   |  209 ++++++++++-------------------
 6 files changed, 359 insertions(+), 444 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-01-13 15:54:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-01-13 15:55:00.000000000 +0100
@@ -31,15 +31,11 @@
 #define REG_CSCIR 0x22 		/* Chip Setup and Control Index Register    */
 #define REG_CSCDR 0x23		/* Chip Setup and Control Data  Register    */
 
-static struct cpufreq_driver *elanfreq_driver;
+static struct cpufreq_driver elanfreq_driver;
 
 /* Module parameter */
 static int max_freq;
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Robert Schwebel <r.schwebel@pengutronix.de>, Sven Geggus <sven@geggus.net>");
-MODULE_DESCRIPTION("cpufreq driver for AMD's Elan CPUs");
-
 struct s_elan_multiplier {
 	int clock;		/* frequency in kHz                         */
 	int val40h;		/* PMU Force Mode register                  */
@@ -204,6 +200,37 @@
  *	Module init and exit code
  */
 
+static int elanfreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpuinfo_x86 *c = cpu_data;
+	unsigned int i;
+
+	/* capability check */
+	if ((c->x86_vendor != X86_VENDOR_AMD) ||
+	    (c->x86 != 4) || (c->x86_model!=10))
+		return -ENODEV;
+
+	/* max freq */
+	if (!max_freq)
+		max_freq = elanfreq_get_cpu_frequency();
+
+	/* table init */
+ 	for (i=0; (elanfreq_table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		if (elanfreq_table[i].frequency > max_freq)
+			elanfreq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+	}
+
+	/* cpuinfo and default policy values */
+	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+#ifdef CONFIG_CPU_FREQ_24_API
+	elanfreq_driver.cpu_cur_freq[policy->cpu] = elanfreq_get_cpu_frequency();
+#endif
+
+	return cpufreq_frequency_table_cpuinfo(policy, &elanfreq_table[0]);;
+}
+
+
 #ifndef MODULE
 /**
  * elanfreq_setup - elanfreq command line parameter parsing
@@ -238,63 +265,32 @@
                 return -ENODEV;
 	}
 	
-	driver = kmalloc(sizeof(struct cpufreq_driver) +
-			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
-	if (!driver)
-		return -ENOMEM;
-
-	driver->policy = (struct cpufreq_policy *) (driver + 1);
-
-	if (!max_freq)
-		max_freq = elanfreq_get_cpu_frequency();
-
-	/* table init */
- 	for (i=0; (elanfreq_table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		if (elanfreq_table[i].frequency > max_freq)
-			elanfreq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
-	}
+	return cpufreq_register_driver(driver);
+}
 
-#ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_cur_freq[0] = elanfreq_get_cpu_frequency();
-#endif
 
-	driver->verify        = &elanfreq_verify;
-	driver->setpolicy     = &elanfreq_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
-	strncpy(driver->name, "elanfrep\0", CPUFREQ_NAME_LEN);
-
-	driver->policy[0].cpu    = 0;
-	ret = cpufreq_frequency_table_cpuinfo(&driver->policy[0], &elanfreq_table[0]);
-	if (ret) {
-		kfree(driver);
-		return ret;
-	}
-	driver->policy[0].policy = CPUFREQ_POLICY_PERFORMANCE;
-	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+static void __exit elanfreq_exit(void) 
+{
+	cpufreq_unregister_driver(&elanfreq_driver);
+}
 
-	elanfreq_driver = driver;
 
-	ret = cpufreq_register(driver);
-	if (ret) {
-		elanfreq_driver = NULL;
-		kfree(driver);
-	}
+static struct cpufreq_driver elanfreq_driver = {
+	.verify 	= elanfreq_verify,
+	.setpolicy 	= elanfreq_setpolicy,
+	.init		= elanfreq_cpu_init,
+	.exit		= NULL,
+	.policy		= NULL,
+	.name		= "elanfreq",
+};
 
-	return ret;
-}
 
+MODULE_PARM (max_freq, "i");
 
-static void __exit elanfreq_exit(void) 
-{
-	if (elanfreq_driver) {
-		cpufreq_unregister();
-		kfree(elanfreq_driver);
-	}
-}
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Robert Schwebel <r.schwebel@pengutronix.de>, Sven Geggus <sven@geggus.net>");
+MODULE_DESCRIPTION("cpufreq driver for AMD's Elan CPUs");
 
 module_init(elanfreq_init);
 module_exit(elanfreq_exit);
 
-MODULE_PARM (max_freq, "i");
-
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/arch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c	2003-01-13 15:54:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	2003-01-13 15:55:00.000000000 +0100
@@ -18,7 +18,7 @@
 #include <asm/processor.h>
 #include <asm/timex.h>
 
-static struct cpufreq_driver	*longrun_driver;
+static struct cpufreq_driver	longrun_driver;
 
 /**
  * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz 
@@ -39,9 +39,6 @@
 {
 	u32 msr_lo, msr_hi;
 
-	if (!longrun_driver)
-		return;
-
 	rdmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
 	if (msr_lo & 0x01)
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
@@ -72,7 +69,7 @@
 	u32 msr_lo, msr_hi;
 	u32 pctg_lo, pctg_hi;
 
-	if (!longrun_driver || !policy)
+	if (!policy)
 		return -EINVAL;
 
 	pctg_lo = (policy->min - longrun_low_freq) / 
@@ -117,13 +114,13 @@
  */
 static int longrun_verify_policy(struct cpufreq_policy *policy)
 {
-	if (!policy || !longrun_driver)
+	if (!policy)
 		return -EINVAL;
 
 	policy->cpu = 0;
 	cpufreq_verify_within_limits(policy, 
-		longrun_driver->policy[0].cpuinfo.min_freq, 
-		longrun_driver->policy[0].cpuinfo.max_freq);
+		policy->cpuinfo.min_freq, 
+		policy->cpuinfo.max_freq);
 
 	return 0;
 }
@@ -221,58 +218,51 @@
 }
 
 
-/**
- * longrun_init - initializes the Transmeta Crusoe LongRun CPUFreq driver
- *
- * Initializes the LongRun support.
- */
-static int __init longrun_init(void)
+static int longrun_cpu_init(struct cpufreq_policy *policy)
 {
-	int                     result;
-	struct cpufreq_driver   *driver;
+	int                     result = 0;
 	struct cpuinfo_x86 *c = cpu_data;
 
+	/* capability check */
+	if (policy->cpu != 0)
+		return -ENODEV;
 	if (c->x86_vendor != X86_VENDOR_TRANSMETA || 
 	    !cpu_has(c, X86_FEATURE_LONGRUN))
-		return 0;
-
-	/* initialization of main "cpufreq" code*/
-	driver = kmalloc(sizeof(struct cpufreq_driver) + 
-			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
-	if (!driver)
-		return -ENOMEM;
-
-	driver->policy = (struct cpufreq_policy *) (driver + 1);
-
-	if (longrun_determine_freqs(&longrun_low_freq, &longrun_high_freq)) {
-		kfree(driver);
-		return -EIO;
-	}
-	driver->policy[0].cpuinfo.min_freq = longrun_low_freq;
-	driver->policy[0].cpuinfo.max_freq = longrun_high_freq;
-	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	driver->init = NULL;
-	driver->exit = NULL;
-	strncpy(driver->name, "longrun\0", CPUFREQ_NAME_LEN);
-
-	longrun_get_policy(&driver->policy[0]);
+		return -ENODEV;
 
+	/* detect low and high frequency */
+	result = longrun_determine_freqs(&longrun_low_freq, &longrun_high_freq);
+	if (result)
+		return result;
+
+	/* cpuinfo and default policy values */
+	policy->cpuinfo.min_freq = longrun_low_freq;
+	policy->cpuinfo.max_freq = longrun_high_freq;
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	longrun_get_policy(policy);
+	
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_cur_freq[0] = longrun_high_freq; /* dummy value */
+	longrun_driver.cpu_cur_freq[policy->cpu] = longrun_low_freq; /* dummy value */
 #endif
 
-	driver->verify         = &longrun_verify_policy;
-	driver->setpolicy      = &longrun_set_policy;
+	return 0;
+}
 
-	longrun_driver = driver;
 
-	result = cpufreq_register(driver);
-	if (result) {
-		longrun_driver = NULL;
-		kfree(driver);
-	}
+/**
+ * longrun_init - initializes the Transmeta Crusoe LongRun CPUFreq driver
+ *
+ * Initializes the LongRun support.
+ */
+static int __init longrun_init(void)
+{
+	struct cpuinfo_x86 *c = cpu_data;
+
+	if (c->x86_vendor != X86_VENDOR_TRANSMETA || 
+	    !cpu_has(c, X86_FEATURE_LONGRUN))
+		return -ENODEV;
 
-	return result;
+	return cpufreq_register_driver(&longrun_driver);
 }
 
 
@@ -281,15 +271,23 @@
  */
 static void __exit longrun_exit(void)
 {
-	if (longrun_driver) {
-		cpufreq_unregister();
-		kfree(longrun_driver);
-	}
+	cpufreq_unregister_driver(&longrun_driver);
 }
 
 
+static struct cpufreq_driver longrun_driver = {
+	.verify 	= longrun_verify_policy,
+	.setpolicy 	= longrun_set_policy,
+	.init		= longrun_cpu_init,
+	.exit		= NULL,
+	.policy		= NULL,
+	.name		= "longrun",
+};
+
+
 MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION ("LongRun driver for Transmeta Crusoe processors.");
 MODULE_LICENSE ("GPL");
+
 module_init(longrun_init);
 module_exit(longrun_exit);
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-13 15:54:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-13 15:55:00.000000000 +0100
@@ -45,11 +45,11 @@
 #define DC_ENTRIES	8
 
 
-static int has_N44_O17_errata;
+static int has_N44_O17_errata[NR_CPUS];
 static int stock_freq;
 MODULE_PARM(stock_freq, "i");
 
-static struct cpufreq_driver *cpufreq_p4_driver;
+static struct cpufreq_driver p4clockmod_driver;
 
 
 static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
@@ -109,7 +109,7 @@
 	if (l & 0x01)
 		printk(KERN_DEBUG PFX "CPU#%d currently thermal throttled\n", cpu);
 
-	if (has_N44_O17_errata && (newstate == DC_25PT || newstate == DC_DFLT))
+	if (has_N44_O17_errata[cpu] && (newstate == DC_25PT || newstate == DC_DFLT))
 		newstate = DC_38PT;
 
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
@@ -174,39 +174,30 @@
 }
 
 
-static int __init cpufreq_p4_init(void)
-{	
-	struct cpuinfo_x86 *c = cpu_data;
-	int cpuid;
-	int ret;
-	struct cpufreq_driver *driver;
+static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpuinfo_x86 *c = &cpu_data[policy->cpu];
+	int cpuid = 0;
 	unsigned int i;
 
-	/*
-	 * THERM_CONTROL is architectural for IA32 now, so 
-	 * we can rely on the capability checks
-	 */
+	/* capability check */
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return -ENODEV;
-
 	if (!test_bit(X86_FEATURE_ACPI, c->x86_capability) ||
-		!test_bit(X86_FEATURE_ACC, c->x86_capability))
+	    !test_bit(X86_FEATURE_ACC, c->x86_capability))
 		return -ENODEV;
-
-	/* Errata workarounds */
+	
+	/* Errata workaround */
 	cpuid = (c->x86 << 8) | (c->x86_model << 4) | c->x86_mask;
 	switch (cpuid) {
-		case 0x0f07:
-		case 0x0f0a:
-		case 0x0f11:
-		case 0x0f12:
-			has_N44_O17_errata = 1;
-		default:
-			break;
+	case 0x0f07:
+	case 0x0f0a:
+	case 0x0f11:
+	case 0x0f12:
+		has_N44_O17_errata[policy->cpu] = 1;
 	}
-
-	printk(KERN_INFO PFX "P4/Xeon(TM) CPU On-Demand Clock Modulation available\n");
-
+	
+	/* get frequency */
 	if (!stock_freq) {
 		if (cpu_khz)
 			stock_freq = cpu_khz;
@@ -216,71 +207,70 @@
 		}
 	}
 
-	driver = kmalloc(sizeof(struct cpufreq_driver) +
-			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
-	if (!driver)
-		return -ENOMEM;
-
-	driver->policy = (struct cpufreq_policy *) (driver + 1);
-
 	/* table init */
 	for (i=1; (p4clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		if ((i<2) && (has_N44_O17_errata))
+		if ((i<2) && (has_N44_O17_errata[policy->cpu]))
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;
 	}
 	
-
+	/* cpuinfo and default policy values */
+	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 #ifdef CONFIG_CPU_FREQ_24_API
-	for (i=0;i<NR_CPUS;i++) {
-		driver->cpu_cur_freq[i] = stock_freq;
-	}
+	p4clockmod_driver.cpu_cur_freq[policy->cpu] = stock_freq;
 #endif
 
-	driver->verify        = &cpufreq_p4_verify;
-	driver->setpolicy     = &cpufreq_p4_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
-	strncpy(driver->name, "p4-clockmod\0", CPUFREQ_NAME_LEN);
-
-	for (i=0;i<NR_CPUS;i++) {
-		driver->policy[i].cpu    = i;
-		ret = cpufreq_frequency_table_cpuinfo(&driver->policy[i], &p4clockmod_table[0]);
-		if (ret) {
-			kfree(driver);
-			return ret;
-		}
-		driver->policy[i].policy = CPUFREQ_POLICY_PERFORMANCE;
-		driver->policy[i].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	}
+	return cpufreq_frequency_table_cpuinfo(policy, &p4clockmod_table[0]);
+}
 
-	cpufreq_p4_driver = driver;
-	
-	ret = cpufreq_register(driver);
-	if (ret) {
-		cpufreq_p4_driver = NULL;
-		kfree(driver);
-	}
 
-	return ret;
+static int cpufreq_p4_cpu_exit(struct cpufreq_policy *policy)
+{
+	return cpufreq_p4_setdc(policy->cpu, DC_DISABLE);
+}
+
+
+static int __init cpufreq_p4_init(void)
+{	
+	struct cpuinfo_x86 *c = cpu_data;
+
+	/*
+	 * THERM_CONTROL is architectural for IA32 now, so 
+	 * we can rely on the capability checks
+	 */
+	if (c->x86_vendor != X86_VENDOR_INTEL)
+		return -ENODEV;
+
+	if (!test_bit(X86_FEATURE_ACPI, c->x86_capability) ||
+		!test_bit(X86_FEATURE_ACC, c->x86_capability))
+		return -ENODEV;
+
+	printk(KERN_INFO PFX "P4/Xeon(TM) CPU On-Demand Clock Modulation available\n");
+
+	return cpufreq_register_driver(&p4clockmod_driver);
 }
 
 
 static void __exit cpufreq_p4_exit(void)
 {
-	unsigned int i;
-
-	if (cpufreq_p4_driver) {
-		for (i=0; i<NR_CPUS; i++) {
-			if (cpu_online(i)) 
-				cpufreq_p4_setdc(i, DC_DISABLE);
-		}
-		cpufreq_unregister();
-		kfree(cpufreq_p4_driver);
-	}
+	cpufreq_unregister_driver(&p4clockmod_driver);
 }
 
+
+static struct cpufreq_driver p4clockmod_driver = {
+	.verify 	= cpufreq_p4_verify,
+	.setpolicy 	= cpufreq_p4_setpolicy,
+	.init		= cpufreq_p4_cpu_init,
+	.exit		= cpufreq_p4_cpu_exit,
+	.policy		= NULL,
+	.name		= "p4-clockmod",
+};
+
+
+MODULE_PARM(stock_freq, "i");
+
 MODULE_AUTHOR ("Zwane Mwaikambo <zwane@commfireservices.com>");
 MODULE_DESCRIPTION ("cpufreq driver for Pentium(TM) 4/Xeon(TM)");
 MODULE_LICENSE ("GPL");
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-01-13 15:54:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-01-13 15:55:00.000000000 +0100
@@ -25,7 +25,7 @@
 #define POWERNOW_IOPORT 0xfff0         /* it doesn't matter where, as long
 					  as it is unused */
 
-static struct cpufreq_driver		*powernow_driver;
+static struct cpufreq_driver		powernow_k6_driver;
 static unsigned int                     busfreq;   /* FSB, in 10 kHz */
 static unsigned int                     max_multiplier;
 
@@ -77,8 +77,8 @@
 	unsigned long           msrval;
 	struct cpufreq_freqs    freqs;
 
-	if (!powernow_driver) {
-		printk(KERN_ERR "cpufreq: initialization problem or invalid target frequency\n");
+	if (clock_ratio[best_i].index > max_multiplier) {
+		printk(KERN_ERR "cpufreq: invalid target frequency\n");
 		return;
 	}
 
@@ -139,41 +139,22 @@
 }
 
 
-/**
- * powernow_k6_init - initializes the k6 PowerNow! CPUFreq driver
- *
- *   Initializes the K6 PowerNow! support. Returns -ENODEV on unsupported
- * devices, -EINVAL or -ENOMEM on problems during initiatization, and zero
- * on success.
- */
-static int __init powernow_k6_init(void)
-{	
-	struct cpuinfo_x86      *c = cpu_data;
-	struct cpufreq_driver   *driver;
-	unsigned int            result;
-	unsigned int            i;
+static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpuinfo_x86 *c = cpu_data;
+	unsigned int i;
 
+	/* capability check */
 	if ((c->x86_vendor != X86_VENDOR_AMD) || (c->x86 != 5) ||
-		((c->x86_model != 12) && (c->x86_model != 13)))
+	    ((c->x86_model != 12) && (c->x86_model != 13)))
+		return -ENODEV;
+	if (policy->cpu != 0)
 		return -ENODEV;
 
+	/* get frequencies */
 	max_multiplier = powernow_k6_get_cpu_multiplier();
 	busfreq = cpu_khz / max_multiplier;
 
-	if (!request_region(POWERNOW_IOPORT, 16, "PowerNow!")) {
-		printk("cpufreq: PowerNow IOPORT region already used.\n");
-		return -EIO;
-	}
-
-	/* initialization of main "cpufreq" code*/
-	driver = kmalloc(sizeof(struct cpufreq_driver) +
-			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
-	if (!driver) {
-		release_region (POWERNOW_IOPORT, 16);
-		return -ENOMEM;
-	}
-	driver->policy = (struct cpufreq_policy *) (driver + 1);
-
 	/* table init */
  	for (i=0; (clock_ratio[i].frequency != CPUFREQ_TABLE_END); i++) {
 		if (clock_ratio[i].index > max_multiplier)
@@ -182,35 +163,52 @@
 			clock_ratio[i].frequency = busfreq * clock_ratio[i].index;
 	}
 
-	driver->verify        = &powernow_k6_verify;
-	driver->setpolicy     = &powernow_k6_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
-	strncpy(driver->name, "powernow-k6\0", CPUFREQ_NAME_LEN);
-
 	/* cpuinfo and default policy values */
-	driver->policy[0].cpu    = 0;
-	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	driver->policy[0].policy = CPUFREQ_POLICY_PERFORMANCE;
+	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_cur_freq[0]  = busfreq * max_multiplier;
+	powernow_k6_driver.cpu_cur_freq[policy->cpu] = busfreq * max_multiplier;
 #endif
-	result = cpufreq_frequency_table_cpuinfo(&driver->policy[0], &clock_ratio[0]);
-	if (result) {
-		kfree(driver);
-		return result;
+
+	return cpufreq_frequency_table_cpuinfo(policy, &clock_ratio[0]);
+}
+
+static int powernow_k6_cpu_exit(struct cpufreq_policy *policy)
+{
+	unsigned int i;
+	for (i=0; i<8; i++) {
+		if (i==max_multiplier)
+			powernow_k6_set_state(i);
 	}
+	return 0;
+}
 
-	powernow_driver = driver;
+/**
+ * powernow_k6_init - initializes the k6 PowerNow! CPUFreq driver
+ *
+ *   Initializes the K6 PowerNow! support. Returns -ENODEV on unsupported
+ * devices, -EINVAL or -ENOMEM on problems during initiatization, and zero
+ * on success.
+ */
+static int __init powernow_k6_init(void)
+{	
+	struct cpuinfo_x86      *c = cpu_data;
+
+	if ((c->x86_vendor != X86_VENDOR_AMD) || (c->x86 != 5) ||
+		((c->x86_model != 12) && (c->x86_model != 13)))
+		return -ENODEV;
 
-	result = cpufreq_register(driver);
-	if (result) {
+	if (!request_region(POWERNOW_IOPORT, 16, "PowerNow!")) {
+		printk("cpufreq: PowerNow IOPORT region already used.\n");
+		return -EIO;
+	}
+
+	if (cpufreq_register_driver(&powernow_k6_driver)) {
 		release_region (POWERNOW_IOPORT, 16);
-		powernow_driver = NULL;
-		kfree(driver);
+		return -EINVAL;
 	}
 
-	return result;
+	return 0;
 }
 
 
@@ -221,20 +219,24 @@
  */
 static void __exit powernow_k6_exit(void)
 {
-	unsigned int i;
-
-	if (powernow_driver) {
-		for (i=0;i<8;i++)
-			if (clock_ratio[i].index == max_multiplier)
-				powernow_k6_set_state(i);		
-		cpufreq_unregister();
-		kfree(powernow_driver);
-	}
+	cpufreq_unregister_driver(&powernow_k6_driver);
+	release_region (POWERNOW_IOPORT, 16);
 }
 
 
+static struct cpufreq_driver powernow_k6_driver = {
+	.verify 	= powernow_k6_verify,
+	.setpolicy 	= powernow_k6_setpolicy,
+	.init		= powernow_k6_cpu_init,
+	.exit		= powernow_k6_cpu_exit,
+	.policy		= NULL,
+	.name		= "powernow-k6",
+};
+
+
 MODULE_AUTHOR ("Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@suse.de>, Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION ("PowerNow! driver for AMD K6-2+ / K6-3+ processors.");
 MODULE_LICENSE ("GPL");
+
 module_init(powernow_k6_init);
 module_exit(powernow_k6_exit);
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-13 15:54:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-13 15:55:00.000000000 +0100
@@ -30,7 +30,7 @@
 #include <asm/msr.h>
 
 
-static struct cpufreq_driver		*speedstep_driver;
+static struct cpufreq_driver		speedstep_driver;
 
 /* speedstep_chipset:
  *   It is necessary to know which chipset is used. As accesses to 
@@ -599,6 +599,42 @@
 }
 
 
+static int speedstep_cpu_init(struct cpufreq_policy *policy)
+{
+	int		result = 0;
+	unsigned int	speed;
+
+	/* capability check */
+	if (policy->cpu != 0)
+		return -ENODEV;
+
+	/* detect low and high frequency */
+	result = speedstep_detect_speeds();
+	if (result)
+		return result;
+
+	/* get current speed setting */
+	result = speedstep_get_state(&speed);
+	if (result)
+		return result;
+
+	speed = (speed == SPEEDSTEP_LOW) ? speedstep_low_freq : speedstep_high_freq;
+	dprintk(KERN_INFO "cpufreq: currently at %s speed setting - %i MHz\n", 
+		(speed == speedstep_low_freq) ? "low" : "high",
+		(speed / 1000));
+
+	/* cpuinfo and default policy values */
+	policy->policy = (speed == speedstep_low_freq) ? 
+		CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+#ifdef CONFIG_CPU_FREQ_24_API
+	speedstep_driver.cpu_cur_freq[policy->cpu] = speed;
+#endif
+
+	return cpufreq_frequency_table_cpuinfo(policy, &speedstep_freqs[0]);
+}
+
+
 #ifndef MODULE
 /**
  * speedstep_setup  speedstep command line parameter parsing
@@ -627,11 +663,6 @@
  */
 static int __init speedstep_init(void)
 {
-	int                     result;
-	unsigned int            speed;
-	struct cpufreq_driver   *driver;
-
-
 	/* detect chipset */
 	speedstep_chipset = speedstep_detect_chipset(); 
 
@@ -640,74 +671,17 @@
 		speedstep_processor = speedstep_detect_processor();
 
 	if ((!speedstep_chipset) || (!speedstep_processor)) {
-		printk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet) available.\n", speedstep_chipset ? "processor" : "chipset");
+		dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet) available.\n", speedstep_chipset ? "processor" : "chipset");
 		return -ENODEV;
 	}
 
 	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.58 $\n");
-	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n", 
-	       speedstep_chipset, speedstep_processor);
-
-	/* activate speedstep support */
-	result = speedstep_activate();
-	if (result)
-		return result;
 
-	/* detect low and high frequency */
-	result = speedstep_detect_speeds();
-	if (result)
-		return result;
-
-	/* get current speed setting */
-	result = speedstep_get_state(&speed);
-	if (result)
-		return result;
-
-	speed = (speed == SPEEDSTEP_LOW) ? speedstep_low_freq : speedstep_high_freq;
-
-	dprintk(KERN_INFO "cpufreq: currently at %s speed setting - %i MHz\n", 
-	       (speed == speedstep_low_freq) ? "low" : "high",
-	       (speed / 1000));
-
-	/* initialization of main "cpufreq" code*/
-	driver = kmalloc(sizeof(struct cpufreq_driver) + 
-			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
-	if (!driver)
-		return -ENOMEM;
-
-	driver->policy = (struct cpufreq_policy *) (driver + 1);
-
-	driver->policy[0].cpu    = 0;
-	result = cpufreq_frequency_table_cpuinfo(&driver->policy[0], &speedstep_freqs[0]);
-	if (result) {
-		kfree(driver);
-		return result;
-	}
-
-#ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_cur_freq[0] = speed;
-#endif
-
-	driver->verify      = &speedstep_verify;
-	driver->setpolicy   = &speedstep_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
-	strncpy(driver->name, "speedstep\0", CPUFREQ_NAME_LEN);
-
-	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-
-	driver->policy[0].policy = (speed == speedstep_low_freq) ? 
-	    CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
-
-	speedstep_driver = driver;
-
-	result = cpufreq_register(driver);
-	if (result) {
-		speedstep_driver = NULL;
-		kfree(driver);
-	}
+	/* activate speedstep support on chipset */
+	if (speedstep_activate())
+		return -EINVAL;
 
-	return result;
+	return cpufreq_register_driver(&speedstep_driver);
 }
 
 
@@ -718,17 +692,25 @@
  */
 static void __exit speedstep_exit(void)
 {
-	if (speedstep_driver) {
-		cpufreq_unregister();
-		kfree(speedstep_driver);
-	}
+	cpufreq_unregister_driver(&speedstep_driver);
 }
 
 
+static struct cpufreq_driver speedstep_driver = {
+	.verify 	= speedstep_verify,
+	.setpolicy 	= speedstep_setpolicy,
+	.init		= speedstep_cpu_init,
+	.exit		= NULL,
+	.policy		= NULL,
+	.name		= "speedstep",
+};
+
+
+MODULE_PARM (speedstep_coppermine, "i");
+
 MODULE_AUTHOR ("Dave Jones <davej@suse.de>, Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION ("Speedstep driver for Intel mobile processors.");
 MODULE_LICENSE ("GPL");
+
 module_init(speedstep_init);
 module_exit(speedstep_exit);
-
-MODULE_PARM (speedstep_coppermine, "i");
diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2003-01-13 15:54:11.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-01-13 15:55:00.000000000 +0100
@@ -166,6 +166,9 @@
 	u16			status_register;
 	int			state_count;
 	struct acpi_processor_px states[ACPI_PROCESSOR_MAX_PERFORMANCE];
+#ifdef CONFIG_ACPI_PROCESSOR_PERF
+	struct cpufreq_frequency_table freq_table[ACPI_PROCESSOR_MAX_PERFORMANCE];
+#endif
 };
 
 
@@ -263,8 +266,8 @@
 static void (*pm_idle_save)(void) = NULL;
 
 #ifdef CONFIG_ACPI_PROCESSOR_PERF
-static unsigned int cpufreq_usage_count = 0;
-static struct cpufreq_driver *acpi_cpufreq_driver;
+static unsigned int cpufreq_usage = 0;
+static struct cpufreq_driver acpi_cpufreq_driver;
 static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file);
 static struct file_operations acpi_processor_perf_fops = {
 	.open 		= acpi_processor_perf_open_fs,
@@ -1658,7 +1661,6 @@
 acpi_cpufreq_setpolicy (
 	struct cpufreq_policy   *policy)
 {
-	unsigned int i = 0;
 	struct acpi_processor *pr = NULL;
 	unsigned int next_state = 0;
 	unsigned int result = 0;
@@ -1672,33 +1674,12 @@
 	if (!pr)
 		return_VALUE(-EINVAL);
 
-	/* select appropriate P-State */
-	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
-	{
-		for (i=(pr->performance.state_count - 1); i>= pr->limit.state.px; i--)
-		{
-			unsigned int state_freq = pr->performance.states[i].core_frequency * 1000;
-			if ((policy->min <= state_freq) &&
-			    (policy->max >= state_freq)) 
-			{
-				next_state = i;
-				break;
-			}
-		}
-	} else {
-		for (i=pr->limit.state.px; i < pr->performance.state_count; i++)
-		{
-			unsigned int state_freq = pr->performance.states[i].core_frequency * 1000;
-			if ((policy->min <= state_freq) &&
-			    (policy->max >= state_freq)) 
-			{
-				next_state = i;
-				break;
-			}
-		}
-	}
+	result = cpufreq_frequency_table_setpolicy(policy, 
+			&pr->performance.freq_table[pr->limit.state.px], 
+			&next_state);
+	if (result)
+		return_VALUE(result);
 
-	/* set one or all CPUs to the new state */
 	result = acpi_processor_set_performance (pr, next_state);
 
 	return_VALUE(result);
@@ -1709,10 +1690,8 @@
 acpi_cpufreq_verify (
 	struct cpufreq_policy   *policy)
 {
-	unsigned int i = 0;
 	struct acpi_processor *pr = NULL;
-	unsigned int number_states = 0;
-	unsigned int next_larger_state = 0;
+	unsigned int result = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_verify");
 
@@ -1723,55 +1702,75 @@
 	if (!pr)
 		return_VALUE(-EINVAL);
 
-	/* first check if min and max are within valid limits */
+	result = cpufreq_frequency_table_verify(policy, 
+			&pr->performance.freq_table[pr->limit.state.px]);
+
 	cpufreq_verify_within_limits(
 		policy, 
 		pr->performance.states[pr->performance.state_count - 1].core_frequency * 1000,
 		pr->performance.states[pr->limit.state.px].core_frequency * 1000);
 
-	/* now check if at least one value is within this limit */
-	for (i=pr->limit.state.px; i < pr->performance.state_count; i++)
-	{
-		unsigned int state_freq = pr->performance.states[i].core_frequency * 1000;
-		if ((policy->min <= state_freq) &&
-		    (policy->max >= state_freq))
-			number_states++;
-		if (state_freq > policy->max)
-			next_larger_state = i;
+	return_VALUE(result);
+}
+
+
+static int
+acpi_cpufreq_cpu_init (
+	struct cpufreq_policy   *policy)
+{
+	unsigned int		i;
+	struct acpi_processor  *pr = NULL;
+	unsigned int		result = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_cpufreq_cpu_init");
+
+	pr = processors[policy->cpu];
+	if (!pr)
+		return_VALUE(-EINVAL);
+
+	/* capability check */
+	if (!pr->flags.performance)
+		return_VALUE(-ENODEV);
+
+	/* detect transition latency */
+	policy->cpuinfo.transition_latency = 0;
+	for (i=0;i<pr->performance.state_count;i++) {
+		if (pr->performance.states[i].transition_latency > policy->cpuinfo.transition_latency)
+			policy->cpuinfo.transition_latency = pr->performance.states[i].transition_latency;
 	}
+	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 
-	if (!number_states) {
-		/* round up now */
-		policy->max = pr->performance.states[next_larger_state].core_frequency * 1000;
+	/* table init */
+	for (i=0; i<=pr->performance.state_count; i++)
+	{
+		pr->performance.freq_table[i].index = i;
+		if (i<pr->performance.state_count)
+			pr->performance.freq_table[i].frequency = pr->performance.states[i].core_frequency * 1000;
+		else
+			pr->performance.freq_table[i].frequency = CPUFREQ_TABLE_END;
 	}
 
-	cpufreq_verify_within_limits(
-		policy, 
-		pr->performance.states[pr->performance.state_count - 1].core_frequency * 1000,
-		pr->performance.states[pr->limit.state.px].core_frequency * 1000);
+#ifdef CONFIG_CPU_FREQ_24_API
+	acpi_cpufreq_driver.cpu_cur_freq[policy->cpu] = pr->performance.states[pr->limit.state.px].core_frequency * 1000;
+#endif
 
-	return_VALUE(0);
+	result = cpufreq_frequency_table_cpuinfo(policy, &pr->performance.freq_table[0]);
+
+	return_VALUE(result);
 }
 
+
 static int
 acpi_cpufreq_init (
 	struct acpi_processor   *pr)
 {
 	int                     result = 0;
-	int                     i = 0;
 	int                     current_state = 0;
-	struct cpufreq_driver   *driver;
 
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_init");
 
-	if (!pr->flags.performance)
-		return_VALUE(0);
-
-	if (cpufreq_usage_count) {
-		if (pr->flags.performance == 1)
-			cpufreq_usage_count++;
+	if (!pr->flags.performance || cpufreq_usage)
 		return_VALUE(0);
-	}
 
 	/* test if it works */
 	current_state = pr->performance.state;
@@ -1801,97 +1800,44 @@
 		}
 	}
 
-	/* initialization of main "cpufreq" code*/
-	driver = kmalloc(sizeof(struct cpufreq_driver) + 
-			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
-	if (!driver)
-		return_VALUE(-ENOMEM);
-
-	driver->policy = (struct cpufreq_policy *) (driver + 1);
-
-#ifdef CONFIG_CPU_FREQ_24_API
-	for (i=0;i<NR_CPUS;i++) {
-		driver->cpu_cur_freq[0] = pr->performance.states[current_state].core_frequency * 1000;
-	}
-#endif
-
-	/* detect highest transition latency */
-	for (i=0;i<pr->performance.state_count;i++) {
-		if (pr->performance.states[i].transition_latency > driver->policy[0].cpuinfo.transition_latency)
-			driver->policy[0].cpuinfo.transition_latency = pr->performance.states[i].transition_latency;
-	}
-
-	driver->verify      = &acpi_cpufreq_verify;
-	driver->setpolicy   = &acpi_cpufreq_setpolicy;
-	driver->init        = NULL;
-	driver->exit        = NULL;
-	strncpy(driver->name, "acpi-processor\0", CPUFREQ_NAME_LEN);
-
-	for (i=0;i<NR_CPUS;i++) {
-		driver->policy[i].cpu    = pr->id;
-		driver->policy[i].min    = pr->performance.states[pr->performance.state_count - 1].core_frequency * 1000;
-		driver->policy[i].max    = pr->performance.states[pr->limit.state.px].core_frequency * 1000;
-		driver->policy[i].cpuinfo.max_freq = pr->performance.states[0].core_frequency * 1000;
-		driver->policy[i].cpuinfo.min_freq = pr->performance.states[pr->performance.state_count - 1].core_frequency * 1000;
-		driver->policy[i].cpuinfo.transition_latency = driver->policy[0].cpuinfo.transition_latency;
-		driver->policy[i].policy = ( pr->performance.states[current_state].core_frequency * 1000 == driver->policy[i].max) ? 
-			CPUFREQ_POLICY_PERFORMANCE : CPUFREQ_POLICY_POWERSAVE;
-	}
-
-	acpi_cpufreq_driver = driver;
-	result = cpufreq_register(driver);
+	/* register driver */
+	result = cpufreq_register_driver(&acpi_cpufreq_driver);
 	if (result) {
-		kfree(driver);
-		acpi_cpufreq_driver = NULL;
+		pr->flags.performance = 0;
 		return_VALUE(result);
 	}
 
-	cpufreq_usage_count++;
-
+	cpufreq_usage = 1;
 	return_VALUE(0);
 }
 
 static int
-acpi_cpufreq_exit (
-	struct acpi_processor   *pr)
+acpi_cpufreq_exit (void)
 {
 	int                     result = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_exit");
 
-	if (!pr)
-		return_VALUE(-EINVAL);
-
-	if (pr->flags.performance)
-		cpufreq_usage_count--;
-
-	if (!cpufreq_usage_count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
-			"Removing cpufreq driver\n"));
-		result = cpufreq_unregister();
-	}
+	result = cpufreq_unregister_driver(&acpi_cpufreq_driver);
 
 	return_VALUE(result);
 }
-#else
-static int
-acpi_cpufreq_init (
-	struct acpi_processor   *pr)
-{
-	ACPI_FUNCTION_TRACE("acpi_cpufreq_init_dummy");
-	return_VALUE(0);
-}
 
+static struct cpufreq_driver acpi_cpufreq_driver = {
+	.verify 	= acpi_cpufreq_verify,
+	.setpolicy 	= acpi_cpufreq_setpolicy,
+	.init		= acpi_cpufreq_cpu_init,
+	.exit		= NULL,
+	.policy		= NULL,
+	.name		= "acpi-processor",
+};
 
-static int
-acpi_cpufreq_exit (
-	struct acpi_processor   *pr)
-{
-	ACPI_FUNCTION_TRACE("acpi_cpufreq_exit_dummy");
-	return_VALUE(0);
-}
+#else
+#define acpi_cpufreq_init(x) do {} while(0)
+#define acpi_cpufreq_exit()  do {} while(0)
 #endif
 
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -2554,7 +2500,6 @@
 		return_VALUE(-ENODEV);
 	}
 
-	acpi_cpufreq_exit(pr);
 	acpi_processor_remove_fs(device);
 
 	processors[pr->id] = NULL;
@@ -2594,6 +2539,8 @@
 {
 	ACPI_FUNCTION_TRACE("acpi_processor_exit");
 
+	acpi_cpufreq_exit();
+
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
