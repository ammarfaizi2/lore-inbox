Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262082AbSJDXbB>; Fri, 4 Oct 2002 19:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262088AbSJDXbB>; Fri, 4 Oct 2002 19:31:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3067 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262082AbSJDXaH>;
	Fri, 4 Oct 2002 19:30:07 -0400
Message-ID: <3D9E2592.B1519042@mvista.com>
Date: Fri, 04 Oct 2002 16:34:42 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] High-res-timers part 1 (core) take 3
Content-Type: multipart/mixed;
 boundary="------------3FCC7045A66D9CE4144455DE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------3FCC7045A66D9CE4144455DE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is the latest series of patches as submitted to lkml.

With tabs, this time :)

Patch is against 2.5.40-bk3

This patch supplies the core changes to implement high
resolution timers.  Mostly it changes the timer list from
the multi stage hash (or cascade) list to a single stage
hash list.  This change makes it easy to configure the list
size for those who are concerned with performance.  It also
eliminates the "time out" for the cascade operation every
512 jiffies, thus eliminating possible long preemption
times.

It also adds a sub jiffie word to the timer structure to
allow timers to exist between jiffies.  However, to support
the sub jiffie timers, work needs to be done in the platform
code for each arch.  The platform work for the i386 arch
follows in part 2.  To prevent requests from
nonexistent code for sub jiffies stuff, these parts of this
patch are disabled with the IF_HIGH_RES() macro which
depends on CONFIG_HIGH_RES_TIMERS which will be defined for
each platform as they supply the needed code.

Some of Ingo's timer code has been optimized to drop suff
not needed if the system is not SMP.

With this patch applied, the system should boot and run much
as it does prior to the patch.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------3FCC7045A66D9CE4144455DE
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-2.5.40-bk3-core-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-2.5.40-bk3-core-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.40-bk3-kb/include/linux/hrtime.h linux/include/linux/hrtime.h
--- linux-2.5.40-bk3-kb/include/linux/hrtime.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/hrtime.h	Fri Oct  4 12:12:53 2002
@@ -0,0 +1,156 @@
+#ifndef _HRTIME_H
+#define _HRTIME_H
+
+
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
+#endif	// schedule_next_int
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
+#endif	// sub_jiffie
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
+
+#define IF_HIGH_RES(a) a
+
+#else	/*  CONFIG_HIGH_RES_TIMERS */
+#define IF_HIGH_RES(a)
+#define nsec_to_arch_cycles(a) 0
+
+#endif	 /*  CONFIG_HIGH_RES_TIMERS */
+
+/*
+ * Here is an SMP helping macro...
+ */
+#ifdef CONFIG_SMP
+#define if_SMP(a) a
+#else
+#define if_SMP(a)
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
+#endif	 /* ifndef div_long_long_rem */
+
+#endif	 /* _HRTIME_H  */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.40-bk3-kb/include/linux/signal.h linux/include/linux/signal.h
--- linux-2.5.40-bk3-kb/include/linux/signal.h	Mon Sep  9 10:35:04 2002
+++ linux/include/linux/signal.h	Fri Oct  4 12:12:53 2002
@@ -219,6 +219,35 @@
 }
 
 extern long do_sigpending(void *, unsigned long);
