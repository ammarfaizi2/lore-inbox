Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWGKWti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWGKWti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWGKWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:49:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:62337 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932228AbWGKWth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:49:37 -0400
Subject: [PATCH] improve timekeeping resume robustness
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz,
       Mikael Pettersson <mikpe@it.uu.se>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <200607102336.k6ANaFpx020663@harpo.it.uu.se>
References: <200607102336.k6ANaFpx020663@harpo.it.uu.se>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 15:49:34 -0700
Message-Id: <1152658174.4852.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 01:36 +0200, Mikael Pettersson wrote:
> With this patch my Latitude resumes OK from APM suspend again.

This patch (against current git tree) resolves problems seen w/ APM
suspend.

Due to resume initialization ordering, its possible we could get a timer
interrupt before the timekeeping resume() function is called. This patch
ensures we don't do any timekeeping accounting before we're fully
resumed.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/kernel/timer.c b/kernel/timer.c
index 2a87430..6ffff03 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -968,6 +968,7 @@ void __init timekeeping_init(void)
 }
 
 
+static int timekeeping_suspended;
 /*
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
  * @dev:	unused
@@ -983,6 +984,18 @@ static int timekeeping_resume(struct sys
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
@@ -990,6 +1003,7 @@ static int timekeeping_resume(struct sys
 /* sysfs resume/suspend bits for timekeeping */
 static struct sysdev_class timekeeping_sysclass = {
 	.resume		= timekeeping_resume,
+	.suspend	= timekeeping_suspend,
 	set_kset_name("timekeeping"),
 };
 
@@ -1099,14 +1113,17 @@ static void clocksource_adjust(struct cl
 static void update_wall_time(void)
 {
 	cycle_t offset;
-
-	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
+	
+	/* Make sure we're fully resumed: */
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


