Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWAQOvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWAQOvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWAQOvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:51:18 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:41185 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751222AbWAQOub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:31 -0500
Message-Id: <20060117143327.996833000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:21 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 23/34] PID Virtualization Use vpid_to_pid functions
Content-Disposition: inline; filename=FA-vpid-to-pid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We now utilize the vpid_to_pid function where ever
a pid is passed from user space and needs to be converted 
into a kernel pid.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 arch/ia64/kernel/ptrace.c |    1 +
 arch/s390/kernel/ptrace.c |    1 +
 drivers/char/tty_io.c     |    1 +
 fs/proc/base.c            |    2 ++
 kernel/capability.c       |    1 +
 kernel/exit.c             |    2 ++
 kernel/ptrace.c           |    1 +
 kernel/sched.c            |    6 +++++-
 kernel/signal.c           |    7 +++++--
 kernel/sys.c              |   14 ++++++++++++++
 10 files changed, 33 insertions(+), 3 deletions(-)

Index: linux-2.6.15/arch/ia64/kernel/ptrace.c
===================================================================
--- linux-2.6.15.orig/arch/ia64/kernel/ptrace.c	2006-01-17 08:17:29.000000000 -0500
+++ linux-2.6.15/arch/ia64/kernel/ptrace.c	2006-01-17 08:37:06.000000000 -0500
@@ -1419,6 +1419,7 @@
 	struct switch_stack *sw;
 	long ret;
 
+	pid = vpid_to_pid(pid);
 	lock_kernel();
 	ret = -EPERM;
 	if (request == PTRACE_TRACEME) {
Index: linux-2.6.15/arch/s390/kernel/ptrace.c
===================================================================
--- linux-2.6.15.orig/arch/s390/kernel/ptrace.c	2006-01-17 08:17:29.000000000 -0500
+++ linux-2.6.15/arch/s390/kernel/ptrace.c	2006-01-17 08:37:06.000000000 -0500
@@ -711,6 +711,7 @@
 	struct task_struct *child;
 	int ret;
 
+	pid = vpid_to_pid(pid);
 	lock_kernel();
 
 	if (request == PTRACE_TRACEME) {
Index: linux-2.6.15/drivers/char/tty_io.c
===================================================================
--- linux-2.6.15.orig/drivers/char/tty_io.c	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/drivers/char/tty_io.c	2006-01-17 08:37:06.000000000 -0500
@@ -2176,6 +2176,7 @@
 		return -ENOTTY;
 	if (get_user(pgrp, p))
 		return -EFAULT;
+	pgrp = vpid_to_pid(pgrp);
 	if (pgrp < 0)
 		return -EINVAL;
 	if (session_of_pgrp(pgrp) != current->signal->session)
Index: linux-2.6.15/fs/proc/base.c
===================================================================
--- linux-2.6.15.orig/fs/proc/base.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/fs/proc/base.c	2006-01-17 08:37:06.000000000 -0500
@@ -1975,6 +1975,7 @@
 	tgid = name_to_int(dentry);
 	if (tgid == ~0U)
 		goto out;
+	tgid = vpid_to_pid(tgid);
 
 	read_lock(&tasklist_lock);
 	task = find_task_by_pid(tgid);
@@ -2032,6 +2033,7 @@
 	unsigned tid;
 
 	tid = name_to_int(dentry);
+	tid = vpid_to_pid(tid);
 	if (tid == ~0U)
 		goto out;
 
Index: linux-2.6.15/kernel/capability.c
===================================================================
--- linux-2.6.15.orig/kernel/capability.c	2006-01-17 08:36:59.000000000 -0500
+++ linux-2.6.15/kernel/capability.c	2006-01-17 08:37:06.000000000 -0500
@@ -63,6 +63,7 @@
      if (pid < 0) 
              return -EINVAL;
 
+     pid = vpid_to_pid(pid);
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock); 
 
Index: linux-2.6.15/kernel/exit.c
===================================================================
--- linux-2.6.15.orig/kernel/exit.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/kernel/exit.c	2006-01-17 08:37:06.000000000 -0500
@@ -1529,10 +1529,12 @@
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
Index: linux-2.6.15/kernel/sched.c
===================================================================
--- linux-2.6.15.orig/kernel/sched.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/kernel/sched.c	2006-01-17 08:37:06.000000000 -0500
@@ -3680,7 +3680,11 @@
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
Index: linux-2.6.15/kernel/signal.c
===================================================================
--- linux-2.6.15.orig/kernel/signal.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/kernel/signal.c	2006-01-17 08:37:06.000000000 -0500
@@ -1209,9 +1209,9 @@
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
 
@@ -2264,6 +2264,8 @@
 	info.si_pid = task_vtgid(current);
 	info.si_uid = current->uid;
 
+	pid  = vpid_to_pid(pid);
+	tgid = vpid_to_pid(tgid);
 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
 	if (p && (tgid <= 0 || task_tgid(p) == tgid)) {
@@ -2331,6 +2333,7 @@
 	info.si_signo = sig;
 
 	/* POSIX.1b doesn't mention process groups.  */
+	pid = vpid_to_pid(pid);
 	return kill_proc_info(sig, &info, pid);
 }
 
Index: linux-2.6.15/kernel/sys.c
===================================================================
--- linux-2.6.15.orig/kernel/sys.c	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/kernel/sys.c	2006-01-17 08:37:06.000000000 -0500
@@ -269,6 +269,8 @@
 		case PRIO_PROCESS:
 			if (!who)
 				who = task_pid(current);
+			else
+				who = vpid_to_pid(who);
 			p = find_task_by_pid(who);
 			if (p)
 				error = set_one_prio(p, niceval, error);
@@ -276,6 +278,8 @@
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
+			else
+				who = vpid_to_pid(who);
 			do_each_task_pid(who, PIDTYPE_PGID, p) {
 				error = set_one_prio(p, niceval, error);
 			} while_each_task_pid(who, PIDTYPE_PGID, p);
@@ -322,6 +326,8 @@
 		case PRIO_PROCESS:
 			if (!who)
 				who = task_pid(current);
+			else
+				who = vpid_to_pid(who);
 			p = find_task_by_pid(who);
 			if (p) {
 				niceval = 20 - task_nice(p);
@@ -332,6 +338,8 @@
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
+			else
+				who = vpid_to_pid(who);
 			do_each_task_pid(who, PIDTYPE_PGID, p) {
 				niceval = 20 - task_nice(p);
 				if (niceval > retval)
@@ -1088,8 +1096,12 @@
 
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
 
@@ -1160,6 +1172,7 @@
 		int retval;
 		struct task_struct *p;
 
+		pid = vpid_to_pid(pid);
 		read_lock(&tasklist_lock);
 		p = find_task_by_pid(pid);
 
@@ -1192,6 +1205,7 @@
 		int retval;
 		struct task_struct *p;
 
+		pid = vpid_to_pid(pid);
 		read_lock(&tasklist_lock);
 		p = find_task_by_pid(pid);
 
Index: linux-2.6.15/kernel/ptrace.c
===================================================================
--- linux-2.6.15.orig/kernel/ptrace.c	2006-01-17 08:36:59.000000000 -0500
+++ linux-2.6.15/kernel/ptrace.c	2006-01-17 08:37:06.000000000 -0500
@@ -440,6 +440,7 @@
 	/*
 	 * You may not mess with init
 	 */
+	pid = vpid_to_pid(pid);
 	if (pid == 1)
 		return -EPERM;
 

--

