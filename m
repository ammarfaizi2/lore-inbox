Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVFVBwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVFVBwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVFVBwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:52:00 -0400
Received: from 67.Red-80-25-56.pooles.rima-tde.net ([80.25.56.67]:60466 "EHLO
	estila.tuxedo-es.org") by vger.kernel.org with ESMTP
	id S262504AbVFVBvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:51:54 -0400
Subject: [patch 1/2] selinux: add executable stack check
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, jmorris@redhat.com
From: Lorenzo =?ISO-8859-1?Q?=20Hern=E1ndez?=
	 =?ISO-8859-1?Q?=20Garc=EDa-Hierro?= <lorenzo@gnu.org>
Date: Wed, 22 Jun 2005 03:51:55 +0200
Message-Id: <20050622015156.AAD7056C876@estila.tuxedo-es.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds an execstack permission check that controls the
ability to make the main process stack executable so that attempts to
make the stack executable can still be prevented even if the process is
allowed the existing execmem permission in order to e.g. perform runtime
code generation.  Note that this does not yet address thread stacks.
Note also that unlike the execmem check, the execstack check is only
applied on mprotect calls, not mmap calls, as the current
security_file_mmap hook is not passed the necessary information
presently.

The original author of the code that makes the distinction of the stack
region, is Ingo Molnar, who wrote it within his patch for
/proc/<pid>/maps markers.
(http://marc.theaimsgroup.com/?l=linux-kernel&m=110719881508591&w=2)

The patches also can be found at:
http://pearls.tuxedo-es.org/patches/selinux/policy-execstack.patch
http://pearls.tuxedo-es.org/patches/selinux/kernel-execstack.patch

policy-execstack.patch is the patch that needs to be applied to the policy in
order to support the execstack permission and exclude it
from general_domain_access within macros/core_macros.te.

kernel-execstack.patch adds such permission to the SELinux code within
the kernel and adds the proper permission check to the selinux_file_mprotect() hook.

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

 security/selinux/hooks.c                     |   10 ++++++++++
 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    1 +
 3 files changed, 12 insertions(+)

diff -puN security/selinux/hooks.c~selinux-kernel-execstack security/selinux/hooks.c
--- linux-2.6.11/security/selinux/hooks.c~selinux-kernel-execstack	2005-06-21 13:26:34.572259232 +0200
+++ linux-2.6.11-lorenzo/security/selinux/hooks.c	2005-06-21 13:26:34.623251480 +0200
@@ -2491,6 +2491,16 @@ static int selinux_file_mprotect(struct 
 		if (rc)
 			return rc;
 	}
+	if (!vma->vm_file && (prot & PROT_EXEC) &&
+		vma->vm_start <= vma->vm_mm->start_stack &&
+		vma->vm_end >= vma->vm_mm->start_stack) {
+		/* Attempt to make the process stack executable.
+		 * This has an additional execstack check.
+		 */
+		rc = task_has_perm(current, current, PROCESS__EXECSTACK);
+		if (rc)
+			return rc;
+	}
 #endif
 
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
diff -puN security/selinux/include/av_permissions.h~selinux-kernel-execstack security/selinux/include/av_permissions.h
--- linux-2.6.11/security/selinux/include/av_permissions.h~selinux-kernel-execstack	2005-06-21 13:26:34.574258928 +0200
+++ linux-2.6.11-lorenzo/security/selinux/include/av_permissions.h	2005-06-21 13:26:34.592256192 +0200
@@ -465,6 +465,7 @@
 #define PROCESS__DYNTRANSITION                    0x00800000UL
 #define PROCESS__SETCURRENT                       0x01000000UL
 #define PROCESS__EXECMEM                          0x02000000UL
+#define PROCESS__EXECSTACK                        0x04000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
diff -puN security/selinux/include/av_perm_to_string.h~selinux-kernel-execstack security/selinux/include/av_perm_to_string.h
--- linux-2.6.11/security/selinux/include/av_perm_to_string.h~selinux-kernel-execstack	2005-06-21 13:26:34.576258624 +0200
+++ linux-2.6.11-lorenzo/security/selinux/include/av_perm_to_string.h	2005-06-21 13:26:34.598255280 +0200
@@ -70,6 +70,7 @@
    S_(SECCLASS_PROCESS, PROCESS__DYNTRANSITION, "dyntransition")
    S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
+   S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
_
