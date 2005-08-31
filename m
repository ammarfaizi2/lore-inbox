Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVHaMvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVHaMvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVHaMvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:51:24 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:11005
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S964782AbVHaMvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:51:23 -0400
Subject: Re: [PATCH 2.6.13 1/2] New Syscall: get/set rlimits of any process
	(udate)
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1125492405.5810.5.camel@w2>
References: <1125027277.6394.8.camel@w2>  <1125492405.5810.5.camel@w2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Aug 2005 14:51:06 +0200
Message-Id: <1125492666.5810.8.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch for the getprlimit() syscall:


Signed-off-by: Wieland Gmeiner <e8607062@student.tuwien.ac.at>



---

 arch/i386/kernel/syscall_table.S |    1 
 include/asm-i386/unistd.h        |    3 -
 include/linux/security.h         |   25 ++++++-----
 kernel/sys.c                     |   85 +++++++++++++++++++++++++++++++++------
 security/dummy.c                 |    5 +-
 security/selinux/hooks.c         |   17 +++++--
 6 files changed, 107 insertions(+), 29 deletions(-)

diff -puN arch/i386/kernel/syscall_table.S~getprlimit arch/i386/kernel/syscall_table.S
--- linux-2.6.13/arch/i386/kernel/syscall_table.S~getprlimit	2005-08-31 02:09:48.000000000 +0200
+++ linux-2.6.13-wieland/arch/i386/kernel/syscall_table.S	2005-08-31 02:29:57.000000000 +0200
@@ -294,3 +294,4 @@ ENTRY(sys_call_table)
 	.long sys_inotify_init
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_getprlimit
diff -puN include/asm-i386/unistd.h~getprlimit include/asm-i386/unistd.h
--- linux-2.6.13/include/asm-i386/unistd.h~getprlimit	2005-08-31 02:09:48.000000000 +0200
+++ linux-2.6.13-wieland/include/asm-i386/unistd.h	2005-08-31 02:30:43.000000000 +0200
@@ -299,8 +299,9 @@
 #define __NR_inotify_init	291
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
+#define __NR_getprlimit		294
 
-#define NR_syscalls 294
+#define NR_syscalls 295
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -puN include/linux/security.h~getprlimit include/linux/security.h
--- linux-2.6.13/include/linux/security.h~getprlimit	2005-08-31 02:09:48.000000000 +0200
+++ linux-2.6.13-wieland/include/linux/security.h	2005-08-31 02:37:52.000000000 +0200
@@ -584,10 +584,12 @@ struct swap_info_struct;
  *	@p contains the task_struct of process.
  *	@nice contains the new nice value.
  *	Return 0 if permission is granted.
- * @task_setrlimit:
- *	Check permission before setting the resource limits of the current
- *	process for @resource to @new_rlim.  The old resource limit values can
- *	be examined by dereferencing (current->signal->rlim + resource).
+ * @task_rlimit:
+ *	Check permission before reading the resource limits of the process @p
+ *	for @resource or setting the limits to @new_rlim.  The old resource
+ *	limit values can be examined by dereferencing
+ *	(p->signal->rlim + resource).
+ *	@p contains the task_struct for the process.
  *	@resource contains the resource whose limit is being set.
  *	@new_rlim contains the new limits for @resource.
  *	Return 0 if permission is granted.
@@ -1156,7 +1158,8 @@ struct security_operations {
 	int (*task_getsid) (struct task_struct * p);
 	int (*task_setgroups) (struct group_info *group_info);
 	int (*task_setnice) (struct task_struct * p, int nice);
-	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
+	int (*task_rlimit) (struct task_struct * p, unsigned int resource,
+			    struct rlimit * new_rlim);
 	int (*task_setscheduler) (struct task_struct * p, int policy,
 				  struct sched_param * lp);
 	int (*task_getscheduler) (struct task_struct * p);
@@ -1798,10 +1801,11 @@ static inline int security_task_setnice 
 	return security_ops->task_setnice (p, nice);
 }
 
