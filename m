Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUEWJa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUEWJa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUEWJa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:30:29 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:5058 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261752AbUEWJ3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:29:53 -0400
From: Andy Lutomirski <luto@myrealbox.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] scaled-back caps, take 4
Date: Sun, 23 May 2004 02:28:28 -0700
User-Agent: KMail/1.6.2
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40AABE49.1050401@myrealbox.com> <20040519003013.L21045@build.pdx.osdl.net>
In-Reply-To: <20040519003013.L21045@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405230228.28418.luto@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 May 2004 00:30, Chris Wright wrote:
> * Andy Lutomirski (luto@myrealbox.com) wrote:
> > Chris Wright wrote:

> > The reason I didn't go for something like your approach (other than not 
> > thinking of it) was that, as long as we're changing the semantics, we might 
> > as well make them as clean as possible.  I also didn't mind ripping out 
> > lots of old code :).  If the inheritable mask stays, then programs need to 
> > be audited for what happens if they are run with different inheritable 
> > masks.  I'd rather just eliminate that complication and the corresponding 
> > blob of commoncap code.  Obviously my patch fails a lot of your tests as a 
> > result.
> 
> Actually the only glaring difference (aside from the uid/suid and non-root
> execs nonroot-yet-diff-id-setuid-app issue I mentioned earlier) is in
> something like "=ep cap_setpcap-ep cap_ipc_lock+i" IIRC.
> 
> I have the feeling we both are after the same thing, which is introducing
> the ability to keep some caps through exec and still being able to sleep
> at night w/ confidence that there isn't some subtle new hole lurking.
> This is why I aimed to change as little code as possible.
> 
> > So do we arm-wrestle over whose implementation wins? :)  I'd say mine wins 
> > on readability (not your fault -- the old code was pretty bad to begin 
> > with) and some simplicity, but yours has the benefit of being less intrusive.
> 
> Hehe, arm wrestling could be entertaining ;-)  I'm in favor of the most
> conservative change, which I feel is in my patch.  But I'm game to
> continue to pick on each.
> 

You don't like my patch because it rips out a bunch of code and it's
not clear it won't break stuff.

I don't like your patch because it takes a bunch of incomprehensible
code that does almost nothing and tweaks it slightly to do something
useful.  (That's not to say it's does the wrong thing; I just don't
think the code is clear.)

So I decided to figure out what was going on with the original code.

First, CAP_SETPCAP is never obtainable (by anything).
Since cap_bset never has this bit set, nothing can inherit it
from fP.  capset_check prevents it from getting set in pI.

Second, cap_bset is broken.  For one thing, there's no way
to remove the caps you want to restrict from already-running
tasks.  So I don't think it matters if we break/change it.


cap_bprm_set_security does:
fP = fI = (new_uid == 0 || new_euid == 0)
fE = (new_euid == 0)

cap_bprm_apply_creds then does:
1. pP' = (fP & X) | (fI & pI)
2. unsafeness stuff
3. fix up uids
4. pE' = fE & pP'

Now for the fun part:

Since fP == fI, pP' = fP & (X | pI)
But X | pI == X (since pI can't have CAP_SETPCAP and X==~CAP_SETPCAP)
So pP' = fP & X

pE' == fE & pP' == fE & fP & X
But fE & fP == fE, so:
pE' = fE & X

The whole result is just
pP' = (uid == 0 || euid==0) & X
pE' = (euid == 0) & X


This patch implements this.  It should be invisible to userspace
(unless userspace (ab)uses cap_bset).  It also adds a secureexec
flag, which we both need.

First, did I get this right?  It seems to work :)

Second, do you have any objection to both of us redoing our
patches against this one?  It should make them nicer-looking
at least.

--Andy

--- 2.6.6-mm4/fs/exec.c~cap_cleanup	2004-05-19 10:37:25.000000000 -0700
+++ 2.6.6-mm4/fs/exec.c	2004-05-21 19:03:16.000000000 -0700
@@ -1093,6 +1093,7 @@
 	bprm.loader = 0;
 	bprm.exec = 0;
 	bprm.security = NULL;
+	bprm.secflags = 0;
 	bprm.mm = mm_alloc();
 	retval = -ENOMEM;
 	if (!bprm.mm)
--- 2.6.6-mm4/security/commoncap.c~cap_cleanup	2004-05-21 18:51:42.000000000 -0700
+++ 2.6.6-mm4/security/commoncap.c	2004-05-23 01:42:51.000000000 -0700
@@ -89,44 +89,20 @@
 
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
-	 */
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
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
-	/* Derived from fs/exec.c:compute_creds. */
-	kernel_cap_t new_permitted, working;
+	kernel_cap_t new_pP, new_pE;
 
-	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
-	working = cap_intersect (bprm->cap_inheritable,
-				 current->cap_inheritable);
-	new_permitted = cap_combine (new_permitted, working);
+	if (bprm->e_uid == 0 || current->uid == 0)
+		new_pP = cap_bset;
+	else
+		cap_clear(new_pP);
 
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
-	    !cap_issubset (new_permitted, current->cap_permitted)) {
+	    !cap_issubset (new_pP, current->cap_permitted)) {
 		current->mm->dumpable = 0;
 
 		if (unsafe & ~LSM_UNSAFE_PTRACE_CAP) {
@@ -134,13 +110,16 @@
 				bprm->e_uid = current->uid;
 				bprm->e_gid = current->gid;
 			}
-			if (!capable (CAP_SETPCAP)) {
-				new_permitted = cap_intersect (new_permitted,
-							current->cap_permitted);
-			}
+			new_pP = cap_intersect (new_pP,
+						current->cap_permitted);
 		}
 	}
 
+	if (bprm->e_uid == 0)
+		new_pE = new_pP;
+	else
+		cap_clear(new_pE);
+
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
@@ -148,9 +127,8 @@
 	 * in the init_task struct. Thus we skip the usual
 	 * capability rules */
 	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective =
-		    cap_intersect (new_permitted, bprm->cap_effective);
+		current->cap_permitted = new_pP;
+		current->cap_effective = new_pE;
 	}
 
 	/* AUD: Audit candidate if current->cap_effective is set */
@@ -160,13 +138,9 @@
 
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
--- 2.6.6-mm4/include/linux/binfmts.h~cap_cleanup	2004-05-19 10:37:25.000000000 -0700
+++ 2.6.6-mm4/include/linux/binfmts.h	2004-05-23 02:24:31.034876220 -0700
@@ -20,6 +20,7 @@
 /*
  * This structure is used to hold the arguments that are used when loading binaries.
  */
+#define BINPRM_SEC_SECUREEXEC	1
 struct linux_binprm{
 	char buf[BINPRM_BUF_SIZE];
 	struct page *page[MAX_ARG_PAGES];
@@ -28,6 +29,7 @@
 	int sh_bang;
 	struct file * file;
 	int e_uid, e_gid;
+	int secflags;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
 	void *security;
 	int argc, envc;


