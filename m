Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWIIMtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWIIMtR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 08:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWIIMtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 08:49:17 -0400
Received: from nef2.ens.fr ([129.199.96.40]:7185 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932132AbWIIMtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 08:49:16 -0400
Date: Sat, 9 Sep 2006 14:49:13 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060909124913.GA22748@clipper.ens.fr>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz> <20060908041034.GB24135@clipper.ens.fr> <edt3m6$9kn$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edt3m6$9kn$1@taverner.cs.berkeley.edu>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sat, 09 Sep 2006 14:49:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 01:01:02AM +0000, David Wagner wrote:
> David Madore  wrote:
> >On Fri, Sep 08, 2006 at 12:54:29AM +0200, Pavel Machek wrote:
> >>		      Alternatively disallow suid/sgid-anything exec
> >> when all "usual" capabilities are not present.
> >
> >This is probably too stringent: remove any trivial capability
> >whatsoever and you lose a rather important ability.
> 
> This might not be so terrible.  At least, I'm not sure I'd rule it
> out at this point -- it seems like it might be worth considering.

The following patch (follows version 0.4.3 of my main patch) should
make people happy in this respect: it adds a securebit (off by
default) to enable suid non-root execution by underprivileged
processes.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---
 fs/exec.c                  |   16 ++++++++++++----
 include/linux/securebits.h |    9 +++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1cb5e34..adf834b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -44,6 +44,7 @@ #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/security.h>
+#include <linux/securebits.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
@@ -918,6 +919,7 @@ int prepare_binprm(struct linux_binprm *
 	int mode;
 	struct inode * inode = bprm->file->f_dentry->d_inode;
 	int retval;
+	char ok_to_sxid;
 
 	mode = inode->i_mode;
 	if (bprm->file->f_op == NULL)
@@ -928,9 +930,16 @@ int prepare_binprm(struct linux_binprm *
 	bprm->is_suid = 0;
 	bprm->is_sgid = 0;
 
-	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
+	ok_to_sxid = capable(CAP_REG_SXID)
+	  && !(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID);
+	if (!cap_issubset(CAP_REGULAR_SET, current->cap_permitted)
+	    && !issecure(SECURE_UNDERPRIVILEGED_MAY_SXID)
+	    && (issecure(SECURE_NOROOT) || inode->i_uid != 0))
+		ok_to_sxid = 0;
+
+	if (ok_to_sxid) {
 		/* Set-uid? */
-		if (mode & S_ISUID && capable(CAP_REG_SXID)) {
+		if (mode & S_ISUID) {
 			bprm->is_suid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_uid = inode->i_uid;
@@ -942,8 +951,7 @@ int prepare_binprm(struct linux_binprm *
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)
-		    && capable(CAP_REG_SXID)) {
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			bprm->is_sgid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_gid = inode->i_gid;
diff --git a/include/linux/securebits.h b/include/linux/securebits.h
index 5b06178..16e8f3e 100644
--- a/include/linux/securebits.h
+++ b/include/linux/securebits.h
@@ -18,6 +18,15 @@ #define SECURE_NOROOT            0
    privileges. When unset, setuid doesn't change privileges. */
 #define SECURE_NO_SETUID_FIXUP   2
 
+/* When set, allow underprivileged processes (= not possessing all
+   "regular" caps) to execute SUID/SGID executables (this is a
+   security issue as such executables might be surprised to run with
+   reduced privileges); if SECURE_NOROOT is _not_ set, this _does not_
+   apply to SUID root processes (they are already made secure by
+   raising all caps).  Removing the (regular) CAP_REG_SXID capability
+   also always inhibits any kind of SUID/SGID. */
+#define SECURE_UNDERPRIVILEGED_MAY_SXID 4
+
 /* Each securesetting is implemented using two bits. One bit specify
    whether the setting is on or off. The other bit specify whether the
    setting is fixed or not. A setting which is fixed cannot be changed
