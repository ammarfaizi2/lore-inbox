Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUGQJnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUGQJnh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 05:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUGQJnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 05:43:37 -0400
Received: from aun.it.uu.se ([130.238.12.36]:35231 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266674AbUGQJnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 05:43:22 -0400
Date: Sat, 17 Jul 2004 11:43:11 +0200 (MEST)
Message-Id: <200407170943.i6H9hB4C015575@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] perfctr inheritance 1/3: driver updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[repost, seems 1st try didn't make it to LKML]

- Bump driver version to 2.7.4
- Add children counts & control inheritance id to per-process perfctr state
- Drop vperfctr_task_lock() wrapper, always use task_lock() now
- Add copy_thread() callback to inherit perfctr settings from parent to child
- Add release_task() callback to merge final counts back to parent
- Extend sys_vperfctr_read() to allow reading children counts

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/version.h |    2 
 drivers/perfctr/virtual.c |  177 ++++++++++++++++++++++++++++++++++------------
 include/linux/perfctr.h   |   20 +++--
 3 files changed, 150 insertions(+), 49 deletions(-)

diff -ruN linux-2.6.8-rc1-mm1/drivers/perfctr/version.h linux-2.6.8-rc1-mm1.perfctr-inheritance/drivers/perfctr/version.h
--- linux-2.6.8-rc1-mm1/drivers/perfctr/version.h	2004-07-14 12:59:21.000000000 +0200
+++ linux-2.6.8-rc1-mm1.perfctr-inheritance/drivers/perfctr/version.h	2004-07-17 00:28:21.832314000 +0200
@@ -1 +1 @@
-#define VERSION "2.7.3"
+#define VERSION "2.7.4"
diff -ruN linux-2.6.8-rc1-mm1/drivers/perfctr/virtual.c linux-2.6.8-rc1-mm1.perfctr-inheritance/drivers/perfctr/virtual.c
--- linux-2.6.8-rc1-mm1/drivers/perfctr/virtual.c	2004-07-14 12:59:21.000000000 +0200
+++ linux-2.6.8-rc1-mm1.perfctr-inheritance/drivers/perfctr/virtual.c	2004-07-17 00:28:21.832314000 +0200
@@ -42,6 +42,9 @@
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 	unsigned int iresume_cstatus;
 #endif
+	/* protected by task_lock(owner) */
+	unsigned long long inheritance_id;
+	struct perfctr_sum_ctrs children;
 };
 #define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->cpu_state.cstatus)
 
@@ -71,37 +74,8 @@
 	atomic_set(&perfctr->bad_cpus_allowed, 0);
 }
 
-/* Concurrent set_cpus_allowed() is possible. The only lock it
-   can take is the task lock, so we have to take it as well.
-   task_lock/unlock also disables/enables preemption. */
-
-static inline void vperfctr_task_lock(struct task_struct *p)
-{
-	task_lock(p);
-}
-
-static inline void vperfctr_task_unlock(struct task_struct *p)
-{
-	task_unlock(p);
-}
-
 #else	/* !CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK */
-
 static inline void vperfctr_init_bad_cpus_allowed(struct vperfctr *perfctr) { }
-
-/* Concurrent set_cpus_allowed() is impossible or irrelevant.
-   Disabling and enabling preemption suffices for an atomic region. */
-
-static inline void vperfctr_task_lock(struct task_struct *p)
-{
-	preempt_disable();
-}
-
-static inline void vperfctr_task_unlock(struct task_struct *p)
-{
-	preempt_enable();
-}
-
 #endif	/* !CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK */
 
 /****************************************************************
@@ -186,6 +160,18 @@
 		vperfctr_free(perfctr);
 }
 
+static unsigned long long new_inheritance_id(void)
+{
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static unsigned long long counter;
+	unsigned long long id;
+
+	spin_lock(&lock);
+	id = ++counter;
+	spin_unlock(&lock);
+	return id;
+}
+
 /****************************************************************
  *								*
  * Basic counter operations.					*
@@ -282,12 +268,59 @@
  *								*
  ****************************************************************/
 
