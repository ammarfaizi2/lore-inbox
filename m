Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbULOTxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbULOTxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbULOTxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:53:06 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:16375 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262473AbULOTsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:48:16 -0500
Date: Wed, 15 Dec 2004 13:48:12 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Properly split capset_check+capset_set
Message-ID: <20041215194812.GA3080@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel/capability.c, capset_check verifies whether or not the
destination process is permitted to undergo the capability change,
while capset_set (1) checks the permission of current to set the
destination process' capability and (2) performs the change.

As Stephen Smalley pointed out, the cap_capset_check code is redundant
with what is hardcoded in kernel/capability.c:sys_capset().  On the
other hand, because the security_capset_set hook is responsible for
doing both an authorization check and doing the actual change,
(particularly, in the case of a cap_set_all or cap_set_pg), when
stacking security modules, the first module may complete the
capset_set before the second module refuses permission.

The attached patch (against 2.6.10-rc3-mm1 w/ ioctl patch) removes the
redundant cap_capset_check hook and moves the security_capset_check
call to just before security_capset_set.  The selinux_capset_set hook
now simply sets the capability (through its secondary), while
selinux_capset_check checks the authorization permission.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc3-mm1/include/linux/security.h
===================================================================
--- linux-2.6.10-rc3-mm1.orig/include/linux/security.h	2004-12-13 12:17:35.000000000 -0600
+++ linux-2.6.10-rc3-mm1/include/linux/security.h	2004-12-13 17:57:41.053436296 -0600
@@ -41,7 +41,6 @@ extern int cap_capable (struct task_stru
 extern int cap_settime (struct timespec *ts, struct timezone *tz);
 extern int cap_ptrace (struct task_struct *parent, struct task_struct *child);
 extern int cap_capget (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
-extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern int cap_bprm_set_security (struct linux_binprm *bprm);
 extern void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe);
@@ -1943,7 +1942,7 @@ static inline int security_capset_check 
 					 kernel_cap_t *inheritable,
 					 kernel_cap_t *permitted)
 {
-	return cap_capset_check (target, effective, inheritable, permitted);
+	return 0;
 }
 
 static inline void security_capset_set (struct task_struct *target,
Index: linux-2.6.10-rc3-mm1/kernel/capability.c
===================================================================
--- linux-2.6.10-rc3-mm1.orig/kernel/capability.c	2004-12-13 12:17:36.000000000 -0600
+++ linux-2.6.10-rc3-mm1/kernel/capability.c	2004-12-13 12:18:40.000000000 -0600
@@ -93,8 +93,12 @@ static inline void cap_set_pg(int pgrp, 
 
 	do_each_task_pid(pgrp, PIDTYPE_PGID, g) {
 		target = g;
-		while_each_thread(g, target)
-			security_capset_set(target, effective, inheritable, permitted);
+		while_each_thread(g, target) {
+			if (!security_capset_check(target, effective,
+					inheritable, permitted))
+				security_capset_set(target, effective,
+					inheritable, permitted);
+		}
 	} while_each_task_pid(pgrp, PIDTYPE_PGID, g);
 }
 
@@ -111,6 +115,9 @@ static inline void cap_set_all(kernel_ca
      do_each_thread(g, target) {
              if (target == current || target->pid == 1)
                      continue;
+	     if (security_capset_check(target, effective, inheritable,
+				permitted))
+		     continue;
 	     security_capset_set(target, effective, inheritable, permitted);
      } while_each_thread(g, target);
 }
@@ -169,9 +176,6 @@ asmlinkage long sys_capset(cap_user_head
 
      ret = -EPERM;
 
-     if (security_capset_check(target, &effective, &inheritable, &permitted))
-	     goto out;
-
      if (!cap_issubset(inheritable, cap_combine(target->cap_inheritable,
                        current->cap_permitted)))
              goto out;
@@ -196,7 +200,10 @@ asmlinkage long sys_capset(cap_user_head
              else            /* all procs in process group */
                      cap_set_pg(-pid, &effective, &inheritable, &permitted);
      } else {
-	     security_capset_set(target, &effective, &inheritable, &permitted);
+	     if (!security_capset_check(target, &effective, &inheritable,
+				&permitted))
+		     security_capset_set(target, &effective, &inheritable,
+					&permitted);
      }
 
 out:
Index: linux-2.6.10-rc3-mm1/security/capability.c
===================================================================
--- linux-2.6.10-rc3-mm1.orig/security/capability.c	2004-12-13 15:56:16.000000000 -0600
+++ linux-2.6.10-rc3-mm1/security/capability.c	2004-12-13 17:57:41.084431584 -0600
@@ -27,7 +27,6 @@
 static struct security_operations capability_ops = {
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
-	.capset_check =			cap_capset_check,
 	.capset_set =			cap_capset_set,
 	.capable =			cap_capable,
 	.settime =			cap_settime,
Index: linux-2.6.10-rc3-mm1/security/commoncap.c
===================================================================
--- linux-2.6.10-rc3-mm1.orig/security/commoncap.c	2004-12-13 12:17:36.000000000 -0600
+++ linux-2.6.10-rc3-mm1/security/commoncap.c	2004-12-13 12:18:40.000000000 -0600
@@ -75,32 +75,6 @@ int cap_capget (struct task_struct *targ
 	return 0;
 }
 
-int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
-		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
-{
-	/* Derived from kernel/capability.c:sys_capset. */
-	/* verify restrictions on target's new Inheritable set */
-	if (!cap_issubset (*inheritable,
-			   cap_combine (target->cap_inheritable,
-					current->cap_permitted))) {
-		return -EPERM;
-	}
-
-	/* verify restrictions on target's new Permitted set */
-	if (!cap_issubset (*permitted,
-			   cap_combine (target->cap_permitted,
-					current->cap_permitted))) {
-		return -EPERM;
-	}
-
-	/* verify the _new_Effective_ is a subset of the _new_Permitted_ */
-	if (!cap_issubset (*effective, *permitted)) {
-		return -EPERM;
-	}
-
-	return 0;
-}
-
 void cap_capset_set (struct task_struct *target, kernel_cap_t *effective,
 		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
@@ -406,7 +380,6 @@ EXPORT_SYMBOL(cap_capable);
 EXPORT_SYMBOL(cap_settime);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
-EXPORT_SYMBOL(cap_capset_check);
 EXPORT_SYMBOL(cap_capset_set);
 EXPORT_SYMBOL(cap_bprm_set_security);
 EXPORT_SYMBOL(cap_bprm_apply_creds);
Index: linux-2.6.10-rc3-mm1/security/root_plug.c
===================================================================
--- linux-2.6.10-rc3-mm1.orig/security/root_plug.c	2004-10-18 16:55:28.000000000 -0500
+++ linux-2.6.10-rc3-mm1/security/root_plug.c	2004-12-13 17:57:41.085431432 -0600
@@ -86,7 +86,6 @@ static struct security_operations rootpl
 	/* Use the capability functions for some of the hooks */
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
-	.capset_check =			cap_capset_check,
 	.capset_set =			cap_capset_set,
 	.capable =			cap_capable,
 
Index: linux-2.6.10-rc3-mm1/security/selinux/hooks.c
===================================================================
--- linux-2.6.10-rc3-mm1.orig/security/selinux/hooks.c	2004-12-13 12:17:36.000000000 -0600
+++ linux-2.6.10-rc3-mm1/security/selinux/hooks.c	2004-12-13 17:57:38.456831040 -0600
@@ -1393,24 +1393,12 @@ static int selinux_capget(struct task_st
 static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effective,
                                 kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	int error;
-
-	error = secondary_ops->capset_check(target, effective, inheritable, permitted);
-	if (error)
-		return error;
-
 	return task_has_perm(current, target, PROCESS__SETCAP);
 }
 
 static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
                                kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	int error;
-
-	error = task_has_perm(current, target, PROCESS__SETCAP);
-	if (error)
-		return;
-
 	secondary_ops->capset_set(target, effective, inheritable, permitted);
 }
 
