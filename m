Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTEMOq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTEMOq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:46:27 -0400
Received: from [144.51.25.10] ([144.51.25.10]:2179 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S261292AbTEMOqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:46:23 -0400
Subject: [RFC][PATCH] /proc/pid inode security labels 2.5.69-bk
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1052837868.4729.418.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2003 10:57:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.69-bk adds a hook to proc_pid_make_inode to allow
security modules to set the security attributes on /proc/pid inodes
based on the security attributes of the associated task.  This is
required by SELinux in order to control access to the process state
accessible via /proc/pid inodes in accordance with the task's security
label.

An alternative approach that was considered was to implement an xattr
handler for /proc/pid inodes.  That approach would still require a hook
call from the xattr handler to the security module to obtain an xattr
value based on the task security attributes, so it would add a further
level of indirection/translation.  The only benefit of implementing an
xattr handler for the /proc/pid inodes would be that the /proc/pid inode
security labels could then be exported to userspace.  However, the
/proc/pid inode security labels are only used internally by the security
module for access control purposes, and userspace access to the full
range of process attributes is already provided via the /proc/pid/attr
interface. Consequently, a simple hook in proc_pid_make_inode seemed
preferable.  

If anyone has any objections to this patch, please let me know.

 fs/proc/base.c           |    1 +
 include/linux/security.h |   14 ++++++++++++++
 security/dummy.c         |    4 ++++
 3 files changed, 19 insertions(+)

===== fs/proc/base.c 1.42 vs edited =====
--- 1.42/fs/proc/base.c	Wed Apr  9 09:42:36 2003
+++ edited/fs/proc/base.c	Tue May 13 10:17:00 2003
@@ -787,6 +787,7 @@
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
+	security_task_to_inode(task, inode);
 
 out:
 	return inode;
===== include/linux/security.h 1.18 vs edited =====
--- 1.18/include/linux/security.h	Fri May  9 17:23:37 2003
+++ edited/include/linux/security.h	Tue May 13 10:19:07 2003
@@ -596,6 +596,11 @@
  * 	Set the security attributes in @p->security for a kernel thread that
  * 	is being reparented to the init task.
  *	@p contains the task_struct for the kernel thread.
+ * @task_to_inode:
+ * 	Set the security attributes for an inode based on an associated task's
+ * 	security attributes, e.g. for /proc/pid inodes.
+ *	@p contains the task_struct for the task.
+ *	@inode contains the inode structure for the inode.
  *
  * Security hooks for Netlink messaging.
  *
@@ -1086,6 +1091,7 @@
 			   unsigned long arg5);
 	void (*task_kmod_set_label) (void);
 	void (*task_reparent_to_init) (struct task_struct * p);
+	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
 
@@ -1656,6 +1662,11 @@
 	security_ops->task_reparent_to_init (p);
 }
 
+static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
+{
+	security_ops->task_to_inode(p, inode);
+}
+
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
@@ -2254,6 +2265,9 @@
 {
 	cap_task_reparent_to_init (p);
 }
+
+static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
+{ }
 
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
===== security/dummy.c 1.20 vs edited =====
--- 1.20/security/dummy.c	Tue May  6 10:02:55 2003
+++ edited/security/dummy.c	Tue May 13 10:17:00 2003
@@ -513,6 +513,9 @@
 	return;
 }
 
+static void dummy_task_to_inode(struct task_struct *p, struct inode *inode)
+{ }
+
 static int dummy_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
@@ -842,6 +845,7 @@
 	set_to_dummy_if_null(ops, task_prctl);
 	set_to_dummy_if_null(ops, task_kmod_set_label);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
+ 	set_to_dummy_if_null(ops, task_to_inode);
 	set_to_dummy_if_null(ops, ipc_permission);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);
 	set_to_dummy_if_null(ops, msg_msg_free_security);

  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

