Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWHICSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWHICSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWHICRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:17:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46741 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751235AbWHICRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:17:49 -0400
Date: Tue, 8 Aug 2006 22:17:46 -0400
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060809021746.23103.1842.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
Subject: [RFC][PATCH 6/6] x86_64: GENERIC_TIME based vsyscall code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-enable vsyscall gettimeofday using the generic clocksource 
infrastructure.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/x86_64/Kconfig              |    4 +
 arch/x86_64/kernel/time.c        |   23 +++++--
 arch/x86_64/kernel/vmlinux.lds.S |   24 +-------
 arch/x86_64/kernel/vsyscall.c    |  116 ++++++++++++++++++++++++++-------------
 include/asm-x86_64/proto.h       |    2 
 include/asm-x86_64/timex.h       |    2 
 include/asm-x86_64/vsyscall.h    |   38 +-----------
 7 files changed, 105 insertions(+), 104 deletions(-)

linux-2.6.18-rc4_timeofday-arch-x86-64-part5_C5.patch
============================================
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index fabb174..6167ce2 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -28,6 +28,10 @@ config GENERIC_TIME
 	bool
 	default y
 
+config GENERIC_TIME_VSYSCALL
+	bool
+	default y
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 546abc7..3501871 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -68,16 +68,9 @@ unsigned long hpet_address;
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 int hpet_use_timer;				/* Use counter of hpet for time keeping, otherwise PIT */
-unsigned long vxtime_hz = PIT_TICK_RATE;
 int report_lost_ticks;				/* command line option */
-unsigned long long monotonic_base;
 
-struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
-
-volatile unsigned long __jiffies __section_jiffies = INITIAL_JIFFIES;
-unsigned long __wall_jiffies __section_wall_jiffies = INITIAL_JIFFIES;
-struct timespec __xtime __section_xtime;
-struct timezone __sys_tz __section_sys_tz;
+volatile unsigned long jiffies  = INITIAL_JIFFIES;
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
@@ -1021,6 +1014,13 @@ static cycle_t read_tsc(void)
 	return ret;
 }
 
+static cycle_t __vsyscall_fn vread_tsc(void)
+{
+	cycle_t ret;
+	rdtscll(ret);
+	return ret;
+}
+
 static struct clocksource clocksource_tsc = {
 	.name			= "tsc",
 	.rating			= 300,
@@ -1030,6 +1030,7 @@ static struct clocksource clocksource_ts
 	.shift			= 22,
 	.update_callback	= tsc_update_callback,
 	.is_continuous		= 1,
+	.vread			= vread_tsc,
 };
 
 static int tsc_update_callback(void)
@@ -1080,6 +1081,11 @@ static cycle_t read_hpet(void)
 	return (cycle_t)readl(hpet_ptr);
 }
 
