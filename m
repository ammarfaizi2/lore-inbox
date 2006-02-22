Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWBVXH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWBVXH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWBVXH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:07:56 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:43240 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751524AbWBVXHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:07:54 -0500
Message-ID: <43FCEE17.FC2814B6@tv-sign.ru>
Date: Thu, 23 Feb 2006 02:04:56 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: [PATCH 3/6] do_signal_stop: don't take tasklist_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_signal_stop() does not need tasklist_lock anymore.
So it does not need to do misc re-checks, and we can
simplify the code.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/signal.c~3_DOSS	2006-02-23 01:22:45.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-23 01:46:17.000000000 +0300
@@ -1685,8 +1685,7 @@ out:
  * Returns nonzero if we've actually stopped and released the siglock.
  * Returns zero if we didn't stop and still hold the siglock.
  */
-static int
-do_signal_stop(int signr)
+static int do_signal_stop(int signr)
 {
 	struct signal_struct *sig = current->signal;
 	struct sighand_struct *sighand = current->sighand;
@@ -1706,7 +1705,6 @@ do_signal_stop(int signr)
 		set_current_state(TASK_STOPPED);
 		if (stop_count == 0)
 			sig->flags = SIGNAL_STOP_STOPPED;
-		spin_unlock_irq(&sighand->siglock);
 	}
 	else if (thread_group_empty(current)) {
 		/*
@@ -1715,71 +1713,38 @@ do_signal_stop(int signr)
 		current->exit_code = current->signal->group_exit_code = signr;
 		set_current_state(TASK_STOPPED);
 		sig->flags = SIGNAL_STOP_STOPPED;
-		spin_unlock_irq(&sighand->siglock);
 	}
 	else {
 		/*
+		 * (sig->group_stop_count == 0)
 		 * There is no group stop already in progress.
-		 * We must initiate one now, but that requires
-		 * dropping siglock to get both the tasklist lock
-		 * and siglock again in the proper order.  Note that
-		 * this allows an intervening SIGCONT to be posted.
-		 * We need to check for that and bail out if necessary.
+		 * We must initiate one now.
 		 */
 		struct task_struct *t;
 
-		spin_unlock_irq(&sighand->siglock);
-
-		/* signals can be posted during this window */
-
-		read_lock(&tasklist_lock);
-		spin_lock_irq(&sighand->siglock);
+		current->exit_code = signr;
+		sig->group_exit_code = signr;
 
-		if (!likely(sig->flags & SIGNAL_STOP_DEQUEUED)) {
+		stop_count = 0;
+		for (t = next_thread(current); t != current; t = next_thread(t))
 			/*
-			 * Another stop or continue happened while we
-			 * didn't have the lock.  We can just swallow this
-			 * signal now.  If we raced with a SIGCONT, that
-			 * should have just cleared it now.  If we raced
-			 * with another processor delivering a stop signal,
-			 * then the SIGCONT that wakes us up should clear it.
+			 * Setting state to TASK_STOPPED for a group
+			 * stop is always done with the siglock held,
+			 * so this check has no races.
 			 */
-			read_unlock(&tasklist_lock);
-			return 0;
-		}
-
-		if (sig->group_stop_count == 0) {
-			sig->group_exit_code = signr;
-			stop_count = 0;
-			for (t = next_thread(current); t != current;
-			     t = next_thread(t))
-				/*
-				 * Setting state to TASK_STOPPED for a group
-				 * stop is always done with the siglock held,
-				 * so this check has no races.
-				 */
-				if (!t->exit_state &&
-				    !(t->state & (TASK_STOPPED|TASK_TRACED))) {
-					stop_count++;
-					signal_wake_up(t, 0);
-				}
-			sig->group_stop_count = stop_count;
-		}
-		else {
-			/* A race with another thread while unlocked.  */
-			signr = sig->group_exit_code;
-			stop_count = --sig->group_stop_count;
-		}
+			if (!t->exit_state &&
+			    !(t->state & (TASK_STOPPED|TASK_TRACED))) {
+				stop_count++;
+				signal_wake_up(t, 0);
+			}
+		sig->group_stop_count = stop_count;
 
-		current->exit_code = signr;
 		set_current_state(TASK_STOPPED);
 		if (stop_count == 0)
 			sig->flags = SIGNAL_STOP_STOPPED;
-
-		spin_unlock_irq(&sighand->siglock);
-		read_unlock(&tasklist_lock);
 	}
 
+	spin_unlock_irq(&sighand->siglock);
 	finish_stop(stop_count);
 	return 1;
 }
