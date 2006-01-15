Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWAOUsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWAOUsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWAOUsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:48:03 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:29091 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750771AbWAOUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:47:52 -0500
Message-Id: <200601152139.k0FLdcj0027715@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 3/11] UML -  Move libc-dependent time code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:38 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from time.c file under os-Linux dir
and joins time.c and tine_kernel.c files

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/os.h	2006-01-06 21:10:53.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/os.h	2006-01-06 21:19:03.000000000 -0500
@@ -190,7 +190,6 @@ extern int os_protect_memory(void *addr,
 			     int r, int w, int x);
 extern int os_unmap_memory(void *addr, int len);
 extern void os_flush_stdout(void);
-extern unsigned long long os_usecs(void);
 
 /* tt.c
  * for tt mode only (will be deleted in future...)
@@ -245,4 +244,15 @@ extern void setup_machinename(char *mach
 extern void setup_hostinfo(void);
 extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
 
+/* time.c */
+#define BILLION (1000 * 1000 * 1000)
+
+extern void switch_timers(int to_real);
+extern void idle_sleep(int secs);
+extern void enable_timer(void);
+extern void disable_timer(void);
+extern void user_time_init(void);
+extern void uml_idle_timer(void);
+extern unsigned long long os_nsecs(void);
+
 #endif
Index: linux-2.6.15-mm/arch/um/include/time_user.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/time_user.h	2005-08-28 19:41:01.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,19 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __TIME_USER_H__
-#define __TIME_USER_H__
-
-extern void timer(void);
-extern void switch_timers(int to_real);
-extern void idle_sleep(int secs);
-extern void enable_timer(void);
-extern void prepare_timer(void * ptr);
-extern void disable_timer(void);
-extern unsigned long time_lock(void);
-extern void time_unlock(unsigned long);
-extern void user_time_init(void);
-
-#endif
Index: linux-2.6.15-mm/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/Makefile	2006-01-06 21:10:53.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/Makefile	2006-01-06 21:19:03.000000000 -0500
@@ -9,7 +9,7 @@ clean-files :=
 obj-y = config.o exec_kern.o exitcode.o \
 	init_task.o irq.o irq_user.o ksyms.o mem.o physmem.o \
 	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
-	signal_kern.o smp.o syscall_kern.o sysrq.o time.o \
+	signal_kern.o smp.o syscall_kern.o sysrq.o \
 	time_kern.o tlb.o trap_kern.o uaccess.o um_arch.o umid.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
@@ -23,7 +23,7 @@ obj-$(CONFIG_MODE_SKAS) += skas/
 
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := $(user-objs-y) config.o time.o tty_log.o
+USER_OBJS := $(user-objs-y) config.o tty_log.o
 
 include arch/um/scripts/Makefile.rules
 
Index: linux-2.6.15-mm/arch/um/kernel/exec_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/exec_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15-mm/arch/um/kernel/exec_kern.c	2006-01-06 21:19:03.000000000 -0500
@@ -17,7 +17,6 @@
 #include "irq_user.h"
 #include "tlb.h"
 #include "os.h"
-#include "time_user.h"
 #include "choose-mode.h"
 #include "mode_kern.h"
 
Index: linux-2.6.15-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/process_kern.c	2006-01-06 21:09:26.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/process_kern.c	2006-01-06 21:19:03.000000000 -0500
@@ -39,7 +39,6 @@
 #include "init.h"
 #include "irq_user.h"
 #include "mem_user.h"
-#include "time_user.h"
 #include "tlb.h"
 #include "frame_kern.h"
 #include "sigcontext.h"
Index: linux-2.6.15-mm/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/process.c	2006-01-06 21:10:36.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/skas/process.c	2006-01-06 21:19:03.000000000 -0500
@@ -18,7 +18,6 @@
 #include <asm/types.h>
 #include "user.h"
 #include "ptrace_user.h"
-#include "time_user.h"
 #include "sysdep/ptrace.h"
 #include "user_util.h"
 #include "kern_util.h"
Index: linux-2.6.15-mm/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/process_kern.c	2006-01-06 21:10:45.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/skas/process_kern.c	2006-01-06 21:19:03.000000000 -0500
@@ -13,7 +13,6 @@
 #include "asm/uaccess.h"
 #include "asm/atomic.h"
 #include "kern_util.h"
-#include "time_user.h"
 #include "skas.h"
 #include "os.h"
 #include "user_util.h"
