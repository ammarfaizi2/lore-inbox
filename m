Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267723AbTAIAGL>; Wed, 8 Jan 2003 19:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbTAIAGK>; Wed, 8 Jan 2003 19:06:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:57071 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267723AbTAIAEV>;
	Wed, 8 Jan 2003 19:04:21 -0500
Message-ID: <3E1CB046.BBBD8CEB@mvista.com>
Date: Wed, 08 Jan 2003 15:12:06 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 1/3] High-res-timers part 1 (core) take 24
Content-Type: multipart/mixed;
 boundary="------------F3E1AC0966E221011A4A4BF2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------F3E1AC0966E221011A4A4BF2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Just in case you might like high res timers...

Now for 2.5.54-bk6

Changes since last time:
Fixed patch rejection on kernel make file.
-----------
Update the kernel base.
--------
Added stub macros to include/linux/hrtime.h to handle the no
high res case.  This was causing undefines when building a
kernel with CONFIG_HIGH_RES = n.

Removed the SMP optimization in timer.c (folks objected to
eliminating unneeded spin locks in favor of letting the
compiler do it).
-------
This patch supplies the core changes to implement high
resolution timers.  Mostly it changes the timer list from
the multi stage hash (or cascade) list to a single stage
hash list.  This change makes it easy to configure the list
size for those who are concerned with performance.  It also
eliminates the "time out" for the cascade operation every
512 jiffies, thus eliminating possibly long preemption
times.  On input from Stephen Hemminger<shemminger@osdl.org>
the configuration of the timer list size is no longer
presented as a configure option.  The code can still be
change (one line) to use larger or smaller lists.

It also adds a sub jiffie word to the timer structure to
allow timers to exist between jiffies.  However, to support
the sub jiffie timers, work needs to be done in the platform
code for each arch.  The platform work for the i386 arch
follows in part 2.  To prevent requests from
nonexistent code for sub jiffies stuff, these parts of this
patch are disabled with the IF_HIGH_RES() macro which
depends on CONFIG_HIGH_RES_TIMERS which will be defined for
each platform as they supply the needed code.

With this patch applied, the system should boot and run much
as it does prior to the patch.  This patch depends on the
POSIX clocks & timers patch in that it assumes the changes
that patch made to timer.c to remove timer_t.  This
dependency can be removed if needed.

This patch as well as the POSIX clocks & timers patch is
available on the project site:
http://sourceforge.net/projects/high-res-timers/

For those who want a change log, this version is changed
only to follow the changes in the posix patch, which, was
changed to use the new syscall restart stuff.

The 3 parts to the high res timers are:
*core		The core kernel (i.e. platform independent) changes
 i386		The high-res changes for the i386 (x86) platform
 hrposix	The changes to the POSIX clocks & timers patch to
use high-res timers

