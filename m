Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVLJIT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVLJIT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVLJIT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:19:29 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19929 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964969AbVLJITZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:25 -0500
Date: Sat, 10 Dec 2005 00:19:16 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081916.12303.8253.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 06/10] Cpuset: implement cpuset_mems_allowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a cpuset_mems_allowed() method, which the sys_migrate_pages()
code needed, to obtain the mems_allowed vector of a cpuset, and
replaced the workaround in sys_migrate_pages() to call this new
method.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/cpuset.h |    8 +++++++-
 kernel/cpuset.c        |   29 ++++++++++++++++++++++++++---
 mm/mempolicy.c         |    3 ---
 3 files changed, 33 insertions(+), 7 deletions(-)

--- 2.6.15-rc3-mm1.orig/include/linux/cpuset.h	2005-12-07 23:34:04.173695910 -0800
+++ 2.6.15-rc3-mm1/include/linux/cpuset.h	2005-12-07 23:36:26.159621364 -0800
@@ -18,7 +18,8 @@ extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
 extern void cpuset_exit(struct task_struct *p);
-extern cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
+extern cpumask_t cpuset_cpus_allowed(struct task_struct *p);
+extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 void cpuset_update_task_memory_state(void);
 #define cpuset_nodes_subset_current_mems_allowed(nodes) \
@@ -50,6 +51,11 @@ static inline cpumask_t cpuset_cpus_allo
 	return cpu_possible_map;
 }
 
+static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
+{
+	return node_possible_map;
+}
+
 static inline void cpuset_init_current_mems_allowed(void) {}
 static inline void cpuset_update_task_memory_state(void) {}
 #define cpuset_nodes_subset_current_mems_allowed(nodes) (1)
--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-07 23:35:54.229585036 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-07 23:36:26.164504230 -0800
@@ -1871,14 +1871,14 @@ void cpuset_exit(struct task_struct *tsk
  * tasks cpuset.
  **/
 
-cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
+cpumask_t cpuset_cpus_allowed(struct task_struct *tsk)
 {
 	cpumask_t mask;
 
 	down(&callback_sem);
-	task_lock((struct task_struct *)tsk);
+	task_lock(tsk);
 	guarantee_online_cpus(tsk->cpuset, &mask);
-	task_unlock((struct task_struct *)tsk);
+	task_unlock(tsk);
 	up(&callback_sem);
 
 	return mask;
@@ -1890,6 +1890,29 @@ void cpuset_init_current_mems_allowed(vo
 }
 
 /**
+ * cpuset_mems_allowed - return mems_allowed mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->mems_allowed.
+ *
+ * Description: Returns the nodemask_t mems_allowed of the cpuset
+ * attached to the specified @tsk.  Guaranteed to return some non-empty
+ * subset of node_online_map, even if this means going outside the
+ * tasks cpuset.
+ **/
+
+nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
+{
+	nodemask_t mask;
+
+	down(&callback_sem);
+	task_lock(tsk);
+	guarantee_online_mems(tsk->cpuset, &mask);
+	task_unlock(tsk);
+	up(&callback_sem);
+
+	return mask;
+}
+
+/**
  * cpuset_zonelist_valid_mems_allowed - check zonelist vs. curremt mems_allowed
  * @zl: the zonelist to be checked
  *
--- 2.6.15-rc3-mm1.orig/mm/mempolicy.c	2005-12-07 23:34:04.182485069 -0800
+++ 2.6.15-rc3-mm1/mm/mempolicy.c	2005-12-07 23:36:26.168410523 -0800
@@ -774,9 +774,6 @@ asmlinkage long sys_set_mempolicy(int mo
 	return do_set_mempolicy(mode, &nodes);
 }
 
-/* Macro needed until Paul implements this function in kernel/cpusets.c */
-#define cpuset_mems_allowed(task) node_online_map
-
 asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
 		const unsigned long __user *old_nodes,
 		const unsigned long __user *new_nodes)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
