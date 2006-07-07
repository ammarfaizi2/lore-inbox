Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWGGLt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWGGLt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWGGLs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:48:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932133AbWGGLr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:47:58 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/8] FDPIC: Adjust the ELF-FDPIC driver to conform more to the CodingStyle [try #4]
Date: Fri, 07 Jul 2006 12:47:46 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060707114746.948.21082.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
References: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Adjust the ELF-FDPIC binfmt driver to conform much more to the CodingStyle,
silly though it may be.

Further changes:

 (*) Drop the casts to long for addresses in kdebug() statements (they're
     unsigned long already).

 (*) Use extra variables to avoid expressions longer than 80 chars by splitting
     the statement into multiple statements and letting the compiler optimise
     them back together.

 (*) Eliminate duplicate call of ksize() when working out how much space was
     actually allocated for the stack.

 (*) Discard the commented-out load_shlib prototype and op pointer as this will
     not be supported in ELF-FDPIC for the foreseeable future.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/binfmt_elf_fdpic.c |  305 +++++++++++++++++++++++++++----------------------
 1 files changed, 168 insertions(+), 137 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 07624b9..a4ff873 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1,6 +1,6 @@
 /* binfmt_elf_fdpic.c: FDPIC ELF binary format
  *
- * Copyright (C) 2003, 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2003, 2004, 2006 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  * Derived from binfmt_elf.c
  *
@@ -50,43 +50,45 @@ #endif
 
 MODULE_LICENSE("GPL");
 
-static int load_elf_fdpic_binary(struct linux_binprm *bprm, struct pt_regs *regs);
-//static int load_elf_fdpic_library(struct file *);
-static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params, struct file *file);
-static int elf_fdpic_map_file(struct elf_fdpic_params *params,
-			      struct file *file,
-			      struct mm_struct *mm,
-			      const char *what);
+static int load_elf_fdpic_binary(struct linux_binprm *, struct pt_regs *);
+static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *, struct file *);
+static int elf_fdpic_map_file(struct elf_fdpic_params *, struct file *,
+			      struct mm_struct *, const char *);
 
-static int create_elf_fdpic_tables(struct linux_binprm *bprm,
-				   struct mm_struct *mm,
-				   struct elf_fdpic_params *exec_params,
-				   struct elf_fdpic_params *interp_params);
+static int create_elf_fdpic_tables(struct linux_binprm *, struct mm_struct *,
+				   struct elf_fdpic_params *,
+				   struct elf_fdpic_params *);
 
 #ifndef CONFIG_MMU
-static int elf_fdpic_transfer_args_to_stack(struct linux_binprm *bprm, unsigned long *_sp);
-static int elf_fdpic_map_file_constdisp_on_uclinux(struct elf_fdpic_params *params,
-						   struct file *file,
-						   struct mm_struct *mm);
+static int elf_fdpic_transfer_args_to_stack(struct linux_binprm *,
+					    unsigned long *);
+static int elf_fdpic_map_file_constdisp_on_uclinux(struct elf_fdpic_params *,
+						   struct file *,
+						   struct mm_struct *);
 #endif
 
-static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
-					     struct file *file,
-					     struct mm_struct *mm);
+static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *,
+					     struct file *, struct mm_struct *);
 
 static struct linux_binfmt elf_fdpic_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_elf_fdpic_binary,
-//	.load_shlib	= load_elf_fdpic_library,
 //	.core_dump	= elf_fdpic_core_dump,
 	.min_coredump	= ELF_EXEC_PAGESIZE,
 };
 
-static int __init init_elf_fdpic_binfmt(void)  { return register_binfmt(&elf_fdpic_format); }
-static void __exit exit_elf_fdpic_binfmt(void) { unregister_binfmt(&elf_fdpic_format); }
+static int __init init_elf_fdpic_binfmt(void)
+{
+	return register_binfmt(&elf_fdpic_format);
+}
 
-module_init(init_elf_fdpic_binfmt)
-module_exit(exit_elf_fdpic_binfmt)
+static void __exit exit_elf_fdpic_binfmt(void)
+{
+	unregister_binfmt(&elf_fdpic_format);
+}
+
+module_init(init_elf_fdpic_binfmt);
+module_exit(exit_elf_fdpic_binfmt);
 
 static int is_elf_fdpic(struct elfhdr *hdr, struct file *file)
 {
@@ -105,7 +107,8 @@ static int is_elf_fdpic(struct elfhdr *h
 /*
  * read the program headers table into memory
  */
-static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params, struct file *file)
+static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
+				 struct file *file)
 {
 	struct elf32_phdr *phdr;
 	unsigned long size;
@@ -121,7 +124,8 @@ static int elf_fdpic_fetch_phdrs(struct 
 	if (!params->phdrs)
 		return -ENOMEM;
 
-	retval = kernel_read(file, params->hdr.e_phoff, (char *) params->phdrs, size);
+	retval = kernel_read(file, params->hdr.e_phoff,
+			     (char *) params->phdrs, size);
 	if (retval < 0)
 		return retval;
 
@@ -141,17 +145,24 @@ static int elf_fdpic_fetch_phdrs(struct 
 	}
 
 	return 0;
-} /* end elf_fdpic_fetch_phdrs() */
+}
 
 /*****************************************************************************/
 /*
  * load an fdpic binary into various bits of memory
  */
