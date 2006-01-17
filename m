Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWAQOvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWAQOvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWAQOvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:51:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11665 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751237AbWAQOub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:31 -0500
Message-Id: <20060117143328.345473000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:23 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 25/34] PID Virtualization Context for pid_to_vpid conversition functions
Content-Disposition: inline; filename=FC-context-for-pid2vpid.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pid_to_vpid conversion require the context task relative to which
the conversion should take place. For instance, the virtual init process 
of a container is vpid=1 relative to the tasks of that container, 
vpid=-1 from within a different container and vpid=pid in the global context.

By default we assume that the virtual access functions are called
within the context of the task's container itself.
Provide the context for the pid_to_vpid translations
vpids are with respect to a context task. 
In this patch we therefore only identify where the context is different
then the default. 

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 fs/binfmt_elf.c       |    4 ++--
 fs/fcntl.c            |    2 +-
 fs/proc/array.c       |   18 +++++++++---------
 fs/proc/base.c        |    4 ++--
 include/linux/sched.h |   41 +++++++++++++++++++++++++++++++++++++----
 ipc/msg.c             |    8 ++++----
 ipc/sem.c             |    2 +-
 ipc/shm.c             |    8 ++++----
 kernel/exit.c         |    4 ++--
 kernel/fork.c         |    3 ++-
 kernel/signal.c       |    4 ++--
 kernel/sys.c          |    7 ++++---
 kernel/timer.c        |    2 +-
 13 files changed, 71 insertions(+), 36 deletions(-)

