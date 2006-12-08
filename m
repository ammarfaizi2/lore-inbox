Return-Path: <linux-kernel-owner+w=401wt.eu-S1425629AbWLHQv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425629AbWLHQv4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425632AbWLHQv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:51:56 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:58985 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425629AbWLHQvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:51:55 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] group xtime, xtime_lock, wall_to_monotonic, avenrun, calc_load_count fields together in ktimed
Date: Fri, 8 Dec 2006 17:52:09 +0100
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20061206234942.79d6db01.akpm@osdl.org> <457849E2.3080909@garzik.org> <20061207095715.0cafffb9.akpm@osdl.org>
In-Reply-To: <20061207095715.0cafffb9.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5gZeFEV8GdHgg3p"
Message-Id: <200612081752.09749.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_5gZeFEV8GdHgg3p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch introduces a new structure called ktimed (Kernel Time Data), where 
some time keeping related variables are put together to share as few cache 
lines as possible. This avoid some false sharing, (since linker could put 
calc_load_count in a *random* cache line for example)

I also optimized calc_load() to not always call count_active_tasks() :
It should call it only once every 5 seconds (LOAD_FREQ=5*HZ)

Note : x86_64 was using an arch specific placement of __xtime and __xtime_lock 
(see arch/x86_64/kernel/vmlinux.lds.S). (vsyscall stuff)
It is now using a specific placement of __ktimed, since xtime and xtime_lock 
are now fields from __ktimed.

Note : I failed to move jiffies64 as well in ktimed : too many changes needed 
because of jiffies aliasing (and endianess), but it could be done.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
---
 arch/x86_64/kernel/time.c        |    5 ++-
 arch/x86_64/kernel/vmlinux.lds.S |    7 +---
 arch/x86_64/kernel/vsyscall.c    |    1 
 include/asm-x86_64/vsyscall.h    |   13 +++------
 include/linux/sched.h            |    1 
 include/linux/time.h             |   18 ++++++++++--
 kernel/timer.c                   |   41 ++++++++++++-----------------
 7 files changed, 43 insertions(+), 43 deletions(-)


--Boundary-00=_5gZeFEV8GdHgg3p
Content-Type: text/plain;
  charset="iso-8859-1";
  name="xtime_s.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="xtime_s.patch"

--- linux-2.6.19/include/linux/time.h	2006-12-08 11:40:46.000000000 +0100
+++ linux-2.6.19-ed/include/linux/time.h	2006-12-08 16:58:57.000000000 +0100
@@ -88,9 +88,21 @@ static inline struct timespec timespec_s
 #define timespec_valid(ts) \
 	(((ts)->tv_sec >= 0) && (((unsigned long) (ts)->tv_nsec) < NSEC_PER_SEC))
 
-extern struct timespec xtime;
-extern struct timespec wall_to_monotonic;
-extern seqlock_t xtime_lock;
+/*
+ * define a structure to keep all fields close to each others.
+ */
+struct ktimed_struct {
+	struct timespec _xtime;
+	struct timespec wall_to_monotonic;
+	seqlock_t lock;
+	unsigned long avenrun[3];
+	int calc_load_count;
+};
+extern struct ktimed_struct ktimed;
+#define xtime             ktimed._xtime
+#define wall_to_monotonic ktimed.wall_to_monotonic
+#define xtime_lock        ktimed.lock
+#define avenrun           ktimed.avenrun
 
 void timekeeping_init(void);
 
--- linux-2.6.19/kernel/timer.c	2006-12-08 11:50:11.000000000 +0100
+++ linux-2.6.19-ed/kernel/timer.c	2006-12-08 18:13:24.000000000 +0100
@@ -570,11 +570,13 @@ found:
  * however, we will ALWAYS keep the tv_nsec part positive so we can use
  * the usual normalization.
  */
-struct timespec xtime __attribute__ ((aligned (16)));
-struct timespec wall_to_monotonic __attribute__ ((aligned (16)));
-
-EXPORT_SYMBOL(xtime);
-
+#ifndef ARCH_HAVE_KTIMED
+struct ktimed_struct ktimed __cacheline_aligned = {
+	.lock = __SEQLOCK_UNLOCKED(ktimed.lock),
+	.calc_load_count = LOAD_FREQ,
+};
+EXPORT_SYMBOL(ktimed);
+#endif
 
 /* XXX - all of this timekeeping code should be later moved to time.c */
 #include <linux/clocksource.h>