Index: linux-2.6.15-mm/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/syscall.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15-mm/arch/um/kernel/syscall.c	2006-01-06 21:19:03.000000000 -0500
@@ -25,12 +25,12 @@ int record_syscall_start(int syscall)
 	syscall_record[index].syscall = syscall;
 	syscall_record[index].pid = current_pid();
 	syscall_record[index].result = 0xdeadbeef;
-	syscall_record[index].start = os_usecs();
+	syscall_record[index].start = os_nsecs();
 	return(index);
 }
 
 void record_syscall_end(int index, long result)
 {
 	syscall_record[index].result = result;
-	syscall_record[index].end = os_usecs();
+	syscall_record[index].end = os_nsecs();
 }
Index: linux-2.6.15-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/time_kern.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/time_kern.c	2006-01-06 21:21:20.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -13,12 +13,12 @@
 #include "linux/interrupt.h"
 #include "linux/init.h"
 #include "linux/delay.h"
+#include "linux/hrtimer.h"
 #include "asm/irq.h"
 #include "asm/param.h"
 #include "asm/current.h"
 #include "kern_util.h"
 #include "user_util.h"
-#include "time_user.h"
 #include "mode.h"
 #include "os.h"
 
@@ -39,7 +39,7 @@ unsigned long long sched_clock(void)
 int timer_irq_inited = 0;
 
 static int first_tick;
-static unsigned long long prev_usecs;
+static unsigned long long prev_nsecs;
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
 static long long delta;   		/* Deviation per interval */
 #endif
@@ -58,23 +58,23 @@ void timer_irq(union uml_pt_regs *regs)
 	if(first_tick){
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
 		/* We've had 1 tick */
-		unsigned long long usecs = os_usecs();
+		unsigned long long nsecs = os_nsecs();
 
-		delta += usecs - prev_usecs;
-		prev_usecs = usecs;
+		delta += nsecs - prev_nsecs;
+		prev_nsecs = nsecs;
 
 		/* Protect against the host clock being set backwards */
 		if(delta < 0)
 			delta = 0;
 
-		ticks += (delta * HZ) / MILLION;
-		delta -= (ticks * MILLION) / HZ;
+		ticks += (delta * HZ) / BILLION;
+		delta -= (ticks * BILLION) / HZ;
 #else
 		ticks = 1;
 #endif
 	}
 	else {
-		prev_usecs = os_usecs();
+		prev_nsecs = os_nsecs();
 		first_tick = 1;
 	}
 
@@ -88,45 +88,99 @@ void boot_timer_handler(int sig)
 {
 	struct pt_regs regs;
 
-	CHOOSE_MODE((void) 
+	CHOOSE_MODE((void)
 		    (UPT_SC(&regs.regs) = (struct sigcontext *) (&sig + 1)),
 		    (void) (regs.regs.skas.is_user = 0));
 	do_timer(&regs);
 }
 
+static DEFINE_SPINLOCK(timer_spinlock);
+
+static unsigned long long local_offset = 0;
+
+static inline unsigned long long get_time(void)
+{
+	unsigned long long nsecs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&timer_spinlock, flags);
+	nsecs = os_nsecs();
+	nsecs += local_offset;
+	spin_unlock_irqrestore(&timer_spinlock, flags);
+
+	return nsecs;
+}
+
 irqreturn_t um_timer(int irq, void *dev, struct pt_regs *regs)
 {
+	unsigned long long nsecs;
 	unsigned long flags;
 
 	do_timer(regs);
+
 	write_seqlock_irqsave(&xtime_lock, flags);
-	timer();
+	nsecs = get_time() + local_offset;
+	xtime.tv_sec = nsecs / NSEC_PER_SEC;
+	xtime.tv_nsec = nsecs - xtime.tv_sec * NSEC_PER_SEC;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
+
 	return(IRQ_HANDLED);
 }
 
 long um_time(int __user *tloc)
 {
-	struct timeval now;
+	long ret = get_time() / NSEC_PER_SEC;
 
-	do_gettimeofday(&now);
-	if (tloc) {
- 		if (put_user(now.tv_sec, tloc))
-			now.tv_sec = -EFAULT;
-	}
-	return now.tv_sec;
+	if((tloc != NULL) && put_user(ret, tloc))
+		return -EFAULT;
+
+	return ret;
+}
+
+void do_gettimeofday(struct timeval *tv)
+{
+	unsigned long long nsecs = get_time();
+
+	tv->tv_sec = nsecs / NSEC_PER_SEC;
+	/* Careful about calculations here - this was originally done as
+	 * (nsecs - tv->tv_sec * NSEC_PER_SEC) / NSEC_PER_USEC
+	 * which gave bogus (> 1000000) values.  Dunno why, suspect gcc
+	 * (4.0.0) miscompiled it, or there's a subtle 64/32-bit conversion
+	 * problem that I missed.
+	 */
+	nsecs -= tv->tv_sec * NSEC_PER_SEC;
+	tv->tv_usec = (unsigned long) nsecs / NSEC_PER_USEC;
+}
+
+static inline void set_time(unsigned long long nsecs)
+{
+	unsigned long long now;
+	unsigned long flags;
+
+	spin_lock_irqsave(&timer_spinlock, flags);
+	now = os_nsecs();
+	local_offset = nsecs - now;
+	spin_unlock_irqrestore(&timer_spinlock, flags);
+
+	clock_was_set();
 }
 
 long um_stime(int __user *tptr)
 {
 	int value;
-	struct timespec new;
 
 	if (get_user(value, tptr))
                 return -EFAULT;
-	new.tv_sec = value;
-	new.tv_nsec = 0;
-	do_settimeofday(&new);
+
+	set_time((unsigned long long) value * NSEC_PER_SEC);
+
+	return 0;
+}
+
+int do_settimeofday(struct timespec *tv)
+{
+	set_time((unsigned long long) tv->tv_sec * NSEC_PER_SEC + tv->tv_nsec);
+
 	return 0;
 }
 
