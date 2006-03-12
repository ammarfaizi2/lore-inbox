Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWCLKh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWCLKh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCLKg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:36:58 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26598
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751424AbWCLKgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:36:55 -0500
Message-Id: <20060312080331.963406000@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:16 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 3/8] posix-timer cleanup common_timer_get()
Content-Disposition: inline; filename=posixtimer-cleanup-common-timer-get.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roman Zippel <zippel@linux-m68k.org>

Cleanup common_timer_get() a little.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 kernel/posix-timers.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

Index: linux-2.6.16-updates/kernel/posix-timers.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/posix-timers.c
+++ linux-2.6.16-updates/kernel/posix-timers.c
@@ -606,18 +606,20 @@ static struct k_itimer * lock_timer(time
 static void
 common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
-	ktime_t remaining;
+	ktime_t now, remaining;
 	struct hrtimer *timer = &timr->it.real.timer;
 
 	memset(cur_setting, 0, sizeof(struct itimerspec));
-	remaining = hrtimer_get_remaining(timer);
 
-	/* Time left ? or timer pending */
-	if (remaining.tv64 > 0 || hrtimer_active(timer))
-		goto calci;
 	/* interval timer ? */
-	if (timr->it.real.interval.tv64 == 0)
+	if (timr->it.real.interval.tv64 == 0) {
+		cur_setting->it_interval =
+			ktime_to_timespec(timr->it.real.interval);
+	} else if (!hrtimer_active(timer))
 		return;
+
+	now = timer->base->get_time();
+
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer
 	 * move the expiry time forward by intervals, so expiry is >
@@ -625,16 +627,11 @@ common_timer_get(struct k_itimer *timr, 
 	 */
 	if (timr->it_requeue_pending & REQUEUE_PENDING ||
 	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-		timr->it_overrun +=
-			hrtimer_forward(timer, timer->base->get_time(),
-					timr->it.real.interval);
-		remaining = hrtimer_get_remaining(timer);
+		timr->it_overrun += hrtimer_forward(timer, now,
+						    timr->it.real.interval);
 	}
- calci:
-	/* interval timer ? */
-	if (timr->it.real.interval.tv64 != 0)
-		cur_setting->it_interval =
-			ktime_to_timespec(timr->it.real.interval);
+
+	remaining = ktime_sub(timer->expires, now);
 	/* Return 0 only, when the timer is expired and not pending */
 	if (remaining.tv64 <= 0)
 		cur_setting->it_value.tv_nsec = 1;

--

