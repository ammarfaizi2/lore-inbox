Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266949AbSKRXel>; Mon, 18 Nov 2002 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbSKRXek>; Mon, 18 Nov 2002 18:34:40 -0500
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.234.83]:49795 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S266949AbSKRXbp>;
	Mon, 18 Nov 2002 18:31:45 -0500
Date: Mon, 18 Nov 2002 18:38:05 -0500
Message-Id: <200211182338.gAINc5g10797@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com,
       george@mvista.com
Subject: [PATCH] The alternate Posix timers patch5
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

This is the fifth version of my spin on the Posix timers.  This patch
works with linux-2.5.48.  I started with George Anzinger's patch, but
I have made major changes.  

This version fixes a bunch of my bugs.  It supports high resolution
by sharing the local APIC timer as the timing source.  If you don't
have this timer, this patch is not for you.

Here is a summary of my changes:

     -	I keep the timers in seconds and nano-seconds. 

     -	Changes to the arch/i386/kernel/timers code to use nanoseconds
	consistently.  I added do_[get/set]timeofday_ns() to get/set time
	in nanoseconds.  I also added a monotonic time since boot clock
	do_gettime_sinceboot_ns().

     -	A new queue just for Posix timers and code to handle expiring
	timers.  This supports high resolution without having to change
	the existing jiffie based timers.  It also works fine with tick
	based time measurement.

	I implemented this priority queue as a sorted list with a rbtree
	to index the list.  It is deterministic and fast.  
	I want my posix timers to have low jitter so I will expire them
	directly from the interrupt.  Having a separate queue gives
	me this flexibilty.
	
     -	A new id allocator/lookup mechanism based on a radix tree.  It
	includes  a bitmap to summarize the portion of the tree which is
	in use.  (George picked this up from me.)  My version doesn't
	immediately re-use the id when it is freed.  This is intended
	to catch application errors e.g. continuing to use a timer
	after it is destroyed.

     -	Code to limit the rate at which timers expire.  Without this an
	errant program could swamp the system with interrupts.  I added
	a sysctl interface to adjust the parameters which control this.
	It includes the resolution for posix timers and nanosleep
	and three values which set a duty cycle for timer expiry.
	It limits the number of timers expired from a single interrupt.
	If the system hits this limit, it waits a recovery time before
	expiring more timers.

     -	Nanosleep shouldn't complete early.  It is not allowed to
	return early if the process is hit with a signal that is
	not delivered.  The existing nanosleep does return early.

	George has fixed this in his patch by calling do_signal()
	from inside nanosleep (actually clock_nanosleep).  This is
	ugly because it requires a pointer to the registers which
	makes it architecture specific code.

	I take a different approach.  I let nanosleep return to do the
	do_signal() from entry.S, but I arrange to restart the nanosleep
	if the signal is not delivered.  The logic is similar to the
	existing ERESTARTNOHAND mechanism.  This interface is close to what
	I want, but the system call doesn't have a clue that it's being
	restarted.  I ended up making a small change to do_signal which
	should not be too painful to add to the other architectures.

It now passes all of the tests that are included in George's timers
support package.  Actually I had to make a small change to the 
clock_nanosleeptest to get around a synchronization problem.  I also
have a minor problem with the ltp nanosleep02 test.  It doesn't expect
the time to be rounded up to the clock resolution.

I have been using George's version of the patch and would be glad to
see it included into the 2.5 tree.  On the other hand, since we don't
know what might appeal to Linus, it makes sense to give him a choice.

Jim Houston - Concurrent Computer Corp.

diff -X dontdiff -urN linux-2.5.48.orig/arch/i386/kernel/apic.c linux-2.5.48/arch/i386/kernel/apic.c
--- linux-2.5.48.orig/arch/i386/kernel/apic.c	Mon Nov 18 10:15:11 2002
+++ linux-2.5.48/arch/i386/kernel/apic.c	Mon Nov 18 09:49:34 2002
@@ -32,6 +32,7 @@
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include "mach_apic.h"
+#include <asm/div64.h>
 
 void __init apic_intr_init(void)
 {
@@ -807,7 +808,7 @@
 	unsigned int lvtt1_value, tmp_value;
 
 	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
-			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+			LOCAL_TIMER_VECTOR;
 	apic_write_around(APIC_LVTT, lvtt1_value);
 
 	/*
@@ -916,6 +917,31 @@
 
 static unsigned int calibration_result;
 
+/*
+ * Set the APIC timer for a one shot expiry in nanoseconds.
+ * This is called from the posix-timers code.
+ */
+int ns2clock;
+void set_APIC_timer(int ns)
+{
+	long long tmp;
+	int clocks;
+	unsigned int  tmp_value;
+
+	if (!ns2clock) {
+		tmp = (calibration_result * HZ);
+		tmp = tmp << 32;
+		do_div(tmp, 1000000000);
+		ns2clock = (int)tmp;
+		clocks = ((long long)ns2clock * ns) >> 32;
+	}
+	clocks = ((long long)ns2clock * ns) >> 32;
+	tmp_value = apic_read(APIC_TMCCT);
+	if (!tmp_value || clocks/APIC_DIVISOR < tmp_value)
+		apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+}
+
+
 int dont_use_local_apic_timer __initdata = 0;
 
 void __init setup_boot_APIC_clock(void)
@@ -1005,9 +1031,17 @@
  * value into /proc/profile.
  */
 
+long get_eip(void *regs)
+{
+	return(((struct pt_regs *)regs)->eip);
+}
+
 inline void smp_local_timer_interrupt(struct pt_regs * regs)
 {
 	int cpu = smp_processor_id();
+
+	if (!run_posix_timers((void *)regs)) 
+		return;
 
 	x86_do_profile(regs);
 
diff -X dontdiff -urN linux-2.5.48.orig/arch/i386/kernel/entry.S linux-2.5.48/arch/i386/kernel/entry.S
--- linux-2.5.48.orig/arch/i386/kernel/entry.S	Mon Nov 18 10:17:13 2002
+++ linux-2.5.48/arch/i386/kernel/entry.S	Mon Nov 18 10:00:41 2002
@@ -768,6 +768,15 @@
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
  	.long sys_set_tid_address
+ 	.long sys_timer_create
+	.long sys_timer_settime	/* 260 */
+	.long sys_timer_gettime
+ 	.long sys_timer_getoverrun
+ 	.long sys_timer_delete
+ 	.long sys_clock_settime
+ 	.long sys_clock_gettime	/* 265 */
+ 	.long sys_clock_getres
+	.long sys_clock_nanosleep
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
diff -X dontdiff -urN linux-2.5.48.orig/arch/i386/kernel/signal.c linux-2.5.48/arch/i386/kernel/signal.c
--- linux-2.5.48.orig/arch/i386/kernel/signal.c	Mon Nov 18 10:14:04 2002
+++ linux-2.5.48/arch/i386/kernel/signal.c	Mon Nov 18 09:49:34 2002
@@ -507,6 +507,7 @@
 		/* If so, check system call restarting.. */
 		switch (regs->eax) {
 			case -ERESTARTNOHAND:
+			case -ERESTARTNANOSLP:
 				regs->eax = -EINTR;
 				break;
 
@@ -588,6 +589,16 @@
 		if (regs->eax == -ERESTARTNOHAND ||
 		    regs->eax == -ERESTARTSYS ||
 		    regs->eax == -ERESTARTNOINTR) {
+			regs->eax = regs->orig_eax;
+			regs->eip -= 2;
+		}
+		/*
+		 * If a nanosleep or clock_nanosleep is interrupted
+		 * by a non delivered signal we want to complete 
+		 * the requested delay.
+		 */
+		if (regs->eax == -ERESTARTNANOSLP) {
+			current->nanosleep_restart = RESTART_ACK;
 			regs->eax = regs->orig_eax;
 			regs->eip -= 2;
 		}
diff -X dontdiff -urN linux-2.5.48.orig/arch/i386/kernel/smpboot.c linux-2.5.48/arch/i386/kernel/smpboot.c
--- linux-2.5.48.orig/arch/i386/kernel/smpboot.c	Mon Nov 18 10:16:41 2002
+++ linux-2.5.48/arch/i386/kernel/smpboot.c	Mon Nov 18 09:49:34 2002
@@ -181,8 +181,6 @@
 
 #define NR_LOOPS 5
 
-extern unsigned long fast_gettimeoffset_quotient;
-
 /*
  * accurate 64-bit/32-bit division, expanded to 32-bit divisions and 64-bit
  * multiplication. Not terribly optimized but we need it at boot time only
@@ -222,7 +220,7 @@
 
 	printk("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
 
-	one_usec = ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
+	one_usec = cpu_khz/1000;
 
 	atomic_set(&tsc_start_flag, 1);
 	wmb();
diff -X dontdiff -urN linux-2.5.48.orig/arch/i386/kernel/time.c linux-2.5.48/arch/i386/kernel/time.c
--- linux-2.5.48.orig/arch/i386/kernel/time.c	Mon Nov 18 10:16:50 2002
+++ linux-2.5.48/arch/i386/kernel/time.c	Mon Nov 18 09:49:34 2002
@@ -83,33 +83,70 @@
  * This version of gettimeofday has microsecond resolution
  * and better than microsecond precision on fast x86 machines with TSC.
  */
-void do_gettimeofday(struct timeval *tv)
+
+void do_gettime_offset(struct timespec *tv)
+{
+	unsigned long lost = jiffies - wall_jiffies;
+
+	tv->tv_sec = 0;
+	tv->tv_nsec = timer->get_offset();
+	if (lost)
+		tv->tv_nsec += lost * (1000000000 / HZ);
+	while (tv->tv_nsec >= 1000000000) {
+		tv->tv_nsec -= 1000000000;
+		tv->tv_sec++;
+	}
+}
+void do_gettimeofday_ns(struct timespec *tv)
 {
 	unsigned long flags;
-	unsigned long usec, sec;
+	struct timespec ts;
 
 	read_lock_irqsave(&xtime_lock, flags);
-	usec = timer->get_offset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
-	sec = xtime.tv_sec;
-	usec += (xtime.tv_nsec / 1000);
+	do_gettime_offset(&ts);
+	ts.tv_sec += xtime.tv_sec;
+	ts.tv_nsec += xtime.tv_nsec;
 	read_unlock_irqrestore(&xtime_lock, flags);
-
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
+	if (ts.tv_nsec >= 1000000000) {
+		ts.tv_nsec -= 1000000000;
+		ts.tv_sec += 1;
 	}
+	tv->tv_sec = ts.tv_sec;
+	tv->tv_nsec = ts.tv_nsec;
+}
+
+void do_gettimeofday(struct timeval *tv)
+{
+	struct timespec ts;
 
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
+	do_gettimeofday_ns(&ts);
+	tv->tv_sec = ts.tv_sec;
+	tv->tv_usec = ts.tv_nsec/1000;
 }
 
-void do_settimeofday(struct timeval *tv)
+
+void do_gettime_sinceboot_ns(struct timespec *tv)
+{
+	unsigned long flags;
+	struct timespec ts;
+
+	read_lock_irqsave(&xtime_lock, flags);
+	do_gettime_offset(&ts);
+	ts.tv_sec += ytime.tv_sec;
+	ts.tv_nsec +=ytime.tv_nsec;
+	read_unlock_irqrestore(&xtime_lock, flags);
+	if (ts.tv_nsec >= 1000000000) {
+		ts.tv_nsec -= 1000000000;
+		ts.tv_sec += 1;
+	}
+	tv->tv_sec = ts.tv_sec;
+	tv->tv_nsec = ts.tv_nsec;
+}
+
+void do_settimeofday_ns(struct timespec *tv)
 {
+	struct timespec ts;
+
 	write_lock_irq(&xtime_lock);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
@@ -117,16 +154,15 @@
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	tv->tv_usec -= timer->get_offset();
-	tv->tv_usec -= (jiffies - wall_jiffies) * (1000000 / HZ);
-
-	while (tv->tv_usec < 0) {
-		tv->tv_usec += 1000000;
+	do_gettime_offset(&ts);
+	tv->tv_nsec -= ts.tv_nsec;
+	tv->tv_sec -= ts.tv_sec;
+	while (tv->tv_nsec < 0) {
+		tv->tv_nsec += 1000000000;
 		tv->tv_sec--;
 	}
-
 	xtime.tv_sec = tv->tv_sec;
-	xtime.tv_nsec = (tv->tv_usec * 1000);
+	xtime.tv_nsec = tv->tv_nsec;
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -134,6 +170,15 @@
 	write_unlock_irq(&xtime_lock);
 }
 
+void do_settimeofday(struct timeval *tv)
+{
+	struct timespec ts;
+	ts.tv_sec = tv->tv_sec;
+	ts.tv_nsec = tv->tv_usec * 1000;
+
+	do_settimeofday_ns(&ts);
+}
+
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be
  * called 500 ms after the second nowtime has started, because when
@@ -351,6 +396,8 @@
 	
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = 0;
+	ytime.tv_sec = 0;
+	ytime.tv_nsec = 0;
 
 
 	timer = select_timer();
diff -X dontdiff -urN linux-2.5.48.orig/arch/i386/kernel/timers/timer_cyclone.c linux-2.5.48/arch/i386/kernel/timers/timer_cyclone.c
--- linux-2.5.48.orig/arch/i386/kernel/timers/timer_cyclone.c	Mon Nov 18 10:14:50 2002
+++ linux-2.5.48/arch/i386/kernel/timers/timer_cyclone.c	Mon Nov 18 16:15:39 2002
@@ -47,7 +47,7 @@
 	count |= inb(0x40) << 8;
 	spin_unlock(&i8253_lock);
 
-	count = ((LATCH-1) - count) * TICK_SIZE;
+	count = ((LATCH-1) - count) * tick_nsec;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 }
 
@@ -64,11 +64,11 @@
 	/* .. relative to previous jiffy */
 	offset = offset - last_cyclone_timer;
 
-	/* convert cyclone ticks to microseconds */	
+	/* convert cyclone ticks to nanoseconds */	
 	/* XXX slow, can we speed this up? */
-	offset = offset/(CYCLONE_TIMER_FREQ/1000000);
+	offset = offset*(1000000000/CYCLONE_TIMER_FREQ);
 
-	/* our adjusted time offset in microseconds */
+	/* our adjusted time offset in nanoseconds */
 	return delay_at_last_interrupt + offset;
 }
 
diff -X dontdiff -urN linux-2.5.48.orig/arch/i386/kernel/timers/timer_pit.c linux-2.5.48/arch/i386/kernel/timers/timer_pit.c
--- linux-2.5.48.orig/arch/i386/kernel/timers/timer_pit.c	Mon Nov 18 10:16:41 2002
+++ linux-2.5.48/arch/i386/kernel/timers/timer_pit.c	Mon Nov 18 09:49:34 2002
@@ -115,7 +115,7 @@
 
 	count_p = count;
 
-	count = ((LATCH-1) - count) * TICK_SIZE;
+	count = ((LATCH-1) - count) * tick_nsec;
 	count = (count + LATCH/2) / LATCH;
 
 	return count;
diff -X dontdiff -urN linux-2.5.48.orig/arch/i386/kernel/timers/timer_tsc.c linux-2.5.48/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.5.48.orig/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 18 10:17:13 2002
+++ linux-2.5.48/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 18 16:16:44 2002
@@ -16,14 +16,14 @@
 extern spinlock_t i8253_lock;
 
 static int use_tsc;
-/* Number of usecs that the last interrupt was delayed */
+/* Number of nsecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 
-/* Cached *multiplier* to convert TSC counts to microseconds.
+/* Cached *multiplier* to convert TSC counts to nanoseconds.
  * (see the equation below).
- * Equal to 2^32 * (1 / (clocks per usec) ).
+ * Equal to 2^22 * (1 / (clocks per nsec) ).
  * Initialized in time_init.
  */
 unsigned long fast_gettimeoffset_quotient;
@@ -41,19 +41,14 @@
 
 	/*
          * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
-         *             = (tsc_low delta) * (usecs_per_clock)
-         *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
 	 *
 	 * Using a mull instead of a divl saves up to 31 clock cycles
 	 * in the critical path.
          */
 
-	__asm__("mull %2"
-		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
-		 "0" (eax));
+	edx = ((long long)fast_gettimeoffset_quotient*eax) >> 22;
 
-	/* our adjusted time offset in microseconds */
+	/* our adjusted time offset in nanoseconds */
 	return delay_at_last_interrupt + edx;
 }
 
@@ -99,13 +94,13 @@
 		}
 	}
 
