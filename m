Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVK2Bev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVK2Bev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVK2Ber
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:34:47 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:16830 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932315AbVK2Bee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:34:34 -0500
Date: Tue, 29 Nov 2005 02:34:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] posix timer overrun handling
Message-ID: <Pine.LNX.4.61.0511290234280.2779@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This slightly changes the overrun handling. Instead of initially initializing
setting the overrun count to -1 it's set to 0 now and the extra overrun is
removed at timer restart time.

This has the two advantages, that the return value of timer_getoverrun()
doesn't overlap with the error values and si_overrun and it_overrun_last are
changed at the same time (and could be merged later).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 kernel/posix-timers.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-2.6-mm/kernel/posix-timers.c
===================================================================
--- linux-2.6-mm.orig/kernel/posix-timers.c	2005-11-28 22:31:03.000000000 +0100
+++ linux-2.6-mm/kernel/posix-timers.c	2005-11-28 22:31:06.000000000 +0100
@@ -371,8 +371,7 @@ static int schedule_next_timer(struct k_
 	} else {
 		posix_bump_timer(timr, now);
 	}
-	timr->it_overrun_last = timr->it_overrun;
-	timr->it_overrun = -1;
+	timr->it_overrun--;
 	return 1;
 }
 
@@ -401,14 +400,16 @@ void do_schedule_next_timer(struct sigin
 		if (timr->it_requeue_pending != info->si_sys_private)
 			goto exit;
 		posix_cpu_timer_schedule(timr);
+		info->si_overrun = timr->it_overrun_last;
 	} else {
 		BUG_ON(!timr->it_requeue_pending);
 		if (timr->it_requeue_pending > 1 &&
 		    schedule_next_timer(timr))
 			ptimer_start(&timr->it.real.timer);
 		timr->it_requeue_pending = 0;
+		info->si_overrun = timr->it_overrun_last = timr->it_overrun;
+		timr->it_overrun = 0;
 	}
-	info->si_overrun = timr->it_overrun_last;
 exit:
 	unlock_timer(timr, flags);
 }
@@ -621,7 +622,6 @@ sys_timer_create(clockid_t which_clock,
 	it_id_set = IT_ID_SET;
 	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
-	new_timer->it_overrun = -1;
 	error = CLOCK_DISPATCH(which_clock, timer_create, (new_timer));
 	if (error)
 		goto out;
@@ -974,8 +974,7 @@ common_timer_set(struct k_itimer *timr, 
 
 	if (timr->it_requeue_pending)
 		timr->it_requeue_pending = 1;
-	timr->it_overrun_last = 0;
-	timr->it_overrun = -1;
+	timr->it_overrun = 0;
 	/*
 	 *switch off the timer when it_value is zero
 	 */
