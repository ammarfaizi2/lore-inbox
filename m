Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264833AbSJaKtK>; Thu, 31 Oct 2002 05:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264831AbSJaKtK>; Thu, 31 Oct 2002 05:49:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:18173 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264841AbSJaKrs>;
	Thu, 31 Oct 2002 05:47:48 -0500
Message-ID: <3DC10BC1.F1EC35C6@mvista.com>
Date: Thu, 31 Oct 2002 02:53:53 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 10
References: <3DB9A314.6CECA1AC@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------6B4E38D7BF3C7ADF52D3D0DA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------6B4E38D7BF3C7ADF52D3D0DA
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


This patch adds the two POSIX clocks CLOCK_REALTIME_HR and
CLOCK_MONOTONIC_HR to the posix clocks & timers package.  A
small change is made in sched.h and the rest of the patch is
against .../kernel/posix_timers.c.

Concerns and on going work:

The kernel interface to the signal delivery code and it's
need for &regs causes the nanosleep and clock_nanosleep code
to be very messy.  The supplied interface works for the x86
platform and provides the hooks for other platforms to
connect (see .../include/asm-i386/signal.h for details), but
a much cleaner solution is desired.

This patch guards against overload by limiting the repeat
interval of timers to a fixed value (currently 0.5 ms).  A
suggested change, and one I am working on, is to not put the
timer back in the timer list until the user's signal handler
has completed processing the current expiry.  This requires
a call back from the signal completion code, again a
platform dependent thing, BUT it has the advantage of
automatically adjusting the interval to match the hardware,
the system overhead and the current load.  In all cases, the
standard says we need to account for the overruns, but by
not getting the timer interrupt code involved in useless
spinning, we just bump the overrun, saving a LOT of
overhead.

This patch fixes the high resolution timer resolution at 1
micro second.  Should this number be a CONFIG option?

I think it would be a "good thing"=AE to move the NTP stuff to
the jiffies clock.  This would allow the wall clock/ jiffies
clock difference to be a "fixed value" so that code that
needed this would not have to read two clocks.  Setting the
wall clock would then just be an adjustment to this "fixed
value".  It would also eliminate the problem of asking for a
wall clock offset and getting a jiffies clock offset.  This
issue is what causes the current 2.5.44 system to fail the
simple:

time sleep 60

test (any value less than 60 seconds violates the standard
in that it implies a timer expired early).

Patch is against 2.5.45

These patches as well as the POSIX clocks & timers patch are
available on the project site:
http://sourceforge.net/projects/high-res-timers/

The 3 parts to the high res timers are:
 core           The core kernel (i.e. platform independent)
changes
 i386           The high-res changes for the i386 (x86)
platform
*posixhr        The changes to the POSIX clocks & timers
patch to
use high-res timers

Please apply.
-- =

George Anzinger   george@mvista.com
High-res-timers: =

http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------6B4E38D7BF3C7ADF52D3D0DA
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-hrposix-2.5.45-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-hrposix-2.5.45-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.45-i386/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-2.5.45-i386/arch/i386/Kconfig	Thu Oct 31 00:00:56 2002
+++ linux/arch/i386/Kconfig	Thu Oct 31 01:35:03 2002
@@ -315,6 +315,98 @@
 
 	  If you don't know what to do here, say N.
 