-	count = ((LATCH-1) - count) * TICK_SIZE;
+	count = ((LATCH-1) - count) * tick_nsec;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 }
 
 
 /* ------ Calibrate the TSC ------- 
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Return 2^22 * (1 / (TSC clocks per nsec)) for do_fast_gettimeoffset().
  * Too much 64-bit arithmetic here to do this cleanly in C, and for
  * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
  * output busy loop as low as possible. We avoid reading the CTC registers
@@ -113,8 +108,13 @@
  * device.
  */
 
-#define CALIBRATE_LATCH	(5 * LATCH)
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
+/*
+ * Pick the largest possible latch value (its a 16 bit counter)
+ * and calculate the corresponding time.
+ */
+#define CALIBRATE_LATCH	(0xffff)
+#define CALIBRATE_TIME	((int)((1000000000LL*CALIBRATE_LATCH + \
+			CLOCK_TICK_RATE/2) / CLOCK_TICK_RATE))
 
 static unsigned long __init calibrate_tsc(void)
 {
@@ -164,12 +164,14 @@
 			goto bad_ctc;
 
 		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
+		if (endlow <= (CALIBRATE_TIME>>10))
 			goto bad_ctc;
 
 		__asm__("divl %2"
 			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+			:"r" (endlow),
+			"0" (CALIBRATE_TIME<<22),
+			"1" (CALIBRATE_TIME>>10));
 
 		return endlow;
 	}
@@ -179,6 +181,7 @@
 	 * or the CPU was so fast/slow that the quotient wouldn't fit in
 	 * 32 bits..
 	 */
+
 bad_ctc:
 	return 0;
 }
@@ -268,11 +271,14 @@
 			x86_udelay_tsc = 1;
 
 			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+			 * The formula is 
+			 *    (10^6 * 2^22) / (2^22 * 1 / (clocks/ns)) =
 			 * clock/second. Our precision is about 100 ppm.
 			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
+			{	unsigned long eax, edx;
+				eax = (long)(1000000LL<<22);
+				edx = (long)(1000000LL>>10);
+				__asm__("divl %2;"
 		       		:"=a" (cpu_khz), "=d" (edx)
         	       		:"r" (tsc_quotient),
 	                	"0" (eax), "1" (edx));
@@ -281,6 +287,7 @@
 #ifdef CONFIG_CPU_FREQ
 			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
+			mark_offset_tsc();
 			return 0;
 		}
 	}
diff -X dontdiff -urN linux-2.5.48.orig/fs/exec.c linux-2.5.48/fs/exec.c
--- linux-2.5.48.orig/fs/exec.c	Mon Nov 18 10:17:32 2002
+++ linux-2.5.48/fs/exec.c	Mon Nov 18 09:49:34 2002
@@ -778,6 +778,7 @@
 			
 	flush_signal_handlers(current);
 	flush_old_files(current->files);
+	exit_itimers(current, 0);
 
 	return 0;
 
diff -X dontdiff -urN linux-2.5.48.orig/include/asm-generic/siginfo.h linux-2.5.48/include/asm-generic/siginfo.h
--- linux-2.5.48.orig/include/asm-generic/siginfo.h	Mon Nov 18 10:15:41 2002
+++ linux-2.5.48/include/asm-generic/siginfo.h	Mon Nov 18 09:49:34 2002
@@ -43,8 +43,9 @@
 
 		/* POSIX.1b timers */
 		struct {
-			unsigned int _timer1;
-			unsigned int _timer2;
+			timer_t _tid;		/* timer id */
+			int _overrun;		/* overrun count */
+			sigval_t _sigval;	/* same as below */
 		} _timer;
 
 		/* POSIX.1b signals */
@@ -86,8 +87,8 @@
  */
 #define si_pid		_sifields._kill._pid
 #define si_uid		_sifields._kill._uid
-#define si_timer1	_sifields._timer._timer1
-#define si_timer2	_sifields._timer._timer2
+#define si_tid		_sifields._timer._tid
+#define si_overrun	_sifields._timer._overrun
 #define si_status	_sifields._sigchld._status
 #define si_utime	_sifields._sigchld._utime
 #define si_stime	_sifields._sigchld._stime
@@ -221,6 +222,7 @@
 #define SIGEV_SIGNAL	0	/* notify via signal */
 #define SIGEV_NONE	1	/* other notification: meaningless */
 #define SIGEV_THREAD	2	/* deliver via thread creation */
+#define SIGEV_THREAD_ID 4	/* deliver to thread */
 
 #define SIGEV_MAX_SIZE	64
 #ifndef SIGEV_PAD_SIZE
