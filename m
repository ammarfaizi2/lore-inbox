Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTBXSim>; Mon, 24 Feb 2003 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbTBXSVk>; Mon, 24 Feb 2003 13:21:40 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:34985 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S267322AbTBXSKQ> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:16 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (13/13): 31 bit compatability layer.
Date: Mon, 24 Feb 2003 19:15:53 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241915.53928.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for the 31 bit compatability layer:
 * add compat function for jiffies_to_timeval
 * convert parameters of clone system call
 * incorporate changes from setup_arg_pages to setup_arg_pages32
 * incorporate changes from do_execve to do_execve32
 * take care of nanosecond field in struct timespec
 * remove functions of old module system calls
 * add TIF_31BIT thread flag and replace S390_FLAG_31BIT with it
 * add arch_get_unmapped_area
 * add wrapper for sys_set_tid_address

diff -urN linux-2.5.62/arch/s390x/kernel/binfmt_elf32.c linux-2.5.62-s390/arch/s390x/kernel/binfmt_elf32.c
--- linux-2.5.62/arch/s390x/kernel/binfmt_elf32.c	Mon Feb 17 23:57:21 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/binfmt_elf32.c	Mon Feb 24 18:25:00 2003
@@ -9,9 +9,10 @@
  * Copyright (C) 1995, 1996, 1997, 1998 Jakub Jelinek   (jj@ultra.linux.cz)
  */
 
-
 #define __ASMS390_ELF_H
 
+#include <linux/time.h>
+
 /*
  * These are used to set parameters in the core dumps.
  */
@@ -38,7 +39,7 @@
 #define ELF_PLAT_INIT(_r) \
 	do { \
 	_r->gprs[14] = 0; \
-	current->thread.flags |= S390_FLAG_31BIT; \
+	set_thread_flag(TIF_31BIT); \
 	} while(0)
 
 #define USE_ELF_CORE_DUMP
@@ -49,9 +50,7 @@
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE         ((TASK31_SIZE & 0x80000000) \
-                                ? TASK31_SIZE / 3 * 2 \
-                                : 2 * TASK31_SIZE / 3)     
+#define ELF_ET_DYN_BASE         (TASK31_SIZE / 3 * 2)
 
 /* Wow, the "main" arch needs arch dependent functions too.. :) */
 
@@ -86,7 +85,6 @@
 
 #define ELF_PLATFORM (NULL)
 
-#ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2)			\
 do {							\
 	if (ibcs2)                                      \
@@ -94,7 +92,6 @@
 	else if (current->personality != PER_LINUX32)   \
 		set_personality(PER_LINUX);             \
 } while (0)
-#endif 
 
 #include "linux32.h"
 
@@ -186,6 +183,14 @@
 #undef MODULE_DESCRIPTION
 #undef MODULE_AUTHOR
 
+#define jiffies_to_timeval jiffies_to_compat_timeval
+static __inline__ void
+jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
+{
+	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
+	value->tv_sec = jiffies / HZ;
+}
+
 #include "../../../fs/binfmt_elf.c"
 
 static unsigned long
@@ -193,14 +198,17 @@
 {
 	unsigned long map_addr;
 
-	if(!addr)
-		addr = 0x40000000;
+	if (!addr) 
+		addr = 0x40000000; 
+
+	if (prot & PROT_READ) 
+		prot |= PROT_EXEC; 
 
 	down_write(&current->mm->mmap_sem);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
+			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr),
+			   prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
 	up_write(&current->mm->mmap_sem);
 	return(map_addr);
 }
-
diff -urN linux-2.5.62/arch/s390x/kernel/entry.S linux-2.5.62-s390/arch/s390x/kernel/entry.S
--- linux-2.5.62/arch/s390x/kernel/entry.S	Mon Feb 24 18:18:38 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/entry.S	Mon Feb 24 18:25:00 2003
@@ -280,6 +280,12 @@
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
         jg      sys_clone              # branch to sys_clone
 