Please apply.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------F3E1AC0966E221011A4A4BF2
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-core-2.5.54-bk6-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-core-2.5.54-bk6-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-posix/include/linux/hrtime.h linux/include/linux/hrtime.h
--- linux-2.5.54-bk6-posix/include/linux/hrtime.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/hrtime.h	Wed Jan  8 13:40:50 2003
@@ -0,0 +1,155 @@
+#ifndef _HRTIME_H
+#define _HRTIME_H
+
+/*
+ * This file is the glue to bring in the platform stuff.
+ * We make it all depend on the CONFIG option so all archs
+ * will work as long as the CONFIG is not set.	Once an 
+ * arch defines the CONFIG, it had better have the 
+ * asm/hrtime.h file in place.
+ */
+
+/*
+ * This gets filled in at init time, either static or dynamic.
+ * Someday this will be what NTP fiddles with.
+ * Do we need the scale here?  I don't think so, as long as we
+ * do percentage offsets for NTP.
+ */
+struct timer_conversion_bits {
+	unsigned long _arch_to_usec;
+	unsigned long _arch_to_nsec;
+	unsigned long _usec_to_arch;
+	unsigned long _nsec_to_arch;
+	long _cycles_per_jiffies;
+	unsigned long _arch_to_latch;
+};
+extern struct timer_conversion_bits timer_conversion_bits;
+/*
+ * The following four values are not used for machines 
+ * without a TSC.  For machines with a TSC they
+ * are caculated at boot time. They are used to 
+ * calculate "cycles" to jiffies or usec.  Don't get
+ * confused into thinking they are simple multiples or
+ * divisors, however.  
+ */
+#define arch_to_usec timer_conversion_bits._arch_to_usec
+#define arch_to_nsec timer_conversion_bits._arch_to_nsec
+#define usec_to_arch timer_conversion_bits._usec_to_arch
+#define nsec_to_arch timer_conversion_bits._nsec_to_arch
+#define cycles_per_jiffies timer_conversion_bits._cycles_per_jiffies
+#define arch_to_latch timer_conversion_bits._arch_to_latch
+
+#include <linux/config.h>
+#ifdef CONFIG_HIGH_RES_TIMERS
+#include <asm/hrtime.h>
+/*
+ * The schedule_next_int function is to be defined by the "arch" code
+ * when an "arch" is implementing the high-res part of POSIX timers.
+ * The actual function will be called with the offset in "arch" (parm 2)
+ * defined sub_jiffie units from the reference jiffie boundry (parm 1)to
+ * the next required sub_jiffie timer interrupt. This value will be -1
+ * if the next timer interrupt should be the next jiffie value.	 The
+ * "arch" code must determine how far out the interrupt is, based on
+ * current jiffie, sub_jiffie time and set up the hardware to interrupt
+ * at that time.  It is possible that the time will already have passed,
+ * in which case the function should return true (no interrupt is
+ * needed), otherwise the return should be 0.  The third parameter is the
+ * "always" flag which says that the code needs an interrupt, even if the
+ * time has passed.  In this case a "close" in time should be used to 
+ * generate the required interrupt.  The sub_jiffie interrupt
+ * should just call do_timer(). If the interrupt code ususally does stuff
+ * each jiffie, a flag should be kept by the jiffies update code to
+ * indicate that a new jiffie has started.  This flag is to keep this code 
+ * from being executed on the sub jiffie interrupt.
+ */
+#ifndef schedule_next_int
+#define schedule_next_int(s,d,a) 0
+#undef CONFIG_HIGH_RES_TIMERS
+#endif				// schedule_next_int
+/*
+ * The sub_jiffie() macro should return the current time offset from the latest
+ * jiffie.  This will be in "arch" defined units and is used to determine if
+ * a timer has expired.	 Since no sub_expire value will be used if "arch" 
+ * has not defined the high-res package, 0 will work well here.
+ *
+ * In addition, to save time if there is no high-res package (or it is not
+ * configured), we define the sub expression for the run_timer_list.
+ */
+
+#ifndef sub_jiffie
+#undef CONFIG_HIGH_RES_TIMERS
+#define sub_jiffie() 0
+#endif				// sub_jiffie
+
+/*
+ * The high_res_test() macro should set up a test mode that will do a
+ * worst case timer interrupt.	I.e. it may be that a call to 
+ * schedule_next_int() could return -1 indicating that the time has
+ * already expired.  This macro says to set it so that schedule_next_int()
+ * will always set up a timer interrupt.  This is used during init to
+ * calculate the worst case loop time from timer set up to int to 
+ * the signal code.
+
+ * high_res_end_test() cancels the above state and allows the no
+ * interrupt return from schedule_next_int()
+ */
+#ifndef high_res_test
+#define high_res_test()
+#define high_res_end_test()
+#endif
+
+#define IF_HIGH_RES(a) a
+
+#else				/*  CONFIG_HIGH_RES_TIMERS */
+#define IF_HIGH_RES(a)
+#define nsec_to_arch_cycles(a) 0
+
+#define discipline_timer(cpu)
+#define compute_latch(calibration_result)
+#endif				/*  CONFIG_HIGH_RES_TIMERS */
+
+/*
+ * Here is an SMP helping macro...
+ */
+#ifdef CONFIG_SMP
+#define IF_SMP(a) a
+#else
+#define IF_SMP(a)
+#endif
+/*
+ * These should have been defined in the platform hrtimers.h
+ * If not (or HIGH_RES_TIMERS not configured) define the default.
+ */
+#ifndef update_jiffies
+extern u64 jiffies_64;
+#define update_jiffies() (*(u64 *)&jiffies_64)++
+#endif
+#ifndef new_jiffie
+#define new_jiffie() 0
+#endif
+#ifndef schedule_next_int
+#define schedule_next_int(a,b,c)
+#endif
+/*
+ * If we included a high-res file, we may have gotten a more efficient 
+ * u64/u32, u64%u32 routine.  The one in div64.h actually handles a 
+ * u64 result, something we don't need, and, since it is more expensive
+ * arch porters are encouraged to implement the div_long_long_rem().
+ *
+ * int div_long_long_rem(u64 dividend,int divisor,int* remainder)
+ * which returns dividend/divisor.
+ * 
+ * Here we provide default code for those who, for what ever reason,
+ * have not provided the above.
+ */
+#ifndef div_long_long_rem
+#include <asm/div64.h>
+
+#define div_long_long_rem(dividend,divisor,remainder) ({ \
+		       u64 result = dividend;		\
+		       *remainder = do_div(result,divisor); \
+		       result; })
+
+#endif				/* ifndef div_long_long_rem */
+
+#endif				/* _HRTIME_H  */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-posix/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.54-bk6-posix/include/linux/time.h	Wed Jan  8 13:36:27 2003
+++ linux/include/linux/time.h	Wed Jan  8 13:40:50 2003
@@ -1,7 +1,7 @@
 #ifndef _LINUX_TIME_H
 #define _LINUX_TIME_H
 
