Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSI0AMH>; Thu, 26 Sep 2002 20:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSI0AMH>; Thu, 26 Sep 2002 20:12:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40438 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261582AbSI0AL4>;
	Thu, 26 Sep 2002 20:11:56 -0400
Message-ID: <3D93A363.ACA56815@mvista.com>
Date: Thu, 26 Sep 2002 17:16:35 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
Subject: [PATCH] High-res-timers part 1 (core)
Content-Type: multipart/mixed;
 boundary="------------2DA34975E9119BB1C36C61DC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------2DA34975E9119BB1C36C61DC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


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
non-existant code for sub jiffies stuff, these parts of this
patch are disabled with the IF_HIGH_RES() macro which
depends on CONFIG_HIGH_RES_TIMERS which will be defined for
each platform as they supply the needed code.

With this patch applied, the system should boot and run much
as it does prior to the patch.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------2DA34975E9119BB1C36C61DC
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-core-2.5.38-bk5-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-core-2.5.38-bk5-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/include/linux/hrtime.h linux/include/linux/hrtime.h
--- linux-2.5.38-bk5-org/include/linux/hrtime.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/hrtime.h	Thu Sep 26 16:03:06 2002
@@ -0,0 +1,155 @@
+#ifndef _HRTIME_H
+#define _HRTIME_H
+
+
+
+/*
+ * This file is the glue to bring in the platform stuff.
+ * We make it all depend on the CONFIG option so all archs
+ * will work as long as the CONFIG is not set.  Once an 
+ * arch defines the CONFIG, it had better have the 
+ * asm/hrtime.h file in place.
+ */
+/*
+ * This gets filled in at init time, either static or dynamic.
+ * Someday this will be what NTP fiddles with.
+ * Do we need the scale here?  I don't think so, as long as we
+ * do percentage offsets for NTP.
+ */
+struct timer_conversion_bits {
+        unsigned long _arch_to_usec; 
+        unsigned long _arch_to_nsec;
+        unsigned long _usec_to_arch; 
+        unsigned long _nsec_to_arch;
+        long _cycles_per_jiffies;
+        unsigned long _arch_to_latch;
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
+ * if the next timer interrupt should be the next jiffie value.  The
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
+#endif  // schedule_next_int
+/*
+ * The sub_jiffie() macro should return the current time offset from the latest
+ * jiffie.  This will be in "arch" defined units and is used to determine if
+ * a timer has expired.  Since no sub_expire value will be used if "arch" 
+ * has not defined the high-res package, 0 will work well here.
+ *
+ * In addition, to save time if there is no high-res package (or it is not
+ * configured), we define the sub expression for the run_timer_list.
+ */
+
+#ifndef sub_jiffie
+#undef CONFIG_HIGH_RES_TIMERS
+#define sub_jiffie() 0
+#endif  // sub_jiffie
+
+/*
+ * The high_res_test() macro should set up a test mode that will do a
+ * worst case timer interrupt.  I.e. it may be that a call to 
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
+#else   /*  CONFIG_HIGH_RES_TIMERS */
+#define IF_HIGH_RES(a)
+#define nsec_to_arch_cycles(a) 0
+
+#endif   /*  CONFIG_HIGH_RES_TIMERS */
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
+                       u64 result = dividend;           \
+                       *remainder = do_div(result,divisor); \
+                       result; })
+
+#endif   /* ifndef div_long_long_rem */
+
+#endif   /* _HRTIME_H  */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/include/linux/signal.h linux/include/linux/signal.h
--- linux-2.5.38-bk5-org/include/linux/signal.h	Mon Sep  9 10:35:04 2002
+++ linux/include/linux/signal.h	Thu Sep 26 14:33:39 2002
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
+                                                          struct timespec * rmtp) \
+{ a
+#endif
+#ifndef CLOCK_NANOSLEEP_ENTRY
+#define CLOCK_NANOSLEEP_ENTRY(a) asmlinkage long sys_clock_nanosleep( \
+                               clockid_t which_clock,      \
+                               int flags,                  \
+                               const struct timespec *rqtp, \
+                               struct timespec *rmtp)       \
+{ a
+ 
+#endif
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.38-bk5-org/include/linux/time.h	Wed Sep 18 17:04:09 2002
+++ linux/include/linux/time.h	Thu Sep 26 14:33:39 2002
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/include/linux/timer.h linux/include/linux/timer.h
--- linux-2.5.38-bk5-org/include/linux/timer.h	Mon Sep  9 10:35:04 2002
+++ linux/include/linux/timer.h	Thu Sep 26 14:33:39 2002
@@ -14,15 +14,18 @@
  * timeouts. You can use this field to distinguish between the different
  * invocations.
  */
+
 struct timer_list {
 	struct list_head list;
 	unsigned long expires;
+        long sub_expires;
 	unsigned long data;
 	void (*function)(unsigned long);
 };
 
 extern void add_timer(struct timer_list * timer);
 extern int del_timer(struct timer_list * timer);
+extern void update_real_wall_time(void);
 
 #ifdef CONFIG_SMP
 extern int del_timer_sync(struct timer_list * timer);
@@ -37,14 +40,24 @@
  * If the timer is known to be not pending (ie, in the handler), mod_timer
  * is less efficient than a->expires = b; add_timer(a).
  */
+#ifdef CONFIG_HIGH_RES_TIMERS
+int mod_timer_hr(struct timer_list *timer, 
+                 unsigned long expires,
+                 long sub_expires);
+#else
+#define  mod_timer_hr(a,b,c) mod_timer(a,b)
+#endif
+
 int mod_timer(struct timer_list *timer, unsigned long expires);
 
 extern void it_real_fn(unsigned long);
 
 static inline void init_timer(struct timer_list * timer)
 {
-	timer->list.next = timer->list.prev = NULL;
+        timer->sub_expires = 0;
+	timer->list.next = timer->list.prev =(struct list_head *) NULL;
 }
+#define TIMER_INIT(fun) {function: fun}
 
 static inline int timer_pending (const struct timer_list * timer)
 {
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/init/Config.help linux/init/Config.help
--- linux-2.5.38-bk5-org/init/Config.help	Mon Sep  9 10:35:01 2002
+++ linux/init/Config.help	Thu Sep 26 14:33:39 2002
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
+  memory usage.  (The list size must be a power of 2.)
+
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/init/Config.in linux/init/Config.in
--- linux-2.5.38-bk5-org/init/Config.in	Mon Sep  9 10:35:03 2002
+++ linux/init/Config.in	Thu Sep 26 14:33:39 2002
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
+if [ "$CONFIG_TIMERLIST_512" =  "y" ]; then
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.38-bk5-org/kernel/ksyms.c	Thu Sep 26 11:25:02 2002
+++ linux/kernel/ksyms.c	Thu Sep 26 14:35:55 2002
@@ -55,6 +55,7 @@
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
 #include <asm/checksum.h>
+#include <linux/hrtime.h>
 
 #if defined(CONFIG_PROC_FS)
 #include <linux/proc_fs.h>
@@ -495,6 +496,7 @@
 EXPORT_SYMBOL(jiffies);
 EXPORT_SYMBOL(jiffies_64);
 EXPORT_SYMBOL(xtime);
+EXPORT_SYMBOL(timer_conversion_bits);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
 #ifdef CONFIG_DEBUG_KERNEL
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.38-bk5-org/kernel/timer.c	Thu Sep 26 11:25:02 2002
+++ linux/kernel/timer.c	Thu Sep 26 14:33:39 2002
@@ -14,6 +14,9 @@
  *                              Copyright (C) 1998  Andrea Arcangeli
  *  1999-03-10  Improved NTP compatibility by Ulrich Windl
  *  2002-05-31	Move sys_sysinfo here and make its locking sane, Robert Love
+ *  2002-08-13  High res timers code by George Anzinger 
+ *                  Copyright (C)2002 by MontaVista Software.
+
  */
 
 #include <linux/config.h>
@@ -25,6 +28,9 @@
 #include <linux/tqueue.h>
 #include <linux/kernel_stat.h>
 
+#include <linux/hrtime.h>
+#include <linux/compiler.h>
+#include <asm/signal.h>
 #include <asm/uaccess.h>
 
 struct kernel_stat kstat;
@@ -38,6 +44,10 @@
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));
+ /*
+  * This spinlock protect us from races in SMP while playing with xtime. -arca
+  */
+ rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
@@ -83,104 +93,146 @@
 /*
  * Event timer code
  */
