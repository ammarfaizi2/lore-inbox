Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264956AbUELD1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbUELD1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265016AbUELD0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:26:05 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:19409 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S265005AbUELDYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:24:31 -0400
From: Andy Lutomirski <luto@myrealbox.com>
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] capabilities: capability evolution
Date: Tue, 11 May 2004 20:24:25 -0700
User-Agent: KMail/1.6.2
Cc: luto@myrealbox.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405112024.25623.luto@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change capability evolution to make capabilities useful.

 include/linux/capability.h |    2
 include/linux/init_task.h  |    4 -
 kernel/capability.c        |    2
 security/commoncap.c       |  137 +++++++++++++++++++++++++++------------------ 4 files changed, 87 insertions(+), 58 deletions(-)

--- linux-2.6.6-mm1/security/commoncap.c~cap_2_evolution	2004-05-11 00:28:02.000000000 -0700
+++ linux-2.6.6-mm1/security/commoncap.c	2004-05-11 19:49:24.091175930 -0700
@@ -58,9 +58,7 @@
 {
 	/* Derived from kernel/capability.c:sys_capset. */
 	/* verify restrictions on target's new Inheritable set */
-	if (!cap_issubset (*inheritable,
-			   cap_combine (target->cap_inheritable,
-					current->cap_permitted))) {
+	if (!cap_issubset (*inheritable, target->cap_inheritable)) {
 		return -EPERM;
 	}
 
@@ -76,6 +74,11 @@
 		return -EPERM;
 	}
 
+	/* verify the _new_Permitted_ is a subset of the _new_Inheritable_ */
+	if (!cap_issubset (*permitted, *inheritable)) {
+		return -EPERM;
+	}
+
 	return 0;
 }
 
@@ -96,69 +99,96 @@
 	return 0;
 }
 
+/*
+ *
+ * What the masks mean:
+ *  pI = capabilities that this process or its children may have
+ *  pP = capabilities that this process has
+ *  pE = capabilities that this process has and are enabled
+ * (so pE <= pP <= pI)
+ *
+ * The capability evolution rules are:
+ *
+ *  pI' = pI & fI
+ *  pP' = ((fP & cap_bset) | (pP & Y)) & pI'
+ *  pE' = (euid changed ? pP' : pE)
+ *
+ * Caveat: if (fP & ~pI'), there is no _theoretical_ problem, but
+ * this could introduce exploits in buggy programs.  Since programs
+ * that aren't capability-aware are insecure _anyway_ if pP!=0, this
+ * is OK.
+ *
+ * To allow pI != ~0 to be secure in the presence of buggy programs,
+ * we require full pI for setuid.
+ *
+ * The moral is that, if file capabilities are introduced, programs
+ * that are granted fP > 0 need to be aware of how to deal with it.
+ * Because the effective set is left alone on non-setuid fP>0,
+ * such a program should drop capabilities that were not in its initial
+ * effective set before running untrusted code.
+ *
+ */
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
-	/* Derived from fs/exec.c:compute_creds. */
-	kernel_cap_t new_permitted, working;
+	kernel_cap_t new_pI, new_pP;
 
