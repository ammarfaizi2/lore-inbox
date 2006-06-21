Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWFUTUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWFUTUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWFUTUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:20:43 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:29873 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751236AbWFUTUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:20:43 -0400
Date: Wed, 21 Jun 2006 15:20:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Eric Paris <eparis@redhat.com>, David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 1/3] SELinux: Add security hook definitions for setmempolicy
Message-ID: <Pine.LNX.4.64.0606211517170.11782@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds new security hook definitions for the setmempolicy 
operation (currently unmediated by SELinux).  At present, the SELinux hook 
function implementation for this hook is identical to the setscheduler 
implementation, but a separate hook introduced to allow this check to be 
specialized in the future if necessary.

This patch is aimed at 2.6.18 inclusion.

Please apply.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>

---

 include/linux/security.h |   16 ++++++++++++++++
 security/dummy.c         |    6 ++++++
 security/selinux/hooks.c |    6 ++++++
 3 files changed, 28 insertions(+)

diff -purN -X dontdiff linux-2.6.17-mm1.p/include/linux/security.h linux-2.6.17-mm1.w/include/linux/security.h
--- linux-2.6.17-mm1.p/include/linux/security.h	2006-06-21 11:54:11.000000000 -0400
+++ linux-2.6.17-mm1.w/include/linux/security.h	2006-06-21 12:30:11.000000000 -0400
@@ -601,6 +601,11 @@ struct swap_info_struct;
  *	@p.
  *	@p contains the task_struct for process.
  *	Return 0 if permission is granted.
+ * @task_setmempolicy
+ *	Check permission before setting memory policy and/or parameters of
+ *	process @p.
+ *	@p contains the task_struct for process.
+ *	Return 0 if permission is granted.
  * @task_kill:
  *	Check permission before sending signal @sig to @p.  @info can be NULL,
  *	the constant 1, or a pointer to a siginfo structure.  If @info is 1 or
@@ -1221,6 +1226,7 @@ struct security_operations {
 	int (*task_setscheduler) (struct task_struct * p, int policy,
 				  struct sched_param * lp);
 	int (*task_getscheduler) (struct task_struct * p);
+	int (*task_setmempolicy) (struct task_struct * p); 
 	int (*task_kill) (struct task_struct * p,
 			  struct siginfo * info, int sig);
 	int (*task_wait) (struct task_struct * p);
@@ -1866,6 +1872,11 @@ static inline int security_task_getsched
 	return security_ops->task_getscheduler (p);
 }
 
+static inline int security_task_setmempolicy (struct task_struct *p)
+{
+	return security_ops->task_setmempolicy (p);
+}
+
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
@@ -2513,6 +2524,11 @@ static inline int security_task_getsched
 	return 0;
 }
 
+static inline int security_task_setmempolicy (struct task_struct *p)
+{
+	return 0;
+}
+
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
diff -purN -X dontdiff linux-2.6.17-mm1.p/security/dummy.c linux-2.6.17-mm1.w/security/dummy.c
--- linux-2.6.17-mm1.p/security/dummy.c	2006-06-21 11:54:12.000000000 -0400
+++ linux-2.6.17-mm1.w/security/dummy.c	2006-06-21 12:30:11.000000000 -0400
@@ -537,6 +537,11 @@ static int dummy_task_getscheduler (stru
 	return 0;
 }
 
+static int dummy_task_setmempolicy (struct task_struct *p)
+{
+	return 0;
+}
+
 static int dummy_task_wait (struct task_struct *p)
 {
 	return 0;
@@ -982,6 +987,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_setrlimit);
 	set_to_dummy_if_null(ops, task_setscheduler);
 	set_to_dummy_if_null(ops, task_getscheduler);
+	set_to_dummy_if_null(ops, task_setmempolicy);
 	set_to_dummy_if_null(ops, task_wait);
 	set_to_dummy_if_null(ops, task_kill);
 	set_to_dummy_if_null(ops, task_prctl);
diff -purN -X dontdiff linux-2.6.17-mm1.p/security/selinux/hooks.c linux-2.6.17-mm1.w/security/selinux/hooks.c
--- linux-2.6.17-mm1.p/security/selinux/hooks.c	2006-06-21 11:54:12.000000000 -0400
+++ linux-2.6.17-mm1.w/security/selinux/hooks.c	2006-06-21 12:30:11.000000000 -0400
@@ -2690,6 +2690,11 @@ static int selinux_task_getscheduler(str
 	return task_has_perm(current, p, PROCESS__GETSCHED);
 }
 
+static int selinux_task_setmempolicy(struct task_struct *p)
+{
+	return task_has_perm(current, p, PROCESS__SETSCHED);
+}
+
 static int selinux_task_kill(struct task_struct *p, struct siginfo *info, int sig)
 {
 	u32 perm;
@@ -4416,6 +4421,7 @@ static struct security_operations selinu
 	.task_setrlimit =		selinux_task_setrlimit,
 	.task_setscheduler =		selinux_task_setscheduler,
 	.task_getscheduler =		selinux_task_getscheduler,
+	.task_setmempolicy =		selinux_task_setmempolicy,
 	.task_kill =			selinux_task_kill,
 	.task_wait =			selinux_task_wait,
 	.task_prctl =			selinux_task_prctl,
