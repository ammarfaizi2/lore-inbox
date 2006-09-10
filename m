Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWIJNnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWIJNnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWIJNnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:43:00 -0400
Received: from nef2.ens.fr ([129.199.96.40]:22021 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932133AbWIJNm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:42:59 -0400
Date: Sun, 10 Sep 2006 15:42:57 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060910134257.GC12086@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910133759.GA12086@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 10 Sep 2006 15:42:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce six new "regular" (=on-by-default) capabilities:

 * CAP_REG_FORK, CAP_REG_OPEN, CAP_REG_EXEC allow access to the
   fork(), open() and exec() syscalls,

 * CAP_REG_SXID allows privilege gain on suid/sgid exec,

 * CAP_REG_WRITE controls any write-access to the filesystem,

 * CAP_REG_PTRACE allows ptrace().

See <URL: http://www.madore.org/~david/linux/newcaps/ > for more
detailed explanations.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---
 fs/exec.c                  |    4 ++
 include/linux/binfmts.h    |    1 
 include/linux/securebits.h |    4 ++
 kernel/capability.c        |    2 -
 security/commoncap.c       |   90 ++++++++++++++++++++++++++++++--------------
 5 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 54135df..e4d0a2c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -925,10 +925,13 @@ int prepare_binprm(struct linux_binprm *
 
 	bprm->e_uid = current->euid;
 	bprm->e_gid = current->egid;
+	bprm->is_suid = 0;
+	bprm->is_sgid = 0;
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
 		if (mode & S_ISUID) {
+			bprm->is_suid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_uid = inode->i_uid;
 		}
@@ -940,6 +943,7 @@ int prepare_binprm(struct linux_binprm *
 		 * executable.
 		 */
 		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+			bprm->is_sgid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_gid = inode->i_gid;
 		}
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index c1e82c5..c7fb183 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -29,6 +29,7 @@ struct linux_binprm{
 	struct file * file;
 	int e_uid, e_gid;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
+	char is_suid, is_sgid;
 	void *security;
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */
diff --git a/include/linux/securebits.h b/include/linux/securebits.h
index 5b06178..0092332 100644
--- a/include/linux/securebits.h
+++ b/include/linux/securebits.h
@@ -18,6 +18,10 @@ #define SECURE_NOROOT            0
    privileges. When unset, setuid doesn't change privileges. */
 #define SECURE_NO_SETUID_FIXUP   2
 
+/* When set, exec()ing a suid/sgid program does not force reinstate
+   all "regular" capabilities. */
+#define SECURE_NO_SXID_SANITIZE  4
+
 /* Each securesetting is implemented using two bits. One bit specify
    whether the setting is on or off. The other bit specify whether the
    setting is fixed or not. A setting which is fixed cannot be changed
diff --git a/kernel/capability.c b/kernel/capability.c
index 32b2521..2bb802a 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -15,7 +15,7 @@ #include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
-kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
+kernel_cap_t cap_bset = CAP_INIT_INH_SET;
 
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
diff --git a/security/commoncap.c b/security/commoncap.c
index 91dc53d..291a4bd 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -12,6 +12,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/security.h>
+#include <linux/securebits.h>
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -97,6 +98,8 @@ int cap_capset_check (struct task_struct
 	if (!cap_issubset (*effective, *permitted)) {
 		return -EPERM;
 	}
+	/* we allow Inheritable not to be a subset of Permitted:
+	 * cap_capset_set will intersect them anyway */
 
 	return 0;
 }
@@ -105,7 +108,7 @@ void cap_capset_set (struct task_struct 
 		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	target->cap_effective = *effective;
-	target->cap_inheritable = *inheritable;
+	target->cap_inheritable = cap_intersect (*permitted, *inheritable);
 	target->cap_permitted = *permitted;
 }
 
@@ -114,39 +117,66 @@ int cap_bprm_set_security (struct linux_
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
+	cap_set_full (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
+	cap_set_full (bprm->cap_effective);
+
+	/* Sanitize caps for all suid/sgid programs. */
+	if (!issecure (SECURE_NO_SXID_SANITIZE) && (bprm->is_suid
+						    || bprm->is_sgid)) {
+		/* Ensure that they get _at least_ regular caps. */
+		bprm->cap_permitted = CAP_REGULAR_SET;
+		if ((current->uid != 0 && current->euid != 0
+		     && current->suid != 0)
+		    || issecure (SECURE_NOROOT)) {
+			/* Ensure that they don't get _more_ caps when they
+			   might not expect it.  Note that dropping
+			   capabilities on change of ?uid from ==0 to !=0 will
+			   be handled by cap_task_post_setuid() called from
+			   cap_bprm_apply_creds() below.  Yuck!!!!!!  This is
+			   soooooo ugly! */
+			bprm->cap_inheritable = CAP_REGULAR_SET;
+			bprm->cap_effective = CAP_REGULAR_SET;
+		}
+	}
 
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
 	 *  capability sets for the file.
-	 *
-	 *  If only the real uid is 0, we only raise the inheritable
-	 *  and permitted sets of the executable file.
 	 */
-
 	if (!issecure (SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
+		if (bprm->is_suid && bprm->e_uid == 0) {
 			cap_set_full (bprm->cap_inheritable);
 			cap_set_full (bprm->cap_permitted);
-		}
-		if (bprm->e_uid == 0)
 			cap_set_full (bprm->cap_effective);
+		}
 	}
+
 	return 0;
 }
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
 	/* Derived from fs/exec.c:compute_creds. */
-	kernel_cap_t new_permitted, working;
+	kernel_cap_t new_permitted, new_effective, working;
+	uid_t old_ruid, old_euid, old_suid;
 
+	/* P'(per) = (P(inh) & F(inh)) | (F(per) & bset) */
 	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
 	working = cap_intersect (bprm->cap_inheritable,
 				 current->cap_inheritable);
 	new_permitted = cap_combine (new_permitted, working);
 
+	/* P'(eff) = (P(inh) & P(eff) & F(inh)) | (F(per) & F(eff) & bset) */
+	new_effective = cap_intersect (bprm->cap_permitted, bprm->cap_effective);
+	new_effective = cap_intersect (new_effective, cap_bset);
+	working = cap_intersect (bprm->cap_inheritable,
+				 current->cap_effective);
+	working = cap_intersect (working, current->cap_inheritable);
+	new_effective = cap_combine (new_effective, working);
+
+	/* P'(inh) = P'(per) */
+
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
 	    !cap_issubset (new_permitted, current->cap_permitted)) {
 		current->mm->dumpable = suid_dumpable;
@@ -159,36 +189,37 @@ void cap_bprm_apply_creds (struct linux_
 			if (!capable (CAP_SETPCAP)) {
 				new_permitted = cap_intersect (new_permitted,
 							current->cap_permitted);
+				new_effective = cap_intersect (new_permitted,
+							       new_effective);
 			}
 		}
 	}
 
+	old_ruid = current->uid;
+	old_euid = current->euid;
+	old_suid = current->suid;
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
-	/* For init, we want to retain the capabilities set
-	 * in the init_task struct. Thus we skip the usual
-	 * capability rules */
-	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective =
-		    cap_intersect (new_permitted, bprm->cap_effective);
-	}
-
-	/* AUD: Audit candidate if current->cap_effective is set */
+	current->cap_permitted = new_permitted;
+	current->cap_effective = new_effective;
+	current->cap_inheritable = new_permitted;
 
 	current->keep_capabilities = 0;
+	/* Make sure we drop capabilities if required by suid. */
+	cap_task_post_setuid (old_ruid, old_euid, old_suid, LSM_SETID_RES);
+
+	/* AUD: Audit candidate if current->cap_effective is set */
 }
 
 int cap_bprm_secureexec (struct linux_binprm *bprm)
 {
 	/* If/when this module is enhanced to incorporate capability
 	   bits on files, the test below should be extended to also perform a 
-	   test between the old and new capability sets.  For now,
-	   it simply preserves the legacy decision algorithm used by
-	   the old userland. */
-	return (current->euid != current->uid ||
-		current->egid != current->gid);
+	   test between the old and new capability sets. */
+	return ((bprm->is_suid || bprm->is_sgid)
+		&& !cap_issubset (bprm->cap_permitted,
+				  current->cap_permitted));
 }
 
 int cap_inode_setxattr(struct dentry *dentry, char *name, void *value,
@@ -253,12 +284,15 @@ static inline void cap_emulate_setxuid (
 				= cap_intersect (current->cap_effective,
 						 CAP_REGULAR_SET);
 		}
+		current->cap_inheritable
+			= cap_intersect (current->cap_inheritable,
+					 CAP_REGULAR_SET);
 	}
-	if (old_euid == 0 && current->euid != 0) {
+	if (old_euid == 0 && current->euid != 0 && !current->keep_capabilities) {
 		current->cap_effective = cap_intersect (current->cap_effective,
 							CAP_REGULAR_SET);
 	}
-	if (old_euid != 0 && current->euid == 0) {
+	if (old_euid != 0 && current->euid == 0 && !current->keep_capabilities) {
 		current->cap_effective = current->cap_permitted;
 	}
 }
