Return-Path: <linux-kernel-owner+w=401wt.eu-S932874AbWLTBVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbWLTBVw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWLTBV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:21:27 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:48768 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932897AbWLTBVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:21:11 -0500
Date: Tue, 19 Dec 2006 20:21:09 -0500
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Message-Id: <20061220011737.25341.40577.sendpatchset@localhost>
In-Reply-To: <20061220011707.25341.6522.sendpatchset@localhost>
References: <20061220011707.25341.6522.sendpatchset@localhost>
Subject: [PATCH 5/5][time][x86_64] Re-enable vsyscall support for x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup and re-enable vsyscall gettimeofday using the generic 
clocksource infrastructure.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/x86_64/Kconfig              |    4 +
 arch/x86_64/kernel/hpet.c        |    6 +
 arch/x86_64/kernel/time.c        |    6 -
 arch/x86_64/kernel/tsc.c         |    7 ++
 arch/x86_64/kernel/vmlinux.lds.S |   28 +++------
 arch/x86_64/kernel/vsyscall.c    |  121 +++++++++++++++++++++++----------------
 include/asm-x86_64/proto.h       |    2 
 include/asm-x86_64/timex.h       |    1 
 include/asm-x86_64/vsyscall.h    |   33 +---------
 9 files changed, 105 insertions(+), 103 deletions(-)

linux-2.6.20-rc1_timeofday-arch-x86-64-vsyscall-reenablement_C7.patch
============================================
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index e1d044c..98b11c6 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -28,6 +28,10 @@ config GENERIC_TIME
 	bool
 	default y
 
+config GENERIC_TIME_VSYSCALL
+	bool
+	default y
+
 config ZONE_DMA32
 	bool
 	default y
diff --git a/arch/x86_64/kernel/hpet.c b/arch/x86_64/kernel/hpet.c
index 74d95d0..cd834cc 100644
--- a/arch/x86_64/kernel/hpet.c
+++ b/arch/x86_64/kernel/hpet.c
@@ -442,6 +442,11 @@ static cycle_t read_hpet(void)
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
@@ -450,6 +455,7 @@ struct clocksource clocksource_hpet = {
 	.mult		= 0, /* set below */
 	.shift		= HPET_SHIFT,
 	.is_continuous	= 1,
+	.vread		= vread_hpet,
 };
 
 static int __init init_hpet_clocksource(void)
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 4bc737c..17bb7de 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -53,13 +53,7 @@ DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 DEFINE_SPINLOCK(i8253_lock);
 
-unsigned long vxtime_hz = PIT_TICK_RATE;
-
-struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
-
 volatile unsigned long __jiffies __section_jiffies = INITIAL_JIFFIES;
-struct timespec __xtime __section_xtime;
-struct timezone __sys_tz __section_sys_tz;
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
diff --git a/arch/x86_64/kernel/tsc.c b/arch/x86_64/kernel/tsc.c
index 958ec0a..f16733e 100644
--- a/arch/x86_64/kernel/tsc.c
+++ b/arch/x86_64/kernel/tsc.c
@@ -185,6 +185,12 @@ static cycle_t read_tsc(void)
 	return ret;
 }
 
+static cycle_t __vsyscall_fn vread_tsc(void)
+{
+	cycle_t ret = (cycle_t)get_cycles_sync();
+	return ret;
+}
+
 static struct clocksource clocksource_tsc = {
 	.name			= "tsc",
 	.rating			= 300,
@@ -194,6 +200,7 @@ static struct clocksource clocksource_ts
 	.shift			= 22,
 	.update_callback	= tsc_update_callback,
 	.is_continuous		= 1,
+	.vread			= vread_tsc,
 };
 
 static int tsc_update_callback(void)
diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
index 1e54ddf..adb4263 100644
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -88,31 +88,25 @@ #define VVIRT(x) (ADDR(x) - VVIRT_OFFSET
   __vsyscall_0 = VSYSCALL_VIRT_ADDR;
 
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .xtime_lock : AT(VLOAD(.xtime_lock)) { *(.xtime_lock) }
-  xtime_lock = VVIRT(.xtime_lock);
-
-  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
-  vxtime = VVIRT(.vxtime);
+  .vsyscall_fn : AT(VLOAD(.vsyscall_fn)) { *(.vsyscall_fn) }
+  . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
+  .vsyscall_gtod_data : AT(VLOAD(.vsyscall_gtod_data))
+		{ *(.vsyscall_gtod_data) }
+  vsyscall_gtod_data = VVIRT(.vsyscall_gtod_data);
 
   .vgetcpu_mode : AT(VLOAD(.vgetcpu_mode)) { *(.vgetcpu_mode) }
   vgetcpu_mode = VVIRT(.vgetcpu_mode);
 
