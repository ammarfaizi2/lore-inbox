Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265283AbUFVTXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUFVTXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUFVTTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:19:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:53161 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265146AbUFVTQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:16:04 -0400
Subject: [PATCH] ppc32: oprofile support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1087931373.1859.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 14:09:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds basic oprofile support to ppc32. Originally from Anton
Blanchard, I just re-diffed it against current kernels. Please apply,

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Anton Blanchard <anton@samba.org>

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2004-06-22 14:05:08 -05:00
+++ b/arch/ppc/Kconfig	2004-06-22 14:05:08 -05:00
@@ -1183,6 +1183,7 @@
 
 source "lib/Kconfig"
 
+source "arch/ppc/oprofile/Kconfig"
 
 menu "Kernel hacking"
 
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	2004-06-22 14:05:08 -05:00
+++ b/arch/ppc/Makefile	2004-06-22 14:05:08 -05:00
@@ -50,6 +50,8 @@
 drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
 drivers-$(CONFIG_8260)		+= arch/ppc/8260_io/
 
+drivers-$(CONFIG_OPROFILE)	+= arch/ppc/oprofile/
+
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
 
 .PHONY: $(BOOT_TARGETS)
diff -Nru a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c	2004-06-22 14:05:08 -05:00
+++ b/arch/ppc/kernel/time.c	2004-06-22 14:05:08 -05:00
@@ -56,6 +56,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/time.h>
 #include <linux/init.h>
+#include <linux/profile.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -107,17 +108,23 @@
 	return delta;
 }
 
-extern unsigned long prof_cpu_mask;
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
 extern char _stext;
 
-static inline void ppc_do_profile (unsigned long nip)
+static inline void ppc_do_profile (struct pt_regs *regs)
 {
+	unsigned long nip;
+	extern unsigned long prof_cpu_mask;
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
@@ -156,8 +163,9 @@
 
 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
 		jiffy_stamp += tb_ticks_per_jiffy;
-		if (!user_mode(regs))
-			ppc_do_profile(instruction_pointer(regs));
+		
+		ppc_do_profile(regs);
+
 	  	if (smp_processor_id())
 			continue;
 
diff -Nru a/arch/ppc/oprofile/Kconfig b/arch/ppc/oprofile/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/Kconfig	2004-06-22 14:05:08 -05:00
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
diff -Nru a/arch/ppc/oprofile/Makefile b/arch/ppc/oprofile/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/Makefile	2004-06-22 14:05:08 -05:00
@@ -0,0 +1,9 @@
+obj-$(CONFIG_OPROFILE) += oprofile.o
+
+DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
+		oprof.o cpu_buffer.o buffer_sync.o \
+		event_buffer.o oprofile_files.o \
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
+
+oprofile-y := $(DRIVER_OBJS) init.o
diff -Nru a/arch/ppc/oprofile/init.c b/arch/ppc/oprofile/init.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/init.c	2004-06-22 14:05:08 -05:00
@@ -0,0 +1,23 @@
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
+#include <linux/errno.h>
+
+int __init oprofile_arch_init(struct oprofile_operations ** ops)
+{
+	return -ENODEV;
+}
+
+
+void oprofile_arch_exit(void)
+{
+}


