Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUIJTPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUIJTPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUIJTPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:15:13 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6058 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267804AbUIJTOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:14:35 -0400
Subject: [PATCH] BSD Jail LSM (1/3)
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, serue@us.ibm.com
Content-Type: multipart/mixed; boundary="=-ZztGpz182ffO5x8J7wJi"
Message-Id: <1094847705.2188.94.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 10 Sep 2004 15:21:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZztGpz182ffO5x8J7wJi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch which introduces a new LSM hook,
security_task_lookup.  This hook allows an LSM to mediate visibility of
/proc/<pid> on a per-process level.  It applies cleanly to 2.6.8.1 and
has been tested on xSeries, pSeries, and zSeries.  The bsdjail lsm which
will be sent next is a user of this hook.

Please apply.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

-serge


--=-ZztGpz182ffO5x8J7wJi
Content-Disposition: attachment; filename=tasklookup.diff
Content-Type: text/x-patch; name=tasklookup.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nru linux-2.6.8.1/fs/proc/base.c linux-2.6.8.1-jail/fs/proc/base.c
--- linux-2.6.8.1/fs/proc/base.c	2004-08-14 05:55:35.000000000 -0500
+++ linux-2.6.8.1-jail/fs/proc/base.c	2004-09-01 04:42:26.000000000 -0500
@@ -1679,6 +1679,8 @@
 		int tgid = p->pid;
 		if (!pid_alive(p))
 			continue;
+		if (security_task_lookup(p))
+			continue;
 		if (--index >= 0)
 			continue;
 		tgids[nr_tgids] = tgid;
diff -Nru linux-2.6.8.1/include/linux/security.h linux-2.6.8.1-jail/include/linux/security.h
--- linux-2.6.8.1/include/linux/security.h	2004-08-14 05:55:48.000000000 -0500
+++ linux-2.6.8.1-jail/include/linux/security.h	2004-09-01 04:42:26.000000000 -0500
@@ -627,6 +627,11 @@
  * 	Set the security attributes in @p->security for a kernel thread that
  * 	is being reparented to the init task.
  *	@p contains the task_struct for the kernel thread.
+ * @task_lookup:
+ *	Check permission to see the /proc/<pid> entry for process @p.
+ *	@p contains the task_struct for task <pid> which is being looked
+ *	up under /proc
+ *	return 0 if permission is granted.
  * @task_to_inode:
  * 	Set the security attributes for an inode based on an associated task's
  * 	security attributes, e.g. for /proc/pid inodes.
@@ -1152,6 +1157,7 @@
 			   unsigned long arg3, unsigned long arg4,
 			   unsigned long arg5);
 	void (*task_reparent_to_init) (struct task_struct * p);
+	int (*task_lookup)(struct task_struct *p);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
@@ -1751,6 +1757,11 @@
 	security_ops->task_reparent_to_init (p);
 }
 
+static inline int security_task_lookup(struct task_struct *p)
+{
+	return security_ops->task_lookup(p);
+}
+
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 {
 	security_ops->task_to_inode(p, inode);
@@ -2386,6 +2397,11 @@
 	cap_task_reparent_to_init (p);
 }
 
+static inline int security_task_lookup(struct task_struct *p)
+{
+	return 0;
+}
+
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
diff -Nru linux-2.6.8.1/security/dummy.c linux-2.6.8.1-jail/security/dummy.c
--- linux-2.6.8.1/security/dummy.c	2004-08-14 05:54:51.000000000 -0500
+++ linux-2.6.8.1-jail/security/dummy.c	2004-09-01 04:42:26.000000000 -0500
@@ -616,6 +616,11 @@
 	return;
 }
 
+static int dummy_task_lookup(struct task_struct *p)
+{
+	return 0;
+}
+
 static void dummy_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
@@ -978,6 +983,7 @@
 	set_to_dummy_if_null(ops, task_kill);
 	set_to_dummy_if_null(ops, task_prctl);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
+ 	set_to_dummy_if_null(ops, task_lookup);
  	set_to_dummy_if_null(ops, task_to_inode);
 	set_to_dummy_if_null(ops, ipc_permission);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);

--=-ZztGpz182ffO5x8J7wJi--

