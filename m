Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSHOPrB>; Thu, 15 Aug 2002 11:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSHOPrA>; Thu, 15 Aug 2002 11:47:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33806 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317232AbSHOPqx>;
	Thu, 15 Aug 2002 11:46:53 -0400
Date: Thu, 15 Aug 2002 16:50:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more upward-growing-stack changes
Message-ID: <20020815165048.C29958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 - remove elf_caddr_t.  It's positively dangerous to #define this since
   elf_caddr_t foo, bar; creates variables of different types (foo is
   char *, bar is char).
 - rewrite large chunks of create_elf_tables(), it needed cleaning anyway.
 - add upwards-growing stack support to create_elf_tables.
 - redefine the ARCH_DLINFO stuff on powerpc -- it's tested, works.
 - add upwards-growing-stack support to exec.c too.

diff -urpNX dontdiff linux-2.5.31/arch/mips/kernel/irixelf.c linux-2.5.31-willy/arch/mips/kernel/irixelf.c
--- linux-2.5.31/arch/mips/kernel/irixelf.c	2002-08-01 14:16:27.000000000 -0700
+++ linux-2.5.31-willy/arch/mips/kernel/irixelf.c	2002-08-03 18:35:55.000000000 -0700
@@ -54,7 +54,6 @@ static struct linux_binfmt irix_format =
 
 #ifndef elf_addr_t
 #define elf_addr_t unsigned long
-#define elf_caddr_t char *
 #endif
 
 #ifdef DEBUG_ELF