@@ -235,6 +237,7 @@
 	int sigev_notify;
 	union {
 		int _pad[SIGEV_PAD_SIZE];
+		 int _tid;
 
 		struct {
 			void (*_function)(sigval_t);
@@ -247,6 +250,7 @@
 
 #define sigev_notify_function	_sigev_un._sigev_thread._function
 #define sigev_notify_attributes	_sigev_un._sigev_thread._attribute
+#define sigev_notify_thread_id	 _sigev_un._tid
 
 #ifdef __KERNEL__
 
diff -X dontdiff -urN linux-2.5.48.orig/include/asm-i386/posix_types.h linux-2.5.48/include/asm-i386/posix_types.h
--- linux-2.5.48.orig/include/asm-i386/posix_types.h	Tue Jan 18 01:22:52 2000
+++ linux-2.5.48/include/asm-i386/posix_types.h	Mon Nov 18 09:49:34 2002
@@ -22,6 +22,8 @@
 typedef long		__kernel_time_t;
 typedef long		__kernel_suseconds_t;
 typedef long		__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int		__kernel_daddr_t;
 typedef char *		__kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
diff -X dontdiff -urN linux-2.5.48.orig/include/asm-i386/unistd.h linux-2.5.48/include/asm-i386/unistd.h
--- linux-2.5.48.orig/include/asm-i386/unistd.h	Mon Nov 18 10:17:34 2002
+++ linux-2.5.48/include/asm-i386/unistd.h	Mon Nov 18 09:58:38 2002
@@ -263,6 +263,15 @@
 #define __NR_sys_epoll_wait	256
 #define __NR_remap_file_pages	257
 #define __NR_set_tid_address	258
+#define __NR_timer_create	259
+#define __NR_timer_settime	(__NR_timer_create+1)
+#define __NR_timer_gettime	(__NR_timer_create+2)
+#define __NR_timer_getoverrun	(__NR_timer_create+3)
+#define __NR_timer_delete	(__NR_timer_create+4)
+#define __NR_clock_settime	(__NR_timer_create+5)
+#define __NR_clock_gettime	(__NR_timer_create+6)
+#define __NR_clock_getres	(__NR_timer_create+7)
+#define __NR_clock_nanosleep	(__NR_timer_create+8)
 
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/errno.h linux-2.5.48/include/linux/errno.h
--- linux-2.5.48.orig/include/linux/errno.h	Mon Nov 18 10:12:58 2002
+++ linux-2.5.48/include/linux/errno.h	Mon Nov 18 09:49:34 2002
@@ -10,6 +10,7 @@
 #define ERESTARTNOINTR	513
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
+#define ERESTARTNANOSLP	516
 
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/id2ptr.h linux-2.5.48/include/linux/id2ptr.h
--- linux-2.5.48.orig/include/linux/id2ptr.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.48/include/linux/id2ptr.h	Mon Nov 18 09:49:34 2002
@@ -0,0 +1,47 @@
+/*
+ * include/linux/id2ptr.h
+ * 
+ * 2002-10-18  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Small id to pointer translation service avoiding fixed sized
+ * tables.
+ */
+
+#define ID_BITS 5
+#define ID_MASK ((1 << ID_BITS)-1)
+#define ID_FULL ((1 << (1 << ID_BITS))-1)
+
+/* Number of id_layer structs to leave in free list */
+#define ID_FREE_MAX 6
+
+struct id_layer {
+	unsigned int	bitmap;
+	struct id_layer	*ary[1<<ID_BITS];
+};
+
+struct id {
+	int		layers;
+	int		last;
+	int		count;
+	int		min_wrap;
+	struct id_layer *top;
+};
+
+void *id2ptr_lookup(struct id *idp, int id);
+int id2ptr_new(struct id *idp, void *ptr);
+void id2ptr_remove(struct id *idp, int id);
+void id2ptr_init(struct id *idp, int min_wrap);
+
+
+static inline void update_bitmap(struct id_layer *p, int bit)
+{
+	if (p->ary[bit] && p->ary[bit]->bitmap == 0xffffffff)
+		p->bitmap |= 1<<bit;
+	else
+		p->bitmap &= ~(1<<bit);
+}
+
+extern kmem_cache_t *id_layer_cache;
+
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/init_task.h linux-2.5.48/include/linux/init_task.h
--- linux-2.5.48.orig/include/linux/init_task.h	Mon Nov 18 10:14:07 2002
+++ linux-2.5.48/include/linux/init_task.h	Mon Nov 18 09:49:34 2002
@@ -93,6 +93,12 @@
 	.sig		= &init_signals,				\
 	.pending	= { NULL, &tsk.pending.head, {{0}}},		\
 	.blocked	= {{0}},					\
+	.posix_timers	= LIST_HEAD_INIT(tsk.posix_timers),		\
+	.nanosleep_tmr.it_v.it_interval.tv_sec = 0,			\
+	.nanosleep_tmr.it_v.it_interval.tv_nsec = 0,			\
+	.nanosleep_tmr.it_process = &tsk,				\
+	.nanosleep_tmr.it_type = NANOSLEEP,				\
+	.nanosleep_restart = RESTART_NONE,				\
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/posix-timers.h linux-2.5.48/include/linux/posix-timers.h
--- linux-2.5.48.orig/include/linux/posix-timers.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.48/include/linux/posix-timers.h	Mon Nov 18 09:49:34 2002
@@ -0,0 +1,83 @@
+/*
+ * include/linux/posix-timers.h
+ * 
+ * 2002-10-22  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ */
+
+#ifndef _linux_POSIX_TIMERS_H
+#define _linux_POSIX_TIMERS_H
+
+/* This should be in posix-timers.h - but this is easier now. */
+
+enum timer_type {
+	TIMER,
+	TICK,
+	NANOSLEEP
+};
+
+struct k_itimer {
+	struct list_head	it_pq_list;	/* fields for timer priority queue. */
+	struct rb_node		it_pq_node;	
+	struct timer_pq		*it_pq;		/* pointer to the queue. */
+
+	struct list_head it_task_list;	/* list for exit_itimers */
+	spinlock_t it_lock;
+	clockid_t it_clock;		/* which timer type */
+	timer_t it_id;			/* timer id */
+	int it_overrun;			/* overrun on pending signal  */
+	int it_overrun_last;		 /* overrun on last delivered signal */
+	int it_overrun_deferred;	 /* overrun on pending timer interrupt */
+	int it_sigev_notify;		 /* notify word of sigevent struct */
+	int it_sigev_signo;		 /* signo word of sigevent struct */
+	sigval_t it_sigev_value;	 /* value word of sigevent struct */
+	struct task_struct *it_process;	/* process to send signal to */
+	struct itimerspec it_v;		/* expiry time & interval */
+	enum timer_type it_type;
+};
+
+/*
+ * The priority queue is a sorted doubly linked list ordered by
+ * expiry time.  A rbtree is used as an index in to this list
+ * so that inserts are O(log2(n)).
+ */
+
+struct timer_pq {
+	struct list_head	head;
+	struct rb_root		rb_root;
+};
+
+#define TIMER_PQ_INIT(name)	{ \
+	.rb_root = RB_ROOT, \
+	.head = LIST_HEAD_INIT(name.head), \
+}
+
+struct k_clock {
+	struct timer_pq	pq[NR_CPUS];
+	struct k_itimer tick[NR_CPUS];
+	int  res;			/* in nano seconds */
+	int ( *clock_set)(struct timespec *tp);
+	int ( *clock_get)(struct timespec *tp);
+	int ( *nsleep)(   int flags, 
+			   struct timespec*new_setting,
+			   struct itimerspec *old_setting);
+	int ( *timer_set)(struct k_itimer *timr, int flags,
+			   struct itimerspec *new_setting,
+			   struct itimerspec *old_setting);
+	int  ( *timer_del)(struct k_itimer *timr);
+	void ( *timer_get)(struct k_itimer *timr,
+			   struct itimerspec *cur_setting);
+};
+
+int do_posix_clock_monotonic_gettime(struct timespec *tp);
+int do_posix_clock_monotonic_settime(struct timespec *tp);
+asmlinkage int sys_timer_delete(timer_t timer_id);
+
+/* values for current->nanosleep_restart */
+#define RESTART_NONE	0
+#define RESTART_REQUEST	1
+#define RESTART_ACK	2
+
+#endif
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/sched.h linux-2.5.48/include/linux/sched.h
--- linux-2.5.48.orig/include/linux/sched.h	Mon Nov 18 10:17:34 2002
+++ linux-2.5.48/include/linux/sched.h	Mon Nov 18 09:49:34 2002
@@ -27,6 +27,7 @@
 #include <linux/compiler.h>
 #include <linux/completion.h>
 #include <linux/pid.h>
+#include <linux/posix-timers.h>
 
 struct exec_domain;
 
@@ -338,6 +339,9 @@
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
+	struct list_head posix_timers; /* POSIX.1b Interval Timers */
+	struct k_itimer nanosleep_tmr;
+	int	nanosleep_restart;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
@@ -607,6 +611,7 @@
 
 extern void exit_mm(struct task_struct *);
 extern void exit_files(struct task_struct *);
+extern void exit_itimers(struct task_struct *, int);
 extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
 
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/sys.h linux-2.5.48/include/linux/sys.h
--- linux-2.5.48.orig/include/linux/sys.h	Mon Nov 18 10:16:28 2002
+++ linux-2.5.48/include/linux/sys.h	Mon Nov 18 09:49:34 2002
@@ -4,7 +4,7 @@
 /*
  * system call entry points ... but not all are defined
  */
-#define NR_syscalls 260
+#define NR_syscalls 275
 
 /*
  * These are system calls that will be removed at some time
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/sysctl.h linux-2.5.48/include/linux/sysctl.h
--- linux-2.5.48.orig/include/linux/sysctl.h	Mon Nov 18 10:17:09 2002
+++ linux-2.5.48/include/linux/sysctl.h	Mon Nov 18 09:49:34 2002
@@ -129,6 +129,7 @@
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+  	KERN_POSIX_TIMERS=57,	/* posix timer parameters */
 };
 
 
@@ -188,6 +189,16 @@
 	RANDOM_WRITE_THRESH=4,
 	RANDOM_BOOT_ID=5,
 	RANDOM_UUID=6
+};
+
+/* /proc/sys/kernel/posix-timers */
+enum
+{
+	POSIX_TIMERS_RESOLUTION=1,
+	POSIX_TIMERS_NANOSLEEP_RES=2,
+	POSIX_TIMERS_MAX_EXPIRIES=3,
+	POSIX_TIMERS_RECOVERY_TIME=4,
+	POSIX_TIMERS_MIN_DELAY=5
 };
 
 /* /proc/sys/bus/isa */
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/time.h linux-2.5.48/include/linux/time.h
--- linux-2.5.48.orig/include/linux/time.h	Mon Nov 18 10:17:34 2002
+++ linux-2.5.48/include/linux/time.h	Mon Nov 18 09:55:48 2002
@@ -40,6 +40,19 @@
  */
 #define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)
 
+/* Parameters used to convert the timespec values */
+#ifndef USEC_PER_SEC
+#define USEC_PER_SEC (1000000L)
+#endif
+
+#ifndef NSEC_PER_SEC
+#define NSEC_PER_SEC (1000000000L)
+#endif
+
+#ifndef NSEC_PER_USEC
+#define NSEC_PER_USEC (1000L)
+#endif
+
 static __inline__ unsigned long
 timespec_to_jiffies(struct timespec *value)
 {
@@ -119,7 +132,8 @@
 	)*60 + sec; /* finally seconds */
 }
 
-extern struct timespec xtime;
+extern struct timespec xtime;	/* time of day */
+extern struct timespec ytime;	/* time since boot */
 extern rwlock_t xtime_lock;
 
 static inline unsigned long get_seconds(void)
@@ -137,7 +151,11 @@
 
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
+extern void do_gettimeofday_ns(struct timespec *tv);
 extern void do_settimeofday(struct timeval *tv);
+extern void do_settimeofday_ns(struct timespec *tv);
+extern void do_gettime_sinceboot_ns(struct timespec *tv);
+extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 #endif
 
 #define FD_SETSIZE		__FD_SETSIZE
@@ -163,5 +181,25 @@
 	struct	timeval it_interval;	/* timer interval */
 	struct	timeval it_value;	/* current value */
 };
+
+
+/*
+ * The IDs of the various system clocks (for POSIX.1b interval timers).
+ */
+#define CLOCK_REALTIME		  0
+#define CLOCK_MONOTONIC	  1
+#define CLOCK_PROCESS_CPUTIME_ID 2
+#define CLOCK_THREAD_CPUTIME_ID	 3
+#define CLOCK_REALTIME_HR	 4
+#define CLOCK_MONOTONIC_HR	  5
+
+#define MAX_CLOCKS 6
+
+/*
+ * The various flags for setting POSIX.1b interval timers.
+ */
+
+#define TIMER_ABSTIME 0x01
+
 
 #endif
diff -X dontdiff -urN linux-2.5.48.orig/include/linux/types.h linux-2.5.48/include/linux/types.h
--- linux-2.5.48.orig/include/linux/types.h	Mon Nov 18 10:15:06 2002
+++ linux-2.5.48/include/linux/types.h	Mon Nov 18 09:49:35 2002
@@ -23,6 +23,8 @@
 typedef __kernel_daddr_t	daddr_t;
 typedef __kernel_key_t		key_t;
 typedef __kernel_suseconds_t	suseconds_t;
+typedef __kernel_timer_t	timer_t;
+typedef __kernel_clockid_t	clockid_t;
 
 #ifdef __KERNEL__
 typedef __kernel_uid32_t	uid_t;
diff -X dontdiff -urN linux-2.5.48.orig/kernel/Makefile linux-2.5.48/kernel/Makefile
--- linux-2.5.48.orig/kernel/Makefile	Mon Nov 18 10:17:34 2002
+++ linux-2.5.48/kernel/Makefile	Mon Nov 18 09:51:48 2002
@@ -10,7 +10,7 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o \
-	    rcupdate.o intermodule.o
+	    rcupdate.o intermodule.o posix-timers.o id2ptr.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -X dontdiff -urN linux-2.5.48.orig/kernel/exit.c linux-2.5.48/kernel/exit.c
--- linux-2.5.48.orig/kernel/exit.c	Mon Nov 18 10:17:34 2002
+++ linux-2.5.48/kernel/exit.c	Mon Nov 18 09:49:35 2002
@@ -660,6 +660,7 @@
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_namespace(tsk);
+	exit_itimers(tsk, 1);
 	exit_thread();
 
 	if (current->leader)
diff -X dontdiff -urN linux-2.5.48.orig/kernel/fork.c linux-2.5.48/kernel/fork.c
--- linux-2.5.48.orig/kernel/fork.c	Mon Nov 18 10:17:34 2002
+++ linux-2.5.48/kernel/fork.c	Mon Nov 18 09:49:35 2002
@@ -815,6 +815,13 @@
 		goto bad_fork_cleanup_files;
 	if (copy_sighand(clone_flags, p))
 		goto bad_fork_cleanup_fs;
