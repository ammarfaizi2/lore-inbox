Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271719AbTG2NQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271728AbTG2NQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:16:38 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:59524
	"EHLO gaston") by vger.kernel.org with ESMTP id S271719AbTG2NQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:16:24 -0400
Subject: [PATCH] PPC32: Update pmac_cpufreq driver back to working
	conditions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059484561.8537.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 09:16:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the PowerMac cpufreq driver so that
it builds & works in current 2.6

Please apply,
Ben.

diff -urN linux-2.5/arch/ppc/platforms/pmac_cpufreq.c linuxppc-2.5-benh/arch/ppc/platforms/pmac_cpufreq.c
--- linux-2.5/arch/ppc/platforms/pmac_cpufreq.c	2003-07-29 08:50:25.000000000 -0400
+++ linuxppc-2.5-benh/arch/ppc/platforms/pmac_cpufreq.c	2003-07-23 20:04:23.000000000 -0400
@@ -1,4 +1,16 @@
+/*
+ *  arch/ppc/platforms/pmac_cpufreq.c
+ *
+ *  Copyright (C) 2002 - 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -36,6 +48,18 @@
 #define PMAC_CPU_LOW_SPEED	1
 #define PMAC_CPU_HIGH_SPEED	0
 
+/* There are only two frequency states for each processor. Values
+ * are in kHz for the time being.
+ */
+#define CPUFREQ_HIGH                  PMAC_CPU_HIGH_SPEED
+#define CPUFREQ_LOW                   PMAC_CPU_LOW_SPEED
+
+static struct cpufreq_frequency_table pmac_cpu_freqs[] = {
+	{CPUFREQ_HIGH, 		0},
+	{CPUFREQ_LOW,		0},
+	{0,			CPUFREQ_TABLE_END},
+};
+
 static inline void
 wakeup_decrementer(void)
 {
@@ -192,37 +216,21 @@
 static int __pmac
 pmac_cpufreq_verify(struct cpufreq_policy *policy)
 {
-	if (!policy)
-		return -EINVAL;
-		
-	policy->cpu = 0; /* UP only */
-
-	cpufreq_verify_within_limits(policy, low_freq, hi_freq);
-
-	if ((policy->min > low_freq) && 
-	    (policy->max < hi_freq))
-		policy->max = hi_freq;
-
-	return 0;
+	return cpufreq_frequency_table_verify(policy, pmac_cpu_freqs);
 }
 
 static int __pmac
-pmac_cpufreq_setpolicy(struct cpufreq_policy *policy)
+pmac_cpufreq_target(	struct cpufreq_policy *policy,
+			unsigned int target_freq,
+			unsigned int relation)
 {
-	int rc;
-	
-	if (!policy)
+	unsigned int    newstate = 0;
+
+	if (cpufreq_frequency_table_target(policy, pmac_cpu_freqs,
+			target_freq, relation, &newstate))
 		return -EINVAL;
-	if (policy->min > low_freq)
-		rc = do_set_cpu_speed(PMAC_CPU_HIGH_SPEED);
-	else if (policy->max < hi_freq)
-		rc = do_set_cpu_speed(PMAC_CPU_LOW_SPEED);
-	else if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
-		rc = do_set_cpu_speed(PMAC_CPU_LOW_SPEED);
-	else
-		rc = do_set_cpu_speed(PMAC_CPU_HIGH_SPEED);
 
-	return rc;
+	return do_set_cpu_speed(newstate);
 }
 
 unsigned int __pmac
@@ -232,6 +240,27 @@
 	return (i == 0) ? cur_freq : 0;
 }
 
+static int __pmac
+pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	if (policy->cpu != 0)
+		return -ENODEV;
+
+	policy->policy = (cur_freq == low_freq) ? 
+		CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
+	policy->cpuinfo.transition_latency	= CPUFREQ_ETERNAL;
+	policy->cur = cur_freq;
+
+	return cpufreq_frequency_table_cpuinfo(policy, &pmac_cpu_freqs[0]);
+}
+
+static struct cpufreq_driver pmac_cpufreq_driver = {
+	.verify 	= pmac_cpufreq_verify,
+	.target 	= pmac_cpufreq_target,
+	.init		= pmac_cpufreq_cpu_init,
+	.name		= "powermac",
+	.owner		= THIS_MODULE,
+};
 
 /* Currently, we support the following machines:
  * 
@@ -244,13 +273,9 @@
 pmac_cpufreq_setup(void)
 {	
 	struct device_node	*cpunode;
-	struct cpufreq_driver   *driver;
 	u32			*value;
 	int			has_freq_ctl = 0;
-	int			rc;
 	
-	memset(&driver, 0, sizeof(driver));
-
 	/* Assume only one CPU */
 	cpunode = find_type_devices("cpu");
 	if (!cpunode)
@@ -318,34 +343,11 @@
 	if (!has_freq_ctl)
 		return -ENODEV;
 	
-	/* initialization of main "cpufreq" code*/
-	driver = kmalloc(sizeof(struct cpufreq_driver) + 
-			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
-	if (!driver)
-		return -ENOMEM;
-
-	driver->policy = (struct cpufreq_policy *) (driver + 1);
-
-	driver->verify		= &pmac_cpufreq_verify;
-	driver->setpolicy	= &pmac_cpufreq_setpolicy;
-	driver->init		= NULL;
-	driver->exit		= NULL;
-	strlcpy(driver->name, "powermac", sizeof(driver->name));
-
-	driver->policy[0].cpu				= 0;
-	driver->policy[0].cpuinfo.transition_latency	= CPUFREQ_ETERNAL;
-	driver->policy[0].cpuinfo.min_freq		= low_freq;
-	driver->policy[0].min				= low_freq;
-	driver->policy[0].max				= cur_freq;
-	driver->policy[0].cpuinfo.max_freq		= cur_freq;
-	driver->policy[0].policy			= (cur_freq == low_freq) ? 
-	    	CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
-
-	rc = cpufreq_register_driver(driver);
-	if (rc)
-		kfree(driver);
-	return rc;
+	pmac_cpu_freqs[CPUFREQ_LOW].frequency = low_freq;
+	pmac_cpu_freqs[CPUFREQ_HIGH].frequency = hi_freq;
+
+	return cpufreq_register_driver(&pmac_cpufreq_driver);
 }
 
-__initcall(pmac_cpufreq_setup);
+module_init(pmac_cpufreq_setup);
 

