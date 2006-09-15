Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWIOAnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWIOAnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIOAnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:43:05 -0400
Received: from smtp-out.google.com ([216.239.45.12]:2421 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751382AbWIOAnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:43:02 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:mime-version:
	content-type:content-disposition:user-agent;
	b=Ws8lS6k0NlBjiBZ992kstq5pR0PqWtnfMa9Dnk9WPlfUkrC1MlRCn0rK8H2Xq2cxX
	/FTgyQReVUUsrx7muWK4A==
Date: Thu, 14 Sep 2006 17:42:36 -0700
From: Dima Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, zwane@arm.linux.org.uk
Subject: [PATCH] x86_64/i386: Rework thermal throttling detection/handling code for Intel P4/Xeons.
Message-ID: <20060915004236.GA9766@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Maintain a count of thermal throttle events and export them to /sys/devices/system/cpu/cpuX/thermal_throttle/count
- Factor out the thermal throttle event handling (i.e. logging) to a separate file, therm_throt.c under
  i386/kernel/cpu/mcheck.
  - The interrupt handlers call into these functions, so that i386 and x86_64 behaviour is the same, and there is no
    code duplication (except for registering the irq, and actually handling it. It's probably better to keep that
    separate even though it is, in fact, almost identical)
  - I will see if it's plausible to refactor that as well, but for a later patch.
- These changes make it easy to add thermal throttling detection for other x86 vendors (coming in a later patch)


Signed-off-by: Dmitriy Zavin <dmitriyz@google.com>

---
 arch/i386/kernel/cpu/mcheck/Makefile      |    2 
 arch/i386/kernel/cpu/mcheck/p4.c          |   25 +--
 arch/i386/kernel/cpu/mcheck/therm_throt.c |  239 +++++++++++++++++++++++++++++
 arch/x86_64/kernel/Makefile               |    4 
 arch/x86_64/kernel/mce.c                  |   50 ++++++
 arch/x86_64/kernel/mce_intel.c            |   34 ++--
 include/asm-i386/therm_throt.h            |   17 ++
 include/asm-x86_64/mce.h                  |    4 
 include/asm-x86_64/therm_throt.h          |    1 
 9 files changed, 338 insertions(+), 38 deletions(-)

diff --git a/arch/i386/kernel/cpu/mcheck/Makefile b/arch/i386/kernel/cpu/mcheck/Makefile
index 30808f3..f1ebe1c 100644
--- a/arch/i386/kernel/cpu/mcheck/Makefile
+++ b/arch/i386/kernel/cpu/mcheck/Makefile
@@ -1,2 +1,2 @@
-obj-y	=	mce.o k7.o p4.o p5.o p6.o winchip.o
+obj-y	=	mce.o k7.o p4.o p5.o p6.o winchip.o therm_throt.o
 obj-$(CONFIG_X86_MCE_NONFATAL)	+=	non-fatal.o
diff --git a/arch/i386/kernel/cpu/mcheck/p4.c b/arch/i386/kernel/cpu/mcheck/p4.c
index b95f1b3..4a64bb9 100644
--- a/arch/i386/kernel/cpu/mcheck/p4.c
+++ b/arch/i386/kernel/cpu/mcheck/p4.c
@@ -13,6 +13,8 @@ #include <asm/system.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
 
+#include <asm/therm_throt.h>
+
 #include "mce.h"
 
 /* as supported by the P4/Xeon family */
@@ -45,24 +47,14 @@ static void unexpected_thermal_interrupt
 static void intel_thermal_interrupt(struct pt_regs *regs)
 {
 	u32 l, h;
-	unsigned int cpu = smp_processor_id();
-	static unsigned long next[NR_CPUS];
 
 	ack_APIC_irq();
 
-	if (time_after(next[cpu], jiffies))
-		return;
-
-	next[cpu] = jiffies + HZ*5;
 	rdmsr(MSR_IA32_THERM_STATUS, l, h);
-	if (l & 0x1) {
-		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
-		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n",
-				cpu);
-		add_taint(TAINT_MACHINE_CHECK);
-	} else {
-		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
-	}
+	if (l & 0x1)
+		thermal_throttle_inc_count();
+
+	thermal_throttle_process_event(NULL, (l & 0x1));
 }
 
 /* Thermal interrupt handler for this CPU setup */
