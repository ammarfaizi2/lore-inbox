Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267722AbTAIAFa>; Wed, 8 Jan 2003 19:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267993AbTAIAFa>; Wed, 8 Jan 2003 19:05:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:37359 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267722AbTAIAD4>;
	Wed, 8 Jan 2003 19:03:56 -0500
Message-ID: <3E1CB027.E9242C94@mvista.com>
Date: Wed, 08 Jan 2003 15:11:35 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH ] POSIX clocks & timers take 20 (NOT HIGH RES)
References: <Pine.LNX.4.44.0212050904390.27298-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------EDC927D74804D2E3973A55B7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------EDC927D74804D2E3973A55B7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Now for 2.5.54-bk6.

Changes since last time:

Fixed a spin lock hand off problem in locking timers (thanks
to Randy).
Fixed nanosleep to test for out of bound nano seconds
(thanks to Julie).
Fixed a couple of id deallocation bugs that left old ids
laying around (hay I get this one).
-----------
This version has a new timer id manager.  Andrew Morton
suggested elimination of recursion (done) and I added code
to allow it to release unused nodes.  The prior version only
released the leaf nodes.  (The id manager uses radix tree
type nodes.)  Also added is a reuse count so ids will not
repeat for at least 256 alloc/ free cycles.
-----------

The changes for the new sys_call restart now allow one
restart function to handle both nanosleep and
clock_nanosleep.  Saves a bit of code, nice.

All the requested changes and Lindent too :).

I also broke clock_nanosleep() apart much the same way
nanosleep() was with the 2.5.50-bk5 changes.  

This is still this way.  Should be easy to do the compat
stuff.


-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------EDC927D74804D2E3973A55B7
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-posix-2.5.54-bk6-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-posix-2.5.54-bk6-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.54-bk6-kb/arch/i386/kernel/entry.S	Wed Jan  8 13:35:51 2003
+++ linux/arch/i386/kernel/entry.S	Wed Jan  8 13:36:26 2003
@@ -41,7 +41,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/sys.h>
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
@@ -276,7 +275,7 @@
 	pushl %eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebx)
-	cmpl $(NR_syscalls), %eax
+	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 
 	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebx)
@@ -300,7 +299,7 @@
 	pushl %eax			# save orig_eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebx)
-	cmpl $(NR_syscalls), %eax
+	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 					# system call tracing in operation
 	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebx)
@@ -376,7 +375,7 @@
 	xorl %edx,%edx
 	call do_syscall_trace
 	movl ORIG_EAX(%esp), %eax
-	cmpl $(NR_syscalls), %eax
+	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
 
@@ -838,8 +837,15 @@
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
  	.long sys_set_tid_address
-
-
-	.rept NR_syscalls-(.-sys_call_table)/4
-		.long sys_ni_syscall
-	.endr
+ 	.long sys_timer_create
+ 	.long sys_timer_settime		/* 260 */
+ 	.long sys_timer_gettime
+ 	.long sys_timer_getoverrun
+ 	.long sys_timer_delete
+ 	.long sys_clock_settime
+ 	.long sys_clock_gettime		/* 265 */
+ 	.long sys_clock_getres
+ 	.long sys_clock_nanosleep
+ 
+ 
+nr_syscalls=(.-sys_call_table)/4
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.5.54-bk6-kb/arch/i386/kernel/time.c	Thu Jan  2 12:16:49 2003
+++ linux/arch/i386/kernel/time.c	Wed Jan  8 13:36:27 2003
@@ -133,6 +133,7 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 	write_unlock_irq(&xtime_lock);
+	clock_was_set();
 }
 
 /*
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/fs/exec.c linux/fs/exec.c
--- linux-2.5.54-bk6-kb/fs/exec.c	Wed Jan  8 13:35:03 2003
+++ linux/fs/exec.c	Wed Jan  8 13:36:27 2003
@@ -782,6 +782,7 @@
 			
 	flush_signal_handlers(current);
 	flush_old_files(current->files);
+	exit_itimers(current);
 
 	return 0;
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/asm-generic/siginfo.h linux/include/asm-generic/siginfo.h
--- linux-2.5.54-bk6-kb/include/asm-generic/siginfo.h	Wed Oct 30 22:45:08 2002
+++ linux/include/asm-generic/siginfo.h	Wed Jan  8 13:36:27 2003
@@ -43,8 +43,11 @@
 
 		/* POSIX.1b timers */
 		struct {
-			unsigned int _timer1;
-			unsigned int _timer2;
+			timer_t _tid;		/* timer id */
+			int _overrun;		/* overrun count */
+			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
+			sigval_t _sigval;	/* same as below */
+			int _sys_private;       /* not to be passed to user */
 		} _timer;
 
 		/* POSIX.1b signals */
@@ -86,8 +89,9 @@
  */
 #define si_pid		_sifields._kill._pid
 #define si_uid		_sifields._kill._uid
-#define si_timer1	_sifields._timer._timer1
-#define si_timer2	_sifields._timer._timer2
+#define si_tid		_sifields._timer._tid
+#define si_overrun	_sifields._timer._overrun
+#define si_sys_private  _sifields._timer._sys_private
 #define si_status	_sifields._sigchld._status
 #define si_utime	_sifields._sigchld._utime
 #define si_stime	_sifields._sigchld._stime
@@ -221,6 +225,7 @@
 #define SIGEV_SIGNAL	0	/* notify via signal */
 #define SIGEV_NONE	1	/* other notification: meaningless */
 #define SIGEV_THREAD	2	/* deliver via thread creation */
+#define SIGEV_THREAD_ID 4	/* deliver to thread */
 
 #define SIGEV_MAX_SIZE	64
 #ifndef SIGEV_PAD_SIZE