-static int load_elf_fdpic_binary(struct linux_binprm *bprm, struct pt_regs *regs)
+static int load_elf_fdpic_binary(struct linux_binprm *bprm,
+				 struct pt_regs *regs)
 {
 	struct elf_fdpic_params exec_params, interp_params;
 	struct elf_phdr *phdr;
-	unsigned long stack_size;
+	unsigned long stack_size, entryaddr;
+#ifndef CONFIG_MMU
+	unsigned long fullsize;
+#endif
+#ifdef ELF_FDPIC_PLAT_INIT
+	unsigned long dynaddr;
+#endif
 	struct file *interpreter = NULL; /* to shut gcc up */
 	char *interpreter_name = NULL;
 	int executable_stack;
@@ -212,7 +223,8 @@ static int load_elf_fdpic_binary(struct 
 				goto error;
 			}
 
-			retval = kernel_read(interpreter, 0, bprm->buf, BINPRM_BUF_SIZE);
+			retval = kernel_read(interpreter, 0, bprm->buf,
+					     BINPRM_BUF_SIZE);
 			if (retval < 0)
 				goto error;
 
@@ -295,7 +307,8 @@ #ifdef CONFIG_MMU
 				  &current->mm->start_stack,
 				  &current->mm->start_brk);
 
-	retval = setup_arg_pages(bprm, current->mm->start_stack, executable_stack);
+	retval = setup_arg_pages(bprm, current->mm->start_stack,
+				 executable_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
 		goto error_kill;
@@ -303,7 +316,8 @@ #ifdef CONFIG_MMU
 #endif
 
 	/* load the executable and interpreter into memory */
-	retval = elf_fdpic_map_file(&exec_params, bprm->file, current->mm, "executable");
+	retval = elf_fdpic_map_file(&exec_params, bprm->file, current->mm,
+				    "executable");
 	if (retval < 0)
 		goto error_kill;
 
@@ -324,7 +338,8 @@ #ifdef CONFIG_MMU
 	if (!current->mm->start_brk)
 		current->mm->start_brk = current->mm->end_data;
 
-	current->mm->brk = current->mm->start_brk = PAGE_ALIGN(current->mm->start_brk);
+	current->mm->brk = current->mm->start_brk =
+		PAGE_ALIGN(current->mm->start_brk);
 
 #else
 	/* create a stack and brk area big enough for everyone
@@ -336,47 +351,45 @@ #else
 		stack_size = PAGE_SIZE * 2;
 
 	down_write(&current->mm->mmap_sem);
-	current->mm->start_brk = do_mmap(NULL,
-					 0,
-					 stack_size,
+	current->mm->start_brk = do_mmap(NULL, 0, stack_size,
 					 PROT_READ | PROT_WRITE | PROT_EXEC,
 					 MAP_PRIVATE | MAP_ANON | MAP_GROWSDOWN,
 					 0);
 
-	if (IS_ERR((void *) current->mm->start_brk)) {
+	if (IS_ERR_VALUE(current->mm->start_brk)) {
 		up_write(&current->mm->mmap_sem);
 		retval = current->mm->start_brk;
 		current->mm->start_brk = 0;
 		goto error_kill;
 	}
 
-	if (do_mremap(current->mm->start_brk,
-		      stack_size,
-		      ksize((char *) current->mm->start_brk),
-		      0, 0
-		      ) == current->mm->start_brk
-	    )
-		stack_size = ksize((char *) current->mm->start_brk);
+	/* expand the stack mapping to use up the entire allocation granule */
+	fullsize = ksize((char *) current->mm->start_brk);
+	if (!IS_ERR_VALUE(do_mremap(current->mm->start_brk, stack_size,
+				    fullsize, 0, 0)))
+		stack_size = fullsize;
 	up_write(&current->mm->mmap_sem);
 
 	current->mm->brk = current->mm->start_brk;
 	current->mm->context.end_brk = current->mm->start_brk;
-	current->mm->context.end_brk += (stack_size > PAGE_SIZE) ? (stack_size - PAGE_SIZE) : 0;
+	current->mm->context.end_brk +=
+		(stack_size > PAGE_SIZE) ? (stack_size - PAGE_SIZE) : 0;
 	current->mm->start_stack = current->mm->start_brk + stack_size;
 #endif
 
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
-	if (create_elf_fdpic_tables(bprm, current->mm, &exec_params, &interp_params) < 0)
+	if (create_elf_fdpic_tables(bprm, current->mm,
+				    &exec_params, &interp_params) < 0)
 		goto error_kill;
 
-	kdebug("- start_code  %lx",	(long) current->mm->start_code);
-	kdebug("- end_code    %lx",	(long) current->mm->end_code);
-	kdebug("- start_data  %lx",	(long) current->mm->start_data);
-	kdebug("- end_data    %lx",	(long) current->mm->end_data);
-	kdebug("- start_brk   %lx",	(long) current->mm->start_brk);
-	kdebug("- brk         %lx",	(long) current->mm->brk);
-	kdebug("- start_stack %lx",	(long) current->mm->start_stack);
+	kdebug("- start_code  %lx", current->mm->start_code);
+	kdebug("- end_code    %lx", current->mm->end_code);
+	kdebug("- start_data  %lx", current->mm->start_data);
+	kdebug("- end_data    %lx", current->mm->end_data);
+	kdebug("- start_brk   %lx", current->mm->start_brk);
+	kdebug("- brk         %lx", current->mm->brk);
+	kdebug("- start_stack %lx", current->mm->start_stack);
 
 #ifdef ELF_FDPIC_PLAT_INIT
 	/*
@@ -385,21 +398,18 @@ #ifdef ELF_FDPIC_PLAT_INIT
 	 * example.  This macro performs whatever initialization to
 	 * the regs structure is required.
 	 */
-	ELF_FDPIC_PLAT_INIT(regs,
-			    exec_params.map_addr,
-			    interp_params.map_addr,
-			    interp_params.dynamic_addr ?: exec_params.dynamic_addr
-			    );
+	dynaddr = interp_params.dynamic_addr ?: exec_params.dynamic_addr;
+	ELF_FDPIC_PLAT_INIT(regs, exec_params.map_addr, interp_params.map_addr,
+			    dynaddr);
 #endif
 
 	/* everything is now ready... get the userspace context ready to roll */
-	start_thread(regs,
-		     interp_params.entry_addr ?: exec_params.entry_addr,
-		     current->mm->start_stack);
+	entryaddr = interp_params.entry_addr ?: exec_params.entry_addr;
+	start_thread(regs, entryaddr, current->mm->start_stack);
 
 	if (unlikely(current->ptrace & PT_PTRACED)) {
 		if (current->ptrace & PT_TRACE_EXEC)
-			ptrace_notify ((PTRACE_EVENT_EXEC << 8) | SIGTRAP);
+			ptrace_notify((PTRACE_EVENT_EXEC << 8) | SIGTRAP);
 		else
 			send_sig(SIGTRAP, current, 0);
 	}
@@ -419,11 +429,11 @@ error:
 	return retval;
 
 	/* unrecoverable error - kill the process */
- error_kill:
+error_kill:
 	send_sig(SIGSEGV, current, 0);
 	goto error;
 
-} /* end load_elf_fdpic_binary() */
+}
 
 /*****************************************************************************/
 /*
@@ -471,11 +481,11 @@ #endif
 
 #if defined(__i386__) && defined(CONFIG_SMP)
 	/* in some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
-	 * by the processes running on the same package. One thing we can do
-	 * is to shuffle the initial stack for them.
+	 * by the processes running on the same package. One thing we can do is
+	 * to shuffle the initial stack for them.
 	 *
-	 * the conditionals here are unneeded, but kept in to make the
-	 * code behaviour the same as pre change unless we have hyperthreaded
+	 * the conditionals here are unneeded, but kept in to make the code
+	 * behaviour the same as pre change unless we have hyperthreaded
 	 * processors. This keeps Mr Marcelo Person happier but should be
 	 * removed for 2.5
 	 */
