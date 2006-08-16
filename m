Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWHPWr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWHPWr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWHPWr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:47:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:50841 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932301AbWHPWr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:47:26 -0400
Subject: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever clock
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: takata@linux-m32r.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       davem@davemloft.net, wli@holomorphy.com,
       Joel Becker <Joel.Becker@oracle.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 15:45:32 -0700
Message-Id: <1155768332.6785.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Almost every arch has some form of persistent clock (CMOS, RTC, etc)
which is normally used at boot time to initialize xtime and
wall_to_monotonic. As part of the timekeeping consolidation, I propose
the following generic interface to the arch specific persistent clock:

unsigned long read_persistent_clock(void);

Which returns seconds since the epoch.

Having this interface allows for the xtime/wall_to_monotonic
initialization and management to be consolidated along with the rest of
the timekeeping core. Additionally it provides a common interface to a
low-res purely hardware driven clock, which is useful for watchdog
functionality as seen in the hangcheck-timer module.

My first pass at this can be found below. There are a few arches
(specifically: m32r, s390, sparc, sparc64) where I just didn't know what
to do, or where I suspect I didn't get it right, so I've CC'ed those
maintainers for suggestions.

I'll break this patch up before submitting it (using a generic weak
function we can go arch-by-arch), but I wanted to get it out there to
show I'm shooting for 100% coverage and see the initial reaction.

thanks
-john

 arch/alpha/kernel/time.c     |   77 +++++++++++++++++++++----------------------
 arch/cris/kernel/crisksyms.c |    4 +-
 arch/cris/kernel/time.c      |    4 +-
 arch/frv/kernel/time.c       |   10 +++--
 arch/h8300/kernel/time.c     |    8 ++--
 arch/i386/kernel/apm.c       |    6 +--
 arch/i386/kernel/time.c      |   22 +++---------
 arch/ia64/kernel/time.c      |   14 +++----
 arch/m32r/kernel/time.c      |    6 +++
 arch/m68k/kernel/time.c      |   10 +++--
 arch/m68knommu/kernel/time.c |    9 ++---
 arch/mips/kernel/time.c      |   11 ++----
 arch/parisc/kernel/time.c    |   19 +++-------
 arch/powerpc/kernel/time.c   |    4 +-
 arch/ppc/kernel/time.c       |    8 ++++
 arch/s390/kernel/time.c      |    6 +++
 arch/sh/kernel/time.c        |   20 +++++------
 arch/sh64/kernel/time.c      |    8 ++--
 arch/sparc/kernel/time.c     |    6 +++
 arch/sparc64/kernel/time.c   |   44 +++++++++++++-----------
 arch/um/kernel/time.c        |    9 ++---
 arch/v850/kernel/time.c      |    8 +++-
 arch/x86_64/kernel/time.c    |   12 +-----
 arch/xtensa/kernel/time.c    |   24 ++++++-------
 kernel/timer.c               |    8 +++-
 25 files changed, 194 insertions(+), 163 deletions(-)

linux-2.6.18-rc4_timeofday-persistent-clock_C5.patch
============================================
diff --git a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
index b191cc7..647f700 100644
--- a/arch/alpha/kernel/time.c
+++ b/arch/alpha/kernel/time.c
@@ -349,44 +349,6 @@ time_init(void)
 	   bogomips yet, but this is close on a 500Mhz box.  */
 	__delay(1000000);
 
