Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUGAIWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUGAIWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 04:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUGAIWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 04:22:37 -0400
Received: from alsvidh.mathematik.uni-muenchen.de ([129.187.111.42]:31946 "EHLO
	alsvidh.mathematik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S264266AbUGAIWb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 04:22:31 -0400
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: [patch, resend, 2.6, ppc32] enable OProfile profiling driver
Organization: Lehrstuhl fuer vergleichende Astrozoologie
X-Mahlzeit: Das ist per Saldo Gemuetlichkeit
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 01 Jul 2004 10:22:30 +0200
Message-ID: <hh7jtoi1bt.fsf@alsvidh.mathematik.uni-muenchen.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please find enclosed a patch to enable to OProfile profiling driver
for ppc32, forward ported from Ben's development tree.  I sent an
incomplete version some time ago, this time I didn't forget anything
(hopefully).

Regards, Jens.

diff -Nur kernel-source-2.6.6/arch/ppc/Makefile linuxppc-2.5-benh/arch/ppc/Makefile
--- kernel-source-2.6.6/arch/ppc/Makefile   2004-06-16 07:18:57.000000000 +0200
+++ linuxppc-2.5-benh/arch/ppc/Makefile   2004-06-24 12:43:55.995114195 +0200
@@ -43,6 +43,7 @@
 drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_io/
 drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
 drivers-$(CONFIG_8260)		+= arch/ppc/8260_io/
+drivers-$(CONFIG_OPROFILE)	+= arch/ppc/oprofile/
 
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
 
diff -Nur kernel-source-2.6.6/arch/ppc/Kconfig linuxppc-2.5-benh/arch/ppc/Kconfig
--- kernel-source-2.6.6/arch/ppc/Kconfig        2004-04-05 11:49:23.000000000 +0200
+++ linuxppc-2.5-benh/arch/ppc/Kconfig  2004-03-29 08:34:26.000000000 +0200
@@ -1154,6 +1154,7 @@
 
 source "lib/Kconfig"
 
+source "arch/ppc/oprofile/Kconfig"
 
 menu "Kernel hacking"
 
diff -Nur kernel-source-2.6.6/arch/ppc/kernel/time.c linuxppc-2.5-benh/arch/ppc/kernel/time.c
--- kernel-source-2.6.5/arch/ppc/kernel/time.c	2004-03-11 03:55:37.000000000 +0100
+++ linuxppc-2.5-benh/arch/ppc/kernel/time.c	2004-03-04 03:04:26.000000000 +0100
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
+static inline void ppc_do_profile(struct pt_regs *regs)
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
@@ -156,8 +170,7 @@
 
 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
 		jiffy_stamp += tb_ticks_per_jiffy;
-		if (!user_mode(regs))
-			ppc_do_profile(instruction_pointer(regs));
+		ppc_do_profile(regs);
 	  	if (smp_processor_id())
 			continue;
 
diff -Nur kernel-source-2.6.6/arch/ppc/oprofile/Kconfig linuxppc-2.5-benh/arch/ppc/oprofile/Kconfig
--- kernel-source-2.6.6/arch/ppc/oprofile/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/Kconfig	2003-12-31 03:50:43.000000000 +0100
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
diff -Nur kernel-source-2.6.6/arch/ppc/oprofile/Makefile linuxppc-2.5-benh/arch/ppc/oprofile/Makefile
--- kernel-source-2.6.6/arch/ppc/oprofile/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/Makefile	2003-12-31 03:50:44.000000000 +0100
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
diff -Nur kernel-source-2.6.6/arch/ppc/oprofile/init.c linuxppc-2.5-benh/arch/ppc/oprofile/init.c
--- kernel-source-2.6.6/arch/ppc/oprofile/init.c	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/init.c	2003-12-31 03:50:45.000000000 +0100
@@ -0,0 +1,25 @@
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
+extern void timer_init(struct oprofile_operations ** ops);
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


-- 
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!