@@ -498,11 +508,13 @@ #endif
 
 	if (interp_params->loadmap) {
 		len = sizeof(struct elf32_fdpic_loadmap);
-		len += sizeof(struct elf32_fdpic_loadseg) * interp_params->loadmap->nsegs;
+		len += sizeof(struct elf32_fdpic_loadseg) *
+			interp_params->loadmap->nsegs;
 		sp = (sp - len) & ~7UL;
 		interp_params->map_addr = sp;
 
-		if (copy_to_user((void __user *) sp, interp_params->loadmap, len) != 0)
+		if (copy_to_user((void __user *) sp, interp_params->loadmap,
+				 len) != 0)
 			return -EFAULT;
 
 		current->mm->context.interp_fdpic_loadmap = (unsigned long) sp;
@@ -526,34 +538,37 @@ #endif
 	sp -= sp & 15UL;
 
 	/* put the ELF interpreter info on the stack */
-#define NEW_AUX_ENT(nr, id, val)						\
-	do {									\
-		struct { unsigned long _id, _val; } __user *ent = (void __user *) csp;	\
-		__put_user((id), &ent[nr]._id);					\
-		__put_user((val), &ent[nr]._val);				\
+#define NEW_AUX_ENT(nr, id, val)					\
+	do {								\
+		struct { unsigned long _id, _val; } __user *ent;	\
+									\
+		ent = (void __user *) csp;				\
+		__put_user((id), &ent[nr]._id);				\
+		__put_user((val), &ent[nr]._val);			\
 	} while (0)
 
 	csp -= 2 * sizeof(unsigned long);
 	NEW_AUX_ENT(0, AT_NULL, 0);
 	if (k_platform) {
 		csp -= 2 * sizeof(unsigned long);
-		NEW_AUX_ENT(0, AT_PLATFORM, (elf_addr_t)(unsigned long) u_platform);
+		NEW_AUX_ENT(0, AT_PLATFORM,
+			    (elf_addr_t) (unsigned long) u_platform);
 	}
 
 	csp -= DLINFO_ITEMS * 2 * sizeof(unsigned long);
-	NEW_AUX_ENT( 0, AT_HWCAP,		hwcap);
-	NEW_AUX_ENT( 1, AT_PAGESZ,		PAGE_SIZE);
-	NEW_AUX_ENT( 2, AT_CLKTCK,		CLOCKS_PER_SEC);
-	NEW_AUX_ENT( 3, AT_PHDR,		exec_params->ph_addr);
-	NEW_AUX_ENT( 4, AT_PHENT,		sizeof(struct elf_phdr));
-	NEW_AUX_ENT( 5, AT_PHNUM,		exec_params->hdr.e_phnum);
-	NEW_AUX_ENT( 6,	AT_BASE,		interp_params->elfhdr_addr);
-	NEW_AUX_ENT( 7, AT_FLAGS,		0);
-	NEW_AUX_ENT( 8, AT_ENTRY,		exec_params->entry_addr);
-	NEW_AUX_ENT( 9, AT_UID,			(elf_addr_t) current->uid);
-	NEW_AUX_ENT(10, AT_EUID,		(elf_addr_t) current->euid);
-	NEW_AUX_ENT(11, AT_GID,			(elf_addr_t) current->gid);
-	NEW_AUX_ENT(12, AT_EGID,		(elf_addr_t) current->egid);
+	NEW_AUX_ENT( 0, AT_HWCAP,	hwcap);
+	NEW_AUX_ENT( 1, AT_PAGESZ,	PAGE_SIZE);
+	NEW_AUX_ENT( 2, AT_CLKTCK,	CLOCKS_PER_SEC);
+	NEW_AUX_ENT( 3, AT_PHDR,	exec_params->ph_addr);
+	NEW_AUX_ENT( 4, AT_PHENT,	sizeof(struct elf_phdr));
+	NEW_AUX_ENT( 5, AT_PHNUM,	exec_params->hdr.e_phnum);
+	NEW_AUX_ENT( 6,	AT_BASE,	interp_params->elfhdr_addr);
+	NEW_AUX_ENT( 7, AT_FLAGS,	0);
+	NEW_AUX_ENT( 8, AT_ENTRY,	exec_params->entry_addr);
+	NEW_AUX_ENT( 9, AT_UID,		(elf_addr_t) current->uid);
+	NEW_AUX_ENT(10, AT_EUID,	(elf_addr_t) current->euid);
+	NEW_AUX_ENT(11, AT_GID,		(elf_addr_t) current->gid);
+	NEW_AUX_ENT(12, AT_EGID,	(elf_addr_t) current->egid);
 
 #ifdef ARCH_DLINFO
 	/* ARCH_DLINFO must come last so platform specific code can enforce
@@ -579,7 +594,8 @@ #undef NEW_AUX_ENT
 #ifdef CONFIG_MMU
 	current->mm->arg_start = bprm->p;
 #else
-	current->mm->arg_start = current->mm->start_stack - (MAX_ARG_PAGES * PAGE_SIZE - bprm->p);
+	current->mm->arg_start = current->mm->start_stack -
+		(MAX_ARG_PAGES * PAGE_SIZE - bprm->p);
 #endif
 
 	p = (char __user *) current->mm->arg_start;
@@ -607,7 +623,7 @@ #endif
 
 	mm->start_stack = (unsigned long) sp;
 	return 0;
-} /* end create_elf_fdpic_tables() */
+}
 
 /*****************************************************************************/
 /*
@@ -615,7 +631,8 @@ #endif
  * the stack
  */
 #ifndef CONFIG_MMU
-static int elf_fdpic_transfer_args_to_stack(struct linux_binprm *bprm, unsigned long *_sp)
+static int elf_fdpic_transfer_args_to_stack(struct linux_binprm *bprm,
+					    unsigned long *_sp)
 {
 	unsigned long index, stop, sp;
 	char *src;
@@ -636,9 +653,9 @@ static int elf_fdpic_transfer_args_to_st
 
 	*_sp = (*_sp - (MAX_ARG_PAGES * PAGE_SIZE - bprm->p)) & ~15;
 
- out:
+out:
 	return ret;
-} /* end elf_fdpic_transfer_args_to_stack() */
+}
 #endif
 
 /*****************************************************************************/