@@ -122,7 +114,10 @@ static void intel_init_thermal(struct cp
 	
 	rdmsr (MSR_IA32_MISC_ENABLE, l, h);
 	wrmsr (MSR_IA32_MISC_ENABLE, l | (1<<3), h);
-	
+
+	/* init thermal throttle counting before re-enabling the interrupt */
+	thermal_throttle_count_init(cpu);
+
 	l = apic_read (APIC_LVTTHMR);
 	apic_write_around (APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 	printk (KERN_INFO "CPU%d: Thermal monitoring enabled\n", cpu);
diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
new file mode 100644
index 0000000..fd3993a
--- /dev/null
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -0,0 +1,239 @@
+/*
+ * Thermal throttle event support code.
+ * It creates /sys variables for keeping track
+ * of events, keeps an ongoing count of events, logs to mce_log (if available).
+ *
+ * Author: Dmitriy Zavin (dmitriyz@google.com)
+ *
+ * Credits:
+ *      The mce_log stuff adapted from mce_intel.c (Zwane Mwaitambo)
+ *      The sysfs stuff blatantly copied/pasted from base/topology.c
+ *      Inspired by rossb/alb
+ */
+
+#include <linux/percpu.h>
+#include <linux/sysdev.h>
+#include <linux/cpu.h>
+#include <asm/cpu.h>
+#include <linux/notifier.h>
+#include <asm/therm_throt.h>
+
+/* How long to wait between reporting thermal events */
+#define CHECK_INTERVAL              (300 * HZ)
+
+static DEFINE_PER_CPU(atomic_t, tt_report_flag);
+static DEFINE_PER_CPU(struct timer_list, tt_report_timer);
+
+static DEFINE_PER_CPU(unsigned long, last_time);
+static DEFINE_PER_CPU(unsigned long, thermal_throttle_count);
+static DEFINE_PER_CPU(unsigned long, last_count);
+static DEFINE_PER_CPU(atomic_t, tt_enabled);
+
+#define define_one_ro(_name)                                                 \
+        static SYSDEV_ATTR(_name, 0444, show_##_name, NULL)
+
+#define define_show_func(name)                                               \
+static ssize_t show_##name(struct sys_device *dev, char *buf)                \
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
+define_show_func(count);
+define_one_ro(count);
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
+
+/* tt_report_timer_tick -
+ *    This timer was started by the interrupt to prevent spamming the logs.
+ *    When it fires, we clear the flag to allow another log update.
+ */
+static void tt_report_timer_tick(unsigned long cpu)
+{
+	atomic_set(&per_cpu(tt_report_flag, cpu), 0);
+}
+
+/* thermal_throttle_count_init -
+ *    Initialize all the internal state variables. The inits to 0 are not
+ *    that important since the BSS is always 0 in kernel.
+ *
+ *    This function should be called ONLY if thermal throttle detection was
+ *    enabled on this 'cpu'.
+ */
+void __cpuinit thermal_throttle_count_init(unsigned int cpu)
+{
+	per_cpu(last_time, cpu)  = INITIAL_JIFFIES;
+	per_cpu(thermal_throttle_count, cpu) = 0;
+	per_cpu(last_count, cpu) = 0;
+
+	/* initialize the check-flag-timer */
+	init_timer(&per_cpu(tt_report_timer, cpu));
+	per_cpu(tt_report_timer, cpu).function = tt_report_timer_tick;
+	per_cpu(tt_report_timer, cpu).data = cpu;
+
+	/* mark us as enabled */
+	atomic_set(&per_cpu(tt_enabled, cpu), 1);
+	return;
+}
+
+/* thermal_throttle_inc_count -
+ *    This function is normally called by the thermal interrupt if
+ *    the code determines that we just entered into a thermal event.
+ */
+void thermal_throttle_inc_count(void)
+{
+	__get_cpu_var(thermal_throttle_count)++;
+}
+
+/* thermal_throttle_process_event -
+ *    This function is normally called by the thermal interrupt,
+ *    after the thermal event has been counted by calling
+ *    thermal_throttle_inc_count().
+ *
+ *    evinfo is a pointer to astructure where event info will be filled in.
+ *    Currently that's just the cpu#, time since last logged event, and
+ *    number of skipped (silently counted) events since last logged
+ *    event.
+ *
+ *    Since the thermal interrupt normally gets called both when the thermal
+ *    event begins and once the event has ended, the caller passes in a
+ *    boolean 'curr' to specify whether or not it is currently IN the
+ *    thermal event.
+ *
+ *  Returns: 0 : Event should NOT be further logged, i.e. still in
+ *               "timeout" from previous log message.
+ *           1 : Event should be logged, and a message has been printed.
+ */
+int thermal_throttle_process_event(struct therm_throt_event_info *evinfo,
+				   int curr)
+{
+	unsigned int cpu = smp_processor_id();
+	__u64 intvl;
+	__u64 intvl_cnt;
+
+	/* Prevent flooding the logs with thermal entries */
+	if (atomic_read(&__get_cpu_var(tt_report_flag)))
+		return 0;
+
+	/* set the flag, and add the timer that will clear it */
+	atomic_set(&__get_cpu_var(tt_report_flag), 1);
+	__get_cpu_var(tt_report_timer).expires = jiffies + CHECK_INTERVAL;
+	add_timer_on(&__get_cpu_var(tt_report_timer), cpu);
+
+	/* get the interval */
+	intvl = (jiffies - __get_cpu_var(last_time)) / HZ;
+
+	/* get the count for the interval */
+	intvl_cnt = __get_cpu_var(thermal_throttle_count) -
+		    __get_cpu_var(last_count);
+
+	/* check > 1 because the current event should not be used for
+	 * historical report */
+	if (intvl_cnt > 1) {
+		printk(KERN_CRIT "CPU%d: Temperature exceeded threshold %llu "
+		       "time(s) over last %llu second(s)\n", cpu, intvl_cnt,
+		       intvl);
+	}
+
+	/* if we just entered the thermal event */
+	if (curr) {
+		printk(KERN_CRIT "CPU%d: Temperature above threshold, "
+		       "cpu clock throttled\n", cpu);
+		add_taint(TAINT_MACHINE_CHECK);
+	} else {
+		printk(KERN_CRIT "CPU%d: Temperature/speed normal\n", cpu);
+	}
+
+	/* update the values for next time */
+	__get_cpu_var(last_count) = __get_cpu_var(thermal_throttle_count);
+	__get_cpu_var(last_time)  = jiffies;
+
+	/* fill in the info structure */
+	if (evinfo) {
+		evinfo->interval = intvl;
+		evinfo->interval_count = intvl_cnt;
+		evinfo->cpu = cpu;
+	}
+
+	return 1;
+}
+
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
+	}ss
+	return NOTIFY_OK;
+}
+
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
+	/* connect to sysfs */
+	for_each_online_cpu(cpu) {
+		preempt_disable();
+		if (cpu_online(cpu)) {
+			if (atomic_read(&per_cpu(tt_enabled, cpu)))
+				thermal_throttle_add_dev(get_cpu_sysdev(cpu));
+		}
+		preempt_enable();
+	}
+
+#ifdef CONFIG_HOTPLUG_CPU
+	register_hotcpu_notifier(&thermal_throttle_cpu_notifier);
+#endif
+	return 0;
+}
+
+device_initcall(thermal_throttle_init_device);
diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
index b5aaeaf..d97cec0 100644
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -11,7 +11,7 @@ obj-y	:= process.o signal.o entry.o trap
 		pci-dma.o pci-nommu.o alternative.o
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
-obj-$(CONFIG_X86_MCE)         += mce.o
+obj-$(CONFIG_X86_MCE)		+= mce.o therm_throt.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
 obj-$(CONFIG_X86_MCE_AMD)	+= mce_amd.o
 obj-$(CONFIG_MTRR)		+= ../../i386/kernel/cpu/mtrr/
