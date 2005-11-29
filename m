Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVK2Bfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVK2Bfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVK2Bfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:35:32 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17342 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932324AbVK2Bey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:34:54 -0500
Date: Tue, 29 Nov 2005 02:34:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] handle lost timer ticks in ptimer
Message-ID: <Pine.LNX.4.61.0511290234490.2785@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changes how ptimer deals with lost timer ticks (as far as they can be
detected).  If ticks have been lost, the runqueue is run repeatedly until it
has catched up with the current time. As lost ticks is a rather uncommon event,
I think it's a lot better to deal with it at a single place.

This mean the ptimer users don't have to deal with this anymore and makes them
simpler, e.g. itimer doesn't doesn't has to loop anymore to update the expire
value and posix-timer avoids calling schedule_next_timer().

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 kernel/itimer.c       |    3 +--
 kernel/posix-timers.c |   12 +++++++++---
 kernel/ptimer.c       |   13 ++++++++++++-
 3 files changed, 22 insertions(+), 6 deletions(-)

Index: linux-2.6-mm/kernel/itimer.c
===================================================================
--- linux-2.6-mm.orig/kernel/itimer.c	2005-11-28 22:31:00.000000000 +0100
+++ linux-2.6-mm/kernel/itimer.c	2005-11-28 22:31:10.000000000 +0100
@@ -132,8 +132,7 @@ int it_real_fn(struct ptimer *timer)
 	 */
 	if (!inc)
 		return 0;
-	while (time_before_eq(sig->real_timer.expires, jiffies))
-		sig->real_timer.expires += inc;
+	sig->real_timer.expires += inc;
 	return 1;
 }
 
Index: linux-2.6-mm/kernel/posix-timers.c
===================================================================
--- linux-2.6-mm.orig/kernel/posix-timers.c	2005-11-28 22:31:08.000000000 +0100
+++ linux-2.6-mm/kernel/posix-timers.c	2005-11-28 22:31:10.000000000 +0100
@@ -500,9 +500,15 @@ static int posix_timer_fn(struct ptimer 
 	}
 
 	if (!timr->it_requeue_pending) {
-		if (!posix_timer_event(timr, 1))
-			timr->it_requeue_pending = 1;
-		do_restart = schedule_next_timer(timr);
+		timr->it_requeue_pending = 1;
+		if (unlikely(posix_timer_event(timr, 1))) {
+			timr->it_requeue_pending = 0;
+			timr->it_overrun++;
+		}
+		if (timr->it.real.incr) {
+			timr->it.real.timer.expires += timr->it.real.incr;
+			do_restart = 1;
+		}
 	} else {
 		timr->it_requeue_pending = 2;
 		timr->it_overrun++;
Index: linux-2.6-mm/kernel/ptimer.c
===================================================================
--- linux-2.6-mm.orig/kernel/ptimer.c	2005-11-28 22:31:00.000000000 +0100
+++ linux-2.6-mm/kernel/ptimer.c	2005-11-28 22:31:10.000000000 +0100
@@ -252,9 +252,20 @@ static inline void ptimer_run_queue(stru
 void ptimer_run_queues(void)
 {
 	struct ptimer_base *base;
+	unsigned long expired, now = jiffies;
 
 	base = __get_cpu_var(ptimer_bases);
-	base->last_expired = jiffies;
+
+	expired = base[CLOCK_MONOTONIC].last_expired + 1;
+	if (unlikely(expired != now)) {
+		if (time_after(expired, now))
+			return;
+		do {
+			base[CLOCK_MONOTONIC].last_expired = expired;
+			ptimer_run_queue(&base[CLOCK_MONOTONIC]);
+		} while (++expired != now);
+	}
+	base[CLOCK_MONOTONIC].last_expired = jiffies;
 	ptimer_run_queue(&base[CLOCK_MONOTONIC]);
 }
 
