Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbTBSXlu>; Wed, 19 Feb 2003 18:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTBSXlK>; Wed, 19 Feb 2003 18:41:10 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34578 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262806AbTBSXj6>;
	Wed, 19 Feb 2003 18:39:58 -0500
Date: Wed, 19 Feb 2003 15:43:02 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.62
Message-ID: <20030219234302.GG18590@kroah.com>
References: <20030219234140.GA18590@kroah.com> <20030219234203.GB18590@kroah.com> <20030219234216.GC18590@kroah.com> <20030219234228.GD18590@kroah.com> <20030219234239.GE18590@kroah.com> <20030219234250.GF18590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219234250.GF18590@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.914.81.3, 2003/02/05 14:37:12+11:00, sds@epoch.ncsc.mil

[PATCH] LSM: Add LSM syslog hook to 2.5.59

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


diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Wed Feb 19 15:38:52 2003
+++ b/include/linux/security.h	Wed Feb 19 15:38:52 2003
@@ -47,6 +47,7 @@
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_kmod_set_label (void);
 extern void cap_task_reparent_to_init (struct task_struct *p);
+extern int cap_syslog (int type);
 
 /*
  * Values used in the task_security_ops calls
@@ -778,6 +779,12 @@
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
@@ -808,6 +815,7 @@
 	int (*capable) (struct task_struct * tsk, int cap);
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
+	int (*syslog) (int type);
 
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
@@ -1013,6 +1021,11 @@
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
 static inline int security_quota_on (struct file * file)
 {
 	return 0;
+}
+
+static inline int security_syslog(int type)
+{
+	return cap_syslog(type);
 }
 
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
diff -Nru a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	Wed Feb 19 15:38:52 2003
+++ b/kernel/printk.c	Wed Feb 19 15:38:52 2003
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
@@ -273,8 +278,6 @@
 
 asmlinkage long sys_syslog(int type, char * buf, int len)
 {
-	if ((type != 3) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	return do_syslog(type, buf, len);
 }
 
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Wed Feb 19 15:38:52 2003
+++ b/security/capability.c	Wed Feb 19 15:38:52 2003
@@ -262,6 +262,13 @@
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
@@ -272,6 +279,7 @@
 EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_kmod_set_label);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
+EXPORT_SYMBOL(cap_syslog);
 
 #ifdef CONFIG_SECURITY
 
@@ -289,6 +297,8 @@
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.syslog =                       cap_syslog,
 };
 
 #if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Wed Feb 19 15:38:52 2003
+++ b/security/dummy.c	Wed Feb 19 15:38:52 2003
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
@@ -640,6 +647,7 @@
 	set_to_dummy_if_null(ops, quotactl);
 	set_to_dummy_if_null(ops, quota_on);
 	set_to_dummy_if_null(ops, sysctl);
+	set_to_dummy_if_null(ops, syslog);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);
 	set_to_dummy_if_null(ops, bprm_compute_creds);