@@ -235,6 +240,7 @@
 	int sigev_notify;
 	union {
 		int _pad[SIGEV_PAD_SIZE];
+		 int _tid;
 
 		struct {
 			void (*_function)(sigval_t);
@@ -247,10 +253,12 @@
 
 #define sigev_notify_function	_sigev_un._sigev_thread._function
 #define sigev_notify_attributes	_sigev_un._sigev_thread._attribute
+#define sigev_notify_thread_id	 _sigev_un._tid
 
 #ifdef __KERNEL__
 
 struct siginfo;
+void do_schedule_next_timer(struct siginfo *info);
 
 #ifndef HAVE_ARCH_COPY_SIGINFO
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/asm-i386/posix_types.h linux/include/asm-i386/posix_types.h
--- linux-2.5.54-bk6-kb/include/asm-i386/posix_types.h	Mon Sep  9 10:35:18 2002
+++ linux/include/asm-i386/posix_types.h	Wed Jan  8 13:36:27 2003
@@ -22,6 +22,8 @@
 typedef long		__kernel_time_t;
 typedef long		__kernel_suseconds_t;
 typedef long		__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int		__kernel_daddr_t;
 typedef char *		__kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/asm-i386/signal.h linux/include/asm-i386/signal.h
--- linux-2.5.54-bk6-kb/include/asm-i386/signal.h	Wed Dec 11 06:25:28 2002
+++ linux/include/asm-i386/signal.h	Wed Jan  8 13:36:27 2003
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/linkage.h>
+#include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.54-bk6-kb/include/asm-i386/unistd.h	Thu Jan  2 12:17:13 2003
+++ linux/include/asm-i386/unistd.h	Wed Jan  8 13:36:27 2003
@@ -262,6 +262,15 @@
 #define __NR_epoll_wait		256
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/linux/idr.h linux/include/linux/idr.h
--- linux-2.5.54-bk6-kb/include/linux/idr.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/idr.h	Wed Jan  8 13:36:27 2003
@@ -0,0 +1,63 @@
+/*
+ * include/linux/id.h
+ * 
+ * 2002-10-18  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Small id to pointer translation service avoiding fixed sized
+ * tables.
+ */
+#include <linux/types.h>
+#include <asm/bitops.h>
+
+#define RESERVED_ID_BITS 8
+
+#if     BITS_PER_LONG == 32
+#define IDR_BITS 5
+#define IDR_FULL 0xffffffff
+#elif BITS_PER_LONG == 64
+#define IDR_BITS 6
+#define IDR_FULL 0xffffffffffffffff
+#else
+#error "BITS_PER_LONG is not 32 or 64"
+#endif
+
+#define IDR_MASK ((1 << IDR_BITS)-1)
+
+/* Leave the possibility of an incomplete final layer */
+#define MAX_LEVEL (BITS_PER_LONG - RESERVED_ID_BITS + IDR_BITS - 1) / IDR_BITS
+#define MAX_ID_SHIFT (BITS_PER_LONG - RESERVED_ID_BITS)
+#define MAX_ID_BIT (1 << MAX_ID_SHIFT)
+#define MAX_ID_MASK (MAX_ID_BIT - 1)
+
+/* Number of id_layer structs to leave in free list */
+#define IDR_FREE_MAX MAX_LEVEL + MAX_LEVEL
+
+struct idr_layer {
+	unsigned long	        bitmap;     // A zero bit means "space here"
+	int                     count;      // When zero, we can release it
+	struct idr_layer       *ary[1<<IDR_BITS];
+};
+
+struct idr {
+	struct idr_layer *top;
+	int		  layers;
+	int		  count;
+	struct idr_layer *id_free;
+	int               id_free_cnt;
+	spinlock_t        lock;
+};
+
+/*
+ * This is what we export.
+ */
+
+void *idr_find(struct idr *idp, int id);
+int idr_pre_get(struct idr *idp);
+int idr_get_new(struct idr *idp, void *ptr);
+void idr_remove(struct idr *idp, int id);
+void idr_init(struct idr *idp);
+
+extern kmem_cache_t *idr_layer_cache;
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/linux/init_task.h linux/include/linux/init_task.h
--- linux-2.5.54-bk6-kb/include/linux/init_task.h	Mon Dec 30 11:48:18 2002
+++ linux/include/linux/init_task.h	Wed Jan  8 13:36:27 2003
@@ -93,6 +93,7 @@
 	.sig		= &init_signals,				\
 	.pending	= { NULL, &tsk.pending.head, {{0}}},		\
 	.blocked	= {{0}},					\
+	 .posix_timers	 = LIST_HEAD_INIT(tsk.posix_timers),		   \
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/linux/posix-timers.h linux/include/linux/posix-timers.h
--- linux-2.5.54-bk6-kb/include/linux/posix-timers.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/posix-timers.h	Wed Jan  8 13:36:27 2003
@@ -0,0 +1,30 @@
+#ifndef _linux_POSIX_TIMERS_H
+#define _linux_POSIX_TIMERS_H
+
+struct k_clock {
+	int res;		/* in nano seconds */
+	int (*clock_set) (struct timespec * tp);
+	int (*clock_get) (struct timespec * tp);
+	int (*nsleep) (int flags,
+		       struct timespec * new_setting,
+		       struct itimerspec * old_setting);
+	int (*timer_set) (struct k_itimer * timr, int flags,
+			  struct itimerspec * new_setting,
+			  struct itimerspec * old_setting);
+	int (*timer_del) (struct k_itimer * timr);
+	void (*timer_get) (struct k_itimer * timr,
+			   struct itimerspec * cur_setting);
+};
+struct now_struct {
+	unsigned long jiffies;
+};
+
+#define posix_get_now(now) (now)->jiffies = jiffies;
+#define posix_time_before(timer, now) \
+                      time_before((timer)->expires, (now)->jiffies)
+
+#define posix_bump_timer(timr) do { \
+                        (timr)->it_timer.expires += (timr)->it_incr; \
+                        (timr)->it_overrun++;               \
+                       }while (0)
+#endif
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.54-bk6-kb/include/linux/sched.h	Thu Jan  2 12:17:16 2003
+++ linux/include/linux/sched.h	Wed Jan  8 13:36:27 2003
@@ -276,6 +276,25 @@
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
+	int it_requeue_pending;          /* waiting to requeue this timer */
+	int it_sigev_notify;		 /* notify word of sigevent struct */
+	int it_sigev_signo;		 /* signo word of sigevent struct */
+	sigval_t it_sigev_value;	 /* value word of sigevent struct */
+	unsigned long it_incr;		/* interval specified in jiffies */
+	struct task_struct *it_process;	/* process to send signal to */
+	struct timer_list it_timer;
+};
+
+
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -339,6 +358,7 @@
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
+	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
@@ -576,6 +596,7 @@
 extern void exit_files(struct task_struct *);
 extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
+extern void exit_itimers(struct task_struct *);
 
 extern void reparent_to_init(void);
 extern void daemonize(void);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/linux/signal.h linux/include/linux/signal.h
--- linux-2.5.54-bk6-kb/include/linux/signal.h	Wed Dec 11 06:25:32 2002
+++ linux/include/linux/signal.h	Wed Jan  8 13:36:27 2003
@@ -224,7 +224,7 @@
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs);
 #endif
-
+#define FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/linux/sys.h linux/include/linux/sys.h
--- linux-2.5.54-bk6-kb/include/linux/sys.h	Wed Oct 30 22:46:36 2002
+++ linux/include/linux/sys.h	Wed Jan  8 13:36:27 2003
@@ -2,9 +2,8 @@
 #define _LINUX_SYS_H
 
 /*
- * system call entry points ... but not all are defined
+ * This file is no longer used or needed
  */
