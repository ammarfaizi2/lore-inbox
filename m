Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTAQVig>; Fri, 17 Jan 2003 16:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTAQVig>; Fri, 17 Jan 2003 16:38:36 -0500
Received: from [144.51.25.10] ([144.51.25.10]:46223 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id <S261593AbTAQVid>;
	Fri, 17 Jan 2003 16:38:33 -0500
Message-Id: <200301172154.QAA00757@moss-shockers.ncsc.mil>
Date: Fri, 17 Jan 2003 16:54:37 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: [RFC][PATCH] Add LSM sysctl hook to 2.5.59
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@wirex.com, sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: Oij5t4HERqPQ+EOLPspxMQ==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a LSM sysctl hook for controlling access to
sysctl variables to 2.5.59, split out from the lsm-2.5 BitKeeper tree.
SELinux uses this hook to control such accesses in accordance with the
security policy configuration.

If anyone has any objections to this change, please let me know.

 include/linux/security.h |   17 +++++++++++++++++
 kernel/sysctl.c          |    5 +++++
 security/dummy.c         |    6 ++++++
 3 files changed, 28 insertions(+)
-----

===== include/linux/security.h 1.9 vs edited =====
--- 1.9/include/linux/security.h	Wed Dec 18 09:10:50 2002
+++ edited/include/linux/security.h	Fri Jan 17 14:49:12 2003
@@ -771,6 +771,12 @@
  *	is NULL.
  *	@file contains the file structure for the accounting file (may be NULL).
  *	Return 0 if permission is granted.
+ * @sysctl:
+ *	Check permission before accessing the @table sysctl variable in the
+ *	manner specified by @op.
+ *	@table contains the ctl_table structure for the sysctl variable.
+ *	@op contains the operation (001 = search, 002 = write, 004 = read).
+ *	Return 0 if permission is granted.
  * @capable:
  *	Check whether the @tsk process has the @cap capability.
  *	@tsk contains the task_struct for the process.
@@ -802,6 +808,7 @@
 			    kernel_cap_t * inheritable,
 			    kernel_cap_t * permitted);
 	int (*acct) (struct file * file);
+	int (*sysctl) (ctl_table * table, int op);
 	int (*capable) (struct task_struct * tsk, int cap);
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
@@ -992,6 +999,11 @@
 	return security_ops->acct (file);
 }
 
+static inline int security_sysctl(ctl_table * table, int op)
+{
+	return security_ops->sysctl(table, op);
+}
+
 static inline int security_quotactl (int cmds, int type, int id,
 				     struct super_block *sb)
 {
@@ -1593,6 +1605,11 @@
 }
 
 static inline int security_acct (struct file *file)
+{
+	return 0;
+}
+
+static inline int security_sysctl(ctl_table * table, int op)
 {
 	return 0;
 }
===== kernel/sysctl.c 1.37 vs edited =====
--- 1.37/kernel/sysctl.c	Thu Dec  5 11:06:54 2002
+++ edited/kernel/sysctl.c	Fri Jan 17 14:49:15 2003
@@ -33,6 +33,7 @@
 #include <linux/highuid.h>
 #include <linux/writeback.h>
 #include <linux/hugetlb.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_ROOT_NFS
@@ -432,6 +433,10 @@
 
 static inline int ctl_perm(ctl_table *table, int op)
 {
+	int error;
+	error = security_sysctl(table, op);
+	if (error)
+		return error;
 	return test_perm(table->mode, op);
 }
 
===== security/dummy.c 1.14 vs edited =====
--- 1.14/security/dummy.c	Wed Dec 18 09:11:56 2002
+++ edited/security/dummy.c	Fri Jan 17 14:49:15 2003
@@ -75,6 +75,11 @@
 	return -EPERM;
 }
 
+static int dummy_sysctl (ctl_table * table, int op)
+{
+	return 0;
+}
+
 static int dummy_quotactl (int cmds, int type, int id, struct super_block *sb)
 {
 	return 0;
@@ -628,6 +633,7 @@
 	set_to_dummy_if_null(ops, capable);
 	set_to_dummy_if_null(ops, quotactl);
 	set_to_dummy_if_null(ops, quota_on);
+	set_to_dummy_if_null(ops, sysctl);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);
 	set_to_dummy_if_null(ops, bprm_compute_creds);



--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

