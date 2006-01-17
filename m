Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWAQOu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWAQOu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWAQOus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:64906 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751162AbWAQOua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143327.483869000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:18 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 20/34] PID Virtualization Use pid_to_vpid conversion functions
Content-Disposition: inline; filename=F7-pid-to-vpid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the pid_to_vpid translation function 
to return to userspace a virtual pid. 
These need to be applied where the task access functions 
previously defined can not be utilized.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 drivers/char/tty_io.c |    2 +-
 fs/binfmt_elf.c       |    4 ++--
 fs/proc/array.c       |    4 ++--
 ipc/msg.c             |    8 ++++----
 ipc/shm.c             |    8 ++++----
 kernel/fork.c         |    9 ++++++---
 kernel/sys.c          |    4 ++--
 7 files changed, 21 insertions(+), 18 deletions(-)

Index: linux-2.6.15/drivers/char/tty_io.c
===================================================================
--- linux-2.6.15.orig/drivers/char/tty_io.c	2006-01-17 08:36:54.000000000 -0500
+++ linux-2.6.15/drivers/char/tty_io.c	2006-01-17 08:37:05.000000000 -0500
@@ -2158,7 +2158,7 @@
 	 */
 	if (tty == real_tty && current->signal->tty != real_tty)
 		return -ENOTTY;
-	return put_user(real_tty->pgrp, p);
+	return put_user(pid_to_vpid(real_tty->pgrp), p);
 }
 
 static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
Index: linux-2.6.15/fs/proc/array.c
===================================================================
--- linux-2.6.15.orig/fs/proc/array.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/fs/proc/array.c	2006-01-17 08:37:05.000000000 -0500
@@ -379,11 +379,11 @@
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
Index: linux-2.6.15/ipc/msg.c
===================================================================
--- linux-2.6.15.orig/ipc/msg.c	2006-01-17 08:36:59.000000000 -0500
+++ linux-2.6.15/ipc/msg.c	2006-01-17 08:37:05.000000000 -0500
@@ -416,8 +416,8 @@
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
@@ -821,8 +821,8 @@
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
Index: linux-2.6.15/ipc/shm.c
===================================================================
--- linux-2.6.15.orig/ipc/shm.c	2006-01-17 08:36:59.000000000 -0500
+++ linux-2.6.15/ipc/shm.c	2006-01-17 08:37:05.000000000 -0500
@@ -508,8 +508,8 @@
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
@@ -896,8 +896,8 @@
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
Index: linux-2.6.15/kernel/fork.c
===================================================================
--- linux-2.6.15.orig/kernel/fork.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/kernel/fork.c	2006-01-17 08:37:05.000000000 -0500
@@ -1238,6 +1238,7 @@
 	struct task_struct *p;
 	int trace = 0;
 	long pid = alloc_pidmap();
+	long vpid;
 
 	if (pid < 0)
 		return -EAGAIN;
@@ -1268,13 +1269,15 @@
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
 
@@ -1285,9 +1288,9 @@
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
Index: linux-2.6.15/kernel/sys.c
===================================================================
--- linux-2.6.15.orig/kernel/sys.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/kernel/sys.c	2006-01-17 08:37:05.000000000 -0500
@@ -1187,7 +1187,7 @@
 asmlinkage long sys_getsid(pid_t pid)
 {
 	if (!pid) {
-		return current->signal->session;
+		return pid_to_vpid(current->signal->session);
 	} else {
 		int retval;
 		struct task_struct *p;
@@ -1199,7 +1199,7 @@
 		if(p) {
 			retval = security_task_getsid(p);
 			if (!retval)
-				retval = p->signal->session;
+				retval = pid_to_vpid(p->signal->session);
 		}
 		read_unlock(&tasklist_lock);
 		return retval;
Index: linux-2.6.15/fs/binfmt_elf.c
===================================================================
--- linux-2.6.15.orig/fs/binfmt_elf.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/fs/binfmt_elf.c	2006-01-17 08:37:05.000000000 -0500
@@ -1273,7 +1273,7 @@
 	prstatus->pr_pid = task_vpid(p);
 	prstatus->pr_ppid = task_vppid(p);
 	prstatus->pr_pgrp = virt_process_group(p);
-	prstatus->pr_sid = p->signal->session;
+	prstatus->pr_sid = pid_to_vpid(p->signal->session);
 	if (thread_group_leader(p)) {
 		/*
 		 * This is the record for the group leader.  Add in the
@@ -1319,7 +1319,7 @@
 	psinfo->pr_pid = task_vpid(p);
 	psinfo->pr_ppid = task_vppid(p);
 	psinfo->pr_pgrp = virt_process_group(p);
-	psinfo->pr_sid = p->signal->session;
+	psinfo->pr_sid = pid_to_vpid(p->signal->session);
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
 	psinfo->pr_state = i;

--

