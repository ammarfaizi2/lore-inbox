Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUEXXjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUEXXjX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUEXXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:39:23 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:37866 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263932AbUEXXjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:39:01 -0400
From: Andy Lutomirski <luto@myrealbox.com>
To: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] caps, compromise version (was Re: [PATCH] scaled-back caps, take 4)
Date: Mon, 24 May 2004 16:38:07 -0700
User-Agent: KMail/1.6.2
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, luto@myrealbox.com
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40AABE49.1050401@myrealbox.com> <20040519003013.L21045@build.pdx.osdl.net>
In-Reply-To: <20040519003013.L21045@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405241638.07296.luto@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hehe, arm wrestling could be entertaining ;-)  I'm in favor of the most
> conservative change, which I feel is in my patch.  But I'm game to
> continue to pick on each.


I like your legacy mode.  I don't like making processes inherit
non-legacyness.  (With your patch, some daemon might be secure
when started from initscripts but insecure when started from the
command line, if root ended up in non-legacy mode.)

You've also convinced me that an inheritable mask is good, because
it may make some IRIX apps work.  It's also necessary for this patch
to be safe.

I don't like touching the inode in the security module (you
forgot to check nosuid, for one thing).

So here's another shot at it:

"Legacy mode" is controlled by a new bit in task_struct called
keep_all_caps (controlled by PRCTL_SET_KEEPALLCAPS).  This bit turns
off setuid emulation completely (except for setfsuid).

The evolution rules are:
pP' = (fP & X) | (pI & pP) [with the setuid-nonroot fix]
pE' = (pE | fP) & pP'
pI' = full

This time around, I haven't touched the unsafeness rules.

The magic is in the setuid emulation:
	if (current->uid == 0 || current->euid == 0)
		cap_set_full(current->cap_inheritable);
	else
		cap_clear(current->cap_inheritable);

So, unless a program plays with it's inheritable mask,
root will not pick up caps on exec (which is good -- it
means it's safe to chroot somewhere, disable all caps
except CAP_SETUID, and let untrusted code play around.)
But, if you start as root and setuid away, _even with
keepcaps_, you lose the caps on exec.  Which is the broken
behavior we want to preserve.

So, to avoid this, new code can either set keep_all_caps
or just explicitly enable inheritance after setuid, in
which case it just works.

I have pI' = full because otherwise it's just one more
(partially) user-controlled variable that programs need
to worry about.  (And because anything else would break
root.)

As for the rest of the changes:

The code no longer assumes that pI<pP, so I yanked all checks
on the inheritable mask.  On the other hand, it makes no
sense to me for capset when changing lots of processes'
masks to affect the inheritable mask.  So I made it leave
it alone, except when changing current.

keep_all_caps is clearly not entirely necessary.  I can take
it out if anyone objects.

I yanked all capset sanity checks from kernel/capability.c --
they were duplicates anyway.

And I left the old (IMHO pointless) behavior that one needs to hack
init in order to use CAP_SETPCAP.