-#define TVN_BITS 6
-#define TVR_BITS 8
-#define TVN_SIZE (1 << TVN_BITS)
-#define TVR_SIZE (1 << TVR_BITS)
-#define TVN_MASK (TVN_SIZE - 1)
-#define TVR_MASK (TVR_SIZE - 1)
-
-struct timer_vec {
-	int index;
-	struct list_head vec[TVN_SIZE];
-};
-
-struct timer_vec_root {
-	int index;
-	struct list_head vec[TVR_SIZE];
-};
-
-static struct timer_vec tv5;
-static struct timer_vec tv4;
-static struct timer_vec tv3;
-static struct timer_vec tv2;
-static struct timer_vec_root tv1;
-
-static struct timer_vec * const tvecs[] = {
-	(struct timer_vec *)&tv1, &tv2, &tv3, &tv4, &tv5
-};
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
+
+#ifndef CONFIG_NEW_TIMER_LISTSIZE
+#define CONFIG_NEW_TIMER_LISTSIZE 512
+#endif
+#define NEW_TVEC_SIZE CONFIG_NEW_TIMER_LISTSIZE
+#define NEW_TVEC_MASK (NEW_TVEC_SIZE - 1)
 
-#define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))
+static struct list_head new_tvec[NEW_TVEC_SIZE];
 
 void init_timervecs (void)
 {
 	int i;
 
-	for (i = 0; i < TVN_SIZE; i++) {
-		INIT_LIST_HEAD(tv5.vec + i);
-		INIT_LIST_HEAD(tv4.vec + i);
-		INIT_LIST_HEAD(tv3.vec + i);
-		INIT_LIST_HEAD(tv2.vec + i);
-	}
-	for (i = 0; i < TVR_SIZE; i++)
-		INIT_LIST_HEAD(tv1.vec + i);
+        for (i = 0; i < NEW_TVEC_SIZE; i++)
+                INIT_LIST_HEAD( new_tvec + i);
 }
 
 static unsigned long timer_jiffies;
 
