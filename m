Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265630AbSJXT5F>; Thu, 24 Oct 2002 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265638AbSJXT5F>; Thu, 24 Oct 2002 15:57:05 -0400
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.61.209]:50561 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S265630AbSJXTzm>;
	Thu, 24 Oct 2002 15:55:42 -0400
Date: Thu, 24 Oct 2002 16:01:08 -0400
Message-Id: <200210242001.g9OK18O09345@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org, george@mvista.com,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com,
       ak@suse.de
Subject: [PATCH] alternate Posix timer patch3
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

This is the third version of my spin on the Posix timers.  I started
with George Anzinger's patch but I have made major changes.

I have been using George's version of the patch and would be glad to
see it included into the 2.5 tree.  On the other hand since we don't
know what might appeal to Linus it makes sense to give him a choice.

My latest change is a rewrite of nanosleep/clock_nanosleep.  The hard
problem here is how to restart a nanosleep if it is interrupted by
a signal which is not delivered to the program.  This is typically
debug signals.  My change leaves the timer running and arranges 
to have the system call restarted.  The logic is similar to the 
existing ERESTARTNOHAND mechanism.  This interface is close to what
I want but the system call doesn't have a clue that its being restarted.
I ended up making a small change to do_signal which should not be
to painful to add to the other architectures.

It now passes most of the tests that are included in George's timers
support package.  The few remaining failures are test issues e.g.
expecting the remaining time to be set on a nanosleep which completed
normally.  This field is only meaningful if the sleep is interrupted
by a signal.  It also passed the LTP nanosleep tests.

I sent out the first version of this patch last friday and had useful 
coments from Andi Kleen.  I have addressed most of his concerns including
a race  between saving a task_struct pointer, using this pointer to send
signals and the process exiting.  Andi thanks for reviewing my code.

Here is a summary of my changes:

     -	A new queue just for Posix timers and code to
	handle expiring timers.  This supports high resolution
	without having to change the existing jiffie based timers.
	It also works fine with tick based time measurement.

	I implemented this priority queue as a sort list
	with a rbtree to index the list.  It is deterministic
	and fast. 
	
     -	Change to use the slab allocator.  I have removed the 
	config time limit on number of timers.  I plan to add /proc based 
	limits.

     -	A new id allocator/lookup mechanism based on a
	radix tree.  It includes  a bitmap to summarize the portion
	of the tree which is in use.  Currently the Posix
	timers patch reuses the id immediately.
	
     -	I keep the timers in seconds and nano-seconds.
	I'm hoping that the system time keeping will sort 
	itself out and the Posix timers can just be a consumer.
	Posix timers need two clocks - the time since boot and
	the wall clock time.   

When I catch up on lost sleep I will play with getting this working
at high resolution.

This patch works with linux- 2.5.44.

Jim Houston - Concurrent Computer Corp.


diff -X /usr1/jhouston/dontdiff -urN linux.orig/arch/i386/kernel/entry.S linux.mytimers/arch/i386/kernel/entry.S
--- linux.orig/arch/i386/kernel/entry.S	Wed Oct 23 00:54:19 2002
+++ linux.mytimers/arch/i386/kernel/entry.S	Wed Oct 23 01:17:51 2002
@@ -737,6 +737,15 @@
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/arch/i386/kernel/signal.c linux.mytimers/arch/i386/kernel/signal.c
--- linux.orig/arch/i386/kernel/signal.c	Wed Oct 23 00:54:01 2002
+++ linux.mytimers/arch/i386/kernel/signal.c	Thu Oct 24 12:08:41 2002
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/fs/exec.c linux.mytimers/fs/exec.c
--- linux.orig/fs/exec.c	Wed Oct 23 00:54:21 2002
+++ linux.mytimers/fs/exec.c	Wed Oct 23 01:37:27 2002
@@ -756,6 +756,7 @@
 			
 	flush_signal_handlers(current);
 	flush_old_files(current->files);
+	exit_itimers(current, 0);
 
 	return 0;
 
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/asm-generic/siginfo.h linux.mytimers/include/asm-generic/siginfo.h
--- linux.orig/include/asm-generic/siginfo.h	Wed Oct 23 00:54:24 2002
+++ linux.mytimers/include/asm-generic/siginfo.h	Wed Oct 23 01:17:51 2002
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
 
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/asm-i386/posix_types.h linux.mytimers/include/asm-i386/posix_types.h
--- linux.orig/include/asm-i386/posix_types.h	Tue Jan 18 01:22:52 2000
+++ linux.mytimers/include/asm-i386/posix_types.h	Wed Oct 23 01:17:51 2002
@@ -22,6 +22,8 @@
 typedef long		__kernel_time_t;
 typedef long		__kernel_suseconds_t;
 typedef long		__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int		__kernel_daddr_t;
 typedef char *		__kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/asm-i386/unistd.h linux.mytimers/include/asm-i386/unistd.h
--- linux.orig/include/asm-i386/unistd.h	Wed Oct 23 00:54:21 2002
+++ linux.mytimers/include/asm-i386/unistd.h	Wed Oct 23 01:17:51 2002
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/linux/errno.h linux.mytimers/include/linux/errno.h
--- linux.orig/include/linux/errno.h	Wed Oct 23 00:53:15 2002
+++ linux.mytimers/include/linux/errno.h	Wed Oct 23 17:54:45 2002
@@ -10,6 +10,7 @@
 #define ERESTARTNOINTR	513
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
+#define ERESTARTNANOSLP	516
 
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/linux/id2ptr.h linux.mytimers/include/linux/id2ptr.h
--- linux.orig/include/linux/id2ptr.h	Wed Dec 31 19:00:00 1969
+++ linux.mytimers/include/linux/id2ptr.h	Wed Oct 23 01:25:23 2002
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/linux/init_task.h linux.mytimers/include/linux/init_task.h
--- linux.orig/include/linux/init_task.h	Wed Oct 23 00:54:03 2002
+++ linux.mytimers/include/linux/init_task.h	Thu Oct 24 12:30:21 2002
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/linux/posix-timers.h linux.mytimers/include/linux/posix-timers.h
--- linux.orig/include/linux/posix-timers.h	Wed Dec 31 19:00:00 1969
+++ linux.mytimers/include/linux/posix-timers.h	Thu Oct 24 12:42:43 2002
@@ -0,0 +1,81 @@
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
+	struct timer_pq	pq;
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/linux/sched.h linux.mytimers/include/linux/sched.h
--- linux.orig/include/linux/sched.h	Wed Oct 23 00:54:28 2002
+++ linux.mytimers/include/linux/sched.h	Wed Oct 23 17:38:16 2002
@@ -29,6 +29,7 @@
 #include <linux/compiler.h>
 #include <linux/completion.h>
 #include <linux/pid.h>
+#include <linux/posix-timers.h>
 
 struct exec_domain;
 
@@ -333,6 +334,9 @@
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
+	struct list_head posix_timers; /* POSIX.1b Interval Timers */
+	struct k_itimer nanosleep_tmr;
+	int	nanosleep_restart;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
@@ -637,6 +641,7 @@
 
 extern void exit_mm(struct task_struct *);
 extern void exit_files(struct task_struct *);
+extern void exit_itimers(struct task_struct *, int);
 extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
 
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/linux/sys.h linux.mytimers/include/linux/sys.h
--- linux.orig/include/linux/sys.h	Sun Dec 10 23:56:37 1995
+++ linux.mytimers/include/linux/sys.h	Wed Oct 23 01:17:51 2002
@@ -4,7 +4,7 @@
 /*
  * system call entry points ... but not all are defined
  */
