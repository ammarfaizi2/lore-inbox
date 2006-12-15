Return-Path: <linux-kernel-owner+w=401wt.eu-S1752823AbWLOQVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbWLOQVc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbWLOQVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:21:32 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:53951 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbWLOQVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:21:30 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Introduce time_data, a new structure to hold jiffies, xtime, xtime_lock, wall_to_monotonic, calc_load_count and avenrun
Date: Fri, 15 Dec 2006 17:21:06 +0100
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20061206234942.79d6db01.akpm@osdl.org> <200612081752.09749.dada1@cosmosbay.com> <200612132226.26535.dada1@cosmosbay.com>
In-Reply-To: <200612132226.26535.dada1@cosmosbay.com>
MIME-Version: 1.0
Message-Id: <200612151721.06162.dada1@cosmosbay.com>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ytsgFDeoVinnlDU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ytsgFDeoVinnlDU
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Just in case, I re-based the patch against 2.6.20-rc1-mm1


[PATCH] Introduce time_data, a new structure to hold jiffies, xtime,=20
xtime_lock, wall_to_monotonic, calc_load_count and avenrun

This patch introduces a new structure called time_data, where some time=20
keeping related variables are put together to share as few cache lines as=20
possible. This should reduce timer interrupt latency and cache lines ping=20
pongs in SMP machines.

struct time_data {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0_jiffies_64;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec _xtime;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec _wall_to_monotonic;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 seqlock_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lo=
ck;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 calc_load_count;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 _avenrun[3];
};

_jiffies_64 is a place holder so that arches can (optionally) aliases=20
jiffies_64/jiffies in time_data. This patch does the thing for i386, x86_64=
=20
and ia64=20

avenrun, xtime, xtime_lock, wall_to_monotonic, are now temporary defined as=
=20
macros to make this patch not too invasive, but we can in future patches=20
gradually deletes these macros.

=46or ia64, I added aliases for xtime, xtime_lock and wall_to_monotonic bec=
ause=20
arch/ia64/kernel/fsys.S uses these symbols. This file might be changed to=20
directly access time_data in the future (reducing registers use as well)


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
=2D--
 arch/i386/kernel/vmlinux.lds.S   |    3 +
 arch/ia64/kernel/asm-offsets.c   |    3 +
 arch/ia64/kernel/vmlinux.lds.S   |    7 +++
 arch/s390/appldata/appldata_os.c |   18 ++++-----
 arch/x86_64/kernel/time.c        |    8 +++-
 arch/x86_64/kernel/vmlinux.lds.S |   14 ++-----
 arch/x86_64/kernel/vsyscall.c    |   15 +++-----
 include/asm-x86_64/vsyscall.h    |    8 +---
 include/linux/jiffies.h          |    2 -
 include/linux/sched.h            |   10 +++--
 include/linux/time.h             |   34 +++++++++++++++---
 kernel/timer.c                   |   54 ++++++++++++++---------------
 12 files changed, 102 insertions(+), 74 deletions(-)

--Boundary-00=_ytsgFDeoVinnlDU
Content-Type: text/plain;
  charset="utf-8";
  name="time_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="time_data.patch"

--- linux-2.6.20-rc1-mm1/include/linux/time.h	2006-12-15 15:46:16.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/include/linux/time.h	2006-12-15 17:22:15.000000000 +0100
@@ -88,22 +88,46 @@ static inline struct timespec timespec_s
 #define timespec_valid(ts) \
 	(((ts)->tv_sec >= 0) && (((unsigned long) (ts)->tv_nsec) < NSEC_PER_SEC))
 
-extern struct timespec xtime;
-extern struct timespec wall_to_monotonic;
-extern seqlock_t xtime_lock __attribute__((weak));
+
+/*
+ * Structure time_data holds most timekeeping related variables
+ * to make them share as few cache lines as possible.
+ */
+struct time_data {
+	/*
+	 * We want to alias jiffies_64 to time_data._jiffies_64,
+	 * in vmlinux.lds.S files (jiffies_64 = time_data)
+	 * so keep _jiffies_64 at the beginning of time_data
+	 */
+	u64		_jiffies_64;
+	struct timespec _xtime;
+	struct timespec _wall_to_monotonic;
+	seqlock_t	lock;
+	int		calc_load_count;
+	unsigned int	_avenrun[3];
+};
+/*
+ * time_data has weak attribute because some arches (x86_64) want
+ * to have a read_only version in their vsyscall page
+ */
+extern struct time_data time_data __attribute__((weak));
+#define xtime             time_data._xtime
+#define wall_to_monotonic time_data._wall_to_monotonic
+#define xtime_lock        time_data.lock
+#define avenrun           time_data._avenrun
 
 extern unsigned long read_persistent_clock(void);
 void timekeeping_init(void);
 
 static inline unsigned long get_seconds(void)
 {
-	return xtime.tv_sec;
+	return time_data._xtime.tv_sec;
 }
 
 struct timespec current_kernel_time(void);
 
 #define CURRENT_TIME		(current_kernel_time())
