Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUENWuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUENWuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUENWuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:50:17 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:48783 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S263088AbUENWtA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:49:00 -0400
From: Andy Lutomirski <luto@myrealbox.com>
To: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] scaled-back caps, take 4 (was Re: [PATCH] capabilites, take 2)
Date: Fri, 14 May 2004 15:48:04 -0700
User-Agent: KMail/1.6.2
Cc: Andy Lutomirski <luto@stanford.edu>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu> <20040514110752.U21045@build.pdx.osdl.net>
In-Reply-To: <20040514110752.U21045@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405141548.05106.luto@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 May 2004 11:07, Chris Wright wrote:
> * Andy Lutomirski (luto@stanford.edu) wrote:
> > Stephen Smalley wrote:
> > > On Fri, 2004-05-14 at 11:57, Andy Lutomirski wrote:
> > > > Thanks -- turning brain back on, SELinux is obviously better than any
> > > > fine-grained capability scheme I can imagine.
> > > > 
> > > > So unless anyone convinces me you're wrong, I'll stick with just
> > > > fixing up capabilities to work without making them finer-grained.
> > > 
> > > Great, thanks.  Fixing capabilities to work is definitely useful and
> > > desirable.  Significantly expanding them in any manner is a poor use of
> > > limited resources, IMHO; I'd much rather see people work on applying
> > > SELinux to the problem and solving it more effectively for the future.
> > 
> > Does this mean I should trash my 'maximum' mask?
> > 
> > (I like 'cap -c = sftp-server' so it can't try to run setuid/fP apps.)
> > OTOH, since SELinux accomplishes this better, it may not be worth the
> > effort.
> 
> Let's just get back to the simplest task.  Allow execve() to do smth.
> reasonable with capabilities.

Sold.

This version throws out the inheritable mask.  There is no change in
behavior with newcaps=0.

All that's left in newcaps=1 mode is:

fP := permitted (app gains these)
pP := permitted (app can make them effective)
pE := effective

There is no inheritable mask :)  So we can't argue about what it's
supposed to / not supposed to.

It's not too well tested yet.  Enjoy.

--Andy

cap_2.6.6-mm2_4.patch: New stripped-back capabilities.

 fs/exec.c               |   15 ++++-
 include/linux/binfmts.h |    9 ++-
 security/commoncap.c    |  130 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 136 insertions(+), 18 deletions(-)

--- linux-2.6.6-mm2/fs/exec.c~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/fs/exec.c	2004-05-14 12:36:17.000000000 -0700
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
@@ -891,10 +893,18 @@
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
+	if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
+		cap_set_full(bprm->cap_permitted);
+	else
+		cap_clear(bprm->cap_permitted);
+
 	/* fill in binprm security blob */
 	retval = security_bprm_set(bprm);
 	if (retval)
@@ -1089,6 +1099,7 @@
 	bprm.loader = 0;
 	bprm.exec = 0;
 	bprm.security = NULL;
+	bprm.secflags = 0;
 	bprm.mm = mm_alloc();
 	retval = -ENOMEM;
 	if (!bprm.mm)
--- linux-2.6.6-mm2/security/commoncap.c~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/security/commoncap.c	2004-05-14 13:24:45.000000000 -0700
@@ -24,6 +24,11 @@
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
 
