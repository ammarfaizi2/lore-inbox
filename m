Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268920AbUHZMWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268920AbUHZMWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUHZMU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:20:56 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:18647 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S268798AbUHZMKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:10:37 -0400
Date: Thu, 26 Aug 2004 14:07:53 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       John Stultz <johnstul@us.ibm.com>, albert@users.sourceforge.net,
       george@mvista.com, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
In-Reply-To: <20040826040436.360f05f7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>
References: <87smcf5zx7.fsf@devron.myhome.or.jp> <20040816124136.27646d14.akpm@osdl.org>
 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
 <412285A5.9080003@mvista.com> <1092782243.2429.254.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
 <1092787863.2429.311.camel@cog.beaverton.ibm.com> <1092781172.2301.1654.camel@cube>
 <1092791363.2429.319.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
 <20040819191537.GA24060@elektroni.ee.tut.fi> <20040826040436.360f05f7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Andrew Morton wrote:

> Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
> >
> > On Wed, Aug 18, 2004 at 09:42:17AM +0200, Tim Schmielau wrote:
> > > Updated patch below. It's not very well tested, but it compiles, boots, 
> > > and fixes the problem on i386 with the default HZ=1000 and USER_HZ=100.
> > 
> > Yes, it works nicely now.
> 
> So...  is this settled now?
> 
> If so, could you (Tim) please send out a fresh, changelogged version of the
> patch for review?
> 
> Thanks.

I still want to do some basic testing, (boot with different values of HZ /
USER_HZ, check that I didn't spoil the OOM killer), and we might have some
arguments about the helper functions, but it might already go into -mm as
it is:


Derive process start times from the posix_clock_monotonic notion of 
uptime instead of "jiffies", consistent with the earlier change to 
/proc/uptime itself.
(http://linus.bkbits.net:8080/linux-2.5/cset@3ef4851dGg0fxX58R9Zv8SIq9fzNmQ?na%0Av=index.html|src/.|src/fs|src/fs/proc|related/fs/proc/proc_misc.c)

Process start times are reported to userspace in units of 1/USER_HZ since
boot, thus applications as procps need the value of "uptime" to convert
them into absolute time.

Currently "uptime" is derived from an ntp-corrected time base, but process
start time is derived from the free-running "jiffies" counter.
This results in inaccurate, drifting process start times as seen by the
user, even if the exported number stays constant, because the users notion
of "jiffies" changes in time.

It's John Stultz's patch anyways, which I only messed up a bit, but since
people started trading signed-off lines on lkml:

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>


--- linux-2.6.8.1-oom/fs/proc/array.c	2004-08-17 21:38:54.000000000 +0200
+++ linux-2.6.8.1-oom-uf/fs/proc/array.c	2004-08-25 23:24:20.000000000 +0200
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

--- linux-2.6.8.1-oom/include/linux/acct.h	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-oom-uf/include/linux/acct.h	2004-08-25 23:50:15.000000000 +0200
@@ -172,17 +172,24 @@ static inline u32 jiffies_to_AHZ(unsigne
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
+         * max relative error 5.7e-8 (1.8s per year) for AHZ <= 1024,
+         * overflow after 64.99 years.
+         * exact for AHZ=60, 72, 90, 120, 144, 180, 300, 600, 900, ...
+         */
+	x *= 9;
+	do_div(x, (unsigned long)((9ull * NSEC_PER_SEC + (AHZ/2))
+	                          / AHZ));
 #endif
-       return x;
+	return x;
 }
 
 #endif  /* __KERNEL */

--- linux-2.6.8.1-oom/include/linux/sched.h	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-oom-uf/include/linux/sched.h	2004-08-25 23:24:20.000000000 +0200
@@ -457,7 +457,7 @@ struct task_struct {
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
-	u64 start_time;
+	struct timespec start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 /* process credentials */

--- linux-2.6.8.1-oom/include/linux/times.h	2004-08-17 00:13:35.000000000 +0200
+++ linux-2.6.8.1-oom-uf/include/linux/times.h	2004-08-25 23:24:20.000000000 +0200
@@ -55,6 +55,26 @@ static inline u64 jiffies_64_to_clock_t(
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
+         * max relative error 5.7e-8 (1.8s per year) for USER_HZ <= 1024,
+         * overflow after 64.99 years.
+         * exact for HZ=60, 72, 90, 120, 144, 180, 300, 600, 900, ...
+         */
+	x *= 9;
+	do_div(x, (unsigned long)((9ull * NSEC_PER_SEC + (USER_HZ/2))
+	                          / USER_HZ));
+#endif
+	return x;
+}
+
 struct tms {
 	clock_t tms_utime;
 	clock_t tms_stime;

--- linux-2.6.8.1-oom/kernel/acct.c	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-oom-uf/kernel/acct.c	2004-08-25 23:24:20.000000000 +0200
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
+					+ current->start_time.tv_nsec;
+	/* convert nsec -> AHZ */
+	elapsed = nsec_to_AHZ(run_time);
 #if ACCT_VERSION==3
 	ac.ac_etime = encode_float(elapsed);
 #else

--- linux-2.6.8.1-oom/kernel/fork.c	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-oom-uf/kernel/fork.c	2004-08-25 23:24:20.000000000 +0200
@@ -961,7 +961,7 @@ struct task_struct *copy_process(unsigne
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = get_jiffies_64();
+	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
 	p->io_context = NULL;
 	p->audit_context = NULL;

--- linux-2.6.8.1-oom/mm/oom_kill.c	2004-08-24 17:40:58.000000000 +0200
+++ linux-2.6.8.1-oom-uf/mm/oom_kill.c	2004-08-25 23:32:03.000000000 +0200
@@ -26,6 +26,7 @@
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
+ * @p: current uptime in seconds
  *
  * The formula used is relatively simple and documented inline in the
  * function. The main rationale is that we want to select a good task
@@ -41,7 +42,7 @@
  *    of least surprise ... (be careful when you change it)
  */
 
-static unsigned long badness(struct task_struct *p)
+static unsigned long badness(struct task_struct *p, unsigned long uptime)
 {
 	unsigned long points, cpu_time, run_time, s;
 
@@ -56,12 +57,16 @@ static unsigned long badness(struct task
 	points = p->mm->total_vm;
 
 	/*
-	 * CPU time is in seconds and run time is in minutes. There is no
-	 * particular reason for this other than that it turned out to work
-	 * very well in practice.
+	 * CPU time is in tens of seconds and run time is in thousands
+         * of seconds. There is no particular reason for this other than
+         * that it turned out to work very well in practice.
 	 */
 	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
-	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
+
+	if (uptime >= p->start_time.tv_sec)
+		run_time = (uptime - p->start_time.tv_sec) >> 10;
+	else
+		run_time = 0;
 
 	s = int_sqrt(cpu_time);
 	if (s)
@@ -111,10 +116,12 @@ static struct task_struct * select_bad_p
 	unsigned long maxpoints = 0;
 	struct task_struct *g, *p;
 	struct task_struct *chosen = NULL;
+	struct timespec uptime;
 
+	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p)
 		if (p->pid) {
-			unsigned long points = badness(p);
+			unsigned long points = badness(p, uptime.tv_sec);
 			if (points > maxpoints) {
 				chosen = p;
 				maxpoints = points;
