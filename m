Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUDQKEA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUDQKEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:04:00 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:44987 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263770AbUDQJtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:49:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Consolidate do_execve32
Date: Fri, 16 Apr 2004 18:04:17 +0200
User-Agent: KMail/1.6.1
References: <200404161800.22367.arnd@arndb.de>
In-Reply-To: <200404161800.22367.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404161804.17961.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code for sys32_execve/do_execve32 in most of the seven versions
was copied from fs/exec.c but not kept up-to-date. The new
compat_do_execve() function is based on the mips code and has been
resync'ed with do_execve(). IA64 changes are from Arun Sharma.

Tested on x86_64, ia64 and s390

 arch/ia64/ia32/sys_ia32.c         |   70 ++---------
 arch/mips/kernel/linux32.c        |  228 -------------------------------------
 arch/parisc/kernel/sys_parisc32.c |  187 ------------------------------
 arch/ppc64/kernel/sys_ppc32.c     |  187 ------------------------------
 arch/s390/kernel/compat_linux.c   |  187 ------------------------------
 arch/sparc64/kernel/sys_sparc32.c |  195 --------------------------------
 arch/x86_64/ia32/sys_ia32.c       |  101 ++--------------
 fs/compat.c                       |  231 ++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h            |    3
 9 files changed, 275 insertions(+), 1114 deletions(-)

===== arch/ia64/ia32/sys_ia32.c 1.95 vs edited =====
--- 1.95/arch/ia64/ia32/sys_ia32.c	Sat Apr  3 21:51:49 2004
+++ edited/arch/ia64/ia32/sys_ia32.c	Thu Apr 15 17:08:18 2004
@@ -90,58 +90,17 @@
 /* XXX make per-mm: */
 static DECLARE_MUTEX(ia32_mmap_sem);
 
-static int
-nargs (unsigned int arg, char **ap)
-{
-	unsigned int addr;
-	int n, err;
-
-	if (!arg)
-		return 0;
-
-	n = 0;
-	do {
-		err = get_user(addr, (unsigned int *)A(arg));
-		if (err)
-			return err;
-		if (ap)
-			*ap++ = (char *) A(addr);
-		arg += sizeof(unsigned int);
-		n++;
-	} while (addr);
-	return n - 1;
-}
-
 asmlinkage long
