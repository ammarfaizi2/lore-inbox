Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWF2VFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWF2VFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWF2VFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:05:07 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:65202 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932639AbWF2VFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:05:00 -0400
Date: Thu, 29 Jun 2006 17:04:58 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       David Quigley <dpquigl@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: Add security hook definition for getioprio and
 insert hooks
Message-ID: <Pine.LNX.4.64.0606291702380.26876@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dpquigl@tycho.nsa.gov>
 
This patch adds a new security hook definition for the sys_ioprio_get 
operation. At present, the SELinux hook function implementation for this 
hook is identical to the getscheduler implementation but a separate hook 
is introduced to allow this check to be specialized in the future if 
necessary. This patch also creates a helper function get_task_ioprio which 
handles the access check in addition to retrieving the ioprio value for 
the task.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>


Please apply.

---

 fs/ioprio.c              |   29 ++++++++++++++++++++++++-----
 include/linux/security.h |   15 +++++++++++++++
 security/dummy.c         |    6 ++++++
 security/selinux/hooks.c |    6 ++++++
 4 files changed, 51 insertions(+), 5 deletions(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/fs/ioprio.c linux-2.6.17-mm3-ioprio/fs/ioprio.c
--- linux-2.6.17-mm3/fs/ioprio.c	2006-06-28 13:58:56.000000000 -0400
+++ linux-2.6.17-mm3-ioprio/fs/ioprio.c	2006-06-29 15:58:29.000000000 -0400
@@ -125,11 +125,24 @@ asmlinkage long sys_ioprio_set(int which
 	return ret;
 }
 
+static int get_task_ioprio(struct task_struct *p)
+{
+	int ret;
+
+	ret = security_task_getioprio(p);
+	if (ret)
+		goto out;
+	ret = p->ioprio;
+out:
+	return ret;
+}
+
 asmlinkage long sys_ioprio_get(int which, int who)
 {
 	struct task_struct *g, *p;
 	struct user_struct *user;
 	int ret = -ESRCH;
+	int tmpio;
 
 	read_lock_irq(&tasklist_lock);
 	switch (which) {
@@ -139,16 +152,19 @@ asmlinkage long sys_ioprio_get(int which
 			else
 				p = find_task_by_pid(who);
 			if (p)
-				ret = p->ioprio;
+				ret = get_task_ioprio(p);
 			break;
 		case IOPRIO_WHO_PGRP:
 			if (!who)
 				who = process_group(current);
 			do_each_task_pid(who, PIDTYPE_PGID, p) {
+				tmpio = get_task_ioprio(p);
+				if (tmpio < 0)
+					continue;
 				if (ret == -ESRCH)
-					ret = p->ioprio;
+					ret = tmpio;
 				else
-					ret = ioprio_best(ret, p->ioprio);
+					ret = ioprio_best(ret, tmpio);
 			} while_each_task_pid(who, PIDTYPE_PGID, p);
 			break;
 		case IOPRIO_WHO_USER:
@@ -163,10 +179,13 @@ asmlinkage long sys_ioprio_get(int which
 			do_each_thread(g, p) {
 				if (p->uid != user->uid)
 					continue;
+				tmpio = get_task_ioprio(p);
+				if (tmpio < 0)
+					continue;
 				if (ret == -ESRCH)
-					ret = p->ioprio;
+					ret = tmpio;
 				else
-					ret = ioprio_best(ret, p->ioprio);
+					ret = ioprio_best(ret, tmpio);
 			} while_each_thread(g, p);
 
 			if (who)
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/include/linux/security.h linux-2.6.17-mm3-ioprio/include/linux/security.h
--- linux-2.6.17-mm3/include/linux/security.h	2006-06-28 13:58:59.000000000 -0400
+++ linux-2.6.17-mm3-ioprio/include/linux/security.h	2006-06-28 11:21:37.000000000 -0400
@@ -582,6 +582,10 @@ struct swap_info_struct;
  *	@p contains the task_struct of process.
  *	@ioprio contains the new ioprio value
  *	Return 0 if permission is granted.
+ * @task_getioprio
+ *	Check permission before getting the ioprio value of @p.
+ *	@p contains the task_struct of process.
+ *	Return 0 if permission is granted.
  * @task_setrlimit:
  *	Check permission before setting the resource limits of the current
  *	process for @resource to @new_rlim.  The old resource limit values can
@@ -1221,6 +1225,7 @@ struct security_operations {
 	int (*task_setgroups) (struct group_info *group_info);
 	int (*task_setnice) (struct task_struct * p, int nice);
 	int (*task_setioprio) (struct task_struct * p, int ioprio);
+	int (*task_getioprio) (struct task_struct * p);
 	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
 	int (*task_setscheduler) (struct task_struct * p, int policy,
 				  struct sched_param * lp);
@@ -1853,6 +1858,11 @@ static inline int security_task_setiopri
 	return security_ops->task_setioprio (p, ioprio);
 }
 
+static inline int security_task_getioprio (struct task_struct *p)
+{
+	return security_ops->task_getioprio (p);
+}
+
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
@@ -2505,6 +2515,11 @@ static inline int security_task_setiopri
 	return 0;
 }
 
+static inline int security_task_getioprio (struct task_struct *p)
+{
+	return 0;
+}
+
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/dummy.c linux-2.6.17-mm3-ioprio/security/dummy.c
--- linux-2.6.17-mm3/security/dummy.c	2006-06-28 13:58:59.000000000 -0400
+++ linux-2.6.17-mm3-ioprio/security/dummy.c	2006-06-28 11:23:00.000000000 -0400
@@ -521,6 +521,11 @@ static int dummy_task_setioprio (struct 
 	return 0;
 }
 
+static int dummy_task_getioprio (struct task_struct *p)
+{
+	return 0;
+}
+
 static int dummy_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
 {
 	return 0;
@@ -984,6 +989,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_setgroups);
 	set_to_dummy_if_null(ops, task_setnice);
 	set_to_dummy_if_null(ops, task_setioprio);
+	set_to_dummy_if_null(ops, task_getioprio);
 	set_to_dummy_if_null(ops, task_setrlimit);
 	set_to_dummy_if_null(ops, task_setscheduler);
 	set_to_dummy_if_null(ops, task_getscheduler);
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/selinux/hooks.c linux-2.6.17-mm3-ioprio/security/selinux/hooks.c
--- linux-2.6.17-mm3/security/selinux/hooks.c	2006-06-28 13:58:59.000000000 -0400
+++ linux-2.6.17-mm3-ioprio/security/selinux/hooks.c	2006-06-28 11:49:13.000000000 -0400
@@ -2665,6 +2665,11 @@ static int selinux_task_setioprio(struct
 	return task_has_perm(current, p, PROCESS__SETSCHED);
 }
 
+static int selinux_task_getioprio(struct task_struct *p)
+{
+	return task_has_perm(current, p, PROCESS__GETSCHED);
+}
+
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
 	struct rlimit *old_rlim = current->signal->rlim + resource;
@@ -4432,6 +4437,7 @@ static struct security_operations selinu
 	.task_setgroups =		selinux_task_setgroups,
 	.task_setnice =			selinux_task_setnice,
 	.task_setioprio =		selinux_task_setioprio,
+	.task_getioprio =		selinux_task_getioprio,
 	.task_setrlimit =		selinux_task_setrlimit,
 	.task_setscheduler =		selinux_task_setscheduler,
 	.task_getscheduler =		selinux_task_getscheduler,
