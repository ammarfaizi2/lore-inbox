Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUHRHoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUHRHoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 03:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUHRHoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 03:44:09 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:2220 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263761AbUHRHny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 03:43:54 -0400
Date: Wed, 18 Aug 2004 09:42:17 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       george anzinger <george@mvista.com>, Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
In-Reply-To: <1092791363.2429.319.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
References: <1087948634.9831.1154.camel@cube>  <87smcf5zx7.fsf@devron.myhome.or.jp>
  <20040816124136.27646d14.akpm@osdl.org> 
 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de> 
 <412285A5.9080003@mvista.com>  <1092782243.2429.254.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de> 
 <1092787863.2429.311.camel@cog.beaverton.ibm.com>  <1092781172.2301.1654.camel@cube>
 <1092791363.2429.319.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004, john stultz wrote:

> Everybody sing: Thanks, nice catch/Here's an updated patch!

> ===== fs/proc/array.c 1.62 vs edited =====
> --- 1.62/fs/proc/array.c	2004-08-05 13:36:53 -07:00
> +++ edited/fs/proc/array.c	2004-08-17 18:03:55 -07:00
> @@ -356,7 +356,13 @@
>  	read_unlock(&tasklist_lock);
>  
>  	/* Temporary variable needed for gcc-2.96 */
> -	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
> +	/* convert timespec -> nsec*/
> +	start_time = (unsigned long long)task->start_time.tv_sec * NSEC_PER_SEC 
> +				+ task->start_time.tv_nsec;
> +	/* convert nsec -> ticks */
> +	do_div(start_time, NSEC_PER_SEC/HZ);
> +	/* convert ticks -> USER_HZ ticks */
> +	start_time = jiffies_64_to_clock_t(start_time);

As Albert already noted, we can collapse the two conversions into one.

> ===== kernel/acct.c 1.34 vs edited =====
[...]
> +	/* convert nsec -> ticks */
> +	do_div(run_time, NSEC_PER_SEC/HZ);
> +	
> +	elapsed = jiffies_64_to_AHZ(run_time);

ditto

> ===== mm/oom_kill.c 1.28 vs edited =====

> @@ -61,7 +62,9 @@
>  	 * very well in practice.
>  	 */
>  	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
> -	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
> +
> +	do_posix_clock_monotonic_gettime(&uptime);
> +	run_time = (uptime.tv_sec - p->start_time.tv_sec)/60;

Doh, now I understand what you scratched your head over...
Since these shifts are magical constants found by empirical tuning and 
anecdotal evidence, I'd rather keep the behavior of the code and fix the 
comment accordingly.

Also, we might optimize this to call do_posix_clock_monotonic_gettime()
only once per oom killer invocation, rather than once per process.
Haven't yet looked into how expensive do_posix_clock_monotonic_gettime()
is, though.


Updated patch below. It's not very well tested, but it compiles, boots, 
and fixes the problem on i386 with the default HZ=1000 and USER_HZ=100.

Time to do some work for my day-job now.

Thanks,
Tim


