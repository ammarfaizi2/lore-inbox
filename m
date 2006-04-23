Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWDWQ5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWDWQ5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 12:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWDWQ5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 12:57:31 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:25271 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751426AbWDWQ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 12:57:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gqI5/rRoCGBPqwTZX2bc6zUCg2CwWd7efN87bAlDT8I5eckzEnX3rzz1LEUbiJ1+FhOfByjLqz/c+S5xNUSW+dcP46+jh90q1nrEwLEwFv5dpxZFnke1nWMXHwkS5YardJasaiNn2OnVs49IMl1B48ucOpXGxRJPsQpmIX6D1vQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf CodingStyle cleanup and remove some pointless casts
Date: Sun, 23 Apr 2006 18:58:15 +0200
User-Agent: KMail/1.9.1
Cc: Eric Youngdale <ericy@cais.com>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604231858.15646.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that does a CodingStyle cleanup of fs/binfmt_elf.c and also
removes some pointless casts of kmalloc() return values in the same file.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/binfmt_elf.c |  342 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 182 insertions(+), 160 deletions(-)

--- linux-2.6.17-rc2-git4-orig/fs/binfmt_elf.c	2006-04-20 21:37:38.000000000 +0200
+++ linux-2.6.17-rc2-git4/fs/binfmt_elf.c	2006-04-23 16:46:29.000000000 +0200
@@ -38,15 +38,13 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/random.h>
-
+#include <linux/elf.h>
 #include <asm/uaccess.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
-#include <linux/elf.h>
-
-static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
-static int load_elf_library(struct file*);
+static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs);
+static int load_elf_library(struct file *);
 static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
 extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
 
@@ -59,15 +57,15 @@ extern int dump_fpu (struct pt_regs *, e
  * don't even try.
  */
 #if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
-static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file);
+static int elf_core_dump(long signr, struct pt_regs *regs, struct file *file);
 #else
 #define elf_core_dump	NULL
 #endif
 
 #if ELF_EXEC_PAGESIZE > PAGE_SIZE
-# define ELF_MIN_ALIGN	ELF_EXEC_PAGESIZE
+#define ELF_MIN_ALIGN	ELF_EXEC_PAGESIZE
 #else
-# define ELF_MIN_ALIGN	PAGE_SIZE
+#define ELF_MIN_ALIGN	PAGE_SIZE
 #endif
 
 #ifndef ELF_CORE_EFLAGS
@@ -86,7 +84,7 @@ static struct linux_binfmt elf_format = 
 		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x) ((unsigned long)(x) > TASK_SIZE)
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -104,13 +102,11 @@ static int set_brk(unsigned long start, 
 	return 0;
 }
 
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
-   be in memory */
-
-
+   be in memory
+ */
 static int padzero(unsigned long elf_bss)
 {
 	unsigned long nbyte;
@@ -129,7 +125,9 @@ static int padzero(unsigned long elf_bss
 #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) + (items))
 #define STACK_ROUND(sp, items) \
 	((15 + (unsigned long) ((sp) + (items))) &~ 15UL)
-#define STACK_ALLOC(sp, len) ({ elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; old_sp; })
+#define STACK_ALLOC(sp, len) ({ \
+	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
+	old_sp; })
 #else
 #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
 #define STACK_ROUND(sp, items) \