@@ -713,17 +730,18 @@ #endif
 		seg = loadmap->segs;
 		for (loop = loadmap->nsegs; loop > 0; loop--, seg++) {
 			if (params->hdr.e_entry >= seg->p_vaddr &&
-			    params->hdr.e_entry < seg->p_vaddr + seg->p_memsz
-			    ) {
+			    params->hdr.e_entry < seg->p_vaddr + seg->p_memsz) {
 				params->entry_addr =
-					(params->hdr.e_entry - seg->p_vaddr) + seg->addr;
+					(params->hdr.e_entry - seg->p_vaddr) +
+					seg->addr;
 				break;
 			}
 		}
 	}
 
 	/* determine where the program header table has wound up if mapped */
-	stop = params->hdr.e_phoff + params->hdr.e_phnum * sizeof (struct elf_phdr);
+	stop = params->hdr.e_phoff;
+	stop += params->hdr.e_phnum * sizeof (struct elf_phdr);
 	phdr = params->phdrs;
 
 	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
@@ -737,9 +755,11 @@ #endif
 		seg = loadmap->segs;
 		for (loop = loadmap->nsegs; loop > 0; loop--, seg++) {
 			if (phdr->p_vaddr >= seg->p_vaddr &&
-			    phdr->p_vaddr + phdr->p_filesz <= seg->p_vaddr + seg->p_memsz
-			    ) {
-				params->ph_addr = (phdr->p_vaddr - seg->p_vaddr) + seg->addr +
+			    phdr->p_vaddr + phdr->p_filesz <=
+			    seg->p_vaddr + seg->p_memsz) {
+				params->ph_addr =
+					(phdr->p_vaddr - seg->p_vaddr) +
+					seg->addr +
 					params->hdr.e_phoff - phdr->p_offset;
 				break;
 			}
@@ -756,18 +776,22 @@ #endif
 		seg = loadmap->segs;
 		for (loop = loadmap->nsegs; loop > 0; loop--, seg++) {
 			if (phdr->p_vaddr >= seg->p_vaddr &&
-			    phdr->p_vaddr + phdr->p_memsz <= seg->p_vaddr + seg->p_memsz
-			    ) {
-				params->dynamic_addr = (phdr->p_vaddr - seg->p_vaddr) + seg->addr;
-
-				/* check the dynamic section contains at least one item, and that
-				 * the last item is a NULL entry */
+			    phdr->p_vaddr + phdr->p_memsz <=
+			    seg->p_vaddr + seg->p_memsz) {
+				params->dynamic_addr =
+					(phdr->p_vaddr - seg->p_vaddr) +
+					seg->addr;
+
+				/* check the dynamic section contains at least
+				 * one item, and that the last item is a NULL
+				 * entry */
 				if (phdr->p_memsz == 0 ||
 				    phdr->p_memsz % sizeof(Elf32_Dyn) != 0)
 					goto dynamic_error;
 
 				tmp = phdr->p_memsz / sizeof(Elf32_Dyn);
-				if (((Elf32_Dyn *) params->dynamic_addr)[tmp - 1].d_tag != 0)
+				if (((Elf32_Dyn *)
+				     params->dynamic_addr)[tmp - 1].d_tag != 0)
 					goto dynamic_error;
 				break;
 			}
@@ -776,8 +800,8 @@ #endif
 	}
 
 	/* now elide adjacent segments in the load map on MMU linux
-	 * - on uClinux the holes between may actually be filled with system stuff or stuff from
-	 *   other processes
+	 * - on uClinux the holes between may actually be filled with system
+	 *   stuff or stuff from other processes
 	 */
 #ifdef CONFIG_MMU
 	nloads = loadmap->nsegs;
@@ -788,7 +812,9 @@ #ifdef CONFIG_MMU
 		if (seg->p_vaddr - mseg->p_vaddr == seg->addr - mseg->addr) {
 			load_addr = PAGE_ALIGN(mseg->addr + mseg->p_memsz);
 			if (load_addr == (seg->addr & PAGE_MASK)) {
-				mseg->p_memsz += load_addr - (mseg->addr + mseg->p_memsz);
+				mseg->p_memsz +=
+					load_addr -
+					(mseg->addr + mseg->p_memsz);
 				mseg->p_memsz += seg->addr & ~PAGE_MASK;
 				mseg->p_memsz += seg->p_memsz;
 				loadmap->nsegs--;
@@ -816,20 +842,21 @@ #endif
 
 	return 0;
 
- dynamic_error:
+dynamic_error:
 	printk("ELF FDPIC %s with invalid DYNAMIC section (inode=%lu)\n",
 	       what, file->f_dentry->d_inode->i_ino);
 	return -ELIBBAD;
-} /* end elf_fdpic_map_file() */
+}
 
 /*****************************************************************************/
 /*
  * map a file with constant displacement under uClinux
  */
 #ifndef CONFIG_MMU
-static int elf_fdpic_map_file_constdisp_on_uclinux(struct elf_fdpic_params *params,
-						   struct file *file,
-						   struct mm_struct *mm)
+static int elf_fdpic_map_file_constdisp_on_uclinux(
+	struct elf_fdpic_params *params,
+	struct file *file,
+	struct mm_struct *mm)
 {
 	struct elf32_fdpic_loadseg *seg;
 	struct elf32_phdr *phdr;
@@ -840,7 +867,8 @@ static int elf_fdpic_map_file_constdisp_
 	load_addr = params->load_addr;
 	seg = params->loadmap->segs;
 
-	/* determine the bounds of the contiguous overall allocation we must make */
+	/* determine the bounds of the contiguous overall allocation we must
+	 * make */
 	phdr = params->phdrs;
 	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
 		if (params->phdrs[loop].p_type != PT_LOAD)
@@ -861,7 +889,7 @@ static int elf_fdpic_map_file_constdisp_
 	maddr = do_mmap(NULL, load_addr, top - base,
 			PROT_READ | PROT_WRITE | PROT_EXEC, mflags, 0);
 	up_write(&mm->mmap_sem);
-	if (IS_ERR((void *) maddr))
+	if (IS_ERR_VALUE(maddr))
 		return (int) maddr;
 
 	if (load_addr != 0)
@@ -879,7 +907,8 @@ static int elf_fdpic_map_file_constdisp_
 		seg->p_vaddr = phdr->p_vaddr;
 		seg->p_memsz = phdr->p_memsz;
 
-		ret = file->f_op->read(file, (void *) seg->addr, phdr->p_filesz, &fpos);
+		ret = file->f_op->read(file, (void *) seg->addr,
+				       phdr->p_filesz, &fpos);
 		if (ret < 0)
 			return ret;
 
@@ -896,8 +925,7 @@ static int elf_fdpic_map_file_constdisp_
 			if (phdr->p_flags & PF_X) {
 				mm->start_code = seg->addr;
 				mm->end_code = seg->addr + phdr->p_memsz;
-			}
-			else if (!mm->start_data) {
+			} else if (!mm->start_data) {
 				mm->start_data = seg->addr;
 #ifndef CONFIG_MMU
 				mm->end_data = seg->addr + phdr->p_memsz;
@@ -914,7 +942,7 @@ #endif
 	}
 
 	return 0;
-} /* end elf_fdpic_map_file_constdisp_on_uclinux() */
+}
 #endif
 
 /*****************************************************************************/