-#define CURRENT_TIME_SEC	((struct timespec) { xtime.tv_sec, 0 })
+#define CURRENT_TIME_SEC	((struct timespec) { time_data._xtime.tv_sec, 0 })
 
 extern void do_gettimeofday(struct timeval *tv);
 extern int do_settimeofday(struct timespec *tv);
--- linux-2.6.20-rc1-mm1/include/linux/jiffies.h	2006-12-15 15:46:16.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/include/linux/jiffies.h	2006-12-15 17:19:07.000000000 +0100
@@ -78,7 +78,7 @@
  * without sampling the sequence number in xtime_lock.
  * get_jiffies_64() will do this for you as appropriate.
  */
-extern u64 __jiffy_data jiffies_64;
+extern u64 __jiffy_data jiffies_64 __attribute__((weak));
 extern unsigned long volatile __jiffy_data jiffies;
 
 #if (BITS_PER_LONG < 64)
--- linux-2.6.20-rc1-mm1/include/linux/sched.h	2006-12-15 15:46:16.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/include/linux/sched.h	2006-12-15 17:19:07.000000000 +0100
@@ -106,7 +106,6 @@ struct bio;
  *    the EXP_n values would be 1981, 2034 and 2043 if still using only
  *    11 bit fractions.
  */
-extern unsigned long avenrun[];		/* Load averages */
 
 #define FSHIFT		11		/* nr of bits of precision */
 #define FIXED_1		(1<<FSHIFT)	/* 1.0 as fixed-point */
@@ -116,9 +115,12 @@ extern unsigned long avenrun[];		/* Load
 #define EXP_15		2037		/* 1/exp(5sec/15min) */
 
 #define CALC_LOAD(load,exp,n) \
-	load *= exp; \
-	load += n*(FIXED_1-exp); \
-	load >>= FSHIFT;
+	{ \
+	unsigned long temp = load; \
+	temp *= exp; \
+	temp += n*(FIXED_1-exp); \
+	load = temp >> FSHIFT; \
+	}
 
 extern unsigned long total_forks;
 extern int nr_threads;
--- linux-2.6.20-rc1-mm1/kernel/timer.c	2006-12-15 15:46:16.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/kernel/timer.c	2006-12-15 17:19:07.000000000 +0100
@@ -42,7 +42,7 @@
 #include <asm/timex.h>
 #include <asm/io.h>
 
-u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
+__attribute__((weak)) u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
 
@@ -771,10 +771,12 @@ unsigned long next_timer_interrupt(void)
  * however, we will ALWAYS keep the tv_nsec part positive so we can use
  * the usual normalization.
  */
-struct timespec xtime __attribute__ ((aligned (16)));
-struct timespec wall_to_monotonic __attribute__ ((aligned (16)));
-
-EXPORT_SYMBOL(xtime);
+__attribute__((weak)) struct time_data time_data __cacheline_aligned = {
+	._jiffies_64 = INITIAL_JIFFIES,
+	.lock = __SEQLOCK_UNLOCKED(time_data.lock),
+	.calc_load_count = LOAD_FREQ,
+};
+EXPORT_SYMBOL(time_data);
 
 
 /* XXX - all of this timekeeping code should be later moved to time.c */
@@ -1238,9 +1240,6 @@ static unsigned long count_active_tasks(
  *
  * Requires xtime_lock to access.
  */
-unsigned long avenrun[3];
-
-EXPORT_SYMBOL(avenrun);
 
 /*
  * calc_load - given tick count, update the avenrun load estimates.
@@ -1249,29 +1248,20 @@ EXPORT_SYMBOL(avenrun);
 static inline void calc_load(unsigned long ticks)
 {
 	unsigned long active_tasks; /* fixed-point */
-	static int count = LOAD_FREQ;
 
-	count -= ticks;
-	if (unlikely(count < 0)) {
+	time_data.calc_load_count -= ticks;
+	if (unlikely(time_data.calc_load_count < 0)) {
 		active_tasks = count_active_tasks();
 		do {
-			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
-			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
-			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
-			count += LOAD_FREQ;
-		} while (count < 0);
+			CALC_LOAD(time_data._avenrun[0], EXP_1, active_tasks);
+			CALC_LOAD(time_data._avenrun[1], EXP_5, active_tasks);
+			CALC_LOAD(time_data._avenrun[2], EXP_15, active_tasks);
+			time_data.calc_load_count += LOAD_FREQ;
+		} while (time_data.calc_load_count < 0);
 	}
 }
 
 /*
- * This read-write spinlock protects us from races in SMP while
- * playing with xtime and avenrun.
- */
-__attribute__((weak)) __cacheline_aligned_in_smp DEFINE_SEQLOCK(xtime_lock);
-
-EXPORT_SYMBOL(xtime_lock);
-
-/*
  * This function runs timers and the timer-tq in bottom half context.
  */
 static void run_timer_softirq(struct softirq_action *h)