+/*
+ * We would like the asm/signal.h code to define these so that the using
+ * function can call do_signal().  In loo of that, we define a genaric
+ * version that pretends that do_signal() was called and delivered a signal.
+ * To see how this is used, see nano_sleep() in timer.c and the i386 version
+ * in asm_i386/signal.h.
+ */
+#ifndef PT_REGS_ENTRY
+#define PT_REGS_ENTRY(type,name,p1_type,p1, p2_type,p2) \
+type name(p1_type p1,p2_type p2)\
+{
+#endif
+#ifndef _do_signal
+#define _do_signal() 1
+#endif
+#ifndef NANOSLEEP_ENTRY
+#define NANOSLEEP_ENTRY(a) asmlinkage long sys_nanosleep( struct timespec* rqtp, \
+							  struct timespec * rmtp) \
+{ a
+#endif
+#ifndef CLOCK_NANOSLEEP_ENTRY
+#define CLOCK_NANOSLEEP_ENTRY(a) asmlinkage long sys_clock_nanosleep( \
+			       clockid_t which_clock,	   \
+			       int flags,		   \
+			       const struct timespec *rqtp, \
+			       struct timespec *rmtp)	    \
+{ a
+ 
+#endif
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.40-bk3-kb/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.40-bk3-kb/include/linux/time.h	Wed Sep 18 17:04:09 2002
+++ linux/include/linux/time.h	Fri Oct  4 12:12:53 2002
@@ -1,7 +1,7 @@
 #ifndef _LINUX_TIME_H
 #define _LINUX_TIME_H
 
-#include <asm/param.h>
+#include <linux/param.h>
 #include <linux/types.h>
 
 #ifndef _STRUCT_TIMESPEC
@@ -38,6 +38,19 @@
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
@@ -46,16 +59,16 @@
 
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
@@ -124,6 +137,7 @@
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern void do_settimeofday(struct timeval *tv);
+extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 #endif
 
 #define FD_SETSIZE		__FD_SETSIZE
@@ -140,9 +154,9 @@
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.40-bk3-kb/include/linux/timer.h linux/include/linux/timer.h
--- linux-2.5.40-bk3-kb/include/linux/timer.h	Fri Oct  4 12:08:52 2002
+++ linux/include/linux/timer.h	Fri Oct  4 12:18:37 2002
@@ -14,6 +14,7 @@
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
+	long sub_expires;
 };
 
 /***
@@ -46,6 +47,7 @@
 extern void add_timer(struct timer_list * timer);
 extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
+extern void update_real_wall_time(void);
   
 #if CONFIG_SMP
   extern int del_timer_sync(struct timer_list * timer);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.40-bk3-kb/init/Config.help linux/init/Config.help
--- linux-2.5.40-bk3-kb/init/Config.help	Mon Sep  9 10:35:01 2002
+++ linux/init/Config.help	Fri Oct  4 12:12:53 2002
@@ -115,3 +115,13 @@
   replacement for kerneld.) Say Y here and read about configuring it
   in <file:Documentation/kmod.txt>.
 
+Configure timer list size
+CONFIG_TIMERLIST_512
+  This choice allows you to choose the timer list size you want.  The
+  list insert time is Order(N/size) where N is the number of active
+  timers.  Each list head is 8 bytes, thus a 512 list size requires 4K
+  bytes.  Use larger numbers if you will be using a large number of
+  timers and are more concerned about list insertion time than the extra
+  memory usage.	 (The list size must be a power of 2.)
+
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.40-bk3-kb/init/Config.in linux/init/Config.in
--- linux-2.5.40-bk3-kb/init/Config.in	Mon Sep  9 10:35:03 2002
+++ linux/init/Config.in	Fri Oct  4 12:12:53 2002
@@ -9,6 +9,27 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+choice 'Size of timer list?' \
+	"512		CONFIG_TIMERLIST_512 \
+	1024		CONFIG_TIMERLIST_1k  \
+	2048		CONFIG_TIMERLIST_2k  \
+	4096		CONFIG_TIMERLIST_4k  \
+	8192		CONFIG_TIMERLIST_8k" 512
+if [ "$CONFIG_TIMERLIST_512" =	"y" ]; then
+	define_int CONFIG_NEW_TIMER_LISTSIZE 512
+fi
+if [ "$CONFIG_TIMERLIST_1k" =  "y" ]; then
+	define_int CONFIG_NEW_TIMER_LISTSIZE 1024
+fi
+if [ "$CONFIG_TIMERLIST_2k" =  "y" ]; then
+	define_int CONFIG_NEW_TIMER_LISTSIZE 2048
+fi
+if [ "$CONFIG_TIMERLIST_4k" =  "y" ]; then
+	define_int CONFIG_NEW_TIMER_LISTSIZE 4096
+fi
+if [ "$CONFIG_TIMERLIST_8k" =  "y" ]; then
+	define_int CONFIG_NEW_TIMER_LISTSIZE 8192
+fi
 endmenu
 
 mainmenu_option next_comment
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.40-bk3-kb/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.40-bk3-kb/kernel/ksyms.c	Fri Oct  4 12:08:52 2002
+++ linux/kernel/ksyms.c	Fri Oct  4 12:12:53 2002
@@ -55,6 +55,7 @@
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
 #include <asm/checksum.h>
+#include <linux/hrtime.h>
 
 #if defined(CONFIG_PROC_FS)
 #include <linux/proc_fs.h>
@@ -487,6 +488,7 @@
 #endif
 EXPORT_SYMBOL(jiffies);
 EXPORT_SYMBOL(jiffies_64);
+EXPORT_SYMBOL(timer_conversion_bits);
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.40-bk3-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.40-bk3-kb/kernel/timer.c	Fri Oct  4 12:08:53 2002
+++ linux/kernel/timer.c	Fri Oct  4 14:10:48 2002
@@ -17,6 +17,8 @@
  *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
  *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
  *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
+ *  2002-10-01	High res timers code by George Anzinger 
+ *		    Copyright (C)2002 by MontaVista Software.
  */
 
 #include <linux/kernel_stat.h>
