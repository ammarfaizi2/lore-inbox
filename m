Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTCIT3l>; Sun, 9 Mar 2003 14:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262583AbTCIT3L>; Sun, 9 Mar 2003 14:29:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34322 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262580AbTCITZy>; Sun, 9 Mar 2003 14:25:54 -0500
Date: Sun, 9 Mar 2003 19:36:31 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH] cpufreq (3/7): remove unneeded code
Message-ID: <20030309193631.D26266@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Dominik Brodowski <linux@brodo.de> -----

From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq (3/7): remove unneeded code
Date: Fri, 7 Mar 2003 11:09:04 +0100

- no cpufreq driver uses the frequency table helper "setpolicy" any more
  ("target" is much more appropriate for them anyways) - so remove
  that helper
- all cpufreq drivers use the advanced registration process, so some
  compatibility code can safely be removed.

 drivers/cpufreq/freq_table.c |   50 -------------------------------------------
 include/linux/cpufreq.h      |    7 ------
 kernel/cpufreq.c             |   22 ++++++------------
 3 files changed, 7 insertions(+), 72 deletions(-)

diff -u linux-original/drivers/cpufreq/freq_table.c linux/drivers/cpufreq/freq_table.c
--- linux-original/drivers/cpufreq/freq_table.c	2003-03-06 19:13:52.000000000 +0100
+++ linux/drivers/cpufreq/freq_table.c	2003-03-06 21:17:14.000000000 +0100
@@ -77,56 +77,6 @@
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
 
 
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
-
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table,
 				   unsigned int target_freq,
diff -u linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-03-06 21:18:02.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-03-06 21:17:14.000000000 +0100
@@ -172,9 +172,6 @@
 
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
-/* deprecated */
-#define cpufreq_register(x)   cpufreq_register_driver(x)
-#define cpufreq_unregister() cpufreq_unregister_driver(NULL)
 
 
 void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state);
@@ -297,10 +294,6 @@
 int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
 
-int cpufreq_frequency_table_setpolicy(struct cpufreq_policy *policy,
-				      struct cpufreq_frequency_table *table,
-				      unsigned int *index);
-
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table,
 				   unsigned int target_freq,
diff -u linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-03-06 21:18:02.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-03-06 21:17:14.000000000 +0100
@@ -798,7 +798,7 @@
 	if (cpufreq_driver)
 		return -EBUSY;
 	
-	if (!driver_data || !driver_data->verify || 
+	if (!driver_data || !driver_data->verify || !driver_data->init ||
 	    ((!driver_data->setpolicy) && (!driver_data->target)))
 		return -EINVAL;
 
@@ -806,20 +806,12 @@
 
 	cpufreq_driver = driver_data;
 
+	cpufreq_driver->policy = kmalloc(NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!cpufreq_driver->policy) {
-		/* then we need per-CPU init */
-		if (!cpufreq_driver->init) {
-			up(&cpufreq_driver_sem);
-			return -EINVAL;
-		}
-		cpufreq_driver->policy = kmalloc(NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
-		if (!cpufreq_driver->policy) {
-			up(&cpufreq_driver_sem);
-			return -ENOMEM;
-		}
-		memset(cpufreq_driver->policy, 0, NR_CPUS * sizeof(struct cpufreq_policy));
+		up(&cpufreq_driver_sem);
+		return -ENOMEM;
 	}
-	
+	memset(cpufreq_driver->policy, 0, NR_CPUS * sizeof(struct cpufreq_policy));
 	up(&cpufreq_driver_sem);
 
 	ret = interface_register(&cpufreq_interface);
@@ -841,8 +833,8 @@
 {
 	down(&cpufreq_driver_sem);
 
-	if (!cpufreq_driver || 
-	    ((driver != cpufreq_driver) && (driver != NULL))) { /* compat */
+	if (!cpufreq_driver ||
+	    (driver != cpufreq_driver)) { 
 		up(&cpufreq_driver_sem);
 		return -EINVAL;
 	}

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

