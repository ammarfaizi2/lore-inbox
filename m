Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTAVOPU>; Wed, 22 Jan 2003 09:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTAVOPT>; Wed, 22 Jan 2003 09:15:19 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:5601 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S261286AbTAVOPR>;
	Wed, 22 Jan 2003 09:15:17 -0500
Message-Id: <200301221431.JAA02913@moss-shockers.ncsc.mil>
Date: Wed, 22 Jan 2003 09:31:53 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: [RFC][PATCH] Add LSM syslog hook to 2.5.59
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@wirex.com, sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: DTOY9RKCXy5zip/bD9s/qg==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the LSM security_syslog hook for controlling the
syslog(2) interface relative to 2.5.59 plus the previously posted
security_sysctl patch.  In response to earlier comments by Christoph,
the existing capability check for syslog(2) is moved into the
capability security module hook function, and a corresponding dummy
security module hook function is defined that provides traditional
superuser behavior.  The LSM hook is placed in do_syslog rather than
sys_syslog so that it is called when either the system call interface
or the /proc/kmsg interface is used.  SELinux uses this hook to
control access to the kernel message ring and to the console log
level.

If anyone has any objections to this change, please let me know.

 include/linux/security.h |   18 ++++++++++++++++++
 kernel/printk.c          |    7 +++++--
 security/capability.c    |   10 ++++++++++
 security/dummy.c         |    8 ++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)
-----

diff -X /home/sds/dontdiff -ru sysctl-2.5.59/include/linux/security.h syslog-2.5.59/include/linux/security.h
--- sysctl-2.5.59/include/linux/security.h	Tue Jan 21 16:53:08 2003
+++ syslog-2.5.59/include/linux/security.h	Tue Jan 21 16:56:27 2003
@@ -47,6 +47,7 @@
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_kmod_set_label (void);
 extern void cap_task_reparent_to_init (struct task_struct *p);
+extern int cap_syslog (int type);
 
 /*
  * Values used in the task_security_ops calls
@@ -782,6 +783,12 @@
  *	@tsk contains the task_struct for the process.
  *	@cap contains the capability <include/linux/capability.h>.
  *	Return 0 if the capability is granted for @tsk.
+ * @syslog:
+ *	Check permission before accessing the kernel message ring or changing
+ *	logging to the console.
+ *	See the syslog(2) manual page for an explanation of the @type values.  
+ *	@type contains the type of action.
+ *	Return 0 if permission is granted.
  *
  * @register_security:
  * 	allow module stacking.
@@ -812,6 +819,7 @@
 	int (*capable) (struct task_struct * tsk, int cap);
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
+	int (*syslog) (int type);
 
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
@@ -1015,6 +1023,11 @@
 	return security_ops->quota_on (file);
 }
 
+static inline int security_syslog(int type)
+{
+	return security_ops->syslog(type);
+}
+
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
 {
 	return security_ops->bprm_alloc_security (bprm);
@@ -1625,6 +1638,11 @@
 	return 0;
 }
 
+static inline int security_syslog(int type)
+{
+	return cap_syslog(type);
+}
+
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
 {
 	return 0;
diff -X /home/sds/dontdiff -ru sysctl-2.5.59/kernel/printk.c syslog-2.5.59/kernel/printk.c
--- sysctl-2.5.59/kernel/printk.c	Thu Jan 16 21:22:59 2003
+++ syslog-2.5.59/kernel/printk.c	Tue Jan 21 16:56:27 2003
@@ -28,6 +28,7 @@
 #include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -161,6 +162,10 @@
 	char c;
 	int error = 0;
 
+	error = security_syslog(type);
+	if (error)
+		return error;
+
 	switch (type) {
 	case 0:		/* Close log */
 		break;
@@ -283,8 +288,6 @@
 
 asmlinkage long sys_syslog(int type, char * buf, int len)
 {
-	if ((type != 3) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	return do_syslog(type, buf, len);
 }
 
diff -X /home/sds/dontdiff -ru sysctl-2.5.59/security/capability.c syslog-2.5.59/security/capability.c
--- sysctl-2.5.59/security/capability.c	Thu Jan 16 21:22:01 2003
+++ syslog-2.5.59/security/capability.c	Tue Jan 21 16:56:27 2003
@@ -266,6 +266,13 @@
 	return;
 }
 
+int cap_syslog (int type)
+{
+	if ((type != 3) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	return 0;
+}
+
 EXPORT_SYMBOL(cap_capable);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
@@ -276,6 +283,7 @@
 EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_kmod_set_label);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
+EXPORT_SYMBOL(cap_syslog);
 
 #ifdef CONFIG_SECURITY
 
@@ -293,6 +301,8 @@
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.syslog =                       cap_syslog,
 };
 
 #if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
diff -X /home/sds/dontdiff -ru sysctl-2.5.59/security/dummy.c syslog-2.5.59/security/dummy.c
--- sysctl-2.5.59/security/dummy.c	Tue Jan 21 16:53:08 2003
+++ syslog-2.5.59/security/dummy.c	Tue Jan 21 16:56:47 2003
@@ -90,6 +90,13 @@
 	return 0;
 }
 
+static int dummy_syslog (int type)
+{
+	if ((type != 3) && current->euid)
+		return -EPERM;
+	return 0;
+}
+
 static int dummy_bprm_alloc_security (struct linux_binprm *bprm)
 {
 	return 0;
@@ -634,6 +641,7 @@
 	set_to_dummy_if_null(ops, quotactl);
 	set_to_dummy_if_null(ops, quota_on);
 	set_to_dummy_if_null(ops, sysctl);
+	set_to_dummy_if_null(ops, syslog);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);
 	set_to_dummy_if_null(ops, bprm_compute_creds);



--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

