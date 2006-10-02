Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965435AbWJBVtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965435AbWJBVtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965436AbWJBVtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:49:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:13031 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965435AbWJBVtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:49:31 -0400
Subject: Re: [patch 02/23] GTOD: persistent clock support, core
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <20060930013558.679bf961.akpm@osdl.org>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	 <20060929234439.041924000@cruncher.tec.linutronix.de>
	 <20060930013558.679bf961.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 14:49:23 -0700
Message-Id: <1159825763.27968.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 01:35 -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 23:58:21 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > From: John Stultz <johnstul@us.ibm.com>
> > 
> > persistent clock support: do proper timekeeping across suspend/resume.
> 
> How?

Improved description included below.

> > +/* Weak dummy function for arches that do not yet support it.
> > + * XXX - Do be sure to remove it once all arches implement it.
> > + */
> > +unsigned long __attribute__((weak)) read_persistent_clock(void)
> > +{
> > +	return 0;
> > +}
> 
> Seconds?  microseconds?  jiffies?  walltime?  uptime?
> 
> Needs some comments.

Agreed. Thanks for pointing it out.


> 
> >  void __init timekeeping_init(void)
> >  {
> > -	unsigned long flags;
> > +	unsigned long flags, sec = read_persistent_clock();
> 
> So it apparently returns seconds-since-epoch?
> 
> If so, why?
> 
> >  	write_seqlock_irqsave(&xtime_lock, flags);
> >  
> > @@ -758,11 +769,18 @@ void __init timekeeping_init(void)
> >  	clocksource_calculate_interval(clock, tick_nsec);
> >  	clock->cycle_last = clocksource_read(clock);
> >  
> > +	xtime.tv_sec = sec;
> > +	xtime.tv_nsec = (jiffies % HZ) * (NSEC_PER_SEC / HZ);
> 
> Why is it valid to take the second from the persistent clock and the
> fraction-of-a-second from jiffies?  Some comments describing the
> implementation would improve its understandability and maintainability.

Yea. i386 and other arches have done this for awhile, so I preserved it.
However on further inspection, it really doesn't make much sense. We're
pre-timer interurpts anyway, so jiffies won't have begun yet. So now I
just initialize it to zero.

> This statement can set xtime.tv_nsec to a value >= NSEC_PER_SEC.  Should it
> not be normalised?

Yep, it is, and you commented just above it.:)

> > +	set_normalized_timespec(&wall_to_monotonic,
> > +		-xtime.tv_sec, -xtime.tv_nsec);
> > +
> >  	write_sequnlock_irqrestore(&xtime_lock, flags);
> >  }
> >  
> >  static int timekeeping_suspended;
> > +static unsigned long timekeeping_suspend_time;
> 
> In what units?

Fixed.

