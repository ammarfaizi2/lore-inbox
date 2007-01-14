Return-Path: <linux-kernel-owner+w=401wt.eu-S1751118AbXANFee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbXANFee (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbXANFed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:34:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58653 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbXANFec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:34:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 4/11] i386 vDSO: use VM_ALWAYSDUMP
Emacs: or perhaps you'd prefer Russian Roulette, after all?
Message-Id: <20070114053428.900DB1800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:34:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes core dumps to include the vDSO vma, which is left out now.
It removes the special-case core writing macros, which were not doing the
right thing for the vDSO vma anyway.  Instead, it uses VM_ALWAYSDUMP in the
vma; there is no need for the fixmap page to be installed.  It handles the
CONFIG_COMPAT_VDSO case by making elf_core_dump use the fake vma from
get_gate_vma after real vmas in the same way the /proc/PID/maps code does.

This changes core dumps so they no longer include the non-PT_LOAD phdrs
from the vDSO.  I made the change to add them in the first place, but in
turned out that nothing ever wanted them there since the advent of NT_AUXV.
It's cleaner to leave them out, and just let the phdrs inside the vDSO
image speak for themselves.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/i386/kernel/sysenter.c |   12 ++++++----
 fs/binfmt_elf.c             |   12 ++++++++--
 include/asm-i386/elf.h      |   44 -------------------------------------------
 mm/memory.c                 |    7 ++++++
 4 files changed, 23 insertions(+), 52 deletions(-)

diff --git a/arch/i386/kernel/sysenter.c b/arch/i386/kernel/sysenter.c
index 454d12d..5da7442 100644  
--- a/arch/i386/kernel/sysenter.c
+++ b/arch/i386/kernel/sysenter.c
@@ -79,11 +79,6 @@ int __init sysenter_setup(void)
 #ifdef CONFIG_COMPAT_VDSO
 	__set_fixmap(FIX_VDSO, __pa(syscall_page), PAGE_READONLY);
 	printk("Compat vDSO mapped to %08lx.\n", __fix_to_virt(FIX_VDSO));
-#else
-	/*
-	 * In the non-compat case the ELF coredumping code needs the fixmap:
-	 */
-	__set_fixmap(FIX_VDSO, __pa(syscall_page), PAGE_KERNEL_RO);
 #endif
 
 	if (!boot_cpu_has(X86_FEATURE_SEP)) {
@@ -147,6 +142,13 @@ int arch_setup_additional_pages(struct l
 	vma->vm_end = addr + PAGE_SIZE;
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
 	vma->vm_ops = &syscall_vm_ops;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6fec8bf..4ee7cf5 100644  
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1443,7 +1443,7 @@ static int elf_core_dump(long signr, str
 	int segs;
 	size_t size = 0;
 	int i;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *gate_vma;
 	struct elfhdr *elf = NULL;
 	loff_t offset = 0, dataoff, foffset;
 	unsigned long limit = current->signal->rlim[RLIMIT_CORE].rlim_cur;
@@ -1529,6 +1529,10 @@ static int elf_core_dump(long signr, str
 	segs += ELF_CORE_EXTRA_PHDRS;
 #endif
 
+	gate_vma = get_gate_vma(current);
+	if (gate_vma != NULL)
+		segs++;
+
 	/* Set up header */
 	fill_elf_header(elf, segs + 1);	/* including notes section */
 
@@ -1596,7 +1600,8 @@ static int elf_core_dump(long signr, str
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
 	/* Write program headers for segments dump */
-	for (vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for (vma = current->mm->mmap; vma != NULL;
+	     vma = vma->vm_next ?: vma == gate_vma ? NULL : gate_vma) {
 		struct elf_phdr phdr;
 		size_t sz;
 
@@ -1645,7 +1650,8 @@ static int elf_core_dump(long signr, str
 	/* Align to page */
 	DUMP_SEEK(dataoff - foffset);
 
-	for (vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for (vma = current->mm->mmap; vma != NULL;
+	     vma = vma->vm_next ?: vma == gate_vma ? NULL : gate_vma) {
 		unsigned long addr;
 
 		if (!maydump(vma))
diff --git a/include/asm-i386/elf.h b/include/asm-i386/elf.h
index 0515d61..369035d 100644  
--- a/include/asm-i386/elf.h
+++ b/include/asm-i386/elf.h
@@ -168,50 +168,6 @@ do if (vdso_enabled) {						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_COMPAT_BASE);	\
 } while (0)
 
-/*
- * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
- * extra segments containing the vsyscall DSO contents.  Dumping its
- * contents makes post-mortem fully interpretable later without matching up
- * the same kernel and hardware config to see what PC values meant.
- * Dumping its extra ELF program headers includes all the other information
- * a debugger needs to easily find how the vsyscall DSO was being used.
- */
-#define ELF_CORE_EXTRA_PHDRS		(VDSO_HIGH_EHDR->e_phnum)
-#define ELF_CORE_WRITE_EXTRA_PHDRS					      \
-do {									      \
-	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VDSO_HIGH_BASE		      \
-					   + VDSO_HIGH_EHDR->e_phoff);    \
-	int i;								      \
-	Elf32_Off ofs = 0;						      \
-	for (i = 0; i < VDSO_HIGH_EHDR->e_phnum; ++i) {		      \
-		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
-		if (phdr.p_type == PT_LOAD) {				      \
-			BUG_ON(ofs != 0);				      \
-			ofs = phdr.p_offset = offset;			      \
-			phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);	      \
-			phdr.p_filesz = phdr.p_memsz;			      \
-			offset += phdr.p_filesz;			      \
-		}							      \
-		else							      \
-			phdr.p_offset += ofs;				      \
-		phdr.p_paddr = 0; /* match other core phdrs */		      \
-		DUMP_WRITE(&phdr, sizeof(phdr));			      \
-	}								      \
-} while (0)
-#define ELF_CORE_WRITE_EXTRA_DATA					      \
-do {									      \
-	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VDSO_HIGH_BASE		      \
-					   + VDSO_HIGH_EHDR->e_phoff);    \
-	int i;								      \
-	for (i = 0; i < VDSO_HIGH_EHDR->e_phnum; ++i) {		      \
-		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
-			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
-				   PAGE_ALIGN(vsyscall_phdrs[i].p_memsz));    \
-	}								      \
-} while (0)
-
 #endif
 
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 5beb4b8..ef09f0a 100644  
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2608,6 +2608,13 @@ static int __init gate_vma_init(void)
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
 	gate_vma.vm_page_prot = __P101;
+	/*
+	 * Make sure the vDSO gets into every core dump.
+	 * Dumping its contents makes post-mortem fully interpretable later
+	 * without matching up the same kernel and hardware config to see
+	 * what PC values meant.
+	 */
+	gate_vma.vm_flags |= VM_ALWAYSDUMP;
 	return 0;
 }
 __initcall(gate_vma_init);
