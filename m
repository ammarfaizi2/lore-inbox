Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUELDY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUELDY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUELDYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:24:55 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:57293 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S264998AbUELDY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:24:28 -0400
From: Andy Lutomirski <luto@myrealbox.com>
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] capabilities: cleanups
Date: Tue, 11 May 2004 20:24:23 -0700
User-Agent: KMail/1.6.2
Cc: luto@myrealbox.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405112024.23834.luto@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move setuid logic out of cap_brpm_set_security; modify linux_binprm
to store the relevent information.

 fs/exec.c               |   25 +++++++++++++++++-------
 include/linux/binfmts.h |    8 +++++--
 security/commoncap.c    |   50 ++++++++++++++++++++---------------------------- 3 files changed, 45 insertions(+), 38 deletions(-)

--- linux-2.6.6-mm1/fs/exec.c~cap_1_cleanup	2004-05-10 23:55:39.000000000 -0700
+++ linux-2.6.6-mm1/fs/exec.c	2004-05-11 00:14:05.000000000 -0700
@@ -833,7 +833,7 @@
 
 	flush_thread();
 
-	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid || 
+	if (bprm->set_uid != current->euid || bprm->set_gid != current->egid || 
 	    permission(bprm->file->f_dentry->d_inode,MAY_READ, NULL) ||
 	    (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP))
 		current->mm->dumpable = 0;
@@ -877,13 +877,15 @@
 	if (bprm->file->f_op == NULL)
 		return -EACCES;
 
-	bprm->e_uid = current->euid;
-	bprm->e_gid = current->egid;
+	bprm->set_uid = current->euid;
+	bprm->set_gid = current->egid;
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
-			bprm->e_uid = inode->i_uid;
+		if (mode & S_ISUID) {
+			bprm->set_uid = inode->i_uid;
+			bprm->secflags |= BINPRM_SEC_SETUID;
+		}
 
 		/* Set-gid? */
 		/*
@@ -891,10 +893,19 @@
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
-			bprm->e_gid = inode->i_gid;
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+			bprm->set_gid = inode->i_gid;
+			bprm->secflags |= BINPRM_SEC_SETGID;
+		}
 	}
 
+	/* Pretend we have VFS capabilities */
+	cap_set_full(bprm->cap_inheritable);
+	if((bprm->secflags & BINPRM_SEC_SETUID) && bprm->set_uid == 0)
+		cap_set_full(bprm->cap_permitted);
+	else
+		cap_clear(bprm->cap_permitted);
+
 	/* fill in binprm security blob */
 	retval = security_bprm_set(bprm);
 	if (retval)
--- linux-2.6.6-mm1/security/commoncap.c~cap_1_cleanup	2004-05-10 23:54:18.000000000 -0700
+++ linux-2.6.6-mm1/security/commoncap.c	2004-05-11 19:47:28.394725741 -0700
@@ -89,29 +89,10 @@
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
-	/* Copied from fs/exec.c:prepare_binprm. */
-
-	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
-	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
-
-	/*  To support inheritance of root-permissions and suid-root
-	 *  executables under compatibility mode, we raise all three
-	 *  capability sets for the file.
-	 *
-	 *  If only the real uid is 0, we only raise the inheritable
-	 *  and permitted sets of the executable file.
+	/* The generic code is in fs/exec.c.  We don't do any magic
+	 * here, because we need the unsafe flag that gets passed
+	 * to apply_creds.  So all the logic goes there.
 	 */
-
-	if (!issecure (SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
-			cap_set_full (bprm->cap_inheritable);
-			cap_set_full (bprm->cap_permitted);
-		}
-		if (bprm->e_uid == 0)
-			cap_set_full (bprm->cap_effective);
-	}
 	return 0;
 }
 
@@ -120,19 +101,29 @@
 	/* Derived from fs/exec.c:compute_creds. */
 	kernel_cap_t new_permitted, working;
 
+	/* This code is clearly broken.  I think it's equivalent
+	 * to the old code...
+	 */
+	int euid, egid;
+	euid = bprm->set_uid;
+	egid = bprm->set_gid;
+	if (euid != 0 && current->uid != 0)
+		cap_clear(bprm->cap_inheritable);
+
 	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
 	working = cap_intersect (bprm->cap_inheritable,
 				 current->cap_inheritable);
 	new_permitted = cap_combine (new_permitted, working);
 
-	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
+	if (euid != current->uid || egid != current->gid ||
+
 	    !cap_issubset (new_permitted, current->cap_permitted)) {
 		current->mm->dumpable = 0;
 
 		if (unsafe & ~LSM_UNSAFE_PTRACE_CAP) {
 			if (!capable(CAP_SETUID)) {
-				bprm->e_uid = current->uid;
-				bprm->e_gid = current->gid;
+				euid = current->uid;
+				egid = current->gid;
 			}
 			if (!capable (CAP_SETPCAP)) {
 				new_permitted = cap_intersect (new_permitted,
@@ -141,16 +132,17 @@
 		}
 	}
 
-	current->suid = current->euid = current->fsuid = bprm->e_uid;
-	current->sgid = current->egid = current->fsgid = bprm->e_gid;
+	current->suid = current->euid = current->fsuid = euid;
+	current->sgid = current->egid = current->fsgid = egid;
 
 	/* For init, we want to retain the capabilities set
 	 * in the init_task struct. Thus we skip the usual
 	 * capability rules */
 	if (current->pid != 1) {
 		current->cap_permitted = new_permitted;
-		current->cap_effective =
-		    cap_intersect (new_permitted, bprm->cap_effective);
+		current->cap_effective = new_permitted;
+		if (euid != 0)
+			cap_clear(current->cap_effective);
 	}
 
 	/* AUD: Audit candidate if current->cap_effective is set */
--- linux-2.6.6-mm1/include/linux/binfmts.h~cap_1_cleanup	2004-05-10 23:52:05.000000000 -0700
+++ linux-2.6.6-mm1/include/linux/binfmts.h	2004-05-11 00:58:13.000000000 -0700
@@ -20,6 +20,9 @@
 /*
  * This structure is used to hold the arguments that are used when loading binaries.
  */
+#define BINPRM_SEC_SETUID	1
+#define BINPRM_SEC_SETGID	2
+#define BINPRM_SEC_SECUREEXEC	4
 struct linux_binprm{
 	char buf[BINPRM_BUF_SIZE];
 	struct page *page[MAX_ARG_PAGES];
@@ -27,8 +30,9 @@
 	unsigned long p; /* current top of mem */
 	int sh_bang;
 	struct file * file;
-	int e_uid, e_gid;
-	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
+	int set_uid, set_gid;
+	int secflags;
+	kernel_cap_t cap_inheritable, cap_permitted;
 	void *security;
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */


