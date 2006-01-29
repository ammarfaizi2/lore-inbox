Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWA2GX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWA2GX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWA2GX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:23:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22238 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750837AbWA2GX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:23:28 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] exec: Cleanup exec from a non thread group leader.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 28 Jan 2006 23:23:00 -0700
Message-ID: <m1zmlfft8b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modifies switch_exec_pids so that it uses the
normal attach_pid/detach_pid functions.  This makes
the code more maintainable and it removes a race
where find_pid could fail to find a thread group or
a process id that currently exists.

We also now preserve the exit_signal of our thread group
leader when we call exec (when we take over the thread
group leaders identity).

And for good measure we set the thread group leaders
exit_signal to -1 so it will self reap.  We are actually
past the point where that matters but it can't hurt, and
it might help someday.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/exec.c    |    3 ++-
 kernel/pid.c |   33 +++++++++++++--------------------
 2 files changed, 15 insertions(+), 21 deletions(-)

dab45943cf60c11f4432d6fdd26d68eb7092b8dd
diff --git a/fs/exec.c b/fs/exec.c
index c9d8e31..922dbee 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -721,10 +721,11 @@ static int de_thread(struct task_struct 
 
 		list_del(&current->tasks);
 		list_add_tail(&current->tasks, &init_task.tasks);
-		current->exit_signal = SIGCHLD;
+		current->exit_signal = leader->exit_signal;
 
 		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
 		leader->exit_state = EXIT_DEAD;
+		leader->exit_signal = -1;
 
 		write_unlock_irq(&tasklist_lock);
 		spin_unlock(&leader->proc_lock);
diff --git a/kernel/pid.c b/kernel/pid.c
index 1acc072..d2247dc 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -220,31 +220,24 @@ EXPORT_SYMBOL(find_task_by_pid_type);
 /*
  * This function switches the PIDs if a non-leader thread calls
  * sys_execve() - this must be done without releasing the PID.
- * (which a detach_pid() would eventually do.)
+ *
+ * The attach and detach operations have been carefully
+ * ordered so there is never an instant that pids that will
+ * survive are absent from the hash table.  This ensures
+ * that we don't release pids we mean to keep.
  */
 void switch_exec_pids(task_t *leader, task_t *thread)
 {
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
+	detach_pid(thread, PIDTYPE_PID);
+	thread->pid = leader->pid;
+	attach_pid(thread, PIDTYPE_PID,  thread->pid);
 	attach_pid(thread, PIDTYPE_PGID, thread->signal->pgrp);
-	attach_pid(thread, PIDTYPE_SID, thread->signal->session);
-	list_add_tail(&thread->tasks, &init_task.tasks);
+	attach_pid(thread, PIDTYPE_SID,  thread->signal->session);
 
-	attach_pid(leader, PIDTYPE_PID, leader->pid);
-	attach_pid(leader, PIDTYPE_TGID, leader->tgid);
-	attach_pid(leader, PIDTYPE_PGID, leader->signal->pgrp);
-	attach_pid(leader, PIDTYPE_SID, leader->signal->session);
+	detach_pid(leader, PIDTYPE_PID);
+	detach_pid(leader, PIDTYPE_TGID);
+	detach_pid(leader, PIDTYPE_PGID);
+	detach_pid(leader, PIDTYPE_SID);
 }
 
 /*
-- 
1.1.5.g3480

