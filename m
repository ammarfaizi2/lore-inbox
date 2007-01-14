Return-Path: <linux-kernel-owner+w=401wt.eu-S1751169AbXANIHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbXANIHR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 03:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXANIHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 03:07:17 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:57759 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbXANIHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 03:07:14 -0500
Date: Sun, 14 Jan 2007 00:07:12 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: ak@muc.de, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] faster vgetcpu using sidt (take 2)
In-Reply-To: <Pine.LNX.4.64.0701132245260.27121@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.64.0701140002330.16472@twinlark.arctic.org>
References: <Pine.LNX.4.64.0701061807530.26307@twinlark.arctic.org>
 <Pine.LNX.4.64.0701132245260.27121@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2007, dean gaudet wrote:

> ok here is the latest rev of this patch (against 2.6.20-rc4).
> 
> timings in cycles:
> 
>                 baseline   patched    baseline   patched
>                 no cache   no cache    cache      cache
> k8 pre-revF        21        16          14        17
> k8 revF            31        17          14        17
> core2              38        16          12        14
> p4                 49        41          24        24
> 
> the degredation in cached timings appears to be due to the 16 byte stack
> frame set up for the sidt instruction.  apparently due to -mno-red-zone...
> would you accept a patch which re-enables the red-zone for vsyscalls?

here is a first stab at a patch (applied on top of my vgetcpu sidt patch) 
which enables red-zone for vsyscall.  it fixes the cache degredation 
problem above by getting rid of the stack frame setup in vgetcpu (and 
improves the no cache cases as well but i haven't run it everywhere yet).

to do this i split the user-mode-only portion of vsyscall.c into 
vsyscall_user.c.  this required a couple externs in vsyscall.c and two 
extra ".globl" in the asm in vsyscall_user.c.

i'm not sure if we need the CFLAGS_vsyscall.o still or not.

let me know what you think... thanks.

-dean

Index: linux/arch/x86_64/kernel/Makefile
===================================================================
--- linux.orig/arch/x86_64/kernel/Makefile	2006-11-29 13:57:37.000000000 -0800
+++ linux/arch/x86_64/kernel/Makefile	2007-01-13 23:34:22.000000000 -0800
@@ -6,7 +6,7 @@
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
-		x8664_ksyms.o i387.o syscall.o vsyscall.o \
+		x8664_ksyms.o i387.o syscall.o vsyscall.o vsyscall_user.o \
 		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
 		pci-dma.o pci-nommu.o alternative.o
 
@@ -45,6 +45,7 @@
 obj-y				+= intel_cacheinfo.o
 
 CFLAGS_vsyscall.o		:= $(PROFILING) -g0
+CFLAGS_vsyscall_user.o		:= $(PROFILING) -g0 -mred-zone
 
 therm_throt-y                   += ../../i386/kernel/cpu/mcheck/therm_throt.o
 bootflag-y			+= ../../i386/kernel/bootflag.o
Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c	2007-01-13 22:21:01.000000000 -0800
+++ linux/arch/x86_64/kernel/vsyscall.c	2007-01-13 23:41:08.000000000 -0800
@@ -40,161 +40,12 @@
 #include <asm/segment.h>
 #include <asm/desc.h>
 #include <asm/topology.h>
-
-#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
-#define __syscall_clobber "r11","rcx","memory"
-
-int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
-seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
-
-/* is this necessary? */
-#ifndef CONFIG_NODES_SHIFT
-#define CONFIG_NODES_SHIFT 0
-#endif
-
 #include <asm/unistd.h>
 
-static __always_inline void timeval_normalize(struct timeval * tv)
-{
-	time_t __sec;
-
-	__sec = tv->tv_usec / 1000000;
-	if (__sec) {
-		tv->tv_usec %= 1000000;
-		tv->tv_sec += __sec;
-	}
-}
-
-static __always_inline void do_vgettimeofday(struct timeval * tv)
-{
-	long sequence, t;
-	unsigned long sec, usec;
-
-	do {
-		sequence = read_seqbegin(&__xtime_lock);
-		
-		sec = __xtime.tv_sec;
-		usec = __xtime.tv_nsec / 1000;
-
-		if (__vxtime.mode != VXTIME_HPET) {
-			t = get_cycles_sync();
-			if (t < __vxtime.last_tsc)
-				t = __vxtime.last_tsc;
-			usec += ((t - __vxtime.last_tsc) *
-				 __vxtime.tsc_quot) >> 32;
-			/* See comment in x86_64 do_gettimeofday. */
-		} else {
-			usec += ((readl((void __iomem *)
-				   fix_to_virt(VSYSCALL_HPET) + 0xf0) -
-				  __vxtime.last) * __vxtime.quot) >> 32;
-		}
-	} while (read_seqretry(&__xtime_lock, sequence));
-
-	tv->tv_sec = sec + usec / 1000000;
-	tv->tv_usec = usec % 1000000;
-}
-
-/* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
-static __always_inline void do_get_tz(struct timezone * tz)
-{
-	*tz = __sys_tz;
-}
-
-static __always_inline int gettimeofday(struct timeval *tv, struct timezone *tz)
-{
-	int ret;
-	asm volatile("vsysc2: syscall"
-		: "=a" (ret)
-		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
-	return ret;
-}
-
-static __always_inline long time_syscall(long *t)
-{
-	long secs;
-	asm volatile("vsysc1: syscall"
-		: "=a" (secs)
-		: "0" (__NR_time),"D" (t) : __syscall_clobber);
-	return secs;
-}
-
-int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
-{
-	if (!__sysctl_vsyscall)
-		return gettimeofday(tv,tz);
-	if (tv)
-		do_vgettimeofday(tv);
-	if (tz)
-		do_get_tz(tz);
-	return 0;
-}
-
-/* This will break when the xtime seconds get inaccurate, but that is
- * unlikely */
-time_t __vsyscall(1) vtime(time_t *t)
-{
-	if (!__sysctl_vsyscall)
-		return time_syscall(t);
-	else if (t)
-		*t = __xtime.tv_sec;		
-	return __xtime.tv_sec;
-}
-
-/* Fast way to get current CPU and node.
-   This helps to do per node and per CPU caches in user space.
-   The result is not guaranteed without CPU affinity, but usually
-   works out because the scheduler tries to keep a thread on the same
-   CPU.
-
-   tcache must point to a two element sized long array.
-   All arguments can be NULL. */
-long __vsyscall(2)
-vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
-{
-	unsigned int p;
-	unsigned long j = 0;
-
-	/* Fast cache - only recompute value once per jiffies and avoid
-	   relatively costly lsl/sidt otherwise.
-	   This works because the scheduler usually keeps the process
-	   on the same CPU and this syscall doesn't guarantee its
-	   results anyways.
-	   We do this here because otherwise user space would do it on
-	   its own in a likely inferior way (no access to jiffies).
-	   If you don't like it pass NULL. */
-	if (tcache && tcache->blob[0] == (j = __jiffies)) {
-		p = tcache->blob[1];
-	}
-	else {
-#ifdef VGETCPU_USE_SIDT
-                struct {
-                        char pad[6];	/* avoid unaligned stores */
-                        u16 size;
-                        u64 address;
-                } idt;
-
-                asm("sidt %0" : "=m" (idt.size));
-                p = idt.size - 0x1000;
-#else
-		/* Load per CPU data from GDT */
-		asm("lsl %1,%0" : "=r" (p) : "r" (__PER_CPU_SEG));
-#endif
-		if (tcache) {
-			tcache->blob[0] = j;
-			tcache->blob[1] = p;
-		}
-	}
-	if (cpu)
-		*cpu = p >> CONFIG_NODES_SHIFT;
-	if (node)
-		*node = p & ((1<<CONFIG_NODES_SHIFT) - 1);
-	return 0;
-}
-
-long __vsyscall(3) venosys_1(void)
-{
-	return -ENOSYS;
-}
+/* the vsyscalls themselves */
+extern int vgettimeofday(struct timeval * tv, struct timezone * tz);
+extern time_t vtime(time_t *t);
+extern long vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache);
 
 #ifdef CONFIG_SYSCTL
 
