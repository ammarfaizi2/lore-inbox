Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbULBPyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbULBPyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbULBPy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:54:29 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:54979 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261664AbULBPuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:50:50 -0500
Subject: [PATCH 5/6] Enhance SELinux control of executable mappings
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102002356.26015.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 10:45:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.6.10-rc2-mm4 adds new permission checks to the SELinux mmap and mprotect
hooks to enable control over the ability to make executable a mapping
that can contain data not covered by the existing file-based
permission checks.  The task->self execmem permission controls the
ability to create an executable anonymous mapping or a writable
executable private file mapping. The task->file execmod permission
controls the ability to make executable a previously written private
file mapping, e.g. for text relocations.  Thanks to Roland McGrath for
input and feedback on earlier versions of this patch.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/hooks.c                     |   23 +++++++++++++++++++++++
 security/selinux/include/av_perm_to_string.h |    2 ++
 security/selinux/include/av_permissions.h    |    2 ++
 3 files changed, 27 insertions(+)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.139
diff -u -p -r1.139 hooks.c
--- linux-2.6/security/selinux/hooks.c	30 Nov 2004 17:39:08 -0000	1.139
+++ linux-2.6/security/selinux/hooks.c	30 Nov 2004 21:30:04 -0000
@@ -2465,6 +2465,17 @@ static int selinux_file_ioctl(struct fil
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
+	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
+		/*
+		 * We are making executable an anonymous mapping or a
+		 * private file mapping that will also be writable.
+		 * This has an additional check.
+		 */
+		int rc = task_has_perm(current, current, PROCESS__EXECMEM);
+		if (rc)
+			return rc;
+	}
+
 	if (file) {
 		/* read access is always possible with a mapping */
 		u32 av = FILE__READ;
@@ -2502,6 +2513,18 @@ static int selinux_file_mprotect(struct 
 	if (rc)
 		return rc;
 
+	if (vma->vm_file != NULL && vma->anon_vma != NULL && (prot & PROT_EXEC)) {
+		/*
+		 * We are making executable a file mapping that has 
+		 * had some COW done. Since pages might have been written, 
+		 * check ability to execute the possibly modified content.
+		 * This typically should only occur for text relocations.
+		 */
+		int rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
+		if (rc)
+			return rc;		
+	}
+
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
 }
 
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.18
diff -u -p -r1.18 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	29 Nov 2004 21:37:36 -0000	1.18
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	30 Nov 2004 21:32:19 -0000
@@ -16,6 +16,7 @@
    S_(SECCLASS_DIR, DIR__RMDIR, "rmdir")
    S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
+   S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
    S_(SECCLASS_FD, FD__USE, "use")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
@@ -64,6 +65,7 @@
    S_(SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh")
    S_(SECCLASS_PROCESS, PROCESS__DYNTRANSITION, "dyntransition")
    S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
+   S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.17
diff -u -p -r1.17 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	29 Nov 2004 21:37:36 -0000	1.17
+++ linux-2.6/security/selinux/include/av_permissions.h	30 Nov 2004 21:32:19 -0000
@@ -105,6 +105,7 @@
 
 #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
 #define FILE__ENTRYPOINT                          0x00040000UL
+#define FILE__EXECMOD                             0x00080000UL
 
 #define LNK_FILE__IOCTL                           0x00000001UL
 #define LNK_FILE__READ                            0x00000002UL
@@ -458,6 +459,7 @@
 #define PROCESS__RLIMITINH                        0x00400000UL
 #define PROCESS__DYNTRANSITION                    0x00800000UL
 #define PROCESS__SETCURRENT                       0x01000000UL
+#define PROCESS__EXECMEM                          0x02000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