+/* do_fork() -> copy_process() -> copy_thread() -> __vperfctr_copy().
+ * Inherit the parent's perfctr settings to the child.
+ * PREEMPT note: do_fork() etc do not run with preemption disabled.
+*/
+void __vperfctr_copy(struct task_struct *child_tsk, struct pt_regs *regs)
+{
+	struct vperfctr *parent_perfctr;
+	struct vperfctr *child_perfctr;
+
+	/* Do not inherit perfctr settings to kernel-generated
+	   threads, like those created by kmod. */
+	child_perfctr = NULL;
+	if (!user_mode(regs))
+		goto out;
+
+	/* Allocation may sleep. Do it before the critical region. */
+	child_perfctr = get_empty_vperfctr();
+	if (IS_ERR(child_perfctr)) {
+		child_perfctr = NULL;
+		goto out;
+	}
+
+	/* Although we're executing in the parent, if it is scheduled
+	   then a remote monitor may attach and change the perfctr
+	   pointer or the object it points to. This may already have
+	   occurred when we get here, so the old copy of the pointer
+	   in the child cannot be trusted. */
+	preempt_disable();
+	parent_perfctr = current->thread.perfctr;
+	if (parent_perfctr) {
+		child_perfctr->cpu_state.control = parent_perfctr->cpu_state.control;
+		child_perfctr->si_signo = parent_perfctr->si_signo;
+		child_perfctr->inheritance_id = parent_perfctr->inheritance_id;
+	}
+	preempt_enable();
+	if (!parent_perfctr) {
+		put_vperfctr(child_perfctr);
+		child_perfctr = NULL;
+		goto out;
+	}
+	(void)perfctr_cpu_update_control(&child_perfctr->cpu_state, 0);
+	child_perfctr->owner = child_tsk;
+ out:
+	child_tsk->thread.perfctr = child_perfctr;
+}
+
 /* Called from exit_thread() or do_vperfctr_unlink().
  * If the counters are running, stop them and sample their final values.
- * Detach the vperfctr object from its owner task.
+ * Mark the vperfctr object as dead.
+ * Optionally detach the vperfctr object from its owner task.
  * PREEMPT note: exit_thread() does not run with preemption disabled.
  */
-static void vperfctr_unlink(struct task_struct *owner, struct vperfctr *perfctr)
+static void vperfctr_unlink(struct task_struct *owner, struct vperfctr *perfctr, int do_unlink)
 {
 	/* this synchronises with sys_vperfctr() */
 	spin_lock(&perfctr->owner_lock);
@@ -296,20 +329,61 @@
 
 	/* perfctr suspend+detach must be atomic wrt process suspend */
 	/* this also synchronises with perfctr_set_cpus_allowed() */
-	vperfctr_task_lock(owner);
+	task_lock(owner);
 	if (IS_RUNNING(perfctr) && owner == current)
 		vperfctr_suspend(perfctr);
-	owner->thread.perfctr = NULL;
-	vperfctr_task_unlock(owner);
+	if (do_unlink)
+		owner->thread.perfctr = NULL;
+	task_unlock(owner);
 
 	perfctr->cpu_state.cstatus = 0;
 	vperfctr_clear_iresume_cstatus(perfctr);
-	put_vperfctr(perfctr);
+	if (do_unlink)
+		put_vperfctr(perfctr);
 }
 
 void __vperfctr_exit(struct vperfctr *perfctr)
 {
-	vperfctr_unlink(current, perfctr);
+	vperfctr_unlink(current, perfctr, 0);
+}
+
+/* release_task() -> perfctr_release_task() -> __vperfctr_release().
+ * A task is being released. If it inherited its perfctr settings
+ * from its parent, then merge its final counts back into the parent.
+ * Then unlink the child's perfctr.
+ * PRE: caller holds tasklist_lock.
+ * PREEMPT note: preemption is disabled due to tasklist_lock.
+ */
+void __vperfctr_release(struct task_struct *child_tsk)
+{
+	struct task_struct *parent_tsk;
+	struct vperfctr *parent_perfctr;
+	struct vperfctr *child_perfctr;
+	unsigned int cstatus, nrctrs, i;
+
+	/* Our caller holds tasklist_lock, protecting child_tsk->parent.
+	   We must also task_lock(child_tsk->parent), to prevent its
+	   ->thread.perfctr from changing. */
+	parent_tsk = child_tsk->parent;
+	task_lock(parent_tsk);
+	parent_perfctr = parent_tsk->thread.perfctr;
+	child_perfctr = child_tsk->thread.perfctr;
+	if (parent_perfctr && child_perfctr &&
+	    parent_perfctr->inheritance_id == child_perfctr->inheritance_id) {
+		cstatus = parent_perfctr->cpu_state.cstatus;
+		if (perfctr_cstatus_has_tsc(cstatus))
+			parent_perfctr->children.tsc +=
+				child_perfctr->cpu_state.tsc_sum +
+				child_perfctr->children.tsc;
+		nrctrs = perfctr_cstatus_nrctrs(cstatus);
+		for(i = 0; i < nrctrs; ++i)
+			parent_perfctr->children.pmc[i] +=
+				child_perfctr->cpu_state.pmc[i].sum +
+				child_perfctr->children.pmc[i];
+	}
+	task_unlock(parent_tsk);
+	child_tsk->thread.perfctr = NULL;
+	put_vperfctr(child_perfctr);
 }
 
 /* schedule() --> switch_to() --> .. --> __vperfctr_suspend().
@@ -455,6 +529,11 @@
 		if (!(control->preserve & (1<<i)))
 			perfctr->cpu_state.pmc[i].sum = 0;
 
+	task_lock(tsk);
+	perfctr->inheritance_id = new_inheritance_id();
+	memset(&perfctr->children, 0, sizeof perfctr->children);
+	task_unlock(tsk);
+
 	if (tsk == current)
 		vperfctr_resume(perfctr);
 
@@ -504,22 +583,24 @@
 static int do_vperfctr_unlink(struct vperfctr *perfctr, struct task_struct *tsk)
 {
 	if (tsk)
-		vperfctr_unlink(tsk, perfctr);
+		vperfctr_unlink(tsk, perfctr, 1);
 	return 0;
 }
 
 static int do_vperfctr_read(struct vperfctr *perfctr,
 			    struct perfctr_sum_ctrs __user *sump,
 			    struct vperfctr_control __user *controlp,
-			    const struct task_struct *tsk)
+			    struct perfctr_sum_ctrs __user *childrenp,
+			    struct task_struct *tsk)
 {
 	struct {
 		struct perfctr_sum_ctrs sum;
 		struct vperfctr_control control;
+		struct perfctr_sum_ctrs children;
 	} *tmp;
 	int ret;
 
-	/* The state snapshot can be large (almost 500 bytes on i386),
+	/* The state snapshot can be large (more than 600 bytes on i386),
 	   so kmalloc() it instead of storing it on the stack.
 	   We must use task-private storage to prevent racing with a
 	   monitor process attaching to us during the preemptible
@@ -550,6 +631,13 @@
 		tmp->control.cpu_control = perfctr->cpu_state.control;
 		tmp->control.preserve = 0;
 	}
+	if (childrenp) {
+		if (tsk)
+			task_lock(tsk);
+		tmp->children = perfctr->children;
+		if (tsk)
+			task_unlock(tsk);
+	}
 	if (tsk == current)
 		preempt_enable();
 	ret = -EFAULT;
@@ -557,6 +645,8 @@
 		goto out;
 	if (controlp && copy_to_user(controlp, &tmp->control, sizeof tmp->control))
 		goto out;
+	if (childrenp && copy_to_user(childrenp, &tmp->children, sizeof tmp->children))
+		goto out;
 	ret = 0;
  out:
 	kfree(tmp);
@@ -777,14 +867,14 @@
 	}
 	if (creat) {
 		/* check+install must be atomic to prevent remote-control races */
