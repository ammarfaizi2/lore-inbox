Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWGJWmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWGJWmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWGJWmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:42:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16292 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964989AbWGJWmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:42:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] pid: Implement transfer_pid and use it to simplify de_thread.
CC: <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>
Date: Mon, 10 Jul 2006 16:41:19 -0600
Message-ID: <m1lkr1krqo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In de_thread we move pids from one process to another, a rather ugly case.
The function transfer_pid makes it clear what we are doing, and makes the
action atomic.  This is useful we ever want to atomically traverse the
process group and session lists, in a rcu safe manner.

Even if the atomic properties this change should be a win as transfer_pid
should be less code to execute than executing both attach_pid and detach_pid,
and this should make de_thread slightly smaller as only a single function
call needs to be emitted.  The only downside is that the code might be slower
to execute as the odds are against transfer_pid being in cache.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/exec.c           |   11 ++++-------
 include/linux/pid.h |    2 ++
 kernel/pid.c        |   10 ++++++++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 208a027..1dd7d49 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -698,23 +698,20 @@ static int de_thread(struct task_struct 
 		 */
 
 		/* Become a process group leader with the old leader's pid.
-		 * Note: The old leader also uses thispid until release_task
+		 * The old leader becomes a thread of the this thread group.
+		 * Note: The old leader also uses this pid until release_task
 		 *       is called.  Odd but simple and correct.
 		 */
 		detach_pid(current, PIDTYPE_PID);
 		current->pid = leader->pid;
 		attach_pid(current, PIDTYPE_PID,  current->pid);
-		attach_pid(current, PIDTYPE_PGID, current->signal->pgrp);
-		attach_pid(current, PIDTYPE_SID,  current->signal->session);
+		transfer_pid(leader, current, PIDTYPE_PGID);
+		transfer_pid(leader, current, PIDTYPE_SID);
 		list_replace_rcu(&leader->tasks, &current->tasks);
 
 		current->group_leader = current;
 		leader->group_leader = current;
 
-		/* Reduce leader to a thread */
-		detach_pid(leader, PIDTYPE_PGID);
-		detach_pid(leader, PIDTYPE_SID);
-
 		current->exit_signal = SIGCHLD;
 
 		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 29960b0..93da7e2 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -76,6 +76,8 @@ extern int FASTCALL(attach_pid(struct ta
 				enum pid_type type, int nr));
 
 extern void FASTCALL(detach_pid(struct task_struct *task, enum pid_type));
+extern void FASTCALL(transfer_pid(struct task_struct *old,
+				  struct task_struct *new, enum pid_type));
 
 /*
  * look up a PID in the hash table. Must be called with the tasklist_lock
diff --git a/kernel/pid.c b/kernel/pid.c
index 37851b0..3153e96 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -253,6 +253,16 @@ void fastcall detach_pid(struct task_str
 	free_pid(pid);
 }
 
+/* transfer_pid is an optimization of attach_pid(new), detach_pid(old) */
+void fastcall transfer_pid(struct task_struct *old, struct task_struct *new,
+			   enum pid_type type)
+{
+	new->pids[type].pid = old->pids[type].pid;
+	hlist_replace_rcu(&old->pids[type].node, &new->pids[type].node);
+	old->pids[type].pid = NULL;
+
+}
+
 struct task_struct * fastcall pid_task(struct pid *pid, enum pid_type type)
 {
 	struct task_struct *result = NULL;
-- 
1.4.1.gac83a

