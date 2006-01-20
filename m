Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161408AbWATCzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161408AbWATCzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbWATCzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:10 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34285
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161408AbWATCzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:09 -0500
Message-Id: <20060120021341.668183000@tglx.tec.linutronix.de>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
Date: Fri, 20 Jan 2006 02:55:45 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/7] [hrtimers] Fixup itimer conversion
Content-Disposition: inline; filename=0001-hrtimers-Fixup-itimer-conversion.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The itimer conversion removed the locking which protects
the timer and variables in the shared signal structure.
Steven Rostedt found the problem in the latest -rt patches.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

 kernel/itimer.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

52ae41e3d11d6f1828c5827861b7b83b7e854222
diff --git a/kernel/itimer.c b/kernel/itimer.c
index c2c05c4..6433d06 100644
--- a/kernel/itimer.c
+++ b/kernel/itimer.c
@@ -49,9 +49,11 @@ int do_getitimer(int which, struct itime
 
 	switch (which) {
 	case ITIMER_REAL:
+		spin_lock_irq(&tsk->sighand->siglock);
 		value->it_value = itimer_get_remtime(&tsk->signal->real_timer);
 		value->it_interval =
 			ktime_to_timeval(tsk->signal->it_real_incr);
+		spin_unlock_irq(&tsk->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:
 		read_lock(&tasklist_lock);
@@ -150,8 +152,14 @@ int do_setitimer(int which, struct itime
 
 	switch (which) {
 	case ITIMER_REAL:
+again:
+		spin_lock_irq(&tsk->sighand->siglock);
 		timer = &tsk->signal->real_timer;
-		hrtimer_cancel(timer);
+		/* We are sharing ->siglock with it_real_fn() */
+		if (hrtimer_try_to_cancel(timer) < 0) {
+			spin_unlock_irq(&tsk->sighand->siglock);
+			goto again;
+		}
 		if (ovalue) {
 			ovalue->it_value = itimer_get_remtime(timer);
 			ovalue->it_interval
@@ -162,6 +170,7 @@ int do_setitimer(int which, struct itime
 		expires = timeval_to_ktime(value->it_value);
 		if (expires.tv64 != 0)
 			hrtimer_start(timer, expires, HRTIMER_REL);
+		spin_unlock_irq(&tsk->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:
 		nval = timeval_to_cputime(&value->it_value);
-- 
1.0.8

--