-		vperfctr_task_lock(tsk);
+		task_lock(tsk);
 		if (!tsk->thread.perfctr) {
 			perfctr->owner = tsk;
 			tsk->thread.perfctr = perfctr;
 			err = 0;
 		} else
 			err = -EEXIST;
-		vperfctr_task_unlock(tsk);
+		task_unlock(tsk);
 		if (err)
 			goto err_tsk;
 	} else {
@@ -932,7 +1022,8 @@
 
 asmlinkage long sys_vperfctr_read(int fd,
 				  struct perfctr_sum_ctrs __user *sum,
-				  struct vperfctr_control __user *control)
+				  struct vperfctr_control __user *control,
+				  struct perfctr_sum_ctrs __user *children)
 {
 	struct vperfctr *perfctr;
 	struct task_struct *tsk;
@@ -946,7 +1037,7 @@
 		ret = PTR_ERR(tsk);
 		goto out;
 	}
-	ret = do_vperfctr_read(perfctr, sum, control, tsk);
+	ret = do_vperfctr_read(perfctr, sum, control, children, tsk);
 	vperfctr_put_tsk(tsk);
  out:
 	put_vperfctr(perfctr);
diff -ruN linux-2.6.8-rc1-mm1/include/linux/perfctr.h linux-2.6.8-rc1-mm1.perfctr-inheritance/include/linux/perfctr.h
--- linux-2.6.8-rc1-mm1/include/linux/perfctr.h	2004-07-14 12:59:21.000000000 +0200
+++ linux-2.6.8-rc1-mm1.perfctr-inheritance/include/linux/perfctr.h	2004-07-17 00:28:21.832314000 +0200
@@ -76,7 +76,8 @@
 asmlinkage long sys_vperfctr_iresume(int fd);
 asmlinkage long sys_vperfctr_read(int fd,
 				  struct perfctr_sum_ctrs __user*,
-				  struct vperfctr_control __user*);
+				  struct vperfctr_control __user*,
+				  struct perfctr_sum_ctrs __user*);
 
 extern struct perfctr_info perfctr_info;
 
@@ -88,16 +89,24 @@
 struct vperfctr;	/* opaque */
 
 /* process management operations */
-extern struct vperfctr *__vperfctr_copy(struct vperfctr*);
+extern void __vperfctr_copy(struct task_struct*, struct pt_regs*);
+extern void __vperfctr_release(struct task_struct*);
 extern void __vperfctr_exit(struct vperfctr*);
 extern void __vperfctr_suspend(struct vperfctr*);
 extern void __vperfctr_resume(struct vperfctr*);
 extern void __vperfctr_sample(struct vperfctr*);
 extern void __vperfctr_set_cpus_allowed(struct task_struct*, struct vperfctr*, cpumask_t);
 
-static inline void perfctr_copy_thread(struct thread_struct *thread)
+static inline void perfctr_copy_task(struct task_struct *tsk, struct pt_regs *regs)
 {
-	thread->perfctr = NULL;
+	if (tsk->thread.perfctr)
+		__vperfctr_copy(tsk, regs);
+}
+
+static inline void perfctr_release_task(struct task_struct *tsk)
+{
+	if (tsk->thread.perfctr)
+		__vperfctr_release(tsk);
 }
 
 static inline void perfctr_exit_thread(struct thread_struct *thread)
@@ -147,7 +156,8 @@
 
 #else	/* !CONFIG_PERFCTR_VIRTUAL */
 
-static inline void perfctr_copy_thread(struct thread_struct *t) { }
+static inline void perfctr_copy_task(struct task_struct *p, struct pt_regs *r) { }
+static inline void perfctr_release_task(struct task_struct *p) { }
 static inline void perfctr_exit_thread(struct thread_struct *t) { }
 static inline void perfctr_suspend_thread(struct thread_struct *t) { }
 static inline void perfctr_resume_thread(struct thread_struct *t) { }
