Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWHVIhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWHVIhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWHVIhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:37:06 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:3477 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751359AbWHVIhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:37:04 -0400
Date: Tue, 22 Aug 2006 17:40:07 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com
Subject: [RFC][PATCH] ps command race fix take2 [2/4] change task_list
Message-Id: <20060822174007.e3c7087b.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes task->tasks from list_head to list_token.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-Off-By: Tadashi Saito <shiba@mail2.accsnet.ne.jp>

 include/linux/init_task.h |    3 ++-
 include/linux/sched.h     |   11 ++++++++---
 kernel/exit.c             |    2 +-
 kernel/fork.c             |    2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6.18-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/sched.h
+++ linux-2.6.18-rc4/include/linux/sched.h
@@ -74,6 +74,7 @@ struct sched_param {
 #include <linux/rcupdate.h>
 #include <linux/futex.h>
 #include <linux/rtmutex.h>
+#include <linux/listtoken.h>
 
 #include <linux/time.h>
 #include <linux/param.h>
@@ -799,7 +800,7 @@ struct task_struct {
 	struct sched_info sched_info;
 #endif
 
-	struct list_head tasks;
+	struct list_token tasks;
 	/*
 	 * ptrace_list/ptrace_children forms the list of my children
 	 * that were stolen by a ptracer.
@@ -1315,8 +1316,12 @@ extern void wait_task_inactive(struct ta
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p)		list_add_tail(&(p)->sibling,&(p)->parent->children)
 
-#define next_task(p)	list_entry(rcu_dereference((p)->tasks.next), struct task_struct, tasks)
-
+static inline struct task_struct *next_task(struct task_struct *task)
+{
+	struct list_token *ent;
+	ent = list_next_rcu_skiptoken(&task->tasks);
+	return container_of(ent, struct task_struct, tasks);
+}
 #define for_each_process(p) \
 	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
 
Index: linux-2.6.18-rc4/kernel/exit.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/exit.c
+++ linux-2.6.18-rc4/kernel/exit.c
@@ -57,7 +57,7 @@ static void __unhash_process(struct task
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
 
-		list_del_rcu(&p->tasks);
+		list_del_rcu_token(&p->tasks);
 		__get_cpu_var(process_counts)--;
 	}
 	list_del_rcu(&p->thread_group);
Index: linux-2.6.18-rc4/kernel/fork.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/fork.c
+++ linux-2.6.18-rc4/kernel/fork.c
@@ -1237,7 +1237,7 @@ static struct task_struct *copy_process(
 			attach_pid(p, PIDTYPE_PGID, process_group(p));
 			attach_pid(p, PIDTYPE_SID, p->signal->session);
 
-			list_add_tail_rcu(&p->tasks, &init_task.tasks);
+			list_add_tail_rcu_token(&p->tasks, &init_task.tasks);
 			__get_cpu_var(process_counts)++;
 		}
 		attach_pid(p, PIDTYPE_PID, p->pid);
Index: linux-2.6.18-rc4/include/linux/init_task.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/init_task.h
+++ linux-2.6.18-rc4/include/linux/init_task.h
@@ -5,6 +5,7 @@
 #include <linux/rcupdate.h>
 #include <linux/irqflags.h>
 #include <linux/lockdep.h>
+#include <linux/listtoken.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -97,7 +98,7 @@ extern struct group_info init_groups;
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
 	.ioprio		= 0,						\
 	.time_slice	= HZ,						\
-	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
+	.tasks		= LIST_TOKEN_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
 	.real_parent	= &tsk,						\

