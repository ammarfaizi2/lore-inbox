Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTFBJr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTFBJr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:47:28 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:18424 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262127AbTFBJrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:47:07 -0400
Date: Mon, 2 Jun 2003 02:57:37 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Early init for security modules and various cleanups
Message-ID: <20030602025736.D27233@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030602024910.B27233@figure1.int.wirex.com> <20030602025450.C27233@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030602025450.C27233@figure1.int.wirex.com>; from chris@wirex.com on Mon, Jun 02, 2003 at 02:54:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1260  -> 1.1261 
#	    security/dummy.c	1.23    -> 1.24   
#	security/capability.c	1.15    -> 1.16   
#	include/linux/security.h	1.22    -> 1.23   
#	security/root_plug.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/02	chris@wirex.com	1.1261
# [LSM] Remove task_kmod_set_label hook, it is no longer necessary.
# kmod is now handled by keventd which already does reparent_to_init,
# so there is no need to worry about getting the security labels right
# for code running off the keventd workqueue.
# --------------------------------------------
#
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Mon Jun  2 01:31:14 2003
+++ b/include/linux/security.h	Mon Jun  2 01:31:14 2003
@@ -46,7 +46,6 @@
 extern int cap_bprm_set_security (struct linux_binprm *bprm);
 extern void cap_bprm_compute_creds (struct linux_binprm *bprm);
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
-extern void cap_task_kmod_set_label (void);
 extern void cap_task_reparent_to_init (struct task_struct *p);
 extern int cap_syslog (int type);
 
@@ -607,10 +606,6 @@
  *	@arg4 contains a argument.
  *	@arg5 contains a argument.
  *	Return 0 if permission is granted.
- * @task_kmod_set_label:
- *	Set the security attributes in current->security for the kernel module
- *	loader thread, so that it has the permissions needed to perform its
- *	function.
  * @task_reparent_to_init:
  * 	Set the security attributes in @p->security for a kernel thread that
  * 	is being reparented to the init task.
@@ -1111,7 +1106,6 @@
 	int (*task_prctl) (int option, unsigned long arg2,
 			   unsigned long arg3, unsigned long arg4,
 			   unsigned long arg5);
-	void (*task_kmod_set_label) (void);
 	void (*task_reparent_to_init) (struct task_struct * p);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
@@ -1697,11 +1691,6 @@
 	return security_ops->task_prctl (option, arg2, arg3, arg4, arg5);
 }
 
-static inline void security_task_kmod_set_label (void)
-{
-	security_ops->task_kmod_set_label ();
-}
-
 static inline void security_task_reparent_to_init (struct task_struct *p)
 {
 	security_ops->task_reparent_to_init (p);
@@ -2329,11 +2318,6 @@
 				       unsigned long arg5)
 {
 	return 0;
-}
-
-static inline void security_task_kmod_set_label (void)
-{
-	cap_task_kmod_set_label ();
 }
 
 static inline void security_task_reparent_to_init (struct task_struct *p)
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Mon Jun  2 01:31:14 2003
+++ b/security/capability.c	Mon Jun  2 01:31:14 2003
@@ -248,12 +248,6 @@
 	return 0;
 }
 
-void cap_task_kmod_set_label (void)
-{
-	cap_set_full (current->cap_effective);
-	return;
-}
-
 void cap_task_reparent_to_init (struct task_struct *p)
 {
 	p->cap_effective = CAP_INIT_EFF_SET;
@@ -278,7 +272,6 @@
 EXPORT_SYMBOL(cap_bprm_set_security);
 EXPORT_SYMBOL(cap_bprm_compute_creds);
 EXPORT_SYMBOL(cap_task_post_setuid);
-EXPORT_SYMBOL(cap_task_kmod_set_label);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
 
@@ -298,7 +291,6 @@
 	.bprm_set_security =		cap_bprm_set_security,
 
 	.task_post_setuid =		cap_task_post_setuid,
-	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
 
 	.syslog =                       cap_syslog,
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Mon Jun  2 01:31:14 2003
+++ b/security/dummy.c	Mon Jun  2 01:31:14 2003
@@ -517,11 +517,6 @@
 	return 0;
 }
 
-static void dummy_task_kmod_set_label (void)
-{
-	return;
-}
-
 static void dummy_task_reparent_to_init (struct task_struct *p)
 {
 	p->euid = p->fsuid = 0;
@@ -871,7 +866,6 @@
 	set_to_dummy_if_null(ops, task_wait);
 	set_to_dummy_if_null(ops, task_kill);
 	set_to_dummy_if_null(ops, task_prctl);
-	set_to_dummy_if_null(ops, task_kmod_set_label);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
  	set_to_dummy_if_null(ops, task_to_inode);
 	set_to_dummy_if_null(ops, ipc_permission);
diff -Nru a/security/root_plug.c b/security/root_plug.c
--- a/security/root_plug.c	Mon Jun  2 01:31:14 2003
+++ b/security/root_plug.c	Mon Jun  2 01:31:14 2003
@@ -143,7 +143,6 @@
 	.bprm_set_security =		cap_bprm_set_security,
 
 	.task_post_setuid =		cap_task_post_setuid,
-	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
 
 	.bprm_check_security =		rootplug_bprm_check_security,