@@ -975,14 +1003,14 @@ static int elf_fdpic_map_file_by_direct_
 
 		case ELF_FDPIC_FLAG_CONSTDISP:
 			/* constant displacement
-			 * - can be mapped anywhere, but must be mapped as a unit
+			 * - can be mapped anywhere, but must be mapped as a
+			 *   unit
 			 */
 			if (!dvset) {
 				maddr = load_addr;
 				delta_vaddr = phdr->p_vaddr;
 				dvset = 1;
-			}
-			else {
+			} else {
 				maddr = load_addr + phdr->p_vaddr - delta_vaddr;
 				flags |= MAP_FIXED;
 			}
@@ -1006,13 +1034,14 @@ static int elf_fdpic_map_file_by_direct_
 		up_write(&mm->mmap_sem);
 
 		kdebug("mmap[%d] <file> sz=%lx pr=%x fl=%x of=%lx --> %08lx",
-		       loop, phdr->p_memsz + disp, prot, flags, phdr->p_offset - disp,
-		       maddr);
+		       loop, phdr->p_memsz + disp, prot, flags,
+		       phdr->p_offset - disp, maddr);
 
-		if (IS_ERR((void *) maddr))
+		if (IS_ERR_VALUE(maddr))
 			return (int) maddr;
 
-		if ((params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) == ELF_FDPIC_FLAG_CONTIGUOUS)
+		if ((params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) ==
+		    ELF_FDPIC_FLAG_CONTIGUOUS)
 			load_addr += PAGE_ALIGN(phdr->p_memsz + disp);
 
 		seg->addr = maddr + disp;