@@ -25,39 +27,46 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 
+#include <linux/hrtime.h>
+#include <linux/compiler.h>
+#include <asm/signal.h>
 #include <asm/uaccess.h>
 
+#ifndef IF_HIGH_RES
+#ifdef CONFIG_HIGH_RES_TIMERS
+/*
+ * ifdef eliminator macro...
+ */
+#define IF_HIGH_RES(a) a
+#else
+#define IF_HIGH_RES(a)
+#endif
+#endif
+#ifdef CONFIG_SMP
+#undef IF_SMP
+#define IF_SMP(a) a
+#define SMP 1
+#else
+#undef IF_SMP
+#define IF_SMP(a) 
+#define SMP 0
+#endif
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
 
-typedef struct timer_list timer_t;
+
 
 struct tvec_t_base_s {
 	spinlock_t lock;
 	unsigned long timer_jiffies;
-	timer_t *running_timer;
-	tvec_root_t tv1;
-	tvec_t tv2;
-	tvec_t tv3;
-	tvec_t tv4;
-	tvec_t tv5;
+	volatile struct timer_list * volatile running_timer;
+	struct list_head tv[NEW_TVEC_SIZE];
 } ____cacheline_aligned_in_smp;
 
 typedef struct tvec_t_base_s tvec_base_t;
@@ -67,40 +76,101 @@
 /* Fake initialization needed to avoid compiler breakage */
 static DEFINE_PER_CPU(struct tasklet_struct, timer_tasklet) = { NULL };
 