-#include <asm/param.h>
+#include <linux/param.h>
 #include <linux/types.h>
 
 #ifndef _STRUCT_TIMESPEC
@@ -53,6 +53,19 @@
 #define NSEC_PER_USEC (1000L)
 #endif
 
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
@@ -61,16 +74,16 @@
 
 	if (sec >= (MAX_JIFFY_OFFSET / HZ))
 		return MAX_JIFFY_OFFSET;
-	nsec += 1000000000L / HZ - 1;
-	nsec /= 1000000000L / HZ;
+	nsec += NSEC_PER_SEC / HZ - 1;
+	nsec /= NSEC_PER_SEC / HZ;
 	return HZ * sec + nsec;
 }
 
 static __inline__ void
-jiffies_to_timespec(unsigned long jiffies, struct timespec *value)
+jiffies_to_timespec(unsigned long _jiffies, struct timespec *value)
 {
-	value->tv_nsec = (jiffies % HZ) * (1000000000L / HZ);
-	value->tv_sec = jiffies / HZ;
+	value->tv_nsec = (_jiffies % HZ) * (NSEC_PER_SEC / HZ);
+	value->tv_sec = _jiffies / HZ;
 }
 
 /* Same for "timeval" */
@@ -171,9 +184,9 @@
 #define	ITIMER_VIRTUAL	1
 #define	ITIMER_PROF	2
 
-struct  itimerspec {
-        struct  timespec it_interval;    /* timer period */
-        struct  timespec it_value;       /* timer expiration */
+struct	itimerspec {
+	struct	timespec it_interval;	 /* timer period */
+	struct	timespec it_value;	 /* timer expiration */
 };
 
 struct	itimerval {
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-posix/include/linux/timer.h linux/include/linux/timer.h
--- linux-2.5.54-bk6-posix/include/linux/timer.h	Tue Nov 12 12:40:04 2002
+++ linux/include/linux/timer.h	Wed Jan  8 13:40:50 2003
@@ -18,6 +18,7 @@
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
+	long sub_expires;
 };
 
 #define TIMER_MAGIC	0x4b87ad6e
@@ -29,6 +30,7 @@
 		.base = NULL,					\
 		.magic = TIMER_MAGIC,				\
 		.lock = SPIN_LOCK_UNLOCKED,			\
+		.sub_expires = 0,			        \
 	}
 
 /***
@@ -41,6 +43,7 @@
 static inline void init_timer(struct timer_list * timer)
 {
 	timer->base = NULL;
+	timer->sub_expires = 0;
 	timer->magic = TIMER_MAGIC;
 	spin_lock_init(&timer->lock);
 }
@@ -64,6 +67,7 @@
 extern void add_timer_on(struct timer_list *timer, int cpu);
 extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
+extern void update_real_wall_time(void);
   
 #if CONFIG_SMP
   extern int del_timer_sync(struct timer_list * timer);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-posix/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.54-bk6-posix/kernel/ksyms.c	Thu Jan  2 12:17:16 2003
+++ linux/kernel/ksyms.c	Wed Jan  8 13:40:50 2003
@@ -56,6 +56,7 @@
 #include <linux/mount.h>
 #include <linux/ptrace.h>
 #include <asm/checksum.h>
+#include <linux/hrtime.h>
 
 #if defined(CONFIG_PROC_FS)
 #include <linux/proc_fs.h>
@@ -484,6 +485,9 @@
 #endif
 EXPORT_SYMBOL(jiffies);
 EXPORT_SYMBOL(jiffies_64);
+#ifdef CONFIG_HIGH_RES_TIMERS
+EXPORT_SYMBOL(timer_conversion_bits);
+#endif
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-posix/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.54-bk6-posix/kernel/timer.c	Wed Jan  8 13:36:27 2003
+++ linux/kernel/timer.c	Wed Jan  8 13:40:50 2003
@@ -17,6 +17,8 @@
  *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
  *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
  *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
+ *  2002-10-01	High res timers code by George Anzinger 
+ *		    Copyright (C)2002 by MontaVista Software.
  */
 
 #include <linux/kernel_stat.h>