-sys32_execve (char *filename, unsigned int argv, unsigned int envp,
-	      struct pt_regs *regs)
+sys32_execve (char *name, compat_uptr_t __user *argv, compat_uptr_t __user *envp, struct pt_regs *regs)
 {
+	long error;
+	char *filename;
 	unsigned long old_map_base, old_task_size, tssd;
-	char **av, **ae;
-	int na, ne, len;
-	long r;
-
-	na = nargs(argv, NULL);
-	if (na < 0)
-		return na;
-	ne = nargs(envp, NULL);
-	if (ne < 0)
-		return ne;
-	len = (na + ne + 2) * sizeof(*av);
-	av = kmalloc(len, GFP_KERNEL);
-	if (!av)
-		return -ENOMEM;
-
-	ae = av + na + 1;
-	av[na] = NULL;
-	ae[ne] = NULL;
-
-	r = nargs(argv, av);
-	if (r < 0)
-		goto out;
-	r = nargs(envp, ae);
-	if (r < 0)
-		goto out;
+
+	filename = getname(name);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		return error;
 
 	old_map_base  = current->thread.map_base;
 	old_task_size = current->thread.task_size;
@@ -153,19 +112,18 @@
 	ia64_set_kr(IA64_KR_IO_BASE, current->thread.old_iob);
 	ia64_set_kr(IA64_KR_TSSD, current->thread.old_k1);
 
-	set_fs(KERNEL_DS);
-	r = sys_execve(filename, av, ae, regs);
-	if (r < 0) {
+	error = compat_do_execve(filename, argv, envp, regs);
+	putname(filename);
+
+	if (error < 0) {
 		/* oops, execve failed, switch back to old values... */
 		ia64_set_kr(IA64_KR_IO_BASE, IA32_IOBASE);
 		ia64_set_kr(IA64_KR_TSSD, tssd);
 		current->thread.map_base  = old_map_base;
 		current->thread.task_size = old_task_size;
-		set_fs(USER_DS);	/* establish new task-size as the address-limit */
 	}
-  out:
-	kfree(av);
-	return r;
+
+	return error;
 }
 
 int cp_compat_stat(struct kstat *stat, struct compat_stat *ubuf)
===== arch/mips/kernel/linux32.c 1.23 vs edited =====
--- 1.23/arch/mips/kernel/linux32.c	Sat Apr  3 21:51:49 2004
+++ edited/arch/mips/kernel/linux32.c	Thu Apr 15 17:08:12 2004
@@ -142,228 +142,6 @@
 }
 
 /*
- * count32() counts the number of arguments/envelopes
- */
-static int count32(u32 * argv, int max)
-{
-	int i = 0;
-
-	if (argv != NULL) {
-		for (;;) {
-			u32 p; int error;
-
-			error = get_user(p,argv);
-			if (error)
-				return error;
-			if (!p)
-				break;
-			argv++;
-			if (++i > max)
-				return -E2BIG;
-		}
-	}
-	return i;
-}
-
-
-/*
- * 'copy_strings32()' copies argument/envelope strings from user
- * memory to free pages in kernel mem. These are in a format ready
- * to be put directly into the top of new user memory.
- */
-int copy_strings32(int argc, u32 * argv, struct linux_binprm *bprm)
-{
-	struct page *kmapped_page = NULL;
-	char *kaddr = NULL;
-	int ret;
-
-	while (argc-- > 0) {
-		u32 str;
-		int len;
-		unsigned long pos;
-
-		if (get_user(str, argv+argc) || !str ||
-		     !(len = strnlen_user((char *)A(str), bprm->p))) {
-			ret = -EFAULT;
-			goto out;
-		}
-
-		if (bprm->p < len)  {
-			ret = -E2BIG;
-			goto out;
-		}
-
-		bprm->p -= len;
-		/* XXX: add architecture specific overflow check here. */
-
-		pos = bprm->p;
-		while (len > 0) {
-			int i, new, err;
-			int offset, bytes_to_copy;
-			struct page *page;
-
-			offset = pos % PAGE_SIZE;
-			i = pos/PAGE_SIZE;
-			page = bprm->page[i];
-			new = 0;
-			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
-				bprm->page[i] = page;
-				if (!page) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				new = 1;
-			}
-
-			if (page != kmapped_page) {
-				if (kmapped_page)
-					kunmap(kmapped_page);
-				kmapped_page = page;
-				kaddr = kmap(kmapped_page);
-			}
-			if (new && offset)
-				memset(kaddr, 0, offset);
-			bytes_to_copy = PAGE_SIZE - offset;
-			if (bytes_to_copy > len) {
-				bytes_to_copy = len;
-				if (new)
-					memset(kaddr+offset+len, 0,
-					       PAGE_SIZE-offset-len);
-			}
-			err = copy_from_user(kaddr + offset, (char *)A(str),
-			                     bytes_to_copy);
-			if (err) {
-				ret = -EFAULT;
-				goto out;
-			}
-
-			pos += bytes_to_copy;
-			str += bytes_to_copy;
-			len -= bytes_to_copy;
-		}
-	}
-	ret = 0;
-out:
-	if (kmapped_page)
-		kunmap(kmapped_page);
-	return ret;
-}
-
-#ifdef CONFIG_MMU
-
-#define free_arg_pages(bprm) do { } while (0)
-
-#else
-
-static inline void free_arg_pages(struct linux_binprm *bprm)
-{
-	int i;
-
-	for (i = 0; i < MAX_ARG_PAGES; i++) {
-		if (bprm->page[i])
-			__free_page(bprm->page[i]);
-		bprm->page[i] = NULL;
-	}
-}
-
-#endif /* CONFIG_MMU */
-
-/*
- * sys32_execve() executes a new program.
- */
-static inline int 
-do_execve32(char * filename, u32 * argv, u32 * envp, struct pt_regs * regs)
-{
-	struct linux_binprm bprm;
-	struct file * file;
-	int retval;
-
-	sched_balance_exec();
-
-	file = open_exec(filename);
-
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		return retval;
-
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES * sizeof(bprm.page[0]));
-
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.interp = filename;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-	bprm.security = NULL;
-	bprm.mm = mm_alloc();
-	retval = -ENOMEM;
-	if (!bprm.mm) 
-		goto out_file;
-
-	retval = init_new_context(current, bprm.mm);
-	if (retval < 0)
-		goto out_mm;
-
-	bprm.argc = count32(argv, bprm.p / sizeof(u32));
-	if ((retval = bprm.argc) < 0)
-		goto out_mm;
-
-	bprm.envc = count32(envp, bprm.p / sizeof(u32));
-	if ((retval = bprm.envc) < 0)
-		goto out_mm;
-
-	retval = security_bprm_alloc(&bprm);
-	if (retval)
-		goto out;
-
-	retval = prepare_binprm(&bprm);
-	if (retval < 0)
-		goto out;
-	
-	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
-	if (retval < 0)
-		goto out;
-
-	bprm.exec = bprm.p;
-	retval = copy_strings32(bprm.envc, envp, &bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = copy_strings32(bprm.argc, argv, &bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = search_binary_handler(&bprm, regs);
-	if (retval >= 0) {
-		free_arg_pages(&bprm);
-
-		/* execve success */
-		security_bprm_free(&bprm);
-		return retval;
-	}
-
-out:
-	/* Something went wrong, return the inode and free the argument pages*/
-	free_arg_pages(&bprm);
-
-	if (bprm.security)
-		security_bprm_free(&bprm);
-
-out_mm:
-	if (bprm.mm)
-		mmdrop(bprm.mm);
-
-out_file:
-	if (bprm.file) {
-		allow_write_access(bprm.file);
-		fput(bprm.file);
-	}
-	return retval;
-}
-
-/*
  * sys_execve() executes a new program.
  */
 asmlinkage int sys32_execve(nabi_no_regargs struct pt_regs regs)
@@ -371,12 +149,12 @@
 	int error;
 	char * filename;
 
-	filename = getname((char *) (long)regs.regs[4]);
+	filename = getname(compat_ptr(regs.regs[4]));
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename))
 		goto out;
-	error = do_execve32(filename, (u32 *) (long)regs.regs[5],
-	                  (u32 *) (long)regs.regs[6], &regs);
+	error = compat_do_execve(filename, compat_ptr(regs.regs[5]),
+				 compat_ptr(regs.regs[6]), &regs);
 	putname(filename);
 
 out:
===== arch/parisc/kernel/sys_parisc32.c 1.26 vs edited =====
--- 1.26/arch/parisc/kernel/sys_parisc32.c	Sat Apr  3 21:51:49 2004
+++ edited/arch/parisc/kernel/sys_parisc32.c	Thu Apr 15 17:08:12 2004
@@ -65,189 +65,6 @@
 #endif
 
 /*
- * count32() counts the number of arguments/envelopes. It is basically
- *           a copy of count() from fs/exec.c, except that it works
- *           with 32 bit argv and envp pointers.
- */
-
-static int count32(u32 *argv, int max)
-{
-	int i = 0;
-
-	if (argv != NULL) {
-		for (;;) {
-			u32 p;
-			int error;
-
-			error = get_user(p,argv);
-			if (error)
-				return error;
-			if (!p)
-				break;
-			argv++;
-			if(++i > max)
-				return -E2BIG;
-		}
-	}
-	return i;
-}
-
-
-/*
- * copy_strings32() is basically a copy of copy_strings() from fs/exec.c
- *                  except that it works with 32 bit argv and envp pointers.
- */
-
-
-static int copy_strings32(int argc, u32 *argv, struct linux_binprm *bprm)
-{
-	while (argc-- > 0) {
-		u32 str;
-		int len;
-		unsigned long pos;
-
-		if (get_user(str, argv + argc) ||
-		    !str ||
-		    !(len = strnlen_user((char *)compat_ptr(str), bprm->p)))
-			return -EFAULT;
-
-		if (bprm->p < len) 
-			return -E2BIG; 
-
-		bprm->p -= len;
-
-		pos = bprm->p;
-		while (len > 0) {
-			char *kaddr;
-			int i, new, err;
-			struct page *page;
-			int offset, bytes_to_copy;
-
-			offset = pos % PAGE_SIZE;
-			i = pos/PAGE_SIZE;
-			page = bprm->page[i];
-			new = 0;
-			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
-				bprm->page[i] = page;
-				if (!page)
-					return -ENOMEM;
-				new = 1;
-			}
-			kaddr = (char *)kmap(page);
-
-			if (new && offset)
-				memset(kaddr, 0, offset);
-			bytes_to_copy = PAGE_SIZE - offset;
-			if (bytes_to_copy > len) {
-				bytes_to_copy = len;
-				if (new)
-					memset(kaddr+offset+len, 0, PAGE_SIZE-offset-len);
-			}
-			err = copy_from_user(kaddr + offset, (char *)compat_ptr(str), bytes_to_copy);
-			flush_dcache_page(page);
-			kunmap(page);
-
-			if (err)
-				return -EFAULT; 
-
-			pos += bytes_to_copy;
-			str += bytes_to_copy;
-			len -= bytes_to_copy;
-		}
-	}
-	return 0;
-}
-
-/*
- * do_execve32() is mostly a copy of do_execve(), with the exception
- * that it processes 32 bit argv and envp pointers.
- */
-
-static inline int 
-do_execve32(char * filename, u32 * argv, u32 * envp, struct pt_regs * regs)
-{
-	struct linux_binprm bprm;
-	struct file *file;
-	int retval;
-	int i;
-
-	file = open_exec(filename);
-
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		return retval;
-
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0]));
-
-	DBG(("do_execve32(%s, %p, %p, %p)\n", filename, argv, envp, regs));
-
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.interp = filename;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-
-	bprm.mm = mm_alloc();
-	retval = -ENOMEM;
-	if (!bprm.mm)
-		goto out_file;
-
-	retval = init_new_context(current, bprm.mm);
-	if (retval < 0)
-		goto out_mm;
-
-	if ((bprm.argc = count32(argv, bprm.p / sizeof(u32))) < 0) 
-		goto out_mm;
-
-	if ((bprm.envc = count32(envp, bprm.p / sizeof(u32))) < 0) 
-		goto out_mm;
-
-	retval = prepare_binprm(&bprm);
-	if (retval < 0)
-		goto out;
-	
-	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
-	if (retval < 0)
-		goto out;
-
-	bprm.exec = bprm.p;
-	retval = copy_strings32(bprm.envc, envp, &bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = copy_strings32(bprm.argc, argv, &bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = search_binary_handler(&bprm,regs);
-	if (retval >= 0)
-		/* execve success */
-		return retval;
-
-out:
-	/* Something went wrong, return the inode and free the argument pages*/
-	for (i = 0; i < MAX_ARG_PAGES; i++) {
-		struct page *page = bprm.page[i];
-		if (page)
-			__free_page(page);
-	}
-
-out_mm:
-	mmdrop(bprm.mm);
-
-out_file:
-	if (bprm.file) {
-		allow_write_access(bprm.file);
-		fput(bprm.file);
-	}
-
-	return retval;
-}
-
-/*
  * sys32_execve() executes a new program.
  */
 
@@ -261,8 +78,8 @@
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename))
 		goto out;
-	error = do_execve32(filename, (u32 *) regs->gr[25],
-		(u32 *) regs->gr[24], regs);
+	error = compat_do_execve(filename, compat_ptr(regs->gr[25]),
+				 compat_ptr(regs->gr[24]), regs);
 	if (error == 0)
 		current->ptrace &= ~PT_DTRACE;
 	putname(filename);
===== arch/ppc64/kernel/sys_ppc32.c 1.87 vs edited =====
--- 1.87/arch/ppc64/kernel/sys_ppc32.c	Sat Apr  3 21:51:49 2004
+++ edited/arch/ppc64/kernel/sys_ppc32.c	Thu Apr 15 17:08:12 2004
@@ -1549,191 +1549,6 @@
 	return ret;
 }
 