+config HIGH_RES_TIMERS
+	bool "Configure High-Resolution-Timers"
+	help
+	  POSIX timers are available by default.  This option enables
+	  high resolution POSIX timers.  With this option the resolution
+	  is at least 1 micro second.  High resolution is not free.  If
+	  enabled this option will add a small overhead each time a
+	  timer expires that is not on a 1/HZ tick boundry.  If no such
+	  timers are used the overhead is nil.
+
+	  This option enables two additional POSIX CLOCKS,
+	  CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR.  Note that this
+	  option does not change the resolution of CLOCK_REALTIME or
+	  CLOCK_MONOTONIC which remain at 1/HZ resolution.
+
+choice
+	prompt "Clock source?"
+	default HIGH_RES_TIMER_TSC
+	help 
+	  This option allows you to choose the wall clock timer for your
+	  system.  With high resolution timers on the x86 platforms it
+	  is best to keep the interrupt generating timer separate from
+	  the time keeping timer.  On x86 platforms there are three
+	  possible sources implemented for the wall clock.  These are:
+ 
+  	  <timer>				<resolution>
+ 	  ACPI power management (pm) timer	~280 nano seconds
+  	  TSC (Time Stamp Counter)		1/CPU clock
+ 	  PIT (Programmable Interrupt Timer)	~838 nano seconds
+
+	  The PIT is used to generate interrupts and at any given time
+	  will be programmed to interrupt when the next timer is to
+	  expire or on the next 1/HZ tick.  For this reason it is best
+	  to not use this timer as the wall clock timer.  This timer has
+	  a resolution of 838 nano seconds.  THIS OPTION SHOULD ONLY BE
+	  USED IF BOTH ACPI AND TSC ARE NOT AVAILABLE.
+
+	  The TSC runs at the cpu clock rate (i.e. its resolution is
+	  1/CPU clock) and it has a very low access time.  However, it
+	  is subject, in some (incorrect) processors, to throttling to
+	  cool the cpu, and to other slow downs during power management.
+	  If your cpu is correct and does not change the TSC frequency
+	  for throttling or power management this is the best clock
+	  timer.
+
+	  The ACPI pm timer is available on systems with Advanced
+	  Configuration and Power Interface support.  The pm timer is
+	  available on these systems even if you don't use or enable
+	  ACPI in the software or the BIOS (but see Default ACPI pm
+	  timer address).  The timer has a resolution of about 280
+	  nanoseconds, however, the access time is a bit higher that
+	  that of the TSC.  Since it is part of ACPI it is intended to
+	  keep track of time while the system is under power management,
+	  thus it is not subject to the problems of the TSC.
+
+	  If you enable the ACPI pm timer and it can not be found, it is
+	  possible that your BIOS is not producing the ACPI table or
+	  that your machine does not support ACPI.  In the former case,
+	  see "Default ACPI pm timer address".  If the timer is not
+	  found the boot will fail when trying to calibrate the delay
+	  timer.
+
+config HIGH_RES_TIMER_ACPI_PM
+	bool "ACPI-pm-timer"
+	
+config HIGH_RES_TIMER_TSC
+	bool "Time-stamp-counter/TSC"
+	depends on X86_TSC
+
+config HIGH_RES_TIMER_PIT
+	bool "Programable-interrupt-timer/PIT"
+	  
+endchoice	  
+
+config HIGH_RES_TIMER_ACPI_PM_ADD
+	int "Default ACPI pm timer address"
+	depends on HIGH_RES_TIMER_ACPI_PM
+	default 0
+	help
+	  This option is available for use on systems where the BIOS
+	  does not generate the ACPI tables if ACPI is not enabled.  For
+	  example some BIOSes will not generate the ACPI tables if APM
+	  is enabled.  The ACPI pm timer is still available but can not
+	  be found by the software.  This option allows you to supply
+	  the needed address.  When the high resolution timers code
+	  finds a valid ACPI pm timer address it reports it in the boot
+	  messages log (look for lines that begin with
+	  "High-res-timers:").  You can turn on the ACPI support in the
+	  BIOS, boot the system and find this value.  You can then enter
+	  it at configure time.  Both the report and the entry are in
+	  decimal.
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
@@ -1613,7 +1705,7 @@
 	  somewhat, as all symbols have to be loaded into the kernel image.
 
 config KGDB
-	bool 'Include kgdb kernel debugger' 
+	bool "Include kgdb kernel debugger" 
 	depends on DEBUG_KERNEL
 	help  
 	  If you say Y here, the system will be compiled with the debug
@@ -1634,7 +1726,7 @@
 
 choice
 	depends on KGDB
-    	prompt 'Debug serial port BAUD' 
+    	prompt "Debug serial port BAUD" 
 	default KGDB_115200BAUD
 	help  
 	  Gdb and the kernel stub need to agree on the baud rate to be
@@ -1782,7 +1874,7 @@
 	  serial driver to be configured.
 
 config KGDB_SYSRQ
-	bool "Turn on SysRq "G" command to do a break?"
+	bool "Turn on SysRq 'G' command to do a break?"
 	depends on KGDB
 	default y
 	help
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.45-i386/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.45-i386/include/linux/sched.h	Thu Oct 31 00:02:24 2002
+++ linux/include/linux/sched.h	Thu Oct 31 00:29:23 2002
@@ -281,6 +281,9 @@
 	int it_sigev_signo;		 /* signo word of sigevent struct */
 	sigval_t it_sigev_value;	 /* value word of sigevent struct */
 	unsigned long it_incr;		/* interval specified in jiffies */