@@ -27,38 +29,25 @@
 #include <linux/notifier.h>
 #include <linux/thread_info.h>
 
+#include <linux/hrtime.h>
+#include <linux/compiler.h>
+#include <asm/signal.h>
 #include <asm/uaccess.h>
 
+#ifndef CONFIG_NEW_TIMER_LISTSIZE
+#define CONFIG_NEW_TIMER_LISTSIZE 512
+#endif
+#define NEW_TVEC_SIZE CONFIG_NEW_TIMER_LISTSIZE
+#define NEW_TVEC_MASK (NEW_TVEC_SIZE - 1)
 /*
  * per-CPU timer vector definitions:
  */
-#define TVN_BITS 6
-#define TVR_BITS 8
-#define TVN_SIZE (1 << TVN_BITS)
-#define TVR_SIZE (1 << TVR_BITS)
-#define TVN_MASK (TVN_SIZE - 1)
-#define TVR_MASK (TVR_SIZE - 1)
-
-typedef struct tvec_s {
-	int index;
-	struct list_head vec[TVN_SIZE];
-} tvec_t;
-
-typedef struct tvec_root_s {
-	int index;
-	struct list_head vec[TVR_SIZE];
-} tvec_root_t;
-
 
 struct tvec_t_base_s {
 	spinlock_t lock;
 	unsigned long timer_jiffies;
-	struct timer_list *running_timer;
-	tvec_root_t tv1;
-	tvec_t tv2;
-	tvec_t tv3;
-	tvec_t tv4;
-	tvec_t tv5;
+ 	volatile struct timer_list * volatile running_timer;
+ 	struct list_head tv[NEW_TVEC_SIZE];
 } ____cacheline_aligned_in_smp;
 
 typedef struct tvec_t_base_s tvec_base_t;
@@ -90,42 +79,101 @@
 		check_timer_failed(timer);
 }
 