+	INIT_LIST_HEAD(&p->posix_timers);
+	p->nanosleep_tmr.it_v.it_interval.tv_sec = 0;
+	p->nanosleep_tmr.it_v.it_interval.tv_nsec = 0;
+	p->nanosleep_tmr.it_process = p;
+	p->nanosleep_tmr.it_type = NANOSLEEP;
+	p->nanosleep_tmr.it_pq = 0;
+	p->nanosleep_restart = RESTART_NONE;
 	if (copy_mm(clone_flags, p))
 		goto bad_fork_cleanup_sighand;
 	if (copy_namespace(clone_flags, p))
diff -X dontdiff -urN linux-2.5.48.orig/kernel/id2ptr.c linux-2.5.48/kernel/id2ptr.c
--- linux-2.5.48.orig/kernel/id2ptr.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.48/kernel/id2ptr.c	Mon Nov 18 09:49:35 2002
@@ -0,0 +1,225 @@
+/*
+ * linux/kernel/id2ptr.c
+ *
+ * 2002-10-18  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Small id to pointer translation service.  
+ *
+ * It uses a radix tree like structure as a sparse array indexed 
+ * by the id to obtain the pointer.  A bit map is included in each
+ * level of the tree which identifies portions of the tree which
+ * are completely full.  This makes the process of allocating a
+ * new id quick.
+ */
+
+
+#include <linux/slab.h>
+#include <linux/id2ptr.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+static kmem_cache_t *id_layer_cache;
+spinlock_t id_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * Since we can't allocate memory with spinlock held and dropping the
+ * lock to allocate gets ugly keep a free list which will satisfy the
+ * worst case allocation.
+ */
+
+struct id_layer *id_free;
+int id_free_cnt;
+
+static inline struct id_layer *alloc_layer(void)
+{
+	struct id_layer *p;
+
+	if (!(p = id_free))
+		BUG();
+	id_free = p->ary[0];
+	id_free_cnt--;
+	p->ary[0] = 0;
+	return(p);
+}
+
+static inline void free_layer(struct id_layer *p)
+{
+	p->ary[0] = id_free;
+	id_free = p;
+	id_free_cnt++;
+}
+
+/*
+ * Lookup the kernel pointer associated with a user supplied 
+ * id value.
+ */
+void *id2ptr_lookup(struct id *idp, int id)
+{
+	int n;
+	struct id_layer *p;
+
+	if (id <= 0)
+		return(NULL);
+	id--;
+	spin_lock_irq(&id_lock);
+	n = idp->layers * ID_BITS;
+	p = idp->top;
+	if (id >= (1 << n)) {
+		spin_unlock_irq(&id_lock);
+		return(NULL);
+	}
+
+	while (n > 0 && p) {
+		n -= ID_BITS;
+		p = p->ary[(id >> n) & ID_MASK];
+	}
+	spin_unlock_irq(&id_lock);
+	return((void *)p);
+}
+
+static int sub_alloc(struct id_layer *p, int shift, int id, void *ptr)
+{
+	int n = (id >> shift) & ID_MASK;
+	int bitmap = p->bitmap;
+	int id_base = id & ~((1 << (shift+ID_BITS))-1);
+	int v;
+	
+	for ( ; n <= ID_MASK; n++, id = id_base + (n << shift)) {
+		if (bitmap & (1 << n))
+			continue;
+		if (shift == 0) {
+			p->ary[n] = (struct id_layer *)ptr;
+			p->bitmap |= 1<<n;
+			return(id);
+		}
+		if (!p->ary[n])
+			p->ary[n] = alloc_layer();
+		if ((v = sub_alloc(p->ary[n], shift-ID_BITS, id, ptr))) {
+			update_bitmap(p, n);
+			return(v);
+		}
+	}
+	return(0);
+}
+
+/*
+ * Allocate a new id associate the value ptr with this new id.
+ */
+int id2ptr_new(struct id *idp, void *ptr)
+{
+	int n, last, id, v;
+	struct id_layer *new;
+	
+	spin_lock_irq(&id_lock);
+	n = idp->layers * ID_BITS;
+	last = idp->last;
+	while (id_free_cnt < n+1) {
+		spin_unlock_irq(&id_lock);
+		/* If the allocation fails giveup. */
+		if (!(new = kmem_cache_alloc(id_layer_cache, GFP_KERNEL)))
+			return(0);
+		spin_lock_irq(&id_lock);
+		memset(new, 0, sizeof(struct id_layer));
+		free_layer(new);
+	}
+	/*
+	 * Add a new layer if the array is full or the last id
+	 * was at the limit and we don't want to wrap.
+	 */
+	if ((last == ((1 << n)-1) && last < idp->min_wrap) ||
+		idp->count == (1 << n)) {
+		++idp->layers;
+		n += ID_BITS;
+		new = alloc_layer();
+		new->ary[0] = idp->top;
+		idp->top = new;
+		update_bitmap(new, 0);
+	}
+	if (last >= ((1 << n)-1))
+		last = 0;
+
+	/*
+	 * Search for a free id starting after last id allocated.
+	 * If that fails wrap back to start.
+	 */
+	id = last+1;
+	if (!(v = sub_alloc(idp->top, n-ID_BITS, id, ptr)))
+		v = sub_alloc(idp->top, n-ID_BITS, 1, ptr);
+	idp->last = v;
+	idp->count++;
+	spin_unlock_irq(&id_lock);
+	return(v+1);
+}
+
+
+static int sub_remove(struct id_layer *p, int shift, int id)
+{
+	int n = (id >> shift) & ID_MASK;
+	int i, bitmap, rv;
+	
+	rv = 0;
+	bitmap = p->bitmap & ~(1<<n);
+	p->bitmap = bitmap;
+	if (shift == 0) {
+		p->ary[n] = NULL;
+		rv = !bitmap;
+	} else {
+		if (sub_remove(p->ary[n], shift-ID_BITS, id)) {
+			free_layer(p->ary[n]);
+			p->ary[n] = 0;
+			for (i = 0; i < (1 << ID_BITS); i++)
+				if (p->ary[i])
+					break;
+			if (i == (1 << ID_BITS))
+				rv = 1;
+		}
+	}
+	return(rv);
+}
+
+/*
+ * Remove (free) an id value and break the association with
+ * the kernel pointer.
+ */
+void id2ptr_remove(struct id *idp, int id)
+{
+	struct id_layer *p;
+
+	if (id <= 0)
+		return;
+	id--;
+	spin_lock_irq(&id_lock);
+	sub_remove(idp->top, (idp->layers-1)*ID_BITS, id);
+	idp->count--;
+	if (id_free_cnt >= ID_FREE_MAX) {
+		
+		p = alloc_layer();
+		spin_unlock_irq(&id_lock);
+		kmem_cache_free(id_layer_cache, p);
+		return;
+	}
+	spin_unlock_irq(&id_lock);
+}
+
+void init_id_cache(void)
+{
+	if (!id_layer_cache)
+		id_layer_cache = kmem_cache_create("id_layer_cache", 
+			sizeof(struct id_layer), 0, 0, 0, 0);
+}
+
+void id2ptr_init(struct id *idp, int min_wrap)
+{
+	init_id_cache();
+	idp->count = 1;
+	idp->last = 0;
+	idp->layers = 1;
+	idp->top = kmem_cache_alloc(id_layer_cache, GFP_KERNEL);
+	memset(idp->top, 0, sizeof(struct id_layer));
+	idp->top->bitmap = 0;
+	idp->min_wrap = min_wrap;
+}
+
+__initcall(init_id_cache);
diff -X dontdiff -urN linux-2.5.48.orig/kernel/posix-timers.c linux-2.5.48/kernel/posix-timers.c
--- linux-2.5.48.orig/kernel/posix-timers.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.48/kernel/posix-timers.c	Mon Nov 18 09:49:35 2002
@@ -0,0 +1,1230 @@
+/*
+ * linux/kernel/posix_timers.c
+ *
+ * 
+ * 2002-10-15  Posix Clocks & timers by George Anzinger
+ *			     Copyright (C) 2002 by MontaVista Software.
+ *
+ * 2002-10-18  changes by Jim Houston jim.houston@attbi.com
+ *	Copyright (C) 2002 by Concurrent Computer Corp.
+ *
+ *	     -	Add a separate queue for posix timers.  Its a 
+ *		priority queue implemented as a sorted doubly
+ * 		linked list & a rbtree as an index into the list.
+ *	     -	Use a slab cache to allocate the timer structures.
+ *	     -	Allocate timer ids using my new id allocator.
+ *		This avoids the immediate reuse of timer ids.
+ *	     -  Uses seconds and nano-seconds rather than
+ *		jiffies and sub_jiffies.
+ *
+ * 	This is an experimental change.  I'm sending it out to
+ *	the mailing list in the hope that it will stimulate 
+ *	discussion.
+ */
+
+/* These are all the functions necessary to implement 
+ * POSIX clocks & timers
+ */
+
+#include <linux/mm.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/nmi.h>
+#include <linux/compiler.h>
+#include <linux/id2ptr.h>
+#include <linux/rbtree.h>
+#include <linux/posix-timers.h>
+#include <linux/sysctl.h>
+#include <asm/div64.h>
+
+#define MAXLOG 0x1000
+struct log {
+	long	flag;
+	long	tsc;
+	long	a, b;
+} mylog[MAXLOG];
+int myoffset;
+
+void logit(long flag, long a, long b)
+{
+	register unsigned long eax, edx;
+	int i;
+
+	i = myoffset;
+	myoffset = (i+1) % (MAXLOG-1);
+	rdtsc(eax,edx);
+	mylog[i].flag = flag << 16 | edx;
+	mylog[i].tsc = eax;
+	mylog[i].a = a;
+	mylog[i].b = b;
+}
+
+extern long get_eip(void *);
+
+/*
+ * Lets keep our timers in a slab cache :-)
+ */
+static kmem_cache_t *posix_timers_cache;
+struct id posix_timers_id;
+int posix_timers_ready;
+
+/*
+ * This lock protects the timer queues it is held for the
+ * duration of the timer expiry process.
+ */
+spinlock_t posix_timers_lock = SPIN_LOCK_UNLOCKED;
+
+struct k_clock clock_realtime = {
+	.res = NSEC_PER_SEC/HZ,
+};
+
+struct k_clock clock_monotonic = {
+	.res= NSEC_PER_SEC/HZ,
+	.clock_get = do_posix_clock_monotonic_gettime, 
+	.clock_set = do_posix_clock_monotonic_settime
+};
+
+
+/*
+ * The following parameters are set through sysctl or
+ * using the files in /proc/sys/kernel/posix-timers directory.
+ */
+static int posix_timers_res = 1000;	/* resolution for posix timers */
+static int nanosleep_res = 1000000;	/* resolution for nanosleep */
+
+/*
+ * These parameters limit the timer interrupt load if the 
+ * timers are over commited.  
+ */
+static int max_expiries = 20;		/* Maximum timers to expire from */
+					/* a single timer interrupt */
+static int recovery_time = 100000;	/* Recovery time used if we hit the */						/* timer expiry limit above. */
+static int min_delay = 10000;		/* Minimum delay before next timer */
+					/* interrupt in nanoseconds.*/
+
+
+static int min_posix_timers_res = 1000;
+static int max_posix_timers_res = 10000000;
+static int min_max_expiries = 5;
+static int max_max_expiries = 1000;
+static int min_recovery_time = 5000;
+static int max_recovery_time = 1000000;
+
+ctl_table posix_timers_table[] = {
+	{POSIX_TIMERS_RESOLUTION, "resolution", &posix_timers_res,
+	sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	&min_posix_timers_res, &max_posix_timers_res},
+	{POSIX_TIMERS_NANOSLEEP_RES, "nanosleep_res", &nanosleep_res,
+	sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	&min_posix_timers_res, &max_posix_timers_res},
+	{POSIX_TIMERS_MAX_EXPIRIES, "max_expiries", &max_expiries,
+	sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	&min_max_expiries, &max_max_expiries},
+	{POSIX_TIMERS_RECOVERY_TIME, "recovery_time", &recovery_time,
+	sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	&min_recovery_time, &max_recovery_time},
+	{POSIX_TIMERS_MIN_DELAY, "min_delay", &min_delay,
+	sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	&min_recovery_time, &max_recovery_time},
+	{0}
+};
+
+extern void set_APIC_timer(int);
+static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
+
+/*
+ * Setup hardware timer for fractional tick delay.  This is called
+ * when a new timer is inserted at the front of the priority queue.
+ * Since there are two queues and we don't look at both queues
+ * the hardware specific layer needs to read the timer and only
+ * set a new value if it is smaller than the current count.
+ */
+void set_hw_timer(struct k_clock *clock, struct k_itimer *timr)
+{
+	struct timespec ts;
+
+	do_posix_gettime(clock, &ts);
+	ts.tv_sec = timr->it_v.it_value.tv_sec - ts.tv_sec;
+	ts.tv_nsec = timr->it_v.it_value.tv_nsec - ts.tv_nsec;
+	if (ts.tv_nsec < 0) {
+		ts.tv_nsec += 1000000000;
+		ts.tv_sec--;
+	}
+	if (ts.tv_sec > 0 || ts.tv_nsec > (1000000000/HZ))
+		return;
+	if (ts.tv_sec < 0 || ts.tv_nsec < min_delay)
+		ts.tv_nsec = min_delay;
+	set_APIC_timer(ts.tv_nsec);
+}
+
+/*
+ * Insert a timer into a priority queue.  This is a sorted
+ * list of timers.  A rbtree is used to index the list.
+ */
+
+static int timer_insert_nolock(struct timer_pq *pq, struct k_itimer *t)
+{
+	struct rb_node ** p = &pq->rb_root.rb_node;
+	struct rb_node * parent = NULL;
+	struct k_itimer *cur;
+	struct list_head *prev;
+	prev = &pq->head;
+
+	if (t->it_pq)
+		BUG();
+	t->it_pq = pq;
+	while (*p) {
+		parent = *p;
+		cur = rb_entry(parent, struct k_itimer , it_pq_node);
+
+		/*
+		 * We allow non unique entries.  This works
+		 * but there might be opportunity to do something
+		 * clever.
+		 */
+		if (t->it_v.it_value.tv_sec < cur->it_v.it_value.tv_sec  ||
+			(t->it_v.it_value.tv_sec == cur->it_v.it_value.tv_sec &&
+			 t->it_v.it_value.tv_nsec < cur->it_v.it_value.tv_nsec))
+			p = &(*p)->rb_left;
+		else {
+			prev = &cur->it_pq_list;
+			p = &(*p)->rb_right;
+		}
+	}
+	/* link into rbtree. */
+	rb_link_node(&t->it_pq_node, parent, p);
+	rb_insert_color(&t->it_pq_node, &pq->rb_root);
+	/* link it into the list */
+	list_add(&t->it_pq_list, prev);
+	/*
+	 * We need to setup a timer interrupt if the new timer is
+	 * at the head of the queue.
+	 */
+	return(pq->head.next == &t->it_pq_list);
+}
+
+static inline void timer_remove_nolock(struct k_itimer *t)
+{
+	struct timer_pq *pq;
+
+	if (!(pq = t->it_pq))
+		return;
+	rb_erase(&t->it_pq_node, &pq->rb_root);
+	list_del(&t->it_pq_list);
+	t->it_pq = 0;
+}
+
+static void timer_remove(struct k_itimer *t)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&posix_timers_lock, flags);
+	timer_remove_nolock(t);
+	spin_unlock_irqrestore(&posix_timers_lock, flags);
+}
+
+
+static void timer_insert(struct k_clock *clock, struct k_itimer *t)
+{
+	unsigned long flags;
+	int rv, cpu;
+
+	cpu = get_cpu();
+	spin_lock_irqsave(&posix_timers_lock, flags);
+	rv = timer_insert_nolock(&clock->pq[cpu], t);
+	if (rv) 
+		set_hw_timer(clock, t);
+	spin_unlock_irqrestore(&posix_timers_lock, flags);
+	put_cpu();
+}
+
+/*
+ * If we are late delivering a periodic timer we may 
+ * have missed several expiries.  We want to calculate the 
+ * number we have missed both as the overrun count but also
+ * so that we can pick next expiry.
+ *
+ * You really need this if you schedule a high frequency timer
+ * and then make a big change to the current time.
+ */
+
+int handle_overrun(struct k_itimer *t, struct timespec dt)
+{
+	int ovr;
+#if 1
+	long long ldt, in;
+	long sec, nsec;
+
+	in =  (long long)t->it_v.it_interval.tv_sec*1000000000 +
+		t->it_v.it_interval.tv_nsec;
+	ldt = (long long)dt.tv_sec * 1000000000 + dt.tv_nsec;
+	/* scale ldt and in so that in fits in 32 bits. */
+	while (in > (1LL << 31)) {
+		in >>= 1;
+		ldt >>= 1;
+	}
+	/*
+	 * ovr = ldt/in + 1;
+	 * ldt = (long long)t->it_v.it_interval.tv_nsec * ovr;
+	 */
+	do_div(ldt, (long)in);
+	ldt++;
+	ovr = (long)ldt;
+	ldt *= t->it_v.it_interval.tv_nsec;
+	/*
+	 * nsec = ldt % 1000000000;
+	 * sec = ldt / 1000000000;
+	 */
+	nsec = do_div(ldt, 1000000000);
+	sec = (long)ldt;
+	sec += ovr * t->it_v.it_interval.tv_sec;
+	nsec += t->it_v.it_value.tv_nsec;
+	sec +=  t->it_v.it_value.tv_sec;
+	if (nsec > 1000000000) {
+		sec++;
+		nsec -= 1000000000;
+	}
+	t->it_v.it_value.tv_sec = sec;
+	t->it_v.it_value.tv_nsec = nsec;
+#else
+	/* Temporary hack */
+	ovr = 0;
+	while (dt.tv_sec > t->it_v.it_interval.tv_sec ||
+		(dt.tv_sec == t->it_v.it_interval.tv_sec && 
+		dt.tv_nsec > t->it_v.it_interval.tv_nsec)) {
+		dt.tv_sec -= t->it_v.it_interval.tv_sec;
+		dt.tv_nsec -= t->it_v.it_interval.tv_nsec;
+		if (dt.tv_nsec < 0) {
+			 dt.tv_sec--;
+			 dt.tv_nsec += 1000000000;
+		}
+		t->it_v.it_value.tv_sec += t->it_v.it_interval.tv_sec;
+		t->it_v.it_value.tv_nsec += t->it_v.it_interval.tv_nsec;
+		if (t->it_v.it_value.tv_nsec >= 1000000000) {
+			t->it_v.it_value.tv_sec++;
+			t->it_v.it_value.tv_nsec -= 1000000000;
+		}
+		ovr++;
+	}
+#endif
+	return(ovr);
+}
+
+int sending_signal_failed;
+
+static void timer_notify_task(struct k_itimer *timr, int ovr)
+{
+	struct siginfo info;
+	int ret;
+
+	timr->it_overrun_deferred = ovr-1;
+	if (! (timr->it_sigev_notify & SIGEV_NONE)) {
+		memset(&info, 0, sizeof(info));
+		/* Send signal to the process that owns this timer. */
+		info.si_signo = timr->it_sigev_signo;
+		info.si_errno = 0;
+		info.si_code = SI_TIMER;
+		info.si_tid = timr->it_id;
+		info.si_value = timr->it_sigev_value;
+		info.si_overrun = timr->it_overrun_deferred;
+		ret = send_sig_info(info.si_signo, &info, timr->it_process);
+		switch (ret) {
+		case 0:		/* all's well new signal queued */
+			timr->it_overrun_last = timr->it_overrun;
+			timr->it_overrun = timr->it_overrun_deferred;
+			break;
+		case 1:	/* signal from this timer was already in the queue */
+			timr->it_overrun += timr->it_overrun_deferred + 1;
+			break;
+		default:
+			sending_signal_failed++;
+			break;
+		}
+	}
+}
+
+/*
+ * Check if the timer at the head of the priority queue has 
+ * expired and handle the expiry.  Update the time in nsec till
+ * the next expiry.  We only really care about expiries
+ * before the next clock tick so we use a 32 bit int here.
+ */
+
+static int check_expiry(struct timer_pq *pq, struct timespec *tv,
+int *next_expiry, int *expiry_cnt, void *regs)
+{
+	struct k_itimer *t;
+	struct timespec dt;
+	int ovr;
+	long sec, nsec;
+	unsigned long flags;
+	int tick_expired = 0;
+	
+	ovr = 1;
+	spin_lock_irqsave(&posix_timers_lock, flags);
+	while (!list_empty(&pq->head)) {
+		t = list_entry(pq->head.next, struct k_itimer, it_pq_list);
+		dt.tv_sec = tv->tv_sec - t->it_v.it_value.tv_sec;
+		dt.tv_nsec = tv->tv_nsec - t->it_v.it_value.tv_nsec;
+		if (dt.tv_sec < 0 || (dt.tv_sec == 0 && dt.tv_nsec < 0)) {
+			/*
+			 * It has not expired yet.  Update the time
+			 * till the next expiry if it's less than a 
+			 * second.
+			 */
+			if (dt.tv_sec >= -1) {
+				nsec = dt.tv_sec ? 1000000000-dt.tv_nsec :
+					 -dt.tv_nsec;
+				if (nsec < *next_expiry)
+					*next_expiry = nsec;
+			}
+			spin_unlock_irqrestore(&posix_timers_lock, flags);
+			return(tick_expired);
+		}
+		/*
+		 * Its expired.  If this is a periodic timer we need to
+		 * setup for the next expiry.  We also check for overrun
+		 * here.  If the timer has already missed an expiry we want
+		 * deliver the overrun information and get back on schedule.
+		 */
+		if (dt.tv_nsec < 0) {
+			dt.tv_sec--;
+			dt.tv_nsec += 1000000000;
+		}
+if (dt.tv_sec || dt.tv_nsec > 50000) logit(8, dt.tv_nsec, get_eip(regs));
+		timer_remove_nolock(t);
+		if (t->it_v.it_interval.tv_sec || t->it_v.it_interval.tv_nsec) {
+			if (dt.tv_sec > t->it_v.it_interval.tv_sec ||
+			   (dt.tv_sec == t->it_v.it_interval.tv_sec && 
+			    dt.tv_nsec > t->it_v.it_interval.tv_nsec)) {
+				ovr = handle_overrun(t, dt);
+			} else {
+				nsec = t->it_v.it_value.tv_nsec +
+					t->it_v.it_interval.tv_nsec;
+				sec = t->it_v.it_value.tv_sec +
+					t->it_v.it_interval.tv_sec;
+				if (nsec > 1000000000) {
+					nsec -= 1000000000;
+					sec++;
+				}
+				t->it_v.it_value.tv_sec = sec;
+				t->it_v.it_value.tv_nsec = nsec;
+			}
+			/*
+			 * It might make sense to leave the timer queue and
+			 * avoid the remove/insert for timers which stay
+			 * at the front of the queue.
+			 */
+			timer_insert_nolock(pq, t);
+		}
+		switch (t->it_type) {
+		case TIMER:
+			timer_notify_task(t, ovr);
+			break;
+		case NANOSLEEP:
+			/*
+			 * If a clock_nanosleep is interrupted by a 
+			 * signal we leave the timer in the queue 
+			 * in case the nanosleep is restarted.
+			 * We only want the wakeup if we are blocked.
+			 */
+			if (t->it_process->nanosleep_restart == RESTART_NONE)
+				wake_up_process(t->it_process);
+			break;
+		case TICK:
+			tick_expired = 1;
+		}
+		/*
+		 * Limit the number of timers we expire from a 
+		 * single interrupt and allow a recovery time before
+		 * the next interrupt.
+		 */
+		if (++*expiry_cnt > max_expiries) {
+			*next_expiry = recovery_time;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&posix_timers_lock, flags);
+	return(tick_expired);
+}
+
+/*
+ * kluge?  We should know the offset between clock_realtime and
+ * clock_monotonic so we don't need to get the time twice.
+ */
+
+extern int system_running;
+
+int run_posix_timers(void *regs)
+{
+	struct timer_pq *pq;
+	struct timespec now;
+	int next_expiry, expiry_cnt, ret, cpu;
+
+	/*
+	 * hack alert!  We can't count on time to make sense during
+	 * start up.  If we are called from smp_local_timer_interrupt()
+	 * our return indicates if this is the real tick v.s. an extra
+	 * interrupt just for posix timers.  Without this check we
+	 * hang during boot.  
+	 */
+	if (!system_running) {
+		set_APIC_timer(1000000000/HZ);
+		return(1);
+	}
+	ret = 1;
+	cpu = get_cpu();
+	next_expiry = 1000000000/HZ;
+	expiry_cnt = 0;
+	pq = &clock_monotonic.pq[cpu];
+	if (!list_empty(&pq->head)) {
+		do_gettime_sinceboot_ns(&now);
+		ret = check_expiry(pq, &now, &next_expiry, &expiry_cnt, regs);
+	}
+
+	pq = &clock_realtime.pq[cpu];
+	if (!list_empty(&pq->head)) {
+		do_gettimeofday_ns(&now);
+		check_expiry(pq, &now, &next_expiry, &expiry_cnt, regs);
+	}
+if (!expiry_cnt) logit(7, next_expiry, 0);
+	if (next_expiry < min_delay)
+		next_expiry = min_delay;
+	set_APIC_timer(next_expiry);
+	put_cpu();
+	return ret;
+}
+	
+
+extern rwlock_t xtime_lock;
+
+/* 
+ * CLOCKs: The POSIX standard calls for a couple of clocks and allows us
+ *	    to implement others.  This structure defines the various
+ *	    clocks and allows the possibility of adding others.	 We
+ *	    provide an interface to add clocks to the table and expect
+ *	    the "arch" code to add at least one clock that is high
+ *	    resolution.	 Here we define the standard CLOCK_REALTIME as a
+ *	    1/HZ resolution clock.
+
+ * CPUTIME & THREAD_CPUTIME: We are not, at this time, definding these
+ *	    two clocks (and the other process related clocks (Std
+ *	    1003.1d-1999).  The way these should be supported, we think,
+ *	    is to use large negative numbers for the two clocks that are
+ *	    pinned to the executing process and to use -pid for clocks
+ *	    pinned to particular pids.	Calls which supported these clock
+ *	    ids would split early in the function.
+ 
+ * RESOLUTION: Clock resolution is used to round up timer and interval
+ *	    times, NOT to report clock times, which are reported with as
+ *	    much resolution as the system can muster.  In some cases this
+ *	    resolution may depend on the underlaying clock hardware and
+ *	    may not be quantifiable until run time, and only then is the
+ *	    necessary code is written.	The standard says we should say
+ *	    something about this issue in the documentation...
+
+ * FUNCTIONS: The CLOCKs structure defines possible functions to handle
+ *	    various clock functions.  For clocks that use the standard
+ *	    system timer code these entries should be NULL.  This will
+ *	    allow dispatch without the overhead of indirect function
+ *	    calls.  CLOCKS that depend on other sources (e.g. WWV or GPS)
+ *	    must supply functions here, even if the function just returns
+ *	    ENOSYS.  The standard POSIX timer management code assumes the
+ *	    following: 1.) The k_itimer struct (sched.h) is used for the
+ *	    timer.  2.) The list, it_lock, it_clock, it_id and it_process
+ *	    fields are not modified by timer code. 
+ *
+ * Permissions: It is assumed that the clock_settime() function defined
+ *	    for each clock will take care of permission checks.	 Some
+ *	    clocks may be set able by any user (i.e. local process
+ *	    clocks) others not.	 Currently the only set able clock we
+ *	    have is CLOCK_REALTIME and its high res counter part, both of
+ *	    which we beg off on and pass to do_sys_settimeofday().
+ */
+
+struct k_clock *posix_clocks[MAX_CLOCKS];
+
+#define if_clock_do(clock_fun, alt_fun,parms)	(! clock_fun)? alt_fun parms :\
+							      clock_fun parms
+
+#define p_timer_get( clock,a,b) if_clock_do((clock)->timer_get, \
+					     do_timer_gettime,	 \
+					     (a,b))
+
+#define p_nsleep( clock,a,b,c) if_clock_do((clock)->nsleep,   \
+					    do_nsleep,	       \
+					    (a,b,c))
+
+#define p_timer_del( clock,a) if_clock_do((clock)->timer_del, \
+					   do_timer_delete,    \
+					   (a))
+
+void register_posix_clock(int clock_id, struct k_clock * new_clock);
+
+
+
+void register_posix_clock(int clock_id,struct k_clock * new_clock)
+{
+	if ((unsigned)clock_id >= MAX_CLOCKS) {
+		printk("POSIX clock register failed for clock_id %d\n",clock_id);
+		return;
+	}
+	posix_clocks[clock_id] = new_clock;
+}
+
+static	 __init int init_posix_timers(void)
+{
+	struct k_itimer *t;
+	int i;
+
+	posix_timers_cache = kmem_cache_create("posix_timers_cache",
+		sizeof(struct k_itimer), 0, 0, 0, 0);
+	id2ptr_init(&posix_timers_id, 1000);
+
+	for (i = 0; i < NR_CPUS; i++) {
+		INIT_LIST_HEAD(&clock_realtime.pq[i].head);
+		clock_realtime.pq[i].rb_root = RB_ROOT;
+		INIT_LIST_HEAD(&clock_monotonic.pq[i].head);
+		clock_monotonic.pq[i].rb_root = RB_ROOT;
+		t = &clock_monotonic.tick[i];
+		t->it_v.it_value.tv_sec = 0;
+		t->it_v.it_value.tv_nsec = 0;
+		t->it_v.it_interval.tv_sec = 0;
+		t->it_v.it_interval.tv_nsec = 1000000000/HZ;
+		t->it_type = TICK;
+		timer_insert_nolock(&clock_monotonic.pq[i], t);
+	}
+	register_posix_clock(CLOCK_REALTIME,&clock_realtime);
+	register_posix_clock(CLOCK_MONOTONIC,&clock_monotonic);
+	posix_timers_ready = 1;
+	return 0;
+}
+
+__initcall(init_posix_timers);
+
+static struct task_struct * good_sigevent(sigevent_t *event)
+{
+	struct task_struct * rtn = current;
+
+	if (event->sigev_notify & SIGEV_THREAD_ID) {
+		if ( !(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
+		     rtn->tgid != current->tgid){
+			return NULL;
+		}
+	}
+	if (event->sigev_notify & SIGEV_SIGNAL) {
+		if ((unsigned)(event->sigev_signo > SIGRTMAX))
+			return NULL;
+	}
+	if (event->sigev_notify & ~(SIGEV_SIGNAL | SIGEV_THREAD_ID )) {
+		return NULL;
+	}
+	return rtn;
+}
+
+/* Create a POSIX.1b interval timer. */
+
+asmlinkage int
+sys_timer_create(clockid_t which_clock, struct sigevent *timer_event_spec,
+				timer_t *created_timer_id)
+{
+	int error = 0;
+	struct k_itimer *new_timer = NULL;
+	int id;
+	struct task_struct * process = 0;
+	sigevent_t event;
+
+	if ((unsigned)which_clock >= MAX_CLOCKS || !posix_clocks[which_clock])
+		return -EINVAL;
+
+	if (!(new_timer = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL)))
+		return -EAGAIN;
+	memset(new_timer, 0, sizeof(struct k_itimer));
+
+	if (!(id = id2ptr_new(&posix_timers_id, (void *)new_timer))) {
+		error = -EAGAIN;
+		goto out;
+	}
+	new_timer->it_id = id;
+	
+	if (copy_to_user(created_timer_id, &id, sizeof(id))) {
+		error = -EFAULT;
+		goto out;
+	}
+	spin_lock_init(&new_timer->it_lock);
+	if (timer_event_spec) {
+		if (copy_from_user(&event, timer_event_spec, sizeof(event))) {
+			error = -EFAULT;
+			goto out;
+		}
+		read_lock(&tasklist_lock);
+		if ((process = good_sigevent(&event))) {
+			/*
+			 * We may be setting up this timer for another
+			 * thread.  It may be exitiing.  To catch this
+			 * case the we clear posix_timers.next in 
+			 * exit_itimers.
+			 */
+			spin_lock(&process->alloc_lock);
+			if (process->posix_timers.next) {
+				list_add(&new_timer->it_task_list,
+					&process->posix_timers);
+				spin_unlock(&process->alloc_lock);
+			} else {
+				spin_unlock(&process->alloc_lock);
+				process = 0;
+			}
+		}
+		read_unlock(&tasklist_lock);
+		if (!process) {
+			error = -EINVAL;
+			goto out;
+		}
+		new_timer->it_sigev_notify = event.sigev_notify;
+		new_timer->it_sigev_signo = event.sigev_signo;
+		new_timer->it_sigev_value = event.sigev_value;
+	} else {
+		new_timer->it_sigev_notify = SIGEV_SIGNAL;
+		new_timer->it_sigev_signo = SIGALRM;
+		new_timer->it_sigev_value.sival_int = new_timer->it_id;
+		process = current;
+		spin_lock(&current->alloc_lock);
+		list_add(&new_timer->it_task_list, &current->posix_timers);
+		spin_unlock(&current->alloc_lock);
+	}
+	new_timer->it_clock = which_clock;
+	new_timer->it_overrun = 0;
+	new_timer->it_process = process;
+
+ out:
+	if (error) {
+		if (new_timer->it_id)
+			id2ptr_remove(&posix_timers_id, new_timer->it_id);
+		kmem_cache_free(posix_timers_cache, new_timer);
+	}
+	return error;
+}
+
+
+/*
+ * return  timer owned by the process, used by exit and exec
+ */
+void itimer_delete(struct k_itimer *timer)
+{
+	if (sys_timer_delete(timer->it_id)){
+		BUG();
+	}
+}
+
+/*
+ * This is call from both exec and exit to shutdown the
+ * timers.
+ */
+
+inline void exit_itimers(struct task_struct *tsk, int exit)
+{
+	struct	k_itimer *tmr;
+
+	if (!tsk->posix_timers.next)
+		return;
+	if (tsk->nanosleep_tmr.it_pq)
+		timer_remove(&tsk->nanosleep_tmr);
+	spin_lock(&tsk->alloc_lock);
+	while (tsk->posix_timers.next != &tsk->posix_timers){
+		spin_unlock(&tsk->alloc_lock);
+		 tmr = list_entry(tsk->posix_timers.next,struct k_itimer,
+			it_task_list);
+		itimer_delete(tmr);
+		spin_lock(&tsk->alloc_lock);
+	}
+	/*
+	 * sys_timer_create has the option to create a timer
+	 * for another thread.  There is the risk that as the timer
+	 * is being created that the thread that was supposed to handle
+	 * the signal is exiting.  We use the posix_timers.next field
+	 * as a flag so we can close this race.
+`	 */
+	if (exit)
+		tsk->posix_timers.next = 0;
+	spin_unlock(&tsk->alloc_lock);
+}
+
+/* good_timespec
+ *
+ * This function checks the elements of a timespec structure.
+ *
+ * Arguments:
+ * ts	     : Pointer to the timespec structure to check
+ *
+ * Return value:
+ * If a NULL pointer was passed in, or the tv_nsec field was less than 0 or
+ * greater than NSEC_PER_SEC, or the tv_sec field was less than 0, this
+ * function returns 0. Otherwise it returns 1.
+ */
+
+static int good_timespec(const struct timespec *ts)
+{
+	if ((ts == NULL) || 
+	    (ts->tv_sec < 0) ||
+	    ((unsigned)ts->tv_nsec >= NSEC_PER_SEC))
+		return 0;
+	return 1;
+}
+
+static inline void unlock_timer(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timr->it_lock);
+}
+
+static struct k_itimer* lock_timer( timer_t timer_id)
+{
+	struct  k_itimer *timr;
+
+	timr = (struct  k_itimer *)id2ptr_lookup(&posix_timers_id,
+		(int)timer_id);
+	if (timr)
+		spin_lock_irq(&timr->it_lock);
+	return(timr);
+}
+
+/* 
+ * Get the time remaining on a POSIX.1b interval timer.
+ * This function is ALWAYS called with spin_lock_irq on the timer, thus
+ * it must not mess with irq.
+ */
+void inline do_timer_gettime(struct k_itimer *timr,
+			     struct itimerspec *cur_setting)
+{
+	struct timespec ts;
+
+	do_posix_gettime(posix_clocks[timr->it_clock], &ts);
+	ts.tv_sec = timr->it_v.it_value.tv_sec - ts.tv_sec;
+	ts.tv_nsec = timr->it_v.it_value.tv_nsec - ts.tv_nsec;
+	if (ts.tv_nsec < 0) {
+		ts.tv_nsec += 1000000000;
+		ts.tv_sec--;
+	}
+	if (ts.tv_sec < 0)
+		ts.tv_sec = ts.tv_nsec = 0;
+	cur_setting->it_value = ts;
+	cur_setting->it_interval = timr->it_v.it_interval;
+}
+
+/* Get the time remaining on a POSIX.1b interval timer. */
+asmlinkage int sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
+{
+	struct k_itimer *timr;
+	struct itimerspec cur_setting;
+
+	timr = lock_timer(timer_id);
+	if (!timr) return -EINVAL;
+
+	p_timer_get(posix_clocks[timr->it_clock],timr, &cur_setting);
+
+	unlock_timer(timr);
+	
+	if (copy_to_user(setting, &cur_setting, sizeof(cur_setting)))
+		return -EFAULT;
+
+	return 0;
+}
+/*
+ * Get the number of overruns of a POSIX.1b interval timer
+ * This is a bit messy as we don't easily know where he is in the delivery
+ * of possible multiple signals.  We are to give him the overrun on the
+ * last delivery.  If we have another pending, we want to make sure we
+ * use the last and not the current.  If there is not another pending
+ * then he is current and gets the current overrun.  We search both the
+ * shared and local queue.
+ */
+
+asmlinkage int sys_timer_getoverrun(timer_t timer_id)
+{
+	struct k_itimer *timr;
+	int overrun, i;
+	struct sigqueue *q;
+	struct sigpending *sig_queue;
+	struct task_struct * t;
+
+	timr = lock_timer( timer_id);
+	if (!timr) return -EINVAL;
+
+	t = timr->it_process;
+	overrun = timr->it_overrun;
+	spin_lock_irq(&t->sig->siglock);
+	for (sig_queue = &t->sig->shared_pending, i = 2; i; 
+	     sig_queue = &t->pending, i--){
+		for (q = sig_queue->head; q; q = q->next) {
+			if ((q->info.si_code == SI_TIMER) &&
+			    (q->info.si_tid == timr->it_id)) {
+
+				overrun = timr->it_overrun_last;
+				goto out;
+			}
+		}
+	}
+ out:
+	spin_unlock_irq(&t->sig->siglock);
+	
+	unlock_timer(timr);
+
+	return overrun;
+}
+
+/*
+ * If it is relative time, we need to add the current  time to it to
+ * get the proper expiry time.
+ */
+static int  adjust_rel_time(struct k_clock *clock,struct timespec *tp)
+{
+	struct timespec now;
+
+
+	do_posix_gettime(clock,&now);
+	tp->tv_sec += now.tv_sec;
+	tp->tv_nsec += now.tv_nsec;
+	/* Normalize.  */
+	if (( tp->tv_nsec - NSEC_PER_SEC) >= 0){
+		tp->tv_nsec -= NSEC_PER_SEC;
+		tp->tv_sec++;
+	}
+	return 0;
+}
+
+/* Set a POSIX.1b interval timer. */
+/* timr->it_lock is taken. */
+static inline int do_timer_settime(struct k_itimer *timr, int flags,
+				   struct itimerspec *new_setting,
+				   struct itimerspec *old_setting)
+{
+	struct k_clock * clock = posix_clocks[timr->it_clock];
+
+	timer_remove(timr);
+	if (old_setting) {
+		do_timer_gettime(timr, old_setting);
+	}
+	
+	
+	/* switch off the timer when it_value is zero */
+	if ((new_setting->it_value.tv_sec == 0) &&
+		(new_setting->it_value.tv_nsec == 0)) {
+		timr->it_v = *new_setting;
+		return 0;
+	}
+
+	if (!(flags & TIMER_ABSTIME))
+		adjust_rel_time(clock, &new_setting->it_value);
+
+	timr->it_v = *new_setting;
+	timr->it_overrun_deferred = 
+		timr->it_overrun_last = 
+		timr->it_overrun = 0;
+	timer_insert(clock, timr);
+	return 0;
+}
+
+static inline void round_to_res(struct timespec *tp, int res)
+{
+	long nsec;
+
+	nsec = tp->tv_nsec;
+	nsec +=  res-1;
+	nsec -= nsec % res;
+	if (nsec > 1000000000) {
+		nsec -=1000000000;
+		tp->tv_sec++;
+	}
+	tp->tv_nsec = nsec;
+}
+
+
+/* Set a POSIX.1b interval timer */
+asmlinkage int sys_timer_settime(timer_t timer_id, int flags,
+				 const struct itimerspec *new_setting,
+				 struct itimerspec *old_setting)
+{
+	struct k_clock *clock;
+	struct k_itimer *timr;
+	struct itimerspec new_spec, old_spec;
+	int error = 0;
+	int res;
+	struct itimerspec *rtn = old_setting ? &old_spec : NULL;
+
+
+	if (new_setting == NULL) {
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&new_spec, new_setting, sizeof(new_spec))) {
+		return -EFAULT;
+	}
+
+	if ((!good_timespec(&new_spec.it_interval)) ||
+	    (!good_timespec(&new_spec.it_value))) {
+		return -EINVAL;
+	}
+
+	timr = lock_timer( timer_id);
+	if (!timr)
+		return -EINVAL;
+	clock = posix_clocks[timr->it_clock];
+#if 0
+	res = clock->res;
+#else
+	res = posix_timers_res;
+#endif
+	round_to_res(&new_spec.it_interval, res);
+	round_to_res(&new_spec.it_value, res);
+
+	if (!clock->timer_set)
+		error = do_timer_settime(timr, flags, &new_spec, rtn );
+	else
+		error = clock->timer_set(timr, flags, &new_spec, rtn );
+	unlock_timer(timr);
+
+	if (old_setting && ! error) {
+		if (copy_to_user(old_setting, &old_spec, sizeof(old_spec))) {
+			error = -EFAULT;
+		}
+	}
+
+	return error;
+}
+
+static inline int do_timer_delete(struct k_itimer  *timer)
+{
+	timer_remove(timer);
+	return 0;
+}
+
+/* Delete a POSIX.1b interval timer. */
+asmlinkage int sys_timer_delete(timer_t timer_id)
+{
+	struct k_itimer *timer;
+
+	timer = lock_timer( timer_id);
+	if (!timer)
+		return -EINVAL;
+
+	p_timer_del(posix_clocks[timer->it_clock],timer);
+
+	spin_lock(&timer->it_process->alloc_lock);
+	list_del(&timer->it_task_list);
+	spin_unlock(&timer->it_process->alloc_lock);
+
+	/*
+	 * This keeps any tasks waiting on the spin lock from thinking
+	 * they got something (see the lock code above).
+	 */
+	timer->it_process = NULL;
+	unlock_timer(timer);
+	if (timer->it_id)
+		id2ptr_remove(&posix_timers_id, timer->it_id);
+	kmem_cache_free(posix_timers_cache, timer);
+	return 0;
+}
+/*
+ * And now for the "clock" calls
+ * These functions are called both from timer functions (with the timer
+ * spin_lock_irq() held and from clock calls with no locking.	They must
+ * use the save flags versions of locks.
+ */
+static int do_posix_gettime(struct k_clock *clock, struct timespec *tp)
+{
+
+	if (clock->clock_get){
+		return clock->clock_get(tp);
+	}
+
+	do_gettimeofday_ns(tp);
+	return 0;
+}
+
+struct timespec monotonic_ts;
+unsigned long monotonic_tsc;
+extern unsigned long fast_gettimeoffset_quotient;
+
+int do_posix_clock_monotonic_gettime(struct timespec *tp)
+{
+	do_gettime_sinceboot_ns(tp);
+	return 0;
+}
+
+int do_posix_clock_monotonic_settime(struct timespec *tp)
+{
+	return -EINVAL;
+}
+
+asmlinkage int sys_clock_settime(clockid_t which_clock,const struct timespec *tp)
+{
+	struct timespec new_tp;
+
+	if ((unsigned)which_clock >= MAX_CLOCKS || !posix_clocks[which_clock])
+		return -EINVAL;
+	if (copy_from_user(&new_tp, tp, sizeof(*tp)))
+		return -EFAULT;
+	if ( posix_clocks[which_clock]->clock_set){
+		return posix_clocks[which_clock]->clock_set(&new_tp);
+	}
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+	do_settimeofday_ns(&new_tp);
+	return 0;
+}
+
+asmlinkage int sys_clock_gettime(clockid_t which_clock, struct timespec *tp)
+{
+	struct timespec rtn_tp;
+	int error = 0;
+	
+	if ((unsigned)which_clock >= MAX_CLOCKS || !posix_clocks[which_clock])
+		return -EINVAL;
+
+	error = do_posix_gettime(posix_clocks[which_clock],&rtn_tp);
+	 
+	if ( ! error) {
+		if (copy_to_user(tp, &rtn_tp, sizeof(rtn_tp))) {
+			error = -EFAULT;
+		}
+	}
+	return error;
+		 
+}
+asmlinkage int	 sys_clock_getres(clockid_t which_clock, struct timespec *tp)
+{
+	struct timespec rtn_tp;
+
+	if ((unsigned)which_clock >= MAX_CLOCKS || !posix_clocks[which_clock])
+		return -EINVAL;
+
+	rtn_tp.tv_sec = 0;
+	rtn_tp.tv_nsec = posix_clocks[which_clock]->res;
+	if ( tp){
+		if (copy_to_user(tp, &rtn_tp, sizeof(rtn_tp))) {
+			return -EFAULT;
+		}
+	}
+	return 0;
+	 
+}
+
+/*
+ * nanosleep is not supposed to leave early.  The problem is
+ * being woken by signals that are not delivered to the user.  Typically
+ * this means debug related signals.
+ *
+ * The solution is to leave the timer running and request that the system
+ * call be restarted.  The existing ERESTARTNOHAND mechanism is close to
+ * what we need, but it doesn't provide a way to tell if the system
+ * call has been restarted.  I have added ERESTARTNANOSLEEP which sets
+ * the current->nanosleep_restart flag before restarting the system call.
+ *
+ * Its unfortunate that the change to do_signal() means a per architecture
+ * change.  If this change is missing an interrupted nanosleep will 
+ * return an odd value - but the system will work.
+ */
+int do_clock_nanosleep(clockid_t which_clock, int flags, 
+const struct timespec *rqtp, struct timespec *rmtp, int from_nanosleep)
+{
+	struct timespec ts;
+	struct k_itimer *t;
+	struct k_clock *clock;
+	int active;
+	int res;
+
+	if ((unsigned)which_clock >= MAX_CLOCKS || !posix_clocks[which_clock])
+		return -EINVAL;
+	clock = posix_clocks[which_clock];
+	t = &current->nanosleep_tmr;
+	if (current->nanosleep_restart == RESTART_ACK) {
+		spin_lock_irqsave(&posix_timers_lock, flags);
+		current->nanosleep_restart = RESTART_NONE;
+		/* If the timer is still queue we setup to block. */
+		if (t->it_pq) {
+			current->state = TASK_INTERRUPTIBLE;
+			spin_unlock_irqrestore(&posix_timers_lock, flags);
+			goto restart;
+		}
+		spin_unlock_irqrestore(&posix_timers_lock, flags);
+		/* The timer has expired no need to sleep. */
+		return 0;
+	}
+	/*
+	 * The timer may still be active from a previous nanosleep
+	 * which was interrupted by a real signal, so stop it now.
+	 */
+	if (t->it_pq) 
+		timer_remove(t);
+	current->nanosleep_restart = RESTART_NONE;
+		
+	if(copy_from_user(&t->it_v.it_value, rqtp, sizeof(struct timespec)))
+		return -EFAULT;
+
+	if ((t->it_v.it_value.tv_nsec < 0) ||
+		(t->it_v.it_value.tv_nsec >= NSEC_PER_SEC) ||
+		(t->it_v.it_value.tv_sec < 0))
+		return -EINVAL;
+
+	if (!(flags & TIMER_ABSTIME))
+		adjust_rel_time(clock, &t->it_v.it_value);
+#if 0
+	/* These fields are now setup in fork.  */
+	t->it_v.it_interval.tv_sec = 0;
+	t->it_v.it_interval.tv_nsec = 0;
+	t->it_type = NANOSLEEP;
+	t->it_process = current;
+#endif
+	current->state = TASK_INTERRUPTIBLE;
+#if 0
+	res = clock->res;
+#else
+	res = from_nanosleep ? nanosleep_res : posix_timers_res;
+#endif
+	round_to_res(&t->it_v.it_value, res);
+	timer_insert(clock, t);
+restart:
+	schedule();
+	active = (t->it_pq != 0);
+	if (!(flags & TIMER_ABSTIME) && rmtp ) {
+		if (active) {
+			do_posix_gettime(clock, &ts);
+			ts.tv_sec = t->it_v.it_value.tv_sec - ts.tv_sec;
+			ts.tv_nsec = t->it_v.it_value.tv_nsec - ts.tv_nsec;
+			if (ts.tv_nsec < 0) {
+				ts.tv_nsec += 1000000000;
+				ts.tv_sec--;
+			}
+			if (ts.tv_sec < 0)
+				ts.tv_sec = ts.tv_nsec = 0;
+		} else {
+			ts.tv_sec = ts.tv_nsec  = 0;
+		}
+		if (copy_to_user(rmtp, &ts, sizeof(struct timespec)))
+			return -EFAULT;
+	}
+	if (active) {
+		/*
+		 * Leave the timer running we may restart this system
+		 * call.  If the signal is real, setting nanosleep_restart
+		 * will prevent the timer completion from doing an
+		 * unexpected wakeup.
+		 */
+		current->nanosleep_restart = RESTART_REQUEST;
+		return -ERESTARTNANOSLP;
+	}
+	return 0;
+}
+
+asmlinkage int 
+sys_clock_nanosleep(clockid_t which_clock, int flags,
+const struct timespec *rqtp, struct timespec *rmtp)
+{
+	return(do_clock_nanosleep(which_clock, flags, rqtp, rmtp, 0));
+}
diff -X dontdiff -urN linux-2.5.48.orig/kernel/signal.c linux-2.5.48/kernel/signal.c
--- linux-2.5.48.orig/kernel/signal.c	Mon Nov 18 10:17:10 2002
+++ linux-2.5.48/kernel/signal.c	Mon Nov 18 09:49:35 2002
@@ -426,8 +426,6 @@
 		if (!collect_signal(sig, pending, info))
 			sig = 0;
 				