@@ -155,8 +154,8 @@ unsigned long * create_irix_tables(char 
 				   unsigned int interp_load_addr,
 				   struct pt_regs *regs, struct elf_phdr *ephdr)
 {
-	elf_caddr_t *argv;
-	elf_caddr_t *envp;
+	elf_addr_t *argv;
+	elf_addr_t *envp;
 	elf_addr_t *sp, *csp;
 	
 #ifdef DEBUG_ELF
@@ -202,20 +201,20 @@ unsigned long * create_irix_tables(char 
 #undef NEW_AUX_ENT
 
 	sp -= envc+1;
-	envp = (elf_caddr_t *) sp;
+	envp = sp;
 	sp -= argc+1;
-	argv = (elf_caddr_t *) sp;
+	argv = sp;
 
 	__put_user((elf_addr_t)argc,--sp);
 	current->mm->arg_start = (unsigned long) p;
 	while (argc-->0) {
-		__put_user((elf_caddr_t)(unsigned long)p,argv++);
+		__put_user((unsigned long)p,argv++);
 		p += strlen_user(p);
 	}
 	__put_user(NULL, argv);
 	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
 	while (envc-->0) {
-		__put_user((elf_caddr_t)(unsigned long)p,envp++);
+		__put_user((unsigned long)p,envp++);
 		p += strlen_user(p);
 	}
 	__put_user(NULL, envp);
diff -urpNX dontdiff linux-2.5.31/arch/mips64/kernel/binfmt_elf32.c linux-2.5.31-willy/arch/mips64/kernel/binfmt_elf32.c
--- linux-2.5.31/arch/mips64/kernel/binfmt_elf32.c	2002-08-01 14:16:17.000000000 -0700
+++ linux-2.5.31-willy/arch/mips64/kernel/binfmt_elf32.c	2002-08-03 18:35:55.000000000 -0700
@@ -80,7 +80,6 @@ struct elf_prpsinfo32
 };
 
 #define elf_addr_t	u32
-#define elf_caddr_t	u32
 #define init_elf_binfmt init_elf32_binfmt
 #undef CONFIG_BINFMT_ELF
 #ifdef CONFIG_BINFMT_ELF32
diff -urpNX dontdiff linux-2.5.31/arch/s390x/kernel/binfmt_elf32.c linux-2.5.31-willy/arch/s390x/kernel/binfmt_elf32.c
--- linux-2.5.31/arch/s390x/kernel/binfmt_elf32.c	2002-08-01 14:16:25.000000000 -0700
+++ linux-2.5.31-willy/arch/s390x/kernel/binfmt_elf32.c	2002-08-03 18:35:55.000000000 -0700
@@ -166,7 +166,6 @@ struct elf_prpsinfo32
 #define NEW_TO_OLD_GID(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid) 
 
 #define elf_addr_t	u32
-#define elf_caddr_t	u32
 /*
 #define init_elf_binfmt init_elf32_binfmt
 */
diff -urpNX dontdiff linux-2.5.31/arch/sparc64/kernel/binfmt_elf32.c linux-2.5.31-willy/arch/sparc64/kernel/binfmt_elf32.c
--- linux-2.5.31/arch/sparc64/kernel/binfmt_elf32.c	2002-08-01 14:16:34.000000000 -0700
+++ linux-2.5.31-willy/arch/sparc64/kernel/binfmt_elf32.c	2002-08-03 18:35:55.000000000 -0700
@@ -147,7 +147,6 @@ jiffies_to_timeval32(unsigned long jiffi
 }
 
 #define elf_addr_t	u32
-#define elf_caddr_t	u32
 #undef start_thread
 #define start_thread start_thread32
 #define init_elf_binfmt init_elf32_binfmt
diff -urpNX dontdiff linux-2.5.31/arch/x86_64/ia32/ia32_binfmt.c linux-2.5.31-willy/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.5.31/arch/x86_64/ia32/ia32_binfmt.c	2002-08-01 14:16:04.000000000 -0700
+++ linux-2.5.31-willy/arch/x86_64/ia32/ia32_binfmt.c	2002-08-03 18:35:55.000000000 -0700
@@ -186,7 +186,6 @@ MODULE_AUTHOR("Eric Youngdale, Andi Klee
 #undef MODULE_AUTHOR
 
 #define elf_addr_t __u32
-#define elf_caddr_t __u32
 
 static void elf32_init(struct pt_regs *);
 
diff -urpNX dontdiff linux-2.5.31/fs/binfmt_elf.c linux-2.5.31-willy/fs/binfmt_elf.c
--- linux-2.5.31/fs/binfmt_elf.c	2002-08-01 14:16:23.000000000 -0700
+++ linux-2.5.31-willy/fs/binfmt_elf.c	2002-08-03 18:35:55.000000000 -0700
@@ -39,19 +39,15 @@
 #include <asm/param.h>
 #include <asm/pgalloc.h>
 
-#define DLINFO_ITEMS 13
-
 #include <linux/elf.h>
 
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
 static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
 extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
-extern void dump_thread(struct pt_regs *, struct user *);
 
 #ifndef elf_addr_t
 #define elf_addr_t unsigned long
-#define elf_caddr_t char *
 #endif
 
 /*
@@ -88,9 +84,9 @@ static void set_brk(unsigned long start,
 {
 	start = ELF_PAGEALIGN(start);
 	end = ELF_PAGEALIGN(end);
-	if (end <= start)
-		return;
-	do_brk(start, end - start);
+	if (end > start)
+		do_brk(start, end - start);
+	current->mm->start_brk = current->mm->brk = end;
 }
 
 
@@ -111,134 +107,149 @@ static void padzero(unsigned long elf_bs
 	}
 }
 
-static elf_addr_t * 
-create_elf_tables(char *p, int argc, int envc,
-		  struct elfhdr * exec,
-		  unsigned long load_addr,
-		  unsigned long load_bias,
-		  unsigned long interp_load_addr, int ibcs)
+/* Let's use some macros to make this stack manipulation a litle clearer */
+#ifdef ARCH_STACK_GROWSUP
+#define STACK_ADD(sp, items) ((elf_addr_t *)(sp) + (items))
+#define STACK_ROUND(sp, items) \
+	((15 + (unsigned long) ((sp) + (items))) &~ 15UL)
+#define STACK_ALLOC(sp, len) ({ elf_addr_t old_sp = sp; sp += len; old_sp; })
+#else
+#define STACK_ADD(sp, items) ((elf_addr_t *)(sp) - (items))
+#define STACK_ROUND(sp, items) \
+	(((unsigned long) (sp - items)) &~ 15UL)
+#define STACK_ALLOC(sp, len) sp -= len
+#endif
+
+static void
+create_elf_tables(struct linux_binprm *bprm, struct elfhdr * exec,
+		int interp_aout, unsigned long load_addr,
+		unsigned long interp_load_addr)
 {
-	elf_caddr_t *argv;
-	elf_caddr_t *envp;
-	elf_addr_t *sp, *csp;
-	char *k_platform, *u_platform;
-	long hwcap;
-	size_t platform_len = 0;
-	size_t len;
+	unsigned long p = bprm->p;
+	int argc = bprm->argc;
+	int envc = bprm->envc;
+	elf_addr_t *argv, *envp;
+	elf_addr_t *sp, u_platform;
+	const char *k_platform = ELF_PLATFORM;
+	int items;
+	elf_addr_t elf_info[30];
+	int ei_index = 0;
 
 	/*
-	 * Get hold of platform and hardware capabilities masks for
-	 * the machine we are running on.  In some cases (Sparc), 
-	 * this info is impossible to get, in others (i386) it is
+	 * If this architecture has a platform capability string, copy it
+	 * to userspace.  In some cases (Sparc), this info is impossible
+	 * for userspace to get any other way, in others (i386) it is
 	 * merely difficult.
 	 */
 
-	hwcap = ELF_HWCAP;
-	k_platform = ELF_PLATFORM;
-
 	if (k_platform) {
-		platform_len = strlen(k_platform) + 1;
-		u_platform = p - platform_len;
-		__copy_to_user(u_platform, k_platform, platform_len);
-	} else
-		u_platform = p;
+		size_t len = strlen(k_platform) + 1;
 
 #if defined(__i386__) && defined(CONFIG_SMP)
-	/*
-	 * In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
-	 * by the processes running on the same package. One thing we can do
-	 * is to shuffle the initial stack for them.
-	 *
-	 * The conditionals here are unneeded, but kept in to make the
-	 * code behaviour the same as pre change unless we have hyperthreaded
-	 * processors. This should be cleaned up before 2.6
-	 */
+		/*
+		 * In some cases (e.g. Hyper-Threading), we want to avoid L1
+		 * evictions by the processes running on the same package. One
+		 * thing we can do is to shuffle the initial stack for them.
+		 *
+		 * The conditionals here are unneeded, but kept in to make the
+		 * code behaviour the same as pre change unless we have
+		 * hyperthreaded processors. This should be cleaned up
+		 * before 2.6
+		 */
 	 
-	if(smp_num_siblings > 1)
-		u_platform = u_platform - ((current->pid % 64) << 7);
-#endif	
-
-	/*
-	 * Force 16 byte _final_ alignment here for generality.
-	 */
-	sp = (elf_addr_t *)(~15UL & (unsigned long)(u_platform));
-	csp = sp;
-	csp -= (1+DLINFO_ITEMS)*2 + (k_platform ? 2 : 0);
-#ifdef DLINFO_ARCH_ITEMS
-	csp -= DLINFO_ARCH_ITEMS*2;
+		if (smp_num_siblings > 1)
+			STACK_ALLOC(p, ((current->pid % 64) << 7));
 #endif
-	csp -= envc+1;
-	csp -= argc+1;
-	csp -= (!ibcs ? 3 : 1);	/* argc itself */
-	if ((unsigned long)csp & 15UL)
-		sp -= ((unsigned long)csp & 15UL) / sizeof(*sp);
+		u_platform = STACK_ALLOC(p, len);
+		__copy_to_user((void *)u_platform, k_platform, len);
+	}
 
-	/*
-	 * Put the ELF interpreter info on the stack
-	 */
-#define NEW_AUX_ENT(nr, id, val) \
-	  __put_user ((id), sp+(nr*2)); \
-	  __put_user ((val), sp+(nr*2+1)); \
+	/* Create the ELF interpreter info */
+#define NEW_AUX_ENT(id, val) \
+	do { elf_info[ei_index++] = id; elf_info[ei_index++] = val; } while (0)
 
-	sp -= 2;
-	NEW_AUX_ENT(0, AT_NULL, 0);
-	if (k_platform) {
-		sp -= 2;
-		NEW_AUX_ENT(0, AT_PLATFORM, (elf_addr_t)(unsigned long) u_platform);
-	}
-	sp -= DLINFO_ITEMS*2;
-	NEW_AUX_ENT( 0, AT_HWCAP, hwcap);
-	NEW_AUX_ENT( 1, AT_PAGESZ, ELF_EXEC_PAGESIZE);
-	NEW_AUX_ENT( 2, AT_CLKTCK, CLOCKS_PER_SEC);
-	NEW_AUX_ENT( 3, AT_PHDR, load_addr + exec->e_phoff);
-	NEW_AUX_ENT( 4, AT_PHENT, sizeof (struct elf_phdr));
-	NEW_AUX_ENT( 5, AT_PHNUM, exec->e_phnum);
-	NEW_AUX_ENT( 6, AT_BASE, interp_load_addr);
-	NEW_AUX_ENT( 7, AT_FLAGS, 0);
-	NEW_AUX_ENT( 8, AT_ENTRY, load_bias + exec->e_entry);
-	NEW_AUX_ENT( 9, AT_UID, (elf_addr_t) current->uid);
-	NEW_AUX_ENT(10, AT_EUID, (elf_addr_t) current->euid);
-	NEW_AUX_ENT(11, AT_GID, (elf_addr_t) current->gid);
-	NEW_AUX_ENT(12, AT_EGID, (elf_addr_t) current->egid);
 #ifdef ARCH_DLINFO
 	/* 
-	 * ARCH_DLINFO must come last so platform specific code can enforce
-	 * special alignment requirements on the AUXV if necessary (eg. PPC).
+	 * ARCH_DLINFO must come first so PPC can do its special alignment of
+	 * AUXV.
 	 */
 	ARCH_DLINFO;
 #endif
+	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
+	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
+	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
+	NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
+	NEW_AUX_ENT(AT_PHENT, sizeof (struct elf_phdr));
+	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
+	NEW_AUX_ENT(AT_BASE, interp_load_addr);
+	NEW_AUX_ENT(AT_FLAGS, 0);
+	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
+	NEW_AUX_ENT(AT_UID, (elf_addr_t) current->uid);
+	NEW_AUX_ENT(AT_EUID, (elf_addr_t) current->euid);
+	NEW_AUX_ENT(AT_GID, (elf_addr_t) current->gid);
+	NEW_AUX_ENT(AT_EGID, (elf_addr_t) current->egid);
+	if (k_platform) {
+		NEW_AUX_ENT(AT_PLATFORM, u_platform);
+	}
+	NEW_AUX_ENT(AT_NULL, 0);
 #undef NEW_AUX_ENT
 
-	sp -= envc+1;
-	envp = (elf_caddr_t *) sp;
-	sp -= argc+1;
-	argv = (elf_caddr_t *) sp;
-	if (!ibcs) {
-		__put_user((elf_addr_t)(unsigned long) envp,--sp);
-		__put_user((elf_addr_t)(unsigned long) argv,--sp);
+	sp = STACK_ADD(p, ei_index);
+
+	items = (argc + 1) + (envc + 1);
+	if (interp_aout) {
+		items += 3; /* a.out interpreters require argv & envp too */
+	} else {
+		items += 1; /* ELF interpreters only put argc on the stack */
 	}
+	bprm->p = STACK_ROUND(sp, items);
+
+	/* Point sp at the lowest address on the stack */
+#ifdef ARCH_STACK_GROWSUP
+	sp = (elf_addr_t *)bprm->p - items - ei_index;
+	bprm->exec = (unsigned long) sp; /* XXX: PARISC HACK */
+#else
+	sp = (elf_addr_t *)bprm->p;
+#endif
 
-	__put_user((elf_addr_t)argc,--sp);
-	current->mm->arg_start = (unsigned long) p;
-	while (argc-->0) {
-		__put_user((elf_caddr_t)(unsigned long)p,argv++);
-		len = strnlen_user(p, PAGE_SIZE*MAX_ARG_PAGES);
+	/* Now, let's put argc (and argv, envp if appropriate) on the stack */
+	__put_user(argc, sp++);
+	if (interp_aout) {
+		argv = sp + 2;
+		envp = argv + argc + 1;
+		__put_user((elf_addr_t)argv, sp++);
+		__put_user((elf_addr_t)envp, sp++);
+	} else {
+		argv = sp;
+		envp = argv + argc + 1;
+	}
+
+	/* Populate argv and envp */
+	p = current->mm->arg_start;
+	while (argc-- > 0) {
+		size_t len;
+		__put_user((elf_addr_t)p, argv++);
+		len = strnlen_user((void *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return NULL;
+			return;
 		p += len;
 	}
 	__put_user(NULL, argv);
-	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
-	while (envc-->0) {
-		__put_user((elf_caddr_t)(unsigned long)p,envp++);
-		len = strnlen_user(p, PAGE_SIZE*MAX_ARG_PAGES);
+	current->mm->arg_end = current->mm->env_start = p;
+	while (envc-- > 0) {
+		size_t len;
+		__put_user((elf_addr_t)p, envp++);
+		len = strnlen_user((void *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
-			return NULL;
+			return;
 		p += len;
 	}
 	__put_user(NULL, envp);
-	current->mm->env_end = (unsigned long) p;
-	return sp;
+	current->mm->env_end = p;
+
+	/* Put the elf_info on the stack in the right place.  */
+	sp = (elf_addr_t *)envp + 1;
+	copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t));
 }
 
 #ifndef elf_map
@@ -438,7 +449,7 @@ static int load_elf_binary(struct linux_
 	unsigned char ibcs2_interpreter = 0;
 	unsigned long error;
 	struct elf_phdr * elf_ppnt, *elf_phdata;
-	unsigned long elf_bss, k, elf_brk;
+	unsigned long elf_bss, elf_brk;
 	int elf_exec_fileno;
 	int retval, i;
 	unsigned int size;
@@ -576,19 +587,15 @@ static int load_elf_binary(struct linux_
 	/* OK, we are done with that, now set up the arg stuff,
 	   and then start this sucker up */
 
-	if (!bprm->sh_bang) {
-		char * passed_p;
+	if ((!bprm->sh_bang) && (interpreter_type == INTERPRETER_AOUT)) {
+		char *passed_p = passed_fileno;
+		sprintf(passed_fileno, "%d", elf_exec_fileno);
 
-		if (interpreter_type == INTERPRETER_AOUT) {
-		  sprintf(passed_fileno, "%d", elf_exec_fileno);
-		  passed_p = passed_fileno;
-
-		  if (elf_interpreter) {
-		    retval = copy_strings_kernel(1,&passed_p,bprm);
+		if (elf_interpreter) {
+			retval = copy_strings_kernel(1, &passed_p, bprm);
 			if (retval)
 				goto out_free_dentry; 
-		    bprm->argc++;
-		  }
+			bprm->argc++;
 		}
 	}
 
@@ -603,7 +610,10 @@ static int load_elf_binary(struct linux_
 	current->mm->end_code = 0;
 	current->mm->mmap = NULL;
 	current->flags &= ~PF_FORKNOEXEC;
-	elf_entry = (unsigned long) elf_ex.e_entry;
+
+	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
+	   may depend on the personality.  */
+	SET_PERSONALITY(elf_ex, ibcs2_interpreter);
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
@@ -623,7 +633,7 @@ static int load_elf_binary(struct linux_
 
 	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
-		unsigned long vaddr;
+		unsigned long k, vaddr;
 
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
@@ -656,7 +666,7 @@ static int load_elf_binary(struct linux_
 		} else if (elf_ex.e_type == ET_DYN) {
 			/* Try and get dynamic programs out of the way of the default mmap
 			   base, as well as whatever program they might try to exec.  This
-		           is because the brk will follow the loader, and is not movable.  */
+			   is because the brk will follow the loader, and is not movable.  */
 			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
 		}
 
@@ -681,7 +691,7 @@ static int load_elf_binary(struct linux_
 
 		if (k > elf_bss)
 			elf_bss = k;
-		if ((elf_ppnt->p_flags & PF_X) && end_code <  k)
+		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
 			end_data = k;
@@ -690,7 +700,7 @@ static int load_elf_binary(struct linux_
 			elf_brk = k;
 	}
 
-	elf_entry += load_bias;
+	elf_ex.e_entry += load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -717,6 +727,8 @@ static int load_elf_binary(struct linux_
 			send_sig(SIGSEGV, current, 0);
 			return 0;
 		}
+	} else {
+		elf_entry = elf_ex.e_entry;
 	}
 
 	kfree(elf_phdata);
@@ -728,18 +740,11 @@ static int load_elf_binary(struct linux_
 
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
-	bprm->p = (unsigned long)
-	  create_elf_tables((char *)bprm->p,
-			bprm->argc,
-			bprm->envc,
-			&elf_ex,
-			load_addr, load_bias,
-			interp_load_addr,
-			(interpreter_type == INTERPRETER_AOUT ? 0 : 1));
+	create_elf_tables(bprm, &elf_ex, (interpreter_type == INTERPRETER_AOUT),
+			load_addr, interp_load_addr);
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
 		current->mm->arg_start += strlen(passed_fileno) + 1;
-	current->mm->start_brk = current->mm->brk = elf_brk;
 	current->mm->end_code = end_code;
 	current->mm->start_code = start_code;
 	current->mm->start_data = start_data;
diff -urpNX dontdiff linux-2.5.31/fs/exec.c linux-2.5.31-willy/fs/exec.c
--- linux-2.5.31/fs/exec.c	2002-08-13 19:54:01.000000000 -0700
+++ linux-2.5.31-willy/fs/exec.c	2002-08-14 06:46:59.000000000 -0700
@@ -328,9 +328,50 @@ int setup_arg_pages(struct linux_binprm 
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
+	struct mm_struct *mm = current->mm;
 	int i;
 
-	stack_base = STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
+#ifdef ARCH_STACK_GROWSUP
+	/* Move the argument and environment strings to the bottom of the
+	 * stack space.
+	 */
+	int offset, j;
+	char *to, *from;
+
+	/* Start by shifting all the pages down */
+	i = 0;
+	for (j = 0; j < MAX_ARG_PAGES; j++) {
+		struct page *page = bprm->page[j];
+		if (!page)
+			continue;
+		bprm->page[i++] = page;
+	}
+
+	/* Now move them within their pages */
+	offset = bprm->p % PAGE_SIZE;
+	to = kmap(bprm->page[0]);
+	for (j = 1; j < i; j++) {
+		memmove(to, to + offset, PAGE_SIZE - offset);
+		from = kmap(bprm->page[j]);
+		memcpy(to + PAGE_SIZE - offset, from, offset);
+		kunmap(bprm[j - 1]);
+		to = from;
+	}
+	memmove(to, to + offset, PAGE_SIZE - offset);
+	kunmap(bprm[j - 1]);
+
+	/* Adjust bprm->p to point to the end of the strings. */
+	bprm->p = PAGE_SIZE * i - offset;
+	stack_base = STACK_TOP - current->rlim[RLIMIT_STACK].rlim_max;
+	mm->arg_start = stack_base;
+
+	/* zero pages that were copied above */
+	while (i < MAX_ARG_PAGES)
+		bprm->page[i++] = NULL;
+#else
+	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
+	mm->arg_start = bprm->p + stack_base;
+#endif
 
 	bprm->p += stack_base;
 	if (bprm->loader)
@@ -338,7 +379,7 @@ int setup_arg_pages(struct linux_binprm 
 	bprm->exec += stack_base;
 
 	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (!mpnt) 
+	if (!mpnt)
 		return -ENOMEM;
 
 	if (!vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
@@ -346,19 +387,25 @@ int setup_arg_pages(struct linux_binprm 
 		return -ENOMEM;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 	{
-		mpnt->vm_mm = current->mm;
+		mpnt->vm_mm = mm;
+#ifdef ARCH_STACK_GROWSUP
+		mpnt->vm_start = stack_base;
+		mpnt->vm_end = PAGE_MASK &
+			(PAGE_SIZE - 1 + (unsigned long) bprm->p);
+#else
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = STACK_TOP;
+#endif
 		mpnt->vm_page_prot = PAGE_COPY;
 		mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
 		mpnt->vm_private_data = (void *) 0;
-		insert_vm_struct(current->mm, mpnt);
-		current->mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+		insert_vm_struct(mm, mpnt);
+		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 	} 
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
@@ -369,7 +416,7 @@ int setup_arg_pages(struct linux_binprm 
 		}
 		stack_base += PAGE_SIZE;
 	}
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 	
 	return 0;
 }
@@ -737,7 +784,6 @@ void compute_creds(struct linux_binprm *
 	security_ops->bprm_compute_creds(bprm);
 }
 
-
 void remove_arg_zero(struct linux_binprm *bprm)
 {
 	if (bprm->argc) {
@@ -859,7 +905,6 @@ int search_binary_handler(struct linux_b
 	return retval;
 }
 
-
 /*
  * sys_execve() executes a new program.
  */
diff -urpNX dontdiff linux-2.5.31/include/asm-ia64/ia32.h linux-2.5.31-willy/include/asm-ia64/ia32.h
--- linux-2.5.31/include/asm-ia64/ia32.h	2002-08-01 14:16:45.000000000 -0700
+++ linux-2.5.31-willy/include/asm-ia64/ia32.h	2002-08-03 18:35:55.000000000 -0700
@@ -334,7 +334,6 @@ void ia64_elf32_init(struct pt_regs *reg
 #define ELF_PLAT_INIT(_r)	ia64_elf32_init(_r)
 
 #define elf_addr_t	u32
-#define elf_caddr_t	u32
 
 /* ELF register definitions.  This is needed for core dump support.  */
 
diff -urpNX dontdiff linux-2.5.31/include/asm-mips64/elf.h linux-2.5.31-willy/include/asm-mips64/elf.h
--- linux-2.5.31/include/asm-mips64/elf.h	2002-08-01 14:16:03.000000000 -0700
+++ linux-2.5.31-willy/include/asm-mips64/elf.h	2002-08-03 18:35:55.000000000 -0700
@@ -31,7 +31,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
-	if (sizeof(elf_caddr_t) == 8 &&					\
+	if (sizeof(elf_addr_t) == 8 &&					\
 	    __h->e_ident[EI_CLASS] == ELFCLASS32)			\
 	        __res = 0;						\
 									\
diff -urpNX dontdiff linux-2.5.31/include/asm-ppc/elf.h linux-2.5.31-willy/include/asm-ppc/elf.h
--- linux-2.5.31/include/asm-ppc/elf.h	2002-08-01 14:16:01.000000000 -0700
+++ linux-2.5.31-willy/include/asm-ppc/elf.h	2002-08-03 18:35:55.000000000 -0700
@@ -98,19 +98,14 @@ extern int ucache_bsize;
  * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
  *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
  */
-#define DLINFO_ARCH_ITEMS	3
 #define ARCH_DLINFO							\
 do {									\
-	sp -= DLINFO_ARCH_ITEMS * 2;					\
-	NEW_AUX_ENT(0, AT_DCACHEBSIZE, dcache_bsize);			\
-	NEW_AUX_ENT(1, AT_ICACHEBSIZE, icache_bsize);			\
-	NEW_AUX_ENT(2, AT_UCACHEBSIZE, ucache_bsize);			\
-	/*								\
-	 * Now handle glibc compatibility.				\
-	 */								\
-	sp -= 2*2;							\
-	NEW_AUX_ENT(0, AT_IGNOREPPC, AT_IGNOREPPC);			\
-	NEW_AUX_ENT(1, AT_IGNOREPPC, AT_IGNOREPPC);			\
+	NEW_AUX_ENT(AT_DCACHEBSIZE, dcache_bsize);			\
+	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
+	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
+	/* Now handle glibc compatibility. */				\
+	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
+	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
  } while (0)
 
 #endif /* __KERNEL__ */
diff -urpNX dontdiff linux-2.5.31/include/asm-ppc64/elf.h linux-2.5.31-willy/include/asm-ppc64/elf.h
--- linux-2.5.31/include/asm-ppc64/elf.h	2002-08-01 14:16:32.000000000 -0700
+++ linux-2.5.31-willy/include/asm-ppc64/elf.h	2002-08-03 18:35:55.000000000 -0700
@@ -31,13 +31,11 @@ typedef elf_greg_t32 elf_gregset_t32[ELF
   typedef elf_greg_t64 elf_greg_t;
   typedef elf_gregset_t64 elf_gregset_t;
 # define elf_addr_t unsigned long
-# define elf_caddr_t char *
 #else
   /* Assumption: ELF_ARCH == EM_PPC and ELF_CLASS == ELFCLASS32 */
   typedef elf_greg_t32 elf_greg_t;
   typedef elf_gregset_t32 elf_gregset_t;
 # define elf_addr_t u32
-# define elf_caddr_t u32
 #endif
 
 typedef double elf_fpreg_t;
@@ -122,19 +120,14 @@ extern int ucache_bsize;
  * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
  *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
  */
-#define DLINFO_ARCH_ITEMS	3
 #define ARCH_DLINFO							\
 do {									\
-	sp -= DLINFO_ARCH_ITEMS * 2;					\
-	NEW_AUX_ENT(0, AT_DCACHEBSIZE, dcache_bsize);			\
-	NEW_AUX_ENT(1, AT_ICACHEBSIZE, icache_bsize);			\
-	NEW_AUX_ENT(2, AT_UCACHEBSIZE, ucache_bsize);			\
-	/*								\
-	 * Now handle glibc compatibility.				\
-	 */								\
-	sp -= 2*2;							\
-	NEW_AUX_ENT(0, AT_IGNOREPPC, AT_IGNOREPPC);			\
-	NEW_AUX_ENT(1, AT_IGNOREPPC, AT_IGNOREPPC);			\
+	NEW_AUX_ENT(AT_DCACHEBSIZE, dcache_bsize);			\
+	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
+	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
+	/* Now handle glibc compatibility. */				\
+	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
+	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
  } while (0)
 
 #endif /* __PPC64_ELF_H */

-- 
Revolutions do not require corporate support.