-static inline void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
-{
-	unsigned long expires = timer->expires;
-	unsigned long idx = expires - base->timer_jiffies;
-	struct list_head *vec;
-
-	if (idx < TVR_SIZE) {
-		int i = expires & TVR_MASK;
-		vec = base->tv1.vec + i;
-	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
-		int i = (expires >> TVR_BITS) & TVN_MASK;
-		vec = base->tv2.vec + i;
-	} else if (idx < 1 << (TVR_BITS + 2 * TVN_BITS)) {
-		int i = (expires >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
-		vec = base->tv3.vec + i;
-	} else if (idx < 1 << (TVR_BITS + 3 * TVN_BITS)) {
-		int i = (expires >> (TVR_BITS + 2 * TVN_BITS)) & TVN_MASK;
-		vec = base->tv4.vec + i;
-	} else if ((signed long) idx < 0) {
-		/*
-		 * Can happen if you add a timer with expires == jiffies,
-		 * or you set a timer to go off in the past
-		 */
-		vec = base->tv1.vec + base->tv1.index;
-	} else if (idx <= 0xffffffffUL) {
-		int i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
-		vec = base->tv5.vec + i;
-	} else {
-		/* Can only get here on architectures with 64-bit jiffies */
-		INIT_LIST_HEAD(&timer->entry);
-		return;
-	}
-	/*
-	 * Timers are FIFO:
-	 */
-	list_add_tail(&timer->entry, vec);
+static inline void internal_add_timer(tvec_base_t *base, 
+ 				      struct timer_list *timer)
+  {
+ 	/*
+ 	 * must be cli-ed when calling this
+ 	 */
+  	unsigned long expires = timer->expires;
+ 	IF_HIGH_RES(int sub_expires = timer->sub_expires;)
+ 		int indx;
+ 	struct list_head *pos,*list_start;
+  
+ 	if ( time_before(expires, base->timer_jiffies) ){
+ 		/*
+ 		 * already expired, schedule for next tick 
+ 		 * would like to do better here
+ 		 * Actually this now works just fine with the
+ 		 * back up of timer_jiffies in "run_timer_list".
+ 		 * Note that this puts the timer on a list other
+ 		 * than the one it idexes to.  We don't want to
+ 		 * change the expires value in the timer as it is
+ 		 * used by the repeat code in setitimer and the
+ 		 * POSIX timers code.
+ 			 */
+ 		expires = base->timer_jiffies;
+ 		IF_HIGH_RES(sub_expires = 0);
+ 	}
+ 			
+ 	indx =	expires & NEW_TVEC_MASK;
+ 	if ((expires - base->timer_jiffies) <= NEW_TVEC_SIZE) {
+#ifdef CONFIG_HIGH_RES_TIMERS
+ 		unsigned long jiffies_f;
+  		/*
+ 		 * The high diff bits are the same, goes to the head of 
+ 		 * the list, sort on sub_expire.
+  		 */
+ 		for (pos = (list_start = &base->tv[indx])->next; 
+ 		     pos != list_start; 
+ 		     pos = pos->next){
+ 			struct timer_list *tmr = 
+ 				list_entry(pos,
+ 					   struct timer_list,
+ 					   entry);
+ 			if ((tmr->sub_expires >= sub_expires) ||
+ 			    (tmr->expires != expires)){
+ 				break;
+ 			}
+ 		}
+ 		list_add_tail(&timer->entry, pos);
+ 		/*
+ 		 * Notes to me.	 Use jiffies here instead of 
+ 		 * timer_jiffies to prevent adding unneeded interrupts.
+ 		 * Running_timer is NULL if we are NOT currently 
+ 		 * activly dispatching timers.	Since we are under
+ 		 * the same spin lock, it being false means that 
+ 		 * it has dropped the spinlock to call the timer
+ 		 * function, which could well be who called us.
+ 		 * In any case, we don't need a new interrupt as
+ 		 * the timer dispach code (run_timer_list) will
+ 		 * pick this up when the function it is calling 
+ 		 * returns.
+ 		 */
+ 		if ( expires == (jiffies_f = base->timer_jiffies) && 
+ 		     list_start->next == &timer->entry &&
+ 		     (base->running_timer == NULL)) {
+ 			schedule_next_int(jiffies_f, sub_expires,1);
+ 		}
+#else
+ 		pos = (&base->tv[indx])->next;
+ 		list_add_tail(&timer->entry, pos);
+#endif
+ 	}else{
+ 		/*
+ 		 * The high diff bits differ, search from the tail
+ 		 * The for will pick up an empty list.
+ 		 */
+ 		for (pos = (list_start = &base->tv[indx])->prev; 
+ 		     pos != list_start; 
+ 		     pos = pos->prev){
+ 			struct timer_list *tmr = 
+ 				list_entry(pos,
+ 					   struct timer_list,
+ 					   entry);
+ 			if (time_after(tmr->expires, expires)){
+ 				continue;
+ 			}
+ 			IF_HIGH_RES(
+ 				if ((tmr->expires != expires) ||
+ 				    (tmr->sub_expires < sub_expires)) {
+ 					break;
+ 				}
+ 				);
+ 		}
+ 		list_add(&timer->entry, pos);
+ 	}
+ 				
 }
 
 /***
@@ -200,7 +248,14 @@
  * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
  * active timer returns 1.)
  */
-int mod_timer(struct timer_list *timer, unsigned long expires)
+#ifdef CONFIG_HIGH_RES_TIMERS
+int mod_timer_hr(struct timer_list *timer, 
+		 unsigned long expires, 
+		 long sub_expires)
+#else
+int mod_timer(struct timer_list *timer, 
+		 unsigned long expires)
+#endif
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
@@ -255,6 +310,7 @@
 		ret = 1;
 	}
 	timer->expires = expires;
+	IF_HIGH_RES(timer->sub_expires = sub_expires);
 	internal_add_timer(new_base, timer);
 	timer->base = new_base;
 
@@ -265,6 +321,12 @@
 
 	return ret;
 }