@@ -142,21 +196,6 @@ void timer_handler(int sig, union uml_pt
 		timer_irq(regs);
 }
 
-static DEFINE_SPINLOCK(timer_spinlock);
-
-unsigned long time_lock(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&timer_spinlock, flags);
-	return(flags);
-}
-
-void time_unlock(unsigned long flags)
-{
-	spin_unlock_irqrestore(&timer_spinlock, flags);
-}
-
 int __init timer_init(void)
 {
 	int err;
@@ -171,14 +210,3 @@ int __init timer_init(void)
 }
 
 __initcall(timer_init);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.15-mm/arch/um/kernel/tt/exec_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/exec_kern.c	2006-01-06 21:09:26.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/tt/exec_kern.c	2006-01-06 21:19:03.000000000 -0500
@@ -13,7 +13,6 @@
 #include "user_util.h"
 #include "kern_util.h"
 #include "irq_user.h"
-#include "time_user.h"
 #include "mem_user.h"
 #include "os.h"
 #include "tlb.h"
Index: linux-2.6.15-mm/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/process_kern.c	2006-01-06 21:09:26.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/tt/process_kern.c	2006-01-06 21:19:03.000000000 -0500
@@ -18,7 +18,6 @@
 #include "os.h"
 #include "kern.h"
 #include "sigcontext.h"
-#include "time_user.h"
 #include "mem_user.h"
 #include "tlb.h"
 #include "mode.h"
Index: linux-2.6.15-mm/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/main.c	2006-01-06 21:09:26.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/main.c	2006-01-06 21:19:03.000000000 -0500
@@ -16,7 +16,6 @@
 #include "user_util.h"
 #include "kern_util.h"
 #include "mem_user.h"
-#include "time_user.h"
 #include "irq_user.h"
 #include "user.h"
 #include "init.h"
Index: linux-2.6.15-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/signal.c	2006-01-06 21:09:26.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/signal.c	2006-01-06 21:19:03.000000000 -0500
@@ -18,8 +18,8 @@
 #include "sysdep/sigcontext.h"
 #include "sysdep/signal.h"
 #include "sigcontext.h"
-#include "time_user.h"
 #include "mode.h"
