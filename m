Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUHIKPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUHIKPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUHIKPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:15:24 -0400
Received: from aun.it.uu.se ([130.238.12.36]:7627 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266450AbUHIKN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:13:57 -0400
Date: Mon, 9 Aug 2004 12:13:47 +0200 (MEST)
Message-Id: <200408091013.i79ADlXc012588@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc3-mm2] perfctr inheritance locking fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch eliminates the illegal task_lock() perfctr's
inheritance feature introduced in release_task().

- Changed __vperfctr_release() to use schedule_work() to do
  the task_lock(parent) etc in a different thread's context.
  This is because release_task() has a write lock on the
  task list lock, and task_lock() is forbidden in that case.
  When current == parent, this is bypassed and the merge work
  is done immediately without taking task_lock().
  Added children_lock to struct vperfctr, to synchronise
  accesses (release/update_control/read) to the children array.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 Documentation/perfctr/virtual.txt |   12 +---
 drivers/perfctr/version.h         |    2 
 drivers/perfctr/virtual.c         |   97 +++++++++++++++++++++++++-------------
 3 files changed, 70 insertions(+), 41 deletions(-)

diff -ruN linux-2.6.8-rc3-mm2/Documentation/perfctr/virtual.txt linux-2.6.8-rc3-mm2.perfctr-inheritance-fixes/Documentation/perfctr/virtual.txt
--- linux-2.6.8-rc3-mm2/Documentation/perfctr/virtual.txt	2004-08-09 01:16:37.000000000 +0200
+++ linux-2.6.8-rc3-mm2.perfctr-inheritance-fixes/Documentation/perfctr/virtual.txt	2004-08-09 10:59:46.000000000 +0200
@@ -1,4 +1,4 @@
-$Id: perfctr-documentation-update.patch,v 1.1 2004/07/12 05:41:57 akpm Exp $
+$Id: virtual.txt,v 1.3 2004/08/09 09:42:22 mikpe Exp $
 
 VIRTUAL PER-PROCESS PERFORMANCE COUNTERS
 ========================================
@@ -140,13 +140,9 @@
    before accessing the perfctr pointer.
 
 5. release_task().
-   While reaping a child, the kernel only takes the tasklist_lock to
-   prevent the parent from changing or disappearing. This does not
-   prevent the parent's perfctr state pointer from changing. Concurrent
-   accesses to the parent's "children counts" state are also possible.
-
-   To avoid these issues, perfctr_release_task() performs a task_lock()
-   on the parent.
+   Reaping a child may or may not be done by the parent of that child.
+   When done by the parent, no lock is taken. Otherwise, a task_lock()
+   on the parent is done before accessing its thread's perfctr pointer.
 
 The Pseudo File System
 ----------------------
diff -ruN linux-2.6.8-rc3-mm2/drivers/perfctr/version.h linux-2.6.8-rc3-mm2.perfctr-inheritance-fixes/drivers/perfctr/version.h
--- linux-2.6.8-rc3-mm2/drivers/perfctr/version.h	2004-08-09 01:16:38.000000000 +0200
+++ linux-2.6.8-rc3-mm2.perfctr-inheritance-fixes/drivers/perfctr/version.h	2004-08-09 10:59:46.000000000 +0200
@@ -1 +1 @@
-#define VERSION "2.7.4"
+#define VERSION "2.7.5"
diff -ruN linux-2.6.8-rc3-mm2/drivers/perfctr/virtual.c linux-2.6.8-rc3-mm2.perfctr-inheritance-fixes/drivers/perfctr/virtual.c
--- linux-2.6.8-rc3-mm2/drivers/perfctr/virtual.c	2004-08-09 01:16:38.000000000 +0200
+++ linux-2.6.8-rc3-mm2.perfctr-inheritance-fixes/drivers/perfctr/virtual.c	2004-08-09 10:59:46.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: virtual.c,v 1.95 2004/05/31 20:36:37 mikpe Exp $
+/* $Id: virtual.c,v 1.104 2004/08/09 09:42:22 mikpe Exp $
  * Virtual per-process performance counters.
  *
  * Copyright (C) 1999-2004  Mikael Pettersson
@@ -42,10 +42,15 @@
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 	unsigned int iresume_cstatus;
 #endif
-	/* protected by task_lock(owner) */
+	/* children_lock protects inheritance_id and children,
+	   when parent is not the one doing release_task() */
+	spinlock_t children_lock;
 	unsigned long long inheritance_id;
 	struct perfctr_sum_ctrs children;
-	struct work_struct free_work;
+	/* schedule_work() data for when an operation cannot be
+	   done in the current context due to locking rules */
+	struct work_struct work;
+	struct task_struct *parent_tsk;
 };
 #define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->cpu_state.cstatus)
 
@@ -170,8 +175,8 @@
 {
 	if (!atomic_dec_and_test(&perfctr->count))
 		return;
-	INIT_WORK(&perfctr->free_work, scheduled_vperfctr_free, perfctr);
-	schedule_work(&perfctr->free_work);
+	INIT_WORK(&perfctr->work, scheduled_vperfctr_free, perfctr);
+	schedule_work(&perfctr->work);
 }
 
 static unsigned long long new_inheritance_id(void)
