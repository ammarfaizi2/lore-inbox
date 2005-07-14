Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263112AbVGNVm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbVGNVm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVGNVm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:42:56 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28809 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263112AbVGNVmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:42:52 -0400
Date: Thu, 14 Jul 2005 23:42:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add security_task_post_setgid
Message-ID: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


the following patch adds a post_setgid() security hook, and necessary dummy 
funcs.

Signed-off-by: Jan Engelhardt <jengelh@linux01.gwdg.de>

diff -dpru linux-2.6.13-rc1-git3-20050706140055/include/linux/security.h AS17/include/linux/security.h
--- linux-2.6.13-rc1-git3-20050706140055/include/linux/security.h	2005-07-11 22:16:30.000000000 +0200
+++ AS17/include/linux/security.h	2005-07-14 23:28:45.000000000 +0200
@@ -558,6 +558,17 @@ struct swap_info_struct;
  *	@id2 contains a gid.
  *	@flags contains one of the LSM_SETID_* values.
  *	Return 0 if permission is granted.
+ * @task_post_setgid:
+ *	Update the module's state after setting one or more of the user
+ *	identity attributes of the current process. The @flags parameter
+ *	indicates which of the set*gid system calls invoked this hook. If
+ *	@flags is LSM_SETID_FS, then @old_rgid is the old fs gid and the other
+ *	parameters are not used.
+ *	@old_rgid contains the old real gid (or fs gid if LSM_SETID_FS).
+ *	@old_egid contains the old effective gid (or -1 if LSM_SETID_FS).
+ *	@old_sgid contains the old saved gid (or -1 if LSM_SETID_FS).
+ *	@flags contains one of the LSM_SETID_* values.
+ *	Return 0 on success.
  * @task_setpgid:
  *	Check permission before setting the process group identifier of the
  *	process @p to @pgid.
@@ -1151,6 +1162,7 @@ struct security_operations {
 	int (*task_post_setuid) (uid_t old_ruid /* or fsuid */ ,
 				 uid_t old_euid, uid_t old_suid, int flags);
 	int (*task_setgid) (gid_t id0, gid_t id1, gid_t id2, int flags);
+	int (*task_post_setgid) (gid_t, gid_t, gid_t, int);
 	int (*task_setpgid) (struct task_struct * p, pid_t pgid);
 	int (*task_getpgid) (struct task_struct * p);
 	int (*task_getsid) (struct task_struct * p);
@@ -1949,6 +1961,12 @@ static inline int security_task_setgid (
 			 0);
 }
 
+static inline int security_task_post_setgid(gid_t id0, gid_t id1, gid_t id2,
+					int flags)
+{
+	return COND_SECURITY(task_post_setgid(id0, id1, id2, flags), 0);
+}
+
 static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
 {
 	return COND_SECURITY(task_setpgid (p, pgid),
diff -dpru linux-2.6.13-rc1-git3-20050706140055/kernel/sys.c AS17/kernel/sys.c
--- linux-2.6.13-rc1-git3-20050706140055/kernel/sys.c	2005-07-07 20:53:44.000000000 +0200
+++ AS17/kernel/sys.c	2005-07-14 23:23:12.000000000 +0200
@@ -558,7 +558,7 @@ asmlinkage long sys_setregid(gid_t rgid,
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	key_fsgid_changed(current);
-	return 0;
+	return security_task_post_setgid(old_rgid, old_egid, -1, LSM_SETID_RE);
 }
 
 /*
@@ -597,7 +597,7 @@ asmlinkage long sys_setgid(gid_t gid)
 		return -EPERM;
 
 	key_fsgid_changed(current);
-	return 0;
+	return security_task_post_setgid(gid, -1, -1, LSM_SETID_ID);
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
@@ -801,6 +801,9 @@ asmlinkage long sys_getresuid(uid_t __us
  */
 asmlinkage long sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 {
+	gid_t old_rgid = current->gid;
+	gid_t old_egid = current->egid;
+	gid_t old_sgid = current->sgid;
 	int retval;
 
 	retval = security_task_setgid(rgid, egid, sgid, LSM_SETID_RES);
@@ -833,7 +836,7 @@ asmlinkage long sys_setresgid(gid_t rgid
 		current->sgid = sgid;
 
 	key_fsgid_changed(current);
-	return 0;
+	return security_task_post_setgid(old_rgid, old_egid, old_sgid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
diff -dpru linux-2.6.13-rc1-git3-20050706140055/security/dummy.c AS17/security/dummy.c
--- linux-2.6.13-rc1-git3-20050706140055/security/dummy.c	2005-07-07 20:53:51.000000000 +0200
+++ AS17/security/dummy.c	2005-07-14 23:26:27.000000000 +0200
@@ -518,6 +518,11 @@ static int dummy_task_setgid (gid_t id0,
 	return 0;
 }
 
+static int dummy_task_post_setgid(gid_t id0, gid_t id1, gid_t id2, int flags)
+{
+	return 0;
+}
+
 static int dummy_task_setpgid (struct task_struct *p, pid_t pgid)
 {
 	return 0;
@@ -931,6 +936,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_setuid);
 	set_to_dummy_if_null(ops, task_post_setuid);
 	set_to_dummy_if_null(ops, task_setgid);
+	set_to_dummy_if_null(ops, task_post_setgid);
 	set_to_dummy_if_null(ops, task_setpgid);
 	set_to_dummy_if_null(ops, task_getpgid);
 	set_to_dummy_if_null(ops, task_getsid);
#eof


Jan Engelhardt
-- 
