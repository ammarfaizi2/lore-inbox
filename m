Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262066AbSIYTGo>; Wed, 25 Sep 2002 15:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSIYTGo>; Wed, 25 Sep 2002 15:06:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40327 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262066AbSIYTGk>;
	Wed, 25 Sep 2002 15:06:40 -0400
Date: Wed, 25 Sep 2002 21:20:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] exit-fix-2.5.38-E3
Message-ID: <Pine.LNX.4.44.0209252113280.16723-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) fixes a number of bugs in the
thread-release code:

 - notify parents only if the group leader is a zombie,
   and if it's not a detached thread.

 - do not reparent children to zombie tasks.

 - introduce the TASK_DEAD state for tasks, to serialize the task-release
   path. (to some it might be confusing that tasks are zombies first, then
   dead :-)

 - simplify tasklist_lock usage in release_task().

the effect of the above bugs ranged from unkillable hung zombies to kernel
crashes. None of those happens with the patch applied.

	Ingo

--- linux/include/linux/sched.h.orig	Wed Sep 25 18:04:03 2002
+++ linux/include/linux/sched.h	Wed Sep 25 21:08:57 2002
@@ -100,8 +100,9 @@
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
 #define TASK_UNINTERRUPTIBLE	2
-#define TASK_ZOMBIE		4
-#define TASK_STOPPED		8
+#define TASK_STOPPED		4
+#define TASK_ZOMBIE		8
+#define TASK_DEAD		16
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
--- linux/kernel/exit.c.orig	Wed Sep 25 18:01:52 2002
+++ linux/kernel/exit.c	Wed Sep 25 21:13:39 2002
@@ -32,6 +32,7 @@
 static struct dentry * __unhash_process(struct task_struct *p)
 {
 	struct dentry *proc_dentry;
+
 	nr_threads--;
 	detach_pid(p, PIDTYPE_PID);
 	detach_pid(p, PIDTYPE_TGID);
@@ -57,31 +58,31 @@
 void release_task(struct task_struct * p)
 {
 	struct dentry *proc_dentry;
+	task_t *leader;
 
-	if (p->state != TASK_ZOMBIE)
+	if (p->state < TASK_ZOMBIE)
 		BUG();
 	if (p != current)
 		wait_task_inactive(p);
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
-	if (unlikely(p->ptrace)) {
-		write_lock_irq(&tasklist_lock);
+	write_lock_irq(&tasklist_lock);
+	if (unlikely(p->ptrace))
 		__ptrace_unlink(p);
-		write_unlock_irq(&tasklist_lock);
-	}
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
-	write_lock_irq(&tasklist_lock);
 	__exit_sighand(p);
 	proc_dentry = __unhash_process(p);
 
 	/*
 	 * If we are the last non-leader member of the thread
 	 * group, and the leader is zombie, then notify the
-	 * group leader's parent process.
+	 * group leader's parent process. (if it wants notification.)
 	 */
-	if (p->group_leader != p && thread_group_empty(p))
-		do_notify_parent(p->group_leader, p->group_leader->exit_signal);
+	leader = p->group_leader;
+	if (leader != p && thread_group_empty(leader) &&
+		    leader->state == TASK_ZOMBIE && leader->exit_signal != -1)
+		do_notify_parent(leader, leader->exit_signal);
 
 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
@@ -159,7 +160,7 @@
 
 	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
 		if (p == ignored_task
-				|| p->state == TASK_ZOMBIE 
+				|| p->state >= TASK_ZOMBIE 
 				|| p->real_parent->pid == 1)
 			continue;
 		if (p->real_parent->pgrp != pgrp
@@ -435,8 +436,11 @@
 
 static inline void choose_new_parent(task_t *p, task_t *reaper, task_t *child_reaper)
 {
-	/* Make sure we're not reparenting to ourselves.  */
-	if (p == reaper)
+	/*
+	 * Make sure we're not reparenting to ourselves and that
+	 * the parent is not a zombie.
+	 */
+	if (p == reaper || reaper->state >= TASK_ZOMBIE)
 		p->real_parent = child_reaper;
 	else
 		p->real_parent = reaper;
@@ -774,9 +778,10 @@
 
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru)
 {
-	int flag, retval;
 	DECLARE_WAITQUEUE(wait, current);
 	struct task_struct *tsk;
+	unsigned long state;
+	int flag, retval;
 
 	if (options & ~(WNOHANG|WUNTRACED|__WNOTHREAD|__WCLONE|__WALL))
 		return -EINVAL;
@@ -827,7 +832,15 @@
 				 */
 				if (ret == 2)
 					continue;
+				/*
+				 * Try to move the task's state to DEAD
+				 * only one thread is allowed to do this:
+				 */
+				state = xchg(&p->state, TASK_DEAD);
+				if (state != TASK_ZOMBIE)
+					continue;
 				read_unlock(&tasklist_lock);
+
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 				if (!retval && stat_addr) {
 					if (p->sig->group_exit)
@@ -835,13 +848,16 @@
 					else
 						retval = put_user(p->exit_code, stat_addr);
 				}
-				if (retval)
-					goto end_wait4; 
+				if (retval) {
+					p->state = TASK_ZOMBIE;
+					goto end_wait4;
+				}
 				retval = p->pid;
 				if (p->real_parent != p->parent) {
 					write_lock_irq(&tasklist_lock);
 					__ptrace_unlink(p);
 					do_notify_parent(p, SIGCHLD);
+					p->state = TASK_ZOMBIE;
 					write_unlock_irq(&tasklist_lock);
 				} else
 					release_task(p);

