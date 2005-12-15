Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVLOOoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVLOOoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVLOOia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:38:30 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:37018 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750723AbVLOOi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:26 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143819.088976000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:04 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 07/21] PID Virtualization: Use pid_to_vpid conversion functions
Content-Disposition: inline; filename=F7-pid-to-vpid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the pid_to_vpid translation function 
to return to userspace a virtual pid. 
These need to be applied where the task access functions 
previously defined can not be utilized.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 drivers/char/tty_io.c |    2 +-
 fs/binfmt_elf.c       |    4 ++--
 fs/proc/array.c       |    4 ++--
 ipc/msg.c             |    8 ++++----
 ipc/shm.c             |    8 ++++----
 kernel/fork.c         |    9 ++++++---
 kernel/sys.c          |    4 ++--
 7 files changed, 21 insertions(+), 18 deletions(-)

Index: linux-2.6.15-rc1/drivers/char/tty_io.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/tty_io.c	2005-12-12 18:37:36.000000000 -0500
+++ linux-2.6.15-rc1/drivers/char/tty_io.c	2005-12-12 18:46:39.000000000 -0500
@@ -2158,7 +2158,7 @@ static int tiocgpgrp(struct tty_struct *
 	 */
 	if (tty == real_tty && current->signal->tty != real_tty)
 		return -ENOTTY;
-	return put_user(real_tty->pgrp, p);
+	return put_user(pid_to_vpid(real_tty->pgrp), p);
 }
 
 static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
