Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbUAEUlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUAEUlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:41:09 -0500
Received: from APastourelles-108-2-1-3.w80-14.abo.wanadoo.fr ([80.14.139.3]:2964
	"EHLO mail.two-towers.net") by vger.kernel.org with ESMTP
	id S265300AbUAEUhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:37:02 -0500
Message-ID: <3FF9CAE4.7030001@two-towers.net>
Date: Mon, 05 Jan 2004 21:36:52 +0100
From: Philip Dodd <spambox@two-towers.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 and exec-shield-2.4.23-G4
Content-Type: multipart/mixed;
 boundary="------------030703040802050608080407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030703040802050608080407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Just a quick query - I rebuilt the kernel on one of the machines here 
and I was running the previous 2.4.23 with Ingo's exec-shield patch.  I 
got the same patch (2.4.23-G4) to apply pretty easily (the mmremap hunk 
applied with an offset, only the makefile failed, patched by hand) and 
was just wondering if it is reasonable to assume the mmremap patch in 
2.4.24 won't impact the exec-shield patch.  The patch in question is 
attached here.

I'm a bit of a neopyhte, but a quick look through the code didn't 
suggest that it would have any leathal effect.  Am I wrong and will my 
PC catch fire overnight because of this? :-D

Thanks in advance,

Phil

-- 
()  ascii ribbon campaign - against html mail
/\                        - against microsoft attachments

--------------030703040802050608080407
Content-Type: text/plain;
 name="exec-shield-2.4.23-G4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="exec-shield-2.4.23-G4"

