Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264565AbSIVWD6>; Sun, 22 Sep 2002 18:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264572AbSIVWD6>; Sun, 22 Sep 2002 18:03:58 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:60426 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S264565AbSIVWD4>;
	Sun, 22 Sep 2002 18:03:56 -0400
Date: Mon, 23 Sep 2002 00:07:53 +0200
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Message-Id: <200209222207.g8MM7rG05008@fokkensr.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 32bit wraps and USER_HZ [timespec values], kernel 2.5.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With the introduction of USER_HZ some counters may wrap much faster on 32 bit
platforms. On i386 HZ=1000 which means that all kinds of time related counters
may wrap within (4294967296 / 1000 / 60 / 60 / 24) = 49 days.

This patch is an attempt to overcome this problem by replacing the relevant
counters with timespec (sec, nsec) values that measure time instead of ticks.
This introduces the necessity to do additional locking when these values are
accessed as operations on them no longer are atomic.

To limit the size of this message the attached patch is restricted to the
kernel_stat.h and sched.h files, just to give an impression. The full patch
can be downloaded from:

    ftp://twww.vertis.nl/pub/linux/userhz/linux-2.5.38-timespec-1.patch

Rolf Fokkens
fokkensr@fokkensr.vertis.nl

diff -ruN linux-2.5.38.orig/include/linux/kernel_stat.h linux-2.5.38/include/linux/kernel_stat.h
--- linux-2.5.38.orig/include/linux/kernel_stat.h	Sun Aug 11 03:41:27 2002
+++ linux-2.5.38/include/linux/kernel_stat.h	Sun Sep 22 13:07:50 2002
@@ -5,6 +5,8 @@
 #include <asm/irq.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
+#include <linux/time.h>
+#include <linux/spinlock.h>
 
 /*
  * 'kernel_stat.h' contains the definitions needed for doing
@@ -16,9 +18,12 @@
 #define DK_MAX_DISK 16
 
 struct kernel_stat {
-	unsigned int per_cpu_user[NR_CPUS],
-	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
+	rwlock_t times_lock;
+	struct timespec uptime,
+		        cpu_utime[NR_CPUS],
+		        cpu_ntime[NR_CPUS],
+		        cpu_stime[NR_CPUS],
+		        cpu_itime[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
diff -ruN linux-2.5.38.orig/include/linux/sched.h linux-2.5.38/include/linux/sched.h
--- linux-2.5.38.orig/include/linux/sched.h	Sat Sep 21 13:03:22 2002
+++ linux-2.5.38/include/linux/sched.h	Sun Sep 22 13:25:15 2002
@@ -82,9 +82,6 @@
 	load += n*(FIXED_1-exp); \
 	load >>= FSHIFT;
 
-#define CT_TO_SECS(x)	((x) / HZ)
-#define CT_TO_USECS(x)	(((x) % HZ) * 1000000/HZ)
-
 extern int nr_threads;
 extern int last_pid;
 extern unsigned long nr_running(void);
@@ -155,8 +152,6 @@
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
-extern void update_one_process(struct task_struct *p, unsigned long user,
-			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
@@ -340,9 +335,18 @@
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
-	unsigned long utime, stime, cutime, cstime;
-	unsigned long start_time;
-	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
+
+	rwlock_t times_lock;
+
+	struct timespec utime;
+	struct timespec stime;
+	struct timespec cutime;
+	struct timespec cstime;
+
+	struct timespec cpu_utime[NR_CPUS];
+	struct timespec cpu_stime[NR_CPUS];
+
+	struct timespec start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
