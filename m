Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbULHSOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbULHSOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbULHR7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:59:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54483 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261299AbULHR4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:56:53 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix some ELF-FDPIC binfmt problems
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.2
Date: Wed, 08 Dec 2004 17:56:44 +0000
Message-ID: <7814.1102528604@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes the following problems in the ELF-FDPIC binfmt
driver:

 (1) elf_fdpic_map_file() should be passed an mm_struct pointer, not NULL.

 (2) do_mmap() should be called with the mmap_sem held.

 (3) mm_struct::end_brk doesn't exist in 2.6 (debugging only).

 (4) Avoid debugging warnings by casting certain values to unsigned long
     before printing them.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat elf-fdpic-2610rc2mm3-3.diff 
 binfmt_elf_fdpic.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/fs/binfmt_elf_fdpic.c linux-2.6.10-rc2-mm3-shmem/fs/binfmt_elf_fdpic.c
--- linux-2.6.10-rc2-mm3-mmcleanup/fs/binfmt_elf_fdpic.c	2004-11-22 10:54:09.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/fs/binfmt_elf_fdpic.c	2004-12-01 16:31:43.000000000 +0000
@@ -315,7 +315,8 @@ static int load_elf_fdpic_binary(struct 
 		goto error_kill;
 
 	if (interpreter_name) {
-		retval = elf_fdpic_map_file(&interp_params, interpreter, NULL, "interpreter");
+		retval = elf_fdpic_map_file(&interp_params, interpreter,
+					    current->mm, "interpreter");
 		if (retval < 0) {
 			printk(KERN_ERR "Unable to load interpreter\n");
 			goto error_kill;
@@ -341,6 +342,7 @@ static int load_elf_fdpic_binary(struct 
 	if (stack_size < PAGE_SIZE * 2)
 		stack_size = PAGE_SIZE * 2;
 
+	down_write(&current->mm->mmap_sem);
 	current->mm->start_brk = do_mmap(NULL,
 					 0,
 					 stack_size,
@@ -349,12 +351,12 @@ static int load_elf_fdpic_binary(struct 
 					 0);
 
 	if (IS_ERR((void *) current->mm->start_brk)) {
+		up_write(&current->mm->mmap_sem);
 		retval = current->mm->start_brk;
 		current->mm->start_brk = 0;
 		goto error_kill;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	if (do_mremap(current->mm->start_brk,
 		      stack_size,
 		      ksize((char *) current->mm->start_brk),
@@ -381,9 +383,6 @@ static int load_elf_fdpic_binary(struct 
 	kdebug("- end_data    %lx",	(long) current->mm->end_data);
 	kdebug("- start_brk   %lx",	(long) current->mm->start_brk);
 	kdebug("- brk         %lx",	(long) current->mm->brk);
-#ifndef CONFIG_MMU
-	kdebug("- end_brk     %lx",	(long) current->mm->end_brk);
-#endif
 	kdebug("- start_stack %lx",	(long) current->mm->start_stack);
 
 #ifdef ELF_FDPIC_PLAT_INIT
@@ -870,8 +869,10 @@ static int elf_fdpic_map_file_constdisp_
 	if (params->flags & ELF_FDPIC_FLAG_EXECUTABLE)
 		mflags |= MAP_EXECUTABLE;
 
+	down_write(&mm->mmap_sem);
 	maddr = do_mmap(NULL, load_addr, top - base,
 			PROT_READ | PROT_WRITE | PROT_EXEC, mflags, 0);
+	up_write(&mm->mmap_sem);
 	if (IS_ERR((void *) maddr))
 		return (int) maddr;
 
@@ -957,7 +958,10 @@ static int elf_fdpic_map_file_by_direct_
 			continue;
 
 		kdebug("[LOAD] va=%lx of=%lx fs=%lx ms=%lx",
-		       phdr->p_vaddr, phdr->p_offset, phdr->p_filesz, phdr->p_memsz);
+		       (unsigned long) phdr->p_vaddr,
+		       (unsigned long) phdr->p_offset,
+		       (unsigned long) phdr->p_filesz,
+		       (unsigned long) phdr->p_memsz);
 
 		/* determine the mapping parameters */
 		if (phdr->p_flags & PF_R) prot |= PROT_READ;
@@ -1008,8 +1012,10 @@ static int elf_fdpic_map_file_by_direct_
 
 		/* create the mapping */
 		disp = phdr->p_vaddr & ~PAGE_MASK;
+		down_write(&mm->mmap_sem);
 		maddr = do_mmap(file, maddr, phdr->p_memsz + disp, prot, flags,
 				phdr->p_offset - disp);
+		up_write(&mm->mmap_sem);
 
 		kdebug("mmap[%d] <file> sz=%lx pr=%x fl=%x of=%lx --> %08lx",
 		       loop, phdr->p_memsz + disp, prot, flags, phdr->p_offset - disp,
@@ -1051,7 +1057,9 @@ static int elf_fdpic_map_file_by_direct_
 			unsigned long xmaddr;
 
 			flags |= MAP_FIXED | MAP_ANONYMOUS;
+			down_write(&mm->mmap_sem);
 			xmaddr = do_mmap(NULL, xaddr, excess - excess1, prot, flags, 0);
+			up_write(&mm->mmap_sem);
 
 			kdebug("mmap[%d] <anon>"
 			       " ad=%lx sz=%lx pr=%x fl=%x of=0 --> %08lx",
