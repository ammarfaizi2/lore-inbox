Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWCYMpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWCYMpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWCYMpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:45:22 -0500
Received: from www.osadl.org ([213.239.205.134]:14301 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751154AbWCYMpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:45:18 -0500
Message-Id: <20060325121223.966390000@localhost.localdomain>
References: <20060325121219.172731000@localhost.localdomain>
Date: Sat, 25 Mar 2006 12:46:02 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 2/2] hrtimer
Content-Disposition: inline;
	filename=hrtimer-nanosleep-use-generic-sleeper.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replace the nanosleep private sleeper functionality by the generic
hrtimer sleeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>


 kernel/hrtimer.c |   34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

Index: linux-2.6.16/kernel/hrtimer.c
===================================================================
--- linux-2.6.16.orig/kernel/hrtimer.c
+++ linux-2.6.16/kernel/hrtimer.c
@@ -655,7 +655,6 @@ void hrtimer_run_queues(void)
 /*
  * Sleep related functions:
  */
-
 static int hrtimer_wakeup(struct hrtimer *timer)
 {
 	struct hrtimer_sleeper *t =
@@ -675,28 +674,9 @@ void hrtimer_init_sleeper(struct hrtimer
 	sl->task = task;
 }
 
-struct sleep_hrtimer {
-	struct hrtimer timer;
-	struct task_struct *task;
-	int expired;
-};
-
-static int nanosleep_wakeup(struct hrtimer *timer)
-{
-	struct sleep_hrtimer *t =
-		container_of(timer, struct sleep_hrtimer, timer);
-
-	t->expired = 1;
-	wake_up_process(t->task);
-
-	return HRTIMER_NORESTART;
-}
-
-static int __sched do_nanosleep(struct sleep_hrtimer *t, enum hrtimer_mode mode)
+static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode)
 {
-	t->timer.function = nanosleep_wakeup;
-	t->task = current;
-	t->expired = 0;
+	hrtimer_init_sleeper(t, current);
 
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -704,18 +684,18 @@ static int __sched do_nanosleep(struct s
 
 		schedule();
 
-		if (unlikely(!t->expired)) {
+		if (unlikely(t->task)) {
 			hrtimer_cancel(&t->timer);
 			mode = HRTIMER_ABS;
 		}
-	} while (!t->expired && !signal_pending(current));
+	} while (t->task && !signal_pending(current));
 
-	return t->expired;
+	return t->task == NULL;
 }
 
 static long __sched nanosleep_restart(struct restart_block *restart)
 {
-	struct sleep_hrtimer t;
+	struct hrtimer_sleeper t;
 	struct timespec __user *rmtp;
 	struct timespec tu;
 	ktime_t time;
@@ -748,7 +728,7 @@ long hrtimer_nanosleep(struct timespec *
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
-	struct sleep_hrtimer t;
+	struct hrtimer_sleeper t;
 	struct timespec tu;
 	ktime_t rem;
 

--