@@ -995,9 +997,6 @@ static unsigned long count_active_tasks(
  *
  * Requires xtime_lock to access.
  */
-unsigned long avenrun[3];
-
-EXPORT_SYMBOL(avenrun);
 
 /*
  * calc_load - given tick count, update the avenrun load estimates.
@@ -1006,27 +1005,21 @@ EXPORT_SYMBOL(avenrun);
 static inline void calc_load(unsigned long ticks)
 {
 	unsigned long active_tasks; /* fixed-point */
-	static int count = LOAD_FREQ;
 
-	active_tasks = count_active_tasks();
-	for (count -= ticks; count < 0; count += LOAD_FREQ) {
-		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
-		CALC_LOAD(avenrun[1], EXP_5, active_tasks);
-		CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+	ktimed.calc_load_count -= ticks;
+
+	if (unlikely(ktimed.calc_load_count < 0)) {
+		active_tasks = count_active_tasks();
+		do {
+			ktimed.calc_load_count += LOAD_FREQ;
+			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
+			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
+			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+		} while (ktimed.calc_load_count < 0);
 	}
 }
 
 /*
- * This read-write spinlock protects us from races in SMP while
- * playing with xtime and avenrun.
- */
-#ifndef ARCH_HAVE_XTIME_LOCK
-__cacheline_aligned_in_smp DEFINE_SEQLOCK(xtime_lock);
-
-EXPORT_SYMBOL(xtime_lock);
-#endif
-
-/*
  * This function runs timers and the timer-tq in bottom half context.
  */
 static void run_timer_softirq(struct softirq_action *h)
--- linux-2.6.19/include/linux/sched.h	2006-12-08 12:10:45.000000000 +0100
+++ linux-2.6.19-ed/include/linux/sched.h	2006-12-08 12:10:59.000000000 +0100
@@ -104,7 +104,6 @@ struct futex_pi_state;
  *    the EXP_n values would be 1981, 2034 and 2043 if still using only
  *    11 bit fractions.
  */
-extern unsigned long avenrun[];		/* Load averages */
 
 #define FSHIFT		11		/* nr of bits of precision */
 #define FIXED_1		(1<<FSHIFT)	/* 1.0 as fixed-point */
--- linux-2.6.19/include/asm-x86_64/vsyscall.h	2006-12-08 11:47:03.000000000 +0100
+++ linux-2.6.19-ed/include/asm-x86_64/vsyscall.h	2006-12-08 18:04:29.000000000 +0100
@@ -20,8 +20,7 @@ enum vsyscall_num {
 #define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
 #define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz"), aligned(16)))
 #define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
-#define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
-#define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
+#define __section_ktimed __attribute__ ((unused, __section__ (".ktimed"), aligned(16)))
 
 #define VXTIME_TSC	1
 #define VXTIME_HPET	2
@@ -45,21 +44,19 @@ struct vxtime_data {
 /* vsyscall space (readonly) */
 extern struct vxtime_data __vxtime;
 extern int __vgetcpu_mode;
-extern struct timespec __xtime;
 extern volatile unsigned long __jiffies;
 extern struct timezone __sys_tz;
-extern seqlock_t __xtime_lock;
+extern struct ktimed_struct __ktimed;
+#define __xtime_lock __ktimed.lock
+#define __xtime      __ktimed._xtime
 
 /* kernel space (writeable) */
 extern struct vxtime_data vxtime;
 extern int vgetcpu_mode;
 extern struct timezone sys_tz;
 extern int sysctl_vsyscall;
-extern seqlock_t xtime_lock;
 
-extern int sysctl_vsyscall;
-
-#define ARCH_HAVE_XTIME_LOCK 1
+#define ARCH_HAVE_KTIMED 1
 
 #endif /* __KERNEL__ */
 
--- linux-2.6.19/arch/x86_64/kernel/vmlinux.lds.S	2006-12-08 16:03:13.000000000 +0100
+++ linux-2.6.19-ed/arch/x86_64/kernel/vmlinux.lds.S	2006-12-08 17:52:29.000000000 +0100
@@ -94,8 +94,8 @@ SECTIONS
   __vsyscall_0 = VSYSCALL_VIRT_ADDR;
 
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .xtime_lock : AT(VLOAD(.xtime_lock)) { *(.xtime_lock) }
-  xtime_lock = VVIRT(.xtime_lock);
+  .ktimed : AT(VLOAD(.ktimed)) { *(.ktimed) }
+  ktimed = VVIRT(.ktimed);
 
   .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
   vxtime = VVIRT(.vxtime);
@@ -109,9 +109,6 @@ SECTIONS
   .sysctl_vsyscall : AT(VLOAD(.sysctl_vsyscall)) { *(.sysctl_vsyscall) }
   sysctl_vsyscall = VVIRT(.sysctl_vsyscall);
 
-  .xtime : AT(VLOAD(.xtime)) { *(.xtime) }
-  xtime = VVIRT(.xtime);
-
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   .jiffies : AT(VLOAD(.jiffies)) { *(.jiffies) }
   jiffies = VVIRT(.jiffies);
--- linux-2.6.19/arch/x86_64/kernel/vsyscall.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19-ed/arch/x86_64/kernel/vsyscall.c	2006-12-08 18:02:49.000000000 +0100
@@ -44,7 +44,6 @@
 #define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
-seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
 int __vgetcpu_mode __section_vgetcpu_mode;
 
 #include <asm/unistd.h>
--- linux-2.6.19/arch/x86_64/kernel/time.c	2006-12-08 16:22:15.000000000 +0100
+++ linux-2.6.19-ed/arch/x86_64/kernel/time.c	2006-12-08 18:13:24.000000000 +0100
@@ -77,7 +77,10 @@ unsigned long long monotonic_base;
 struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
 
 volatile unsigned long __jiffies __section_jiffies = INITIAL_JIFFIES;
-struct timespec __xtime __section_xtime;
+struct ktimed_struct __ktimed __section_ktimed = {
+	.lock =  __SEQLOCK_UNLOCKED(ktimed.lock),
+	.calc_load_count = LOAD_FREQ,
+};
 struct timezone __sys_tz __section_sys_tz;
 
 /*

--Boundary-00=_5gZeFEV8GdHgg3p--
