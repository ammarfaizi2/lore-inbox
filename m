Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUEMUNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUEMUNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUEMULm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:11:42 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:46258 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S265137AbUEMUIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:08:47 -0400
From: Andy Lutomirski <luto@myrealbox.com>
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] capabilites, take 2
Date: Thu, 13 May 2004 13:08:40 -0700
User-Agent: KMail/1.6.2
Cc: luto@myrealbox.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405131308.40477.luto@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This implements working capabilities.

Changes from the previous version:

- It's now just one patch (the split doesn't make sense anymore)
- Cleaned up cap_bprm_apply_creds
- Restrictions on setuid are somewhat stricter now
- Rediffed against 2.6.6-mm2 (didn't change anything)
- bprm is initialized correctly in fs/exec.c
- printk to remind users that the patch is enabled
- LSM builds correctly.  Untested.

The whole thing is now a module parameter -- specify
commoncap.newcaps=1 if capabilities is built-in or newcaps=1 in
modprobe or insmod if not.

Known issues:

1. setxuid emulation is wrong (keepcaps doesn't work for setre(s)uid).
   I haven't fixed this because I don't what to change the semantics
   of PR_SET_KEEPCAPS.  I'll probably add PR_SET_REALLY_KEEPCAPS
   to really keep capabilities.

2. When newcaps=0 (the default), linuxrc gets all capabilities.  This
   is different from the old behavior.  Init and programs started from
   linuxrc still match the old behavior.  I couldn't think of any
   remotely clean way around that without breaking linuxrc for
   newcaps=1

3. I haven't tried it, but I imagine that unloading commoncap and then
   reloading it in a different mode may do unexpected things.  So read
   the code before you try that.  I see no reason to fix this one because
   the whole thing should go away eventually.

When newcaps=1, this extends the LSM interface:
bprm->secflags & BINPRM_SEC_NO_ELEVATE means that privileges should not
be elevated.  So stacking modules (e.g. selinux) should set this before
calling to the lower module and test it again before deciding whether
to elevate privileges.  That way, either all privs are elevated or none
are.

I also added a flag (BINPRM_SEC_SECUREEXEC) with the obvious meaning.
Otherwise cap_bprm_secureexec would have been a mess.

--Andy


Implement optional working capability support.  Try to avoid giving Andrew
a heart attack. ;)

 fs/exec.c                  |   16 ++++
 include/linux/binfmts.h    |    8 ++
 include/linux/capability.h |    6 +
 include/linux/init_task.h  |    4 -
 kernel/capability.c        |    2 
 security/commoncap.c       |  155 +++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 172 insertions(+), 19 deletions(-)

--- linux-2.6.6-mm2/fs/exec.c~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/fs/exec.c	2004-05-13 12:15:20.000000000 -0700
@@ -882,8 +882,10 @@
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
+		if (mode & S_ISUID) {
 			bprm->e_uid = inode->i_uid;
+			bprm->secflags |= BINPRM_SEC_SETUID;
+		}
 
 		/* Set-gid? */
 		/*
@@ -891,10 +893,19 @@
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			bprm->e_gid = inode->i_gid;
+			bprm->secflags |= BINPRM_SEC_SETGID;
+		}
 	}
 
+	/* Pretend we have VFS capabilities */
+	cap_set_full(bprm->cap_inheritable);
+	if((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
+		cap_set_full(bprm->cap_permitted);
+	else
+		cap_clear(bprm->cap_permitted);
+
 	/* fill in binprm security blob */
 	retval = security_bprm_set(bprm);
 	if (retval)
@@ -1089,6 +1100,7 @@
 	bprm.loader = 0;
 	bprm.exec = 0;
 	bprm.security = NULL;
+	bprm.secflags = 0;
 	bprm.mm = mm_alloc();
 	retval = -ENOMEM;
 	if (!bprm.mm)
--- linux-2.6.6-mm2/security/commoncap.c~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/security/commoncap.c	2004-05-13 12:59:32.934690092 -0700
@@ -24,6 +24,11 @@
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
 
+int newcaps = 0;
+
+module_param(newcaps, int, 444);
+MODULE_PARM_DESC(newcaps, "Set newcaps=1 to enable experimental capabilities");
+
 int cap_capable (struct task_struct *tsk, int cap)
 {
 	/* Derived from include/linux/sched.h:capable. */
@@ -36,6 +41,11 @@
 int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
+	/* CAP_SYS_PTRACE still can't bypass inheritable restrictions */
+	if (newcaps &&
+	    !cap_issubset (child->cap_inheritable, current->cap_inheritable))
+		return -EPERM;
+
 	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
 	    !capable (CAP_SYS_PTRACE))
 		return -EPERM;
@@ -76,6 +86,11 @@
 		return -EPERM;
 	}
 
+	/* verify the _new_Permitted_ is a subset of the _new_Inheritable_ */
+	if (newcaps && !cap_issubset (*permitted, *inheritable)) {
+		return -EPERM;
+	}
+
 	return 0;
 }
 
@@ -89,6 +104,8 @@
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+	if (newcaps) return 0;
+
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	/* We don't have VFS support for capabilities yet */
@@ -115,10 +132,11 @@
 	return 0;
 }
 