-  .sys_tz : AT(VLOAD(.sys_tz)) { *(.sys_tz) }
-  sys_tz = VVIRT(.sys_tz);
-
-  .sysctl_vsyscall : AT(VLOAD(.sysctl_vsyscall)) { *(.sysctl_vsyscall) }
-  sysctl_vsyscall = VVIRT(.sysctl_vsyscall);
-
-  .xtime : AT(VLOAD(.xtime)) { *(.xtime) }
-  xtime = VVIRT(.xtime);
-
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   .jiffies : AT(VLOAD(.jiffies)) { *(.jiffies) }
   jiffies = VVIRT(.jiffies);
 
-  .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT(VLOAD(.vsyscall_1)) { *(.vsyscall_1) }
-  .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
-  .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) { *(.vsyscall_3) }
+  .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT(VLOAD(.vsyscall_1))
+		{ *(.vsyscall_1) }
+  .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2))
+		{ *(.vsyscall_2) }
+  .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3))
+		{ *(.vsyscall_3) }
 
   . = VSYSCALL_VIRT_ADDR + 4096;
 
diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index 2433d6f..9814bf8 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -26,6 +26,7 @@ #include <linux/timer.h>
 #include <linux/seqlock.h>
 #include <linux/jiffies.h>
 #include <linux/sysctl.h>
+#include <linux/clocksource.h>
 #include <linux/getcpu.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
@@ -34,6 +35,7 @@ #include <linux/notifier.h>
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/unistd.h>
 #include <asm/fixmap.h>
 #include <asm/errno.h>
 #include <asm/io.h>
@@ -44,56 +46,41 @@ #include <asm/topology.h>
 #define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
 #define __syscall_clobber "r11","rcx","memory"
 
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
 int __vgetcpu_mode __section_vgetcpu_mode;
 
-#include <asm/unistd.h>
-
-static __always_inline void timeval_normalize(struct timeval * tv)
+struct vsyscall_gtod_data_t __vsyscall_gtod_data __section_vsyscall_gtod_data =
 {
-	time_t __sec;
-
-	__sec = tv->tv_usec / 1000000;
-	if (__sec) {
-		tv->tv_usec %= 1000000;
-		tv->tv_sec += __sec;
-	}
-}
+	.lock = SEQLOCK_UNLOCKED,
+	.sysctl_enabled = 1,
+};
 
-static __always_inline void do_vgettimeofday(struct timeval * tv)
+void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
 {
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
+	unsigned long flags;
+
+	write_seqlock_irqsave(&vsyscall_gtod_data.lock, flags);
+	/* copy vsyscall data */
+	vsyscall_gtod_data.clock = *clock;
+	vsyscall_gtod_data.wall_time_tv.tv_sec = wall_time->tv_sec;
+	vsyscall_gtod_data.wall_time_tv.tv_usec = wall_time->tv_nsec/1000;
+	vsyscall_gtod_data.sys_tz = sys_tz;
+	write_sequnlock_irqrestore(&vsyscall_gtod_data.lock, flags);
 }
 
-/* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
+/* RED-PEN may want to readd seq locking, but then the variable should be
+ * write-once.
+ */
 static __always_inline void do_get_tz(struct timezone * tz)
 {
-	*tz = __sys_tz;
+	*tz = __vsyscall_gtod_data.sys_tz;
 }
 
 static __always_inline int gettimeofday(struct timeval *tv, struct timezone *tz)
@@ -101,7 +88,8 @@ static __always_inline int gettimeofday(
 	int ret;
 	asm volatile("vsysc2: syscall"
 		: "=a" (ret)
-		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
+		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz)
+		: __syscall_clobber );
 	return ret;
 }
 
@@ -114,10 +102,44 @@ static __always_inline long time_syscall
 	return secs;
 }
 
