Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUGAVeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUGAVeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUGAVeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:34:12 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:28356 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S266292AbUGAVdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:33:55 -0400
Date: Thu, 1 Jul 2004 14:33:49 -0700
Message-Id: <200407012133.i61LXnPm022451@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: Andrea Arcangeli's message of  Thursday, 1 July 2004 16:26:33 +0200 <20040701142633.GE15086@dualathlon.random>
Emacs: if SIGINT doesn't work, try a tranquilizer.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the full version of my patch, in case you care.  It has the same
effect as Andrea's variant.  But I think this one doesn't introduce any new
tests into the hot code path, which that one does.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>


--- linux-2.6.7-mm4/kernel/exit.c.~1~	2004-06-30 16:29:06.000000000 -0700
+++ linux-2.6.7-mm4/kernel/exit.c	2004-07-01 14:23:36.000000000 -0700
@@ -537,7 +537,8 @@ static inline void choose_new_parent(tas
 		BUG();
 }
 
-static inline void reparent_thread(task_t *p, task_t *father, int traced)
+static inline void reparent_thread(task_t *p, task_t *father, int traced,
+				   struct list_head *to_release)
 {
 	/* We don't want people slaying init.  */
 	if (p->exit_signal != -1)
@@ -566,9 +567,12 @@ static inline void reparent_thread(task_
 		/* If we'd notified the old parent about this child's death,
 		 * also notify the new parent.
 		 */
-		if (p->state == TASK_ZOMBIE && p->exit_signal != -1 &&
-		    thread_group_empty(p))
-			do_notify_parent(p, p->exit_signal);
+		if (p->state == TASK_ZOMBIE) {
+			if (p->exit_signal == -1)
+				list_add(&p->ptrace_list, to_release);
+			else if (thread_group_empty(p))
+				do_notify_parent(p, p->exit_signal);
+		}
 	}
 
 	/*
@@ -594,7 +598,8 @@ static inline void reparent_thread(task_
  * group, and if no such member exists, give it to
  * the global child reaper process (ie "init")
  */
-static inline void forget_original_parent(struct task_struct * father)
+static inline void forget_original_parent(struct task_struct * father,
+					  struct list_head *to_release)
 {
 	struct task_struct *p, *reaper = father;
 	struct list_head *_p, *_n;
@@ -615,18 +620,29 @@ static inline void forget_original_paren
 		p = list_entry(_p,struct task_struct,sibling);
 		if (father == p->real_parent) {
 			choose_new_parent(p, reaper, child_reaper);
-			reparent_thread(p, father, 0);
+			reparent_thread(p, father, 0, to_release);
 		} else {
-			ptrace_unlink (p);
-			if (p->state == TASK_ZOMBIE && p->exit_signal != -1 &&
-			    thread_group_empty(p))
-				do_notify_parent(p, p->exit_signal);
+			BUG_ON(!p->ptrace);
+			__ptrace_unlink (p);
+			if (p->state == TASK_ZOMBIE) {
+				if (p->exit_signal == -1) {
+					/*
+					 * This was only a zombie because
+					 * we were tracing it.  Now it should
+					 * disappear as it would have done
+					 * if we hadn't been tracing it.
+					 */
+					list_add(&p->ptrace_list, to_release);
+				}
+				else if (thread_group_empty(p))
+					do_notify_parent(p, p->exit_signal);
+			}
 		}
 	}
 	list_for_each_safe(_p, _n, &father->ptrace_children) {
 		p = list_entry(_p,struct task_struct,ptrace_list);
 		choose_new_parent(p, reaper, child_reaper);
-		reparent_thread(p, father, 1);
+		reparent_thread(p, father, 1, to_release);
 	}
 }
 
@@ -638,6 +654,7 @@ static void exit_notify(struct task_stru
 {
 	int state;
 	struct task_struct *t;
+	struct list_head ptrace_dead, *_p, *_n;
 
 	if (signal_pending(tsk) && !tsk->signal->group_exit
 	    && !thread_group_empty(tsk)) {
@@ -673,7 +690,8 @@ static void exit_notify(struct task_stru
 	 *	jobs, send them a SIGHUP and then a SIGCONT.  (POSIX 3.2.2.2)
 	 */
 
-	forget_original_parent(tsk);
+	INIT_LIST_HEAD(&ptrace_dead);
+	forget_original_parent(tsk, &ptrace_dead);
 	BUG_ON(!list_empty(&tsk->children));
 
 	/*
@@ -759,6 +777,12 @@ static void exit_notify(struct task_stru
 	_raw_write_unlock(&tasklist_lock);
 	local_irq_enable();
 
+	list_for_each_safe(_p, _n, &ptrace_dead) {
+		list_del_init(_p);
+		t = list_entry(_p,struct task_struct,ptrace_list);
+		release_task(t);
+	}
+
 	/* If the process is dead, release it - nobody will wait for it */
 	if (state == TASK_DEAD)
 		release_task(tsk);