@@ -45,6 +45,7 @@ obj-y				+= intel_cacheinfo.o
 
 CFLAGS_vsyscall.o		:= $(PROFILING) -g0
 
+therm_throt-y                   += ../../i386/kernel/cpu/mcheck/therm_throt.o
 bootflag-y			+= ../../i386/kernel/bootflag.o
 cpuid-$(subst m,y,$(CONFIG_X86_CPUID))  += ../../i386/kernel/cpuid.o
 topology-y                     += ../../i386/kernel/topology.o
@@ -54,4 +55,3 @@ quirks-y			+= ../../i386/kernel/quirks.o
 i8237-y				+= ../../i386/kernel/i8237.o
 msr-$(subst m,y,$(CONFIG_X86_MSR))  += ../../i386/kernel/msr.o
 alternative-y			+= ../../i386/kernel/alternative.o
-
diff --git a/arch/x86_64/kernel/mce.c b/arch/x86_64/kernel/mce.c
index 4e017fb..d331c85 100644
--- a/arch/x86_64/kernel/mce.c
+++ b/arch/x86_64/kernel/mce.c
@@ -22,6 +22,7 @@ #include <linux/ctype.h>
 #include <asm/processor.h> 
 #include <asm/msr.h>
 #include <asm/mce.h>
+#include <asm/therm_throt.h>
 #include <asm/kdebug.h>
 #include <asm/uaccess.h>
 #include <asm/smp.h>
