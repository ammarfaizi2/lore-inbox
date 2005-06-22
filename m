Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVFVBwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVFVBwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVFVBwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:52:12 -0400
Received: from 67.Red-80-25-56.pooles.rima-tde.net ([80.25.56.67]:4403 "EHLO
	estila.tuxedo-es.org") by vger.kernel.org with ESMTP
	id S262508AbVFVBv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:51:56 -0400
Subject: [patch 2/2] selinux: add executable heap check
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, jmorris@redhat.com
From: Lorenzo =?ISO-8859-1?Q?=20Hern=E1ndez?=
	 =?ISO-8859-1?Q?=20Garc=EDa-Hierro?= <lorenzo@gnu.org>
Date: Wed, 22 Jun 2005 03:51:57 +0200
Message-Id: <20050622015158.346C856C87A@estila.tuxedo-es.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch,based on sample code by Roland McGrath, adds an execheap
permission check that controls the ability to make the heap executable
so that this can be prevented in almost all cases (the X server is
presently an exception, but this will hopefully be resolved in the future)
so that even programs with execmem permission will need to have the anonymous
memory mapped in order to make it executable. 
The only reason that we use a permission check for such restriction
(vs. making it unconditional) is that the X module loader presently
needs it; it could possibly be made unconditional in the future when
X is changed.

The policy patch for the execheap permission is available at:
http://pearls.tuxedo-es.org/patches/selinux/policy-execheap.patch

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

 security/selinux/hooks.c                     |   11 +++++++++++
 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    1 +
 3 files changed, 13 insertions(+)

diff -puN security/selinux/hooks.c~selinux-kernel-execheap security/selinux/hooks.c
--- linux-2.6.11/security/selinux/hooks.c~selinux-kernel-execheap	2005-06-21 13:27:21.647102768 +0200
+++ linux-2.6.11-lorenzo/security/selinux/hooks.c	2005-06-21 13:27:21.862070088 +0200
@@ -2480,6 +2480,17 @@ static int selinux_file_mprotect(struct 
 		prot = reqprot;
 
 #ifndef CONFIG_PPC32
+	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXECUTABLE) &&
+	   (vma->vm_start >= vma->vm_mm->start_brk &&
+	    vma->vm_end <= vma->vm_mm->brk)) {
+	    	/*
+		 * We are making an executable mapping in the brk region.
+		 * This has an additional execheap check.
+		 */
+		rc = task_has_perm(current, current, PROCESS__EXECHEAP);
+		if (rc)
+			return rc;
+	}
 	if (vma->vm_file != NULL && vma->anon_vma != NULL && (prot & PROT_EXEC)) {
 		/*
 		 * We are making executable a file mapping that has
diff -puN security/selinux/include/av_permissions.h~selinux-kernel-execheap security/selinux/include/av_permissions.h
--- linux-2.6.11/security/selinux/include/av_permissions.h~selinux-kernel-execheap	2005-06-21 13:27:21.649102464 +0200
+++ linux-2.6.11-lorenzo/security/selinux/include/av_permissions.h	2005-06-21 13:27:21.860070392 +0200
@@ -466,6 +466,7 @@
 #define PROCESS__SETCURRENT                       0x01000000UL
 #define PROCESS__EXECMEM                          0x02000000UL
 #define PROCESS__EXECSTACK                        0x04000000UL
+#define PROCESS__EXECHEAP                         0x08000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
diff -puN security/selinux/include/av_perm_to_string.h~selinux-kernel-execheap security/selinux/include/av_perm_to_string.h
--- linux-2.6.11/security/selinux/include/av_perm_to_string.h~selinux-kernel-execheap	2005-06-21 13:27:21.856071000 +0200
+++ linux-2.6.11-lorenzo/security/selinux/include/av_perm_to_string.h	2005-06-21 13:27:21.860070392 +0200
@@ -71,6 +71,7 @@
    S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
+   S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
_
