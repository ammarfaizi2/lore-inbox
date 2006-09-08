Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWIHS22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWIHS22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWIHS22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:28:28 -0400
Received: from nef2.ens.fr ([129.199.96.40]:6916 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751161AbWIHS20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:28:26 -0400
Date: Fri, 8 Sep 2006 20:28:25 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: [PATCH 2/4] security: capabilities patch (version 0.4.3), part 2/4: change inheritance semantics
Message-ID: <20060908182825.GB2659@clipper.ens.fr>
References: <20060908182157.GA2659@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908182157.GA2659@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 20:28:25 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make capabilities inheritable by default.  The following remarks
apply:

 * executables are assumed by default to have a full set of
   "inheritable" (allowed) and "effective" capabilities,

 * w.r.t. capabilities(7)-documented behavior, inheritance of the
   effective bits is changed (use P(eff) rather than F(eff) in half
   of the formula),

 * also, inheritance of the inheritable set is based on the new
   permitted set rather than on the old inheritable.

See <URL: http://www.madore.org/~david/linux/newcaps/ > for more
detailed explanations.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---
 fs/exec.c               |    4 +++
 include/linux/binfmts.h |    1 +
 kernel/capability.c     |    2 +
 security/commoncap.c    |   69 ++++++++++++++++++++++++++++-------------------
 4 files changed, 47 insertions(+), 29 deletions(-)

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
index 91dc53d..3f90ae8 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -97,6 +97,8 @@ int cap_capset_check (struct task_struct
 	if (!cap_issubset (*effective, *permitted)) {
 		return -EPERM;
 	}
+	/* we allow Inheritable not to be a subset of Permitted:
+	 * cap_capset_set will intersect them anyway */
 
 	return 0;
 }
@@ -105,7 +107,7 @@ void cap_capset_set (struct task_struct 
 		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	target->cap_effective = *effective;
-	target->cap_inheritable = *inheritable;
+	target->cap_inheritable = cap_intersect (*permitted, *inheritable);
 	target->cap_permitted = *permitted;
 }
 
@@ -114,25 +116,20 @@ int cap_bprm_set_security (struct linux_
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
+	cap_set_full (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
+	cap_set_full (bprm->cap_effective);
 
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
 	return 0;
 }
@@ -140,13 +137,25 @@ int cap_bprm_set_security (struct linux_
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
@@ -159,36 +168,37 @@ void cap_bprm_apply_creds (struct linux_
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
@@ -253,12 +263,15 @@ static inline void cap_emulate_setxuid (
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
