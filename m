Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264381AbTEPI2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTEPI17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:27:59 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64507 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264381AbTEPI1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:27:37 -0400
Date: Fri, 16 May 2003 01:40:26 -0700
Message-Id: <200305160840.h4G8eQb01924@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix vsyscall page core dump segment size
X-Fcc: ~/Mail/linus
X-Zippy-Says: Look into my eyes and try to forget that you have a Macy's charge card!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My change to core dumps that was included with the vsyscall DSO
implementation had a bug (braino on my part).  Core dumps don't include the
full page of the vsyscall DSO, and so don't accurately represent the whole
memory image of the process.  This patch fixes it.

arch/x86_64/ia32/ia32_binfmt.c's copy of this code needs the corresponding
update as well.  I don't include a patch since that code is not in the main
tree.


Thanks,
Roland


--- linux-2.5.69/include/asm-i386/elf.h.~1~	Sun May  4 16:53:35 2003
+++ linux-2.5.69/include/asm-i386/elf.h	Thu May 15 23:39:22 2003
@@ -149,7 +149,10 @@ do {									      \
 	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
 		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
 		if (phdr.p_type == PT_LOAD) {				      \
+			BUG_ON(ofs != 0);				      \
 			ofs = phdr.p_offset = offset;			      \
+			phdr.p_filesz = PAGE_ALIGN(phdr.p_filesz);	      \
+			phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);	      \
 			offset += phdr.p_filesz;			      \
 		}							      \
 		else							      \
@@ -167,7 +170,7 @@ do {									      \
 	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
 		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
 			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
-				   vsyscall_phdrs[i].p_filesz);		      \
+				   PAGE_ALIGN(vsyscall_phdrs[i].p_filesz));   \
 	}								      \
 } while (0)
 
