Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161443AbWATCzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161443AbWATCzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWATCzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:13 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:37101
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161428AbWATCzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:11 -0500
Message-Id: <20060120021342.498532000@tglx.tec.linutronix.de>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
Date: Fri, 20 Jan 2006 02:55:47 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/7] [hrtimers] Fix oldvalue return in setitimer
Content-Disposition: inline;
	filename=0003-hrtimers-Fix-oldvalue-return-in-setitimer.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This resolves bugzilla bug#5617. The oldvalue of the
timer was read after the timer was cancelled, so the
remaining time was always zero.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

 kernel/itimer.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

3f59dd20898d805781b3eac7ed0807e7a0b30f2f
diff --git a/kernel/itimer.c b/kernel/itimer.c
index 6433d06..379be2f 100644
--- a/kernel/itimer.c
+++ b/kernel/itimer.c
@@ -155,16 +155,16 @@ int do_setitimer(int which, struct itime
 again:
 		spin_lock_irq(&tsk->sighand->siglock);
 		timer = &tsk->signal->real_timer;
-		/* We are sharing ->siglock with it_real_fn() */
-		if (hrtimer_try_to_cancel(timer) < 0) {
-			spin_unlock_irq(&tsk->sighand->siglock);
-			goto again;
-		}
 		if (ovalue) {
 			ovalue->it_value = itimer_get_remtime(timer);
 			ovalue->it_interval
 				= ktime_to_timeval(tsk->signal->it_real_incr);
 		}
+		/* We are sharing ->siglock with it_real_fn() */
+		if (hrtimer_try_to_cancel(timer) < 0) {
+			spin_unlock_irq(&tsk->sighand->siglock);
+			goto again;
+		}
 		tsk->signal->it_real_incr =
 			timeval_to_ktime(value->it_interval);
 		expires = timeval_to_ktime(value->it_value);
-- 
1.0.8

--