@@ -259,6 +110,11 @@
 
 #endif
 
+/* is this necessary? */
+#ifndef CONFIG_NODES_SHIFT
+#define CONFIG_NODES_SHIFT 0
+#endif
+
 /* Assume __initcall executes before all user space. Hopefully kmod
    doesn't violate that. We'll find out if it does. */
 static void __cpuinit vsyscall_set_cpu(int cpu)
Index: linux/arch/x86_64/kernel/vsyscall_user.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/x86_64/kernel/vsyscall_user.c	2007-01-14 00:03:44.000000000 -0800
@@ -0,0 +1,201 @@
+/*
+ *  linux/arch/x86_64/kernel/vsyscall_user.c
+ *
+ *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
+ *  Copyright 2003 Andi Kleen, SuSE Labs.
+ *
+ *  Thanks to hpa@transmeta.com for some useful hint.
+ *  Special thanks to Ingo Molnar for his early experience with
+ *  a different vsyscall implementation for Linux/IA32 and for the name.
+ *
+ *  vsyscall 1 is located at -10Mbyte, vsyscall 2 is located
+ *  at virtual address -10Mbyte+1024bytes etc... There are at max 4
+ *  vsyscalls. One vsyscall can reserve more than 1 slot to avoid
+ *  jumping out of line if necessary. We cannot add more with this
+ *  mechanism because older kernels won't return -ENOSYS.
+ *  If we want more than four we need a vDSO.
+ *
+ *  Note: the concept clashes with user mode linux. If you use UML and
+ *  want per guest time just set the kernel.vsyscall64 sysctl to 0.
+ */
+
+#include <linux/time.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/seqlock.h>
+#include <linux/jiffies.h>
+#include <linux/sysctl.h>
+#include <linux/getcpu.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <linux/notifier.h>
+
+#include <asm/vsyscall.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/errno.h>
+#include <asm/io.h>
+#include <asm/segment.h>
+#include <asm/desc.h>
+#include <asm/topology.h>
+
+#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
+#define __syscall_clobber "r11","rcx","memory"
+
+int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
+seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
+
+#include <asm/unistd.h>
+
+static __always_inline void timeval_normalize(struct timeval * tv)
+{
+	time_t __sec;
+
+	__sec = tv->tv_usec / 1000000;
+	if (__sec) {
+		tv->tv_usec %= 1000000;
+		tv->tv_sec += __sec;
+	}
+}
+
+static __always_inline void do_vgettimeofday(struct timeval * tv)
+{
+	long sequence, t;
+	unsigned long sec, usec;
+
+	do {
+		sequence = read_seqbegin(&__xtime_lock);
+
+		sec = __xtime.tv_sec;
+		usec = __xtime.tv_nsec / 1000;
+
+		if (__vxtime.mode != VXTIME_HPET) {
+			t = get_cycles_sync();
+			if (t < __vxtime.last_tsc)
+				t = __vxtime.last_tsc;
+			usec += ((t - __vxtime.last_tsc) *
+				 __vxtime.tsc_quot) >> 32;
+			/* See comment in x86_64 do_gettimeofday. */
+		} else {
+			usec += ((readl((void __iomem *)
+				   fix_to_virt(VSYSCALL_HPET) + 0xf0) -
+				  __vxtime.last) * __vxtime.quot) >> 32;
+		}
+	} while (read_seqretry(&__xtime_lock, sequence));
+
+	tv->tv_sec = sec + usec / 1000000;
+	tv->tv_usec = usec % 1000000;
+}
+
+/* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
+static __always_inline void do_get_tz(struct timezone * tz)
+{
+	*tz = __sys_tz;
+}
+
+static __always_inline int gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	int ret;
+	asm volatile(
+                ".globl vsysc2\n"
+                "vsysc2: syscall\n"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
+	return ret;
+}
+
+static __always_inline long time_syscall(long *t)
+{
+	long secs;
+	asm volatile(
+                ".globl vsysc1\n"
+                "vsysc1: syscall\n"
+		: "=a" (secs)
+		: "0" (__NR_time),"D" (t) : __syscall_clobber);
+	return secs;
+}
+
+int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
+{
+	if (!__sysctl_vsyscall)
+		return gettimeofday(tv,tz);
+	if (tv)
+		do_vgettimeofday(tv);
+	if (tz)
+		do_get_tz(tz);
+	return 0;
+}
+
+/* This will break when the xtime seconds get inaccurate, but that is
+ * unlikely */
+time_t __vsyscall(1) vtime(time_t *t)
+{
+	if (!__sysctl_vsyscall)
+		return time_syscall(t);
+	else if (t)
+		*t = __xtime.tv_sec;
+	return __xtime.tv_sec;
+}
+
+/* is this necessary? */
+#ifndef CONFIG_NODES_SHIFT
+#define CONFIG_NODES_SHIFT 0
+#endif
+
+/* Fast way to get current CPU and node.
+   This helps to do per node and per CPU caches in user space.
+   The result is not guaranteed without CPU affinity, but usually
+   works out because the scheduler tries to keep a thread on the same
+   CPU.
+
+   tcache must point to a two element sized long array.
+   All arguments can be NULL. */
+long __vsyscall(2)
+vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+{
+	unsigned int p;
+	unsigned long j = 0;
+
+	/* Fast cache - only recompute value once per jiffies and avoid
+	   relatively costly lsl/sidt otherwise.
+	   This works because the scheduler usually keeps the process
+	   on the same CPU and this syscall doesn't guarantee its
+	   results anyways.
+	   We do this here because otherwise user space would do it on
+	   its own in a likely inferior way (no access to jiffies).
+	   If you don't like it pass NULL. */
+	if (tcache && tcache->blob[0] == (j = __jiffies)) {
+		p = tcache->blob[1];
+	}
+	else {
+#ifdef VGETCPU_USE_SIDT
+                struct {
+                        char pad[6];	/* avoid unaligned stores */
+                        u16 size;
+                        u64 address;
+                } idt;
+
+                asm("sidt %0" : "=m" (idt.size));
+                p = idt.size - 0x1000;
+#else
+		/* Load per CPU data from GDT */
+		asm("lsl %1,%0" : "=r" (p) : "r" (__PER_CPU_SEG));
+#endif
+		if (tcache) {
+			tcache->blob[0] = j;
+			tcache->blob[1] = p;
+		}
+	}
+	if (cpu)
+		*cpu = p >> CONFIG_NODES_SHIFT;
+	if (node)
+		*node = p & ((1<<CONFIG_NODES_SHIFT) - 1);
+	return 0;
+}
+
+long __vsyscall(3) venosys_1(void)
+{
+	return -ENOSYS;
+}
