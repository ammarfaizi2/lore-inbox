Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbTCGJTt>; Fri, 7 Mar 2003 04:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbTCGJTs>; Fri, 7 Mar 2003 04:19:48 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:57357 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261442AbTCGJTo>;
	Fri, 7 Mar 2003 04:19:44 -0500
Date: Fri, 7 Mar 2003 04:29:16 -0500 (EST)
Message-Id: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       segher@koffie.nl, o.oppitz@web.de, afleming@motorola.com,
       linux-kernel@vger.kernel.org
Subject: [patch] oprofile for ppc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is basic timer profiling for ppc, tested on the
2.5.62 linuxppc kernel. It's a port of the ppc64 code.


diff -Naurd orig62/arch/ppc/Kconfig hack62/arch/ppc/Kconfig
--- orig62/arch/ppc/Kconfig	2003-02-24 20:15:49.000000000 -0500
+++ hack62/arch/ppc/Kconfig	2003-03-07 00:22:41.000000000 -0500
@@ -1522,6 +1522,8 @@
 source "lib/Kconfig"
 
 
+source "arch/ppc/oprofile/Kconfig"
+
 menu "Kernel hacking"
 
 config DEBUG_KERNEL
diff -Naurd orig62/arch/ppc/Makefile hack62/arch/ppc/Makefile
--- orig62/arch/ppc/Makefile	2003-02-24 20:12:40.000000000 -0500
+++ hack62/arch/ppc/Makefile	2003-03-07 00:22:41.000000000 -0500
@@ -49,6 +49,7 @@
 core-$(CONFIG_MATH_EMULATION)	+= arch/ppc/math-emu/
 core-$(CONFIG_XMON)		+= arch/ppc/xmon/
 core-$(CONFIG_APUS)		+= arch/ppc/amiga/
+drivers-$(CONFIG_OPROFILE)	+= arch/ppc/oprofile/
 drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_io/
 drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
 drivers-$(CONFIG_8260)		+= arch/ppc/8260_io/
diff -Naurd orig62/arch/ppc/defconfig hack62/arch/ppc/defconfig
--- orig62/arch/ppc/defconfig	2003-02-24 20:15:14.000000000 -0500
+++ hack62/arch/ppc/defconfig	2003-03-07 00:22:41.000000000 -0500
@@ -1108,6 +1108,12 @@
 # CONFIG_BT is not set
 
 #
+# Profiling support
+#
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+
+#
 # Library routines
 #
 # CONFIG_CRC32 is not set
diff -Naurd orig62/arch/ppc/kernel/time.c hack62/arch/ppc/kernel/time.c
--- orig62/arch/ppc/kernel/time.c	2003-02-24 20:15:00.000000000 -0500
+++ hack62/arch/ppc/kernel/time.c	2003-03-07 00:22:41.000000000 -0500
@@ -56,6 +56,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/time.h>
 #include <linux/init.h>
+#include <linux/profile.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -105,17 +106,28 @@
 	return delta;
 }
 
-extern unsigned long prof_cpu_mask;
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
-extern char _stext;
-
-static inline void ppc_do_profile (unsigned long nip)
+/*
+ * The profiling function is SMP safe. (nothing can mess
+ * around with "current", and the profiling counters are
+ * updated with atomic operations). This is especially
+ * useful with a profiling multiplier != 1
+ */
+static inline void ppc_do_profile(struct pt_regs *regs)
 {
+	unsigned long nip;
+	extern unsigned long prof_cpu_mask;
+	extern char _stext;
+
+	profile_hook(regs);
+
+	if (user_mode(regs))
+		return;
+
 	if (!prof_buffer)
 		return;
 
+	nip = instruction_pointer(regs);
+
 	/*
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
@@ -151,11 +163,10 @@
 		do_IRQ(regs);
 
 	irq_enter();
-	
+
 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
 		jiffy_stamp += tb_ticks_per_jiffy;
-		if (!user_mode(regs))
-			ppc_do_profile(instruction_pointer(regs));
+		ppc_do_profile(regs);
 	  	if (smp_processor_id())
 			continue;
 
diff -Naurd orig62/arch/ppc/oprofile/Kconfig hack62/arch/ppc/oprofile/Kconfig
--- orig62/arch/ppc/oprofile/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ hack62/arch/ppc/oprofile/Kconfig	2003-03-07 00:22:41.000000000 -0500
@@ -0,0 +1,23 @@
+
+menu "Profiling support"
+	depends on EXPERIMENTAL
+
+config PROFILING
+	bool "Profiling support (EXPERIMENTAL)"
+	help
+	  Say Y here to enable the extended profiling support mechanisms used
+	  by profilers such as OProfile.
+	  
+
+config OPROFILE
+	tristate "OProfile system profiling (EXPERIMENTAL)"
+	depends on PROFILING
+	help
+	  OProfile is a profiling system capable of profiling the
+	  whole system, include the kernel, kernel modules, libraries,
+	  and applications.
+
+	  If unsure, say N.
+
+endmenu
+
diff -Naurd orig62/arch/ppc/oprofile/Makefile hack62/arch/ppc/oprofile/Makefile
--- orig62/arch/ppc/oprofile/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ hack62/arch/ppc/oprofile/Makefile	2003-03-07 00:22:41.000000000 -0500
@@ -0,0 +1,8 @@
+obj-$(CONFIG_OPROFILE) += oprofile.o
+
+DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
+		oprof.o cpu_buffer.o buffer_sync.o \
+		event_buffer.o oprofile_files.o \
+		oprofilefs.o oprofile_stats.o )
+
+oprofile-y := $(DRIVER_OBJS) init.o timer_int.o
diff -Naurd orig62/arch/ppc/oprofile/init.c hack62/arch/ppc/oprofile/init.c
--- orig62/arch/ppc/oprofile/init.c	1969-12-31 19:00:00.000000000 -0500
+++ hack62/arch/ppc/oprofile/init.c	2003-03-07 00:22:41.000000000 -0500
@@ -0,0 +1,20 @@
+/**
+ * @file init.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/oprofile.h>
+#include <linux/init.h>
+ 
+extern void timer_init(struct oprofile_operations ** ops);
+
+int __init oprofile_arch_init(struct oprofile_operations ** ops)
+{
+	timer_init(ops);
+	return 0;
+}
diff -Naurd orig62/arch/ppc/oprofile/timer_int.c hack62/arch/ppc/oprofile/timer_int.c
--- orig62/arch/ppc/oprofile/timer_int.c	1969-12-31 19:00:00.000000000 -0500
+++ hack62/arch/ppc/oprofile/timer_int.c	2003-03-07 00:22:41.000000000 -0500
@@ -0,0 +1,59 @@
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
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+#include <linux/oprofile.h>
+#include <linux/profile.h>
+#include <asm/ptrace.h>
+ 
+static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
+{
+	struct pt_regs * regs = (struct pt_regs *)data;
+	int cpu = smp_processor_id();
+	unsigned long pc = instruction_pointer(regs);
+	int is_kernel = !user_mode(regs);
+ 
+	oprofile_add_sample(pc, is_kernel, 0, cpu);
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
