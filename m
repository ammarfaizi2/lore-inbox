Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWITCnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWITCnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 22:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWITCnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 22:43:12 -0400
Received: from smtp-out.google.com ([216.239.45.12]:49179 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750793AbWITCnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 22:43:03 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer:
	in-reply-to:references;
	b=d8iMdIEABufCKTQdapPA96hi4Om8zobL1Lp+I/wRDNAU4+L2dkSBRmJERCRVmUGxZ
	HtXjNK+lua3j6wRGvJFEQ==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [PATCH 4/4] therm_throt: Add a cumulative event counter and export it to /sys.
Date: Tue, 19 Sep 2006 19:42:42 -0700
Message-Id: <11587201621272-git-send-email-dmitriyz@google.com>
X-Mailer: git-send-email 1.4.2
In-Reply-To: <1158720162574-git-send-email-dmitriyz@google.com>
References: <11587201623432-git-send-email-dmitriyz@google.com> <11587201623187-git-send-email-dmitriyz@google.com> <11587201621900-git-send-email-dmitriyz@google.com> <1158720162574-git-send-email-dmitriyz@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitriy Zavin <dmitriyz@google.com>
---
 arch/i386/kernel/cpu/mcheck/p4.c          |    3 +
 arch/i386/kernel/cpu/mcheck/therm_throt.c |  114 ++++++++++++++++++++++++++++-
 arch/x86_64/kernel/mce_intel.c            |    3 +
 include/asm-i386/therm_throt.h            |    1 
 4 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/arch/i386/kernel/cpu/mcheck/p4.c b/arch/i386/kernel/cpu/mcheck/p4.c
index 5f9896f..7d10e67 100644
--- a/arch/i386/kernel/cpu/mcheck/p4.c
+++ b/arch/i386/kernel/cpu/mcheck/p4.c
@@ -115,6 +115,9 @@ static void intel_init_thermal(struct cp
 	l = apic_read (APIC_LVTTHMR);
 	apic_write_around (APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 	printk (KERN_INFO "CPU%d: Thermal monitoring enabled\n", cpu);
+
+	/* enable thermal throttle processing */
+	atomic_set(&therm_throt_en, 1);
 	return;
 }
 #endif /* CONFIG_X86_MCE_P4THERMAL */
diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
index 3d6f217..c56fffb 100644
--- a/arch/i386/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -2,14 +2,16 @@
  * linux/arch/i386/kerne/cpu/mcheck/therm_throt.c
  *
  * Thermal throttle event support code.
+ * Maintains a counter of thermal throttle events in /sys.
  *
  * Author: Dmitriy Zavin (dmitriyz@google.com)
  *
  * Credits: Adapted from Zwane Mwaikambo's original code in mce_intel.c.
- *
+ *          Inspired by rossb and alb's counter code.
  */
 
 #include <linux/percpu.h>
+#include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <linux/notifier.h>
@@ -23,6 +25,44 @@ #endif /* CONFIG_X86_64 */
 #define CHECK_INTERVAL              (300 * HZ)
 
 static DEFINE_PER_CPU(__u64, next_check) = INITIAL_JIFFIES;
+static DEFINE_PER_CPU(unsigned long, thermal_throttle_count);
+atomic_t therm_throt_en = ATOMIC_INIT(0);
+
+#ifdef CONFIG_SYSFS
+#define define_therm_throt_sysdev_one_ro(_name)                              \
+        static SYSDEV_ATTR(_name, 0444, therm_throt_sysdev_show_##_name, NULL)
+
+#define define_therm_throt_sysdev_show_func(name)                            \
+static ssize_t therm_throt_sysdev_show_##name(struct sys_device *dev,        \
+                                              char *buf)                     \
+{                                                                            \
+	unsigned int cpu = dev->id;                                          \
+	ssize_t ret;                                                         \
+                                                                             \
+	preempt_disable();              /* CPU hotplug */                    \
+	if (cpu_online(cpu))                                                 \
+		ret = sprintf(buf, "%lu\n",                                  \
+			      per_cpu(thermal_throttle_##name, cpu));        \
+	else                                                                 \
+		ret = 0;                                                     \
+	preempt_enable();                                                    \
+                                                                             \
+	return ret;                                                          \
+}
+
+define_therm_throt_sysdev_show_func(count);
+define_therm_throt_sysdev_one_ro(count);
+
+static struct attribute *thermal_throttle_attrs[] = {
+	&attr_count.attr,
+	NULL
+};
+
+static struct attribute_group thermal_throttle_attr_group = {
+	.attrs = thermal_throttle_attrs,
+	.name = "thermal_throttle"
+};
+#endif /* CONFIG_SYSFS */
 
 #ifdef CONFIG_X86_64
 static void therm_throt_log_mce(unsigned int cpu, __u64 status)
@@ -39,13 +79,13 @@ static void therm_throt_log_mce(unsigned
 #endif /* CONFIG_X86_64 */
 
 /***
- * therm_throt_process - Process thermal throttling event
+ * therm_throt_process - Process thermal throttling event from interrupt
  * @curr: Whether the condition is current or not (boolean), since the
  *        thermal interrupt normally gets called both when the thermal
  *        event begins and once the event has ended.
  * @status: Event status information.
  *
- * This function is normally called by the thermal interrupt after the
+ * This function is called by the thermal interrupt after the
  * IRQ has been acknowledged.
  *
  * It will take care of rate limiting and printing messages to the syslog.
@@ -58,6 +98,9 @@ void therm_throt_process(int curr, __u64
 {
 	unsigned int cpu = smp_processor_id();
 
+	if (curr)
+		__get_cpu_var(thermal_throttle_count)++;
+
 	if (time_before64(get_jiffies_64(), __get_cpu_var(next_check)))
 		return;
 
@@ -66,7 +109,9 @@ void therm_throt_process(int curr, __u64
 	/* if we just entered the thermal event */
 	if (curr) {
 		printk(KERN_CRIT "CPU%d: Temperature above threshold, "
-		       "cpu clock throttled\n", cpu);
+		       "cpu clock throttled (total events = %lu)\n", cpu,
+		       __get_cpu_var(thermal_throttle_count));
+
 		add_taint(TAINT_MACHINE_CHECK);
 
 #ifdef CONFIG_X86_64
@@ -75,5 +120,66 @@ #endif
 	} else {
 		printk(KERN_CRIT "CPU%d: Temperature/speed normal\n", cpu);
 	}
+}
+
+#ifdef CONFIG_SYSFS
+/* Add/Remove thermal_throttle interface for CPU device */
+static __cpuinit int thermal_throttle_add_dev(struct sys_device * sys_dev)
+{
+	sysfs_create_group(&sys_dev->kobj, &thermal_throttle_attr_group);
+	return 0;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static __cpuinit int thermal_throttle_remove_dev(struct sys_device * sys_dev)
+{
+	sysfs_remove_group(&sys_dev->kobj, &thermal_throttle_attr_group);
+	return 0;
+}
+
+/* Get notified when a cpu comes on/off. Be hotplug friendly. */
+static __cpuinit int thermal_throttle_cpu_callback(struct notifier_block *nfb,
+						   unsigned long action,
+						   void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct sys_device *sys_dev;
+
+	sys_dev = get_cpu_sysdev(cpu);
+	switch (action) {
+		case CPU_ONLINE:
+			thermal_throttle_add_dev(sys_dev);
+			break;
+		case CPU_DEAD:
+			thermal_throttle_remove_dev(sys_dev);
+			break;
+	}
+	return NOTIFY_OK;
+}
 
+static struct notifier_block thermal_throttle_cpu_notifier =
+{
+	.notifier_call = thermal_throttle_cpu_callback,
+};
+#endif
+
+static __init int thermal_throttle_init_device(void)
+{
+	unsigned int cpu = 0;
+
+	if (!atomic_read(&therm_throt_en))
+		return 0;
+
+	preempt_disable();         /* CPU hotplug */
+	for_each_online_cpu(cpu) {
+		/* connect live CPUs to sysfs */
+		thermal_throttle_add_dev(get_cpu_sysdev(cpu));
+	}
+	preempt_enable();
+
+	register_hotcpu_notifier(&thermal_throttle_cpu_notifier);
+	return 0;
 }
+
+device_initcall(thermal_throttle_init_device);
+#endif /* CONFIG_SYSFS */
diff --git a/arch/x86_64/kernel/mce_intel.c b/arch/x86_64/kernel/mce_intel.c
index a13096e..7bbcfbb 100644
--- a/arch/x86_64/kernel/mce_intel.c
+++ b/arch/x86_64/kernel/mce_intel.c
@@ -76,6 +76,9 @@ static void __cpuinit intel_init_thermal
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 	printk(KERN_INFO "CPU%d: Thermal monitoring enabled (%s)\n",
 		cpu, tm2 ? "TM2" : "TM1");
+
+	/* enable thermal throttle processing */
+	atomic_set(&therm_throt_en, 1);
 	return;
 }
 
diff --git a/include/asm-i386/therm_throt.h b/include/asm-i386/therm_throt.h
index c6e638b..4cf4f75 100644
--- a/include/asm-i386/therm_throt.h
+++ b/include/asm-i386/therm_throt.h
@@ -3,6 +3,7 @@ #define __ASM_I386_THERM_THROT_H__ 1
 
 #include <asm/types.h>
 
+extern atomic_t therm_throt_en;
 void therm_throt_process(int curr, __u64 status);
 
 #endif /* __ASM_I386_THERM_THROT_H__ */
-- 
1.4.2

