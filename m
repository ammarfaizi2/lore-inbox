Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbTJFJZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTJFJZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:25:17 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:38125 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262779AbTJFJZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:25:02 -0400
Date: Mon, 6 Oct 2003 11:24:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/7): base patch.
Message-ID: <20031006092417.GB1786@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Makefile fix: default make target builds the kernel image.
 - Add export statement for cpcmd.
 - Add tgkill system call.
 - Reserve system call number for vserver.

diffstat:
 arch/s390/Makefile            |   16 +++++++---------
 arch/s390/boot/Makefile       |    2 +-
 arch/s390/kernel/s390_ksyms.c |    3 +++
 arch/s390/kernel/syscalls.S   |    5 +++--
 arch/s390/kernel/time.c       |    2 +-
 include/asm-s390/unistd.h     |    9 +++++----
 6 files changed, 20 insertions(+), 17 deletions(-)

diff -urN linux-2.6/arch/s390/Makefile linux-2.6-s390/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	Sun Sep 28 02:50:10 2003
+++ linux-2.6-s390/arch/s390/Makefile	Mon Oct  6 10:59:17 2003
@@ -48,20 +48,18 @@
 drivers-y	+= drivers/s390/
 drivers-$(CONFIG_MATHEMU) += arch/$(ARCH)/math-emu/
 
+boot		:= arch/$(ARCH)/boot
 
-makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/$(ARCH)/boot $(1)
-
-all: image listing
-
-listing image: vmlinux
-	$(call makeboot,arch/$(ARCH)/boot/$@)
+all: image
 
 install: vmlinux
-	$(call makeboot, $@)
+	$(Q)$(MAKE) $(build)=$(boot) $@
 
-archclean:
-	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/$(ARCH)/boot
+image: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
 
 prepare: include/asm-$(ARCH)/offsets.h
 
diff -urN linux-2.6/arch/s390/boot/Makefile linux-2.6-s390/arch/s390/boot/Makefile
--- linux-2.6/arch/s390/boot/Makefile	Sun Sep 28 02:51:21 2003
+++ linux-2.6-s390/arch/s390/boot/Makefile	Mon Oct  6 10:59:17 2003
@@ -6,7 +6,7 @@
 			tr -c '[0-9A-Za-z]' '_'`__`date | \
 			tr -c '[0-9A-Za-z]' '_'`_t
 
-EXTRA_CFLAGS  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I .
+EXTRA_CFLAGS  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I.
 
 targets := image
 
diff -urN linux-2.6/arch/s390/kernel/s390_ksyms.c linux-2.6-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.6/arch/s390/kernel/s390_ksyms.c	Sun Sep 28 02:50:30 2003
+++ linux-2.6-s390/arch/s390/kernel/s390_ksyms.c	Mon Oct  6 10:59:17 2003
@@ -10,6 +10,7 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <asm/checksum.h>
+#include <asm/cpcmd.h>
 #include <asm/delay.h>
 #include <asm/pgalloc.h>
 #include <asm/setup.h>
@@ -72,3 +73,5 @@
 EXPORT_SYMBOL(console_device);
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
 EXPORT_SYMBOL(sys_wait4);
+EXPORT_SYMBOL(cpcmd);
+
diff -urN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-s390/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	Sun Sep 28 02:50:09 2003
+++ linux-2.6-s390/arch/s390/kernel/syscalls.S	Mon Oct  6 10:59:17 2003
@@ -249,7 +249,7 @@
 SYSCALL(sys_futex,sys_futex,compat_sys_futex_wrapper)
 SYSCALL(sys_sched_setaffinity,sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
 SYSCALL(sys_sched_getaffinity,sys_sched_getaffinity,sys32_sched_getaffinity_wrapper)	/* 240 */
-NI_SYSCALL					
+SYSCALL(sys_tgkill,sys_tgkill,sys_tgkill)
 NI_SYSCALL							/* reserved for TUX */
 SYSCALL(sys_io_setup,sys_io_setup,sys_ni_syscall)
 SYSCALL(sys_io_destroy,sys_io_destroy,sys_ni_syscall)
@@ -268,6 +268,7 @@
 SYSCALL(sys_timer_getoverrun,sys_timer_getoverrun,sys_ni_syscall)
 SYSCALL(sys_timer_delete,sys_timer_delete,sys_ni_syscall)
 SYSCALL(sys_clock_settime,sys_clock_settime,sys_ni_syscall)
-SYSCALL(sys_clock_gettime,sys_clock_gettime,sys_ni_syscall)
+SYSCALL(sys_clock_gettime,sys_clock_gettime,sys_ni_syscall)	/* 260 */
 SYSCALL(sys_clock_getres,sys_clock_getres,sys_ni_syscall)
 SYSCALL(sys_clock_nanosleep,sys_clock_nanosleep,sys_ni_syscall)
+NI_SYSCALL							/* reserved for vserver */
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-s390/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	Sun Sep 28 02:50:05 2003
+++ linux-2.6-s390/arch/s390/kernel/time.c	Mon Oct  6 10:59:17 2003
@@ -266,7 +266,7 @@
 	jiffies_timer_cc = init_timer_cc - jiffies_64 * CLK_TICKS_PER_JIFFY;
 
 	/* set xtime */
-	xtime_cc = init_timer_cc;
+	xtime_cc = init_timer_cc + CLK_TICKS_PER_JIFFY;
 	set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
 		(0x3c26700LL*1000000*4096);
         tod_to_timeval(set_time_cc, &xtime);
diff -urN linux-2.6/include/asm-s390/unistd.h linux-2.6-s390/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	Sun Sep 28 02:51:28 2003
+++ linux-2.6-s390/include/asm-s390/unistd.h	Mon Oct  6 10:59:17 2003
@@ -232,9 +232,7 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
-/*
- * Number 241 is currently unused
- */
+#define __NR_tgkill		241
 /*
  * Number 242 is reserved for tux
  */
@@ -258,8 +256,11 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+/*
+ * Number 263 is reserved for vserver
+ */
 
-#define NR_syscalls 263
+#define NR_syscalls 264
 
 /* 
  * There are some system calls that are not present on 64 bit, some