-		/* XXX: Once POSIX.1b timers are in, if si_code == SI_TIMER,
-		   we need to xchg out the timer overrun values.  */
 	}
 	recalc_sigpending();
 
@@ -694,6 +692,7 @@
 specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t, int shared)
 {
 	int ret;
+	 struct sigpending *sig_queue;
 
 	if (!irqs_disabled())
 		BUG();
@@ -727,20 +726,43 @@
 	if (ignored_signal(sig, t))
 		goto out;
 
+	 sig_queue = shared ? &t->sig->shared_pending : &t->pending;
+
 #define LEGACY_QUEUE(sigptr, sig) \
 	(((sig) < SIGRTMIN) && sigismember(&(sigptr)->signal, (sig)))
-
+	 /*
+	  * Support queueing exactly one non-rt signal, so that we
+	  * can get more detailed information about the cause of
+	  * the signal.
+	  */
+	 if (LEGACY_QUEUE(sig_queue, sig))
+		 goto out;
+	 /*
+	  * In case of a POSIX timer generated signal you must check 
+	 * if a signal from this timer is already in the queue.
+	 * If that is true, the overrun count will be increased in
+	 * itimer.c:posix_timer_fn().
+	  */
+
+	if (((unsigned long)info > 1) && (info->si_code == SI_TIMER)) {
+		struct sigqueue *q;
+		for (q = sig_queue->head; q; q = q->next) {
+			if ((q->info.si_code == SI_TIMER) &&
+			    (q->info.si_tid == info->si_tid)) {
+				 q->info.si_overrun += info->si_overrun + 1;
+				/* 
+				  * this special ret value (1) is recognized
+				  * only by posix_timer_fn() in itimer.c
+				  */
+				ret = 1;
+				goto out;
+			}
+		}
+	}
 	if (!shared) {
-		/* Support queueing exactly one non-rt signal, so that we
-		   can get more detailed information about the cause of
-		   the signal. */
-		if (LEGACY_QUEUE(&t->pending, sig))
-			goto out;
 
 		ret = deliver_signal(sig, info, t);
 	} else {
-		if (LEGACY_QUEUE(&t->sig->shared_pending, sig))
-			goto out;
 		ret = send_signal(sig, info, &t->sig->shared_pending);
 	}
 out:
@@ -1434,8 +1456,9 @@
 		err |= __put_user(from->si_uid, &to->si_uid);
 		break;
 	case __SI_TIMER:
-		err |= __put_user(from->si_timer1, &to->si_timer1);
-		err |= __put_user(from->si_timer2, &to->si_timer2);
+		 err |= __put_user(from->si_tid, &to->si_tid);
+		 err |= __put_user(from->si_overrun, &to->si_overrun);
+		 err |= __put_user(from->si_ptr, &to->si_ptr);
 		break;
 	case __SI_POLL:
 		err |= __put_user(from->si_band, &to->si_band);
diff -X dontdiff -urN linux-2.5.48.orig/kernel/sysctl.c linux-2.5.48/kernel/sysctl.c
--- linux-2.5.48.orig/kernel/sysctl.c	Mon Nov 18 10:17:10 2002
+++ linux-2.5.48/kernel/sysctl.c	Mon Nov 18 09:49:35 2002
@@ -118,6 +118,7 @@
 static ctl_table debug_table[];
 static ctl_table dev_table[];
 extern ctl_table random_table[];
+extern ctl_table posix_timers_table[];
 
 /* /proc declarations: */
 
@@ -157,6 +158,7 @@
 	{0}
 };
 
