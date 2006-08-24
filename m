Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWHXL7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWHXL7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWHXL7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:59:23 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:52431 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751160AbWHXL7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:59:22 -0400
Date: Thu, 24 Aug 2006 21:01:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, kamezawa.hiroyu@jp.fujitsu.com,
       Andrew Morton <akpm@osdl.org>, saito.tadashi@soft.fujitsu.com,
       ak@suse.de
Subject: [RFC][PATCH] ps command race fix take 3 [2/4]  add member to task
 struct
Message-Id: <20060824210136.dcfb7d15.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 add watch_head to task_struct.
 This is used by /proc/<pid> readdir() routine.

 pointer from /proc (which traverse task_list) is moved to next_task()
 if target task is removed.

 Note: next_task() in release_task() never return stale task struct.

 Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 include/linux/init_task.h |    2 ++
 include/linux/sched.h     |    4 +++-
 kernel/exit.c             |    7 ++++++-
 kernel/fork.c             |    3 +++
 4 files changed, 14 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/sched.h
+++ linux-2.6.18-rc4/include/linux/sched.h
@@ -80,6 +80,7 @@ struct sched_param {
 #include <linux/resource.h>
 #include <linux/timer.h>
 #include <linux/hrtimer.h>
+#include <linux/watch_head.h>
 
 #include <asm/processor.h>
 
@@ -988,7 +989,8 @@ struct task_struct {
 
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
-
+	/* used by /proc/<pid> */
+	struct watch_head watch;
 	/*
 	 * cache last used pipe for splice
 	 */
Index: linux-2.6.18-rc4/kernel/fork.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/fork.c
+++ linux-2.6.18-rc4/kernel/fork.c
@@ -45,6 +45,7 @@
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
+#include <linux/watch_head.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1154,6 +1155,7 @@ static struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->thread_group);
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
+	init_watch(&p->watch);
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	sched_fork(p, clone_flags);
@@ -1241,6 +1243,7 @@ static struct task_struct *copy_process(
 			__get_cpu_var(process_counts)++;
 		}
 		attach_pid(p, PIDTYPE_PID, p->pid);
+		make_watch_ready(&p->watch);
 		nr_threads++;
 	}
 
Index: linux-2.6.18-rc4/include/linux/init_task.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/init_task.h
+++ linux-2.6.18-rc4/include/linux/init_task.h
@@ -5,6 +5,7 @@
 #include <linux/rcupdate.h>
 #include <linux/irqflags.h>
 #include <linux/lockdep.h>
+#include <linux/watch_head.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -128,6 +129,7 @@ extern struct group_info init_groups;
 	.pi_lock	= SPIN_LOCK_UNLOCKED,				\
 	INIT_TRACE_IRQFLAGS						\
 	INIT_LOCKDEP							\
+	.watch		= WATCH_HEAD_INIT(tsk.watch),			\
 }
 
 
Index: linux-2.6.18-rc4/kernel/exit.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/exit.c
+++ linux-2.6.18-rc4/kernel/exit.c
@@ -38,6 +38,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
+#include <linux/watch_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -136,13 +137,17 @@ static void delayed_put_task_struct(stru
 
 void release_task(struct task_struct * p)
 {
-	struct task_struct *leader;
+	struct task_struct *leader, *next;
 	int zap_leader;
 repeat:
 	atomic_dec(&p->user->processes);
 	write_lock_irq(&tasklist_lock);
 	ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
+
+	/* move pointer from /proc to next task */
+	next = next_task(p);
+	move_watcher(&p->watch, &next->watch);
 	__exit_signal(p);
 
 	/*

