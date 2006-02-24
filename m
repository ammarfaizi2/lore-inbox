Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWBXBK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWBXBK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWBXBKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:10:55 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:33764 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932336AbWBXBKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:10:54 -0500
Subject: Re: [BUG -rt] -rt16 hang w/ realtime thread test
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1139882031.28536.135.camel@cog.beaverton.ibm.com>
References: <1139626674.28536.30.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0602111033400.13041@gandalf.stny.rr.com>
	 <1139882031.28536.135.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 17:10:51 -0800
Message-Id: <1140743451.1271.73.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 17:53 -0800, john stultz wrote:
> On Sat, 2006-02-11 at 10:34 -0500, Steven Rostedt wrote:
> > On Fri, 10 Feb 2006, john stultz wrote:
> > 
> > > Hey Ingo,
> > > 	I've been hunting a report that lower priority realtime threads are not
> > > preempting higher priority realtime threads. However, in generating test
> > > cases, I found I was locking the system quite frequently.
> > >
> > > The attached test runs to completion on 2.6.15, but with 2.6.15-rt16, it
> > > hangs the box. It could very well be a test issue, but I'm not sure I
> > > see where the problem is.
> > >
> > 
> > Hi John,
> > 
> > Have you turned on nmi_watchdog and softlockup detect?  Just so we can see
> > where it is hung.
> 
> Ugh. Ok, I think I've found the issue.
> 
> The systems I'm testing w/ all use the ACPI PM timer for the
> clocksource. On a whim I forced the TSC to be used and the hang went
> away.
> 
> It appears the issue is that the ACPI PM wraps every ~5 seconds.  Since
> the test takes longer the 5 seconds to run, the
> timeofday_periodic_hook() function gets starved and we never accumulate
> time. Then as the counter wraps, time starts wrapping thus timers do not
> expire and the test never completes, effectively hanging the box.
> 
> I believe this issue was hit before back when cycle_t was 32bits long,
> thus causing the TSC to wrap every ~4seconds on a 1Ghz box.
> 
> So whats the solution here? Do we need to do something to
> timeofday_periodic_hook is guaranteed to run with some frequency? Or is
> the test just bunk because realtime threads must give up the cpu in
> order for the kernel to function?

So without any suggestions, I created a terrible hack that tries to
avoid this issue. Maybe it will spur some discussion. :)

Basically, we set a flag value every time timeofday_periodic_hook() is
run, then every HZ ticks (1 second), we call
timeofday_ensure_correctness() which checks that flag variable to make
sure the periodic_hook has been called in that second. If it has been
called clear the flag and wait another second, otherwise directly call
timeofday_periodic_hook().

This has worked around the starvation in my tests, but I really doubt
its the right solution.

Any other ideas or thoughts?

thanks
-john

diff -ru 2.6-rt/kernel/time/clockevents.c rttest/kernel/time/clockevents.c
--- 2.6-rt/kernel/time/clockevents.c	2006-02-22 17:31:03.000000000 -0600
+++ rttest/kernel/time/clockevents.c	2006-02-23 19:24:25.000000000 -0600
@@ -94,8 +94,15 @@
 /*
  * Handle tick
  */
+extern void timeofday_ensure_correctness(void);
+
 static void handle_tick(struct pt_regs *regs)
 {
+	static atomic_t tick_ctr;
+	atomic_inc(&tick_ctr);
+	if(!(atomic_read(&tick_ctr)%HZ))
+		timeofday_ensure_correctness();
+
 	write_seqlock(&xtime_lock);
 	do_timer(regs);
 	write_sequnlock(&xtime_lock);
diff -ru 2.6-rt/kernel/time/timeofday.c rttest/kernel/time/timeofday.c
--- 2.6-rt/kernel/time/timeofday.c	2006-02-22 17:31:03.000000000 -0600
+++ rttest/kernel/time/timeofday.c	2006-02-23 19:50:16.000000000 -0600
@@ -487,6 +487,9 @@
 
 device_initcall(timeofday_init_device);
 
+/* hack for periodic hook starvation */
+unsigned long recently_run;
+
 /**
  * timeofday_periodic_hook - Does periodic update of timekeeping values.
  * @unused:	unused value
@@ -514,6 +517,8 @@
 	struct clocksource old_clock;
 	static nsec_t second_check;
 
+	set_bit(0,&recently_run);
+
 	write_seqlock_irqsave(&system_time_lock, flags);
 
 	/* read time source & calc time since last call: */
@@ -626,6 +631,17 @@
 		jiffies + 1 + msecs_to_jiffies(PERIODIC_INTERVAL_MS));
 }
 
+/* If timeofday_periodic_hook might be starved, call this at least
+ * once a second from interrupt context to ensure things run properly.
+ */
+void timeofday_ensure_correctness(void)
+{
+	if (!test_bit(0,&recently_run))
+		timeofday_periodic_hook(0);
+	else
+		clear_bit(0, &recently_run);
+}
+
 /**
  * timeofday_is_continuous - check to see if timekeeping is free running
  */


