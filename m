Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWGLLMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWGLLMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWGLLMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:12:06 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:37571 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751243AbWGLLMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:12:05 -0400
Subject: Fix prctl privilege escalation (CVE-2006-2451)
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <mtk-manpages@gmx.net>
Content-Type: multipart/mixed; boundary="=-T+cI14n0Ty9WHfFJitIb"
Date: Wed, 12 Jul 2006 13:12:00 +0200
Message-Id: <1152702720.14173.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T+cI14n0Ty9WHfFJitIb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Linus,

attached is the fix with full explanation for CVE-2006-2451. It fixes a
possible privilege escalation through the prctl() system call.

I also put Michael Kerrisk on CC, because the manual page of prctl()
needs adjustment. The value 2 for the PR_SET_DUMPABLE flag is no longer
valid after this patch. The only way to get root-owned core dumps is
through /proc/sys/fs/suid_dumpable and the manual page should reflect
that.

Regards

Marcel


--=-T+cI14n0Ty9WHfFJitIb
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

[PATCH] Fix prctl privilege escalation and suid_dumpable (CVE-2006-2451)

Based on a patch from Ernie Petrides

During security research, Red Hat discovered a behavioral flaw in core
dump handling. A local user could create a program that would cause a
core file to be dumped into a directory they would not normally have
permissions to write to. This could lead to a denial of service (disk
consumption), or allow the local user to gain root privileges.

The prctl() system call should never allow to set "dumpable" to the
value 2. Especially not for non-privileged users.

This can be split into three cases:

  1) running as root -- then core dumps will already be done as root,
     and so prctl(PR_SET_DUMPABLE, 2) is not useful

  2) running as non-root w/setuid-to-root -- this is the debatable case

  3) running as non-root w/setuid-to-non-root -- then you definitely
     do NOT want "dumpable" to get set to 2 because you have the
     privilege escalation vulnerability

With case #2, the only potential usefulness is for a program that has
designed to run with higher privilege (than the user invoking it) that
wants to be able to create root-owned root-validated core dumps. This
might be useful as a debugging aid, but would only be safe if the program
had done a chdir() to a safe directory.

There is no benefit to a production setuid-to-root utility, because it
shouldn't be dumping core in the first place. If this is true, then the
same debugging aid could also be accomplished with the "suid_dumpable"
sysctl.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit a5c53fee00abefc2269ebf3fe05b53c05e9f389f
tree 871b99fbcced6db040c59fe2f3de6d14a9bf09fe
parent 7c3dec0679c66ce177726802adbe2f403942fc27
author Marcel Holtmann <marcel@holtmann.org> Wed, 12 Jul 2006 12:44:51 +0200
committer Marcel Holtmann <marcel@holtmann.org> Wed, 12 Jul 2006 12:44:51 +0200

 kernel/sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index dbb3b9c..e236f98 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1983,7 +1983,7 @@ asmlinkage long sys_prctl(int option, un
 			error = current->mm->dumpable;
 			break;
 		case PR_SET_DUMPABLE:
-			if (arg2 < 0 || arg2 > 2) {
+			if (arg2 < 0 || arg2 > 1) {
 				error = -EINVAL;
 				break;
 			}

--=-T+cI14n0Ty9WHfFJitIb--

