Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWITCni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWITCni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 22:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWITCnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 22:43:17 -0400
Received: from smtp-out.google.com ([216.239.45.12]:54043 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750840AbWITCnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 22:43:07 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer:
	in-reply-to:references;
	b=PerAD6Td5zFRFV+spHTQfeWuVjN61HsAPomjwpRJUPDVwDdwQmuu/TN79YMOTs4cG
	YzY8xBYr5sRFblaAK63hA==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [PATCH 1/4] x86_64/i386 thermal mce: Refactor thermal throttle reporting.
Date: Tue, 19 Sep 2006 19:42:39 -0700
Message-Id: <11587201623187-git-send-email-dmitriyz@google.com>
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11587201623432-git-send-email-dmitriyz@google.com>
References: <11587201623432-git-send-email-dmitriyz@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Refactor the event processing (syslog/mcelog messaging and rate limiting)
  into separate file therm_throt.c.
- After ACK'ing the interrupt, if the event is current, the user
  (p4.c/mce_intel.c) just has to make a single call to take care of logging
  the event.

Signed-off-by: Dmitriy Zavin <dmitriyz@google.com>
---
 arch/i386/kernel/cpu/mcheck/Makefile      |    2 -
 arch/i386/kernel/cpu/mcheck/p4.c          |   23 ++------
 arch/i386/kernel/cpu/mcheck/therm_throt.c |   79 +++++++++++++++++++++++++++++
 arch/x86_64/kernel/Makefile               |    4 +
 arch/x86_64/kernel/mce_intel.c            |   26 ++--------
 include/asm-i386/therm_throt.h            |    8 +++
 include/asm-x86_64/therm_throt.h          |    1 
 7 files changed, 102 insertions(+), 41 deletions(-)

diff --git a/arch/i386/kernel/cpu/mcheck/Makefile b/arch/i386/kernel/cpu/mcheck/Makefile
index 30808f3..f1ebe1c 100644
--- a/arch/i386/kernel/cpu/mcheck/Makefile
+++ b/arch/i386/kernel/cpu/mcheck/Makefile
@@ -1,2 +1,2 @@
-obj-y	=	mce.o k7.o p4.o p5.o p6.o winchip.o
+obj-y	=	mce.o k7.o p4.o p5.o p6.o winchip.o therm_throt.o
 obj-$(CONFIG_X86_MCE_NONFATAL)	+=	non-fatal.o
diff --git a/arch/i386/kernel/cpu/mcheck/p4.c b/arch/i386/kernel/cpu/mcheck/p4.c
index b95f1b3..5f9896f 100644
--- a/arch/i386/kernel/cpu/mcheck/p4.c
+++ b/arch/i386/kernel/cpu/mcheck/p4.c
@@ -13,6 +13,8 @@ #include <asm/system.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
 
+#include <asm/therm_throt.h>
+
 #include "mce.h"
 
 /* as supported by the P4/Xeon family */
@@ -44,25 +46,12 @@ static void unexpected_thermal_interrupt
 /* P4/Xeon Thermal transition interrupt handler */
 static void intel_thermal_interrupt(struct pt_regs *regs)
 {
-	u32 l, h;
-	unsigned int cpu = smp_processor_id();
-	static unsigned long next[NR_CPUS];
+	__u64 msr_val;
 
 	ack_APIC_irq();
 
-	if (time_after(next[cpu], jiffies))
-		return;
-
-	next[cpu] = jiffies + HZ*5;
-	rdmsr(MSR_IA32_THERM_STATUS, l, h);
-	if (l & 0x1) {
-		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
-		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n",
-				cpu);
-		add_taint(TAINT_MACHINE_CHECK);
-	} else {
-		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
-	}
+	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
+	therm_throt_process(msr_val & 0x1, msr_val);
 }
 
 /* Thermal interrupt handler for this CPU setup */
