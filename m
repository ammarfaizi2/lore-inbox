Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbUCKGTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbUCKGTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:19:53 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:42167 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262793AbUCKGTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:19:00 -0500
Message-ID: <4050047F.5010808@BitWagon.com>
Date: Wed, 10 Mar 2004 22:17:35 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf.c allow .bss with no access (p---)
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <m1brn8us96.fsf@ebiederm.dsl.xmission.com> <404C0B57.6030607@BitWagon.com> <20040308080615.GS31589@devserv.devel.redhat.com>
In-Reply-To: <20040308080615.GS31589@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>LOAD           0x001000 0x00400000 0x00400000 0x00000 0x10000000 R   0x1000

> It should really be p_flags 0 and binfmt_elf.c should be fixed if it doesn't
> handle that properly.

This ALPHA quality patch against 2.6.3 adds another argument to do_brk()
which enables having a user ELF .bss with no-access (or read-only).
Such cases must be page-aligned on the low-address end of .bss, else the
padzero() runs into trouble.  The new code applies .bss immediately to each
PT_LOAD whenever .p_filesz < .p_memsz .  In 99.9% of cases at most one
PT_LOAD has any .bss, so this costs no more time than 2.6.3,
which tries to wait as long as it can before applying .bss.
This patch runs on x86.


--- ./fs/binfmt_elf.c.orig	2004-03-10 19:24:51.243682696 -0800
+++ ./fs/binfmt_elf.c	2004-03-10 19:28:31.435208496 -0800
@@ -83,12 +83,12 @@

  #define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)

-static int set_brk(unsigned long start, unsigned long end)
+static int set_brk(unsigned long start, unsigned long end, unsigned int vm_inhibit)
  {
  	start = ELF_PAGEALIGN(start);
  	end = ELF_PAGEALIGN(end);
  	if (end > start) {
-		unsigned long addr = do_brk(start, end - start);
+		unsigned long addr = do_brk(start, end - start, vm_inhibit);
  		if (BAD_ADDR(addr))
  			return addr;
  	}
@@ -114,6 +114,18 @@
  	}
  }

+static /*inline*/ unsigned int
+calc_bss_inhibit(struct elf_phdr const *phdr, unsigned elf_prot)
+{
+	unsigned vm_inhib = (VM_READ|VM_WRITE|VM_EXEC) ^ calc_vm_prot_bits(elf_prot);
+  /* Can readonly .data/.text have associated read+write .bss ?
+	if (phdr->p_filesz && !(phdr->p_flags & PF_W)) {
+		vm_inhib &= ~VM_WRITE;
+	}
+   */
+	return vm_inhib;
+}
+
  /* Let's use some macros to make this stack manipulation a litle clearer */
  #ifdef CONFIG_STACK_GROWSUP
  #define STACK_ADD(sp, items) ((elf_addr_t *)(sp) + (items))
@@ -298,7 +310,6 @@
  	struct elf_phdr *eppnt;
  	unsigned long load_addr = 0;
  	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
  	unsigned long error = ~0UL;
  	int retval, i, size;

@@ -340,7 +351,7 @@
  	    int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
  	    int elf_prot = 0;
  	    unsigned long vaddr = 0;
-	    unsigned long k, map_addr;
+	    unsigned long map_addr;

  	    if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
  	    if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
@@ -359,38 +370,20 @@
  		load_addr_set = 1;
  	    }

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
-	}
-
-	/*
-	 * Now fill out the bss section.  First pad the last page up
-	 * to the page boundary, and then perform a mmap to make sure
-	 * that there are zero-mapped pages up to and including the
-	 * last bss page.
-	 */
-	padzero(elf_bss);
-	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
-
-	/* Map the last of the bss segment */
-	if (last_bss > elf_bss) {
-		error = do_brk(elf_bss, last_bss - elf_bss);
-		if (BAD_ADDR(error))
+	    if (eppnt->p_filesz < eppnt->p_memsz) {  /* has local .bss */
+		unsigned long elf_bss = load_addr + vaddr + eppnt->p_filesz;
+		padzero(elf_bss);
+		elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);
+
+		vaddr += load_addr + eppnt->p_memsz;
+		if (elf_bss < vaddr) {
+		    error = do_brk(elf_bss, vaddr - elf_bss,
+				calc_bss_inhibit(eppnt, elf_prot) );
+		    if (BAD_ADDR(error))
  			goto out_close;
+		}
+	    }
+	  }
  	}

  	*interp_load_addr = load_addr;
