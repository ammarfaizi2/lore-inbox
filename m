Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbUJ0H6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbUJ0H6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUJ0H6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:58:17 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:33502 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262318AbUJ0H4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:56:04 -0400
Date: Wed, 27 Oct 2004 09:55:29 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       lkml <linux-kernel@vger.kernel.org>, george@mvista.com
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
In-Reply-To: <1098216701.20778.78.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0410270950550.7885@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
 <1098216701.20778.78.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, john stultz wrote:

> On Tue, 2004-10-19 at 11:21, Jerome Borsboom wrote:
> > Starting with kernel 2.6.9 the process start time is set wrongly for 
> > processes that get started early in the boot process. Below is a dump from 
> > my 'ps' command. Note the start time for processes 1-12. After process 12 
> > the start time is set right.
> 
> How reproducible is this? Are the correct and incorrect time values
> always off by the same amount? 

If the problem is reproducible, does it go away with the following patch 
against 2.6.9?

An untested patch against 2.6.9-mm1 is at
  http://www.physik3.uni-rostock.de/tim/kernel/2.6/uptime-fix-09.patch

Tim


--- linux-2.6.9/fs/proc/array.c	2004-10-27 00:04:58.000000000 +0200
+++ linux-2.6.9-uf/fs/proc/array.c	2004-10-27 01:44:13.000000000 +0200
@@ -360,11 +360,7 @@ int proc_pid_stat(struct task_struct *ta
 	read_unlock(&tasklist_lock);
 
 	/* Temporary variable needed for gcc-2.96 */
-	/* convert timespec -> nsec*/
-	start_time = (unsigned long long)task->start_time.tv_sec * NSEC_PER_SEC
-				+ task->start_time.tv_nsec;
-	/* convert nsec -> ticks */
-	start_time = nsec_to_clock_t(start_time);
+	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
 
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \

--- linux-2.6.9/fs/proc/proc_misc.c	2004-10-27 00:04:58.000000000 +0200
+++ linux-2.6.9-uf/fs/proc/proc_misc.c	2004-10-27 01:44:23.000000000 +0200
@@ -133,19 +133,36 @@ static struct vmalloc_info get_vmalloc_i
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	struct timespec uptime;
-	struct timespec idle;
+	u64 uptime;
+	unsigned long uptime_remainder;
 	int len;
-	u64 idle_jiffies = init_task.utime + init_task.stime;
 
-	do_posix_clock_monotonic_gettime(&uptime);
-	jiffies_to_timespec(idle_jiffies, &idle);
-	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-			(unsigned long) uptime.tv_sec,
-			(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
-			(unsigned long) idle.tv_sec,
-			(idle.tv_nsec / (NSEC_PER_SEC / 100)));
+	uptime = get_jiffies_64() - INITIAL_JIFFIES;
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 
+#if HZ!=100
+	{
+		u64 idle = init_task.utime + init_task.stime;
+		unsigned long idle_remainder;
+
+		idle_remainder = (unsigned long) do_div(idle, HZ);
+		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime,
+			(uptime_remainder * 100) / HZ,
+			(unsigned long) idle,
+			(idle_remainder * 100) / HZ);
+	}
+#else
+	{
+		unsigned long idle = init_task.utime + init_task.stime;
+
+		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime,
+			uptime_remainder,
+			idle / HZ,
+			idle % HZ);
+	}
+#endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 

--- linux-2.6.9/include/linux/acct.h	2004-10-27 00:04:58.000000000 +0200
+++ linux-2.6.9-uf/include/linux/acct.h	2004-10-27 01:44:13.000000000 +0200
@@ -172,22 +172,15 @@ static inline u32 jiffies_to_AHZ(unsigne
 #endif
 }
 
-static inline u64 nsec_to_AHZ(u64 x)
+static inline u64 jiffies_64_to_AHZ(u64 x)
 {
-#if (NSEC_PER_SEC % AHZ) == 0
-	do_div(x, (NSEC_PER_SEC / AHZ));
-#elif (AHZ % 512) == 0
-	x *= AHZ/512;
-	do_div(x, (NSEC_PER_SEC / 512));
+#if (TICK_NSEC % (NSEC_PER_SEC / AHZ)) == 0
+#if HZ != AHZ
+	do_div(x, HZ / AHZ);
+#endif
 #else
-	/*
-         * max relative error 5.7e-8 (1.8s per year) for AHZ <= 1024,
-         * overflow after 64.99 years.
-         * exact for AHZ=60, 72, 90, 120, 144, 180, 300, 600, 900, ...
-         */
-	x *= 9;
-	do_div(x, (unsigned long)((9ull * NSEC_PER_SEC + (AHZ/2))
-	                          / AHZ));
+	x *= TICK_NSEC;
+	do_div(x, (NSEC_PER_SEC / AHZ));
 #endif
	return x;
 }

