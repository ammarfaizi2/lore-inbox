Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVJXFBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVJXFBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 01:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVJXFBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 01:01:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9097 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751003AbVJXFBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 01:01:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH] posix-cpu-timers: fix overrun reporting
X-Shopping-List: (1) Magnificent vagrants
   (2) Catholic Toothpick rebellions
   (3) Sardonic fruit yarns
Message-Id: <20051024050115.117EC1809AD@magilla.sf.frob.com>
Date: Sun, 23 Oct 2005 22:01:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change corrects an omission in posix_cpu_timer_schedule, so that it
correctly propagates the overrun calculation to where it will get reported
to the user.

Signed-off-by: Roland McGrath <roland@redhat.com>

---

 kernel/posix-cpu-timers.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

4da6a042f1fe3a10265f4cb444c464c16644f814
diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -1223,7 +1223,7 @@ void posix_cpu_timer_schedule(struct k_i
 		/*
 		 * The task was cleaned up already, no future firings.
 		 */
-		return;
+		goto out;
 
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
@@ -1233,7 +1233,7 @@ void posix_cpu_timer_schedule(struct k_i
 		bump_cpu_timer(timer, now);
 		if (unlikely(p->exit_state)) {
 			clear_dead_task(timer, now);
-			return;
+			goto out;
 		}
 		read_lock(&tasklist_lock); /* arm_timer needs it.  */
 	} else {
@@ -1246,8 +1246,7 @@ void posix_cpu_timer_schedule(struct k_i
 			put_task_struct(p);
 			timer->it.cpu.task = p = NULL;
 			timer->it.cpu.expires.sched = 0;
-			read_unlock(&tasklist_lock);
-			return;
+			goto out_unlock;
 		} else if (unlikely(p->exit_state) && thread_group_empty(p)) {
 			/*
 			 * We've noticed that the thread is dead, but
@@ -1255,8 +1254,7 @@ void posix_cpu_timer_schedule(struct k_i
 			 * drop our task ref.
 			 */
 			clear_dead_task(timer, now);
-			read_unlock(&tasklist_lock);
-			return;
+			goto out_unlock;
 		}
 		cpu_clock_sample_group(timer->it_clock, p, &now);
 		bump_cpu_timer(timer, now);
@@ -1268,7 +1266,13 @@ void posix_cpu_timer_schedule(struct k_i
 	 */
 	arm_timer(timer, now);
 
+out_unlock:
 	read_unlock(&tasklist_lock);
+
+out:
+	timer->it_overrun_last = timer->it_overrun;
+	timer->it_overrun = -1;
+	++timer->it_requeue_pending;
 }
 
 /*
