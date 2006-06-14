Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWFNO6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWFNO6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWFNO6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:58:47 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:1934 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751146AbWFNO6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:58:46 -0400
Subject: [RFC][PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 16:58:42 +0200
Message-Id: <1150297122.31522.54.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Some folks find 128KB of env+arg space too little. Solaris provides them with
1MB. Manually changing MAX_ARG_PAGES worked for them so far, however they
would like to run the supported vendor kernel.

In the interrest of not penalizing everybody with the overhead of just
setting it larger, provide a sysctl to change it.

Compiles and boots on i386.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

---
 arch/ia64/ia32/binfmt_elf32.c  |    4 +--
 arch/mips/kernel/sysirix.c     |    2 -
 arch/x86_64/ia32/ia32_binfmt.c |    4 +--
 fs/binfmt_elf.c                |   10 +++++----
 fs/binfmt_elf_fdpic.c          |   15 +++++++------
 fs/binfmt_flat.c               |    2 -
 fs/compat.c                    |   18 +++++++++++++---
 fs/exec.c                      |   44 +++++++++++++++++++++++++++++------------
 include/linux/binfmts.h        |   14 ++++---------
 include/linux/sysctl.h         |    1 
 kernel/sysctl.c                |   14 +++++++++++++
 11 files changed, 86 insertions(+), 42 deletions(-)

Index: linux-2.6/fs/binfmt_elf.c
===================================================================
--- linux-2.6.orig/fs/binfmt_elf.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/fs/binfmt_elf.c	2006-06-14 16:00:36.000000000 +0200
@@ -255,8 +255,9 @@ create_elf_tables(struct linux_binprm *b
 	while (argc-- > 0) {
 		size_t len;
 		__put_user((elf_addr_t)p, argv++);
-		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
-		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
+		len = strnlen_user((void __user *)p,
+				PAGE_SIZE*bprm->max_arg_pages);
+		if (!len || len > PAGE_SIZE*bprm->max_arg_pages)
 			return 0;
 		p += len;
 	}
@@ -266,8 +267,9 @@ create_elf_tables(struct linux_binprm *b
 	while (envc-- > 0) {
 		size_t len;
 		__put_user((elf_addr_t)p, envp++);
-		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
-		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
+		len = strnlen_user((void __user *)p,
+				PAGE_SIZE*bprm->max_arg_pages);
+		if (!len || len > PAGE_SIZE*bprm->max_arg_pages)
 			return 0;
 		p += len;
 	}
Index: linux-2.6/fs/binfmt_elf_fdpic.c
===================================================================
--- linux-2.6.orig/fs/binfmt_elf_fdpic.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/fs/binfmt_elf_fdpic.c	2006-06-14 16:00:36.000000000 +0200
@@ -578,14 +578,15 @@ static int create_elf_fdpic_tables(struc
 #ifdef CONFIG_MMU
 	current->mm->arg_start = bprm->p;
 #else
-	current->mm->arg_start = current->mm->start_stack - (MAX_ARG_PAGES * PAGE_SIZE - bprm->p);
+	current->mm->arg_start = current->mm->start_stack -
+		(bprm->max_arg_pages * PAGE_SIZE - bprm->p);
 #endif
 
 	p = (char *) current->mm->arg_start;
 	for (loop = bprm->argc; loop > 0; loop--) {
 		__put_user((elf_caddr_t) p, argv++);
-		len = strnlen_user(p, PAGE_SIZE * MAX_ARG_PAGES);
-		if (!len || len > PAGE_SIZE * MAX_ARG_PAGES)
+		len = strnlen_user(p, PAGE_SIZE * bprm->max_arg_pages);
+		if (!len || len > PAGE_SIZE * bprm->max_arg_pages)
 			return -EINVAL;
 		p += len;
 	}
@@ -596,8 +597,8 @@ static int create_elf_fdpic_tables(struc
 	current->mm->env_start = (unsigned long) p;
 	for (loop = bprm->envc; loop > 0; loop--) {
 		__put_user((elf_caddr_t)(unsigned long) p, envp++);
-		len = strnlen_user(p, PAGE_SIZE * MAX_ARG_PAGES);
-		if (!len || len > PAGE_SIZE * MAX_ARG_PAGES)
+		len = strnlen_user(p, PAGE_SIZE * bprm->max_arg_pages);
+		if (!len || len > PAGE_SIZE * bprm->max_arg_pages)
 			return -EINVAL;
 		p += len;
 	}
@@ -623,7 +624,7 @@ static int elf_fdpic_transfer_args_to_st
 	stop = bprm->p >> PAGE_SHIFT;
 	sp = *_sp;
 
-	for (index = MAX_ARG_PAGES - 1; index >= stop; index--) {
+	for (index = bprm->max_arg_pages - 1; index >= stop; index--) {
 		src = kmap(bprm->page[index]);
 		sp -= PAGE_SIZE;
 		if (copy_to_user((void *) sp, src, PAGE_SIZE) != 0)
@@ -633,7 +634,7 @@ static int elf_fdpic_transfer_args_to_st
 			goto out;
 	}
 
-	*_sp = (*_sp - (MAX_ARG_PAGES * PAGE_SIZE - bprm->p)) & ~15;
+	*_sp = (*_sp - (bprm->max_arg_pages * PAGE_SIZE - bprm->p)) & ~15;
 
  out:
 	return ret;
Index: linux-2.6/fs/binfmt_flat.c
===================================================================
--- linux-2.6.orig/fs/binfmt_flat.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/fs/binfmt_flat.c	2006-06-14 16:00:36.000000000 +0200
@@ -840,7 +840,7 @@ static int load_flat_binary(struct linux
 	 * pedantic and include space for the argv/envp array as it may have
 	 * a lot of entries.
 	 */
-#define TOP_OF_ARGS (PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *))
+#define TOP_OF_ARGS (PAGE_SIZE * bprm->max_arg_pages - sizeof(void *))
 	stack_len = TOP_OF_ARGS - bprm->p;             /* the strings */
 	stack_len += (bprm->argc + 1) * sizeof(char *); /* the argv array */
 	stack_len += (bprm->envc + 1) * sizeof(char *); /* the envp array */
Index: linux-2.6/fs/compat.c
===================================================================
--- linux-2.6.orig/fs/compat.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/fs/compat.c	2006-06-14 16:04:11.000000000 +0200
@@ -1476,7 +1476,7 @@ static inline void free_arg_pages(struct
 {
 	int i;
 
-	for (i = 0; i < MAX_ARG_PAGES; i++) {
+	for (i = 0; i < bprm->max_arg_pages; i++) {
 		if (bprm->page[i])
 			__free_page(bprm->page[i]);
 		bprm->page[i] = NULL;
@@ -1504,14 +1504,20 @@ int compat_do_execve(char * filename,
 	if (!bprm)
 		goto out_ret;
 
+	bprm->max_arg_pages = max_arg_pages;
+	bprm->page = kzalloc(bprm->max_arg_pages*sizeof(struct page *),
+			GFP_KERNEL);
+	if (!bprm->page)
+		goto out_kfree;
+
 	file = open_exec(filename);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
-		goto out_kfree;
+		goto out_kfree_page;
 
 	sched_exec();
 
-	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	bprm->p = PAGE_SIZE*bprm->max_arg_pages-sizeof(void *);
 	bprm->file = file;
 	bprm->filename = filename;
 	bprm->interp = filename;
@@ -1560,13 +1566,14 @@ int compat_do_execve(char * filename,
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
+		kfree(bprm->page);
 		kfree(bprm);
 		return retval;
 	}
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
+	for (i = 0 ; i < bprm->max_arg_pages ; i++) {
 		struct page * page = bprm->page[i];
 		if (page)
 			__free_page(page);
@@ -1585,6 +1592,9 @@ out_file:
 		fput(bprm->file);
 	}
 
+out_kfree_page:
+	kfree(bprm->page);
+
 out_kfree:
 	kfree(bprm);
 
Index: linux-2.6/fs/exec.c
===================================================================
--- linux-2.6.orig/fs/exec.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/fs/exec.c	2006-06-14 16:03:43.000000000 +0200
@@ -64,6 +64,16 @@ int suid_dumpable = 0;
 EXPORT_SYMBOL(suid_dumpable);
 /* The maximal length of core_pattern is also specified in sysctl.c */
 
+/*
+ * MAX_ARG_PAGES defines the number of pages allocated for arguments
+ * and envelope for the new program. 32 should suffice, this gives
+ * a maximum env+arg of 128kB w/4KB pages!
+ */
+int max_arg_pages = 32;
+int max_arg_pages_min = 32;
+int max_arg_pages_max = PAGE_SIZE/sizeof(struct page *);
+EXPORT_SYMBOL(max_arg_pages);
+
 static struct linux_binfmt *formats;
 static DEFINE_RWLOCK(binfmt_lock);
 
@@ -355,7 +365,7 @@ int setup_arg_pages(struct linux_binprm 
 
 	/* Start by shifting all the pages down */
 	i = 0;
-	for (j = 0; j < MAX_ARG_PAGES; j++) {
+	for (j = 0; j < bprm->max_arg_pages; j++) {
 		struct page *page = bprm->page[j];
 		if (!page)
 			continue;
@@ -388,10 +398,11 @@ int setup_arg_pages(struct linux_binprm 
 	arg_size = i << PAGE_SHIFT;
 
 	/* zero pages that were copied above */
-	while (i < MAX_ARG_PAGES)
+	while (i < bprm->max_arg_pages)
 		bprm->page[i++] = NULL;
 #else
-	stack_base = arch_align_stack(stack_top - MAX_ARG_PAGES*PAGE_SIZE);
+	stack_base = arch_align_stack(stack_top -
+			bprm->max_arg_pages*PAGE_SIZE);
 	stack_base = PAGE_ALIGN(stack_base);
 	bprm->p += stack_base;
 	mm->arg_start = bprm->p;
@@ -439,7 +450,7 @@ int setup_arg_pages(struct linux_binprm 
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	}
 
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
+	for (i = 0 ; i < bprm->max_arg_pages ; i++) {
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
@@ -462,7 +473,7 @@ static inline void free_arg_pages(struct
 {
 	int i;
 
-	for (i = 0; i < MAX_ARG_PAGES; i++) {
+	for (i = 0; i < bprm->max_arg_pages; i++) {
 		if (bprm->page[i])
 			__free_page(bprm->page[i]);
 		bprm->page[i] = NULL;
@@ -1058,7 +1069,7 @@ int search_binary_handler(struct linux_b
 		fput(bprm->file);
 		bprm->file = NULL;
 
-	        loader = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	        loader = PAGE_SIZE*bprm->max_arg_pages-sizeof(void *);
 
 		file = open_exec("/sbin/loader");
 		retval = PTR_ERR(file);
@@ -1153,14 +1164,20 @@ int do_execve(char * filename,
 	if (!bprm)
 		goto out_ret;
 
+	bprm->max_arg_pages = max_arg_pages;
+	bprm->page = kzalloc(bprm->max_arg_pages*sizeof(struct page*),
+			GFP_KERNEL);
+	if (!bprm->page)
+		goto out_kfree;
+
 	file = open_exec(filename);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
-		goto out_kfree;
+		goto out_kfree_page;
 
 	sched_exec();
 
-	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
+	bprm->p = PAGE_SIZE*bprm->max_arg_pages-sizeof(void *);
 
 	bprm->file = file;
 	bprm->filename = filename;
@@ -1210,16 +1227,16 @@ int do_execve(char * filename,
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
+		kfree(bprm->page);
 		kfree(bprm);
 		return retval;
 	}
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page * page = bprm->page[i];
-		if (page)
-			__free_page(page);
+	for (i = 0; i < bprm->max_arg_pages; i++) {
+		if (bprm->page[i])
+			__free_page(bprm->page[i]);
 	}
 
 	if (bprm->security)
@@ -1235,6 +1252,9 @@ out_file:
 		fput(bprm->file);
 	}
 
+out_kfree_page:
+	kfree(bprm->page);
+
 out_kfree:
 	kfree(bprm);
 
Index: linux-2.6/include/linux/binfmts.h
===================================================================
--- linux-2.6.orig/include/linux/binfmts.h	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/include/linux/binfmts.h	2006-06-14 16:00:36.000000000 +0200
@@ -5,13 +5,6 @@
 
 struct pt_regs;
 
-/*
- * MAX_ARG_PAGES defines the number of pages allocated for arguments
- * and envelope for the new program. 32 should suffice, this gives
- * a maximum env+arg of 128kB w/4KB pages!
- */
-#define MAX_ARG_PAGES 32
-
 /* sizeof(linux_binprm->buf) */
 #define BINPRM_BUF_SIZE 128
 
@@ -20,9 +13,10 @@ struct pt_regs;
 /*
  * This structure is used to hold the arguments that are used when loading binaries.
  */
-struct linux_binprm{
+struct linux_binprm {
 	char buf[BINPRM_BUF_SIZE];
-	struct page *page[MAX_ARG_PAGES];
+	struct page **page;
+	int max_arg_pages;
 	struct mm_struct *mm;
 	unsigned long p; /* current top of mem */
 	int sh_bang;
@@ -40,6 +34,8 @@ struct linux_binprm{
 	unsigned long loader, exec;
 };
 
+extern int max_arg_pages;
+
 #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
 #define BINPRM_FLAGS_ENFORCE_NONDUMP (1 << BINPRM_FLAGS_ENFORCE_NONDUMP_BIT)
 
Index: linux-2.6/include/linux/sysctl.h
===================================================================
--- linux-2.6.orig/include/linux/sysctl.h	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/include/linux/sysctl.h	2006-06-14 16:00:36.000000000 +0200
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_MAX_ARG_PAGES=73, /* int: max env+arg in pages */
 };
 
 
Index: linux-2.6/kernel/sysctl.c
===================================================================
--- linux-2.6.orig/kernel/sysctl.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/kernel/sysctl.c	2006-06-14 16:00:36.000000000 +0200
@@ -131,6 +131,9 @@ extern int acct_parm[];
 extern int no_unaligned_warning;
 #endif
 
+extern int max_arg_pages;
+extern int max_arg_pages_min, max_arg_pages_max;
+
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -683,6 +686,17 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_MAX_ARG_PAGES,
+		.procname	= "max_arg_pages",
+		.data		= &max_arg_pages,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &max_arg_pages_min,
+		.extra2		= &max_arg_pages_max,
+	},
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.6/arch/ia64/ia32/binfmt_elf32.c
===================================================================
--- linux-2.6.orig/arch/ia64/ia32/binfmt_elf32.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/arch/ia64/ia32/binfmt_elf32.c	2006-06-14 16:00:36.000000000 +0200
@@ -207,7 +207,7 @@ ia32_setup_arg_pages (struct linux_binpr
 	struct mm_struct *mm = current->mm;
 	int i, ret;
 
-	stack_base = IA32_STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
+	stack_base = IA32_STACK_TOP - bprm->max_arg_pages*PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
 
 	bprm->p += stack_base;
@@ -242,7 +242,7 @@ ia32_setup_arg_pages (struct linux_binpr
 		current->mm->stack_vm = current->mm->total_vm = vma_pages(mpnt);
 	}
 
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
+	for (i = 0 ; i < bprm->max_arg_pages ; i++) {
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
Index: linux-2.6/arch/mips/kernel/sysirix.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/sysirix.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/arch/mips/kernel/sysirix.c	2006-06-14 16:16:12.000000000 +0200
@@ -344,7 +344,7 @@ asmlinkage int irix_syssgi(struct pt_reg
 	case SGI_SYSCONF: {
 		switch(regs->regs[base + 5]) {
 		case 1:
-			retval = (MAX_ARG_PAGES >> 4); /* XXX estimate... */
+			retval = (max_arg_pages >> 4); /* XXX estimate... */
 			goto out;
 		case 2:
 			retval = max_threads;
Index: linux-2.6/arch/x86_64/ia32/ia32_binfmt.c
===================================================================
--- linux-2.6.orig/arch/x86_64/ia32/ia32_binfmt.c	2006-06-14 15:56:40.000000000 +0200
+++ linux-2.6/arch/x86_64/ia32/ia32_binfmt.c	2006-06-14 16:00:36.000000000 +0200
@@ -339,7 +339,7 @@ int ia32_setup_arg_pages(struct linux_bi
 	struct mm_struct *mm = current->mm;
 	int i, ret;
 
-	stack_base = stack_top - MAX_ARG_PAGES * PAGE_SIZE;
+	stack_base = stack_top - bprm->max_arg_pages * PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
 
 	bprm->p += stack_base;
@@ -374,7 +374,7 @@ int ia32_setup_arg_pages(struct linux_bi
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	} 
 
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
+	for (i = 0 ; i < bprm->max_arg_pages ; i++) {
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;