--- linux-2.6.9/include/linux/sched.h	2004-10-27 00:04:58.000000000 +0200
+++ linux-2.6.9-uf/include/linux/sched.h	2004-10-27 01:44:13.000000000 +0200
@@ -508,7 +508,7 @@ struct task_struct {
 	struct timer_list real_timer;
 	unsigned long utime, stime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
-	struct timespec start_time;
+	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt;
 /* process credentials */

--- linux-2.6.9/include/linux/times.h	2004-10-27 00:04:58.000000000 +0200
+++ linux-2.6.9-uf/include/linux/times.h	2004-10-27 01:44:23.000000000 +0200
@@ -7,16 +7,11 @@
 #include <asm/types.h>
 #include <asm/param.h>
 
-static inline clock_t jiffies_to_clock_t(long x)
-{
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
-	return x / (HZ / USER_HZ);
+#if (HZ % USER_HZ)==0
+# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
 #else
-	u64 tmp = (u64)x * TICK_NSEC;
-	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
-	return (long)tmp;
+# define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
 #endif
-}
 
 static inline unsigned long clock_t_to_jiffies(unsigned long x)
 {
@@ -40,7 +35,7 @@ static inline unsigned long clock_t_to_j
 
 static inline u64 jiffies_64_to_clock_t(u64 x)
 {
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+#if (HZ % USER_HZ)==0
 	do_div(x, HZ / USER_HZ);
 #else
 	/*
@@ -48,33 +43,13 @@ static inline u64 jiffies_64_to_clock_t(
 	 * but even this doesn't overflow in hundreds of years
 	 * in 64 bits, so..
 	 */
-	x *= TICK_NSEC;
-	do_div(x, (NSEC_PER_SEC / USER_HZ));
+	x *= USER_HZ;
+	do_div(x, HZ);
 #endif
 	return x;
 }
 #endif
 
-static inline u64 nsec_to_clock_t(u64 x)
-{
-#if (NSEC_PER_SEC % USER_HZ) == 0
-	do_div(x, (NSEC_PER_SEC / USER_HZ));
-#elif (USER_HZ % 512) == 0
-	x *= USER_HZ/512;
-	do_div(x, (NSEC_PER_SEC / 512));
-#else
-	/*
-         * max relative error 5.7e-8 (1.8s per year) for USER_HZ <= 1024,
-         * overflow after 64.99 years.
-         * exact for HZ=60, 72, 90, 120, 144, 180, 300, 600, 900, ...
-         */
-	x *= 9;
-	do_div(x, (unsigned long)((9ull * NSEC_PER_SEC + (USER_HZ/2))
-	                          / USER_HZ));
-#endif
-	return x;
-}
-
 struct tms {
 	clock_t tms_utime;
 	clock_t tms_stime;

--- linux-2.6.9/kernel/acct.c	2004-10-27 00:04:58.000000000 +0200
+++ linux-2.6.9-uf/kernel/acct.c	2004-10-27 01:44:13.000000000 +0200
@@ -384,8 +384,6 @@ static void do_acct_process(long exitcod
 	unsigned long vsize;
 	unsigned long flim;
 	u64 elapsed;
-	u64 run_time;
-	struct timespec uptime;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -403,13 +401,7 @@ static void do_acct_process(long exitcod
 	ac.ac_version = ACCT_VERSION | ACCT_BYTEORDER;
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
-	/* calculate run_time in nsec*/
-	do_posix_clock_monotonic_gettime(&uptime);
-	run_time = (u64)uptime.tv_sec*NSEC_PER_SEC + uptime.tv_nsec;
-	run_time -= (u64)current->start_time.tv_sec*NSEC_PER_SEC
-					+ current->start_time.tv_nsec;
-	/* convert nsec -> AHZ */
-	elapsed = nsec_to_AHZ(run_time);
+	elapsed = jiffies_64_to_AHZ(get_jiffies_64() - current->start_time);
 #if ACCT_VERSION==3
 	ac.ac_etime = encode_float(elapsed);
 #else

--- linux-2.6.9/kernel/fork.c	2004-10-27 00:04:58.000000000 +0200
+++ linux-2.6.9-uf/kernel/fork.c	2004-10-27 01:44:13.000000000 +0200
@@ -992,7 +992,7 @@ static task_t *copy_process(unsigned lon
 
 	p->utime = p->stime = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
-	do_posix_clock_monotonic_gettime(&p->start_time);
+	p->start_time = get_jiffies_64();
 	p->security = NULL;
 	p->io_context = NULL;
 	p->io_wait = NULL;

--- linux-2.6.9/mm/oom_kill.c	2004-10-27 00:04:59.000000000 +0200
+++ linux-2.6.9-uf/mm/oom_kill.c	2004-10-27 01:44:13.000000000 +0200
@@ -26,7 +26,6 @@
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
- * @p: current uptime in seconds
  *
  * The formula used is relatively simple and documented inline in the
  * function. The main rationale is that we want to select a good task
@@ -42,7 +41,7 @@
  *    of least surprise ... (be careful when you change it)
  */
 
-static unsigned long badness(struct task_struct *p, unsigned long uptime)
+static unsigned long badness(struct task_struct *p)
 {
 	unsigned long points, cpu_time, run_time, s;
 
@@ -57,16 +56,12 @@ static unsigned long badness(struct task
 	points = p->mm->total_vm;
 
 	/*
-	 * CPU time is in tens of seconds and run time is in thousands
-         * of seconds. There is no particular reason for this other than
-         * that it turned out to work very well in practice.
+	 * CPU time is in seconds and run time is in minutes. There is no
+	 * particular reason for this other than that it turned out to work
+	 * very well in practice.
 	 */
 	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
-
-	if (uptime >= p->start_time.tv_sec)
-		run_time = (uptime - p->start_time.tv_sec) >> 10;
-	else
-		run_time = 0;
+	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
 
 	s = int_sqrt(cpu_time);
 	if (s)
@@ -116,12 +111,10 @@ static struct task_struct * select_bad_p
 	unsigned long maxpoints = 0;
 	struct task_struct *g, *p;
 	struct task_struct *chosen = NULL;
-	struct timespec uptime;
 
-	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p)
 		if (p->pid) {
-			unsigned long points = badness(p, uptime.tv_sec);
+			unsigned long points = badness(p);
 			if (points > maxpoints) {
 				chosen = p;
 				maxpoints = points;