@@ -1497,6 +1487,16 @@ asmlinkage long sys_gettid(void)
 }
 
 /**
+ * avenrun_to_loads - convert an _avenrun[] to sysinfo.loads[]
+ * @idx: index (0..2) in time_data._avenrun[]
+ */
+static inline unsigned long avenrun_to_loads(unsigned int idx)
+{
+	unsigned long ret = time_data._avenrun[idx];
+	return ret << (SI_LOAD_SHIFT - FSHIFT);
+}
+
+/**
  * sys_sysinfo - fill in sysinfo struct
  * @info: pointer to buffer to fill
  */ 
@@ -1529,9 +1529,9 @@ asmlinkage long sys_sysinfo(struct sysin
 		}
 		val.uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
 
-		val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
-		val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
-		val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
+		val.loads[0] = avenrun_to_loads(0);
+		val.loads[1] = avenrun_to_loads(1);
+		val.loads[2] = avenrun_to_loads(2);
 
 		val.procs = nr_threads;
 	} while (read_seqretry(&xtime_lock, seq));
--- linux-2.6.20-rc1-mm1/include/asm-x86_64/vsyscall.h	2006-12-15 15:46:16.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/include/asm-x86_64/vsyscall.h	2006-12-15 17:19:07.000000000 +0100
@@ -18,11 +18,9 @@ enum vsyscall_num {
 
 #define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
 #define __section_vgetcpu_mode __attribute__ ((unused, __section__ (".vgetcpu_mode"), aligned(16)))
-#define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
 #define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz"), aligned(16)))
 #define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
-#define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
-#define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
+#define __section_time_data __attribute__ ((unused, __section__ (".time_data"), aligned(16)))
 
 #define VXTIME_TSC	1
 #define VXTIME_HPET	2
@@ -44,12 +42,10 @@ struct vxtime_data {
 #define hpet_writel(d,a)        writel(d, (void __iomem *)fix_to_virt(FIX_HPET_BASE) + a)
 
 /* vsyscall space (readonly) */
+extern struct time_data __time_data;
 extern struct vxtime_data __vxtime;
 extern int __vgetcpu_mode;
-extern struct timespec __xtime;
-extern volatile unsigned long __jiffies;
 extern struct timezone __sys_tz;
-extern seqlock_t __xtime_lock;
 
 /* kernel space (writeable) */
 extern struct vxtime_data vxtime;
--- linux-2.6.20-rc1-mm1/arch/x86_64/kernel/vsyscall.c	2006-12-14 02:14:23.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/arch/x86_64/kernel/vsyscall.c	2006-12-15 17:19:07.000000000 +0100
@@ -45,7 +45,6 @@
 #define __syscall_clobber "r11","rcx","memory"
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
-seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
 int __vgetcpu_mode __section_vgetcpu_mode;
 
 #include <asm/unistd.h>
@@ -67,10 +66,10 @@ static __always_inline void do_vgettimeo
 	unsigned long sec, usec;
 
 	do {
-		sequence = read_seqbegin(&__xtime_lock);
+		sequence = read_seqbegin(&__time_data.lock);
 		
-		sec = __xtime.tv_sec;
-		usec = __xtime.tv_nsec / 1000;
+		sec = __time_data._xtime.tv_sec;
+		usec = __time_data._xtime.tv_nsec / 1000;
 
 		if (__vxtime.mode != VXTIME_HPET) {
 			t = get_cycles_sync();
@@ -84,7 +83,7 @@ static __always_inline void do_vgettimeo
 				   fix_to_virt(VSYSCALL_HPET) + 0xf0) -
 				  __vxtime.last) * __vxtime.quot) >> 32;
 		}
-	} while (read_seqretry(&__xtime_lock, sequence));
+	} while (read_seqretry(&__time_data.lock, sequence));
 
 	tv->tv_sec = sec + usec / 1000000;
 	tv->tv_usec = usec % 1000000;