-/*
- * count32() counts the number of arguments/envelopes
- */
-static int count32(u32 * argv, int max)
-{
-	int i = 0;
-
-	if (argv != NULL) {
-		for (;;) {
-			u32 p; int error;
-
-			error = get_user(p,argv);
-			if (error)
-				return error;
-			if (!p)
-				break;
-			argv++;
-			if (++i > max)
-				return -E2BIG;
-		}
-	}
-	return i;
-}
-
-/*
- * 'copy_string32()' copies argument/envelope strings from user
- * memory to free pages in kernel mem. These are in a format ready
- * to be put directly into the top of new user memory.
- */
-static int copy_strings32(int argc, u32 * argv, struct linux_binprm *bprm)
-{
-	while (argc-- > 0) {
-		u32 str;
-		int len;
-		unsigned long pos;
-
-		if (get_user(str, argv + argc) ||
-		    !str ||
-		    !(len = strnlen_user((char *)A(str), bprm->p)))
-			return -EFAULT;
-
-		if (bprm->p < len)
-			return -E2BIG;
-
-		bprm->p -= len;
-
-		pos = bprm->p;
-		while (len) {
-			char *kaddr;
-			struct page *page;
-			int offset, bytes_to_copy, new, err;
-
-			offset = pos % PAGE_SIZE;
-			page = bprm->page[pos / PAGE_SIZE];
-			new = 0;
-			if (!page) {
-				page = alloc_page(GFP_USER);
-				bprm->page[pos / PAGE_SIZE] = page;
-				if (!page)
-					return -ENOMEM;
-				new = 1;
-			}
-			kaddr = (char *)kmap(page);
-
-			if (new && offset)
-				memset(kaddr, 0, offset);
-			bytes_to_copy = PAGE_SIZE - offset;
-			if (bytes_to_copy > len) {
-				bytes_to_copy = len;
-				if (new)
-					memset(kaddr+offset+len, 0,
-					       PAGE_SIZE-offset-len);
-			}
-
-			err = copy_from_user(kaddr + offset, (char *)A(str),
-					     bytes_to_copy);
-			kunmap((unsigned long)kaddr);
-
-			if (err)
-				return -EFAULT;
-
-			pos += bytes_to_copy;
-			str += bytes_to_copy;
-			len -= bytes_to_copy;
-		}
-	}
-	return 0;
-}
-
-/*
- * sys32_execve() executes a new program.
- */
-static int do_execve32(char * filename, u32 * argv, u32 * envp, struct pt_regs * regs)
-{
-	struct linux_binprm bprm;
-	struct file * file;
-	int retval;
-	int i;
-
-	sched_balance_exec();
-
-	file = open_exec(filename);
-
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		return retval;
-
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES * sizeof(bprm.page[0]));
-
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.interp = filename;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-	bprm.security = NULL;
-	bprm.mm = mm_alloc();
-	retval = -ENOMEM;
-	if (!bprm.mm)
-		goto out_file;
-
-	retval = init_new_context(current, bprm.mm);
-	if (retval < 0)
-		goto out_mm;
-
-	bprm.argc = count32(argv, bprm.p / sizeof(u32));
-	if ((retval = bprm.argc) < 0)
-		goto out_mm;
-
-	bprm.envc = count32(envp, bprm.p / sizeof(u32));
-	if ((retval = bprm.envc) < 0)
-		goto out_mm;
-
-	retval = security_bprm_alloc(&bprm);
-	if (retval)
-		goto out;
-
-	retval = prepare_binprm(&bprm);
-	if (retval < 0) 
-		goto out; 
-
-	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
-	if (retval < 0) 
-		goto out; 
-
-	bprm.exec = bprm.p;
-	retval = copy_strings32(bprm.envc, envp, &bprm);
-	if (retval < 0) 
-		goto out; 
-
-	retval = copy_strings32(bprm.argc, argv, &bprm);
-	if (retval < 0) 
-		goto out; 
-
-	retval = search_binary_handler(&bprm,regs);
-	if (retval >= 0) {
-		/* execve success */
-		security_bprm_free(&bprm);
-		return retval;
-	}
-
-out:
-	/* Something went wrong, return the inode and free the argument pages*/
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm.page[i];
-		if (page)
-			__free_page(page);
-	}
-
-	if (bprm.security)
-		security_bprm_free(&bprm);
-
-out_mm:
-	if (bprm.mm)
-		mmdrop(bprm.mm);
-
-out_file:
-	if (bprm.file) {
-		allow_write_access(bprm.file);
-		fput(bprm.file);
-	}
-	return retval;
-}
-
 long sys32_execve(unsigned long a0, unsigned long a1, unsigned long a2,
 		  unsigned long a3, unsigned long a4, unsigned long a5,
 		  struct pt_regs *regs)
@@ -1752,7 +1567,7 @@
 		giveup_altivec(current);
 #endif /* CONFIG_ALTIVEC */
 
-	error = do_execve32(filename, (u32*) a1, (u32*) a2, regs);
+	error = compat_do_execve(filename, compat_ptr(a1), compat_ptr(a2), regs);
 
 	if (error == 0)
 		current->ptrace &= ~PT_DTRACE;