[Side note: for cap_bset to be useful, I think there needs to be
an operation "atomically remove these caps from all tasks."  I
don't see one.]

This patch also should work fine if VFS capabilities are
introduced (there's an fP mask which defaults to (setuid-
root ? full : 0).

Patch against 2.6.6-mm4 (-mm5 didn't like my filesystem...).
It's not as well tested as it should be.  The old cap.cc
tool still works (but remember to set inheritable).  I
don't have a tool yet to play with keep_all_caps.

This depends on my cleanup patch from Saturday.

--Andy

Signed-off-by: Andy Lutomirski (luto@myrealbox.com)

 fs/exec.c                  |    8 +++++-
 include/linux/binfmts.h    |    2 +
 include/linux/capability.h |    2 -
 include/linux/init_task.h  |    1 
 include/linux/prctl.h      |    4 +++
 include/linux/sched.h      |    1 
 kernel/capability.c        |   13 ----------
 kernel/sys.c               |   11 +++++++++
 security/commoncap.c       |   54 +++++++++++++++++++++++++++++++--------------
 9 files changed, 64 insertions(+), 32 deletions(-)

--- 2.6.6-mm4/fs/exec.c~cap_2	2004-05-23 22:22:42.000000000 -0700
+++ 2.6.6-mm4/fs/exec.c	2004-05-23 22:43:22.000000000 -0700
@@ -886,8 +886,10 @@
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
+		if (mode & S_ISUID) {
 			bprm->e_uid = inode->i_uid;
+			bprm->secflags |= BINPRM_SEC_SETUID;
+		}
 
 		/* Set-gid? */
 		/*
@@ -895,8 +897,10 @@
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			bprm->e_gid = inode->i_gid;
+			bprm->secflags |= BINPRM_SEC_SETGID;
+		}
 	}
 
 	/* fill in binprm security blob */
--- 2.6.6-mm4/security/commoncap.c~cap_2	2004-05-23 22:15:39.000000000 -0700
+++ 2.6.6-mm4/security/commoncap.c	2004-05-24 14:32:43.210834050 -0700
@@ -57,13 +57,6 @@
 		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	/* Derived from kernel/capability.c:sys_capset. */
-	/* verify restrictions on target's new Inheritable set */
-	if (!cap_issubset (*inheritable,
-			   cap_combine (target->cap_inheritable,
-					current->cap_permitted))) {
-		return -EPERM;
-	}
-
 	/* verify restrictions on target's new Permitted set */
 	if (!cap_issubset (*permitted,
 			   cap_combine (target->cap_permitted,
@@ -83,12 +76,19 @@
 		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	target->cap_effective = *effective;
-	target->cap_inheritable = *inheritable;
 	target->cap_permitted = *permitted;
+	if (current == target)
+		target->cap_inheritable = *inheritable;
 }
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+	/* Pretend we have VFS capabilities */
+	if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
+		cap_set_full(bprm->cap_permitted);
+	else
+		cap_clear(bprm->cap_permitted);		
+
 	return 0;
 }
 
@@ -96,10 +96,9 @@
 {
 	kernel_cap_t new_pP, new_pE;
 
-	if (bprm->e_uid == 0 || current->uid == 0)
-		new_pP = cap_bset;
-	else
-		cap_clear(new_pP);
+	new_pP = cap_combine(cap_intersect(bprm->cap_permitted, cap_bset),
+			     cap_intersect(current->cap_permitted,
+					   current->cap_inheritable));
 
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
 	    !cap_issubset (new_pP, current->cap_permitted)) {
@@ -115,10 +114,15 @@
 		}
 	}
 
-	if (bprm->e_uid == 0)
-		new_pE = new_pP;
-	else
-		cap_clear(new_pE);
+	/* setuid-nonroot is special. */
+	if (bprm->e_uid != 0 && current->uid != 0 && current->euid == 0)
+		cap_clear(new_pP);
+
+	new_pE = cap_combine(current->cap_effective, bprm->cap_permitted);
+	cap_mask(new_pE, new_pP);
+
+	if (!cap_issubset(new_pP, current->cap_permitted))
+		bprm->secflags |= BINPRM_SEC_SECUREEXEC;
 
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
@@ -129,11 +133,13 @@
 	if (current->pid != 1) {
 		current->cap_permitted = new_pP;
 		current->cap_effective = new_pE;
+		cap_set_full(current->cap_inheritable);
 	}
 
 	/* AUD: Audit candidate if current->cap_effective is set */
 
 	current->keep_capabilities = 0;
+	current->keep_all_caps = 0;
 }
 
 int cap_bprm_secureexec (struct linux_binprm *bprm)
@@ -191,10 +197,18 @@
  * Keeping uid 0 is not an option because uid 0 owns too many vital
  * files..
  * Thanks to Olaf Kirch and Peter Benie for spotting this.
+ *
+ * luto - New behavior, May '04
+ * To emulate old evolution rules, inheritable tracks uid and euid.
+ * prctl(PRCTL_SET_KEEPALLCAPS) disables this.  In fact, keepallcaps
+ * disables this whole function.  BE CAREFUL ABOUT THE EFFECTIVE MASK!!!
  */
 static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
 					int old_suid)
 {
+	if (current->keep_all_caps)
+		return;
+
 	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
 	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
 	    !current->keep_capabilities) {
@@ -207,6 +221,11 @@
 	if (old_euid != 0 && current->euid == 0) {
 		current->cap_effective = current->cap_permitted;
 	}
+
+	if (current->uid == 0 || current->euid == 0)
+		cap_set_full(current->cap_inheritable);
+	else
+		cap_clear(current->cap_inheritable);
 }
 
 int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
@@ -230,6 +249,9 @@
 			/*
 			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
 			 *          if not, we might be a bit too harsh here.
+			 *
+			 * This explicitly ignores keep_all_caps.  The
+			 * potential for error is just too large.
 			 */
 
 			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