@@ -132,8 +131,8 @@ time_t __vsyscall(1) vtime(time_t *t)
 	if (!__sysctl_vsyscall)
 		return time_syscall(t);
 	else if (t)
-		*t = __xtime.tv_sec;		
-	return __xtime.tv_sec;
+		*t = __time_data._xtime.tv_sec;		
+	return __time_data._xtime.tv_sec;
 }
 
 /* Fast way to get current CPU and node.
@@ -158,7 +157,7 @@ vgetcpu(unsigned *cpu, unsigned *node, s
 	   We do this here because otherwise user space would do it on
 	   its own in a likely inferior way (no access to jiffies).
 	   If you don't like it pass NULL. */
-	if (tcache && tcache->blob[0] == (j = __jiffies)) {
+	if (tcache && tcache->blob[0] == (j = __time_data._jiffies_64)) {
 		p = tcache->blob[1];
 	} else if (__vgetcpu_mode == VGETCPU_RDTSCP) {
 		/* Load per CPU data from RDTSCP */
--- linux-2.6.20-rc1-mm1/arch/x86_64/kernel/time.c	2006-12-15 15:46:15.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/arch/x86_64/kernel/time.c	2006-12-15 17:19:07.000000000 +0100
@@ -76,8 +76,12 @@ unsigned long long monotonic_base;
 
 struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
 
-volatile unsigned long __jiffies __section_jiffies = INITIAL_JIFFIES;
-struct timespec __xtime __section_xtime;
+struct time_data __time_data __section_time_data = {
+	._jiffies_64 = INITIAL_JIFFIES,
+	.lock =  __SEQLOCK_UNLOCKED(time_data.lock),
+	.calc_load_count = LOAD_FREQ,
+};
+
 struct timezone __sys_tz __section_sys_tz;
 
 /*
--- linux-2.6.20-rc1-mm1/arch/x86_64/kernel/vmlinux.lds.S	2006-12-15 15:46:15.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/arch/x86_64/kernel/vmlinux.lds.S	2006-12-15 17:22:15.000000000 +0100
@@ -12,7 +12,6 @@
 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
 OUTPUT_ARCH(i386:x86-64)
 ENTRY(phys_startup_64)
-jiffies_64 = jiffies;
 _proxy_pda = 0;
 PHDRS {
 	text PT_LOAD FLAGS(5);	/* R_E */
@@ -88,8 +87,10 @@ SECTIONS
   __vsyscall_0 = VSYSCALL_VIRT_ADDR;
 
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .xtime_lock : AT(VLOAD(.xtime_lock)) { *(.xtime_lock) }
-  xtime_lock = VVIRT(.xtime_lock);
+  .time_data : AT(VLOAD(.time_data)) { *(.time_data) }
+  time_data = VVIRT(.time_data);
+  jiffies = time_data;
+  jiffies_64 = time_data;
 
   .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
   vxtime = VVIRT(.vxtime);
@@ -103,13 +104,6 @@ SECTIONS
   .sysctl_vsyscall : AT(VLOAD(.sysctl_vsyscall)) { *(.sysctl_vsyscall) }
   sysctl_vsyscall = VVIRT(.sysctl_vsyscall);
 
-  .xtime : AT(VLOAD(.xtime)) { *(.xtime) }
-  xtime = VVIRT(.xtime);
-
-  . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .jiffies : AT(VLOAD(.jiffies)) { *(.jiffies) }
-  jiffies = VVIRT(.jiffies);
-
   .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT(VLOAD(.vsyscall_1)) { *(.vsyscall_1) }
   .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
   .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) { *(.vsyscall_3) }
--- linux-2.6.20-rc1-mm1/arch/i386/kernel/vmlinux.lds.S	2006-12-15 15:46:15.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/arch/i386/kernel/vmlinux.lds.S	2006-12-15 17:22:15.000000000 +0100
@@ -25,7 +25,8 @@
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(phys_startup_32)
-jiffies = jiffies_64;
+jiffies = time_data;
+jiffies_64 = time_data;
 _proxy_pda = 0;
 
 PHDRS {
--- linux-2.6.20-rc1-mm1/arch/ia64/kernel/asm-offsets.c	2006-12-14 02:14:23.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/arch/ia64/kernel/asm-offsets.c	2006-12-15 17:19:07.000000000 +0100
@@ -268,4 +268,7 @@ void foo(void)
 	DEFINE(IA64_TIME_SOURCE_MMIO64, TIME_SOURCE_MMIO64);
 	DEFINE(IA64_TIME_SOURCE_MMIO32, TIME_SOURCE_MMIO32);
 	DEFINE(IA64_TIMESPEC_TV_NSEC_OFFSET, offsetof (struct timespec, tv_nsec));
+	DEFINE(IA64_XTIME_OFFSET, offsetof (struct time_data, _xtime));
+	DEFINE(IA64_WALL_TO_MONOTONIC_OFFSET, offsetof (struct time_data, _wall_to_monotonic));
+	DEFINE(IA64_XTIME_LOCK_OFFSET, offsetof (struct time_data, lock));
 }
--- linux-2.6.20-rc1-mm1/arch/ia64/kernel/vmlinux.lds.S	2006-12-15 15:46:15.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/arch/ia64/kernel/vmlinux.lds.S	2006-12-15 17:19:07.000000000 +0100
@@ -4,6 +4,7 @@
 #include <asm/system.h>
 #include <asm/sparsemem.h>
 #include <asm/pgtable.h>
+#include <asm/asm-offsets.h>
 
 #define LOAD_OFFSET	(KERNEL_START - KERNEL_TR_PAGE_SIZE)
 #include <asm-generic/vmlinux.lds.h>
@@ -16,7 +17,11 @@
 OUTPUT_FORMAT("elf64-ia64-little")
 OUTPUT_ARCH(ia64)
 ENTRY(phys_start)
-jiffies = jiffies_64;
+jiffies = time_data;
+jiffies_64 = time_data;
+xtime = time_data + IA64_XTIME_OFFSET;
+wall_to_monotonic = time_data + IA64_WALL_TO_MONOTONIC_OFFSET;
+xtime_lock = time_data + IA64_XTIME_LOCK_OFFSET;
 PHDRS {
   code   PT_LOAD;
   percpu PT_LOAD;
--- linux-2.6.20-rc1-mm1/arch/s390/appldata/appldata_os.c	2006-12-14 02:14:23.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/arch/s390/appldata/appldata_os.c	2006-12-15 17:19:07.000000000 +0100
@@ -68,7 +68,7 @@ struct appldata_os_data {
 
 	u32 nr_running;		/* number of runnable threads      */
 	u32 nr_threads;		/* number of threads               */
-	u32 avenrun[3];		/* average nr. of running processes during */
+	u32 _avenrun[3];		/* average nr. of running processes during */
 				/* the last 1, 5 and 15 minutes */
 
 	/* New in 2.6 */
@@ -98,11 +98,11 @@ static inline void appldata_print_debug(
 	P_DEBUG("nr_threads   = %u\n", os_data->nr_threads);
 	P_DEBUG("nr_running   = %u\n", os_data->nr_running);
 	P_DEBUG("nr_iowait    = %u\n", os_data->nr_iowait);
-	P_DEBUG("avenrun(int) = %8x / %8x / %8x\n", os_data->avenrun[0],
-		os_data->avenrun[1], os_data->avenrun[2]);
-	a0 = os_data->avenrun[0];
-	a1 = os_data->avenrun[1];
-	a2 = os_data->avenrun[2];
+	P_DEBUG("avenrun(int) = %8x / %8x / %8x\n", os_data->_avenrun[0],
+		os_data->_avenrun[1], os_data->_avenrun[2]);
+	a0 = os_data->_avenrun[0];
+	a1 = os_data->_avenrun[1];
+	a2 = os_data->_avenrun[2];
 	P_DEBUG("avenrun(float) = %d.%02d / %d.%02d / %d.%02d\n",
 		LOAD_INT(a0), LOAD_FRAC(a0), LOAD_INT(a1), LOAD_FRAC(a1),
 		LOAD_INT(a2), LOAD_FRAC(a2));
@@ -145,9 +145,9 @@ static void appldata_get_os_data(void *d
 	os_data->nr_threads = nr_threads;
 	os_data->nr_running = nr_running();
 	os_data->nr_iowait  = nr_iowait();
-	os_data->avenrun[0] = avenrun[0] + (FIXED_1/200);
-	os_data->avenrun[1] = avenrun[1] + (FIXED_1/200);
-	os_data->avenrun[2] = avenrun[2] + (FIXED_1/200);
+	os_data->_avenrun[0] = avenrun[0] + (FIXED_1/200);
+	os_data->_avenrun[1] = avenrun[1] + (FIXED_1/200);
+	os_data->_avenrun[2] = avenrun[2] + (FIXED_1/200);
 
 	j = 0;
 	for_each_online_cpu(i) {

--Boundary-00=_ytsgFDeoVinnlDU--
