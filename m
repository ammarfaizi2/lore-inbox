Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269405AbUJFTOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269405AbUJFTOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269399AbUJFTOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:14:07 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:8383 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269398AbUJFTN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:13:56 -0400
Subject: (patch 1/3) lsm: add control over /proc/<pid> visibility
From: Serge Hallyn <serue@us.ibm.com>
To: akpm@osdl.org, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Cc: serue@us.ibm.com
Content-Type: text/plain
Message-Id: <1097094103.6939.5.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 06 Oct 2004 15:21:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attached is a patch which introduces a new LSM hook,
security_task_lookup. This hook allows an LSM to mediate visibility of
/proc/<pid> on a per-pid level.  The bsdjail lsm which will be sent
next is a user of this hook.

Please apply.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

diff -Nrup linux-2.6.9-rc3-bk6/fs/proc/base.c
linux-2.6.9-rc3-bk6-jail/fs/proc/base.c
--- linux-2.6.9-rc3-bk6/fs/proc/base.c	2004-10-06 10:07:55.000000000
-0500
+++ linux-2.6.9-rc3-bk6-jail/fs/proc/base.c	2004-10-06
10:51:04.000000000 -0500
@@ -1683,6 +1683,8 @@ static int get_tgid_list(int index, unsi
 		int tgid = p->pid;
 		if (!pid_alive(p))
 			continue;
+		if (security_task_lookup(p))
+			continue;
 		if (--index >= 0)
 			continue;
 		tgids[nr_tgids] = tgid;
diff -Nrup linux-2.6.9-rc3-bk6/include/linux/security.h
linux-2.6.9-rc3-bk6-jail/include/linux/security.h
--- linux-2.6.9-rc3-bk6/include/linux/security.h	2004-08-14
00:37:30.000000000 -0500
+++ linux-2.6.9-rc3-bk6-jail/include/linux/security.h	2004-10-06
10:51:04.000000000 -0500
@@ -627,6 +627,11 @@ struct swap_info_struct;
  * 	Set the security attributes in @p->security for a kernel thread
that
  * 	is being reparented to the init task.
  *	@p contains the task_struct for the kernel thread.
+ * @task_lookup:
+ *	Check permission to see the /proc/<pid> entry for process @p.
+ *	@p contains the task_struct for task <pid> which is being looked
+ *	up under /proc
+ *	return 0 if permission is granted.
  * @task_to_inode:
  * 	Set the security attributes for an inode based on an associated
task's
  * 	security attributes, e.g. for /proc/pid inodes.
@@ -1152,6 +1157,7 @@ struct security_operations {
 			   unsigned long arg3, unsigned long arg4,
 			   unsigned long arg5);
 	void (*task_reparent_to_init) (struct task_struct * p);
+	int (*task_lookup)(struct task_struct *p);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
@@ -1751,6 +1757,11 @@ static inline void security_task_reparen
 	security_ops->task_reparent_to_init (p);
 }
 
+static inline int security_task_lookup(struct task_struct *p)
+{
+	return security_ops->task_lookup(p);
+}
+
 static inline void security_task_to_inode(struct task_struct *p, struct
inode *inode)
 {
 	security_ops->task_to_inode(p, inode);
@@ -2386,6 +2397,11 @@ static inline void security_task_reparen
 	cap_task_reparent_to_init (p);
 }
 
+static inline int security_task_lookup(struct task_struct *p)
+{
+	return 0;
+}
+
 static inline void security_task_to_inode(struct task_struct *p, struct
inode *inode)
 { }
 
diff -Nrup linux-2.6.9-rc3-bk6/security/dummy.c
linux-2.6.9-rc3-bk6-jail/security/dummy.c
--- linux-2.6.9-rc3-bk6/security/dummy.c	2004-10-06 10:11:29.000000000
-0500
+++ linux-2.6.9-rc3-bk6-jail/security/dummy.c	2004-10-06
10:51:04.000000000 -0500
@@ -616,6 +616,11 @@ static void dummy_task_reparent_to_init 
 	return;
 }
 
+static int dummy_task_lookup(struct task_struct *p)
+{
+	return 0;
+}
+
 static void dummy_task_to_inode(struct task_struct *p, struct inode
*inode)
 { }
 
@@ -978,6 +983,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_kill);
 	set_to_dummy_if_null(ops, task_prctl);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
+ 	set_to_dummy_if_null(ops, task_lookup);
  	set_to_dummy_if_null(ops, task_to_inode);
 	set_to_dummy_if_null(ops, ipc_permission);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);


