Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268050AbUHKM6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268050AbUHKM6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUHKM6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:58:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:30954 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268050AbUHKM6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:58:33 -0400
Date: Wed, 11 Aug 2004 18:41:55 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-ID: <20040811131155.GA4239@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Paul,

Considering that cpu_possible_map does not get fully initialized
until smp_prepare_cpus gets called by init(), I thought it right
to move cpuset_init() to after smp initialization. I tested it on
2.6.8-rc2-mm2 and it seemed to work ok.

Patch attached below

Regards,

Dinakar 

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>



--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuset-init.patch"

diff -Naurp linux-2.6.8-rc2-mm2-cs3/include/linux/cpuset.h linux-2.6.8-rc2-mm2-cs3.new/include/linux/cpuset.h
--- linux-2.6.8-rc2-mm2-cs3/include/linux/cpuset.h	2004-08-05 17:22:31.000000000 +0530
+++ linux-2.6.8-rc2-mm2-cs3.new/include/linux/cpuset.h	2004-08-10 22:58:23.000000000 +0530
@@ -14,6 +14,43 @@
 
 #ifdef CONFIG_CPUSETS
 
+struct cpuset {
+	unsigned long flags;		/* "unsigned long" so bitops work */
+	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
+	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
+
+	atomic_t count;			/* count tasks using this cpuset */
+
+	/*
+	 * We link our 'sibling' struct into our parents 'children'.
+	 * Our children link their 'sibling' into our 'children'.
+	 */
+	struct list_head sibling;	/* my parents children */
+	struct list_head children;	/* my children */
+
+	struct cpuset *parent;		/* my parent */
+	struct dentry *dentry;		/* cpuset fs entry */
+};
+
+/* bits in struct cpuset flags field */
+typedef enum {
+	CS_CPU_EXCLUSIVE,
+	CS_MEM_EXCLUSIVE,
+	CS_REMOVED,
+	CS_NOTIFY_ON_RELEASE
+} cpuset_flagbits_t;
+
+static struct cpuset top_cpuset = {
+	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
+	.cpus_allowed = CPU_MASK_ALL,
+	.mems_allowed = NODE_MASK_ALL,
+	.count = ATOMIC_INIT(0),
+	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
+	.children = LIST_HEAD_INIT(top_cpuset.children),
+	.parent = NULL,
+	.dentry = NULL,
+};
+
 extern int cpuset_init(void);
 extern void cpuset_fork(struct task_struct *p);
 extern void cpuset_exit(struct task_struct *p);
