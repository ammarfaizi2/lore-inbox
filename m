Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314131AbSDLSd7>; Fri, 12 Apr 2002 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314135AbSDLSd6>; Fri, 12 Apr 2002 14:33:58 -0400
Received: from seldon.terminus.sk ([195.146.17.130]:7387 "EHLO
	seldon.terminus.sk") by vger.kernel.org with ESMTP
	id <S314131AbSDLSd5>; Fri, 12 Apr 2002 14:33:57 -0400
Date: Fri, 12 Apr 2002 20:38:04 +0200 (CEST)
From: Marek Zelem <marek@terminus.sk>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] + story;) on POSIX capabilities and SUID bit
Message-ID: <Pine.LNX.4.33.0204122026170.903-100000@seldon.terminus.sk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello

The POSIX capabilities support defines the file and process capabilities,
and rules to be obeyed at particular events, such as exec() and so.
Because of historic reasons, there is also a SUID bit, which is also
POSIX, and has its own set of rules. You can choose either to use
SUID, or to use POSIX capabilities. If you want to be compatible with
both of them, you have a problem.

Linux internally uses POSIX capabilities to verify permissions. On
the other hand, it uses a filesystem, which doesn't hold the capability
information at each file, so it must use SUID bit, which is available
on all UNIX-like filesystems. This is called the SUID emulation, and
if everything goes well, it might disappear some day and will be replaced
by proper implementation of capabilities in the filesystem.

The rules for computing new process capabilities at exec() involve
the previous set of process capabilities, and the capabilities got
from the file to be executed. (I,P and E means inherited, permitted
and effective capabilities, p means process caps and f means file caps).

The old formula, which is used during exec:
  *       pI' = pI
  * (***) pP' = (fP & X) | (fI & pI)
  *       pE' = pP' & fE          [NB. fE is 0 or ~0]
is not compatible with the SUID-bit semantics. Because of this, there is
an ugly piece of code in prepare_binprm(), which (after several lines
of code) results in setting either FULL or NONE capabilities to the
process. If we want to have the POSIX capabilities working, we
DON'T want this behaviour. We want to have new capabilities reflecting
the old ones and, at the same time, honour the SUID bit.

Our new formula:
  * (***) pP' = (fP & X) | (fI & pI)
  *       pI' = pP'
  *       pE' = ((pP' & pE) | fP) & X & fE
respects the ideas of POSIX capabilities, and preserves the SUID bit emulation
at the same time. In this case, SUID bit just alters the file capabilities.

The new formula is not exactly the same as in the POSIX standard. That's o.k.
The old version, with SUID bit emulation turned on, was in conflict with
POSIX too. The new one honours the SUID bit just like the previous one,
and ENABLES use of the file capabilities. Thus, the new implementation
  * is ready for the POSIX caps-enabled filesystems and
  * enables use of POSIX capabilities even in the system, which uses
    the SUID files.

					Marek Zelem

Here follows the patch for 2.5. For those who are interrested, there
is a 2.4 patch available at
	http://www.terminus.sk/~marek/kernel/capabilities-2.4.18.diff.

--- linux-2.5.7.orig/fs/exec.c	Mon Mar 18 21:37:12 2002
+++ linux-2.5.7/fs/exec.c	Fri Apr 12 19:29:53 2002
@@ -20,6 +20,10 @@
  * table to check for several different types  of binary formats.  We keep
  * trying until we recognize the file or we run out of supported binary
  * formats.
+ *
+ * Modified formula for evolving capabilities to allow nice SUID emulation
+ * which work together with (future) VFS capabilities implementation.
+ * Feb 2002 by Marek Zelem <marek@terminus.sk>
  */

 #include <linux/config.h>
@@ -651,11 +655,23 @@
 	bprm->e_uid = current->euid;
 	bprm->e_gid = current->egid;

