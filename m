Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753097AbWKCE1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbWKCE1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbWKCE1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:27:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:35781 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753079AbWKCE1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:27:52 -0500
Message-Id: <20061103042749.061929000@us.ibm.com>
References: <20061103042257.274316000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 02 Nov 2006 20:23:00 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/9] Task Watchers v2: Register semundo task watcher
Content-Disposition: inline; filename=task-watchers-register-semundo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the semaphore undo code use a task watcher instead of hooking into
copy_process() and do_exit() directly.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 include/linux/sem.h |   17 -----------------
 ipc/sem.c           |   12 ++++++++----
 kernel/exit.c       |    3 ---
 kernel/fork.c       |    6 +-----
 4 files changed, 9 insertions(+), 29 deletions(-)

Benchmark results:
System: 4 1.7GHz ppc64 (Power 4+) processors, 30968600MB RAM, 2.6.19-rc2-mm2 kernel

Clone	Number of Children Cloned
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17960.5 	18169.3 	18408.2 	18479.9 	18515.6 	18465.4
Dev	305.381 	314.209 	292.395 	284.992 	299.331 	295.311
Err (%)	1.70029 	1.72934 	1.5884 		1.54217 	1.61664 	1.59927

Fork	Number of Children Forked
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	18050.2 	18141.4 	18316.2 	18386.2 	18441.9 	18476.2
Dev	295.68	 	312.922 	296.962 	298.81 		300.985 	294.046
Err (%)	1.63809 	1.72491 	1.62131 	1.62519 	1.63207 	1.59149

Kernbench:
Elapsed: 124.272s User: 439.643s System: 46.32s CPU: 390.5%
439.64user 46.25system 2:04.46elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.70user 46.27system 2:04.04elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.64user 46.31system 2:04.18elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.49user 46.27system 2:04.41elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.55user 46.47system 2:04.32elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.77user 46.29system 2:04.63elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.61user 46.31system 2:04.09elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.68user 46.31system 2:04.02elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.76user 46.49system 2:04.59elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.59user 46.23system 2:03.98elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k

Index: linux-2.6.19-rc2-mm2/ipc/sem.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/ipc/sem.c
+++ linux-2.6.19-rc2-mm2/ipc/sem.c
@@ -81,10 +81,11 @@
 #include <linux/audit.h>
 #include <linux/capability.h>
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/nsproxy.h>
+#include <linux/task_watchers.h>
 
 #include <asm/uaccess.h>
 #include "util.h"
 
 #define sem_ids(ns)	(*((ns)->ids[IPC_SEM_IDS]))
@@ -1288,11 +1289,11 @@ asmlinkage long sys_semop (int semid, st
  * See the notes above unlock_semundo() regarding the spin_lock_init()
  * in this code.  Initialize the undo_list->lock here instead of get_undo_list()
  * because of the reasoning in the comment above unlock_semundo.
  */
 
-int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct sem_undo_list *undo_list;
 	int error;
 
 	if (clone_flags & CLONE_SYSVSEM) {
@@ -1304,10 +1305,11 @@ int copy_semundo(unsigned long clone_fla
 	} else 
 		tsk->sysvsem.undo_list = NULL;
 
 	return 0;
 }
+task_watcher_func(init, copy_semundo);
 
 /*
  * add semadj values to semaphores, free undo structures.
  * undo structures are not freed when semaphore arrays are destroyed
  * so some of them may be out of date.
@@ -1317,22 +1319,22 @@ int copy_semundo(unsigned long clone_fla
  * should we queue up and wait until we can do so legally?
  * The original implementation attempted to do this (queue and wait).
  * The current implementation does not do so. The POSIX standard
  * and SVID should be consulted to determine what behavior is mandated.
  */
-void exit_sem(struct task_struct *tsk)
+static int exit_sem(unsigned long ignored, struct task_struct *tsk)
 {
 	struct sem_undo_list *undo_list;
 	struct sem_undo *u, **up;
 	struct ipc_namespace *ns;
 
 	undo_list = tsk->sysvsem.undo_list;
 	if (!undo_list)
-		return;
+		return 0;
 
 	if (!atomic_dec_and_test(&undo_list->refcnt))
-		return;
+		return 0;
 
 	ns = tsk->nsproxy->ipc_ns;
 	/* There's no need to hold the semundo list lock, as current
          * is the last task exiting for this undo list.
 	 */
@@ -1395,11 +1397,13 @@ found:
 		update_queue(sma);
 next_entry:
 		sem_unlock(sma);
 	}
 	kfree(undo_list);
+	return 0;
 }
+task_watcher_func(free, exit_sem);
 
 #ifdef CONFIG_PROC_FS
 static int sysvipc_sem_proc_show(struct seq_file *s, void *it)
 {
 	struct sem_array *sma = it;
Index: linux-2.6.19-rc2-mm2/kernel/exit.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/exit.c
+++ linux-2.6.19-rc2-mm2/kernel/exit.c
@@ -46,12 +46,10 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 
-extern void sem_exit (void);
-
 static void exit_mm(struct task_struct * tsk);
 
 static void __unhash_process(struct task_struct *p)
 {
 	nr_threads--;
@@ -919,11 +917,10 @@ fastcall NORET_TYPE void do_exit(long co
 	exit_mm(tsk);
 	notify_task_watchers(WATCH_TASK_FREE, code, tsk);
 
 	if (group_dead)
 		acct_process();
-	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_thread();
 	cpuset_exit(tsk);
 	exit_keys(tsk);
Index: linux-2.6.19-rc2-mm2/kernel/fork.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/fork.c
+++ linux-2.6.19-rc2-mm2/kernel/fork.c
@@ -1095,14 +1095,12 @@ static struct task_struct *copy_process(
 #endif
 
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup_policy;
 	/* copy all the process information */
-	if ((retval = copy_semundo(clone_flags, p)))
-		goto bad_fork_cleanup_security;
 	if ((retval = copy_files(clone_flags, p)))
-		goto bad_fork_cleanup_semundo;
+		goto bad_fork_cleanup_security;
 	if ((retval = copy_fs(clone_flags, p)))
 		goto bad_fork_cleanup_files;
 	if ((retval = copy_sighand(clone_flags, p)))
 		goto bad_fork_cleanup_fs;
 	if ((retval = copy_signal(clone_flags, p)))
@@ -1269,12 +1267,10 @@ bad_fork_cleanup_sighand:
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
-bad_fork_cleanup_semundo:
-	exit_sem(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
 bad_fork_cleanup_policy:
 #ifdef CONFIG_NUMA
 	mpol_free(p->mempolicy);
Index: linux-2.6.19-rc2-mm2/include/linux/sem.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/linux/sem.h
+++ linux-2.6.19-rc2-mm2/include/linux/sem.h
@@ -136,25 +136,8 @@ struct sem_undo_list {
 
 struct sysv_sem {
 	struct sem_undo_list *undo_list;
 };
 
-#ifdef CONFIG_SYSVIPC
-
-extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
-extern void exit_sem(struct task_struct *tsk);
-
-#else
-static inline int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
-{
-	return 0;
-}
-
-static inline void exit_sem(struct task_struct *tsk)
-{
-	return;
-}
-#endif
-
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SEM_H */

--
