Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261408AbSIPMkF>; Mon, 16 Sep 2002 08:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbSIPMkF>; Mon, 16 Sep 2002 08:40:05 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:19726 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261408AbSIPMkE>; Mon, 16 Sep 2002 08:40:04 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Daniel Jacobowitz <drow@false.org>
Subject: Re: [PATCH] Fix for ptrace breakage
References: <Pine.LNX.4.44.0209161349270.29027-100000@localhost.localdomain>
	<87vg565eo2.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 16 Sep 2002 21:44:34 +0900
In-Reply-To: <87vg565eo2.fsf@devron.myhome.or.jp>
Message-ID: <87wupmrtn1.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Grr, sorry. This patch is bad version.
> 
>  	list_for_each(_p, &father->ptrace_children) {
> 
> of course, this should
> 
>  	list_for_each_safe(_p, _n, &father->ptrace_children) {

This is a patch which fixed the above. Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- linux-2.5.35/kernel/exit.c~	2002-09-16 17:41:59.000000000 +0900
+++ linux-2.5.35/kernel/exit.c	2002-09-16 20:55:43.000000000 +0900
@@ -221,7 +221,6 @@ void reparent_to_init(void)
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
 
-	current->ptrace = 0;
 	if ((current->policy == SCHED_NORMAL) && (task_nice(current) < 0))
 		set_user_nice(current, 0);
 	/* cpus_allowed? */
@@ -443,7 +442,7 @@ void exit_mm(struct task_struct *tsk)
 static inline void forget_original_parent(struct task_struct * father)
 {
 	struct task_struct *p, *reaper = father;
-	struct list_head *_p;
+	struct list_head *_p, *_n;
 
 	reaper = father->group_leader;
 	if (reaper == father)
@@ -462,52 +461,37 @@ static inline void forget_original_paren
 		if (father == p->real_parent)
 			reparent_thread(p, reaper, child_reaper);
 	}
-	list_for_each(_p, &father->ptrace_children) {
+	list_for_each_safe(_p, _n, &father->ptrace_children) {
 		p = list_entry(_p,struct task_struct,ptrace_list);
+		list_del_init(&p->ptrace_list);
 		reparent_thread(p, reaper, child_reaper);
+		if (p->parent != p->real_parent)
+			list_add(&p->ptrace_list, &p->real_parent->ptrace_children);
 	}
 }
 
-static inline void zap_thread(task_t *p, task_t *father, int traced)
+static inline void zap_thread(task_t *p, task_t *father)
 {
-	/* If someone else is tracing this thread, preserve the ptrace links.  */
-	if (unlikely(traced)) {
-		task_t *trace_task = p->parent;
-		int ptrace_flag = p->ptrace;
-		BUG_ON (ptrace_flag == 0);
-
-		__ptrace_unlink(p);
-		p->ptrace = ptrace_flag;
-		__ptrace_link(p, trace_task);
-	} else {
-		/*
-		 * Otherwise, if we were tracing this thread, untrace it.
-		 * If we were only tracing the thread (i.e. not its real
-		 * parent), stop here.
-		 */
-		ptrace_unlink (p);
-		if (p->parent != father) {
-			BUG_ON(p->parent != p->real_parent);
-			return;
-		}
-		list_del_init(&p->sibling);
-		p->parent = p->real_parent;
-		list_add_tail(&p->sibling, &p->parent->children);
-	}
+	ptrace_unlink(p);
 
+	remove_parent(p);
+	p->parent = p->real_parent;
+	add_parent(p, p->parent);
 	if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
 		do_notify_parent(p, p->exit_signal);
+
 	/*
 	 * process group orphan check
 	 * Case ii: Our child is in a different pgrp
 	 * than we are, and it was the only connection
 	 * outside, so the child pgrp is now orphaned.
 	 */
-	if ((p->pgrp != current->pgrp) &&
-	    (p->session == current->session)) {
+	if ((p->pgrp != father->pgrp) &&
+	    (p->session == father->session)) {
 		int pgrp = p->pgrp;
 
-		if (__will_become_orphaned_pgrp(pgrp, 0) && __has_stopped_jobs(pgrp)) {
+		if (__will_become_orphaned_pgrp(pgrp, 0) &&
+		    __has_stopped_jobs(pgrp)) {
 			__kill_pg_info(SIGHUP, (void *)1, pgrp);
 			__kill_pg_info(SIGCONT, (void *)1, pgrp);
 		}
@@ -520,7 +504,7 @@ static inline void zap_thread(task_t *p,
  */
 static void exit_notify(void)
 {
-	struct task_struct *t;
+	struct task_struct *t, *p;
 
 	write_lock_irq(&tasklist_lock);
 
@@ -580,10 +564,8 @@ static void exit_notify(void)
 	if (current->exit_signal != -1)
 		do_notify_parent(current, current->exit_signal);
 
-	while (!list_empty(&current->children))
-		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
-	while (!list_empty(&current->ptrace_children))
-		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,ptrace_list), current, 1);
+	while ((p = eldest_child(current)) != NULL)
+		zap_thread(p, current);
 	BUG_ON(!list_empty(&current->children));
 
 	current->state = TASK_ZOMBIE;