Index: linux-2.6.15-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/array.c	2005-12-12 18:37:42.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/array.c	2005-12-12 18:49:10.000000000 -0500
@@ -379,11 +379,11 @@ static int do_task_stat(struct task_stru
 	}
 	if (task->signal) {
 		if (task->signal->tty) {
-			tty_pgrp = task->signal->tty->pgrp;
+			tty_pgrp = pid_to_vpid(task->signal->tty->pgrp);
 			tty_nr = new_encode_dev(tty_devnum(task->signal->tty));
 		}
 		pgid = virt_process_group(task);
-		sid = task->signal->session;
+		sid = pid_to_vpid(task->signal->session);
 		cmin_flt = task->signal->cmin_flt;
 		cmaj_flt = task->signal->cmaj_flt;
 		cutime = task->signal->cutime;
Index: linux-2.6.15-rc1/ipc/msg.c
===================================================================
--- linux-2.6.15-rc1.orig/ipc/msg.c	2005-12-12 18:37:36.000000000 -0500
+++ linux-2.6.15-rc1/ipc/msg.c	2005-12-12 18:46:38.000000000 -0500
@@ -416,8 +416,8 @@ asmlinkage long sys_msgctl (int msqid, i
 		tbuf.msg_cbytes = msq->q_cbytes;
 		tbuf.msg_qnum   = msq->q_qnum;
 		tbuf.msg_qbytes = msq->q_qbytes;
-		tbuf.msg_lspid  = msq->q_lspid;
-		tbuf.msg_lrpid  = msq->q_lrpid;
+		tbuf.msg_lspid  = pid_to_vpid(msq->q_lspid);
+		tbuf.msg_lrpid  = pid_to_vpid(msq->q_lrpid);
 		msg_unlock(msq);
 		if (copy_msqid_to_user(buf, &tbuf, version))
 			return -EFAULT;
@@ -821,8 +821,8 @@ static int sysvipc_msg_proc_show(struct 
 			  msq->q_perm.mode,
 			  msq->q_cbytes,
 			  msq->q_qnum,
-			  msq->q_lspid,
-			  msq->q_lrpid,
+			  pid_to_vpid(msq->q_lspid),
+			  pid_to_vpid(msq->q_lrpid),
 			  msq->q_perm.uid,
 			  msq->q_perm.gid,
 			  msq->q_perm.cuid,
Index: linux-2.6.15-rc1/ipc/shm.c
===================================================================
--- linux-2.6.15-rc1.orig/ipc/shm.c	2005-12-12 18:37:36.000000000 -0500
+++ linux-2.6.15-rc1/ipc/shm.c	2005-12-12 18:46:38.000000000 -0500
@@ -508,8 +508,8 @@ asmlinkage long sys_shmctl (int shmid, i
 		tbuf.shm_atime	= shp->shm_atim;
 		tbuf.shm_dtime	= shp->shm_dtim;
 		tbuf.shm_ctime	= shp->shm_ctim;
-		tbuf.shm_cpid	= shp->shm_cprid;
-		tbuf.shm_lpid	= shp->shm_lprid;
+		tbuf.shm_cpid	= pid_to_vpid(shp->shm_cprid);
+		tbuf.shm_lpid	= pid_to_vpid(shp->shm_lprid);
 		if (!is_file_hugepages(shp->shm_file))
 			tbuf.shm_nattch	= shp->shm_nattch;
 		else
@@ -896,8 +896,8 @@ static int sysvipc_shm_proc_show(struct 
 			  shp->id,
 			  shp->shm_flags,
 			  shp->shm_segsz,
-			  shp->shm_cprid,
-			  shp->shm_lprid,
+			  pid_to_vpid(shp->shm_cprid),
+			  pid_to_vpid(shp->shm_lprid),
 			  is_file_hugepages(shp->shm_file) ? (file_count(shp->shm_file) - 1) : shp->shm_nattch,
 			  shp->shm_perm.uid,
 			  shp->shm_perm.gid,
Index: linux-2.6.15-rc1/kernel/fork.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/fork.c	2005-12-12 18:37:41.000000000 -0500
+++ linux-2.6.15-rc1/kernel/fork.c	2005-12-12 18:46:38.000000000 -0500
@@ -1241,6 +1241,7 @@ long do_fork(unsigned long clone_flags,
 	struct task_struct *p;
 	int trace = 0;
 	long pid = alloc_pidmap();
+	long vpid;
 
 	if (pid < 0)
 		return -EAGAIN;
@@ -1271,13 +1272,15 @@ long do_fork(unsigned long clone_flags,
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
+		vpid = pid_to_vpid(pid);
+
 		if (!(clone_flags & CLONE_STOPPED))
 			wake_up_new_task(p, clone_flags);
 		else
 			p->state = TASK_STOPPED;
 
 		if (unlikely (trace)) {
-			current->ptrace_message = pid;
+			current->ptrace_message = vpid;
 			ptrace_notify ((trace << 8) | SIGTRAP);
 		}
 
@@ -1288,9 +1291,9 @@ long do_fork(unsigned long clone_flags,
 		}
 	} else {
 		free_pidmap(pid);
-		pid = PTR_ERR(p);
+		vpid = PTR_ERR(p);
 	}
-	return pid;
+	return vpid;
 }
 
 void __init proc_caches_init(void)
Index: linux-2.6.15-rc1/kernel/sys.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/sys.c	2005-12-12 18:37:41.000000000 -0500
+++ linux-2.6.15-rc1/kernel/sys.c	2005-12-12 18:50:31.000000000 -0500
@@ -1186,7 +1186,7 @@ asmlinkage long sys_getpgrp(void)
 asmlinkage long sys_getsid(pid_t pid)
 {
 	if (!pid) {
-		return current->signal->session;
+		return pid_to_vpid(current->signal->session);
 	} else {
 		int retval;
 		struct task_struct *p;
@@ -1198,7 +1198,7 @@ asmlinkage long sys_getsid(pid_t pid)
 		if(p) {
 			retval = security_task_getsid(p);
 			if (!retval)
-				retval = p->signal->session;
+				retval = pid_to_vpid(p->signal->session);
 		}
 		read_unlock(&tasklist_lock);
 		return retval;
Index: linux-2.6.15-rc1/fs/binfmt_elf.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/binfmt_elf.c	2005-12-12 18:37:41.000000000 -0500
+++ linux-2.6.15-rc1/fs/binfmt_elf.c	2005-12-12 18:47:53.000000000 -0500
@@ -1273,7 +1273,7 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_pid = task_vpid(p);
 	prstatus->pr_ppid = task_vppid(p);
 	prstatus->pr_pgrp = virt_process_group(p);
-	prstatus->pr_sid = p->signal->session;
+	prstatus->pr_sid = pid_to_vpid(p->signal->session);
 	if (thread_group_leader(p)) {
 		/*
 		 * This is the record for the group leader.  Add in the
@@ -1319,7 +1319,7 @@ static int fill_psinfo(struct elf_prpsin
 	psinfo->pr_pid = task_vpid(p);
 	psinfo->pr_ppid = task_vppid(p);
 	psinfo->pr_pgrp = virt_process_group(p);
-	psinfo->pr_sid = p->signal->session;
+	psinfo->pr_sid = pid_to_vpid(p->signal->session);
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
 	psinfo->pr_state = i;

--