+static cycle_t __vsyscall_fn vread_hpet(void)
+{
+	return (cycle_t)readl((void *)fix_to_virt(VSYSCALL_HPET) + 0xf0);
+}
+
 struct clocksource clocksource_hpet = {
 	.name		= "hpet",
 	.rating		= 250,
@@ -1088,6 +1094,7 @@ struct clocksource clocksource_hpet = {
 	.mult		= 0, /* set below */
 	.shift		= HPET_SHIFT,
 	.is_continuous	= 1,
+	.vread		= vread_hpet,
 };
 
 static int __init init_hpet_clocksource(void)
diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
index 7c4de31..9e7c048 100644
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -93,27 +93,11 @@ SECTIONS
   __vsyscall_0 = VSYSCALL_VIRT_ADDR;
 
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .xtime_lock : AT(VLOAD(.xtime_lock)) { *(.xtime_lock) }
-  xtime_lock = VVIRT(.xtime_lock);
-
-  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
-  vxtime = VVIRT(.vxtime);
-
-  .wall_jiffies : AT(VLOAD(.wall_jiffies)) { *(.wall_jiffies) }
-  wall_jiffies = VVIRT(.wall_jiffies);
-
-  .sys_tz : AT(VLOAD(.sys_tz)) { *(.sys_tz) }
-  sys_tz = VVIRT(.sys_tz);
-
-  .sysctl_vsyscall : AT(VLOAD(.sysctl_vsyscall)) { *(.sysctl_vsyscall) }
-  sysctl_vsyscall = VVIRT(.sysctl_vsyscall);
-
-  .xtime : AT(VLOAD(.xtime)) { *(.xtime) }
-  xtime = VVIRT(.xtime);
-
+  .vsyscall_fn : AT(VLOAD(.vsyscall_fn)) { *(.vsyscall_fn) }
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .jiffies : AT(VLOAD(.jiffies)) { *(.jiffies) }
-  jiffies = VVIRT(.jiffies);
+  .vsyscall_gtod_data : AT(VLOAD(.vsyscall_gtod_data)) { *(.vsyscall_gtod_data) }
+  vsyscall_gtod_data = VVIRT(.vsyscall_gtod_data);
+
 
   .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT(VLOAD(.vsyscall_1)) { *(.vsyscall_1) }
   .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index f603037..cdd8448 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -26,65 +26,105 @@
 #include <linux/seqlock.h>
 #include <linux/jiffies.h>
 #include <linux/sysctl.h>
+#include <linux/clocksource.h>
 
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/unistd.h>
 #include <asm/fixmap.h>
 #include <asm/errno.h>
 #include <asm/io.h>
 
 #define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
 
-int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
-seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
+struct vsyscall_gtod_data_t {
+	seqlock_t lock;
+	int sysctl_enabled;
+	struct timeval wall_time_tv;
+	struct timezone sys_tz;
+	cycle_t offset_base;
+	struct clocksource clock;
+};
+
+struct vsyscall_gtod_data_t __vsyscall_gtod_data __section_vsyscall_gtod_data =  {
+	.lock = SEQLOCK_UNLOCKED,
+	.sysctl_enabled = 1,
+};
+extern struct vsyscall_gtod_data_t vsyscall_gtod_data;
 
-#include <asm/unistd.h>
 
-static __always_inline void timeval_normalize(struct timeval * tv)
+void update_vsyscall(struct timespec* wall_time, struct clocksource* clock)
 {
-	time_t __sec;
+	unsigned long flags;
 
-	__sec = tv->tv_usec / 1000000;
-	if (__sec) {
-		tv->tv_usec %= 1000000;
-		tv->tv_sec += __sec;
-	}
+	write_seqlock_irqsave(&vsyscall_gtod_data.lock, flags);
+	/* copy vsyscall data */
+	vsyscall_gtod_data.clock = *clock;
+	vsyscall_gtod_data.wall_time_tv.tv_sec = wall_time->tv_sec;
+	vsyscall_gtod_data.wall_time_tv.tv_usec = wall_time->tv_nsec/1000;
+	vsyscall_gtod_data.sys_tz = sys_tz;
+
+	write_sequnlock_irqrestore(&vsyscall_gtod_data.lock, flags);
+}
+
+/*
+ * XXX - this is ugly. gettimeofday() has a label in it so we can't
+ *       call it twice.
+ */
+static __always_inline int syscall_gtod(struct timeval *tv, struct timezone *tz)
+{
+	int ret;
+
+	asm volatile("syscall"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz)
+		: __syscall_clobber);
+
+	return ret;
 }
 
+
 static __always_inline void do_vgettimeofday(struct timeval * tv)
 {
-	long sequence, t;
-	unsigned long sec, usec;
+	cycle_t now, base, mask, cycle_delta;
+	unsigned long seq, mult, shift, nsec_delta;
 
 	do {
-		sequence = read_seqbegin(&__xtime_lock);
-		
-		sec = __xtime.tv_sec;
-		usec = (__xtime.tv_nsec / 1000) +
-			(__jiffies - __wall_jiffies) * (1000000 / HZ);
-
-		if (__vxtime.mode != VXTIME_HPET) {
-			t = get_cycles_sync();
-			if (t < __vxtime.last_tsc)
-				t = __vxtime.last_tsc;
-			usec += ((t - __vxtime.last_tsc) *
-				 __vxtime.tsc_quot) >> 32;
-			/* See comment in x86_64 do_gettimeofday. */
-		} else {
-			usec += ((readl((void *)fix_to_virt(VSYSCALL_HPET) + 0xf0) -
-				  __vxtime.last) * __vxtime.quot) >> 32;
+		seq = read_seqbegin(&__vsyscall_gtod_data.lock);
+		if (!__vsyscall_gtod_data.clock.vread) {
+			syscall_gtod(tv, NULL);
+			return;
 		}
-	} while (read_seqretry(&__xtime_lock, sequence));
 
-	tv->tv_sec = sec + usec / 1000000;
-	tv->tv_usec = usec % 1000000;
+		now = __vsyscall_gtod_data.clock.vread();
+
+		base = __vsyscall_gtod_data.clock.cycle_last;
+		mask = __vsyscall_gtod_data.clock.mask;
+		mult = __vsyscall_gtod_data.clock.mult;
+		shift = __vsyscall_gtod_data.clock.shift;
+
+		*tv = __vsyscall_gtod_data.wall_time_tv;
+
+	} while (read_seqretry(&__vsyscall_gtod_data.lock, seq));
+
+	/* calculate interval: */
+	cycle_delta = (now - base) & mask;
+	/* convert to nsecs: */
+	nsec_delta = (cycle_delta * mult) >> shift;
+
+	/* convert to usecs and add to timespec: */
+	tv->tv_usec += nsec_delta / NSEC_PER_USEC;
+	while (tv->tv_usec > USEC_PER_SEC) {
+		tv->tv_sec += 1;
+		tv->tv_usec -= USEC_PER_SEC;
+	}
 }
 
 /* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
 static __always_inline void do_get_tz(struct timezone * tz)
 {
-	*tz = __sys_tz;
+	*tz = __vsyscall_gtod_data.sys_tz;
 }
 
 static __always_inline int gettimeofday(struct timeval *tv, struct timezone *tz)
@@ -107,7 +147,7 @@ static __always_inline long time_syscall
 
 int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
 {
-	if (!__sysctl_vsyscall)
+	if (unlikely(!__vsyscall_gtod_data.sysctl_enabled))
 		return gettimeofday(tv,tz);
 	if (tv)
 		do_vgettimeofday(tv);
@@ -120,11 +160,11 @@ int __vsyscall(0) vgettimeofday(struct t
  * unlikely */
 time_t __vsyscall(1) vtime(time_t *t)
 {
-	if (!__sysctl_vsyscall)
+	if (unlikely(!__vsyscall_gtod_data.sysctl_enabled))
 		return time_syscall(t);
 	else if (t)
-		*t = __xtime.tv_sec;		
-	return __xtime.tv_sec;
+		*t = __vsyscall_gtod_data.wall_time_tv.tv_sec;
+	return __vsyscall_gtod_data.wall_time_tv.tv_sec;
 }
 
 long __vsyscall(2) venosys_0(void)
