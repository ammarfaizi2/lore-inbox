Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTECXdC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 19:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbTECXcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 19:32:31 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:60427 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263479AbTECXbp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 19:31:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052005446607@movementarian.org>
Subject: [PATCH 2/8] OProfile update
In-Reply-To: <10520054422453@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Sun, 4 May 2003 00:44:06 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Spam-Score: -6.3 (------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C6fm-000JiB-QX*1IhsQELY7cw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Consolidate all the arch copies of timer_int.c into one place. Also fixes
a problem with PA-RISC not using instruction_pointer() when it should.

diff -Naur -X dontdiff linux-cvs/arch/alpha/oprofile/Makefile linux-me/arch/alpha/oprofile/Makefile
--- linux-cvs/arch/alpha/oprofile/Makefile	2003-02-23 18:27:21.000000000 +0000
+++ linux-me/arch/alpha/oprofile/Makefile	2003-04-29 01:17:51.000000000 +0100
@@ -5,7 +5,8 @@
 DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 		oprof.o cpu_buffer.o buffer_sync.o \
 		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o )
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
 
 oprofile-y				:= $(DRIVER_OBJS) common.o
 oprofile-$(CONFIG_ALPHA_GENERIC)	+= op_model_ev4.o \
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/init.c linux-me/arch/i386/oprofile/init.c
--- linux-cvs/arch/i386/oprofile/init.c	2003-04-05 18:44:23.000000000 +0100
+++ linux-me/arch/i386/oprofile/init.c	2003-04-29 01:17:00.000000000 +0100
@@ -11,22 +11,19 @@
 #include <linux/init.h>
  
 /* We support CPUs that have performance counters like the Pentium Pro
- * with NMI mode samples. Other x86 CPUs use a simple interrupt keyed
- * off the timer interrupt, which cannot profile interrupts-disabled
- * code unlike the NMI-based code.
+ * with the NMI mode driver.
  */
  
 extern int nmi_init(struct oprofile_operations ** ops);
 extern void nmi_exit(void);
-extern void timer_init(struct oprofile_operations ** ops);
 
 int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (!nmi_init(ops))
+	return nmi_init(ops);
+#else
+	return -ENODEV;
 #endif
-		timer_init(ops);
-	return 0;
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/Makefile linux-me/arch/i386/oprofile/Makefile
--- linux-cvs/arch/i386/oprofile/Makefile	2003-02-11 20:25:24.000000000 +0000
+++ linux-me/arch/i386/oprofile/Makefile	2003-04-29 01:11:32.000000000 +0100
@@ -3,8 +3,9 @@
 DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 		oprof.o cpu_buffer.o buffer_sync.o \
 		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o )
+		oprofilefs.o oprofile_stats.o  \
+		timer_int.o )
 
-oprofile-y				:= $(DRIVER_OBJS) init.o timer_int.o
+oprofile-y				:= $(DRIVER_OBJS) init.o
 oprofile-$(CONFIG_X86_LOCAL_APIC) 	+= nmi_int.o op_model_athlon.o \
 					   op_model_ppro.o op_model_p4.o
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/nmi_int.c linux-me/arch/i386/oprofile/nmi_int.c
--- linux-cvs/arch/i386/oprofile/nmi_int.c	2003-04-05 18:44:23.000000000 +0100
+++ linux-me/arch/i386/oprofile/nmi_int.c	2003-04-29 01:16:50.000000000 +0100
@@ -314,13 +314,13 @@
 	__u8 family = current_cpu_data.x86;
  
 	if (!cpu_has_apic)
-		return 0;
+		return -ENODEV;
  
 	switch (vendor) {
 		case X86_VENDOR_AMD:
 			/* Needs to be at least an Athlon (or hammer in 32bit mode) */
 			if (family < 6)
-				return 0;
+				return -ENODEV;
 			model = &op_athlon_spec;
 			nmi_ops.cpu_type = "i386/athlon";
 			break;
@@ -331,30 +331,30 @@
 				/* Pentium IV */
 				case 0xf:
 					if (!p4_init())
-						return 0;
+						return -ENODEV;
 					break;
 
 				/* A P6-class processor */
 				case 6:
 					if (!ppro_init())
-						return 0;
+						return -ENODEV;
 					break;
 
 				default:
-					return 0;
+					return -ENODEV;
 			}
 			break;
 #endif /* !CONFIG_X86_64 */
 
 		default:
-			return 0;
+			return -ENODEV;
 	}
 
 	init_driverfs();
 	using_nmi = 1;
 	*ops = &nmi_ops;
 	printk(KERN_INFO "oprofile: using NMI interrupt.\n");
