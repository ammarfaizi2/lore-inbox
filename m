Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSEaVQL>; Fri, 31 May 2002 17:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSEaVQK>; Fri, 31 May 2002 17:16:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38392 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316898AbSEaVQH>; Fri, 31 May 2002 17:16:07 -0400
Subject: [PATCH] sys_sysinfo overhaul
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 May 2002 14:16:07 -0700
Message-Id: <1022879767.958.194.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Looks like sys_sysinfo has not been touched in years.  Among other
things, it uses a global cli() for protection; I switched it to a
rwlock.  I also pulled it out of info.c and stuck it in timer.c.

The details:

	- move sys_sysinfo to kernel/timer.c from kernel/info.c:
	  why one small syscall got its own file is beyond me.

	- delete kernel/info.c

	- stop the global cli!  now grab a read_lock on xtime_lock.
	  this is safe as we moved the write_unlock on xtime_lock
	  up one line to cover the calculating of avenrun.

	- trivial code cleanup

Patch is against 2.5.19, please apply.

	Robert Love

diff -urN linux-2.5.19/kernel/Makefile linux/kernel/Makefile
--- linux-2.5.19/kernel/Makefile	Wed May 29 11:42:48 2002
+++ linux/kernel/Makefile	Fri May 31 11:20:50 2002
@@ -13,7 +13,7 @@
 		printk.o platform.o suspend.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
-	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
+	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o platform.o
 
diff -urN linux-2.5.19/kernel/info.c linux/kernel/info.c
--- linux-2.5.19/kernel/info.c	Wed May 29 11:42:46 2002
+++ linux/kernel/info.c	Wed Dec 31 16:00:00 1969
@@ -1,79 +0,0 @@
-/*
- * linux/kernel/info.c
- *
- * Copyright (C) 1992 Darren Senn
- */
-
-/* This implements the sysinfo() system call */
-
-#include <linux/mm.h>
-#include <linux/unistd.h>
-#include <linux/swap.h>
-#include <linux/smp_lock.h>
-
-#include <asm/uaccess.h>
-
-asmlinkage long sys_sysinfo(struct sysinfo *info)
-{
-	struct sysinfo val;
-
-	memset((char *)&val, 0, sizeof(struct sysinfo));
-
-	cli();
-	val.uptime = jiffies / HZ;
-
-	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
-	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
-	val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
-
-	val.procs = nr_threads;
-	sti();
-
-	si_meminfo(&val);
-	si_swapinfo(&val);
-
-	{
-		unsigned long mem_total, sav_total;
-		unsigned int mem_unit, bitcount;
-
-		/* If the sum of all the available memory (i.e. ram + swap)
-		 * is less than can be stored in a 32 bit unsigned long then
-		 * we can be binary compatible with 2.2.x kernels.  If not,
-		 * well, in that case 2.2.x was broken anyways...
-		 *
-		 *  -Erik Andersen <andersee@debian.org> */
-
-		mem_total = val.totalram + val.totalswap;
-		if (mem_total < val.totalram || mem_total < val.totalswap)
-			goto out;
-		bitcount = 0;
-		mem_unit = val.mem_unit;
-		while (mem_unit > 1) {
-			bitcount++;
-			mem_unit >>= 1;
-			sav_total = mem_total;
-			mem_total <<= 1;
-			if (mem_total < sav_total)
-				goto out;
-		}
-
-		/* If mem_total did not overflow, multiply all memory values by
-		 * val.mem_unit and set it to 1.  This leaves things compatible
-		 * with 2.2.x, and also retains compatibility with earlier 2.4.x
-		 * kernels...  */
-
-		val.mem_unit = 1;
-		val.totalram <<= bitcount;
-		val.freeram <<= bitcount;
-		val.sharedram <<= bitcount;
-		val.bufferram <<= bitcount;
-		val.totalswap <<= bitcount;
-		val.freeswap <<= bitcount;
-		val.totalhigh <<= bitcount;
-		val.freehigh <<= bitcount;
-	}
-out:
-	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
-		return -EFAULT;
-	return 0;
-}
diff -urN linux-2.5.19/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.19/kernel/timer.c	Wed May 29 11:42:50 2002
+++ linux/kernel/timer.c	Fri May 31 13:36:07 2002
@@ -13,6 +13,7 @@
  *              serialize accesses to xtime/lost_ticks).
  *                              Copyright (C) 1998  Andrea Arcangeli
  *  1999-03-10  Improved NTP compatibility by Ulrich Windl
