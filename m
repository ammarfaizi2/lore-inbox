Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTJGI2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 04:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTJGI2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 04:28:22 -0400
Received: from mail9.speakeasy.net ([216.254.0.209]:42666 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S261891AbTJGI2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 04:28:18 -0400
Date: Tue, 7 Oct 2003 01:28:15 -0700
Message-Id: <200310070828.h978SFQO028412@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] dump read-only anonymous memory in core files
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently core dumps omit all pages that are read-only at the time of the
dump.  I think that anonymous pages should be included even if read-only.
This patch makes that change.  Take for example this program:

	#include <sys/mman.h>
	#include <string.h>
	#include <unistd.h>

	int main ()
	{
	  const size_t pagesz = sysconf (_SC_PAGE_SIZE);
	  void *page = mmap (0, pagesz, PROT_READ|PROT_WRITE,
			     MAP_ANON|MAP_PRIVATE, -1, 0);
	  memset (page, 0x17, pagesz);
	  mprotect (page, pagesz, PROT_READ);
	  printf ("pid %d address %p size %x\n", getpid (),
		  page, (unsigned int) pagesz);
	  abort ();
	}

Without this change, the core dump will not include the `page' page--when
examining the dump, there will be no way to know it contains 0x17.  This is
obviously a contrived and useless example.  But such cases do exist in the
real world, e.g. garbage collectors that temporarily mprotect some pages to
read-only--in a core dump of such a process, knowing the contents of these
pages could be important.  With my change, that page appears in the dump.


Thanks,
Roland


Index: linux-2.6/fs/binfmt_elf.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/binfmt_elf.c,v
retrieving revision 1.57
diff -u -b -p -r1.57 binfmt_elf.c
--- linux-2.6/fs/binfmt_elf.c 3 Oct 2003 15:35:40 -0000 1.57
+++ linux-2.6/fs/binfmt_elf.c 7 Oct 2003 06:35:06 -0000
@@ -960,12 +960,13 @@ static int maydump(struct vm_area_struct
 	/* Do not dump I/O mapped devices! -DaveM */
 	if (vma->vm_flags & VM_IO)
 		return 0;
-#if 1
+	/* Dump anything writable.  */
 	if (vma->vm_flags & (VM_WRITE|VM_GROWSUP|VM_GROWSDOWN))
 		return 1;
-	if (vma->vm_flags & (VM_READ|VM_EXEC|VM_EXECUTABLE|VM_SHARED))
+	/* Don't dump unwritable segments mapped from files.  */
+	if (vma->vm_file != NULL)
 		return 0;
-#endif
+	/* Dump everything else.  */
 	return 1;
 }
 
