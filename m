Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319215AbSIFPsf>; Fri, 6 Sep 2002 11:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319223AbSIFPsf>; Fri, 6 Sep 2002 11:48:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23441 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319215AbSIFPs3>;
	Fri, 6 Sep 2002 11:48:29 -0400
Date: Fri, 6 Sep 2002 17:57:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
In-Reply-To: <20020906154508.GA20709@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209061753070.27292-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Sep 2002, Daniel Jacobowitz wrote:

> Because it's also needed for non-CLONE_DETACH processes.  I added it
> earlier down by the release_task, remember?  I deleted it in this patch
> originally, and the change got lost somewhere; my intent is to check for
> this only in release_task and nowhere else.  When I have a clear point
> to resync with Linus again then I'll make sure this is right.

Linus' tree is at http://linux.bkbits.net/linux-2.5/, and i've done the
attached patch to collect & clean up all the things that happened since
yesterday. It's basically what was your tree this morning - i'd suggest
for you to base subsequent patches on BK-curr + this patch. (To reduce
confusion i wont send any new patches for this area from now on.)

	Ingo

diff -rNu linux.orig/kernel/exit.c linux/kernel/exit.c
--- linux.orig/kernel/exit.c	Fri Sep  6 11:37:53 2002
+++ linux/kernel/exit.c	Fri Sep  6 11:39:47 2002
@@ -66,8 +66,12 @@
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
-	BUG_ON(p->ptrace || !list_empty(&p->ptrace_list) ||
-					!list_empty(&p->ptrace_children));
+	if (unlikely(p->ptrace)) {
+		write_lock_irq(&tasklist_lock);
+		__ptrace_unlink(p);
+		write_unlock_irq(&tasklist_lock);
+	}
+	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	unhash_process(p);
 
 	release_thread(p);
@@ -428,7 +432,7 @@
 	 * There are only two places where our children can be:
 	 *
 	 * - in our child list
-	 * - in the global ptrace list
+	 * - in our ptraced child list
 	 *
 	 * Search them and reparent children.
 	 */
@@ -443,14 +447,22 @@
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
@@ -541,11 +553,11 @@
 
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
@@ -716,17 +728,11 @@
 				retval = p->pid;
 				if (p->real_parent != p->parent) {
 					write_lock_irq(&tasklist_lock);
-					ptrace_unlink(p);
+					__ptrace_unlink(p);
 					do_notify_parent(p, SIGCHLD);
 					write_unlock_irq(&tasklist_lock);
-				} else {
-					if (p->ptrace) {
-						write_lock_irq(&tasklist_lock);
-						ptrace_unlink(p);
-						write_unlock_irq(&tasklist_lock);
-					}
+				} else
 					release_task(p);
-				}
 				goto end_wait4;
 			default:
 				continue;