+#ifdef CONFIG_HIGH_RES_TIMERS
+int mod_timer(struct timer_list *timer, unsigned long expires)
+{
+	return mod_timer_hr(timer, expires, timer->sub_expires);
+}
+#endif
 
 /***
  * del_timer - deactive a timer.
@@ -347,55 +409,42 @@
 #endif
 
 
-static int cascade(tvec_base_t *base, tvec_t *tv)
-{
-	/* cascade all the timers from tv up one level */
-	struct list_head *head, *curr, *next;
-
-	head = tv->vec + tv->index;
-	curr = head->next;
-	/*
-	 * We are removing _all_ timers from the list, so we don't  have to
-	 * detach them individually, just clear the list afterwards.
-	 */
-	while (curr != head) {
-		struct timer_list *tmp;
-
-		tmp = list_entry(curr, struct timer_list, entry);
-		if (tmp->base != base)
-			BUG();
-		next = curr->next;
-		internal_add_timer(base, tmp);
-		curr = next;
-	}
-	INIT_LIST_HEAD(head);
-
-	return tv->index = (tv->index + 1) & TVN_MASK;
-}
-
-/***
- * __run_timers - run all expired timers (if any) on this CPU.
- * @base: the timer vector to be processed.
- *
- * This function cascades all vectors and executes all expired timer
- * vectors.
+/*
+ * run_timer_list is ALWAYS called from softirq which calls with irq enabled.
+ * We may assume this and not save the flags.
  */