@@ -122,7 +111,7 @@ static void intel_init_thermal(struct cp
 	
 	rdmsr (MSR_IA32_MISC_ENABLE, l, h);
 	wrmsr (MSR_IA32_MISC_ENABLE, l | (1<<3), h);
-	
+
 	l = apic_read (APIC_LVTTHMR);
 	apic_write_around (APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 	printk (KERN_INFO "CPU%d: Thermal monitoring enabled\n", cpu);
diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
new file mode 100644
index 0000000..342750e
--- /dev/null
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -0,0 +1,79 @@
+/*
+ * linux/arch/i386/kerne/cpu/mcheck/therm_throt.c
+ *
+ * Thermal throttle event support code.
+ *
+ * Author: Dmitriy Zavin (dmitriyz@google.com)
+ *
+ * Credits: Adapted from Zwane Mwaikambo's original code in mce_intel.c.
+ *
+ */
+
+#include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <asm/cpu.h>
+#include <linux/notifier.h>
+#include <asm/therm_throt.h>
+
+#ifdef CONFIG_X86_64
+#include <asm/mce.h>
+#endif /* CONFIG_X86_64 */
+
+/* How long to wait between reporting thermal events */
+#define CHECK_INTERVAL              (300 * HZ)
+
+static DEFINE_PER_CPU(unsigned long, next_check);
+
+#ifdef CONFIG_X86_64
+static void therm_throt_log_mce(unsigned int cpu, __u64 status)
+{
+	struct mce m;
+
+	memset(&m, 0, sizeof(m));
+	m.cpu = cpu;
+	m.bank = MCE_THERMAL_BANK;
+	m.status = status;
+	rdtscll(m.tsc);
+	mce_log(&m);
+}
+#endif /* CONFIG_X86_64 */
+
+/***
+ * therm_throt_process - Process thermal throttling event
+ * @curr: Whether the condition is current or not (boolean), since the
+ *        thermal interrupt normally gets called both when the thermal
+ *        event begins and once the event has ended.
+ * @status: Event status information.
+ *
+ * This function is normally called by the thermal interrupt after the
+ * IRQ has been acknowledged.
+ *
+ * It will take care of rate limiting and printing messages to the syslog.
+ *
+ * The status parameter is used for an mce_log entry (if available), and
+ * historically has been the register value of the MSR_IA32_THERMAL_STATUS
+ * msr.
+ */
+void therm_throt_process(int curr, __u64 status)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (time_before(jiffies, __get_cpu_var(next_check)))
+		return;
+
+	__get_cpu_var(next_check) = jiffies + CHECK_INTERVAL;
+
+	/* if we just entered the thermal event */
+	if (curr) {
+		printk(KERN_CRIT "CPU%d: Temperature above threshold, "
+		       "cpu clock throttled\n", cpu);
+		add_taint(TAINT_MACHINE_CHECK);
+
+#ifdef CONFIG_X86_64
+		therm_throt_log_mce(cpu, status);
+#endif
+	} else {
+		printk(KERN_CRIT "CPU%d: Temperature/speed normal\n", cpu);
+	}
+
+}
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
diff --git a/arch/x86_64/kernel/mce_intel.c b/arch/x86_64/kernel/mce_intel.c
index 8f533d2..a13096e 100644
--- a/arch/x86_64/kernel/mce_intel.c
+++ b/arch/x86_64/kernel/mce_intel.c
@@ -11,36 +11,20 @@ #include <asm/msr.h>
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
-	}
 
-	mce_log(&m);
-done:
+	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
+	therm_throt_process(msr_val & 1, msr_val);
+
 	irq_exit();
 }
 
diff --git a/include/asm-i386/therm_throt.h b/include/asm-i386/therm_throt.h
new file mode 100644
index 0000000..c6e638b
--- /dev/null
+++ b/include/asm-i386/therm_throt.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_I386_THERM_THROT_H__
+#define __ASM_I386_THERM_THROT_H__ 1
+
+#include <asm/types.h>
+
+void therm_throt_process(int curr, __u64 status);
+
+#endif /* __ASM_I386_THERM_THROT_H__ */
diff --git a/include/asm-x86_64/therm_throt.h b/include/asm-x86_64/therm_throt.h
new file mode 100644
index 0000000..5aac059
--- /dev/null
+++ b/include/asm-x86_64/therm_throt.h
@@ -0,0 +1 @@
+#include <asm-i386/therm_throt.h>
-- 
1.4.2