@@ -138,7 +136,7 @@ static int padzero(unsigned long elf_bss
 #endif
 
 static int
-create_elf_tables(struct linux_binprm *bprm, struct elfhdr * exec,
+create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 		int interp_aout, unsigned long load_addr,
 		unsigned long interp_load_addr)
 {
@@ -161,7 +159,6 @@ create_elf_tables(struct linux_binprm *b
 	 * for userspace to get any other way, in others (i386) it is
 	 * merely difficult.
 	 */
-
 	u_platform = NULL;
 	if (k_platform) {
 		size_t len = strlen(k_platform) + 1;
@@ -171,7 +168,7 @@ create_elf_tables(struct linux_binprm *b
 		 * evictions by the processes running on the same package. One
 		 * thing we can do is to shuffle the initial stack for them.
 		 */
-	 
+
 		p = arch_align_stack(p);
 
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
@@ -182,7 +179,9 @@ create_elf_tables(struct linux_binprm *b
 	/* Create the ELF interpreter info */
 	elf_info = (elf_addr_t *) current->mm->saved_auxv;
 #define NEW_AUX_ENT(id, val) \
-	do { elf_info[ei_index++] = id; elf_info[ei_index++] = val; } while (0)
+	do { \
+		elf_info[ei_index++] = id; elf_info[ei_index++] = val; \
+	} while (0)
 
 #ifdef ARCH_DLINFO
 	/* 
@@ -195,21 +194,22 @@ create_elf_tables(struct linux_binprm *b
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
 	NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
-	NEW_AUX_ENT(AT_PHENT, sizeof (struct elf_phdr));
+	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
 	NEW_AUX_ENT(AT_FLAGS, 0);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
-	NEW_AUX_ENT(AT_UID, (elf_addr_t) tsk->uid);
-	NEW_AUX_ENT(AT_EUID, (elf_addr_t) tsk->euid);
-	NEW_AUX_ENT(AT_GID, (elf_addr_t) tsk->gid);
-	NEW_AUX_ENT(AT_EGID, (elf_addr_t) tsk->egid);
- 	NEW_AUX_ENT(AT_SECURE, (elf_addr_t) security_bprm_secureexec(bprm));
+	NEW_AUX_ENT(AT_UID, (elf_addr_t)tsk->uid);
+	NEW_AUX_ENT(AT_EUID, (elf_addr_t)tsk->euid);
+	NEW_AUX_ENT(AT_GID, (elf_addr_t)tsk->gid);
+	NEW_AUX_ENT(AT_EGID, (elf_addr_t)tsk->egid);
+ 	NEW_AUX_ENT(AT_SECURE, (elf_addr_t)security_bprm_secureexec(bprm));
 	if (k_platform) {
-		NEW_AUX_ENT(AT_PLATFORM, (elf_addr_t)(unsigned long)u_platform);
+		NEW_AUX_ENT(AT_PLATFORM,
+			(elf_addr_t)(unsigned long)u_platform);
 	}
 	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD) {
-		NEW_AUX_ENT(AT_EXECFD, (elf_addr_t) bprm->interp_data);
+		NEW_AUX_ENT(AT_EXECFD, (elf_addr_t)bprm->interp_data);
 	}
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */
@@ -232,7 +232,7 @@ create_elf_tables(struct linux_binprm *b
 	/* Point sp at the lowest address on the stack */
 #ifdef CONFIG_STACK_GROWSUP
 	sp = (elf_addr_t __user *)bprm->p - items - ei_index;
-	bprm->exec = (unsigned long) sp; /* XXX: PARISC HACK */
+	bprm->exec = (unsigned long)sp; /* XXX: PARISC HACK */
 #else
 	sp = (elf_addr_t __user *)bprm->p;
 #endif
@@ -285,7 +285,7 @@ create_elf_tables(struct linux_binprm *b
 #ifndef elf_map
 
 static unsigned long elf_map(struct file *filep, unsigned long addr,
-			struct elf_phdr *eppnt, int prot, int type)
+		struct elf_phdr *eppnt, int prot, int type)
 {
 	unsigned long map_addr;
 	unsigned long pageoffset = ELF_PAGEOFFSET(eppnt->p_vaddr);
@@ -310,9 +310,8 @@ static unsigned long elf_map(struct file
    is only provided so that we can read a.out libraries that have
    an ELF header */
 
-static unsigned long load_elf_interp(struct elfhdr * interp_elf_ex,
-				     struct file * interpreter,
-				     unsigned long *interp_load_addr)
+static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
+		struct file *interpreter, unsigned long *interp_load_addr)
 {
 	struct elf_phdr *elf_phdata;
 	struct elf_phdr *eppnt;
@@ -342,15 +341,15 @@ static unsigned long load_elf_interp(str
 		goto out;
 
 	/* Now read in all of the header information */
-
 	size = sizeof(struct elf_phdr) * interp_elf_ex->e_phnum;
 	if (size > ELF_MIN_ALIGN)
 		goto out;
-	elf_phdata = (struct elf_phdr *) kmalloc(size, GFP_KERNEL);
+	elf_phdata = kmalloc(size, GFP_KERNEL);
 	if (!elf_phdata)
 		goto out;
 
-	retval = kernel_read(interpreter,interp_elf_ex->e_phoff,(char *)elf_phdata,size);
+	retval = kernel_read(interpreter, interp_elf_ex->e_phoff,
+			     (char *)elf_phdata,size);
 	error = -EIO;
 	if (retval != size) {
 		if (retval < 0)
@@ -359,58 +358,65 @@ static unsigned long load_elf_interp(str
 	}
 
 	eppnt = elf_phdata;
-	for (i=0; i<interp_elf_ex->e_phnum; i++, eppnt++) {
-	  if (eppnt->p_type == PT_LOAD) {
-	    int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
-	    int elf_prot = 0;
-	    unsigned long vaddr = 0;
-	    unsigned long k, map_addr;
-
-	    if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
-	    if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
-	    if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
-	    vaddr = eppnt->p_vaddr;
-	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
-	    	elf_type |= MAP_FIXED;
-
-	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
-	    error = map_addr;
-	    if (BAD_ADDR(map_addr))
-	    	goto out_close;
-
-	    if (!load_addr_set && interp_elf_ex->e_type == ET_DYN) {
-		load_addr = map_addr - ELF_PAGESTART(vaddr);
-		load_addr_set = 1;
-	    }
-
-	    /*
-	     * Check to see if the section's size will overflow the
-	     * allowed task size. Note that p_filesz must always be
-	     * <= p_memsize so it is only necessary to check p_memsz.
-	     */
-	    k = load_addr + eppnt->p_vaddr;
-	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
-		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
-	        error = -ENOMEM;
-		goto out_close;
-	    }
+	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
+		if (eppnt->p_type == PT_LOAD) {
+			int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
+			int elf_prot = 0;
+			unsigned long vaddr = 0;
+			unsigned long k, map_addr;
+
+			if (eppnt->p_flags & PF_R)
+		    		elf_prot = PROT_READ;
+			if (eppnt->p_flags & PF_W)
+				elf_prot |= PROT_WRITE;
+			if (eppnt->p_flags & PF_X)
+				elf_prot |= PROT_EXEC;
+			vaddr = eppnt->p_vaddr;
+			if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
+				elf_type |= MAP_FIXED;
+
+			map_addr = elf_map(interpreter, load_addr + vaddr,
+					   eppnt, elf_prot, elf_type);
+			error = map_addr;
+			if (BAD_ADDR(map_addr))
+				goto out_close;
+
+			if (!load_addr_set &&
+			    interp_elf_ex->e_type == ET_DYN) {
+				load_addr = map_addr - ELF_PAGESTART(vaddr);
+				load_addr_set = 1;
+			}
+
+			/*
+			 * Check to see if the section's size will overflow the
+			 * allowed task size. Note that p_filesz must always be
+			 * <= p_memsize so it's only necessary to check p_memsz.
+			 */
+			k = load_addr + eppnt->p_vaddr;
+			if (k > TASK_SIZE ||
+			    eppnt->p_filesz > eppnt->p_memsz ||
+			    eppnt->p_memsz > TASK_SIZE ||
+			    TASK_SIZE - eppnt->p_memsz < k) {
+				error = -ENOMEM;
+				goto out_close;
+			}
+
+			/*
+			 * Find the end of the file mapping for this phdr, and
+			 * keep track of the largest address we see for this.
+			 */
+			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
+			if (k > elf_bss)
+				elf_bss = k;
 
-	    /*
-	     * Find the end of the file mapping for this phdr, and keep
-	     * track of the largest address we see for this.
-	     */
-	    k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
-	    if (k > elf_bss)
-		elf_bss = k;
-
-	    /*
-	     * Do the same thing for the memory mapping - between
-	     * elf_bss and last_bss is the bss section.
-	     */
-	    k = load_addr + eppnt->p_memsz + eppnt->p_vaddr;
-	    if (k > last_bss)
-		last_bss = k;
-	  }
+			/*
+			 * Do the same thing for the memory mapping - between
+			 * elf_bss and last_bss is the bss section.
+			 */
+			k = load_addr + eppnt->p_memsz + eppnt->p_vaddr;
+			if (k > last_bss)
+				last_bss = k;
+		}
 	}
 
 	/*
@@ -424,7 +430,8 @@ static unsigned long load_elf_interp(str
 		goto out_close;
 	}
 
-	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
+	/* What we have mapped so far */
+	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);
 
 	/* Map the last of the bss segment */
 	if (last_bss > elf_bss) {
@@ -436,7 +443,7 @@ static unsigned long load_elf_interp(str
 	}
 
 	*interp_load_addr = load_addr;
-	error = ((unsigned long) interp_elf_ex->e_entry) + load_addr;
+	error = ((unsigned long)interp_elf_ex->e_entry) + load_addr;
 
 out_close:
 	kfree(elf_phdata);
@@ -444,8 +451,8 @@ out:
 	return error;
 }
 
-static unsigned long load_aout_interp(struct exec * interp_ex,
-			     struct file * interpreter)
+static unsigned long load_aout_interp(struct exec *interp_ex,
+		struct file *interpreter)
 {
 	unsigned long text_data, elf_entry = ~0UL;
 	char __user * addr;
@@ -464,7 +471,7 @@ static unsigned long load_aout_interp(st
 	case ZMAGIC:
 	case QMAGIC:
 		offset = N_TXTOFF(*interp_ex);
-		addr = (char __user *) N_TXTADDR(*interp_ex);
+		addr = (char __user *)N_TXTADDR(*interp_ex);
 		break;
 	default:
 		goto out;
@@ -480,7 +487,6 @@ static unsigned long load_aout_interp(st
 	flush_icache_range((unsigned long)addr,
 	                   (unsigned long)addr + text_data);
 
-
 	down_write(&current->mm->mmap_sem);	
 	do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
 		interp_ex->a_bss);
@@ -519,7 +525,7 @@ static unsigned long randomize_stack_top
 #endif
 }
 
-static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs)
+static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
  	unsigned long load_addr = 0, load_bias = 0;
@@ -528,7 +534,7 @@ static int load_elf_binary(struct linux_
 	unsigned int interpreter_type = INTERPRETER_NONE;
 	unsigned char ibcs2_interpreter = 0;
 	unsigned long error;
-	struct elf_phdr * elf_ppnt, *elf_phdata;
+	struct elf_phdr *elf_ppnt, *elf_phdata;
 	unsigned long elf_bss, elf_brk;
 	int elf_exec_fileno;
 	int retval, i;
@@ -553,7 +559,7 @@ static int load_elf_binary(struct linux_
 	}
 	
 	/* Get the exec-header */
-	loc->elf_ex = *((struct elfhdr *) bprm->buf);
+	loc->elf_ex = *((struct elfhdr *)bprm->buf);
 
 	retval = -ENOEXEC;
 	/* First of all, some simple consistency checks */
@@ -568,7 +574,6 @@ static int load_elf_binary(struct linux_
 		goto out;
 
 	/* Now read in all of the header information */
-
 	if (loc->elf_ex.e_phentsize != sizeof(struct elf_phdr))
 		goto out;
 	if (loc->elf_ex.e_phnum < 1 ||
@@ -576,18 +581,19 @@ static int load_elf_binary(struct linux_
 		goto out;
 	size = loc->elf_ex.e_phnum * sizeof(struct elf_phdr);
 	retval = -ENOMEM;
-	elf_phdata = (struct elf_phdr *) kmalloc(size, GFP_KERNEL);
+	elf_phdata = kmalloc(size, GFP_KERNEL);
 	if (!elf_phdata)
 		goto out;
 
-	retval = kernel_read(bprm->file, loc->elf_ex.e_phoff, (char *) elf_phdata, size);
+	retval = kernel_read(bprm->file, loc->elf_ex.e_phoff,
+			     (char *)elf_phdata, size);
 	if (retval != size) {
 		if (retval >= 0)
 			retval = -EIO;
 		goto out_free_ph;
 	}
 
-	files = current->files;		/* Refcounted so ok */
+	files = current->files;	/* Refcounted so ok */
 	retval = unshare_files();
 	if (retval < 0)
 		goto out_free_ph;
@@ -598,7 +604,6 @@ static int load_elf_binary(struct linux_
 
 	/* exec will make our files private anyway, but for the a.out
 	   loader stuff we need to do it earlier */
-
 	retval = get_unused_fd();
 	if (retval < 0)
 		goto out_free_fh;
@@ -620,7 +625,6 @@ static int load_elf_binary(struct linux_
 			 * shared libraries - for now assume that this
 			 * is an a.out format binary
 			 */
-
 			retval = -ENOEXEC;
 			if (elf_ppnt->p_filesz > PATH_MAX || 
 			    elf_ppnt->p_filesz < 2)
@@ -628,13 +632,13 @@ static int load_elf_binary(struct linux_
 
 			retval = -ENOMEM;
 			elf_interpreter = kmalloc(elf_ppnt->p_filesz,
-							   GFP_KERNEL);
+						  GFP_KERNEL);
 			if (!elf_interpreter)
 				goto out_free_file;
 
 			retval = kernel_read(bprm->file, elf_ppnt->p_offset,
-					   elf_interpreter,
-					   elf_ppnt->p_filesz);
+					     elf_interpreter,
+					     elf_ppnt->p_filesz);
 			if (retval != elf_ppnt->p_filesz) {
 				if (retval >= 0)
 					retval = -EIO;
@@ -678,7 +682,8 @@ static int load_elf_binary(struct linux_
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
 				goto out_free_interp;
-			retval = kernel_read(interpreter, 0, bprm->buf, BINPRM_BUF_SIZE);
+			retval = kernel_read(interpreter, 0, bprm->buf,
+					     BINPRM_BUF_SIZE);
 			if (retval != BINPRM_BUF_SIZE) {
 				if (retval >= 0)
 					retval = -EIO;
@@ -686,8 +691,8 @@ static int load_elf_binary(struct linux_
 			}
 
 			/* Get the exec headers */
-			loc->interp_ex = *((struct exec *) bprm->buf);
-			loc->interp_elf_ex = *((struct elfhdr *) bprm->buf);
+			loc->interp_ex = *((struct exec *)bprm->buf);
+			loc->interp_elf_ex = *((struct elfhdr *)bprm->buf);
 			break;
 		}
 		elf_ppnt++;
@@ -739,7 +744,6 @@ static int load_elf_binary(struct linux_
 
 	/* OK, we are done with that, now set up the arg stuff,
 	   and then start this sucker up */
-
 	if ((!bprm->sh_bang) && (interpreter_type == INTERPRETER_AOUT)) {
 		char *passed_p = passed_fileno;
 		sprintf(passed_fileno, "%d", elf_exec_fileno);
@@ -778,7 +782,7 @@ static int load_elf_binary(struct linux_
 	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if ( !(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 	arch_pick_mmap_layout(current->mm);
 
@@ -799,8 +803,8 @@ static int load_elf_binary(struct linux_
 	   the correct location in memory.  At this point, we assume that
 	   the image should be loaded at fixed address, not at a variable
 	   address. */
-
-	for(i = 0, elf_ppnt = elf_phdata; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
+	for(i = 0, elf_ppnt = elf_phdata;
+	    i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
 		unsigned long k, vaddr;
 
@@ -828,30 +832,35 @@ static int load_elf_binary(struct linux_
 							load_bias, nbyte)) {
 					/*
 					 * This bss-zeroing can fail if the ELF
-					 * file specifies odd protections.  So
+					 * file specifies odd protections. So
 					 * we don't check the return value
 					 */
 				}
 			}
 		}
 
-		if (elf_ppnt->p_flags & PF_R) elf_prot |= PROT_READ;
-		if (elf_ppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
-		if (elf_ppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
+		if (elf_ppnt->p_flags & PF_R)
+			elf_prot |= PROT_READ;
+		if (elf_ppnt->p_flags & PF_W)
+			elf_prot |= PROT_WRITE;
+		if (elf_ppnt->p_flags & PF_X)
+			elf_prot |= PROT_EXEC;
 
-		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
+		elf_flags = MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE;
 
 		vaddr = elf_ppnt->p_vaddr;
 		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
 			elf_flags |= MAP_FIXED;
 		} else if (loc->elf_ex.e_type == ET_DYN) {
-			/* Try and get dynamic programs out of the way of the default mmap
-			   base, as well as whatever program they might try to exec.  This
-			   is because the brk will follow the loader, and is not movable.  */
+			/* Try and get dynamic programs out of the way of the
+			 * default mmap base, as well as whatever program they
+			 * might try to exec.  This is because the brk will
+			 * follow the loader, and is not movable.  */
 			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
 		}
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
+		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
+				elf_prot, elf_flags);
 		if (BAD_ADDR(error)) {
 			send_sig(SIGKILL, current, 0);
 			goto out_free_dentry;
@@ -868,8 +877,10 @@ static int load_elf_binary(struct linux_
 			}
 		}
 		k = elf_ppnt->p_vaddr;
-		if (k < start_code) start_code = k;
-		if (start_data < k) start_data = k;
+		if (k < start_code)
+			start_code = k;
+		if (start_data < k)
+			start_data = k;
 
 		/*
 		 * Check to see if the section's size will overflow the
@@ -879,7 +890,7 @@ static int load_elf_binary(struct linux_
 		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
 		    elf_ppnt->p_memsz > TASK_SIZE ||
 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
-			/* set_brk can never work.  Avoid overflows.  */
+			/* set_brk can never work. Avoid overflows. */
 			send_sig(SIGKILL, current, 0);
 			goto out_free_dentry;
 		}
@@ -967,8 +978,9 @@ static int load_elf_binary(struct linux_
 
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
-	create_elf_tables(bprm, &loc->elf_ex, (interpreter_type == INTERPRETER_AOUT),
-			load_addr, interp_load_addr);
+	create_elf_tables(bprm, &loc->elf_ex,
+			  (interpreter_type == INTERPRETER_AOUT),
+			  load_addr, interp_load_addr);
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
 		current->mm->arg_start += strlen(passed_fileno) + 1;
@@ -982,7 +994,7 @@ static int load_elf_binary(struct linux_
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
 		   and some applications "depend" upon this behavior.
 		   Since we do not have the power to recompile these, we
-		   emulate the SVr4 behavior.  Sigh.  */
+		   emulate the SVr4 behavior. Sigh. */
 		down_write(&current->mm->mmap_sem);
 		error = do_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
@@ -1037,7 +1049,6 @@ out_free_ph:
 
 /* This is really simpleminded and specialized - we are loading an
    a.out library that is given an ELF header. */
-
 static int load_elf_library(struct file *file)
 {
 	struct elf_phdr *elf_phdata;
@@ -1047,7 +1058,7 @@ static int load_elf_library(struct file 
 	struct elfhdr elf_ex;
 
 	error = -ENOEXEC;
-	retval = kernel_read(file, 0, (char *) &elf_ex, sizeof(elf_ex));
+	retval = kernel_read(file, 0, (char *)&elf_ex, sizeof(elf_ex));
 	if (retval != sizeof(elf_ex))
 		goto out;
 
@@ -1056,7 +1067,7 @@ static int load_elf_library(struct file 
 
 	/* First of all, some simple consistency checks */
 	if (elf_ex.e_type != ET_EXEC || elf_ex.e_phnum > 2 ||
-	   !elf_check_arch(&elf_ex) || !file->f_op || !file->f_op->mmap)
+	    !elf_check_arch(&elf_ex) || !file->f_op || !file->f_op->mmap)
 		goto out;
 
 	/* Now read in all of the header information */
@@ -1104,7 +1115,8 @@ static int load_elf_library(struct file 
 		goto out_free_ph;
 	}
 
-	len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr + ELF_MIN_ALIGN - 1);
+	len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr +
+			    ELF_MIN_ALIGN - 1);
 	bss = eppnt->p_memsz + eppnt->p_vaddr;
 	if (bss > len) {
 		down_write(&current->mm->mmap_sem);
@@ -1163,7 +1175,7 @@ static int maydump(struct vm_area_struct
 	if (vma->vm_flags & (VM_IO | VM_RESERVED))
 		return 0;
 
-	/* Dump shared memory only if mapped from an anonymous file.  */
+	/* Dump shared memory only if mapped from an anonymous file. */
 	if (vma->vm_flags & VM_SHARED)
 		return vma->vm_file->f_dentry->d_inode->i_nlink == 0;
 
@@ -1174,7 +1186,7 @@ static int maydump(struct vm_area_struct
 	return 1;
 }
 
-#define roundup(x, y)  ((((x)+((y)-1))/(y))*(y))
+#define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 
 /* An ELF note in memory */
 struct memelfnote
@@ -1277,11 +1289,11 @@ static void fill_note(struct memelfnote 
 }
 
 /*
- * fill up all the fields in prstatus from the given task struct, except registers
- * which need to be filled up separately.
+ * fill up all the fields in prstatus from the given task struct, except
+ * registers which need to be filled up separately.
  */
 static void fill_prstatus(struct elf_prstatus *prstatus,
-			struct task_struct *p, long signr) 
+		struct task_struct *p, long signr) 
 {
 	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
 	prstatus->pr_sigpend = p->pending.signal.sig[0];
@@ -1366,8 +1378,8 @@ struct elf_thread_status
 
 /*
  * In order to add the specific thread information for the elf file format,
- * we need to keep a linked list of every threads pr_status and then
- * create a single section for them in the final core file.
+ * we need to keep a linked list of every threads pr_status and then create
+ * a single section for them in the final core file.
  */
 static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 {
@@ -1378,19 +1390,23 @@ static int elf_dump_thread_status(long s
 	fill_prstatus(&t->prstatus, p, signr);
 	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	
 	
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus), &(t->prstatus));
+	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
+		  &(t->prstatus));
 	t->num_notes++;
 	sz += notesize(&t->notes[0]);
 
-	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, NULL, &t->fpu))) {
-		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu), &(t->fpu));
+	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, NULL,
+								&t->fpu))) {
+		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
+			  &(t->fpu));
 		t->num_notes++;
 		sz += notesize(&t->notes[1]);
 	}
 
 #ifdef ELF_CORE_COPY_XFPREGS
 	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
-		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu), &t->xfpu);
+		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu),
+			  &t->xfpu);
 		t->num_notes++;
 		sz += notesize(&t->notes[2]);
 	}
@@ -1405,7 +1421,7 @@ static int elf_dump_thread_status(long s
  * and then they are actually written out.  If we run out of core limit
  * we just truncate.
  */
-static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file)
+static int elf_core_dump(long signr, struct pt_regs *regs, struct file *file)
 {
 #define	NUM_NOTES	6
 	int has_dumped = 0;
@@ -1434,12 +1450,12 @@ static int elf_core_dump(long signr, str
 	/*
 	 * We no longer stop all VM operations.
 	 * 
-	 * This is because those proceses that could possibly change map_count or
-	 * the mmap / vma pages are now blocked in do_exit on current finishing
-	 * this core dump.
+	 * This is because those proceses that could possibly change map_count
+	 * or the mmap / vma pages are now blocked in do_exit on current
+	 * finishing this core dump.
 	 *
 	 * Only ptrace can touch these memory addresses, but it doesn't change
-	 * the map_count or the pages allocated.  So no possibility of crashing
+	 * the map_count or the pages allocated. So no possibility of crashing
 	 * exists while dumping the mm->vm_next areas to the core file.
 	 */
   
@@ -1501,7 +1517,7 @@ static int elf_core_dump(long signr, str
 #endif
 
 	/* Set up header */
-	fill_elf_header(elf, segs+1);	/* including notes section */
+	fill_elf_header(elf, segs + 1);	/* including notes section */
 
 	has_dumped = 1;
 	current->flags |= PF_DUMPCORE;
@@ -1511,24 +1527,24 @@ static int elf_core_dump(long signr, str
 	 * with info from their /proc.
 	 */
 
-	fill_note(notes +0, "CORE", NT_PRSTATUS, sizeof(*prstatus), prstatus);
-	
+	fill_note(notes + 0, "CORE", NT_PRSTATUS, sizeof(*prstatus), prstatus);
 	fill_psinfo(psinfo, current->group_leader, current->mm);
-	fill_note(notes +1, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
+	fill_note(notes + 1, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
 	
 	numnote = 2;
 
-	auxv = (elf_addr_t *) current->mm->saved_auxv;
+	auxv = (elf_addr_t *)current->mm->saved_auxv;
 
 	i = 0;
 	do
 		i += 2;
 	while (auxv[i - 2] != AT_NULL);
 	fill_note(&notes[numnote++], "CORE", NT_AUXV,
-		  i * sizeof (elf_addr_t), auxv);
+		  i * sizeof(elf_addr_t), auxv);
 
   	/* Try to dump the FPU. */
-	if ((prstatus->pr_fpvalid = elf_core_copy_task_fpregs(current, regs, fpu)))
+	if ((prstatus->pr_fpvalid =
+	     elf_core_copy_task_fpregs(current, regs, fpu)))
 		fill_note(notes + numnote++,
 			  "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
 #ifdef ELF_CORE_COPY_XFPREGS
@@ -1577,8 +1593,10 @@ static int elf_core_dump(long signr, str
 		phdr.p_memsz = sz;
 		offset += phdr.p_filesz;
 		phdr.p_flags = vma->vm_flags & VM_READ ? PF_R : 0;
-		if (vma->vm_flags & VM_WRITE) phdr.p_flags |= PF_W;
-		if (vma->vm_flags & VM_EXEC) phdr.p_flags |= PF_X;
+		if (vma->vm_flags & VM_WRITE)
+			phdr.p_flags |= PF_W;
+		if (vma->vm_flags & VM_EXEC)
+			phdr.p_flags |= PF_X;
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
 		DUMP_WRITE(&phdr, sizeof(phdr));
@@ -1595,7 +1613,9 @@ static int elf_core_dump(long signr, str
 
 	/* write out the thread status notes section */
 	list_for_each(t, &thread_list) {
-		struct elf_thread_status *tmp = list_entry(t, struct elf_thread_status, list);
+		struct elf_thread_status *tmp =
+				list_entry(t, struct elf_thread_status, list);
+
 		for (i = 0; i < tmp->num_notes; i++)
 			if (!writenote(&tmp->notes[i], file))
 				goto end_coredump;
@@ -1612,18 +1632,19 @@ static int elf_core_dump(long signr, str
 		for (addr = vma->vm_start;
 		     addr < vma->vm_end;
 		     addr += PAGE_SIZE) {
-			struct page* page;
+			struct page *page;
 			struct vm_area_struct *vma;
 
 			if (get_user_pages(current, current->mm, addr, 1, 0, 1,
 						&page, &vma) <= 0) {
-				DUMP_SEEK (file->f_pos + PAGE_SIZE);
+				DUMP_SEEK(file->f_pos + PAGE_SIZE);
 			} else {
 				if (page == ZERO_PAGE(addr)) {
-					DUMP_SEEK (file->f_pos + PAGE_SIZE);
+					DUMP_SEEK(file->f_pos + PAGE_SIZE);
 				} else {
 					void *kaddr;
-					flush_cache_page(vma, addr, page_to_pfn(page));
+					flush_cache_page(vma, addr,
+							 page_to_pfn(page));
 					kaddr = kmap(page);
 					if ((size += PAGE_SIZE) > limit ||
 					    !dump_write(file, kaddr,
@@ -1645,7 +1666,8 @@ static int elf_core_dump(long signr, str
 
 	if ((off_t)file->f_pos != offset) {
 		/* Sanity check */
-		printk(KERN_WARNING "elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
+		printk(KERN_WARNING 
+		       "elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
 		       (off_t)file->f_pos, offset);
 	}
 



