Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314657AbSEKK0n>; Sat, 11 May 2002 06:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314658AbSEKK0n>; Sat, 11 May 2002 06:26:43 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:20229 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314657AbSEKK0l>; Sat, 11 May 2002 06:26:41 -0400
Date: Sat, 11 May 2002 12:26:38 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2/6: basic 64 bit jiffies uses
Message-ID: <Pine.LNX.4.33.0205111226030.26626-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two simple uses of 64 bit jiffies:
  - export correct uptime through sysinfo after 32 bit jiffies wrap.
    Note that this does not change the ABI, which exports uptime in seconds.
    It just prevents internal overflow.
  - use 64 bit jiffies in the OOM-killer. Before, deaemons and very
    long-running jobs were likely to be killed in OOM situations after
    jiffies wrap.

The uptime exported through /proc/uptime will be corrected in patch 5/6.


--- linux-2.5.15/kernel/info.c	Mon Mar 18 21:37:05 2002
+++ linux-2.5.15-j64/kernel/info.c	Thu May  9 17:48:21 2002
@@ -12,15 +12,19 @@
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	u64 uptime;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	cli();
-	val.uptime = jiffies / HZ;
+	uptime = get_jiffies64();
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;
 
 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);

--- linux-2.5.15/mm/oom_kill.c	Mon Mar 18 21:37:02 2002
+++ linux-2.5.15-j64/mm/oom_kill.c	Thu May  9 17:48:21 2002
@@ -69,11 +69,10 @@
 	/*
 	 * CPU time is in seconds and run time is in minutes. There is no
 	 * particular reason for this other than that it turned out to work
-	 * very well in practice. This is not safe against jiffie wraps
-	 * but we don't care _that_ much...
+	 * very well in practice.
 	 */
 	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
-	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+	run_time = (get_jiffies64() - p->start_time) >> (SHIFT_HZ + 10);
 
 	points /= int_sqrt(cpu_time);
 	points /= int_sqrt(int_sqrt(run_time));