-#define NR_syscalls 256
+#define NR_syscalls 275
 
 /*
  * These are system calls that will be removed at some time
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/linux/time.h linux.mytimers/include/linux/time.h
--- linux.orig/include/linux/time.h	Wed Oct 23 00:53:34 2002
+++ linux.mytimers/include/linux/time.h	Thu Oct 24 12:57:27 2002
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
@@ -124,6 +137,7 @@
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern void do_settimeofday(struct timeval *tv);
+extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 #endif
 
 #define FD_SETSIZE		__FD_SETSIZE
@@ -149,5 +163,25 @@
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/include/linux/types.h linux.mytimers/include/linux/types.h
--- linux.orig/include/linux/types.h	Wed Oct 23 00:54:17 2002
+++ linux.mytimers/include/linux/types.h	Wed Oct 23 01:17:51 2002
@@ -23,6 +23,8 @@
 typedef __kernel_daddr_t	daddr_t;
 typedef __kernel_key_t		key_t;
 typedef __kernel_suseconds_t	suseconds_t;
+typedef __kernel_timer_t	timer_t;
+typedef __kernel_clockid_t	clockid_t;
 
 #ifdef __KERNEL__
 typedef __kernel_uid32_t	uid_t;
diff -X /usr1/jhouston/dontdiff -urN linux.orig/kernel/Makefile linux.mytimers/kernel/Makefile
--- linux.orig/kernel/Makefile	Wed Oct 23 00:54:21 2002
+++ linux.mytimers/kernel/Makefile	Wed Oct 23 01:24:01 2002
@@ -10,7 +10,7 @@
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o \
-	    rcupdate.o
+	    rcupdate.o posix-timers.o id2ptr.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -X /usr1/jhouston/dontdiff -urN linux.orig/kernel/exit.c linux.mytimers/kernel/exit.c
--- linux.orig/kernel/exit.c	Wed Oct 23 00:54:21 2002
+++ linux.mytimers/kernel/exit.c	Wed Oct 23 01:22:00 2002
@@ -647,6 +647,7 @@
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_namespace(tsk);
+	exit_itimers(tsk, 1);
 	exit_thread();
 
 	if (current->leader)
diff -X /usr1/jhouston/dontdiff -urN linux.orig/kernel/fork.c linux.mytimers/kernel/fork.c
--- linux.orig/kernel/fork.c	Wed Oct 23 00:54:17 2002
+++ linux.mytimers/kernel/fork.c	Thu Oct 24 12:34:12 2002
@@ -783,6 +783,12 @@
 		goto bad_fork_cleanup_files;
 	if (copy_sighand(clone_flags, p))
 		goto bad_fork_cleanup_fs;
+	INIT_LIST_HEAD(&p->posix_timers);
+	p->nanosleep_tmr.it_v.it_interval.tv_sec = 0;
+	p->nanosleep_tmr.it_v.it_interval.tv_nsec = 0;
+	p->nanosleep_tmr.it_process = p;
+	p->nanosleep_tmr.it_type = NANOSLEEP;
+	p->nanosleep_restart = RESTART_NONE;
 	if (copy_mm(clone_flags, p))
 		goto bad_fork_cleanup_sighand;
 	if (copy_namespace(clone_flags, p))
diff -X /usr1/jhouston/dontdiff -urN linux.orig/kernel/id2ptr.c linux.mytimers/kernel/id2ptr.c
--- linux.orig/kernel/id2ptr.c	Wed Dec 31 19:00:00 1969
+++ linux.mytimers/kernel/id2ptr.c	Wed Oct 23 01:23:24 2002
@@ -0,0 +1,223 @@
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
+		new = kmem_cache_alloc(id_layer_cache, GFP_KERNEL);
+		memset(new, 0, sizeof(struct id_layer));
+		spin_lock_irq(&id_lock);
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/kernel/posix-timers.c linux.mytimers/kernel/posix-timers.c
--- linux.orig/kernel/posix-timers.c	Wed Dec 31 19:00:00 1969
+++ linux.mytimers/kernel/posix-timers.c	Thu Oct 24 15:09:26 2002
@@ -0,0 +1,1111 @@
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
+
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
+
+/*
+ * Lets keep our timers in a slab cache :-)
+ */
+static kmem_cache_t *posix_timers_cache;
+struct id posix_timers_id;
+
+/*
+ * This lock portects the timer queues it is held for the
+ * duration of the timer expiry process.
+ */
+spinlock_t posix_timers_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * Kluge until I can wire into the timer interrupt.
+ */
+int poll_timer_running;
+void run_posix_timers(unsigned long dummy);
+static struct timer_list poll_posix_timers = {
+	.function = &run_posix_timers,
+};
+
+struct k_clock clock_realtime = {
+	.pq = TIMER_PQ_INIT(clock_realtime.pq),
+	.res = NSEC_PER_SEC/HZ,
+};
+
+struct k_clock clock_monotonic = {
+	.pq = TIMER_PQ_INIT(clock_monotonic.pq),
+	.res= NSEC_PER_SEC/HZ,
+	.clock_get = do_posix_clock_monotonic_gettime, 
+	.clock_set = do_posix_clock_monotonic_settime
+};
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
+static int timer_insert(struct timer_pq *pq, struct k_itimer *t)
+{
+	unsigned long flags;
+	int rv;
+
+	spin_lock_irqsave(&posix_timers_lock, flags);
+	rv = timer_insert_nolock(pq, t);
+	spin_unlock_irqrestore(&posix_timers_lock, flags);
+	if (!poll_timer_running) {
+		poll_timer_running = 1;
+		poll_posix_timers.expires = jiffies + 1;
+		add_timer(&poll_posix_timers);
+	}
+	return(rv);
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
+#if 0
+	long long ldt, in;
+	long sec, nsec;
+
+	in =  (long long)t->it_v.it_interval.tv_sec*1000000000 +
+		t->it_v.it_interval.tv_nsec;
+	ldt = (long long)dt.tv_sec * 1000000000 + dt.tv_nsec;
+	ovr = ldt/in + 1;
+	ldt = (long long)t->it_v.it_interval.tv_nsec * ovr;
+	nsec = ldt % 1000000000;
+	sec = ldt / 1000000000;
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
+/*
+ * Yes I calculate an overrun but don't deliver it.  I need to
+ * play with this code.
+ */
+static void timer_notify_task(struct k_itimer *timr, int ovr)
+{
+	struct siginfo info;
+	int ret;
+
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
+void do_expiry(struct k_itimer *t, int ovr)
+{
+	switch (t->it_type) {
+	case TIMER:
+		timer_notify_task(t, ovr);
+		return;
+	case NANOSLEEP:
+		/*
+		 * If a clock_nanosleep is interrupted by a 
+		 * signal we leave the timer in the queue 
+		 * in case the nanosleep is restarted.
+		 * We only want the wakeup if we are blocked.
+		 */
+		if (current->nanosleep_restart == RESTART_NONE)
+			wake_up_process(t->it_process);
+		return;
+	}
+}
+
+/*
+ * Check if the timer at the head of the priority queue has 
+ * expired and handle the expiry.  Return time in nsec till
+ * the next expiry.  We only really care about expiries
+ * before the next clock tick so we use a 32 bit int here.
+ */
+
+static int check_expiry(struct timer_pq *pq, struct timespec *tv)
+{
+	struct k_itimer *t;
+	struct timespec dt;
+	int ovr;
+	long sec, nsec;
+	unsigned long flags;
+	
+	ovr = 1;
+	spin_lock_irqsave(&posix_timers_lock, flags);
+	while (!list_empty(&pq->head)) {
+		t = list_entry(pq->head.next, struct k_itimer, it_pq_list);
+		dt.tv_sec = tv->tv_sec - t->it_v.it_value.tv_sec;
+		dt.tv_nsec = tv->tv_nsec - t->it_v.it_value.tv_nsec;
+		if (dt.tv_sec < 0 || (dt.tv_sec == 0 && dt.tv_nsec < 0)) {
+			/*
+			 * It has not expired yet.  Return nano-seconds
+			 * remaining if its less than a second.
+			 */
+			if (dt.tv_sec < -1)
+				nsec = -1;
+			else
+				nsec = dt.tv_sec ? 1000000000-dt.tv_nsec :
+					 -dt.tv_nsec;
+			spin_unlock_irqrestore(&posix_timers_lock, flags);
+			return(nsec);
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
+		do_expiry(t, ovr);
+	}
+	spin_unlock_irqrestore(&posix_timers_lock, flags);
+	return(-1);
+}
+
+/*
+ * kluge?  We should know the offset between clock_realtime and
+ * clock_monotonic so we don't need to get the time twice.
+ */
+
+void run_posix_timers(unsigned long dummy)
+{
+	struct timespec now;
+	int ns, ret;
+
+	ns = 0x7fffffff;
+	do_posix_clock_monotonic_gettime(&now);
+	ret = check_expiry(&clock_monotonic.pq, &now);
+	if (ret > 0 && ret < ns)
+		ns = ret;
+
+	do_gettimeofday((struct timeval*)&now);
+	now.tv_nsec *= NSEC_PER_USEC;
+	ret = check_expiry(&clock_realtime.pq, &now);
+	if (ret > 0 && ret < ns)
+		ns = ret;
+	poll_posix_timers.expires = jiffies + 1;
+	add_timer(&poll_posix_timers);
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
+static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
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
+	posix_timers_cache = kmem_cache_create("posix_timers_cache",
+		sizeof(struct k_itimer), 0, 0, 0, 0);
+	id2ptr_init(&posix_timers_id, 1000);
+
+	register_posix_clock(CLOCK_REALTIME,&clock_realtime);
+	register_posix_clock(CLOCK_MONOTONIC,&clock_monotonic);
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
+
+
+static struct k_itimer * alloc_posix_timer(void)
+{
+	struct k_itimer *tmr;
+	tmr = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL);
+	memset(tmr, 0, sizeof(struct k_itimer));
+	return(tmr);
+}
+
+static void release_posix_timer(struct k_itimer *tmr)
+{
+	if (tmr->it_id > 0)
+		id2ptr_remove(&posix_timers_id, tmr->it_id);
+	kmem_cache_free(posix_timers_cache, tmr);
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
+	int new_timer_id;
+	struct task_struct * process = 0;
+	sigevent_t event;
+
+	if ((unsigned)which_clock >= MAX_CLOCKS || !posix_clocks[which_clock])
+		return -EINVAL;
+
+	new_timer = alloc_posix_timer();
+	if (new_timer == NULL) return -EAGAIN;
+
+	new_timer_id = (timer_t)id2ptr_new(&posix_timers_id,
+		(void *)new_timer);
+	if (!new_timer_id) {
+		error = -EAGAIN;
+		goto out;
+	}
+	new_timer->it_id = new_timer_id;
+	
+	if (copy_to_user(created_timer_id, &new_timer_id, 
+			 sizeof(new_timer_id))) {
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
+	if (error)
+		release_posix_timer(new_timer);
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
+	timer_insert(&clock->pq, timr);
+	return 0;
+}
+
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
+
+	timr = lock_timer( timer_id);
+	if (!timr)
+		return -EINVAL;
+
+	if (! posix_clocks[timr->it_clock]->timer_set) {
+		error = do_timer_settime(timr, flags, &new_spec, rtn );
+	}else{
+		error = posix_clocks[timr->it_clock]->timer_set(timr, 
+							       flags, 
+							       &new_spec, 
+							       rtn );
+	}
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
+	release_posix_timer(timer);
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
+	if ((unsigned)which_clock >= MAX_CLOCKS || !posix_clocks[which_clock])
+		return -EINVAL;
+	if (copy_from_user(&new_tp, tp, sizeof(*tp)))
+		return -EFAULT;
+	if ( posix_clocks[which_clock]->clock_set){
+		return posix_clocks[which_clock]->clock_set(&new_tp);
+	}
+	new_tp.tv_nsec /= NSEC_PER_USEC;
+	return do_sys_settimeofday((struct timeval*)&new_tp,NULL);
+}
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
+const struct timespec *rqtp, struct timespec *rmtp)
+{
+	struct timespec ts;
+	struct k_itimer *t;
+	struct k_clock *clock;
+	int active;
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
+	timer_insert(&clock->pq, t);
+restart:
+	schedule();
+	active = (t->it_pq != 0);
+	if (!(flags & TIMER_ABSTIME) && active && rmtp ) {
+		do_posix_gettime(clock, &ts);
+		ts.tv_sec = t->it_v.it_value.tv_sec - ts.tv_sec;
+		ts.tv_nsec = t->it_v.it_value.tv_nsec - ts.tv_nsec;
+		if (ts.tv_nsec < 0) {
+			ts.tv_nsec += 1000000000;
+			ts.tv_sec--;
+		}
+		if (ts.tv_sec < 0)
+			ts.tv_sec = ts.tv_nsec = 0;
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
+	return(do_clock_nanosleep(which_clock, flags, rqtp, rmtp));
+}
diff -X /usr1/jhouston/dontdiff -urN linux.orig/kernel/signal.c linux.mytimers/kernel/signal.c
--- linux.orig/kernel/signal.c	Wed Oct 23 00:54:30 2002
+++ linux.mytimers/kernel/signal.c	Wed Oct 23 01:17:51 2002
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
diff -X /usr1/jhouston/dontdiff -urN linux.orig/kernel/timer.c linux.mytimers/kernel/timer.c
--- linux.orig/kernel/timer.c	Wed Oct 23 00:54:21 2002
+++ linux.mytimers/kernel/timer.c	Thu Oct 24 14:41:58 2002
@@ -47,12 +47,12 @@
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
@@ -67,7 +67,7 @@
 /* Fake initialization needed to avoid compiler breakage */
 static DEFINE_PER_CPU(struct tasklet_struct, timer_tasklet) = { NULL };
 
-static inline void internal_add_timer(tvec_base_t *base, timer_t *timer)
+static inline void internal_add_timer(tvec_base_t *base, tmr_t *timer)
 {
 	unsigned long expires = timer->expires;
 	unsigned long idx = expires - base->timer_jiffies;
@@ -119,7 +119,7 @@
  * Timers with an ->expired field in the past will be executed in the next
  * timer tick. It's illegal to add an already pending timer.
  */
-void add_timer(timer_t *timer)
+void add_timer(tmr_t *timer)
 {
 	int cpu = get_cpu();
 	tvec_base_t *base = tvec_bases + cpu;
@@ -153,7 +153,7 @@
  * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
  * active timer returns 1.)
  */
-int mod_timer(timer_t *timer, unsigned long expires)
+int mod_timer(tmr_t *timer, unsigned long expires)
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
@@ -226,7 +226,7 @@
  * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
  * active timer returns 1.)
  */
-int del_timer(timer_t *timer)
+int del_timer(tmr_t *timer)
 {
 	unsigned long flags;
 	tvec_base_t *base;
@@ -263,7 +263,7 @@
  *
  * The function returns whether it has deactivated a pending timer or not.
  */
-int del_timer_sync(timer_t *timer)
+int del_timer_sync(tmr_t *timer)
 {
 	tvec_base_t *base = tvec_bases;
 	int i, ret = 0;
@@ -302,9 +302,9 @@
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
@@ -343,9 +343,9 @@
 		if (curr != head) {
 			void (*fn)(unsigned long);
 			unsigned long data;
-			timer_t *timer;
+			tmr_t *timer;
 
-			timer = list_entry(curr, timer_t, entry);
+			timer = list_entry(curr, tmr_t, entry);
  			fn = timer->function;
  			data = timer->data;
 
@@ -912,7 +912,7 @@
  */
 signed long schedule_timeout(signed long timeout)
 {
-	timer_t timer;
+	tmr_t timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -968,6 +968,25 @@
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
+const struct timespec *rqtp, struct timespec *rmtp);
+
+asmlinkage long
+sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+{
+	struct timespec t;
+	unsigned long expire;
+
+	return(do_clock_nanosleep(CLOCK_REALTIME, 0, rqtp, rmtp));
+}
+#else 
 asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
 {
 	struct timespec t;
@@ -994,6 +1013,7 @@
 	}
 	return 0;
 }
+#endif
 
 /*
  * sys_sysinfo - fill in sysinfo struct
