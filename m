Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVFWH6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVFWH6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVFWHzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:55:11 -0400
Received: from [24.22.56.4] ([24.22.56.4]:11238 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262250AbVFWGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:40 -0400
Message-Id: <20050623061759.853524000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:20 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 28/38] CKRM e18: Cleanups to CKRM initialization
Content-Disposition: inline; filename=ckrm-inittask
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the CKRM initialization only if the Taskclass classtype is built 
and set the initial class of the init process.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm.c	2005-06-20 15:02:49.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm.c	2005-06-20 15:04:54.000000000 -0700
@@ -845,7 +845,10 @@ void __init ckrm_init(void)
 #ifdef CONFIG_CKRM_TYPE_TASKCLASS
 	{
 		extern void ckrm_meta_init_taskclass(void);
+		ckrm_cb_newtask(&init_task);
 		ckrm_meta_init_taskclass();
+		/* prepare init_task and then rely on inheritance
+		   of properties */
 	}
 #endif
 #ifdef CONFIG_CKRM_TYPE_SOCKETCLASS
@@ -854,8 +857,6 @@ void __init ckrm_init(void)
 		ckrm_meta_init_sockclass();
 	}
 #endif
-	/* prepare init_task and then rely on inheritance of properties */
-	ckrm_cb_newtask(&init_task);
 	printk("CKRM Initialization done\n");
 }
 
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_tc.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_tc.c	2005-06-20 15:02:49.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_tc.c	2005-06-20 15:04:54.000000000 -0700
@@ -35,6 +35,8 @@
 
 #include <linux/ckrm_tc.h>
 
+#define TASK_EXIT_CLASS ((void*)-1)
+
 static struct ckrm_task_class taskclass_dflt_class = {
 };
 
@@ -112,14 +114,15 @@ ckrm_set_taskclass(struct task_struct *t
 	spin_lock(&tsk->ckrm_tsklock);
 	curcls = tsk->taskclass;
 
-	if ((void *)-1 == curcls) {
+	if (TASK_EXIT_CLASS == curcls) {
 		/* task is disassociated from ckrm.  Don't bother it. */
 		spin_unlock(&tsk->ckrm_tsklock);
-		ckrm_core_drop(class_core(newcls));
+		if (newcls && (newcls != TASK_EXIT_CLASS))
+			ckrm_core_drop(class_core(newcls));
 		return;
 	}
 
-	if ((curcls == NULL) && (newcls == (void *)-1)) {
+	if ((curcls == NULL) && (newcls == TASK_EXIT_CLASS)) {
 		/*
 		 * Task needs to disassociated from ckrm and has no circles
 		 * just disassociate and return.
@@ -130,7 +133,7 @@ ckrm_set_taskclass(struct task_struct *t
 	}
 	if (oldcls && (oldcls != curcls)) {
 		spin_unlock(&tsk->ckrm_tsklock);
-		if (newcls) {
+		if (newcls && (newcls != TASK_EXIT_CLASS)) {
 			/* compensate for previous grab */
 			pr_debug("(%s:%d): Race-condition caught <%s> %d\n",
 				 tsk->comm, tsk->pid, class_core(newcls)->name,
@@ -140,7 +143,7 @@ ckrm_set_taskclass(struct task_struct *t
 		return;
 	}
 	/* Make sure we have a real destination core. */
-	if (!newcls) {
+	if (newcls == NULL) {
 		newcls = &taskclass_dflt_class;
 		ckrm_core_grab(class_core(newcls));
 	}
@@ -160,7 +163,7 @@ ckrm_set_taskclass(struct task_struct *t
 		INIT_LIST_HEAD(&tsk->taskclass_link);
 		tsk->taskclass = NULL;
 		class_unlock(class_core(curcls));
-		if (newcls == (void *)-1) {
+		if (newcls == TASK_EXIT_CLASS) {
 			tsk->taskclass = newcls;
 			spin_unlock(&tsk->ckrm_tsklock);
 
@@ -223,7 +226,7 @@ static void tc_add_resctrl(struct ckrm_c
 	class_lock(core);
 	list_for_each_entry(tsk, &core->objlist, taskclass_link) {
 		if (rcbs->change_resclass)
-			(*rcbs->change_resclass) (tsk, (void *)-1,
+			(*rcbs->change_resclass) (tsk, TASK_EXIT_CLASS,
 						  core->res_class[resid]);
 	}
 	class_unlock(core);
@@ -289,7 +292,7 @@ static void cb_taskclass_exit(void *tsk1
 	struct task_struct *tsk = (struct task_struct *)tsk1;
 
 	CE_CLASSIFY_NORET(&ct_taskclass, CKRM_EVENT_EXIT, tsk);
-	ckrm_set_taskclass(tsk, (void *)-1, NULL, CKRM_EVENT_EXIT);
+	ckrm_set_taskclass(tsk, TASK_EXIT_CLASS, NULL, CKRM_EVENT_EXIT);
 }
 
 static void cb_taskclass_exec(void *filename)
@@ -636,6 +639,9 @@ void __init ckrm_meta_init_taskclass(voi
 	 * note registeration of all resource controllers will be done
 	 * later dynamically as these are specified as modules
 	 */
+
+	/* prepare init_task and then rely on inheritance of properties */
+	ckrm_set_taskclass(&init_task, NULL, NULL, CKRM_EVENT_NEWTASK);
 }
 
 static int tc_show_members(struct ckrm_core_class *core, struct seq_file *seq)

--
