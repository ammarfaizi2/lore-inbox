Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWGJSAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWGJSAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWGJSAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:00:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:61922 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964950AbWGJSAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:00:32 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: john stultz <johnstul@us.ibm.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
In-Reply-To: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 10:58:47 -0700
Message-Id: <1152554328.5320.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 01:52 +0200, Mikael Pettersson wrote:
> On Sun, 09 Jul 2006 14:20:56 -0700, john stultz wrote:
> >> I've traced the cause of this problem to the i386 time-keeping
> >> changes in kernel 2.6.17-git11. What happens is that:
> >> - The kernel autoselects TSC as my clocksource, which is
> >>   reasonable since it's a PentiumII. 2.6.17 also chose the TSC.
> >> - Immediately after APM resumes (arch/i386/kernel/apm.c line
> >>   1231 in 2.6.18-rc1) there is an interrupt from the PIT,
> >>   which takes us to kernel/timer.c:update_wall_time().
> >> - update_wall_time() does a clocksource_read() and computes
> >>   the offset from the previous read. However, the TSC was
> >>   reset by HW or BIOS during the APM suspend/resume cycle and
> >>   is now smaller than it was at the prevous read. On my machine,
> >>   the offset is 0xffffffd598e0a566 at this point, which appears
> >>   to throw update_wall_time() into a very very long loop.
> >
> >Huh. It seems you're getting an interrupt before timekeeping_resume()
> >runs (which resets cycle_last). I'll look over the code and see if I can
> >sort out why it works w/ ACPI suspend, but not APM, or if the
> >resume/interrupt-enablement bit is just racy in general.
> 
> I forgot to mention this, but I had a debug printk() in apm.c
> which showed that irqs_disabled() == 0 at the point when APM
> resumes the kernel.

So it seems possible that the timer tick will be enabled before the
timekeeping resume code runs. I'm not sure why this isn't seen w/ ACPI
suspend/resume, as I think they're using the same
sysdev_class .suspend/.resume bits. 

Anyway, I think this patch should fix it (I've only compile tested it,
as I don't have my laptop on me right now). Would you mind giving it a
try? 

thanks
-john

diff --git a/kernel/timer.c b/kernel/timer.c
index 396a3c0..afaa594 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -966,7 +966,7 @@ void __init timekeeping_init(void)
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
 
-
+static int timekeeping_suspended;
 /*
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
  * @dev:	unused
@@ -982,6 +982,18 @@ static int timekeeping_resume(struct sys
 	write_seqlock_irqsave(&xtime_lock, flags);
 	/* restart the last cycle value */
 	clock->cycle_last = clocksource_read(clock);
+	clock->error = 0;
+	timekeeping_suspended = 0;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+	return 0;
+}
+
+static int timekeeping_suspend(struct sys_device *dev, pm_message_t state)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	timekeeping_suspended = 1;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return 0;
 }
@@ -989,6 +1001,7 @@ static int timekeeping_resume(struct sys
 /* sysfs resume/suspend bits for timekeeping */
 static struct sysdev_class timekeeping_sysclass = {
 	.resume		= timekeeping_resume,
+	.suspend	= timekeeping_suspend,
 	set_kset_name("timekeeping"),
 };
 
@@ -1090,14 +1103,17 @@ static void clocksource_adjust(struct cl
 static void update_wall_time(void)
 {
 	cycle_t offset;
-
-	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
+	
+	/* avoid timekeeping before we're fully resumed */
+	if (unlikely(timekeeping_suspended))
+		return;
 
 #ifdef CONFIG_GENERIC_TIME
 	offset = (clocksource_read(clock) - clock->cycle_last) & clock->mask;
 #else
 	offset = clock->cycle_interval;
 #endif
+	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
 
 	/* normally this loop will run just once, however in the
 	 * case of lost or late ticks, it will accumulate correctly.


