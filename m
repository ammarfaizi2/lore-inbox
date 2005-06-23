Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVFWHNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVFWHNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVFWHMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:12:25 -0400
Received: from [24.22.56.4] ([24.22.56.4]:31974 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262353AbVFWGTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:10 -0400
Message-Id: <20050623061755.039403000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:15:57 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>,
       Vivek Kashyap <vivk@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [patch 05/38] CKRM e18: Classtype definitions for task class
Content-Disposition: inline; filename=05-diff_taskclass
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch provides the extensions for CKRM to track task classes.
 This is the base to enable task class based resource control for
 cpu, memory and disk I/O.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


 fs/rcfs/Makefile        |    1 
 fs/rcfs/rootdir.c       |   12 
 fs/rcfs/tc_magic.c      |   93 +++++
 include/linux/ckrm_tc.h |   46 ++
 include/linux/sched.h   |   11 
 init/Kconfig            |   12 
 kernel/ckrm/Makefile    |    1 
 kernel/ckrm/ckrm_tc.c   |  745 ++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 915 insertions(+), 6 deletions(-)

Index: linux-2.6.12-ckrm1/fs/rcfs/Makefile
===================================================================
--- linux-2.6.12-ckrm1.orig/fs/rcfs/Makefile	2005-06-20 13:08:30.000000000 -0700
+++ linux-2.6.12-ckrm1/fs/rcfs/Makefile	2005-06-20 13:08:31.000000000 -0700
@@ -5,3 +5,4 @@
 obj-$(CONFIG_RCFS_FS) += rcfs.o
 
 rcfs-y := super.o inode.o dir.o rootdir.o magic.o
+rcfs-$(CONFIG_CKRM_TYPE_TASKCLASS) += tc_magic.o
Index: linux-2.6.12-ckrm1/fs/rcfs/rootdir.c
===================================================================
--- linux-2.6.12-ckrm1.orig/fs/rcfs/rootdir.c	2005-06-20 13:08:30.000000000 -0700
+++ linux-2.6.12-ckrm1/fs/rcfs/rootdir.c	2005-06-20 13:08:31.000000000 -0700
@@ -58,7 +58,7 @@ int rcfs_unregister_engine(struct rbce_e
 	return 0;
 }
 
-EXPORT_SYMBOL(rcfs_unregister_engine);
+EXPORT_SYMBOL_GPL(rcfs_unregister_engine);
 
 /*
  * rcfs_mkroot
@@ -183,6 +183,10 @@ int rcfs_deregister_classtype(struct ckr
 
 EXPORT_SYMBOL_GPL(rcfs_deregister_classtype);
 
+#ifdef CONFIG_CKRM_TYPE_TASKCLASS
+extern struct rcfs_mfdesc tc_mfdesc;
+#endif
+
 /* Common root and magic file entries.
  * root name, root permissions, magic file names and magic file permissions
  * are needed by all entities (classtypes and classification engines) existing
@@ -193,6 +197,10 @@ EXPORT_SYMBOL_GPL(rcfs_deregister_classt
  * table to initialize their magf entries.
  */
 
-struct rcfs_mfdesc *genmfdesc[] = {
+struct rcfs_mfdesc *genmfdesc[CKRM_MAX_CLASSTYPES] = {
+#ifdef CONFIG_CKRM_TYPE_TASKCLASS
+	&tc_mfdesc,
+#else
 	NULL,
+#endif
 };
Index: linux-2.6.12-ckrm1/fs/rcfs/tc_magic.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/fs/rcfs/tc_magic.c	2005-06-20 13:08:31.000000000 -0700
@@ -0,0 +1,93 @@
+/*
+ * fs/rcfs/tc_magic.c
+ *
+ * Copyright (C) Shailabh Nagar,      IBM Corp. 2004
+ *           (C) Vivek Kashyap,       IBM Corp. 2004
+ *           (C) Chandra Seetharaman, IBM Corp. 2004
+ *           (C) Hubertus Franke,     IBM Corp. 2004
+ *
+ * define magic fileops for taskclass classtype
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/rcfs.h>
+#include <linux/ckrm_tc.h>
+
+/*
+ * Taskclass general
+ *
+ * Define structures for taskclass root directory and its magic files
+ * In taskclasses, there is one set of magic files, created automatically under
+ * the taskclass root (upon classtype registration) and each directory (class)
+ * created subsequently. However, classtypes can also choose to have different
+ * sets of magic files created under their root and other directories under
+ * root using their mkdir function. RCFS only provides helper functions for
+ * creating the root directory and its magic files
+ *
+ */
+
+#define TC_FILE_MODE (S_IFREG | S_IRUGO | S_IWUSR)
+
+#define NR_TCROOTMF  7
+struct rcfs_magf tc_rootdesc[NR_TCROOTMF] = {
+	/* First entry must be root */
+	{
+	/* .name = should not be set, copy from classtype name */
+	 .mode = RCFS_DEFAULT_DIR_MODE,
+	 .i_op = &rcfs_dir_inode_operations,
+	 .i_fop = &simple_dir_operations,
+	 },
+	/* Rest are root's magic files */
+	{
+	 .name = "target",
+	 .mode = TC_FILE_MODE,
+	 .i_fop = &target_fileops,
+	 .i_op = &rcfs_file_inode_operations,
+	 },
+	{
+	 .name = "members",
+	 .mode = TC_FILE_MODE,
+	 .i_fop = &members_fileops,
+	 .i_op = &rcfs_file_inode_operations,
+	 },
+	{
+	 .name = "stats",
+	 .mode = TC_FILE_MODE,
+	 .i_fop = &stats_fileops,
+	 .i_op = &rcfs_file_inode_operations,
+	 },
+	{
+	 .name = "shares",
+	 .mode = TC_FILE_MODE,
+	 .i_fop = &shares_fileops,
+	 .i_op = &rcfs_file_inode_operations,
+	 },
+	/*
+	 * Reclassify and Config should be made available only at the
+	 * root level. Make sure they are the last two entries, as
+	 * rcfs_mkdir depends on it.
+	 */
+	{
+	 .name = "reclassify",
+	 .mode = TC_FILE_MODE,
+	 .i_fop = &reclassify_fileops,
+	 .i_op = &rcfs_file_inode_operations,
+	 },
+	{
+	 .name = "config",
+	 .mode = TC_FILE_MODE,
+	 .i_fop = &config_fileops,
+	 .i_op = &rcfs_file_inode_operations,
+	 },
+};
+
+struct rcfs_mfdesc tc_mfdesc = {
+	.rootmf = tc_rootdesc,
+	.rootmflen = NR_TCROOTMF,
+};
Index: linux-2.6.12-ckrm1/include/linux/ckrm_tc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/include/linux/ckrm_tc.h	2005-06-20 13:08:31.000000000 -0700
@@ -0,0 +1,46 @@
+/* ckrm_tc.h - Header file to be used by task class users
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
+ *
+ * Provides data structures, macros and kernel API for the
+ * classtype, taskclass.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#ifndef _LINUX_CKRM_TC_H_
+#define _LINUX_CKRM_TC_H_
+
+#ifdef CONFIG_CKRM_TYPE_TASKCLASS
+#include <linux/ckrm_rc.h>
+
+#define TASK_CLASS_TYPE_NAME "taskclass"
+
+struct ckrm_task_class {
+	struct ckrm_core_class core;
+};
+
+/*
+ * Index into genmfdesc array, defined in rcfs/dir_modules.c,
+ * which has the mfdesc entry that taskclass wants to use.
+ */
+#define TC_MF_IDX  0
+
+extern int ckrm_forced_reclassify_pid(int, struct ckrm_task_class *);
+
+#else /* CONFIG_CKRM_TYPE_TASKCLASS */
+
+#define ckrm_forced_reclassify_pid(a, b) (0)
+
+#endif
+
+#endif /* _LINUX_CKRM_TC_H_ */
Index: linux-2.6.12-ckrm1/include/linux/sched.h
===================================================================
--- linux-2.6.12-ckrm1.orig/include/linux/sched.h	2005-06-20 13:08:29.000000000 -0700
+++ linux-2.6.12-ckrm1/include/linux/sched.h	2005-06-20 13:08:31.000000000 -0700
@@ -741,14 +741,17 @@ struct task_struct {
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
-#ifdef CONFIG_DELAY_ACCT
-	struct task_delay_info delays;
-#endif
 #ifdef CONFIG_CKRM
 	spinlock_t  ckrm_tsklock;
 	void       *ce_data;
+#ifdef CONFIG_CKRM_TYPE_TASKCLASS
+	struct ckrm_task_class *taskclass;
+	struct list_head taskclass_link;
+#endif /* CONFIG_CKRM_TYPE_TASKCLASS */
+#endif /* CONFIG_CKRM */
+#ifdef CONFIG_DELAY_ACCT
+	struct task_delay_info delays;
 #endif
-
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: linux-2.6.12-ckrm1/init/Kconfig
===================================================================
--- linux-2.6.12-ckrm1.orig/init/Kconfig	2005-06-20 13:08:30.000000000 -0700
+++ linux-2.6.12-ckrm1/init/Kconfig	2005-06-20 13:08:31.000000000 -0700
@@ -170,6 +170,18 @@ config RCFS_FS
 
 	  Say M if unsure, Y to save on module loading. N doesn't make sense
 	  when CKRM has been configured.
+
+config CKRM_TYPE_TASKCLASS
+	bool "Class Manager for Task Groups"
+	depends on CKRM && RCFS_FS
+	default y
+	help
+	  TASKCLASS provides the extensions for CKRM to track task classes
+	  This is the base to enable task class based resource control for
+	  cpu, memory and disk I/O.
+
+	  Say Y if unsure
+
 endmenu
 
 config SYSCTL
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_tc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_tc.c	2005-06-20 13:08:31.000000000 -0700
@@ -0,0 +1,745 @@
+/* ckrm_tc.c - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003,2004
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ *           (C) Chandra Seetharaman,  IBM Corp. 2003
+ *	     (C) Vivek Kashyap,	IBM Corp. 2004
+ *
+ *
+ * Provides kernel API of CKRM for in-kernel,per-resource controllers
+ * (one each for cpu, memory, io, network) and callbacks for
+ * classification modules.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <linux/mm.h>
+#include <asm/errno.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/ckrm_rc.h>
+
+#include <linux/ckrm_tc.h>
+
+static struct ckrm_task_class taskclass_dflt_class = {
+};
+
+const char *dflt_taskclass_name = TASK_CLASS_TYPE_NAME;
+
+static struct ckrm_core_class *ckrm_alloc_task_class(struct ckrm_core_class
+						     *parent, const char *name);
+static int ckrm_free_task_class(struct ckrm_core_class *core);
+
+static int tc_forced_reclassify(struct ckrm_core_class * target,
+				const char *resname);
+static int tc_show_members(struct ckrm_core_class *core, struct seq_file *seq);
+static void tc_add_resctrl(struct ckrm_core_class *core, int resid);
+
+struct ckrm_classtype ct_taskclass = {
+	.mfidx = TC_MF_IDX,
+	.name = TASK_CLASS_TYPE_NAME,
+	.type_id = CKRM_CLASSTYPE_TASK_CLASS,
+	.maxdepth = 3,		/* starting point */
+	.resid_reserved = 4,
+	.max_res_ctlrs = CKRM_MAX_RES_CTLRS,
+	.max_resid = 0,
+	.bit_res_ctlrs = 0L,
+	.res_ctlrs_lock = SPIN_LOCK_UNLOCKED,
+	.classes = LIST_HEAD_INIT(ct_taskclass.classes),
+
+	.default_class = &taskclass_dflt_class.core,
+
+	/* private version of functions */
+	.alloc = &ckrm_alloc_task_class,
+	.free = &ckrm_free_task_class,
+	.show_members = &tc_show_members,
+	.forced_reclassify = &tc_forced_reclassify,
+
+	/* use of default functions */
+	.show_shares = &ckrm_class_show_shares,
+	.show_stats = &ckrm_class_show_stats,
+	.show_config = &ckrm_class_show_config,
+	.set_config = &ckrm_class_set_config,
+	.set_shares = &ckrm_class_set_shares,
+	.reset_stats = &ckrm_class_reset_stats,
+
+	/* mandatory private version; no default available */
+	.add_resctrl = &tc_add_resctrl,
+};
+
+/*
+ * Change the task class of the given task.
+ *
+ * Change the task's task class  to "newcls" if the task's current
+ * class (task->taskclass) is same as given "oldcls", if it is non-NULL.
+ *
+ * Caller is responsible to make sure the task structure stays put through
+ * this function.
+ *
+ * This function should be called with the following locks NOT held
+ * 	- tsk->ckrm_tsklock
+ * 	- core->ckrm_lock, if core is NULL then ckrm_dflt_class.ckrm_lock
+ * 	- tsk->taskclass->ckrm_lock
+ *
+ * Function is also called with a ckrm_core_grab on the new core, hence
+ * it needs to be dropped if no assignment takes place.
+ */
+static void
+ckrm_set_taskclass(struct task_struct *tsk, struct ckrm_task_class *newcls,
+		   struct ckrm_task_class *oldcls, enum ckrm_event event)
+{
+	int i;
+	struct ckrm_classtype *clstype;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_task_class *curcls;
+	void *old_res_class, *new_res_class;
+	int drop_old_cls;
+
+	spin_lock(&tsk->ckrm_tsklock);
+	curcls = tsk->taskclass;
+
+	if ((void *)-1 == curcls) {
+		/* task is disassociated from ckrm.  Don't bother it. */
+		spin_unlock(&tsk->ckrm_tsklock);
+		ckrm_core_drop(class_core(newcls));
+		return;
+	}
+
+	if ((curcls == NULL) && (newcls == (void *)-1)) {
+		/*
+		 * Task needs to disassociated from ckrm and has no circles
+		 * just disassociate and return.
+		 */
+		tsk->taskclass = newcls;
+		spin_unlock(&tsk->ckrm_tsklock);
+		return;
+	}
+	if (oldcls && (oldcls != curcls)) {
+		spin_unlock(&tsk->ckrm_tsklock);
+		if (newcls) {
+			/* compensate for previous grab */
+			pr_debug("(%s:%d): Race-condition caught <%s> %d\n",
+				 tsk->comm, tsk->pid, class_core(newcls)->name,
+				 event);
+			ckrm_core_drop(class_core(newcls));
+		}
+		return;
+	}
+	/* Make sure we have a real destination core. */
+	if (!newcls) {
+		newcls = &taskclass_dflt_class;
+		ckrm_core_grab(class_core(newcls));
+	}
+	/* Take out of old class and drop the oldcore. */
+	if ((drop_old_cls = (curcls != NULL))) {
+		class_lock(class_core(curcls));
+		if (newcls == curcls) {
+			/*
+			 * We are already in the destination class.
+			 * we still need to drop oldcore.
+			 */
+			class_unlock(class_core(curcls));
+			spin_unlock(&tsk->ckrm_tsklock);
+			goto out;
+		}
+		list_del(&tsk->taskclass_link);
+		INIT_LIST_HEAD(&tsk->taskclass_link);
+		tsk->taskclass = NULL;
+		class_unlock(class_core(curcls));
+		if (newcls == (void *)-1) {
+			tsk->taskclass = newcls;
+			spin_unlock(&tsk->ckrm_tsklock);
+
+			/* still need to get out of old class. */
+			newcls = NULL;
+			goto rc_handling;
+		}
+	}
+	/* put into new class */
+	class_lock(class_core(newcls));
+	tsk->taskclass = newcls;
+	list_add(&tsk->taskclass_link, &class_core(newcls)->objlist);
+	class_unlock(class_core(newcls));
+
+	if (newcls == curcls) {
+		spin_unlock(&tsk->ckrm_tsklock);
+		goto out;
+	}
+
+	CE_NOTIFY(&ct_taskclass, event, newcls, tsk);
+
+	spin_unlock(&tsk->ckrm_tsklock);
+
+      rc_handling:
+	clstype = &ct_taskclass;
+	if (clstype->bit_res_ctlrs) {
+		/* avoid running through the entire list if none are registered */
+		for (i = 0; i < clstype->max_resid; i++) {
+			if (clstype->res_ctlrs[i] == NULL)
+				continue;
+			atomic_inc(&clstype->nr_resusers[i]);
+			old_res_class =
+			    curcls ? class_core(curcls)->res_class[i] : NULL;
+			new_res_class =
+			    newcls ? class_core(newcls)->res_class[i] : NULL;
+			rcbs = clstype->res_ctlrs[i];
+			if (rcbs && rcbs->change_resclass
+			    && (old_res_class != new_res_class))
+				(*rcbs->change_resclass) (tsk, old_res_class,
+							  new_res_class);
+			atomic_dec(&clstype->nr_resusers[i]);
+		}
+	}
+
+      out:
+	if (drop_old_cls)
+		ckrm_core_drop(class_core(curcls));
+	return;
+}
+
+static void tc_add_resctrl(struct ckrm_core_class *core, int resid)
+{
+	struct task_struct *tsk;
+	struct ckrm_res_ctlr *rcbs;
+
+	if ((resid < 0) || (resid >= CKRM_MAX_RES_CTLRS)
+	    || ((rcbs = core->classtype->res_ctlrs[resid]) == NULL))
+		return;
+
+	class_lock(core);
+	list_for_each_entry(tsk, &core->objlist, taskclass_link) {
+		if (rcbs->change_resclass)
+			(*rcbs->change_resclass) (tsk, (void *)-1,
+						  core->res_class[resid]);
+	}
+	class_unlock(core);
+}
+
+/**************************************************************************
+ *                   Functions called from classification points          *
+ **************************************************************************/
+
+#define CE_CLASSIFY_TASK(event, tsk)					\
+do {									\
+	struct ckrm_task_class *newcls = NULL;				\
+ 	struct ckrm_task_class *oldcls = tsk->taskclass;		\
+									\
+	CE_CLASSIFY_RET(newcls,&ct_taskclass,event,tsk);		\
+	if (newcls) {							\
+		/* called synchrously. no need to get task struct */	\
+		ckrm_set_taskclass(tsk, newcls, oldcls, event);		\
+	}								\
+} while (0)
+
+
+#define CE_CLASSIFY_TASK_PROTECT(event, tsk)	\
+do {						\
+	ce_protect(&ct_taskclass);		\
+	CE_CLASSIFY_TASK(event,tsk);		\
+	ce_release(&ct_taskclass);              \
+} while (0)
+
+static void cb_taskclass_newtask(struct task_struct *tsk)
+{
+	tsk->taskclass = NULL;
+	INIT_LIST_HEAD(&tsk->taskclass_link);
+}
+
+static void cb_taskclass_fork(struct task_struct *tsk)
+{
+	struct ckrm_task_class *cls = NULL;
+
+	pr_debug("%p:%d:%s\n", tsk, tsk->pid, tsk->comm);
+
+	ce_protect(&ct_taskclass);
+	CE_CLASSIFY_RET(cls, &ct_taskclass, CKRM_EVENT_FORK, tsk);
+	if (cls == NULL) {
+		spin_lock(&tsk->parent->ckrm_tsklock);
+		cls = tsk->parent->taskclass;
+		ckrm_core_grab(class_core(cls));
+		spin_unlock(&tsk->parent->ckrm_tsklock);
+	}
+	if (!list_empty(&tsk->taskclass_link))
+		pr_debug("cb_taskclass_fork: BUG in cb_fork.. tsk (%s:%d> already linked\n",
+		       tsk->comm, tsk->pid);
+
+	ckrm_set_taskclass(tsk, cls, NULL, CKRM_EVENT_FORK);
+	ce_release(&ct_taskclass);
+}
+
+static void cb_taskclass_exit(struct task_struct *tsk)
+{
+	CE_CLASSIFY_NORET(&ct_taskclass, CKRM_EVENT_EXIT, tsk);
+	ckrm_set_taskclass(tsk, (void *)-1, NULL, CKRM_EVENT_EXIT);
+}
+
+static void cb_taskclass_exec(const char *filename)
+{
+	pr_debug("%p:%d:%s <%s>\n", current, current->pid, current->comm,
+		   filename);
+	CE_CLASSIFY_TASK_PROTECT(CKRM_EVENT_EXEC, current);
+}
+
+static void cb_taskclass_uid(void)
+{
+	pr_debug("%p:%d:%s\n", current, current->pid, current->comm);
+	CE_CLASSIFY_TASK_PROTECT(CKRM_EVENT_UID, current);
+}
+
+static void cb_taskclass_gid(void)
+{
+	pr_debug("%p:%d:%s\n", current, current->pid, current->comm);
+	CE_CLASSIFY_TASK_PROTECT(CKRM_EVENT_GID, current);
+}
+
+static struct ckrm_event_spec taskclass_events_callbacks[] = {
+	{CKRM_EVENT_NEWTASK, { cb_taskclass_newtask, NULL}},
+	{CKRM_EVENT_EXEC, { cb_taskclass_exec, NULL }},
+	{CKRM_EVENT_FORK, { cb_taskclass_fork, NULL }},
+	{CKRM_EVENT_EXIT, { cb_taskclass_exit, NULL }},
+	{CKRM_EVENT_UID, { cb_taskclass_uid, NULL }},
+	{CKRM_EVENT_GID, { cb_taskclass_gid, NULL }},
+	{-1, { -1, NULL }}
+};
+
+/*
+ * Asynchronous callback functions   (driven by RCFS)
+ *
+ *    Async functions force a setting of the task structure
+ *    synchronous callbacks are protected against race conditions
+ *    by using a cmpxchg on the core before setting it.
+ *    Async calls need to be serialized to ensure they can't
+ *    race against each other
+ */
+
+static DECLARE_MUTEX(ckrm_async_serializer);	/* serialize all async functions */
+
+/*
+ * Go through the task list and reclassify all tasks according to the current
+ * classification rules.
+ *
+ * We have the problem that we can not hold any lock (including the
+ * tasklist_lock) while classifying. Two methods possible
+ *
+ * (a) go through entire pidrange (0..pidmax) and if a task exists at
+ *     that pid then reclassify it
+ * (b) go several time through task list and build a bitmap for a particular
+ *     subrange of pid otherwise the memory requirements ight be too much.
+ *
+ * We use a hybrid by comparing ratio nr_threads/pidmax
+ */
+
+static int ckrm_reclassify_all_tasks(void)
+{
+	extern int pid_max;
+
+	struct task_struct *proc, *thread;
+	int i;
+	int curpidmax = pid_max;
+	int ratio;
+	int use_bitmap;
+
+	/* Check permissions */
+	if ((!capable(CAP_SYS_NICE)) && (!capable(CAP_SYS_RESOURCE))) {
+		return -EPERM;
+	}
+
+	ratio = curpidmax / nr_threads;
+	if (curpidmax <= PID_MAX_DEFAULT) {
+		use_bitmap = 1;
+	} else {
+		use_bitmap = (ratio >= 2);
+	}
+
+	ce_protect(&ct_taskclass);
+
+      retry:
+
+	if (use_bitmap == 0) {
+		/* Go through it in one walk. */
+		read_lock(&tasklist_lock);
+		for (i = 0; i < curpidmax; i++) {
+			if ((thread = find_task_by_pid(i)) == NULL)
+				continue;
+			get_task_struct(thread);
+			read_unlock(&tasklist_lock);
+			CE_CLASSIFY_TASK(CKRM_EVENT_RECLASSIFY, thread);
+			put_task_struct(thread);
+			read_lock(&tasklist_lock);
+		}
+		read_unlock(&tasklist_lock);
+	} else {
+		unsigned long *bitmap;
+		int bitmapsize;
+		int order = 0;
+		int num_loops;
+		int pid, do_next;
+
+		bitmap = (unsigned long *)__get_free_pages(GFP_KERNEL, order);
+		if (bitmap == NULL) {
+			use_bitmap = 0;
+			goto retry;
+		}
+
+		bitmapsize = 8 * (1 << (order + PAGE_SHIFT));
+		num_loops = (curpidmax + bitmapsize - 1) / bitmapsize;
+
+		do_next = 1;
+		for (i = 0; i < num_loops && do_next; i++) {
+			int pid_start = i * bitmapsize;
+			int pid_end = pid_start + bitmapsize;
+			int num_found = 0;
+			int pos;
+
+			memset(bitmap, 0, bitmapsize / 8);	/* start afresh */
+			do_next = 0;
+
+			read_lock(&tasklist_lock);
+			do_each_thread(proc, thread) {
+				pid = thread->pid;
+				if ((pid < pid_start) || (pid >= pid_end)) {
+					if (pid >= pid_end) {
+						do_next = 1;
+					}
+					continue;
+				}
+				pid -= pid_start;
+				set_bit(pid, bitmap);
+				num_found++;
+			}
+			while_each_thread(proc, thread);
+			read_unlock(&tasklist_lock);
+
+			if (num_found == 0)
+				continue;
+
+			pos = 0;
+			for (; num_found--;) {
+				pos = find_next_bit(bitmap, bitmapsize, pos);
+				pid = pos + pid_start;
+
+				read_lock(&tasklist_lock);
+				if ((thread = find_task_by_pid(pid)) != NULL) {
+					get_task_struct(thread);
+					read_unlock(&tasklist_lock);
+					CE_CLASSIFY_TASK(CKRM_EVENT_RECLASSIFY,
+							 thread);
+					put_task_struct(thread);
+				} else {
+					read_unlock(&tasklist_lock);
+				}
+				pos++;
+			}
+		}
+
+	}
+	ce_release(&ct_taskclass);
+	return 0;
+}
+
+/*
+ * Reclassify all tasks in the given core class.
+ */
+
+static void ckrm_reclassify_class_tasks(struct ckrm_task_class *cls)
+{
+	int ce_regd;
+	struct ckrm_hnode *cnode;
+	struct ckrm_task_class *parcls;
+	int num = 0;
+
+	if (!ckrm_validate_and_grab_core(&cls->core))
+		return;
+
+	down(&ckrm_async_serializer);
+	pr_debug("start %p:%s:%d:%d\n", cls, cls->core.name,
+		 atomic_read(&cls->core.refcnt),
+		 atomic_read(&cls->core.hnode.parent->refcnt));
+	/*
+	 * If no CE registered for this classtype, following will be needed
+	 * repeatedly.
+	 */
+	ce_regd = atomic_read(&class_core(cls)->classtype->ce_regd);
+	cnode = &(class_core(cls)->hnode);
+	parcls = class_type(struct ckrm_task_class, cnode->parent);
+
+      next_task:
+	class_lock(class_core(cls));
+	if (!list_empty(&class_core(cls)->objlist)) {
+		struct ckrm_task_class *newcls = NULL;
+		struct task_struct *tsk =
+		    list_entry(class_core(cls)->objlist.next,
+			       struct task_struct, taskclass_link);
+
+		get_task_struct(tsk);
+		class_unlock(class_core(cls));
+
+		if (ce_regd) {
+			CE_CLASSIFY_RET(newcls, &ct_taskclass,
+					CKRM_EVENT_RECLASSIFY, tsk);
+			if (cls == newcls) {
+				/*
+				 * Don't allow reclassifying to the same class
+				 * as we are in the process of cleaning up
+				 * this class
+				 */
+
+				/* compensate for CE's grab */
+				ckrm_core_drop(class_core(newcls));
+				newcls = NULL;
+			}
+		}
+		if (newcls == NULL) {
+			newcls = parcls;
+			ckrm_core_grab(class_core(newcls));
+		}
+		ckrm_set_taskclass(tsk, newcls, cls, CKRM_EVENT_RECLASSIFY);
+		put_task_struct(tsk);
+		num++;
+		goto next_task;
+	}
+	pr_debug("stop  %p:%s:%d:%d   %d\n", cls, cls->core.name,
+		 atomic_read(&cls->core.refcnt),
+		 atomic_read(&cls->core.hnode.parent->refcnt), num);
+	class_unlock(class_core(cls));
+	ckrm_core_drop(class_core(cls));
+
+	up(&ckrm_async_serializer);
+
+	return;
+}
+
+/*
+ * Change the core class of the given task
+ */
+
+int ckrm_forced_reclassify_pid(pid_t pid, struct ckrm_task_class *cls)
+{
+	struct task_struct *tsk;
+
+	if (cls && !ckrm_validate_and_grab_core(class_core(cls)))
+		return -EINVAL;
+
+	read_lock(&tasklist_lock);
+	if ((tsk = find_task_by_pid(pid)) == NULL) {
+		read_unlock(&tasklist_lock);
+		if (cls)
+			ckrm_core_drop(class_core(cls));
+		return -EINVAL;
+	}
+	get_task_struct(tsk);
+	read_unlock(&tasklist_lock);
+
+	/* Check permissions */
+	if ((!capable(CAP_SYS_NICE)) &&
+	    (!capable(CAP_SYS_RESOURCE)) && (current->user != tsk->user)) {
+		if (cls)
+			ckrm_core_drop(class_core(cls));
+		put_task_struct(tsk);
+		return -EPERM;
+	}
+
+	ce_protect(&ct_taskclass);
+	if (cls == NULL)
+		CE_CLASSIFY_TASK(CKRM_EVENT_RECLASSIFY,tsk);
+	else
+		ckrm_set_taskclass(tsk, cls, NULL, CKRM_EVENT_MANUAL);
+
+	ce_release(&ct_taskclass);
+	put_task_struct(tsk);
+
+	return 0;
+}
+
+static struct ckrm_core_class *ckrm_alloc_task_class(struct ckrm_core_class
+						     *parent, const char *name)
+{
+	struct ckrm_task_class *taskcls;
+	taskcls = kmalloc(sizeof(struct ckrm_task_class), GFP_KERNEL);
+	if (taskcls == NULL)
+		return NULL;
+	memset(taskcls, 0, sizeof(struct ckrm_task_class));
+
+	ckrm_init_core_class(&ct_taskclass, class_core(taskcls), parent, name);
+
+	ce_protect(&ct_taskclass);
+	if (ct_taskclass.ce_cb_active && ct_taskclass.ce_callbacks.class_add)
+		(*ct_taskclass.ce_callbacks.class_add) (name, taskcls,
+							ct_taskclass.type_id);
+	ce_release(&ct_taskclass);
+
+	return class_core(taskcls);
+}
+
+static int ckrm_free_task_class(struct ckrm_core_class *core)
+{
+	struct ckrm_task_class *taskcls;
+
+	if (!ckrm_is_core_valid(core)) {
+		return (-EINVAL);		/* Invalid core */
+	}
+	if (core == core->classtype->default_class) {
+		/* reset the name tag */
+		core->name = dflt_taskclass_name;
+		return 0;
+	}
+
+	pr_debug("%p:%s:%d\n", core, core->name, atomic_read(&core->refcnt));
+
+	taskcls = class_type(struct ckrm_task_class, core);
+
+	ce_protect(&ct_taskclass);
+
+	if (ct_taskclass.ce_cb_active && ct_taskclass.ce_callbacks.class_delete)
+		(*ct_taskclass.ce_callbacks.class_delete) (core->name, taskcls,
+							   ct_taskclass.type_id);
+	ckrm_reclassify_class_tasks(taskcls);
+
+	ce_release(&ct_taskclass);
+
+	ckrm_release_core_class(core);
+	return 0;
+}
+
+void __init ckrm_meta_init_taskclass(void)
+{
+	pr_debug("...... Initializing ClassType<%s> ........\n",
+	       ct_taskclass.name);
+	/* intialize the default class */
+	ckrm_init_core_class(&ct_taskclass, class_core(&taskclass_dflt_class),
+			     NULL, dflt_taskclass_name);
+
+	/* register classtype and initialize default task class */
+	ckrm_register_classtype(&ct_taskclass);
+	ckrm_register_event_set(taskclass_events_callbacks);
+
+	/*
+	 * note registeration of all resource controllers will be done
+	 * later dynamically as these are specified as modules
+	 */
+}
+
+static int tc_show_members(struct ckrm_core_class *core, struct seq_file *seq)
+{
+	struct list_head *lh;
+	struct task_struct *tsk;
+
+	class_lock(core);
+	list_for_each(lh, &core->objlist) {
+		tsk = container_of(lh, struct task_struct, taskclass_link);
+		seq_printf(seq, "%ld\n", (long)tsk->pid);
+	}
+	class_unlock(core);
+
+	return 0;
+}
+
+static int tc_forced_reclassify(struct ckrm_core_class *target, const char *obj)
+{
+	pid_t pid;
+	int rc = -EINVAL;
+
+	pid = (pid_t) simple_strtol(obj, NULL, 0);
+
+	down(&ckrm_async_serializer);	/* protect against race with reclassify_class */
+	if (pid < 0) {
+		/* TBD: We could treat this as a process group. */
+		rc = -EINVAL;
+	} else if (pid == 0) {
+		rc = (target == NULL) ? ckrm_reclassify_all_tasks() : -EINVAL;
+	} else {
+		struct ckrm_task_class *cls = NULL;
+		if (target)
+			cls = class_type(struct ckrm_task_class, target);
+		rc = ckrm_forced_reclassify_pid(pid,cls);
+	}
+	up(&ckrm_async_serializer);
+	return rc;
+}
+
+#if 0
+
+/******************************************************************************
+ * Debugging Task Classes:  Utility functions
+ ******************************************************************************/
+
+void check_tasklist_sanity(struct ckrm_task_class *cls)
+{
+	struct ckrm_core_class *core = class_core(cls);
+	struct list_head *lh1, *lh2;
+	int count = 0;
+
+	if (core) {
+		class_lock(core);
+		if (list_empty(&core->objlist)) {
+			class_lock(core);
+			pr_debug("check_tasklist_sanity: class %s empty list\n",
+			       core->name);
+			return;
+		}
+		list_for_each_safe(lh1, lh2, &core->objlist) {
+			struct task_struct *tsk =
+			    container_of(lh1, struct task_struct,
+					 taskclass_link);
+			if (count++ > 20000) {
+				pr_debug("check_tasklist_sanity: CKRM taskclass list is CORRUPTED\n");
+				break;
+			}
+			if (tsk->taskclass != cls) {
+				const char *tclsname;
+				tclsname = (tsk->taskclass) ?
+					class_core(tsk->taskclass)->name:"NULL";
+				pr_debug("sanity: task %s:%d has ckrm_core "
+				       "|%s| but in list |%s|\n", tsk->comm,
+				       tsk->pid, tclsname, core->name);
+			}
+		}
+		class_unlock(core);
+	}
+}
+
+void ckrm_debug_free_task_class(struct ckrm_task_class *tskcls)
+{
+	struct task_struct *proc, *thread;
+	int count = 0;
+
+	pr_debug("ckrm_debug_free_task_class: Analyze Error <%s> %d\n",
+	       class_core(tskcls)->name,
+	       atomic_read(&(class_core(tskcls)->refcnt)));
+
+	read_lock(&tasklist_lock);
+	class_lock(class_core(tskcls));
+	do_each_thread(proc, thread) {
+		count += (tskcls == thread->taskclass);
+		if ((thread->taskclass == tskcls) || (tskcls == NULL)) {
+			const char *tclsname;
+			tclsname = (thread->taskclass) ?
+				class_core(thread->taskclass)->name :"NULL";
+			pr_debug("ckrm-debug_free_task_class: %d thread=<%s:%d>  -> <%s> <%lx>\n", count,
+			       thread->comm, thread->pid, tclsname,
+			       thread->flags & PF_EXITING);
+		}
+	} while_each_thread(proc, thread);
+	class_unlock(class_core(tskcls));
+	read_unlock(&tasklist_lock);
+
+	pr_debug("ckrm_debug_free_task_class: End Analyze Error <%s> %d\n",
+	       class_core(tskcls)->name,
+	       atomic_read(&(class_core(tskcls)->refcnt)));
+}
+
+#endif
Index: linux-2.6.12-ckrm1/kernel/ckrm/Makefile
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/Makefile	2005-06-20 13:08:29.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/Makefile	2005-06-20 13:08:31.000000000 -0700
@@ -3,3 +3,4 @@
 #
 
 obj-y += ckrm_events.o ckrm.o ckrmutils.o
+obj-$(CONFIG_CKRM_TYPE_TASKCLASS) += ckrm_tc.o

--
