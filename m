Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVAAImN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVAAImN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 03:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVAAImN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 03:42:13 -0500
Received: from canuck.infradead.org ([205.233.218.70]:17683 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262198AbVAAIkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 03:40:47 -0500
Subject: Re: 2.5isms
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Justin Pryzby <justinpryzby@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41D60C35.9000503@yahoo.com.au>
References: <20041231230624.GA29411@andromeda>
	 <41D60C35.9000503@yahoo.com.au>
Content-Type: multipart/mixed; boundary="=-W3DkV0Y8ErgwMtUll4pI"
Date: Sat, 01 Jan 2005 09:40:33 +0100
Message-Id: <1104568835.4186.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W3DkV0Y8ErgwMtUll4pI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-01-01 at 13:34 +1100, Nick Piggin wrote:
> Justin Pryzby wrote:
> > Hi all, I have more 2.5isms for the list.  ./fs/binfmt_elf.c:
> > 
> >   #ifdef CONFIG_X86_HT
> >                   /*
> >                    * In some cases (e.g. Hyper-Threading), we want to avoid L1
> >                    * evictions by the processes running on the same package. One
> >                    * thing we can do is to shuffle the initial stack for them.
> >                    *
> >                    * The conditionals here are unneeded, but kept in to make the
> >                    * code behaviour the same as pre change unless we have
> >                    * hyperthreaded processors. This should be cleaned up
> >                    * before 2.6
> >                    */
> > 
> >                   if (smp_num_siblings > 1)
> >                           STACK_ALLOC(p, ((current->pid % 64) << 7));
> >   #endif
> > 
> 
> Can we just kill it? Or do it unconditionally? Or maybe better yet, wrap
> it properly in arch code?

something like this perhaps?
http://www.kernel.org/pub/linux/kernel/people/arjan/execshield/00-
randomize-A0

although that randomizes more than just the stack pointer; the idea for
just the stackpointer should be clear

--=-W3DkV0Y8ErgwMtUll4pI
Content-Disposition: attachment; filename=00-randomize-A0
Content-Type: text/x-patch; name=00-randomize-A0; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN linux-2.6.10-rc1/arch/i386/kernel/process.c linux-2.6.10-rc1-01-random/arch/i386/kernel/process.c
--- linux-2.6.10-rc1/arch/i386/kernel/process.c	2004-10-30 18:20:31.000000000 +0200
+++ linux-2.6.10-rc1-01-random/arch/i386/kernel/process.c	2004-10-30 18:34:48.000000000 +0200
@@ -36,6 +36,8 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -805,3 +807,28 @@ asmlinkage int sys_get_thread_area(struc
 	return 0;
 }
 
+
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (current->flags & PF_RELOCEXEC)
+		sp -= ((get_random_int() % 65536) << 4);
+	return sp & ~0xf;
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
diff -purN linux-2.6.10-rc1/arch/ia64/ia32/binfmt_elf32.c linux-2.6.10-rc1-01-random/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.6.10-rc1/arch/ia64/ia32/binfmt_elf32.c	2004-10-18 23:55:18.000000000 +0200
+++ linux-2.6.10-rc1-01-random/arch/ia64/ia32/binfmt_elf32.c	2004-10-30 18:33:40.000000000 +0200
@@ -256,7 +256,7 @@ elf32_set_personality (void)
 }
 
 static unsigned long
-elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type, unsigned long unused)
 {
 	unsigned long pgoff = (eppnt->p_vaddr) & ~IA32_PAGE_MASK;
 
diff -purN linux-2.6.10-rc1/arch/x86_64/ia32/ia32_binfmt.c linux-2.6.10-rc1-01-random/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.10-rc1/arch/x86_64/ia32/ia32_binfmt.c	2004-10-30 18:20:31.000000000 +0200
+++ linux-2.6.10-rc1-01-random/arch/x86_64/ia32/ia32_binfmt.c	2004-10-30 18:33:40.000000000 +0200
@@ -386,7 +386,7 @@ int setup_arg_pages(struct linux_binprm 
 }
 
 static unsigned long
-elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type, unsigned long unused)
 {
 	unsigned long map_addr;
 	struct task_struct *me = current; 
diff -purN linux-2.6.10-rc1/drivers/char/random.c linux-2.6.10-rc1-01-random/drivers/char/random.c
--- linux-2.6.10-rc1/drivers/char/random.c	2004-10-18 23:53:11.000000000 +0200
+++ linux-2.6.10-rc1-01-random/drivers/char/random.c	2004-10-30 19:53:55.000000000 +0200
@@ -2453,3 +2453,30 @@ __u32 check_tcp_syn_cookie(__u32 cookie,
 	return (cookie - tmp[17]) & COOKIEMASK;	/* Leaving the data behind */
 }
 #endif
+
+/*
+ * Get a random word:
+ */
+unsigned int get_random_int(void)
+{
+	unsigned int val = 0;
+
+	val += current->pid + jiffies + (int)val;
+
+	/*
+	 * Use IP's RNG. It suits our purpose perfectly: it re-keys itself
+	 * every second, from the entropy pool (and thus creates a limited
+	 * drain on it), and uses halfMD4Transform within the second. We
+	 * also spice it with the TSC (if available), jiffies, PID and the
+	 * stack address:
+	 */
+	return secure_ip_id(val);
+}
+
+unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len)
+{
+	unsigned long range = end - len - start;
+	if (end <= start + len)
+		return 0;
+	return PAGE_ALIGN(get_random_int() % range + start);
+}
diff -purN linux-2.6.10-rc1/fs/binfmt_elf.c linux-2.6.10-rc1-01-random/fs/binfmt_elf.c
--- linux-2.6.10-rc1/fs/binfmt_elf.c	2004-10-30 18:20:32.000000000 +0200
+++ linux-2.6.10-rc1-01-random/fs/binfmt_elf.c	2004-10-30 20:03:33.000000000 +0200
@@ -46,7 +46,7 @@
 
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
-static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
+static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int, unsigned long);
 extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
 
 #ifndef elf_addr_t
