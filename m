Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbUBHVXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 16:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUBHVWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 16:22:51 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:6343 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263996AbUBHVWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 16:22:45 -0500
Date: Sun, 8 Feb 2004 16:22:21 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Philippe Elie <phil.el@wanadoo.fr>, Russell King <rmk@arm.linux.org.uk>,
       "Jiang, Dave" <dave.jiang@intel.com>,
       Linux ARM <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [PATCH][2.6] Oprofile, ARM infrastructure
Message-ID: <Pine.LNX.4.58.0402081606220.3370@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds infrastructure code and enables ARM to utilise
the timer int oprofile driver. There is PMU code under development for the
XScale but that is still forthcoming. In the meantime you can use the
timer int driver with an updated Oprofile-CVS userspace (SF is a bit slow,
please allow 24hrs).

Tested on an IOP331 eval board courtesy of Intel, if someone would like
the additional patches to put on top of the iop1 patchset please contact
me.

Index: linux-2.6.2/arch/arm/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.2/arch/arm/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.2/arch/arm/Kconfig	4 Feb 2004 07:43:40 -0000	1.1.1.1
+++ linux-2.6.2/arch/arm/Kconfig	8 Feb 2004 20:37:25 -0000
@@ -633,6 +633,8 @@ source "drivers/media/Kconfig"

 source "fs/Kconfig"

+source "arch/arm/oprofile/Kconfig"
+
 source "drivers/video/Kconfig"

 if ARCH_ACORN || ARCH_CLPS7500 || ARCH_TBOX || ARCH_SHARK || ARCH_SA1100 || PCI
Index: linux-2.6.2/arch/arm/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.2/arch/arm/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.2/arch/arm/Makefile	4 Feb 2004 07:43:40 -0000	1.1.1.1
+++ linux-2.6.2/arch/arm/Makefile	8 Feb 2004 20:37:25 -0000
@@ -116,6 +116,7 @@ endif
 core-$(CONFIG_FPE_NWFPE)	+= arch/arm/nwfpe/
 core-$(CONFIG_FPE_FASTFPE)	+= $(FASTFPE_OBJ)

+drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 drivers-$(CONFIG_ARCH_CLPS7500)	+= drivers/acorn/char/
 drivers-$(CONFIG_ARCH_L7200)	+= drivers/acorn/char/

Index: linux-2.6.2/arch/arm/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.2/arch/arm/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.2/arch/arm/kernel/time.c	4 Feb 2004 07:43:40 -0000	1.1.1.1
+++ linux-2.6.2/arch/arm/kernel/time.c	8 Feb 2004 18:23:15 -0000
@@ -83,6 +83,9 @@ unsigned long long sched_clock(void)
  */
 static inline void do_profile(struct pt_regs *regs)
 {
+
+	profile_hook(regs);
+
 	if (!user_mode(regs) &&
 	    prof_buffer &&
 	    current->pid) {
Index: linux-2.6.2/arch/arm/oprofile/Kconfig
===================================================================
RCS file: linux-2.6.2/arch/arm/oprofile/Kconfig
diff -N linux-2.6.2/arch/arm/oprofile/Kconfig
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.2/arch/arm/oprofile/Kconfig	8 Feb 2004 20:55:01 -0000
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
Index: linux-2.6.2/arch/arm/oprofile/Makefile
===================================================================
RCS file: linux-2.6.2/arch/arm/oprofile/Makefile
diff -N linux-2.6.2/arch/arm/oprofile/Makefile
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.2/arch/arm/oprofile/Makefile	8 Feb 2004 20:37:25 -0000
@@ -0,0 +1,9 @@
+obj-$(CONFIG_OPROFILE) += oprofile.o
+
+DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
+		oprof.o cpu_buffer.o buffer_sync.o \
+		event_buffer.o oprofile_files.o \
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
+
+oprofile-y				:= $(DRIVER_OBJS) init.o
Index: linux-2.6.2/arch/arm/oprofile/init.c
===================================================================
RCS file: linux-2.6.2/arch/arm/oprofile/init.c
diff -N linux-2.6.2/arch/arm/oprofile/init.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.2/arch/arm/oprofile/init.c	8 Feb 2004 20:37:25 -0000
@@ -0,0 +1,22 @@
+/**
+ * @file init.c
+ *
+ * @remark Copyright 2004 Oprofile Authors
+ *
+ * @author Zwane Mwaikambo
+ */
+
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+
+int oprofile_arch_init(struct oprofile_operations **ops)
+{
+	int ret = -ENODEV;
+
+	return ret;
+}
+
+void oprofile_arch_exit(void)
+{
+}
Index: linux-2.6.2/drivers/oprofile/timer_int.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.2/drivers/oprofile/timer_int.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 timer_int.c
--- linux-2.6.2/drivers/oprofile/timer_int.c	4 Feb 2004 07:43:53 -0000	1.1.1.1
+++ linux-2.6.2/drivers/oprofile/timer_int.c	8 Feb 2004 20:37:25 -0000
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
-#include <linux/irq.h>
 #include <linux/oprofile.h>
 #include <linux/profile.h>
 #include <linux/init.h>
