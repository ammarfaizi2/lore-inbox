Return-Path: <linux-kernel-owner+w=401wt.eu-S1762605AbWLJVGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762605AbWLJVGf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762607AbWLJVGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:06:35 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:43300 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762605AbWLJVGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:06:34 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] PM: Fix freezing of stopped tasks
Date: Sun, 10 Dec 2006 22:08:48 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612102208.48903.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if a task is stopped (ie. it's in the TASK_STOPPED state), it is
considered by the freezer as unfreezeable.  However, there may be a race
between the freezer and the delivery of the continuation signal to the task
resulting in the task running after we have finished freezing the other tasks.
This, in turn, may lead to undesirable effects up to and including data
corruption.

To prevent this from happening we first need to make the freezer consider
stopped tasks as freezeable.  For this purpose we need to make freezeable()
stop returning 0 for these tasks and we need to force them to enter the
refrigerator.  However, if there's no continuation signal in the meantime, the
stopped tasks should remain stopped after all processes have been thawed,
so we need to send an additional SIGSTOP to each of them before waking
it up.

Also, a stopped task that has just been woken up should first check if there's
a freezing request for it and go to the refrigerator if that's the case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/process.c |   12 ++++++------
 kernel/signal.c        |    4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6.19-rc6-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/power/process.c	2006-12-08 21:15:18.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/power/process.c	2006-12-08 21:47:23.000000000 +0100
@@ -28,8 +28,7 @@ static inline int freezeable(struct task
 	if ((p == current) || 
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
-	    (p->exit_state == EXIT_DEAD) ||
-	    (p->state == TASK_STOPPED))
+	    (p->exit_state == EXIT_DEAD))
 		return 0;
 	return 1;
 }
@@ -61,9 +60,12 @@ static inline void freeze_process(struct
 	unsigned long flags;
 
 	if (!freezing(p)) {
+		if (p->state == TASK_STOPPED)
+			force_sig_specific(SIGSTOP, p);
+
 		freeze(p);
 		spin_lock_irqsave(&p->sighand->siglock, flags);
-		signal_wake_up(p, 0);
+		signal_wake_up(p, p->state == TASK_STOPPED);
 		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	}
 }
@@ -103,9 +105,7 @@ static unsigned int try_to_freeze_tasks(
 			if (frozen(p))
 				continue;
 
-			if (p->state == TASK_TRACED &&
-			    (frozen(p->parent) ||
-			     p->parent->state == TASK_STOPPED)) {
+			if (p->state == TASK_TRACED && frozen(p->parent)) {
 				cancel_freezing(p);
 				continue;
 			}
Index: linux-2.6.19-rc6-mm2/kernel/signal.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/signal.c	2006-12-08 21:15:18.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/signal.c	2006-12-08 21:15:30.000000000 +0100
@@ -1829,7 +1829,9 @@ finish_stop(int stop_count)
 		read_unlock(&tasklist_lock);
 	}
 
-	schedule();
+	do {
+		schedule();
+	} while (try_to_freeze());
 	/*
 	 * Now we don't run again until continued.
 	 */