+
 static ctl_table kern_table[] = {
 	{KERN_OSTYPE, "ostype", system_utsname.sysname, 64,
 	 0444, NULL, &proc_doutsstring, &sysctl_string},
@@ -259,6 +261,7 @@
 #endif
 	{KERN_PIDMAX, "pid_max", &pid_max, sizeof (int),
 	 0600, NULL, &proc_dointvec},
+	{KERN_POSIX_TIMERS, "posix-timers", NULL, 0, 0555, posix_timers_table},
 	{0}
 };
 
diff -X dontdiff -urN linux-2.5.48.orig/kernel/timer.c linux-2.5.48/kernel/timer.c
--- linux-2.5.48.orig/kernel/timer.c	Mon Nov 18 10:17:34 2002
+++ linux-2.5.48/kernel/timer.c	Mon Nov 18 09:49:35 2002
@@ -48,12 +48,12 @@
 	struct list_head vec[TVR_SIZE];
 } tvec_root_t;
 
-typedef struct timer_list timer_t;
+typedef struct timer_list tmr_t;
 
 struct tvec_t_base_s {
 	spinlock_t lock;
 	unsigned long timer_jiffies;
-	timer_t *running_timer;
+	tmr_t *running_timer;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -66,7 +66,7 @@
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
-static void check_timer_failed(timer_t *timer)
+static void check_timer_failed(tmr_t *timer)
 {
 	static int whine_count;
 	if (whine_count < 16) {
@@ -84,13 +84,13 @@
 	timer->magic = TIMER_MAGIC;
 }
 
-static inline void check_timer(timer_t *timer)
+static inline void check_timer(tmr_t *timer)
 {
 	if (timer->magic != TIMER_MAGIC)
 		check_timer_failed(timer);
 }
 
-static inline void internal_add_timer(tvec_base_t *base, timer_t *timer)
+static inline void internal_add_timer(tvec_base_t *base, tmr_t *timer)
 {
 	unsigned long expires = timer->expires;
 	unsigned long idx = expires - base->timer_jiffies;
@@ -142,7 +142,7 @@
  * Timers with an ->expired field in the past will be executed in the next
  * timer tick. It's illegal to add an already pending timer.
  */
-void add_timer(timer_t *timer)
+void add_timer(tmr_t *timer)
 {
 	int cpu = get_cpu();
 	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
@@ -200,7 +200,7 @@
  * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
  * active timer returns 1.)
  */
-int mod_timer(timer_t *timer, unsigned long expires)
+int mod_timer(tmr_t *timer, unsigned long expires)
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
@@ -277,7 +277,7 @@
  * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
  * active timer returns 1.)
  */
-int del_timer(timer_t *timer)
+int del_timer(tmr_t *timer)
 {
 	unsigned long flags;
 	tvec_base_t *base;
@@ -316,7 +316,7 @@
  *
  * The function returns whether it has deactivated a pending timer or not.
  */
-int del_timer_sync(timer_t *timer)
+int del_timer_sync(tmr_t *timer)
 {
 	tvec_base_t *base;
 	int i, ret = 0;
@@ -359,9 +359,9 @@
 	 * detach them individually, just clear the list afterwards.
 	 */
 	while (curr != head) {
-		timer_t *tmp;
+		tmr_t *tmp;
 
-		tmp = list_entry(curr, timer_t, entry);
+		tmp = list_entry(curr, tmr_t, entry);
 		if (tmp->base != base)
 			BUG();
 		next = curr->next;
@@ -400,9 +400,9 @@
 		if (curr != head) {
 			void (*fn)(unsigned long);
 			unsigned long data;
-			timer_t *timer;
+			tmr_t *timer;
 
-			timer = list_entry(curr, timer_t, entry);
+			timer = list_entry(curr, tmr_t, entry);
  			fn = timer->function;
  			data = timer->data;
 
@@ -438,6 +438,7 @@
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));
+struct timespec ytime __attribute__ ((aligned (16)));
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
@@ -609,6 +610,12 @@
 	    time_adjust -= time_adjust_step;
 	}
 	xtime.tv_nsec += tick_nsec + time_adjust_step * 1000;
+	/* time since boot too */
+	ytime.tv_nsec += tick_nsec + time_adjust_step * 1000;
+	if (ytime.tv_nsec > 1000000000) {
+		ytime.tv_nsec -= 1000000000;
+		ytime.tv_sec++;
+	}
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.
@@ -968,7 +975,7 @@
  */
 signed long schedule_timeout(signed long timeout)
 {
-	timer_t timer;
+	tmr_t timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -1024,6 +1031,22 @@
 	return current->pid;
 }
 
+#define NANOSLEEP_USE_CLOCK_NANOSLEEP 1
+#ifdef NANOSLEEP_USE_CLOCK_NANOSLEEP
+/*
+ * nanosleep is no supposed to return early if it is interrupted
+ * by a signal which is not delivered to the process.  This is 
+ * fixed in clock_nanosleep so lets use it.
+ */
+extern int do_clock_nanosleep(clockid_t which_clock, int flags, 
+const struct timespec *rqtp, struct timespec *rmtp, int from_nanosleep);
+
+asmlinkage long
+sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+{
+	return(do_clock_nanosleep(CLOCK_REALTIME, 0, rqtp, rmtp, 1));
+}
+#else 
 asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
 {
 	struct timespec t;
@@ -1050,6 +1073,7 @@
 	}
 	return 0;
 }
+#endif
 
 /*
  * sys_sysinfo - fill in sysinfo struct