+#include "os.h"
 
 void sig_handler(ARCH_SIGHDLR_PARAM)
 {
Index: linux-2.6.15-mm/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/start_up.c	2006-01-06 21:09:26.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/start_up.c	2006-01-06 21:19:03.000000000 -0500
@@ -29,7 +29,6 @@
 #include "irq_user.h"
 #include "ptrace_user.h"
 #include "mem_user.h"
-#include "time_user.h"
 #include "init.h"
 #include "os.h"
 #include "uml-config.h"
Index: linux-2.6.15-mm/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/time.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15-mm/arch/um/os-Linux/time.c	2006-01-06 21:21:01.000000000 -0500
@@ -1,21 +1,128 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
 #include <stdlib.h>
+#include <unistd.h>
+#include <time.h>
 #include <sys/time.h>
+#include <signal.h>
+#include <errno.h>
+#include "user_util.h"
+#include "kern_util.h"
+#include "user.h"
+#include "process.h"
+#include "kern_constants.h"
+#include "os.h"
+
+/* XXX This really needs to be declared and initialized in a kernel file since
+ * it's in <linux/time.h>
+ */
+extern struct timespec wall_to_monotonic;
+
+static void set_interval(int timer_type)
+{
+	int usec = 1000000/hz();
+	struct itimerval interval = ((struct itimerval) { { 0, usec },
+							  { 0, usec } });
+
+	if(setitimer(timer_type, &interval, NULL) == -1)
+		panic("setitimer failed - errno = %d\n", errno);
+}
+
+void enable_timer(void)
+{
+	set_interval(ITIMER_VIRTUAL);
+}
+
+void disable_timer(void)
+{
+	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
+	if((setitimer(ITIMER_VIRTUAL, &disable, NULL) < 0) ||
+	   (setitimer(ITIMER_REAL, &disable, NULL) < 0))
+		printk("disnable_timer - setitimer failed, errno = %d\n",
+		       errno);
+	/* If there are signals already queued, after unblocking ignore them */
+	set_handler(SIGALRM, SIG_IGN, 0, -1);
+	set_handler(SIGVTALRM, SIG_IGN, 0, -1);
+}
+
+void switch_timers(int to_real)
+{
+	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
+	struct itimerval enable = ((struct itimerval) { { 0, 1000000/hz() },
+							{ 0, 1000000/hz() }});
+	int old, new;
+
+	if(to_real){
+		old = ITIMER_VIRTUAL;
+		new = ITIMER_REAL;
+	}
+	else {
+		old = ITIMER_REAL;
+		new = ITIMER_VIRTUAL;
+	}
+
+	if((setitimer(old, &disable, NULL) < 0) ||
+	   (setitimer(new, &enable, NULL)))
+		printk("switch_timers - setitimer failed, errno = %d\n",
+		       errno);
+}
 
-unsigned long long os_usecs(void)
+void uml_idle_timer(void)
+{
+	if(signal(SIGVTALRM, SIG_IGN) == SIG_ERR)
+		panic("Couldn't unset SIGVTALRM handler");
+
+	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
+		    SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
+	set_interval(ITIMER_REAL);
+}
+
+extern void ktime_get_ts(struct timespec *ts);
+#define do_posix_clock_monotonic_gettime(ts) ktime_get_ts(ts)
+
+void time_init(void)
+{
+	struct timespec now;
+
+	if(signal(SIGVTALRM, boot_timer_handler) == SIG_ERR)
+		panic("Couldn't set SIGVTALRM handler");
+	set_interval(ITIMER_VIRTUAL);
+
+	do_posix_clock_monotonic_gettime(&now);
+	wall_to_monotonic.tv_sec = -now.tv_sec;
+	wall_to_monotonic.tv_nsec = -now.tv_nsec;
+}
+
+unsigned long long os_nsecs(void)
 {
 	struct timeval tv;
 
 	gettimeofday(&tv, NULL);
-	return((unsigned long long) tv.tv_sec * 1000000 + tv.tv_usec);
+	return((unsigned long long) tv.tv_sec * BILLION + tv.tv_usec * 1000);
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+void idle_sleep(int secs)
+{
+	struct timespec ts;
+
+	ts.tv_sec = secs;
+	ts.tv_nsec = 0;
+	nanosleep(&ts, NULL);
+}
+
+/* XXX This partly duplicates init_irq_signals */
+
+void user_time_init(void)
+{
+	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
+		    SIGALRM, SIGUSR2, -1);
+	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
+		    SIGVTALRM, SIGUSR2, -1);
+	set_interval(ITIMER_VIRTUAL);
+}
Index: linux-2.6.15-mm/arch/um/os-Linux/tt.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/tt.c	2006-01-06 21:10:53.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/tt.c	2006-01-06 21:19:03.000000000 -0500
@@ -27,7 +27,6 @@
 #include "sysdep/sigcontext.h"
 #include "irq_user.h"
 #include "ptrace_user.h"
-#include "time_user.h"
 #include "init.h"
 #include "os.h"
 #include "uml-config.h"