--- linux-2.6.8.1/fs/proc/array.c	2004-08-17 21:38:54.000000000 +0200
+++ linux-2.6.8.1-uf/fs/proc/array.c	2004-08-18 08:35:23.000000000 +0200
@@ -356,7 +356,11 @@ int proc_pid_stat(struct task_struct *ta
 	read_unlock(&tasklist_lock);
 
 	/* Temporary variable needed for gcc-2.96 */
-	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
+	/* convert timespec -> nsec*/
+	start_time = (unsigned long long)task->start_time.tv_sec * NSEC_PER_SEC 
+				+ task->start_time.tv_nsec;
+	/* convert nsec -> ticks */
+	start_time = nsec_to_clock_t(start_time);
 
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \

--- linux-2.6.8.1/include/linux/acct.h	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-uf/include/linux/acct.h	2004-08-18 08:41:38.000000000 +0200
@@ -172,17 +172,23 @@ static inline u32 jiffies_to_AHZ(unsigne
 #endif
 }
 
-static inline u64 jiffies_64_to_AHZ(u64 x)
+static inline u64 nsec_to_AHZ(u64 x)
 {
-#if (TICK_NSEC % (NSEC_PER_SEC / AHZ)) == 0
-#if HZ != AHZ
-	do_div(x, HZ / AHZ);
-#endif
-#else
-	x *= TICK_NSEC;
+#if (NSEC_PER_SEC % AHZ) == 0
 	do_div(x, (NSEC_PER_SEC / AHZ));
+#elif (AHZ % 512) == 0
+	x *= AHZ/512;
+	do_div(x, (NSEC_PER_SEC / 512));
+#else
+	/* 
+         * max relative error 1.28e-7 for AHZ <= 1024,
+         * overflow after 146 years.
+         * Note that 4*NSEC_PER_SEC just fits into an unsigned long.
+         */
+	x *= 4;
+	do_div(x, (4ul * NSEC_PER_SEC + (AHZ/2)) / AHZ);
 #endif
-       return x;
+	return x;
 }
 
 #endif  /* __KERNEL */

--- linux-2.6.8.1/include/linux/sched.h	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-uf/include/linux/sched.h	2004-08-18 07:59:52.000000000 +0200
@@ -457,7 +457,7 @@ struct task_struct {
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
-	u64 start_time;
+	struct timespec start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 /* process credentials */

--- linux-2.6.8.1/include/linux/times.h	2004-08-17 00:13:35.000000000 +0200
+++ linux-2.6.8.1-uf/include/linux/times.h	2004-08-18 08:38:45.000000000 +0200
@@ -55,6 +55,25 @@ static inline u64 jiffies_64_to_clock_t(
 }
 #endif
 
+static inline u64 nsec_to_clock_t(u64 x)
+{
+#if (NSEC_PER_SEC % USER_HZ) == 0
+	do_div(x, (NSEC_PER_SEC / USER_HZ));
+#elif (USER_HZ % 512) == 0
+	x *= USER_HZ/512;
+	do_div(x, (NSEC_PER_SEC / 512));
+#else
+	/* 
+         * max relative error 1.28e-7 for USER_HZ <= 1024,
+         * overflow after 146 years.
+         * Note that 4*NSEC_PER_SEC just fits into an unsigned long.
+         */
+	x *= 4;
+	do_div(x, (4ul * NSEC_PER_SEC + (USER_HZ/2)) / USER_HZ);
+#endif
+	return x;
+}
+
 struct tms {
 	clock_t tms_utime;
 	clock_t tms_stime;

--- linux-2.6.8.1/kernel/acct.c	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-uf/kernel/acct.c	2004-08-18 08:41:44.000000000 +0200
@@ -384,6 +384,8 @@ static void do_acct_process(long exitcod
 	unsigned long vsize;
 	unsigned long flim;
 	u64 elapsed;
+	u64 run_time;
+	struct timespec uptime;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -401,7 +403,13 @@ static void do_acct_process(long exitcod
 	ac.ac_version = ACCT_VERSION | ACCT_BYTEORDER;
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
-	elapsed = jiffies_64_to_AHZ(get_jiffies_64() - current->start_time);
+	/* calculate run_time in nsec*/
+	do_posix_clock_monotonic_gettime(&uptime);
+	run_time = (u64)uptime.tv_sec*NSEC_PER_SEC + uptime.tv_nsec;	
+	run_time -= (u64)current->start_time.tv_sec*NSEC_PER_SEC 
+					+ current->start_Time.tv_nsec;
+	/* convert nsec -> AHZ */
+	elapsed = nsec_to_AHZ(run_time);
 #if ACCT_VERSION==3
 	ac.ac_etime = encode_float(elapsed);
 #else

--- linux-2.6.8.1/kernel/fork.c	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-uf/kernel/fork.c	2004-08-18 07:59:52.000000000 +0200
@@ -961,7 +961,7 @@ struct task_struct *copy_process(unsigne
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = get_jiffies_64();
+	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
 	p->io_context = NULL;
 	p->audit_context = NULL;

--- linux-2.6.8.1/mm/oom_kill.c	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-uf/mm/oom_kill.c	2004-08-18 08:49:51.000000000 +0200
@@ -44,6 +44,7 @@
 static int badness(struct task_struct *p)
 {
 	int points, cpu_time, run_time, s;
+	struct timespec uptime;
 
 	if (!p->mm)
 		return 0;
@@ -56,12 +57,14 @@ static int badness(struct task_struct *p
 	points = p->mm->total_vm;
 
 	/*
-	 * CPU time is in seconds and run time is in minutes. There is no
-	 * particular reason for this other than that it turned out to work
-	 * very well in practice.
+	 * CPU time is in tens of seconds and run time is in thousands
+	 * of seconds. There is no particular reason for this other than
+	 * that it turned out to work very well in practice.
 	 */
 	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
-	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
+
+	do_posix_clock_monotonic_gettime(&uptime);
+	run_time = (uptime.tv_sec - p->start_time.tv_sec) >> 10;
 
 	s = int_sqrt(cpu_time);
 	if (s)