@@ -26,8 +63,14 @@ int cpuset_zonelist_valid_mems_allowed(s
 int cpuset_zone_allowed(struct zone *z);
 extern struct file_operations proc_cpuset_operations;
 
+#define INIT_TASK_CPUSET(tsk)	\
+	.cpuset = &top_cpuset,		\
+	.mems_allowed = NODE_MASK_ALL,
+
 #else /* !CONFIG_CPUSETS */
 
+#define INIT_TASK_CPUSET(tsk)
+
 static inline int cpuset_init(void) { return 0; }
 static inline void cpuset_fork(struct task_struct *p) {}
 static inline void cpuset_exit(struct task_struct *p) {}
diff -Naurp linux-2.6.8-rc2-mm2-cs3/include/linux/init_task.h linux-2.6.8-rc2-mm2-cs3.new/include/linux/init_task.h
--- linux-2.6.8-rc2-mm2-cs3/include/linux/init_task.h	2004-08-05 17:20:52.000000000 +0530
+++ linux-2.6.8-rc2-mm2-cs3.new/include/linux/init_task.h	2004-08-10 22:47:14.000000000 +0530
@@ -3,6 +3,7 @@
 
 #include <linux/file.h>
 #include <linux/pagg.h>
+#include <linux/cpuset.h>
 
 #define INIT_FILES \
 { 							\
@@ -114,6 +115,7 @@ extern struct group_info init_groups;
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
 	INIT_TASK_PAGG(tsk)						\
+	INIT_TASK_CPUSET(tsk)						\
 }
 
 
diff -Naurp linux-2.6.8-rc2-mm2-cs3/include/linux/pagg.h linux-2.6.8-rc2-mm2-cs3.new/include/linux/pagg.h
--- linux-2.6.8-rc2-mm2-cs3/include/linux/pagg.h	2004-08-05 17:20:52.000000000 +0530
+++ linux-2.6.8-rc2-mm2-cs3.new/include/linux/pagg.h	2004-08-10 20:12:45.000000000 +0530
@@ -183,7 +183,7 @@ static inline void pagg_exec(struct task
  */
 #define INIT_TASK_PAGG(tsk) \
 	.pagg_list = LIST_HEAD_INIT(tsk.pagg_list),     \
-	.pagg_sem  = __RWSEM_INITIALIZER(tsk.pagg_sem)
+	.pagg_sem  = __RWSEM_INITIALIZER(tsk.pagg_sem),
 
 #else  /* CONFIG_PAGG */
 
diff -Naurp linux-2.6.8-rc2-mm2-cs3/init/main.c linux-2.6.8-rc2-mm2-cs3.new/init/main.c
--- linux-2.6.8-rc2-mm2-cs3/init/main.c	2004-08-05 17:22:31.000000000 +0530
+++ linux-2.6.8-rc2-mm2-cs3.new/init/main.c	2004-08-11 21:50:24.970179272 +0530
@@ -569,8 +569,6 @@ asmlinkage void __init start_kernel(void
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
-	cpuset_init();
-
 	check_bugs();
 
 	/* Do the rest non-__init'ed, we're now alive */
@@ -708,6 +706,8 @@ static int init(void * unused)
 	smp_init();
 	sched_init_smp();
 
+	cpuset_init();
+	
 	/*
 	 * Do this before initcalls, because some drivers want to access
 	 * firmware files.
diff -Naurp linux-2.6.8-rc2-mm2-cs3/kernel/cpuset.c linux-2.6.8-rc2-mm2-cs3.new/kernel/cpuset.c
--- linux-2.6.8-rc2-mm2-cs3/kernel/cpuset.c	2004-08-11 22:02:47.077361832 +0530
+++ linux-2.6.8-rc2-mm2-cs3.new/kernel/cpuset.c	2004-08-11 22:01:07.416512584 +0530
@@ -54,32 +54,6 @@
 
 #define CPUSET_SUPER_MAGIC 		0x27e0eb
 
-struct cpuset {
-	unsigned long flags;		/* "unsigned long" so bitops work */
-	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
-	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
-
-	atomic_t count;			/* count tasks using this cpuset */
-
-	/*
-	 * We link our 'sibling' struct into our parents 'children'.
-	 * Our children link their 'sibling' into our 'children'.
-	 */
-	struct list_head sibling;	/* my parents children */
-	struct list_head children;	/* my children */
-
-	struct cpuset *parent;		/* my parent */
-	struct dentry *dentry;		/* cpuset fs entry */
-};
-
-/* bits in struct cpuset flags field */
-typedef enum {
-	CS_CPU_EXCLUSIVE,
-	CS_MEM_EXCLUSIVE,
-	CS_REMOVED,
-	CS_NOTIFY_ON_RELEASE
-} cpuset_flagbits_t;
-
 /* convenient tests for these bits */
 static inline int is_cpu_exclusive(const struct cpuset *cs)
 {
@@ -101,17 +75,6 @@ static inline int notify_on_release(cons
 	return !!test_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
 }
 
-static struct cpuset top_cpuset = {
-	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
-	.cpus_allowed = CPU_MASK_ALL,
-	.mems_allowed = NODE_MASK_ALL,
-	.count = ATOMIC_INIT(0),
-	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
-	.children = LIST_HEAD_INIT(top_cpuset.children),
-	.parent = NULL,
-	.dentry = NULL,
-};
-
 static struct vfsmount *cpuset_mount;
 static struct super_block *cpuset_sb = NULL;
 

--9amGYk9869ThD9tj--
