Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWI2CPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWI2CPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbWI2CNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2223 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751350AbWI2CNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:04 -0400
Message-Id: <20060929021300.586272000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:36 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>
Subject: [RFC][PATCH 04/10] Task watchers v2 Register semundo task watcher
Content-Disposition: inline; filename=task-watchers-register-semundo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the semaphore undo code use a task watcher instead of hooking into
copy_process() and do_exit() directly.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 include/linux/sem.h |   17 -----------------
 ipc/sem.c           |   12 ++++++++----
 kernel/exit.c       |    1 -
 kernel/fork.c       |    6 +-----
 4 files changed, 9 insertions(+), 27 deletions(-)

Index: linux-2.6.18-mm1/ipc/sem.c
===================================================================
--- linux-2.6.18-mm1.orig/ipc/sem.c
+++ linux-2.6.18-mm1/ipc/sem.c
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
@@ -1286,11 +1287,11 @@ asmlinkage long sys_semop (int semid, st
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
@@ -1302,10 +1303,11 @@ int copy_semundo(unsigned long clone_fla
 	} else 
 		tsk->sysvsem.undo_list = NULL;
 
 	return 0;
 }
+task_watcher_func(init, copy_semundo);
 
 /*
  * add semadj values to semaphores, free undo structures.
  * undo structures are not freed when semaphore arrays are destroyed
  * so some of them may be out of date.
@@ -1315,22 +1317,22 @@ int copy_semundo(unsigned long clone_fla
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
@@ -1393,11 +1395,13 @@ found:
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
Index: linux-2.6.18-mm1/kernel/exit.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/exit.c
+++ linux-2.6.18-mm1/kernel/exit.c
@@ -915,11 +915,10 @@ fastcall NORET_TYPE void do_exit(long co
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
Index: linux-2.6.18-mm1/kernel/fork.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/fork.c
+++ linux-2.6.18-mm1/kernel/fork.c
@@ -1103,14 +1103,12 @@ static struct task_struct *copy_process(
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
@@ -1277,12 +1275,10 @@ bad_fork_cleanup_sighand:
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
Index: linux-2.6.18-mm1/include/linux/sem.h
===================================================================
--- linux-2.6.18-mm1.orig/include/linux/sem.h
+++ linux-2.6.18-mm1/include/linux/sem.h
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
