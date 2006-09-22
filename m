Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWIVAsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWIVAsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWIVAsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:48:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:12640 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932151AbWIVAs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:48:28 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer:
	in-reply-to:references;
	b=laQxHk6OG1hQk0zdfmETCNlicAqT8i6sP/oNJLrpcn82FUrzSMcfcneNWbQ+BkNxq
	7gwJIXlmWOhc8+V3psUdg==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [PATCH 4/4] therm_throt: Add a cumulative thermal throttle event counter.
Date: Thu, 21 Sep 2006 17:48:04 -0700
Message-Id: <11588860852260-git-send-email-dmitriyz@google.com>
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11588860852885-git-send-email-dmitriyz@google.com>
References: <11588860842488-git-send-email-dmitriyz@google.com> <11588860854079-git-send-email-dmitriyz@google.com> <11588860853616-git-send-email-dmitriyz@google.com> <11588860852885-git-send-email-dmitriyz@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The counter is exported to /sys that keeps track of the
number of thermal events, such that the user knows how bad the
thermal problem might be (since the logging to syslog and mcelog
is rate limited).

Signed-off-by: Dmitriy Zavin <dmitriyz@google.com>

---
 arch/i386/kernel/cpu/mcheck/p4.c          |    3 +
 arch/i386/kernel/cpu/mcheck/therm_throt.c |  124 ++++++++++++++++++++++++++++-
 arch/x86_64/kernel/mce_intel.c            |    3 +
 include/asm-i386/therm_throt.h            |    3 +
 4 files changed, 127 insertions(+), 6 deletions(-)

diff --git a/arch/i386/kernel/cpu/mcheck/p4.c b/arch/i386/kernel/cpu/mcheck/p4.c
index d83a669..504434a 100644
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
index 101f7ac..227c695 100644
--- a/arch/i386/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -1,15 +1,22 @@
 /*
  * linux/arch/i386/kerne/cpu/mcheck/therm_throt.c
  *
- * Thermal throttle event support code.
+ * Thermal throttle event support code (such as syslog messaging and rate
+ * limiting) that was factored out from x86_64 (mce_intel.c) and i386 (p4.c).
+ * This allows consistent reporting of CPU thermal throttle events.
+ *
+ * Maintains a counter in /sys that keeps track of the number of thermal
+ * events, such that the user knows how bad the thermal problem might be
+ * (since the logging to syslog and mcelog is rate limited).
  *
  * Author: Dmitriy Zavin (dmitriyz@google.com)
  *
  * Credits: Adapted from Zwane Mwaikambo's original code in mce_intel.c.
- *
+ *          Inspired by Ross Biro's and Al Borchers' counter code.
  */
 
 #include <linux/percpu.h>
+#include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <linux/notifier.h>
@@ -18,15 +25,53 @@ #include <asm/therm_throt.h>
 /* How long to wait between reporting thermal events */
 #define CHECK_INTERVAL              (300 * HZ)
 
-static DEFINE_PER_CPU(__u64, next_check);
+static DEFINE_PER_CPU(__u64, next_check) = INITIAL_JIFFIES;
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
 
 /***
- * therm_throt_process - Process thermal throttling event
+ * therm_throt_process - Process thermal throttling event from interrupt
  * @curr: Whether the condition is current or not (boolean), since the
  *        thermal interrupt normally gets called both when the thermal
  *        event begins and once the event has ended.
  *
- * This function is normally called by the thermal interrupt after the
+ * This function is called by the thermal interrupt after the
  * IRQ has been acknowledged.
  *
  * It will take care of rate limiting and printing messages to the syslog.
@@ -41,6 +86,9 @@ int therm_throt_process(int curr)
 	unsigned int cpu = smp_processor_id();
 	__u64 tmp_jiffs = get_jiffies_64();
 
+	if (curr)
+		__get_cpu_var(thermal_throttle_count)++;
+
 	if (time_before64(tmp_jiffs, __get_cpu_var(next_check)))
 		return 0;
 
@@ -49,7 +97,9 @@ int therm_throt_process(int curr)
 	/* if we just entered the thermal event */
 	if (curr) {
 		printk(KERN_CRIT "CPU%d: Temperature above threshold, "
-		       "cpu clock throttled\n", cpu);
+		       "cpu clock throttled (total events = %lu)\n", cpu,
+		       __get_cpu_var(thermal_throttle_count));
+
 		add_taint(TAINT_MACHINE_CHECK);
 	} else {
 		printk(KERN_CRIT "CPU%d: Temperature/speed normal\n", cpu);
@@ -57,3 +107,65 @@ int therm_throt_process(int curr)
 
 	return 1;
 }
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
+
+static struct notifier_block thermal_throttle_cpu_notifier =
+{
+	.notifier_call = thermal_throttle_cpu_callback,
+};
+#endif /* CONFIG_HOTPLUG_CPU */
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
+}
+
+device_initcall(thermal_throttle_init_device);
+#endif /* CONFIG_SYSFS */
diff --git a/arch/x86_64/kernel/mce_intel.c b/arch/x86_64/kernel/mce_intel.c
index dec1121..6551505 100644
--- a/arch/x86_64/kernel/mce_intel.c
+++ b/arch/x86_64/kernel/mce_intel.c
@@ -77,6 +77,9 @@ static void __cpuinit intel_init_thermal
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 	printk(KERN_INFO "CPU%d: Thermal monitoring enabled (%s)\n",
 		cpu, tm2 ? "TM2" : "TM1");
+
+	/* enable thermal throttle processing */
+	atomic_set(&therm_throt_en, 1);
 	return;
 }
 
diff --git a/include/asm-i386/therm_throt.h b/include/asm-i386/therm_throt.h
index 3c9c22c..399bf60 100644
--- a/include/asm-i386/therm_throt.h
+++ b/include/asm-i386/therm_throt.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_I386_THERM_THROT_H__
 #define __ASM_I386_THERM_THROT_H__ 1
 
+#include <asm/atomic.h>
+
+extern atomic_t therm_throt_en;
 int therm_throt_process(int curr);
 
 #endif /* __ASM_I386_THERM_THROT_H__ */
-- 
1.4.2