+static int newcaps = 0;
+
+module_param(newcaps, int, 444);
+MODULE_PARM_DESC(newcaps, "Set newcaps=1 to enable experimental capabilities");
+
 int cap_capable (struct task_struct *tsk, int cap)
 {
 	/* Derived from include/linux/sched.h:capable. */
@@ -48,17 +53,19 @@
 {
 	/* Derived from kernel/capability.c:sys_capget. */
 	*effective = cap_t (target->cap_effective);
-	*inheritable = cap_t (target->cap_inheritable);
 	*permitted = cap_t (target->cap_permitted);
+	if (newcaps)
+		*inheritable = CAP_EMPTY_SET;
+	else
+		*inheritable = cap_t (target->cap_inheritable);
 	return 0;
 }
 
 int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
 		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	/* Derived from kernel/capability.c:sys_capset. */
 	/* verify restrictions on target's new Inheritable set */
-	if (!cap_issubset (*inheritable,
+	if (!newcaps && !cap_issubset (*inheritable,
 			   cap_combine (target->cap_inheritable,
 					current->cap_permitted))) {
 		return -EPERM;
@@ -83,12 +90,16 @@
 		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	target->cap_effective = *effective;
-	target->cap_inheritable = *inheritable;
 	target->cap_permitted = *permitted;
+	if (!newcaps)
+		target->cap_inheritable = *inheritable;
 }
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+	if (newcaps)
+		return 0;
+
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	/* We don't have VFS support for capabilities yet */
@@ -115,9 +126,9 @@
 	return 0;
 }
 
-void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
+static void cap_bprm_apply_creds_compat (struct linux_binprm *bprm, int unsafe)
 {
-	/* Derived from fs/exec.c:compute_creds. */
+	/* This function will hopefully die in 2.7. */
 	kernel_cap_t new_permitted, working;
 
 	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
@@ -158,15 +169,88 @@
 	current->keep_capabilities = 0;
 }
 
+/*
+ * The rules of Linux capabilities (not POSIX!)
+ *
+ * What the masks mean:
+ *  pP = capabilities that this process has
+ *  pE = capabilities that this process has and are enabled
+ * (so pE <= pP)
+ *
+ * The capability evolution rules are:
+ *
+ *  pP' = ((fP & cap_bset) | pP) & Y
+ *  pE' = (pE | fP) & pP'
+ *
+ *  X = cap_bset
+ *  Y is zero if uid!=0, euid==0, and setuid non-root
+ *
+ *  Exception: if setuid-nonroot, then pE' is reset to 0.
+ *
+ * If file capabilities are introduced, programs that are granted
+ * fP > 0 need to be aware of how to deal with it.
+ * Because the effective set is left alone on non-setuid fP>0,
+ * such a program should drop capabilities that were not in its initial
+ * effective set before running untrusted code.
+ *
+ */
+void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
+{
+	kernel_cap_t new_pP, new_pE, fP;
+	int is_setuid, is_setgid;
+
+	if(!newcaps) {
+		cap_bprm_apply_creds_compat(bprm, unsafe);
+		return;
+	}
+
+	fP = bprm->cap_permitted;
+	is_setuid = (bprm->secflags & BINPRM_SEC_SETUID);
+	is_setgid = (bprm->secflags & BINPRM_SEC_SETGID);
+
+	/* Check that it's safe to elevate privileges */
+	if (unsafe & ~LSM_UNSAFE_PTRACE_CAP)
+		bprm->secflags |= BINPRM_SEC_NOELEVATE;
+
+	if (bprm->secflags & BINPRM_SEC_NOELEVATE) {
+		is_setuid = is_setgid = 0;
+		cap_clear(fP);
+	}
+
+	new_pP = cap_intersect(fP, cap_bset);
+	new_pP = cap_combine(new_pP, current->cap_permitted);
+
+	/* setuid-nonroot is special. */
+	if (is_setuid && bprm->e_uid != 0 && current->uid != 0 &&
+	    current->euid == 0)
+		cap_clear(new_pP);
+
+	if (!cap_issubset(new_pP, current->cap_permitted))
+		bprm->secflags |= BINPRM_SEC_SECUREEXEC;
+
+	new_pE = cap_combine(current->cap_effective, fP);
+	cap_mask(new_pE, new_pP);
+	if (is_setuid && bprm->e_uid != 0)
+		cap_clear(new_pE);
+
+	/* Apply new security state */
+	if (is_setuid) {
+	        current->suid = current->euid = current->fsuid = bprm->e_uid;
+	}
+	if (is_setgid)
+	        current->sgid = current->egid = current->fsgid = bprm->e_gid;
+
+	current->cap_permitted = new_pP;
+	current->cap_effective = new_pE;
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
@@ -280,9 +364,14 @@
 
 void cap_task_reparent_to_init (struct task_struct *p)
 {
-	p->cap_effective = CAP_INIT_EFF_SET;
-	p->cap_inheritable = CAP_INIT_INH_SET;
-	p->cap_permitted = CAP_FULL_SET;
+	if (newcaps) {
+		cap_set_full(p->cap_permitted);
+		cap_set_full(p->cap_effective);
+	} else {
+		p->cap_effective = CAP_INIT_EFF_SET;
+		p->cap_inheritable = CAP_INIT_INH_SET;
+		p->cap_permitted = CAP_FULL_SET;
+	}
 	p->keep_capabilities = 0;
 	return;
 }
@@ -367,6 +456,15 @@
 	return -ENOMEM;
 }
 
+static int __init commoncap_init (void)
+{
+	if (newcaps) {
+		printk(KERN_NOTICE "Experimental capability support is on\n");
+	}
+
+	return 0;
+}
+
 EXPORT_SYMBOL(cap_capable);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
@@ -382,5 +480,7 @@
 EXPORT_SYMBOL(cap_syslog);
 EXPORT_SYMBOL(cap_vm_enough_memory);
 
+module_init(commoncap_init);
+
 MODULE_DESCRIPTION("Standard Linux Common Capabilities Security Module");
 MODULE_LICENSE("GPL");
--- linux-2.6.6-mm2/include/linux/binfmts.h~caps	2004-05-13 11:42:26.000000000 -0700
+++ linux-2.6.6-mm2/include/linux/binfmts.h	2004-05-14 10:28:05.000000000 -0700
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
@@ -28,7 +32,10 @@
 	int sh_bang;
 	struct file * file;
 	int e_uid, e_gid;
-	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
+	int secflags;
+	kernel_cap_t cap_permitted;
+	/* old caps -- do NOT use in new code */
+	kernel_cap_t cap_inheritable, cap_effective;
 	void *security;
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */

