Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbTCIT2C>; Sun, 9 Mar 2003 14:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262581AbTCIT1Q>; Sun, 9 Mar 2003 14:27:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36882 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262586AbTCIT0H>; Sun, 9 Mar 2003 14:26:07 -0500
Date: Sun, 9 Mar 2003 19:36:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH] cpufreq (6/7): allow cpufreq drivers to export sysfs files
Message-ID: <20030309193644.G26266@flint.arm.linux.org.uk>
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
Subject: [PATCH] cpufreq (6/7): allow cpufreq drivers to export sysfs files
Date: Fri, 7 Mar 2003 11:09:22 +0100

This patch lets cpufreq drivers export per-CPU files in the cpufreq and
cpu-specific sysfs directory. As an example, a file
"scaling_available_frequencies" is added to the p4-clockmod.c driver.

Please apply,
	Dominik

 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |    7 ++++
 drivers/cpufreq/freq_table.c               |   50 +++++++++++++++++++++++++++++
 include/linux/cpufreq.h                    |   12 ++++++
 kernel/cpufreq.c                           |    9 ++++-
 4 files changed, 77 insertions(+), 1 deletion(-)

diff -ru linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-03-06 21:56:18.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-03-06 23:00:27.000000000 +0100
@@ -214,6 +214,7 @@
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;
 	}
+	cpufreq_frequency_table_get_attr(p4clockmod_table, policy->cpu);
 	
 	/* cpuinfo and default policy values */
 	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
@@ -226,9 +227,14 @@
 
 static int cpufreq_p4_cpu_exit(struct cpufreq_policy *policy)
 {
+	cpufreq_frequency_table_put_attr(policy->cpu);    
 	return cpufreq_p4_setdc(policy->cpu, DC_DISABLE);
 }
 
+static struct freq_attr* p4clockmod_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
 
 static struct cpufreq_driver p4clockmod_driver = {
 	.verify 	= cpufreq_p4_verify,
@@ -237,6 +243,7 @@
 	.exit		= cpufreq_p4_cpu_exit,
 	.name		= "p4-clockmod",
 	.owner		= THIS_MODULE,
+	.attr		= p4clockmod_attr,
 };
 
 
diff -ru linux-original/drivers/cpufreq/freq_table.c linux/drivers/cpufreq/freq_table.c
--- linux-original/drivers/cpufreq/freq_table.c	2003-03-06 21:19:04.000000000 +0100
+++ linux/drivers/cpufreq/freq_table.c	2003-03-06 23:00:21.000000000 +0100
@@ -147,6 +147,56 @@
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
 
+static struct cpufreq_frequency_table *show_table[NR_CPUS];
+/**
+ * show_scaling_governor - show the current policy for the specified CPU
+ */
+static ssize_t show_available_freqs (struct cpufreq_policy *policy, char *buf)
+{
+	unsigned int i = 0;
+	unsigned int cpu = policy->cpu;
+	ssize_t count = 0;
+	struct cpufreq_frequency_table *table;
+
+	if (!show_table[cpu])
+		return -ENODEV;
+
+	table = show_table[cpu];
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
+			continue;
+		count += sprintf(&buf[count], "%d ", table[i].frequency);
+	}
+	count += sprintf(&buf[count], "\n");
+
+	return count;
+
+}
+
+struct freq_attr cpufreq_freq_attr_scaling_available_freqs = {
+	.attr = { .name = "scaling_available_frequencies", .mode = 0444 },
+	.show = show_available_freqs,
+};
+EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
+
+/*
+ * if you use these, you must assure that the frequency table is valid
+ * all the time between get_attr and put_attr!
+ */
+void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table, 
+				      unsigned int cpu)
+{
+	show_table[cpu] = table;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_get_attr);
+
+void cpufreq_frequency_table_put_attr(unsigned int cpu)
+{
+	show_table[cpu] = NULL;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_put_attr);
+
 
 MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION ("CPUfreq frequency table helpers");
diff -ru linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-03-06 21:56:18.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-03-06 23:00:41.000000000 +0100
@@ -152,6 +152,8 @@
 #define CPUFREQ_RELATION_L 0  /* lowest frequency at or above target */
 #define CPUFREQ_RELATION_H 1  /* highest frequency below or at target */
 
+struct freq_attr;
+
 struct cpufreq_driver {
 	/* needed by all drivers */
 	int	(*verify)	(struct cpufreq_policy *policy);
@@ -166,6 +168,7 @@
 	/* optional, for the moment */
 	int	(*init)		(struct cpufreq_policy *policy);
 	int	(*exit)		(struct cpufreq_policy *policy);
+	struct freq_attr	**attr;
 };
 
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
@@ -298,6 +301,15 @@
 				   unsigned int relation,
 				   unsigned int *index);
 
+/* the following are really really optional */
+extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
+
+void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table, 
+				      unsigned int cpu);
+
+void cpufreq_frequency_table_put_attr(unsigned int cpu);
+
+
 #endif /* CONFIG_CPU_FREQ_TABLE */
 
 #endif /* _LINUX_CPUFREQ_H */
diff -ru linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-03-06 21:56:18.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-03-06 23:02:20.000000000 +0100
@@ -340,6 +340,7 @@
 	int ret = 0;
 	struct cpufreq_policy new_policy;
 	struct cpufreq_policy *policy;
+	struct freq_attr **drv_attr;
 
 	if (!kset_get(&cpufreq_interface.kset))
 		return -EINVAL;
@@ -378,7 +379,13 @@
 	ret = kobject_register(&policy->kobj);
 	if (ret)
 		goto out;
-		
+
+	drv_attr = cpufreq_driver->attr;
+	while ((drv_attr) && (*drv_attr)) {
+		sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
+		drv_attr++;
+	}
+
 	/* set default policy */
 	ret = cpufreq_set_policy(&new_policy);
 	if (ret)

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