--- linux/fs/proc/array.c.orig	
+++ linux/fs/proc/array.c	
@@ -202,6 +202,7 @@ static inline char * task_mem(struct mm_
 		}
 	}
 	buffer += sprintf(buffer,
+		"ExecLim:\t%08lx kB\n"
 		"VmSize:\t%8lu kB\n"
 		"VmLck:\t%8lu kB\n"
 		"VmRSS:\t%8lu kB\n"
@@ -209,6 +210,7 @@ static inline char * task_mem(struct mm_
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
 		"VmLib:\t%8lu kB\n",
+		mm->context.exec_limit,
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
@@ -333,7 +335,10 @@ int proc_pid_stat(struct task_struct *ta
 		up_read(&mm->mmap_sem);
 	}
 
-	wchan = get_wchan(task);
+	wchan = 0;
+	if (current->uid == task->uid || current->euid == task->uid ||
+							capable(CAP_SYS_NICE))
+		wchan = get_wchan(task);
 
 	collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
--- linux/fs/proc/base.c.orig	
+++ linux/fs/proc/base.c	
@@ -613,7 +613,7 @@ static struct pid_entry base_stuff[] = {
 #ifdef CONFIG_SMP
   E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
 #endif
-  E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
+  E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUSR),
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
   E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),
--- linux/fs/binfmt_aout.c.orig	
+++ linux/fs/binfmt_aout.c	
@@ -407,7 +407,7 @@ beyond_if:
 
 	set_brk(current->mm->start_brk, current->mm->brk);
 
-	retval = setup_arg_pages(bprm); 
+	retval = setup_arg_pages(bprm, 1); 
 	if (retval < 0) { 
 		/* Someone check-me: is this error path enough? */ 
 		send_sig(SIGKILL, current, 0); 
--- linux/fs/binfmt_elf.c.orig	
+++ linux/fs/binfmt_elf.c	
@@ -44,7 +44,7 @@
 
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
-static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
+static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int, unsigned int);
 extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
 extern void dump_thread(struct pt_regs *, struct user *);
 
@@ -111,7 +111,8 @@ create_elf_tables(char *p, int argc, int
 		  struct elfhdr * exec,
 		  unsigned long load_addr,
 		  unsigned long load_bias,
-		  unsigned long interp_load_addr, int ibcs)
+		  unsigned long interp_load_addr, int ibcs,
+		  int exec_stack)
 {
 	elf_caddr_t *argv;
 	elf_caddr_t *envp;
@@ -138,26 +139,17 @@ create_elf_tables(char *p, int argc, int
 	} else
 		u_platform = p;
 
-#if defined(__i386__) && defined(CONFIG_SMP)
-	/*
-	 * In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
-	 * by the processes running on the same package. One thing we can do
-	 * is to shuffle the initial stack for them.
-	 *
-	 * The conditionals here are unneeded, but kept in to make the
-	 * code behaviour the same as pre change unless we have hyperthreaded
-	 * processors. This keeps Mr Marcelo Person happier but should be
-	 * removed for 2.5
-	 */
-	 
-	if(smp_num_siblings > 1)
-		u_platform = u_platform - ((current->pid % 64) << 7);
-#endif	
+#ifdef __HAVE_ARCH_ALIGN_STACK
+	sp = (void *)arch_align_stack((unsigned long)u_platform);
+#else
+	sp = (void *)u_platform;
+#endif
 
 	/*
 	 * Force 16 byte _final_ alignment here for generality.
 	 */
-	sp = (elf_addr_t *)(~15UL & (unsigned long)(u_platform));
+	sp = (elf_addr_t *)(~15UL & (unsigned long)sp);
+
 	csp = sp;
 	csp -= (1+DLINFO_ITEMS)*2 + (k_platform ? 2 : 0);
 #ifdef DLINFO_ARCH_ITEMS
@@ -239,14 +231,18 @@ create_elf_tables(char *p, int argc, int
 
 #ifndef elf_map
 
-static inline unsigned long
-elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+static unsigned long
+elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type, unsigned int total_size)
 {
 	unsigned long map_addr;
+	unsigned int size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
+
+	if (total_size)
+		size = total_size;
 
+	addr = ELF_PAGESTART(addr);
 	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
+	map_addr = do_mmap(filep, ELF_PAGESTART(addr), size, prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
 	up_write(&current->mm->mmap_sem);
 	return(map_addr);
@@ -254,6 +250,24 @@ elf_map (struct file *filep, unsigned lo
 
 #endif /* !elf_map */
 
+static inline unsigned long total_mapping_size(struct elf_phdr *cmds, int nr)
+{
+	int i, first_idx = -1, last_idx = -1;
+
+	for (i = 0; i < nr; i++)
+		if (cmds[i].p_type == PT_LOAD) {
+			last_idx = i;
+			if (first_idx == -1)
+				first_idx = i;
+		}
+
+	if (first_idx == -1)
+		return 0;
+
+	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
+				ELF_PAGESTART(cmds[first_idx].p_vaddr);
+}
+
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
@@ -269,6 +283,7 @@ static unsigned long load_elf_interp(str
 	int load_addr_set = 0;
 	unsigned long last_bss = 0, elf_bss = 0;
 	unsigned long error = ~0UL;
+	unsigned long total_size;
 	int retval, i, size;
 
 	/* First of all, some simple consistency checks */
@@ -303,6 +318,10 @@ static unsigned long load_elf_interp(str
 	if (retval < 0)
 		goto out_close;
 
+	total_size = total_mapping_size(elf_phdata, interp_elf_ex->e_phnum);
+	if (!total_size)
+		goto out_close;
+
 	eppnt = elf_phdata;
 	for (i=0; i<interp_elf_ex->e_phnum; i++, eppnt++) {
 	  if (eppnt->p_type == PT_LOAD) {
@@ -318,7 +337,8 @@ static unsigned long load_elf_interp(str
 	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
 	    	elf_type |= MAP_FIXED;
 
-	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
+	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type, total_size);
+	    total_size = 0;
 	    if (BAD_ADDR(map_addr))
 	    	goto out_close;
 
@@ -446,6 +466,8 @@ static int load_elf_binary(struct linux_
   	struct exec interp_ex;
 	char passed_fileno[6];
 	struct files_struct *files;
+	int exec_stack, relocexec, old_relocexec = current->flags & PF_RELOCEXEC;
+	unsigned long total_size;
 	
 	/* Get the exec-header */
 	elf_ex = *((struct elfhdr *) bprm->buf);
@@ -553,6 +575,30 @@ static int load_elf_binary(struct linux_
 		elf_ppnt++;
 	}
 
+	relocexec = 0;
+	exec_stack = 1;
+
+	if (current->personality == PER_LINUX)
+	switch (exec_shield) {
+	case 1:
+		elf_ppnt = elf_phdata;
+		for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
+			if (elf_ppnt->p_type == PT_GNU_STACK) {
+				if (!(elf_ppnt->p_flags & PF_X))
+					exec_stack = 0;
+				current->flags |= PF_RELOCEXEC;
+				relocexec = PF_RELOCEXEC;
+				break;
+			}
+		break;
+
+	case 2:
+		exec_stack = 0;
+		current->flags |= PF_RELOCEXEC;
+		relocexec = PF_RELOCEXEC;
+		break;
+	}
+
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
 		interpreter_type = INTERPRETER_ELF | INTERPRETER_AOUT;
@@ -605,6 +651,7 @@ static int load_elf_binary(struct linux_
 	retval = flush_old_exec(bprm);
 	if (retval)
 		goto out_free_dentry;
+	current->flags |= relocexec;
 
 	/* Discard our unneeded old files struct */
 	if (files) {
@@ -613,6 +660,15 @@ static int load_elf_binary(struct linux_
 		files = NULL;
 	}
 
+#ifdef CONFIG_X86
+	/*
+	 * In the exec-shield-disabled case turn off the CS limit
+	 * completely:
+	 */
+	if (!exec_shield)
+		arch_add_exec_range(current->mm, -1);
+#endif
+
 	/* OK, This is the point of no return */
 	current->mm->start_data = 0;
 	current->mm->end_data = 0;
@@ -624,7 +680,7 @@ static int load_elf_binary(struct linux_
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
 	current->mm->rss = 0;
-	retval = setup_arg_pages(bprm);
+	retval = setup_arg_pages(bprm, exec_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
 		return retval;
@@ -633,9 +689,17 @@ static int load_elf_binary(struct linux_
 	current->mm->start_stack = bprm->p;
 
 	/* Now we do a little grungy work by mmaping the ELF image into
-	   the correct location in memory.  At this point, we assume that
-	   the image should be loaded at fixed address, not at a variable
-	   address. */
+	   the correct location in memory.
+	 
+	   We first calculate the total mapping size, which the first
+	   mmap request uses - after that point we use MAP_FIXED to
+	   overmap the existing range. This ensures that a continuous
+	   VM region is allocated - even if VM addresses are randomized.
+	 */
+
+	total_size = total_mapping_size(elf_phdata, elf_ex.e_phnum);
+	if (!total_size)
+		goto out_free_dentry;
 
 	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
@@ -667,16 +731,13 @@ static int load_elf_binary(struct linux_
 		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
 
 		vaddr = elf_ppnt->p_vaddr;
-		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
+		if (elf_ex.e_type == ET_EXEC || load_addr_set)
 			elf_flags |= MAP_FIXED;
-		} else if (elf_ex.e_type == ET_DYN) {
-			/* Try and get dynamic programs out of the way of the default mmap
-			   base, as well as whatever program they might try to exec.  This
-		           is because the brk will follow the loader, and is not movable.  */
-			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
-		}
+		else if (elf_ex.e_type == ET_DYN)
+			load_bias = 0;
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
+		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags, total_size);
+		total_size = 0;
 		if (BAD_ADDR(error))
 			continue;
 
@@ -752,7 +813,8 @@ static int load_elf_binary(struct linux_
 			&elf_ex,
 			load_addr, load_bias,
 			interp_load_addr,
-			(interpreter_type == INTERPRETER_AOUT ? 0 : 1));
+			(interpreter_type == INTERPRETER_AOUT ? 0 : 1),
+			exec_stack);
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
 		current->mm->arg_start += strlen(passed_fileno) + 1;
@@ -770,6 +832,11 @@ static int load_elf_binary(struct linux_
 
 	padzero(elf_bss);
 
+#ifdef __HAVE_ARCH_RANDOMIZE_BRK
+	if (current->flags & PF_RELOCEXEC)
+		randomize_brk(elf_brk);
+#endif
+
 #if 0
 	printk("(start_brk) %lx\n" , (long) current->mm->start_brk);
 	printk("(end_code) %lx\n" , (long) current->mm->end_code);
@@ -829,6 +896,8 @@ out_free_fh:
 	}
 out_free_ph:
 	kfree(elf_phdata);
+	current->flags &= ~PF_RELOCEXEC;
+	current->flags |= old_relocexec;
 	goto out;
 }
 
--- linux/fs/binfmt_som.c.orig	
+++ linux/fs/binfmt_som.c	
@@ -250,7 +250,7 @@ do_load_som_binary(struct linux_binprm *
 
 	set_binfmt(&som_format);
 	compute_creds(bprm);
-	setup_arg_pages(bprm);
+	setup_arg_pages(bprm, 1);
 
 	create_som_tables(bprm);
 
--- linux/fs/exec.c.orig	
+++ linux/fs/exec.c	
@@ -323,14 +323,18 @@ out:
 	return;
 }
 
-int setup_arg_pages(struct linux_binprm *bprm)
+int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
 	int i;
 
+#ifdef __HAVE_ARCH_ALIGN_STACK
+	stack_base = arch_align_stack(STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE);
+	stack_base = PAGE_ALIGN(stack_base);
+#else
 	stack_base = STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
-
+#endif
 	bprm->p += stack_base;
 	if (bprm->loader)
 		bprm->loader += stack_base;
@@ -345,8 +349,11 @@ int setup_arg_pages(struct linux_binprm 
 		mpnt->vm_mm = current->mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = STACK_TOP;
-		mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_page_prot = protection_map[VM_STACK_FLAGS & 0x7];
+		if (executable_stack)
+			mpnt->vm_flags = VM_STACK_FLAGS | VM_MAYEXEC | VM_EXEC;
+		else
+			mpnt->vm_flags = (VM_STACK_FLAGS | VM_MAYEXEC) & ~VM_EXEC;
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
@@ -606,6 +613,7 @@ int flush_old_exec(struct linux_binprm *
 	}
 	current->comm[i] = '\0';
 
+	current->flags &= ~PF_RELOCEXEC;
 	flush_thread();
 
 	de_thread(current);
@@ -670,8 +678,13 @@ int prepare_binprm(struct linux_binprm *
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
+		if (mode & S_ISUID) {
 			bprm->e_uid = inode->i_uid;
+#ifdef __i386__
+			/* reset personality */
+			current->personality = PER_LINUX;
+#endif
+		}
 
 		/* Set-gid? */
 		/*
@@ -679,8 +692,13 @@ int prepare_binprm(struct linux_binprm *
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			bprm->e_gid = inode->i_gid;
+#ifdef __i386__
+			/* reset personality */
+			current->personality = PER_LINUX;
+#endif
+		}
 	}
 
 	/* We don't have VFS support for capabilities yet */
--- linux/kernel/signal.c.orig	
+++ linux/kernel/signal.c	
@@ -843,6 +843,32 @@ EXPORT_SYMBOL(send_sig_info);
 EXPORT_SYMBOL(block_all_signals);
 EXPORT_SYMBOL(unblock_all_signals);
 
+int print_fatal_signals = 0;
+
+void print_fatal_signal(struct pt_regs *regs, int signr)
+{
+	int i;
+	unsigned char insn;
+
+	printk("%s/%d: potentially unexpected fatal signal %d.\n",
+		current->comm, current->pid, signr);
+	printk("code at %08lx: ", regs->eip);
+	for (i = 0; i < 16; i++) {
+		__get_user(insn, (unsigned char *)(regs->eip + i));
+		printk("%02x ", insn);
+	}
+	printk("\n");
+	show_regs(regs);
+}
+
+static int __init setup_print_fatal_signals(char *str)
+{
+	get_option (&str, &print_fatal_signals);
+
+	return 1;
+}
+
+__setup("print-fatal-signals=", setup_print_fatal_signals);
 
 /*
  * System call entry points.
--- linux/kernel/sysctl.c.orig	
+++ linux/kernel/sysctl.c	
@@ -42,6 +42,7 @@
 
 /* External variables not in a header file. */
 extern int panic_timeout;
+extern int print_fatal_signals;
 extern int C_A_D;
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
 extern int sysctl_overcommit_memory;
@@ -56,6 +57,9 @@ extern int cad_pid;
 extern int laptop_mode;
 extern int block_dump;
 
+int exec_shield = 2;
+int exec_shield_randomize = 1;
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -178,6 +182,12 @@ static ctl_table kern_table[] = {
 	 0644, NULL, &proc_doutsstring, &sysctl_string},
 	{KERN_PANIC, "panic", &panic_timeout, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "print_fatal_signals", &print_fatal_signals, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "exec-shield", &exec_shield, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "exec-shield-randomize", &exec_shield_randomize, sizeof(int),
+	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_SETUID, "core_setuid_ok", &core_setuid_ok, sizeof(int),
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -233,6 +233,9 @@ static struct mm_struct * mm_init(struct
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
+#ifdef __HAVE_ARCH_MMAP_TOP
+	mm->mmap_top = mmap_top();
+#endif
 	mm->pgd = pgd_alloc(mm);
 	mm->def_flags = 0;
 	if (mm->pgd)
--- linux/mm/mmap.c.orig	
+++ linux/mm/mmap.c	
@@ -17,6 +17,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/desc.h>
 
 /*
  * WARNING: the debugging will use recursive algorithms so never enable this
@@ -329,6 +330,8 @@ static inline void __vma_link_file(struc
 static void __vma_link(struct mm_struct * mm, struct vm_area_struct * vma,  struct vm_area_struct * prev,
 		       rb_node_t ** rb_link, rb_node_t * rb_parent)
 {
+	if (vma->vm_flags & VM_EXEC)
+		arch_add_exec_range(mm, vma->vm_end);
 	__vma_link_list(mm, vma, prev, rb_parent);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	__vma_link_file(vma);
@@ -371,6 +374,11 @@ static int vma_merge(struct mm_struct * 
 			return 1;
 		}
 		spin_unlock(lock);
+		/*
+		 * Just extended 'prev':
+		 */
+		if (prev->vm_flags & VM_EXEC)
+			arch_add_exec_range(mm, prev->vm_end);
 		return 1;
 	}
 
@@ -422,7 +430,7 @@ unsigned long do_mmap_pgoff(struct file 
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
-	addr = get_unmapped_area(file, addr, len, pgoff, flags);
+	addr = get_unmapped_area(file, addr, len, pgoff, flags, prot & PROT_EXEC);
 	if (addr & ~PAGE_MASK)
 		return addr;
 
@@ -612,7 +620,7 @@ free_vma:
  * This function "knows" that -ENOMEM has the bits set.
  */
 #ifndef HAVE_ARCH_UNMAPPED_AREA
-static inline unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
+static inline unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags, unsigned long exec)
 {
 	struct vm_area_struct *vma;
 
@@ -638,10 +646,10 @@ static inline unsigned long arch_get_unm
 	}
 }
 #else
-extern unsigned long arch_get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+extern unsigned long arch_get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #endif	
 
-unsigned long get_unmapped_area(struct file *file, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
+unsigned long get_unmapped_area(struct file *file, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags, unsigned long exec)
 {
 	if (flags & MAP_FIXED) {
 		if (addr > TASK_SIZE - len)
@@ -654,7 +662,7 @@ unsigned long get_unmapped_area(struct f
 	if (file && file->f_op && file->f_op->get_unmapped_area)
 		return file->f_op->get_unmapped_area(file, addr, len, pgoff, flags);
 
-	return arch_get_unmapped_area(file, addr, len, pgoff, flags);
+	return arch_get_unmapped_area(file, addr, len, pgoff, flags, exec);
 }
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
@@ -801,17 +809,21 @@ static struct vm_area_struct * unmap_fix
 			area->vm_ops->close(area);
 		if (area->vm_file)
 			fput(area->vm_file);
+		if (area->vm_flags & VM_EXEC)
+			arch_remove_exec_range(mm, area->vm_end);
 		kmem_cache_free(vm_area_cachep, area);
 		return extra;
 	}
 
 	/* Work out to one of the ends. */
 	if (end == area->vm_end) {
+		unsigned long old_end = area->vm_end;
 		/*
 		 * here area isn't visible to the semaphore-less readers
 		 * so we don't need to update it under the spinlock.
 		 */
 		area->vm_end = addr;
+		arch_remove_exec_range(mm, old_end);
 		lock_vma_mappings(area);
 		spin_lock(&mm->page_table_lock);
 	} else if (addr == area->vm_start) {
@@ -1168,6 +1180,7 @@ void exit_mmap(struct mm_struct * mm)
 	clear_page_tables(mm, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
 
 	flush_tlb_mm(mm);
+	arch_flush_exec_range(mm);
 }
 
 /* Insert vm structure into process list sorted by address
--- linux/mm/mprotect.c.orig	
+++ linux/mm/mprotect.c	
@@ -96,6 +96,7 @@ static inline int mprotect_fixup_all(str
 {
 	struct vm_area_struct * prev = *pprev;
 	struct mm_struct * mm = vma->vm_mm;
+	int oldflags;
 
 	if (prev && prev->vm_end == vma->vm_start && can_vma_merge(prev, newflags) &&
 	    !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
@@ -103,6 +104,8 @@ static inline int mprotect_fixup_all(str
 		prev->vm_end = vma->vm_end;
 		__vma_unlink(mm, vma, prev);
 		spin_unlock(&mm->page_table_lock);
+		if (vma->vm_flags & VM_EXEC)
+			arch_add_exec_range(current->mm, vma->vm_end);
 
 		kmem_cache_free(vm_area_cachep, vma);
 		mm->map_count--;
@@ -111,8 +114,13 @@ static inline int mprotect_fixup_all(str
 	}
 
 	spin_lock(&mm->page_table_lock);
+	oldflags = vma->vm_flags;
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = prot;
+	if (oldflags & VM_EXEC)
+		arch_remove_exec_range(current->mm, vma->vm_end);
+	if (newflags & VM_EXEC)
+		arch_add_exec_range(current->mm, vma->vm_end);
 	spin_unlock(&mm->page_table_lock);
 
 	*pprev = vma;
@@ -125,15 +133,21 @@ static inline int mprotect_fixup_start(s
 	int newflags, pgprot_t prot)
 {
 	struct vm_area_struct * n, * prev = *pprev;
+	unsigned long prev_end;
 
 	*pprev = vma;
 
 	if (prev && prev->vm_end == vma->vm_start && can_vma_merge(prev, newflags) &&
 	    !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
 		spin_lock(&vma->vm_mm->page_table_lock);
+		prev_end = prev->vm_end;
 		prev->vm_end = end;
+		if (prev->vm_flags & VM_EXEC)
+			arch_remove_exec_range(current->mm, prev_end);
 		vma->vm_start = end;
 		spin_unlock(&vma->vm_mm->page_table_lock);
+		if (prev->vm_flags & VM_EXEC)
+			arch_add_exec_range(current->mm, prev->vm_end);
 
 		return 0;
 	}
@@ -156,6 +170,8 @@ static inline int mprotect_fixup_start(s
 	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
 	unlock_vma_mappings(vma);
+	if (vma->vm_flags & VM_EXEC)
+		arch_add_exec_range(current->mm, vma->vm_end);
 
 	return 0;
 }
@@ -185,6 +201,10 @@ static inline int mprotect_fixup_end(str
 	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
 	unlock_vma_mappings(vma);
+	if (n->vm_flags & VM_EXEC)
+		arch_add_exec_range(current->mm, n->vm_end);
+	if (vma->vm_flags & VM_EXEC)
+		arch_add_exec_range(current->mm, vma->vm_end);
 
 	*pprev = n;
 
@@ -196,6 +216,8 @@ static inline int mprotect_fixup_middle(
 	int newflags, pgprot_t prot)
 {
 	struct vm_area_struct * left, * right;
+	unsigned long prev_end;
+	int oldflags;
 
 	left = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!left)
@@ -223,13 +245,21 @@ static inline int mprotect_fixup_middle(
 	vma->vm_page_prot = prot;
 	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
+	oldflags = vma->vm_flags;
+	vma->vm_flags = newflags;
 	vma->vm_start = start;
+	prev_end = vma->vm_end;
 	vma->vm_end = end;
-	vma->vm_flags = newflags;
+	if (!(newflags & VM_EXEC))
+		arch_remove_exec_range(current->mm, prev_end);
+	if (newflags & VM_EXEC)
+		arch_add_exec_range(current->mm, end);
 	__insert_vm_struct(current->mm, left);
 	__insert_vm_struct(current->mm, right);
 	spin_unlock(&vma->vm_mm->page_table_lock);
 	unlock_vma_mappings(vma);
+	if (vma->vm_flags & VM_EXEC)
+		arch_add_exec_range(current->mm, vma->vm_end);
 
 	*pprev = right;
 
@@ -330,6 +360,8 @@ asmlinkage long sys_mprotect(unsigned lo
 
 		kmem_cache_free(vm_area_cachep, next);
 		prev->vm_mm->map_count--;
+		if (prev->vm_flags & VM_EXEC)
+			arch_add_exec_range(current->mm, prev->vm_end);
 	}
 out:
 	up_write(&current->mm->mmap_sem);
--- linux/mm/mremap.c.orig	
+++ linux/mm/mremap.c	
@@ -333,7 +333,7 @@ unsigned long do_mremap(unsigned long ad
 			if (vma->vm_flags & VM_SHARED)
 				map_flags |= MAP_SHARED;
 
-			new_addr = get_unmapped_area(vma->vm_file, 0, new_len, vma->vm_pgoff, map_flags);
+			new_addr = get_unmapped_area(vma->vm_file, 0, new_len, vma->vm_pgoff, map_flags, vma->vm_flags & VM_EXEC);
 			ret = new_addr;
 			if (new_addr & ~PAGE_MASK)
 				goto out;
--- linux/include/linux/apm_bios.h.orig	
+++ linux/include/linux/apm_bios.h	
@@ -21,8 +21,7 @@ typedef unsigned short	apm_eventinfo_t;
 
 #ifdef __KERNEL__
 
-#define APM_40		0x40
-#define APM_CS		(APM_40 + 8)
+#define APM_CS		(GDT_ENTRY_APMBIOS_BASE * 8)
 #define APM_CS_16	(APM_CS + 8)
 #define APM_DS		(APM_CS_16 + 8)
 
--- linux/include/linux/binfmts.h.orig	2000-12-31 20:10:17.000000000 +0100
+++ linux/include/linux/binfmts.h	
@@ -52,7 +52,7 @@ extern int prepare_binprm(struct linux_b
 extern void remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *,struct pt_regs *);
 extern int flush_old_exec(struct linux_binprm * bprm);
-extern int setup_arg_pages(struct linux_binprm * bprm);
+extern int setup_arg_pages(struct linux_binprm * bprm, int exec_stack);
 extern int copy_strings(int argc,char ** argv,struct linux_binprm *bprm); 
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
 extern void compute_creds(struct linux_binprm *binprm);
--- linux/include/linux/elf.h.orig	
+++ linux/include/linux/elf.h	
@@ -33,6 +33,9 @@ typedef __s64	Elf64_Sxword;
 #define PT_HIPROC  0x7fffffff
 #define PT_MIPS_REGINFO		0x70000000
 
+#define PT_LOOS		0x60000000
+#define PT_GNU_STACK	(PT_LOOS + 0x474e551)
+
 /* Flags in the e_flags field of the header */
 #define EF_MIPS_NOREORDER 0x00000001
 #define EF_MIPS_PIC       0x00000002
--- linux/include/linux/mm.h.orig	
+++ linux/include/linux/mm.h	
@@ -550,7 +550,7 @@ extern void __insert_vm_struct(struct mm
 extern void build_mmap_rb(struct mm_struct *);
 extern void exit_mmap(struct mm_struct *);
 
-extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
@@ -573,12 +573,16 @@ extern int do_munmap(struct mm_struct *,
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
+
+extern void arch_remove_exec_range(struct mm_struct *mm, unsigned long limit);
+
 static inline void __vma_unlink(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev)
 {
 	prev->vm_next = vma->vm_next;
 	rb_erase(&vma->vm_rb, &mm->mm_rb);
 	if (mm->mmap_cache == vma)
 		mm->mmap_cache = prev;
+	arch_remove_exec_range(mm, vma->vm_end);
 }
 
 static inline int can_vma_merge(struct vm_area_struct * vma, unsigned long vm_flags)
--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -28,6 +28,10 @@ extern unsigned long event;
 #include <linux/fs_struct.h>
 
 struct exec_domain;
+extern int exec_shield;
+extern int exec_shield_randomize;
+extern int print_fatal_signals;
+extern void print_fatal_signal(struct pt_regs *regs, int signr);
 
 /*
  * cloning flags:
@@ -207,6 +211,7 @@ struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	rb_root_t mm_rb;
 	struct vm_area_struct * mmap_cache;	/* last find_vma result */
+	unsigned long mmap_top;			/* top of mmap area */
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
@@ -433,6 +438,7 @@ struct task_struct {
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
 
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
+#define PF_RELOCEXEC	0x00400000	/* relocate shared libraries */
 
 /*
  * Ptrace flags
@@ -448,9 +454,9 @@ struct task_struct {
 
 /*
  * Limit the stack by to some sane default: root can always
- * increase this limit if needed..  8MB seems reasonable.
+ * increase this limit if needed..  10MB seems reasonable.
  */
-#define _STK_LIM	(8*1024*1024)
+#define _STK_LIM	(10*1024*1024)
 
 #define DEF_COUNTER	(10*HZ/100)	/* 100 ms time slice */
 #define MAX_COUNTER	(20*HZ/100)
--- linux/include/asm-i386/desc.h.orig	2001-08-21 14:26:23.000000000 +0200
+++ linux/include/asm-i386/desc.h	
@@ -2,63 +2,23 @@
 #define __ARCH_DESC_H
 
 #include <asm/ldt.h>
-
-/*
- * The layout of the GDT under Linux:
- *
- *   0 - null
- *   1 - not used
- *   2 - kernel code segment
- *   3 - kernel data segment
- *   4 - user code segment                  <-- new cacheline 
- *   5 - user data segment
- *   6 - not used
- *   7 - not used
- *   8 - APM BIOS support                   <-- new cacheline 
- *   9 - APM BIOS support
- *  10 - APM BIOS support
- *  11 - APM BIOS support
- *
- * The TSS+LDT descriptors are spread out a bit so that every CPU
- * has an exclusive cacheline for the per-CPU TSS and LDT:
- *
- *  12 - CPU#0 TSS                          <-- new cacheline 
- *  13 - CPU#0 LDT
- *  14 - not used 
- *  15 - not used 
- *  16 - CPU#1 TSS                          <-- new cacheline 
- *  17 - CPU#1 LDT
- *  18 - not used 
- *  19 - not used 
- *  ... NR_CPUS per-CPU TSS+LDT's if on SMP
- *
- * Entry into gdt where to find first TSS.
- */
-#define __FIRST_TSS_ENTRY 12
-#define __FIRST_LDT_ENTRY (__FIRST_TSS_ENTRY+1)
-
-#define __TSS(n) (((n)<<2) + __FIRST_TSS_ENTRY)
-#define __LDT(n) (((n)<<2) + __FIRST_LDT_ENTRY)
+#include <asm/segment.h>
 
 #ifndef __ASSEMBLY__
-struct desc_struct {
-	unsigned long a,b;
-};
 
-extern struct desc_struct gdt_table[];
-extern struct desc_struct *idt, *gdt;
+#include <asm/mmu.h>
+
+extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
 
 struct Xgt_desc_struct {
 	unsigned short size;
 	unsigned long address __attribute__((packed));
-};
-
-#define idt_descr (*(struct Xgt_desc_struct *)((char *)&idt - 2))
-#define gdt_descr (*(struct Xgt_desc_struct *)((char *)&gdt - 2))
+} __attribute__ ((packed));
 
-#define load_TR(n) __asm__ __volatile__("ltr %%ax"::"a" (__TSS(n)<<3))
+extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
 
-#define __load_LDT(n) __asm__ __volatile__("lldt %%ax"::"a" (__LDT(n)<<3))
+#define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (GDT_ENTRY_TSS*8))
+#define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (GDT_ENTRY_LDT*8))
 
 /*
  * This is the ldt that every process will get unless we need
@@ -66,14 +26,57 @@ struct Xgt_desc_struct {
  */
 extern struct desc_struct default_ldt[];
 extern void set_intr_gate(unsigned int irq, void * addr);
-extern void set_ldt_desc(unsigned int n, void *addr, unsigned int size);
-extern void set_tss_desc(unsigned int n, void *addr);
+
+#define _set_tssldt_desc(n,addr,limit,type) \
+__asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
+	"movw %%ax,2(%2)\n\t" \
+	"rorl $16,%%eax\n\t" \
+	"movb %%al,4(%2)\n\t" \
+	"movb %4,5(%2)\n\t" \
+	"movb $0,6(%2)\n\t" \
+	"movb %%ah,7(%2)\n\t" \
+	"rorl $16,%%eax" \
+	: "=m"(*(n)) : "a" (addr), "r"(n), "ir"(limit), "i"(type))
+
+static inline void set_tss_desc(unsigned int cpu, void *addr)
+{
+	_set_tssldt_desc(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (int)addr, 235, 0x89);
+}
+
+static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
+{
+	_set_tssldt_desc(&cpu_gdt_table[cpu][GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+}
+
+#define LDT_entry_a(info) \
+	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
+
+#define LDT_entry_b(info) \
+	(((info)->base_addr & 0xff000000) | \
+	(((info)->base_addr & 0x00ff0000) >> 16) | \
+	((info)->limit & 0xf0000) | \
+	(((info)->read_exec_only ^ 1) << 9) | \
+	((info)->contents << 10) | \
+	(((info)->seg_not_present ^ 1) << 15) | \
+	((info)->seg_32bit << 22) | \
+	((info)->limit_in_pages << 23) | \
+	((info)->useable << 20) | \
+	0x7000)
+
+#define LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0	)
 
 static inline void clear_LDT(void)
 {
-	int cpu = smp_processor_id();
-	set_ldt_desc(cpu, &default_ldt[0], 5);
-	__load_LDT(cpu);
+	set_ldt_desc(smp_processor_id(), &default_ldt[0], 5);
+	load_LDT_desc();
 }
 
 /*
@@ -81,7 +84,6 @@ static inline void clear_LDT(void)
  */
 static inline void load_LDT (struct mm_struct *mm)
 {
-	int cpu = smp_processor_id();
 	void *segments = mm->context.segments;
 	int count = LDT_ENTRIES;
 
@@ -90,8 +92,8 @@ static inline void load_LDT (struct mm_s
 		count = 5;
 	}
 		
-	set_ldt_desc(cpu, segments, count);
-	__load_LDT(cpu);
+	set_ldt_desc(smp_processor_id(), segments, count);
+	load_LDT_desc();
 }
 
 #endif /* !__ASSEMBLY__ */
--- linux/include/asm-i386/elf.h.orig	
+++ linux/include/asm-i386/elf.h	
@@ -98,7 +98,11 @@ typedef struct user_fxsr_struct elf_fpxr
 #define ELF_PLATFORM  (system_utsname.machine)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+/* child inherits the personality of the parent */
+#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 #endif
 
+#define __HAVE_ARCH_RANDOMIZE_BRK
+extern void randomize_brk(unsigned long old_brk);
+
 #endif
--- linux/include/asm-i386/mmu.h.orig	2001-08-21 14:26:23.000000000 +0200
+++ linux/include/asm-i386/mmu.h	
@@ -4,10 +4,15 @@
 /*
  * The i386 doesn't have a mmu context, but
  * we put the segment information here.
+ *
+ * exec_limit is used to track the range PROT_EXEC
+ * mappings span.
  */
 typedef struct { 
 	void *segments;
 	unsigned long cpuvalid;
+	struct desc_struct user_cs;
+	unsigned long exec_limit;
 } mm_context_t;
 
 #endif
--- linux/include/asm-i386/page.h.orig	
+++ linux/include/asm-i386/page.h	
@@ -131,10 +131,18 @@ static __inline__ int get_order(unsigned
 #define MAXMEM			((unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE))
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
+#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+#ifndef CONFIG_DISCONTIGMEM
+#define pfn_to_page(pfn)	(mem_map + (pfn))
+#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#endif /* !CONFIG_DISCONTIGMEM */
+#define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+#define VM_DATA_DEFAULT_FLAGS	\
+		(VM_READ | VM_WRITE | \
+			((current->flags & PF_RELOCEXEC) ? 0 : VM_EXEC) | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #endif /* __KERNEL__ */
--- linux/include/asm-i386/pgalloc.h.orig	
+++ linux/include/asm-i386/pgalloc.h	
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/fixmap.h>
+#include <asm/desc.h>
 #include <linux/threads.h>
 
 #define pgd_quicklist (current_cpu_data.pgd_quick)
@@ -235,4 +236,20 @@ static inline void flush_tlb_pgtables(st
 	flush_tlb_mm(mm);
 }
 
+static inline void set_user_cs(struct desc_struct *desc, unsigned long limit)
+{
+	limit = (limit - 1) / PAGE_SIZE;
+	desc->a = limit & 0xffff;
+	desc->b = (limit & 0xf0000) | 0x00c0fb00;
+}
+
+#define load_user_cs_desc(cpu, mm) \
+    	cpu_gdt_table[(cpu)][GDT_ENTRY_DEFAULT_USER_CS] = (mm)->context.user_cs
+
+extern void arch_add_exec_range(struct mm_struct *mm, unsigned long limit);
+extern void arch_remove_exec_range(struct mm_struct *mm, unsigned long limit);
+extern void arch_flush_exec_range(struct mm_struct *mm);
+
+#define HAVE_ARCH_UNMAPPED_AREA 1
+
 #endif /* _I386_PGALLOC_H */
--- linux/include/asm-i386/pgtable-2level.h.orig	
+++ linux/include/asm-i386/pgtable-2level.h	
@@ -60,6 +60,10 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		(mem_map+((unsigned long)(((x).pte_low >> PAGE_SHIFT))))
 #define pte_none(x)		(!(x).pte_low)
-#define __mk_pte(page_nr,pgprot) __pte(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
+#define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+
+#define __mk_pte(nr,prot)	pfn_pte(nr,prot)
 
 #endif /* _I386_PGTABLE_2LEVEL_H */
--- linux/include/asm-i386/pgtable-3level.h.orig	
+++ linux/include/asm-i386/pgtable-3level.h	
@@ -89,10 +89,12 @@ static inline int pte_same(pte_t a, pte_
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
 }
 
-#define pte_page(x)	(mem_map+(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT))))
+#define pte_page(x)	pfn_to_page(pte_pfn(x))
 #define pte_none(x)	(!(x).pte_low && !(x).pte_high)
+#define pte_pfn(x)	(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT)))
 
-static inline pte_t __mk_pte(unsigned long page_nr, pgprot_t pgprot)
+#define __mk_pte(nr,prot)	pfn_pte(nr,prot)
+static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
 	pte_t pte;
 
@@ -101,4 +103,11 @@ static inline pte_t __mk_pte(unsigned lo
 	return pte;
 }
 
+static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
+{
+	return __pmd(((unsigned long long)page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
+}
+
+extern struct kmem_cache_s *pae_pgd_cachep;
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
--- linux/include/asm-i386/processor.h.orig	
+++ linux/include/asm-i386/processor.h	
@@ -18,6 +18,15 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 
+struct desc_struct {
+	unsigned long a,b;
+};
+
+#define desc_empty(desc) \
+		(!((desc)->a + (desc)->b))
+
+#define desc_equal(desc1, desc2) \
+		(((desc1)->a == (desc2)->a) && ((desc1)->b == (desc2)->b))
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
@@ -264,7 +273,15 @@ extern unsigned int mca_pentium_flag;
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+#define TASK_UNMAPPED_BASE    PAGE_ALIGN(TASK_SIZE/3)
+
+#define SHLIB_BASE            0x00111000
+
+#define __HAVE_ARCH_ALIGN_STACK
+extern unsigned long arch_align_stack(unsigned long sp);
+
+#define __HAVE_ARCH_MMAP_TOP
+extern unsigned long mmap_top(void);
 
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
@@ -399,7 +416,7 @@ struct thread_struct {
 	0,0,0,0, /* esp,ebp,esi,edi */				\
 	0,0,0,0,0,0, /* es,cs,ss */				\
 	0,0,0,0,0,0, /* ds,fs,gs */				\
-	__LDT(0),0, /* ldt */					\
+	GDT_ENTRY_LDT,0, /* ldt */					\
 	0, INVALID_IO_BITMAP_OFFSET, /* tace, bitmap */		\
 	{~0, } /* ioperm */					\
 }
@@ -413,6 +430,7 @@ struct thread_struct {
 	regs->xcs = __USER_CS;					\
 	regs->eip = new_eip;					\
 	regs->esp = new_esp;					\
+	load_user_cs_desc(smp_processor_id(), current->mm);	\
 } while (0)
 
 /* Forward declaration, a strange C thing */
--- linux/include/asm-i386/segment.h.orig	1997-12-01 19:34:12.000000000 +0100
+++ linux/include/asm-i386/segment.h	
@@ -1,10 +1,79 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
 
-#define __KERNEL_CS	0x10
-#define __KERNEL_DS	0x18
+/*
+ * The layout of the per-CPU GDT under Linux:
+ *
+ *   0 - null
+ *   1 - reserved
+ *   2 - reserved
+ *   3 - reserved
+ *
+ *   4 - default user CS		<==== new cacheline
+ *   5 - default user DS
+ *
+ *  ------- start of TLS (Thread-Local Storage) segments:
+ *
+ *   6 - TLS segment #1			[ glibc's TLS segment ]
+ *   7 - TLS segment #2			[ Wine's %fs Win32 segment ]
+ *   8 - TLS segment #3
+ *   9 - reserved
+ *  10 - reserved
+ *  11 - reserved
+ *
+ *  ------- start of kernel segments:
+ *
+ *  12 - kernel code segment		<==== new cacheline
+ *  13 - kernel data segment
+ *  14 - TSS
+ *  15 - LDT
+ *  16 - PNPBIOS support (16->32 gate)
+ *  17 - PNPBIOS support
+ *  18 - PNPBIOS support
+ *  19 - PNPBIOS support
+ *  20 - PNPBIOS support
+ *  21 - APM BIOS support
+ *  22 - APM BIOS support
+ *  23 - APM BIOS support 
+ */
+#define GDT_ENTRY_TLS_ENTRIES	3
+#define GDT_ENTRY_TLS_MIN	6
+#define GDT_ENTRY_TLS_MAX 	(GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
 
-#define __USER_CS	0x23
-#define __USER_DS	0x2B
+#define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)
+
+#define GDT_ENTRY_DEFAULT_USER_CS	4
+#define __USER_CS (GDT_ENTRY_DEFAULT_USER_CS * 8 + 3)
+
+#define GDT_ENTRY_DEFAULT_USER_DS	5
+#define __USER_DS (GDT_ENTRY_DEFAULT_USER_DS * 8 + 3)
+
+#define GDT_ENTRY_KERNEL_BASE	12
+
+#define GDT_ENTRY_KERNEL_CS		(GDT_ENTRY_KERNEL_BASE + 0)
+#define __KERNEL_CS (GDT_ENTRY_KERNEL_CS * 8)
+
+#define GDT_ENTRY_KERNEL_DS		(GDT_ENTRY_KERNEL_BASE + 1)
+#define __KERNEL_DS (GDT_ENTRY_KERNEL_DS * 8)
+
+#define GDT_ENTRY_TSS			(GDT_ENTRY_KERNEL_BASE + 2)
+#define GDT_ENTRY_LDT			(GDT_ENTRY_KERNEL_BASE + 3)
+
+#define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 4)
+#define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 9)
+
+/*
+ * The GDT has 21 entries but we pad it to cacheline boundary:
+ */
+#define GDT_ENTRIES 24
+
+#define GDT_SIZE (GDT_ENTRIES * 8)
+
+/*
+ * The interrupt descriptor table has room for 256 idt's,
+ * the global descriptor table is dependent on the number
+ * of tasks we can have..
+ */
+#define IDT_ENTRIES 256
 
 #endif
--- linux/include/asm-i386/system.h.orig	
+++ linux/include/asm-i386/system.h	
@@ -58,6 +58,10 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 	 "0" (limit) \
         ); } while(0)
 
+struct desc_struct;
+
+extern void set_desc_limit(struct desc_struct *desc, unsigned long limit);
+
 #define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
 #define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1)>>12 )
 
--- linux/include/asm-i386/save_state.h.orig	
+++ linux/include/asm-i386/save_state.h	
@@ -112,10 +112,10 @@ static void fix_processor_context(void)
 	struct tss_struct * t = &init_tss[nr];
 
 	set_tss_desc(nr,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
-        gdt_table[__TSS(nr)].b &= 0xfffffdff;
+	cpu_gdt_table[nr][GDT_ENTRY_TSS].b &= 0xfffffdff;
 
-	load_TR(nr);		/* This does ltr */
-	__load_LDT(nr);		/* This does lldt */
+	load_TR_desc();			/* This does ltr */
+	load_LDT(&init_mm.context);	/* This does lldt */
 
 	/*
 	 * Now maybe reload the debug registers
--- linux/arch/i386/boot/setup.S.orig	
+++ linux/arch/i386/boot/setup.S	
@@ -1074,9 +1074,14 @@ delay:
 	ret
 
 # Descriptor tables
+#
+# NOTE: if you think the GDT is large, you can make it smaller by just
+# defining the KERNEL_CS and KERNEL_DS entries and shifting the gdt
+# address down by GDT_ENTRY_KERNEL_CS*8. This puts bogus entries into
+# the GDT, but those wont be used so it's not a problem.
+#
 gdt:
-	.word	0, 0, 0, 0			# dummy
-	.word	0, 0, 0, 0			# unused
+	.fill GDT_ENTRY_KERNEL_CS,8,0
 
 	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
 	.word	0				# base address = 0
--- linux/arch/i386/mm/fault.c.orig	
+++ linux/arch/i386/mm/fault.c	
@@ -24,6 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/hardirq.h>
+#include <asm/desc.h>
 
 extern void die(const char *,struct pt_regs *,long);
 
@@ -125,7 +126,6 @@ void bust_spinlocks(int yes)
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
-extern unsigned long idt;
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -286,7 +286,7 @@ bad_area:
 	if (boot_cpu_data.f00f_bug) {
 		unsigned long nr;
 		
-		nr = (address - idt) >> 3;
+		nr = (address - idt_descr.address) >> 3;
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
--- linux/arch/i386/kernel/apm.c.orig	
+++ linux/arch/i386/kernel/apm.c	
@@ -214,6 +214,7 @@
 #include <linux/sched.h>
 #include <linux/pm.h>
 #include <linux/kernel.h>
+#include <linux/smp.h>
 #include <linux/smp_lock.h>
 
 #include <asm/system.h>
@@ -418,6 +419,7 @@ static int			broken_psr;
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
+static struct desc_struct	bad_bios_desc = { 0, 0x00409200 };
 
 static char			driver_version[] = "1.16";	/* no spaces */
 
@@ -603,6 +605,7 @@ static u8 apm_bios_call(u32 func, u32 eb
 	APM_DECL_SEGS
 	unsigned long	flags;
 	unsigned long cpus = apm_save_cpus();
+	struct desc_struct	save_desc_40;
 	
 	__save_flags(flags);
 	APM_DO_CLI;
@@ -628,6 +631,8 @@ static u8 apm_bios_call(u32 func, u32 eb
 	
 	apm_restore_cpus(cpus);
 	
+	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
+	
 	return *eax & 0xff;
 }
 
@@ -649,9 +654,13 @@ static u8 apm_bios_call_simple(u32 func,
 {
 	u8		error;
 	APM_DECL_SEGS
-	unsigned long	flags;
-
+	unsigned long		flags;
+	int			cpu = smp_processor_id();
+	struct desc_struct	save_desc_40;
 	unsigned long cpus = apm_save_cpus();
+
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
 	
 	__save_flags(flags);
 	APM_DO_CLI;
@@ -681,6 +690,8 @@ static u8 apm_bios_call_simple(u32 func,
 
 	apm_restore_cpus(cpus);
 	
+	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
+	
 	return error;
 }
 
@@ -1187,6 +1198,11 @@ static void queue_event(apm_event_t even
 static void set_time(void)
 {
 	unsigned long	flags;
+	int			cpu = smp_processor_id();
+	struct desc_struct	save_desc_40;
+
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
 
 	if (got_clock_diff) {	/* Must know time zone in order to set clock */
 		save_flags(flags);
@@ -1910,6 +1926,8 @@ static struct miscdevice apm_device = {
  */
 static int __init apm_init(void)
 {
+	int i;
+
 	struct proc_dir_entry *apm_proc;
 
 	if (apm_info.bios.version == 0) {
@@ -1981,37 +1999,39 @@ static int __init apm_init(void)
 	 * This is for buggy BIOS's that refer to (real mode) segment 0x40
 	 * even though they are called in protected mode.
 	 */
-	set_base(gdt[APM_40 >> 3],
-		 __va((unsigned long)0x40 << 4));
-	_set_limit((char *)&gdt[APM_40 >> 3], 4095 - (0x40 << 4));
+	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
+	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
 
 	apm_bios_entry.offset = apm_info.bios.offset;
 	apm_bios_entry.segment = APM_CS;
-	set_base(gdt[APM_CS >> 3],
-		 __va((unsigned long)apm_info.bios.cseg << 4));
-	set_base(gdt[APM_CS_16 >> 3],
-		 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-	set_base(gdt[APM_DS >> 3],
-		 __va((unsigned long)apm_info.bios.dseg << 4));
+
+	for (i = 0; i < NR_CPUS; i++) {
+		set_base(cpu_gdt_table[i][APM_CS >> 3],
+			 __va((unsigned long)apm_info.bios.cseg << 4));
+		set_base(cpu_gdt_table[i][APM_CS_16 >> 3],
+			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
+		set_base(cpu_gdt_table[i][APM_DS >> 3],
+			 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
-	if (apm_info.bios.version == 0x100) {
+		if (apm_info.bios.version == 0x100) {
 #endif
-		/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
-		_set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 - 1);
-		/* For some unknown machine. */
-		_set_limit((char *)&gdt[APM_CS_16 >> 3], 64 * 1024 - 1);
-		/* For the DEC Hinote Ultra CT475 (and others?) */
-		_set_limit((char *)&gdt[APM_DS >> 3], 64 * 1024 - 1);
+			/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
+			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3], 64 * 1024 - 1);
+			/* For some unknown machine. */
+			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >> 3], 64 * 1024 - 1);
+			/* For the DEC Hinote Ultra CT475 (and others?) */
+			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3], 64 * 1024 - 1);
 #ifndef APM_RELAX_SEGMENTS
-	} else {
-		_set_limit((char *)&gdt[APM_CS >> 3],
-			(apm_info.bios.cseg_len - 1) & 0xffff);
-		_set_limit((char *)&gdt[APM_CS_16 >> 3],
-			(apm_info.bios.cseg_16_len - 1) & 0xffff);
-		_set_limit((char *)&gdt[APM_DS >> 3],
-			(apm_info.bios.dseg_len - 1) & 0xffff);
-	}
+		} else {
+			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3],
+				(apm_info.bios.cseg_len - 1) & 0xffff);
+			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >> 3],
+				(apm_info.bios.cseg_16_len - 1) & 0xffff);
+			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3],
+				(apm_info.bios.dseg_len - 1) & 0xffff);
+		}
 #endif
+	}
 
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
 	if (apm_proc)
--- linux/arch/i386/kernel/head.S.orig	
+++ linux/arch/i386/kernel/head.S	
@@ -241,7 +241,7 @@ is386:	pushl %ecx		# restore original EF
 2:	movl %eax,%cr0
 	call check_x87
 	incb ready
-	lgdt gdt_descr
+	lgdt cpu_gdt_descr
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
@@ -249,12 +249,7 @@ is386:	pushl %ecx		# restore original EF
 	movl %eax,%es
 	movl %eax,%fs
 	movl %eax,%gs
-#ifdef CONFIG_SMP
-	movl $(__KERNEL_DS), %eax
-	movl %eax,%ss		# Reload the stack pointer (segment only)
-#else
-	lss stack_start,%esp	# Load processor stack
-#endif
+	movl %eax,%ss
 	xorl %eax,%eax
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
@@ -347,30 +342,30 @@ ignore_int:
 	popl %eax
 	iret
 
+
 /*
- * The interrupt descriptor table has room for 256 idt's,
- * the global descriptor table is dependent on the number
- * of tasks we can have..
+ * The IDT and GDT 'descriptors' are a strange 48-bit object
+ * only used by the lidt and lgdt instructions. They are not
+ * like usual segment descriptors - they consist of a 16-bit
+ * segment size, and 32-bit linear address value:
  */
-#define IDT_ENTRIES	256
-#define GDT_ENTRIES	(__TSS(NR_CPUS))
 
-
-.globl SYMBOL_NAME(idt)
-.globl SYMBOL_NAME(gdt)
+.globl SYMBOL_NAME(idt_descr)
+.globl SYMBOL_NAME(cpu_gdt_descr)
 
 	ALIGN
-	.word 0
-idt_descr:
+	.word 0				# 32-bit align idt_desc.address
+
+SYMBOL_NAME(idt_descr):
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
-SYMBOL_NAME(idt):
 	.long SYMBOL_NAME(idt_table)
 
-	.word 0
-gdt_descr:
+SYMBOL_NAME(cpu_gdt_descr):
 	.word GDT_ENTRIES*8-1
-SYMBOL_NAME(gdt):
-	.long SYMBOL_NAME(gdt_table)
+	.long SYMBOL_NAME(cpu_gdt_table)
+
+	.fill NR_CPUS-1,6,0		# space for the other GDT descriptors
+
 
 /*
  * This is initialized to create an identity-mapping at 0-8M (for bootup
@@ -423,26 +418,42 @@ ENTRY(_stext)
 
 ALIGN
 /*
- * This contains typically 140 quadwords, depending on NR_CPUS.
- *
- * NOTE! Make sure the gdt descriptor in head.S matches this if you
- * change anything.
+ * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
-ENTRY(gdt_table)
+ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
-	.quad 0x0000000000000000	/* not used */
-	.quad 0x00cf9a000000ffff	/* 0x10 kernel 4GB code at 0x00000000 */
-	.quad 0x00cf92000000ffff	/* 0x18 kernel 4GB data at 0x00000000 */
-	.quad 0x00cffa000000ffff	/* 0x23 user   4GB code at 0x00000000 */
-	.quad 0x00cff2000000ffff	/* 0x2b user   4GB data at 0x00000000 */
-	.quad 0x0000000000000000	/* not used */
-	.quad 0x0000000000000000	/* not used */
+	.quad 0x0000000000000000	/* 0x0b reserved */
+	.quad 0x0000000000000000	/* 0x13 reserved */
+	.quad 0x0000000000000000	/* 0x1b reserved */
+	.quad 0x00cffa000000ffff	/* 0x23 user 4GB code at 0x00000000 */
+	.quad 0x00cff2000000ffff	/* 0x2b user 4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x33 TLS entry 1 */
+	.quad 0x0000000000000000	/* 0x3b TLS entry 2 */
+	.quad 0x0000000000000000	/* 0x43 TLS entry 3 */
+	.quad 0x0000000000000000	/* 0x4b reserved */
+	.quad 0x0000000000000000	/* 0x53 reserved */
+	.quad 0x0000000000000000	/* 0x5b reserved */
+
+	.quad 0x00cf9a000000ffff	/* 0x60 kernel 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* 0x68 kernel 4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x70 TSS descriptor */
+	.quad 0x0000000000000000	/* 0x78 LDT descriptor */
+
+	/* Segments used for calling PnP BIOS */
+	.quad 0x00c09a0000000000	/* 0x80 32-bit code */
+	.quad 0x00809a0000000000	/* 0x88 16-bit code */
+	.quad 0x0080920000000000	/* 0x90 16-bit data */
+	.quad 0x0080920000000000	/* 0x98 16-bit data */
+	.quad 0x0080920000000000	/* 0xa0 16-bit data */
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * and limits are set at run time.
 	 */
-	.quad 0x0040920000000000	/* 0x40 APM set up for bad BIOS's */
-	.quad 0x00409a0000000000	/* 0x48 APM CS    code */
-	.quad 0x00009a0000000000	/* 0x50 APM CS 16 code (16 bit) */
-	.quad 0x0040920000000000	/* 0x58 APM DS    data */
-	.fill NR_CPUS*4,8,0		/* space for TSS's and LDT's */
+	.quad 0x00409a0000000000	/* 0xa8 APM CS    code */
+	.quad 0x00009a0000000000	/* 0xb0 APM CS 16 code (16 bit) */
+	.quad 0x0040920000000000	/* 0xb8 APM DS    data */
+
+#if CONFIG_SMP
+	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
+#endif
+
--- linux/arch/i386/kernel/i386_ksyms.c.orig	
+++ linux/arch/i386/kernel/i386_ksyms.c	
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(apm_info);
-EXPORT_SYMBOL(gdt);
+EXPORT_SYMBOL_GPL(cpu_gdt_table);
 EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_DEBUG_IOVIRT
--- linux/arch/i386/kernel/process.c.orig	
+++ linux/arch/i386/kernel/process.c	
@@ -33,6 +33,8 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
+#include <linux/mman.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -689,12 +691,13 @@ void dump_thread(struct pt_regs * regs, 
  */
 void __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
-	struct thread_struct *prev = &prev_p->thread,
-				 *next = &next_p->thread;
-	struct tss_struct *tss = init_tss + smp_processor_id();
+	int cpu = smp_processor_id();
+	struct thread_struct *prev = &prev_p->thread, *next = &next_p->thread;
+	struct tss_struct *tss = init_tss + cpu;
 
 	unlazy_fpu(prev_p);
-
+	if (next_p->mm)
+		load_user_cs_desc(cpu, next_p->mm);
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
@@ -835,3 +838,267 @@ unsigned long get_wchan(struct task_stru
 }
 #undef last_sched
 #undef first_sched
+
+/*
+ * In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
+ * by the processes running on the same package. One thing we can do
+ * is to shuffle the initial stack for them.
+ *
+ * (Plus, wiggling the stack a bit also makes it a bit harder for
+ * attackers to guess the stack pointer.)
+ */
+
+static inline unsigned int get_random_int(void)
+{
+	unsigned int jitter, tsc = 0;
+
+	if (!exec_shield_randomize)
+		return 0;
+	/*
+	 * This is a pretty fast call, so no performance worries:
+	 */
+       	get_random_bytes(&jitter, sizeof(jitter));
+#ifdef CONFIG_X86_HAS_TSC
+	rdtscl(tsc);
+#endif
+	jitter += current->pid + (int)&tsc + jiffies + tsc;
+
+	return jitter;
+}
+
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (current->flags & PF_RELOCEXEC)
+		sp -= ((get_random_int() % 65536) << 4);
+	return sp & ~0xf;
+}
+
+#if SHLIB_BASE >= 0x01000000
+# error SHLIB_BASE must be under 16MB!
+#endif
+
+static unsigned long arch_get_unmapped_nonexecutable_area(struct mm_struct *mm, unsigned long addr, unsigned long len)
+{
+	struct vm_area_struct *vma, *prev_vma;
+
+	if (!mm->mmap_top) {
+		printk("hm, %s:%d, !mmap_top.\n", current->comm, current->pid);
+		mm->mmap_top = mmap_top();
+	}
+	/* requested length too big for entire address space */
+	if (len > TASK_SIZE) 
+		return -ENOMEM;
+
+	/* requesting a specific address */
+        if (addr) {
+                addr = PAGE_ALIGN(addr);
+                vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr && 
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+        }
+
+	/* make sure it can fit in the remaining address space */
+	if (mm->mmap_top < len)
+		return -ENOMEM;
+
+	/* either no address requested or cant fit in requested address hole */
+        addr = (mm->mmap_top - len) & PAGE_MASK;
+	do {
+       	 	if (!(vma = find_vma_prev(mm, addr, &prev_vma)))
+                        return -ENOMEM;
+		/*
+		 * If new region fits between prev_vma->vm_end and
+		 * vma->vm_start, then use it:
+		 */
+		if (addr+len <= vma->vm_start &&
+				(!prev_vma || (addr >= prev_vma->vm_end)))
+			return addr;
+
+		/* try just below the current vma->vm_start */
+		addr = vma->vm_start - len;
+        } while (len <= vma->vm_start);
+
+	return -ENOMEM;
+}
+
+static unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len)
+{
+	unsigned long range = end - len - start;
+	if (end <= start + len)
+		return 0;
+	return PAGE_ALIGN(get_random_int() % range + start);
+}
+
+static inline unsigned long stock_arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct vm_area_struct *vma;
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(current->mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
+
+	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (TASK_SIZE - len < addr)
+			return -ENOMEM;
+		if (!vma || addr + len <= vma->vm_start)
+			return addr;
+		addr = vma->vm_end;
+	}
+}
+
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr0,
+		unsigned long len0, unsigned long pgoff, unsigned long flags,
+		unsigned long prot)
+{
+	unsigned long addr = addr0, len = len0;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	int ascii_shield = 0;
+	unsigned long tmp;
+
+	/*
+	 * Fall back to the old layout:
+	 */
+	if (unlikely(!(current->flags & PF_RELOCEXEC)))
+	       return stock_arch_get_unmapped_area(filp, addr0, len0, pgoff, flags);
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (!addr && (prot & PROT_EXEC) && !(flags & MAP_FIXED))
+		addr = randomize_range(SHLIB_BASE, 0x01000000, len);
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+
+	if (prot & PROT_EXEC) {
+		ascii_shield = 1;
+		addr = SHLIB_BASE;
+	} else {
+		/* this can fail if the stack was unlimited */
+		if ((tmp = arch_get_unmapped_nonexecutable_area(mm, addr, len)) != -ENOMEM)
+			return tmp;
+search_upper:
+		addr = PAGE_ALIGN(arch_align_stack(TASK_UNMAPPED_BASE));
+	}
+
+	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (TASK_SIZE - len < addr)
+			return -ENOMEM;
+		if (!vma || addr + len <= vma->vm_start) {
+			/*
+			 * Must not let a PROT_EXEC mapping get into the
+			 * brk area:
+			 */
+			if (ascii_shield && (addr + len > mm->brk)) {
+				ascii_shield = 0;
+				goto search_upper;
+			}
+			/*
+			 * Up until the brk area we randomize addresses
+			 * as much as possible:
+			 */
+			if (ascii_shield && (addr >= 0x01000000)) {
+				tmp = randomize_range(0x01000000, mm->brk, len);
+				vma = find_vma(mm, tmp);
+				if (TASK_SIZE - len >= tmp &&
+				    (!vma || tmp + len <= vma->vm_start))
+					return tmp;
+			}
+			/*
+			 * Ok, randomization didnt work out - return
+			 * the result of the linear search:
+			 */
+			return addr;
+		}
+		addr = vma->vm_end;
+	}
+}
+
+void arch_add_exec_range(struct mm_struct *mm, unsigned long limit)
+{
+	if (limit > mm->context.exec_limit) {
+		mm->context.exec_limit = limit;
+		set_user_cs(&mm->context.user_cs, limit);
+		if (mm == current->mm)
+			load_user_cs_desc(smp_processor_id(), mm);
+	}
+}
+
+void arch_remove_exec_range(struct mm_struct *mm, unsigned long old_end)
+{
+	struct vm_area_struct *vma;
+	unsigned long limit = 0;
+
+	if (old_end == mm->context.exec_limit) {
+		for (vma = mm->mmap; vma; vma = vma->vm_next)
+			if ((vma->vm_flags & VM_EXEC) && (vma->vm_end > limit))
+				limit = vma->vm_end;
+
+		mm->context.exec_limit = limit;
+		set_user_cs(&mm->context.user_cs, limit);
+		if (mm == current->mm)
+			load_user_cs_desc(smp_processor_id(), mm);
+	}
+}
+
+void arch_flush_exec_range(struct mm_struct *mm)
+{
+	mm->context.exec_limit = 0;
+	set_user_cs(&mm->context.user_cs, 0);
+}
+
+/*
+ * Generate random brk address between 128MB and 196MB. (if the layout
+ * allows it.)
+ */
+void randomize_brk(unsigned long old_brk)
+{
+	unsigned long new_brk, range_start, range_end;
+
+	range_start = 0x08000000;
+	if (current->mm->brk >= range_start)
+		range_start = current->mm->brk;
+	range_end = range_start + 0x02000000;
+	new_brk = randomize_range(range_start, range_end, 0);
+	if (new_brk)
+		current->mm->brk = new_brk;
+}
+
+/*
+ * Top of mmap area (just below the process stack).
+ * leave an at least ~128 MB hole. Randomize it.
+ */
+#define MIN_GAP (128*1024*1024)
+#define MAX_GAP (TASK_SIZE/6*5)
+
+unsigned long mmap_top(void)
+{
+	unsigned long gap = 0;
+
+	gap = current->rlim[RLIMIT_STACK].rlim_cur;
+	if (gap < MIN_GAP)
+		gap = MIN_GAP;
+	else if (gap > MAX_GAP)
+		gap = MAX_GAP;
+
+	gap = arch_align_stack(gap) & PAGE_MASK;
+
+	return TASK_SIZE - gap;
+}
+
--- linux/arch/i386/kernel/setup.c.orig	
+++ linux/arch/i386/kernel/setup.c	
@@ -2665,6 +2665,14 @@ static int __init x86_fxsr_setup(char * 
 __setup("nofxsr", x86_fxsr_setup);
 
 
+static int __init setup_exec_shield(char *str)
+{
+	get_option (&str, &exec_shield);
+
+	return 1;
+}
+__setup("exec-shield=", setup_exec_shield);
+
 /* Standard macro to see if a specific flag is changeable */
 static inline int flag_is_changeable_p(u32 flag)
 {
@@ -3147,14 +3155,15 @@ unsigned long cpu_initialized __initdata
  */
 void __init cpu_init (void)
 {
-	int nr = smp_processor_id();
-	struct tss_struct * t = &init_tss[nr];
+	int cpu = smp_processor_id();
+	struct tss_struct * t = &init_tss[cpu];
+	struct thread_struct *thread = &current->thread;
 
-	if (test_and_set_bit(nr, &cpu_initialized)) {
-		printk(KERN_WARNING "CPU#%d already initialized!\n", nr);
+	if (test_and_set_bit(cpu, &cpu_initialized)) {
+		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
 		for (;;) __sti();
 	}
-	printk(KERN_INFO "Initializing CPU#%d\n", nr);
+	printk(KERN_INFO "Initializing CPU#%d\n", cpu);
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
@@ -3167,7 +3176,21 @@ void __init cpu_init (void)
 	}
 #endif
 
-	__asm__ __volatile__("lgdt %0": "=m" (gdt_descr));
+	/*
+	 * Initialize the per-CPU GDT with the boot GDT,
+	 * and set up the GDT descriptor:
+	 */
+	if (cpu) {
+		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
+		cpu_gdt_descr[cpu].size = GDT_SIZE-1;
+		cpu_gdt_descr[cpu].address = (unsigned long)cpu_gdt_table[cpu];
+	}
+
+
+
+
+
+	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 
 	/*
@@ -3182,12 +3205,12 @@ void __init cpu_init (void)
 	current->active_mm = &init_mm;
 	if(current->mm)
 		BUG();
-	enter_lazy_tlb(&init_mm, current, nr);
 
-	t->esp0 = current->thread.esp0;
-	set_tss_desc(nr,t);
-	gdt_table[__TSS(nr)].b &= 0xfffffdff;
-	load_TR(nr);
+	enter_lazy_tlb(&init_mm, current, cpu);
+	t->esp0 = thread->esp0;
+	set_tss_desc(cpu, t);
+	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
+	load_TR_desc();
 	load_LDT(&init_mm);
 
 	/*
--- linux/arch/i386/kernel/signal.c.orig	
+++ linux/arch/i386/kernel/signal.c	
@@ -680,6 +680,8 @@ int do_signal(struct pt_regs *regs, sigs
 			case SIGQUIT: case SIGILL: case SIGTRAP:
 			case SIGABRT: case SIGFPE: case SIGSEGV:
 			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
+				if (print_fatal_signals)
+					print_fatal_signal(regs, signr);
 				if (do_coredump(signr, regs))
 					exit_code |= 0x80;
 				/* FALLTHRU */
--- linux/arch/i386/kernel/trampoline.S.orig	
+++ linux/arch/i386/kernel/trampoline.S	
@@ -61,9 +61,14 @@ idt_48:
 	.word	0			# idt limit = 0
 	.word	0, 0			# idt base = 0L
 
+#
+# NOTE: here we actually use CPU#0's GDT - but that is OK, we reload
+# the proper GDT shortly after booting up the secondary CPUs.
+#
+
 gdt_48:
 	.word	0x0800			# gdt limit = 2048, 256 GDT entries
-	.long	gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
+	.long	cpu_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 
 .globl SYMBOL_NAME(trampoline_end)
 SYMBOL_NAME_LABEL(trampoline_end)
--- linux/arch/i386/kernel/traps.c.orig	
+++ linux/arch/i386/kernel/traps.c	
@@ -397,6 +397,10 @@ DO_ERROR(11, SIGBUS,  "segment not prese
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, get_cr2())
 
+/*
+ * the original non-exec stack patch was written by
+ * Solar Designer <solar at openwall.com>. Thanks!
+ */
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
 	if (regs->eflags & VM_MASK)
@@ -405,6 +409,31 @@ asmlinkage void do_general_protection(st
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
 
+	/*
+	 * lazy-check for CS validity on exec-shield binaries:
+	 */
+	if (current->mm) {
+		int cpu = smp_processor_id();
+		struct desc_struct *desc1, *desc2;
+
+		desc1 = &current->mm->context.user_cs;
+		desc2 = cpu_gdt_table[cpu] + GDT_ENTRY_DEFAULT_USER_CS;
+
+		/*
+		 * The CS was not in sync - reload it and retry the
+		 * instruction. If the instruction still faults then
+		 * we wont hit this branch next time around.
+		 */
+		if (desc1->a != desc2->a || desc1->b != desc2->b) {
+			load_user_cs_desc(cpu, current->mm);
+			return;
+		}
+	}
+	if (print_fatal_signals) {
+		printk("#GPF(%ld[seg:%lx]) at %08lx, CPU#%d.\n", error_code, error_code/8, regs->eip, smp_processor_id());
+		printk(" exec_limit: %08lx, user_cs: %08lx/%08lx.\n", current->mm->context.exec_limit, current->mm->context.user_cs.a, current->mm->context.user_cs.b);
+	}
+
 	current->thread.error_code = error_code;
 	current->thread.trap_no = 13;
 	force_sig(SIGSEGV, current);
@@ -785,7 +814,7 @@ void __init trap_init_f00f_bug(void)
 	 * update the idt descriptor..
 	 */
 	__set_fixmap(FIX_F00F, __pa(&idt_table), PAGE_KERNEL_RO);
-	idt = (struct desc_struct *)__fix_to_virt(FIX_F00F);
+	idt_descr.address = __fix_to_virt(FIX_F00F);
 
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 }
@@ -831,37 +860,6 @@ static void __init set_call_gate(void *a
 	_set_gate(a,12,3,addr);
 }
 
-#define _set_seg_desc(gate_addr,type,dpl,base,limit) {\
-	*((gate_addr)+1) = ((base) & 0xff000000) | \
-		(((base) & 0x00ff0000)>>16) | \
-		((limit) & 0xf0000) | \
-		((dpl)<<13) | \
-		(0x00408000) | \
-		((type)<<8); \
-	*(gate_addr) = (((base) & 0x0000ffff)<<16) | \
-		((limit) & 0x0ffff); }
-
-#define _set_tssldt_desc(n,addr,limit,type) \
-__asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
-	"movw %%ax,2(%2)\n\t" \
-	"rorl $16,%%eax\n\t" \
-	"movb %%al,4(%2)\n\t" \
-	"movb %4,5(%2)\n\t" \
-	"movb $0,6(%2)\n\t" \
-	"movb %%ah,7(%2)\n\t" \
-	"rorl $16,%%eax" \
-	: "=m"(*(n)) : "a" (addr), "r"(n), "ir"(limit), "i"(type))
-
-void set_tss_desc(unsigned int n, void *addr)
-{
-	_set_tssldt_desc(gdt_table+__TSS(n), (int)addr, 235, 0x89);
-}
-
-void set_ldt_desc(unsigned int n, void *addr, unsigned int size)
-{
-	_set_tssldt_desc(gdt_table+__LDT(n), (int)addr, ((size << 3)-1), 0x82);
-}
-
 #ifdef CONFIG_X86_VISWS_APIC
 
 /*
--- linux/Makefile.orig	
+++ linux/Makefile	
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 23
-EXTRAVERSION =
+EXTRAVERSION = -exec-shield
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 

--------------030703040802050608080407--

