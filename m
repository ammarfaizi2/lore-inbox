Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbTFQOkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTFQOkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:40:21 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:50961 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264759AbTFQOkA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:40:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10558616341836@movementarian.org>
Subject: [PATCH 2/3] OProfile: IO-APIC based NMI delivery
In-Reply-To: <10558616342231@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 17 Jun 2003 15:53:54 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19SHqN-000BnO-EO*RWWqWk75Z8A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the IO-APIC NMI delivery when the local APIC performance counter delivery is
not available. By Zwane Mwaikambo.

diff -Naur -X dontdiff linux-cvs/arch/i386/kernel/nmi.c linux-fixes/arch/i386/kernel/nmi.c
--- linux-cvs/arch/i386/kernel/nmi.c	2003-06-12 02:46:46.000000000 +0100
+++ linux-fixes/arch/i386/kernel/nmi.c	2003-06-15 19:00:08.000000000 +0100
@@ -23,17 +23,27 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
+#include <linux/nmi.h>
 #include <linux/sysdev.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
+#include <asm/nmi.h>
 
 unsigned int nmi_watchdog = NMI_NONE;
 static unsigned int nmi_hz = HZ;
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 extern void show_registers(struct pt_regs *regs);
 
+/* nmi_active:
+ * +1: the lapic NMI watchdog is active, but can be disabled
+ *  0: the lapic NMI watchdog has not been set up, and cannot
+ *     be enabled
+ * -1: the lapic NMI watchdog is disabled, but can be enabled
+ */
+static int nmi_active;
+
 #define K7_EVNTSEL_ENABLE	(1 << 22)
 #define K7_EVNTSEL_INT		(1 << 20)
 #define K7_EVNTSEL_OS		(1 << 17)
@@ -91,6 +101,7 @@
 			continue;
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
+			nmi_active = 0;
 			return -1;
 		}
 	}
@@ -131,21 +142,15 @@
 	 * We can enable the IO-APIC watchdog
 	 * unconditionally.
 	 */
-	if (nmi == NMI_IO_APIC)
+	if (nmi == NMI_IO_APIC) {
+		nmi_active = 1;
 		nmi_watchdog = nmi;
+	}
 	return 1;
 }
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-/* nmi_active:
- * +1: the lapic NMI watchdog is active, but can be disabled
- *  0: the lapic NMI watchdog has not been set up, and cannot
- *     be enabled
- * -1: the lapic NMI watchdog is disabled, but can be enabled
- */
-static int nmi_active;
-
 void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
@@ -179,6 +184,27 @@
 	}
 }
 
+void disable_timer_nmi_watchdog(void)
+{
+	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
+		return;
+
+	disable_irq(0);
+	unset_nmi_callback();
+	nmi_active = -1;
+	nmi_watchdog = NMI_NONE;
+}
+
+void enable_timer_nmi_watchdog(void)
+{
+	if (nmi_active < 0) {
+		nmi_watchdog = NMI_IO_APIC;
+		touch_nmi_watchdog();
+		nmi_active = 1;
+		enable_irq(0);
+	}
+}
+
 #ifdef CONFIG_PM
 
 static int nmi_pm_active; /* nmi_active before suspend */
@@ -429,3 +455,5 @@
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
 EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
+EXPORT_SYMBOL(disable_timer_nmi_watchdog);
+EXPORT_SYMBOL(enable_timer_nmi_watchdog);
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/init.c linux-fixes/arch/i386/oprofile/init.c
--- linux-cvs/arch/i386/oprofile/init.c	2003-06-15 03:30:51.000000000 +0100
+++ linux-fixes/arch/i386/oprofile/init.c	2003-06-15 19:05:04.000000000 +0100
@@ -16,15 +16,21 @@
  */
  
 extern int nmi_init(struct oprofile_operations ** ops);
+extern int nmi_timer_init(struct oprofile_operations **ops);
 extern void nmi_exit(void);
 
 int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
+	int ret = -ENODEV;
 #ifdef CONFIG_X86_LOCAL_APIC
-	return nmi_init(ops);
-#else
-	return -ENODEV;
+	ret = nmi_init(ops);
 #endif
+
+#ifdef CONFIG_X86_IO_APIC
+	if (ret < 0)
+		ret = nmi_timer_init(ops);
+#endif
+	return ret;
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/Makefile linux-fixes/arch/i386/oprofile/Makefile
--- linux-cvs/arch/i386/oprofile/Makefile	2003-06-15 02:06:38.000000000 +0100
+++ linux-fixes/arch/i386/oprofile/Makefile	2003-06-15 19:00:08.000000000 +0100
@@ -9,3 +9,4 @@
 oprofile-y				:= $(DRIVER_OBJS) init.o
 oprofile-$(CONFIG_X86_LOCAL_APIC) 	+= nmi_int.o op_model_athlon.o \
 					   op_model_ppro.o op_model_p4.o
+oprofile-$(CONFIG_X86_IO_APIC)		+= nmi_timer_int.o
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/nmi_timer_int.c linux-fixes/arch/i386/oprofile/nmi_timer_int.c
--- linux-cvs/arch/i386/oprofile/nmi_timer_int.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-fixes/arch/i386/oprofile/nmi_timer_int.c	2003-06-15 19:04:34.000000000 +0100
@@ -0,0 +1,57 @@
+/**
+ * @file nmi_timer_int.c
+ *
+ * @remark Copyright 2003 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author Zwane Mwaikambo <zwane@linuxpower.ca>
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+#include <linux/oprofile.h>
+#include <linux/rcupdate.h>
+
+
+#include <asm/nmi.h>
+#include <asm/apic.h>
+#include <asm/ptrace.h>
+ 
+static int nmi_timer_callback(struct pt_regs * regs, int cpu)
+{
+	unsigned long eip = instruction_pointer(regs);
+ 
+	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
+	return 1;
+}
+
+static int timer_start(void)
+{
+	disable_timer_nmi_watchdog();
+	set_nmi_callback(nmi_timer_callback);
+	return 0;
+}
+
+
+static void timer_stop(void)
+{
+	enable_timer_nmi_watchdog();
+	unset_nmi_callback();
+	synchronize_kernel();
+}
+
+
+static struct oprofile_operations nmi_timer_ops = {
+	.start	= timer_start,
+	.stop	= timer_stop,
+	.cpu_type = "timer"
+};
+
+ 
+int __init nmi_timer_init(struct oprofile_operations ** ops)
+{
+	*ops = &nmi_timer_ops;
+	printk(KERN_INFO "oprofile: using NMI timer interrupt.\n");
+	return 0;
+}
diff -Naur -X dontdiff linux-cvs/include/asm-i386/apic.h linux-fixes/include/asm-i386/apic.h
--- linux-cvs/include/asm-i386/apic.h	2003-06-15 15:50:14.000000000 +0100
+++ linux-fixes/include/asm-i386/apic.h	2003-06-15 19:00:08.000000000 +0100
@@ -81,6 +81,8 @@
 extern void setup_apic_nmi_watchdog (void);
 extern void disable_lapic_nmi_watchdog(void);
 extern void enable_lapic_nmi_watchdog(void);
+extern void disable_timer_nmi_watchdog(void);
+extern void enable_timer_nmi_watchdog(void);
 extern inline void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);

