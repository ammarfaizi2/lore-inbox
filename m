Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTBPMfV>; Sun, 16 Feb 2003 07:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbTBPMfV>; Sun, 16 Feb 2003 07:35:21 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:39365 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266638AbTBPMfM>; Sun, 16 Feb 2003 07:35:12 -0500
Date: Sun, 16 Feb 2003 13:43:38 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq: Intel SpeedStep driver update & cleanup (Petri Koistinen)
Message-ID: <20030216124338.GC28689@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- switch the x86 Intel speedstep driver to use the advanced
	cpufreq_driver registration process
- cleanups
- spelling fixes (Petri Koistinen) - thanks!

	Dominik

 speedstep.c |  145 ++++++++++++++++++++++++++----------------------------------
 1 files changed, 64 insertions(+), 81 deletions(-)

diff -ru linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-02-16 09:28:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-02-16 09:57:18.000000000 +0100
@@ -1,8 +1,8 @@
 /*
- *  $Id: speedstep.c,v 1.58 2002/11/11 15:35:46 db Exp $
+ *  $Id: speedstep.c,v 1.68 2003/01/20 17:31:47 db Exp $
  *
  * (C) 2001  Dave Jones, Arjan van de ven.
- * (C) 2002  Dominik Brodowski <linux@brodo.de>
+ * (C) 2002 - 2003  Dominik Brodowski <linux@brodo.de>
  *
  *  Licensed under the terms of the GNU GPL License version 2.
  *  Based upon reverse engineered information, and on Intel documentation
@@ -30,7 +30,7 @@
 #include <asm/msr.h>
 
 
-static struct cpufreq_driver		*speedstep_driver;
+static struct cpufreq_driver		speedstep_driver;
 
 /* speedstep_chipset:
  *   It is necessary to know which chipset is used. As accesses to 
@@ -208,7 +208,7 @@
 		pm2_blk &= 0xfe;
 		outb(pm2_blk, (pmbase + 0x20));
 
-		/* check if transition was sucessful */
+		/* check if transition was successful */
 		value = inb(pmbase + 0x50);
 
 		/* Enable IRQs */
@@ -217,7 +217,7 @@
 		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
 
 		if (state == (value & 0x1)) {
-			dprintk (KERN_INFO "cpufreq: change to %u MHz succeded\n", (freqs.new / 1000));
+			dprintk (KERN_INFO "cpufreq: change to %u MHz succeeded\n", (freqs.new / 1000));
 		} else {
 			printk (KERN_ERR "cpufreq: change failed - I/O error\n");
 		}
@@ -311,7 +311,7 @@
 			
 		pci_read_config_byte(hostbridge, PCI_REVISION_ID, &rev);
 		if (rev < 5) {
-			dprintk(KERN_INFO "cpufreq: hostbrige does not support speedstep\n");
+			dprintk(KERN_INFO "cpufreq: hostbridge does not support speedstep\n");
 			speedstep_chipset_dev = NULL;
 			return 0;
 		}
@@ -573,11 +573,13 @@
  *
  * Sets a new CPUFreq policy.
  */
-static int speedstep_setpolicy (struct cpufreq_policy *policy)
+static int speedstep_target (struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
 {
 	unsigned int    newstate = 0;
 
-	if (cpufreq_frequency_table_setpolicy(policy, &speedstep_freqs[0], &newstate))
+	if (cpufreq_frequency_table_target(policy, &speedstep_freqs[0], target_freq, relation, &newstate))
 		return -EINVAL;
 
 	speedstep_set_state(newstate, 1);
@@ -599,6 +601,42 @@
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
@@ -608,7 +646,7 @@
  * if the CPU in your notebook is a SpeedStep-capable Intel
  * Pentium III Coppermine. These processors cannot be detected
  * automatically, as Intel continues to consider the detection 
- * alogrithm as proprietary material.
+ * algorithm as proprietary material.
  */
 static int __init speedstep_setup(char *str)
 {
@@ -618,6 +656,15 @@
 __setup("speedstep_coppermine=", speedstep_setup);
 #endif
 
+
+static struct cpufreq_driver speedstep_driver = {
+	.name		= "speedstep",
+	.verify 	= speedstep_verify,
+	.target 	= speedstep_target,
+	.init		= speedstep_cpu_init,
+};
+
+
 /**
  * speedstep_init - initializes the SpeedStep CPUFreq driver
  *
@@ -627,11 +674,6 @@
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
 
@@ -644,70 +686,13 @@
 		return -ENODEV;
 	}
 
-	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.58 $\n");
-	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n", 
-	       speedstep_chipset, speedstep_processor);
+	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.68 $\n");
 
 	/* activate speedstep support */
-	result = speedstep_activate();
-	if (result)
-		return result;
-
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
-	memset(driver, 0, sizeof(struct cpufreq_driver) +
-			NR_CPUS * sizeof(struct cpufreq_policy));
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
-	strncpy(driver->name, "speedstep", CPUFREQ_NAME_LEN);
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
+	if (speedstep_activate())
+		return -EINVAL;
 
-	return result;
+	return cpufreq_register_driver(&speedstep_driver);
 }
 
 
@@ -718,17 +703,15 @@
  */
 static void __exit speedstep_exit(void)
 {
-	if (speedstep_driver) {
-		cpufreq_unregister();
-		kfree(speedstep_driver);
-	}
+	cpufreq_unregister_driver(&speedstep_driver);
 }
 
 
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
