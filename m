Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbULCTum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbULCTum (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbULCT16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:27:58 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:7940
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262469AbULCT0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:26:48 -0500
Message-Id: <200412032142.iB3LgoZW004657@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - include vsyscall page in core dumps
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:42:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser:

Complete the dump with the vsyscall-information, if a vsyscall-page
is available.

Signed-off-by: Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/include/asm-um/archparam-i386.h
===================================================================
--- 2.6.9.orig/include/asm-um/archparam-i386.h	2004-12-01 23:44:11.000000000 -0500
+++ 2.6.9/include/asm-um/archparam-i386.h	2004-12-01 23:46:18.000000000 -0500
@@ -88,22 +88,18 @@
  * Dumping its extra ELF program headers includes all the other information
  * a debugger needs to easily find how the vsyscall DSO was being used.
  */
-#if 0
-#define ELF_CORE_EXTRA_PHDRS		(VSYSCALL_EHDR->e_phnum)
-#endif
-
-#undef ELF_CORE_EXTRA_PHDRS
+#define ELF_CORE_EXTRA_PHDRS						      \
+	(vsyscall_ehdr ? (((struct elfhdr *)vsyscall_ehdr)->e_phnum) : 0 )
 
-#if 0
 #define ELF_CORE_WRITE_EXTRA_PHDRS					      \
-do {									      \
-	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VSYSCALL_BASE		      \
-					   + VSYSCALL_EHDR->e_phoff);	      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
 	int i;								      \
 	Elf32_Off ofs = 0;						      \
-	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
-		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		struct elf_phdr phdr = phdrp[i];			      \
 		if (phdr.p_type == PT_LOAD) {				      \
 			ofs = phdr.p_offset = offset;			      \
 			offset += phdr.p_filesz;			      \
@@ -113,23 +109,19 @@
 		phdr.p_paddr = 0; /* match other core phdrs */		      \
 		DUMP_WRITE(&phdr, sizeof(phdr));			      \
 	}								      \
-} while (0)
+}
 #define ELF_CORE_WRITE_EXTRA_DATA					      \
-do {									      \
-	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VSYSCALL_BASE		      \
-					   + VSYSCALL_EHDR->e_phoff);	      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
 	int i;								      \
-	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
-		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
-			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
-				   vsyscall_phdrs[i].p_filesz);		      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		if (phdrp[i].p_type == PT_LOAD)				      \
+			DUMP_WRITE((void *) phdrp[i].p_vaddr,		      \
+				   phdrp[i].p_filesz);			      \
 	}								      \
-} while (0)
-#endif
-
-#undef ELF_CORE_WRITE_EXTRA_PHDRS
-#undef ELF_CORE_WRITE_EXTRA_DATA
+}
 
 #define R_386_NONE	0
 #define R_386_32	1