@@ -163,7 +203,7 @@ static int vsyscall_sysctl_change(ctl_ta
 		ret = -ENOMEM;
 		goto out;
 	}
-	if (!sysctl_vsyscall) {
+	if (!vsyscall_gtod_data.sysctl_enabled) {
 		*map1 = SYSCALL;
 		*map2 = SYSCALL;
 	} else {
@@ -186,7 +226,7 @@ static int vsyscall_sysctl_nostrat(ctl_t
 
 static ctl_table kernel_table2[] = {
 	{ .ctl_name = 99, .procname = "vsyscall64",
-	  .data = &sysctl_vsyscall, .maxlen = sizeof(int), .mode = 0644,
+	  .data = &vsyscall_gtod_data.sysctl_enabled, .maxlen = sizeof(int), .mode = 0644,
 	  .strategy = vsyscall_sysctl_nostrat,
 	  .proc_handler = vsyscall_sysctl_change },
 	{ 0, }
diff --git a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
index 716ac55..33d1a19 100644
--- a/include/asm-x86_64/proto.h
+++ b/include/asm-x86_64/proto.h
@@ -47,9 +47,7 @@ extern u32 pmtmr_ioport;
 #else
 #define pmtmr_ioport 0
 #endif
-extern int sysctl_vsyscall;
 extern int nohpet;
-extern unsigned long vxtime_hz;
 
 extern int numa_setup(char *opt);
 
diff --git a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
index 11c6820..043a774 100644
--- a/include/asm-x86_64/timex.h
+++ b/include/asm-x86_64/timex.h
@@ -47,6 +47,4 @@ extern void mark_tsc_unstable(void);
 extern int read_current_timer(unsigned long *timer_value);
 #define ARCH_HAS_READ_CURRENT_TIMER	1
 
-extern struct vxtime_data vxtime;
-
 #endif
diff --git a/include/asm-x86_64/vsyscall.h b/include/asm-x86_64/vsyscall.h
index a85e16f..0b5a499 100644
--- a/include/asm-x86_64/vsyscall.h
+++ b/include/asm-x86_64/vsyscall.h
@@ -15,49 +15,19 @@ enum vsyscall_num {
 
 #ifdef __KERNEL__
 
-#define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
-#define __section_wall_jiffies __attribute__ ((unused, __section__ (".wall_jiffies"), aligned(16)))
-#define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
-#define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz"), aligned(16)))
-#define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
-#define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
-#define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
-
-#define VXTIME_TSC	1
-#define VXTIME_HPET	2
-#define VXTIME_PMTMR	3
-
-struct vxtime_data {
-	long hpet_address;	/* HPET base address */
-	int last;
-	unsigned long last_tsc;
-	long quot;
-	long tsc_quot;
-	int mode;
-};
+/* Definitions for CONFIG_GENERIC_TIME definitions */
+#define __section_vsyscall_gtod_data __attribute__ ((unused, __section__ (".vsyscall_gtod_data"),aligned(16)))
+#define __vsyscall_fn __attribute__ ((unused,__section__(".vsyscall_fn")))
+
 
 #define hpet_readl(a)           readl((const void __iomem *)fix_to_virt(FIX_HPET_BASE) + a)
 #define hpet_writel(d,a)        writel(d, (void __iomem *)fix_to_virt(FIX_HPET_BASE) + a)
 
-/* vsyscall space (readonly) */
-extern struct vxtime_data __vxtime;
-extern struct timespec __xtime;
-extern volatile unsigned long __jiffies;
-extern unsigned long __wall_jiffies;
-extern struct timezone __sys_tz;
-extern seqlock_t __xtime_lock;
-
 /* kernel space (writeable) */
-extern struct vxtime_data vxtime;
 extern unsigned long wall_jiffies;
 extern struct timezone sys_tz;
-extern int sysctl_vsyscall;
 extern seqlock_t xtime_lock;
 
-extern int sysctl_vsyscall;
-
-#define ARCH_HAVE_XTIME_LOCK 1
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_64_VSYSCALL_H_ */