-static inline void internal_add_timer(tvec_base_t *base, timer_t *timer)
+static inline void internal_add_timer(tvec_base_t *base, 
+				      struct timer_list *timer)
 {
+	/*
+	 * must be cli-ed when calling this
+	 */
 	unsigned long expires = timer->expires;
-	unsigned long idx = expires - base->timer_jiffies;
-	struct list_head *vec;
+	IF_HIGH_RES(int sub_expires = timer->sub_expires;)
+		int indx;
+	struct list_head *pos,*list_start;
 
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
+	if ( time_before(expires, base->timer_jiffies) ){
+		/*
+		 * already expired, schedule for next tick 
+		 * would like to do better here
+		 * Actually this now works just fine with the
+		 * back up of timer_jiffies in "run_timer_list".
+		 * Note that this puts the timer on a list other
+		 * than the one it idexes to.  We don't want to
+		 * change the expires value in the timer as it is
+		 * used by the repeat code in setitimer and the
+		 * POSIX timers code.
+			 */
+		expires = base->timer_jiffies;
+		IF_HIGH_RES(sub_expires = 0);
+	}
+			
+	indx =	expires & NEW_TVEC_MASK;
+	if ((expires - base->timer_jiffies) <= NEW_TVEC_SIZE) {
+#ifdef CONFIG_HIGH_RES_TIMERS
+		unsigned long jiffies_f;
 		/*
-		 * Can happen if you add a timer with expires == jiffies,
-		 * or you set a timer to go off in the past
+		 * The high diff bits are the same, goes to the head of 
+		 * the list, sort on sub_expire.
 		 */
-		vec = base->tv1.vec + base->tv1.index;
-	} else if (idx <= 0xffffffffUL) {
-		int i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
-		vec = base->tv5.vec + i;
-	} else
-		/* Can only get here on architectures with 64-bit jiffies */
-		return;
-	/*
-	 * Timers are FIFO:
-	 */
-	list_add_tail(&timer->entry, vec);
+		for (pos = (list_start = &base->tv[indx])->next; 
+		     pos != list_start; 
+		     pos = pos->next){
+			struct timer_list *tmr = 
+				list_entry(pos,
+					   struct timer_list,
+					   entry);
+			if ((tmr->sub_expires >= sub_expires) ||
+			    (tmr->expires != expires)){
+				break;
+			}
+		}
+		list_add_tail(&timer->entry, pos);
+		/*
+		 * Notes to me.	 Use jiffies here instead of 
+		 * timer_jiffies to prevent adding unneeded interrupts.
+		 * Running_timer is NULL if we are NOT currently 
+		 * activly dispatching timers.	Since we are under
+		 * the same spin lock, it being false means that 
+		 * it has dropped the spinlock to call the timer
+		 * function, which could well be who called us.
+		 * In any case, we don't need a new interrupt as
+		 * the timer dispach code (run_timer_list) will
+		 * pick this up when the function it is calling 
+		 * returns.
+		 */
+		if ( expires == (jiffies_f = jiffies) && 
+		     list_start->next == &timer->entry &&
+		     (base->running_timer == NULL)) {
+			schedule_next_int(jiffies_f, sub_expires,1);
+		}
+#else
+		pos = (&base->tv[indx])->next;
+		list_add_tail(&timer->entry, pos);
+#endif
+	}else{
+		/*
+		 * The high diff bits differ, search from the tail
+		 * The for will pick up an empty list.
+		 */
+		for (pos = (list_start = &base->tv[indx])->prev; 
+		     pos != list_start; 
+		     pos = pos->prev){
+			struct timer_list *tmr = 
+				list_entry(pos,
+					   struct timer_list,
+					   entry);
+			if (time_after(tmr->expires, expires)){
+				continue;
+			}
+			IF_HIGH_RES(
+				if ((tmr->expires != expires) ||
+				    (tmr->sub_expires < sub_expires)) {
+					break;
+				}
+				);
+		}
+		list_add(&timer->entry, pos);
+	}
+				
 }
 
 /***
@@ -117,7 +187,7 @@
  * Timers with an ->expired field in the past will be executed in the next
  * timer tick. It's illegal to add an already pending timer.
  */
-void add_timer(timer_t *timer)
+void add_timer(struct timer_list *timer)
 {
 	int cpu = get_cpu();
 	tvec_base_t *base = tvec_bases + cpu;
@@ -151,9 +221,11 @@
  * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
  * active timer returns 1.)
  */
-int mod_timer(timer_t *timer, unsigned long expires)
+#ifndef CONFIG_HIGH_RES_TIMERS
+int mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	tvec_base_t *old_base, *new_base;
+	tvec_base_t *new_base;
+	IF_SMP( tvec_base_t *old_base;)
 	unsigned long flags;
 	int ret = 0;
 
@@ -168,6 +240,7 @@
 
 	local_irq_save(flags);
 	new_base = tvec_bases + smp_processor_id();
+#ifdef CONFIG_SMP
 repeat:
 	old_base = timer->base;
 
