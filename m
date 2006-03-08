Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWCHRNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWCHRNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWCHRNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:13:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3816 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751133AbWCHRNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:13:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       William Irwin <wli@holomorphy.com>, Roland McGrath <roland@redhat.com>
Subject: [PATCH] task: Make task list manipulations RCU safe.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Mar 2006 09:42:49 -0700
Message-ID: <m1bqwgx4za.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While we can currently walk through thread groups, process groups, and
sessions with just the rcu_read_lock,  this opens the door to walking
the entire task list.

We already have all of the other RCU guarantees so there is no cost
in doing this, this should be enough so that proc can stop taking the
tasklist lock during readdir.

prev_task was killed because it has no users, and using it will
miss new tasks when doing an rcu traversal.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/exec.c             |    2 +-
 include/linux/sched.h |    3 +--
 kernel/exit.c         |    2 +-
 kernel/fork.c         |    2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

51621c1a347edd8935a80fdf4c78840e03be5e03
diff --git a/fs/exec.c b/fs/exec.c
index d961639..c01150e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -713,7 +713,7 @@ static int de_thread(struct task_struct 
 		attach_pid(current, PIDTYPE_PID,  current->pid);
 		attach_pid(current, PIDTYPE_PGID, current->signal->pgrp);
 		attach_pid(current, PIDTYPE_SID,  current->signal->session);
-		list_add_tail(&current->tasks, &init_task.tasks);
+		list_add_tail_rcu(&current->tasks, &init_task.tasks);
 
 		current->parent = current->real_parent = leader->real_parent;
 		leader->parent = leader->real_parent = child_reaper;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2856f52..e6fde1a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1187,8 +1187,7 @@ extern void wait_task_inactive(task_t * 
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p)		list_add_tail(&(p)->sibling,&(p)->parent->children)
 
-#define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
-#define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
+#define next_task(p)	list_entry(rcu_dereference((p)->tasks.next), struct task_struct, tasks)
 
 #define for_each_process(p) \
 	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
diff --git a/kernel/exit.c b/kernel/exit.c
index 806a667..47add40 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -56,7 +56,7 @@ static void __unhash_process(struct task
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
 
-		list_del_init(&p->tasks);
+		list_del_rcu(&p->tasks);
 		__get_cpu_var(process_counts)--;
 	}
 
diff --git a/kernel/fork.c b/kernel/fork.c
index d0eebc2..e7eef2e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1210,7 +1210,7 @@ static task_t *copy_process(unsigned lon
 			attach_pid(p, PIDTYPE_PGID, process_group(p));
 			attach_pid(p, PIDTYPE_SID, p->signal->session);
 
-			list_add_tail(&p->tasks, &init_task.tasks);
+			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			__get_cpu_var(process_counts)++;
 		}
 		attach_pid(p, PIDTYPE_TGID, p->tgid);
-- 
1.2.2.g709a-dirty

