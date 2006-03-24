Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWCXQQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWCXQQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWCXQQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:16:25 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:49833 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932448AbWCXQQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:16:24 -0500
Message-ID: <44241A9C.7B270680@tv-sign.ru>
Date: Fri, 24 Mar 2006 19:13:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 2.6.16-mm1 1/3] simplify do_signal_stop()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depends on
	do_signal_stop-dont-take-tasklist_lock.patch

do_signal_stop() considers 'thread_group_empty()' as a special case.
This was needed to avoid taking tasklist_lock. Since this lock is
unneeded any longer, we can remove this special case and simplify
the code even more.

Also, before this patch, finish_stop() was called with stop_count == -1
for 'thread_group_empty()' case. This is not strictly wrong, but confusing
and unneeded.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/signal.c~2_DOSS	2006-03-23 22:48:10.000000000 +0300
+++ MM/kernel/signal.c	2006-03-24 20:01:46.000000000 +0300
@@ -1685,8 +1685,7 @@ out:
 static int do_signal_stop(int signr)
 {
 	struct signal_struct *sig = current->signal;
-	struct sighand_struct *sighand = current->sighand;
-	int stop_count = -1;
+	int stop_count;
 
 	if (!likely(sig->flags & SIGNAL_STOP_DEQUEUED))
 		return 0;
@@ -1696,30 +1695,14 @@ static int do_signal_stop(int signr)
 		 * There is a group stop in progress.  We don't need to
 		 * start another one.
 		 */
-		signr = sig->group_exit_code;
 		stop_count = --sig->group_stop_count;
-		current->exit_code = signr;
-		set_current_state(TASK_STOPPED);
-		if (stop_count == 0)
-			sig->flags = SIGNAL_STOP_STOPPED;
-	}
-	else if (thread_group_empty(current)) {
-		/*
-		 * Lock must be held through transition to stopped state.
-		 */
-		current->exit_code = current->signal->group_exit_code = signr;
-		set_current_state(TASK_STOPPED);
-		sig->flags = SIGNAL_STOP_STOPPED;
-	}
-	else {
+	} else {
 		/*
-		 * (sig->group_stop_count == 0)
 		 * There is no group stop already in progress.
 		 * We must initiate one now.
 		 */
 		struct task_struct *t;
 
-		current->exit_code = signr;
 		sig->group_exit_code = signr;
 
 		stop_count = 0;
@@ -1735,13 +1718,14 @@ static int do_signal_stop(int signr)
 				signal_wake_up(t, 0);
 			}
 		sig->group_stop_count = stop_count;
-
-		set_current_state(TASK_STOPPED);
-		if (stop_count == 0)
-			sig->flags = SIGNAL_STOP_STOPPED;
 	}
 
-	spin_unlock_irq(&sighand->siglock);
+	if (stop_count == 0)
+		sig->flags = SIGNAL_STOP_STOPPED;
+	current->exit_code = sig->group_exit_code;
+	__set_current_state(TASK_STOPPED);
+
+	spin_unlock_irq(&current->sighand->siglock);
 	finish_stop(stop_count);
 	return 1;
 }