-#define NR_syscalls 260
 
 /*
  * These are system calls that will be removed at some time
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.54-bk6-kb/include/linux/time.h	Wed Dec 11 06:25:33 2002
+++ linux/include/linux/time.h	Wed Jan  8 13:36:27 2003
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
@@ -138,6 +151,8 @@
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern void do_settimeofday(struct timeval *tv);
+extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
+extern void clock_was_set(void); // call when ever the clock is set
 extern long do_nanosleep(struct timespec *t);
 extern long do_utimes(char * filename, struct timeval * times);
 #endif
@@ -165,5 +180,25 @@
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/include/linux/types.h linux/include/linux/types.h
--- linux-2.5.54-bk6-kb/include/linux/types.h	Thu Jan  2 12:17:16 2003
+++ linux/include/linux/types.h	Wed Jan  8 13:36:27 2003
@@ -25,6 +25,8 @@
 typedef __kernel_daddr_t	daddr_t;
 typedef __kernel_key_t		key_t;
 typedef __kernel_suseconds_t	suseconds_t;
+typedef __kernel_timer_t	timer_t;
+typedef __kernel_clockid_t	clockid_t;
 
 #ifdef __KERNEL__
 typedef __kernel_uid32_t	uid_t;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/kernel/Makefile linux/kernel/Makefile
--- linux-2.5.54-bk6-kb/kernel/Makefile	Wed Jan  8 13:35:06 2003
+++ linux/kernel/Makefile	Wed Jan  8 13:39:48 2003
@@ -10,7 +10,7 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o futex.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/kernel/exit.c linux/kernel/exit.c
--- linux-2.5.54-bk6-kb/kernel/exit.c	Thu Jan  2 12:17:16 2003
+++ linux/kernel/exit.c	Wed Jan  8 13:36:27 2003
@@ -411,6 +411,7 @@
 	mmdrop(active_mm);
 }
 
+
 /*
  * Turn us into a lazy TLB process if we
  * aren't already..
@@ -659,6 +660,7 @@
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_namespace(tsk);
+	exit_itimers(tsk);
 	exit_thread();
 
 	if (current->leader)
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/kernel/fork.c linux/kernel/fork.c
--- linux-2.5.54-bk6-kb/kernel/fork.c	Thu Jan  2 12:17:16 2003
+++ linux/kernel/fork.c	Wed Jan  8 13:36:27 2003
@@ -812,6 +812,7 @@
 		goto bad_fork_cleanup_files;
 	if (copy_sighand(clone_flags, p))
 		goto bad_fork_cleanup_fs;
+	INIT_LIST_HEAD(&p->posix_timers);
 	if (copy_mm(clone_flags, p))
 		goto bad_fork_cleanup_sighand;
 	if (copy_namespace(clone_flags, p))
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.54-bk6-kb/kernel/posix-timers.c	Wed Dec 31 16:00:00 1969
+++ linux/kernel/posix-timers.c	Wed Jan  8 13:36:27 2003
@@ -0,0 +1,1326 @@
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
+#include <linux/compiler.h>
+#include <linux/idr.h>
+#include <linux/posix-timers.h>
+
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
+/*
+ * Management arrays for POSIX timers.	 Timers are kept in slab memory
+ * Timer ids are allocated by an external routine that keeps track of the
+ * id and the timer.  The external interface is:
+ *
+ *void *idr_find(struct idr *idp, int id);           to find timer_id <id>
+ *int idr_get_new(struct idr *idp, void *ptr);       to get a new id and 
+ *                                                  related it to <ptr>
+ *void idr_remove(struct idr *idp, int id);          to release <id>
+ *void idr_init(struct idr *idp);                    to initialize <idp>
+ *                                                  which we supply.
+ * The idr_get_new *may* call slab for more memory so it must not be
+ * called under a spin lock.  Likewise idr_remore may release memory
+ * (but it may be ok to do this under a lock...).
+ * idr_find is just a memory look up and is quite fast.  A zero return
+ * indicates that the requested id does not exist.
+
+ */
+/*
+   * Lets keep our timers in a slab cache :-)
+ */
+static kmem_cache_t *posix_timers_cache;
+struct idr posix_timers_id;
+spinlock_t idr_lock = SPIN_LOCK_UNLOCKED;
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
+#define timer_active(tmr) BARFY	// error to use outside of SMP
+#define set_timer_inactive(tmr)
+#endif
+/*
+ * The timer ID is turned into a timer address by idr_find().
+ * Verifying a valid ID consists of:
+ * 
+ * a) checking that idr_find() returns other than zero.
+ * b) checking that the timer id matches the one in the timer itself.
+ * c) that the timer owner is in the callers thread group.
+ */
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
+ *          At this time all functions EXCEPT clock_nanosleep can be
+ *          redirected by the CLOCKS structure.  Clock_nanosleep is in
+ *          there, but the code ignors it.
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
+void register_posix_clock(int clock_id, struct k_clock *new_clock);
+
+static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
+
+int do_posix_clock_monotonic_gettime(struct timespec *tp);
+
+int do_posix_clock_monotonic_settime(struct timespec *tp);
+static struct k_itimer *lock_timer(timer_t timer_id, long *flags);
+static inline void unlock_timer(struct k_itimer *timr, long flags);
+
+/* 
+ * Initialize everything, well, just everything in Posix clocks/timers ;)
+ */
+
+static __init int
+init_posix_timers(void)
+{
+	struct k_clock clock_realtime = {.res = NSEC_PER_SEC / HZ };
+	struct k_clock clock_monotonic = {.res = NSEC_PER_SEC / HZ,
+		.clock_get = do_posix_clock_monotonic_gettime,
+		.clock_set = do_posix_clock_monotonic_settime
+	};
+
+	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
+	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
+
+	posix_timers_cache = kmem_cache_create("posix_timers_cache",
+					       sizeof (struct k_itimer), 0, 0,
+					       0, 0);
+	idr_init(&posix_timers_id);
+	return 0;
+}
+
+__initcall(init_posix_timers);
+
+static inline int
+tstojiffie(struct timespec *tp, int res, unsigned long *jiff)
+{
+	unsigned long sec = tp->tv_sec;
+	long nsec = tp->tv_nsec + res - 1;
+
+	if (nsec > NSEC_PER_SEC) {
+		sec++;
+		nsec -= NSEC_PER_SEC;
+	}
+
+	/*
+	 * A note on jiffy overflow: It is possible for the system to
+	 * have been up long enough for the jiffies quanity to overflow.
+	 * In order for correct timer evaluations we require that the
+	 * specified time be somewhere between now and now + (max
+	 * unsigned int/2).  Times beyond this will be truncated back to
+	 * this value.   This is done in the absolute adjustment code,
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
+	return 0;
+}
+static void
+tstotimer(struct itimerspec *time, struct k_itimer *timer)
+{
+	int res = posix_clocks[timer->it_clock].res;
+	tstojiffie(&time->it_value, res, &timer->it_timer.expires);
+	tstojiffie(&time->it_interval, res, &timer->it_incr);
+}
+
+static void
+schedule_next_timer(struct k_itimer *timr)
+{
+	struct now_struct now;
+
+	/* Set up the timer for the next interval (if there is one) */
+	if (timr->it_incr == 0) {
+		{
+			set_timer_inactive(timr);
+			return;
+		}
+	}
+	posix_get_now(&now);
+	while (posix_time_before(&timr->it_timer, &now)) {
+		posix_bump_timer(timr);
+	};
+	timr->it_overrun_last = timr->it_overrun;
+	timr->it_overrun = -1;
+	timr->it_requeue_pending = 0;
+	add_timer(&timr->it_timer);
+}
+
+/*
+
+ * This function is exported for use by the signal deliver code.  It is
+ * called just prior to the info block being released and passes that
+ * block to us.  It's function is to update the overrun entry AND to
+ * restart the timer.  It should only be called if the timer is to be
+ * restarted (i.e. we have flagged this in the sys_private entry of the
+ * info block).
+ *
+ * To protect aginst the timer going away while the interrupt is queued,
+ * we require that the it_requeue_pending flag be set.
+
+ */
+void
+do_schedule_next_timer(struct siginfo *info)
+{
+
+	struct k_itimer *timr;
+	long flags;
+
+	timr = lock_timer(info->si_tid, &flags);
+
+	if (!timr || !timr->it_requeue_pending)
+		goto exit;
+
+	schedule_next_timer(timr);
+	info->si_overrun = timr->it_overrun_last;
+      exit:
+	if (timr)
+		unlock_timer(timr, flags);
+}
+
+/* 
+
+ * Notify the task and set up the timer for the next expiration (if
+ * applicable).  This function requires that the k_itimer structure
+ * it_lock is taken.  This code will requeue the timer only if we get
+ * either an error return or a flag (ret > 0) from send_seg_info
+ * indicating that the signal was either not queued or was queued
+ * without an info block.  In this case, we will not get a call back to
+ * do_schedule_next_timer() so we do it here.  This should be rare...
+
+ */
+
+static void
+timer_notify_task(struct k_itimer *timr)
+{
+	struct siginfo info;
+	int ret;
+
+	memset(&info, 0, sizeof (info));
+
+	/* Send signal to the process that owns this timer. */
+	info.si_signo = timr->it_sigev_signo;
+	info.si_errno = 0;
+	info.si_code = SI_TIMER;
+	info.si_tid = timr->it_id;
+	info.si_value = timr->it_sigev_value;
+	if (timr->it_incr == 0) {
+		set_timer_inactive(timr);
+	} else {
+		timr->it_requeue_pending = info.si_sys_private = 1;
+	}
+	ret = send_sig_info(info.si_signo, &info, timr->it_process);
+	switch (ret) {
+
+	default:
+		/*
+		 * Signal was not sent.  May or may not need to
+		 * restart the timer.
+		 */
+		printk(KERN_WARNING "sending signal failed: %d\n", ret);
+	case 1:
+		/*
+		 * signal was not sent because of sig_ignor or,
+		 * possibly no queue memory OR will be sent but,
+		 * we will not get a call back to restart it AND
+		 * it should be restarted. 
+		 */
+		schedule_next_timer(timr);
+	case 0:
+		/* 
+		 * all's well new signal queued
+		 */
+		break;
+	}
+}
+
+/*
+
+ * This function gets called when a POSIX.1b interval timer expires.  It
+ * is used as a callback from the kernel internal timer.  The
+ * run_timer_list code ALWAYS calls with interrutps on.
+
+ */
+static void
+posix_timer_fn(unsigned long __data)
+{
+	struct k_itimer *timr = (struct k_itimer *) __data;
+	long flags;
+
+	spin_lock_irqsave(&timr->it_lock, flags);
+	timer_notify_task(timr);
+	unlock_timer(timr, flags);
+}
+
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
+static inline struct task_struct *
+good_sigevent(sigevent_t * event)
+{
+	struct task_struct *rtn = current;
+
+	if (event->sigev_notify & SIGEV_THREAD_ID & MIPS_SIGEV) {
+		if (!(rtn =
+		      find_task_by_pid(event->sigev_notify_thread_id)) ||
+		    rtn->tgid != current->tgid) {
+			return NULL;
+		}
+	}
+	if (event->sigev_notify & SIGEV_SIGNAL & MIPS_SIGEV) {
+		if ((unsigned) (event->sigev_signo > SIGRTMAX))
+			return NULL;
+	}
+	if (event->sigev_notify & ~(SIGEV_SIGNAL | SIGEV_THREAD_ID)) {
+		return NULL;
+	}
+	return rtn;
+}
+
+void
+register_posix_clock(int clock_id, struct k_clock *new_clock)
+{
+	if ((unsigned) clock_id >= MAX_CLOCKS) {
+		printk("POSIX clock register failed for clock_id %d\n",
+		       clock_id);
+		return;
+	}
+	posix_clocks[clock_id] = *new_clock;
+}
+
+static struct k_itimer *
+alloc_posix_timer(void)
+{
+	struct k_itimer *tmr;
+	tmr = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL);
+	memset(tmr, 0, sizeof (struct k_itimer));
+	return (tmr);
+}
+
+static void
+release_posix_timer(struct k_itimer *tmr)
+{
+	if (tmr->it_id != -1){
+		spin_lock_irq(&idr_lock);
+		idr_remove(&posix_timers_id, tmr->it_id);
+		spin_unlock_irq(&idr_lock);
+	}
+	kmem_cache_free(posix_timers_cache, tmr);
+}
+
+/* Create a POSIX.1b interval timer. */
+
+asmlinkage int
+sys_timer_create(clockid_t which_clock,
+		 struct sigevent *timer_event_spec, timer_t * created_timer_id)
+{
+	int error = 0;
+	struct k_itimer *new_timer = NULL;
+	timer_t new_timer_id;
+	struct task_struct *process = 0;
+	sigevent_t event;
+
+	if ((unsigned) which_clock >= MAX_CLOCKS ||
+	    !posix_clocks[which_clock].res) return -EINVAL;
+
+	new_timer = alloc_posix_timer();
+	if (unlikely (new_timer == NULL))
+		return -EAGAIN;
+
+	spin_lock_init(&new_timer->it_lock);
+	do {
+		if ( unlikely ( !idr_pre_get(&posix_timers_id))){
+			error = -EAGAIN;
+			new_timer_id = (timer_t)-1;
+			goto out;			
+		}
+		spin_lock_irq(&idr_lock);
+		new_timer_id = (timer_t) idr_get_new(
+			&posix_timers_id, (void *) new_timer);
+		spin_unlock_irq(&idr_lock);
+	}while( unlikely (new_timer_id == -1));
+
+	new_timer->it_id = new_timer_id;
+	/*
+	 * return the timer_id now.  The next step is hard to 
+	 * back out if there is an error.
+	 */
+	if (copy_to_user(created_timer_id,
+			 &new_timer_id, sizeof (new_timer_id))) {
+		error = -EFAULT;
+		goto out;
+	}
+	if (timer_event_spec) {
+		if (copy_from_user(&event, timer_event_spec, sizeof (event))) {
+			error = -EFAULT;
+			goto out;
+		}
+		read_lock(&tasklist_lock);
+		if ((process = good_sigevent(&event))) {
+			/*
+
+			 * We may be setting up this process for another
+			 * thread.  It may be exitiing.  To catch this
+			 * case the we check the PF_EXITING flag.  If
+			 * the flag is not set, the task_lock will catch
+			 * him before it is too late (in exit_itimers).
+
+			 * The exec case is a bit more invloved but easy
+			 * to code.  If the process is in our thread
+			 * group (and it must be or we would not allow
+			 * it here) and is doing an exec, it will cause
+			 * us to be killed.  In this case it will wait
+			 * for us to die which means we can finish this
+			 * linkage with our last gasp. I.e. no code :)
+
+			 */
+			task_lock(process);
+			if (!(process->flags & PF_EXITING)) {
+				list_add(&new_timer->list,
+					 &process->posix_timers);
+				task_unlock(process);
+			} else {
+				task_unlock(process);
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
+		task_lock(process);
+		list_add(&new_timer->list, &process->posix_timers);
+		task_unlock(process);
+	}
+
+	new_timer->it_clock = which_clock;
+	new_timer->it_incr = 0;
+	new_timer->it_overrun = -1;
+	init_timer(&new_timer->it_timer);
+	new_timer->it_timer.expires = 0;
+	new_timer->it_timer.data = (unsigned long) new_timer;
+	new_timer->it_timer.function = posix_timer_fn;
+	set_timer_inactive(new_timer);
+
+	/*
+	 * Once we set the process, it can be found so do it last...
+	 */
+	new_timer->it_process = process;
+
+      out:
+	if (error) {
+		release_posix_timer(new_timer);
+	}
+	return error;
+}
+
+/*
+ * good_timespec
+ *
+ * This function checks the elements of a timespec structure.
+ *
+ * Arguments:
+ * ts	     : Pointer to the timespec structure to check
+ *
+ * Return value: 
+ * If a NULL pointer was passed in, or the tv_nsec field was less than 0
+ * or greater than NSEC_PER_SEC, or the tv_sec field was less than 0,
+ * this function returns 0. Otherwise it returns 1.
+
+ */
+
+static int
+good_timespec(const struct timespec *ts)
+{
+	if ((ts == NULL) ||
+	    (ts->tv_sec < 0) ||
+	    ((unsigned) ts->tv_nsec >= NSEC_PER_SEC)) return 0;
+	return 1;
+}
+
+static inline void
+unlock_timer(struct k_itimer *timr, long flags)
+{
+	spin_unlock_irqrestore(&timr->it_lock, flags);
+}
+
+/*
+
+ * Locking issues: We need to protect the result of the id look up until
+ * we get the timer locked down so it is not deleted under us.  The
+ * removal is done under the idr spinlock so we use that here to bridge
+ * the find to the timer lock.  To avoid a dead lock, the timer id MUST
+ * be release with out holding the timer lock.
+
+ */
+static struct k_itimer *
+lock_timer(timer_t timer_id, long *flags)
+{
+	struct k_itimer *timr;
+	/*
+	 * Watch out here.  We do a irqsave on the idr_lock and pass the 
+	 * flags part over to the timer lock.  Must not let interrupts in
+	 * while we are moving the lock.
+	 */
+
+	spin_lock_irqsave(&idr_lock, *flags);
+	timr = (struct k_itimer *) idr_find(&posix_timers_id, (int) timer_id);
+	if (timr) {
+		spin_lock(&timr->it_lock);
+		spin_unlock(&idr_lock);
+
+		if ( (timr->it_id != timer_id) || !(timr->it_process) ||
+		     timr->it_process->tgid != current->tgid) {
+			unlock_timer(timr, *flags);
+			timr = NULL;
+		}
+	} else {
+		spin_unlock_irqrestore(&idr_lock, *flags);
+	}
+
+	return timr;
+}
+
+/* 
+
+ * Get the time remaining on a POSIX.1b interval timer.  This function
+ * is ALWAYS called with spin_lock_irq on the timer, thus it must not
+ * mess with irq.
+
+ * We have a couple of messes to clean up here.  First there is the case
+ * of a timer that has a requeue pending.  These timers should appear to
+ * be in the timer list with an expiry as if we were to requeue them
+ * now.
+
+ * The second issue is the SIGEV_NONE timer which may be active but is
+ * not really ever put in the timer list (to save system resources).
+ * This timer may be expired, and if so, we will do it here.  Otherwise
+ * it is the same as a requeue pending timer WRT to what we should
+ * report.
+
+ */
+void inline
+do_timer_gettime(struct k_itimer *timr, struct itimerspec *cur_setting)
+{
+	long sub_expires;
+	unsigned long expires;
+	struct now_struct now;
+
+	do {
+		expires = timr->it_timer.expires;
+	} while ((volatile long) (timr->it_timer.expires) != expires);
+
+	posix_get_now(&now);
+
+	if (expires && (timr->it_sigev_notify & SIGEV_NONE) && !timr->it_incr) {
+		if (posix_time_before(&timr->it_timer, &now)) {
+			timr->it_timer.expires = expires = 0;
+		}
+	}
+	if (expires) {
+		if (timr->it_requeue_pending ||
+		    (timr->it_sigev_notify & SIGEV_NONE)) {
+			while (posix_time_before(&timr->it_timer, &now)) {
+				posix_bump_timer(timr);
+			};
+		} else {
+			if (!timer_pending(&timr->it_timer)) {
+				sub_expires = expires = 0;
+			}
+		}
+		if (expires) {
+			expires -= now.jiffies;
+		}
+	}
+	jiffies_to_timespec(expires, &cur_setting->it_value);
+	jiffies_to_timespec(timr->it_incr, &cur_setting->it_interval);
+
+	if (cur_setting->it_value.tv_sec < 0) {
+		cur_setting->it_value.tv_nsec = 1;
+		cur_setting->it_value.tv_sec = 0;
+	}
+}
+/* Get the time remaining on a POSIX.1b interval timer. */
+asmlinkage int
+sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
+{
+	struct k_itimer *timr;
+	struct itimerspec cur_setting;
+	long flags;
+
+	timr = lock_timer(timer_id, &flags);
+	if (!timr)
+		return -EINVAL;
+
+	p_timer_get(&posix_clocks[timr->it_clock], timr, &cur_setting);
+
+	unlock_timer(timr, flags);
+
+	if (copy_to_user(setting, &cur_setting, sizeof (cur_setting)))
+		return -EFAULT;
+
+	return 0;
+}
+/*
+
+ * Get the number of overruns of a POSIX.1b interval timer.  This is to
+ * be the overrun of the timer last delivered.  At the same time we are
+ * accumulating overruns on the next timer.  The overrun is frozen when
+ * the signal is delivered, either at the notify time (if the info block
+ * is not queued) or at the actual delivery time (as we are informed by
+ * the call back to do_schedule_next_timer().  So all we need to do is
+ * to pick up the frozen overrun.
+
+ */
+
+asmlinkage int
+sys_timer_getoverrun(timer_t timer_id)
+{
+	struct k_itimer *timr;
+	int overrun;
+	long flags;
+
+	timr = lock_timer(timer_id, &flags);
+	if (!timr)
+		return -EINVAL;
+
+	overrun = timr->it_overrun_last;
+	unlock_timer(timr, flags);
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
+static int
+adjust_abs_time(struct k_clock *clock, struct timespec *tp, int abs)
+{
+	struct timespec now;
+	struct timespec oc;
+	do_posix_clock_monotonic_gettime(&now);
+
+	if (abs &&
+	    (posix_clocks[CLOCK_MONOTONIC].clock_get == clock->clock_get)) {
+	} else {
+
+		if (abs) {
+			do_posix_gettime(clock, &oc);
+		} else {
+			oc.tv_nsec = oc.tv_sec = 0;
+		}
+		tp->tv_sec += now.tv_sec - oc.tv_sec;
+		tp->tv_nsec += now.tv_nsec - oc.tv_nsec;
+
+		/* 
+		 * Normalize...
+		 */
+		if ((tp->tv_nsec - NSEC_PER_SEC) >= 0) {
+			tp->tv_nsec -= NSEC_PER_SEC;
+			tp->tv_sec++;
+		}
+		if ((tp->tv_nsec) < 0) {
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
+	if ((unsigned) (tp->tv_sec - now.tv_sec) > (MAX_JIFFY_OFFSET / HZ)) {
+		if ((unsigned) tp->tv_sec < now.tv_sec) {
+			tp->tv_sec = now.tv_sec;
+			tp->tv_nsec = now.tv_nsec;
+		} else {
+			// tp->tv_sec = now.tv_sec + (MAX_JIFFY_OFFSET / HZ);
+			/*
+			 * This is a considered response, not exactly in
+			 * line with the standard (in fact it is silent on
+			 * possible overflows).  We assume such a large 
+			 * value is ALMOST always a programming error and
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
+static inline int
+do_timer_settime(struct k_itimer *timr, int flags,
+		 struct itimerspec *new_setting, struct itimerspec *old_setting)
+{
+	struct k_clock *clock = &posix_clocks[timr->it_clock];
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
+	if (timer_active(timr) && !del_timer(&timr->it_timer)) {
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
+	timr->it_requeue_pending = 0;
+	timr->it_overrun_last = 0;
+	timr->it_overrun = -1;
+	/* 
+	 *switch off the timer when it_value is zero 
+	 */
+	if ((new_setting->it_value.tv_sec == 0) &&
+	    (new_setting->it_value.tv_nsec == 0)) {
+		timr->it_timer.expires = 0;
+		return 0;
+	}
+
+	if ((flags & TIMER_ABSTIME) &&
+	    (clock->clock_get != do_posix_clock_monotonic_gettime)) {
+	}
+	if (adjust_abs_time(clock,
+			    &new_setting->it_value, flags & TIMER_ABSTIME)) {
+		return -EINVAL;
+	}
+	tstotimer(new_setting, timr);
+
+	/*
+	 * For some reason the timer does not fire immediately if expires is
+	 * equal to jiffies, so the timer notify function is called directly.
+	 * We do not even queue SIGEV_NONE timers!
+	 */
+	if (!(timr->it_sigev_notify & SIGEV_NONE)) {
+		if (timr->it_timer.expires == jiffies) {
+			timer_notify_task(timr);
+		} else
+			add_timer(&timr->it_timer);
+	}
+	return 0;
+}
+
+/* Set a POSIX.1b interval timer */
+asmlinkage int
+sys_timer_settime(timer_t timer_id, int flags,
+		  const struct itimerspec *new_setting,
+		  struct itimerspec *old_setting)
+{
+	struct k_itimer *timr;
+	struct itimerspec new_spec, old_spec;
+	int error = 0;
+	long flag;
+	struct itimerspec *rtn = old_setting ? &old_spec : NULL;
+
+	if (new_setting == NULL) {
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&new_spec, new_setting, sizeof (new_spec))) {
+		return -EFAULT;
+	}
+
+	if ((!good_timespec(&new_spec.it_interval)) ||
+	    (!good_timespec(&new_spec.it_value))) {
+		return -EINVAL;
+	}
+      retry:
+	timr = lock_timer(timer_id, &flag);
+	if (!timr)
+		return -EINVAL;
+
+	if (!posix_clocks[timr->it_clock].timer_set) {
+		error = do_timer_settime(timr, flags, &new_spec, rtn);
+	} else {
+		error = posix_clocks[timr->it_clock].timer_set(timr,
+							       flags,
+							       &new_spec, rtn);
+	}
+	unlock_timer(timr, flag);
+	if (error == TIMER_RETRY) {
+		rtn = NULL;	// We already got the old time...
+		goto retry;
+	}
+
+	if (old_setting && !error) {
+		if (copy_to_user(old_setting, &old_spec, sizeof (old_spec))) {
+			error = -EFAULT;
+		}
+	}
+
+	return error;
+}
+
+static inline int
+do_timer_delete(struct k_itimer *timer)
+{
+	timer->it_incr = 0;
+#ifdef CONFIG_SMP
+	if (timer_active(timer) &&
+	    !del_timer(&timer->it_timer) && !timer->it_requeue_pending) {
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
+asmlinkage int
+sys_timer_delete(timer_t timer_id)
+{
+	struct k_itimer *timer;
+	long flags;
+
+#ifdef CONFIG_SMP
+	int error;
+      retry_delete:
+#endif
+
+	timer = lock_timer(timer_id, &flags);
+	if (!timer)
+		return -EINVAL;
+
+#ifdef CONFIG_SMP
+	error = p_timer_del(&posix_clocks[timer->it_clock], timer);
+
+	if (error == TIMER_RETRY) {
+		unlock_timer(timer, flags);
+		goto retry_delete;
+	}
+#else
+	p_timer_del(&posix_clocks[timer->it_clock], timer);
+#endif
+
+	task_lock(timer->it_process);
+
+	list_del(&timer->list);
+
+	task_unlock(timer->it_process);
+
+	/*
+	 * This keeps any tasks waiting on the spin lock from thinking
+	 * they got something (see the lock code above).
+	 */
+	timer->it_process = NULL;
+	unlock_timer(timer, flags);
+	release_posix_timer(timer);
+	return 0;
+}
+/*
+ * return  timer owned by the process, used by exit_itimers
+ */
+static inline void
+itimer_delete(struct k_itimer *timer)
+{
+	if (sys_timer_delete(timer->it_id)) {
+		BUG();
+	}
+}
+/*
+ * This is exported to exit and exec
+ */
+void
+exit_itimers(struct task_struct *tsk)
+{
+	struct k_itimer *tmr;
+
+	task_lock(tsk);
+	while (!list_empty(&tsk->posix_timers)) {
+		tmr = list_entry(tsk->posix_timers.next, struct k_itimer, list);
+		task_unlock(tsk);
+		itimer_delete(tmr);
+		task_lock(tsk);
+	}
+	task_unlock(tsk);
+}
+
+/*
+ * And now for the "clock" calls
+
+ * These functions are called both from timer functions (with the timer
+ * spin_lock_irq() held and from clock calls with no locking.	They must
+ * use the save flags versions of locks.
+ */
+static int
+do_posix_gettime(struct k_clock *clock, struct timespec *tp)
+{
+
+	if (clock->clock_get) {
+		return clock->clock_get(tp);
+	}
+
+	do_gettimeofday((struct timeval *) tp);
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
+int
+do_posix_clock_monotonic_gettime(struct timespec *tp)
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
+	/* Tricks don't work here, must take the lock.   Remember, called
+	 * above from both timer and clock system calls => save flags.
+	 */
+	{
+		unsigned long flags;
+		read_lock_irqsave(&xtime_lock, flags);
+		jiffies_64_f = jiffies_64;
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
+#endif
+	tp->tv_sec = div_long_long_rem(jiffies_64_f, HZ, &sub_sec);
+
+	tp->tv_nsec = sub_sec * (NSEC_PER_SEC / HZ);
+	return 0;
+}
+
+int
+do_posix_clock_monotonic_settime(struct timespec *tp)
+{
+	return -EINVAL;
+}
+
+asmlinkage int
+sys_clock_settime(clockid_t which_clock, const struct timespec *tp)
+{
+	struct timespec new_tp;
+
+	if ((unsigned) which_clock >= MAX_CLOCKS ||
+	    !posix_clocks[which_clock].res) return -EINVAL;
+	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
+		return -EFAULT;
+	if (posix_clocks[which_clock].clock_set) {
+		return posix_clocks[which_clock].clock_set(&new_tp);
+	}
+	new_tp.tv_nsec /= NSEC_PER_USEC;
+	return do_sys_settimeofday((struct timeval *) &new_tp, NULL);
+}
+asmlinkage int
+sys_clock_gettime(clockid_t which_clock, struct timespec *tp)
+{
+	struct timespec rtn_tp;
+	int error = 0;
+
+	if ((unsigned) which_clock >= MAX_CLOCKS ||
+	    !posix_clocks[which_clock].res) return -EINVAL;
+
+	error = do_posix_gettime(&posix_clocks[which_clock], &rtn_tp);
+
+	if (!error) {
+		if (copy_to_user(tp, &rtn_tp, sizeof (rtn_tp))) {
+			error = -EFAULT;
+		}
+	}
+	return error;
+
+}
+asmlinkage int
+sys_clock_getres(clockid_t which_clock, struct timespec *tp)
+{
+	struct timespec rtn_tp;
+
+	if ((unsigned) which_clock >= MAX_CLOCKS ||
+	    !posix_clocks[which_clock].res) return -EINVAL;
+
+	rtn_tp.tv_sec = 0;
+	rtn_tp.tv_nsec = posix_clocks[which_clock].res;
+	if (tp) {
+		if (copy_to_user(tp, &rtn_tp, sizeof (rtn_tp))) {
+			return -EFAULT;
+		}
+	}
+	return 0;
+
+}
+static void
+nanosleep_wake_up(unsigned long __data)
+{
+	struct task_struct *p = (struct task_struct *) __data;
+
+	wake_up_process(p);
+}
+
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
+struct list_head nanosleep_abs_list = LIST_HEAD_INIT(nanosleep_abs_list);
+
+struct abs_struct {
+	struct list_head list;
+	struct task_struct *t;
+};
+
+void
+clock_was_set(void)
+{
+	struct list_head *pos;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nanosleep_abs_list_lock, flags);
+	list_for_each(pos, &nanosleep_abs_list) {
+		wake_up_process(list_entry(pos, struct abs_struct, list)->t);
+	}
+	spin_unlock_irqrestore(&nanosleep_abs_list_lock, flags);
+}
+
+long clock_nanosleep_restart(struct restart_block *restart_block);
+
+extern long do_clock_nanosleep(clockid_t which_clock, int flags, 
+			       struct timespec *t);
+
+#ifdef FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
+
+asmlinkage long
+sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+{
+	struct timespec t;
+	long ret;
+
+	if (copy_from_user(&t, rqtp, sizeof (t)))
+		return -EFAULT;
+
+	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
+		return -EINVAL;
+
+	ret = do_clock_nanosleep(CLOCK_REALTIME, 0, &t);
+
+	if (ret == -ERESTART_RESTARTBLOCK && rmtp && 
+	    copy_to_user(rmtp, &t, sizeof (t)))
+			return -EFAULT;
+	return ret;
+}
+#endif				// ! FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
+
+asmlinkage long
+sys_clock_nanosleep(clockid_t which_clock, int flags,
+		    const struct timespec *rqtp, struct timespec *rmtp)
+{
+	struct timespec t;
+	int ret;
+
+	if ((unsigned) which_clock >= MAX_CLOCKS ||
+	    !posix_clocks[which_clock].res) return -EINVAL;
+
+	if (copy_from_user(&t, rqtp, sizeof (struct timespec)))
+		return -EFAULT;
+
+	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
+		return -EINVAL;
+
+	ret = do_clock_nanosleep(which_clock, flags, &t);
+
+	if ((ret == -ERESTART_RESTARTBLOCK) && rmtp && 
+	    copy_to_user(rmtp, &t, sizeof (t)))
+			return -EFAULT;
+	return ret;
+
+}
+
+long
+do_clock_nanosleep(clockid_t which_clock, int flags, struct timespec *tsave)
+{
+	struct timespec t;
+	struct timer_list new_timer;
+	struct abs_struct abs_struct = { list:{next:0} };
+	int abs;
+	int rtn = 0;
+	int active;
+	struct restart_block *restart_block =
+	    &current_thread_info()->restart_block;
+
+	init_timer(&new_timer);
+	new_timer.expires = 0;
+	new_timer.data = (unsigned long) current;
+	new_timer.function = nanosleep_wake_up;
+	abs = flags & TIMER_ABSTIME;
+
+	if (restart_block->fn == clock_nanosleep_restart) {
+		/*
+		 * Interrupted by a non-delivered signal, pick up remaining
+		 * time and continue.
+		 */
+		restart_block->fn = do_no_restart_syscall;
+		if (!restart_block->arg2)
+			return -EINTR;
+
+		new_timer.expires = restart_block->arg2;
+		if (time_before(new_timer.expires, jiffies))
+			return 0;
+	}
+
+	if (abs && (posix_clocks[which_clock].clock_get !=
+		    posix_clocks[CLOCK_MONOTONIC].clock_get)) {
+		spin_lock_irq(&nanosleep_abs_list_lock);
+		list_add(&abs_struct.list, &nanosleep_abs_list);
+		abs_struct.t = current;
+		spin_unlock_irq(&nanosleep_abs_list_lock);
+	}
+	do {
+		t = *tsave;
+		if ((abs || !new_timer.expires) &&
+		    !(rtn = adjust_abs_time(&posix_clocks[which_clock],
+					    &t, abs))) {
+			/*
+			 * On error, we don't set up the timer so
+			 * we don't arm the timer so
+			 * del_timer_sync() will return 0, thus
+			 * active is zero... and so it goes.
+			 */
+
+			tstojiffie(&t,
+				   posix_clocks[which_clock].res,
+				   &new_timer.expires);
+		}
+		if (new_timer.expires) {
+			current->state = TASK_INTERRUPTIBLE;
+			add_timer(&new_timer);
+
+			schedule();
+		}
+	}
+	while ((active = del_timer_sync(&new_timer)) &&
+	       !test_thread_flag(TIF_SIGPENDING));
+
+	if (abs_struct.list.next) {
+		spin_lock_irq(&nanosleep_abs_list_lock);
+		list_del(&abs_struct.list);
+		spin_unlock_irq(&nanosleep_abs_list_lock);
+	}
+	if (active) {
+		unsigned long jiffies_f = jiffies;
+
+		/*
+		 * Always restart abs calls from scratch to pick up any
+		 * clock shifting that happened while we are away.
+		 */
+		if (abs)
+			return -ERESTARTNOHAND;
+
+		jiffies_to_timespec(new_timer.expires - jiffies_f, tsave);
+
+		while (tsave->tv_nsec < 0) {
+			tsave->tv_nsec += NSEC_PER_SEC;
+			tsave->tv_sec--;
+		}
+		if (tsave->tv_sec < 0) {
+			tsave->tv_sec = 0;
+			tsave->tv_nsec = 1;
+		}
+		restart_block->fn = clock_nanosleep_restart;
+		restart_block->arg0 = which_clock;
+		restart_block->arg1 = (int)tsave;
+		restart_block->arg2 = new_timer.expires;
+		return -ERESTART_RESTARTBLOCK;
+	}
+
+	return rtn;
+}
+/*
+ * This will restart either clock_nanosleep or clock_nanosleep
+ */
+long
+clock_nanosleep_restart(struct restart_block *restart_block)
+{
+	struct timespec t;
+	int ret = do_clock_nanosleep(restart_block->arg0, 0, &t);
+
+	if ((ret == -ERESTART_RESTARTBLOCK) && restart_block->arg1 && 
+	    copy_to_user((struct timespec *)(restart_block->arg1), &t, 
+			 sizeof (t)))
+		return -EFAULT;
+	return ret;
+}
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/kernel/signal.c linux/kernel/signal.c
--- linux-2.5.54-bk6-kb/kernel/signal.c	Thu Dec 19 12:13:18 2002
+++ linux/kernel/signal.c	Wed Jan  8 13:36:27 2003
@@ -457,8 +457,6 @@
 		if (!collect_signal(sig, pending, info))
 			sig = 0;
 				
-		/* XXX: Once POSIX.1b timers are in, if si_code == SI_TIMER,
-		   we need to xchg out the timer overrun values.  */
 	}
 	recalc_sigpending();
 
@@ -473,6 +471,7 @@
  */
 int dequeue_signal(sigset_t *mask, siginfo_t *info)
 {
+	int ret;
 	/*
 	 * Here we handle shared pending signals. To implement the full
 	 * semantics we need to unqueue and resend them. It will likely
@@ -483,7 +482,13 @@
 		if (signr)
 			__send_sig_info(signr, info, current);
 	}
-	return __dequeue_signal(&current->pending, mask, info);
+	ret = __dequeue_signal(&current->pending, mask, info);
+	if ( ret &&
+	     ((info->si_code & __SI_MASK) == __SI_TIMER) &&
+	     info->si_sys_private){
+		do_schedule_next_timer(info);
+	}
+	return ret;
 }
 
 static int rm_from_queue(int sig, struct sigpending *s)
@@ -622,6 +627,7 @@
 static int send_signal(int sig, struct siginfo *info, struct sigpending *signals)
 {
 	struct sigqueue * q = NULL;
+	int ret = 0;
 
 	/*
 	 * fast-pathed signals for kernel-internal things like SIGSTOP
@@ -665,17 +671,26 @@
 				copy_siginfo(&q->info, info);
 				break;
 		}
-	} else if (sig >= SIGRTMIN && info && (unsigned long)info != 1
+	} else {
+		if (sig >= SIGRTMIN && info && (unsigned long)info != 1
 		   && info->si_code != SI_USER)
 		/*
 		 * Queue overflow, abort.  We may abort if the signal was rt
 		 * and sent by user using something other than kill().
 		 */
-		return -EAGAIN;
+			return -EAGAIN;
+
+		if (((unsigned long)info > 1) && (info->si_code == SI_TIMER))
+			/*
+			 * Set up a return to indicate that we dropped 
+			 * the signal.
+			 */
+			ret = info->si_sys_private;
+	}
 
 out_set:
 	sigaddset(&signals->signal, sig);
-	return 0;
+	return ret;
 }
 
 /*
@@ -715,7 +730,7 @@
 {
 	int retval = send_signal(sig, info, &t->pending);
 
-	if (!retval && !sigismember(&t->blocked, sig))
+	if ((retval >= 0) && !sigismember(&t->blocked, sig))
 		signal_wake_up(t);
 
 	return retval;
@@ -751,6 +766,12 @@
 
 	handle_stop_signal(sig, t);
 
+	if (((unsigned long)info > 2) && (info->si_code == SI_TIMER))
+		/*
+		 * Set up a return to indicate that we dropped the signal.
+		 */
+		ret = info->si_sys_private;
+
 	/* Optimize away the signal, if it's a signal that can be
 	   handled immediately (ie non-blocked and untraced) and
 	   that is ignored (either explicitly or by default).  */
@@ -1478,8 +1499,9 @@
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.54-bk6-kb/kernel/timer.c	Thu Dec 19 12:13:18 2002
+++ linux/kernel/timer.c	Wed Jan  8 13:36:27 2003
@@ -49,12 +49,11 @@
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
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
-static void check_timer_failed(timer_t *timer)
+static void check_timer_failed(struct timer_list *timer)
 {
 	static int whine_count;
 	if (whine_count < 16) {
@@ -85,13 +84,13 @@
 	timer->magic = TIMER_MAGIC;
 }
 
-static inline void check_timer(timer_t *timer)
+static inline void check_timer(struct timer_list *timer)
 {
 	if (timer->magic != TIMER_MAGIC)
 		check_timer_failed(timer);
 }
 
-static inline void internal_add_timer(tvec_base_t *base, timer_t *timer)
+static inline void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
 {
 	unsigned long expires = timer->expires;
 	unsigned long idx = expires - base->timer_jiffies;
@@ -143,7 +142,7 @@
  * Timers with an ->expired field in the past will be executed in the next
  * timer tick. It's illegal to add an already pending timer.
  */
-void add_timer(timer_t *timer)
+void add_timer(struct timer_list *timer)
 {
 	int cpu = get_cpu();
 	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
@@ -201,7 +200,7 @@
  * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
  * active timer returns 1.)
  */
-int mod_timer(timer_t *timer, unsigned long expires)
+int mod_timer(struct timer_list *timer, unsigned long expires)
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
@@ -278,7 +277,7 @@
  * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
  * active timer returns 1.)
  */
-int del_timer(timer_t *timer)
+int del_timer(struct timer_list *timer)
 {
 	unsigned long flags;
 	tvec_base_t *base;
@@ -317,7 +316,7 @@
  *
  * The function returns whether it has deactivated a pending timer or not.
  */
-int del_timer_sync(timer_t *timer)
+int del_timer_sync(struct timer_list *timer)
 {
 	tvec_base_t *base;
 	int i, ret = 0;
@@ -360,9 +359,9 @@
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
@@ -401,9 +400,9 @@
 		if (curr != head) {
 			void (*fn)(unsigned long);
 			unsigned long data;
-			timer_t *timer;
+			struct timer_list *timer;
 
-			timer = list_entry(curr, timer_t, entry);
+			timer = list_entry(curr, struct timer_list, entry);
  			fn = timer->function;
  			data = timer->data;
 
@@ -505,6 +504,7 @@
 	if (xtime.tv_sec % 86400 == 0) {
 	    xtime.tv_sec--;
 	    time_state = TIME_OOP;
+	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
 	}
 	break;
@@ -513,6 +513,7 @@
 	if ((xtime.tv_sec + 1) % 86400 == 0) {
 	    xtime.tv_sec++;
 	    time_state = TIME_WAIT;
+	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
 	}
 	break;
@@ -965,7 +966,7 @@
  */
 signed long schedule_timeout(signed long timeout)
 {
-	timer_t timer;
+	struct timer_list timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -1020,6 +1021,7 @@
 {
 	return current->pid;
 }
+#ifndef FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 
 static long nanosleep_restart(struct restart_block *restart)
 {
@@ -1078,6 +1080,7 @@
 	}
 	return ret;
 }
+#endif // ! FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 
 /*
  * sys_sysinfo - fill in sysinfo struct
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/lib/Makefile linux/lib/Makefile
--- linux-2.5.54-bk6-kb/lib/Makefile	Fri Jan  3 16:37:01 2003
+++ linux/lib/Makefile	Wed Jan  8 13:36:27 2003
@@ -9,11 +9,11 @@
 L_TARGET := lib.a
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
-	       crc32.o rbtree.o radix-tree.o kobject.o
+	       crc32.o rbtree.o radix-tree.o kobject.o idr.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o
+	 kobject.o idr.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-kb/lib/idr.c linux/lib/idr.c
--- linux-2.5.54-bk6-kb/lib/idr.c	Wed Dec 31 16:00:00 1969
+++ linux/lib/idr.c	Wed Jan  8 13:36:27 2003
@@ -0,0 +1,342 @@
+/*
+ * linux/kernel/id.c
+ *
+ * 2002-10-18  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Small id to pointer translation service.  
+ *
+ * It uses a radix tree like structure as a sparse array indexed 
+ * by the id to obtain the pointer.  The bitmap makes allocating
+ * a new id quick.  
+
+ * Modified by George Anzinger to reuse immediately and to use
+ * find bit instructions.  Also removed _irq on spinlocks.
+
+ * So here is what this bit of code does:
+
+ * You call it to allocate an id (an int) an associate with that id a
+ * pointer or what ever, we treat it as a (void *).  You can pass this
+ * id to a user for him to pass back at a later time.  You then pass
+ * that id to this code and it returns your pointer.
+
+ * You can release ids at any time. When all ids are released, most of 
+ * the memory is returned (we keep IDR_FREE_MAX) in a local pool so we
+ * don't need to go to the memory "store" during an id allocate, just 
+ * so you don't need to be too concerned about locking and conflicts
+ * with the slab allocator.
+
+ * A word on reuse.  We reuse empty id slots as soon as we can, always
+ * using the lowest one available.  But we also merge a counter in the
+ * high bits of the id.  The counter is RESERVED_ID_BITS (8 at this time)
+ * long.  This means that if you allocate and release the same id in a 
+ * loop we will reuse an id after about 256 times around the loop.  The
+ * word about is used here as we will NOT return a valid id of -1 so if
+ * you loop on the largest possible id (and that is 24 bits, wow!) we
+ * will kick the counter to avoid -1.  (Paranoid?  You bet!)
+ *
+ * What you need to do is, since we don't keep the counter as part of
+ * id / ptr pair, to keep a copy of it in the pointed to structure
+ * (or else where) so that when you ask for a ptr you can varify that
+ * the returned ptr is correct by comparing the id it contains with the one
+ * you asked for.  In other words, we only did half the reuse protection.
+ * Since the code depends on your code doing this check, we ignore high
+ * order bits in the id, not just the count, but bits that would, if used,
+ * index outside of the allocated ids.  In other words, if the largest id
+ * currently allocated is 32 a look up will only look at the low 5 bits of
+ * the id.  Since you will want to keep this id in the structure anyway
+ * (if for no other reason than to be able to eliminate the id when the
+ * structure is found in some other way) this seems reasonable.  If you
+ * really think otherwise, the code to check these bits here, it is just
+ * disabled with a #if 0.
+
+
+ * So here are the complete details:
+
+ *  include <linux/idr.h>
+
+ * void idr_init(struct idr *idp)
+
+ *   This function is use to set up the handle (idp) that you will pass
+ *   to the rest of the functions.  The structure is defined in the
+ *   header.
+
+ * int idr_pre_get(struct idr *idp)
+
+ *   This function should be called prior to locking and calling the
+ *   following function.  It pre allocates enough memory to satisfy the
+ *   worst possible allocation.  It can sleep, so must not be called
+ *   with any spinlocks held.  If the system is REALLY out of memory
+ *   this function returns 0, other wise 1.
+
+ * int idr_get_new(struct idr *idp, void *ptr);
+ 
+ *   This is the allocate id function.  It should be called with any
+ *   required locks.  In fact, in the SMP case, you MUST lock prior to
+ *   calling this function to avoid possible out of memory problems.  If
+ *   memory is required, it will return a -1, in which case you should
+ *   unlock and go back to the idr_pre_get() call.  ptr is the pointer
+ *   you want associated with the id.  In other words:
+
+ * void *idr_find(struct idr *idp, int id);
+ 
+ *   returns the "ptr", given the id.  A NULL return indicates that the
+ *   id is not valid (or you passed NULL in the idr_get_new(), shame on
+ *   you).  This function must be called with a spinlock that prevents
+ *   calling either idr_get_new() or idr_remove() or idr_find() while it
+ *   is working.
+
+ * void idr_remove(struct idr *idp, int id);
+
+ *   removes the given id, freeing that slot and any memory that may
+ *   now be unused.  See idr_find() for locking restrictions.
+
+ */
+
+
+
+#ifndef TEST                        // to test in user space...
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#endif
+#include <linux/string.h>
+#include <linux/idr.h>
+
+
+static kmem_cache_t *idr_layer_cache;
+
+
+
+static inline struct idr_layer *alloc_layer(struct idr *idp)
+{
+	struct idr_layer *p;
+
+	spin_lock(&idp->lock);
+	if (!(p = idp->id_free))
+		BUG();
+	idp->id_free = p->ary[0];
+	idp->id_free_cnt--;
+	p->ary[0] = 0;
+	spin_unlock(&idp->lock);
+	return(p);
+}
+
+static inline void free_layer(struct idr *idp, struct idr_layer *p)
+{
+	/*
+	 * Depends on the return element being zeroed.
+	 */
+	spin_lock(&idp->lock);
+	p->ary[0] = idp->id_free;
+	idp->id_free = p;
+	idp->id_free_cnt++;
+	spin_unlock(&idp->lock);
+}
+
+int idr_pre_get(struct idr *idp)
+{
+	while (idp->id_free_cnt < idp->layers + 1) {
+		struct idr_layer *new;
+		new = kmem_cache_alloc(idr_layer_cache, GFP_KERNEL);
+		if(new == NULL)
+			return (0);
+		free_layer(idp, new);
+	}
+	return 1;
+}
+EXPORT_SYMBOL(idr_pre_get);
+
+static inline int sub_alloc(struct idr *idp, int shift, void *ptr)
+{
+	int n, v = 0;
+	struct idr_layer *p;
+	struct idr_layer **pa[MAX_LEVEL];
+	struct idr_layer ***paa = &pa[0];
+	
+	*paa = NULL;
+	*++paa = &idp->top;
+
+	/*
+	 * By keeping each pointer in an array we can do the 
+	 * "after" recursion processing.  In this case, that means
+	 * we can update the upper level bit map.
+	 */
+	
+	while (1){
+		p = **paa;
+		n = ffz(p->bitmap);
+		if (shift){
+			/*
+			 * We run around this while until we
+			 * reach the leaf node...
+			 */
+			if (!p->ary[n]){
+				/*
+				 * If no node, allocate one, AFTER
+				 * we insure that we will not
+				 * intrude on the reserved bit field.
+				 */
+				if ((n << shift) >= MAX_ID_BIT)
+					return -1;
+				p->ary[n] = alloc_layer(idp);
+				p->count++;
+			}
+			*++paa = &p->ary[n];
+			v += (n << shift);
+			shift -= IDR_BITS;
+		} else {
+			/*
+			 * We have reached the leaf node, plant the
+			 * users pointer and return the raw id.
+			 */
+			p->ary[n] = (struct idr_layer *)ptr;
+			__set_bit(n, &p->bitmap);
+			v += n;
+			p->count++;
+			/*
+			 * This is the post recursion processing.  Once
+			 * we find a bitmap that is not full we are
+			 * done
+			 */
+			while (*(paa-1) && (**paa)->bitmap == IDR_FULL){
+				n = *paa - &(**(paa-1))->ary[0];
+				__set_bit(n, &(**--paa)->bitmap);
+			}
+			return(v);
+		}
+	}
+}
+
+int idr_get_new(struct idr *idp, void *ptr)
+{
+	int v;
+	
+	if (idp->id_free_cnt < idp->layers + 1) 
+		return (-1);
+	/*
+	 * Add a new layer if the array is full 
+	 */
+	if (unlikely(!idp->top || idp->top->bitmap == IDR_FULL)){
+		/*
+		 * This is a bit different than the lower layers because
+		 * we have one branch already allocated and full.
+		 */
+		struct idr_layer *new = alloc_layer(idp);
+		new->ary[0] = idp->top;
+		if ( idp->top)
+			++new->count;
+		idp->top = new;
+		if ( idp->layers++ )
+			__set_bit(0, &new->bitmap);
+	}
+	v = sub_alloc(idp,  (idp->layers - 1) * IDR_BITS, ptr);
+	if ( likely(v >= 0 )){
+		idp->count++;
+		v += (idp->count << MAX_ID_SHIFT);
+		if ( unlikely( v == -1 ))
+		     v += (1 << MAX_ID_SHIFT);
+	}
+	return(v);
+}
+EXPORT_SYMBOL(idr_get_new);
+
+
+static inline void sub_remove(struct idr *idp, int shift, int id)
+{
+	struct idr_layer *p = idp->top;
+	struct idr_layer **pa[MAX_LEVEL];
+	struct idr_layer ***paa = &pa[0];
+
+	*paa = NULL;
+	*++paa = &idp->top;
+
+	while ((shift > 0) && p) {
+		int n = (id >> shift) & IDR_MASK;
+		__clear_bit(n, &p->bitmap);
+		*++paa = &p->ary[n];
+		p = p->ary[n];
+		shift -= IDR_BITS;
+	}
+	if ( likely(p)){
+		int n = id & IDR_MASK;
+		__clear_bit(n, &p->bitmap);
+		p->ary[n] = NULL;
+		while(*paa && ! --((**paa)->count)){
+			free_layer(idp, **paa);
+			**paa-- = NULL;
+		}
+		if ( ! *paa )
+			idp->layers = 0;
+	}
+}
+void idr_remove(struct idr *idp, int id)
+{
+	struct idr_layer *p;
+
+	sub_remove(idp, (idp->layers - 1) * IDR_BITS, id);
+	if ( idp->top && idp->top->count == 1 && 
+	     (idp->layers > 1) &&
+	     idp->top->ary[0]){  // We can drop a layer
+
+		p = idp->top->ary[0];
+		idp->top->bitmap = idp->top->count = 0;
+		free_layer(idp, idp->top);
+		idp->top = p;
+		--idp->layers;
+	}
+	while (idp->id_free_cnt >= IDR_FREE_MAX) {
+		
+		p = alloc_layer(idp);
+		kmem_cache_free(idr_layer_cache, p);
+		return;
+	}
+}
+EXPORT_SYMBOL(idr_remove);
+
+void *idr_find(struct idr *idp, int id)
+{
+	int n;
+	struct idr_layer *p;
+
+	n = idp->layers * IDR_BITS;
+	p = idp->top;
+#if 0
+	/*
+	 * This tests to see if bits outside the current tree are
+	 * present.  If so, tain't one of ours!
+	 */
+	if ( unlikely( (id & ~(~0 << MAX_ID_SHIFT)) >> (n + IDR_BITS)))
+	     return NULL;
+#endif
+	while (n > 0 && p) {
+		n -= IDR_BITS;
+		p = p->ary[(id >> n) & IDR_MASK];
+	}
+	return((void *)p);
+}
+EXPORT_SYMBOL(idr_find);
+
+static void idr_cache_ctor(void * idr_layer, 
+			   kmem_cache_t *idr_layer_cache, unsigned long flags)
+{
+	memset(idr_layer, 0, sizeof(struct idr_layer));
+}
+
+static  int init_id_cache(void)
+{
+	if (!idr_layer_cache)
+		idr_layer_cache = kmem_cache_create("idr_layer_cache", 
+			sizeof(struct idr_layer), 0, 0, idr_cache_ctor, 0);
+	return 0;
+}
+
+void idr_init(struct idr *idp)
+{
+	init_id_cache();
+	memset(idp, 0, sizeof(struct idr));
+	spin_lock_init(&idp->lock);
+}
+EXPORT_SYMBOL(idr_init);
+

--------------EDC927D74804D2E3973A55B7--