===== arch/s390/kernel/compat_linux.c 1.20 vs edited =====
--- 1.20/arch/s390/kernel/compat_linux.c	Sat Apr  3 21:51:49 2004
+++ edited/arch/s390/kernel/compat_linux.c	Thu Apr 15 17:08:12 2004
@@ -906,188 +906,6 @@
 	return ret;
 }
 
-extern void check_pending(int signum);
-
-/*
- * count32() counts the number of arguments/envelopes
- */
-static int count32(u32 * argv)
-{
-	int i = 0;
-
-	if (argv != NULL) {
-		for (;;) {
-			u32 p; int error;
-
-			error = get_user(p,argv);
-			if (error) return error;
-			if (!p) break;
-			argv++; i++;
-		}
-	}
-	return i;
-}
-
-/*
- * 'copy_string32()' copies argument/envelope strings from user
- * memory to free pages in kernel mem. These are in a format ready
- * to be put directly into the top of new user memory.
- */
-static int copy_strings32(int argc, u32 * argv, struct linux_binprm *bprm)
-{
-	while (argc-- > 0) {
-		u32 str;
-		int len;
-		unsigned long pos;
-
-		if (get_user(str, argv + argc) ||
-		    !str ||
-		    !(len = strnlen_user((char *)A(str), bprm->p)))
-			return -EFAULT;
-
-		if (bprm->p < len)
-			return -E2BIG;
-
-		bprm->p -= len;
-
-		pos = bprm->p;
-		while (len) {
-			char *kaddr;
-			struct page *page;
-			int offset, bytes_to_copy, new, err;
-
-			offset = pos % PAGE_SIZE;
-			page = bprm->page[pos / PAGE_SIZE];
-			new = 0;
-			if (!page) {
-				page = alloc_page(GFP_USER);
-				bprm->page[pos / PAGE_SIZE] = page;
-				if (!page)
-					return -ENOMEM;
-				new = 1;
-			}
-			kaddr = (char *)kmap(page);
-
-			if (new && offset)
-				memset(kaddr, 0, offset);
-			bytes_to_copy = PAGE_SIZE - offset;
-			if (bytes_to_copy > len) {
-				bytes_to_copy = len;
-				if (new)
-					memset(kaddr+offset+len, 0,
-					       PAGE_SIZE-offset-len);
-			}
-
-			err = copy_from_user(kaddr + offset, (char *)A(str),
-					     bytes_to_copy);
-			kunmap(page);
-
-			if (err)
-				return -EFAULT;
-
-			pos += bytes_to_copy;
-			str += bytes_to_copy;
-			len -= bytes_to_copy;
-		}
-	}
-	return 0;
-}
-
-/*
- * sys32_execve() executes a new program.
- */
-static inline int 
-do_execve32(char * filename, u32 * argv, u32 * envp, struct pt_regs * regs)
-{
-	struct linux_binprm bprm;
-	struct file * file;
-	int retval;
-	int i;
-
-	sched_balance_exec();
-
-	file = open_exec(filename);
-
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		return retval;
-
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES * sizeof(bprm.page[0]));
-
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.interp = filename;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-	bprm.mm = mm_alloc();
-	retval = -ENOMEM;
-	if (!bprm.mm)
-		goto out_file;
-
-	/* init_new_context is empty for s390x. */
-
-	bprm.argc = count32(argv);
-	if ((retval = bprm.argc) < 0)
-		goto out_mm;
-
-	bprm.envc = count32(envp);
-	if ((retval = bprm.envc) < 0)
-		goto out_mm;
-
-	retval = security_bprm_alloc(&bprm);
-	if (retval)
-		goto out;
-
-	retval = prepare_binprm(&bprm);
-	if (retval < 0)
-		goto out;
-	
-	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
-	if (retval < 0)
-		goto out;
-
-	bprm.exec = bprm.p;
-	retval = copy_strings32(bprm.envc, envp, &bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = copy_strings32(bprm.argc, argv, &bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = search_binary_handler(&bprm, regs);
-	if (retval >= 0) {
-		/* execve success */
-		security_bprm_free(&bprm);
-		return retval;
-	}
-
-out:
-	/* Something went wrong, return the inode and free the argument pages*/
-	for (i=0 ; i<MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm.page[i];
-		if (page)
-			__free_page(page);
-	}
-
-	if (bprm.security)
-		security_bprm_free(&bprm);
-
-out_mm:
-	if (bprm.mm)
-		mmdrop(bprm.mm);
-
-out_file:
-	if (bprm.file) {
-		allow_write_access(bprm.file);
-		fput(bprm.file);
-	}
-
-	return retval;
-}
-
 /*
  * sys32_execve() executes a new program after the asm stub has set
  * things up for us.  This should basically do what I want it to.
@@ -1098,11 +916,12 @@
         int error;
         char * filename;
 
-        filename = getname((char *)A(regs.orig_gpr2));
+        filename = getname(compat_ptr(regs.orig_gpr2));
         error = PTR_ERR(filename);
         if (IS_ERR(filename))
                 goto out;
-        error = do_execve32(filename, (u32 *)A(regs.gprs[3]), (u32 *)A(regs.gprs[4]), &regs);
+        error = compat_do_execve(filename, compat_ptr(regs.gprs[3]),
+				 compat_ptr(regs.gprs[4]), &regs);
 	if (error == 0)
 	{
 		current->ptrace &= ~PT_DTRACE;
===== arch/sparc64/kernel/sys_sparc32.c 1.96 vs edited =====
--- 1.96/arch/sparc64/kernel/sys_sparc32.c	Sat Apr  3 21:51:49 2004
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Thu Apr 15 17:08:12 2004
@@ -1386,8 +1386,6 @@
 	return ret;
 }
 
-extern void check_pending(int signum);
-
 asmlinkage int sys32_sigaction (int sig, struct old_sigaction32 *act, struct old_sigaction32 *oact)
 {
         struct k_sigaction new_ka, old_ka;
@@ -1483,193 +1481,6 @@
         return ret;
 }
 
-
-/*
- * count32() counts the number of arguments/envelopes
- */
-static int count32(u32 * argv, int max)
-{
-	int i = 0;
-
-	if (argv != NULL) {
-		for (;;) {
-			u32 p; int error;
-
-			error = get_user(p,argv);
-			if (error)
-				return error;
-			if (!p)
-				break;
-			argv++;
-			if (++i > max)
-				return -E2BIG;
-		}
-	}
-	return i;
-}
-
-/*
- * 'copy_string32()' copies argument/envelope strings from user
- * memory to free pages in kernel mem. These are in a format ready
- * to be put directly into the top of new user memory.
- */
-static int copy_strings32(int argc, u32 * argv, struct linux_binprm *bprm)
-{
-	while (argc-- > 0) {
-		u32 str;
-		int len;
-		unsigned long pos;
-
-		if (get_user(str, argv + argc) ||
-		    !str ||
-		    !(len = strnlen_user((char *)A(str), bprm->p)))
-			return -EFAULT;
-
-		if (bprm->p < len)
-			return -E2BIG;
-
-		bprm->p -= len;
-
-		pos = bprm->p;
-		while (len) {
-			char *kaddr;
-			struct page *page;
-			int offset, bytes_to_copy, new, err;
-
-			offset = pos % PAGE_SIZE;
-			page = bprm->page[pos / PAGE_SIZE];
-			new = 0;
-			if (!page) {
-				page = alloc_page(GFP_USER);
-				bprm->page[pos / PAGE_SIZE] = page;
-				if (!page)
-					return -ENOMEM;
-				new = 1;
-			}
-			kaddr = kmap(page);
-
-			if (new && offset)
-				memset(kaddr, 0, offset);
-			bytes_to_copy = PAGE_SIZE - offset;
-			if (bytes_to_copy > len) {
-				bytes_to_copy = len;
-				if (new)
-					memset(kaddr+offset+len, 0,
-					       PAGE_SIZE-offset-len);
-			}
-
-			err = copy_from_user(kaddr + offset, (char *)A(str),
-					     bytes_to_copy);
-			kunmap(page);
-
-			if (err)
-				return -EFAULT;
-
-			pos += bytes_to_copy;
-			str += bytes_to_copy;
-			len -= bytes_to_copy;
-		}
-	}
-	return 0;
-}
-
-/*
- * sys32_execve() executes a new program.
- */
-static inline int 
-do_execve32(char * filename, u32 * argv, u32 * envp, struct pt_regs * regs)
-{
-	struct linux_binprm bprm;
-	struct file * file;
-	int retval;
-	int i;
-
-	sched_balance_exec();
-
-	file = open_exec(filename);
-
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		return retval;
-
-	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
-	memset(bprm.page, 0, MAX_ARG_PAGES * sizeof(bprm.page[0]));
-
-	bprm.file = file;
-	bprm.filename = filename;
-	bprm.interp = filename;
-	bprm.sh_bang = 0;
-	bprm.loader = 0;
-	bprm.exec = 0;
-	bprm.security = NULL;
-	bprm.mm = mm_alloc();
-	retval = -ENOMEM;
-	if (!bprm.mm) 
-		goto out_file;
-
-	retval = init_new_context(current, bprm.mm);
-	if (retval < 0)
-		goto out_mm;
-
-	bprm.argc = count32(argv, bprm.p / sizeof(u32));
-	if ((retval = bprm.argc) < 0)
-		goto out_mm;
-
-	bprm.envc = count32(envp, bprm.p / sizeof(u32));
-	if ((retval = bprm.envc) < 0)
-		goto out_mm;
-
-	retval = security_bprm_alloc(&bprm);
-	if (retval)
-		goto out;
-
-	retval = prepare_binprm(&bprm);
-	if (retval < 0)
-		goto out;
-	
-	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
-	if (retval < 0)
-		goto out;
-
-	bprm.exec = bprm.p;
-	retval = copy_strings32(bprm.envc, envp, &bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = copy_strings32(bprm.argc, argv, &bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = search_binary_handler(&bprm, regs);
-	if (retval >= 0) {
-		/* execve success */
-		security_bprm_free(&bprm);
-		return retval;
-	}
-
-out:
-	/* Something went wrong, return the inode and free the argument pages*/
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm.page[i];
-		if (page)
-			__free_page(page);
-	}
-
-	if (bprm.security)
-		security_bprm_free(&bprm);
-
-out_mm:
-	if (bprm.mm)
-		mmdrop(bprm.mm);
-
-out_file:
-	if (bprm.file) {
-		allow_write_access(bprm.file);
-		fput(bprm.file);
-	}
-	return retval;
-}
-
 /*
  * sparc32_execve() executes a new program after the asm stub has set
  * things up for us.  This should basically do what I want it to.
@@ -1689,9 +1500,9 @@
 	error = PTR_ERR(filename);
         if(IS_ERR(filename))
                 goto out;
-        error = do_execve32(filename,
-        	(u32 *)AA((u32)regs->u_regs[base + UREG_I1]),
-        	(u32 *)AA((u32)regs->u_regs[base + UREG_I2]), regs);
+        error = compat_do_execve(filename,
+        	compat_ptr((u32)regs->u_regs[base + UREG_I1]),
+        	compat_ptr((u32)regs->u_regs[base + UREG_I2]), regs);
         putname(filename);
 
 	if(!error) {
===== arch/x86_64/ia32/sys_ia32.c 1.58 vs edited =====
--- 1.58/arch/x86_64/ia32/sys_ia32.c	Sat Apr  3 21:51:49 2004
+++ edited/arch/x86_64/ia32/sys_ia32.c	Thu Apr 15 17:08:12 2004
@@ -1225,93 +1225,22 @@
 	return ret;
 } 
 
-static int nargs(u32 src, char **dst) 
-{ 
-	int cnt;
-	u32 val; 
-
-	cnt = 0; 
-	do { 		
-		int ret = get_user(val, (__u32 *)(u64)src); 
-		if (ret)
-			return ret;
-		if (dst)
-			dst[cnt] = (char *)(u64)val; 
-		cnt++;
-		src += 4; 	
-		if (cnt >= (MAX_ARG_PAGES*PAGE_SIZE)/sizeof(void*))
-			return -E2BIG; 
-	} while(val); 
-	if (dst)
-		dst[cnt-1] = 0; 
-	return cnt; 
-} 
-
-asmlinkage long sys32_execve(char *name, u32 argv, u32 envp, struct pt_regs regs)
-{ 
-	mm_segment_t oldseg; 
-	char **buf = NULL; 
-	int na = 0,ne = 0;
-	int ret;
-	unsigned sz = 0; 
-
-	if (argv) {
-	na = nargs(argv, NULL); 
-	if (na < 0) 
-		return -EFAULT; 
-	} 	
-	if (envp) { 
-	ne = nargs(envp, NULL); 
-	if (ne < 0) 
-		return -EFAULT; 
-	}
-
-	if (argv || envp) { 
-	sz = (na+ne)*sizeof(void *); 
-	if (sz > PAGE_SIZE) 
-		buf = vmalloc(sz); 
-	else
-		buf = kmalloc(sz, GFP_KERNEL); 
-	if (!buf)
-		return -ENOMEM; 
-	} 
-	
-	if (argv) { 
-	ret = nargs(argv, buf);
-	if (ret < 0)
-		goto free;
-	}
-
-	if (envp) { 
-	ret = nargs(envp, buf + na); 
-	if (ret < 0)
-		goto free; 
-	}
-
-	name = getname(name); 
-	ret = PTR_ERR(name); 
-	if (IS_ERR(name))
-		goto free; 
-
-	oldseg = get_fs(); 
-	set_fs(KERNEL_DS);
-	ret = do_execve(name, argv ? buf : NULL, envp ? buf+na : NULL, &regs);  
-	set_fs(oldseg); 
-
-	if (ret == 0)
+asmlinkage long sys32_execve(char *name, compat_uptr_t __user *argv,
+			     compat_uptr_t __user *envp, struct pt_regs regs)
+{
+	long error;
+	char * filename;
+
+	filename = getname(name);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename)) 
+		return error;
+	error = compat_do_execve(filename, argv, envp, &regs); 
+	if (error == 0)
 		current->ptrace &= ~PT_DTRACE;
-
-	putname(name);
- 
-free:
-	if (argv || envp) { 
-	if (sz > PAGE_SIZE)
-		vfree(buf); 
-	else
-	kfree(buf);
-	}
-	return ret; 
-} 
+	putname(filename);
+	return error;
+}
 
 asmlinkage long sys32_clone(unsigned int clone_flags, unsigned int newsp, struct pt_regs regs)
 {
===== fs/compat.c 1.23 vs edited =====
--- 1.23/fs/compat.c	Sat Apr  3 21:51:49 2004
+++ edited/fs/compat.c	Thu Apr 15 17:09:08 2004
@@ -980,3 +980,234 @@
 	fput(file);
 	return ret;
 }
+
+/*
+ * compat_count() counts the number of arguments/envelopes. It is basically
+ * a copy of count() from fs/exec.c, except that it works with 32 bit argv
+ * and envp pointers.
+ */
+static int compat_count(compat_uptr_t *argv, int max)
+{
+	int i = 0;
+
+	if (argv != NULL) {
+		for (;;) {
+			compat_uptr_t p;
+
+			if (get_user(p, argv))
+				return -EFAULT;
+			if (!p)
+				break;
+			argv++;
+			if(++i > max)
+				return -E2BIG;
+		}
+	}
+	return i;
+}
+
+/*
+ * compat_copy_strings() is basically a copy of copy_strings() from fs/exec.c
+ * except that it works with 32 bit argv and envp pointers.
+ */
+static int compat_copy_strings(int argc, compat_uptr_t __user *argv,
+				struct linux_binprm *bprm)
+{
+	struct page *kmapped_page = NULL;
+	char *kaddr = NULL;
+	int ret;
+
+	while (argc-- > 0) {
+		compat_uptr_t str;
+		int len;
+		unsigned long pos;
+
+		if (get_user(str, argv+argc) ||
+			!(len = strnlen_user(compat_ptr(str), bprm->p))) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		if (bprm->p < len)  {
+			ret = -E2BIG;
+			goto out;
+		}
+
+		bprm->p -= len;
+		/* XXX: add architecture specific overflow check here. */
+		pos = bprm->p;
+
+		while (len > 0) {
+			int i, new, err;
+			int offset, bytes_to_copy;
+			struct page *page;
+
+			offset = pos % PAGE_SIZE;
+			i = pos/PAGE_SIZE;
+			page = bprm->page[i];
+			new = 0;
+			if (!page) {
+				page = alloc_page(GFP_HIGHUSER);
+				bprm->page[i] = page;
+				if (!page) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				new = 1;
+			}
+
+			if (page != kmapped_page) {
+				if (kmapped_page)
+					kunmap(kmapped_page);
+				kmapped_page = page;
+				kaddr = kmap(kmapped_page);
+			}
+			if (new && offset)
+				memset(kaddr, 0, offset);
+			bytes_to_copy = PAGE_SIZE - offset;
+			if (bytes_to_copy > len) {
+				bytes_to_copy = len;
+				if (new)
+					memset(kaddr+offset+len, 0,
+						PAGE_SIZE-offset-len);
+			}
+			err = copy_from_user(kaddr+offset, compat_ptr(str),
+						bytes_to_copy);
+			if (err) {
+				ret = -EFAULT;
+				goto out;
+			}
+
+			pos += bytes_to_copy;
+			str += bytes_to_copy;
+			len -= bytes_to_copy;
+		}
+	}
+	ret = 0;
+out:
+	if (kmapped_page)
+		kunmap(kmapped_page);
+	return ret;
+}
+
+#ifdef CONFIG_MMU
+
+#define free_arg_pages(bprm) do { } while (0)
+
+#else
+
+static inline void free_arg_pages(struct linux_binprm *bprm)
+{
+	int i;
+
+	for (i = 0; i < MAX_ARG_PAGES; i++) {
+		if (bprm->page[i])
+			__free_page(bprm->page[i]);
+		bprm->page[i] = NULL;
+	}
+}
+
+#endif /* CONFIG_MMU */
+
+/*
+ * compat_do_execve() is mostly a copy of do_execve(), with the exception
+ * that it processes 32 bit argv and envp pointers.
+ */
+int compat_do_execve(char * filename,
+	compat_uptr_t __user *argv,
+	compat_uptr_t __user *envp,
+	struct pt_regs * regs)
+{
+	struct linux_binprm bprm;
+	struct file *file;
+	int retval;
+	int i;
+
+	sched_balance_exec();
+
+	file = open_exec(filename);
+
+	retval = PTR_ERR(file);
+	if (IS_ERR(file))
+		return retval;
+
+	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0]));
+
+	bprm.file = file;
+	bprm.filename = filename;
+	bprm.interp = filename;
+	bprm.sh_bang = 0;
+	bprm.loader = 0;
+	bprm.exec = 0;
+	bprm.security = NULL;
+	bprm.mm = mm_alloc();
+	retval = -ENOMEM;
+	if (!bprm.mm)
+		goto out_file;
+
+	retval = init_new_context(current, bprm.mm);
+	if (retval < 0)
+		goto out_mm;
+
+	bprm.argc = compat_count(argv, bprm.p / sizeof(compat_uptr_t));
+	if ((retval = bprm.argc) < 0)
+		goto out_mm;
+
+	bprm.envc = compat_count(envp, bprm.p / sizeof(compat_uptr_t));
+	if ((retval = bprm.envc) < 0)
+		goto out_mm;
+
+	retval = security_bprm_alloc(&bprm);
+	if (retval)
+		goto out;
+
+	retval = prepare_binprm(&bprm);
+	if (retval < 0)
+		goto out;
+
+	retval = copy_strings_kernel(1, &bprm.filename, &bprm);
+	if (retval < 0)
+		goto out;
+
+	bprm.exec = bprm.p;
+	retval = compat_copy_strings(bprm.envc, envp, &bprm);
+	if (retval < 0)
+		goto out;
+
+	retval = compat_copy_strings(bprm.argc, argv, &bprm);
+	if (retval < 0)
+		goto out;
+
+	retval = search_binary_handler(&bprm,regs);
+	if (retval >= 0) {
+		free_arg_pages(&bprm);
+
+		/* execve success */
+		security_bprm_free(&bprm);
+		return retval;
+	}
+
+out:
+	/* Something went wrong, return the inode and free the argument pages*/
+	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
+		struct page * page = bprm.page[i];
+		if (page)
+			__free_page(page);
+	}
+
+	if (bprm.security)
+		security_bprm_free(&bprm);
+
+out_mm:
+	if (bprm.mm)
+		mmdrop(bprm.mm);
+
+out_file:
+	if (bprm.file) {
+		allow_write_access(bprm.file);
+		fput(bprm.file);
+	}
+
+	return retval;
+}
===== include/linux/compat.h 1.21 vs edited =====
--- 1.21/include/linux/compat.h	Sat Apr  3 22:03:56 2004
+++ edited/include/linux/compat.h	Thu Apr 15 17:08:12 2004
@@ -123,5 +123,8 @@
 asmlinkage ssize_t compat_sys_writev(unsigned long fd,
 		const struct compat_iovec __user *vec, unsigned long vlen);
 
+int compat_do_execve(char * filename, compat_uptr_t __user *argv,
+	        compat_uptr_t __user *envp, struct pt_regs * regs);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */

