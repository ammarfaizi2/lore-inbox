Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbUKDWZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbUKDWZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbUKDWYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:24:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:60854 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262474AbUKDWEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:04:22 -0500
Subject: Re: [RFC] [PATCH] [1/3] LSM Stacking: stackable bsdjail
	(tasklookup)
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1099610069.2096.29.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:14:34 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next three patches add bsdjail as another example of stacking
LSMs.  This patch adds the security_task_lookup hook required for
bsdjail.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc1-bk14/fs/proc/base.c
===================================================================
--- linux-2.6.10-rc1-bk14.orig/fs/proc/base.c	2004-11-04
12:28:00.402094432 -0600
+++ linux-2.6.10-rc1-bk14/fs/proc/base.c	2004-11-04 12:31:28.974386624
-0600
@@ -1687,6 +1687,8 @@
 		int tgid = p->pid;
 		if (!pid_alive(p))
 			continue;
+		if (security_task_lookup(p))
+			continue;
 		if (--index >= 0)
 			continue;
 		tgids[nr_tgids] = tgid;
Index: linux-2.6.10-rc1-bk14/include/linux/security.h
===================================================================
--- linux-2.6.10-rc1-bk14.orig/include/linux/security.h	2004-11-04
12:28:12.736219360 -0600
+++ linux-2.6.10-rc1-bk14/include/linux/security.h	2004-11-04
12:31:28.977386168 -0600
@@ -623,6 +623,11 @@
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
@@ -1154,6 +1159,7 @@
 			   unsigned long arg3, unsigned long arg4,
 			   unsigned long arg5);
 	void (*task_reparent_to_init) (struct task_struct * p);
+	int (*task_lookup)(struct task_struct *p);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
@@ -1759,6 +1765,11 @@
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
@@ -2399,6 +2410,11 @@
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
 
Index: linux-2.6.10-rc1-bk14/security/dummy.c
===================================================================
--- linux-2.6.10-rc1-bk14.orig/security/dummy.c	2004-11-04
12:28:13.741066600 -0600
+++ linux-2.6.10-rc1-bk14/security/dummy.c	2004-11-04 12:31:28.979385864
-0600
@@ -622,6 +622,11 @@
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
 
@@ -985,6 +990,7 @@
 	set_to_dummy_if_null(ops, task_kill);
 	set_to_dummy_if_null(ops, task_prctl);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
+ 	set_to_dummy_if_null(ops, task_lookup);
  	set_to_dummy_if_null(ops, task_to_inode);
 	set_to_dummy_if_null(ops, ipc_permission);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);
Index: linux-2.6.10-rc1-bk14/security/stacker.c
===================================================================
--- linux-2.6.10-rc1-bk14.orig/security/stacker.c	2004-11-04
12:31:12.248929280 -0600
+++ linux-2.6.10-rc1-bk14/security/stacker.c	2004-11-04
12:31:28.998382976 -0600
@@ -756,6 +756,11 @@
 	CALL_ALL(task_reparent_to_init,task_reparent_to_init(p));
 }
 
+static int stacker_task_lookup(struct task_struct *p)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_lookup,task_lookup(p));
+}
+
 static void stacker_task_to_inode(struct task_struct *p, struct inode
*inode)
 {
 	CALL_ALL(task_to_inode,task_to_inode(p, inode));
@@ -1264,6 +1269,7 @@
 	.task_wait =			stacker_task_wait,
 	.task_prctl =			stacker_task_prctl,
 	.task_reparent_to_init =	stacker_task_reparent_to_init,
+	.task_lookup =			stacker_task_lookup,
 	.task_to_inode =		stacker_task_to_inode,
 
 	.ipc_permission 		= stacker_ipc_permission,


