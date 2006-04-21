Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWDUCZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWDUCZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWDUCZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:30895 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750876AbWDUCYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:41 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:39 -0700
Message-Id: <20060421022439.6145.56465.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 05/12] Init and clear class info in task
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05/12 - ckrm_tasksupport_fork_exit_init

Initializes and clears ckrm specific information in a task at fork() and
exit().
Inititalizes ckrm (called from start_kernel)
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 include/linux/ckrm.h     |    7 ++++++
 init/main.c              |    2 +
 kernel/ckrm/ckrm.c       |   11 +++++++++
 kernel/ckrm/ckrm_local.h |    1 
 kernel/ckrm/ckrm_task.c  |   52 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/exit.c            |    2 +
 kernel/fork.c            |    2 +
 7 files changed, 77 insertions(+)

Index: linux2617-rc2/kernel/exit.c
===================================================================
--- linux2617-rc2.orig/kernel/exit.c
+++ linux2617-rc2/kernel/exit.c
@@ -35,6 +35,7 @@
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
+#include <linux/ckrm.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -731,6 +732,7 @@ static void exit_notify(struct task_stru
 	struct task_struct *t;
 	struct list_head ptrace_dead, *_p, *_n;
 
+	ckrm_clear_task(tsk);
 	if (signal_pending(tsk) && !(tsk->signal->flags & SIGNAL_GROUP_EXIT)
 	    && !thread_group_empty(tsk)) {
 		/*
Index: linux2617-rc2/kernel/fork.c
===================================================================
--- linux2617-rc2.orig/kernel/fork.c
+++ linux2617-rc2/kernel/fork.c
@@ -44,6 +44,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/ckrm.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1214,6 +1215,7 @@ static task_t *copy_process(unsigned lon
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+	ckrm_init_task(p);
 	proc_fork_connector(p);
 	return p;
 
Index: linux2617-rc2/init/main.c
===================================================================
--- linux2617-rc2.orig/init/main.c
+++ linux2617-rc2/init/main.c
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/ckrm.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -541,6 +542,7 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	cpuset_init();
+	ckrm_init();
 
 	check_bugs();
 
Index: linux2617-rc2/kernel/ckrm/ckrm.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm.c
+++ linux2617-rc2/kernel/ckrm/ckrm.c
@@ -231,6 +231,7 @@ int ckrm_free_class(struct ckrm_class *c
 		return -EBUSY;
 	}
 	spin_unlock(&class->class_lock);
+	ckrm_move_tasks_to_parent(class);
 	kref_put(&class->ref, ckrm_release_class);
 	return 0;
 }
@@ -391,6 +392,16 @@ void ckrm_teardown(void)
 	}
 }
 
+void ckrm_init(void)
+{
+	write_lock(&ckrm_class_lock);
+	list_add_tail(&ckrm_default_class.class_list, &ckrm_classes);
+	write_unlock(&ckrm_class_lock);
+	kref_init(&ckrm_default_class.ref);
+	init_task.class = &ckrm_default_class;
+	ckrm_init_task(&init_task);
+}
+
 EXPORT_SYMBOL_GPL(ckrm_register_controller);
 EXPORT_SYMBOL_GPL(ckrm_unregister_controller);
 EXPORT_SYMBOL_GPL(ckrm_alloc_class);
Index: linux2617-rc2/kernel/ckrm/ckrm_task.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_task.c
+++ linux2617-rc2/kernel/ckrm/ckrm_task.c
@@ -141,4 +141,56 @@ int ckrm_setclass(pid_t pid, struct ckrm
 	put_task_struct(tsk);
 	return rc;
 }
+
+void ckrm_init_task(struct task_struct *tsk)
+{
+	struct ckrm_class *class;
+
+	/*
+	 * processes inherit their class from their real parent, and
+	 * threads inherit class from their process.
+	 */
+	if (thread_group_leader(tsk))
+		class = tsk->real_parent->class;
+	else
+		class = tsk->group_leader->class;
+
+	tsk->class = CKRM_NO_CLASS;
+	INIT_LIST_HEAD(&tsk->member_list);
+
+	BUG_ON(class == NULL);
+	kref_get(&class->ref);
+	move_to_new_class(tsk, class);
+	notify_res_ctlrs(tsk, CKRM_NO_CLASS, class);
+}
+
+void ckrm_clear_task(struct task_struct *tsk)
+{
+	ckrm_setclass_internal(tsk, CKRM_NO_CLASS);
+}
+
+/*
+ * Move all tasks in the given class to its parent.
+ */
+void ckrm_move_tasks_to_parent(struct ckrm_class *class)
+{
+	kref_get(&class->ref);
+
+next_task:
+	spin_lock(&class->class_lock);
+	if (!list_empty(&class->task_list)) {
+		struct task_struct *tsk =
+			list_entry(class->task_list.next,
+				struct task_struct, member_list);
+		get_task_struct(tsk);
+		spin_unlock(&class->class_lock);
+		kref_get(&class->parent->ref);
+		ckrm_setclass_internal(tsk, class->parent);
+		put_task_struct(tsk);
+		goto next_task;
+	}
+	spin_unlock(&class->class_lock);
+	kref_put(&class->ref, ckrm_release_class);
+}
+
 EXPORT_SYMBOL_GPL(ckrm_setclass);
Index: linux2617-rc2/include/linux/ckrm.h
===================================================================
--- linux2617-rc2.orig/include/linux/ckrm.h
+++ linux2617-rc2/include/linux/ckrm.h
@@ -94,5 +94,12 @@ struct ckrm_class {
 	struct list_head children;	/* head of children */
 };
 
+extern void ckrm_init_task(struct task_struct *);
+extern void ckrm_clear_task(struct task_struct *);
+extern void ckrm_init(void);
+#else /* CONFIG_CKRM */
+static inline void ckrm_init_task(struct task_struct *tsk) { }
+static inline void ckrm_clear_task(struct task_struct *tsk) { }
+static inline void ckrm_init(void) { }
 #endif /* CONFIG_CKRM */
 #endif /* _LINUX_CKRM_H */
Index: linux2617-rc2/kernel/ckrm/ckrm_local.h
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_local.h
+++ linux2617-rc2/kernel/ckrm/ckrm_local.h
@@ -18,3 +18,4 @@ extern void ckrm_set_shares_to_default(s
 						struct ckrm_controller *);
 extern void ckrm_teardown(void);
 extern int ckrm_setclass(pid_t, struct ckrm_class *);
+extern void ckrm_move_tasks_to_parent(struct ckrm_class *);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