-static inline void __run_timers(tvec_base_t *base)
+  
+  
+static void __run_timers(tvec_base_t *base)
 {
+	IF_HIGH_RES( unsigned long jiffies_f;
+		     long sub_jiff = -1;
+		     long sub_jiffie_f);
 	spin_lock_irq(&base->lock);
+#ifdef CONFIG_HIGH_RES_TIMERS
+	read_lock(&xtime_lock);
+	jiffies_f = jiffies;
+	sub_jiffie_f = sub_jiffie() + quick_get_cpuctr();
+	read_unlock(&xtime_lock);
+	while ( unlikely(sub_jiffie_f >= cycles_per_jiffies)){
+		sub_jiffie_f -= cycles_per_jiffies;
+		jiffies_f++;
+	}
+	while ((long)(jiffies_f - base->timer_jiffies) >= 0) {
+#else
 	while ((long)(jiffies - base->timer_jiffies) >= 0) {
+#endif
+ 
 		struct list_head *head, *curr;
-
+		head = base->tv + 
+			(base->timer_jiffies	& NEW_TVEC_MASK);
 		/*
-		 * Cascade timers:
+		 * Note that we never move "head" but continue to
+		 * pick the first entry from it.  This allows new
+		 * entries to be inserted while we unlock for the
+		 * function call below.
 		 */
-		if (!base->tv1.index &&
-			(cascade(base, &base->tv2) == 1) &&
-				(cascade(base, &base->tv3) == 1) &&
-					cascade(base, &base->tv4) == 1)
-			cascade(base, &base->tv5);
 repeat:
-		head = base->tv1.vec + base->tv1.index;
 		curr = head->next;
 		if (curr != head) {
 			void (*fn)(unsigned long);
@@ -403,28 +452,67 @@
 			struct timer_list *timer;
 
 			timer = list_entry(curr, struct timer_list, entry);
- 			fn = timer->function;
- 			data = timer->data;
-
-			list_del(&timer->entry);
-			timer->base = NULL;
-#if CONFIG_SMP
-			base->running_timer = timer;
+#ifdef CONFIG_HIGH_RES_TIMERS
+			/*
+			 * This would be simpler if we never got behind
+			 * i.e. if timer_jiffies == jiffies, we could
+			 * drop one of the tests.  Since we may get 
+			 * behind, (in fact we don't up date until
+			 * we are behind to allow sub_jiffie entries)
+			 * we need a way to negate the sub_jiffie
+			 * test in that case...
+			 */
+			if (time_before(timer->expires, jiffies_f)||
+			    ((timer->expires == jiffies_f) &&
+			     timer->sub_expires <= sub_jiffie_f))
+#else
+			if (time_before_eq(timer->expires, jiffies))
 #endif
-			spin_unlock_irq(&base->lock);
-			if (!fn)
-				printk("Bad: timer %p has NULL fn. (data: %08lx)\n", timer, data);
-			else
+				{fn = timer->function;
+				data= timer->data;
+
+				list_del(&timer->entry);
+				timer->base = NULL;
+				timer->entry.next = timer->entry.prev = NULL;
+				base->running_timer = timer;
+				spin_unlock_irq(&base->lock);
 				fn(data);
-			spin_lock_irq(&base->lock);
-			goto repeat;
+				spin_lock_irq(&base->lock);
+				goto repeat;
+			}
+#ifdef CONFIG_HIGH_RES_TIMERS
+			else{
+				/*
+				 * The new timer list is not always emptied
+				 * here as it contains:
+				 * a.) entries (list size)^N*jiffies out and
+				 * b.) entries that match in jiffies, but have
+				 *     sub_expire times further out than now.
+				 */
+				 if (timer->expires == jiffies_f ){
+					sub_jiff = timer->sub_expires;
+				}
+			}
+#endif
 		}
 		++base->timer_jiffies; 
-		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 	}
-#if CONFIG_SMP
+	/*
+	 * It is faster to back out the last bump, than to prevent it.
+	 * This allows zero time inserts as well as sub_jiffie values in
+	 * the current jiffie.
+	 */
+	--base->timer_jiffies;
 	base->running_timer = NULL;
-#endif
+
+	IF_HIGH_RES(if (schedule_next_int( jiffies_f, sub_jiff, 0)){
+		/*
+		 * If schedule_next_int says the time has passed
+		 * bump the tasklet lock so we go round again
+		 */
+		run_local_timers();
+		});
+
 	spin_unlock_irq(&base->lock);
 }
 
@@ -704,15 +792,37 @@
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
  * process.  user_tick is 1 if the tick is user time, 0 for system.
+ *
+ * Here is where we need to sort out the sub-jiffie interrupts from the 
+ * jiffie ones and make sure we only do accounting once per jiffie per cpu.
+ * We do this by using new_jiffie as a bit per cpu. All ops are atomic.
+ */
+/*
+ * This read-write spinlock protects us from races in SMP while
+ * playing with xtime and avenrun.
  */
+rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
+
 void update_process_times(int user_tick)
 {
 	struct task_struct *p = current;
 	int cpu = smp_processor_id(), system = user_tick ^ 1;
 
-	update_one_process(p, user_tick, system, cpu);
+	/*
+	 * always run the timer list to pick up sub-jiffie timers
+	 */
 	run_local_timers();
-	scheduler_tick(user_tick, system);
+
+	/* 
+         * If high-res, we come here more often that 1/HZ.  Don't pass
+	 * the extra calls to those who only want the 1/HZ call.
+         */
+#ifdef CONFIG_HIGH_RES_TIMERS
+	if (test_and_clear_bit(cpu, (volatile unsigned long *)&new_jiffie()))
+#endif	 
+	{	update_one_process(p, user_tick, system, cpu);
+		scheduler_tick(user_tick, system);
+	}
 }
 
 /*
@@ -731,35 +841,38 @@
  *
  * Requires xtime_lock to access.
  */
-unsigned long avenrun[3];
 
 /*
- * calc_load - given tick count, update the avenrun load estimates.
- * This is called while holding a write_lock on xtime_lock.
+ * calc_load - (runs on above timer), update the avenrun load estimates.
+ * This is called from soft_irq context, ints on, bh locked.
  */
-static inline void calc_load(unsigned long ticks)
+unsigned long avenrun[3];
+static inline void calc_load(void);
+
+struct timer_list calc_load_timer = {
+	.expires = LOAD_FREQ,
+	.function = (void (*)(unsigned long))calc_load,
+	.entry = {0,0} };
+				       
+static inline void calc_load(void)
 {
 	unsigned long active_tasks; /* fixed-point */
-	static int count = LOAD_FREQ;
 
-	count -= ticks;
-	if (count < 0) {
-		count += LOAD_FREQ;
-		active_tasks = count_active_tasks();
-		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
-		CALC_LOAD(avenrun[1], EXP_5, active_tasks);
-		CALC_LOAD(avenrun[2], EXP_15, active_tasks);
-	}
+	active_tasks = count_active_tasks();
+	write_lock_irq(&xtime_lock);
+	CALC_LOAD(avenrun[0], EXP_1, active_tasks);
+	CALC_LOAD(avenrun[1], EXP_5, active_tasks);
+	CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+	write_unlock_irq(&xtime_lock);
+
+	calc_load_timer.expires = jiffies + LOAD_FREQ;
+	add_timer(&calc_load_timer);
 }
 
+
 /* jiffies at the most recent update of wall time */
 unsigned long wall_jiffies;
 
-/*
- * This read-write spinlock protects us from races in SMP while
- * playing with xtime and avenrun.
- */
-rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
 unsigned long last_time_offset;
 
 /*
@@ -769,8 +882,7 @@
 {
 	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
 
-	if ((long)(jiffies - base->timer_jiffies) >= 0)
-		__run_timers(base);
+	__run_timers(base);
 }
 
 /*
@@ -795,8 +907,25 @@
 		update_wall_time(ticks);
 	}
 	last_time_offset = 0;
-	calc_load(ticks);
 }
+#ifdef CONFIG_HIGH_RES_TIMERS
+void update_real_wall_time(void)
+{
+	unsigned long ticks;
+       /*
+	 * To get the time of day really right, we need to make sure 
+	 * every one is on the same jiffie. (Because of adj_time, etc.)
+	 * So we provide this for the high res code.  Must be called 
+	 * under the write(xtime_lock).	 (External locking allows the
+	 * caller to include sub jiffies in the lock region.)
+	 */
+	ticks = jiffies - wall_jiffies;
+	if (ticks) {
+		wall_jiffies += ticks;
+		update_wall_time(ticks);
+	}
+}
+#endif
   
 /*
  * The 64-bit jiffies value is not atomic - you MUST NOT read it
@@ -806,10 +935,11 @@
 
 void do_timer(struct pt_regs *regs)
 {
-	jiffies_64++;
+	update_jiffies();
+	/* 
+	 * SMP process accounting uses the local APIC timer 
+	 */
 #ifndef CONFIG_SMP
