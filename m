Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUI2CYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUI2CYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 22:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUI2CYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 22:24:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268156AbUI2CYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 22:24:38 -0400
Date: Tue, 28 Sep 2004 22:24:33 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH] Fix bugs in SELinux mprotect hook
Message-ID: <Xine.LNX.4.44.0409282217450.29333-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below by Roland McGrath fixes two bugs in the implementation of 
the selinux_file_mprotect hook:

  It calls selinux_file_mmap, which has two problems.  First, the stacked
  security module will get both mmap and mprotect callbacks for an 
  mprotect call, which is wrong.  Secondly, the vm_flags value contains 
  VM_* bits, and these do not match the MAP_* bits of the same name or 
  function, so it passes bogus flags and causes every mprotect to be 
  treated as if MAP_SHARED were in use.
  
  The patch shares the common code while not having one function call the
  other, and fixes these two bugs.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Roland McGrath <roland@redhat.com>


diff -purN -X dontdiff linux-2.6.9-rc2-bk14.o/security/selinux/hooks.c linux-2.6.9-rc2-bk14.w/security/selinux/hooks.c
--- linux-2.6.9-rc2-bk14.o/security/selinux/hooks.c	2004-09-13 01:33:37.000000000 -0400
+++ linux-2.6.9-rc2-bk14.w/security/selinux/hooks.c	2004-09-28 22:04:53.306900408 -0400
@@ -2466,21 +2466,14 @@ static int selinux_file_ioctl(struct fil
 	return error;
 }
 
-static int selinux_file_mmap(struct file *file, unsigned long prot, unsigned long flags)
+static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
-	u32 av;
-	int rc;
-
-	rc = secondary_ops->file_mmap(file, prot, flags);
-	if (rc)
-		return rc;
-
 	if (file) {
 		/* read access is always possible with a mapping */
-		av = FILE__READ;
+		u32 av = FILE__READ;
 
 		/* write access only matters if the mapping is shared */
-		if ((flags & MAP_TYPE) == MAP_SHARED && (prot & PROT_WRITE))
+		if (shared && (prot & PROT_WRITE))
 			av |= FILE__WRITE;
 
 		if (prot & PROT_EXEC)
@@ -2491,6 +2484,18 @@ static int selinux_file_mmap(struct file
 	return 0;
 }
 
+static int selinux_file_mmap(struct file *file, unsigned long prot, unsigned long flags)
+{
+	int rc;
+
+	rc = secondary_ops->file_mmap(file, prot, flags);
+	if (rc)
+		return rc;
+
+	return file_map_prot_check(file, prot,
+				   (flags & MAP_TYPE) == MAP_SHARED);
+}
+
 static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
@@ -2500,7 +2505,7 @@ static int selinux_file_mprotect(struct 
 	if (rc)
 		return rc;
 
-	return selinux_file_mmap(vma->vm_file, prot, vma->vm_flags);
+	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
 }
 
 static int selinux_file_lock(struct file *file, unsigned int cmd)