+	/* We don't have VFS support for capabilities yet */
+	cap_clear(bprm->cap_permitted);
+	cap_set_full(bprm->cap_inheritable);
+	cap_set_full(bprm->cap_effective);
+
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
+		if (mode & S_ISUID) {
 			bprm->e_uid = inode->i_uid;
-
+			if (bprm->e_uid == 0) {
+				if (!issecure(SECURE_NOROOT))
+					cap_set_full(bprm->cap_permitted);
+			}
+			else {
+				cap_clear(bprm->cap_effective);
+			}
+		}
 		/* Set-gid? */
 		/*
 		 * If setgid is set but no group execute bit then this
@@ -666,28 +682,6 @@
 			bprm->e_gid = inode->i_gid;
 	}

-	/* We don't have VFS support for capabilities yet */
-	cap_clear(bprm->cap_inheritable);
-	cap_clear(bprm->cap_permitted);
-	cap_clear(bprm->cap_effective);
-
-	/*  To support inheritance of root-permissions and suid-root
-         *  executables under compatibility mode, we raise all three
-         *  capability sets for the file.
-         *
-         *  If only the real uid is 0, we only raise the inheritable
-         *  and permitted sets of the executable file.
-         */
-
-	if (!issecure(SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
-			cap_set_full(bprm->cap_inheritable);
-			cap_set_full(bprm->cap_permitted);
-		}
-		if (bprm->e_uid == 0)
-			cap_set_full(bprm->cap_effective);
-	}
-
 	memset(bprm->buf,0,BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file,0,bprm->buf,BINPRM_BUF_SIZE);
 }
@@ -698,6 +692,11 @@
  *
  * The formula used for evolving capabilities is:
  *
+ * (***) pP' = (fP & X) | (fI & pI)
+ *       pI' = pP'
+ *       pE' = ((pP' & pE) | fP) & X & fE
+ *
+ * original was:
  *       pI' = pI
  * (***) pP' = (fP & X) | (fI & pI)
  *       pE' = pP' & fE          [NB. fE is 0 or ~0]
@@ -744,6 +743,14 @@
          * capability rules */
 	if (current->pid != 1) {
 		current->cap_permitted = new_permitted;
+/* This is to allow good SUID emulation (Marek Zelem <marek@terminus.sk>) */
+		current->cap_inheritable = new_permitted;
+		working =
+			cap_intersect(new_permitted,current->cap_effective);
+		new_permitted =
+			cap_combine(working,bprm->cap_permitted);
+		new_permitted = cap_intersect(new_permitted, cap_bset);
+/* END of good SUID emulation (Marek Zelem <marek@terminus.sk>) */
 		current->cap_effective =
 			cap_intersect(new_permitted, bprm->cap_effective);
 	}
--- linux-2.5.7.orig/include/linux/capability.h	Mon Mar 18 21:37:09 2002
+++ linux-2.5.7/include/linux/capability.h	Fri Apr 12 19:29:53 2002
@@ -302,8 +302,9 @@

 #define CAP_EMPTY_SET       to_cap_t(0)
 #define CAP_FULL_SET        to_cap_t(~0)
-#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
+//#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
+#define CAP_INIT_EFF_SET    to_cap_t(~0)
+#define CAP_INIT_INH_SET    to_cap_t(~0)

 #define CAP_TO_MASK(x) (1 << (x))
 #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
--- linux-2.5.7.orig/kernel/sys.c	Mon Mar 18 21:37:05 2002
+++ linux-2.5.7/kernel/sys.c	Fri Apr 12 19:29:53 2002
@@ -482,6 +482,7 @@
 	    !current->keep_capabilities) {
 		cap_clear(current->cap_permitted);
 		cap_clear(current->cap_effective);
+		cap_clear(current->cap_inheritable);
 	}
 	if (old_euid == 0 && current->euid != 0) {
 		cap_clear(current->cap_effective);
--- linux-2.5.7.orig/kernel/kmod.c	Mon Mar 18 21:37:10 2002
+++ linux-2.5.7/kernel/kmod.c	Fri Apr 12 19:29:53 2002
@@ -134,6 +134,8 @@
 	curtask->euid = curtask->fsuid = 0;
 	curtask->egid = curtask->fsgid = 0;
 	cap_set_full(curtask->cap_effective);
+	cap_set_full(curtask->cap_inheritable);
+	cap_set_full(curtask->cap_permitted);

 	/* Allow execve args to be in kernel space. */
 	set_fs(KERNEL_DS);


--
  e-mail: marek@terminus.sk
  web: http://www.terminus.sk/~marek/
  pgp key: http://www.terminus.sk/~marek/gpg.txt