-	/* SMP process accounting uses the local APIC timer */
-
 	update_process_times(user_mode(regs));
 #endif
 	update_times();
@@ -820,7 +950,7 @@
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
 /*
- * For backwards compatibility?  This can be done in libc so Alpha
+ * For backwards compatibility?	 This can be done in libc so Alpha
  * and all newer ports shouldn't need it.
  */
 asmlinkage unsigned long sys_alarm(unsigned int seconds)
@@ -928,7 +1058,7 @@
 asmlinkage long sys_getegid(void)
 {
 	/* Only we change this so SMP safe */
-	return  current->egid;
+	return	current->egid;
 }
 
 #endif
@@ -1160,14 +1290,8 @@
        
 	base = &per_cpu(tvec_bases, cpu);
 	spin_lock_init(&base->lock);
-	for (j = 0; j < TVN_SIZE; j++) {
-		INIT_LIST_HEAD(base->tv5.vec + j);
-		INIT_LIST_HEAD(base->tv4.vec + j);
-		INIT_LIST_HEAD(base->tv3.vec + j);
-		INIT_LIST_HEAD(base->tv2.vec + j);
-	}
-	for (j = 0; j < TVR_SIZE; j++)
-		INIT_LIST_HEAD(base->tv1.vec + j);
+	for (j = 0; j < NEW_TVEC_SIZE; j++)
+		INIT_LIST_HEAD(base->tv + j);
 }
 	
 static int __devinit timer_cpu_notify(struct notifier_block *self, 
@@ -1194,5 +1318,6 @@
 	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
 				(void *)(long)smp_processor_id());
 	register_cpu_notifier(&timers_nb);
+	calc_load();
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
 }

--------------F3E1AC0966E221011A4A4BF2--