+#ifdef CONFIG_S390_SUPPORT
+sys32_clone_glue: 
+        la      %r2,SP_PTREGS(%r15)    # load pt_regs
+        jg      sys32_clone            # branch to sys32_clone
+#endif
+
 sys_fork_glue:  
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
         jg      sys_fork               # branch to sys_fork
@@ -511,7 +517,7 @@
         .long  SYSCALL(sys_ipc,sys32_ipc_wrapper)
         .long  SYSCALL(sys_fsync,sys32_fsync_wrapper)
         .long  SYSCALL(sys_sigreturn_glue,sys32_sigreturn_glue)
-        .long  SYSCALL(sys_clone_glue,sys_clone_glue) /* 120 */
+        .long  SYSCALL(sys_clone_glue,sys32_clone_glue) /* 120 */
         .long  SYSCALL(sys_setdomainname,sys32_setdomainname_wrapper)
         .long  SYSCALL(s390x_newuname,sys32_newuname_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* modify_ldt for i386 */
@@ -643,7 +649,7 @@
 	.long  SYSCALL(sys_epoll_create,sys_ni_syscall)
 	.long  SYSCALL(sys_epoll_ctl,sys_ni_syscall)
 	.long  SYSCALL(sys_epoll_wait,sys_ni_syscall)
-	.long  SYSCALL(sys_set_tid_address,sys_ni_syscall)
+	.long  SYSCALL(sys_set_tid_address,sys32_set_tid_address_wrapper)
 	.long  SYSCALL(sys_fadvise64,sys_ni_syscall)
         .rept  255-253
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
diff -urN linux-2.5.62/arch/s390x/kernel/exec32.c linux-2.5.62-s390/arch/s390x/kernel/exec32.c
--- linux-2.5.62/arch/s390x/kernel/exec32.c	Mon Feb 17 23:55:49 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/exec32.c	Mon Feb 24 18:25:00 2003
@@ -42,9 +42,11 @@
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
+	struct mm_struct *mm = current->mm;
 	int i;
 
 	stack_base = STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
+	mm->arg_start = bprm->p + stack_base;
 
 	bprm->p += stack_base;
 	if (bprm->loader)
@@ -55,9 +57,14 @@
 	if (!mpnt) 
 		return -ENOMEM; 
 	
-	down_write(&current->mm->mmap_sem);
+	if (!vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
+		kmem_cache_free(vm_area_cachep, mpnt);
+		return -ENOMEM;
+	}
+
+	down_write(&mm->mmap_sem);
 	{
-		mpnt->vm_mm = current->mm;
+		mpnt->vm_mm = mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = STACK_TOP;
 		mpnt->vm_page_prot = PAGE_COPY;
@@ -65,9 +72,10 @@
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
+		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
-		insert_vm_struct(current->mm, mpnt);
-		current->mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+		insert_vm_struct(mm, mpnt);
+		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 	} 
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
@@ -78,7 +86,7 @@
 		}
 		stack_base += PAGE_SIZE;
 	}
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 	
 	return 0;
 }
diff -urN linux-2.5.62/arch/s390x/kernel/linux32.c linux-2.5.62-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.62/arch/s390x/kernel/linux32.c	Mon Feb 24 18:17:42 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/linux32.c	Mon Feb 24 18:25:00 2003
@@ -1328,12 +1328,12 @@
 	err |= put_user(high2lowgid(stat->gid), &statbuf->st_gid);
 	err |= put_user(stat->rdev, &statbuf->st_rdev);
 	err |= put_user(stat->size, &statbuf->st_size);