-	return 1;
+	return 0;
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/timer_int.c linux-me/arch/i386/oprofile/timer_int.c
--- linux-cvs/arch/i386/oprofile/timer_int.c	2003-02-11 20:26:06.000000000 +0000
+++ linux-me/arch/i386/oprofile/timer_int.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,58 +0,0 @@
-/**
- * @file timer_int.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/notifier.h>
-#include <linux/smp.h>
-#include <linux/irq.h>
-#include <linux/oprofile.h>
-#include <asm/ptrace.h>
- 
-#include "op_counter.h"
- 
-static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
-{
-	struct pt_regs * regs = (struct pt_regs *)data;
-	int cpu = smp_processor_id();
-	unsigned long eip = instruction_pointer(regs);
- 
-	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
-	return 0;
-}
- 
- 
-static struct notifier_block timer_notifier = {
-	.notifier_call	= timer_notify,
-};
- 
-
-static int timer_start(void)
-{
-	return register_profile_notifier(&timer_notifier);
-}
-
-
-static void timer_stop(void)
-{
-	unregister_profile_notifier(&timer_notifier);
-}
-
-
-static struct oprofile_operations timer_ops = {
-	.start	= timer_start,
-	.stop	= timer_stop,
-	.cpu_type = "timer"
-};
-
- 
-void __init timer_init(struct oprofile_operations ** ops)
-{
-	*ops = &timer_ops;
-	printk(KERN_INFO "oprofile: using timer interrupt.\n");
-}
diff -Naur -X dontdiff linux-cvs/arch/parisc/oprofile/init.c linux-me/arch/parisc/oprofile/init.c
--- linux-cvs/arch/parisc/oprofile/init.c	2003-04-05 18:44:29.000000000 +0100
+++ linux-me/arch/parisc/oprofile/init.c	2003-04-29 01:24:09.000000000 +0100
@@ -15,8 +15,7 @@
 
 int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
-	timer_init(ops);
-	return 0;
+	return -ENODEV;
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/parisc/oprofile/Makefile linux-me/arch/parisc/oprofile/Makefile
--- linux-cvs/arch/parisc/oprofile/Makefile	2003-01-13 21:24:33.000000000 +0000
+++ linux-me/arch/parisc/oprofile/Makefile	2003-04-29 01:24:18.000000000 +0100
@@ -3,6 +3,7 @@
 DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 		oprof.o cpu_buffer.o buffer_sync.o \
 		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o )
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
 
-oprofile-y				:= $(DRIVER_OBJS) init.o timer_int.o
+oprofile-y				:= $(DRIVER_OBJS) init.o
diff -Naur -X dontdiff linux-cvs/arch/parisc/oprofile/timer_int.c linux-me/arch/parisc/oprofile/timer_int.c
--- linux-cvs/arch/parisc/oprofile/timer_int.c	2003-02-11 20:26:06.000000000 +0000
+++ linux-me/arch/parisc/oprofile/timer_int.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,58 +0,0 @@
-/**
- * @file timer_int.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/notifier.h>
-#include <linux/smp.h>
-#include <linux/irq.h>
-#include <linux/oprofile.h>
-#include <asm/ptrace.h>
- 
-static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
-{
-	struct pt_regs * regs = (struct pt_regs *)data;
-	int cpu = smp_processor_id();
-	unsigned long pc = regs->iaoq[0];
-	int is_kernel = !user_mode(regs);
- 
-	oprofile_add_sample(pc, is_kernel, 0, cpu);
-	return 0;
-}
- 
- 
-static struct notifier_block timer_notifier = {
-	.notifier_call	= timer_notify,
-};
- 
-
-static int timer_start(void)
-{
-	return register_profile_notifier(&timer_notifier);
-}
-
-
-static void timer_stop(void)
-{
-	unregister_profile_notifier(&timer_notifier);
-}
-
-
-static struct oprofile_operations timer_ops = {
-	.start	= timer_start,
-	.stop	= timer_stop,
-	.cpu_type = "timer"
-};
-
- 
-void __init timer_init(struct oprofile_operations ** ops)
-{
-	*ops = &timer_ops;
-	printk(KERN_INFO "oprofile: using timer interrupt.\n");
-}
diff -Naur -X dontdiff linux-cvs/arch/ppc64/oprofile/init.c linux-me/arch/ppc64/oprofile/init.c
--- linux-cvs/arch/ppc64/oprofile/init.c	2003-04-05 18:44:32.000000000 +0100
+++ linux-me/arch/ppc64/oprofile/init.c	2003-04-29 01:23:33.000000000 +0100
@@ -15,8 +15,7 @@
 
 int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
-	timer_init(ops);
-	return 0;
+	return -ENODEV;
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/ppc64/oprofile/Makefile linux-me/arch/ppc64/oprofile/Makefile
--- linux-cvs/arch/ppc64/oprofile/Makefile	2003-01-02 19:32:40.000000000 +0000
+++ linux-me/arch/ppc64/oprofile/Makefile	2003-04-29 01:24:29.000000000 +0100
@@ -3,6 +3,7 @@
 DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
 		oprof.o cpu_buffer.o buffer_sync.o \
 		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o )
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
 
-oprofile-y := $(DRIVER_OBJS) init.o timer_int.o
+oprofile-y := $(DRIVER_OBJS) init.o
diff -Naur -X dontdiff linux-cvs/arch/ppc64/oprofile/timer_int.c linux-me/arch/ppc64/oprofile/timer_int.c
--- linux-cvs/arch/ppc64/oprofile/timer_int.c	2003-02-22 07:55:49.000000000 +0000
+++ linux-me/arch/ppc64/oprofile/timer_int.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,59 +0,0 @@
-/**
- * @file timer_int.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/notifier.h>
-#include <linux/smp.h>
-#include <linux/irq.h>
-#include <linux/oprofile.h>
-#include <linux/profile.h>
-#include <asm/ptrace.h>
- 
-static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
-{
-	struct pt_regs * regs = (struct pt_regs *)data;
-	int cpu = smp_processor_id();
-	unsigned long pc = instruction_pointer(regs);
-	int is_kernel = !user_mode(regs);
- 
-	oprofile_add_sample(pc, is_kernel, 0, cpu);
-	return 0;
-}
- 
- 
-static struct notifier_block timer_notifier = {
-	.notifier_call	= timer_notify,
-};
- 
-
-static int timer_start(void)
-{
-	return register_profile_notifier(&timer_notifier);
-}
-
-
-static void timer_stop(void)
-{
-	unregister_profile_notifier(&timer_notifier);
-}
-
-
-static struct oprofile_operations timer_ops = {
-	.start	= timer_start,
-	.stop	= timer_stop,
-	.cpu_type = "timer"
-};
-
- 
-void __init timer_init(struct oprofile_operations ** ops)
-{
-	*ops = &timer_ops;
-	printk(KERN_INFO "oprofile: using timer interrupt.\n");
-}
diff -Naur -X dontdiff linux-cvs/arch/sparc64/oprofile/init.c linux-me/arch/sparc64/oprofile/init.c
--- linux-cvs/arch/sparc64/oprofile/init.c	2003-04-05 18:44:34.000000000 +0100
+++ linux-me/arch/sparc64/oprofile/init.c	2003-04-29 01:23:09.000000000 +0100
@@ -15,8 +15,7 @@
 
 int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
-	timer_init(ops);
-	return 0;
+	return -ENODEV;
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/sparc64/oprofile/Makefile linux-me/arch/sparc64/oprofile/Makefile
--- linux-cvs/arch/sparc64/oprofile/Makefile	2002-12-09 01:58:08.000000000 +0000
+++ linux-me/arch/sparc64/oprofile/Makefile	2003-04-29 01:20:27.000000000 +0100
@@ -3,6 +3,7 @@
 DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 		oprof.o cpu_buffer.o buffer_sync.o \
 		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o )
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
 
-oprofile-y				:= $(DRIVER_OBJS) init.o timer_int.o
+oprofile-y				:= $(DRIVER_OBJS) init.o
diff -Naur -X dontdiff linux-cvs/arch/sparc64/oprofile/timer_int.c linux-me/arch/sparc64/oprofile/timer_int.c
--- linux-cvs/arch/sparc64/oprofile/timer_int.c	2003-02-20 01:03:34.000000000 +0000
+++ linux-me/arch/sparc64/oprofile/timer_int.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,59 +0,0 @@
-/**
- * @file timer_int.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/notifier.h>
-#include <linux/smp.h>
-#include <linux/irq.h>
-#include <linux/oprofile.h>
-#include <linux/profile.h>
-#include <asm/ptrace.h>
- 
-static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
-{
-	struct pt_regs * regs = (struct pt_regs *)data;
-	int cpu = smp_processor_id();
-	unsigned long pc = instruction_pointer(regs);
-	int is_kernel = !user_mode(regs);
- 
-	oprofile_add_sample(pc, is_kernel, 0, cpu);
-	return 0;
-}
- 
- 
-static struct notifier_block timer_notifier = {
-	.notifier_call	= timer_notify,
-};
- 
-
-static int timer_start(void)
-{
-	return register_profile_notifier(&timer_notifier);
-}
-
-
-static void timer_stop(void)
-{
-	unregister_profile_notifier(&timer_notifier);
-}
-
-
-static struct oprofile_operations timer_ops = {
-	.start	= timer_start,
-	.stop	= timer_stop,
-	.cpu_type = "timer"
-};
-
- 
-void __init timer_init(struct oprofile_operations ** ops)
-{
-	*ops = &timer_ops;
-	printk(KERN_INFO "oprofile: using timer interrupt.\n");
-}
diff -Naur -X dontdiff linux-cvs/arch/x86_64/oprofile/Makefile linux-me/arch/x86_64/oprofile/Makefile
--- linux-cvs/arch/x86_64/oprofile/Makefile	2002-12-28 19:54:15.000000000 +0000
+++ linux-me/arch/x86_64/oprofile/Makefile	2003-04-29 01:19:24.000000000 +0100
@@ -9,9 +9,10 @@
 DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 	oprof.o cpu_buffer.o buffer_sync.o \
 	event_buffer.o oprofile_files.o \
-	oprofilefs.o oprofile_stats.o )
+	oprofilefs.o oprofile_stats.o \
+	timer_int.o )
  
-oprofile-objs := $(DRIVER_OBJS) init.o timer_int.o
+oprofile-objs := $(DRIVER_OBJS) init.o
 
 oprofile-$(CONFIG_X86_LOCAL_APIC) += nmi_int.o op_model_athlon.o
  
@@ -23,11 +24,9 @@
 	@ln -sf ../../i386/oprofile/op_model_athlon.c $(obj)/op_model_athlon.c
 $(obj)/init.c: ${INCL}
 	@ln -sf ../../i386/oprofile/init.c $(obj)/init.c
-$(obj)/timer_int.c: ${INCL}
-	@ln -sf ../../i386/oprofile/timer_int.c $(obj)/timer_int.c
 $(obj)/op_counter.h: 
 	@ln -sf ../../i386/oprofile/op_counter.h $(obj)/op_counter.h
 $(obj)/op_x86_model.h:
 	@ln -sf ../../i386/oprofile/op_x86_model.h $(obj)/op_x86_model.h	
-clean-files += op_x86_model.h op_counter.h timer_int.c init.c \
+clean-files += op_x86_model.h op_counter.h init.c \
 	       op_model_athlon.c nmi_int.c
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/timer_int.c linux-me/drivers/oprofile/timer_int.c
--- linux-cvs/drivers/oprofile/timer_int.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-me/drivers/oprofile/timer_int.c	2003-04-29 01:25:24.000000000 +0100
@@ -0,0 +1,56 @@
+/**
+ * @file timer_int.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+#include <linux/oprofile.h>
+#include <asm/ptrace.h>
+ 
+static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
+{
+	struct pt_regs * regs = (struct pt_regs *)data;
+	int cpu = smp_processor_id();
+	unsigned long eip = instruction_pointer(regs);
+ 
+	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
+	return 0;
+}
+ 
+ 
+static struct notifier_block timer_notifier = {
+	.notifier_call	= timer_notify,
+};
+ 
+
+static int timer_start(void)
+{
+	return register_profile_notifier(&timer_notifier);
+}
+
+
+static void timer_stop(void)
+{
+	unregister_profile_notifier(&timer_notifier);
+}
+
+
+static struct oprofile_operations timer_ops = {
+	.start	= timer_start,
+	.stop	= timer_stop,
+	.cpu_type = "timer"
+};
+
+ 
+void __init timer_init(struct oprofile_operations ** ops)
+{
+	*ops = &timer_ops;
+	printk(KERN_INFO "oprofile: using timer interrupt.\n");
+}
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprof.c linux-me/drivers/oprofile/oprof.c
--- linux-cvs/drivers/oprofile/oprof.c	2003-04-05 18:44:50.000000000 +0100
+++ linux-me/drivers/oprofile/oprof.c	2003-04-30 19:58:07.000000000 +0100
@@ -119,14 +119,23 @@
 }
 
  
+extern void timer_init(struct oprofile_operations ** ops);
+
+ 
 static int __init oprofile_init(void)
 {
 	int err;
 
 	/* Architecture must fill in the interrupt ops and the
-	 * logical CPU type.
+	 * logical CPU type, or we can fall back to the timer
+	 * interrupt profiler.
 	 */
 	err = oprofile_arch_init(&oprofile_ops);
+	if (err == -ENODEV) {
+		timer_init(&oprofile_ops);
+		err = 0;
+	}
+
 	if (err)
 		goto out;
 