@@ -156,20 +156,8 @@ create_elf_tables(struct linux_binprm *b
 	if (k_platform) {
 		size_t len = strlen(k_platform) + 1;
 
-#ifdef CONFIG_X86_HT
-		/*
-		 * In some cases (e.g. Hyper-Threading), we want to avoid L1
-		 * evictions by the processes running on the same package. One
-		 * thing we can do is to shuffle the initial stack for them.
-		 *
-		 * The conditionals here are unneeded, but kept in to make the
-		 * code behaviour the same as pre change unless we have
-		 * hyperthreaded processors. This should be cleaned up
-		 * before 2.6
-		 */
-	 
-		if (smp_num_siblings > 1)
-			STACK_ALLOC(p, ((current->pid % 64) << 7));
+#ifdef __HAVE_ARCH_ALIGN_STACK
+		p = (unsigned long)arch_align_stack((unsigned long)p);
 #endif
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
 		__copy_to_user(u_platform, k_platform, len);
@@ -276,20 +264,59 @@ create_elf_tables(struct linux_binprm *b
 #ifndef elf_map
 
 static unsigned long elf_map(struct file *filep, unsigned long addr,
-			struct elf_phdr *eppnt, int prot, int type)
+			     struct elf_phdr *eppnt, int prot, int type,
+			     unsigned long total_size)
 {
 	unsigned long map_addr;
+	unsigned long size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
+	unsigned long off = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
+
+	addr = ELF_PAGESTART(addr);
+	size = ELF_PAGEALIGN(size);
 
 	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+
+	/*
+	 * total_size is the size of the ELF (interpreter) image.
+	 * The _first_ mmap needs to know the full size, otherwise
+	 * randomization might put this image into an overlapping
+	 * position with the ELF binary image. (since size < total_size)
+	 * So we first map the 'big' image - and unmap the remainder at
+	 * the end. (which unmap is needed for ELF images with holes.)
+	 */
+	if (total_size) {
+		total_size = ELF_PAGEALIGN(total_size);
+		map_addr = do_mmap(filep, addr, total_size, prot, type, off);
+		if (!BAD_ADDR(map_addr))
+			do_munmap(current->mm, map_addr+size, total_size-size);
+	} else
+		map_addr = do_mmap(filep, addr, size, prot, type, off);
+		
 	up_write(&current->mm->mmap_sem);
-	return(map_addr);
+
+	return map_addr;
 }
 
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
@@ -297,7 +324,8 @@ static unsigned long elf_map(struct file
 
 static unsigned long load_elf_interp(struct elfhdr * interp_elf_ex,
 				     struct file * interpreter,
-				     unsigned long *interp_load_addr)
+				     unsigned long *interp_load_addr,
+				     unsigned long no_base)
 {
 	struct elf_phdr *elf_phdata;
 	struct elf_phdr *eppnt;
@@ -305,6 +333,7 @@ static unsigned long load_elf_interp(str
 	int load_addr_set = 0;
 	unsigned long last_bss = 0, elf_bss = 0;
 	unsigned long error = ~0UL;
+	unsigned long total_size;
 	int retval, i, size;
 
 	/* First of all, some simple consistency checks */
@@ -339,6 +368,10 @@ static unsigned long load_elf_interp(str
 	if (retval < 0)
 		goto out_close;
 
+	total_size = total_mapping_size(elf_phdata, interp_elf_ex->e_phnum);
+	if (!total_size)
+		goto out_close;
+
 	eppnt = elf_phdata;
 	for (i=0; i<interp_elf_ex->e_phnum; i++, eppnt++) {
 	  if (eppnt->p_type == PT_LOAD) {
@@ -353,8 +386,11 @@ static unsigned long load_elf_interp(str
 	    vaddr = eppnt->p_vaddr;
 	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
 	    	elf_type |= MAP_FIXED;
+	    else if (no_base && interp_elf_ex->e_type == ET_DYN)
+		load_addr = -vaddr;
 
-	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
+	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type, total_size);
+	    total_size = 0;
 	    error = map_addr;
 	    if (BAD_ADDR(map_addr))
 	    	goto out_close;
@@ -491,6 +527,7 @@ static int load_elf_binary(struct linux_
 	char passed_fileno[6];
 	struct files_struct *files;
 	int have_pt_gnu_stack, executable_stack = EXSTACK_DEFAULT;
+	int old_relocexec = current->flags & PF_RELOCEXEC;
 	unsigned long def_flags = 0;
 	struct {
 		struct elfhdr elf_ex;
@@ -638,6 +675,9 @@ static int load_elf_binary(struct linux_
 		}
 	have_pt_gnu_stack = (i < loc->elf_ex.e_phnum);
 
+	if (executable_stack == EXSTACK_DISABLE_X) 
+			current->flags |= PF_RELOCEXEC;
+
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
 		interpreter_type = INTERPRETER_ELF | INTERPRETER_AOUT;
@@ -726,10 +766,10 @@ static int load_elf_binary(struct linux_
 	
 	current->mm->start_stack = bprm->p;
 
+
 	/* Now we do a little grungy work by mmaping the ELF image into
-	   the correct location in memory.  At this point, we assume that
-	   the image should be loaded at fixed address, not at a variable
-	   address. */
+	   the correct location in memory.
+	 */
 
 	for(i = 0, elf_ppnt = elf_phdata; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
@@ -766,16 +806,16 @@ static int load_elf_binary(struct linux_
 		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
 
 		vaddr = elf_ppnt->p_vaddr;
-		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
+		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set)
 			elf_flags |= MAP_FIXED;
-		} else if (loc->elf_ex.e_type == ET_DYN) {
-			/* Try and get dynamic programs out of the way of the default mmap
-			   base, as well as whatever program they might try to exec.  This
-			   is because the brk will follow the loader, and is not movable.  */
+		else if (loc->elf_ex.e_type == ET_DYN)
+#ifdef __i386__
+			load_bias = 0;
+#else
 			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
-		}
+#endif
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
+		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags, 0);
 		if (BAD_ADDR(error))
 			continue;
 
@@ -846,7 +886,8 @@ static int load_elf_binary(struct linux_
 		else
 			elf_entry = load_elf_interp(&loc->interp_elf_ex,
 						    interpreter,
-						    &interp_load_addr);
+						    &interp_load_addr,
+						    load_bias);
 		if (BAD_ADDR(elf_entry)) {
 			printk(KERN_ERR "Unable to load interpreter\n");
 			send_sig(SIGSEGV, current, 0);
@@ -882,6 +923,10 @@ static int load_elf_binary(struct linux_
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
+#ifdef __HAVE_ARCH_RANDOMIZE_BRK
+	if (current->flags & PF_RELOCEXEC)
+		randomize_brk(elf_brk);
+#endif
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
 		   and some applications "depend" upon this behavior.
@@ -937,6 +982,8 @@ out_free_fh:
 	}
 out_free_ph:
 	kfree(elf_phdata);
+	current->flags &= ~PF_RELOCEXEC;
+	current->flags |= old_relocexec;
 	goto out;
 }
 
diff -purN linux-2.6.10-rc1/fs/exec.c linux-2.6.10-rc1-01-random/fs/exec.c
--- linux-2.6.10-rc1/fs/exec.c	2004-10-30 18:20:32.000000000 +0200
+++ linux-2.6.10-rc1-01-random/fs/exec.c	2004-10-31 11:39:56.000000000 +0100
@@ -390,7 +390,12 @@ int setup_arg_pages(struct linux_binprm 
 	while (i < MAX_ARG_PAGES)
 		bprm->page[i++] = NULL;
 #else
+#ifdef __HAVE_ARCH_ALIGN_STACK
+	stack_base = arch_align_stack(STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE);
+	stack_base = PAGE_ALIGN(stack_base);
+#else
 	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
+#endif
 	mm->arg_start = bprm->p + stack_base;
 	arg_size = STACK_TOP - (PAGE_MASK & (unsigned long) mm->arg_start);
 #endif
@@ -839,6 +844,7 @@ int flush_old_exec(struct linux_binprm *
 	tcomm[i] = '\0';
 	set_task_comm(current, tcomm);
 
+	current->flags &= ~PF_RELOCEXEC;
 	flush_thread();
 
 	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid || 
diff -purN linux-2.6.10-rc1/include/asm-i386/elf.h linux-2.6.10-rc1-01-random/include/asm-i386/elf.h
--- linux-2.6.10-rc1/include/asm-i386/elf.h	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6.10-rc1-01-random/include/asm-i386/elf.h	2004-10-30 18:40:56.000000000 +0200
@@ -190,4 +190,7 @@ do {									      \
 
 #endif
 
+#define __HAVE_ARCH_RANDOMIZE_BRK
+extern void randomize_brk(unsigned long old_brk);
+
 #endif
diff -purN linux-2.6.10-rc1/include/linux/random.h linux-2.6.10-rc1-01-random/include/linux/random.h
--- linux-2.6.10-rc1/include/linux/random.h	2004-10-18 23:55:29.000000000 +0200
+++ linux-2.6.10-rc1-01-random/include/linux/random.h	2004-10-30 18:33:40.000000000 +0200
@@ -71,6 +71,9 @@ extern __u32 secure_tcpv6_sequence_numbe
 extern struct file_operations random_fops, urandom_fops;
 #endif
 
+unsigned int get_random_int(void);
+unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len);
+
 #endif /* __KERNEL___ */
 
 #endif /* _LINUX_RANDOM_H */
diff -purN linux-2.6.10-rc1/include/linux/resource.h linux-2.6.10-rc1-01-random/include/linux/resource.h
--- linux-2.6.10-rc1/include/linux/resource.h	2004-10-18 23:53:13.000000000 +0200
+++ linux-2.6.10-rc1-01-random/include/linux/resource.h	2004-10-30 18:33:40.000000000 +0200
@@ -52,8 +52,11 @@ struct rlimit {
 /*
  * Limit the stack by to some sane default: root can always
  * increase this limit if needed..  8MB seems reasonable.
+ *
+ * (2MB more to cover randomization effects.)
  */
-#define _STK_LIM	(8*1024*1024)
+#define _STK_LIM	(10*1024*1024)
+#define EXEC_STACK_BIAS	(2*1024*1024)
 
 /*
  * GPG wants 32kB of mlocked memory, to make sure pass phrases
diff -purN linux-2.6.10-rc1/include/linux/sched.h linux-2.6.10-rc1-01-random/include/linux/sched.h
--- linux-2.6.10-rc1/include/linux/sched.h	2004-10-30 18:20:33.000000000 +0200
+++ linux-2.6.10-rc1-01-random/include/linux/sched.h	2004-10-30 18:58:28.000000000 +0200
@@ -701,6 +701,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
+#define PF_RELOCEXEC	0x00800000      /* randomize virtual address space */
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);

--=-W3DkV0Y8ErgwMtUll4pI--

