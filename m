Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWDJXSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWDJXSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWDJXSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:18:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38636 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932164AbWDJXSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:18:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] de_thread: Don't confuse users do_each_thread.
References: <20060406220403.GA205@oleg>
	<m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
	<20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org>
	<20060407155619.18f3c5ec.akpm@osdl.org>
	<m1d5fslcwx.fsf@ebiederm.dsl.xmission.com> <20060408172745.GA89@oleg>
	<m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 10 Apr 2006 17:16:49 -0600
In-Reply-To: <m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 10 Apr 2006 17:07:42 -0600")
Message-ID: <m1u091dnry.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't seem to send out a correct patch out today with out
sending it twice.  I accidently grabbed my old version
that sent to many arguments to detach_pid and so would not
compile.  Oops.

---

Oleg Nesterov spotted two interesting bugs with the current de_thread
code.  The simplest is a long standing double decrement of
__get_cpu_var(process_counts) in __unhash_process.  Caused by
two processes exiting when only one was created.

The other is that since we no longer detach from the thread_group list
it is possible for do_each_thread when run under the tasklist_lock to
see the same task_struct twice.  Once on the task list as a
thread_group_leader, and once on the thread list of another
thread.

The double appearance in do_each_thread can cause a double increment
of mm_core_waiters in zap_threads resulting in problems later on in
coredump_wait.

To remedy those two problems this patch takes the simple approach
of changing the old thread group leader into a child thread.
The only routine in release_task that cares is __unhash_process,
and it can be trivially seen that we handle cleaning up a
thread group leader properly.

Since de_thread doesn't change the pid of the exiting leader process
and instead shares it with the new leader process.  I change
thread_group_leader to recognize group leadership based on the
group_leader field and not based on pids.  This should also be
slightly cheaper then the existing thread_group_leader macro.

I performed a quick audit and I couldn't see any user of
thread_group_leader that cared how cared about the difference.

I believe this is 2.6.17 material as the bug is present in
2.6.17-rc1 and the fix is simple.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/exec.c             |    7 ++++++-
 include/linux/sched.h |    3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

e621f800b1de6684beb995014190b3ccaad5c0b3
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 541f482..a3e4f6b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1203,7 +1203,8 @@ #define do_each_thread(g, t) \
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
-#define thread_group_leader(p)	(p->pid == p->tgid)
+/* de_thread depends on thread_group_leader not being a pid based check */
+#define thread_group_leader(p)	(p == p->group_leader)
 
 static inline task_t *next_thread(task_t *p)
 {
diff --git a/fs/exec.c b/fs/exec.c
index 0291a68..4d38ad0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -723,7 +723,12 @@ static int de_thread(struct task_struct 
 		current->parent = current->real_parent = leader->real_parent;
 		leader->parent = leader->real_parent = child_reaper;
 		current->group_leader = current;
-		leader->group_leader = leader;
+		leader->group_leader = current;
+
+		/* Reduce leader to a thread */
+		detach_pid(leader, PIDTYPE_PGID);
+		detach_pid(leader, PIDTYPE_SID);
+		list_del_init(&leader->tasks);
 
 		add_parent(current);
 		add_parent(leader);
-- 
1.3.0.rc3.g6b3a

