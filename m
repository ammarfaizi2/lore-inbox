Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVLOOiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVLOOiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVLOOiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:38:13 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:27290 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750713AbVLOOiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:04 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143756.647035000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:00 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 03/21] PID Virtualization: return virtual pids where required
Content-Disposition: inline; filename=F3-replace-pid-kernel-access-with-virt-access.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch we now identify where in the kernel code conceptually
a virtual pid(etc.) needs to be returned to userspace. This is at the 
kernel/user interfaces. We need to identify all locations where 
pids are returned, broadly they fall into 3 categories:
(a) syscall return parameter, 
(b) syscall return code, 
(c) through a datastructure filled in a syscall

The process_group virtualization will be done in the following patch.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 arch/ia64/kernel/signal.c |    2 +-
 fs/binfmt_elf.c           |    8 ++++----
 fs/proc/array.c           |    8 ++++----
 fs/proc/base.c            |    8 ++++----
 kernel/exit.c             |    4 ++--
 kernel/fork.c             |    4 ++--
 kernel/sched.c            |    2 +-
 kernel/signal.c           |   10 +++++-----
 kernel/timer.c            |    4 ++--
 9 files changed, 25 insertions(+), 25 deletions(-)

Index: linux-2.6.15-rc1/arch/ia64/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/signal.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/arch/ia64/kernel/signal.c	2005-12-12 15:24:27.000000000 -0500
@@ -270,7 +270,7 @@ ia64_rt_sigreturn (struct sigscratch *sc
 	si.si_signo = SIGSEGV;
 	si.si_errno = 0;
 	si.si_code = SI_KERNEL;
-	si.si_pid = task_pid(current);
+	si.si_pid = task_vpid(current);
 	si.si_uid = current->uid;
 	si.si_addr = sc;
 	force_sig_info(SIGSEGV, &si, current);
Index: linux-2.6.15-rc1/fs/binfmt_elf.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/binfmt_elf.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/fs/binfmt_elf.c	2005-12-12 16:11:37.000000000 -0500
@@ -1270,8 +1270,8 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
 	prstatus->pr_sigpend = p->pending.signal.sig[0];
 	prstatus->pr_sighold = p->blocked.sig[0];
-	prstatus->pr_pid = task_pid(p);
-	prstatus->pr_ppid = task_pid(p->parent);
+	prstatus->pr_pid = task_vpid(p);
+	prstatus->pr_ppid = task_vppid(p);
 	prstatus->pr_pgrp = process_group(p);
 	prstatus->pr_sid = p->signal->session;
 	if (thread_group_leader(p)) {
@@ -1316,8 +1316,8 @@ static int fill_psinfo(struct elf_prpsin
 			psinfo->pr_psargs[i] = ' ';
 	psinfo->pr_psargs[len] = 0;
 
-	psinfo->pr_pid = task_pid(p);
-	psinfo->pr_ppid = task_pid(p->parent);
+	psinfo->pr_pid = task_vpid(p);
+	psinfo->pr_ppid = task_vppid(p);
 	psinfo->pr_pgrp = process_group(p);
 	psinfo->pr_sid = p->signal->session;
 
Index: linux-2.6.15-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/array.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/array.c	2005-12-12 16:11:54.000000000 -0500
@@ -174,10 +174,10 @@ static inline char * task_state(struct t
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
-	       	task_tgid(p),
-		task_pid(p), pid_alive(p) ?
-			task_tgid(p->group_leader->real_parent) : 0,
-		pid_alive(p) && p->ptrace ? task_pid(p->parent) : 0,
+	       	task_vtgid(p),
+		task_vpid(p), pid_alive(p) ?
+			task_vtgid(p->group_leader->real_parent) : 0,
+		pid_alive(p) && p->ptrace ? task_vpid(p->parent) : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);
@@ -390,7 +390,7 @@ static int do_task_stat(struct task_stru
 		it_real_value = task->signal->it_real_value;
 	}
 	ppid = pid_alive(task) ?
-		task_tgid(task->group_leader->real_parent) : 0;
+		task_vtgid(task->group_leader->real_parent) : 0;
 	read_unlock(&tasklist_lock);
 
 	if (!whole || num_threads<2)
@@ -417,7 +417,7 @@ static int do_task_stat(struct task_stru
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
-		task_pid(task),
+		task_vpid(task),
 		tcomm,
 		state,
 		ppid,
Index: linux-2.6.15-rc1/fs/proc/base.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/base.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/base.c	2005-12-12 16:07:05.000000000 -0500
@@ -1878,14 +1878,14 @@ static int proc_self_readlink(struct den
 			      int buflen)
 {
 	char tmp[30];
-	sprintf(tmp, "%d", task_tgid(current));
+	sprintf(tmp, "%d", task_vtgid(current));
 	return vfs_readlink(dentry,buffer,buflen,tmp);
 }
 
 static void *proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char tmp[30];
-	sprintf(tmp, "%d", task_tgid(current));
+	sprintf(tmp, "%d", task_vtgid(current));
 	return ERR_PTR(vfs_follow_link(nd,tmp));
 }	
 
@@ -2100,7 +2100,7 @@ static int get_tgid_list(int index, unsi
 		p = next_task(&init_task);
 
 	for ( ; p != &init_task; p = next_task(p)) {
-		int tgid = task_pid(p);
+		int tgid = task_vpid(p);
 		if (!pid_alive(p))
 			continue;
 		if (--index >= 0)
@@ -2133,7 +2133,7 @@ static int get_tid_list(int index, unsig
 	 * via next_thread().
 	 */
 	if (pid_alive(task)) do {
-		int tid = task_pid(task);
+		int tid = task_vpid(task);
 
 		if (--index >= 0)
 			continue;
Index: linux-2.6.15-rc1/kernel/exit.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/exit.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/kernel/exit.c	2005-12-12 16:07:05.000000000 -0500
@@ -1143,7 +1143,7 @@ static int wait_task_zombie(task_t *p, i
 		p->exit_state = EXIT_ZOMBIE;
 		return retval;
 	}
-	retval = task_pid(p);
+	retval = task_vpid(p);
 	if (p->real_parent != p->parent) {
 		write_lock_irq(&tasklist_lock);
 		/* Double-check with lock held.  */
@@ -1278,7 +1278,7 @@ bail_ref:
 	if (!retval && infop)
 		retval = put_user(p->uid, &infop->si_uid);
 	if (!retval)
-		retval = task_pid(p);
+		retval = task_vpid(p);
 	put_task_struct(p);
 
 	BUG_ON(!retval);
Index: linux-2.6.15-rc1/kernel/fork.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/fork.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/kernel/fork.c	2005-12-12 16:07:34.000000000 -0500
@@ -850,7 +850,7 @@ asmlinkage long sys_set_tid_address(int 
 {
 	current->clear_child_tid = tidptr;
 
-	return task_pid(current);
+	return task_vpid(current);
 }
 
 /*
@@ -930,7 +930,7 @@ static task_t *copy_process(unsigned lon
 	p->__pid = pid;
 	retval = -EFAULT;
 	if (clone_flags & CLONE_PARENT_SETTID)
-		if (put_user(task_pid(p), parent_tidptr))
+		if (put_user(task_vpid(p), parent_tidptr))
 			goto bad_fork_cleanup;
 
 	p->proc_dentry = NULL;
Index: linux-2.6.15-rc1/kernel/sched.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/sched.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/kernel/sched.c	2005-12-12 16:07:05.000000000 -0500
@@ -1653,7 +1653,7 @@ asmlinkage void schedule_tail(task_t *pr
 	preempt_enable();
 #endif
 	if (current->set_child_tid)
-		put_user(task_pid(current), current->set_child_tid);
+		put_user(task_vpid(current), current->set_child_tid);
 }
 
 /*
Index: linux-2.6.15-rc1/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/signal.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/kernel/signal.c	2005-12-12 16:07:05.000000000 -0500
@@ -809,7 +809,7 @@ static int send_signal(int sig, struct s
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
 			q->info.si_code = SI_USER;
-			q->info.si_pid = task_pid(current);
+			q->info.si_pid = task_vpid(current);
 			q->info.si_uid = current->uid;
 			break;
 		case (unsigned long) SEND_SIG_PRIV:
@@ -1478,7 +1478,7 @@ void do_notify_parent(struct task_struct
 
 	info.si_signo = sig;
 	info.si_errno = 0;
-	info.si_pid = task_pid(tsk);
+	info.si_pid = task_vpid(tsk);
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
@@ -1543,7 +1543,7 @@ static void do_notify_parent_cldstop(str
 
 	info.si_signo = SIGCHLD;
 	info.si_errno = 0;
-	info.si_pid = task_pid(tsk);
+	info.si_pid = task_vpid(tsk);
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
@@ -2254,7 +2254,7 @@ sys_kill(int pid, int sig)
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code = SI_USER;
-	info.si_pid = task_tgid(current);
+	info.si_pid = task_vtgid(current);
 	info.si_uid = current->uid;
 
 	return kill_something_info(sig, &info, pid);
@@ -2270,7 +2270,7 @@ static int do_tkill(int tgid, int pid, i
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code = SI_TKILL;
-	info.si_pid = task_tgid(current);
+	info.si_pid = task_vtgid(current);
 	info.si_uid = current->uid;
 
 	read_lock(&tasklist_lock);
Index: linux-2.6.15-rc1/kernel/timer.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/timer.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/kernel/timer.c	2005-12-12 16:06:39.000000000 -0500
@@ -941,7 +941,7 @@ asmlinkage unsigned long sys_alarm(unsig
  */
 asmlinkage long sys_getpid(void)
 {
-	return task_tgid(current);
+	return task_vtgid(current);
 }
 
 /*
@@ -1115,7 +1115,7 @@ EXPORT_SYMBOL(schedule_timeout_uninterru
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
-	return task_pid(current);
+	return task_vpid(current);
 }
 
 static long __sched nanosleep_restart(struct restart_block *restart)

--