-	sec = CMOS_READ(RTC_SECONDS);
-	min = CMOS_READ(RTC_MINUTES);
-	hour = CMOS_READ(RTC_HOURS);
-	day = CMOS_READ(RTC_DAY_OF_MONTH);
-	mon = CMOS_READ(RTC_MONTH);
-	year = CMOS_READ(RTC_YEAR);
-
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-		BCD_TO_BIN(sec);
-		BCD_TO_BIN(min);
-		BCD_TO_BIN(hour);
-		BCD_TO_BIN(day);
-		BCD_TO_BIN(mon);
-		BCD_TO_BIN(year);
-	}
-
-	/* PC-like is standard; used for year >= 70 */
-	epoch = 1900;
-	if (year < 20)
-		epoch = 2000;
-	else if (year >= 20 && year < 48)
-		/* NT epoch */
-		epoch = 1980;
-	else if (year >= 48 && year < 70)
-		/* Digital UNIX epoch */
-		epoch = 1952;
-
-	printk(KERN_INFO "Using epoch = %d\n", epoch);
-
-	if ((year += epoch) < 1970)
-		year += 100;
-
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = 0;
-
-        wall_to_monotonic.tv_sec -= xtime.tv_sec;
-        wall_to_monotonic.tv_nsec = 0;
-
 	if (HZ > (1<<16)) {
 		extern void __you_loose (void);
 		__you_loose();
@@ -507,6 +469,45 @@ do_settimeofday(struct timespec *tv)
 
 EXPORT_SYMBOL(do_settimeofday);
 
+/* Read the CMOS clock and convert it to epoch based seconds */
+unsigned long read_persistent_clock(void)
+{
+	unsigned int year, mon, day, hour, min, sec, epoch;
+
+	sec = CMOS_READ(RTC_SECONDS);
+	min = CMOS_READ(RTC_MINUTES);
+	hour = CMOS_READ(RTC_HOURS);
+	day = CMOS_READ(RTC_DAY_OF_MONTH);
+	mon = CMOS_READ(RTC_MONTH);
+	year = CMOS_READ(RTC_YEAR);
+
+	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		BCD_TO_BIN(sec);
+		BCD_TO_BIN(min);
+		BCD_TO_BIN(hour);
+		BCD_TO_BIN(day);
+		BCD_TO_BIN(mon);
+		BCD_TO_BIN(year);
+	}
+
+	/* PC-like is standard; used for year >= 70 */
+	epoch = 1900;
+	if (year < 20)
+		epoch = 2000;
+	else if (year >= 20 && year < 48)
+		/* NT epoch */
+		epoch = 1980;
+	else if (year >= 48 && year < 70)
+		/* Digital UNIX epoch */
+		epoch = 1952;
+
+	printk(KERN_INFO "Using epoch = %d\n", epoch);
+
+	if ((year += epoch) < 1970)
+		year += 100;
+
+	return = mktime(year, mon, day, hour, min, sec);
+}
 
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be
diff --git a/arch/cris/kernel/crisksyms.c b/arch/cris/kernel/crisksyms.c
index 1f20c16..3d702c3 100644
--- a/arch/cris/kernel/crisksyms.c
+++ b/arch/cris/kernel/crisksyms.c
@@ -20,7 +20,7 @@
 #include <asm/pgtable.h>
 #include <asm/fasttimer.h>
 
-extern unsigned long get_cmos_time(void);
+extern unsigned long read_persistent_clock(void);
 extern void __Udiv(void);
 extern void __Umod(void);
 extern void __Div(void);
