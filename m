Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWHYJX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWHYJX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWHYJX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:23:28 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:47235 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932362AbWHYJX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:23:27 -0400
Date: Fri, 25 Aug 2006 18:26:31 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, kamezawa.hiroyu@jp.fujitsu.com,
       Andrew Morton <akpm@osdl.org>, saito.tadashi@soft.fujitsu.com,
       ak@suse.de
Subject: [RFC][PATCH] ps command race fix take 4 [2/4] task struct callback
Message-Id: <20060825182631.7190b449.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 add addaptive_pointer's target to task_struct.
 Now, this is used by /proc/<pid> readdir() routine.

 When release_task() is called, call_invalidate_ap() is invoked and
 pointers are invalidated and registerred callback is called.

 Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 include/linux/init_task.h |    1 +
 include/linux/sched.h     |    4 +++-
 kernel/exit.c             |    4 ++++
 kernel/fork.c             |    2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/sched.h
+++ linux-2.6.18-rc4/include/linux/sched.h
@@ -80,6 +80,7 @@ struct sched_param {
 #include <linux/resource.h>
 #include <linux/timer.h>
 #include <linux/hrtimer.h>
+#include <linux/adaptive_pointer.h>
 
 #include <asm/processor.h>
 
@@ -988,7 +989,8 @@ struct task_struct {
 
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
-
+	/* used by /proc/<pid> */
+	struct adaptive_pointer ap_target;
 	/*
 	 * cache last used pipe for splice
 	 */
Index: linux-2.6.18-rc4/kernel/fork.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/fork.c
+++ linux-2.6.18-rc4/kernel/fork.c
@@ -1154,6 +1154,7 @@ static struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->thread_group);
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
+	init_adaptive_pointer(&p->ap_target);
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	sched_fork(p, clone_flags);
@@ -1241,6 +1242,7 @@ static struct task_struct *copy_process(
 			__get_cpu_var(process_counts)++;
 		}
 		attach_pid(p, PIDTYPE_PID, p->pid);
+		ap_alive(&p->ap_target);
 		nr_threads++;
 	}
 
Index: linux-2.6.18-rc4/include/linux/init_task.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/init_task.h
+++ linux-2.6.18-rc4/include/linux/init_task.h
@@ -128,6 +128,7 @@ extern struct group_info init_groups;
 	.pi_lock	= SPIN_LOCK_UNLOCKED,				\
 	INIT_TRACE_IRQFLAGS						\
 	INIT_LOCKDEP							\
+	.ap_target	= ADAPTIVE_POINTER_INIT(tsk.ap_target),		\
 }
 
 
Index: linux-2.6.18-rc4/kernel/exit.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/exit.c
+++ linux-2.6.18-rc4/kernel/exit.c
@@ -38,6 +38,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
+#include <linux/adaptive_pointer.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -143,6 +144,9 @@ repeat:
 	write_lock_irq(&tasklist_lock);
 	ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
+
+	/* invalidate adaptive pointer to this task */
+	call_invalidate_ap(&p->ap_target);
 	__exit_signal(p);
 
 	/*