@@ -183,6 +256,74 @@
 			spin_lock(&new_base->lock);
 		}
 		/*
+		 * Subtle, we rely on timer->base being always
+		 * valid and being updated atomically.
+		 */
+		if (timer->base != old_base) {
+			spin_unlock(&new_base->lock);
+			spin_unlock(&old_base->lock);
+			goto repeat;
+		}
+	} else
+#endif
+		spin_lock(&new_base->lock);
+
+	timer->expires = expires;
+	/*
+	 * Delete the previous timeout (if there was any), and install
+	 * the new one:
+	 */
+	if (timer->base) {
+		list_del(&timer->entry);
+		ret = 1;
+	}
+	internal_add_timer(new_base, timer);
+	timer->base = new_base;
+
+	IF_SMP(if (old_base && (new_base != old_base))
+	       spin_unlock(&old_base->lock);
+		)
+	spin_unlock_irqrestore(&new_base->lock, flags);
+
+	return ret;
+}
+#else
+/*
+ * Is this useful?  It is not used by POSIX timers.
+ */
+int mod_timer_hr(struct timer_list *timer, 
+		 unsigned long expires,
+		 long sub_expires)
+{
+	tvec_base_t *new_base;
+	IF_SMP( tvec_base_t *old_base;)
+	unsigned long flags;
+	int ret = 0;
+
+	if (timer_pending(timer) && 
+	    timer->expires == expires &&
+	    timer->sub_expires == sub_expires)
+		return 1;
+
+	local_irq_save(flags);
+	new_base = tvec_bases + smp_processor_id();
+#ifdef CONFIG_SMP
+
+ repeat: 
+	old_base = timer->base;
+
+	/*
+	 * Prevent deadlocks via ordering by old_base < new_base.
+	 */
+	if (old_base && (new_base != old_base)) {
+		if (old_base < new_base) {
+			spin_lock(&new_base->lock);
+			spin_lock(&old_base->lock);
+		} else {
+			spin_lock(&old_base->lock);
+			spin_lock(&new_base->lock);
+		}
+		/*
 		 * The timer base might have changed while we were
 		 * trying to take the lock(s):
 		 */
@@ -192,26 +333,35 @@
 			goto repeat;
 		}
 	} else
+#endif
+
 		spin_lock(&new_base->lock);
 
 	/*
 	 * Delete the previous timeout (if there was any), and install
 	 * the new one:
 	 */
-	if (old_base) {
+	if (timer->base) {
 		list_del(&timer->entry);
 		ret = 1;
 	}
 	timer->expires = expires;
+	timer->sub_expires = sub_expires;
 	internal_add_timer(new_base, timer);
 	timer->base = new_base;
 
-	if (old_base && (new_base != old_base))
-		spin_unlock(&old_base->lock);
+	IF_SMP(if (old_base && (new_base != old_base))
+	       spin_unlock(&old_base->lock);
+		)
 	spin_unlock_irqrestore(&new_base->lock, flags);
 
 	return ret;
 }
+int mod_timer(struct timer_list *timer, unsigned long expires)
+{
+	return mod_timer_hr(timer, expires, timer->sub_expires);
+}
+#endif
 
 /***
  * del_timer - deactive a timer.
@@ -224,7 +374,7 @@
  * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
  * active timer returns 1.)
  */
-int del_timer(timer_t *timer)
+int del_timer(struct timer_list *timer)
 {
 	unsigned long flags;
 	tvec_base_t *base;
@@ -261,7 +411,8 @@
  *
  * The function returns whether it has deactivated a pending timer or not.
  */
-int del_timer_sync(timer_t *timer)
+
+int del_timer_sync(struct timer_list * timer)
 {
 	tvec_base_t *base = tvec_bases;
 	int i, ret;
@@ -285,94 +436,113 @@
 }
 #endif
 
+/*
+ * run_timer_list is ALWAYS called from softirq which calls with irq enabled.
+ * We may assume this and not save the flags.
+ */
 
-static void cascade(tvec_base_t *base, tvec_t *tv)
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
-		timer_t *tmp;
 
-		tmp = list_entry(curr, timer_t, entry);
-		if (tmp->base != base)
-			BUG();
-		next = curr->next;
-		internal_add_timer(base, tmp);
-		curr = next;
-	}
-	INIT_LIST_HEAD(head);
-	tv->index = (tv->index + 1) & TVN_MASK;
-}
-
-/***
- * __run_timers - run all expired timers (if any) on this CPU.
- * @base: the timer vector to be processed.
- *
- * This function cascades all vectors and executes all expired timer
- * vectors.
- */
-static inline void __run_timers(tvec_base_t *base)
+static void __run_timers(tvec_base_t *base)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&base->lock, flags);
+	IF_HIGH_RES( unsigned long jiffies_f;
+		     long sub_jiff = -1;
+		     long sub_jiffie_f);
+	spin_lock_irq(&base->lock);
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
-		struct list_head *head, *curr;
+#endif
 
