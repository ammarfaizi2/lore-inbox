Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWHOSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWHOSXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWHOSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:23:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14046 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030440AbWHOSXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:23:33 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/7] pid: Implement signal functions that take a struct pid *
Date: Tue, 15 Aug 2006 12:23:08 -0600
Message-Id: <11556661932938-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the signal functions all either take a task or
a pid_t argument.  This patch implements variants that take
a struct pid *.  After all of the users have been update
it is my intention to remove the variants that take a pid_t
as using pid_t can be more work (an extra hash table lookup)
and difficult to get right in the presence of multiple pid
namespaces.

There are two kinds of functions introduced in this patch.  The
are the general use functions kill_pgrp and kill_pid which take
a priv argument that is ultimately used to create the appropriate
siginfo information,  Then there are _kill_pgrp_info, kill_pgrp_info,
kill_pid_info the internal implementation helpers that take an
explicit siginfo.

The distinction is made because filling out an explcit siginfo is
tricky, and will be even more tricky when pid namespaces are introduced.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sched.h |    5 ++++
 kernel/signal.c       |   57 ++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6560dd3..e7d7bad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1290,6 +1290,11 @@ extern int send_sig_info(int, struct sig
 extern int send_group_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sigsegv(int, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
+extern int __kill_pgrp_info(int sig, struct siginfo *info, struct pid *pgrp);
+extern int kill_pgrp_info(int sig, struct siginfo *info, struct pid *pgrp);
+extern int kill_pid_info(int sig, struct siginfo *info, struct pid *pid);
+extern int kill_pgrp(struct pid *pid, int sig, int priv);
+extern int kill_pid(struct pid *pid, int sig, int priv);
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
diff --git a/kernel/signal.c b/kernel/signal.c
index c476195..9eecb2f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1181,28 +1181,44 @@ int group_send_sig_info(int sig, struct 
 }
 
 /*
- * kill_pg_info() sends a signal to a process group: this is what the tty
+ * kill_pgrp_info() sends a signal to a process group: this is what the tty
  * control characters do (^C, ^Z etc)
  */
 
-int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
+int __kill_pgrp_info(int sig, struct siginfo *info, struct pid *pgrp)
 {
 	struct task_struct *p = NULL;
 	int retval, success;
 
-	if (pgrp <= 0)
-		return -EINVAL;
-
 	success = 0;
 	retval = -ESRCH;
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
 		int err = group_send_sig_info(sig, info, p);
 		success |= !err;
 		retval = err;
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
+	} while_each_pid_task(pgrp, PIDTYPE_PGID, p);
 	return success ? 0 : retval;
 }
 
+int kill_pgrp_info(int sig, struct siginfo *info, struct pid *pgrp)
+{
+	int retval;
+
+	read_lock(&tasklist_lock);
+	retval = __kill_pgrp_info(sig, info, pgrp);
+	read_unlock(&tasklist_lock);
+
+	return retval;
+}
+
+int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
+{
+	if (pgrp <= 0)
+		return -EINVAL;
+
+	return __kill_pgrp_info(sig, info, find_pid(pgrp));
+}
+
 int
 kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
 {
@@ -1215,8 +1231,7 @@ kill_pg_info(int sig, struct siginfo *in
 	return retval;
 }
 
-int
-kill_proc_info(int sig, struct siginfo *info, pid_t pid)
+int kill_pid_info(int sig, struct siginfo *info, struct pid *pid)
 {
 	int error;
 	int acquired_tasklist_lock = 0;
@@ -1227,7 +1242,7 @@ kill_proc_info(int sig, struct siginfo *
 		read_lock(&tasklist_lock);
 		acquired_tasklist_lock = 1;
 	}
-	p = find_task_by_pid(pid);
+	p = pid_task(pid, PIDTYPE_PID);
 	error = -ESRCH;
 	if (p)
 		error = group_send_sig_info(sig, info, p);
@@ -1237,6 +1252,16 @@ kill_proc_info(int sig, struct siginfo *
 	return error;
 }
 
+int
+kill_proc_info(int sig, struct siginfo *info, pid_t pid)
+{
+	int error;
+	rcu_read_lock();
+	error = kill_pid_info(sig, info, find_pid(pid));
+	rcu_read_unlock();
+	return error;
+}
+
 /* like kill_proc_info(), but doesn't use uid/euid of "current" */
 int kill_proc_info_as_uid(int sig, struct siginfo *info, pid_t pid,
 		      uid_t uid, uid_t euid, u32 secid)
@@ -1390,6 +1415,18 @@ force_sigsegv(int sig, struct task_struc
 	return 0;
 }
 
+int kill_pgrp(struct pid *pid, int sig, int priv)
+{
+	return kill_pgrp_info(sig, __si_special(priv), pid);
+}
+EXPORT_SYMBOL(kill_pgrp);
+
+int kill_pid(struct pid *pid, int sig, int priv)
+{
+	return kill_pid_info(sig, __si_special(priv), pid);
+}
+EXPORT_SYMBOL(kill_pid);
+
 int
 kill_pg(pid_t pgrp, int sig, int priv)
 {
-- 
1.4.2.rc3.g7e18e-dirty

