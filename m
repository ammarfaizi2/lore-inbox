Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161477AbWATC4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161477AbWATC4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161469AbWATCzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:38637
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161438AbWATCzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:12 -0500
Message-Id: <20060120021342.813743000@tglx.tec.linutronix.de>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
Date: Fri, 20 Jan 2006 02:55:49 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/7] [hrtimers] Fix posix-timer requeue race
Content-Disposition: inline;
	filename=0004-hrtimers-Fix-posix-timer-requeue-race.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedtrostedt@goodmis.org <rostedt@goodmis.org>
Date: 1137711149 +0100

CPU0 expires a posix-timer and runs the callback function.
The signal is queued.
After releasing the posix-timer lock and before returning to
hrtimer_run_queue CPU0 gets interrupted.
CPU1 delivers the queued signal and rearms the timer.
CPU0 comes back to hrtimer_run_queue and sets the timer state to expired.
The next modification of the timer can result in an oops, because the state
information is wrong.

Keep track of state = RUNNING and check if the state has been in the return
path of hrtimer_run_queue. In case the state has been changed, ignore a
restart request and do not touch the state variable.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

 include/linux/hrtimer.h |    1 +
 kernel/hrtimer.c        |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

7a42511f275d3c895be54f4e578921fc35e25dd2
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 089bfb1..c657f3d 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -40,6 +40,7 @@ enum hrtimer_restart {
 enum hrtimer_state {
 	HRTIMER_INACTIVE,	/* Timer is inactive */
 	HRTIMER_EXPIRED,		/* Timer is expired */
+	HRTIMER_RUNNING,		/* Timer is running the callback function */
 	HRTIMER_PENDING,		/* Timer is pending */
 };
 
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index f1c4155..f580dd9 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -550,6 +550,7 @@ static inline void run_hrtimer_queue(str
 		fn = timer->function;
 		data = timer->data;
 		set_curr_timer(base, timer);
+		timer->state = HRTIMER_RUNNING;
 		__remove_hrtimer(timer, base);
 		spin_unlock_irq(&base->lock);
 
@@ -565,6 +566,10 @@ static inline void run_hrtimer_queue(str
 
 		spin_lock_irq(&base->lock);
 
+		/* Another CPU has added back the timer */
+		if (timer->state != HRTIMER_RUNNING)
+			continue;
+
 		if (restart == HRTIMER_RESTART)
 			enqueue_hrtimer(timer, base);
 		else
-- 
1.0.8

--

