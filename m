Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWD1BoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWD1BoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWD1Bex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:17329 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030236AbWD1Bej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:39 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:38 -0700
Message-Id: <20060428013438.27212.84970.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 05/12] Init and clear resource group info in task
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05/12 - tasksupport_fork_exit_init

Initializes and clears Resource Group specific information in a task at 
fork() and exit().
Inititalizes Resource Groups (called from start_kernel)
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 include/linux/res_group.h    |    7 +++++
 init/main.c                  |    2 +
 kernel/exit.c                |    2 +
 kernel/fork.c                |    2 +
 kernel/res_group/local.h     |    1 
 kernel/res_group/res_group.c |   11 +++++++++
 kernel/res_group/task.c      |   52 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 77 insertions(+)

Index: linux-2617-rc3/kernel/exit.c
===================================================================
--- linux-2617-rc3.orig/kernel/exit.c	2006-04-27 09:18:03.000000000 -0700
+++ linux-2617-rc3/kernel/exit.c	2006-04-27 09:22:20.000000000 -0700
@@ -35,6 +35,7 @@
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
+#include <linux/res_group.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -731,6 +732,7 @@ static void exit_notify(struct task_stru
 	struct task_struct *t;
 	struct list_head ptrace_dead, *_p, *_n;
 
+	clear_task_res_group(tsk);
 	if (signal_pending(tsk) && !(tsk->signal->flags & SIGNAL_GROUP_EXIT)
 	    && !thread_group_empty(tsk)) {
 		/*
Index: linux-2617-rc3/kernel/fork.c
===================================================================
--- linux-2617-rc3.orig/kernel/fork.c	2006-04-27 09:18:03.000000000 -0700
+++ linux-2617-rc3/kernel/fork.c	2006-04-27 09:22:20.000000000 -0700
@@ -44,6 +44,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/res_group.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1215,6 +1216,7 @@ static task_t *copy_process(unsigned lon
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+	init_task_res_group(p);
 	proc_fork_connector(p);
 	return p;
 
Index: linux-2617-rc3/init/main.c
===================================================================
--- linux-2617-rc3.orig/init/main.c	2006-04-27 09:18:03.000000000 -0700
+++ linux-2617-rc3/init/main.c	2006-04-27 09:22:20.000000000 -0700
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/res_group.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -541,6 +542,7 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	cpuset_init();
+	res_group_init();
 
 	check_bugs();
 
Index: linux-2617-rc3/kernel/res_group/res_group.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/res_group.c	2006-04-27 09:22:16.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/res_group.c	2006-04-27 09:22:20.000000000 -0700
@@ -231,6 +231,7 @@ int free_res_group(struct resource_group
 		return -EBUSY;
 	}
 	spin_unlock(&rgroup->group_lock);
+	move_tasks_to_parent(rgroup);
 	kref_put(&rgroup->ref, release_res_group);
 	return 0;
 }
@@ -392,6 +393,16 @@ void res_group_teardown(void)
 	}
 }
 
+void res_group_init(void)
+{
+	write_lock(&res_group_lock);
+	list_add_tail(&default_res_group.group_list, &res_groups);
+	write_unlock(&res_group_lock);
+	kref_init(&default_res_group.ref);
+	init_task.res_group = &default_res_group;
+	init_task_res_group(&init_task);
+}
+
 EXPORT_SYMBOL_GPL(register_controller);
 EXPORT_SYMBOL_GPL(unregister_controller);
 EXPORT_SYMBOL_GPL(get_controller_by_name);
Index: linux-2617-rc3/kernel/res_group/task.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/task.c	2006-04-27 09:22:16.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/task.c	2006-04-27 09:22:20.000000000 -0700
@@ -142,4 +142,56 @@ int set_res_group(pid_t pid, struct reso
 	put_task_struct(tsk);
 	return rc;
 }
+
+void init_task_res_group(struct task_struct *tsk)
+{
+	struct resource_group *rgroup;
+
+	/*
+	 * processes inherit their resource group from their real parent and
+	 * threads inherit resource group from their process.
+	 */
+	if (thread_group_leader(tsk))
+		rgroup = tsk->real_parent->res_group;
+	else
+		rgroup = tsk->group_leader->res_group;
+
+	tsk->res_group = NO_RES_GROUP;
+	INIT_LIST_HEAD(&tsk->member_list);
+
+	BUG_ON(rgroup == NULL);
+	kref_get(&rgroup->ref);
+	move_to_new_rgroup(tsk, rgroup);
+	notify_res_ctlrs(tsk, NO_RES_GROUP, rgroup);
+}
+
+void clear_task_res_group(struct task_struct *tsk)
+{
+	__set_res_group(tsk, NO_RES_GROUP);
+}
+
+/*
+ * Move all tasks in the given resource group to its parent.
+ */
+void move_tasks_to_parent(struct resource_group *rgroup)
+{
+	kref_get(&rgroup->ref);
+
+next_task:
+	spin_lock(&rgroup->group_lock);
+	if (!list_empty(&rgroup->task_list)) {
+		struct task_struct *tsk =
+			list_entry(rgroup->task_list.next,
+				struct task_struct, member_list);
+		get_task_struct(tsk);
+		spin_unlock(&rgroup->group_lock);
+		kref_get(&rgroup->parent->ref);
+		__set_res_group(tsk, rgroup->parent);
+		put_task_struct(tsk);
+		goto next_task;
+	}
+	spin_unlock(&rgroup->group_lock);
+	kref_put(&rgroup->ref, release_res_group);
+}
+
 EXPORT_SYMBOL_GPL(set_res_group);
Index: linux-2617-rc3/include/linux/res_group.h
===================================================================
--- linux-2617-rc3.orig/include/linux/res_group.h	2006-04-27 09:22:07.000000000 -0700
+++ linux-2617-rc3/include/linux/res_group.h	2006-04-27 09:22:20.000000000 -0700
@@ -94,5 +94,12 @@ struct resource_group {
 	struct list_head children;	/* head of children */
 };
 
+extern void init_task_res_group(struct task_struct *);
+extern void clear_task_res_group(struct task_struct *);
+extern void res_group_init(void);
+#else /* CONFIG_RES_GROUPS */
+static inline void init_task_res_group(struct task_struct *tsk) { }
+static inline void clear_task_res_group(struct task_struct *tsk) { }
+static inline void res_group_init(void) { }
 #endif /* CONFIG_RES_GROUPS */
 #endif /* _LINUX_RES_GROUP_H */
Index: linux-2617-rc3/kernel/res_group/local.h
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/local.h	2006-04-27 09:22:16.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/local.h	2006-04-27 09:22:20.000000000 -0700
@@ -19,3 +19,4 @@ extern void set_shares_to_default(struct
 						struct res_controller *);
 extern void res_group_teardown(void);
 extern int set_res_group(pid_t, struct resource_group *);
+extern void move_tasks_to_parent(struct resource_group *);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
