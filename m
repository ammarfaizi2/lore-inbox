Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWGJXg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWGJXg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWGJXg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:36:27 -0400
Received: from aun.it.uu.se ([130.238.12.36]:234 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S965064AbWGJXg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:36:26 -0400
Date: Tue, 11 Jul 2006 01:36:15 +0200 (MEST)
Message-Id: <200607102336.k6ANaFpx020663@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: johnstul@us.ibm.com, mikpe@it.uu.se
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 10:58:47 -0700, john stultz wrote:
>So it seems possible that the timer tick will be enabled before the
>timekeeping resume code runs. I'm not sure why this isn't seen w/ ACPI
>suspend/resume, as I think they're using the same
>sysdev_class .suspend/.resume bits. 
>
>Anyway, I think this patch should fix it (I've only compile tested it,
>as I don't have my laptop on me right now). Would you mind giving it a
>try? 
>
>thanks
>-john

With this patch my Latitude resumes OK from APM suspend again.

Thanks John.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

>diff --git a/kernel/timer.c b/kernel/timer.c
>index 396a3c0..afaa594 100644
>--- a/kernel/timer.c
>+++ b/kernel/timer.c
>@@ -966,7 +966,7 @@ void __init timekeeping_init(void)
> 	write_sequnlock_irqrestore(&xtime_lock, flags);
> }
> 
>-
>+static int timekeeping_suspended;
> /*
>  * timekeeping_resume - Resumes the generic timekeeping subsystem.
>  * @dev:	unused
>@@ -982,6 +982,18 @@ static int timekeeping_resume(struct sys
> 	write_seqlock_irqsave(&xtime_lock, flags);
> 	/* restart the last cycle value */
> 	clock->cycle_last = clocksource_read(clock);
>+	clock->error = 0;
>+	timekeeping_suspended = 0;
>+	write_sequnlock_irqrestore(&xtime_lock, flags);
>+	return 0;
>+}
>+
>+static int timekeeping_suspend(struct sys_device *dev, pm_message_t state)
>+{
>+	unsigned long flags;
>+
>+	write_seqlock_irqsave(&xtime_lock, flags);
>+	timekeeping_suspended = 1;
> 	write_sequnlock_irqrestore(&xtime_lock, flags);
> 	return 0;
> }
>@@ -989,6 +1001,7 @@ static int timekeeping_resume(struct sys
> /* sysfs resume/suspend bits for timekeeping */
> static struct sysdev_class timekeeping_sysclass = {
> 	.resume		= timekeeping_resume,
>+	.suspend	= timekeeping_suspend,
> 	set_kset_name("timekeeping"),
> };
> 
>@@ -1090,14 +1103,17 @@ static void clocksource_adjust(struct cl
> static void update_wall_time(void)
> {
> 	cycle_t offset;
>-
>-	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
>+	
>+	/* avoid timekeeping before we're fully resumed */
>+	if (unlikely(timekeeping_suspended))
>+		return;
> 
> #ifdef CONFIG_GENERIC_TIME
> 	offset = (clocksource_read(clock) - clock->cycle_last) & clock->mask;
> #else
> 	offset = clock->cycle_interval;
> #endif
>+	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
> 
> 	/* normally this loop will run just once, however in the
> 	 * case of lost or late ticks, it will accumulate correctly.
>
>
