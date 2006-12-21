Return-Path: <linux-kernel-owner+w=401wt.eu-S1422781AbWLUHLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWLUHLX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422790AbWLUHLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:11:23 -0500
Received: from www.osadl.org ([213.239.205.134]:49748 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422787AbWLUHLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:11:22 -0500
Subject: [patch] high-res timers: core, do itimer rearming in process
	context, fix2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061219211629.GA10586@elte.hu>
References: <20061219211629.GA10586@elte.hu>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 08:15:25 +0100
Message-Id: <1166685325.29505.593.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] high-res timers: core, do itimer rearming in process context, fix2
From: Thomas Gleixner <tglx@linutronix.de>

The rearming code in signal.c has to read the time and can not rely on
the timer->base->softirq time anymore, as it is not longer running in
softirq context.

Ensure, that the it_real_incr variable in the shared signal struct is
set to zero, when setitimer disables the itimer. Otherwise it could
happen that an inactive itimer gets rearmed by a SIGALRM.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.19-git19/kernel/signal.c
===================================================================
--- 2.6.19-git19.orig/kernel/signal.c
+++ 2.6.19-git19/kernel/signal.c
@@ -477,7 +477,7 @@ int dequeue_signal(struct task_struct *t
 
 			if (!hrtimer_is_queued(tmr) &&
 			    tsk->signal->it_real_incr.tv64 != 0) {
-				hrtimer_forward(tmr, hrtimer_cb_get_time(tmr),
+				hrtimer_forward(tmr, tmr->base->get_time(),
 						tsk->signal->it_real_incr);
 				hrtimer_restart(tmr);
 			}
Index: 2.6.19-git19/kernel/itimer.c
===================================================================
--- 2.6.19-git19.orig/kernel/itimer.c
+++ 2.6.19-git19/kernel/itimer.c
@@ -226,11 +226,14 @@ again:
 			spin_unlock_irq(&tsk->sighand->siglock);
 			goto again;
 		}
-		tsk->signal->it_real_incr =
-			timeval_to_ktime(value->it_interval);
 		expires = timeval_to_ktime(value->it_value);
-		if (expires.tv64 != 0)
+		if (expires.tv64 != 0) {
+			tsk->signal->it_real_incr =
+				timeval_to_ktime(value->it_interval);
 			hrtimer_start(timer, expires, HRTIMER_MODE_REL);
+		} else
+			tsk->signal->it_real_incr.tv64 = 0;
+
 		spin_unlock_irq(&tsk->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:


