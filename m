Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270035AbUJTIb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270035AbUJTIb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270057AbUJTIZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:25:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269046AbUJTIW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:22:28 -0400
Date: Wed, 20 Oct 2004 01:22:17 -0700
Message-Id: <200410200822.i9K8MHtp024040@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] include all vmas with unbacked pages in ELF core dumps
Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the criteria for including vm regions in a core dump.
In recent glibc, the dynamic linker uses mprotect on part of a data segment
to write-protect pages that should never be touched after startup time
(this makes it harder for exploits to clobber indirection tables and the like).
Currently, this part of the segment is omitted from core dumps, losing
information about what the program did before it died.

The comment about the old VM_READ test no longer applies since writing uses
kmap now.  Including unreadable regions gives you things like guard pages,
showing an accurate representation of of those in the core dump image.
Since we now have the ZERO_PAGE check, this won't actually write any more
pages to disk for those cases.

Any anonymous memory should always be dumped, since there is by definition
no other source of that information available after the process has died.
File-backed memory that is MAP_PRIVATE and has been touched should also be
dumped, since this is in essence an anonymous memory region.  This is the
case that covers RELRO segments (data pages mprotect'd to read-only after
dynamic linker startup).


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

Index: linux-2.6/fs/binfmt_elf.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/binfmt_elf.c,v
retrieving revision 1.89
diff -B -p -u -r1.89 binfmt_elf.c
--- linux-2.6/fs/binfmt_elf.c 23 Sep 2004 01:24:06 -0000 1.89
+++ linux-2.6/fs/binfmt_elf.c 28 Sep 2004 00:16:26 -0000
@@ -1054,23 +1054,16 @@ static int dump_seek(struct file *file, 
  */
 static int maydump(struct vm_area_struct *vma)
 {
-	/*
-	 * If we may not read the contents, don't allow us to dump
-	 * them either. "dump_write()" can't handle it anyway.
-	 */
-	if (!(vma->vm_flags & VM_READ))
-		return 0;
-
 	/* Do not dump I/O mapped devices! -DaveM */
 	if (vma->vm_flags & VM_IO)
 		return 0;
-#if 1
 	if (vma->vm_flags & (VM_WRITE|VM_GROWSUP|VM_GROWSDOWN))
 		return 1;
-	if (vma->vm_flags & (VM_READ|VM_EXEC|VM_EXECUTABLE|VM_SHARED))
-		return 0;
-#endif
-	return 1;
+	if (vma->vm_file == NULL) /* Anonymous memory is always dumped.  */
+		return 1;
+	if (vma->anon_vma != NULL) /* We've had some COW here.  */
+		return 1;
+	return 0;
 }
 
 #define roundup(x, y)  ((((x)+((y)-1))/(y))*(y))