+		struct list_head *head, *curr;
+		head = base->tv + 
+			(base->timer_jiffies	& NEW_TVEC_MASK);
 		/*
-		 * Cascade timers:
+		 * Note that we never move "head" but continue to
+		 * pick the first entry from it.  This allows new
+		 * entries to be inserted while we unlock for the
+		 * function call below.
 		 */
-		if (!base->tv1.index) {
-			cascade(base, &base->tv2);
-			if (base->tv2.index == 1) {
-				cascade(base, &base->tv3);
-				if (base->tv3.index == 1) {
-					cascade(base, &base->tv4);
-					if (base->tv4.index == 1)
-						cascade(base, &base->tv5);
-				}
-			}
-		}
 repeat:
-		head = base->tv1.vec + base->tv1.index;
 		curr = head->next;
 		if (curr != head) {
 			void (*fn)(unsigned long);
 			unsigned long data;
-			timer_t *timer;
+			struct timer_list *timer;
 
-			timer = list_entry(curr, timer_t, entry);
- 			fn = timer->function;
- 			data = timer->data;
+			timer = list_entry(curr, struct timer_list, entry);
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
+#endif
+				{fn = timer->function;
+				data= timer->data;
 
-			list_del(&timer->entry);
-			timer->base = NULL;
-#if CONFIG_SMP
-			base->running_timer = timer;
+				list_del(&timer->entry);
+				timer->base = NULL;
+				timer->entry.next = timer->entry.prev = NULL;
+				base->running_timer = timer;
+				spin_unlock_irq(&base->lock);
+				fn(data);
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
 #endif
-			spin_unlock_irq(&base->lock);
-			fn(data);
-			spin_lock_irq(&base->lock);
-			goto repeat;
 		}
 		++base->timer_jiffies; 
-		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 	}
-#if CONFIG_SMP
+	/*
+	 * It is faster to back out the last bump, than to prevent it.
+	 * This allows zero time inserts as well as sub_jiffie values in
+	 * the current jiffie.	Did not work for the cascade as tv1.index
+	 * also needs adjusting. 
+	 */
+	--base->timer_jiffies;
 	base->running_timer = NULL;
-#endif
-	spin_unlock_irqrestore(&base->lock, flags);
-}
 
-/******************************************************************/
+	IF_HIGH_RES(if (schedule_next_int( jiffies_f, sub_jiff, 0)){
+		/*
+		 * If schedule_next_int says the time has passed
+		 * bump the tasklet lock so we go round again
+		 */
+		run_local_timers();
+		});
 
+	spin_unlock_irq(&base->lock);
+}
 /*
  * Timekeeping variables
  */
@@ -652,15 +822,37 @@
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
  * process.  user_tick is 1 if the tick is user time, 0 for system.
+ *
+ * Here is where we need to sort out the sub-jiffie interrupts from the 
+ * jiffie ones and make sure we only do accounting once per jiffie per cpu.
+ * We do this by using new_jiffie as a bit per cpu. All ops are atomic.
  */
