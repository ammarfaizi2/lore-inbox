Return-Path: <linux-kernel-owner+w=401wt.eu-S1751115AbXANFfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXANFfd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXANFfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:35:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58797 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbXANFfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:35:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 5/11] x86_64 ia32 vDSO: use VM_ALWAYSDUMP
Emacs: anything free is worth what you paid for it.
Message-Id: <20070114053458.486271800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:34:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes ia32 core dumps on x86_64 to include just one phdr for the
vDSO vma.  Currently it writes a confused format with two phdrs for the
address, one without contents and one with.  This patch removes the
special-case core writing macros for the ia32 vDSO.  Instead, it uses
VM_ALWAYSDUMP in the vma.  This changes core dumps so they no longer
include the non-PT_LOAD phdrs from the vDSO, consistent with fixed native
i386 core dumps.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/x86_64/ia32/ia32_binfmt.c |   49 ----------------------------------------
 arch/x86_64/ia32/syscall32.c   |    7 +++++
 2 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/arch/x86_64/ia32/ia32_binfmt.c b/arch/x86_64/ia32/ia32_binfmt.c
index 543ef4f..5ce0bd4 100644  
--- a/arch/x86_64/ia32/ia32_binfmt.c
+++ b/arch/x86_64/ia32/ia32_binfmt.c
@@ -64,55 +64,6 @@ typedef unsigned int elf_greg_t;
 #define ELF_NGREG (sizeof (struct user_regs_struct32) / sizeof(elf_greg_t))
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
-/*
- * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
- * extra segments containing the vsyscall DSO contents.  Dumping its
- * contents makes post-mortem fully interpretable later without matching up
- * the same kernel and hardware config to see what PC values meant.
- * Dumping its extra ELF program headers includes all the other information
- * a debugger needs to easily find how the vsyscall DSO was being used.
- */
-#define ELF_CORE_EXTRA_PHDRS	(find_vma(current->mm, VSYSCALL32_BASE) ?     \
-    (VSYSCALL32_EHDR->e_phnum) : 0)
-#define ELF_CORE_WRITE_EXTRA_PHDRS					      \
-do {									      \
-	if (find_vma(current->mm, VSYSCALL32_BASE)) { 			      \
-		const struct elf32_phdr *const vsyscall_phdrs =		      \
-			(const struct elf32_phdr *) (VSYSCALL32_BASE	      \
-						   + VSYSCALL32_EHDR->e_phoff);\
-		int i;							      \
-		Elf32_Off ofs = 0;					      \
-		for (i = 0; i < VSYSCALL32_EHDR->e_phnum; ++i) {	      \
-			struct elf32_phdr phdr = vsyscall_phdrs[i];	      \
-			if (phdr.p_type == PT_LOAD) {			      \
-				BUG_ON(ofs != 0);			      \
-				ofs = phdr.p_offset = offset;		      \
-				phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);      \
-				phdr.p_filesz = phdr.p_memsz;		      \
-				offset += phdr.p_filesz;		      \
-			}						      \
-			else						      \
-				phdr.p_offset += ofs;			      \
-			phdr.p_paddr = 0; /* match other core phdrs */	      \
-			DUMP_WRITE(&phdr, sizeof(phdr));		      \
-		}							      \
-	}								      \
-} while (0)
-#define ELF_CORE_WRITE_EXTRA_DATA					      \
-do {									      \
-	if (find_vma(current->mm, VSYSCALL32_BASE)) { 			      \
-		const struct elf32_phdr *const vsyscall_phdrs =		      \
-			(const struct elf32_phdr *) (VSYSCALL32_BASE	      \
-						   + VSYSCALL32_EHDR->e_phoff);      \
-		int i;							      \
-		for (i = 0; i < VSYSCALL32_EHDR->e_phnum; ++i) {	      \
-			if (vsyscall_phdrs[i].p_type == PT_LOAD)	      \
-				DUMP_WRITE((void *) (u64) vsyscall_phdrs[i].p_vaddr,\
-				    PAGE_ALIGN(vsyscall_phdrs[i].p_memsz));   \
-		}							      \
-	}								      \
-} while (0)
-
 struct elf_siginfo
 {
 	int	si_signo;			/* signal number */
diff --git a/arch/x86_64/ia32/syscall32.c b/arch/x86_64/ia32/syscall32.c
index 3e5ed20..3ac9355 100644  
--- a/arch/x86_64/ia32/syscall32.c
+++ b/arch/x86_64/ia32/syscall32.c
@@ -59,6 +59,13 @@ int syscall32_setup_pages(struct linux_b
 	vma->vm_end = VSYSCALL32_END;
 	/* MAYWRITE to allow gdb to COW and set breakpoints */
 	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYWRITE;
+	/*
+	 * Make sure the vDSO gets into every core dump.
+	 * Dumping its contents makes post-mortem fully interpretable later
+	 * without matching up the same kernel and hardware config to see
+	 * what PC values meant.
+	 */
+	vma->vm_flags |= VM_ALWAYSDUMP;
 	vma->vm_flags |= mm->def_flags;
 	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
 	vma->vm_ops = &syscall32_vm_ops;
