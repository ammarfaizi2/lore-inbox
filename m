Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUIHHGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUIHHGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 03:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUIHHGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 03:06:41 -0400
Received: from ppp18-135.dsl-pun.eth.net ([61.11.18.135]:516 "EHLO
	euclid.linsyssoft.com") by vger.kernel.org with ESMTP
	id S268900AbUIHHCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 03:02:49 -0400
Subject: Problem of debugging modules on x86_64 platform using KGDB
From: Mithlesh Thukral <mithlesh@linsyssoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-lVV67ecaEcox55SF8A9E"
Organization: 
Message-Id: <1094626891.1101.55.camel@krypton>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Sep 2004 12:31:31 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lVV67ecaEcox55SF8A9E
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

hi,
On the x86_64 platform we faced a problem of debugging modules using
KGDB. 
For working around the problem, we need the compile the file
'arch/x86_64/kernel/vsyscall.c' without the generation of debugging
information.
For this i moved the 'vsyscall.c' from the directory
'arch/x86_64/kernel' to a new directory 'arch/x86_64/kernel/vsyscall/' .
The make file in this new directory does not generate the debugging
information for the file 'vsyscall.c'.
Please let me know if there is some other way by which i can specify a
different set of compilation flags for a single file in the directory.
this will help me in not moving the file in a new directory.

Regards,
Mithlesh Thukral

--=-lVV67ecaEcox55SF8A9E
Content-Disposition: attachment; filename=vsyscall.patch
Content-Type: text/x-patch; name=vsyscall.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.7/arch/x86_64/kernel/Makefile
===================================================================
--- linux-2.6.7.orig/arch/x86_64/kernel/Makefile	2004-09-07 18:48:57.000000000 +0530
+++ linux-2.6.7/arch/x86_64/kernel/Makefile	2004-09-07 19:10:18.000000000 +0530
@@ -6,8 +6,9 @@
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
-		x8664_ksyms.o i387.o syscall.o vsyscall.o \
+		x8664_ksyms.o i387.o syscall.o \
 		setup64.o bootflag.o e820.o reboot.o warmreboot.o
+obj-y	+= vsyscall/
 obj-y += mce.o
 
 obj-$(CONFIG_MTRR)		+= ../../i386/kernel/cpu/mtrr/
Index: linux-2.6.7/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux-2.6.7.orig/arch/x86_64/kernel/vsyscall.c	2004-06-18 19:23:16.000000000 +0530
+++ linux-2.6.7/arch/x86_64/kernel/vsyscall.c	2003-01-30 15:54:37.000000000 +0530
@@ -1,180 +0,0 @@
-/*
- *  linux/arch/x86_64/kernel/vsyscall.c
- *
- *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
- *  Copyright 2003 Andi Kleen, SuSE Labs.
- *
- *  Thanks to hpa@transmeta.com for some useful hint.
- *  Special thanks to Ingo Molnar for his early experience with
- *  a different vsyscall implementation for Linux/IA32 and for the name.
- *
- *  vsyscall 1 is located at -10Mbyte, vsyscall 2 is located
- *  at virtual address -10Mbyte+1024bytes etc... There are at max 8192
- *  vsyscalls. One vsyscall can reserve more than 1 slot to avoid
- *  jumping out of line if necessary.
- *
- *  Note: the concept clashes with user mode linux. If you use UML just
- *  set the kernel.vsyscall sysctl to 0.
- */
-
-/*
- * TODO 2001-03-20:
- *
- * 1) make page fault handler detect faults on page1-page-last of the vsyscall
- *    virtual space, and make it increase %rip and write -ENOSYS in %rax (so
- *    we'll be able to upgrade to a new glibc without upgrading kernel after
- *    we add more vsyscalls.
- * 2) Possibly we need a fixmap table for the vsyscalls too if we want
- *    to avoid SIGSEGV and we want to return -EFAULT from the vsyscalls as well.
- *    Can we segfault inside a "syscall"? We can fix this anytime and those fixes
- *    won't be visible for userspace. Not fixing this is a noop for correct programs,
- *    broken programs will segfault and there's no security risk until we choose to
- *    fix it.
- *
- * These are not urgent things that we need to address only before shipping the first
- * production binary kernels.
- */
-
-#include <linux/time.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/seqlock.h>
-
-#include <asm/vsyscall.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <asm/fixmap.h>
-#include <asm/errno.h>
-#include <asm/io.h>
-
-#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
-#define force_inline __attribute__((always_inline)) inline
-
-int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
-seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
-
-#include <asm/unistd.h>
-
-static force_inline void timeval_normalize(struct timeval * tv)
-{
-	time_t __sec;
-
-	__sec = tv->tv_usec / 1000000;
-	if (__sec)
-	{
-		tv->tv_usec %= 1000000;
-		tv->tv_sec += __sec;
-	}
-}
-
-static force_inline void do_vgettimeofday(struct timeval * tv)
-{
-	long sequence, t;
-	unsigned long sec, usec;
-
-	do {
-		sequence = read_seqbegin(&__xtime_lock);
-		
-		sec = __xtime.tv_sec;
-		usec = (__xtime.tv_nsec / 1000) +
-			(__jiffies - __wall_jiffies) * (1000000 / HZ);
-
-		if (__vxtime.mode == VXTIME_TSC) {
-			sync_core();
-			rdtscll(t);
-			if (t < __vxtime.last_tsc) t = __vxtime.last_tsc;
-			usec += ((t - __vxtime.last_tsc) *
-				 __vxtime.tsc_quot) >> 32;
-			/* See comment in x86_64 do_gettimeofday. */ 
-		} else {
-			usec += ((readl(fix_to_virt(VSYSCALL_HPET) + 0xf0) -
-				  __vxtime.last) * __vxtime.quot) >> 32;
-		}
-	} while (read_seqretry(&__xtime_lock, sequence));
-
-	tv->tv_sec = sec + usec / 1000000;
-	tv->tv_usec = usec % 1000000;
-}
-
-/* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
-static force_inline void do_get_tz(struct timezone * tz)
-{
-		*tz = __sys_tz;
-}
-
-
-static force_inline int gettimeofday(struct timeval *tv, struct timezone *tz)
-{
-	int ret;
-	asm volatile("syscall" 
-		: "=a" (ret)
-		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
-	return ret;
-}
-
-static force_inline long time_syscall(long *t)
-{
-	long secs;
-	asm volatile("syscall" 
-		: "=a" (secs)
-		: "0" (__NR_time),"D" (t) : __syscall_clobber);
-	return secs;
-}
-
-static int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
-{
-	if (unlikely(!__sysctl_vsyscall))
-	return gettimeofday(tv,tz); 
-	if (tv)
-		do_vgettimeofday(tv);
-	if (tz)
-		do_get_tz(tz);
-	return 0;
-}
-
-/* This will break when the xtime seconds get inaccurate, but that is
- * unlikely */
-static time_t __vsyscall(1) vtime(time_t *t)
-{
-	if (unlikely(!__sysctl_vsyscall))
-		return time_syscall(t);
-	else if (t)
-		*t = __xtime.tv_sec;		
-	return __xtime.tv_sec;
-}
-
-static long __vsyscall(2) venosys_0(void)
-{
-	return -ENOSYS;
-}
-
-static long __vsyscall(3) venosys_1(void)
-{
-	return -ENOSYS;
-
-}
-
-static void __init map_vsyscall(void)
-{
-	extern char __vsyscall_0;
-	unsigned long physaddr_page0 = __pa_symbol(&__vsyscall_0);
-
-	__set_fixmap(VSYSCALL_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
-}
-
-static int __init vsyscall_init(void)
-{
-	if ((unsigned long) &vgettimeofday != VSYSCALL_ADDR(__NR_vgettimeofday))
-		panic("vgettimeofday link addr broken");
-	if ((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime))
-		panic("vtime link addr broken");
-	if (VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE))
-		panic("fixmap first vsyscall %lx should be %lx", __fix_to_virt(VSYSCALL_FIRST_PAGE),
-		      VSYSCALL_ADDR(0));
-	map_vsyscall();
-
-	return 0;
-}
-
-__initcall(vsyscall_init);
Index: linux-2.6.7/arch/x86_64/kernel/vsyscall/vsyscall.c
===================================================================
--- linux-2.6.7.orig/arch/x86_64/kernel/vsyscall/vsyscall.c	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.7/arch/x86_64/kernel/vsyscall/vsyscall.c	2004-09-07 18:48:58.000000000 +0530
@@ -0,0 +1,180 @@
+/*
+ *  linux/arch/x86_64/kernel/vsyscall.c
+ *
+ *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
+ *  Copyright 2003 Andi Kleen, SuSE Labs.
+ *
+ *  Thanks to hpa@transmeta.com for some useful hint.
+ *  Special thanks to Ingo Molnar for his early experience with
+ *  a different vsyscall implementation for Linux/IA32 and for the name.
+ *
+ *  vsyscall 1 is located at -10Mbyte, vsyscall 2 is located
+ *  at virtual address -10Mbyte+1024bytes etc... There are at max 8192
+ *  vsyscalls. One vsyscall can reserve more than 1 slot to avoid
+ *  jumping out of line if necessary.
+ *
+ *  Note: the concept clashes with user mode linux. If you use UML just
+ *  set the kernel.vsyscall sysctl to 0.
+ */
+
+/*
+ * TODO 2001-03-20:
+ *
+ * 1) make page fault handler detect faults on page1-page-last of the vsyscall
+ *    virtual space, and make it increase %rip and write -ENOSYS in %rax (so
+ *    we'll be able to upgrade to a new glibc without upgrading kernel after
+ *    we add more vsyscalls.
+ * 2) Possibly we need a fixmap table for the vsyscalls too if we want
+ *    to avoid SIGSEGV and we want to return -EFAULT from the vsyscalls as well.
+ *    Can we segfault inside a "syscall"? We can fix this anytime and those fixes
+ *    won't be visible for userspace. Not fixing this is a noop for correct programs,
+ *    broken programs will segfault and there's no security risk until we choose to
+ *    fix it.
+ *
+ * These are not urgent things that we need to address only before shipping the first
+ * production binary kernels.
+ */
+
+#include <linux/time.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/seqlock.h>
+
+#include <asm/vsyscall.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/errno.h>
+#include <asm/io.h>
+
+#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
+#define force_inline __attribute__((always_inline)) inline
+
+int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
+seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
+
+#include <asm/unistd.h>
+
+static force_inline void timeval_normalize(struct timeval * tv)
+{
+	time_t __sec;
+
+	__sec = tv->tv_usec / 1000000;
+	if (__sec)
+	{
+		tv->tv_usec %= 1000000;
+		tv->tv_sec += __sec;
+	}
+}
+
+static force_inline void do_vgettimeofday(struct timeval * tv)
+{
+	long sequence, t;
+	unsigned long sec, usec;
+
+	do {
+		sequence = read_seqbegin(&__xtime_lock);
+		
+		sec = __xtime.tv_sec;
+		usec = (__xtime.tv_nsec / 1000) +
+			(__jiffies - __wall_jiffies) * (1000000 / HZ);
+
+		if (__vxtime.mode == VXTIME_TSC) {
+			sync_core();
+			rdtscll(t);
+			if (t < __vxtime.last_tsc) t = __vxtime.last_tsc;
+			usec += ((t - __vxtime.last_tsc) *
+				 __vxtime.tsc_quot) >> 32;
+			/* See comment in x86_64 do_gettimeofday. */ 
+		} else {
+			usec += ((readl(fix_to_virt(VSYSCALL_HPET) + 0xf0) -
+				  __vxtime.last) * __vxtime.quot) >> 32;
+		}
+	} while (read_seqretry(&__xtime_lock, sequence));
+
+	tv->tv_sec = sec + usec / 1000000;
+	tv->tv_usec = usec % 1000000;
+}
+
+/* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
+static force_inline void do_get_tz(struct timezone * tz)
+{
+		*tz = __sys_tz;
+}
+
+
+static force_inline int gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	int ret;
+	asm volatile("syscall" 
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
+	return ret;
+}
+
+static force_inline long time_syscall(long *t)
+{
+	long secs;
+	asm volatile("syscall" 
+		: "=a" (secs)
+		: "0" (__NR_time),"D" (t) : __syscall_clobber);
+	return secs;
+}
+
+static int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
+{
+	if (unlikely(!__sysctl_vsyscall))
+	return gettimeofday(tv,tz); 
+	if (tv)
+		do_vgettimeofday(tv);
+	if (tz)
+		do_get_tz(tz);
+	return 0;
+}
+
+/* This will break when the xtime seconds get inaccurate, but that is
+ * unlikely */
+static time_t __vsyscall(1) vtime(time_t *t)
+{
+	if (unlikely(!__sysctl_vsyscall))
+		return time_syscall(t);
+	else if (t)
+		*t = __xtime.tv_sec;		
+	return __xtime.tv_sec;
+}
+
+static long __vsyscall(2) venosys_0(void)
+{
+	return -ENOSYS;
+}
+
+static long __vsyscall(3) venosys_1(void)
+{
+	return -ENOSYS;
+
+}
+
+static void __init map_vsyscall(void)
+{
+	extern char __vsyscall_0;
+	unsigned long physaddr_page0 = __pa_symbol(&__vsyscall_0);
+
+	__set_fixmap(VSYSCALL_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
+}
+
+static int __init vsyscall_init(void)
+{
+	if ((unsigned long) &vgettimeofday != VSYSCALL_ADDR(__NR_vgettimeofday))
+		panic("vgettimeofday link addr broken");
+	if ((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime))
+		panic("vtime link addr broken");
+	if (VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE))
+		panic("fixmap first vsyscall %lx should be %lx", __fix_to_virt(VSYSCALL_FIRST_PAGE),
+		      VSYSCALL_ADDR(0));
+	map_vsyscall();
+
+	return 0;
+}
+
+__initcall(vsyscall_init);
Index: linux-2.6.7/arch/x86_64/kernel/vsyscall/Makefile
===================================================================
--- linux-2.6.7.orig/arch/x86_64/kernel/vsyscall/Makefile	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.7/arch/x86_64/kernel/vsyscall/Makefile	2004-09-07 18:48:58.000000000 +0530
@@ -0,0 +1,3 @@
+EXTRA_CFLAGS	:= -g0
+
+obj-y := vsyscall.o

--=-lVV67ecaEcox55SF8A9E--

