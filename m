Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTJCB4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 21:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTJCB4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 21:56:45 -0400
Received: from mail7.speakeasy.net ([216.254.0.207]:58033 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S263581AbTJCB4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 21:56:41 -0400
Date: Thu, 2 Oct 2003 18:56:35 -0700
Message-Id: <200310030156.h931uZhL015129@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Fcc: ~/Mail/linus
Subject: [PATCH] fix vsyscall page in core dumps
X-Zippy-Says: HOW could a GLASS be YELLING??
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this change to Linus around the time of 2.5.70, but I just now
noticed that it never made it in.

My change to core dumps that was included with the vsyscall DSO
implementation had a bug (braino on my part).  Core dumps don't include the
full page of the vsyscall DSO, and so don't accurately represent the whole
memory image of the process.  This patch fixes it.  I have tested it on
x86, but not tested the same change to 32-bit core dumps on AMD64 (haven't
even compiled on AMD64).

I've also included the corresponding change for the IA64 code that was
copied blindly from the x86 vsyscall implementation, which looks like more
change than it is since I preserved the formatting of the copied code
instead of arbitrarily diddling it along with the trivial symbol name
changes.  I haven't compiled or tested on ia64.


Thanks,
Roland



Index: linux-2.6/include/asm-i386/elf.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/elf.h,v
retrieving revision 1.11
diff -b -p -u -r1.11 elf.h
--- linux-2.6/include/asm-i386/elf.h 1 Oct 2003 05:03:36 -0000 1.11
+++ linux-2.6/include/asm-i386/elf.h 3 Oct 2003 00:01:23 -0000
@@ -157,7 +157,10 @@ do {									      \
 	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
 		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
 		if (phdr.p_type == PT_LOAD) {				      \
+			BUG_ON(ofs != 0);				      \
 			ofs = phdr.p_offset = offset;			      \
+			phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);	      \
+			phdr.p_filesz = phdr.p_memsz;			      \
 			offset += phdr.p_filesz;			      \
 		}							      \
 		else							      \
@@ -175,7 +178,7 @@ do {									      \
 	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
 		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
 			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
-				   vsyscall_phdrs[i].p_filesz);		      \
+				   PAGE_ALIGN(vsyscall_phdrs[i].p_memsz));    \
 	}								      \
 } while (0)
 
Index: linux-2.6/arch/x86_64/ia32/ia32_binfmt.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/x86_64/ia32/ia32_binfmt.c,v
retrieving revision 1.18
diff -b -p -u -r1.18 ia32_binfmt.c
--- linux-2.6/arch/x86_64/ia32/ia32_binfmt.c 14 Aug 2003 06:38:10 -0000 1.18
+++ linux-2.6/arch/x86_64/ia32/ia32_binfmt.c 3 Oct 2003 00:01:23 -0000
@@ -82,9 +82,12 @@ do {									      \
 	int i;								      \
 	Elf32_Off ofs = 0;						      \
 	for (i = 0; i < VSYSCALL32_EHDR->e_phnum; ++i) {		      \
-		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
+		struct elf32_phdr phdr = vsyscall_phdrs[i];		      \
 		if (phdr.p_type == PT_LOAD) {				      \
+			BUG_ON(ofs != 0);				      \
 			ofs = phdr.p_offset = offset;			      \
+			phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);	      \
+			phdr.p_filesz = phdr.p_memsz;			      \
 			offset += phdr.p_filesz;			      \
 		}							      \
 		else							      \
@@ -99,10 +102,10 @@ do {									      \
 		(const struct elf32_phdr *) (VSYSCALL32_BASE		      \
 					   + VSYSCALL32_EHDR->e_phoff);	      \
 	int i;								      \
-	for (i = 0; i < VSYSCALL32_EHDR->e_phnum; ++i) {		      \
+	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
 		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
 			DUMP_WRITE((void *) (u64) vsyscall_phdrs[i].p_vaddr,	      \
-				   vsyscall_phdrs[i].p_filesz);		      \
+				   PAGE_ALIGN(vsyscall_phdrs[i].p_memsz));    \
 	}								      \
 } while (0)
 
Index: linux-2.6/include/asm-ia64/elf.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-ia64/elf.h,v
retrieving revision 1.10
diff -b -p -u -r1.10 elf.h
--- linux-2.6/include/asm-ia64/elf.h 17 Jul 2003 17:24:28 -0000 1.10
+++ linux-2.6/include/asm-ia64/elf.h 3 Oct 2003 00:08:56 -0000
@@ -206,42 +206,46 @@ do {										\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR, (unsigned long) GATE_EHDR);		\
 } while (0)
 
+
 /*
- * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out extra segments
- * containing the gate DSO contents.  Dumping its contents makes post-mortem fully
- * interpretable later without matching up the same kernel and hardware config to see what
- * IP values meant.  Dumping its extra ELF program headers includes all the other
- * information a debugger needs to easily find how the gate DSO was being used.
+ * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
+ * extra segments containing the gate DSO contents.  Dumping its
+ * contents makes post-mortem fully interpretable later without matching up
+ * the same kernel and hardware config to see what PC values meant.
+ * Dumping its extra ELF program headers includes all the other information
+ * a debugger needs to easily find how the gate DSO was being used.
  */
 #define ELF_CORE_EXTRA_PHDRS		(GATE_EHDR->e_phnum)
 #define ELF_CORE_WRITE_EXTRA_PHDRS						\
 do {										\
-	const struct elf_phdr *const gate_phdrs =				\
-		(const struct elf_phdr *) (GATE_ADDR + GATE_EHDR->e_phoff);	\
+	const struct elf_phdr *const vsyscall_phdrs =			      \
+		(const struct elf_phdr *) (GATE_BASE + GATE_EHDR->e_phoff);   \
 	int i;									\
-	Elf64_Off ofs = 0;							\
+	Elf32_Off ofs = 0;						      \
 	for (i = 0; i < GATE_EHDR->e_phnum; ++i) {				\
-		struct elf_phdr phdr = gate_phdrs[i];				\
+		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
 		if (phdr.p_type == PT_LOAD) {					\
+			BUG_ON(ofs != 0);				      \
 			ofs = phdr.p_offset = offset;				\
+			phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);	      \
+			phdr.p_filesz = phdr.p_memsz;			      \
 			offset += phdr.p_filesz;				\
-		} else								\
+		}							      \
+		else							      \
 			phdr.p_offset += ofs;					\
 		phdr.p_paddr = 0; /* match other core phdrs */			\
 		DUMP_WRITE(&phdr, sizeof(phdr));				\
 	}									\
 } while (0)
-
 #define ELF_CORE_WRITE_EXTRA_DATA					\
 do {									\
-	const struct elf_phdr *const gate_phdrs =			\
-		(const struct elf_phdr *) (GATE_ADDR			\
-					   + GATE_EHDR->e_phoff);	\
+	const struct elf_phdr *const vsyscall_phdrs =			      \
+		(const struct elf_phdr *) (GATE_BASE + GATE_EHDR->e_phoff);   \
 	int i;								\
 	for (i = 0; i < GATE_EHDR->e_phnum; ++i) {			\
-		if (gate_phdrs[i].p_type == PT_LOAD)			\
-			DUMP_WRITE((void *) gate_phdrs[i].p_vaddr,	\
-				   gate_phdrs[i].p_filesz);		\
+		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
+			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
+				   PAGE_ALIGN(vsyscall_phdrs[i].p_memsz));    \
 	}								\
 } while (0)
 
