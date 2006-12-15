Return-Path: <linux-kernel-owner+w=401wt.eu-S1751737AbWLOA0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWLOA0z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWLOAXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:23:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:36268 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbWLOAXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:23:40 -0500
Message-Id: <20061215000818.705095000@us.ibm.com>
References: <20061215000754.764718000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:07:58 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>
Subject: Register cpuset task watcher
Content-Disposition: inline; filename=task-watchers-register-cpusets
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register a task watcher for cpusets instead of hooking into
copy_process() and do_exit() directly.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>
---
 include/linux/cpuset.h |    4 ----
 kernel/cpuset.c        |   11 +++++++++--
 kernel/exit.c          |    2 --
 kernel/fork.c          |    6 +-----
 4 files changed, 10 insertions(+), 13 deletions(-)

Index: linux-2.6.19/kernel/fork.c
===================================================================
--- linux-2.6.19.orig/kernel/fork.c
+++ linux-2.6.19/kernel/fork.c
@@ -28,11 +28,10 @@
 #include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
-#include <linux/cpuset.h>
 #include <linux/security.h>
 #include <linux/swap.h>
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
 #include <linux/futex.h>
@@ -1060,17 +1059,16 @@ static struct task_struct *copy_process(
 		p->tgid = current->tgid;
 
 	retval = notify_task_watchers(WATCH_TASK_INIT, clone_flags, p);
 	if (retval < 0)
 		goto bad_fork_cleanup_delays_binfmt;
-	cpuset_fork(p);
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
  		retval = PTR_ERR(p->mempolicy);
  		p->mempolicy = NULL;
- 		goto bad_fork_cleanup_cpuset;
+ 		goto bad_fork_cleanup_delays_binfmt;
  	}
 	mpol_fix_fork_child_flag(p);
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	p->irq_events = 0;
@@ -1279,13 +1277,11 @@ bad_fork_cleanup_files:
 bad_fork_cleanup_security:
 	security_task_free(p);
 bad_fork_cleanup_policy:
 #ifdef CONFIG_NUMA
 	mpol_free(p->mempolicy);
-bad_fork_cleanup_cpuset:
 #endif
-	cpuset_exit(p);
 bad_fork_cleanup_delays_binfmt:
 	delayacct_tsk_free(p);
 	notify_task_watchers(WATCH_TASK_FREE, 0, p);
 	if (p->binfmt)
 		module_put(p->binfmt->module);
Index: linux-2.6.19/kernel/cpuset.c
===================================================================
--- linux-2.6.19.orig/kernel/cpuset.c
+++ linux-2.6.19/kernel/cpuset.c
@@ -47,10 +47,11 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/backing-dev.h>
 #include <linux/sort.h>
+#include <linux/init.h>
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
 #include <linux/mutex.h>
 
@@ -2173,17 +2174,20 @@ void __init cpuset_init_smp(void)
  *
  * At the point that cpuset_fork() is called, 'current' is the parent
  * task, and the passed argument 'child' points to the child task.
  **/
 
-void cpuset_fork(struct task_struct *child)
+static int __task_init cpuset_fork(unsigned long clone_flags,
+				    struct task_struct *child)
 {
 	task_lock(current);
 	child->cpuset = current->cpuset;
 	atomic_inc(&child->cpuset->count);
 	task_unlock(current);
+	return 0;
 }
+DEFINE_TASK_INITCALL(cpuset_fork);
 
 /**
  * cpuset_exit - detach cpuset from exiting task
  * @tsk: pointer to task_struct of exiting process
  *
@@ -2240,11 +2244,12 @@ void cpuset_fork(struct task_struct *chi
  *    to NULL here, and check in cpuset_update_task_memory_state()
  *    for a NULL pointer.  This hack avoids that NULL check, for no
  *    cost (other than this way too long comment ;).
  **/
 
-void cpuset_exit(struct task_struct *tsk)
+static int __task_free cpuset_exit(unsigned long exit_code,
+				    struct task_struct *tsk)
 {
 	struct cpuset *cs;
 
 	cs = tsk->cpuset;
 	tsk->cpuset = &top_cpuset;	/* the_top_cpuset_hack - see above */
@@ -2258,11 +2263,13 @@ void cpuset_exit(struct task_struct *tsk
 		mutex_unlock(&manage_mutex);
 		cpuset_release_agent(pathbuf);
 	} else {
 		atomic_dec(&cs->count);
 	}
+	return 0;
 }
+DEFINE_TASK_FREECALL(cpuset_exit);
 
 /**
  * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
  * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
  *
Index: linux-2.6.19/kernel/exit.c
===================================================================
--- linux-2.6.19.orig/kernel/exit.c
+++ linux-2.6.19/kernel/exit.c
@@ -28,11 +28,10 @@
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
 #include <linux/taskstats_kern.h>
 #include <linux/delayacct.h>
-#include <linux/cpuset.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
 #include <linux/posix-timers.h>
 #include <linux/cn_proc.h>
 #include <linux/mutex.h>
@@ -918,11 +917,10 @@ fastcall NORET_TYPE void do_exit(long co
 	if (group_dead)
 		acct_process();
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_thread();
-	cpuset_exit(tsk);
 	exit_keys(tsk);
 
 	if (group_dead && tsk->signal->leader)
 		disassociate_ctty(1);
 
Index: linux-2.6.19/include/linux/cpuset.h
===================================================================
--- linux-2.6.19.orig/include/linux/cpuset.h
+++ linux-2.6.19/include/linux/cpuset.h
@@ -17,12 +17,10 @@
 extern int number_of_cpusets;	/* How many cpusets are defined in system? */
 
 extern int cpuset_init_early(void);
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
-extern void cpuset_fork(struct task_struct *p);
-extern void cpuset_exit(struct task_struct *p);
 extern cpumask_t cpuset_cpus_allowed(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 void cpuset_update_task_memory_state(void);
 #define cpuset_nodes_subset_current_mems_allowed(nodes) \
@@ -68,12 +66,10 @@ extern void cpuset_track_online_nodes(vo
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
 static inline int cpuset_init(void) { return 0; }
 static inline void cpuset_init_smp(void) {}
-static inline void cpuset_fork(struct task_struct *p) {}
-static inline void cpuset_exit(struct task_struct *p) {}
 
 static inline cpumask_t cpuset_cpus_allowed(struct task_struct *p)
 {
 	return cpu_possible_map;
 }

--