-	err |= put_user(stat->atime, &statbuf->st_atime);
-	err |= put_user(0, &statbuf->__unused1);
-	err |= put_user(stat->mtime, &statbuf->st_mtime);
-	err |= put_user(0, &statbuf->__unused2);
-	err |= put_user(stat->ctime, &statbuf->st_ctime);
-	err |= put_user(0, &statbuf->__unused3);
+	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
+	err |= put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec);
+	err |= put_user(stat->mtime.tv_sec, &statbuf->st_mtime);
+	err |= put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec);
+	err |= put_user(stat->ctime.tv_sec, &statbuf->st_ctime);
+	err |= put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec);
 	err |= put_user(stat->blksize, &statbuf->st_blksize);
 	err |= put_user(stat->blocks, &statbuf->st_blocks);
 /* fixme
@@ -2700,8 +2700,7 @@
 	int retval;
 	int i;
 
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES * sizeof(bprm.page[0]));
+	sched_balance_exec();
 
 	file = open_exec(filename);
 
@@ -2709,21 +2708,32 @@
 	if (IS_ERR(file))
 		return retval;
 
+	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	memset(bprm.page, 0, MAX_ARG_PAGES * sizeof(bprm.page[0]));
+
 	bprm.file = file;
 	bprm.filename = filename;
 	bprm.sh_bang = 0;
 	bprm.loader = 0;
 	bprm.exec = 0;
-	if ((bprm.argc = count32(argv)) < 0) {
-		allow_write_access(file);
-		fput(file);
-		return bprm.argc;
-	}
-	if ((bprm.envc = count32(envp)) < 0) {
-		allow_write_access(file);
-		fput(file);
-		return bprm.envc;
-	}
+	bprm.mm = mm_alloc();
+	retval = -ENOMEM;
+	if (!bprm.mm)
+		goto out_file;
+
+	/* init_new_context is empty for s390x. */
+
+	bprm.argc = count32(argv);
+	if ((retval = bprm.argc) < 0)
+		goto out_mm;
+
+	bprm.envc = count32(envp);
+	if ((retval = bprm.envc) < 0)
+		goto out_mm;
+
+	retval = security_bprm_alloc(&bprm);
+	if (retval)
+		goto out;
 
 	retval = prepare_binprm(&bprm);
 	if (retval < 0)
@@ -2743,19 +2753,31 @@
 		goto out;
 
 	retval = search_binary_handler(&bprm, regs);
-	if (retval >= 0)
+	if (retval >= 0) {
 		/* execve success */
+		security_bprm_free(&bprm);
 		return retval;
+	}
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	allow_write_access(bprm.file);
-	if (bprm.file)
-		fput(bprm.file);
+	for (i=0 ; i<MAX_ARG_PAGES ; i++) {
+		struct page * page = bprm.page[i];
+		if (page)
+			__free_page(page);
+	}
+
+	if (bprm.security)
+		security_bprm_free(&bprm);
+
+out_mm:
+	mmdrop(bprm.mm);
 
-	for (i=0 ; i<MAX_ARG_PAGES ; i++)
-		if (bprm.page[i])
-			__free_page(bprm.page[i]);
+out_file:
+	if (bprm.file) {
+		allow_write_access(bprm.file);
+		fput(bprm.file);
+	}
 
 	return retval;
 }
@@ -2816,265 +2838,6 @@
 	s32 usecount;
 };
 