+/*
+ * This read-write spinlock protects us from races in SMP while
+ * playing with xtime and avenrun.
+ */
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
@@ -679,35 +871,38 @@
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
+	expires: LOAD_FREQ,
+	function:(void (*)(unsigned long))calc_load,
+	entry: {0,0} };
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
@@ -717,8 +912,7 @@
 {
 	tvec_base_t *base = tvec_bases + smp_processor_id();
 
-	if ((long)(jiffies - base->timer_jiffies) >= 0)
-		__run_timers(base);
+	__run_timers(base);
 }
 
 /*
@@ -743,8 +937,25 @@
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
@@ -754,12 +965,12 @@
 
 void do_timer(struct pt_regs *regs)
 {
-	jiffies_64++;
-#ifndef CONFIG_SMP
-	/* SMP process accounting uses the local APIC timer */
-
-	update_process_times(user_mode(regs));
-#endif
+	update_jiffies();
+	/* 
+	 * SMP process accounting uses the local APIC timer 
+	 */
+	if (!SMP )
+		update_process_times(user_mode(regs));
 	update_times();
 }
 
@@ -768,7 +979,7 @@
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
 /*
- * For backwards compatibility?  This can be done in libc so Alpha
+ * For backwards compatibility?	 This can be done in libc so Alpha
  * and all newer ports shouldn't need it.
  */
 asmlinkage unsigned long sys_alarm(unsigned int seconds)
@@ -870,7 +1081,7 @@
 asmlinkage long sys_getegid(void)
 {
 	/* Only we change this so SMP safe */
-	return  current->egid;
+	return	current->egid;
 }
 
 #endif
@@ -908,7 +1119,7 @@
  */
 signed long schedule_timeout(signed long timeout)
 {
-	timer_t timer;
+	struct timer_list timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -964,10 +1175,31 @@
 	return current->pid;
 }
 
-asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+#if 0  
+// This #if 0 is to keep the pretty printer/ formatter happy so the indents will
+// correct below.  
+// The NANOSLEEP_ENTRY macro is defined in  asm/signal.h and
+// is structured to allow code as well as entry definitions, so that when
+// we get control back here the entry parameters will be available as expected.
+// Some systems may find these paramerts in other ways than as entry parms, 
+// for example, struct pt_regs *regs is defined in i386 as the address of the
+// first parameter, where as other archs pass it as one of the paramerters.
+asmlinkage long sys_nanosleep(void)
 {
-	struct timespec t;
-	unsigned long expire;
+#endif
+	NANOSLEEP_ENTRY(	struct timespec t;
+				unsigned long expire;)
+
+
+		// The following code expects rqtp, rmtp to be available as a result of
+		// the above macro.  Also any regs needed for the _do_signal() macro 
+		// shoule be set up here.
+
+		//asmlinkage long sys_nanosleep(struct timespec *rqtp, 
+		//  struct timespec *rmtp)
+		//  {
+		//    struct timespec t;
+		//    unsigned long expire;
 
 	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
 		return -EFAULT;
@@ -977,8 +1209,9 @@
 
 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
 
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire);
+	do {
+		current->state = TASK_INTERRUPTIBLE;
+	} while((expire = schedule_timeout(expire)) && !_do_signal());
 
 	if (expire) {
 		if (rmtp) {
@@ -1071,14 +1304,9 @@
 	       
 		base = tvec_bases + i;
 		spin_lock_init(&base->lock);
-		for (j = 0; j < TVN_SIZE; j++) {
-			INIT_LIST_HEAD(base->tv5.vec + j);
-			INIT_LIST_HEAD(base->tv4.vec + j);
-			INIT_LIST_HEAD(base->tv3.vec + j);
-			INIT_LIST_HEAD(base->tv2.vec + j);
-		}
-		for (j = 0; j < TVR_SIZE; j++)
-			INIT_LIST_HEAD(base->tv1.vec + j);
+		for (j = 0; j < NEW_TVEC_SIZE; j++)
+			INIT_LIST_HEAD(base->tv + j);
 		tasklet_init(&per_cpu(timer_tasklet, i), run_timer_tasklet, 0);
 	}
+	calc_load();
 }


--------------3FCC7045A66D9CE4144455DE--