+ *  2002-05-31	Move sys_sysinfo here and make its locking sane, Robert Love
  */
 
 #include <linux/config.h>
@@ -605,9 +606,15 @@
  * imply that avenrun[] is the standard name for this kind of thing.
  * Nothing else seems to be standardized: the fractional size etc
  * all seem to differ on different machines.
+ *
+ * Requires xtime_lock to access.
  */
 unsigned long avenrun[3];
 
+/*
+ * calc_load - given tick count, update the avenrun load estimates.
+ * This is called while holding a write_lock on xtime_lock.
+ */
 static inline void calc_load(unsigned long ticks)
 {
 	unsigned long active_tasks; /* fixed-point */
@@ -627,7 +634,8 @@
 unsigned long wall_jiffies;
 
 /*
- * This spinlock protect us from races in SMP while playing with xtime. -arca
+ * This read-write spinlock protects us from races in SMP while
+ * playing with xtime and avenrun.
  */
 rwlock_t xtime_lock = RW_LOCK_UNLOCKED;
 
@@ -647,8 +655,8 @@
 		wall_jiffies += ticks;
 		update_wall_time(ticks);
 	}
-	write_unlock_irq(&xtime_lock);
 	calc_load(ticks);
+	write_unlock_irq(&xtime_lock);
 }
 
 void timer_bh(void)
@@ -910,3 +918,73 @@
 	return 0;
 }
 
+/*
+ * sys_sysinfo - fill in sysinfo struct
+ */ 
+asmlinkage long sys_sysinfo(struct sysinfo *info)
+{
+	struct sysinfo val;
+	unsigned long mem_total, sav_total;
+	unsigned int mem_unit, bitcount;
+
+	memset((char *)&val, 0, sizeof(struct sysinfo));
+
+	read_lock_irq(&xtime_lock);
+	val.uptime = jiffies / HZ;
+
+	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
+	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
+	val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
+
+	val.procs = nr_threads;
+	read_unlock_irq(&xtime_lock);
+
+	si_meminfo(&val);
+	si_swapinfo(&val);
+
+	/*
+	 * If the sum of all the available memory (i.e. ram + swap)
+	 * is less than can be stored in a 32 bit unsigned long then
+	 * we can be binary compatible with 2.2.x kernels.  If not,
+	 * well, in that case 2.2.x was broken anyways...
+	 *
+	 *  -Erik Andersen <andersee@debian.org>
+	 */
+
+	mem_total = val.totalram + val.totalswap;
+	if (mem_total < val.totalram || mem_total < val.totalswap)
+		goto out;
+	bitcount = 0;
+	mem_unit = val.mem_unit;
+	while (mem_unit > 1) {
+		bitcount++;
+		mem_unit >>= 1;
+		sav_total = mem_total;
+		mem_total <<= 1;
+		if (mem_total < sav_total)
+			goto out;
+	}
+
+	/*
+	 * If mem_total did not overflow, multiply all memory values by
+	 * val.mem_unit and set it to 1.  This leaves things compatible
+	 * with 2.2.x, and also retains compatibility with earlier 2.4.x
+	 * kernels...
+	 */
+
+	val.mem_unit = 1;
+	val.totalram <<= bitcount;
+	val.freeram <<= bitcount;
+	val.sharedram <<= bitcount;
+	val.bufferram <<= bitcount;
+	val.totalswap <<= bitcount;
+	val.freeswap <<= bitcount;
+	val.totalhigh <<= bitcount;
+	val.freehigh <<= bitcount;
+
+out:
+	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
+		return -EFAULT;
+
+	return 0;
+}


