Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWE3Ocs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWE3Ocs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWE3Ocs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:32:48 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:46816 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932292AbWE3Ocr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:32:47 -0400
Date: Tue, 30 May 2006 10:32:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH] lsm: add task_setioprio hook
Message-ID: <Pine.LNX.4.64.0605301031090.25929@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch which implements an LSM hook for setting a task's IO 
priority, similar to the hook for setting a tasks's nice value.

A previous version of this LSM hook was included in an older version of 
multiadm by Jan Engelhardt, although I don't recall it being submitted 
upstream.

Also included is the corresponding SELinux hook, which re-uses the 
setsched permission in the proccess class.

Please apply.

Signed-off-by: James Morris <jmorris@namei.org>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>


---

 fs/ioprio.c              |    6 ++++++
 include/linux/security.h |   16 ++++++++++++++++
 security/dummy.c         |    6 ++++++
 security/selinux/hooks.c |    6 ++++++
 4 files changed, 34 insertions(+)

diff -purN -X dontdiff linux-2.6.17-rc4-mm3.p/fs/ioprio.c linux-2.6.17-rc4-mm3.w/fs/ioprio.c
--- linux-2.6.17-rc4-mm3.p/fs/ioprio.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc4-mm3.w/fs/ioprio.c	2006-05-26 16:20:47.000000000 -0400
@@ -24,15 +24,21 @@
 #include <linux/blkdev.h>
 #include <linux/capability.h>
 #include <linux/syscalls.h>
+#include <linux/security.h>
 
 static int set_task_ioprio(struct task_struct *task, int ioprio)
 {
+	int err;
 	struct io_context *ioc;
 
 	if (task->uid != current->euid &&
 	    task->uid != current->uid && !capable(CAP_SYS_NICE))
 		return -EPERM;
 
+	err = security_task_setioprio(task, ioprio);
+	if (err)
+		return err;
+	
 	task_lock(task);
 
 	task->ioprio = ioprio;
diff -purN -X dontdiff linux-2.6.17-rc4-mm3.p/include/linux/security.h linux-2.6.17-rc4-mm3.w/include/linux/security.h
--- linux-2.6.17-rc4-mm3.p/include/linux/security.h	2006-05-22 09:36:49.000000000 -0400
+++ linux-2.6.17-rc4-mm3.w/include/linux/security.h	2006-05-26 16:20:47.000000000 -0400
@@ -577,6 +577,11 @@ struct swap_info_struct;
  *	@p contains the task_struct of process.
  *	@nice contains the new nice value.
  *	Return 0 if permission is granted.
+ * @task_setioprio
+ *	Check permission before setting the ioprio value of @p to @ioprio.
+ *	@p contains the task_struct of process.
+ *	@ioprio contains the new ioprio value
+ *	Return 0 if permission is granted.
  * @task_setrlimit:
  *	Check permission before setting the resource limits of the current
  *	process for @resource to @new_rlim.  The old resource limit values can
@@ -1204,6 +1209,7 @@ struct security_operations {
 	int (*task_getsid) (struct task_struct * p);
 	int (*task_setgroups) (struct group_info *group_info);
 	int (*task_setnice) (struct task_struct * p, int nice);
+	int (*task_setioprio) (struct task_struct * p, int ioprio);
 	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
 	int (*task_setscheduler) (struct task_struct * p, int policy,
 				  struct sched_param * lp);
@@ -1828,6 +1834,11 @@ static inline int security_task_setnice 
 	return security_ops->task_setnice (p, nice);
 }
 
+static inline int security_task_setioprio (struct task_struct *p, int ioprio)
+{
+	return security_ops->task_setioprio (p, ioprio);
+}
+
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
@@ -2470,6 +2481,11 @@ static inline int security_task_setnice 
 	return 0;
 }
 
+static inline int security_task_setioprio (struct task_struct *p, int ioprio)
+{
+	return 0;
+}
+
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
diff -purN -X dontdiff linux-2.6.17-rc4-mm3.p/security/dummy.c linux-2.6.17-rc4-mm3.w/security/dummy.c
--- linux-2.6.17-rc4-mm3.p/security/dummy.c	2006-05-22 09:36:49.000000000 -0400
+++ linux-2.6.17-rc4-mm3.w/security/dummy.c	2006-05-26 16:21:04.000000000 -0400
@@ -516,6 +516,11 @@ static int dummy_task_setnice (struct ta
 	return 0;
 }
 
+static int dummy_task_setioprio (struct task_struct *p, int ioprio)
+{
+	return 0;
+}
+
 static int dummy_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
 {
 	return 0;
@@ -962,6 +967,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_getsid);
 	set_to_dummy_if_null(ops, task_setgroups);
 	set_to_dummy_if_null(ops, task_setnice);
+	set_to_dummy_if_null(ops, task_setioprio);
 	set_to_dummy_if_null(ops, task_setrlimit);
 	set_to_dummy_if_null(ops, task_setscheduler);
 	set_to_dummy_if_null(ops, task_getscheduler);
diff -purN -X dontdiff linux-2.6.17-rc4-mm3.p/security/selinux/hooks.c linux-2.6.17-rc4-mm3.w/security/selinux/hooks.c
--- linux-2.6.17-rc4-mm3.p/security/selinux/hooks.c	2006-05-22 09:37:05.000000000 -0400
+++ linux-2.6.17-rc4-mm3.w/security/selinux/hooks.c	2006-05-26 16:20:48.000000000 -0400
@@ -2645,6 +2645,11 @@ static int selinux_task_setnice(struct t
 	return task_has_perm(current,p, PROCESS__SETSCHED);
 }
 
+static int selinux_task_setioprio(struct task_struct *p, int ioprio)
+{
+	return task_has_perm(current, p, PROCESS__SETSCHED);
+}
+
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
 	struct rlimit *old_rlim = current->signal->rlim + resource;
@@ -4332,6 +4337,7 @@ static struct security_operations selinu
 	.task_getsid =		        selinux_task_getsid,
 	.task_setgroups =		selinux_task_setgroups,
 	.task_setnice =			selinux_task_setnice,
+	.task_setioprio =		selinux_task_setioprio,
 	.task_setrlimit =		selinux_task_setrlimit,
 	.task_setscheduler =		selinux_task_setscheduler,
 	.task_getscheduler =		selinux_task_getscheduler,