-static inline int security_task_setrlimit (unsigned int resource,
-					   struct rlimit *new_rlim)
+static inline int security_task_rlimit (struct task_struct *p,
+					unsigned int resource,
+					struct rlimit *new_rlim)
 {
-	return security_ops->task_setrlimit (resource, new_rlim);
+	return security_ops->task_rlimit (p, resource, new_rlim);
 }
 
 static inline int security_task_setscheduler (struct task_struct *p,
@@ -2447,8 +2451,9 @@ static inline int security_task_setnice 
 	return 0;
 }
 
-static inline int security_task_setrlimit (unsigned int resource,
-					   struct rlimit *new_rlim)
+static inline int security_task_rlimit (struct task_struct *p,
+					unsigned int resource,
+					struct rlimit *new_rlim)
 {
 	return 0;
 }
diff -puN kernel/sys.c~getprlimit kernel/sys.c
--- linux-2.6.13/kernel/sys.c~getprlimit	2005-08-31 02:09:48.000000000 +0200
+++ linux-2.6.13-wieland/kernel/sys.c	2005-08-31 02:42:12.000000000 +0200
@@ -1524,17 +1524,80 @@ asmlinkage long sys_setdomainname(char _
 	return errno;
 }
 
-asmlinkage long sys_getrlimit(unsigned int resource, struct rlimit __user *rlim)
+/*
+ * get/setprlimit()
+ *
+ * As ptrace implies the ability to execute arbitrary code in the given
+ * process, which means that the calling process could obtain and set
+ * rlimits for that process without getprlimit/setprlimit anyways,
+ * we use the same permission checks as ptrace.
+ */
+static inline int prlim_check_perm(task_t *task)
 {
-	if (resource >= RLIM_NLIMITS)
-		return -EINVAL;
-	else {
-		struct rlimit value;
-		task_lock(current->group_leader);
-		value = current->signal->rlim[resource];
-		task_unlock(current->group_leader);
-		return copy_to_user(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;
+	return ((current->uid == task->euid) &&
+		(current->uid == task->suid) &&
+		(current->uid == task->uid) &&
+		(current->gid == task->egid) &&
+		(current->gid == task->sgid) &&
+		(current->gid == task->gid)) || capable(CAP_SYS_PTRACE);
+}
+
+static inline long rlim_do_getprlimit(pid_t pid, unsigned int resource,
+				      struct rlimit __user *rlim)
+{
+	struct rlimit value;
+	task_t *p;
+	int retval = -EINVAL;
+
+ 	if (resource >= RLIM_NLIMITS)
+		goto out;
+
+	if (pid < 0)
+		goto out;
+
+	retval = -ESRCH;
+	read_lock(&tasklist_lock);
+	if (!pid) {
+		p = current;
+	} else {
+		p = find_task_by_pid(pid);
 	}
+	if (p) {
+		retval = -EPERM;
+		if (pid && !prlim_check_perm(p))
+			goto unlock_out;
+		if (pid) {
+			retval = security_task_rlimit(p, resource, 0);
+			if (retval)
+				goto unlock_out;
+		}
+		task_lock(p->group_leader);
+		value = p->signal->rlim[resource];
+		task_unlock(p->group_leader);
+	} else
+		goto unlock_out;
+
+	read_unlock(&tasklist_lock);
+
+	retval = copy_to_user(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;
+
+out:
+	return retval;
+
+unlock_out:
+	read_unlock(&tasklist_lock);
+	return retval;
+}
+
+asmlinkage long sys_getprlimit(pid_t pid, unsigned int resource,
+			       struct rlimit __user *rlim)
+{
+	return rlim_do_getprlimit(pid, resource, rlim);
+}
+
+asmlinkage long sys_getrlimit(unsigned int resource, struct rlimit __user *rlim)
+{
+	return rlim_do_getprlimit(0, resource, rlim);
 }
 
 #ifdef __ARCH_WANT_SYS_OLD_GETRLIMIT
@@ -1542,7 +1605,7 @@ asmlinkage long sys_getrlimit(unsigned i
 /*
  *	Back compatibility for getrlimit. Needed for some apps.
  */
- 
+
 asmlinkage long sys_old_getrlimit(unsigned int resource, struct rlimit __user *rlim)
 {
 	struct rlimit x;
@@ -1579,7 +1642,7 @@ asmlinkage long sys_setrlimit(unsigned i
 	if (resource == RLIMIT_NOFILE && new_rlim.rlim_max > NR_OPEN)
 			return -EPERM;
 
-	retval = security_task_setrlimit(resource, &new_rlim);
+	retval = security_task_rlimit(0, resource, &new_rlim);
 	if (retval)
 		return retval;
 
diff -puN security/dummy.c~getprlimit security/dummy.c
--- linux-2.6.13/security/dummy.c~getprlimit	2005-08-31 02:09:48.000000000 +0200
+++ linux-2.6.13-wieland/security/dummy.c	2005-08-31 02:44:06.000000000 +0200
@@ -543,7 +543,8 @@ static int dummy_task_setnice (struct ta
 	return 0;
 }
 
-static int dummy_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
+static int dummy_task_rlimit (struct task_struct *p, unsigned int resource,
+			      struct rlimit *new_rlim)
 {
 	return 0;
 }
@@ -936,7 +937,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_getsid);
 	set_to_dummy_if_null(ops, task_setgroups);
 	set_to_dummy_if_null(ops, task_setnice);
-	set_to_dummy_if_null(ops, task_setrlimit);
+	set_to_dummy_if_null(ops, task_rlimit);
 	set_to_dummy_if_null(ops, task_setscheduler);
 	set_to_dummy_if_null(ops, task_getscheduler);
 	set_to_dummy_if_null(ops, task_wait);
diff -puN security/selinux/hooks.c~getprlimit security/selinux/hooks.c
--- linux-2.6.13/security/selinux/hooks.c~getprlimit	2005-08-31 02:09:48.000000000 +0200
+++ linux-2.6.13-wieland/security/selinux/hooks.c	2005-08-31 02:47:10.000000000 +0200
@@ -2703,20 +2703,27 @@ static int selinux_task_setnice(struct t
 	return task_has_perm(current,p, PROCESS__SETSCHED);
 }
 
-static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
+static int selinux_task_rlimit(struct task_struct *p,
+			       unsigned int resource,
+			       struct rlimit *new_rlim)
 {
-	struct rlimit *old_rlim = current->signal->rlim + resource;
+	struct rlimit *old_rlim = p->signal->rlim + resource;
 	int rc;
 
-	rc = secondary_ops->task_setrlimit(resource, new_rlim);
+	if (!new_rlim)
+		rc = secondary_ops->task_rlimit(p, resource, 0);
+	else
+		rc = secondary_ops->task_rlimit(0, resource, new_rlim);
 	if (rc)
 		return rc;
 
+	if (!new_rlim)
+		return task_has_perm(current, p, PROCESS__PTRACE);
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
 	   later be used as a safe reset point for the soft limit
 	   upon context transitions. See selinux_bprm_apply_creds. */
-	if (old_rlim->rlim_max != new_rlim->rlim_max)
+	else if (p == current && old_rlim->rlim_max != new_rlim->rlim_max)
 		return task_has_perm(current, current, PROCESS__SETRLIMIT);
 
 	return 0;
@@ -4349,7 +4356,7 @@ static struct security_operations selinu
 	.task_getsid =		        selinux_task_getsid,
 	.task_setgroups =		selinux_task_setgroups,
 	.task_setnice =			selinux_task_setnice,
-	.task_setrlimit =		selinux_task_setrlimit,
+	.task_rlimit =			selinux_task_rlimit,
 	.task_setscheduler =		selinux_task_setscheduler,
 	.task_getscheduler =		selinux_task_getscheduler,
 	.task_kill =			selinux_task_kill,
_