@@ -32,7 +32,7 @@ extern void iounmap(volatile void * __io
 
 /* Platform dependent support */
 EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(get_cmos_time);
+EXPORT_SYMBOL(read_persistent_clock);
 EXPORT_SYMBOL(loops_per_usec);
 
 /* String functions */
diff --git a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
index 66ba889..329323c 100644
--- a/arch/cris/kernel/time.c
+++ b/arch/cris/kernel/time.c
@@ -168,7 +168,7 @@ int set_rtc_mmss(unsigned long nowtime)
 /* grab the time from the RTC chip */
 
 unsigned long
-get_cmos_time(void)
+read_persistent_clock(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 
@@ -204,7 +204,7 @@ void
 update_xtime_from_cmos(void)
 {
 	if(have_rtc) {
-		xtime.tv_sec = get_cmos_time();
+		xtime.tv_sec = read_persistent_clock();
 		xtime.tv_nsec = 0;
 	}
 }
diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
index d5b64e1..c32659e 100644
--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -119,7 +119,8 @@ void time_divisor_init(void)
 	__set_TCSR_DATA(0, base >> 8);
 }
 
-void time_init(void)
+
+unsigned long read_persistent_clock(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 
@@ -135,9 +136,12 @@ void time_init(void)
 
 	if ((year += 1900) < 1970)
 		year += 100;
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = 0;
+	return mktime(year, mon, day, hour, min, sec);
+
+}
 
+void time_init(void)
+{
 	/* install scheduling interrupt handler */
 	setup_irq(IRQ_CPU_TIMER0, &timer_irq);
 
diff --git a/arch/h8300/kernel/time.c b/arch/h8300/kernel/time.c
index 688a510..18ea76c 100644
--- a/arch/h8300/kernel/time.c
+++ b/arch/h8300/kernel/time.c
@@ -48,7 +48,7 @@ static void timer_interrupt(int irq, voi
 	profile_tick(CPU_PROFILING, regs);
 }
 
-void time_init(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 
@@ -62,9 +62,11 @@ void time_init(void)
 
 	if ((year += 1900) < 1970)
 		year += 100;
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = 0;
+	return mktime(year, mon, day, hour, min, sec);
+}
 
+void time_init(void)
+{
 	platform_timer_setup(timer_interrupt);
 }
 
diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index 8591f2f..6d441ae 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -233,7 +233,7 @@
 
 #include "io_ports.h"
 
-extern unsigned long get_cmos_time(void);
+extern unsigned long read_persistent_clock(void);
 extern void machine_real_restart(unsigned char *, int);
 
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
@@ -1155,7 +1155,7 @@ out:
 static void set_time(void)
 {
 	if (got_clock_diff) {	/* Must know time zone in order to set clock */
-		xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
+		xtime.tv_sec = read_persistent_clock() + clock_cmos_diff;
 		xtime.tv_nsec = 0; 
 	} 
 }
@@ -1166,7 +1166,7 @@ static void get_time_diff(void)
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff = -read_persistent_clock();
 	clock_cmos_diff += get_seconds();
 	got_clock_diff = 1;
 #endif
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index edd00f6..571eb6c 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -203,7 +203,7 @@ irqreturn_t timer_interrupt(int irq, voi
 }
 
 /* not static: needed by APM */
-unsigned long get_cmos_time(void)
+unsigned long read_persistent_clock(void)
 {
 	unsigned long retval;
 	unsigned long flags;
@@ -219,7 +219,7 @@ unsigned long get_cmos_time(void)
 
 	return retval;
 }
-EXPORT_SYMBOL(get_cmos_time);
+EXPORT_SYMBOL(read_persistent_clock);
 
 static void sync_cmos_clock(unsigned long dummy);
 
@@ -277,9 +277,9 @@ static int timer_suspend(struct sys_devi
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff = -read_persistent_clock();
 	clock_cmos_diff += get_seconds();
-	sleep_start = get_cmos_time();
+	sleep_start = read_persistent_clock();
 	return 0;
 }
 
@@ -294,8 +294,8 @@ static int timer_resume(struct sys_devic
 		hpet_reenable();
 #endif
 	setup_pit_timer();
-	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = (get_cmos_time() - sleep_start) * HZ;
+	sec = read_persistent_clock() + clock_cmos_diff;
+	sleep_length = (read_persistent_clock() - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
@@ -334,11 +334,6 @@ extern void (*late_time_init)(void);
 /* Duplicate of time_init() below, with hpet_enable part added */
 static void __init hpet_time_init(void)
 {
-	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
-
 	if ((hpet_enable() >= 0) && hpet_use_timer) {
 		printk("Using HPET for base-timer\n");
 	}
@@ -359,10 +354,5 @@ void __init time_init(void)
 		return;
 	}
 #endif
-	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
-
 	time_init_hook();
 }
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 6928ef0..57f119d 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -240,18 +240,18 @@ void __devinit ia64_disable_timer(void)
 	ia64_set_itv(1 << 16);
 }
 
+unsigned long read_persistent_clock(void)
+{
+	struct timespec ts;
+	efi_gettimeofday(&ts);
+	return ts.tv_sec;
+}
+
 void __init
 time_init (void)
 {
 	register_percpu_irq(IA64_TIMER_VECTOR, &timer_irqaction);
-	efi_gettimeofday(&xtime);
 	ia64_init_itm();
-
-	/*
-	 * Initialize wall_to_monotonic such that adding it to xtime will yield zero, the
-	 * tv_nsec field must be normalized (i.e., 0 <= nsec < NSEC_PER_SEC).
-	 */
-	set_normalized_timespec(&wall_to_monotonic, -xtime.tv_sec, -xtime.tv_nsec);
 }
 
 /*
diff --git a/arch/m32r/kernel/time.c b/arch/m32r/kernel/time.c
index ded0be0..eebf379 100644
--- a/arch/m32r/kernel/time.c
+++ b/arch/m32r/kernel/time.c
@@ -240,6 +240,12 @@ irqreturn_t timer_interrupt(int irq, voi
 struct irqaction irq0 = { timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE,
 			  "MFT2", NULL, NULL };
 
+/* XXX - Need some help here! */
+unsigned long read_persistent_clock(void)
+{
+	return 0;
+}
+
 void __init time_init(void)
 {
 	unsigned int epoch, year, mon, day, hour, min, sec;
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 98e4b1a..56b51e2 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -72,7 +72,7 @@ static irqreturn_t timer_interrupt(int i
 	return IRQ_HANDLED;
 }
 
-void time_init(void)
+static unsigned long read_persistent_clock(void)
 {
 	struct rtc_time time;
 
@@ -81,12 +81,14 @@ void time_init(void)
 
 		if ((time.tm_year += 1900) < 1970)
 			time.tm_year += 100;
-		xtime.tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
+		return mktime(time.tm_year, time.tm_mon, time.tm_mday,
 				      time.tm_hour, time.tm_min, time.tm_sec);
-		xtime.tv_nsec = 0;
 	}
-	wall_to_monotonic.tv_sec = -xtime.tv_sec;
+	return 0;
+}
 
+void time_init(void)
+{
 	mach_sched_init(timer_interrupt);
 }
 
diff --git a/arch/m68knommu/kernel/time.c b/arch/m68knommu/kernel/time.c
index 1db9872..2db1557 100644
--- a/arch/m68knommu/kernel/time.c
+++ b/arch/m68knommu/kernel/time.c
@@ -100,7 +100,7 @@ static irqreturn_t timer_interrupt(int i
 	return(IRQ_HANDLED);
 }
 
-void time_init(void)
+static unsigned long read_persistent_clock(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 
@@ -111,10 +111,11 @@ void time_init(void)
 
 	if ((year += 1900) < 1970)
 		year += 100;
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = 0;
-	wall_to_monotonic.tv_sec = -xtime.tv_sec;
+	return mktime(year, mon, day, hour, min, sec);
+}
 
+void time_init(void)
+{
 	mach_sched_init(timer_interrupt);
 }
 
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 170cb67..abac10c 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -625,6 +625,11 @@ static unsigned int __init calibrate_hpt
 	return frequency >> log_2_loops;
 }
 
+unsigned long read_persistent_clock(void)
+{
+	return rtc_mips_get_time();
+}
+
 void __init time_init(void)
 {
 	if (board_time_init)
@@ -633,12 +638,6 @@ void __init time_init(void)
 	if (!rtc_mips_set_mmss)
 		rtc_mips_set_mmss = rtc_mips_set_time;
 
-	xtime.tv_sec = rtc_mips_get_time();
-	xtime.tv_nsec = 0;
-
-	set_normalized_timespec(&wall_to_monotonic,
-	                        -xtime.tv_sec, -xtime.tv_nsec);
-
 	/* Choose appropriate high precision timer routines.  */
 	if (!cpu_has_counter && !mips_hpt_read) {
 		/* No high precision timer -- sorry.  */
diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index 5facc9b..c837d29 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -225,6 +225,13 @@ unsigned long long sched_clock(void)
 	return (unsigned long long)jiffies * (1000000000 / HZ);
 }
 
+unsigned long read_persistent_clock(void)
+{
+	struct tod_data;
+	if(pdc_tod_read(&tod_data))
+		return 0;
+	return tod.tod_sec;
+}
 
 void __init time_init(void)
 {
@@ -243,17 +250,5 @@ void __init time_init(void)
 	/* kick off Itimer (CR16) */
 	mtctl(next_tick, 16);
 
-	if(pdc_tod_read(&tod_data) == 0) {
-		write_seqlock_irq(&xtime_lock);
-		xtime.tv_sec = tod_data.tod_sec;
-		xtime.tv_nsec = tod_data.tod_usec * 1000;
-		set_normalized_timespec(&wall_to_monotonic,
-		                        -xtime.tv_sec, -xtime.tv_nsec);
-		write_sequnlock_irq(&xtime_lock);
-	} else {
-		printk(KERN_ERR "Error reading tod clock\n");
-	        xtime.tv_sec = 0;
-		xtime.tv_nsec = 0;
-	}
 }
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 774c0a3..c5e87eb 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -913,7 +913,7 @@ void __init generic_calibrate_decr(void)
 #endif
 }
 
-unsigned long get_boot_time(void)
+unsigned long read_persistent_clock(void)
 {
 	struct rtc_time tm;
 
@@ -1011,7 +1011,7 @@ void __init time_init(void)
 	tb_to_ns_scale = scale;
 	tb_to_ns_shift = shift;
 
-	tm = get_boot_time();
+	tm = read_persistent_clock();
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 
diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
index 6ab8cc7..59b58e9 100644
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -281,6 +281,14 @@ int do_settimeofday(struct timespec *tv)
 
 EXPORT_SYMBOL(do_settimeofday);
 
+unsigned long read_persistent_clock(void)
+{
+	int sec = 0;
+	if (ppc_md.get_rtc_time)
+		sec = ppc_md.get_rtc_time();
+	return sec;
+}
+
 /* This function is only called on the boot processor */
 void __init time_init(void)
 {
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 74e6178..b1e62b4 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -341,6 +341,12 @@ void init_cpu_timer(void)
 
 extern void vtime_init(void);
 
+unsigned long read_persistent_clock(void)
+{
+	/* XXX I have no clue here. s390 folks, help! */
+	return 0;
+}
+
 /*
  * Initialize the TOD clock and the CPU timer of
  * the boot cpu.
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index a1589f8..cf5c5ec 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -161,6 +161,16 @@ device_initcall(timer_init_sysfs);
 
 void (*board_time_init)(void);
 
+unsigned long read_persistent_clock(void)
+{
+	struct timespec ts;
+	if (rtc_get_time) {
+		rtc_get_time(&ts);
+		return ts.tv_sec;
+	}
+	return 0;
+}
+
 void __init time_init(void)
 {
 	if (board_time_init)
@@ -168,16 +178,6 @@ void __init time_init(void)
 
 	clk_init();
 
-	if (rtc_get_time) {
-		rtc_get_time(&xtime);
-	} else {
-		xtime.tv_sec = mktime(2000, 1, 1, 0, 0, 0);
-		xtime.tv_nsec = 0;
-	}
-
-        set_normalized_timespec(&wall_to_monotonic,
-                                -xtime.tv_sec, -xtime.tv_nsec);
-
 	/*
 	 * Find the timer to use as the system timer, it will be
 	 * initialized for us.
diff --git a/arch/sh64/kernel/time.c b/arch/sh64/kernel/time.c
index b8162e5..d6feac5 100644
--- a/arch/sh64/kernel/time.c
+++ b/arch/sh64/kernel/time.c
@@ -487,6 +487,11 @@ static irqreturn_t sh64_rtc_interrupt(in
 static struct irqaction irq0  = { timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL};
 static struct irqaction irq1  = { sh64_rtc_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "rtc", NULL, NULL};
 
+unsigned long read_persistent_clock(void)
+{
+	return get_rtc_time();
+}
+
 void __init time_init(void)
 {
 	unsigned int cpu_clock, master_clock, bus_clock, module_clock;
@@ -511,9 +516,6 @@ void __init time_init(void)
 		panic("Unable to remap CPRC\n");
 	}
 
-	xtime.tv_sec = get_rtc_time();
-	xtime.tv_nsec = 0;
-
 	setup_irq(TIMER_IRQ, &irq0);
 	setup_irq(RTC_IRQ, &irq1);
 
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index 845081b..21c25ea 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -366,6 +366,12 @@ static int __init clock_init(void)
 fs_initcall(clock_init);
 #endif /* !CONFIG_SUN4 */
 
+unsigned long read_persistent_clock(void)
+{
+	/* XXX - help! not quite sure what to do here. */
+	return 0;
+}
+
 void __init sbus_time_init(void)
 {
 
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 094d3e3..df48592 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -606,23 +606,9 @@ static int __init has_low_battery(void)
 	return (data1 == data2);	/* Was the write blocked? */
 }
 
-/* Probe for the real time clock chip. */
-static void __init set_system_time(void)
+unsigned long read_persistent_clock(void)
 {
-	unsigned int year, mon, day, hour, min, sec;
 	void __iomem *mregs = mstk48t02_regs;
-#ifdef CONFIG_PCI
-	unsigned long dregs = ds1287_regs;
-#else
-	unsigned long dregs = 0UL;
-#endif
-	u8 tmp;
-
-	if (!mregs && !dregs) {
-		prom_printf("Something wrong, clock regs not mapped yet.\n");
-		prom_halt();
-	}		
-
 	if (mregs) {
 		spin_lock_irq(&mostek_lock);
 
@@ -637,6 +623,7 @@ static void __init set_system_time(void)
 		day = MSTK_REG_DOM(mregs);
 		mon = MSTK_REG_MONTH(mregs);
 		year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
+		spin_unlock_irq(&mostek_lock);
 	} else {
 		/* Dallas 12887 RTC chip. */
 
@@ -649,7 +636,8 @@ static void __init set_system_time(void)
 			year = CMOS_READ(RTC_YEAR);
 		} while (sec != CMOS_READ(RTC_SECONDS));
 
-		if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY)
+				|| RTC_ALWAYS_BCD) {
 			BCD_TO_BIN(sec);
 			BCD_TO_BIN(min);
 			BCD_TO_BIN(hour);
@@ -660,13 +648,29 @@ static void __init set_system_time(void)
 		if ((year += 1900) < 1970)
 			year += 100;
 	}
+	return mktime(year, mon, day, hour, min, sec);
+}
 
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
- 	                        -xtime.tv_sec, -xtime.tv_nsec);
+/* Probe for the real time clock chip. */
+static void __init set_system_time(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
+	void __iomem *mregs = mstk48t02_regs;
+#ifdef CONFIG_PCI
+	unsigned long dregs = ds1287_regs;
+#else
+	unsigned long dregs = 0UL;
+#endif
+	u8 tmp;
+
+	if (!mregs && !dregs) {
+		prom_printf("Something wrong, clock regs not mapped yet.\n");
+		prom_halt();
+	}
 
+	/* XXX - I probably messed this bit up. HELP! */
 	if (mregs) {
+		spin_lock_irq(&mostek_lock);
 		tmp = mostek_read(mregs + MOSTEK_CREG);
 		tmp &= ~MSTK_CREG_READ;
 		mostek_write(mregs + MOSTEK_CREG, tmp);
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 552ca1c..85c56ae 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -123,13 +123,14 @@ static void register_timer(void)
 
 extern void (*late_time_init)(void);
 
+unsigned long read_persistent_clock(void)
+{
+	return (long)os_nsecs()/BILLION;
+}
+
 void time_init(void)
 {
 	long long nsecs;
-
-	nsecs = os_nsecs();
-	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
-				-nsecs % BILLION);
 	late_time_init = register_timer;
 }
 
diff --git a/arch/v850/kernel/time.c b/arch/v850/kernel/time.c
index a0b4669..dea2753 100644
--- a/arch/v850/kernel/time.c
+++ b/arch/v850/kernel/time.c
@@ -184,8 +184,14 @@ static struct irqaction timer_irqaction 
 	NULL
 };
 