@@ -365,39 +370,67 @@
  * A task is being released. If it inherited its perfctr settings
  * from its parent, then merge its final counts back into the parent.
  * Then unlink the child's perfctr.
- * PRE: caller holds tasklist_lock.
+ * PRE: caller has write_lock_irq(&tasklist_lock).
  * PREEMPT note: preemption is disabled due to tasklist_lock.
+ *
+ * When current == parent_tsk, the child's counts can be merged
+ * into the parent's immediately. This is the common case.
+ *
+ * When current != parent_tsk, the parent must be task_lock()ed
+ * before its perfctr state can be accessed. task_lock() is illegal
+ * here due to the write_lock_irq(&tasklist_lock) in release_task(),
+ * so the operation is done via schedule_work().
  */
-void __vperfctr_release(struct task_struct *child_tsk)
+static void do_vperfctr_release(struct vperfctr *child_perfctr, struct task_struct *parent_tsk)
 {
-	struct task_struct *parent_tsk;
 	struct vperfctr *parent_perfctr;
-	struct vperfctr *child_perfctr;
 	unsigned int cstatus, nrctrs, i;
 
-	/* Our caller holds tasklist_lock, protecting child_tsk->parent.
-	   We must also task_lock(child_tsk->parent), to prevent its
-	   ->thread.perfctr from changing. */
-	parent_tsk = child_tsk->parent;
-	task_lock(parent_tsk);
 	parent_perfctr = parent_tsk->thread.perfctr;
-	child_perfctr = child_tsk->thread.perfctr;
-	if (parent_perfctr && child_perfctr &&
-	    parent_perfctr->inheritance_id == child_perfctr->inheritance_id) {
-		cstatus = parent_perfctr->cpu_state.cstatus;
-		if (perfctr_cstatus_has_tsc(cstatus))
-			parent_perfctr->children.tsc +=
-				child_perfctr->cpu_state.tsc_sum +
-				child_perfctr->children.tsc;
-		nrctrs = perfctr_cstatus_nrctrs(cstatus);
-		for(i = 0; i < nrctrs; ++i)
-			parent_perfctr->children.pmc[i] +=
-				child_perfctr->cpu_state.pmc[i].sum +
-				child_perfctr->children.pmc[i];
+	if (parent_perfctr && child_perfctr) {
+		spin_lock(&parent_perfctr->children_lock);
+		if (parent_perfctr->inheritance_id == child_perfctr->inheritance_id) {
+			cstatus = parent_perfctr->cpu_state.cstatus;
+			if (perfctr_cstatus_has_tsc(cstatus))
+				parent_perfctr->children.tsc +=
+					child_perfctr->cpu_state.tsc_sum +
+					child_perfctr->children.tsc;
+			nrctrs = perfctr_cstatus_nrctrs(cstatus);
+			for(i = 0; i < nrctrs; ++i)
+				parent_perfctr->children.pmc[i] +=
+					child_perfctr->cpu_state.pmc[i].sum +
+					child_perfctr->children.pmc[i];
+		}
+		spin_unlock(&parent_perfctr->children_lock);
 	}
+	schedule_put_vperfctr(child_perfctr);
+}
+
+static void scheduled_release(void *data)
+{
+	struct vperfctr *child_perfctr = data;
+	struct task_struct *parent_tsk = child_perfctr->parent_tsk;
+
+	task_lock(parent_tsk);
+	do_vperfctr_release(child_perfctr, parent_tsk);
 	task_unlock(parent_tsk);
+	put_task_struct(parent_tsk);
+}
+
+void __vperfctr_release(struct task_struct *child_tsk)
+{
+	struct task_struct *parent_tsk = child_tsk->parent;
+	struct vperfctr *child_perfctr = child_tsk->thread.perfctr;
+
 	child_tsk->thread.perfctr = NULL;
-	schedule_put_vperfctr(child_perfctr);
+	if (parent_tsk == current)
+		do_vperfctr_release(child_perfctr, parent_tsk);
+	else {
+		get_task_struct(parent_tsk);
+		INIT_WORK(&child_perfctr->work, scheduled_release, child_perfctr);
+		child_perfctr->parent_tsk = parent_tsk;
+		schedule_work(&child_perfctr->work);
+	}
 }
 
 /* schedule() --> switch_to() --> .. --> __vperfctr_suspend().
@@ -543,10 +576,10 @@
 		if (!(control->preserve & (1<<i)))
 			perfctr->cpu_state.pmc[i].sum = 0;
 
-	task_lock(tsk);
+	spin_lock(&perfctr->children_lock);
 	perfctr->inheritance_id = new_inheritance_id();
 	memset(&perfctr->children, 0, sizeof perfctr->children);
-	task_unlock(tsk);
+	spin_unlock(&perfctr->children_lock);
 
 	if (tsk == current)
 		vperfctr_resume(perfctr);
@@ -647,10 +680,10 @@
 	}
 	if (childrenp) {
 		if (tsk)
-			task_lock(tsk);
+			spin_lock(&perfctr->children_lock);
 		tmp->children = perfctr->children;
 		if (tsk)
-			task_unlock(tsk);
+			spin_unlock(&perfctr->children_lock);
 	}
 	if (tsk == current)
 		preempt_enable();