-static inline void internal_add_timer(struct timer_list *timer)
-{
-	/*
-	 * must be cli-ed when calling this
-	 */
-	unsigned long expires = timer->expires;
-	unsigned long idx = expires - timer_jiffies;
-	struct list_head * vec;
-
-	if (idx < TVR_SIZE) {
-		int i = expires & TVR_MASK;
-		vec = tv1.vec + i;
-	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
-		int i = (expires >> TVR_BITS) & TVN_MASK;
-		vec = tv2.vec + i;
-	} else if (idx < 1 << (TVR_BITS + 2 * TVN_BITS)) {
-		int i = (expires >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
-		vec =  tv3.vec + i;
-	} else if (idx < 1 << (TVR_BITS + 3 * TVN_BITS)) {
-		int i = (expires >> (TVR_BITS + 2 * TVN_BITS)) & TVN_MASK;
-		vec = tv4.vec + i;
-	} else if ((signed long) idx < 0) {
-		/* can happen if you add a timer with expires == jiffies,
-		 * or you set a timer to go off in the past
-		 */
-		vec = tv1.vec + tv1.index;
-	} else if (idx <= 0xffffffffUL) {
-		int i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
-		vec = tv5.vec + i;
-	} else {
-		/* Can only get here on architectures with 64-bit jiffies */
-		INIT_LIST_HEAD(&timer->list);
-		return;
-	}
-	/*
-	 * Timers are FIFO!
-	 */
-	list_add(&timer->list, vec->prev);
-}
-
 /* Initialize both explicitly - let's try to have them in the same cache line */
 spinlock_t timerlist_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
-#ifdef CONFIG_SMP
 volatile struct timer_list * volatile running_timer;
 #define timer_enter(t) do { running_timer = t; mb(); } while (0)
 #define timer_exit() do { running_timer = NULL; } while (0)
+#define timer_is_inactive() (running_timer == NULL)
+
+#ifdef CONFIG_SMP
 #define timer_is_running(t) (running_timer == t)
 #define timer_synchronize(t) while (timer_is_running(t)) barrier()
+#endif
+
+
+
+static inline void internal_add_timer(struct timer_list *timer)
+{
+	/*
+	 * must be cli-ed when calling this
+	 */
+        unsigned long expires = timer->expires;
+        IF_HIGH_RES(int sub_expires = timer->sub_expires;)
+                int indx;
+        struct list_head *pos,*list_start;
+
+        if ( time_before(expires, timer_jiffies) ){
+                /*
+                 * already expired, schedule for next tick 
+                 * would like to do better here
+                 * Actually this now works just fine with the
+                 * back up of timer_jiffies in "run_timer_list".
+                 * Note that this puts the timer on a list other
+                 * than the one it idexes to.  We don't want to
+                 * change the expires value in the timer as it is
+                 * used by the repeat code in setitimer and the
+                 * POSIX timers code.
+                         */
+                expires = timer_jiffies;
+                IF_HIGH_RES(sub_expires = 0);
+        }
+                        
+        indx =  expires & NEW_TVEC_MASK;
+        if ((expires - timer_jiffies) <= NEW_TVEC_SIZE) {
+#ifdef CONFIG_HIGH_RES_TIMERS
+                unsigned long jiffies_f;
+                /*
+                 * The high diff bits are the same, goes to the head of 
+                 * the list, sort on sub_expire.
+                 */
+                for (pos = (list_start = &new_tvec[indx])->next; 
+                     pos != list_start; 
+                     pos = pos->next){
+                        struct timer_list *tmr = 
+                                list_entry(pos,
+                                           struct timer_list,
+                                           list);
+                        if ((tmr->sub_expires >= sub_expires) ||
+                            (tmr->expires != expires)){
+                                break;
+                        }
+                }
+                list_add_tail(&timer->list, pos);
+                /*
+                 * Notes to me.  Use jiffies here instead of 
+                 * timer_jiffies to prevent adding unneeded interrupts.
+                 * Timer_is_inactive() is false if we are currently 
+                 * activly dispatching timers.  Since we are under
+                 * the same spin lock, it being false means that 
+                 * it has dropped the spinlock to call the timer
+                 * function, which could well be who called us.
+                 * In any case, we don't need a new interrupt as
+                 * the timer dispach code (run_timer_list) will
+                 * pick this up when the function it is calling 
+                 * returns.
+                 */
+                if ( expires == (jiffies_f = jiffies) && 
+                     list_start->next == &timer->list &&
+                     timer_is_inactive()) {
+                        schedule_next_int(jiffies_f, sub_expires,1);
+                }
 #else
-#define timer_enter(t)		do { } while (0)
-#define timer_exit()		do { } while (0)
+                pos = (&new_tvec[indx])->next;
+                list_add_tail(&timer->list, pos);
 #endif
+        }else{
+                /*
+                 * The high diff bits differ, search from the tail
+                 * The for will pick up an empty list.
+                 */
+                for (pos = (list_start = &new_tvec[indx])->prev; 
+                     pos != list_start; 
+                     pos = pos->prev){
+                        struct timer_list *tmr = 
+                                list_entry(pos,
+                                           struct timer_list,
+                                           list);
+                        if (time_after(tmr->expires, expires)){
+                                continue;
+                        }
+                        IF_HIGH_RES(
+                                if ((tmr->expires != expires) ||
+                                    (tmr->sub_expires < sub_expires)) {
+                                        break;
+                                }
+                                );
+                }
+                list_add(&timer->list, pos);
+        }
+                                
+}
+
 
 void add_timer(struct timer_list *timer)
 {
@@ -218,6 +270,26 @@
 	spin_unlock_irqrestore(&timerlist_lock, flags);
 	return ret;
 }
+#ifdef CONFIG_HIGH_RES_TIMERS
+/*
+ * Is this useful?  It is not used by POSIX timers.
+ */
+int mod_timer_hr(struct timer_list *timer, 
+                 unsigned long expires,
+                 long sub_expires)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&timerlist_lock, flags);
+	timer->expires = expires;
+        timer->sub_expires = sub_expires;
+	ret = detach_timer(timer);
+	internal_add_timer(timer);
+	spin_unlock_irqrestore(&timerlist_lock, flags);
+	return ret;
+}
+#endif
 
 int del_timer(struct timer_list * timer)
 {
@@ -265,43 +337,41 @@
 #endif
 
 
-static inline void cascade_timers(struct timer_vec *tv)
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
 
-		tmp = list_entry(curr, struct timer_list, list);
-		next = curr->next;
-		list_del(curr); // not needed
-		internal_add_timer(tmp);
-		curr = next;
-	}
-	INIT_LIST_HEAD(head);
-	tv->index = (tv->index + 1) & TVN_MASK;
-}
+/*
+ * run_timer_list is ALWAYS called from softirq which calls with irq enabled.
+ * We may assume this and not save the flags.
+ */
 
 static inline void run_timer_list(void)
 {
-	spin_lock_irq(&timerlist_lock);
+        IF_HIGH_RES( unsigned long jiffies_f;
+                     long sub_jiff = -1;
+                     long sub_jiffie_f);
+        spin_lock_irq(&timerlist_lock);
+#ifdef CONFIG_HIGH_RES_TIMERS
+        read_lock(&xtime_lock);
+        jiffies_f = jiffies;
+        sub_jiffie_f = sub_jiffie() + quick_get_cpuctr();
+        read_unlock(&xtime_lock);
+        while ( unlikely(sub_jiffie_f >= cycles_per_jiffies)){
+                sub_jiffie_f -= cycles_per_jiffies;
+                jiffies_f++;
+        }
+        while ((long)(jiffies_f - timer_jiffies) >= 0) {
+#else
 	while ((long)(jiffies - timer_jiffies) >= 0) {
+#endif
 		struct list_head *head, *curr;
-		if (!tv1.index) {
-			int n = 1;
-			do {
-				cascade_timers(tvecs[n]);
-			} while (tvecs[n]->index == 1 && ++n < NOOF_TVECS);
-		}
+                head = new_tvec + 
+                        (timer_jiffies  & NEW_TVEC_MASK);
+                /*
+                 * Note that we never move "head" but continue to
+                 * pick the first entry from it.  This allows new
+                 * entries to be inserted while we unlock for the
+                 * function call below.
+                 */
 repeat:
-		head = tv1.vec + tv1.index;
 		curr = head->next;
 		if (curr != head) {
 			struct timer_list *timer;
@@ -309,22 +379,68 @@
 			unsigned long data;
 
 			timer = list_entry(curr, struct timer_list, list);
- 			fn = timer->function;
- 			data= timer->data;
+#ifdef CONFIG_HIGH_RES_TIMERS
+                        /*
+                         * This would be simpler if we never got behind
+                         * i.e. if timer_jiffies == jiffies, we could
+                         * drop one of the tests.  Since we may get 
+                         * behind, (in fact we don't up date until
+                         * we are behind to allow sub_jiffie entries)
+                         * we need a way to negate the sub_jiffie
+                         * test in that case...
+                         */
+                        if (time_before(timer->expires, jiffies_f)||
+                            ((timer->expires == jiffies_f) &&
+                             timer->sub_expires <= sub_jiffie_f))
+#else
+                        if (time_before_eq(timer->expires, jiffies))
+#endif
+                                {fn = timer->function;
+                                data= timer->data;
 
-			detach_timer(timer);
-			timer->list.next = timer->list.prev = NULL;
-			timer_enter(timer);
-			spin_unlock_irq(&timerlist_lock);
-			fn(data);
-			spin_lock_irq(&timerlist_lock);
-			timer_exit();
-			goto repeat;
-		}
+                                detach_timer(timer);
+                                timer->list.next = timer->list.prev = NULL;
+                                timer_enter(timer);
+                                spin_unlock_irq(&timerlist_lock);
+                                fn(data);
+                                spin_lock_irq(&timerlist_lock);
+                                timer_exit();
+                                goto repeat;
+                        }
+#ifdef CONFIG_HIGH_RES_TIMERS
+                        else{
+                                /*
+                                 * The new timer list is not always emptied
+                                 * here as it contains:
+                                 * a.) entries (list size)^N*jiffies out and
+                                 * b.) entries that match in jiffies, but have
+                                 *     sub_expire times further out than now.
+                                 */
+                                 if (timer->expires == jiffies_f ){
+                                        sub_jiff = timer->sub_expires;
+                                }
+                        }
+#endif
+                }
 		++timer_jiffies; 
-		tv1.index = (tv1.index + 1) & TVR_MASK;
 	}
-	spin_unlock_irq(&timerlist_lock);
+        /*
+         * It is faster to back out the last bump, than to prevent it.
+         * This allows zero time inserts as well as sub_jiffie values in
+         * the current jiffie.  Did not work for the cascade as tv1.index
+         * also needs adjusting. 
+         */
+        --timer_jiffies;
+
+        IF_HIGH_RES(if (schedule_next_int( jiffies_f, sub_jiff, 0)){
+                /*
+                 * If schedule_next_int says the time has passed
+                 * bump the tasklet lock so we go round again
+                 */
+                mark_bh(TIMER_BH);
+                });
+
+        spin_unlock_irq(&timerlist_lock);
 }
 
 spinlock_t tqueue_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
