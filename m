Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbSJQXGV>; Thu, 17 Oct 2002 19:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSJQXGV>; Thu, 17 Oct 2002 19:06:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36591 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262408AbSJQXFq>;
	Thu, 17 Oct 2002 19:05:46 -0400
Message-ID: <3DAF4362.EE87F7F1@mvista.com>
Date: Thu, 17 Oct 2002 16:10:26 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH ] POSIX clocks & timers take 3 (NOT HIGH RES)
Content-Type: multipart/mixed;
 boundary="------------62EC33A7CB030B4CCACD446D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------62EC33A7CB030B4CCACD446D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


This, patch implements the POSIX clocks and timers
functions.  The two standard clocks are
defined(CLOCK_REALTIME & CLOCK_MONOTONIC). 

With this version, nano_sleep() is rolled into
clock_nanosleep().  Also a bug fix in clock_nanosleep().

kernel/timer.c is modified to remove the timer_t typedef
which conflicts with the POSIX standard definition for this
type.  

The patch introduces a new kernel source (posix-timers.c)
which contains most of the code.

This implementation defines a timer as a system wide
resource with system wide limits on the number of allocated
timers.  This number can be set at configure time and is
defaulted to 3000.  There
are NO other limits on how many timers a process can have.

Kernel version 2.5.43-bk1

Test programs, man pages and readme files are available
on the sourceforge high-res-timers site: 

http://sourceforge.net/projects/high-res-timers/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------62EC33A7CB030B4CCACD446D
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-2.5.43-bk1-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-2.5.43-bk1-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.43-bk1-kb/arch/i386/kernel/entry.S	Thu Oct 17 15:32:50 2002
+++ linux/arch/i386/kernel/entry.S	Thu Oct 17 15:33:39 2002
@@ -761,6 +761,15 @@
 	.long sys_free_hugepages
 	.long sys_exit_group
 	.long sys_lookup_dcookie
