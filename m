Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVK2Bew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVK2Bew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVK2Beq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:34:46 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17086 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932324AbVK2Beo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:34:44 -0500
Date: Tue, 29 Nov 2005 02:34:44 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] remove relative timer from abs_list
Message-ID: <Pine.LNX.4.61.0511290234370.2782@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When an absolute timer expires, it becomes a relative timer, so remove it from
the abs_list.  The TIMER_ABSTIME flag for timer_settime() changes the
interpretation of the it_value member, but it_interval is always a relative
value and clock_settime() only affects absolute time services.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 kernel/posix-timers.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

Index: linux-2.6-mm/kernel/posix-timers.c
===================================================================
--- linux-2.6-mm.orig/kernel/posix-timers.c	2005-11-28 22:31:06.000000000 +0100
+++ linux-2.6-mm/kernel/posix-timers.c	2005-11-28 22:31:08.000000000 +0100
@@ -466,7 +466,7 @@ static int posix_timer_fn(struct ptimer 
 	unsigned long seq;
 	struct timespec delta, new_wall_to;
 	u64 exp = 0;
-	int do_notify = 1, do_restart = 0;
+	int do_restart = 0;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
 	if (!list_empty(&timr->it.real.abs_timer_entry)) {
@@ -491,24 +491,23 @@ static int posix_timer_fn(struct ptimer 
 				   &exp);
 			timr->it.real.wall_to_prev = new_wall_to;
 			timr->it.real.timer.expires += exp;
-			do_notify = 0;
+			spin_unlock(&abs_list.lock);
 			do_restart = 1;
+			goto exit;
 		}
+		list_del_init(&timr->it.real.abs_timer_entry);
 		spin_unlock(&abs_list.lock);
-
 	}
-	if (do_notify)  {
-		if (!timr->it.real.incr)
-			remove_from_abslist(timr);
-		if (!timr->it_requeue_pending) {
-			if (!posix_timer_event(timr, 1))
-				timr->it_requeue_pending = 1;
-			do_restart = schedule_next_timer(timr);
-		} else {
-			timr->it_requeue_pending = 2;
-			timr->it_overrun++;
-		}
+
+	if (!timr->it_requeue_pending) {
+		if (!posix_timer_event(timr, 1))
+			timr->it_requeue_pending = 1;
+		do_restart = schedule_next_timer(timr);
+	} else {
+		timr->it_requeue_pending = 2;
+		timr->it_overrun++;
 	}
+exit:
 	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
 
 	return do_restart;