-/* Query various bits about modules.  */
-
-static inline long
-get_mod_name(const char *user_name, char **buf)
-{
-	unsigned long page;
-	long retval;
-
-	if ((unsigned long)user_name >= TASK_SIZE
-	    && !segment_eq(get_fs (), KERNEL_DS))
-		return -EFAULT;
-
-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	retval = strncpy_from_user((char *)page, user_name, PAGE_SIZE);
-	if (retval > 0) {
-		if (retval < PAGE_SIZE) {
-			*buf = (char *)page;
-			return retval;
-		}
-		retval = -ENAMETOOLONG;
-	} else if (!retval)
-		retval = -EINVAL;
-
-	free_page(page);
-	return retval;
-}
-
-static inline void
-put_mod_name(char *buf)
-{
-	free_page((unsigned long)buf);
-}
-
-static __inline__ struct module *find_module(const char *name)
-{
-	struct module *mod;
-
-	for (mod = module_list; mod ; mod = mod->next) {
-		if (mod->flags & MOD_DELETED)
-			continue;
-		if (!strcmp(mod->name, name))
-			break;
-	}
-
-	return mod;
-}
-
-static int
-qm_modules(char *buf, size_t bufsize, compat_size_t *ret)
-{
-	struct module *mod;
-	size_t nmod, space, len;
-
-	nmod = space = 0;
-
-	for (mod = module_list; mod->next != NULL; mod = mod->next, ++nmod) {
-		len = strlen(mod->name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, mod->name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
-		space += len;
-	}
-
-	if (put_user(nmod, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	space += len;
-	while ((mod = mod->next)->next != NULL)
-		space += strlen(mod->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
-}
-
-static int
-qm_deps(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
-{
-	size_t i, space, len;
-
-	if (mod->next == NULL)
-		return -EINVAL;
-	if (!MOD_CAN_QUERY(mod))
-		return put_user(0, ret);
-
-	space = 0;
-	for (i = 0; i < mod->ndeps; ++i) {
-		const char *dep_name = mod->deps[i].dep->name;
-
-		len = strlen(dep_name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, dep_name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
-		space += len;
-	}
-
-	return put_user(i, ret);
-
-calc_space_needed:
-	space += len;
-	while (++i < mod->ndeps)
-		space += strlen(mod->deps[i].dep->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
-}
-
-static int
-qm_refs(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
-{
-	size_t nrefs, space, len;
-	struct module_ref *ref;
-
-	if (mod->next == NULL)
-		return -EINVAL;
-	if (!MOD_CAN_QUERY(mod))
-		if (put_user(0, ret))
-			return -EFAULT;
-		else
-			return 0;
-
-	space = 0;
-	for (nrefs = 0, ref = mod->refs; ref ; ++nrefs, ref = ref->next_ref) {
-		const char *ref_name = ref->ref->name;
-
-		len = strlen(ref_name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, ref_name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
-		space += len;
-	}
-
-	if (put_user(nrefs, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	space += len;
-	while ((ref = ref->next_ref) != NULL)
-		space += strlen(ref->ref->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
-}
-
-static inline int
-qm_symbols(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
-{
-	size_t i, space, len;
-	struct module_symbol *s;
-	char *strings;
-	unsigned *vals;
-
-	if (!MOD_CAN_QUERY(mod))
-		if (put_user(0, ret))
-			return -EFAULT;
-		else
-			return 0;
-
-	space = mod->nsyms * 2*sizeof(u32);
-
-	i = len = 0;
-	s = mod->syms;
-
-	if (space > bufsize)
-		goto calc_space_needed;
-
-	if (!access_ok(VERIFY_WRITE, buf, space))
-		return -EFAULT;
-
-	bufsize -= space;
-	vals = (unsigned *)buf;
-	strings = buf+space;
-
-	for (; i < mod->nsyms ; ++i, ++s, vals += 2) {
-		len = strlen(s->name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-
-		if (copy_to_user(strings, s->name, len)
-		    || __put_user(s->value, vals+0)
-		    || __put_user(space, vals+1))
-			return -EFAULT;
-
-		strings += len;
-		bufsize -= len;
-		space += len;
-	}
-
-	if (put_user(i, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	for (; i < mod->nsyms; ++i, ++s)
-		space += strlen(s->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
-}
-
-static inline int
-qm_info(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
-{
-	int error = 0;
-
-	if (mod->next == NULL)
-		return -EINVAL;
-
-	if (sizeof(struct module_info32) <= bufsize) {
-		struct module_info32 info;
-		info.addr = (unsigned long)mod;
-		info.size = mod->size;
-		info.flags = mod->flags;
-		info.usecount =
-			((mod_member_present(mod, can_unload)
-			  && mod->can_unload)
-			 ? -1 : atomic_read(&mod->uc.usecount));
-
-		if (copy_to_user(buf, &info, sizeof(struct module_info32)))
-			return -EFAULT;
-	} else
-		error = -ENOSPC;
-
-	if (put_user(sizeof(struct module_info32), ret))
-		return -EFAULT;
-
-	return error;
-}
-
-struct kernel_sym32 {
-	u32 value;
-	char name[60];
-};
-
 #else /* CONFIG_MODULES */
 
 asmlinkage int
@@ -4069,3 +3832,21 @@
 
 	return sys_write(fd, buf, count);
 }
+
+asmlinkage int sys32_clone(struct pt_regs regs)
+{
+        unsigned long clone_flags;
+        unsigned long newsp;
+	struct task_struct *p;
+	int *parent_tidptr, *child_tidptr;
+
+        clone_flags = regs.gprs[3] & 0xffffffffUL;
+        newsp = regs.orig_gpr2 & 0x7fffffffUL;
+	parent_tidptr = (int *) (regs.gprs[4] & 0x7fffffffUL);
+	child_tidptr = (int *) (regs.gprs[5] & 0x7fffffffUL);
+        if (!newsp)
+                newsp = regs.gprs[15];
+        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
+		    parent_tidptr, child_tidptr);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+}
diff -urN linux-2.5.62/arch/s390x/kernel/process.c linux-2.5.62-s390/arch/s390x/kernel/process.c
--- linux-2.5.62/arch/s390x/kernel/process.c	Mon Feb 24 18:18:38 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/process.c	Mon Feb 24 18:25:00 2003
@@ -206,7 +206,7 @@
 
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS) {
-		if (current->thread.flags & S390_FLAG_31BIT) {
+		if (test_thread_flag(TIF_31BIT)) {
 			frame->childregs.acrs[0] =
 				(unsigned int) regs->gprs[6];
 		} else {
diff -urN linux-2.5.62/arch/s390x/kernel/ptrace.c linux-2.5.62-s390/arch/s390x/kernel/ptrace.c
--- linux-2.5.62/arch/s390x/kernel/ptrace.c	Mon Feb 24 18:18:38 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/ptrace.c	Mon Feb 24 18:25:00 2003
@@ -58,7 +58,7 @@
 	if (per_info->single_step) {
 		per_info->control_regs.bits.starting_addr = 0;
 #ifdef CONFIG_S390_SUPPORT
-		if (current->thread.flags & S390_FLAG_31BIT)
+		if (test_thread_flag(TIF_31BIT))
 			per_info->control_regs.bits.ending_addr = 0x7fffffffUL;
 		else
 #endif
@@ -290,7 +290,7 @@
 	addr_t offset;
 	__u32 tmp;
 
-	if (!(child->thread.flags & S390_FLAG_31BIT) ||
+	if (!test_thread_flag(TIF_31BIT) ||
 	    (addr & 3) || addr > sizeof(struct user) - 3)
 		return -EIO;
 
@@ -349,9 +349,8 @@
 	per_struct32 *dummy_per32 = NULL;
 	addr_t offset;
 	__u32 tmp;
-	int ret;
 
-	if (!(child->thread.flags & S390_FLAG_31BIT) ||
+	if (!test_thread_flag(TIF_31BIT) ||
 	    (addr & 3) || addr > sizeof(struct user32) - 3)
 		return -EIO;
 
@@ -382,7 +381,7 @@
 		 */
 		if (addr == (addr_t) &dummy32->regs.fp_regs.fpc &&
 		    (tmp & ~FPC_VALID_MASK) != 0)
-			/* Invalid floating pointer control. */
+			/* Invalid floating point control. */
 			return -EINVAL;
 	        offset = addr - (addr_t) &dummy32->regs.fp_regs;
 		*(__u32 *)((addr_t) &child->thread.fp_regs + offset) = tmp;
@@ -542,7 +541,7 @@
 	/* Do requests that differ for 31/64 bit */
 	default:
 #ifdef CONFIG_S390_SUPPORT
-		if (current->thread.flags & S390_FLAG_31BIT)
+		if (test_thread_flag(TIF_31BIT))
 			return do_ptrace_emu31(child, request, addr, data);
 #endif
 		return do_ptrace_normal(child, request, addr, data);
diff -urN linux-2.5.62/arch/s390x/kernel/signal.c linux-2.5.62-s390/arch/s390x/kernel/signal.c
--- linux-2.5.62/arch/s390x/kernel/signal.c	Mon Feb 24 18:18:38 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/signal.c	Mon Feb 24 18:25:00 2003
@@ -455,7 +455,7 @@
 	if (!oldset)
 		oldset = &current->blocked;
 #ifdef CONFIG_S390_SUPPORT 
-	if (current->thread.flags & S390_FLAG_31BIT) {
+	if (test_thread_flag(TIF_31BIT)) {
 		extern asmlinkage int do_signal32(struct pt_regs *regs, sigset_t *oldset); 
 		return do_signal32(regs, oldset);
         }
diff -urN linux-2.5.62/arch/s390x/kernel/signal32.c linux-2.5.62-s390/arch/s390x/kernel/signal32.c
--- linux-2.5.62/arch/s390x/kernel/signal32.c	Mon Feb 17 23:56:14 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/signal32.c	Mon Feb 24 18:25:00 2003
@@ -556,7 +556,7 @@
 handle_signal32(unsigned long sig, siginfo_t *info, sigset_t *oldset,
 	struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sig->action[sig-1];
+	struct k_sigaction *ka = &current->sighand->action[sig-1];
 
 	/* Are we from a system call? */
 	if (regs->trap == __LC_SVC_OLD_PSW) {
diff -urN linux-2.5.62/arch/s390x/kernel/sys_s390.c linux-2.5.62-s390/arch/s390x/kernel/sys_s390.c
--- linux-2.5.62/arch/s390x/kernel/sys_s390.c	Mon Feb 17 23:56:55 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/sys_s390.c	Mon Feb 24 18:25:00 2003
@@ -117,6 +117,38 @@
 	return error;
 }
 
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		       unsigned long len, unsigned long pgoff,
+		       unsigned long flags)
+{
+	struct vm_area_struct *vma;
+	unsigned long end;
+
+	if (test_thread_flag(TIF_31BIT)) { 
+		if (!addr) 
+			addr = 0x40000000; 
+		end = 0x80000000;		
+	} else { 
+		if (!addr) 
+			addr = TASK_SIZE / 2;
+		end = TASK_SIZE; 
+	}
+
+	if (len > end)
+		return -ENOMEM;
+	addr = PAGE_ALIGN(addr);
+
+	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (end - len < addr)
+			return -ENOMEM;
+		if (!vma || addr + len <= vma->vm_start)
+			return addr;
+		addr = vma->vm_end;
+	}
+}
+
 extern asmlinkage int sys_select(int, fd_set *, fd_set *, fd_set *, struct timeval *);
 
 /*
diff -urN linux-2.5.62/arch/s390x/kernel/wrapper32.S linux-2.5.62-s390/arch/s390x/kernel/wrapper32.S
--- linux-2.5.62/arch/s390x/kernel/wrapper32.S	Mon Feb 17 23:57:18 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/wrapper32.S	Mon Feb 24 18:25:00 2003
@@ -1204,3 +1204,8 @@
 sys32_exit_group_wrapper:
 	lgfr	%r2,%r2			# int
 	jg	sys_exit_group		# branch to system call
+
+	.globl  sys32_set_tid_address_wrapper
+sys32_set_tid_address_wrapper:
+	llgtr	%r2,%r2			# int *
+	jg	sys_set_tid_address	# branch to system call
diff -urN linux-2.5.62/include/asm-s390x/compat.h linux-2.5.62-s390/include/asm-s390x/compat.h
--- linux-2.5.62/include/asm-s390x/compat.h	Mon Feb 17 23:56:15 2003
+++ linux-2.5.62-s390/include/asm-s390x/compat.h	Mon Feb 24 18:25:00 2003
@@ -49,11 +49,11 @@
 	u32		st_blksize;
 	u32		st_blocks;
 	u32		st_atime;
-	u32		__unused1;
+	u32		st_atime_nsec;
 	u32		st_mtime;
-	u32		__unused2;
+	u32		st_mtime_nsec;
 	u32		st_ctime;
-	u32		__unused3;
+	u32		st_ctime_nsec;
 	u32		__unused4;
 	u32		__unused5;
 };
diff -urN linux-2.5.62/include/asm-s390x/elf.h linux-2.5.62-s390/include/asm-s390x/elf.h
--- linux-2.5.62/include/asm-s390x/elf.h	Mon Feb 17 23:56:15 2003
+++ linux-2.5.62-s390/include/asm-s390x/elf.h	Mon Feb 24 18:25:00 2003
@@ -39,7 +39,7 @@
 #define ELF_PLAT_INIT(_r) \
 	do { \
 	_r->gprs[14] = 0; \
-	current->thread.flags = 0; \
+	clear_thread_flag(TIF_31BIT); \
 	} while(0)
 
 #define USE_ELF_CORE_DUMP
@@ -83,6 +83,7 @@
 		set_personality(PER_SVR4);		\
 	else if (current->personality != PER_LINUX32)	\
 		set_personality(PER_LINUX);		\
+	clear_thread_flag(TIF_31BIT);			\
 } while (0)
 #endif
 
diff -urN linux-2.5.62/include/asm-s390x/pgtable.h linux-2.5.62-s390/include/asm-s390x/pgtable.h
--- linux-2.5.62/include/asm-s390x/pgtable.h	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62-s390/include/asm-s390x/pgtable.h	Mon Feb 24 18:25:00 2003
@@ -544,5 +544,7 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#define HAVE_ARCH_UNMAPPED_AREA
+
 #endif /* _S390_PAGE_H */
 
diff -urN linux-2.5.62/include/asm-s390x/processor.h linux-2.5.62-s390/include/asm-s390x/processor.h
--- linux-2.5.62/include/asm-s390x/processor.h	Mon Feb 17 23:56:49 2003
+++ linux-2.5.62-s390/include/asm-s390x/processor.h	Mon Feb 24 18:25:00 2003
@@ -55,8 +55,6 @@
 /* Lazy FPU handling on uni-processor */
 extern struct task_struct *last_task_used_math;
 
-#define S390_FLAG_31BIT 0x01UL
-
 /*
  * User space process size: 4TB (default).
  */
@@ -66,8 +64,8 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE      ((current->thread.flags & S390_FLAG_31BIT) ? \
-	(TASK31_SIZE / 2) : (TASK_SIZE / 2))
+#define TASK_UNMAPPED_BASE \
+	(test_thread_flag(TIF_31BIT) ? (TASK31_SIZE / 2) : (TASK_SIZE / 2))
 
 #define THREAD_SIZE (4*PAGE_SIZE)
 
diff -urN linux-2.5.62/include/asm-s390x/thread_info.h linux-2.5.62-s390/include/asm-s390x/thread_info.h
--- linux-2.5.62/include/asm-s390x/thread_info.h	Mon Feb 17 23:56:26 2003
+++ linux-2.5.62-s390/include/asm-s390x/thread_info.h	Mon Feb 24 18:25:00 2003
@@ -77,6 +77,7 @@
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
+#define TIF_31BIT		18	/* 32bit process */ 
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -85,6 +86,7 @@
 #define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_31BIT		(1<<TIF_31BIT)
 
 #endif /* __KERNEL__ */
 

