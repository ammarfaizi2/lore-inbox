Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWCHT1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWCHT1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWCHT1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:27:08 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:53196 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932337AbWCHT1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:27:06 -0500
Message-ID: <440F2F4A.3E91C272@tv-sign.ru>
Date: Wed, 08 Mar 2006 22:23:54 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH rc5-mm] pids: kill PIDTYPE_TGID
References: <440DEADB.72C3A8A6@tv-sign.ru>
		<m11wxd27wx.fsf@ebiederm.dsl.xmission.com>
		<440EED04.57FF5594@tv-sign.ru> <m1slpsx61f.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
	s/tgrp/thread_group/

	make it rcu-safe

[PATCH rc5-mm] pids: kill PIDTYPE_TGID

depends on pidhash-dont-count-idle-threads.patch

This patch kills PIDTYPE_TGID pid_type thus saving one hash table
in kernel/pid.c and speeding up subthreads create/destroy a bit.
It is also a preparation for the further tref/pids rework.

This patch adds 'struct list_head thread_group' to 'struct task_struct'
instead.

We don't detach group leader from PIDTYPE_PID namespace until another
thread inherits it's ->pid == ->tgid, so we are safe wrt premature
free_pidmap(->tgid) call.

Currently there are no users of find_task_by_pid_type(PIDTYPE_TGID).
Should the need arise, we can use find_task_by_pid()->group_leader.

 include/linux/pid.h   |    1 -
 include/linux/sched.h |   10 +++++++---
 kernel/exit.c         |   10 +---------
 kernel/fork.c         |    4 +++-
 4 files changed, 11 insertions(+), 14 deletions(-)

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc5/include/linux/pid.h~1_TGID	2006-03-09 00:17:24.000000000 +0300
+++ 2.6.16-rc5/include/linux/pid.h	2006-03-09 00:20:45.000000000 +0300
@@ -4,7 +4,6 @@
 enum pid_type
 {
 	PIDTYPE_PID,
-	PIDTYPE_TGID,
 	PIDTYPE_PGID,
 	PIDTYPE_SID,
 	PIDTYPE_MAX
--- 2.6.16-rc5/include/linux/sched.h~1_TGID	2006-03-09 00:17:24.000000000 +0300
+++ 2.6.16-rc5/include/linux/sched.h	2006-03-09 00:34:57.000000000 +0300
@@ -748,6 +748,7 @@ struct task_struct {
 
 	/* PID/PID hash table linkage. */
 	struct pid pids[PIDTYPE_MAX];
+	struct list_head thread_group;
 
 	struct completion *vfork_done;		/* for vfork() */
 	int __user *set_child_tid;		/* CLONE_CHILD_SETTID */
@@ -1181,13 +1182,17 @@ extern void wait_task_inactive(task_t * 
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
-extern task_t * FASTCALL(next_thread(const task_t *p));
-
 #define thread_group_leader(p)	(p->pid == p->tgid)
 
+static inline task_t *next_thread(task_t *p)
+{
+	return list_entry(rcu_dereference(p->thread_group.next),
+				task_t, thread_group);
+}
+
 static inline int thread_group_empty(task_t *p)
 {
-	return list_empty(&p->pids[PIDTYPE_TGID].pid_list);
+	return list_empty(&p->thread_group);
 }
 
 #define delay_group_leader(p) \
--- 2.6.16-rc5/kernel/exit.c~1_TGID	2006-03-09 00:17:24.000000000 +0300
+++ 2.6.16-rc5/kernel/exit.c	2006-03-09 00:42:26.000000000 +0300
@@ -49,7 +49,6 @@ static void __unhash_process(struct task
 {
 	nr_threads--;
 	detach_pid(p, PIDTYPE_PID);
-	detach_pid(p, PIDTYPE_TGID);
 	if (thread_group_leader(p)) {
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
@@ -57,7 +56,7 @@ static void __unhash_process(struct task
 		list_del_init(&p->tasks);
 		__get_cpu_var(process_counts)--;
 	}
-
+	list_del_rcu(&p->thread_group);
 	remove_parent(p);
 }
 
@@ -953,13 +952,6 @@ asmlinkage long sys_exit(int error_code)
 	do_exit((error_code&0xff)<<8);
 }
 
-task_t fastcall *next_thread(const task_t *p)
-{
-	return pid_task(p->pids[PIDTYPE_TGID].pid_list.next, PIDTYPE_TGID);
-}
-
-EXPORT_SYMBOL(next_thread);
-
 /*
  * Take down every thread in the group.  This is called by fatal signals
  * as well as by sys_exit_group (below).
--- 2.6.16-rc5/kernel/fork.c~1_TGID	2006-03-09 00:17:24.000000000 +0300
+++ 2.6.16-rc5/kernel/fork.c	2006-03-09 00:41:35.000000000 +0300
@@ -1100,6 +1100,7 @@ static task_t *copy_process(unsigned lon
 	 * We dont wake it up yet.
 	 */
 	p->group_leader = p;
+	INIT_LIST_HEAD(&p->thread_group);
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
 
@@ -1153,7 +1154,9 @@ static task_t *copy_process(unsigned lon
 			retval = -EAGAIN;
 			goto bad_fork_cleanup_namespace;
 		}
+
 		p->group_leader = current->group_leader;
+		list_add_tail_rcu(&p->thread_group, &current->thread_group);
 
 		if (current->signal->group_stop_count > 0) {
 			/*
@@ -1201,7 +1204,6 @@ static task_t *copy_process(unsigned lon
 			list_add_tail(&p->tasks, &init_task.tasks);
 			__get_cpu_var(process_counts)++;
 		}
-		attach_pid(p, PIDTYPE_TGID, p->tgid);
 		attach_pid(p, PIDTYPE_PID, p->pid);
 		nr_threads++;
 	}