+#ifdef CONFIG_HIGH_RES_TIMERS
+        int it_sub_incr;                /* sub jiffie part of interval */
+#endif
 	struct task_struct *it_process;	/* process to send signal to */
 	struct timer_list it_timer;
 };
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.45-i386/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.45-i386/kernel/posix-timers.c	Thu Oct 31 00:28:57 2002
+++ linux/kernel/posix-timers.c	Thu Oct 31 00:29:25 2002
@@ -23,6 +23,7 @@
 #include <linux/posix-timers.h>
 #include <linux/compiler.h>
 #include <linux/id_reuse.h>
+#include <linux/hrtime.h>
 
 #ifndef div_long_long_rem
 #include <asm/div64.h>
@@ -33,7 +34,7 @@
 		       result; })
 
 #endif	 /* ifndef div_long_long_rem */
-
+#define CONFIGURE_MIN_INTERVAL 500000
 /*
  * Management arrays for POSIX timers.	 Timers are kept in slab memory
  * Timer ids are allocated by an external routine that keeps track of the
@@ -156,6 +157,7 @@
 
 int do_posix_clock_monotonic_settime(struct timespec *tp);
 
+IF_HIGH_RES(static int high_res_guard = 0;)
 /* 
  * Initialize everything, well, just everything in Posix clocks/timers ;)
  */
@@ -174,6 +176,15 @@
 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 		sizeof(struct k_itimer), 0, 0, 0, 0);
 	idr_init(&posix_timers_id);
+	IF_HIGH_RES(clock_realtime.res = CONFIG_HIGH_RES_RESOLUTION;
+		    register_posix_clock(CLOCK_REALTIME_HR,&clock_realtime);
+		    clock_monotonic.res = CONFIG_HIGH_RES_RESOLUTION;
+		    register_posix_clock(CLOCK_MONOTONIC_HR,&clock_monotonic);
+		    high_res_guard = nsec_to_arch_cycles(CONFIGURE_MIN_INTERVAL);
+		);
+#ifdef	 final_clock_init
+	final_clock_init();	  // defined by arch header file
+#endif
 	return 0;
 }
 
@@ -214,8 +225,23 @@
 	 * We trust that the optimizer will use the remainder from the 
 	 * above div in the following operation as long as they are close. 
 	 */
-	return	0;
+	return	 (nsec_to_arch_cycles(nsec % (NSEC_PER_SEC / HZ)));
+}
+#ifdef CONFIG_HIGH_RES_TIMERS
+static void tstotimer(struct itimerspec * time, struct k_itimer * timer)
+{
+	int res = posix_clocks[timer->it_clock].res;
+
+	timer->it_timer.sub_expires = tstojiffie(&time->it_value,
+						 res,
+						 &timer->it_timer.expires);
+	timer->it_sub_incr = tstojiffie(&time->it_interval,
+					res,
+					(unsigned long*) &timer->it_incr);
+	if ((unsigned long)timer->it_incr > MAX_JIFFY_OFFSET)
+		timer->it_incr = MAX_JIFFY_OFFSET;
 }
+#else
 static void tstotimer(struct itimerspec * time, struct k_itimer * timer)
 {
 	int res = posix_clocks[timer->it_clock].res;
@@ -228,6 +254,7 @@
 }
  
 
