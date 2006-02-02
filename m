Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWBBRq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWBBRq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWBBRq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:46:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30384 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750893AbWBBRq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:46:26 -0500
To: Andrew Morton <akpm@osdl.org>
CC: Oleg Nesterov <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: [PATCH] pidhash:  Kill switch_exec_pids
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Feb 2006 10:45:29 -0700
Message-ID: <m1r76lslhi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew my apologies for the patch thrash, but I'm not certain
which patches are in your tree at the moment (I know there are
things that don't appear in -mm4) or I would send you an incremental
patch.  So this is a clean patch against linus's tree.  After some
more review and seeing how my patches intersected with Oleg's it
appears the sane thing is to just kill switch_exec_pids().

switch_exec_pids is only called from de_thread by way of exec, and it
is only called when we are exec'ing from a non thread group leader.

Currently switch_exec_pids gives the leader the pid of the thread and
unhashes and rehashes all of the process groups.   The leader is
already in the EXIT_DEAD state so no one cares about it's pids.  The
only concern for the leader is that __unhash_process called from release_task
will function correctly.  If we don't touch the leader at all we know
that __unhash_process will work fine so there is no need to touch the leader.

For the task becomming the thread group leader, we just need to
give it the pid of the old thread group leader, add it to the task list,
and attach it to the session and the process group of the thread group.

Currently de_thread is also adding the task to the task list which
is just silly.

Currently the only leader of __detach_pid besides detach_pid is
switch_exec_pids because of the ugly extra work that was being
performed.

So this patch removes switch_exec_pids because it is doing too much,
it is creating an unnecessary special case in pid.c, duing work duplicated
in de_thread, and generally obscuring what it is going on.

The necessary work is added to de_thread, and it seems to be a little
clearer there what is going on.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/exec.c           |   14 +++++++++++---
 include/linux/pid.h |    1 -
 kernel/pid.c        |   30 ------------------------------
 3 files changed, 11 insertions(+), 34 deletions(-)

e418b6a6f92419d947be8cc5778f1ad2b4d71275
diff --git a/fs/exec.c b/fs/exec.c
index 055378d..56d60c4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,17 @@ static int de_thread(struct task_struct 
 		remove_parent(current);
 		remove_parent(leader);
 
-		switch_exec_pids(leader, current);
+
+		/* Become a process group leader with the old leader's pid.
+		 * Note: The old leader also uses thispid until release_task
+		 *       is called.  Odd but simple and correct.
+		 */
+		detach_pid(current, PIDTYPE_PID);
+		current->pid = leader->pid;
+		attach_pid(current, PIDTYPE_PID,  current->pid);
+		attach_pid(current, PIDTYPE_PGID, current->signal->pgrp);
+		attach_pid(current, PIDTYPE_SID,  current->signal->session);
+		list_add_tail(&current->tasks, &init_task.tasks);
 
 		current->parent = current->real_parent = leader->real_parent;
 		leader->parent = leader->real_parent = child_reaper;
@@ -713,8 +723,6 @@ static int de_thread(struct task_struct 
 			__ptrace_link(current, parent);
 		}
 
-		list_del(&current->tasks);
-		list_add_tail(&current->tasks, &init_task.tasks);
 		current->exit_signal = SIGCHLD;
 
 		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 5b2fcb1..099e70e 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -38,7 +38,6 @@ extern struct pid *FASTCALL(find_pid(enu
 
 extern int alloc_pidmap(void);
 extern void FASTCALL(free_pidmap(int));
-extern void switch_exec_pids(struct task_struct *leader, struct task_struct *thread);
 
 #define do_each_task_pid(who, type, task)				\
 	if ((task = find_task_by_pid_type(type, who))) {		\
diff --git a/kernel/pid.c b/kernel/pid.c
index 1acc072..7781d99 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -218,36 +218,6 @@ task_t *find_task_by_pid_type(int type, 
 EXPORT_SYMBOL(find_task_by_pid_type);
 
 /*
- * This function switches the PIDs if a non-leader thread calls
- * sys_execve() - this must be done without releasing the PID.
- * (which a detach_pid() would eventually do.)
- */
-void switch_exec_pids(task_t *leader, task_t *thread)
-{
-	__detach_pid(leader, PIDTYPE_PID);
-	__detach_pid(leader, PIDTYPE_TGID);
-	__detach_pid(leader, PIDTYPE_PGID);
-	__detach_pid(leader, PIDTYPE_SID);
-
-	__detach_pid(thread, PIDTYPE_PID);
-	__detach_pid(thread, PIDTYPE_TGID);
-
-	leader->pid = leader->tgid = thread->pid;
-	thread->pid = thread->tgid;
-
-	attach_pid(thread, PIDTYPE_PID, thread->pid);
-	attach_pid(thread, PIDTYPE_TGID, thread->tgid);
-	attach_pid(thread, PIDTYPE_PGID, thread->signal->pgrp);
-	attach_pid(thread, PIDTYPE_SID, thread->signal->session);
-	list_add_tail(&thread->tasks, &init_task.tasks);
-
-	attach_pid(leader, PIDTYPE_PID, leader->pid);
-	attach_pid(leader, PIDTYPE_TGID, leader->tgid);
-	attach_pid(leader, PIDTYPE_PGID, leader->signal->pgrp);
-	attach_pid(leader, PIDTYPE_SID, leader->signal->session);
-}
-
-/*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
  * more.
-- 
1.1.5.g3480

