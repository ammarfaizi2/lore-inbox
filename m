Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUHRALo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUHRALo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHRALo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:11:44 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:31219 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266845AbUHRALg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:11:36 -0400
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
In-Reply-To: <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	 <412285A5.9080003@mvista.com>
	 <1092782243.2429.254.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1092787863.2429.311.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Aug 2004 17:11:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 16:07, Tim Schmielau wrote:
> On Tue, 17 Aug 2004, john stultz wrote:
> > On Tue, 2004-08-17 at 15:24, George Anzinger wrote:
> > > I see you think you have the solution, but I guess I am just dense here.  May be 
> > > you could help me to see the error of my ways.  Here is my thinking:
> > > 
> > > "now" is from gettimeofday() and as such is ntp corrected.
> > > "uptime" is also corrected.  In fact it is "now" + "wall_to_monotonic".  And 
> > > "wall_to_monotonic" is _only_ changed by do_settime() when the clock is set.
> > > "time_from_boot_to_process_start" is the same as "start_time" restated in 
> > > seconds, i.e. it is a constant.  So, either one or more of the above assumtions 
> > > is wrong, or  somebody is twiddling the clock.  Otherwise I don't see how the 
> > > start time can move at all.
> 
> Start time indeed is a constant for each process, and doesn't drift. 
> The problem trather is that a (slightly) wrong start time is assigned
> to newly created processes.
> 
> > The problem is start time is derived from task->start_time which is the
> > jiffies value at the time the process started. Thus interval calculated
> > by: (start_time = p->start_time - INITIAL_JIFFIES) or (run_time =
> > get_jiffies_64() - p->start_time) is not NTP adjusted. 
> > 
> > So both (uptime - run_time) or (boot_time + start_time) will have
> > problems. 
> > 
> > What needs to happen is task->start_time is changed to a timespec which
> > is set at fork time to be do_posix_clock_monotonic_gettime(). Then in
> > proc_pid_stat() we can calculate the appropriate user-jiffies value.
> 
> Yep.

Ok, I think I've got something to start working with. It compiles, but I
don't have a free machine to test on, so Tim, maybe you could give this
a run? 

thanks
-john

===== fs/proc/array.c 1.62 vs edited =====
--- 1.62/fs/proc/array.c	2004-08-05 13:36:53 -07:00
+++ edited/fs/proc/array.c	2004-08-17 17:08:07 -07:00
@@ -356,7 +356,14 @@
 	read_unlock(&tasklist_lock);
 
 	/* Temporary variable needed for gcc-2.96 */
-	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
+	/* convert timespec -> nsec*/
+	start_time = (unsigned long long)task->start_time.tv_sec * NSEC_PER_SEC 
+				+ task->start_time.tv_nsec;
+	/* convert nsec -> ticks */
+	start_time *= HZ;
+	do_div(start_time, NSEC_PER_SEC);
+	/* convert ticks -> USER_HZ ticks */
+	start_time = jiffies_64_to_clock_t(start_time);
 
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
===== include/linux/sched.h 1.228 vs edited =====
--- 1.228/include/linux/sched.h	2004-07-28 21:58:54 -07:00
+++ edited/include/linux/sched.h	2004-08-17 15:49:38 -07:00
@@ -457,7 +457,7 @@
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
-	u64 start_time;
+	struct timespec start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 /* process credentials */
===== kernel/acct.c 1.34 vs edited =====
--- 1.34/kernel/acct.c	2004-08-02 01:00:40 -07:00
+++ edited/kernel/acct.c	2004-08-17 17:09:03 -07:00
@@ -384,6 +384,8 @@
 	unsigned long vsize;
 	unsigned long flim;
 	u64 elapsed;
+	u64 run_time;
+	struct timespec uptime;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -401,7 +403,16 @@
 	ac.ac_version = ACCT_VERSION | ACCT_BYTEORDER;
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
-	elapsed = jiffies_64_to_AHZ(get_jiffies_64() - current->start_time);
+	/* calculate run_time in nsec*/
+	do_posix_clock_monotonic_gettime(&uptime);
+	run_time = (u64)uptime.tv_sec*NSEC_PER_SEC + uptime.tv_nsec;	
+	run_time -= (u64)current->start_time.tv_sec*NSEC_PER_SEC 
+					+ current->start_Time.tv_nsec;
+	/* convert nsec -> ticks */
+	run_time *= HZ;
+	do_div(run_time, NSEC_PER_SEC);
+	
+	elapsed = jiffies_64_to_AHZ(run_time);
 #if ACCT_VERSION==3
 	ac.ac_etime = encode_float(elapsed);
 #else
===== kernel/fork.c 1.186 vs edited =====
--- 1.186/kernel/fork.c	2004-07-28 21:58:55 -07:00
+++ edited/kernel/fork.c	2004-08-17 15:51:30 -07:00
@@ -961,7 +961,7 @@
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = get_jiffies_64();
+	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
 	p->io_context = NULL;
 	p->audit_context = NULL;
===== mm/oom_kill.c 1.28 vs edited =====
--- 1.28/mm/oom_kill.c	2004-08-02 01:00:42 -07:00
+++ edited/mm/oom_kill.c	2004-08-17 17:09:32 -07:00
@@ -44,6 +44,7 @@
 static int badness(struct task_struct *p)
 {
 	int points, cpu_time, run_time, s;
+	struct timespec uptime;
 
 	if (!p->mm)
 		return 0;
@@ -61,7 +62,9 @@
 	 * very well in practice.
 	 */
 	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
-	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
+
+	do_posix_clock_monotonic_gettime(&uptime);
+	run_time = (uptime.tv_sec - p->start_time.tv_sec)/60;
 
 	s = int_sqrt(cpu_time);
 	if (s)


