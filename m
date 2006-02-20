Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbWBTOqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWBTOqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWBTOqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:46:52 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:58066 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932621AbWBTOqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:46:51 -0500
Message-ID: <43F9E873.808CD086@tv-sign.ru>
Date: Mon, 20 Feb 2006 19:04:03 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 3/4] cleanup __exit_signal()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch factors out duplicated code under 'if' branches.
Also, BUG_ON() conversions and whitespace cleanups.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/signal.c~3_ESIG	2006-02-20 02:02:03.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-20 20:55:50.000000000 +0300
@@ -341,24 +341,20 @@ void __exit_sighand(struct task_struct *
  */
 void __exit_signal(struct task_struct *tsk)
 {
-	struct signal_struct * sig = tsk->signal;
-	struct sighand_struct * sighand;
+	struct signal_struct *sig = tsk->signal;
+	struct sighand_struct *sighand;
+
+	BUG_ON(!sig);
+	BUG_ON(!atomic_read(&sig->count));
 
-	if (!sig)
-		BUG();
-	if (!atomic_read(&sig->count))
-		BUG();
 	rcu_read_lock();
 	sighand = rcu_dereference(tsk->sighand);
 	spin_lock(&sighand->siglock);
+
 	posix_cpu_timers_exit(tsk);
-	if (atomic_dec_and_test(&sig->count)) {
+	if (atomic_dec_and_test(&sig->count))
 		posix_cpu_timers_exit_group(tsk);
-		tsk->signal = NULL;
-		__exit_sighand(tsk);
-		spin_unlock(&sighand->siglock);
-		flush_sigqueue(&sig->shared_pending);
-	} else {
+	else {
 		/*
 		 * If there is any task waiting for the group exit
 		 * then notify it:
@@ -369,7 +365,6 @@ void __exit_signal(struct task_struct *t
 		}
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
-		tsk->signal = NULL;
 		/*
 		 * Accumulate here the counters for all threads but the
 		 * group leader as they die, so they can be added into
@@ -387,14 +382,18 @@ void __exit_signal(struct task_struct *t
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
 		sig->sched_time += tsk->sched_time;
-		__exit_sighand(tsk);
-		spin_unlock(&sighand->siglock);
-		sig = NULL;	/* Marker for below.  */
+		sig = NULL; /* Marker for below. */
 	}
+
+	tsk->signal = NULL;
+	__exit_sighand(tsk);
+	spin_unlock(&sighand->siglock);
 	rcu_read_unlock();
+
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
 	if (sig) {
+		flush_sigqueue(&sig->shared_pending);
 		__cleanup_signal(sig);
 	}
 }
