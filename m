Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319246AbSIEWuz>; Thu, 5 Sep 2002 18:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319247AbSIEWuz>; Thu, 5 Sep 2002 18:50:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:668 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319246AbSIEWux>;
	Thu, 5 Sep 2002 18:50:53 -0400
Date: Fri, 6 Sep 2002 00:58:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
In-Reply-To: <20020905225038.GA14295@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209060058040.20904-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've attached a combined patch of your two patches, against BK-curr. Looks
good to me, and since it passed your more complex ptrace tests ...

	Ingo

--- linux/kernel/exit.c.orig	Fri Sep  6 00:55:02 2002
+++ linux/kernel/exit.c	Fri Sep  6 00:57:58 2002
@@ -66,6 +66,11 @@
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
+	if (unlikely(p->ptrace)) {
+		write_lock_irq(&tasklist_lock);
+		__ptrace_unlink(p);
+		write_unlock_irq(&tasklist_lock);
+	}
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	unhash_process(p);
 
@@ -427,7 +432,7 @@
 	 * There are only two places where our children can be:
 	 *
 	 * - in our child list
-	 * - in the global ptrace list
+	 * - in our ptraced child list
 	 *
 	 * Search them and reparent children.
 	 */
@@ -442,14 +447,22 @@
 	read_unlock(&tasklist_lock);
 }
 
-static inline void zap_thread(task_t *p, task_t *father)
+static inline void zap_thread(task_t *p, task_t *father, int traced)
 {
-	ptrace_unlink(p);
-	list_del_init(&p->sibling);
-	p->ptrace = 0;
+	/* If we were tracing the thread, release it; otherwise preserve the
+	   ptrace links.  */
+	if (unlikely(traced)) {
+		task_t *trace_task = p->parent;
+		__ptrace_unlink(p);
+		p->ptrace = 1;
+		__ptrace_link(p, trace_task);
+	} else {
+		p->ptrace = 0;
+		list_del_init(&p->sibling);
+		p->parent = p->real_parent;
+		list_add_tail(&p->sibling, &p->parent->children);
+	}
 
-	p->parent = p->real_parent;
-	list_add_tail(&p->sibling, &p->parent->children);
 	if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
 		do_notify_parent(p, p->exit_signal);
 	/*
@@ -540,11 +553,11 @@
 
 zap_again:
 	list_for_each_safe(_p, _n, &current->children)
-		zap_thread(list_entry(_p,struct task_struct,sibling), current);
+		zap_thread(list_entry(_p,struct task_struct,sibling), current, 0);
 	list_for_each_safe(_p, _n, &current->ptrace_children)
-		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current);
+		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current, 1);
 	/*
-	 * reparent_thread might drop the tasklist lock, thus we could
+	 * zap_thread might drop the tasklist lock, thus we could
 	 * have new children queued back from the ptrace list into the
 	 * child list:
 	 */
@@ -715,7 +728,7 @@
 				retval = p->pid;
 				if (p->real_parent != p->parent) {
 					write_lock_irq(&tasklist_lock);
-					ptrace_unlink(p);
+					__ptrace_unlink(p);
 					do_notify_parent(p, SIGCHLD);
 					write_unlock_irq(&tasklist_lock);
 				} else
--- linux/kernel/ptrace.c.orig	Fri Sep  6 00:58:13 2002
+++ linux/kernel/ptrace.c	Fri Sep  6 00:58:24 2002
@@ -29,7 +29,7 @@
 	if (!list_empty(&child->ptrace_list))
 		BUG();
 	if (child->parent == new_parent)
-		BUG();
+		return;
 	list_add(&child->ptrace_list, &child->parent->ptrace_children);
 	REMOVE_LINKS(child);
 	child->parent = new_parent;