--- 2.6.6-mm4/kernel/sys.c~cap_2	2004-05-23 22:15:24.000000000 -0700
+++ 2.6.6-mm4/kernel/sys.c	2004-05-23 22:57:40.000000000 -0700
@@ -1646,6 +1646,17 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_GET_KEEPALLCAPS:
+			if (current->keep_all_caps)
+				error = 1;
+			break;
+		case PR_SET_KEEPALLCAPS:
+			if (arg2 != 0 && arg2 != 1) {
+				error = -EINVAL;
+				break;
+			}
+			current->keep_all_caps = arg2;
+			break;
 		default:
 			error = -EINVAL;
 			break;
--- 2.6.6-mm4/kernel/capability.c~cap_2	2004-05-23 23:11:49.000000000 -0700
+++ 2.6.6-mm4/kernel/capability.c	2004-05-23 23:13:14.000000000 -0700
@@ -174,19 +174,6 @@
      if (security_capset_check(target, &effective, &inheritable, &permitted))
 	     goto out;
 
-     if (!cap_issubset(inheritable, cap_combine(target->cap_inheritable,
-                       current->cap_permitted)))
-             goto out;
-
-     /* verify restrictions on target's new Permitted set */
-     if (!cap_issubset(permitted, cap_combine(target->cap_permitted,
-                       current->cap_permitted)))
-             goto out;
-
-     /* verify the _new_Effective_ is a subset of the _new_Permitted_ */
-     if (!cap_issubset(effective, permitted))
-             goto out;
-
      ret = 0;
 
      /* having verified that the proposed changes are legal,
--- 2.6.6-mm4/include/linux/capability.h~cap_2	2004-05-23 22:42:22.000000000 -0700
+++ 2.6.6-mm4/include/linux/capability.h	2004-05-23 22:42:34.000000000 -0700
@@ -309,7 +309,7 @@
 #define CAP_EMPTY_SET       to_cap_t(0)
 #define CAP_FULL_SET        to_cap_t(~0)
 #define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
+#define CAP_INIT_INH_SET    CAP_FULL_SET
 
 #define CAP_TO_MASK(x) (1 << (x))
 #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
--- 2.6.6-mm4/include/linux/sched.h~cap_2	2004-05-23 22:04:50.000000000 -0700
+++ 2.6.6-mm4/include/linux/sched.h	2004-05-23 22:11:15.000000000 -0700
@@ -462,6 +462,7 @@
 	struct group_info *group_info;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
+	int keep_all_caps:1;
 	struct user_struct *user;
 /* limits */
 	struct rlimit rlim[RLIM_NLIMITS];
--- 2.6.6-mm4/include/linux/prctl.h~cap_2	2004-05-23 22:12:18.000000000 -0700
+++ 2.6.6-mm4/include/linux/prctl.h	2004-05-23 22:13:35.000000000 -0700
@@ -20,6 +20,10 @@
 #define PR_GET_KEEPCAPS   7
 #define PR_SET_KEEPCAPS   8
 
+/* Get/set whether to emulate old capability behavior */
+#define PR_GET_KEEPALLCAPS 15
+#define PR_SET_KEEPALLCAPS 16
+
 /* Get/set floating-point emulation control bits (if meaningful) */
 #define PR_GET_FPEMU  9
 #define PR_SET_FPEMU 10
--- 2.6.6-mm4/include/linux/binfmts.h~cap_2	2004-05-23 22:27:43.000000000 -0700
+++ 2.6.6-mm4/include/linux/binfmts.h	2004-05-23 22:27:58.000000000 -0700
@@ -21,6 +21,8 @@
  * This structure is used to hold the arguments that are used when loading binaries.
  */
 #define BINPRM_SEC_SECUREEXEC	1
+#define BINPRM_SEC_SETUID	2
+#define BINPRM_SEC_SETGID	4
 struct linux_binprm{
 	char buf[BINPRM_BUF_SIZE];
 	struct page *page[MAX_ARG_PAGES];
--- 2.6.6-mm4/include/linux/init_task.h~cap_2	2004-05-23 22:11:27.000000000 -0700
+++ 2.6.6-mm4/include/linux/init_task.h	2004-05-23 22:11:44.000000000 -0700
@@ -96,6 +96,7 @@
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
 	.keep_capabilities = 0,						\
+	.keep_all_caps  = 0,						\
 	.rlim		= INIT_RLIMITS,					\
 	.user		= INIT_USER,					\
 	.comm		= "swapper",					\



