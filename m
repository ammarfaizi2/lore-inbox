Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263232AbUDUO6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUDUO6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUDUOw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:52:57 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:1180 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S263162AbUDUOsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:48:46 -0400
Date: Wed, 21 Apr 2004 16:48:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (7/9): oprofile for s390.
Message-ID: <20040421144829.GH2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: oprofile.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add oprofile support for s/390.

diffstat:
 arch/s390/Kconfig                 |    1 
 arch/s390/Makefile                |    3 +
 arch/s390/defconfig               |    5 ++
 arch/s390/kernel/Makefile         |    2 -
 arch/s390/kernel/compat_wrapper.S |    8 ++++
 arch/s390/kernel/irq.c            |   72 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/sys_s390.c       |    1 
 arch/s390/kernel/syscalls.S       |    2 -
 arch/s390/kernel/time.c           |   50 ++++++++++++++++++++++++++
 arch/s390/oprofile/Kconfig        |   23 ++++++++++++
 arch/s390/oprofile/Makefile       |   12 ++++++
 arch/s390/oprofile/init.c         |   26 +++++++++++++
 drivers/s390/cio/cio.c            |    9 ----
 include/asm-s390/unistd.h         |    1 
 14 files changed, 204 insertions(+), 11 deletions(-)

diff -urN linux-2.6/arch/s390/Kconfig linux-2.6-s390/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	Sun Apr  4 05:36:56 2004
+++ linux-2.6-s390/arch/s390/Kconfig	Wed Apr 21 16:29:40 2004
@@ -349,6 +349,7 @@
 
 source "fs/Kconfig"
 
+source "arch/s390/oprofile/Kconfig"
 
 menu "Kernel hacking"
 
diff -urN linux-2.6/arch/s390/Makefile linux-2.6-s390/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	Sun Apr  4 05:36:26 2004
+++ linux-2.6-s390/arch/s390/Makefile	Wed Apr 21 16:29:40 2004
@@ -50,6 +50,9 @@
 drivers-y	+= drivers/s390/
 drivers-$(CONFIG_MATHEMU) += arch/$(ARCH)/math-emu/
 
+#based on arch/i386/Makefile: "must be linked after kernel/"
+drivers-$(CONFIG_OPROFILE)	+= arch/s390/oprofile/
+
 boot		:= arch/$(ARCH)/boot
 
 all: image
diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Wed Apr 21 16:29:36 2004
+++ linux-2.6-s390/arch/s390/defconfig	Wed Apr 21 16:29:40 2004
@@ -463,6 +463,11 @@
 # CONFIG_NLS is not set
 
 #
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
 # Kernel hacking
 #
 CONFIG_DEBUG_KERNEL=y
diff -urN linux-2.6/arch/s390/kernel/Makefile linux-2.6-s390/arch/s390/kernel/Makefile
--- linux-2.6/arch/s390/kernel/Makefile	Sun Apr  4 05:38:20 2004
+++ linux-2.6-s390/arch/s390/kernel/Makefile	Wed Apr 21 16:29:40 2004
@@ -6,7 +6,7 @@
 
 obj-y	:=  bitmap.o traps.o time.o process.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-            semaphore.o s390_ext.o debug.o
+            semaphore.o s390_ext.o debug.o irq.o
 
 extra-$(CONFIG_ARCH_S390_31)	+= head.o 
 extra-$(CONFIG_ARCH_S390X)	+= head64.o 
diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-s390/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	Wed Apr 21 16:29:36 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_wrapper.S	Wed Apr 21 16:29:40 2004
@@ -1234,6 +1234,14 @@
 	lgfr	%r5,%r5			# int
 	jg	sys_epoll_wait		# branch to system call
 
+	.globl	sys32_lookup_dcookie_wrapper
+sys32_lookup_dcookie_wrapper:
+	sllg	%r2,%r2,32		# get high word of 64bit dcookie
+	or	%r2,%r3			# get low word of 64bit dcookie
+	llgtr	%r3,%r4			# char *
+	llgfr	%r4,%r5			# size_t
+	jg	sys_lookup_dcookie
+
 	.globl	sys32_fadvise64_wrapper
 sys32_fadvise64_wrapper:
 	lgfr	%r2,%r2			# int