@@ -500,6 +501,55 @@ static struct miscdevice mce_log_device 
 	&mce_chrdev_ops,
 };
 
+/* mce_log_thermal_throttle_event -
+ *     Add an mce_log entry for the thermal throttle event 'evinfo'. 'status'
+ *     should be whatever the user wants to put into the mce.status field,
+ *     and historically has been the register value of the
+ *     MSR_IA32_THERMAL_STATUS.
+ *
+ *     This will typically be called from a thermal throttle interrupt
+ *     if the event should be logged.
+ */
+void mce_log_thermal_throttle_event(__u64 status,
+				    struct therm_throt_event_info *evinfo)
+{
+	struct mce m;
+
+	memset(&m, 0, sizeof(m));
+	m.cpu = evinfo->cpu;
+	m.bank = MCE_THERMAL_BANK;
+	m.status = status;
+	rdtscll(m.tsc);
+
+	/* save the delta of the throttle count to let the consumer of this
+	 * information know how many throttle instances have been seen.
+	 *
+	 * 'misc' is organized below as follows:
+	 * bits 15:0  - Contains a capped value of thermal events for last
+	 *              interval.
+	 * bits 31:16 - Time in seconds to qualify the interval
+	 *              (capped at 0xffff)
+	 *
+	 * We cap events count at 16 bits to leave room in 'misc' for future
+	 * extensions to this report */
+
+	/* cap values in m.misc for mce_log purposes */
+
+	if (evinfo->interval > 0xffff)
+		m.misc = 0xffff;
+	else
+		m.misc = evinfo->interval;
+	m.misc <<= 16;
+
+	if (unlikely(evinfo->interval_count > 0xffff))
+		m.misc |= 0xffff;
+	else
+		m.misc |= evinfo->interval_count;
+
+	mce_log(&m);
+	return;
+}
+
 /* 
  * Old style boot options parsing. Only for compatibility. 
  */
diff --git a/arch/x86_64/kernel/mce_intel.c b/arch/x86_64/kernel/mce_intel.c
index 8f533d2..d658f42 100644
--- a/arch/x86_64/kernel/mce_intel.c
+++ b/arch/x86_64/kernel/mce_intel.c
@@ -11,36 +11,27 @@ #include <asm/msr.h>
 #include <asm/mce.h>
 #include <asm/hw_irq.h>
 #include <asm/idle.h>