> > +
> >  /**
> >   * timekeeping_resume - Resumes the generic timekeeping subsystem.
> >   * @dev:	unused
> > @@ -773,14 +791,23 @@ static int timekeeping_suspended;
> >   */
> >  static int timekeeping_resume(struct sys_device *dev)
> >  {
> > -	unsigned long flags;
> > +	unsigned long flags, now = read_persistent_clock();
> 
> Would whoever keeps doing that please stop it?  This:
> 	unsigned long flags;
> 	unsigned long now = read_persistent_clock();
> 
> is more readable and makes for more readable patches in the future.

Fixed.

> >  	write_seqlock_irqsave(&xtime_lock, flags);
> > -	/* restart the last cycle value */
> > +
> > +	if (now && (now > timekeeping_suspend_time)) {
> > +		unsigned long sleep_length = now - timekeeping_suspend_time;
> > +		xtime.tv_sec += sleep_length;
> > +		jiffies_64 += sleep_length * HZ;
> 
> sleep_length will overflow if we slept for more than 49 days, and HZ=1000.

Oh! Great catch! Fixed.

Thanks so much for the thorough review!

Updated patch follows:

thanks
-john


Implement generic timekeeping suspend/resume accounting by introducing 
the read_persistent_clock() interface. This is an arch specific 
function that returns the seconds since the epoch using the arch 
defined battery backed clock.

Aside from allowing the removal of duplicate arch specific resume 
logic, this change helps avoid potential resume time ordering issues 
between generic and arch specific time code.

This patch only provides the generic usage of this new function and a 
weak dummy function, that always returns zero if no arch specific 
function is defined. Thus if no persistent clock is present, no change 
in behavior should be seen with this patch.

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: John Stultz <johnstul@us.ibm.com>
--

 include/linux/hrtimer.h |    3 +++
 include/linux/time.h    |    1 +
 kernel/hrtimer.c        |    8 ++++++++
 kernel/timer.c          |   40 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 51 insertions(+), 1 deletion(-)

linux-2.6.18_timeofday-persistent-clock-generic_C7.patch
============================================
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index fca9302..660d91d 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -146,6 +146,9 @@ extern void hrtimer_init_sleeper(struct 
 /* Soft interrupt function to run the hrtimer queues: */
 extern void hrtimer_run_queues(void);
 
+/* Resume notification */
+void hrtimer_notify_resume(void);
+
 /* Bootup initialization: */
 extern void __init hrtimers_init(void);
 
diff --git a/include/linux/time.h b/include/linux/time.h
index a5b7399..db31d2a 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -92,6 +92,7 @@ extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;
 
+extern unsigned long read_persistent_clock(void);
 void timekeeping_init(void);
 
 static inline unsigned long get_seconds(void)
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index d0ba190..090b752 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -287,6 +287,14 @@ static unsigned long ktime_divns(const k
 #endif /* BITS_PER_LONG >= 64 */
 
 /*
+ * Timekeeping resumed notification
+ */
+void hrtimer_notify_resume(void)
+{
+	clock_was_set();
+}
+
+/*
  * Counterpart to lock_timer_base above:
  */
 static inline
diff --git a/kernel/timer.c b/kernel/timer.c
index c1c7fbc..5069139 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -41,6 +41,9 @@
 #include <asm/timex.h>
 #include <asm/io.h>
 
+/* jiffies at the most recent update of wall time */
+unsigned long wall_jiffies = INITIAL_JIFFIES;
+
 u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
@@ -743,12 +746,27 @@ int timekeeping_is_continuous(void)
 	return ret;
 }
 
+/**
+ * read_persistent_clock -  Return time in seconds from the persistent clock.
+ *
+ * Weak dummy function for arches that do not yet support it.
+ * Returns seconds from epoch using the battery backed persistent clock.
+ * Returns zero if unsupported.
+ *
+ *  XXX - Do be sure to remove it once all arches implement it.
+ */
+unsigned long __attribute__((weak)) read_persistent_clock(void)
+{
+	return 0;
+}
+
 /*
  * timekeeping_init - Initializes the clocksource and common timekeeping values
  */
 void __init timekeeping_init(void)
 {
 	unsigned long flags;
+	unsigned long sec = read_persistent_clock();
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 
@@ -758,11 +776,20 @@ void __init timekeeping_init(void)
 	clocksource_calculate_interval(clock, tick_nsec);
 	clock->cycle_last = clocksource_read(clock);
 
+	xtime.tv_sec = sec;
+	xtime.tv_nsec = 0;
+	set_normalized_timespec(&wall_to_monotonic,
+		-xtime.tv_sec, -xtime.tv_nsec);
+
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
 
 
+/* flag for if timekeeping is suspended */
 static int timekeeping_suspended;
+/* time in seconds when suspend began */
+static unsigned long timekeeping_suspend_time;
+
 /**
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
  * @dev:	unused
@@ -774,13 +801,23 @@ static int timekeeping_suspended;
 static int timekeeping_resume(struct sys_device *dev)
 {
 	unsigned long flags;
+	unsigned long now = read_persistent_clock();
 
 	write_seqlock_irqsave(&xtime_lock, flags);
-	/* restart the last cycle value */
+
+	if (now && (now > timekeeping_suspend_time)) {
+		unsigned long sleep_length = now - timekeeping_suspend_time;
+		xtime.tv_sec += sleep_length;
+		jiffies_64 += (u64)sleep_length * HZ;
+	}
+	/* re-base the last cycle value */
 	clock->cycle_last = clocksource_read(clock);
 	clock->error = 0;
 	timekeeping_suspended = 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	hrtimer_notify_resume();
+
 	return 0;
 }
 
@@ -790,6 +827,7 @@ static int timekeeping_suspend(struct sy
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 	timekeeping_suspended = 1;
+	timekeeping_suspend_time = read_persistent_clock();
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return 0;
 }