+#endif
 
 /* PRECONDITION:
  * timr->it_lock must be locked
@@ -265,6 +292,47 @@
 	}
 }
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+/*
+ * This bit of code is to protect the system from being consumed by
+ * repeating timer expirations.	 We detect overrun and adjust the
+ * next time to be at least high_res_guard out. We clock the overrun
+ * but only AFTER the next expire as it has not really happened yet.
+ *
+ * Careful, only do this if the timer repeat time is less than
+ * high_res_guard AND we have fallen behind.
+
+ * All this will go away with signal delivery callback...
+ */
+
+static inline void  do_overrun_protect(struct k_itimer *timr)
+{
+	timr->it_overrun_deferred = 0;
+
+	if (! timr->it_incr &&
+	    (high_res_guard > timr->it_sub_incr)){
+		int offset = quick_update_jiffies_sub( timr->it_timer.expires);
+
+		offset -= timr->it_timer.sub_expires;
+		// touch_nmi_watchdog();
+		offset += high_res_guard;
+		if (offset <= 0){
+			return;
+		}
+		// expire time is in the past (or within the guard window)
+
+		timr->it_overrun_deferred = (offset / timr->it_sub_incr) - 1;
+		timr->it_timer.sub_expires += 
+			offset - (offset % timr->it_sub_incr);
+				     
+		while ((timr->it_timer.sub_expires -  cycles_per_jiffies) >= 0){
+			timr->it_timer.sub_expires -= cycles_per_jiffies;
+			timr->it_timer.expires++;
+		}
+	}
+}
+
+#endif
 /* 
  * Notify the task and set up the timer for the next expiration (if applicable).
  * This function requires that the k_itimer structure it_lock is taken.
@@ -277,7 +345,8 @@
 
 	/* Set up the timer for the next interval (if there is one) */
 	if ((interval = timr->it_incr) == 0){
-		{
+		IF_HIGH_RES(if(timr->it_sub_incr == 0)
+			){
 			set_timer_inactive(timr);
 			return;
 		}
@@ -285,6 +354,13 @@
 	if (interval > (unsigned long) LONG_MAX)
 		interval = LONG_MAX;
 	timr->it_timer.expires += interval;
+	IF_HIGH_RES(timr->it_timer.sub_expires += timr->it_sub_incr;
+		    if ((timr->it_timer.sub_expires - cycles_per_jiffies) >= 0){
+			    timr->it_timer.sub_expires -= cycles_per_jiffies;
+			    timr->it_timer.expires++;
+		    }
+		    do_overrun_protect(timr);
+		);
 	add_timer(&timr->it_timer);
 }
 
@@ -543,17 +619,39 @@
 
 	do {
 		expires = timr->it_timer.expires;  
+		IF_HIGH_RES(sub_expires = timr->it_timer.sub_expires);
 	} while ((volatile long)(timr->it_timer.expires) != expires);
 
+	IF_HIGH_RES(write_lock(&xtime_lock);
+		    update_jiffies_sub());
 	if (expires && timer_pending(&timr->it_timer)){
 		expires -= jiffies;
+		IF_HIGH_RES(sub_expires -=  sub_jiffie());
 	}else{
 		sub_expires = expires = 0;
 	}
+	IF_HIGH_RES( write_unlock(&xtime_lock));
 
 	jiffies_to_timespec(expires, &cur_setting->it_value);
 	jiffies_to_timespec(timr->it_incr, &cur_setting->it_interval);
 
+	IF_HIGH_RES(cur_setting->it_value.tv_nsec += 
+		    arch_cycles_to_nsec( sub_expires);
+		    if (cur_setting->it_value.tv_nsec < 0){
+			    cur_setting->it_value.tv_nsec += NSEC_PER_SEC;
+			    cur_setting->it_value.tv_sec--;
+		    }
+		    if ((cur_setting->it_value.tv_nsec - NSEC_PER_SEC) >= 0){
+			    cur_setting->it_value.tv_nsec -= NSEC_PER_SEC;
+			    cur_setting->it_value.tv_sec++;
+		    }
+		    cur_setting->it_interval.tv_nsec += 
+		    arch_cycles_to_nsec(timr->it_sub_incr);
+		    if ((cur_setting->it_interval.tv_nsec - NSEC_PER_SEC) >= 0){
+			    cur_setting->it_interval.tv_nsec -= NSEC_PER_SEC;
+			    cur_setting->it_interval.tv_sec++;
+		    }
+		);	     
 	if (cur_setting->it_value.tv_sec < 0){
 		cur_setting->it_value.tv_nsec = 1;
 		cur_setting->it_value.tv_sec = 0;
@@ -699,6 +797,7 @@
 
 	/* disable the timer */
 	timr->it_incr = 0;
+	IF_HIGH_RES(timr->it_sub_incr = 0);
 	/* 
 	 * careful here.  If smp we could be in the "fire" routine which will
 	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
@@ -723,6 +822,7 @@
 	if ((new_setting->it_value.tv_sec == 0) &&
 	    (new_setting->it_value.tv_nsec == 0)) {
 		timr->it_timer.expires = 0;
+		IF_HIGH_RES(timr->it_timer.sub_expires = 0 );
 		return 0;
 	}
 
@@ -743,10 +843,12 @@
 	 * For some reason the timer does not fire immediately if expires is
 	 * equal to jiffies, so the timer callback function is called directly.
 	 */
+#ifndef	 CONFIG_HIGH_RES_TIMERS
 	if (timr->it_timer.expires == jiffies) {
 		posix_timer_fire(timr);
 		return 0;
 	}
+#endif
 	timr->it_overrun_deferred = 
 		timr->it_overrun_last = 
 		timr->it_overrun = 0;
@@ -808,6 +910,7 @@
 static inline int do_timer_delete(struct k_itimer  *timer)
 {
 	timer->it_incr = 0;
+	IF_HIGH_RES(timer->it_sub_incr = 0);
 #ifdef CONFIG_SMP
 	if ( timer_active(timer) && ! del_timer(&timer->it_timer)){
 		/*
@@ -905,8 +1008,25 @@
 		return clock->clock_get(tp);
 	}
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+	{
+		unsigned long flags;
+		write_lock_irqsave(&xtime_lock, flags);
+		update_jiffies_sub();
+		update_real_wall_time();  
+		tp->tv_sec = xtime.tv_sec;
+		tp->tv_nsec = xtime.tv_nsec;
+		tp->tv_nsec += arch_cycles_to_nsec(sub_jiffie());
+		write_unlock_irqrestore(&xtime_lock, flags);
+		if ( tp->tv_nsec >  NSEC_PER_SEC ){
+			tp->tv_nsec -= NSEC_PER_SEC ;
+			tp->tv_sec++;
+		}
+	}
+#else
 	do_gettimeofday((struct timeval*)tp);
 	tp->tv_nsec *= NSEC_PER_USEC;
+#endif
 	return 0;
 }
 
@@ -921,8 +1041,9 @@
 {
 	long sub_sec;
 	u64 jiffies_64_f;
+	IF_HIGH_RES(long sub_jiff_offset;)
 
-#if (BITS_PER_LONG > 32) 
+#if (BITS_PER_LONG > 32) && !defined(CONFIG_HIGH_RES_TIMERS)
 
 	jiffies_64_f = jiffies_64;
 
@@ -936,6 +1057,8 @@
 		read_lock_irqsave(&xtime_lock, flags);
 		jiffies_64_f = jiffies_64;
 
+		IF_HIGH_RES(sub_jiff_offset =	
+			    quick_update_jiffies_sub(jiffies));
 
 		read_unlock_irqrestore(&xtime_lock, flags);
 	}
@@ -944,14 +1067,34 @@
 	do {
 		jiffies_f = jiffies;
 		barrier();
+		IF_HIGH_RES(
+			sub_jiff_offset = 
+			quick_update_jiffies_sub(jiffies_f));
 		jiffies_64_f = jiffies_64;
 	} while (unlikely(jiffies_f != jiffies));
 
+#else /* 64 bit long and high-res but no SMP if I did the Venn right */
+	do {
+		jiffies_64_f = jiffies_64;
+		barrier();
+		sub_jiff_offset = quick_update_jiffies_sub(jiffies_64_f);
+	} while (unlikely(jiffies_64_f != jiffies_64));
 
 #endif
-	tp->tv_sec = div_long_long_rem(jiffies_64_f,HZ,&sub_sec);
+	/*
+	 * Remember that quick_update_jiffies_sub() can return more
+	 * than a jiffies worth of cycles...
+	 */
+	IF_HIGH_RES(
+		while ( unlikely(sub_jiff_offset > cycles_per_jiffies)){
+			sub_jiff_offset -= cycles_per_jiffies;
+			jiffies_64_f++;
+		}
+		)
+		tp->tv_sec = div_long_long_rem(jiffies_64_f,HZ,&sub_sec);
 
 	tp->tv_nsec = sub_sec * (NSEC_PER_SEC / HZ);
+	IF_HIGH_RES(tp->tv_nsec += arch_cycles_to_nsec(sub_jiff_offset));
 	return 0;
 }
 
@@ -1110,6 +1253,7 @@
 			 * del_timer_sync() will return 0, thus
 			 * active is zero... and so it goes.
 			 */
+			IF_HIGH_RES(new_timer.sub_expires = )
 
 				tstojiffie(&t,
 					   posix_clocks[which_clock].res,
@@ -1131,9 +1275,15 @@
 	}
 	if (active && rmtp ) {
 		unsigned long jiffies_f = jiffies;
+		IF_HIGH_RES(
+			long sub_jiff = 
+			quick_update_jiffies_sub(jiffies_f));
 
 		jiffies_to_timespec(new_timer.expires - jiffies_f, &t);
 
+		IF_HIGH_RES(t.tv_nsec += 
+			    arch_cycles_to_nsec(new_timer.sub_expires -
+						sub_jiff));
 		while (t.tv_nsec < 0){
 			t.tv_nsec += NSEC_PER_SEC;
 			t.tv_sec--;
Binary files linux-2.5.45-i386/scripts/fixdep and linux/scripts/fixdep differ
Binary files linux-2.5.45-i386/scripts/lxdialog/lxdialog and linux/scripts/lxdialog/lxdialog differ

--------------6B4E38D7BF3C7ADF52D3D0DA--