diff -urN linux-2.6/arch/s390/kernel/irq.c linux-2.6-s390/arch/s390/kernel/irq.c
--- linux-2.6/arch/s390/kernel/irq.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/kernel/irq.c	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,72 @@
+/*
+ * arch/s390/kernel/irq.c
+ *
+ * Contains functions related to oprofile taken from patch
+ * linux-2.4.20-s390-oprofile.patch.
+ *
+ * Copyrith (C) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s): Thomas Spatzier (tspat@de.ibm.com)
+ *
+ */
+#include <linux/threads.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/delay.h>
+#include <asm/lowcore.h>
+#include <asm/uaccess.h>
+
+ 
+static struct proc_dir_entry * root_irq_dir;
+
+#define HEX_DIGITS 8	/* Same as other 64-bit arches. XXX */
+
+static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
+					int count, int *eof, void *data)
+{
+	unsigned long *mask = (unsigned long *) data;
+	if (count < HEX_DIGITS+1)
+		return -EINVAL;
+	return sprintf (page, "%08lx\n", *mask);
+}
+
+static int prof_cpu_mask_write_proc (struct file *file, const char *buffer,
+					unsigned long count, void *data)
+{
+	unsigned long* mask;
+	unsigned char hexnum[HEX_DIGITS];
+	
+	mask = (unsigned long*)data;
+	if (!count)
+		return -EINVAL;
+	if (copy_from_user(hexnum, buffer, count))
+		return -EFAULT;
+	
+	*mask = simple_strtoul(hexnum, NULL, 16);
+	return count;
+}
+
+unsigned long prof_cpu_mask = -1;
+
+void init_irq_proc(void)
+{
+        struct proc_dir_entry *entry;
+
+        /* create /proc/irq */
+        root_irq_dir = proc_mkdir("irq", 0);
+
+        /* create /proc/irq/prof_cpu_mask */
+        entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
+
+        if (!entry)
+		return;
+
+        entry->nlink = 1;
+        entry->data = (void *)&prof_cpu_mask;
+        entry->read_proc = prof_cpu_mask_read_proc;
+        entry->write_proc = prof_cpu_mask_write_proc;
+}
diff -urN linux-2.6/arch/s390/kernel/sys_s390.c linux-2.6-s390/arch/s390/kernel/sys_s390.c
--- linux-2.6/arch/s390/kernel/sys_s390.c	Sun Apr  4 05:36:56 2004
+++ linux-2.6-s390/arch/s390/kernel/sys_s390.c	Wed Apr 21 16:29:40 2004
@@ -4,6 +4,7 @@
  *  S390 version
  *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
+ *               Thomas Spatzier (tspat@de.ibm.com)
  *
  *  Derived from "arch/i386/kernel/sys_i386.c"
  *
diff -urN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-s390/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	Wed Apr 21 16:29:15 2004
+++ linux-2.6-s390/arch/s390/kernel/syscalls.S	Wed Apr 21 16:29:40 2004
@@ -118,7 +118,7 @@
 SYSCALL(sys_newlstat,sys_newlstat,compat_sys_newlstat_wrapper)
 SYSCALL(sys_newfstat,sys_newfstat,compat_sys_newfstat_wrapper)
 NI_SYSCALL							/* old uname syscall */
-NI_SYSCALL							/* reserved for sys_lookup_dcache */
+SYSCALL(sys_lookup_dcookie,sys_lookup_dcookie,sys32_lookup_dcookie_wrapper)	/* 110 */
 SYSCALL(sys_vhangup,sys_vhangup,sys_vhangup)
 NI_SYSCALL							/* old "idle" system call */
 NI_SYSCALL							/* vm86old for i386 */
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-s390/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	Sun Apr  4 05:36:14 2004
+++ linux-2.6-s390/arch/s390/kernel/time.c	Wed Apr 21 16:29:40 2004
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/types.h>
+#include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/config.h>
 
@@ -177,6 +178,54 @@
 
 #endif /* CONFIG_ARCH_S390X */
 