-void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
+static void cap_bprm_apply_creds_compat (struct linux_binprm *bprm, int unsafe)
 {
-	/* Derived from fs/exec.c:compute_creds. */
+	/* This function will hopefully die in 2.7. */
 	kernel_cap_t new_permitted, working;
+	static int fixed_init = 0;
 
 	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
 	working = cap_intersect (bprm->cap_inheritable,
@@ -151,6 +169,15 @@
 		current->cap_permitted = new_permitted;
 		current->cap_effective =
 		    cap_intersect (new_permitted, bprm->cap_effective);
+	} else if (!fixed_init) {
+		/* This is not strictly correct, as it gives linuxrc more
+		 * permissions than it used to have.  It was the only way I
+		 * could think of to keep the resulting disaster contained,
+		 * though.
+		 */
+		current->cap_effective = CAP_OLD_INIT_EFF_SET;
+		current->cap_inheritable = CAP_OLD_INIT_INH_SET;
+		fixed_init = 1;
 	}
 
 	/* AUD: Audit candidate if current->cap_effective is set */
@@ -158,15 +185,103 @@
 	current->keep_capabilities = 0;
 }
 
+/*
+ * The rules of Linux capabilities (not POSIX!)
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
+ *  pP' = ((fP & cap_bset) | pP) & pI' & Y
+ *  pE' = (setuid ? pP' : (pE & pP'))
+ *
+ *  X = cap_bset
+ *  Y is zero if uid!=0, euid==0, and setuid non-root
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
+void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
+{
+	kernel_cap_t new_pI, new_pP;
+	kernel_cap_t fI, fP;
+	int is_setuid, is_setgid;
+
+	if(!newcaps) {
+		cap_bprm_apply_creds_compat(bprm, unsafe);
+		return;
+	}
+
+	fI = bprm->cap_inheritable;
+	fP = bprm->cap_permitted;
+	is_setuid = (bprm->secflags & BINPRM_SEC_SETUID);
+	is_setgid = (bprm->secflags & BINPRM_SEC_SETGID);
+
+	new_pI = cap_intersect(current->cap_inheritable, fI);
+
+	/* Check that it's safe to elevate privileges */
+	if (unsafe & ~LSM_UNSAFE_PTRACE_CAP)
+		bprm->secflags |= BINPRM_SEC_NOELEVATE;
+
+	/* FIXME: Is this overly harsh on setgid? */
+	if ((bprm->secflags & (BINPRM_SEC_SETUID | BINPRM_SEC_SETGID)) &&
+	    new_pI != CAP_FULL_SET)
+			bprm->secflags |= BINPRM_SEC_NOELEVATE;
+
+	if (bprm->secflags & BINPRM_SEC_NOELEVATE) {
+		is_setuid = is_setgid = 0;
+		cap_clear(fP);
+	}
+
+	new_pP = cap_intersect(fP, cap_bset);
+	new_pP = cap_combine(new_pP, current->cap_permitted);
+	cap_mask(new_pP, new_pI);
+
+	/* setuid-nonroot is special. */
+	if (is_setuid && bprm->e_uid != 0 && current->uid != 0 &&
+	    current->euid == 0)
+		cap_clear(new_pP);
+
+	if(!cap_issubset(new_pP, current->cap_permitted))
+		bprm->secflags |= BINPRM_SEC_SECUREEXEC;
+
+	/* Apply new security state */
+	if (is_setuid) {
+	        current->suid = current->euid = current->fsuid = bprm->e_uid;
+		current->cap_effective = new_pP;
+	}
+	if (is_setgid)
+	        current->sgid = current->egid = current->fsgid = bprm->e_gid;
+
+	current->cap_inheritable = new_pI;
+	current->cap_permitted = new_pP;
+	cap_mask(current->cap_effective, new_pP);
+
+	current->keep_capabilities = 0;
+}
+
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
@@ -280,9 +395,15 @@
 
 void cap_task_reparent_to_init (struct task_struct *p)
 {
-	p->cap_effective = CAP_INIT_EFF_SET;
-	p->cap_inheritable = CAP_INIT_INH_SET;
-	p->cap_permitted = CAP_FULL_SET;
+	if (newcaps) {
+		cap_set_full(p->cap_inheritable);
+		cap_set_full(p->cap_permitted);
+		cap_set_full(p->cap_effective);
+	} else {
+		p->cap_effective = CAP_OLD_INIT_EFF_SET;
+		p->cap_inheritable = CAP_OLD_INIT_INH_SET;
+		p->cap_permitted = CAP_FULL_SET;
+	}
 	p->keep_capabilities = 0;
 	return;
 }
