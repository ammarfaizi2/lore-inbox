Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWG0Hza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWG0Hza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWG0Hza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:55:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38361 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750724AbWG0Hz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:55:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] Make suspend possible with a traced process at a breakpoint
Date: Thu, 27 Jul 2006 09:41:45 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200607270914.08774.rjw@sisk.pl>
In-Reply-To: <200607270914.08774.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270941.45876.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It should be possible to suspend, either to RAM or to disk, if there's a
traced process that has just reached a breakpoint.  However, this is a special
case, because its parent process might have been frozen already and then
we are unable to deliver the "freeze" signal to the traced process.  If this
happens, it's better to cancel the freezing of the traced process.

Ref. http://bugzilla.kernel.org/show_bug.cgi?id=6787

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/sched.h  |    8 ++++++++
 kernel/power/process.c |   26 ++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

Index: linux-2.6.18-rc2/kernel/power/process.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/process.c	2006-07-25 23:17:43.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/process.c	2006-07-26 07:49:42.000000000 +0200
@@ -66,13 +66,25 @@ static inline void freeze_process(struct
 	}
 }
 
+static void cancel_freezing(struct task_struct *p)
+{
+	unsigned long flags;
+
+	if (freezing(p)) {
+		pr_debug("  clean up: %s\n", p->comm);
+		do_not_freeze(p);
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		recalc_sigpending_tsk(p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	}
+}
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
 	int todo, nr_user, user_frozen;
 	unsigned long start_time;
 	struct task_struct *g, *p;
-	unsigned long flags;
 
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
@@ -85,6 +97,10 @@ int freeze_processes(void)
 				continue;
 			if (frozen(p))
 				continue;
+			if (p->state == TASK_TRACED && frozen(p->parent)) {
+				cancel_freezing(p);
+				continue;
+			}
 			if (p->mm && !(p->flags & PF_BORROWED_MM)) {
 				/* The task is a user-space one.
 				 * Freeze it unless there's a vfork completion
@@ -126,13 +142,7 @@ int freeze_processes(void)
 		do_each_thread(g, p) {
 			if (freezeable(p) && !frozen(p))
 				printk(KERN_ERR "  %s\n", p->comm);
-			if (freezing(p)) {
-				pr_debug("  clean up: %s\n", p->comm);
-				p->flags &= ~PF_FREEZE;
-				spin_lock_irqsave(&p->sighand->siglock, flags);
-				recalc_sigpending_tsk(p);
-				spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			}
+			cancel_freezing(p);
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		return todo;
Index: linux-2.6.18-rc2/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc2.orig/include/linux/sched.h	2006-07-25 23:17:42.000000000 +0200
+++ linux-2.6.18-rc2/include/linux/sched.h	2006-07-26 07:49:54.000000000 +0200
@@ -1558,6 +1558,14 @@ static inline void freeze(struct task_st
 }
 
 /*
+ * Sometimes we may need to cancel the previous 'freeze' request
+ */
+static inline void do_not_freeze(struct task_struct *p)
+{
+	p->flags &= ~PF_FREEZE;
+}
+
+/*
  * Wake up a frozen process
  */
 static inline int thaw_process(struct task_struct *p)