+static __always_inline void do_vgettimeofday(struct timeval * tv)
+{
+	cycle_t now, base, mask, cycle_delta;
+	unsigned long seq, mult, shift, nsec_delta;
+	cycle_t (*vread)(void);
+	do {
+		seq = read_seqbegin(&__vsyscall_gtod_data.lock);
+
+		vread = __vsyscall_gtod_data.clock.vread;
+		if (unlikely(!__vsyscall_gtod_data.sysctl_enabled || !vread)) {
+			gettimeofday(tv,0);
+			return;
+		}
+		now = vread();
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
+}
+
 int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
 {
-	if (!__sysctl_vsyscall)
-		return gettimeofday(tv,tz);
 	if (tv)
 		do_vgettimeofday(tv);
 	if (tz)
@@ -129,11 +151,11 @@ int __vsyscall(0) vgettimeofday(struct t
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
 
 /* Fast way to get current CPU and node.
@@ -210,7 +232,7 @@ static int vsyscall_sysctl_change(ctl_ta
 		ret = -ENOMEM;
 		goto out;
 	}
-	if (!sysctl_vsyscall) {
+	if (!vsyscall_gtod_data.sysctl_enabled) {
 		writew(SYSCALL, map1);
 		writew(SYSCALL, map2);
 	} else {
@@ -232,7 +254,8 @@ static int vsyscall_sysctl_nostrat(ctl_t
 
 static ctl_table kernel_table2[] = {
 	{ .ctl_name = 99, .procname = "vsyscall64",
-	  .data = &sysctl_vsyscall, .maxlen = sizeof(int), .mode = 0644,
+	  .data = &vsyscall_gtod_data.sysctl_enabled, .maxlen = sizeof(int),
+	  .mode = 0644,
 	  .strategy = vsyscall_sysctl_nostrat,
 	  .proc_handler = vsyscall_sysctl_change },
 	{ 0, }
diff --git a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
index 914b5f6..25d5415 100644
--- a/include/asm-x86_64/proto.h
+++ b/include/asm-x86_64/proto.h
@@ -45,9 +45,7 @@ extern u32 pmtmr_ioport;
 #else
 #define pmtmr_ioport 0
 #endif
-extern int sysctl_vsyscall;
 extern int nohpet;
-extern unsigned long vxtime_hz;
 
 extern void early_printk(const char *fmt, ...) __attribute__((format(printf,1,2)));
 
diff --git a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
index a4d0066..a73d535 100644
--- a/include/asm-x86_64/timex.h
+++ b/include/asm-x86_64/timex.h
@@ -51,7 +51,6 @@ #define FSEC_PER_TICK (FSEC_PER_SEC / HZ
 #define NS_SCALE        10 /* 2^10, carefully chosen */
 #define US_SCALE        32 /* 2^32, arbitralrily chosen */
 
-extern struct vxtime_data vxtime;
 extern void mark_tsc_unstable(void);
 extern void set_cyc2ns_scale(unsigned long khz);
 #endif
diff --git a/include/asm-x86_64/vsyscall.h b/include/asm-x86_64/vsyscall.h
index 05cb8dd..1899a8d 100644
--- a/include/asm-x86_64/vsyscall.h
+++ b/include/asm-x86_64/vsyscall.h
@@ -16,51 +16,28 @@ #define VSYSCALL_ADDR(vsyscall_nr) (VSYS
 #ifdef __KERNEL__
 #include <linux/seqlock.h>
 
-#define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
 #define __section_vgetcpu_mode __attribute__ ((unused, __section__ (".vgetcpu_mode"), aligned(16)))
 #define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
-#define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz"), aligned(16)))
-#define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
-#define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
-#define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
 
-#define VXTIME_TSC	1
-#define VXTIME_HPET	2
-#define VXTIME_PMTMR	3
+/* Definitions for CONFIG_GENERIC_TIME definitions */
+#define __section_vsyscall_gtod_data __attribute__ \
+	((unused, __section__ (".vsyscall_gtod_data"),aligned(16)))
+#define __vsyscall_fn __attribute__ ((unused,__section__(".vsyscall_fn")))
 
 #define VGETCPU_RDTSCP	1
 #define VGETCPU_LSL	2
 
-struct vxtime_data {
-	long hpet_address;	/* HPET base address */
-	int last;
-	unsigned long last_tsc;
-	long quot;
-	long tsc_quot;
-	int mode;
-};
-
 #define hpet_readl(a)           readl((const void __iomem *)fix_to_virt(FIX_HPET_BASE) + a)
 #define hpet_writel(d,a)        writel(d, (void __iomem *)fix_to_virt(FIX_HPET_BASE) + a)
 
-/* vsyscall space (readonly) */
-extern struct vxtime_data __vxtime;
 extern int __vgetcpu_mode;
-extern struct timespec __xtime;
 extern volatile unsigned long __jiffies;
-extern struct timezone __sys_tz;
-extern seqlock_t __xtime_lock;
 
 /* kernel space (writeable) */
-extern struct vxtime_data vxtime;
 extern int vgetcpu_mode;
 extern struct timezone sys_tz;
-extern int sysctl_vsyscall;
 extern seqlock_t xtime_lock;
-
-extern int sysctl_vsyscall;
-
-#define ARCH_HAVE_XTIME_LOCK 1
+extern struct vsyscall_gtod_data_t vsyscall_gtod_data;
 
 #endif /* __KERNEL__ */
 
