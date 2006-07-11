Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWGKEnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWGKEnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWGKEnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:43:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27882 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965154AbWGKEnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:43:16 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Ingo Oeser <ioe-lkml@rameria.de>
Subject: [PATCH] de_thread: Use tsk not current.
Date: Mon, 10 Jul 2006 22:42:25 -0600
Message-ID: <m1bqrwkb0u.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Oeser pointed out that because current expands to an inline function it
is more space efficient and somewhat faster to simply keep a cached copy of
current in another variable.  This patch implements that for the de_thread
function.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/exec.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1dd7d49..4dc39b7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -597,7 +597,7 @@ static int de_thread(struct task_struct 
 	if (!newsighand)
 		return -ENOMEM;
 
-	if (thread_group_empty(current))
+	if (thread_group_empty(tsk))
 		goto no_thread_group;
 
 	/*
@@ -622,17 +622,17 @@ static int de_thread(struct task_struct 
 	 * Reparenting needs write_lock on tasklist_lock,
 	 * so it is safe to do it under read_lock.
 	 */
-	if (unlikely(current->group_leader == child_reaper))
-		child_reaper = current;
+	if (unlikely(tsk->group_leader == child_reaper))
+		child_reaper = tsk;
 
-	zap_other_threads(current);
+	zap_other_threads(tsk);
 	read_unlock(&tasklist_lock);
 
 	/*
 	 * Account for the thread group leader hanging around:
 	 */
 	count = 1;
-	if (!thread_group_leader(current)) {
+	if (!thread_group_leader(tsk)) {
 		count = 2;
 		/*
 		 * The SIGALRM timer survives the exec, but needs to point
@@ -641,14 +641,14 @@ static int de_thread(struct task_struct 
 		 * synchronize with any firing (by calling del_timer_sync)
 		 * before we can safely let the old group leader die.
 		 */
-		sig->tsk = current;
+		sig->tsk = tsk;
 		spin_unlock_irq(lock);
 		if (hrtimer_cancel(&sig->real_timer))
 			hrtimer_restart(&sig->real_timer);
 		spin_lock_irq(lock);
 	}
 	while (atomic_read(&sig->count) > count) {
-		sig->group_exit_task = current;
+		sig->group_exit_task = tsk;
 		sig->notify_count = count;
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(lock);
@@ -664,13 +664,13 @@ static int de_thread(struct task_struct 
 	 * do is to wait for the thread group leader to become inactive,
 	 * and to assume its PID:
 	 */
-	if (!thread_group_leader(current)) {
+	if (!thread_group_leader(tsk)) {
 		/*
 		 * Wait for the thread group leader to be a zombie.
 		 * It should already be zombie at this point, most
 		 * of the time.
 		 */
-		leader = current->group_leader;
+		leader = tsk->group_leader;
 		while (leader->exit_state != EXIT_ZOMBIE)
 			yield();
 
@@ -684,12 +684,12 @@ static int de_thread(struct task_struct 
 		 * When we take on its identity by switching to its PID, we
 		 * also take its birthdate (always earlier than our own).
 		 */
-		current->start_time = leader->start_time;
+		tsk->start_time = leader->start_time;
 
 		write_lock_irq(&tasklist_lock);
 
-		BUG_ON(leader->tgid != current->tgid);
-		BUG_ON(current->pid == current->tgid);
+		BUG_ON(leader->tgid != tsk->tgid);
+		BUG_ON(tsk->pid == tsk->tgid);
 		/*
 		 * An exec() starts a new thread group with the
 		 * TGID of the previous thread group. Rehash the
@@ -702,17 +702,17 @@ static int de_thread(struct task_struct 
 		 * Note: The old leader also uses this pid until release_task
 		 *       is called.  Odd but simple and correct.
 		 */
-		detach_pid(current, PIDTYPE_PID);
-		current->pid = leader->pid;
-		attach_pid(current, PIDTYPE_PID,  current->pid);
-		transfer_pid(leader, current, PIDTYPE_PGID);
-		transfer_pid(leader, current, PIDTYPE_SID);
-		list_replace_rcu(&leader->tasks, &current->tasks);
+		detach_pid(tsk, PIDTYPE_PID);
+		tsk->pid = leader->pid;
+		attach_pid(tsk, PIDTYPE_PID,  tsk->pid);
+		transfer_pid(leader, tsk, PIDTYPE_PGID);
+		transfer_pid(leader, tsk, PIDTYPE_SID);
+		list_replace_rcu(&leader->tasks, &tsk->tasks);
 
-		current->group_leader = current;
-		leader->group_leader = current;
+		tsk->group_leader = tsk;
+		leader->group_leader = tsk;
 
-		current->exit_signal = SIGCHLD;
+		tsk->exit_signal = SIGCHLD;
 
 		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
 		leader->exit_state = EXIT_DEAD;
@@ -752,7 +752,7 @@ no_thread_group:
 		spin_lock(&oldsighand->siglock);
 		spin_lock(&newsighand->siglock);
 
-		rcu_assign_pointer(current->sighand, newsighand);
+		rcu_assign_pointer(tsk->sighand, newsighand);
 		recalc_sigpending();
 
 		spin_unlock(&newsighand->siglock);
@@ -763,7 +763,7 @@ no_thread_group:
 			kmem_cache_free(sighand_cachep, oldsighand);
 	}
 
-	BUG_ON(!thread_group_leader(current));
+	BUG_ON(!thread_group_leader(tsk));
 	return 0;
 }
 	
-- 
1.4.1.gac83a

