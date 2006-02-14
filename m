Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWBNKCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWBNKCO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWBNKCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:02:14 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:19085 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030217AbWBNKCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:02:12 -0500
Date: Tue, 14 Feb 2006 05:01:50 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, George Anzinger <george@wildturkeyranch.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -rt] speed up nanosleep on early expire
Message-ID: <Pine.LNX.4.58.0602140450290.1843@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a revisit of the problem of nanosleep waking up the softirq to wake
itself up when the timer has already expired.  As mentioned in my last
patch, this causes large latencies to nanosleep.  But the last patch was
sloppy and introduced too much ugly code.

I should have noticed this the first time, but here's a much cleaner
patch.  As the hrtimer_interrupt checks the data field to determine to
wake the process up directly or to wake up the softirq, I noticed that the
nanosleep doesn't even need the softirq.  So instead of waking up the
softirq in enqueue_hrtimer, I do the same work as the hrtimer_interrupt
does, and that is to wake up the process directly if there is no function
associated with the timer.

I also saved a few microseconds by checking in schedule_hrtimer if current
is already running don't call schedule.

This patch is much cleaner than the last patch, and gives pretty much the
same result.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.15-rt16/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rt16.orig/kernel/hrtimer.c	2006-02-10 09:53:53.000000000 -0500
+++ linux-2.6.15-rt16/kernel/hrtimer.c	2006-02-14 04:30:43.000000000 -0500
@@ -578,9 +578,18 @@
 		 * and schedule the softirq.
 		 */
 		if (hrtimer_hres_active && hrtimer_reprogram(timer, base)) {
-			list_add_tail(&timer->list, &base->expired);
-			timer->state = HRTIMER_PENDING_CALLBACK;
-			raise_softirq(HRTIMER_SOFTIRQ);
+			/*
+			 * Only wake up the hrtimer softirq if it is needed,
+			 * otherwise wake up the process waiting for this timer.
+			 */
+			if (!timer->function) {
+				wake_up_process(timer->data);
+				timer->state = HRTIMER_EXPIRED;
+			} else {
+				list_add_tail(&timer->list, &base->expired);
+				timer->state = HRTIMER_PENDING_CALLBACK;
+				raise_softirq(HRTIMER_SOFTIRQ);
+			}
 			return;
 		}
 #endif
@@ -1029,7 +1038,13 @@

 	hrtimer_start(timer, timer->expires, mode);

-	schedule();
+	/*
+	 * the timer could have arleady expired, in which
+	 * case current would be running. Don't bother calling
+	 * schedule.
+	 */
+	if (likely(current->state))
+		schedule();
 	hrtimer_cancel(timer);

 	/* Return the remaining time: */
