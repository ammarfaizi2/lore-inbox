Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTB1VFH>; Fri, 28 Feb 2003 16:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTB1VFH>; Fri, 28 Feb 2003 16:05:07 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:20453 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261486AbTB1VFC>; Fri, 28 Feb 2003 16:05:02 -0500
Date: Fri, 28 Feb 2003 22:16:38 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Pavel Machek <pavel@suse.cz>, davej@suse.de
Cc: John Clemens <john@deater.net>, cpufreq@www.linux.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] Re: cpufreq: allow user to specify voltage
Message-ID: <20030228211638.GA888@brodo.de>
References: <20030225190949.GM12028@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302251419290.12073-100000@pianoman.cluster.toy> <20030225193341.GA19556@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225193341.GA19556@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my suggestion, (partly) based on something Patrick Mochel suggested
for the passing of attribute files of cpufreq drivers to the cpufreq core:
a NULL-terminated list of device_attributes *attr is passed to the core. And
if attr itself is NULL, no attribute is passed, of course. Using this
approach, this patch against cpufreq-CVS-HEAD adds a file

/sys/devices/sys/cpu0/scaling_available_freqs (something Carl Thompson
						asked for)

for the powernow-k7.c and the p4-clockmod.c drivers (other frequency table
based drivers can be added at will -- Carl, please don't realy _solely_ on
this file: some drivers don't use frequency tables but still might want to
use your great userspace scaling program!)

And for powernow-k7.c , the file

/sys/devices/sys/cpu0/scaling_setvoltage

should show the current voltage for the current speed (scaling_setspeed).
"echoing" a different value (must be lower than the current voltage) changes
the voltage for this frequency only. However, this override is "static" so
that if you switch to a different frequency in the meantime but get back to
the one you wanted to override the voltage setting for, the new 
user-specified value is remembered.

This is untested (don't have a powernow-k7-capable notebook), so handle with
care.

Comments most welcome,

	Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-02-28 21:42:13.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-02-28 21:45:00.000000000 +0100
@@ -214,6 +214,7 @@
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;
 	}
+	cpufreq_frequency_table_get_attr(p4clockmod_table, policy->cpu);
 	
 	/* cpuinfo and default policy values */
 	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
@@ -226,6 +227,7 @@
 
 static int cpufreq_p4_cpu_exit(struct cpufreq_policy *policy)
 {
+	cpufreq_frequency_table_put_attr(policy->cpu);
 	return cpufreq_p4_setdc(policy->cpu, DC_DISABLE);
 }
 
@@ -236,6 +238,8 @@
 	.init		= cpufreq_p4_cpu_init,
 	.exit		= cpufreq_p4_cpu_exit,
 	.name		= "p4-clockmod",
+	.attr		= {&dev_attr_scaling_available_freqs,
+			   NULL},
 };
 
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k7.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2003-02-28 21:42:13.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2003-02-28 22:03:04.000000000 +0100
@@ -326,6 +326,7 @@
 	return -ENODEV;
 }
 
+static DECLARE_MUTEX(change_speed_lock);
 
 static int powernow_target (struct cpufreq_policy *policy,
 			    unsigned int target_freq,
@@ -336,7 +337,9 @@
 	if (cpufreq_frequency_table_target(policy, powernow_table, target_freq, relation, &newstate))
 		return -EINVAL;
 
+	down(&change_speed_lock);
 	change_speed(newstate);
+	up(&change_speed_lock);
 
 	return 0;
 }
@@ -365,6 +368,7 @@
 	printk (KERN_INFO PFX "Minimum speed %d MHz. Maximum speed %d MHz.\n",
 				minimum_speed, maximum_speed);
 
+	cpufreq_frequency_table_get_attr(powernow_table, policy->cpu);
 	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 	policy->cpuinfo.transition_latency = latency;
 	policy->cur = maximum_speed;
@@ -372,11 +376,103 @@
 	return cpufreq_frequency_table_cpuinfo(policy, powernow_table);
 }
 
