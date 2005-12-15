Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVLOOjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVLOOjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVLOOjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:39:00 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:48282 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750723AbVLOOiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:54 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143835.669583000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:07 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 10/21] PID Virtualization: Use vpid_to_pid functions
Content-Disposition: inline; filename=FA-vpid-to-pid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We now utilize the vpid_to_pid function where ever
a pid is passed from user space and needs to be converted 
into a kernel pid.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 arch/ia64/kernel/ptrace.c |    1 +
 arch/s390/kernel/ptrace.c |    1 +
 drivers/char/tty_io.c     |    1 +
 fs/proc/base.c            |    2 ++
 kernel/capability.c       |    1 +
 kernel/exit.c             |    2 ++
 kernel/ptrace.c           |    1 +
 kernel/sched.c            |    6 +++++-
 kernel/signal.c           |    3 +++
 kernel/sys.c              |   14 ++++++++++++++
 10 files changed, 31 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc1/arch/ia64/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/ptrace.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/arch/ia64/kernel/ptrace.c	2005-12-12 15:24:36.000000000 -0500
@@ -1419,6 +1419,7 @@ sys_ptrace (long request, pid_t pid, uns
 	struct switch_stack *sw;
 	long ret;
 
+	pid = vpid_to_pid(pid);
 	lock_kernel();
 	ret = -EPERM;
 	if (request == PTRACE_TRACEME) {
Index: linux-2.6.15-rc1/arch/s390/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/s390/kernel/ptrace.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/arch/s390/kernel/ptrace.c	2005-12-12 15:24:36.000000000 -0500
@@ -711,6 +711,7 @@ sys_ptrace(long request, long pid, long 
 	struct task_struct *child;
 	int ret;
 
+	pid = vpid_to_pid(pid);
 	lock_kernel();
 
 	if (request == PTRACE_TRACEME) {
Index: linux-2.6.15-rc1/drivers/char/tty_io.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/tty_io.c	2005-12-12 15:24:32.000000000 -0500
+++ linux-2.6.15-rc1/drivers/char/tty_io.c	2005-12-12 15:24:36.000000000 -0500
@@ -2176,6 +2176,7 @@ static int tiocspgrp(struct tty_struct *
 		return -ENOTTY;
 	if (get_user(pgrp, p))
 		return -EFAULT;
+	pgrp = vpid_to_pid(pgrp);
 	if (pgrp < 0)
 		return -EINVAL;
 	if (session_of_pgrp(pgrp) != current->signal->session)
Index: linux-2.6.15-rc1/fs/proc/base.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/base.c	2005-12-12 15:24:27.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/base.c	2005-12-12 15:24:36.000000000 -0500
@@ -1975,6 +1975,7 @@ struct dentry *proc_pid_lookup(struct in
 	tgid = name_to_int(dentry);
 	if (tgid == ~0U)
 		goto out;
+	tgid = vpid_to_pid(tgid);
 
 	read_lock(&tasklist_lock);
 	task = find_task_by_pid(tgid);
@@ -2032,6 +2033,7 @@ static struct dentry *proc_task_lookup(s
 	unsigned tid;
 
 	tid = name_to_int(dentry);
+	tid = vpid_to_pid(tid);
 	if (tid == ~0U)
 		goto out;
 
Index: linux-2.6.15-rc1/kernel/capability.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/capability.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/kernel/capability.c	2005-12-12 15:24:36.000000000 -0500
@@ -63,6 +63,7 @@ asmlinkage long sys_capget(cap_user_head
      if (pid < 0) 
              return -EINVAL;
 
+     pid = vpid_to_pid(pid);
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock); 
 
Index: linux-2.6.15-rc1/kernel/exit.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/exit.c	2005-12-12 15:24:27.000000000 -0500
+++ linux-2.6.15-rc1/kernel/exit.c	2005-12-12 15:24:36.000000000 -0500
@@ -1529,10 +1529,12 @@ asmlinkage long sys_waitid(int which, pi
 	case P_PID:
 		if (pid <= 0)
 			return -EINVAL;
+		pid = vpid_to_pid(pid);
 		break;
 	case P_PGID:
 		if (pid <= 0)
 			return -EINVAL;
+		pid = vpid_to_pid(pid);
 		pid = -pid;
 		break;
 	default:
Index: linux-2.6.15-rc1/kernel/sched.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/sched.c	2005-12-12 15:24:27.000000000 -0500
+++ linux-2.6.15-rc1/kernel/sched.c	2005-12-12 15:24:36.000000000 -0500
@@ -3680,7 +3680,11 @@ task_t *idle_task(int cpu)
  */
 static inline task_t *find_process_by_pid(pid_t pid)
 {
-	return pid ? find_task_by_pid(pid) : current;
+	if (pid) {
+		pid = vpid_to_pid(pid);
+		return find_task_by_pid(pid);
+	}
+	return current;
 }
 
 /* Actually do priority change: must hold rq lock. */
Index: linux-2.6.15-rc1/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/signal.c	2005-12-12 15:24:27.000000000 -0500
+++ linux-2.6.15-rc1/kernel/signal.c	2005-12-12 15:26:42.000000000 -0500
@@ -1218,9 +1218,9 @@ static int kill_something_info(int sig, 
 		read_unlock(&tasklist_lock);
 		return count ? retval : -ESRCH;
 	} else if (pid < 0) {
-		return kill_pg_info(sig, info, -pid);
+		return kill_pg_info(sig, info, vpid_to_pid(-pid));
 	} else {
-		return kill_proc_info(sig, info, pid);
+		return kill_proc_info(sig, info, vpid_to_pid(pid));
 	}
 }
 
@@ -2273,6 +2273,8 @@ static int do_tkill(int tgid, int pid, i
 	info.si_pid = task_vtgid(current);
 	info.si_uid = current->uid;
 
+	pid  = vpid_to_pid(pid);
+	tgid = vpid_to_pid(tgid);
 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
 	if (p && (tgid <= 0 || task_tgid(p) == tgid)) {
@@ -2340,6 +2342,7 @@ sys_rt_sigqueueinfo(int pid, int sig, si
 	info.si_signo = sig;
 
 	/* POSIX.1b doesn't mention process groups.  */
+	pid = vpid_to_pid(pid);
 	return kill_proc_info(sig, &info, pid);
 }
 
Index: linux-2.6.15-rc1/kernel/sys.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/sys.c	2005-12-12 15:24:32.000000000 -0500
+++ linux-2.6.15-rc1/kernel/sys.c	2005-12-12 15:24:36.000000000 -0500
@@ -268,6 +268,8 @@ asmlinkage long sys_setpriority(int whic
 		case PRIO_PROCESS:
 			if (!who)
 				who = task_pid(current);
+			else
+				who = vpid_to_pid(who);
 			p = find_task_by_pid(who);
 			if (p)
 				error = set_one_prio(p, niceval, error);
@@ -275,6 +277,8 @@ asmlinkage long sys_setpriority(int whic
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
+			else
+				who = vpid_to_pid(who);
 			do_each_task_pid(who, PIDTYPE_PGID, p) {
 				error = set_one_prio(p, niceval, error);
 			} while_each_task_pid(who, PIDTYPE_PGID, p);
@@ -321,6 +325,8 @@ asmlinkage long sys_getpriority(int whic
 		case PRIO_PROCESS:
 			if (!who)
 				who = task_pid(current);
+			else
+				who = vpid_to_pid(who);
 			p = find_task_by_pid(who);
 			if (p) {
 				niceval = 20 - task_nice(p);
@@ -331,6 +337,8 @@ asmlinkage long sys_getpriority(int whic
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
+			else
+				who = vpid_to_pid(who);
 			do_each_task_pid(who, PIDTYPE_PGID, p) {
 				niceval = 20 - task_nice(p);
 				if (niceval > retval)
@@ -1087,8 +1095,12 @@ asmlinkage long sys_setpgid(pid_t pid, p
 
 	if (!pid)
 		pid = task_pid(current);
+	else
+		pid = vpid_to_pid(pid);
 	if (!pgid)
 		pgid = pid;
+	else
+		pgid = vpid_to_pid(pgid);
 	if (pgid < 0)
 		return -EINVAL;
 
@@ -1159,6 +1171,7 @@ asmlinkage long sys_getpgid(pid_t pid)
 		int retval;
 		struct task_struct *p;
 
+		pid = vpid_to_pid(pid);
 		read_lock(&tasklist_lock);
 		p = find_task_by_pid(pid);
 
@@ -1191,6 +1204,7 @@ asmlinkage long sys_getsid(pid_t pid)
 		int retval;
 		struct task_struct *p;
 
+		pid = vpid_to_pid(pid);
 		read_lock(&tasklist_lock);
 		p = find_task_by_pid(pid);
 
Index: linux-2.6.15-rc1/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/ptrace.c	2005-12-12 11:46:47.000000000 -0500
+++ linux-2.6.15-rc1/kernel/ptrace.c	2005-12-12 15:24:36.000000000 -0500
@@ -439,6 +439,7 @@ static int ptrace_get_task_struct(long r
 	/*
 	 * You may not mess with init
 	 */
+	pid = vpid_to_pid(pid);
 	if (pid == 1)
 		return -EPERM;
 

--
