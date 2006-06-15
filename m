Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWFOMLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWFOMLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWFOMLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:11:15 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:22744 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030289AbWFOMLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:11:13 -0400
Date: Thu, 15 Jun 2006 20:11:15 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] check_process_timers: fix possible lockup
Message-ID: <20060615161115.GA21455@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the local timer interrupt happens just after do_exit() sets PF_EXITING
(and before it clears ->it_xxx_expires) run_posix_cpu_timers() will call
check_process_timers() with tasklist_lock + ->siglock held and

	check_process_timers:

		t = tsk;
		do {
			....

			do {
				t = next_thread(t);
			} while (unlikely(t->flags & PF_EXITING));
		} while (t != tsk);

the outer loop will never stop.

Actually, the window is bigger. Another process can attach the timer after
->it_xxx_expires was cleared (see the patch 2/3) and the 'if (PF_EXITING)'
check in arm_timer() is racy (see the patch 3/3).

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.17-rc6/kernel/posix-cpu-timers.c~1_CPT	2006-06-15 17:59:15.000000000 +0400
+++ 2.6.17-rc6/kernel/posix-cpu-timers.c	2006-06-15 18:01:57.000000000 +0400
@@ -1173,6 +1173,9 @@ static void check_process_timers(struct 
 		}
 		t = tsk;
 		do {
+			if (unlikely(t->flags & PF_EXITING))
+				continue;
+
 			ticks = cputime_add(cputime_add(t->utime, t->stime),
 					    prof_left);
 			if (!cputime_eq(prof_expires, cputime_zero) &&
@@ -1193,11 +1196,7 @@ static void check_process_timers(struct 
 					      t->it_sched_expires > sched)) {
 				t->it_sched_expires = sched;
 			}
-
-			do {
-				t = next_thread(t);
-			} while (unlikely(t->flags & PF_EXITING));
-		} while (t != tsk);
+		} while ((t = next_thread(t)) != tsk);
 	}
 }
 