+ 	.long sys_timer_create
+ 	.long sys_timer_settime	  /* 255 */
+ 	.long sys_timer_gettime
+ 	.long sys_timer_getoverrun
+ 	.long sys_timer_delete
+ 	.long sys_clock_settime
+ 	.long sys_clock_gettime	  /* 260 */
+ 	.long sys_clock_getres
+ 	.long sys_clock_nanosleep
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.5.43-bk1-kb/arch/i386/kernel/time.c	Wed Oct 16 00:17:47 2002
+++ linux/arch/i386/kernel/time.c	Thu Oct 17 15:33:39 2002
@@ -131,6 +131,7 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 	write_unlock_irq(&xtime_lock);
+	clock_was_set();
 }
 
 /*
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/fs/exec.c linux/fs/exec.c
--- linux-2.5.43-bk1-kb/fs/exec.c	Wed Oct 16 00:18:07 2002
+++ linux/fs/exec.c	Thu Oct 17 15:33:39 2002
@@ -756,6 +756,7 @@
 			
 	flush_signal_handlers(current);
 	flush_old_files(current->files);
+	exit_itimers(current);
 
 	return 0;
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/asm-generic/siginfo.h linux/include/asm-generic/siginfo.h
--- linux-2.5.43-bk1-kb/include/asm-generic/siginfo.h	Thu Oct 17 15:31:20 2002
+++ linux/include/asm-generic/siginfo.h	Thu Oct 17 15:33:39 2002
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
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/asm-i386/posix_types.h linux/include/asm-i386/posix_types.h
--- linux-2.5.43-bk1-kb/include/asm-i386/posix_types.h	Mon Sep  9 10:35:18 2002
+++ linux/include/asm-i386/posix_types.h	Thu Oct 17 15:33:39 2002
@@ -22,6 +22,8 @@
 typedef long		__kernel_time_t;
 typedef long		__kernel_suseconds_t;
 typedef long		__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int		__kernel_daddr_t;
 typedef char *		__kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/asm-i386/signal.h linux/include/asm-i386/signal.h
--- linux-2.5.43-bk1-kb/include/asm-i386/signal.h	Mon Sep  9 10:35:04 2002
+++ linux/include/asm-i386/signal.h	Thu Oct 17 15:33:39 2002
@@ -219,6 +219,73 @@
 
 struct pt_regs;
 extern int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
+/*
+ * These macros are used by nanosleep() and clock_nanosleep().
+ * The issue is that these functions need the *regs pointer which is 
+ * passed in different ways by the differing archs.
+
+ * Below we do things in two differing ways.  In the long run we would
+ * like to see nano_sleep() go away (glibc should call clock_nanosleep
+ * much as we do).  When that happens and the nano_sleep() system
+ * call entry is retired, there will no longer be any real need for
+ * sys_nanosleep() so the FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP macro
+ * could be undefined, resulting in not needing to stack all the 
+ * parms over again, i.e. better (faster AND smaller) code.
+
+ * And while were at it, there needs to be a way to set the return code
+ * on the way to do_signal().  It (i.e. do_signal()) saves the regs on 
+ * the callers stack to call the user handler and then the return is
+ * done using those registers.  This means that the error code MUST be
+ * set in the register PRIOR to calling do_signal().  See our answer 
+ * below...thanks to  Jim Houston <jim.houston@attbi.com>
+ */
+#define FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
+
+
+#ifdef FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
+extern long do_clock_nanosleep(struct pt_regs *regs, 
+			clockid_t which_clock, 
+			int flags, 
+			const struct timespec *rqtp, 
+			struct timespec *rmtp);
+
+#define NANOSLEEP_ENTRY(a) \
+  asmlinkage long sys_nanosleep( struct timespec* rqtp, \
+                                 struct timespec * rmtp) \
+{       struct pt_regs *regs = (struct pt_regs *)&rqtp; \
+        return do_clock_nanosleep(regs, CLOCK_REALTIME, 0, rqtp, rmtp); \
+} 
+
+#define CLOCK_NANOSLEEP_ENTRY(a) asmlinkage long sys_clock_nanosleep( \
+                               clockid_t which_clock,      \
+                               int flags,                  \
+                               const struct timespec *rqtp, \
+                               struct timespec *rmtp)       \
+{       struct pt_regs *regs = (struct pt_regs *)&which_clock; \
+        return do_clock_nanosleep(regs, which_clock, flags, rqtp, rmtp); \
+} \
+long do_clock_nanosleep(struct pt_regs *regs, \
+                    clockid_t which_clock,      \
+                    int flags,                  \
+                    const struct timespec *rqtp, \
+                    struct timespec *rmtp)       \
+{        a
+
+#else
+#define NANOSLEEP_ENTRY(a) \
+      asmlinkage long sys_nanosleep( struct timespec* rqtp, \
+                                     struct timespec * rmtp) \
+{       struct pt_regs *regs = (struct pt_regs *)&rqtp; \
+        a
+#define CLOCK_NANOSLEEP_ENTRY(a) asmlinkage long sys_clock_nanosleep( \
+                               clockid_t which_clock,      \
+                               int flags,                  \
+                               const struct timespec *rqtp, \
+                               struct timespec *rmtp)       \
+{       struct pt_regs *regs = (struct pt_regs *)&which_clock; \
+        a
+#endif
+#define _do_signal() (regs->eax = -EINTR, do_signal(regs, NULL))
 
 #endif /* __KERNEL__ */
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.43-bk1-kb/include/asm-i386/unistd.h	Wed Oct 16 00:18:16 2002
+++ linux/include/asm-i386/unistd.h	Thu Oct 17 15:33:39 2002
@@ -258,6 +258,15 @@
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
+#define __NR_timer_create	254
+#define __NR_timer_settime	(__NR_timer_create+1)
+#define __NR_timer_gettime	(__NR_timer_create+2)
+#define __NR_timer_getoverrun	(__NR_timer_create+3)
+#define __NR_timer_delete	(__NR_timer_create+4)
+#define __NR_clock_settime	(__NR_timer_create+5)
+#define __NR_clock_gettime	(__NR_timer_create+6)
+#define __NR_clock_getres	(__NR_timer_create+7)
+#define __NR_clock_nanosleep	(__NR_timer_create+8)
   
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/linux/init_task.h linux/include/linux/init_task.h
--- linux-2.5.43-bk1-kb/include/linux/init_task.h	Thu Oct  3 10:42:11 2002
+++ linux/include/linux/init_task.h	Thu Oct 17 15:33:39 2002
@@ -93,6 +93,7 @@
 	.sig		= &init_signals,				\
 	.pending	= { NULL, &tsk.pending.head, {{0}}},		\
 	.blocked	= {{0}},					\
+	 .posix_timers	 = LIST_HEAD_INIT(tsk.posix_timers),		   \
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/linux/posix-timers.h linux/include/linux/posix-timers.h
--- linux-2.5.43-bk1-kb/include/linux/posix-timers.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/posix-timers.h	Thu Oct 17 15:33:39 2002
@@ -0,0 +1,18 @@
+#ifndef _linux_POSIX_TIMERS_H
+#define _linux_POSIX_TIMERS_H
+
+struct k_clock {
+	 int  res;		    /* in nano seconds */
+	 int ( *clock_set)(struct timespec *tp);
+	 int ( *clock_get)(struct timespec *tp);
+	 int ( *nsleep)(   int flags, 
+			   struct timespec*new_setting,
+			   struct itimerspec *old_setting);
+	 int ( *timer_set)(struct k_itimer *timr, int flags,
+			   struct itimerspec *new_setting,
+			   struct itimerspec *old_setting);
+	 int  ( *timer_del)(struct k_itimer *timr);
+	 void ( *timer_get)(struct k_itimer *timr,
+			   struct itimerspec *cur_setting);
+};
+#endif
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.43-bk1-kb/include/linux/sched.h	Wed Oct 16 00:18:17 2002
+++ linux/include/linux/sched.h	Thu Oct 17 15:33:39 2002
@@ -278,6 +278,30 @@
 typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 
+/* POSIX.1b interval timer structure. */
+struct k_itimer {
+	struct list_head list;		 /* free/ allocate list */
+	spinlock_t it_lock;
+	clockid_t it_clock;		/* which timer type */
+	timer_t it_id;			/* timer id */
+	int it_overrun;			/* overrun on pending signal  */
+	int it_overrun_last;		 /* overrun on last delivered signal */
+	int it_overrun_deferred;	 /* overrun on pending timer interrupt */
+	int it_sigev_notify;		 /* notify word of sigevent struct */
+	int it_sigev_signo;		 /* signo word of sigevent struct */
+	sigval_t it_sigev_value;	 /* value word of sigevent struct */
+	unsigned long it_incr;		/* interval specified in jiffies */
+#ifdef CONFIG_HIGH_RES_TIMERS
+	 int it_sub_incr;		 /* sub jiffie part of interval */
+#endif
+	struct task_struct *it_process;	/* process to send signal to */
+	struct timer_list it_timer;
+};
+
+
+//extern struct itimer_struct *itimer_struct_new(void);
+extern void itimer_delete(struct k_itimer *timers);
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -343,6 +367,7 @@
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
+	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
@@ -647,6 +672,7 @@
 
 extern void exit_mm(struct task_struct *);
 extern void exit_files(struct task_struct *);
+extern void exit_itimers(struct task_struct *);
 extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/linux/signal.h linux/include/linux/signal.h
--- linux-2.5.43-bk1-kb/include/linux/signal.h	Mon Sep  9 10:35:04 2002
+++ linux/include/linux/signal.h	Thu Oct 17 15:33:39 2002
@@ -224,6 +224,36 @@
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs);
 #endif
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
+
 
 #endif /* __KERNEL__ */
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/linux/sys.h linux/include/linux/sys.h
--- linux-2.5.43-bk1-kb/include/linux/sys.h	Mon Sep  9 10:35:09 2002
+++ linux/include/linux/sys.h	Thu Oct 17 15:33:39 2002
@@ -4,7 +4,7 @@
 /*
  * system call entry points ... but not all are defined
  */
-#define NR_syscalls 256
+#define NR_syscalls 275
 
 /*
  * These are system calls that will be removed at some time
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.43-bk1-kb/include/linux/time.h	Wed Sep 18 17:04:09 2002
+++ linux/include/linux/time.h	Thu Oct 17 15:33:39 2002
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
@@ -124,6 +137,8 @@
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern void do_settimeofday(struct timeval *tv);
+extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
+extern void clock_was_set(void); // call when ever the clock is set
 #endif
 
 #define FD_SETSIZE		__FD_SETSIZE
@@ -149,5 +164,25 @@
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/include/linux/types.h linux/include/linux/types.h
--- linux-2.5.43-bk1-kb/include/linux/types.h	Tue Oct 15 15:43:06 2002
+++ linux/include/linux/types.h	Thu Oct 17 15:33:39 2002
@@ -23,6 +23,8 @@
 typedef __kernel_daddr_t	daddr_t;
 typedef __kernel_key_t		key_t;
 typedef __kernel_suseconds_t	suseconds_t;
+typedef __kernel_timer_t	timer_t;
+typedef __kernel_clockid_t	clockid_t;
 
 #ifdef __KERNEL__
 typedef __kernel_uid32_t	uid_t;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/init/Config.help linux/init/Config.help
--- linux-2.5.43-bk1-kb/init/Config.help	Mon Sep  9 10:35:01 2002
+++ linux/init/Config.help	Thu Oct 17 15:33:39 2002
@@ -115,3 +115,11 @@
   replacement for kerneld.) Say Y here and read about configuring it
   in <file:Documentation/kmod.txt>.
 
+Maximum number of POSIX timers
+CONFIG_MAX_POSIX_TIMERS
+  This option allows you to configure the system wide maximum number of
+  POSIX timers.  Timers are allocated as needed so the only memory
+  overhead this adds is about 4 bytes for every 50 or so timers to keep
+  track of each block of timers.  The system quietly rounds this number
+  up to fill out a timer allocation block.  It is ok to have several
+  thousand timers as needed by your applications.
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/init/Config.in linux/init/Config.in
--- linux-2.5.43-bk1-kb/init/Config.in	Mon Sep  9 10:35:03 2002
+++ linux/init/Config.in	Thu Oct 17 15:33:39 2002
@@ -9,6 +9,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+int 'System wide maximum number of POSIX timers' CONFIG_MAX_POSIX_TIMERS 3000
 endmenu
 
 mainmenu_option next_comment
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/kernel/Makefile linux/kernel/Makefile
--- linux-2.5.43-bk1-kb/kernel/Makefile	Wed Oct 16 00:18:18 2002
+++ linux/kernel/Makefile	Thu Oct 17 15:33:39 2002
@@ -10,7 +10,7 @@
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o \
-	    rcupdate.o
+	    rcupdate.o posix-timers.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/kernel/exit.c linux/kernel/exit.c
--- linux-2.5.43-bk1-kb/kernel/exit.c	Wed Oct 16 00:18:18 2002
+++ linux/kernel/exit.c	Thu Oct 17 15:33:39 2002
@@ -410,6 +410,21 @@
 	mmdrop(active_mm);
 }
 
+static inline void __exit_itimers(struct task_struct *tsk)
+{
+	struct	k_itimer *tmr;
+
+	while (tsk->posix_timers.next != &tsk->posix_timers){
+		 tmr = list_entry(tsk->posix_timers.next,struct k_itimer,list);
+		itimer_delete(tmr);
+	}
+}
+
+void exit_itimers(struct task_struct *tsk)
+{
+	__exit_itimers(tsk);
+}
+
 /*
  * Turn us into a lazy TLB process if we
  * aren't already..
@@ -647,6 +662,7 @@
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_namespace(tsk);
+	__exit_itimers(tsk);
 	exit_thread();
 
 	if (current->leader)
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/kernel/fork.c linux/kernel/fork.c
--- linux-2.5.43-bk1-kb/kernel/fork.c	Tue Oct 15 15:43:07 2002
+++ linux/kernel/fork.c	Thu Oct 17 15:33:39 2002
@@ -783,6 +783,7 @@
 		goto bad_fork_cleanup_files;
 	if (copy_sighand(clone_flags, p))
 		goto bad_fork_cleanup_fs;
+	INIT_LIST_HEAD(&p->posix_timers);
 	if (copy_mm(clone_flags, p))
 		goto bad_fork_cleanup_sighand;
 	if (copy_namespace(clone_flags, p))
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.43-bk1-kb/kernel/posix-timers.c	Wed Dec 31 16:00:00 1969
+++ linux/kernel/posix-timers.c	Thu Oct 17 15:33:39 2002
@@ -0,0 +1,1288 @@
+/*
+ * linux/kernel/posix_timers.c
+ *
+ * 
+ * 2002-10-15  Posix Clocks & timers by George Anzinger
+ *			     Copyright (C) 2002 by MontaVista Software.
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
+#include <linux/posix-timers.h>
+#include <linux/nmi.h>
+#include <linux/compiler.h>
+
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
+/*
+ * Management arrays for POSIX timers.	 Timers are kept in memory that
+ * is allocated a CHUNCK at a time.  Pointers to the CHUNCKS are kept in
+ * an array of pointers.  A bit map is kept of CHUNCKS that have free
+ * timers.  Allocation is always made from the first CHUNCK that has a
+ * free timer.	 Timers in CHUNCKS are kept in a free list, which is
+ * unordered.	A count of free timers in a CHUNCK is kept and when all
+ * timers in a CHUNCK are free, the CHUNCK memory is returned and the
+ * CHUNCK is marked empty in the bit map.  The free slot in the CHUNCK
+ * array is linked into the free list for CHUNCK pointers. 
+ */
+/*
+ * First lets abstract the memory interface.
+ */
+#define get_timer_chunck()(struct posix_timer_chunck *)__get_free_page(GFP_KERNEL)
+#define free_timer_chunck(p) free_page((unsigned long)p)
+#define POSIX_TIMERS_CHUNCK_SIZE (PAGE_SIZE)
+
+#undef NULL
+#define NULL ((void *)0)
+#define CONFIGURE_MIN_INTERVAL 500000
+/*
+ * Love to make this offsetof((struct posix_timer_chunck).timers) or
+ * some such but that is recursive... 
+ */
+#define CHUNCK_OVERHEAD (sizeof(struct list_head) + sizeof(int)	 + sizeof(int)) 
+#define NUM_POSIX_TIMERS_PER_CHUNCK \
+	  ((POSIX_TIMERS_CHUNCK_SIZE - CHUNCK_OVERHEAD)/ sizeof(struct k_itimer))
+
+struct posix_timer_chunck {
+	 struct list_head free_list;
+	 int used_count;
+	 int index;
+	 struct k_itimer  timers[NUM_POSIX_TIMERS_PER_CHUNCK];
+};
+
+#define NUM_CHUNCKS_POSIX_TIMERS \
+	      (1 + (CONFIG_MAX_POSIX_TIMERS /  NUM_POSIX_TIMERS_PER_CHUNCK))
+#define MAX_POSIX_TIMERS NUM_CHUNCKS_POSIX_TIMERS * NUM_POSIX_TIMERS_PER_CHUNCK
+#define CHUNCK_SHIFT 8
+#define CHUNCK_MASK ((1 << CHUNCK_SHIFT) - 1)
+
+
+/*
+ * Just because the timer is not in the timer list does NOT mean it is
+ * inactive.  It could be in the "fire" routine getting a new expire time.
+ */
+#define TIMER_INACTIVE 1
+#define TIMER_RETRY 1
+#ifdef CONFIG_SMP
+#define timer_active(tmr) (tmr->it_timer.entry.prev != (void *)TIMER_INACTIVE)
+#define set_timer_inactive(tmr) tmr->it_timer.entry.prev = (void *)TIMER_INACTIVE
+#else
+#define timer_active(tmr) BARFY	   // error to use outside of SMP
+#define set_timer_inactive(tmr)
+#endif
+/*
+ * Lets talk.
+ *
+ * The following structure is the root of the posix timers data.  The
+ * <list_lock> is taken when ever we are allocating or releasing a timer
+ * structure.	Since we allocate memory for this, we use a semaphore
+ * (memory allocate can block).
+ *
+ * The <free_list> is an array index into the <chuncks> array.	 If a
+ * <chunck> is populated, the array element will point to a struct
+ * posix_timer_chunck which will be the allocated memory block.	 If the
+ * <chunck> is not populated it will contain an array index to the next
+ * free <chunck>, or if there are no more it will be
+ * NUM_CHUNCKS_POSIX_TIMERS, which is too high to be an array index
+ * (this fact is used to verify that a <chunck> is populated and that we
+ * have reached the end of free <chuncks>.
+ *
+ * NOTE- We are not doing any post "settime" processing for abs timers at
+ *	   this time and so, these next two entries are not defined. 
+ */
+#define IF_ABS_TIME_ADJ(a)
+#if 0	 // We are not doing this at this time (ever?).
+ /*
+ * The <abs_list> is a list of all active (some fudging on this, see the
+ * code) timers that are tagged as absolute.  Active absolute timers
+ * need to have their expire time adjusted when ever the system time of
+ * day clock is set or adjusted.
+  *
+ * The <abs_list_lock> is used to protect entries and exits from the <abs_list>.
+ * Since timer expiration is an interrupt driven event this spinlock must be
+ * an irq type.
+ */
+#endif
+/*
+ * The <chuncks> array is described above.  The timer ID is composed of
+ * the <chuncks> index and the array index of <timers> in that chunck.
+ * Verifying a valid ID consists of:
+ * 
+ * a) checking that the chunck index is < NUM_CHUNCKS_POSIX_TIMERS and 
+ * b) that that chunck is allocated (i.e. the <chuncks> array entry 
+ *    is > NUM_CHUNCKS_POSIX_TIMERS) and 
+ * c) that the <timers> index is in bounds and
+ * d) that the timer owner is in the callers thread group.
+ */
+
+static struct {
+	 struct	 semaphore	      list_lock;
+	 int			      free_list;
+	 IF_ABS_TIME_ADJ(
+			 struct list_head	      abs_list;
+			 spinlock_t		      abs_list_lock;
+			 )
+	 union {
+		 struct	 posix_timer_chunck * chunck[NUM_CHUNCKS_POSIX_TIMERS];
+		 int		       free_ent[NUM_CHUNCKS_POSIX_TIMERS];
+	 }				    chunck_free;
+} posix_timers = { list_lock:	   __MUTEX_INITIALIZER( posix_timers.list_lock)
+
+#define chuncks chunck_free.chunck
+#define free	 chunck_free. \
+		      free_ent
+#ifdef ABS_TIMERS_ADJ
+		    ,abs_list:	    LIST_HEAD_INIT(posix_timers.abs_list)
+		    ,abs_list_lock: SPIN_LOCK_UNLOCKED
+#endif
+};
+
+/*
+ * The tmr_bit_ary is a bit array in which a bit is assigned for each
+ * entry in <posix_timers.chunck[]>.  A set bit indicates that the
+ * chunck has one or more free timers.	 This makes it easy to quickly
+ * find a free timer.
+ */
+static struct {
+	 unsigned long tmr_bit_ary[((NUM_CHUNCKS_POSIX_TIMERS)/32) +1];
+	 unsigned long guard;
+}tmr_bits = {guard: -1};
+#define tmr_bit_map tmr_bits.tmr_bit_ary   
+#define BF 31	/* bit flip constant */
+#define	  set_tmr_bit(bit)    set_bit(((bit)&0x1f),&tmr_bit_map[(bit) >> 5])
+#define clear_tmr_bit(bit)  clear_bit(((bit)&0x1f),&tmr_bit_map[(bit) >> 5])
+
+DECLARE_MUTEX(posix_timers_mutex);
+#define mutex_enter(x) down(x)
+#define mutex_enter_interruptable(x) down_interruptible(x)
+#define mutex_exit(x) up(x)
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
+struct k_clock posix_clocks[MAX_CLOCKS];
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
+static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
+
+int do_posix_clock_monotonic_gettime(struct timespec *tp);
+
+int do_posix_clock_monotonic_settime(struct timespec *tp);
+
+/* 
+ * Build the free list
+ */
+
+static	 __init int init_posix_timers(void)
+{
+	int i;
+	struct k_clock clock_realtime = {res: NSEC_PER_SEC/HZ};
+	struct k_clock clock_monotonic = 
+	{res: NSEC_PER_SEC/HZ,
+	 clock_get:  do_posix_clock_monotonic_gettime, 
+	 clock_set: do_posix_clock_monotonic_settime};
+
+	for ( i = 0; i < NUM_CHUNCKS_POSIX_TIMERS;) {
+		posix_timers.free[i] = ++i; 
+	}
+	register_posix_clock(CLOCK_REALTIME,&clock_realtime);
+	register_posix_clock(CLOCK_MONOTONIC,&clock_monotonic);
+	return 0;
+}
+
+__initcall(init_posix_timers);
+
+static inline int tstojiffie(struct timespec *tp, 
+			     int res,
+			     unsigned long *jiff)
+{
+	unsigned long sec = tp->tv_sec;
+	long nsec = tp->tv_nsec + res - 1;
+
+	/*
+	 * A note on jiffy overflow: It is possible for the system to
+	 * have been up long enough for the jiffies quanity to overflow.
+	 * In order for correct timer evaluations we require that the
+	 * specified time be somewhere between now and now + (max
+	 * unsigned int/2).  Times beyond this will be truncated back to
+	 * this value.	 This is done in the absolute adjustment code,
+	 * below.  Here it is enough to just discard the high order
+	 * bits.  
+	 */
+	*jiff = HZ * sec;
+	/*
+	 * Do the res thing. (Don't forget the add in the declaration of nsec) 
+	 */
+	nsec -= nsec % res;
+	/*
+	 * Split to jiffie and sub jiffie
+	 */
+	*jiff += nsec / (NSEC_PER_SEC / HZ);
+	/*
+	 * We trust that the optimizer will use the remainder from the 
+	 * above div in the following operation as long as they are close. 
+	 */
+	return	0;
+}
+static void tstotimer(struct itimerspec * time, struct k_itimer * timer)
+{
+	int res = posix_clocks[timer->it_clock].res;
+	tstojiffie(&time->it_value,
+		   res,
+		   &timer->it_timer.expires);
+	tstojiffie(&time->it_interval,
+		   res,
+		   &timer->it_incr);
+}
+ 
+
+
+/* PRECONDITION:
+ * timr->it_lock must be locked
+ */
+
+static void timer_notify_task(struct k_itimer *timr)
+{
+	struct siginfo info;
+	int ret;
+
+	if (! (timr->it_sigev_notify & SIGEV_NONE)) {
+
+		memset(&info, 0, sizeof(info));
+
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
+			printk(KERN_WARNING "sending signal failed: %d\n", ret);
+			break;
+		}
+	}
+}
+
+/* 
+ * Notify the task and set up the timer for the next expiration (if applicable).
+ * This function requires that the k_itimer structure it_lock is taken.
+ */
+static void posix_timer_fire(struct k_itimer *timr)
+{
+	unsigned long interval;
+
+	timer_notify_task(timr);
+
+	/* Set up the timer for the next interval (if there is one) */
+	if ((interval = timr->it_incr) == 0){
+		{
+			set_timer_inactive(timr);
+			return;
+		}
+	}
+	if (interval > (unsigned long) LONG_MAX)
+		interval = LONG_MAX;
+	timr->it_timer.expires += interval;
+	add_timer(&timr->it_timer);
+}
+
+/*
+ * This function gets called when a POSIX.1b interval timer expires.
+ * It is used as a callback from the kernel internal timer.
+ * The run_timer_list code ALWAYS calls with interrutps on.
+ */
+static void posix_timer_fn(unsigned long __data)
+{
+	struct k_itimer *timr = (struct k_itimer *)__data;
+
+	spin_lock_irq(&timr->it_lock);
+	posix_timer_fire(timr);
+	spin_unlock_irq(&timr->it_lock);
+}
+/*
+ * For some reason mips/mips64 define the SIGEV constants plus 128.  
+ * Here we define a mask to get rid of the common bits.	 The 
+ * optimizer should make this costless to all but mips.
+ */
+#if (ARCH == mips) || (ARCH == mips64)
+#define MIPS_SIGEV ~(SIGEV_NONE & \
+		      SIGEV_SIGNAL & \
+		      SIGEV_THREAD &  \
+		      SIGEV_THREAD_ID)
+#else
+#define MIPS_SIGEV (int)-1
+#endif
+
+static inline struct task_struct * good_sigevent(sigevent_t *event)
+{
+	struct task_struct * rtn = current;
+
+	if (event->sigev_notify & SIGEV_THREAD_ID & MIPS_SIGEV ) {
+		if ( !(rtn = 
+		       find_task_by_pid(event->sigev_notify_thread_id)) ||
+		     rtn->tgid != current->tgid){
+			return NULL;
+		}
+	}
+	if (event->sigev_notify & SIGEV_SIGNAL & MIPS_SIGEV) {
+		if ((unsigned)(event->sigev_signo > SIGRTMAX))
+			return NULL;
+	}
+	if (event->sigev_notify & ~(SIGEV_SIGNAL | SIGEV_THREAD_ID )) {
+		return NULL;
+	}
+	return rtn;
+}
+
+
+void register_posix_clock(int clock_id,struct k_clock * new_clock)
+{
+	if ( (unsigned)clock_id >= MAX_CLOCKS){
+		printk("POSIX clock register failed for clock_id %d\n",clock_id);
+		return;
+	}
+	posix_clocks[clock_id] = *new_clock;
+}
+
+static struct k_itimer * alloc_posix_timer(void)
+{
+	struct k_itimer * tmr;
+	struct posix_timer_chunck *chunck, **chunck_ptr;
+	int i, open;
+	unsigned long *ip;
+	/*
+	 * kmalloc sleeps so we must use a mutex, not a spinlock
+	 */
+	mutex_enter(&posix_timers.list_lock);
+
+	for (ip = &tmr_bit_map[0], open = 0; (*ip == 0); open +=32,ip++);
+	open += ffz(~*ip);
+	if (open > NUM_CHUNCKS_POSIX_TIMERS){
+		/* 
+		 * No free timers, try to allocate some memory
+		 */
+		if (posix_timers.free_list != NUM_CHUNCKS_POSIX_TIMERS){
+			chunck = get_timer_chunck();
+			if ( ! chunck ){
+				mutex_exit(&posix_timers.list_lock);
+				return NULL;
+			} else {
+				chunck_ptr = &posix_timers.
+					chuncks[posix_timers.free_list];
+				posix_timers.free_list = posix_timers.
+					free[posix_timers.free_list];
+				*chunck_ptr = chunck;
+				chunck->index = chunck_ptr - 
+					&posix_timers.chuncks[0];
+				chunck->used_count = 1;
+				INIT_LIST_HEAD(&chunck->free_list);
+				for ( i = 0,tmr = &chunck->timers[0];
+				      i < NUM_POSIX_TIMERS_PER_CHUNCK;
+				      i++, tmr++){
+					list_add(&tmr->list, 
+						 &chunck->free_list);
+					tmr->it_id = 
+						(timer_t)( 
+							(chunck->index << 
+							 CHUNCK_SHIFT) + i);
+					tmr->it_process = NULL;
+				}
+				--tmr;
+				list_del(&tmr->list);
+				set_tmr_bit( chunck->index);
+				mutex_exit(&posix_timers.list_lock);
+				return	 tmr;
+			}
+		} else {
+			/*
+			 * max number of timers is already allocated
+			 */
+			mutex_exit(&posix_timers.list_lock);
+			return NULL;
+		}
+	} else {
+		/*
+		 * we have a partically allocated chunck
+		 */
+		chunck = posix_timers.chuncks[open];
+		chunck->used_count++;
+		if (chunck->used_count == NUM_POSIX_TIMERS_PER_CHUNCK){
+			clear_tmr_bit(open);
+		}
+		tmr = list_entry(chunck->free_list.next,struct k_itimer,list);
+		list_del(&tmr->list);
+		mutex_exit(&posix_timers.list_lock);
+		return	 tmr;
+	}
+}
+
+static void release_posix_timer(struct k_itimer * tmr)
+{
+	int index = tmr->it_id >> CHUNCK_SHIFT;
+	struct posix_timer_chunck *chunck = posix_timers.chuncks[index];
+
+	mutex_enter(&posix_timers.list_lock);
+	list_add_tail(&tmr->list, &chunck->free_list);
+	tmr->it_process = NULL;
+	if ( --chunck->used_count == 0){
+		int i;
+		for ( i = 0; i < NUM_POSIX_TIMERS_PER_CHUNCK; i++) {
+			list_del(&chunck->timers[i].list);
+		}
+		free_timer_chunck(chunck);
+		posix_timers.free[index] = posix_timers.free_list;
+		posix_timers.free_list = index;
+		clear_tmr_bit(index);
+	}
+	mutex_exit(&posix_timers.list_lock);
+}	  
+			 
+/* Create a POSIX.1b interval timer. */
+
+asmlinkage int sys_timer_create(clockid_t which_clock,
+				struct sigevent *timer_event_spec,
+				timer_t *created_timer_id)
+{
+	int error = 0;
+	struct k_itimer *new_timer = NULL;
+	int new_timer_id;
+	struct task_struct * process = current;
+	sigevent_t event;
+
+	/* Right now, we only support CLOCK_REALTIME for timers. */
+	if ((unsigned)which_clock >= MAX_CLOCKS || 
+	    ! posix_clocks[which_clock].res) return -EINVAL;
+
+	new_timer = alloc_posix_timer();
+	if (new_timer == NULL) return -EAGAIN;
+
+	spin_lock_init(&new_timer->it_lock);
+	IF_ABS_TIME_ADJ(INIT_LIST_HEAD(&new_timer->abs_list));
+	if (timer_event_spec) {
+		if (copy_from_user(&event, timer_event_spec,
+				   sizeof(event))) {
+			error = -EFAULT;
+			goto out;
+		}
+		if ((process = good_sigevent(&event)) == NULL) {
+			error = -EINVAL;
+			goto out;
+		}
+		new_timer->it_sigev_notify = event.sigev_notify;
+		new_timer->it_sigev_signo = event.sigev_signo;
+		new_timer->it_sigev_value = event.sigev_value;
+	}
+	else {
+		new_timer->it_sigev_notify = SIGEV_SIGNAL;
+		new_timer->it_sigev_signo = SIGALRM;
+		new_timer->it_sigev_value.sival_int = new_timer->it_id;
+	}
+
+	new_timer->it_clock = which_clock;
+	new_timer->it_incr = 0;
+	new_timer->it_overrun = 0;
+	init_timer (&new_timer->it_timer);
+	new_timer->it_timer.expires = 0;
+	new_timer->it_timer.data = (unsigned long) new_timer;
+	new_timer->it_timer.function = posix_timer_fn;
+	set_timer_inactive(new_timer);
+
+	new_timer_id = new_timer->it_id;
+
+	if (copy_to_user(created_timer_id, 
+			 &new_timer_id, 
+			 sizeof(new_timer_id))) {
+		error = -EFAULT;
+		goto out;
+	}
+	spin_lock(&process->alloc_lock);
+	list_add(&new_timer->list, &process->posix_timers);
+
+	spin_unlock(&process->alloc_lock);
+	/*
+	 * Once we set the process, it can be found so do it last...
+	 */
+	new_timer->it_process = process;
+
+ out:
+	if (error) {
+		release_posix_timer(new_timer);
+	}
+	return error;
+}
+
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
+	struct k_itimer *timr = NULL;
+	int chunck_index = (int)((unsigned)timer_id >> CHUNCK_SHIFT);
+	int chunck_offset = timer_id & CHUNCK_MASK;
+	struct task_struct *owner = NULL;
+
+	mutex_enter(&posix_timers.list_lock);
+	if ( chunck_index >= NUM_CHUNCKS_POSIX_TIMERS || 
+	     chunck_offset >=	NUM_POSIX_TIMERS_PER_CHUNCK ||
+	     posix_timers.free[chunck_index] <= NUM_CHUNCKS_POSIX_TIMERS){
+		timr = NULL;
+		goto lock_timer_exit;
+	}
+	timr = &(posix_timers.chuncks[chunck_index]->timers[chunck_offset]);
+	/*
+	 * It would be better if we had a thread group structure to keep,
+	 * among other things, the head of the owned timers list
+	 * and which could be pointed to by the owners field in the timer
+	 * structure.	Failing that, check to see if owner is one of
+	 * the thread group. Protect against stale timer ids.
+	 */
+	if (timr->it_id != timer_id) {
+		BUG();
+	}
+	if ( ! (owner = timr->it_process) || owner->tgid != current->tgid){ 
+		timr = NULL;
+	}else{
+
+		spin_lock_irq(&timr->it_lock);
+		/*
+		 * Suppose while we were spining, the timer was deleted...
+		 * AND maybe even given to some other process...
+		 * Well, it just can not happen because we hold the mutex!
+		 * AND, now we have the lock.
+		 */
+	}
+ lock_timer_exit:
+	mutex_exit(&posix_timers.list_lock);
+	return timr;
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
+	long sub_expires;
+	unsigned long expires;
+
+	do {
+		expires = timr->it_timer.expires;  
+	} while ((volatile long)(timr->it_timer.expires) != expires);
+
+	if (expires && timer_pending(&timr->it_timer)){
+		expires -= jiffies;
+	}else{
+		sub_expires = expires = 0;
+	}
+
+	jiffies_to_timespec(expires, &cur_setting->it_value);
+	jiffies_to_timespec(timr->it_incr, &cur_setting->it_interval);
+
+	if (cur_setting->it_value.tv_sec < 0){
+		cur_setting->it_value.tv_nsec = 1;
+		cur_setting->it_value.tv_sec = 0;
+	}				 
+}
+/* Get the time remaining on a POSIX.1b interval timer. */
+asmlinkage int sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
+{
+	struct k_itimer *timr;
+	struct itimerspec cur_setting;
+
+	timr = lock_timer(timer_id);
+	if (!timr) return -EINVAL;
+
+	p_timer_get(&posix_clocks[timr->it_clock],timr, &cur_setting);
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
+/* Adjust for absolute time */
+/*
+ * If absolute time is given and it is not CLOCK_MONOTONIC, we need to
+ * adjust for the offset between the timer clock (CLOCK_MONOTONIC) and
+ * what ever clock he is using.
+ *
+ * If it is relative time, we need to add the current (CLOCK_MONOTONIC)
+ * time to it to get the proper time for the timer.
+ */
+static int  adjust_abs_time(struct k_clock *clock,struct timespec *tp, int abs)
+{
+	struct timespec now;
+	struct timespec oc;
+	do_posix_clock_monotonic_gettime(&now);
+
+	if ( abs &&
+	     (posix_clocks[CLOCK_MONOTONIC].clock_get == clock->clock_get)){ 
+	}else{
+
+		if (abs){
+			do_posix_gettime(clock,&oc);
+		}else{
+			oc.tv_nsec = oc.tv_sec =0;
+		}
+		tp->tv_sec += now.tv_sec - oc.tv_sec;
+		tp->tv_nsec += now.tv_nsec - oc.tv_nsec;
+
+		/* 
+		 * Normalize...
+		 */
+		if (( tp->tv_nsec - NSEC_PER_SEC) >= 0){
+			tp->tv_nsec -= NSEC_PER_SEC;
+			tp->tv_sec++;
+		}
+		if (( tp->tv_nsec ) < 0){
+			tp->tv_nsec += NSEC_PER_SEC;
+			tp->tv_sec--;
+		}
+	}
+	/*
+	 * Check if the requested time is prior to now (if so set now) or
+	 * is more than the timer code can handle (if so we error out).
+	 * The (unsigned) catches the case of prior to "now" with the same
+	 * test.  Only on failure do we sort out what happened, and then
+	 * we use the (unsigned) to error out negative seconds.
+	 */
+	if ((unsigned)(tp->tv_sec - now.tv_sec) > (MAX_JIFFY_OFFSET / HZ)){
+		if ( (unsigned)tp->tv_sec < now.tv_sec){
+			tp->tv_sec = now.tv_sec;
+			tp->tv_nsec = now.tv_nsec;
+		}else{
+			// tp->tv_sec = now.tv_sec + (MAX_JIFFY_OFFSET / HZ);
+			/*
+			 * This is a considered response, not exactly in
+			 * line with the standard (in fact it is silent on
+			 * possible overflows).  We assume such a large 
+			 * value ALMOST always is a programming error and
+			 * try not to compound it by setting a really dumb
+			 * value.
+			 */ 
+			return -EINVAL;
+		}
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
+	struct k_clock * clock = &posix_clocks[timr->it_clock];
+
+	if (old_setting) {
+		do_timer_gettime(timr, old_setting);
+	}
+
+	/* disable the timer */
+	timr->it_incr = 0;
+	/* 
+	 * careful here.  If smp we could be in the "fire" routine which will
+	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
+	 */
+#ifdef CONFIG_SMP
+	if ( timer_active(timr) && ! del_timer(&timr->it_timer)){
+		/*
+		 * It can only be active if on an other cpu.  Since
+		 * we have cleared the interval stuff above, it should
+		 * clear once we release the spin lock.  Of course once
+		 * we do that anything could happen, including the 
+		 * complete melt down of the timer.  So return with 
+		 * a "retry" exit status.
+		 */
+		return TIMER_RETRY;
+	}
+	set_timer_inactive(timr);
+#else
+	del_timer(&timr->it_timer);
+#endif
+	/* switch off the timer when it_value is zero */
+	if ((new_setting->it_value.tv_sec == 0) &&
+	    (new_setting->it_value.tv_nsec == 0)) {
+		timr->it_timer.expires = 0;
+		return 0;
+	}
+
+	if ((flags & TIMER_ABSTIME) && 
+	    (clock->clock_get != do_posix_clock_monotonic_gettime)) {
+		//timr->it_timer.abs = TIMER_ABSTIME;
+	}else{
+		// timr->it_timer.abs = 0;
+	}
+	if( adjust_abs_time(clock,
+			    &new_setting->it_value,
+			    flags & TIMER_ABSTIME)){
+		return -EINVAL;
+	}
+	tstotimer(new_setting,timr);
+
+	/*
+	 * For some reason the timer does not fire immediately if expires is
+	 * equal to jiffies, so the timer callback function is called directly.
+	 */
+	if (timr->it_timer.expires == jiffies) {
+		posix_timer_fire(timr);
+		return 0;
+	}
+	timr->it_overrun_deferred = 
+		timr->it_overrun_last = 
+		timr->it_overrun = 0;
+	add_timer(&timr->it_timer);
+	return 0;
+}
+
+
+/* Set a POSIX.1b interval timer */
+asmlinkage int sys_timer_settime(timer_t timer_id, int flags,
+				 const struct itimerspec *new_setting,
+				 struct itimerspec *old_setting)
+{
+	struct k_itimer *timr;
+	struct itimerspec new_spec, old_spec;
+	int error = 0;
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
+ retry:
+	timr = lock_timer( timer_id);
+	if (!timr) return -EINVAL;
+
+	if (! posix_clocks[timr->it_clock].timer_set) {
+		error = do_timer_settime(timr, flags, &new_spec, rtn );
+	}else{
+		error = posix_clocks[timr->it_clock].timer_set(timr, 
+							       flags, 
+							       &new_spec, 
+							       rtn );
+	}
+	unlock_timer(timr);
+	if ( error == TIMER_RETRY){
+		rtn = NULL;	    // We already got the old time...
+		goto retry;
+	}
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
+	timer->it_incr = 0;
+#ifdef CONFIG_SMP
+	if ( timer_active(timer) && ! del_timer(&timer->it_timer)){
+		/*
+		 * It can only be active if on an other cpu.  Since
+		 * we have cleared the interval stuff above, it should
+		 * clear once we release the spin lock.  Of course once
+		 * we do that anything could happen, including the 
+		 * complete melt down of the timer.  So return with 
+		 * a "retry" exit status.
+		 */
+		return TIMER_RETRY;
+	}
+#else
+	del_timer(&timer->it_timer);
+#endif
+	return 0;
+}
+
+/* Delete a POSIX.1b interval timer. */
+asmlinkage int sys_timer_delete(timer_t timer_id)
+{
+	struct k_itimer *timer;
+
+#ifdef CONFIG_SMP
+	int error;
+ retry_delete:
+#endif
+
+	timer = lock_timer( timer_id);
+	if (!timer) return -EINVAL;
+
+#ifdef CONFIG_SMP
+	error =	 p_timer_del(&posix_clocks[timer->it_clock],timer);
+
+	if (error == TIMER_RETRY) {
+		unlock_timer(timer);
+		goto retry_delete;
+	}
+#else
+	p_timer_del(&posix_clocks[timer->it_clock],timer);
+#endif
+
+	spin_lock(&timer->it_process->alloc_lock);
+
+	list_del(&timer->list);
+
+	spin_unlock(&timer->it_process->alloc_lock);
+
+	IF_ABS_TIME_ADJ(
+		spin_lock(&abs_list_lock);
+
+		if (! list_empty(&timer->abs_list)){
+
+			list_del(&timer->abs_list);
+		}
+		spin_unlock( &abs_list_lock); 
+		);
+	/*
+	 * This keeps any tasks waiting on the spin lock from thinking
+	 * they got something (see the lock code above).
+	 */
+	timer->it_process = NULL;
+	unlock_timer(timer);
+	release_posix_timer(timer);
+	return 0;
+}
+/*
+ * return  timer owned by the process, used by exit and exec
+ */
+void itimer_delete(struct k_itimer *timer)
+{
+	if (sys_timer_delete(timer->it_id)){
+		BUG();
+	}
+}
+/*
+ * And now for the "clock" calls
+
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
+	do_gettimeofday((struct timeval*)tp);
+	tp->tv_nsec *= NSEC_PER_USEC;
+	return 0;
+}
+
+/*
+ * We do ticks here to avoid the irq lock ( they take sooo long)
+ * Note also that the while loop assures that the sub_jiff_offset
+ * will be less than a jiffie, thus no need to normalize the result.
+ * Well, not really, if called with ints off :(
+ */
+
+int do_posix_clock_monotonic_gettime(struct timespec *tp)
+{
+	long sub_sec;
+	u64 jiffies_64_f;
+
+#if (BITS_PER_LONG > 32) 
+
+	jiffies_64_f = jiffies_64;
+
+#elif defined(CONFIG_SMP)
+
+	/* Tricks don't work here, must take the lock.	 Remember, called
+	 * above from both timer and clock system calls => save flags.
+	 */
+	{
+		unsigned long flags;
+		read_lock_irqsave(&xtime_lock, flags);
+		jiffies_64_f = jiffies_64;
+
+
+		read_unlock_irqrestore(&xtime_lock, flags);
+	}
+#elif ! defined(CONFIG_SMP) && (BITS_PER_LONG < 64)
+	unsigned long jiffies_f;
+	do {
+		jiffies_f = jiffies;
+		barrier();
+		jiffies_64_f = jiffies_64;
+	} while (unlikely(jiffies_f != jiffies));
+
+
+#endif
+	tp->tv_sec = div_long_long_rem(jiffies_64_f,HZ,&sub_sec);
+
+	tp->tv_nsec = sub_sec * (NSEC_PER_SEC / HZ);
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
+	if ((unsigned)which_clock >= MAX_CLOCKS || 
+	    ! posix_clocks[which_clock].res) return -EINVAL;
+	if (copy_from_user(&new_tp, tp, sizeof(*tp)))
+		return -EFAULT;
+	if ( posix_clocks[which_clock].clock_set){
+		return posix_clocks[which_clock].clock_set(&new_tp);
+	}
+	new_tp.tv_nsec /= NSEC_PER_USEC;
+	return do_sys_settimeofday((struct timeval*)&new_tp,NULL);
+}
+asmlinkage int sys_clock_gettime(clockid_t which_clock, struct timespec *tp)
+{
+	struct timespec rtn_tp;
+	int error = 0;
+	
+	if ((unsigned)which_clock >= MAX_CLOCKS || 
+	    ! posix_clocks[which_clock].res) return -EINVAL;
+
+	error = do_posix_gettime(&posix_clocks[which_clock],&rtn_tp);
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
+	if ((unsigned)which_clock >= MAX_CLOCKS || 
+	    ! posix_clocks[which_clock].res) return -EINVAL;
+
+	rtn_tp.tv_sec = 0;
+	rtn_tp.tv_nsec = posix_clocks[which_clock].res;
+	if ( tp){
+		if (copy_to_user(tp, &rtn_tp, sizeof(rtn_tp))) {
+			return -EFAULT;
+		}
+	}
+	return 0;
+	 
+}
+static void nanosleep_wake_up(unsigned long __data)
+{
+	struct task_struct * p = (struct task_struct *) __data;
+
+	wake_up_process(p);
+}
+/*
+ * The standard says that an absolute nanosleep call MUST wake up at
+ * the requested time in spite of clock settings.  Here is what we do:
+ * For each nanosleep call that needs it (only absolute and not on 
+ * CLOCK_MONOTONIC* (as it can not be set)) we thread a little structure
+ * into the "nanosleep_abs_list".  All we need is the task_struct pointer.
+ * When ever the clock is set we just wake up all those tasks.	 The rest
+ * is done by the while loop in clock_nanosleep().
+
+ * On locking, clock_was_set() is called from update_wall_clock which 
+ * holds (or has held for it) a write_lock_irq( xtime_lock) and is 
+ * called from the timer bh code.  Thus we need the irq save locks.
+ */
+spinlock_t nanosleep_abs_list_lock = SPIN_LOCK_UNLOCKED;
+
+struct list_head nanosleep_abs_list =	LIST_HEAD_INIT(nanosleep_abs_list);
+
+struct abs_struct {
+	struct list_head list;
+	struct task_struct *t;
+};
+
+void clock_was_set(void)
+{
+	struct list_head *pos;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nanosleep_abs_list_lock, flags);
+	list_for_each(pos, &nanosleep_abs_list){
+		wake_up_process(list_entry(pos,struct abs_struct,list)->t);
+	}
+	spin_unlock_irqrestore(&nanosleep_abs_list_lock, flags);
+}
+		 
+#if 0	
+// This #if 0 is to keep the pretty printer/ formatter happy so the indents will
+// correct below.
+  
+// The NANOSLEEP_ENTRY macro is defined in  asm/signal.h and
+// is structured to allow code as well as entry definitions, so that when
+// we get control back here the entry parameters will be available as expected.
+// Some systems may find these paramerts in other ways than as entry parms, 
+// for example, struct pt_regs *regs is defined in i386 as the address of the
+// first parameter, where as other archs pass it as one of the paramerters.
+
+asmlinkage long sys_clock_nanosleep(void)
+{
+#endif
+	CLOCK_NANOSLEEP_ENTRY(	struct timespec t;
+				struct timespec tsave;
+				struct timer_list new_timer;
+				struct abs_struct abs_struct = {list: {next :0}};
+				int abs; 
+				int rtn = 0;
+				int active;)
+
+		//asmlinkage int  sys_clock_nanosleep(clockid_t which_clock, 
+		//			   int flags,
+		//			   const struct timespec *rqtp,
+		//			   struct timespec *rmtp)
+		//{
+		if ((unsigned)which_clock >= MAX_CLOCKS || 
+		    ! posix_clocks[which_clock].res) return -EINVAL;
+
+	if(copy_from_user(&tsave, rqtp, sizeof(struct timespec)))
+		return -EFAULT;
+
+	if ((unsigned)tsave.tv_nsec >= NSEC_PER_SEC || tsave.tv_sec < 0)
+		return -EINVAL;
+	
+	init_timer(&new_timer);
+	new_timer.expires = 0;
+	new_timer.data = (unsigned long)current;
+	new_timer.function = nanosleep_wake_up;
+	abs = flags & TIMER_ABSTIME;
+
+	if ( abs && (posix_clocks[which_clock].clock_get != 
+		     posix_clocks[CLOCK_MONOTONIC].clock_get) ){
+		spin_lock_irq(&nanosleep_abs_list_lock);
+		list_add(&abs_struct.list, &nanosleep_abs_list);
+		abs_struct.t = current;
+		spin_unlock_irq(&nanosleep_abs_list_lock);
+	}
+	do {
+		t = tsave;
+		if ( (abs || !new_timer.expires) &&
+		     !(rtn = adjust_abs_time(&posix_clocks[which_clock],
+					     &t,
+					     abs))){
+			/*
+			 * On error, we don't set up the timer so
+			 * we don't arm the timer so
+			 * del_timer_sync() will return 0, thus
+			 * active is zero... and so it goes.
+			 */
+
+				tstojiffie(&t,
+					   posix_clocks[which_clock].res,
+					   &new_timer.expires);
+		}
+		if (new_timer.expires ){
+			current->state = TASK_INTERRUPTIBLE;
+			add_timer(&new_timer);
+
+			schedule();
+		}
+	}
+	while((active = del_timer_sync(&new_timer)) && !_do_signal());
+	 
+	if ( abs_struct.list.next ){
+		spin_lock_irq(&nanosleep_abs_list_lock);
+		list_del(&abs_struct.list);
+		spin_unlock_irq(&nanosleep_abs_list_lock);
+	}
+	if (active && rmtp ) {
+		unsigned long jiffies_f = jiffies;
+
+		jiffies_to_timespec(new_timer.expires - jiffies_f, &t);
+
+		while (t.tv_nsec < 0){
+			t.tv_nsec += NSEC_PER_SEC;
+			t.tv_sec--;
+		} 
+		if (t.tv_sec < 0){
+			t.tv_sec = 0;
+			t.tv_nsec = 1;
+		}
+	}else{
+		t.tv_sec = 0;
+		t.tv_nsec = 0;
+	}
+	if (!rtn && !abs && rmtp && 
+	    copy_to_user(rmtp, &t, sizeof(struct timespec))){
+		return -EFAULT;
+	}
+	if (active) return -EINTR;
+
+	return rtn;
+}
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/kernel/signal.c linux/kernel/signal.c
--- linux-2.5.43-bk1-kb/kernel/signal.c	Thu Oct 17 15:31:22 2002
+++ linux/kernel/signal.c	Thu Oct 17 15:33:39 2002
@@ -424,8 +424,6 @@
 		if (!collect_signal(sig, pending, info))
 			sig = 0;
 				
-		/* XXX: Once POSIX.1b timers are in, if si_code == SI_TIMER,
-		   we need to xchg out the timer overrun values.  */
 	}
 	recalc_sigpending();
 
@@ -692,6 +690,7 @@
 specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t, int shared)
 {
 	int ret;
+	 struct sigpending *sig_queue;
 
 	if (!irqs_disabled())
 		BUG();
@@ -725,20 +724,43 @@
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
@@ -1418,8 +1440,9 @@
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.43-bk1-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.43-bk1-kb/kernel/timer.c	Wed Oct 16 00:18:19 2002
+++ linux/kernel/timer.c	Thu Oct 17 15:33:39 2002
@@ -47,12 +47,11 @@
 	struct list_head vec[TVR_SIZE];
 } tvec_root_t;
 
-typedef struct timer_list timer_t;
 
 struct tvec_t_base_s {
 	spinlock_t lock;
 	unsigned long timer_jiffies;
-	timer_t *running_timer;
+	struct timer_list *running_timer;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -67,7 +66,7 @@
 /* Fake initialization needed to avoid compiler breakage */
 static DEFINE_PER_CPU(struct tasklet_struct, timer_tasklet) = { NULL };
 
-static inline void internal_add_timer(tvec_base_t *base, timer_t *timer)
+static inline void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
 {
 	unsigned long expires = timer->expires;
 	unsigned long idx = expires - base->timer_jiffies;
@@ -119,7 +118,7 @@
  * Timers with an ->expired field in the past will be executed in the next
  * timer tick. It's illegal to add an already pending timer.
  */
-void add_timer(timer_t *timer)
+void add_timer(struct timer_list *timer)
 {
 	int cpu = get_cpu();
 	tvec_base_t *base = tvec_bases + cpu;
@@ -153,7 +152,7 @@
  * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
  * active timer returns 1.)
  */
-int mod_timer(timer_t *timer, unsigned long expires)
+int mod_timer(struct timer_list *timer, unsigned long expires)
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
@@ -226,7 +225,7 @@
  * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
  * active timer returns 1.)
  */
-int del_timer(timer_t *timer)
+int del_timer(struct timer_list *timer)
 {
 	unsigned long flags;
 	tvec_base_t *base;
@@ -263,7 +262,7 @@
  *
  * The function returns whether it has deactivated a pending timer or not.
  */
-int del_timer_sync(timer_t *timer)
+int del_timer_sync(struct timer_list *timer)
 {
 	tvec_base_t *base = tvec_bases;
 	int i, ret = 0;
@@ -302,9 +301,9 @@
 	 * detach them individually, just clear the list afterwards.
 	 */
 	while (curr != head) {
-		timer_t *tmp;
+		struct timer_list *tmp;
 
-		tmp = list_entry(curr, timer_t, entry);
+		tmp = list_entry(curr, struct timer_list, entry);
 		if (tmp->base != base)
 			BUG();
 		next = curr->next;
@@ -343,9 +342,9 @@
 		if (curr != head) {
 			void (*fn)(unsigned long);
 			unsigned long data;
-			timer_t *timer;
+			struct timer_list *timer;
 
-			timer = list_entry(curr, timer_t, entry);
+			timer = list_entry(curr, struct timer_list, entry);
  			fn = timer->function;
  			data = timer->data;
 
@@ -448,6 +447,7 @@
 	if (xtime.tv_sec % 86400 == 0) {
 	    xtime.tv_sec--;
 	    time_state = TIME_OOP;
+	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
 	}
 	break;
@@ -456,6 +456,7 @@
 	if ((xtime.tv_sec + 1) % 86400 == 0) {
 	    xtime.tv_sec++;
 	    time_state = TIME_WAIT;
+	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
 	}
 	break;
@@ -912,7 +913,7 @@
  */
 signed long schedule_timeout(signed long timeout)
 {
-	timer_t timer;
+	struct timer_list timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -968,10 +969,32 @@
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
+#ifndef FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
+		// The following code expects rqtp, rmtp to be available 
+		// as a result of the above macro.  Also any regs needed 
+		// for the _do_signal() macro shoule be set up here.
+
+		//asmlinkage long sys_nanosleep(struct timespec *rqtp, 
+		//  struct timespec *rmtp)
+		//  {
+		//    struct timespec t;
+		//    unsigned long expire;
+
 
 	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
 		return -EFAULT;
@@ -994,6 +1017,7 @@
 	}
 	return 0;
 }
+#endif // ! FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 
 /*
  * sys_sysinfo - fill in sysinfo struct

--------------62EC33A7CB030B4CCACD446D--