-
-static DEFINE_PER_CPU(unsigned long, next_check);
+#include <asm/therm_throt.h>
 
 asmlinkage void smp_thermal_interrupt(void)
 {
-	struct mce m;
+	__u64 msr_val;
+	struct therm_throt_event_info event;
 
 	ack_APIC_irq();
 
 	exit_idle();
 	irq_enter();
-	if (time_before(jiffies, __get_cpu_var(next_check)))
-		goto done;
-
-	__get_cpu_var(next_check) = jiffies + HZ*300;
-	memset(&m, 0, sizeof(m));
-	m.cpu = smp_processor_id();
-	m.bank = MCE_THERMAL_BANK;
-	rdtscll(m.tsc);
-	rdmsrl(MSR_IA32_THERM_STATUS, m.status);
-	if (m.status & 0x1) {
-		printk(KERN_EMERG
-			"CPU%d: Temperature above threshold, cpu clock throttled\n", m.cpu);
-		add_taint(TAINT_MACHINE_CHECK);
-	} else {
-		printk(KERN_EMERG "CPU%d: Temperature/speed normal\n", m.cpu);
+
+	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
+	if (msr_val & 0x1)
+		thermal_throttle_inc_count();
+
+	/* process the event, and log to mce_log if necessary */
+	if (thermal_throttle_process_event(&event, (msr_val & 1))) {
+		mce_log_thermal_throttle_event(msr_val, &event);
 	}
 
-	mce_log(&m);
-done:
 	irq_exit();
 }
 
@@ -88,6 +79,9 @@ static void __cpuinit intel_init_thermal
 	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
 	wrmsr(MSR_IA32_MISC_ENABLE, l | (1 << 3), h);
 
+	/* init thermal throttle counting before re-enabling the interrupt */
+	thermal_throttle_count_init(cpu);
+
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 	printk(KERN_INFO "CPU%d: Thermal monitoring enabled (%s)\n",
diff --git a/include/asm-i386/therm_throt.h b/include/asm-i386/therm_throt.h
new file mode 100644
index 0000000..228122c
--- /dev/null
+++ b/include/asm-i386/therm_throt.h
@@ -0,0 +1,17 @@
+#ifndef __ASM_I386_THERM_THROT_H__
+#define __ASM_I386_THERM_THROT_H__ 1
+
+#include <asm/types.h>
+
+struct therm_throt_event_info {
+	__u64 interval;
+	__u64 interval_count;
+	unsigned int cpu;
+};
+
+void __cpuinit thermal_throttle_count_init(unsigned int cpu);
+void thermal_throttle_inc_count(void);
+int thermal_throttle_process_event(struct therm_throt_event_info *evinfo,
+				   int curr);
+
+#endif /* __ASM_I386_THERM_THROT_H__ */
diff --git a/include/asm-x86_64/mce.h b/include/asm-x86_64/mce.h
index d13687d..0ba1b4d 100644
--- a/include/asm-x86_64/mce.h
+++ b/include/asm-x86_64/mce.h
@@ -3,6 +3,7 @@ #define _ASM_MCE_H 1
 
 #include <asm/ioctls.h>
 #include <asm/types.h>
+#include <asm/therm_throt.h>
 
 /* 
  * Machine Check support for x86
@@ -99,6 +100,9 @@ static inline void mce_amd_feature_init(
 }
 #endif
 
+void mce_log_thermal_throttle_event(__u64 status,
+				    struct therm_throt_event_info *evinfo);
+
 extern atomic_t mce_entry;
 
 #endif
diff --git a/include/asm-x86_64/therm_throt.h b/include/asm-x86_64/therm_throt.h
new file mode 100644
index 0000000..5aac059
--- /dev/null
+++ b/include/asm-x86_64/therm_throt.h
@@ -0,0 +1 @@
+#include <asm-i386/therm_throt.h>
-- 
1.4.2