@@ -631,14 +747,9 @@
 /* jiffies at the most recent update of wall time */
 unsigned long wall_jiffies;
 
-/*
- * This read-write spinlock protects us from races in SMP while
- * playing with xtime and avenrun.
- */
-rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
 unsigned long last_time_offset;
 
-static inline void update_times(void)
+static inline unsigned long update_times(void)
 {
 	unsigned long ticks;
 
@@ -655,23 +766,44 @@
 		update_wall_time(ticks);
 	}
 	last_time_offset = 0;
-	calc_load(ticks);
 	write_unlock_irq(&xtime_lock);
+        return ticks; 
 }
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+void update_real_wall_time(void)
+{
+ 	unsigned long ticks;
+       /*
+         * To get the time of day really right, we need to make sure 
+         * every one is on the same jiffie. (Because of adj_time, etc.)
+         * So we provide this for the high res code.  Must be called 
+         * under the write(xtime_lock).  (External locking allows the
+         * caller to include sub jiffies in the lock region.)
+         */
+ 	ticks = jiffies - wall_jiffies;
+	if (ticks) {
+		wall_jiffies += ticks;
+		update_wall_time(ticks);
+	}
+}
+#endif
 void timer_bh(void)
 {
-	update_times();
-	run_timer_list();
+        unsigned long ticks;
+	ticks = update_times();
+	calc_load(ticks);       /* This is dum.  Change calc_load to a timer */
+ 	run_timer_list();
 }
 
 void do_timer(struct pt_regs *regs)
 {
-	jiffies_64++;
+        update_jiffies();
 #ifndef CONFIG_SMP
 	/* SMP process accounting uses the local APIC timer */
 
-	update_process_times(user_mode(regs));
+	IF_HIGH_RES( if (new_jiffie()))
+                update_process_times(user_mode(regs));
 #endif
 	mark_bh(TIMER_BH);
 	if (TQ_ACTIVE(tq_timer))
@@ -877,10 +1009,31 @@
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
+        NANOSLEEP_ENTRY(	struct timespec t;
+                                unsigned long expire;)
+
+
+                // The following code expects rqtp, rmtp to be available as a result of
+                // the above macro.  Also any regs needed for the _do_signal() macro 
+                // shoule be set up here.
+
+                //asmlinkage long sys_nanosleep(struct timespec *rqtp, 
+                //  struct timespec *rmtp)
+                //  {
+                //    struct timespec t;
+                //    unsigned long expire;
 
 	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
 		return -EFAULT;
@@ -890,8 +1043,9 @@
 
 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
 
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire);
+	do {
+                current->state = TASK_INTERRUPTIBLE;
+        } while((expire = schedule_timeout(expire)) && !_do_signal());
 
 	if (expire) {
 		if (rmtp) {
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-org/net/ipv4/inetpeer.c linux/net/ipv4/inetpeer.c
--- linux-2.5.38-bk5-org/net/ipv4/inetpeer.c	Mon Sep  9 10:35:08 2002
+++ linux/net/ipv4/inetpeer.c	Thu Sep 26 14:33:39 2002
@@ -98,7 +98,7 @@
 
 static void peer_check_expire(unsigned long dummy);
 static struct timer_list peer_periodic_timer =
-	{ { NULL, NULL }, 0, 0, &peer_check_expire };
+	TIMER_INIT( &peer_check_expire );
 
 /* Exported for sysctl_net_ipv4.  */
 int inet_peer_gc_mintime = 10 * HZ,


--------------2DA34975E9119BB1C36C61DC--