@@ -428,7 +421,7 @@
  		goto out;
  	}

-	do_brk(0, text_data);
+	do_brk(0, text_data, 0);
  	if (!interpreter->f_op || !interpreter->f_op->read)
  		goto out;
  	if (interpreter->f_op->read(interpreter, addr, text_data, &offset) < 0)
@@ -437,7 +430,7 @@
  	                   (unsigned long)addr + text_data);

  	do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
-		interp_ex->a_bss);
+		interp_ex->a_bss, 0);
  	elf_entry = interp_ex->a_entry;

  out:
@@ -464,7 +457,7 @@
  	unsigned char ibcs2_interpreter = 0;
  	unsigned long error;
  	struct elf_phdr * elf_ppnt, *elf_phdata;
-	unsigned long elf_bss, elf_brk;
+	unsigned long elf_brk;
  	int elf_exec_fileno;
  	int retval, i;
  	unsigned int size;
@@ -526,7 +519,6 @@
  	fd_install(elf_exec_fileno = retval, bprm->file);

  	elf_ppnt = elf_phdata;
-	elf_bss = 0;
  	elf_brk = 0;

  	start_code = ~0UL;
@@ -687,44 +679,23 @@
  	   the image should be loaded at fixed address, not at a variable
  	   address. */

-	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
-		int elf_prot = 0, elf_flags;
-		unsigned long k, vaddr;
-
-		if (elf_ppnt->p_type != PT_LOAD)
-			continue;
-
-		if (unlikely (elf_brk > elf_bss)) {
-			unsigned long nbyte;
-	
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
-			retval = set_brk (elf_bss + load_bias,
-					  elf_brk + load_bias);
-			if (retval) {
-				send_sig(SIGKILL, current, 0);
-				goto out_free_dentry;
-			}
-			nbyte = ELF_PAGEOFFSET(elf_bss);
-			if (nbyte) {
-				nbyte = ELF_MIN_ALIGN - nbyte;
-				if (nbyte > elf_brk - elf_bss)
-					nbyte = elf_brk - elf_bss;
-				clear_user((void *) elf_bss + load_bias, nbyte);
-			}
-		}
-
-		if (elf_ppnt->p_flags & PF_R) elf_prot |= PROT_READ;
-		if (elf_ppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
-		if (elf_ppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
-
-		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
-
-		vaddr = elf_ppnt->p_vaddr;
-		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
-			elf_flags |= MAP_FIXED;
-		} else if (elf_ex.e_type == ET_DYN) {
+  	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
+  		int elf_prot = 0, elf_flags;
+		unsigned long const vaddr = elf_ppnt->p_vaddr;
+		unsigned long k, elf_bss;
+
+  		if (elf_ppnt->p_type != PT_LOAD)
+  			continue;
+
+  		if (elf_ppnt->p_flags & PF_R) elf_prot |= PROT_READ;
+  		if (elf_ppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
+  		if (elf_ppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
+
+  		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
+
+  		if (elf_ex.e_type == ET_EXEC || load_addr_set)
+  			elf_flags |= MAP_FIXED;
+  		else if (elf_ex.e_type == ET_DYN)
  			/* Try and get dynamic programs out of the way of the default mmap
  			   base, as well as whatever program they might try to exec.  This
  			   is because the brk will follow the loader, and is not movable.  */
@@ -737,7 +708,7 @@

  		if (!load_addr_set) {
  			load_addr_set = 1;
-			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
+			load_addr = (vaddr - elf_ppnt->p_offset);
  			if (elf_ex.e_type == ET_DYN) {
  				load_bias += error -
  				             ELF_PAGESTART(load_bias + vaddr);
@@ -745,43 +716,45 @@
  				reloc_func_desc = load_bias;
  			}
  		}
-		k = elf_ppnt->p_vaddr;
+		k = vaddr;
  		if (k < start_code) start_code = k;
  		if (start_data < k) start_data = k;

-		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
-
-		if (k > elf_bss)
-			elf_bss = k;
+		k = vaddr + elf_ppnt->p_filesz;  /* start local .bss */
+		elf_bss = k;
  		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
  			end_code = k;
  		if (end_data < k)
  			end_data = k;
-		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
+
+		k = vaddr + elf_ppnt->p_memsz;  /* end local .bss */
  		if (k > elf_brk)
  			elf_brk = k;
+
+		if (elf_bss < k) {
+			elf_bss += load_bias;
+			padzero(elf_bss);
+			elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);
+
+			k += load_bias;
+			if (elf_bss < k) {
+				retval = set_brk(elf_bss, k - elf_bss,
+					calc_bss_inhibit(elf_ppnt, elf_prot) );
+				if (retval) {
+					send_sig(SIGKILL, current, 0);
+					goto out_free_dentry;
+				}
+			}
+		}
  	}

  	elf_ex.e_entry += load_bias;
-	elf_bss += load_bias;
  	elf_brk += load_bias;
  	start_code += load_bias;
  	end_code += load_bias;
  	start_data += load_bias;
  	end_data += load_bias;

-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections.  We must do this before
-	 * mapping in the interpreter, to make sure it doesn't wind
-	 * up getting placed where the bss needs to go.
-	 */
-	retval = set_brk(elf_bss, elf_brk);
-	if (retval) {
-		send_sig(SIGKILL, current, 0);
-		goto out_free_dentry;
-	}
-	padzero(elf_bss);
-
  	if (elf_interpreter) {
  		if (interpreter_type == INTERPRETER_AOUT)
  			elf_entry = load_aout_interp(&interp_ex,
@@ -947,7 +920,7 @@
  	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
  	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
  	if (bss > len)
-		do_brk(len, bss - len);
+		do_brk(len, bss - len, 0);
  	error = 0;

  out_free_ph:
--- ./include/linux/mm.h.orig	2004-03-07 19:01:46.000000000 -0800
+++ ./include/linux/mm.h	2004-03-08 08:43:02.000000000 -0800
@@ -554,7 +554,7 @@

  extern int do_munmap(struct mm_struct *, unsigned long, size_t);

-extern unsigned long do_brk(unsigned long, unsigned long);
+extern unsigned long do_brk(unsigned long, unsigned long, unsigned int);

  extern void __vma_unlink(struct mm_struct *mm, struct vm_area_struct *vma,
  			 struct vm_area_struct *prev);
--- ./fs/binfmt_aout.c.orig	2004-03-07 19:01:46.000000000 -0800
+++ ./fs/binfmt_aout.c	2004-03-08 08:36:01.000000000 -0800
@@ -44,13 +44,13 @@
  	.min_coredump	= PAGE_SIZE
  };

-static void set_brk(unsigned long start, unsigned long end)
+static void set_brk(unsigned long start, unsigned long end, unsigned vm_inhibit)
  {
  	start = PAGE_ALIGN(start);
  	end = PAGE_ALIGN(end);
  	if (end <= start)
  		return;
-	do_brk(start, end - start);
+	do_brk(start, end - start, vm_inhibit);
  }

  /*
@@ -319,10 +319,10 @@
  		loff_t pos = fd_offset;
  		/* Fuck me plenty... */
  		/* <AOL></AOL> */
-		error = do_brk(N_TXTADDR(ex), ex.a_text);
+		error = do_brk(N_TXTADDR(ex), ex.a_text, 0);
  		bprm->file->f_op->read(bprm->file, (char *) N_TXTADDR(ex),
  			  ex.a_text, &pos);
-		error = do_brk(N_DATADDR(ex), ex.a_data);
+		error = do_brk(N_DATADDR(ex), ex.a_data, 0);
  		bprm->file->f_op->read(bprm->file, (char *) N_DATADDR(ex),
  			  ex.a_data, &pos);
  		goto beyond_if;
@@ -343,7 +343,7 @@
  		map_size = ex.a_text+ex.a_data;
  #endif

-		error = do_brk(text_addr & PAGE_MASK, map_size);
+		error = do_brk(text_addr & PAGE_MASK, map_size, 0);
  		if (error != (text_addr & PAGE_MASK)) {
  			send_sig(SIGKILL, current, 0);
  			return error;
@@ -377,7 +377,7 @@

  		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
  			loff_t pos = fd_offset;
-			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data, 0);
  			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
  					ex.a_text+ex.a_data, &pos);
  			flush_icache_range((unsigned long) N_TXTADDR(ex),
@@ -412,7 +412,7 @@
  beyond_if:
  	set_binfmt(&aout_format);

-	set_brk(current->mm->start_brk, current->mm->brk);
+	set_brk(current->mm->start_brk, current->mm->brk, 0);

  	retval = setup_arg_pages(bprm, 1);
  	if (retval < 0) {
@@ -478,7 +478,7 @@
  			error_time = jiffies;
  		}

-		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
+		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss, 0);
  		
  		file->f_op->read(file, (char *)start_addr,
  			ex.a_text + ex.a_data, &pos);
@@ -502,7 +502,7 @@
  	len = PAGE_ALIGN(ex.a_text + ex.a_data);
  	bss = ex.a_text + ex.a_data + ex.a_bss;
  	if (bss > len) {
-		error = do_brk(start_addr + len, bss - len);
+		error = do_brk(start_addr + len, bss - len, 0);
  		retval = error;
  		if (error != start_addr + len)
  			goto out;
--- ./mm/mmap.c.orig	2004-03-07 19:01:46.000000000 -0800
+++ ./mm/mmap.c	2004-03-08 08:29:49.000000000 -0800
@@ -127,7 +127,7 @@
  		goto out;

  	/* Ok, looks good - let it rip. */
-	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk)
+	if (do_brk(oldbrk, newbrk-oldbrk, 0) != oldbrk)
  		goto out;
  set_brk:
  	mm->brk = brk;
@@ -1354,7 +1354,7 @@
   *  anonymous maps.  eventually we may be able to do some
   *  brk-specific accounting here.
   */
-unsigned long do_brk(unsigned long addr, unsigned long len)
+unsigned long do_brk(unsigned long addr, unsigned long len, unsigned vm_inhibit)
  {
  	struct mm_struct * mm = current->mm;
  	struct vm_area_struct * vma, * prev;
@@ -1400,7 +1400,7 @@
  	if (security_vm_enough_memory(len >> PAGE_SHIFT))
  		return -ENOMEM;

-	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	flags = (VM_DATA_DEFAULT_FLAGS &~ vm_inhibit) | VM_ACCOUNT | mm->def_flags;

  	/* Can we just expand an old anonymous mapping? */
  	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len,
--- ./mm/nommu.c.orig	2004-02-17 19:59:20.000000000 -0800
+++ ./mm/nommu.c	2004-03-08 08:30:07.000000000 -0800
@@ -536,7 +536,7 @@
  	return ret;
  }

-unsigned long do_brk(unsigned long addr, unsigned long len)
+unsigned long do_brk(unsigned long addr, unsigned long len, unsigned vm_inhibit)
  {
  	return -ENOMEM;
  }


-- 
John Reiser, jreiser@BitWagon.com