-	/* This code is clearly broken.  I think it's equivalent
-	 * to the old code...
-	 */
-	int euid, egid;
-	euid = bprm->set_uid;
-	egid = bprm->set_gid;
-	if (euid != 0 && current->uid != 0)
-		cap_clear(bprm->cap_inheritable);
-
-	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
-	working = cap_intersect (bprm->cap_inheritable,
-				 current->cap_inheritable);
-	new_permitted = cap_combine (new_permitted, working);
-
-	if (euid != current->uid || egid != current->gid ||
-
-	    !cap_issubset (new_permitted, current->cap_permitted)) {
-		current->mm->dumpable = 0;
-
-		if (unsafe & ~LSM_UNSAFE_PTRACE_CAP) {
-			if (!capable(CAP_SETUID)) {
-				euid = current->uid;
-				egid = current->gid;
-			}
-			if (!capable (CAP_SETPCAP)) {
-				new_permitted = cap_intersect (new_permitted,
-							current->cap_permitted);
-			}
+	new_pI = cap_intersect(current->cap_inheritable, bprm->cap_inheritable);
+
+	/* Check if setuid/setgid is safe */
+	if (bprm->secflags & (BINPRM_SEC_SETUID | BINPRM_SEC_SETGID)) {
+		int revoke_setid = 0;
+		if (unsafe & ~LSM_UNSAFE_PTRACE_CAP) revoke_setid = 1;
+
+		/* FIXME: Is this overly harsh on setgid? */
+		if (new_pI != CAP_FULL_SET) revoke_setid = 1;
+
+		/* Don't break root. */
+		if (revoke_setid && capable(CAP_SETUID)) revoke_setid = 0;
+
+		if (revoke_setid) {
+			bprm->secflags &=
+			  ~(BINPRM_SEC_SETUID | BINPRM_SEC_SETGID);
+			cap_clear(bprm->cap_permitted);
 		}
 	}
 
-	current->suid = current->euid = current->fsuid = euid;
-	current->sgid = current->egid = current->fsgid = egid;
-
-	/* For init, we want to retain the capabilities set
-	 * in the init_task struct. Thus we skip the usual
-	 * capability rules */
-	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective = new_permitted;
-		if (euid != 0)
-			cap_clear(current->cap_effective);
+	/* Enforce unsafeness (a noop without VFS caps) */
+	if(unsafe & ~LSM_UNSAFE_PTRACE_CAP)
+		cap_clear(bprm->cap_permitted);
+
+
+	new_pP = cap_intersect(bprm->cap_permitted, cap_bset);
+	new_pP = cap_combine(new_pP, current->cap_permitted);
+	new_pP = cap_intersect(new_pP, new_pI);
+
+	/* setuid-nonroot is special */
+	if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->set_uid != 0 &&
+	    current->uid != 0 && current->euid == 0)
+		cap_clear(new_pP);
+
+	if(!cap_issubset(new_pP, current->cap_permitted))
+		bprm->secflags |= BINPRM_SEC_SECUREEXEC;
+
+	/* Apply new security state */
+	if (bprm->secflags & BINPRM_SEC_SETUID) {
+	        current->suid = current->euid = current->fsuid = bprm->set_uid;
+		current->cap_effective = new_pP;
 	}
+	if (bprm->secflags & BINPRM_SEC_SETGID)
+	        current->sgid = current->egid = current->fsgid = bprm->set_gid;
 
-	/* AUD: Audit candidate if current->cap_effective is set */
+	current->cap_inheritable = new_pI;
+	current->cap_permitted = new_pP;
+	cap_mask(current->cap_effective, new_pP);
 
 	current->keep_capabilities = 0;
 }
 
 int cap_bprm_secureexec (struct linux_binprm *bprm)
 {
-	/* If/when this module is enhanced to incorporate capability
-	   bits on files, the test below should be extended to also perform a 
-	   test between the old and new capability sets.  For now,
-	   it simply preserves the legacy decision algorithm used by
-	   the old userland. */
 	return (current->euid != current->uid ||
-		current->egid != current->gid);
+		current->egid != current->gid ||
+		(bprm->secflags & BINPRM_SEC_SECUREEXEC));
 }
 
 int cap_inode_setxattr(struct dentry *dentry, char *name, void *value,
@@ -272,8 +302,9 @@
 
 void cap_task_reparent_to_init (struct task_struct *p)
 {
-	p->cap_effective = CAP_INIT_EFF_SET;
-	p->cap_inheritable = CAP_INIT_INH_SET;
+	/* It's a kernel thread.  Don't worry about enforcing inheritable. */
+	p->cap_effective = CAP_FULL_SET;
+	p->cap_inheritable = CAP_FULL_SET;
 	p->cap_permitted = CAP_FULL_SET;
 	p->keep_capabilities = 0;
 	return;
--- linux-2.6.6-mm1/kernel/capability.c~cap_2_evolution	2004-05-11 12:14:40.000000000 -0700
+++ linux-2.6.6-mm1/kernel/capability.c	2004-05-11 12:17:22.000000000 -0700
@@ -13,7 +13,7 @@
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
-kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
+kernel_cap_t cap_bset = CAP_FULL_SET;
 int sysctl_mlock_group;
 
 EXPORT_SYMBOL(securebits);
--- linux-2.6.6-mm1/include/linux/capability.h~cap_2_evolution	2004-05-11 01:43:50.000000000 -0700
+++ linux-2.6.6-mm1/include/linux/capability.h	2004-05-11 01:44:03.000000000 -0700
@@ -308,8 +308,6 @@
 
 #define CAP_EMPTY_SET       to_cap_t(0)
 #define CAP_FULL_SET        to_cap_t(~0)
-#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
 
 #define CAP_TO_MASK(x) (1 << (x))
 #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
--- linux-2.6.6-mm1/include/linux/init_task.h~cap_2_evolution	2004-05-11 01:44:13.000000000 -0700
+++ linux-2.6.6-mm1/include/linux/init_task.h	2004-05-11 01:44:31.000000000 -0700
@@ -92,8 +92,8 @@
 		.function	= it_real_fn				\
 	},								\
 	.group_info	= &init_groups,					\
-	.cap_effective	= CAP_INIT_EFF_SET,				\
-	.cap_inheritable = CAP_INIT_INH_SET,				\
+	.cap_effective	= CAP_FULL_SET,				\
+	.cap_inheritable = CAP_FULL_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
 	.keep_capabilities = 0,						\
 	.rlim		= INIT_RLIMITS,					\