+unsigned long read_persistent_clock(void)
+{
+	struct timespec ts;
+	mach_gettimeofday(&ts);
+	return ts.tv_sec;
+}
+
 void time_init (void)
 {
-	mach_gettimeofday (&xtime);
 	mach_sched_init (&timer_irqaction);
 }
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 7a9b182..343461b 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -511,7 +511,7 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(a);
 }
 
-static unsigned long get_cmos_time(void)
+static unsigned long read_persistent_clock(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	unsigned long flags;
@@ -901,12 +901,6 @@ void __init time_init(void)
 	if (nohpet)
 		vxtime.hpet_address = 0;
 
-	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = 0;
-
-	set_normalized_timespec(&wall_to_monotonic,
-	                        -xtime.tv_sec, -xtime.tv_nsec);
-
 	if (!hpet_init())
                 vxtime_hz = (FSEC_PER_SEC + hpet_period / 2) / hpet_period;
 	else
@@ -1018,7 +1012,7 @@ static int timer_suspend(struct sys_devi
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	long cmos_time =  get_cmos_time();
+	long cmos_time = read_persistent_clock();
 
 	clock_cmos_diff = -cmos_time;
 	clock_cmos_diff += get_seconds();
@@ -1030,7 +1024,7 @@ static int timer_resume(struct sys_devic
 {
 	unsigned long flags;
 	unsigned long sec;
-	unsigned long ctime = get_cmos_time();
+	unsigned long ctime = read_persistent_clock();
 	unsigned long sleep_length = (ctime - sleep_start) * HZ;
 
 	if (vxtime.hpet_address)
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 412ab32..3588484 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -56,10 +56,19 @@ static struct irqaction timer_irqaction 
 	.name =		"timer",
 };
 
-void __init time_init(void)
+
+unsigned long read_persistent_clock(void)
 {
 	time_t sec_o, sec_n = 0;
+	if (platform_get_rtc_time(&sec_o) == 0)
+		while (platform_get_rtc_time(&sec_n))
+			if (sec_o != sec_n)
+				break;
+	return sec_n;
+}
 
+void __init time_init(void)
+{
 	/* The platform must provide a function to calibrate the processor
 	 * speed for the CALIBRATE.
 	 */
@@ -71,20 +80,9 @@ void __init time_init(void)
 			(int)(ccount_per_jiffy/(10000/HZ))%100);
 #endif
 
-	/* Set time from RTC (if provided) */
-
-	if (platform_get_rtc_time(&sec_o) == 0)
-		while (platform_get_rtc_time(&sec_n))
-			if (sec_o != sec_n)
-				break;
-
-	xtime.tv_nsec = 0;
-	last_rtc_update = xtime.tv_sec = sec_n;
+	last_rtc_update = xtime.tv_sec;
 	last_ccount_stamp = get_ccount();
 
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
-
 	/* Initialize the linux timer interrupt. */
 
 	setup_irq(LINUX_TIMER_INT, &timer_irqaction);
diff --git a/kernel/timer.c b/kernel/timer.c
index b650f04..6ce2fd9 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -961,10 +961,16 @@ void __init timekeeping_init(void)
 	unsigned long flags;
 
 	write_seqlock_irqsave(&xtime_lock, flags);
+	ntp_clear();
+
 	clock = clocksource_get_next();
 	clocksource_calculate_interval(clock, tick_nsec);
 	clock->cycle_last = clocksource_read(clock);
-	ntp_clear();
+
+	xtime.tv_sec = read_persistent_clock();
+	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
+	set_normalized_timespec(&wall_to_monotonic,
+		-xtime.tv_sec, -xtime.tv_nsec);
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
 


