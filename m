Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTFMHCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTFMHCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:02:12 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:65523 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265200AbTFMHB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:01:59 -0400
Date: Fri, 13 Jun 2003 00:15:21 -0700
From: Chris Wright <chris@wirex.com>
To: torvalds@transmeta.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Remove task_kmod_set_label hook 2/4
Message-ID: <20030613001521.E31636@figure1.int.wirex.com>
Mail-Followup-To: torvalds@transmeta.com, akpm@digeo.com,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030613001021.D31636@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030613001021.D31636@figure1.int.wirex.com>; from chris@wirex.com on Fri, Jun 13, 2003 at 12:10:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[LSM] Remove task_kmod_set_label hook, it is no longer necessary.
kmod is now handled by keventd which already does reparent_to_init,
so there is no need to worry about getting the security labels right
for code running off the keventd workqueue.

--- linus-2.5/include/linux/security.h.kmod	Thu Jun 12 22:48:12 2003
+++ linus-2.5/include/linux/security.h	Thu Jun 12 22:48:12 2003
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
 
@@ -1692,11 +1686,6 @@
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
@@ -2321,11 +2310,6 @@
 	return 0;
 }
 
-static inline void security_task_kmod_set_label (void)
-{
-	cap_task_kmod_set_label ();
-}
-
 static inline void security_task_reparent_to_init (struct task_struct *p)
 {
 	cap_task_reparent_to_init (p);
--- linus-2.5/security/capability.c.kmod	Thu Jun 12 00:40:11 2003
+++ linus-2.5/security/capability.c	Thu Jun 12 22:48:12 2003
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
--- linus-2.5/security/dummy.c.kmod	Thu Jun 12 22:48:12 2003
+++ linus-2.5/security/dummy.c	Thu Jun 12 22:48:12 2003
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
--- linus-2.5/security/root_plug.c.kmod	Thu Jun 12 00:40:12 2003
+++ linus-2.5/security/root_plug.c	Thu Jun 12 22:48:12 2003
@@ -94,7 +94,6 @@
 	.bprm_set_security =		cap_bprm_set_security,
 
 	.task_post_setuid =		cap_task_post_setuid,
-	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
 
 	.bprm_check_security =		rootplug_bprm_check_security,