+
+#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
+extern char _stext, _etext;
+
+/*
+ * The profiling function is SMP safe. (nothing can mess
+ * around with "current", and the profiling counters are
+ * updated with atomic operations). This is especially
+ * useful with a profiling multiplier != 1
+ */
+static inline void s390_do_profile(struct pt_regs * regs)
+{
+	unsigned long eip;
+	extern unsigned long prof_cpu_mask;
+
+	profile_hook(regs);
+
+	if (user_mode(regs))
+		return;
+
+	if (!prof_buffer)
+		return;
+
+	eip = instruction_pointer(regs);
+
+	/*
+	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
+	 * (default is all CPUs.)
+	 */
+	if (!((1<<smp_processor_id()) & prof_cpu_mask))
+		return;
+
+	eip -= (unsigned long) &_stext;
+	eip >>= prof_shift;
+	/*
+	 * Don't ignore out-of-bounds EIP values silently,
+	 * put them into the last histogram slot, so if
+	 * present, they will show up as a sharp peak.
+	 */
+	if (eip > prof_len-1)
+		eip = prof_len-1;
+	atomic_inc((atomic_t *)&prof_buffer[eip]);
+}
+#else
+#define s390_do_profile(regs)  do { ; } while(0)
+#endif /* CONFIG_OPROFILE */
+
+
 /*
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
@@ -231,6 +280,7 @@
 	while (ticks--)
 		do_timer(regs);
 #endif
+	s390_do_profile(regs);
 }
 
 #ifdef CONFIG_VIRT_TIMER
diff -urN linux-2.6/arch/s390/oprofile/Kconfig linux-2.6-s390/arch/s390/oprofile/Kconfig
--- linux-2.6/arch/s390/oprofile/Kconfig	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/oprofile/Kconfig	Wed Apr 21 16:29:40 2004
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
diff -urN linux-2.6/arch/s390/oprofile/Makefile linux-2.6-s390/arch/s390/oprofile/Makefile
--- linux-2.6/arch/s390/oprofile/Makefile	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/oprofile/Makefile	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,12 @@
+obj-$(CONFIG_OPROFILE) += oprofile.o
+
+DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
+		oprof.o cpu_buffer.o buffer_sync.o \
+		event_buffer.o oprofile_files.o \
+		oprofilefs.o oprofile_stats.o  \
+		timer_int.o )
+
+oprofile-y				:= $(DRIVER_OBJS) init.o
+#oprofile-$(CONFIG_X86_LOCAL_APIC) 	+= nmi_int.o op_model_athlon.o \
+					   op_model_ppro.o op_model_p4.o
+#oprofile-$(CONFIG_X86_IO_APIC)		+= nmi_timer_int.o
diff -urN linux-2.6/arch/s390/oprofile/init.c linux-2.6-s390/arch/s390/oprofile/init.c
--- linux-2.6/arch/s390/oprofile/init.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/oprofile/init.c	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,26 @@
+/**
+ * arch/s390/oprofile/init.c
+ *
+ * S390 Version
+ *   Copyright (C) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *   Author(s): Thomas Spatzier (tspat@de.ibm.com)
+ * 	
+ * @remark Copyright 2002 OProfile authors
+ */
+
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+
+//extern int irq_init(struct oprofile_operations** ops);
+extern void timer_init(struct oprofile_operations** ops);
+
+int __init oprofile_arch_init(struct oprofile_operations** ops)
+{
+	timer_init(ops);
+	return 0;
+}
+
+void oprofile_arch_exit(void)
+{
+}
diff -urN linux-2.6/drivers/s390/cio/cio.c linux-2.6-s390/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	Wed Apr 21 16:29:36 2004
+++ linux-2.6-s390/drivers/s390/cio/cio.c	Wed Apr 21 16:29:40 2004
@@ -52,15 +52,6 @@
 
 __setup ("cio_msg=", cio_setup);
 
-
-#ifdef CONFIG_PROC_FS
-void
-init_irq_proc(void)
-{
-	/* For now, nothing... */
-}
-#endif
-
 /*
  * Function: cio_debug_init
  * Initializes three debug logs (under /proc/s390dbf) for common I/O:
diff -urN linux-2.6/include/asm-s390/unistd.h linux-2.6-s390/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	Wed Apr 21 16:29:18 2004
+++ linux-2.6-s390/include/asm-s390/unistd.h	Wed Apr 21 16:29:40 2004
@@ -105,6 +105,7 @@
 #define __NR_stat               106
 #define __NR_lstat              107
 #define __NR_fstat              108
+#define __NR_lookup_dcookie     110
 #define __NR_vhangup            111
 #define __NR_idle               112
 #define __NR_wait4              114
