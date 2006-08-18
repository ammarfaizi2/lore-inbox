Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWHRAHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWHRAHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 20:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWHRAHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 20:07:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26266 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932163AbWHRAHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 20:07:19 -0400
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever
	clock
From: john stultz <johnstul@us.ibm.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200608171641.20919.david-b@pacbell.net>
References: <200608162247.41632.david-b@pacbell.net>
	 <200608171328.24344.david-b@pacbell.net>
	 <1155850921.31755.115.camel@cog.beaverton.ibm.com>
	 <200608171641.20919.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 17:07:16 -0700
Message-Id: <1155859636.31755.159.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 16:41 -0700, David Brownell wrote:
> On Thursday 17 August 2006 2:42 pm, john stultz wrote:
> > On Thu, 2006-08-17 at 13:28 -0700, David Brownell wrote:
> > > On Thursday 17 August 2006 12:08 pm, john stultz wrote:
> > > > On Wed, 2006-08-16 at 22:47 -0700, David Brownell wrote:
> > > > > 
> > > > > Hmm, this seems to ignore the RTC framework rather entirely, which
> > > > > seems to me like the wrong implementation approach.  You'd likely have
> > > > > noticed that if you had supported a few ARM boards.  :)
> > > > 
> > > > Good point. I've not spent enough time looking at the RTC code, and it
> > > > looks like it has potential to resolve some of the issues I'm looking
> > > > at. Although, how common is it really?
> > > 
> > > Increasingly so; it solves a lot of reinvent-the-wheel problems, much
> > > like the recent generic time-of-day updates are doing.  And just like
> > > with clocksource updates, not all architectures have converted yet!
> > 
> > Is a breakdown somewhere of what is covered at this point? The two
> > letters followed by six number driver files make it difficult to see
> > which arches use what. :)
> 
> A lot of those are part numbers for discrete chips, and some names are
> for various ARM SOC families.
> 
> Seems to me the better question is what non-framework RTC drivers are still
> in the tree ... and actually a good first pass at answering that is that
> every platform touched in your original patch was NOT using the RTC class
> framework.  (Not the answer you wanted, right?)  And drivers/char/*rtc* users.
> There may be a few other RTCs elsewhere in the tree.

Uh, so you're saying the RTC framework is basically ARM only?
Eek. You're right, that's not the answer I wanted to hear!

> It seems all in-kernel ARM platforms except ARM Ltd's own "Integrator" use
> the new framework instead of the older arch/arm/common/rtctime.c code (from
> which the RTC framework evolved).  And I know there are other RTC drivers
> and patches in the queue.  ARMs that haven't yet merged to mainline will,
> as usual, pay the price for their perfidy.
> 
> 
> > 	 However the suspend/resume ordering
> > issue is more difficult. On resume we need to have something usable
> > before we resume the timekeeping code in order to correctly increment
> > xtime and jiffies in one atomic action.
> 
> Right; not something addressed in your original patch, or by many current
> drivers AFAIK.  For the longest time, swsusp resume got that wrong...

True, I left it out of my patch since the generic suspend/resume takes a
bit more arch code then I had. You can find my current arch generic
portion of the patch (including suspend/resume adjustments) below.
Following this one would be the i386 patch that provides
read_persistent_clock() and removes all i386 arch specific timekeeping
adjustments (I can send it on request if needed).


> > > > > I'd be more interested in something that improves on CONFIG_RTC_HCTOSYS,
> > > > > and for example addresses the need to update the system wall time from
> > > > > such RTCs after resume, not just at boot time.
> > > > 
> > > > Agreed.
> > > 
> > > There's some ARM code to restore the jiffies-vs-rtc clock offset on resume,
> > > which seems like a candidate for wider use.
> > 
> > Where is this code? I'm interested here, but I suspect for correctness
> > that bit should be under the control of the timekeeping core.
> 
> {save,restore}_time_delta() in
> 
> 	include/asm-arm/mach/time.h
> 	arch/arm/kernel/time.c
> 
> The rtc-at91.c code is layered classically ... RTC is the first platform
> device registered, and thus resumed, but it's resumed after the jiffies
> timer sysdev (thus with IRQs enabled).  So it will restore the time delta
> very early in the resume sequence.  (PXA uses a different approach.)

Hmmm. So looking at the code, ARM doesn't update jiffies on resume?

> Presumably this is stuff that should be done by the RTC class resume()
> method, probably for the CONFIG_RTC_HCTOSYS_DEVICE clock (though there
> could be a better RTC ... one that's being NTP-corrected).  That'd
> be no sooner than 2.6.19, which adds new class-level suspend()/resume()
> calls to help offload individual drivers.

Hrm. I'm a bit skeptical that the RTC resume code should update the
timekeeping code instead of the timekeeping code doing it. It seems that
it would cause additional complexity (what if there are two RTC
devices?) and would still have some of the suspend/resume ordering
issues I'm worried about.

thanks
-john



 include/linux/time.h |    1 +
 kernel/timer.c       |   36 ++++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

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
diff --git a/kernel/timer.c b/kernel/timer.c
index b650f04..bbf4d99 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -47,6 +47,9 @@ static void time_interpolator_update(lon
 #define time_interpolator_update(x)
 #endif
 
+/* jiffies at the most recent update of wall time */
+unsigned long wall_jiffies = INITIAL_JIFFIES;
+
 u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
