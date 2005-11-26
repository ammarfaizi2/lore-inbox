Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbVKZOzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbVKZOzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbVKZOzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:55:31 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48003 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161005AbVKZOz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:55:27 -0500
Date: Sat, 26 Nov 2005 15:55:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/13] Time: x86-64 Conversion to Generic Timekeeping
Message-ID: <20051126145528.GJ12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013628.18537.58457.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013628.18537.58457.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up timeofday-arch-x86-64-part1.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/x86_64/kernel/time.c     |   91 ++++++++++++++++++++++--------------------
 arch/x86_64/kernel/vsyscall.c |   45 ++++++++++++--------
 2 files changed, 75 insertions(+), 61 deletions(-)

Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -42,6 +42,8 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
+#include <linux/clocksource.h>
+#include <asm/vsyscall.h>
 
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
@@ -251,9 +253,10 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(a);
 }
 
-/* Code to compensate for TSC C3 stalls */
+/* code to compensate for TSC C3 stalls: */
 static u64 tsc_c3_offset;
 static int tsc_unstable;
+
 static inline int check_tsc_unstable(void)
 {
 	return tsc_unstable;
@@ -266,6 +269,7 @@ static inline void mark_tsc_unstable(voi
 void tsc_c3_compensate(unsigned long nsecs)
 {
 	u64 cycles = ((u64)nsecs * tsc_khz)/1000000;
+
 	tsc_c3_offset += cycles;
 }
 
@@ -334,7 +338,7 @@ unsigned long get_cmos_time(void)
 	return mktime(year, mon, day, hour, min, sec);
 }
 
-/* arch specific timeofday hooks */
+/* arch specific timeofday hooks: */
 u64 read_persistent_clock(void)
 {
 	return (u64)get_cmos_time() * NSEC_PER_SEC;
@@ -1042,55 +1046,60 @@ static int __init notsc_setup(char *s)
 __setup("notsc", notsc_setup);
 
 
-/* Clock source code */
-#include <linux/clocksource.h>
-#include <asm/vsyscall.h>
+/* clock-source code: */
 
 static unsigned long current_tsc_khz = 0;
+
 static int tsc_update_callback(void);
 
 #ifdef CONFIG_PARANOID_GENERIC_TIME
 /* This will hurt performance! */
-DEFINE_SPINLOCK(checktsc_lock);
-cycle_t last_tsc;
+static DEFINE_SPINLOCK(checktsc_lock);
+static cycle_t last_tsc;
 
 static cycle_t read_tsc(void)
 {
-	cycle_t ret;
 	unsigned long flags;
+	cycle_t ret;
+
 	spin_lock_irqsave(&checktsc_lock, flags);
 
 	rdtscll(ret);
 
-	if(ret < last_tsc)
+	if (ret < last_tsc)
 		printk("read_tsc: ACK! TSC went backward! Unsynced TSCs?\n");
 	last_tsc = ret;
 
 	spin_unlock_irqrestore(&checktsc_lock, flags);
+
 	return ret;
 }
 
 static cycle_t __vsyscall_fn vread_tsc(void* unused)
 {
 	cycle_t ret;
+
 	rdtscll(ret);
+
 	return ret;
 }
 
 static cycle_t read_tsc_c3(void)
 {
-	cycle_t ret;
 	unsigned long flags;
+	cycle_t ret;
+
 	spin_lock_irqsave(&checktsc_lock, flags);
 
 	rdtscll(ret);
 	ret += tsc_read_c3_time();
 
-	if(ret < last_tsc)
+	if (ret < last_tsc)
 		printk("read_tsc_c3: ACK! TSC went backward! Unsynced TSCs?\n");
 	last_tsc = ret;
 
 	spin_unlock_irqrestore(&checktsc_lock, flags);
+
 	return ret;
 }
 
@@ -1099,43 +1108,37 @@ static cycle_t read_tsc_c3(void)
 static cycle_t read_tsc(void)
 {
 	cycle_t ret;
+
 	rdtscll(ret);
+
 	return ret;
 }
 
 static cycle_t __vsyscall_fn vread_tsc(void* unused)
 {
 	cycle_t ret;
+
 	rdtscll(ret);
+
 	return ret;
 }
 
 static cycle_t read_tsc_c3(void)
 {
 	cycle_t ret;
+
 	rdtscll(ret);
+
 	return ret + tsc_read_c3_time();
 }
 
 #endif /* CONFIG_PARANOID_GENERIC_TIME */
 
-static struct clocksource clocksource_tsc = {
-	.name = "tsc",
-	.rating = 300,
-	.read = read_tsc,
-	.vread = vread_tsc,
-	.mask = (cycle_t)-1,
-	.mult = 0, /* to be set */
-	.shift = 22,
-	.update_callback = tsc_update_callback,
-	.is_continuous = 1,
-};
-
-
 static int tsc_update_callback(void)
 {
 	int change = 0;
-	/* check to see if we should switch to the safe clocksource */
+
+	/* check to see if we should switch to the safe clocksource: */
 	if (tsc_read_c3_time() &&
 		strncmp(clocksource_tsc.name, "c3tsc", 5)) {
 		printk("Falling back to C3 safe TSC\n");
@@ -1150,7 +1153,8 @@ static int tsc_update_callback(void)
 		reselect_clocksource();
 		change = 1;
 	}
-	/* only update if tsc_khz has changed */
+
+	/* only update if tsc_khz has changed: */
 	if (current_tsc_khz != tsc_khz){
 		current_tsc_khz = tsc_khz;
 		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
@@ -1174,12 +1178,11 @@ static int __init init_tsc_clocksource(v
 module_init(init_tsc_clocksource);
 
 
-#define HPET_MASK (0xFFFFFFFF)
-#define HPET_SHIFT 22
+#define HPET_MASK	0xFFFFFFFF
+#define HPET_SHIFT	22
 
 /* FSEC = 10^-15 NSEC = 10^-9 */
-#define FSEC_PER_NSEC 1000000
-
+#define FSEC_PER_NSEC	1000000
 
 static void *hpet_ptr;
 
@@ -1194,35 +1197,35 @@ static cycle_t __vsyscall_fn vread_hpet(
 }
 
 struct clocksource clocksource_hpet = {
-	.name = "hpet",
-	.rating = 250,
-	.read = read_hpet,
-	.vread = vread_hpet,
-	.mask = (cycle_t)HPET_MASK,
-	.mult = 0, /* set below */
-	.shift = HPET_SHIFT,
-	.is_continuous = 1,
+	.name		= "hpet",
+	.rating		= 250,
+	.read		= read_hpet,
+	.vread		= vread_hpet,
+	.mask		= (cycle_t)HPET_MASK,
+	.mult		= 0, /* set below */
+	.shift		= HPET_SHIFT,
+	.is_continuous	= 1,
 };
 
 static int __init init_hpet_clocksource(void)
 {
 	unsigned long hpet_period;
-	void __iomem* hpet_base;
+	void __iomem *hpet_base;
 	u64 tmp;
 
 	if (!hpet_address)
 		return -ENODEV;
 
-	/* calculate the hpet address */
+	/* calculate the hpet address: */
 	hpet_base =
 		(void __iomem*)ioremap_nocache(hpet_address, HPET_MMAP_SIZE);
 	hpet_ptr = hpet_base + HPET_COUNTER;
 
-	/* calculate the frequency */
+	/* calculate the frequency: */
 	hpet_period = readl(hpet_base + HPET_PERIOD);
 
-
-	/* hpet period is in femto seconds per cycle
+	/*
+	 * hpet period is in femto seconds per cycle
 	 * so we need to convert this to ns/cyc units
 	 * aproximated by mult/2^shift
 	 *
@@ -1237,6 +1240,8 @@ static int __init init_hpet_clocksource(
 	clocksource_hpet.mult = (u32)tmp;
 
 	register_clocksource(&clocksource_hpet);
+
 	return 0;
 }
+
 module_init(init_hpet_clocksource);
Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -29,8 +29,10 @@
 #include <linux/jiffies.h>
 #include <linux/sysctl.h>
 
+
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
+#include <asm/unistd.h>
 #include <asm/page.h>
 #include <asm/fixmap.h>
 #include <asm/errno.h>
@@ -42,7 +44,6 @@
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
 seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
 
-
 struct vsyscall_gtod_data_t {
 	struct timeval wall_time_tv;
 	struct timezone sys_tz;
@@ -56,9 +57,6 @@ struct vsyscall_gtod_data_t __vsyscall_g
 extern seqlock_t vsyscall_gtod_lock;
 seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock = SEQLOCK_UNLOCKED;
 
-
-#include <asm/unistd.h>
-
 static force_inline void timeval_normalize(struct timeval * tv)
 {
 	time_t __sec;
@@ -70,22 +68,28 @@ static force_inline void timeval_normali
 	}
 }
 
-/* XXX - this is ugly. gettimeofday() has a label in it so we can't
-	call it twice.
+/*
+ * XXX - this is ugly. gettimeofday() has a label in it so we can't
+ *       call it twice.
  */
 static force_inline int syscall_gtod(struct timeval *tv, struct timezone *tz)
 {
 	int ret;
+
 	asm volatile("syscall"
 		: "=a" (ret)
-		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
+		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz)
+		: __syscall_clobber);
+
 	return ret;
 }
-static force_inline void do_vgettimeofday(struct timeval* tv)
+
+static force_inline void do_vgettimeofday(struct timeval *tv)
 {
 	cycle_t now, cycle_delta;
 	nsec_t nsec_delta;
 	unsigned long seq;
+
 	do {
 		seq = read_seqbegin(&__vsyscall_gtod_lock);
 
@@ -109,6 +113,7 @@ static force_inline void do_vgettimeofda
 		*tv = __vsyscall_gtod_data.wall_time_tv;
 		do_div(nsec_delta, NSEC_PER_USEC);
 		tv->tv_usec += (unsigned long) nsec_delta;
+
 		while (tv->tv_usec > USEC_PER_SEC) {
 			tv->tv_sec += 1;
 			tv->tv_usec -= USEC_PER_SEC;
@@ -116,7 +121,10 @@ static force_inline void do_vgettimeofda
 	} while (read_seqretry(&__vsyscall_gtod_lock, seq));
 }
 
-/* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
+/*
+ * RED-PEN may want to readd seq locking, but then the variable should be
+ * write-once.
+ */
 static force_inline void do_get_tz(struct timezone * tz)
 {
 	*tz = __vsyscall_gtod_data.sys_tz;
@@ -156,11 +164,14 @@ int __vsyscall(0) vgettimeofday(struct t
 time_t __vsyscall(1) vtime(time_t *t)
 {
 	struct timeval tv;
+
 	if (unlikely(!__sysctl_vsyscall))
 		return time_syscall(t);
+
 	vgettimeofday(&tv, 0);
 	if (t)
 		*t = tv.tv_sec;
+
 	return tv.tv_sec;
 }
 
@@ -174,7 +185,7 @@ long __vsyscall(3) venosys_1(void)
 	return -ENOSYS;
 }
 
-struct clocksource* curr_clock;
+struct clocksource *curr_clock;
 
 void arch_update_vsyscall_gtod(struct timespec wall_time, cycle_t offset_base,
 				struct clocksource *clock, int ntp_adj)
@@ -184,28 +195,26 @@ void arch_update_vsyscall_gtod(struct ti
 	write_seqlock_irqsave(&vsyscall_gtod_lock, flags);
 
 	/* XXX - hackitty hack hack. this is terrible! */
-	if (curr_clock != clock) {
+	if (curr_clock != clock)
 		curr_clock = clock;
-	}
 
-	/* save off wall time as timeval */
+	/* save off wall time as timeval: */
 	vsyscall_gtod_data.wall_time_tv.tv_sec = wall_time.tv_sec;
 	vsyscall_gtod_data.wall_time_tv.tv_usec = wall_time.tv_nsec/1000;
 
-	/* save offset_base */
+	/* save offset_base: */
 	vsyscall_gtod_data.offset_base = offset_base;
 
-	/* copy current clocksource */
+	/* copy current clocksource: */
 	vsyscall_gtod_data.clock = *clock;
 
-	/* apply ntp adjustment to clocksource mult */
+	/* apply ntp adjustment to clocksource mult: */
 	vsyscall_gtod_data.clock.mult += ntp_adj;
 
-	/* save off current timezone */
+	/* save off current timezone: */
 	vsyscall_gtod_data.sys_tz = sys_tz;
 
 	write_sequnlock_irqrestore(&vsyscall_gtod_lock, flags);
-
 }
 
 #ifdef CONFIG_SYSCTL