@@ -1023,7 +1052,8 @@ static int elf_fdpic_map_file_by_direct_
 		if (phdr->p_offset == 0)
 			params->elfhdr_addr = seg->addr;
 
-		/* clear the bit between beginning of mapping and beginning of PT_LOAD */
+		/* clear the bit between beginning of mapping and beginning of
+		 * PT_LOAD */
 		if (prot & PROT_WRITE && disp > 0) {
 			kdebug("clear[%d] ad=%lx sz=%lx", loop, maddr, disp);
 			clear_user((void __user *) maddr, disp);
@@ -1039,19 +1069,20 @@ static int elf_fdpic_map_file_by_direct_
 		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 
 #ifdef CONFIG_MMU
-
 		if (excess > excess1) {
 			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
 			unsigned long xmaddr;
 
 			flags |= MAP_FIXED | MAP_ANONYMOUS;
 			down_write(&mm->mmap_sem);
-			xmaddr = do_mmap(NULL, xaddr, excess - excess1, prot, flags, 0);
+			xmaddr = do_mmap(NULL, xaddr, excess - excess1,
+					 prot, flags, 0);
 			up_write(&mm->mmap_sem);
 
 			kdebug("mmap[%d] <anon>"
 			       " ad=%lx sz=%lx pr=%x fl=%x of=0 --> %08lx",
-			       loop, xaddr, excess - excess1, prot, flags, xmaddr);
+			       loop, xaddr, excess - excess1, prot, flags,
+			       xmaddr);
 
 			if (xmaddr != xaddr)
 				return -ENOMEM;
@@ -1060,7 +1091,8 @@ #ifdef CONFIG_MMU
 		if (prot & PROT_WRITE && excess1 > 0) {
 			kdebug("clear[%d] ad=%lx sz=%lx",
 			       loop, maddr + phdr->p_filesz, excess1);
-			clear_user((void __user *) maddr + phdr->p_filesz, excess1);
+			clear_user((void __user *) maddr + phdr->p_filesz,
+				   excess1);
 		}
 
 #else
@@ -1075,8 +1107,7 @@ #endif
 			if (phdr->p_flags & PF_X) {
 				mm->start_code = maddr;
 				mm->end_code = maddr + phdr->p_memsz;
-			}
-			else if (!mm->start_data) {
+			} else if (!mm->start_data) {
 				mm->start_data = maddr;
 				mm->end_data = maddr + phdr->p_memsz;
 			}
@@ -1086,4 +1117,4 @@ #endif
 	}
 
 	return 0;
-} /* end elf_fdpic_map_file_by_direct_mmap() */
+}