@@ -953,6 +956,14 @@ int timekeeping_is_continuous(void)
 	return ret;
 }
 
+/* Weak dummy function for arches that do not yet support it.
+ * XXX - Do be sure to remove it once all arches implement it.
+ */
+unsigned long __attribute__((weak)) read_persistent_clock(void)
+{
+	return 0;
+}
+
 /*
  * timekeeping_init - Initializes the clocksource and common timekeeping values
  */
@@ -961,15 +972,22 @@ void __init timekeeping_init(void)
 	unsigned long flags;
 
 	write_seqlock_irqsave(&xtime_lock, flags);
+	ntp_clear();
+
 	clock = clocksource_get_next();
 	clocksource_calculate_interval(clock, tick_nsec);
 	clock->cycle_last = clocksource_read(clock);
-	ntp_clear();
+
+	xtime.tv_sec = read_persistent_clock();
+	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
+	set_normalized_timespec(&wall_to_monotonic,
+		-xtime.tv_sec, -xtime.tv_nsec);
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
 
 
 static int timekeeping_suspended;
+static unsigned long timekeeping_suspend_time;
 /*
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
  * @dev:	unused
@@ -980,10 +998,18 @@ static int timekeeping_suspended;
  */
 static int timekeeping_resume(struct sys_device *dev)
 {
-	unsigned long flags;
+	unsigned long flags, now;
 
 	write_seqlock_irqsave(&xtime_lock, flags);
-	/* restart the last cycle value */
+	/* calculate time suspended using the persistent clock */
+	now = read_persistent_clock();
+	if (now && (now > timekeeping_suspend_time)) {
+		unsigned long sleep_length = now - timekeeping_suspend_time;
+		xtime.tv_sec += sleep_length;
+		jiffies_64 += sleep_length * HZ;
+		wall_jiffies += sleep_length * HZ;
+	}
+	/* re-base the last cycle value */
 	clock->cycle_last = clocksource_read(clock);
 	clock->error = 0;
 	timekeeping_suspended = 0;
@@ -997,6 +1023,7 @@ static int timekeeping_suspend(struct sy
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 	timekeeping_suspended = 1;
+	timekeeping_suspend_time = read_persistent_clock();
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return 0;
 }
@@ -1227,9 +1254,6 @@ static inline void calc_load(unsigned lo
 	}
 }
 
-/* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies = INITIAL_JIFFIES;
-
 /*
  * This read-write spinlock protects us from races in SMP while
  * playing with xtime and avenrun.


