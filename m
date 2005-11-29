Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVK2Beq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVK2Beq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVK2Be1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:34:27 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:16574 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932315AbVK2BeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:34:25 -0500
Date: Tue, 29 Nov 2005 02:34:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] posix timer requeue handling
Message-ID: <Pine.LNX.4.61.0511290234190.2776@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changes the requeue handling of normal posix timers, instead of a counter
it has now three states: 0 - the timer is idle or running normally, 1 - signal
is queued and callback is pending, 2 - callback is late and timer is stopped
and must be restarted.

This also means if signal callback is still pending, we start the timer but
keep the signal pending, so when the timer expires, it won't touch the signal
structure, which may be read by another cpu at this time to finally deliver the
signal.

This allows to keep the timer running and allows later to keep the common path
smaller (especially most of schedule_next_timer()).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 kernel/posix-timers.c |   50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

Index: linux-2.6-mm/kernel/posix-timers.c
===================================================================
--- linux-2.6-mm.orig/kernel/posix-timers.c	2005-11-28 22:31:00.000000000 +0100
+++ linux-2.6-mm/kernel/posix-timers.c	2005-11-28 22:31:03.000000000 +0100
@@ -373,7 +373,6 @@ static int schedule_next_timer(struct k_
 	}
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1;
-	++timr->it_requeue_pending;
 	return 1;
 }
 
@@ -394,18 +393,24 @@ void do_schedule_next_timer(struct sigin
 	unsigned long flags;
 
 	timr = lock_timer(info->si_tid, &flags);
+	if (!timr)
+		return;
 
-	if (!timr || timr->it_requeue_pending != info->si_sys_private)
-		goto exit;
-
-	if (timr->it_clock < 0)	/* CPU clock */
+	if (timr->it_clock < 0) {
+		/* CPU clock */
+		if (timr->it_requeue_pending != info->si_sys_private)
+			goto exit;
 		posix_cpu_timer_schedule(timr);
-	else if (schedule_next_timer(timr))
-		ptimer_start(&timr->it.real.timer);
+	} else {
+		BUG_ON(!timr->it_requeue_pending);
+		if (timr->it_requeue_pending > 1 &&
+		    schedule_next_timer(timr))
+			ptimer_start(&timr->it.real.timer);
+		timr->it_requeue_pending = 0;
+	}
 	info->si_overrun = timr->it_overrun_last;
 exit:
-	if (timr)
-		unlock_timer(timr, flags);
+	unlock_timer(timr, flags);
 }
 
 int posix_timer_event(struct k_itimer *timr,int si_private)
@@ -492,21 +497,16 @@ static int posix_timer_fn(struct ptimer 
 
 	}
 	if (do_notify)  {
-		int si_private=0;
-
-		if (timr->it.real.incr)
-			si_private = ++timr->it_requeue_pending;
-		else {
+		if (!timr->it.real.incr)
 			remove_from_abslist(timr);
-		}
-
-		if (posix_timer_event(timr, si_private))
-			/*
-			 * signal was not sent because of sig_ignor
-			 * we will not get a call back to restart it AND
-			 * it should be restarted.
-			 */
+		if (!timr->it_requeue_pending) {
+			if (!posix_timer_event(timr, 1))
+				timr->it_requeue_pending = 1;
 			do_restart = schedule_next_timer(timr);
+		} else {
+			timr->it_requeue_pending = 2;
+			timr->it_overrun++;
+		}
 	}
 	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
 
@@ -792,7 +792,7 @@ common_timer_get(struct k_itimer *timr, 
 	    posix_time_before(&timr->it.real.timer, &now))
 		timr->it.real.timer.expires = expires = 0;
 	if (expires) {
-		if (timr->it_requeue_pending & REQUEUE_PENDING ||
+		if (timr->it_requeue_pending > 1 ||
 		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
 			posix_bump_timer(timr, now);
 			expires = timr->it.real.timer.expires;
@@ -972,8 +972,8 @@ common_timer_set(struct k_itimer *timr, 
 
 	remove_from_abslist(timr);
 
-	timr->it_requeue_pending = (timr->it_requeue_pending + 2) & 
-		~REQUEUE_PENDING;
+	if (timr->it_requeue_pending)
+		timr->it_requeue_pending = 1;
 	timr->it_overrun_last = 0;
 	timr->it_overrun = -1;
 	/*
