Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTBSXqP>; Wed, 19 Feb 2003 18:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTBSXqP>; Wed, 19 Feb 2003 18:46:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33810 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262789AbTBSXjq>;
	Wed, 19 Feb 2003 18:39:46 -0500
Date: Wed, 19 Feb 2003 15:42:50 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.62
Message-ID: <20030219234250.GF18590@kroah.com>
References: <20030219234140.GA18590@kroah.com> <20030219234203.GB18590@kroah.com> <20030219234216.GC18590@kroah.com> <20030219234228.GD18590@kroah.com> <20030219234239.GE18590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219234239.GE18590@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.914.81.2, 2003/02/05 14:32:08+11:00, sds@epoch.ncsc.mil

[PATCH] LSM: Add LSM sysctl hook to 2.5.59

This patch adds a LSM sysctl hook for controlling access to
sysctl variables to 2.5.59, split out from the lsm-2.5 BitKeeper tree.
SELinux uses this hook to control such accesses in accordance with the
security policy configuration.


diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Wed Feb 19 15:38:57 2003
+++ b/include/linux/security.h	Wed Feb 19 15:38:57 2003
@@ -767,6 +767,12 @@
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
@@ -798,6 +804,7 @@
 			    kernel_cap_t * inheritable,
 			    kernel_cap_t * permitted);
 	int (*acct) (struct file * file);
+	int (*sysctl) (ctl_table * table, int op);
 	int (*capable) (struct task_struct * tsk, int cap);
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
@@ -990,6 +997,11 @@
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
@@ -1595,6 +1607,11 @@
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
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Wed Feb 19 15:38:57 2003
+++ b/kernel/sysctl.c	Wed Feb 19 15:38:57 2003
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
 
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Wed Feb 19 15:38:57 2003
+++ b/security/dummy.c	Wed Feb 19 15:38:57 2003
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
@@ -634,6 +639,7 @@
 	set_to_dummy_if_null(ops, capable);
 	set_to_dummy_if_null(ops, quotactl);
 	set_to_dummy_if_null(ops, quota_on);
+	set_to_dummy_if_null(ops, sysctl);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);
 	set_to_dummy_if_null(ops, bprm_compute_creds);