@@ -367,6 +488,16 @@
 	return -ENOMEM;
 }
 
+static int __init commoncap_init (void)
+{
+	if (newcaps) {
+		printk(KERN_NOTICE "Experimental capability support is on\n");
+		cap_bset = CAP_FULL_SET;
+	}
+
+	return 0;
+}
+
 EXPORT_SYMBOL(cap_capable);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
@@ -382,5 +513,7 @@
 EXPORT_SYMBOL(cap_syslog);
 EXPORT_SYMBOL(cap_vm_enough_memory);
 
+module_init(commoncap_init);
+
 MODULE_DESCRIPTION("Standard Linux Common Capabilities Security Module");
 MODULE_LICENSE("GPL");
--- linux-2.6.6-mm2/kernel/capability.c~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/kernel/capability.c	2004-05-13 11:42:51.000000000 -0700
@@ -13,7 +13,7 @@
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
-kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
+kernel_cap_t cap_bset = CAP_OLD_INIT_EFF_SET;
 int sysctl_mlock_group;
 
 EXPORT_SYMBOL(securebits);
--- linux-2.6.6-mm2/include/linux/capability.h~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/include/linux/capability.h	2004-05-13 11:42:51.000000000 -0700
@@ -308,8 +308,10 @@
 
 #define CAP_EMPTY_SET       to_cap_t(0)
 #define CAP_FULL_SET        to_cap_t(~0)
-#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
+
+/* For old-style capabilities, we use these. */
+#define CAP_OLD_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
+#define CAP_OLD_INIT_INH_SET    to_cap_t(0)
 
 #define CAP_TO_MASK(x) (1 << (x))
 #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
--- linux-2.6.6-mm2/include/linux/binfmts.h~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/include/linux/binfmts.h	2004-05-13 11:44:02.000000000 -0700
@@ -20,6 +20,10 @@
 /*
  * This structure is used to hold the arguments that are used when loading binaries.
  */
+#define BINPRM_SEC_SETUID	1
+#define BINPRM_SEC_SETGID	2
+#define BINPRM_SEC_SECUREEXEC	4
+#define BINPRM_SEC_NOELEVATE	8
 struct linux_binprm{
 	char buf[BINPRM_BUF_SIZE];
 	struct page *page[MAX_ARG_PAGES];
@@ -28,7 +32,9 @@
 	int sh_bang;
 	struct file * file;
 	int e_uid, e_gid;
-	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
+	int secflags;
+	kernel_cap_t cap_inheritable, cap_permitted;
+	kernel_cap_t cap_effective; /* old caps -- do NOT use in new code */
 	void *security;
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */
--- linux-2.6.6-mm2/include/linux/init_task.h~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/include/linux/init_task.h	2004-05-13 11:42:51.000000000 -0700
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