Index: linux-2.6.15/fs/proc/base.c
===================================================================
--- linux-2.6.15.orig/fs/proc/base.c	2006-01-17 08:37:06.000000000 -0500
+++ linux-2.6.15/fs/proc/base.c	2006-01-17 08:37:07.000000000 -0500
@@ -2102,7 +2102,7 @@
 		p = next_task(&init_task);
 
 	for ( ; p != &init_task; p = next_task(p)) {
-		int tgid = task_vpid(p);
+		int tgid = task_vpid_ctx(p, current);
 		if (!pid_alive(p))
 			continue;
 		if (--index >= 0)
@@ -2135,7 +2135,7 @@
 	 * via next_thread().
 	 */
 	if (pid_alive(task)) do {
-		int tid = task_vpid(task);
+		int tid = task_vpid_ctx(task, current);
 
 		if (--index >= 0)
 			continue;
Index: linux-2.6.15/fs/proc/array.c
===================================================================
--- linux-2.6.15.orig/fs/proc/array.c	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/fs/proc/array.c	2006-01-17 08:37:07.000000000 -0500
@@ -165,11 +165,11 @@
 
 	read_lock(&tasklist_lock);
 	if (pid_alive(p))
-		ppid = task_vtgid(p->group_leader->real_parent);
+		ppid = task_vtgid_ctx(p->group_leader->real_parent, current);
 	else
 		ppid = 0;
 	if (pid_alive(p) && p->ptrace)
-		tpid = task_vppid(p);
+		tpid = task_vppid_ctx(p, current);
 	else
 		tpid = 0;
 	buffer += sprintf(buffer,
@@ -183,8 +183,8 @@
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
-	       	task_vtgid(p),
-		task_vpid(p),
+	       	task_vtgid_ctx(p,current),
+		task_vpid_ctx(p,current),
 		ppid, tpid,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
@@ -379,11 +379,11 @@
 	}
 	if (task->signal) {
 		if (task->signal->tty) {
-			tty_pgrp = pid_to_vpid(task->signal->tty->pgrp);
+			tty_pgrp = pid_to_vpid_ctx(task->signal->tty->pgrp, current);
 			tty_nr = new_encode_dev(tty_devnum(task->signal->tty));
 		}
-		pgid = virt_process_group(task);
-		sid = pid_to_vpid(task->signal->session);
+		pgid = pid_to_vpid_ctx(process_group(task), current);
+		sid = pid_to_vpid_ctx(task->signal->session, current);
 		cmin_flt = task->signal->cmin_flt;
 		cmaj_flt = task->signal->cmaj_flt;
 		cutime = task->signal->cutime;
@@ -398,7 +398,7 @@
 		it_real_value = task->signal->it_real_value;
 	}
 	ppid = pid_alive(task) ?
-		task_vtgid(task->group_leader->real_parent) : 0;
+		pid_to_vpid_ctx(task_tgid(task->group_leader->real_parent), current) : 0;
 	read_unlock(&tasklist_lock);
 
 	if (!whole || num_threads<2)
@@ -425,7 +425,7 @@
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
-		task_vpid(task),
+		task_vpid_ctx(task,current),
 		tcomm,
 		state,
 		ppid,
Index: linux-2.6.15/fs/fcntl.c
===================================================================
--- linux-2.6.15.orig/fs/fcntl.c	2006-01-17 08:37:06.000000000 -0500
+++ linux-2.6.15/fs/fcntl.c	2006-01-17 08:37:07.000000000 -0500
@@ -317,7 +317,7 @@
 		 * current syscall conventions, the only way
 		 * to fix this will be in libc.
 		 */
-		err = pgid_to_vpgid(filp->f_owner.pid);
+		err = pgid_to_vpgid_ctx(filp->f_owner.pid, current);
 		force_successful_syscall_return();
 		break;
 	case F_SETOWN:
Index: linux-2.6.15/ipc/msg.c
===================================================================
--- linux-2.6.15.orig/ipc/msg.c	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/ipc/msg.c	2006-01-17 08:37:07.000000000 -0500
@@ -416,8 +416,8 @@
 		tbuf.msg_cbytes = msq->q_cbytes;
 		tbuf.msg_qnum   = msq->q_qnum;
 		tbuf.msg_qbytes = msq->q_qbytes;
-		tbuf.msg_lspid  = pid_to_vpid(msq->q_lspid);
-		tbuf.msg_lrpid  = pid_to_vpid(msq->q_lrpid);
+		tbuf.msg_lspid  = pid_to_vpid_ctx(msq->q_lspid, current);
+		tbuf.msg_lrpid  = pid_to_vpid_ctx(msq->q_lrpid, current);
 		msg_unlock(msq);
 		if (copy_msqid_to_user(buf, &tbuf, version))
 			return -EFAULT;
@@ -821,8 +821,8 @@
 			  msq->q_perm.mode,
 			  msq->q_cbytes,
 			  msq->q_qnum,
-			  pid_to_vpid(msq->q_lspid),
-			  pid_to_vpid(msq->q_lrpid),
+			  pid_to_vpid_ctx(msq->q_lspid, current),
+			  pid_to_vpid_ctx(msq->q_lrpid, current),
 			  msq->q_perm.uid,
 			  msq->q_perm.gid,
 			  msq->q_perm.cuid,
Index: linux-2.6.15/ipc/shm.c
===================================================================
--- linux-2.6.15.orig/ipc/shm.c	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/ipc/shm.c	2006-01-17 08:37:07.000000000 -0500
@@ -508,8 +508,8 @@
 		tbuf.shm_atime	= shp->shm_atim;
 		tbuf.shm_dtime	= shp->shm_dtim;
 		tbuf.shm_ctime	= shp->shm_ctim;
-		tbuf.shm_cpid	= pid_to_vpid(shp->shm_cprid);
-		tbuf.shm_lpid	= pid_to_vpid(shp->shm_lprid);
+		tbuf.shm_cpid	= pid_to_vpid_ctx(shp->shm_cprid, current);
+		tbuf.shm_lpid	= pid_to_vpid_ctx(shp->shm_lprid, current);
 		if (!is_file_hugepages(shp->shm_file))
 			tbuf.shm_nattch	= shp->shm_nattch;
 		else
@@ -896,8 +896,8 @@
 			  shp->id,
 			  shp->shm_flags,
 			  shp->shm_segsz,
-			  pid_to_vpid(shp->shm_cprid),
-			  pid_to_vpid(shp->shm_lprid),
+			  pid_to_vpid_ctx(shp->shm_cprid, current),
+			  pid_to_vpid_ctx(shp->shm_lprid, current),
 			  is_file_hugepages(shp->shm_file) ? (file_count(shp->shm_file) - 1) : shp->shm_nattch,
 			  shp->shm_perm.uid,
 			  shp->shm_perm.gid,
Index: linux-2.6.15/ipc/sem.c
===================================================================
--- linux-2.6.15.orig/ipc/sem.c	2006-01-17 08:36:59.000000000 -0500
+++ linux-2.6.15/ipc/sem.c	2006-01-17 08:37:07.000000000 -0500
@@ -723,7 +723,7 @@
 		err = curr->semval;
 		goto out_unlock;
 	case GETPID:
-		err = curr->sempid;
+		err = pid_to_vpid_ctx(curr->sempid, current);
 		goto out_unlock;
 	case GETNCNT:
 		err = count_semncnt(sma,semnum);
Index: linux-2.6.15/kernel/exit.c
===================================================================
--- linux-2.6.15.orig/kernel/exit.c	2006-01-17 08:37:06.000000000 -0500
+++ linux-2.6.15/kernel/exit.c	2006-01-17 08:37:07.000000000 -0500
@@ -1143,7 +1143,7 @@
 		p->exit_state = EXIT_ZOMBIE;
 		return retval;
 	}
-	retval = task_vpid(p);
+	retval = task_vpid_ctx(p, current);
 	if (p->real_parent != p->parent) {
 		write_lock_irq(&tasklist_lock);
 		/* Double-check with lock held.  */
@@ -1278,7 +1278,7 @@
 	if (!retval && infop)
 		retval = put_user(p->uid, &infop->si_uid);
 	if (!retval)
-		retval = task_vpid(p);
+		retval = task_vpid_ctx(p, current);
 	put_task_struct(p);
 
 	BUG_ON(!retval);
Index: linux-2.6.15/kernel/fork.c
===================================================================
--- linux-2.6.15.orig/kernel/fork.c	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/kernel/fork.c	2006-01-17 08:37:07.000000000 -0500
@@ -926,9 +926,10 @@
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
 	p->__pid = pid;
+
 	retval = -EFAULT;
 	if (clone_flags & CLONE_PARENT_SETTID)
-		if (put_user(task_vpid(p), parent_tidptr))
+		if (put_user(task_vpid_ctx(p, current), parent_tidptr))
 			goto bad_fork_cleanup;
 
 	p->proc_dentry = NULL;
Index: linux-2.6.15/kernel/signal.c
===================================================================
--- linux-2.6.15.orig/kernel/signal.c	2006-01-17 08:37:06.000000000 -0500
+++ linux-2.6.15/kernel/signal.c	2006-01-17 08:37:07.000000000 -0500
@@ -1469,7 +1469,7 @@
 
 	info.si_signo = sig;
 	info.si_errno = 0;
-	info.si_pid = task_vpid(tsk);
+	info.si_pid = task_vpid_ctx(tsk, tsk->parent);
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
@@ -1534,7 +1534,7 @@
 
 	info.si_signo = SIGCHLD;
 	info.si_errno = 0;
-	info.si_pid = task_vpid(tsk);
+	info.si_pid = task_vpid_ctx(tsk, tsk->parent);
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
Index: linux-2.6.15/kernel/sys.c
===================================================================
--- linux-2.6.15.orig/kernel/sys.c	2006-01-17 08:37:06.000000000 -0500
+++ linux-2.6.15/kernel/sys.c	2006-01-17 08:37:07.000000000 -0500
@@ -1180,7 +1180,8 @@
 		if (p) {
 			retval = security_task_getpgid(p);
 			if (!retval)
-				retval = virt_process_group(p);
+				retval = pid_to_vpid_ctx(process_group(p),
+							 current);
 		}
 		read_unlock(&tasklist_lock);
 		return retval;
@@ -1200,7 +1201,7 @@
 asmlinkage long sys_getsid(pid_t pid)
 {
 	if (!pid) {
-		return pid_to_vpid(current->signal->session);
+		return pid_to_vpid_ctx(current->signal->session,current);
 	} else {
 		int retval;
 		struct task_struct *p;
@@ -1213,7 +1214,7 @@
 		if(p) {
 			retval = security_task_getsid(p);
 			if (!retval)
-				retval = pid_to_vpid(p->signal->session);
+				retval = pid_to_vpid_ctx(p->signal->session, current);
 		}
 		read_unlock(&tasklist_lock);
 		return retval;
Index: linux-2.6.15/kernel/timer.c
===================================================================
--- linux-2.6.15.orig/kernel/timer.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/kernel/timer.c	2006-01-17 08:37:07.000000000 -0500
@@ -968,7 +968,7 @@
 
 	parent = me->group_leader->real_parent;
 	for (;;) {
-		pid = task_tgid(parent);
+		pid = task_vtgid_ctx(parent, current);
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 {
 		struct task_struct *old = parent;
Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h	2006-01-17 08:37:06.000000000 -0500
+++ linux-2.6.15/include/linux/sched.h	2006-01-17 08:37:07.000000000 -0500
@@ -868,14 +868,29 @@
  *  pid domain translation functions:
  *	- from kernel to user pid domain
  */
+static inline pid_t pid_to_vpid_ctx(pid_t pid, const struct task_struct *ctx)
+{
+	return pid;
+}
+
 static inline pid_t pid_to_vpid(pid_t pid)
 {
+	return pid_to_vpid_ctx(pid, current);
+}
+
+static inline pid_t pgid_to_vpgid_ctx(pid_t pid, const struct task_struct *ctx)
+{
+	int isgrp = (pid < 0) ;
+
+	if (isgrp) pid = -pid;
+	pid = pid_to_vpid_ctx(pid, ctx);
+	if (isgrp) pid = -pid;
 	return pid;
 }
 
 static inline pid_t pgid_to_vpgid(pid_t pid)
 {
-	return pid;
+	return pgid_to_vpgid_ctx(pid, current);
 }
 
 static inline pid_t vpid_to_pid(pid_t pid)
@@ -911,19 +926,37 @@
 	return p->__tgid;
 }
 
-static inline pid_t task_vpid(const struct task_struct *p)
+static inline pid_t task_vpid_ctx(const struct task_struct *p,
+				   const struct task_struct *ctx)
 {
 	return task_pid(p);
 }
 
+static inline pid_t task_vpid(const struct task_struct *p)
+{
+	return task_vpid_ctx(p, p);
+}
+
+static inline pid_t task_vppid_ctx(const struct task_struct *p,
+			      	   const struct task_struct *ctx)
+{
+	return task_vpid_ctx(p->parent, ctx);
+}
+
 static inline pid_t task_vppid(const struct task_struct *p)
 {
-	return task_pid(p->parent);
+	return task_vppid_ctx(p, p);
+}
+
+static inline pid_t task_vtgid_ctx(const struct task_struct *p,
+				    const struct task_struct *ctx)
+{
+	return pid_to_vpid_ctx(task_tgid(p), ctx);
 }
 
 static inline pid_t task_vtgid(const struct task_struct *p)
 {
-	return task_tgid(p);
+	return task_vtgid_ctx(p, p);
 }
 
 static inline pid_t virt_process_group(const struct task_struct *p)
Index: linux-2.6.15/fs/binfmt_elf.c
===================================================================
--- linux-2.6.15.orig/fs/binfmt_elf.c	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/fs/binfmt_elf.c	2006-01-17 08:37:07.000000000 -0500
@@ -1273,7 +1273,7 @@
 	prstatus->pr_pid = task_vpid(p);
 	prstatus->pr_ppid = task_vppid(p);
 	prstatus->pr_pgrp = virt_process_group(p);
-	prstatus->pr_sid = pid_to_vpid(p->signal->session);
+	prstatus->pr_sid = pid_to_vpid_ctx(p->signal->session, p);
 	if (thread_group_leader(p)) {
 		/*
 		 * This is the record for the group leader.  Add in the
@@ -1319,7 +1319,7 @@
 	psinfo->pr_pid = task_vpid(p);
 	psinfo->pr_ppid = task_vppid(p);
 	psinfo->pr_pgrp = virt_process_group(p);
-	psinfo->pr_sid = pid_to_vpid(p->signal->session);
+	psinfo->pr_sid = pid_to_vpid_ctx(p->signal->session, p);
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
 	psinfo->pr_state = i;

--