+static int powernow_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static ssize_t show_voltage (struct device *dev, char *buf)
+{
+	union msr_fidvidstatus fidvidstatus;
+	unsigned int freq;
+	unsigned int i;
+	u8 vid;
+
+	rdmsrl (MSR_K7_FID_VID_STATUS, fidvidstatus.val);
+	freq = fsb * fid_codes[fidvidstatus.bits.CFID] * 100;
+
+	for (i=0; (powernow_table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		if (powernow_table[i].frequency == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if (powernow_table[i].frequency == freq)
+			goto found;
+	}
+	return -EINVAL;
+
+ found:
+	vid = (powernow_table[i].index & 0xFF00) >> 8;
+	return sprintf(buf, "%dmV\n", mobile_vid_table[vid]);
+}
+
+static ssize_t store_voltage (struct device *dev, 
+			      const char *buf, size_t count) 
+{
+	union msr_fidvidstatus fidvidstatus;
+	unsigned int freq;
+	unsigned int i;
+	unsigned int tmp;
+	unsigned int new_voltage;
+	unsigned int ret;
+	u8 vid, new_vid;
+
+	ret = sscanf (buf, "%d", &new_voltage);
+	if (ret != 1 || !new_voltage)
+		return -EINVAL;
+
+	for (i=0; i<32; i++) {
+		if (mobile_vid_table[i] == new_voltage)
+			goto match;
+	}
+	return -EINVAL;
+
+ match:
+	new_vid = (u8) i;
+
+	rdmsrl (MSR_K7_FID_VID_STATUS, fidvidstatus.val);
+	freq = fsb * fid_codes[fidvidstatus.bits.CFID] * 100;
+
+	for (i=0; (powernow_table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		if (powernow_table[i].frequency == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if (powernow_table[i].frequency == freq)
+			goto found;
+	}
+	return -ENODEV;
+
+ found:
+	vid = (powernow_table[i].index & 0xFF00) >> 8;
+
+	/* safety check */
+	if (mobile_vid_table[new_vid] > mobile_vid_table[vid])
+		return -EINVAL;
+
+	printk("overwriting voltage for frequency %d MHz with %d mV (old was %d mV).\n", 
+	       (freq/1000), mobile_vid_table[new_vid], mobile_vid_table[vid]);
+
+	down(&change_speed_lock);
+	tmp = powernow_table[i].index;
+	tmp &= powernow_table[i].index & 0x00FF;
+	tmp |= (new_vid << 8); /* upper 8 bits */
+	powernow_table[i].index = tmp; /* actual over-writing */
+
+	/* we're not changing speed but voltage, but anyways... */
+	change_speed (i);
+	up(&change_speed_lock);
+
+	return count;
+}
+static DEVICE_ATTR(scaling_setvoltage, (S_IRUGO | S_IWUSR), show_voltage, store_voltage);
+
 static struct cpufreq_driver powernow_driver = {
 	.verify 	= powernow_verify,
 	.target 	= powernow_target,
 	.init		= powernow_cpu_init,
+	.exit		= powernow_cpu_exit,
 	.name		= "powernow-k7",
+	.attr		= {&dev_attr_scaling_available_freqs,
+			   &dev_attr_scaling_setvoltage,
+			   NULL},
 };
 
 static int __init powernow_init (void)
diff -ruN linux-original/drivers/cpufreq/freq_table.c linux/drivers/cpufreq/freq_table.c
--- linux-original/drivers/cpufreq/freq_table.c	2003-02-26 09:44:57.000000000 +0100
+++ linux/drivers/cpufreq/freq_table.c	2003-02-28 21:17:07.000000000 +0100
@@ -198,6 +198,53 @@
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
 
 
+static struct cpufreq_frequency_table *show_table[NR_CPUS];
+/**
+ * show_scaling_governor - show the current policy for the specified CPU
+ */
+static ssize_t show_available_freqs (struct device *dev, char *buf)
+{
+	unsigned int i = 0;
+	unsigned int cpu = to_cpu_nr(dev);
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
+DEVICE_ATTR(scaling_available_freqs, S_IRUGO, show_available_freqs, NULL);
+EXPORT_SYMBOL_GPL(dev_attr_scaling_available_freqs);
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
+	show_table[cpu] = 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_put_attr);
+
+
 MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION ("CPUfreq frequency table helpers");
 MODULE_LICENSE ("GPL");
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-02-28 21:42:13.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-02-28 20:56:28.000000000 +0100
@@ -166,8 +166,11 @@
 	/* optional, for the moment */
 	int	(*init)		(struct cpufreq_policy *policy);
 	int	(*exit)		(struct cpufreq_policy *policy);
+	struct device_attribute *attr[];
 };
 
+inline int to_cpu_nr (struct device *dev);
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 /* deprecated */
@@ -298,6 +301,14 @@
 				   unsigned int relation,
 				   unsigned int *index);
 
+/* the following are really really optional */
+extern struct device_attribute dev_attr_scaling_available_freqs;
+
+void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table, 
+				      unsigned int cpu);
+
+void cpufreq_frequency_table_put_attr(unsigned int cpu);
+
 #endif /* CONFIG_CPU_FREQ_TABLE */
 
 #endif /* _LINUX_CPUFREQ_H */
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-02-28 21:42:13.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-02-28 21:47:46.000000000 +0100
@@ -102,7 +102,7 @@
         .devnum = 0,
 };
 
-static inline int to_cpu_nr (struct device *dev)
+inline int to_cpu_nr (struct device *dev)
 {
 	struct sys_device * cpu_sys_dev = container_of(dev, struct sys_device, dev);
 	return (cpu_sys_dev->id);
@@ -312,6 +312,7 @@
 	unsigned int cpu = to_cpu_nr(dev);
 	int ret = 0;
 	struct cpufreq_policy policy;
+	struct device_attribute ** drv_attr;
 
 	down(&cpufreq_driver_sem);
 	if (!cpufreq_driver) {
@@ -369,6 +370,12 @@
 	device_create_file (dev, &dev_attr_scaling_driver);
 	device_create_file (dev, &dev_attr_available_scaling_governors);
 
+	drv_attr = cpufreq_driver->attr;
+	while ((drv_attr) && (*drv_attr)) {
+		device_create_file(dev, *drv_attr);
+		drv_attr++;
+	}
+
 	up(&cpufreq_driver_sem);
 	return ret;
 }
@@ -384,6 +391,7 @@
 {
 	struct device * dev = intf->dev;
 	unsigned int cpu = to_cpu_nr(dev);
+	struct device_attribute ** drv_attr;
 
 	if (cpufreq_driver->target)
 		cpufreq_governor(cpu, CPUFREQ_GOV_STOP);
@@ -399,6 +407,12 @@
 	device_remove_file (dev, &dev_attr_scaling_driver);
 	device_remove_file (dev, &dev_attr_available_scaling_governors);
 
+	drv_attr = cpufreq_driver->attr;
+	while ((drv_attr) && (*drv_attr)) {
+		device_remove_file(dev, *drv_attr);
+		drv_attr++;
+	}
+
 	return 0;
 }
 
